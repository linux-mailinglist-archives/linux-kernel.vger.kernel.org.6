Return-Path: <linux-kernel+bounces-548079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C76A53F96
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAEB1891C42
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBC054723;
	Thu,  6 Mar 2025 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeGmXz8/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233621345
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 01:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223157; cv=none; b=WQTgqs+8Y/boUnCN9n6sm30cFT5pooYEQfjmRH5/27tcXGFE1ovlF3WCF3ig5+In0x3cUL+gS82nZD0///z+WYYOo8xza4gSU6UwGaoxiq5NkQw6J+ZrINfi1cMA0L7disXk8WafTyT9pDEY9hEZPg3sTXR+eJS/6DEWx0z3E9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223157; c=relaxed/simple;
	bh=iKZaZZ93A8EmJ6E6wiLd3eIK1XonMbv0JikYfwCMXDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AivgQkstQzVK5xxP/Eet3VIktgh2Jy0ey74Svp0y7dVOj7JKl08OY2bDMm8389jEzL4/pO/ML1EbcyRAIGRcXx/UA6XteBdo5QYTxcI7xJ3EIZwN/PviftFnmVFvHurqVuqgv85TuMH8LGqi/3VsAqT3g4nrbABjpFA8Ucj21tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FeGmXz8/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so300065e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 17:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741223154; x=1741827954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUbDcyt1+aw6K+SCP95Z+3ScUhwExiAJQZmJDC2tNv0=;
        b=FeGmXz8/UXatXipjY2Uf8S0HWtoTPXHgP9s1mPZMdQcLRaDzOY1Y/Usr/GwFW0Quv+
         7RoacIMDUlhlgogaXx9xhOWRSsTBoXgDXD8mzu8YbztycICfbLNA6HqiUugex6vzJ+KJ
         F2tqnxBv4Ux3lQnPcvFMfondHwWRKbfKrdRK1m9Gdfn7JdwiNhkFClUUFngfzE1+bJrb
         LglPoMgT3KEbvUJ4dt2PFXTOJXb32y3rTKewOlWtT6WYCPVYop1GZZ24WO9IYVv+LA6R
         SizlpWjXXtvKHw6KEaF7pi1CzEreXpIJIsXN6izHjEBZDiYvy2VB3kYLTDHCa9jEsZWS
         CxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741223154; x=1741827954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUbDcyt1+aw6K+SCP95Z+3ScUhwExiAJQZmJDC2tNv0=;
        b=DUpkczyeRzHat2USohxo9ZND3XalXOxbc4eOpsKTmh4sPdzZp/ycoq7BhmZkVA+0Ce
         WrvNEuvXb4Db07SFzNGEhjxJ84Nkid036pFtZBlccoCV8oFUOLyr3KidYZgOIK5Wk4ro
         cTwXs4vtcggW/dnmbt3jJCxE8zvgEhYMxiA3e35HUq9+hf3hEP/fYEFVfx5fZ8xWTayY
         Y8fa4hlX2HVF8HTHol+3cNp422z2iET8YdDpJUabRuk0O7WLPseD2Z8AqkWBpLETujHJ
         HuqRxrheauNnid159xGeQf+X1SRzhr8/H3MbBs5qaS1c9G+KJcmYUMNUpUdhiPsQmB4A
         T/rw==
X-Forwarded-Encrypted: i=1; AJvYcCUk4nR5CVEDoxY6X/HUx26kKqsRCPPrrt4FhVG6L7eiQxrAxoiQMPNGGGDweFgR7v37oBb1C8idqg2UHtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xr767ITAdPKqsV34flQEDwnx1dWLaCj1OlPrFr3iXEWovk5f
	8AAZ6Zwv3k7Xu3H0DF1juCM+B1uyBWbaDSMo8ZmX+ejAKHGnNDiF7QAftqv6V4k=
X-Gm-Gg: ASbGnculWJt/1u/9Cda2kyfpXGg+SNhyLH5UMd3WRMdU2fSXDfg7BXrSkolJbBV2Y/k
	v2GCwiDXL+6ffjDWNBzYJGZIzFhJGqabIDTU4SR6X8mN8cItVRFkAR6SB28PrgpoMGhC/b9x0Zv
	Zfs0AcRPfFakFcvo6eDuHz7bnL5FX0Qaa9F2jwChHtmrEIPm07SW73h23UDJ45e2vue7lJjptEY
	rbARhuy89+HhtuXX74JMlDDILaw/44VtCSC7EVBf9CBwxNU0gGJo/6Y+xj1m5O38Mj/vbvMzL+2
	WYVB6wWxoJXdeoabA+sp+ebzZ07LXsy6H+zMZgm1U7lGrosI7PVCuSvaD2YEWjdBWI68xubSKsf
	SQOzX+odOfA==
X-Google-Smtp-Source: AGHT+IEBE+AjJSFQ5hTzB0AD9wDUmggQ6dY7nBAGbbjumNehivZ0YmNvgBtLxJfeYy/ati/9+ylr/A==
X-Received: by 2002:a05:600c:190a:b0:43b:cbe2:ec0c with SMTP id 5b1f17b1804b1-43bd29c9377mr40663785e9.27.1741223152664;
        Wed, 05 Mar 2025 17:05:52 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfe2bsm206780f8f.24.2025.03.05.17.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 17:05:52 -0800 (PST)
Message-ID: <ac44e16c-36af-471a-b47b-bb26ccd9f018@linaro.org>
Date: Thu, 6 Mar 2025 01:05:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/12] media: iris: Add internal buffer calculation
 for HEVC and VP9 decoders
To: Dikshita Agarwal <quic_dikshita@quicinc.com>, quic_vgarodia@quicinc.com,
 quic_abhinavk@quicinc.com, mchehab@kernel.org
Cc: hverkuil@xs4all.nl, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250305104335.3629945-1-quic_dikshita@quicinc.com>
 <20250305104335.3629945-5-quic_dikshita@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250305104335.3629945-5-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 10:43, Dikshita Agarwal wrote:
> Add internal buffer count and size calculations for HEVC and VP9
> decoders.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   .../media/platform/qcom/iris/iris_buffer.c    |   3 +
>   .../platform/qcom/iris/iris_vpu_buffer.c      | 397 +++++++++++++++++-
>   .../platform/qcom/iris/iris_vpu_buffer.h      |  46 +-
>   3 files changed, 432 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
> index e5c5a564fcb8..8c9d5b7fe75c 100644
> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
> @@ -205,6 +205,9 @@ static u32 iris_bitstream_buffer_size(struct iris_inst *inst)
>   	if (num_mbs > NUM_MBS_4K) {
>   		div_factor = 4;
>   		base_res_mbs = caps->max_mbpf;
> +	} else {
> +		if (inst->codec == V4L2_PIX_FMT_VP9)
> +			div_factor = 1;
>   	}
>   
>   	/*
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> index dce25e410d80..13ee93356bcb 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> @@ -31,6 +31,42 @@ static u32 hfi_buffer_bin_h264d(u32 frame_width, u32 frame_height, u32 num_vpp_p
>   	return size_h264d_hw_bin_buffer(n_aligned_w, n_aligned_h, num_vpp_pipes);
>   }
>   
> +static u32 size_h265d_hw_bin_buffer(u32 frame_width, u32 frame_height, u32 num_vpp_pipes)
> +{
> +	u32 product = frame_width * frame_height;
> +	u32 size_yuv, size_bin_hdr, size_bin_res;
> +
> +	size_yuv = (product <= BIN_BUFFER_THRESHOLD) ?
> +		((BIN_BUFFER_THRESHOLD * 3) >> 1) : ((product * 3) >> 1);

When I read this code I have no way of knowing if it makes sense.

#define BIN_BUFFER_THRESHOLD		(1280 * 736)

((BIN_BUFFER_THRESHOLD * 3) >> 1)

How/why is that correct ?

> +	size_bin_hdr = size_yuv * H265_CABAC_HDR_RATIO_HD_TOT;
> +	size_bin_res = size_yuv * H265_CABAC_RES_RATIO_HD_TOT;
> +	size_bin_hdr = ALIGN(size_bin_hdr / num_vpp_pipes, DMA_ALIGNMENT) * num_vpp_pipes;
> +	size_bin_res = ALIGN(size_bin_res / num_vpp_pipes, DMA_ALIGNMENT) * num_vpp_pipes;
> +
> +	return size_bin_hdr + size_bin_res;
> +}
> +
> +static u32 hfi_buffer_bin_vp9d(u32 frame_width, u32 frame_height, u32 num_vpp_pipes)
> +{
> +	u32 _size_yuv = ALIGN(frame_width, 16) * ALIGN(frame_height, 16) * 3 / 2;
> +	u32 _size = ALIGN(((max_t(u32, _size_yuv, ((BIN_BUFFER_THRESHOLD * 3) >> 1)) *
> +			VPX_DECODER_FRAME_BIN_HDR_BUDGET / VPX_DECODER_FRAME_BIN_DENOMINATOR *
> +			VPX_DECODER_FRAME_CONCURENCY_LVL) / num_vpp_pipes), DMA_ALIGNMENT) +
> +			ALIGN(((max_t(u32, _size_yuv, ((BIN_BUFFER_THRESHOLD * 3) >> 1)) *
> +			VPX_DECODER_FRAME_BIN_RES_BUDGET / VPX_DECODER_FRAME_BIN_DENOMINATOR *
> +			VPX_DECODER_FRAME_CONCURENCY_LVL) / num_vpp_pipes), DMA_ALIGNMENT);

The size_yuv I guess just about makes sense but the _size component here 
is pretty hard to say whether or not this adds up.

Could you please add some comments to describe the calculations in these 
complex size/alignment clauses.

---
bod

