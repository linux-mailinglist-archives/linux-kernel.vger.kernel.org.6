Return-Path: <linux-kernel+bounces-206058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5409003C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73C61F216F7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306A8192B82;
	Fri,  7 Jun 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqvwoaSt"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951D15DBB6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763971; cv=none; b=nOl/cUxcxvlcuJrd7bPNwaIc8lT/J51PcWzhqKm0Vjz4P5T7oVG27igBLGLMn2rJgzIQt/wGWmVSEd0khqQ78sdZsHUNUqAqzMYz/UOko0Vl74F1bhTjhUEO7gHgicToqWmYUv1dKLvrAkjSMDidQokTb9SIMR17JUmsIafG1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763971; c=relaxed/simple;
	bh=DO+PIT/EJMox0z4MVaaerBJVh16m1+q/CufQuXZm2ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBwBFY8J04+asbzH4XJc+Gu4BEmunvpFACaae5FwBYuMrR/0BrBsOWq0Z3pRv4Bm2jzs/RrV29WMHr2PoRQAQp1a2x7b5KDQ53P/iHjtbmhVb7zbTw17cZBU0rHXuv4lLhoiMmYUu6Grz9USpSS6Grlcl5b6vQgBvlvFrsoGl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mqvwoaSt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a63359aaacaso318158366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717763967; x=1718368767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqD6XhPELg3ekIrsN8OFaQlLrK5OO1qpE6V+0H8DfXA=;
        b=mqvwoaStNzcUZ8gJXM3LokMi+4BfZddPYzcU4BsmQd7Hpdo9Zua8Q+Xt4vvjWBzota
         K9/4kdNbKPjT3JHpeeD9iUu8KxjmVyfZr7zuT70dmVkty7z0fMO5l8WgdVtxAmoG67Zr
         NjdJlStKpZ6I/luvDqj7XqJWuDwcWFEOXikn7kleuwQHm2qFp3ykLePMJxM92GSEM8wU
         4itUMkrm4ekJ2EWV0mhGBVPlihAZAinQSreq8qVMuE4duWqxDeaXCpZT+h6mz5s3115O
         Squ1E90nL/l1juaO7M+iJ/hlvrolLEQ9PWY6gjU+sKBvqroBb2LAjLew4Wi6nPrbbFvJ
         kJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763967; x=1718368767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqD6XhPELg3ekIrsN8OFaQlLrK5OO1qpE6V+0H8DfXA=;
        b=bYOPEco29nPDubyAP1Fbg9212ekvPaqvwJsPuN9v3iewwj4CN9whpyLyLLAcq9CQSC
         E6rViWtO8SkpWivUBHNeLrfkgKVGU3tNDcTSBF+xjpsVow/Ugs/QRggB2k0S3GF4fJ+U
         DM1jfHljPqSYZaRWegFFAyKvL7U3vBovX/vz8EPQslAiMAwI0TTGZZevimuUUH4aTTX0
         WDhZ3UNKfukOg1C+1QCLKY2jo2BZDJUoTGuzZjXCGXY4ZK5iGywWMNUgb5GjbpV4n3L5
         IvgptbF0EecyVlUTu8ToxRUPLomM2xfmwi7qASy1nhBpcihKdn0LR3+1NmJ+2gYPDjvZ
         K3ag==
X-Forwarded-Encrypted: i=1; AJvYcCVcl+2wiKLBGmZJcgJ7SKFkK/5nbwS1Uif0m7NlacyH/mcVCwYVYsMMyb6abyJncTA36UF7EHzsAu0hcv6IAH5XUZIpCJNFoiUbnFSx
X-Gm-Message-State: AOJu0YwR5AqD7Iy2TQRWeZV+jl8XzF4Le7TzlYRwvBmCnDrRq59oc22A
	kmPmkpwhegMuQHTs3Emd1b0T33UjYwyywrJz1bmUtW3KICF76Em7R+HD9xntujc=
X-Google-Smtp-Source: AGHT+IHFsnXGj/HVopUpVNgtnvfTWQayW/r/JXohCR6sS47qkuu0spIm9tkwy9NxuON/tIaN6PleoQ==
X-Received: by 2002:a17:906:50e:b0:a6e:f6b0:c4a4 with SMTP id a640c23a62f3a-a6ef6b0cd21mr17804266b.57.1717763966672;
        Fri, 07 Jun 2024 05:39:26 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8090? ([2a02:8109:aa0d:be00::8090])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e7fesm244044866b.183.2024.06.07.05.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 05:39:26 -0700 (PDT)
Message-ID: <d9ddc852-2414-4314-8179-9ebba98d3ab1@linaro.org>
Date: Fri, 7 Jun 2024 14:39:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] misc: fastrpc: Fix DSP capabilities request
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, srinivas.kandagatla@linaro.org,
 linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 stable <stable@kernel.org>
References: <20240606165939.12950-1-quic_ekangupt@quicinc.com>
 <20240606165939.12950-3-quic_ekangupt@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240606165939.12950-3-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/06/2024 18:59, Ekansh Gupta wrote:
> The DSP capability request call expects 2 arguments. First is the
> information about the total number of attributes to be copied from
> DSP and second is the information about the buffer where the DSP
> needs to copy the information. The current design is passing the
> information about te size to be copied from DSP which would be

*the size
> considered as a bad argument to the call by DSP causing a failure
> suggesting the same. The second argument carries the information
> about the buffer where the DSP needs to copy the capability
> information and the size to be copied. As the first entry of
> capability attribute is getting skipped, same should also be
> considered while sending the information to DSP. Add changes to
> pass proper arguments to DSP.
> 
> Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 4028cb96bcf2..abf7df7c0c85 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1695,12 +1695,13 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
>   
>   	/* Capability filled in userspace */
>   	dsp_attr_buf[0] = 0;
> +	dsp_attr_buf_len -= 1;

The commit message states "As the first entry of the capability 
attribute is getting skipped, same should also be considered while 
sending the information to the DSP.". But it doesn't explain *why* this 
is the case. Please add a comment here explaining why you subtract 1.

With that change:

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>   
>   	args[0].ptr = (u64)(uintptr_t)&dsp_attr_buf_len;
>   	args[0].length = sizeof(dsp_attr_buf_len);
>   	args[0].fd = -1;
>   	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
> -	args[1].length = dsp_attr_buf_len;
> +	args[1].length = dsp_attr_buf_len * sizeof(u32); >   	args[1].fd = -1;
>   	fl->pd = USER_PD;
>   
> @@ -1730,7 +1731,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>   	if (!dsp_attributes)
>   		return -ENOMEM;
>   
> -	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
> +	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
>   	if (err == DSP_UNSUPPORTED_API) {
>   		dev_info(&cctx->rpdev->dev,
>   			 "Warning: DSP capabilities not supported on domain: %d\n", domain);

-- 
// Caleb (they/them)

