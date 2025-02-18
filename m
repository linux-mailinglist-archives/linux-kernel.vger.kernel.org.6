Return-Path: <linux-kernel+bounces-519108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82CEA39834
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6D13A6C05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E222B8CA;
	Tue, 18 Feb 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udnJrxeM"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB822B8B9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873015; cv=none; b=AEVvXo6BkbrcNWtxvgB1NT+G2y1cUJjR2YaUW9b9NFcmerw5cFP/j/asYvrxSDCO+7Qlguk8VYPF+oapg/XJH/AxWbUH0RkG5tRl8RG/2DDg8Pa2ptGRWDyigQVk27cO9e/IqTGrIclz2CaRb5UgqCOKzorUWpyaEqT7h9NfLyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873015; c=relaxed/simple;
	bh=tG01GpOvm5kiLC9H8cAk72hOolKmbeeUhqUVNNOh5WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7Lf8RvfoCF1ogoNaQL+KsiJK2kEVdM3UIF42GGNNZmgT/qygmiB2jkzOMaUgwWAcqZRBLjYekJ3nCUt/H83f+0y9pytBoOY9AjguYsbDkWOfB1SJpp65FAFS5TpT+39YocIC5lnCwSdaRLk+c2srsQX8DWx5hd/77OIPZV29yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=udnJrxeM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f378498c9so2564308f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739873012; x=1740477812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0839DbdluWzWpmaiM9EB2MAfOdwxjWy1MJ5estDULzs=;
        b=udnJrxeMP6hBIsnGNR0uKmY9EXC62slG/fHDWQDz6lKgF/qyGzN1S1OsizPO2zXQ+f
         OIKfnBlhMFN1seChZMO6ICkpMnmVj6VOIDuajXzGP3cPjMBajuOEG3qsPTc+Vf3KOXkg
         VqALC1vSjqbsRKvsE6i8FX7pJH0ca+l3ivebQi7m7Ag5T0QFWrfmz5tD5WkWgMldrjZz
         ZdrgJqISpv+NRFFYGIH58d4YsSc7/MZ9coj5Bh9FowA2YPwh/IyJQbRuIWM+nDEmlrof
         a2UhYkDkyBkvwsUFSOFbFAy7/l8G2hpkyNhy3UN/7JbG72tr1zN3P0zjHoLA2p6yozsl
         ZA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873012; x=1740477812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0839DbdluWzWpmaiM9EB2MAfOdwxjWy1MJ5estDULzs=;
        b=HFPpuZq+4Y/S11YkfNU86PgM3H42lmdHkVq7lo8c8i4jXrveraKhkszNrKSRFu1JtB
         O9ofLbXi66bfR0b8UDqvKHuk3BE2n1krNWL++VKg3hhQZ0XoU6r7JjTPctuPZGURL8hK
         DTw6uEHYNTuK/YYjs4hpvcboLDkMfHOWXBJsy244+ip5elFbUD7s42UNWgcwM3gDrrZ0
         uOmUEx3gXapkyETuGWxX+WyVGGzKczjxD33uxxi7OIPNvaIrQl52y0S5zS+SdOYHtYbP
         8JqIUq9GOWs8iMMm8gdlmhoYsqThHHnNhu8crAvoMDVbB3eimJn7ZN4jtO6fqg8pZG5Y
         YR9g==
X-Forwarded-Encrypted: i=1; AJvYcCX9/cZbvBoqnw7GDD6GLx7cXlMWVFafqSLR1mGNYb5RXDbkRvTC57yt5B19MWnjKJx5sX3RHshIfPzpHbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVNCxxiz1uiu3VWVdcUEK2WggBLQiEX5eQFIpPvaKCUJ2jJhLb
	G33FYcU2snzApyG46a9P7j+UpxFkmdTsm5ZzuficpKG/m7b9tZy3GW0ifgjK5LU=
X-Gm-Gg: ASbGncuPDGkWirv1eHKpbmwGSHHkZ5o1YKvMnflf9ZNZtpXCN3zQ7T3RXgMho0dCgAr
	kKRk82U2oc6G7F1O8ZwNwMfRunZpUxz3LvzaGuFN7g2TfIrGhgW9AqVStGJRLoy0OLvV4lG+PWe
	Cw0P+MEUIzpbcPrrZGLZYpX53hACCF70PunzwQbW1JswhHbyJpfBI/xD8HKBHpyqw0mfgRrRH1k
	/77huucQUoJjw2S181OwECtCATGbxXn5Rs7jLit5RcYlN10xn3F43zZmvGALnorW9jhz9mYU3TG
	4v+/TxEJs2oNUuukWp/8WoJVQQ==
X-Google-Smtp-Source: AGHT+IGWbXagYwqDWRSF8X9rCootz68CXEnP/Ij/n5wLMpuiaoorUGPClGjqgWRNOLdoR1bU27EBOQ==
X-Received: by 2002:a5d:64cc:0:b0:38f:4fcf:d295 with SMTP id ffacd0b85a97d-38f4fcfd742mr3216642f8f.29.1739873012294;
        Tue, 18 Feb 2025 02:03:32 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbe0sm14730522f8f.39.2025.02.18.02.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:03:31 -0800 (PST)
Message-ID: <9adf9f13-128d-4ef0-ae31-4db4d295e2fe@linaro.org>
Date: Tue, 18 Feb 2025 10:03:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/7] Coresight: Use coresight_etm_get_trace_id() in
 traceid_show()
To: Jie Gan <quic_jiegan@quicinc.com>
Cc: Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Jinlong Mao <quic_jinlmao@quicinc.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20250217093024.1133096-1-quic_jiegan@quicinc.com>
 <20250217093024.1133096-4-quic_jiegan@quicinc.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250217093024.1133096-4-quic_jiegan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/02/2025 9:30 am, Jie Gan wrote:
> From: James Clark <james.clark@linaro.org>
> 
> Use the new API, coresight_etm_get_trace_id, to read the traceid of the ETM
> device when call traceid_show via sysfs node.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 3 +--
>   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 4 ++--
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 68c644be9813..b9006451f515 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -1190,10 +1190,9 @@ static DEVICE_ATTR_RO(cpu);
>   static ssize_t traceid_show(struct device *dev,
>   			    struct device_attribute *attr, char *buf)
>   {
> -	int trace_id;
>   	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	int trace_id = coresight_etm_get_trace_id(drvdata->csdev, CS_MODE_SYSFS, NULL);
>   
> -	trace_id = etm_read_alloc_trace_id(drvdata);
>   	if (trace_id < 0)
>   		return trace_id;
>   
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index c767f8ae4cf1..e5216c0f60da 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -4,6 +4,7 @@
>    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>    */
>   
> +#include <linux/coresight.h>
>   #include <linux/pid_namespace.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/sysfs.h>
> @@ -2402,10 +2403,9 @@ static ssize_t trctraceid_show(struct device *dev,
>   			       struct device_attribute *attr,
>   			       char *buf)
>   {
> -	int trace_id;
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	int trace_id = coresight_etm_get_trace_id(drvdata->csdev, CS_MODE_SYSFS, NULL);
>   
> -	trace_id = etm4_read_alloc_trace_id(drvdata);
>   	if (trace_id < 0)
>   		return trace_id;
>   

Reviewed-by: James Clark <james.clark@linaro.org>


