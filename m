Return-Path: <linux-kernel+bounces-173642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4208C0354
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC4A1C22301
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D11912AAEC;
	Wed,  8 May 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="TbeeZa2K"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67812BF27
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189924; cv=none; b=ZWDTv3Bz33oeVxHTdGsVuc0ikDcEW3xaejqmmO5zbtd7YBrv6QUrDeI8wDY/jfd8yroCIsGedizzvQ5hVtUVaLASVsf2rjR2D+QxBNTkcB+leimhHXcNYvw1l7mP9vk+iFsP/mNSHGhnPq+FqXhhzs6dvt/sn6cGC7dVrkU4FyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189924; c=relaxed/simple;
	bh=5RN14ywOuFpB0z3RCdXcx1stBTRqJssspaiJ8AjqU/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIBIT/+MsbrEhH2fJR0NcEcbVZFtm8rH8KLaexbPJw1cz/QlVW4ISsM60GJ8HThClqLFplfw8C+dnV+Sm3/XIIGYLw0NpXc7Mi9WVNllE8etJ93xRKe+9HGOp3Q66v2184EoYpmOz4Qc04BC/YBpCj8cTc5Ey9XQUhYKsmLq+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=TbeeZa2K; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e3e18c23f9so121591fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1715189921; x=1715794721; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RzAM9cRLAUGiOquaKixP2MGj/PQW99LYyCbfVZ7Leuo=;
        b=TbeeZa2KAkk1cMAXE8NB+27oQdH7uBRv1p1NeI99/1oZYpvj14EK9yfELogDZv73hO
         NV4PYTHKaQ1r67h0FR7BiMg7LeG8cAf/hqg43uMtaO61GlLvTQlyffZ9NueRzrwuhwMF
         H2PEbXYpo5kUZdrnIwqcL/2Sj29yAm1QKj5jZjCR8MPhKESkRc4nYZPU44YquVnfzcVN
         Q5C8KBC6D5EDIPRDsCRrYY58u+oGAlqjLMifoRLJgbM8gkw0Hdowdw12mqTmJJo3RHhk
         kiRwqhquurYZElQ9EyRglTI3Ol3ZGyP8Xq4IcixkDp91INHsMDAb0GxzBOyMphPMGhJS
         5fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189921; x=1715794721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzAM9cRLAUGiOquaKixP2MGj/PQW99LYyCbfVZ7Leuo=;
        b=hXkgCoZXZFpzb2qnKD/oJ8NduRI5wn4fc2TJaatjKLndemlpEKyaSJk5fVu8q+uE1q
         n9xGHVaScn5twLgHPnu2FDkuhdyiGw/5Yk1lHJu1iHR98rbNWXGhjPgWAYL+FrWX9Bgo
         xI0bGgh2Cn1XFKk7Io5Eiq3aNsOP74DkOb+0iiqmlgfbsK4xMkrmqvY4wBkD60chAYYN
         98xgD9RTBIhsJcSt1LYqgBHZDeJMu7w1fQRXZ3JjcUKAkFf9iwOKZf2G1kM/vB4oTodm
         ZQ26U4jEcYKIatFlOyobMSv7WmtiTHxop+GLhQUttUNjWrZqQlICTI3pzBsTq2QTrxAm
         6/og==
X-Forwarded-Encrypted: i=1; AJvYcCVaWPdHgEJzqhq5tbSS5oCndvT9CISW4L5DHIYMP+QcqWHcdlNQsCMnwDk3JwNuagLPq39L260UDgYdv70zxMaDSJZ/QF5I1zxuAZ/o
X-Gm-Message-State: AOJu0Yw+nqNflFWfPqggsqYmJRp5IGyXIV+fKsNbrOQqehQ6xjFhBfbj
	3gvTDzvBAVjZnErYjngnOT92nBy805ndrKGedVsHtkyzwqlIog6RLuCaDx+TlWo=
X-Google-Smtp-Source: AGHT+IGhUVMa9+23KRykDgqW6ofschZeiShfdVYRKcGu8qiCED16khFT1oYx2uAeA8VCadBzBznK8Q==
X-Received: by 2002:a2e:98ca:0:b0:2e2:2623:333 with SMTP id 38308e7fff4ca-2e4476afaadmr20982311fa.39.1715189921124;
        Wed, 08 May 2024 10:38:41 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id dh18-20020a0560000a9200b003439d2a5f99sm15824784wrb.55.2024.05.08.10.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:38:40 -0700 (PDT)
Message-ID: <57f8c9fc-e1ef-4d2a-8587-9a00549450fc@nexus-software.ie>
Date: Wed, 8 May 2024 18:38:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] mfd: pm8008: rename irq chip
To: Johan Hovold <johan+linaro@kernel.org>, Lee Jones <lee@kernel.org>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>,
 Satya Priya <quic_c_skakit@quicinc.com>, Stephen Boyd <swboyd@chromium.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240506150830.23709-1-johan+linaro@kernel.org>
 <20240506150830.23709-7-johan+linaro@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20240506150830.23709-7-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2024 16:08, Johan Hovold wrote:
> Drop the redundant "irq" suffix from the irq chip name.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/mfd/qcom-pm8008.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
> index f1c68b3da1b6..a04bae52a49a 100644
> --- a/drivers/mfd/qcom-pm8008.c
> +++ b/drivers/mfd/qcom-pm8008.c
> @@ -132,7 +132,7 @@ static int pm8008_set_type_config(unsigned int **buf, unsigned int type,
>   }
>   
>   static const struct regmap_irq_chip pm8008_irq_chip = {
> -	.name			= "pm8008_irq",
> +	.name			= "pm8008",
>   	.main_status		= I2C_INTR_STATUS_BASE,
>   	.num_main_regs		= 1,
>   	.irqs			= pm8008_irqs,

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

