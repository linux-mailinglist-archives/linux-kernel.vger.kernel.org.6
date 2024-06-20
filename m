Return-Path: <linux-kernel+bounces-222123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C105C90FD24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AAF282602
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248640875;
	Thu, 20 Jun 2024 06:56:48 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35C40848
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866608; cv=none; b=pPocrM27GhNHCc5ZvyukVemMp5oz2HQP5MjQOemfnb+HGTzNix2LdYYecDUOWu0sG2xrQUZTqIRg5Pm94kv7d/v+1RCZfLskvj4Kj/t/19HRH4Myj/V1sitqYqyLB3yqikeyfW0r8CN4Gz+D33+3skwkXJ/+NYNTZM2NmFEvQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866608; c=relaxed/simple;
	bh=6gBijgTVCVX8zCgP5AZijMGbZqyPpM1a/+bbPky5Ans=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uwl3Eae87l+2opVtHjLUsSMbgzQgw0lwNcKr0uDzgP6pxiLtXg6PakN+QFr+TUY4eS9eIdVDliGyO+UFJ9QZh7j72+GXPjxYw0N7uBZsEbvjtSZmX93KWwVrzxrvGltZKjdw3f51wcrTZgW4kdE4I46qB0db4blzEigRsOoTHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7ACF568AFE; Thu, 20 Jun 2024 08:56:41 +0200 (CEST)
Date: Thu, 20 Jun 2024 08:56:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
Message-ID: <20240620065641.GA22113@lst.de>
References: <20240619163503.500844-1-jmeneghi@redhat.com> <20240619163503.500844-2-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619163503.500844-2-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> [jmeneghi: vairious changes and improvements, addressed review comments]

s/vairious/various/ 

> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))

No need for the double braces here.

> +		WARN_ON_ONCE((atomic_dec_if_positive(&ns->ctrl->nr_active)) < 0);

Overly long line.

But I don't understand why you need the WARN_ON anyway.  If the value
must always be positive there is no point in atomic_dec_if_positive.
If misaccounting is fine there WARN_ON is counterproductive.

> -static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
> -		int node, struct nvme_ns *old)
> +static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
>  {
> -	struct nvme_ns *ns, *found = NULL;
> +	struct nvme_ns *ns, *old, *found = NULL;
> +	int node = numa_node_id();
> +
> +	old = srcu_dereference(head->current_path[node], &head->srcu);
> +	if (unlikely(!old))
> +		return __nvme_find_path(head, node);

Can you split the refactoring of the existing path selectors into a
prep patch, please?

> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
> +		int iopolicy)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> +
> +	if (old_iopolicy == iopolicy)
> +		return;
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);

What is the atomicy model here?  There doesn't seem to be any
global lock protecting it?  Maybe move it into the
nvme_subsystems_lock critical section?

> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
> +			subsys->subnqn);

The function is not really relevant here,  this should become something
like:

	pr_notice("%s: changing iopolicy from %s to %s\n",
		subsys->subnqn,
		nvme_iopolicy_names[old_iopolicy],
		nvme_iopolicy_names[iopolicy]);

or maybe:

	dev_notice(changing iopolicy from %s to %s\n",
		&subsys->dev,
		nvme_iopolicy_names[old_iopolicy],
		nvme_iopolicy_names[iopolicy]);


