Return-Path: <linux-kernel+bounces-184171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F6B8CA383
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEAA2811F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F29613849C;
	Mon, 20 May 2024 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbnmu3tY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18CA17BAF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716238208; cv=none; b=NfTUXQmMiEpOpB9HjwbRELE50U3QDlsjzx+VUaZ5UV8/se7TUtKmVYsYaTH4lvXAs8HA/Dov4P6io7pGt1PBywPgEh1J7idmWIZGtK7RrWhGK9p+Exattoja5R7a+Ai5K3NcH+4BKIWvMziyXd58J2oRzlBEFUch4vclJPmWV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716238208; c=relaxed/simple;
	bh=ZDyGHXDWJU1AWGqFUbfBdq5n343QTXbBlaaM+in5QQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBQJn0AYoWlZVvRGs8Xeb0TCB3NhYVCvpnsWhr5DP991ReRZJgtRqrCpMql7p2QAyPrgltckpDHMpyDa3Pn0SDno9VeGpwHm059Xyql44xTpmmasd04gnC5ykI3MMpU0y7++tHdgPIxsHv9cHswIgU521A5kAFP6BqpXB2ycQAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbnmu3tY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF15C2BD10;
	Mon, 20 May 2024 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716238207;
	bh=ZDyGHXDWJU1AWGqFUbfBdq5n343QTXbBlaaM+in5QQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbnmu3tYZqPFhCg7SFPJA62mj0vmn3HXAQflzoTkOU2wOwZc5XxghPek/w763O9Sx
	 DCmcamLYW0nUVYHw88+/l3k1kmpTPxajKeBPzib2+lTOA2b2GTwLasJXS7WRV6Evpb
	 /QTbFbJ6OI2HDH2+oB0VBqhRcBUdPoorAKmfq2gmr+hMPRzmNQ3beNG5t1YUUzz3p7
	 PokWssnwtcWgmMSvaCF+4Q5mKOSOAcqXf16M3dTK9P2xuSD9E56JWF9vlGoMM0Y8gA
	 0KE+2Zo2Ej4OfDDgrObDjz/FyPWC8IyLehYwhRtwDy0QcxRdJxuzM694gNo7iSJEtF
	 e0YE8fJ86hbEQ==
Date: Mon, 20 May 2024 14:50:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <Zku3fBuauZQX6bEO@kbusch-mbp>
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520202045.427110-2-jmeneghi@redhat.com>

On Mon, May 20, 2024 at 04:20:45PM -0400, John Meneghini wrote:
> From: "Ewan D. Milne" <emilne@redhat.com>
> 
> The round-robin path selector is inefficient in cases where there is a
> difference in latency between multiple active optimized paths.  In the
> presence of one or more high latency paths the round-robin selector
> continues to the high latency path equally. This results in a bias
> towards the highest latency path and can cause is significant decrease
> in overall performance as IOs pile on the lowest latency path. This
> problem is particularly accute with NVMe-oF controllers.

The patch looks pretty good to me. Just a few questions/comments.

>  static LIST_HEAD(nvme_subsystems);
> -static DEFINE_MUTEX(nvme_subsystems_lock);
> +DEFINE_MUTEX(nvme_subsystems_lock);

This seems odd. Why is this lock protecting both the global
nvme_subsystems list, and also subsystem controllers? IOW, why isn't the
subsys->ctrls list protected by the more fine grained 'subsys->lock'
instead of this global lock?

> @@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>  module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>  	&iopolicy, 0644);
>  MODULE_PARM_DESC(iopolicy,
> -	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
> +	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");

Unnecessary space before the ','.

> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> +		atomic_inc(&ns->ctrl->nr_active);
> +		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
> +	}
> +
>  	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>  		return;
>  
> @@ -140,8 +148,12 @@ void nvme_mpath_end_request(struct request *rq)
>  {
>  	struct nvme_ns *ns = rq->q->queuedata;
>  
> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
> +		atomic_dec_if_positive(&ns->ctrl->nr_active);

You can just do a atomic_dec() since your new flag has this tied to to
the atomic_inc().

> +static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
> +{
> +	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
> +	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
> +	unsigned int depth;
> +
> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		if (nvme_path_is_disabled(ns))
> +			continue;
> +
> +		depth = atomic_read(&ns->ctrl->nr_active);
> +
> +		switch (ns->ana_state) {
> +		case NVME_ANA_OPTIMIZED:
> +			if (depth < min_depth_opt) {
> +				min_depth_opt = depth;
> +				best_opt = ns;
> +			}
> +			break;
> +
> +		case NVME_ANA_NONOPTIMIZED:
> +			if (depth < min_depth_nonopt) {
> +				min_depth_nonopt = depth;
> +				best_nonopt = ns;
> +			}
> +			break;
> +		default:
> +			break;
> +		}

Could we break out of this loop early if "min_depth_opt == 0"? We can't
find a better path that that, so no need to read the rest of the paths.

> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> +

Let's add a check here:

	if (old_iopolicy == iopolicy)
		return;

> @@ -935,6 +940,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
>  void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
>  void nvme_mpath_start_request(struct request *rq);
>  void nvme_mpath_end_request(struct request *rq);
> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy);

This funciton isn't used outside multipath.c, so it should be static.

