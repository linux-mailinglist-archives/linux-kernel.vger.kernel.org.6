Return-Path: <linux-kernel+bounces-199905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F98FA780
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83866286B3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC5C138495;
	Tue,  4 Jun 2024 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxmDvlsv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285CB135A46
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717464474; cv=none; b=H5l/11xcyaTg+Ru9qQTfd0k2Q01rhbv5HGagXcV/A1MmUwQwDtHLSD9cyq7k/kDnlXDIC3vvpR+VBOj0FnHZR1YNxCVh8IUqBqSuCb0N7cvZ1OdwEJcwyyYw7ig3BrJZHH7CI13J/xODeJDO4aWKTr/yua4ZcKMFcEQqR+OMTSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717464474; c=relaxed/simple;
	bh=90tuKrUWcNjEg3Qnxq7XEyrl7dqi8tX3BxxtJmME1cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCV9VYXCZXea0wG+11eN9xkZfcsHinW+3Mve47OrVOKaEbar5Hu7Ap5I3t4jd0Td4LXIdbLjey8EUh09l+V7uP+UxAH5iy8jpzFjgni7+8VkPVTX04m9pdxR4zt6UoKb21kB8QsfiFn0f95x71bfnPbhpAGhTp2FemTEBrd1/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxmDvlsv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717464472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Z7SRvzAMckA3XNXJwgjMYaITshj7fSHWjmozr7eVY8=;
	b=fxmDvlsvFuZzvhcZCdKa8Vj8a5Ycwae/bQ0AL2NysxBSEJKIKXFdiaMtxBAjAHnrnbY2tU
	O67OF7wgN9rQ78Dcvyz2qWTJnTrnNcxjPFMoRZykONDSMf0ixdfPbGxvuySFDRJ5bEaz6k
	BceGyBSAPw9+DCvKSww1NwVn6CL+mAc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-RGD_dGosNgWi7FEPvIMLBA-1; Mon, 03 Jun 2024 21:27:48 -0400
X-MC-Unique: RGD_dGosNgWi7FEPvIMLBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD671800CAC;
	Tue,  4 Jun 2024 01:27:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AD641000552;
	Tue,  4 Jun 2024 01:27:42 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:27:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] null_blk: fix validation of block size
Message-ID: <Zl5tilC7VGtmNHBe@fedora>
References: <20240603192645.977968-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603192645.977968-1-nmi@metaspace.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Mon, Jun 03, 2024 at 09:26:45PM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Block size should be between 512 and PAGE_SIZE and be a power of 2. The current
> check does not validate this, so update the check.
> 
> Without this patch, null_blk would Oops due to a null pointer deref when
> loaded with bs=1536 [1].
> 
> Link: https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
> 
> Changes from v2:
> 
>  - Use blk_validate_block_size instead of open coding the check.
>  - Change upper bound of chec from 4096 to PAGE_SIZE.
> 
> V1: https://lore.kernel.org/all/20240601202351.691952-1-nmi@metaspace.dk/
> 
>  drivers/block/null_blk/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index eb023d267369..967d39d191ca 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1823,8 +1823,9 @@ static int null_validate_conf(struct nullb_device *dev)
>  		dev->queue_mode = NULL_Q_MQ;
>  	}
>  
> -	dev->blocksize = round_down(dev->blocksize, 512);
> -	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
> +	if (blk_validate_block_size(dev->blocksize) != 0) {
> +		return -EINVAL;
> +	}

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


