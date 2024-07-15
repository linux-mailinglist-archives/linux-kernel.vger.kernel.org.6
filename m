Return-Path: <linux-kernel+bounces-252829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA27931896
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE29E281E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A581C6A3;
	Mon, 15 Jul 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdYguSgR"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB7C1C6A0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061561; cv=none; b=ip+/5Afm5VODIJJLkz1dw0gnBXDiR+ziKNZXVdnJTqiuUZxGoV+Ibr5GlQ3HJ3gBPAvhRejDgLo1PSz89r6Gmomo2PUSK+o5UfB+4NLnlFyeVCpH50RIboGLsoob5X1GlsQp1lNaKgwADw12m5R3EPE4yrk6KsfAlN8n6iP+LFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061561; c=relaxed/simple;
	bh=CE0LqAXuQKaKknRXD1fYtEk+A34aTCSjMQFYMUl8D1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcO+83OwByvUtDhvsu2IqlzXlr8rm4LIGKDdBng8bS/WhEyFdt/gChKSg5xNLk+awxStPFKiAXTyIbVXH/Kc/R2Saqho8dvOmfoKQomP1Rc1cP8K1BaP0jWMQEH2Z7pn8JmE7UCyFntBZFMLx3A4mgHzMX1YjrBXdE7wtnNmpDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdYguSgR; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea2f58448so6038205e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721061558; x=1721666358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CE0LqAXuQKaKknRXD1fYtEk+A34aTCSjMQFYMUl8D1s=;
        b=hdYguSgRqC1OFdxYYVC0jRmtsc371/mmUVwc34AJyqcDPxd+xJmqDC4/s0IYJgw9tO
         /FZ01RklWuzraV2D11t9NN+qmiGjl4GORubi09+lftWN8uV8hl5GjRq9yygnh7P9Q7Xs
         mukO0oTJLNGZ6ZojlTCGW5buXbCG2sJUHdZPx9Djvx1/q3DOV4O/2CLSOGkqpvN+/d/y
         aATNS6+Csvll2RI56eLHIbJvicCTNEqOCxM/cVhDyJOQiCQW6VLdud8Gaq2UZ4aKwnJz
         3TTGA3wlsV2IWK8wu9EdunFAyeF/M4qItqIAUfv1Zh1P81M+aDHl8g6TQgFVICifj/7Q
         9irA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721061558; x=1721666358;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE0LqAXuQKaKknRXD1fYtEk+A34aTCSjMQFYMUl8D1s=;
        b=KQAEGRGqoYdIenO2P4Ni2zjj0nBk+7B/xMj+fJwM3Fhj3TGq4vI0FV2+1kBYtGDVEQ
         lErVZGLS4Zh2WuRMfyULUruRByrWQTrkJmg7p9I/OkhGmoMslTcde3ZNI5xWZrurAfmO
         FK6N7mwCdYzB0jgKHYr+PtVDRA75bAbpsYsq7dIj5QzPlrcIqH/Fsbpke22QISaSzRCc
         SEPe7wcKka/42KSHpdfX0Cws95SgUd5277Gvoe+sWhO79SyMGos3l2EVAWQp6iVUGx15
         HsUzRaLldkZ6cXeAdI4pZK/WXnryIpSDR+w4RQgOSYRthtzlnwoyXz6L630bJcTKGxOV
         UGIw==
X-Forwarded-Encrypted: i=1; AJvYcCVPytQkjO9mHy6yIYcKESl76TkFHyoImVDTUQIUuv+PAvnlbit9KiPTUkWbo7jJUmxFM6l6wdnOg1UsvztZxK6t/pqcQzZIVtU3xnlV
X-Gm-Message-State: AOJu0YxxXgFtB9GlbyDv7xxTbSGIsHoRDZwdQAxsQA33Xx9DfOkHDgPO
	ugRO2X/huZoRInFBzSmPX1Brid23ApuPTNMHDW2fpi6qQnvej1FU7wXg8BYIUq8=
X-Google-Smtp-Source: AGHT+IGyxqQSwEEwx4sutbUe35WkNNOQQoPjkMDai5sQ2dLieNjyFiOBUOBWCy4NbZ4S99uF01rmgg==
X-Received: by 2002:a05:6512:1244:b0:52c:c9cd:ebc3 with SMTP id 2adb3069b0e04-52ede1d4ceemr34994e87.63.1721061557537;
        Mon, 15 Jul 2024 09:39:17 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc3cb347sm223246366b.0.2024.07.15.09.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 09:39:17 -0700 (PDT)
Message-ID: <0b7fa651-3355-4548-90a9-cb6d87fa6494@linaro.org>
Date: Mon, 15 Jul 2024 18:39:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: Mark APPS and PCIE SMMUs as
 DMA coherent
To: Qingqing Zhou <quic_qqzhou@quicinc.com>, andersson@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240715071649.25738-1-quic_qqzhou@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240715071649.25738-1-quic_qqzhou@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.07.2024 9:16 AM, Qingqing Zhou wrote:
> The SMMUs on sa8775p are cache-coherent. GPU SMMU is marked as such,
> mark the APPS and PCIE ones as well.

Please double-check what you copy-paste, there's no PCIe SMMU in this
patch

Looks good otherwise

Konrad

