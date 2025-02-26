Return-Path: <linux-kernel+bounces-534136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 405FDA46344
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1677167D28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DFC221DB1;
	Wed, 26 Feb 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UA0T92Yi"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3DB21D3C7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580923; cv=none; b=jRg/xhXsBNx9E6/PfzqbnQvKA2sJhiW5jSAF+9JiorT1tXoepsiS3zzOkvnETk4U0CaQm18aTN0ReeyL9B5pXN0n2q/HjG88c8oiLGeQ/IGRSS9lthO3Ct4CwJ4QFh5QGuCLUfVqxlWCmx65XO1UAmTu7Zfc2bjcdXZ/nGEIW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580923; c=relaxed/simple;
	bh=4FWXayBvVhNTS0E6OWpQiCVezWoKUfgMUUoPmP8gePk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pl3SMZiWx05KDwgmvtlSHLnb0k6m5Z1+/3oQoE7QqzQ9E+mfbBtJkdjXmrQxyI+Rr6HghCH/KFyY/51Tv38E+L0Tjyxh2LAHwDUnyaNhPM0Vt7ZRkRovW5C1Omf1wlpWpgmRxP18MRC4ts478C0ELN9jBq8Corx8AC7UgTo2YZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UA0T92Yi; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso1203685866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740580919; x=1741185719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yd4Q4hVeUYOM1ue+qUfzWNg9Q9i3oT/9A9AYIFfGkUc=;
        b=UA0T92YiBtus8ppEPCDg10F757C1qob4i4FvX+s7vjhN06JNq09tElmthayuZTKbKR
         RzBb38v/U1Tzi19jDCCKfJ53nBVMHlTo4YRBTAT+fa36GR1daqknAVGi9+MjMMyGwuYA
         rOmuWLd2B4Pm7oDF7avN9M6Le7mDbT/Ur4DX0LIzc+0kCLKShWuMR7lyzkU9yirIXxsA
         SHikx/C4FcLi+M3Uu8T8uTvLjeMOiachCQHWNAcZlLpyXRW/exId+fnmOo6+wm54cA+Y
         5KlcZvwLo+17WtT5kNkzT6tI7l+preG+EKVTlgCpuLnooIW80GCVX1kZYEmVFa+eTgri
         kjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580919; x=1741185719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd4Q4hVeUYOM1ue+qUfzWNg9Q9i3oT/9A9AYIFfGkUc=;
        b=mby1afW4Qe/ZBpzyRVBcGeQnF70mmKFBWuB9FlW9QsAqhj6TIkMDniRJoH2oqWiy97
         g0Wx8Bt/UKg+s9CLHjOWkkYnYooLX3HVM8HywHRbhIjKD/YmplLyDO9aXOEEt6Ey/E9O
         RWXefo34ErNvBbv8/05zqJqbplLwend8XfSOqbNJpPr4rrxn3WcdXk/1NJ9zg7rA70yt
         d+9cHl9jArBxABUiEpRKTscMAQHxKj2tghgxnsn9qG9GyK+kUTq+CZlir9zsnNhTRcRL
         jEPTd2hhXqqy6KolZE4UgaqQmelrGrCbLBgxdbmsHBsPKIFYC6CGK0D2NAsBiOZXonZr
         JIgg==
X-Forwarded-Encrypted: i=1; AJvYcCUTCk7plM6xGy85EEqyAB0tPioNEoAQ/j1x5LlfU/zICXy/bmMrx5tnL81TNBm59s4Dns+zCQDMXKlfN/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy++h0zousjAEyBQZuzWe7VUXwelR9/rHj9Y9ivWFwLe+EMG7OJ
	MQPDJ+F4sudz+4lxTMMH1mSlf4+F0CxxdOnuoAIuCBh1DuXHH2GjrcAb9eVDDF0=
X-Gm-Gg: ASbGncvOWQkKkCB7G2RcOpu3im0/e/35I4z/GgIKiMsF2ppUn57wPqeZYNfsvo3HVHT
	Jn+5D6hnjl+adz/5nlvDFgxO86cywS7JynjuK/ZTc0NxQJwTZOhmEzdEhDS+8R2qtJiksb5p3GR
	60rLe9Pe0YEkWbyaujrLfD0Rsyj+utQ9bMaQdUC/C8C0ddBuNf7117PstoM582VEBB3xhllb89E
	mTKawrgPB1WILVHojbmWbaTC5TzvBLYlszjaEdWC52m+w2IW3/q2Too4zSyurj3WCYK3FBHk47R
	itIXAoGBvpf7hger1kK/ebhbo3UggZE=
X-Google-Smtp-Source: AGHT+IEqq+wCIO+7KpV9xqIa2Ubw1hCVyP4Ga6WxVj5wemOObN4UBSusPlhMuI5n8yBIpYErWlyqpg==
X-Received: by 2002:a17:906:314d:b0:ab7:9df1:e562 with SMTP id a640c23a62f3a-abc0de55dbcmr1974440866b.48.1740580919225;
        Wed, 26 Feb 2025 06:41:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abed2012142sm333883966b.117.2025.02.26.06.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:41:58 -0800 (PST)
Date: Wed, 26 Feb 2025 17:41:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: slongerbeam@gmail.com, p.zabel@pengutronix.de, mchehab@kernel.org,
	gregkh@linuxfoundation.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	hverkuil@xs4all.nl, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] media: imx: fix a potential memory leak in
 imx_media_csc_scaler_device_init()
Message-ID: <450cdcc9-ccb8-4ebd-847c-b106fae2d709@stanley.mountain>
References: <20250226142126.3620482-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226142126.3620482-1-haoxiang_li2024@163.com>

On Wed, Feb 26, 2025 at 10:21:26PM +0800, Haoxiang Li wrote:
> Add video_device_release() in label 'err_m2m' to release the memory
> allocated by video_device_alloc() and prevent potential memory leaks.
> 
> Fixes: a8ef0488cc59 ("media: imx: add csc/scaler mem2mem device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/staging/media/imx/imx-media-csc-scaler.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/imx/imx-media-csc-scaler.c b/drivers/staging/media/imx/imx-media-csc-scaler.c
> index e5e08c6f79f2..f99c88e87a94 100644
> --- a/drivers/staging/media/imx/imx-media-csc-scaler.c
> +++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
> @@ -913,6 +913,7 @@ imx_media_csc_scaler_device_init(struct imx_media_dev *md)
>  
>  err_m2m:
>  	video_set_drvdata(vfd, NULL);
> +	video_device_release(vfd);

The video_set_drvdata() call is pointless.  It just does:

	vfd.dev->driver_data = NULL;

but that's not necessary if we're just going to free "vfd" on the next
line.

regards,
dan carpenter

>  err_vfd:
>  	kfree(priv);
>  	return ERR_PTR(ret);


