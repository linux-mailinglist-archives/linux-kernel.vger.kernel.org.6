Return-Path: <linux-kernel+bounces-184984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E508CAEDF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F02E1C21845
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53B654278;
	Tue, 21 May 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG/KfFuE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C617C6CC
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296736; cv=none; b=XRKRPmvJzQq7lec1b0uxVGIv/CWrLyIrRzNSJ7J7lFNMIxo73GocQA+09q7N/wWxiM1//v/eyIjmOVQHsTMkvL1MBnw/hah/34qYW8cx/OMHcJ6RbAGIq0frUy1lvdlQQ7kvBtDrR7cRnQOgrnNHo4zxFgiaQjM6i7oM+MNRRbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296736; c=relaxed/simple;
	bh=Rr/GkEedXfncMNSF/dyRDeEza5AsisB/vI8v19rE6Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJp4N6T5xdTwx+zPMzFYZtQL2n8CxnTbvA+PIZisIg1picLKUuOTmnNqgfgFJ0M7ZbSdIcH76ImkVORL3nn0fwvM3uyMIBYbmSjPeUaorHFnDW5r/B1ufztvuViPWqg+uDmfVcQl9948kdaY9OPW+MMJfQ726ZGF1OxsGl1VOx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG/KfFuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E54C32786;
	Tue, 21 May 2024 13:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716296735;
	bh=Rr/GkEedXfncMNSF/dyRDeEza5AsisB/vI8v19rE6Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eG/KfFuEoBcpnCRX8QH0GBE7h95EK2gBtvNobaiURYktE5WUnN3+wo356Q1+ibYm7
	 +lOBnDoAdPdh8Hrpi9rwapEAo9SF2LGGA6CsF6m2QGk5FAmTx7Kjzujv41exStb4W+
	 YqFBAJhWm6KmaU77JY3sLy8XmmYWnatjMJFdi14gZ5UlOQkQDRTF0JnsicMQiiG0P2
	 svdyYUfklf6WYvmT9y01j+ieqYEnLDBlcM9PF0NTNl4RSIErEd2v+eW1Nnrah7sdbj
	 QBVsDMGbGdwWF+UW0raMxxbGq8hBDE3Jb34pQ9U/EITYkCC9SrVULw6mdyxylBIvjB
	 1v8PMbhPbWMLw==
Date: Tue, 21 May 2024 07:05:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: John Meneghini <jmeneghi@redhat.com>, hch@lst.de, sagi@grimberg.me,
	emilne@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, jrani@purestorage.com,
	randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <ZkycHdlWgQtkCVer@kbusch-mbp.dhcp.thefacebook.com>
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>

On Tue, May 21, 2024 at 02:18:09PM +0530, Nilay Shroff wrote:
> On 5/21/24 01:50, John Meneghini wrote:
> > @@ -140,8 +148,12 @@ void nvme_mpath_end_request(struct request *rq)
> >  {
> >  	struct nvme_ns *ns = rq->q->queuedata;
> >  
> > +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
> > +		atomic_dec_if_positive(&ns->ctrl->nr_active);
> > +
> >  	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
> >  		return;
> > +
> >  	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
> >  			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
> >  			 nvme_req(rq)->start_time);
> > @@ -330,6 +342,40 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
> >  	return found;
> >  }
> >  
> I think you may also want to reset nr_active counter if in case, in-flight nvme request 
> is cancelled. If the request is cancelled then nvme_mpath_end_request() wouldn't be invoked.
> So you may want to reset nr_active counter from nvme_cancel_request() as below:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bf7615cb36ee..4fea7883ce8e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -497,8 +497,9 @@ EXPORT_SYMBOL_GPL(nvme_host_path_error);
>  
>  bool nvme_cancel_request(struct request *req, void *data)
>  {
> -       dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> -                               "Cancelling I/O %d", req->tag);
> +       struct nvme_ctrl *ctrl = (struct nvme_ctrl *)data;
> +
> +       dev_dbg_ratelimited(ctrl->device, "Cancelling I/O %d", req->tag);
>  
>         /* don't abort one completed or idle request */
>         if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
> @@ -506,6 +507,8 @@ bool nvme_cancel_request(struct request *req, void *data)
>  
>         nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
>         nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> +       if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
> +               atomic_dec(&ctrl->nr_active);
>         blk_mq_complete_request(req);
>         return true;
>  }

The io stats wouldn't be right if that happened. And maybe it isn't
right on a failover, but it needs to be. Would it work if
nvme_failover_req() calls nvme_end_req() instead of directly calling
blk_mq_end_req()?

