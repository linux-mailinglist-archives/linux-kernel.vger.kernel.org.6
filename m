Return-Path: <linux-kernel+bounces-221653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A107090F6CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 21:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1FD1F22CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B070158D65;
	Wed, 19 Jun 2024 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lc8CGBh/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F79225AF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824580; cv=none; b=ZvSgzFdArs1DvmyS0cLC3Uvl39wIMyS0raQvASoyarrYTaVNw1ABxAx3yCpm9uD2JyoKCSguf4zhvK5Sjxy3leJ31G2CiHQ3ZJjSoG0MsnCcEh3Y2BgR8so1R6amQiQif23hA48DR6coaqCWW7E/B7myhvwGMUzbFq2WV3pDt6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824580; c=relaxed/simple;
	bh=yJrxFSgPh0QuqkiXzOmnP8k+M1hWvwouzWu4chmR7Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/7jwQlQJJYJQC4cZK3tfeeE0EvUTpIyaqGA+fJj0ajlxzRE9Lt7Nr+NgurFmWp0pnBIWyH7MBLjABWYsJJH/aU9zwgqjlmPchHeeY2nkmUbGyTLu/P1JgBafqmivjcp/86JTcjP1/W4g6hSntX0kizHolN8RaFZ2dFAdHzOezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lc8CGBh/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso24973566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718824577; x=1719429377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3yEJfbkZg1yJ5m5VYOAmJOz46lXmJNvnDDj3GFcbJg8=;
        b=lc8CGBh/zhjnJuVaz2GtQP0HJh/gqQX0VCKsYjmD4sgCbqcyzsCNyeVx39oWe7ta5k
         i+S60YchQMGMcohRv/WMBhOyNZ+Z9//DK+FHKmebb8E+AxBYZLT7GJTo482628j2aqZ9
         tI+cYhgXeJtrTIJTuBvCMK9ddIweumviH2cpndEimeGMAltN4u2+B0XF4j7/J6v7PA0X
         ExOXw+nk+F+4+PhLL/rq9lXX+VtIMVRU8fMdF5SIPkE3jqe203IqUA1u/hCbvrG1ZkR3
         KurwepWMa8JvMdF6gR6x7aZyXo1Z3Nggszi5JnE6G2LQBNfSADKKHSfAZ/TUVzKWdwBD
         d9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718824577; x=1719429377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yEJfbkZg1yJ5m5VYOAmJOz46lXmJNvnDDj3GFcbJg8=;
        b=gp+I4jxy988KJkqUB4rJ1kC2DhIbn5gkmnoZREvh0w7Qz5KLTn1xduO5KS52KCTghR
         NwPSu29wpnRb1fbcOIrdfAOW8477tCTWLYMLznqCPdxJSbzMBEa8WL1sNcbX7oh4CDqv
         6JoHHDt+wwTNGe9PXfd8rXpEq5f6WHeNDHZFu7ZlRTkTVVI+OKnX/EtmRbs9zImd8K2q
         e3lhonUoryoiFWgNUTrIU4Iy0CS7MlCPCZMmLOdTYjyQVGZ8a5zjizzsm+DBJTywnsxP
         vfE1EU6wkkKPMrrDt5mULDp18G4wj4JytJUrlO7hWGeJGuFGGtO7MLati27iYcBr8pDb
         Cjgg==
X-Gm-Message-State: AOJu0Yyhju2RoemE3qeE6dGmjgHlPyHBck9R96VojtODHdqoEaeFOBan
	4zThlln7LMCzCMwpnWdxi0FvYK3cQhtr4r0VrER1uTpJbHLlPA4xSVi2d0Yy3aE=
X-Google-Smtp-Source: AGHT+IE8ZkBq8SDbwkZNBrB9p14Qcunp5+QpcNAulyIdJq1GogucMKYZh0P5W7z1T9VwPobhNYsr0Q==
X-Received: by 2002:a17:907:a588:b0:a6f:55e3:ee5f with SMTP id a640c23a62f3a-a6fa4109cd4mr230994066b.9.1718824576961;
        Wed, 19 Jun 2024 12:16:16 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4dba:9578:7545:6874? ([2a00:f41:9028:9df3:4dba:9578:7545:6874])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f4170bsm684420766b.157.2024.06.19.12.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 12:16:16 -0700 (PDT)
Message-ID: <a30fb728-d832-4309-8415-a28fed301e27@linaro.org>
Date: Wed, 19 Jun 2024 21:16:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Add tracepoints in
 bwmon_intr_thread
To: Shivnandan Kumar <quic_kshivnan@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_rgottimu@quicinc.com
References: <20240619135140.3581119-1-quic_kshivnan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240619135140.3581119-1-quic_kshivnan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/19/24 15:51, Shivnandan Kumar wrote:
> Add tracepoint for tracing the measured traffic in kbps,
> up_kbps and down_kbps in bwmon. This information is valuable
> for understanding what bwmon hw measures at the system cache
> level and at the DDR level which is helpful in debugging
> bwmon behavior.
> 
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> ---
>   MAINTAINERS                        |  1 +
>   drivers/soc/qcom/icc-bwmon.c       |  7 +++--
>   drivers/soc/qcom/trace_icc-bwmon.h | 49 ++++++++++++++++++++++++++++++
>   3 files changed, 55 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/soc/qcom/trace_icc-bwmon.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 242fc612fbc5..1b410c0183bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18573,6 +18573,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>   L:	linux-arm-msm@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +F:	drivers/soc/qcom/trace_icc-bwmon.h
>   F:	drivers/soc/qcom/icc-bwmon.c
> 
>   QUALCOMM IOMMU
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index fb323b3364db..9b5ac1e62673 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -17,6 +17,8 @@
>   #include <linux/pm_opp.h>
>   #include <linux/regmap.h>
>   #include <linux/sizes.h>
> +#define CREATE_TRACE_POINTS
> +#include "trace_icc-bwmon.h"
> 
>   /*
>    * The BWMON samples data throughput within 'sample_ms' time. With three
> @@ -645,9 +647,9 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
>   	struct icc_bwmon *bwmon = dev_id;
>   	unsigned int irq_enable = 0;
>   	struct dev_pm_opp *opp, *target_opp;
> -	unsigned int bw_kbps, up_kbps, down_kbps;
> +	unsigned int bw_kbps, up_kbps, down_kbps, meas_kbps;
> 
> -	bw_kbps = bwmon->target_kbps;
> +	meas_kbps = bw_kbps = bwmon->target_kbps;
> 
>   	target_opp = dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_kbps, 0);

This breaks bwmon, as dev_pm_opp_find_bw_ceil is now fed a random
(uninitialized variable) value

Konrad

