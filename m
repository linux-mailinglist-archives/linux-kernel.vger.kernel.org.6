Return-Path: <linux-kernel+bounces-196623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616BC8D5EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4727B285E6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6ED1420A8;
	Fri, 31 May 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwkMn/s+"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4117C6EB
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148889; cv=none; b=dzPtRvyKmxk0JPaiLXM7wpu4PBF8dfzBckwLk9vr91lIgSOTrdANnu5dcnStlslaVHQQSv1gme/SFjSWqkdx1bC2TRs0qLJGkpS3Yk1ZWMAu60+vqYurzG4n5N2/XWTXaomstkAllFmuo1wnWxT7R1Nul7EUvd66NkemJDhZzf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148889; c=relaxed/simple;
	bh=iY0Y8pGOe7NKlzuhxWSHCXrnuMnl+pFzytg+XGfJ2Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mv18AYTkvN1RQnDP/0hca0TlZRqG6jgIn95Fq5O7Z6W4f6YYH9bsEfcdSP9frtHrI4o2Wt/rCL2WkAOzZz3KgnG0u6LBiyq9nnTdxB090WTUlCs0BfRoXrdhYIeVm/nEuaYlWapSTTUqJ0+jwheUz+F3J6ElnuPEZUh0/LaTUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GwkMn/s+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35507e3a5deso1260128f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717148885; x=1717753685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3QphDfY5f+dlpkjZJqpKBufDO6kEZfbPYC8lG8WaDP0=;
        b=GwkMn/s+V7/EOe3FUyHWdzwUUtQwqD9D3XpruOy/4uoeXDAfjFewUfj5ZgB0cYST0y
         oWw0+FQ1BrbQcoLXlStIBwQUQEoUpiuYBAKwey3RfjlHfL5ZMpCZM2Th8JasECLMJSuO
         E8qYW38sj1avZJORNE5w4RKKXfBNk4zWABtBV2BjpRiJFX4ILkQTVnp+ZWon9XKwvroQ
         Uy4XnbLy6lR+TOn+ai4IdHdR3xTZx1Js6kISAuG+3cn6H0GjnT/v4LcBR8g4UdzdiAI8
         K07rOjj/HEBaMfiLRXhn7Gh2vTS5uane4biUDnWwkIfKXBHq6n5uxm4anXXDkzN5H178
         Vt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717148885; x=1717753685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QphDfY5f+dlpkjZJqpKBufDO6kEZfbPYC8lG8WaDP0=;
        b=fDa++SH9131gN4E8fPxpNV9ic/9/wbHdzCvV3Nx7ALSmIJBzIrQQJo2B5qalw6VzDw
         kC43byFKzr671a1nqvjzk8jaLU2elhP7UPphpBJRBCU9lR7am233znv1qTMnsEFX2IrI
         Q6k1TgiL26qseTcWtp/rLzHjRIItVKhV3anWU2FS17xWtayBibvt7672TS82YXiHbXEu
         uIZvCOFdj2XSXwRe+IQ02dV5Nf5qgbO1an5qXuze/Aq9CNL6COz4haGQ2xfnJq1FwhYy
         ZBUS9valyX6/h5Ku1ZxCgVzhtg4ruUAwwuECKiCCVpSgHMYtnZOzF5S9HpRIgfQEyYAk
         HWZA==
X-Forwarded-Encrypted: i=1; AJvYcCVUGmpIvPduFkqRhw6sFoQJoFRJj0Divp4awFApvwtTKjpP69+yct+UR02+zPXoft6BxxOHKkD4HHhtvMazDiISJHwyxLpws3sCq3AJ
X-Gm-Message-State: AOJu0Yw8TvXGedb9s60lmoneG+/iUbsw0BnwaV6brq/iNkFZ/iUUkC5W
	9hJ/f3ijAZjPF29eLfh43wvYlTGS9KjD38m4BGL25YJINL7j3N/iCMrPFaJpiYc=
X-Google-Smtp-Source: AGHT+IFAQRuZmhDxjGlW6esaOhNk56To1ieBo/3ULHIoW0dljiOjAH1mTqztqjhXIUNxR9S9PL+8Cw==
X-Received: by 2002:a5d:4aca:0:b0:358:d9d4:1026 with SMTP id ffacd0b85a97d-35dc7e3e320mr4172508f8f.17.1717148885258;
        Fri, 31 May 2024 02:48:05 -0700 (PDT)
Received: from [192.168.86.191] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd062ee31sm1461077f8f.87.2024.05.31.02.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 02:48:04 -0700 (PDT)
Message-ID: <8fd4ba90-bd9a-4520-a287-f2119a37acb9@linaro.org>
Date: Fri, 31 May 2024 10:48:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 stable <stable@kernel.org>
References: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
 <20240530102032.27179-8-quic_ekangupt@quicinc.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240530102032.27179-8-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/05/2024 11:20, Ekansh Gupta wrote:
> Untrusted application with access to only non-secure fastrpc device
> node can attach to root_pd or static PDs if it can make the respective
> init request. This can cause problems as the untrusted application
> can send bad requests to root_pd or static PDs. Add changes to reject
> attach to privileged PDs if the request is being made using non-secure
> fastrpc device node.
> 
> Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d9d9f889e39e..73fa0e536cf9 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1344,6 +1344,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   	} inbuf;
>   	u32 sc;
>   
> +	if (!fl->is_secure_dev) {
> +		dev_dbg(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
> +		return -EACCES;
> +	}

Please move these checks to fastrpc_device_ioctl which makes it clear 
that these are only supported with secure device nodes.

I would also prefer this to be documented in the the uapi headers.


--srini
> +
>   	args = kcalloc(FASTRPC_CREATE_STATIC_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
>   	if (!args)
>   		return -ENOMEM;
> @@ -1769,6 +1774,11 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
>   	int tgid = fl->tgid;
>   	u32 sc;
>   
> +	if (!fl->is_secure_dev) {
> +		dev_dbg(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
> +		return -EACCES;
> +	}
> +
>   	args[0].ptr = (u64)(uintptr_t) &tgid;
>   	args[0].length = sizeof(tgid);
>   	args[0].fd = -1;

