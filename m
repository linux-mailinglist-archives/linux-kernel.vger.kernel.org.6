Return-Path: <linux-kernel+bounces-230053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E48AF9177D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DC1F22EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F74613B28A;
	Wed, 26 Jun 2024 05:05:55 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100F928E7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378355; cv=none; b=fxRFA4BIqJX8ZxuT3CshjDAupo2exVwMor/kABLM26L8lXobxSogATgdyaC7Lfz/aOWr03g6hZwZMXpNC0wHabtReuhzWGM/xgzR6n1msOt3K0bXpS8Z+c1d0GFj+qamjDxONXlZL/TMfp4GiPNNblplMzbgNxrUyL0uXqJSFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378355; c=relaxed/simple;
	bh=WOgJGxR498hRFbN+vagR9Q1WxEmkLz0HmAk9+fFG82s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGTYAyAyCS6tdye7iOKrK8WE1oADyXDpC0RtYouyJCiCIYFqJLel+VGLM9Yht5X5rkdyZwQ1qfeeVlMeD8ynH6CfGq4K3QMJtNe8Pz+32vBMjX8VqvTznIUxk1ExIYto1IxrXqyk+3uMSjjlm1VTHCLWfEOIj0itd+wxAA4tVVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E16AB68BEB; Wed, 26 Jun 2024 07:05:48 +0200 (CEST)
Date: Wed, 26 Jun 2024 07:05:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v8 1/2] nvme-multipath: prepare for "queue-depth"
 iopolicy
Message-ID: <20240626050548.GA21922@lst.de>
References: <20240625122605.857462-1-jmeneghi@redhat.com> <20240625122605.857462-2-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625122605.857462-2-jmeneghi@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 25, 2024 at 08:26:04AM -0400, John Meneghini wrote:
> +	struct nvme_ns *old = srcu_dereference(head->current_path[node], &head->srcu);

Please avoid the overly long line here.

> +inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
> +{
> +	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
> +		return nvme_round_robin_path(head);
> +	else
> +		return nvme_numa_path(head);

No need for an else after a return.


