Return-Path: <linux-kernel+bounces-539964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1EEA4AB5D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C50F167EC1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CED1DEFE6;
	Sat,  1 Mar 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wgys34JL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962121DE895
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740836972; cv=none; b=uQaOoSQ5knvpO0hEBfavhz2WjWb1JUhk3ChvXxIAi1hRhEuSln2+0RTk0Erq+Aa7YledFlIrntOm9F5Zf0CwMf/2+zE/iWiWSACZOG2/i6XFSacWr9Z4Dt8xOXzdzpoarRyMYXnc/2MuOJWWyI0R/9xDDNa/QlQYTgHc+vX/4mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740836972; c=relaxed/simple;
	bh=TdQrSsfUqsgjam5ayWXfQx9MiC0CEceDz3qNAdJSGZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDZj9Gy47RcT7onk/kHdSSWyeoIW+rb0IoMSAadgL9ZGwhUf3ooe26y1Hu9WfBant5hMizsa7Eh3Z7UgG4gFDgXMPfyefzY1170FYtndvl8HovGeRsW+x1BALtWaB2TrMSFQMcMoq4YgYby2Gqh+Cx5rdPWZz/wPbTICXNog3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wgys34JL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740836968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yX8SsUhxK1pBuuAliUfaXKNUpsQ+odkuNQ8838vLa54=;
	b=Wgys34JLFuQ0P8FSx5EK3e+M2th002YskSeQIcWugE6aANnLy0BCqskES4nlII3IfOMRwn
	SpLWEH9S4uOqKcxkwfz57oerhM2bUYfat5EOw5COd4K/Ey3QJKDX8LwmVRSK85g3brgXG/
	Kd6IsyylQZR3qFCuG3PAaO1REPAIM3Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-UsM1OL0dN9Cwo8BktjiVqw-1; Sat,
 01 Mar 2025 08:49:25 -0500
X-MC-Unique: UsM1OL0dN9Cwo8BktjiVqw-1
X-Mimecast-MFC-AGG-ID: UsM1OL0dN9Cwo8BktjiVqw_1740836964
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E263180034A;
	Sat,  1 Mar 2025 13:49:23 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F35E519560AD;
	Sat,  1 Mar 2025 13:49:17 +0000 (UTC)
Date: Sat, 1 Mar 2025 21:49:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH] io_uring/ublk: report error when unregister operation
 fails
Message-ID: <Z8MQV0EGSFpiHwUC@fedora>
References: <20250228231432.642417-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228231432.642417-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Feb 28, 2025 at 04:14:31PM -0700, Caleb Sander Mateos wrote:
> Indicate to userspace applications if a UBLK_IO_UNREGISTER_IO_BUF
> command specifies an invalid buffer index by returning an error code.
> Return -EINVAL if no buffer is registered with the given index, and
> -EBUSY if the registered buffer is not a kernel bvec.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c     |  3 +--
>  include/linux/io_uring/cmd.h |  4 ++--
>  io_uring/rsrc.c              | 18 ++++++++++++++----
>  3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index b5cf92baaf0f..512cbd456817 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1785,12 +1785,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
>  
>  static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
>  				  const struct ublksrv_io_cmd *ub_cmd,
>  				  unsigned int issue_flags)
>  {
> -	io_buffer_unregister_bvec(cmd, ub_cmd->addr, issue_flags);
> -	return 0;
> +	return io_buffer_unregister_bvec(cmd, ub_cmd->addr, issue_flags);
>  }
>  
>  static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
>  			       unsigned int issue_flags,
>  			       const struct ublksrv_io_cmd *ub_cmd)
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index cf8d80d84734..05d7b6145731 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -127,9 +127,9 @@ static inline struct io_uring_cmd_data *io_uring_cmd_get_async_data(struct io_ur
>  }
>  
>  int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
>  			    void (*release)(void *), unsigned int index,
>  			    unsigned int issue_flags);
> -void io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
> -			       unsigned int issue_flags);
> +int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
> +			      unsigned int issue_flags);
>  
>  #endif /* _LINUX_IO_URING_CMD_H */
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 45bfb37bca1e..29c0c31092eb 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -975,30 +975,40 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
>  	io_ring_submit_unlock(ctx, issue_flags);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
>  
> -void io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
> -			       unsigned int issue_flags)
> +int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int index,
> +			      unsigned int issue_flags)
>  {
>  	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
>  	struct io_rsrc_data *data = &ctx->buf_table;
>  	struct io_rsrc_node *node;
> +	int ret = 0;
>  
>  	io_ring_submit_lock(ctx, issue_flags);
> -	if (index >= data->nr)
> +	if (index >= data->nr) {
> +		ret = -EINVAL;
>  		goto unlock;
> +	}
>  	index = array_index_nospec(index, data->nr);
>  
>  	node = data->nodes[index];
> -	if (!node || !node->buf->is_kbuf)
> +	if (!node) {
> +		ret = -EINVAL;
>  		goto unlock;
> +	}
> +	if (!node->buf->is_kbuf) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}

Good catch, otherwise, ublk request may never get completed if unreg
command fails, which can happen really as one uring_cmd.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


