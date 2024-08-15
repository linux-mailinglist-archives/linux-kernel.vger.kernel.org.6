Return-Path: <linux-kernel+bounces-288136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171C0953655
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD90285390
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAA61A01DE;
	Thu, 15 Aug 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpVzKXMs"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD51A00DF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733706; cv=none; b=J0lAu43gO7jozV4JbUIBPSobyYIutyUfVkviq/7+PMc9rCOyrX/mThVlTaENheTKeeZna7H1OEzzE95Z1TEpxxz8N1mwWL/STnPRatJqboGPhLcYUs+CXgc/3ALxukqNY+ShfowbVb5P7khPJ0Kn41KVEBIzMV5/FQjoue5mIoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733706; c=relaxed/simple;
	bh=jAkiIYHIsImSFQp06/C1NtzsJbNgH2RP8TgSM9DMihU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVCb7RkwcIwrfvOTFfAoYEH3mXZY05DcL3afL/adL83tGDXysTWgyHgp81FaenZpG/R6DPK/jIK6ZPlWw1kvTLu09rWGoWNWNzb5qMlmlQ/d7DdLc71IYeQy6/7KVsQ8g/mJJtBCu630rSfCndV+v1rIGFClX/aRw3hYV8GPWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bpVzKXMs; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so146931866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723733703; x=1724338503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRsVMvhV1m4jnkyYapmQ2mhT4HUKsi82zyg3o1vJhj4=;
        b=bpVzKXMs/lur6/Pu2DpgvhvvrNYHYNNZLHowoP5K3khQqIzltWdXDufF36hSto1fsw
         gq3esG53+WimfOc4mLfJyzSodOS2bSPcl/LbspIsYB7H9xOIOPjA596hTg9X2IS243f5
         qCnoHSt/pbS/Id9zax9QiuiCRTDNm2f3rPK3nvV4yPKPgTdCGAiJQGF4S2kojTAkWIcw
         FoLFHbpxqZYeVaBPFxW2Xij6iopqmRHjoNrGpJs9YxLXaQnYpm8rbbbSQRDUgxD9eE9V
         hYrWp20PoPx7pNjs6V3TscWVQib7Roc50XrEnIrnJMet8wnIKU+2/7BNMfKPqauKpkYH
         jkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723733703; x=1724338503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRsVMvhV1m4jnkyYapmQ2mhT4HUKsi82zyg3o1vJhj4=;
        b=nXqv/Q+Dwbi+4GJGm++ky5PnTN31fm4ppNb/J2dx1OPcw1z59A48PrlFtXimGekR5U
         M+OyjqNT5WISNQCkGZhX/hXlnbs8YCt6F5OSt77Wk2JFwl2bZ59dVEkSD8Aq6pB/zcy2
         ztmsN7pqn5VElLwqYAjD7XrULVJBiFweL5zu/I2+kq1VllCRVzGwSu2NB70c9QBuwLTR
         m/PBvd7blUd7y2mSM8o6TthsonB/cs3cJ/ojvW3U9YFsp66XgD5yAUaty/uRVeVOkQNM
         svF8dkhKr9fWaACzvmcNDsNK70Q+ee8deWU26L3UFNCvz8b+V00c1nJZofDMSKDJCQFD
         akJg==
X-Forwarded-Encrypted: i=1; AJvYcCVvFcwQefryNI+BPXuXLq9xzF8RciSIUgWdDu/+HDnNLbTIkBwz4Ahr3d1meVTiRxAlarFDW6ZSy/SUwFl6AZnXWuzqpc/RPtaJPz55
X-Gm-Message-State: AOJu0YwLcMR5LZUpkiWGnNGzHiNGFWvkrSZXb2w3E/uIpecrHDhb8hny
	sQD4Kak2qPEiFgkcLS7GJSFhFoi7e+Pj8OtlIIx56pLFJQqqM7JhJhaBQWmRER4=
X-Google-Smtp-Source: AGHT+IGOnLR0ehKGNshAowR/t71XZukLfFAAiAx7KkDRy7tTRlkvpQgdTikiClXZ8+TFuO8RPTOe0w==
X-Received: by 2002:a17:907:e6e4:b0:a7a:bae8:f29e with SMTP id a640c23a62f3a-a8366d43f97mr425022066b.29.1723733703106;
        Thu, 15 Aug 2024 07:55:03 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8383935663sm113133966b.121.2024.08.15.07.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 07:55:02 -0700 (PDT)
Message-ID: <b93eda80-828c-4873-a52b-34428f3570df@linaro.org>
Date: Thu, 15 Aug 2024 15:55:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "misc: fastrpc: Restrict untrusted app to attach
 to privileged PD"
To: Griffin Kroah-Hartman <griffin@kroah.com>, amahesh@qti.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>,
 Ekansh Gupta <quic_ekangupt@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joel Selvaraj <joelselvaraj.oss@gmail.com>
References: <20240815094920.8242-1-griffin@kroah.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240815094920.8242-1-griffin@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/08/2024 10:49, Griffin Kroah-Hartman wrote:
> This reverts commit bab2f5e8fd5d2f759db26b78d9db57412888f187.
> 
> Joel reported that this commit breaks userspace and stops sensors in
> SDM845 from working. Also breaks other qcom SoC devices running postmarketOS.
> 
> Cc: stable <stable@kernel.org>
> Cc: Ekansh Gupta <quic_ekangupt@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reported-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
> Link: https://lore.kernel.org/r/9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu
> Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
> ---


Lets fix this properly by updating existing device tree entries and 
bindings to enforce misuse of "qcom,non-secure-domain" on all Qcom SoC's.

As this patch is only doing part of the job and breaking existing 
platforms,

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini



--srini
>   drivers/misc/fastrpc.c      | 22 +++-------------------
>   include/uapi/misc/fastrpc.h |  3 ---
>   2 files changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 5204fda51da3..339d126414d4 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2085,16 +2085,6 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
>   	return err;
>   }
>   
> -static int is_attach_rejected(struct fastrpc_user *fl)
> -{
> -	/* Check if the device node is non-secure */
> -	if (!fl->is_secure_dev) {
> -		dev_dbg(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
> -		return -EACCES;
> -	}
> -	return 0;
> -}
> -
>   static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
>   				 unsigned long arg)
>   {
> @@ -2107,19 +2097,13 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
>   		err = fastrpc_invoke(fl, argp);
>   		break;
>   	case FASTRPC_IOCTL_INIT_ATTACH:
> -		err = is_attach_rejected(fl);
> -		if (!err)
> -			err = fastrpc_init_attach(fl, ROOT_PD);
> +		err = fastrpc_init_attach(fl, ROOT_PD);
>   		break;
>   	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
> -		err = is_attach_rejected(fl);
> -		if (!err)
> -			err = fastrpc_init_attach(fl, SENSORS_PD);
> +		err = fastrpc_init_attach(fl, SENSORS_PD);
>   		break;
>   	case FASTRPC_IOCTL_INIT_CREATE_STATIC:
> -		err = is_attach_rejected(fl);
> -		if (!err)
> -			err = fastrpc_init_create_static_process(fl, argp);
> +		err = fastrpc_init_create_static_process(fl, argp);
>   		break;
>   	case FASTRPC_IOCTL_INIT_CREATE:
>   		err = fastrpc_init_create_process(fl, argp);
> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
> index 91583690bddc..f33d914d8f46 100644
> --- a/include/uapi/misc/fastrpc.h
> +++ b/include/uapi/misc/fastrpc.h
> @@ -8,14 +8,11 @@
>   #define FASTRPC_IOCTL_ALLOC_DMA_BUFF	_IOWR('R', 1, struct fastrpc_alloc_dma_buf)
>   #define FASTRPC_IOCTL_FREE_DMA_BUFF	_IOWR('R', 2, __u32)
>   #define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
> -/* This ioctl is only supported with secure device nodes */
>   #define FASTRPC_IOCTL_INIT_ATTACH	_IO('R', 4)
>   #define FASTRPC_IOCTL_INIT_CREATE	_IOWR('R', 5, struct fastrpc_init_create)
>   #define FASTRPC_IOCTL_MMAP		_IOWR('R', 6, struct fastrpc_req_mmap)
>   #define FASTRPC_IOCTL_MUNMAP		_IOWR('R', 7, struct fastrpc_req_munmap)
> -/* This ioctl is only supported with secure device nodes */
>   #define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
> -/* This ioctl is only supported with secure device nodes */
>   #define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 9, struct fastrpc_init_create_static)
>   #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
>   #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)

