Return-Path: <linux-kernel+bounces-548098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4EFA53FE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8D93AE33B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ADE1624C7;
	Thu,  6 Mar 2025 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a72Yi8si"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820681591E3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224421; cv=none; b=d1YGk3iGo/m1xk5bKR+iJmfxj04+EZF2dDC3esBNthISCgcDfYCLEVU7lAa915onrG4KSmEMNPkrR9b+M20Bi/+vGrW/WHLRY4U66NTs+nXUlzKL5aWGjSH9NfJBnAgcm3wCcXu3NbCNXLsGF8ctjCbocQPfJqiamUI2yGX8dUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224421; c=relaxed/simple;
	bh=kysQR/ePAOZ/v5enzHb/LcSN/TIfROYwJtDyU7z908Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzBpN4PeU+l2W28BhylxiwZvoFEj0PDQT8CXezkVHtFbTSaIdKvFogZeuxfPRkiSRJZFjqto95YRMmhi3vdNIqesXaOiJO/402A5VYsZVkZ6sBDoM5X3txzafD/rRLib73K8/oaetwgu2lKhz9gKF/v9BjDJvYz5v36D+jABkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a72Yi8si; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39129fc51f8so111693f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 17:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741224418; x=1741829218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHG5/QOkCzRdy3FoXOSPPH5k8LS1u46piNn2hJDxzxA=;
        b=a72Yi8siyEfdAk6qq7NWv3bvaByxq9mN8uZyqYvsaGNgR/4GGClIbwAyN5cy3TFhxO
         /hnEuQn6V/Ut+UNWqaWIno4CgL6DGFUfDvBUKU/aR5DJeDt6vjwXu0ILI/bsE0YrX4I/
         vmToiL3QmzVT0l6Lc5O+Q4SITsoCUHLkwh3MLVC9+uX0vPEDMiZ55PULIlRmIXh+F4oF
         ILBflvo/OQ/an5o9X5dwFCbG2IgLA5mIqrHU/9bmvyTMcuic4rAevmlQbuXWTZYS52E/
         ftez71P9RjaUZa/5CYZ700StxUQAZY2gBZpVDwgSTYy3Jivc0JOunpjJsJ/zaFwC8mse
         kh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741224418; x=1741829218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHG5/QOkCzRdy3FoXOSPPH5k8LS1u46piNn2hJDxzxA=;
        b=KxShP0JgqaU1QEwhBd2Z1bvp8X/G15grQHFfYV0dnUzUnN+RI4udvnRMZC7zdj/Fut
         dv7mY9K6psSNv4uC914SJF4lQNmzHu4G+0U9rKMz9w9iOpknWp7ewAXwWiuwZnHBbEJy
         OoCkjrtpuj5TCUZ/XqL14rH7qXe0Dvbv4S03M3uu3N//VczfZWv4AutMvSlhSnCqhtLT
         DrgqgBJ3bxPGI6Fm/Iuvmcn46sPYFuwwxEIRij/5E0y6DMoruFYpWr8OgoGpuA/Sn1fx
         J+N7cvBM4kbxnAFpYC1GmKNlsmCHgjrWNDGeb4aLM91QvAX9W3ORWY4AlBPF5T6QV+xv
         atbg==
X-Forwarded-Encrypted: i=1; AJvYcCVsge35sK7lw1aMhA4PN0ITS/N9cWmITc3UbEvyMG27kVENPcnxdvNUpR2JGN3Z+psPMGOJIcMEuQmkr7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7wTeWqvZ80ZmuLr+GZFq5Pw6pD7X75cPmiPjxbY2uja0DCwk
	LsXlNhk6RmSJHu1o98lbeAN3GcIkUtDYPxb+UKFP8KnhDvPWK/oN3RVqFlaM43o=
X-Gm-Gg: ASbGncvCsA+8g2HelYjlmc6M/Dr62lKj6jsfVAg39RwVjnlL6pL3RWairVVgkwS0zCA
	4tyd/16Ra2iYVR6GgIkhyzIRF96opaxu4hJ9lp4sjcIzMCNu4qnj0x1NBSiMIVg/pgm3KF4lxgD
	A/v803C0LB5/yVDwck6l7wgCWEzT66gsEhFJzQgRPrymwU1ch82yZgbl/Zl/nHx37qOrl/YwUJW
	hrZlzpiFSjM6I5PcOm9eJH3P7danPorRK0DfQa5Pv/lOP4KIe89erZ+lubQNh4cqYlhO2dkS6Ym
	nW7JrF4moYMp6JumtoFClaIkXr/dLE9qX3Iu0vARspVsdIL/+nrcSzn/CBBEaSHy8mDHU+il+nq
	J78Fq5ECAHQ==
X-Google-Smtp-Source: AGHT+IFluJeF4eIIHxMIUoQA1PCUvNr6qPkLzvhXHIODB2ZpF59+PuToFJvzzUt/vRWR1bAjW7o9zw==
X-Received: by 2002:a05:6000:4021:b0:391:1472:bfae with SMTP id ffacd0b85a97d-3911f7cfb87mr4002537f8f.49.1741224417678;
        Wed, 05 Mar 2025 17:26:57 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2b8bsm239939f8f.64.2025.03.05.17.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 17:26:56 -0800 (PST)
Message-ID: <39f566fc-9cc9-44be-9b14-7ced0607464f@linaro.org>
Date: Thu, 6 Mar 2025 01:26:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/12] media: iris: Avoid updating frame size to
 firmware during reconfig
To: Dikshita Agarwal <quic_dikshita@quicinc.com>, quic_vgarodia@quicinc.com,
 quic_abhinavk@quicinc.com, mchehab@kernel.org
Cc: hverkuil@xs4all.nl, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250305104335.3629945-1-quic_dikshita@quicinc.com>
 <20250305104335.3629945-9-quic_dikshita@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250305104335.3629945-9-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 10:43, Dikshita Agarwal wrote:
> During the reconfig, firmware sends the resolution aligned by 8 byte,
> if driver set the same resoluton to firmware, it will be aligned to 16
> byte causing another sequence change which would be incorrect.

During reconfig the firmware sends the resolution aligned to 8 bytes. If 
the driver sends the same resolution back to the firmware the resolution 
will be aligned to 16 bytes not 8.

The alignment mismatch would then subsequently cause the firmware to 
send another redundant sequence change.

> Fix this by not setting the updated resolution to firmware during
> reconfig.

Fix this by not setting the resolution property during reconfig.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   .../platform/qcom/iris/iris_hfi_gen1_command.c    | 15 ++++++++-------
>   .../platform/qcom/iris/iris_hfi_gen1_response.c   |  1 +
>   drivers/media/platform/qcom/iris/iris_instance.h  |  2 ++
>   drivers/media/platform/qcom/iris/iris_vdec.c      |  4 ++++
>   4 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> index a160ae915886..d5e81049d37e 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> @@ -562,14 +562,15 @@ static int iris_hfi_gen1_set_resolution(struct iris_inst *inst)
>   	struct hfi_framesize fs;
>   	int ret;
>   
> -	fs.buffer_type = HFI_BUFFER_INPUT;
> -	fs.width = inst->fmt_src->fmt.pix_mp.width;
> -	fs.height = inst->fmt_src->fmt.pix_mp.height;
> -
> -	ret = hfi_gen1_set_property(inst, ptype, &fs, sizeof(fs));
> -	if (ret)
> -		return ret;
> +	if (!inst->in_reconfig) {
> +		fs.buffer_type = HFI_BUFFER_INPUT;
> +		fs.width = inst->fmt_src->fmt.pix_mp.width;
> +		fs.height = inst->fmt_src->fmt.pix_mp.height;
>   
> +		ret = hfi_gen1_set_property(inst, ptype, &fs, sizeof(fs));
> +		if (ret)
> +			return ret;
> +	}
>   	fs.buffer_type = HFI_BUFFER_OUTPUT2;
>   	fs.width = inst->fmt_dst->fmt.pix_mp.width;
>   	fs.height = inst->fmt_dst->fmt.pix_mp.height;
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c
> index 91d95eed68aa..6576496fdbdf 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_response.c
> @@ -155,6 +155,7 @@ static void iris_hfi_gen1_read_changed_params(struct iris_inst *inst,
>   		inst->crop.height = event.height;
>   	}
>   
> +	inst->in_reconfig = true;

This flag can be changed by iris_hfi_isr_handler() down the chain.


> @@ -453,6 +453,8 @@ static int iris_vdec_process_streamon_input(struct iris_inst *inst)
>   	if (ret)
>   		return ret;
>   
> +	inst->in_reconfig = false;
> +
>   	return iris_inst_change_sub_state(inst, 0, set_sub_state);
>   }
>   
> @@ -544,6 +546,8 @@ static int iris_vdec_process_streamon_output(struct iris_inst *inst)
>   	if (ret)
>   		return ret;
>   
> +	inst->in_reconfig = false;
> +

Are these usages of the in_reconfig flag then thread-safe ?

i.e. are both iris_vdec_process_streamon_input() and 
iris_vdec_process_streamon_output() guaranteed not to run @ the same time ?

I don't see any obvious locking here.

---
bod

