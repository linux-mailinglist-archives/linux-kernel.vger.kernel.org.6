Return-Path: <linux-kernel+bounces-308436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151DA965CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385A61C23AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DFF171E65;
	Fri, 30 Aug 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vms3B1AO"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6FC171650
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010319; cv=none; b=PNaCfRvCnGpNEu2Zf1wenyAd2TrdAVxWEBKtapPZjDFDNRVnjHe+gm4aQFFjlHzVVT73qaTxcFRHAJcgSiM1EM4rzJK/Sqcadg74Io7L80I/LKZhjxmIxGYe3x7ivVzQGjWoOsQWdo7VWK1kSdGJM4phuDiWioETqyOFA4q68Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010319; c=relaxed/simple;
	bh=6sTZdlmHmYyiRvtDtP4yWnQXbtzLSepAwnB75MVotGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDolkEe6bWn8HvvglQl5RpT0Sa5yTOYqlOqOWESTLuH2UhnEg9adDlnujMQ7c02XvCsokbnxQTKzuLWNysoO2fN8ZCM5tngffMGCHhH8OOItXk726tpIyiND2dgdbgZzW58fHRYgJ6ULyrpl3JDditClBmP9flzFPDw4vAJixMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vms3B1AO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53345604960so1629438e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725010316; x=1725615116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+CgpT6APH0hN/ofysbLtlPS9ANv4/uusy+KNHKn0Cos=;
        b=Vms3B1AOEEZH71YTbAyx+FSZhccgevRLHlO57ZVmRG8BDcV76/8nalaf2U+T6WOD67
         /5/O+CvbJ3XP4Yfomu0296j+eMISXkUfeHl1DV3zWJgqBOHkIzlXVFCqCZV8qT3GM22Y
         NZDm36hu4XhXYKQtI5e8tk1EnjVdePyrXyoVXyublqLFCbdM89NZh6KxXyThF9eeNvgk
         RcoebCTOtTjsZH0L80eX2oCjIwMPLsjJ8MSP2mDDRkGnLTfniwowwz1tk8WS2pCRFwKU
         qxaliN8ptjkw04K3JXrmH6mw2aMgO/5mnW8fCdMlpEy3/RjwitUpNnTYYClgpZqkjGV7
         NQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725010316; x=1725615116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CgpT6APH0hN/ofysbLtlPS9ANv4/uusy+KNHKn0Cos=;
        b=DYX333Y7IaVTlZ3MoRA67GrFrv6zxx+oHdp/suG/TRjD4jjQk0PHodD8jjkq7SSdqW
         IxOMlRG2JtWk6XFS+IWOqm9RV/UZW9DDwl965om867ZUC+kczVI82bMzjrmW/p5cUOwo
         8jn1z01G63PrbwzAuuEw2Ff4hghiJ29YJ8vocBSbfzpVmFpKDwKbSgG4Kqc5N+FgsA0L
         J58xzbUXYsqoKuvNwkXoBdwsAag5sDav078XwSFtwOY9uTwaXTf6My4Ncv48ydgjD1xO
         dVTKBA9nPKNs/ymBIwyBNZRRNtI0IGQcow7W53NlhbkdVASYvhLNPRS9acRTYJpzIxUs
         9uuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPLW34Y4eDzbhHg0lpDLKG9B9iuXZq8n3bJ+R1GwQatkS73xWxIJIAYusNB3RC0gW8RJO1hHBROd95DaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VRdPFW8m624EcIiaT1wa9W3x13nIxEjLE7peKGDYw40Xz+rQ
	thurc4U0FX2OkonmIRr35foALsRGvG0r0unInVy5cqutMu9W11DnoYrAL1JTe0c=
X-Google-Smtp-Source: AGHT+IHn7jhW8Fy9/pjCjl+mhkMw6ezrscYRK9gxg95hZfxlj7C/vtXMhfFrMLSxRdPvmXvhab6L6Q==
X-Received: by 2002:a05:6512:33d2:b0:52e:e3c3:643f with SMTP id 2adb3069b0e04-53546af4288mr1110083e87.2.1725010314829;
        Fri, 30 Aug 2024 02:31:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-535407ac076sm510076e87.87.2024.08.30.02.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:31:54 -0700 (PDT)
Date: Fri, 30 Aug 2024 12:31:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de, 
	stable <stable@kernel.org>
Subject: Re: [PATCH v1 2/3] misc: fastrpc: Fix fastrpc_map_lookup operation
Message-ID: <qeoclfg7inqwdzbxl35wsu6z7xecbc77albmnbge3h3hfr5uph@wxl5vfjfs35u>
References: <20240822105933.2644945-1-quic_ekangupt@quicinc.com>
 <20240822105933.2644945-3-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822105933.2644945-3-quic_ekangupt@quicinc.com>

On Thu, Aug 22, 2024 at 04:29:32PM GMT, Ekansh Gupta wrote:
> Fastrpc driver creates maps for user allocated fd buffers. Before
> creating a new map, the map list is checked for any already existing
> maps using map fd. Checking with just map fd is not sufficient as the
> user can pass offsetted buffer with less size when the map is created
> and then a larger size the next time which could result in memory
> issues. Check for user passed VA and length also when looking up for
> the map.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index bcfb8ce1a0e3..ebe828770a8d 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -362,7 +362,8 @@ static int fastrpc_map_get(struct fastrpc_map *map)
>  
>  
>  static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
> -			    struct fastrpc_map **ppmap, bool take_ref)
> +			    u64 va, u64 len, struct fastrpc_map **ppmap,
> +				bool take_ref)

Please use consistent alignment between the lines.

>  {
>  	struct fastrpc_session_ctx *sess = fl->sctx;
>  	struct fastrpc_map *map = NULL;
> @@ -370,7 +371,8 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
>  
>  	spin_lock(&fl->lock);
>  	list_for_each_entry(map, &fl->maps, node) {
> -		if (map->fd != fd)
> +		if (map->fd != fd || va < (u64)map->va ||
> +			va + len > (u64)map->va + map->size)
>  			continue;
>  
>  		if (take_ref) {
> @@ -752,7 +754,8 @@ static const struct dma_buf_ops fastrpc_dma_buf_ops = {
>  };
>  
>  static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
> -			      u64 len, u32 attr, struct fastrpc_map **ppmap)
> +				u64 va, u64 len, u32 attr,
> +				struct fastrpc_map **ppmap)
>  {
>  	struct fastrpc_session_ctx *sess = fl->sctx;
>  	struct fastrpc_map *map = NULL;
> @@ -760,7 +763,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
>  	struct scatterlist *sgl = NULL;
>  	int err = 0, sgl_index = 0;
>  
> -	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
> +	if (!fastrpc_map_lookup(fl, fd, va, len, ppmap, true))
>  		return 0;
>  
>  	map = kzalloc(sizeof(*map), GFP_KERNEL);
> @@ -807,7 +810,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
>  		err = -EINVAL;
>  		goto map_err;
>  	}
> -	map->va = sg_virt(map->table->sgl);
> +	map->va = (void *)(uintptr_t)va;

This looks unrelated

>  	map->len = len;
>  
>  	if (attr & FASTRPC_ATTR_SECUREMAP) {
> @@ -920,7 +923,8 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
>  			continue;
>  
>  		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
> -			 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
> +				(u64)ctx->args[i].ptr, ctx->args[i].length,
> +				ctx->args[i].attr, &ctx->maps[i]);
>  		if (err) {
>  			dev_err(dev, "Error Creating map %d\n", err);
>  			return -EINVAL;
> @@ -1106,7 +1110,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>  	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
>  		if (!fdlist[i])
>  			break;
> -		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
> +		if (!fastrpc_map_lookup(fl, (int)fdlist[i], 0, 0, &mmap, false))

Isn't this going to always return false?

>  			fastrpc_map_put(mmap);
>  	}
>  
> @@ -1412,7 +1416,8 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>  	fl->pd = USER_PD;
>  
>  	if (init.filelen && init.filefd) {
> -		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
> +		err = fastrpc_map_create(fl, init.filefd, init.file,
> +				init.filelen, 0, &map);
>  		if (err)
>  			goto err;
>  	}
> @@ -2034,7 +2039,8 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
>  		return -EFAULT;
>  
>  	/* create SMMU mapping */
> -	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map);
> +	err = fastrpc_map_create(fl, req.fd, req.vaddrin, req.length,
> +			0, &map);
>  	if (err) {
>  		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
>  		return err;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

