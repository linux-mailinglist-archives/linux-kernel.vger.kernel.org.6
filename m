Return-Path: <linux-kernel+bounces-205929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E88900248
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA14D1F27D85
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060418733D;
	Fri,  7 Jun 2024 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1jDKiWt"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701B188CC0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760188; cv=none; b=ty36KcUWTubd45LAnjs/kOeg+88CVvssPd1ZVwLHko48p8tY10a2PrQhxzcKmWQvx53LsiYpO13c9YWNw8mqrQ7Wnxg2DdLdpnRNewrbdm3xEr4sj77YVoIFlKaS0mGj3lzyWKFPrTZaNIks+HjurjWnhsErrJdreW1Fvx0acdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760188; c=relaxed/simple;
	bh=1igZTYjDPXjCcCgy+nI5U257Gn4g4WLUSFaInx/hv2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGyXA0MJHuWZalzU5ZWJTLmYij3Og6Q8pBXJg7mzLFcupTPDTFULGbfQQCF2TRM5VVeQk6ZUZ/eIH0EQxcfM+KSVgWa5GfxuQmXyegdrqPkz3LoHQQoliEfVCBotJp2iwNVxPVnCE9iCitjvsahv5yDdtSCR3TMoEXQ3uuP0ImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R1jDKiWt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b93370ad0so2762637e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717760185; x=1718364985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1mui+HBDxQUFLppGRIOuzCMTBMXzF+PVJZ3OkaVODY=;
        b=R1jDKiWtU+lV54BMnt1Zcuivxy8lZEWiYbJ3kGCl1zjVP0y/YxHNd0479hzQ8IOkEM
         WrQVGMKKBYGI8XrB4TwfgSTpXfdu0BHHJr/FyB99YLK1Swr3i1MKBcFI4eF6am3eCC33
         zzs7kXHXiQplThCVR4m0RManiE1NuzDBPx+Vp+HtZExGITKaI++RlpskRHZBdeHEV+/o
         VLTaoIilJgPH4tiIsjQ7uyP1LYCboJUOD1eYCPhoMAwKDLVwEBw6U08kXgsEBsrzyE/A
         4+95MAVbi7RQvS2fLV4gfLSYCqrLQYvs7n2WRMnU103ATMFOdhj9OnxIQk7k8OlbKgw9
         AFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760185; x=1718364985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1mui+HBDxQUFLppGRIOuzCMTBMXzF+PVJZ3OkaVODY=;
        b=df0gImo5Q+ZVttj82Ze22AjTKcwkXTfkIjkHj3vJ46Is1SZHU75Y3SiNWPWJLOQfab
         k3hBHUCoh/twbZZxY9wMXU03h0NDVBhXHoXC68Y84WjmnT28vG22QzXL6WgVK/iEFJNm
         3KFHb5uIxL2iOZYAUbi9s0xBuo5cgYeHgC9a0MwKwlNfKR460rX9G9xnR5LMZfaTfIM6
         BcwvjpuifuMVBL/8D4QTT68PT0vFDyCP4BmgZCZXaTu6uw19U94HGloulHw5Xf9CsrYQ
         f+Sg5J99JFUXSf8lq0sNkwcnXzL73QYfAleTZWuak4DpMo4m5DIDKVMbpeeW2L9/h8F7
         hGkw==
X-Forwarded-Encrypted: i=1; AJvYcCV88dG2T7eLZOGitlzRGerb0iojW+JdK7uLfCmHLrTs6sd3BWfsfdNVAr7i6p37L+BWekXXE5ee+DTO9TCZtrSkg6JqU3G4VHmjI1lN
X-Gm-Message-State: AOJu0YzgX3wS43FDLsWIR/QOLIMlezbx7NzLn+hYDgPgZGXO+buXECKf
	ZuK5+dXThkjP77fd4R1bFD6mv4ac0l41G/G64/Yr+6uDLvgfkZCXmb6KAQbb2Ok=
X-Google-Smtp-Source: AGHT+IGM/8XZd+a4grzjTEledb54wxf8n6pUQ5sZVQn1MV8kXi0PBuKaZ5LPBD39hh9yVO3xSnEBEw==
X-Received: by 2002:a05:6512:1308:b0:521:cc8a:46dd with SMTP id 2adb3069b0e04-52bb9f6275fmr2450550e87.11.1717760185284;
        Fri, 07 Jun 2024 04:36:25 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41ee3eesm502556e87.74.2024.06.07.04.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:36:24 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:36:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v4 08/11] misc: fastrpc: Fix ownership reassignment of
 remote heap
Message-ID: <7yogq6uxespor2vjzwu5fdw33aahhkep4dmpmjzkinke6deg4j@x6gmcyuotsex>
References: <20240606165939.12950-1-quic_ekangupt@quicinc.com>
 <20240606165939.12950-9-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606165939.12950-9-quic_ekangupt@quicinc.com>

On Thu, Jun 06, 2024 at 10:29:28PM +0530, Ekansh Gupta wrote:
> Audio PD daemon will allocate memory for audio PD dynamic loading
> usage when it is attaching for the first time to audio PD. As
> part of this, the memory ownership is moved to the VM where
> audio PD can use it. In case daemon process is killed without any
> impact to DSP audio PD, the daemon process will retry to attach to
> audio PD and in this case memory won't be reallocated. If the invoke
> fails due to any reason, as part of err_invoke, the memory ownership
> is getting reassigned to HLOS even when the memory was not allocated.
> At this time the audio PD might still be using the memory and an
> attemp of ownership reassignment would result in memory issue.
> 
> Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")

Fixes before functional changes.

> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 3686b2d34741..68c1595446d5 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1334,6 +1334,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  	u64 phys = 0, size = 0;
>  	char *name;
>  	int err;
> +	bool scm_done = false;
>  	struct {
>  		int pgid;
>  		u32 namelen;
> @@ -1398,6 +1399,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  					phys, size, err);
>  				goto err_map;
>  			}
> +			scm_done = true;
>  		}
>  	}
>  
> @@ -1439,7 +1441,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  
>  	return 0;
>  err_invoke:
> -	if (fl->cctx->vmcount) {
> +	if (fl->cctx->vmcount && scm_done) {
>  		u64 src_perms = 0;
>  		struct qcom_scm_vmperm dst_perms;
>  		u32 i;
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

