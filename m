Return-Path: <linux-kernel+bounces-187065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F9B8CCC90
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F766282170
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5013C911;
	Thu, 23 May 2024 06:53:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A913C669
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447184; cv=none; b=rDYxpblWaiHb1/WpUn6sf9xYkD+kOlCxzoCeUNoukAQrLKE+XmZ0rJdQykbp9xrCvOG2of/BdEd0Zn+HRzcp2Fbb7R+aRmqW2KJq1cHd3kgG2wDF9yd1p/Ai7NsFadWDaGUfM6+YChfWUY3jZocLgB4Mc/mPukGOuMOicHXi+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447184; c=relaxed/simple;
	bh=rZqjGZPNvT1EjlniIIgepZxdktVK6MmmE7NRPv6XE+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3KuxExccE+doWhd+dq4w5OyWI/UEonBgaBlL9qFE5xuG9unzKtMQ4t4SuF+Qdo08omYPGc/JvNV1M2CouaV09Y5Nvwp1QvmMZ2hG3ilvgn5H1iToSnFCRSNv1OhLu1qCqWoMTWoN1tkwc19PGzn0tYOihhnfuN0c6/K3I8lQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A235D68BFE; Thu, 23 May 2024 08:52:57 +0200 (CEST)
Date: Thu, 23 May 2024 08:52:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <20240523065257.GB28524@lst.de>
References: <20240522165406.702362-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522165406.702362-1-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	/*
> +	 * queue-depth iopolicy does not need to reference ->current_path
> +	 * but round-robin needs the last path used to advance to the
> +	 * next one, and numa will continue to use the last path unless
> +	 * it is or has become not optimized
> +	 */

Can we please turn this into a full sentence?  I.e.:

	/*
	 * The queue-depth iopolicy does not need to reference ->current_path,
	 * but the round-robin iopolicy needs the last path used to advance to
	 * the next one, and numa will continue to use the last path unless
	 * it is or has become non-optimized.
	 */

?

> +	if (iopolicy == NVME_IOPOLICY_QD)
> +		return nvme_queue_depth_path(head);
> +
> +	node = numa_node_id();
>  	ns = srcu_dereference(head->current_path[node], &head->srcu);
>  	if (unlikely(!ns))
>  		return __nvme_find_path(head, node);
>  
> -	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
> +	if (iopolicy == NVME_IOPOLICY_RR)
>  		return nvme_round_robin_path(head, node, ns);
> +
>  	if (unlikely(!nvme_path_is_optimized(ns)))
>  		return __nvme_find_path(head, node);
>  	return ns;

Also this is growing into the kind of spaghetti code that is on the fast
path to become unmaintainable.  I'd much rather see the
srcu_dereference + __nvme_find_path duplicated and have a switch over
the iopolicies with a separate helper for each of them here than the
various ifs at different levels.

> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)

Overly long line here.

> +{
> +	struct nvme_ctrl *ctrl;
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> +
> +	if (old_iopolicy == iopolicy)
> +		return;
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> +
> +	/* iopolicy changes reset the counters and clear the mpath by design */
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		atomic_set(&ctrl->nr_active, 0);
> +		nvme_mpath_clear_ctrl_paths(ctrl);
> +	}
> +	mutex_unlock(&nvme_subsystems_lock);

You probably want to take the lock over the iopolicy assignment to
serialize it.  And why do we need the atomic_set here?

> +
> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],

Pleae avoid the overly long line here as well.

>  	NVME_REQ_CANCELLED		= (1 << 0),
>  	NVME_REQ_USERCMD		= (1 << 1),
>  	NVME_MPATH_IO_STATS		= (1 << 2),
> +	NVME_MPATH_CNT_ACTIVE	= (1 << 3),

This does not match the indentation above.


