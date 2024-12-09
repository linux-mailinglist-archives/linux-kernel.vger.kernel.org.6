Return-Path: <linux-kernel+bounces-437134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E09E8F81
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A44716271B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C0D217F35;
	Mon,  9 Dec 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnTBb8tX"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839F217F20
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738121; cv=none; b=Bhy3WZkMxBqB6xaJJSuvZ6dlXPcmQHaxL7pVQ57A3A3jVK/HW3DvuwulrUvhziE8H0qSNAmSoxf59yWQDHJz/vO3UsvuxG8LxhKB1fi6qHzOvp13HF950i66iyF1GjM2t6IOW/+Ic1v7OfCwJOIqz4MEMn759Sha+/52ZTHmtXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738121; c=relaxed/simple;
	bh=OF8IHFpfgACEKTILhJU5a7s5El9km9y4LUVYegXHvF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owyaMie+4z9zowtkOmaL2K4kKDo7Ve8YwRzaLmsuJtWJVHJW4BUgjhsGVpjLlLKcfOASRBkvWazXs2nC1QRB8QjwjuYFD4d1aygBQGN4d6EWw8qILxVl0MOSDeWcq0uEsW72e3RahJyvarVdrGFxg1+qwMGw9wRgh51rRYYATYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UnTBb8tX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so1556960f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733738118; x=1734342918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PoYbdSz7UumczsvgvFq1gtMn7sm/DrqPSyNoisj4lhc=;
        b=UnTBb8tXHaARaDPXq1ryqjBBZXGt/litInd+4ctv3b6nvs0ej3AztAN5P5wkG3IRGu
         QhrdyH1qPFx1tgGYjuYjsNxgcjUl3GxDrnIbymP9DgVuLLr5ko20LfudYR2Xcr5mzs5v
         1Y31NTUb0eZ1E9hb0AGuhNT48GD1eHQ6R+/6ETAodMwzKN/uOrXJs3uj/ZBWQwiayLfk
         2qUkDeQhTQ9Kbii03hMbrWLcJ4kTyjzXcpJ2wUzF9SUdssejQ8aYYAvphjqZ7NIwRJ9s
         eHEoJE9O1G8twbbwfOs3X+ZRqAJ9DLU1Xtwt2p1gY/Yg48ytTYxE0joU1qubWXL/wWA5
         Ox3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738118; x=1734342918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoYbdSz7UumczsvgvFq1gtMn7sm/DrqPSyNoisj4lhc=;
        b=MrE4MpURxCFzL+/mXztOgn4Pw5s0zalOUYTgOec98ZeGTQfx0hAbzW1igQhUSErgav
         /yeyL4lVxwiEA/KySigNZY+KaiGxWezl1v25iRnlbodlbAopvebVTFslI+BgWieludEr
         J6g6rbK2poJkwqFmUb+OrjG50mLARi0EHibb1Iywh9v54zW5p0HDjMnqGCxga9Ry2VRX
         YuQeKYUtmJ3lG2YzC/VrblfJTWHP8QbE60m0nABmM/DsV5MNQ5om/1JCEhwU6uYd0Azn
         oqoJrkbXP24CzEuRLdQss4H7j05rNCTld5nsPUtXYJDaMGGiwWkOGXtXl8ymFVcOIJhS
         240g==
X-Forwarded-Encrypted: i=1; AJvYcCWE7jTU8vZm9u3kxZ5m1r4CidjWjKTEcNEQvS/fqJQWNBuFQkmE+YwvuEzXMgXE/kuxJrGdAKDnHND7zTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrKx5AKPiqfvcTZBYBzx1b8QjvhttHN43/zXLOIUQW5KR3Bsi4
	wBTUWHonT8PPPSTBmeB/EMiMPG+jhNIakY2m+Nsvtce8tDrsdN5YJHfp1udx3Pg=
X-Gm-Gg: ASbGncuhqsbanCpqxiIfEYA8HtLlqfNC7cyvzmMKpeqHrphPGhIiIFcsWD1Oiz+mnrx
	RZHXq7LYDWKaCT0HQrs8t8QuVtNOXZNVH+YYjgFByzExRhcX0NDPv9tVwV23Ho2lpfOzkyEWncj
	QG6XKg4jEauZAuxPlFOWmOh/T4Fohf/d1ygE56Jz7PK6ll59j3jUIZuLJXEyGQnNcbfpes1Aksz
	hlhkZBJZxB2NUIc2kLn/1szbirUn8flZC/JjZ2V3UN9aDMoFGDJXuezkea4UEeiFEXV
X-Google-Smtp-Source: AGHT+IG58sGqm9G4KF/wa5VnL28uIHDOt5c6w/WNR71o0EjNxa2YOdsi9O6TM91fztvfDHXZagiiTA==
X-Received: by 2002:a05:6000:1885:b0:386:32ca:aa0e with SMTP id ffacd0b85a97d-38632caaad0mr5793733f8f.5.1733738117915;
        Mon, 09 Dec 2024 01:55:17 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3862d9cf980sm9537280f8f.44.2024.12.09.01.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 01:55:17 -0800 (PST)
Message-ID: <60068361-ddb7-4906-84ca-195e5eb13a0f@linaro.org>
Date: Mon, 9 Dec 2024 09:55:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmem: qfprom: Ensure access to qfprom is word
 aligned
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Naman Jain <quic_namajain@quicinc.com>
References: <20241027-sar2130p-nvmem-v2-0-743c1271bf2d@linaro.org>
 <20241027-sar2130p-nvmem-v2-1-743c1271bf2d@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20241027-sar2130p-nvmem-v2-1-743c1271bf2d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/10/2024 23:42, Dmitry Baryshkov wrote:
> From: Naman Jain <quic_namajain@quicinc.com>
> 
> Add logic for alignment of address for reading in qfprom driver to avoid
> NOC error issues due to unaligned access. The problem manifests on the
> SAR2130P platform, but in msm-5.x kernels the fix is applied

Is this only issue with SAR2130P?

> uncoditionally. Follow this approach and uncoditionally perform aligned
> reads.

If there is a need of having proper register alignment this should go as 
part of the nvmem_config->stride and word_size configuration and not in 
reg_read callbacks.


--srini

> 
> Fixes: 4ab11996b489 ("nvmem: qfprom: Add Qualcomm QFPROM support.")
> Signed-off-by: Naman Jain <quic_namajain@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/nvmem/qfprom.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index 116a39e804c70b4a0374f8ea3ac6ba1dd612109d..cad319e7bfcf34c9b9ab15eb331efda822699cce 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
> @@ -322,15 +322,28 @@ static int qfprom_reg_read(void *context,
>   {
>   	struct qfprom_priv *priv = context;
>   	u8 *val = _val;
> -	int i = 0, words = bytes;
> +	int buf_start, buf_end, index, i = 0;
>   	void __iomem *base = priv->qfpcorrected;
> +	char *buffer = NULL;
> +	u32 read_val;
>   
>   	if (read_raw_data && priv->qfpraw)
>   		base = priv->qfpraw;
> +	buf_start = ALIGN_DOWN(reg, 4);
> +	buf_end = ALIGN(reg + bytes, 4);
> +	buffer = kzalloc(buf_end - buf_start, GFP_KERNEL);
> +	if (!buffer) {
> +		pr_err("memory allocation failed in %s\n", __func__);
> +		return -ENOMEM;
> +	}
>   
> -	while (words--)
> -		*val++ = readb(base + reg + i++);
> +	for (index = buf_start; index < buf_end; index += 4, i += 4) {
> +		read_val = readl_relaxed(base + index);
> +		memcpy(buffer + i, &read_val, 4);
> +	}
>   
> +	memcpy(val, buffer + reg % 4, bytes);
> +	kfree(buffer);
>   	return 0;
>   }
>   
> 

