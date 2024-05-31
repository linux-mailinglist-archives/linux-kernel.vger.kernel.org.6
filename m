Return-Path: <linux-kernel+bounces-196585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57978D5E57
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9E71F228FA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550D684FA0;
	Fri, 31 May 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q87Wh0Uq"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEADA7581D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148014; cv=none; b=IZh/ySBirnfH2elZe+7KvGz4lfDx7gLGJVx5qqhQ2tKJFVtgAFJKW8HJ6q+ug0X15gVHK3D34BHQ2/7hC3IYZk6NR9Aqc2uf7/Q+EswSGFyzN/dq37afXQuWME9qJPuofQlnWRxEBUgJX3BoOfXupbnOBlMawkyyvkf9eAEof64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148014; c=relaxed/simple;
	bh=zvfDNrLm2R/lNmQf1Z5UPnKn0BPnoDGVqQlqTMVdjq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfJGRmSJ6CNHUK3Og/wEEZdlTxRHTu1j/SfjZB2F0u0utqokmEzGYRhL0P1aZuukYczgEQjAnUsMlwmaeON9kYl0ps2o7hKAKhn3newDYXHxM+bhIbtiY3Spp4H4FhWaxNFEgCT0VxjHfOy+WFdYWhTZCVZeCehrquPpirEEzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q87Wh0Uq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3550134ef25so1840629f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717148011; x=1717752811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NWC5UvA3PX+lrjXy8TOdybdxeWSIoSynZtnq1QH028=;
        b=q87Wh0UqRuz/4OCgDSm1YGkg1p0TocbJ6mR9OQp16ysnEWqcxGcttIhXFAQrC0e30+
         e+VdNOUd7osxQlbDm0X8FEPcoRBK8lQe9MpT/P6Hbn3vqcbqEr0KSMBiSSbrf7j1dv7/
         pR3pR/hMCkhLXLkz1goqoXXmwPcVTuaKTrgc3n+qn5g8KxebhRxlr5alS/Bst3n3HHBH
         6GTl4egwrfC5V2+SWElSJtRpMTe0y2m7PFzaWzp7Aw97CCFBq5rHZg30RwNSlD0u02/Z
         4B2DSMJbmAeVWbmOGeLXfSNfE5o/y+HdIZY+IALfTx8TXAcHkhYMz3uv9jmqXoQw1IEy
         Cz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717148011; x=1717752811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NWC5UvA3PX+lrjXy8TOdybdxeWSIoSynZtnq1QH028=;
        b=GtUZ6uO2U80lpfV5Pmh3sb6fVvLySSGAou+29hilk3vRofYR/0PFBRyz09kkER2iJE
         S7M+J8IrLt0on0u6ZYdvbc1gTl/xmWwiDAzsDf3eHQ3a+UJYQHsE4fl4XBaOVexoCdwf
         1J0HluA/SpdqPSV2Fg5VeBZsA/4GWJv2cX49xBHVnzN6jkDmUzoON4OUIqIK9H5a7/YD
         efBMcv2EZTKPyi/tgGKD0RBpUXfvswZ+caH+RD/S/h+ECe8mlV4g77659lqENQeKDA55
         son3xvZeL/meDv9JOdUNL06efQjy97qyT/QGXmtNGeCPVjMhcYHbSaD3aBwezxt0M8oR
         3++g==
X-Forwarded-Encrypted: i=1; AJvYcCWjAPFDsxi6LbST4v0uLLt6HeXGHEEDIuQXhiphouASlxdkEXJU2kCvySGxnTHrSrpdxPBoZc0dW03/4YfgDX3/vxf1EOdBA9NkkxxC
X-Gm-Message-State: AOJu0YyeAQo5H/t2Ogqm9P0aIYTwABGvVGOqP3TCCWctMnt8WWP8EFv5
	Ip9IXJVgY1T1gcufc0qXMBUHRK2CsIDoofts8cTffsprxG9dHlGsiNdXwtUBbU4=
X-Google-Smtp-Source: AGHT+IEG1fEEuxHoaL+fZBj37w61ECXaZTpWHpl0KSl26+8N2yWpwFbQjEkez/6TmMZRhlH8H5ZxwA==
X-Received: by 2002:a5d:6291:0:b0:354:f724:6412 with SMTP id ffacd0b85a97d-35e0f25e125mr754333f8f.3.1717148011164;
        Fri, 31 May 2024 02:33:31 -0700 (PDT)
Received: from [192.168.86.191] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d6csm1446440f8f.1.2024.05.31.02.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 02:33:30 -0700 (PDT)
Message-ID: <32750882-2e4c-44b7-af6d-a1ec0857b69a@linaro.org>
Date: Fri, 31 May 2024 10:33:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] misc: fastrpc: Fix DSP capabilities request
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 stable <stable@kernel.org>
References: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
 <20240530102032.27179-3-quic_ekangupt@quicinc.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240530102032.27179-3-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/05/2024 11:20, Ekansh Gupta wrote:
> Incorrect remote arguments are getting passed when requesting for
> capabilities from DSP. Also there is no requirement to update the
> PD type as it might cause problems for any PD other than user PD.
> In addition to this, the collected capability information is not
> getting copied properly to user. Add changes to address these
> problems and get correct DSP capabilities.
> 
> Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 4028cb96bcf2..61389795f498 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1700,9 +1700,8 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
>   	args[0].length = sizeof(dsp_attr_buf_len);
>   	args[0].fd = -1;
>   	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
> -	args[1].length = dsp_attr_buf_len;
> +	args[1].length = dsp_attr_buf_len * sizeof(uint32_t);
This does not look correct,

we have allocated buffer of size FASTRPC_MAX_DSP_ATTRIBUTES_LEN which is
already (sizeof(u32) * FASTRPC_MAX_DSP_ATTRIBUTES)

now this patch multiplies with again sizeof(uint32_t), this is going to 
send dsp incorrect size for buffer and overrun the buffer size.



>   	args[1].fd = -1;
> -	fl->pd = USER_PD;
another patch may be.

>   
>   	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
>   				       FASTRPC_SCALARS(0, 1, 1), args);
> @@ -1730,7 +1729,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>   	if (!dsp_attributes)
>   		return -ENOMEM;
>   
> -	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
> +	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);

You change this again to send FASTRPC_MAX_DSP_ATTRIBUTES instead of 
FASTRPC_MAX_DSP_ATTRIBUTES_LEN but why?


>   	if (err == DSP_UNSUPPORTED_API) {
>   		dev_info(&cctx->rpdev->dev,
>   			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
> @@ -1783,7 +1782,7 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
>   	if (err)
>   		return err;
>   
> -	if (copy_to_user(argp, &cap.capability, sizeof(cap.capability)))
> +	if (copy_to_user(argp, &cap, sizeof(cap)))

Why are we copying the full struct here? All that user needs is 
cap.capability?



--srini


>   		return -EFAULT;
>   
>   	return 0;

