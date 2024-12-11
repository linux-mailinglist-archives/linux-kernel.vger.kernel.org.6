Return-Path: <linux-kernel+bounces-441490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1939ECF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E3C284A33
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5901D63E4;
	Wed, 11 Dec 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTcLD1z/"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE751D61A1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928852; cv=none; b=DBsYZF6V1K4MeiBvRGz5c5hSwn92mtlmwQ1K9Sxwlh1Zkj7+9W0rH4pHQ85CCSobKMEWzQfsokZpaTwTp7xu+B68RO63mn4114OMbFakwDcdJsUIiYtThe4qanv+eKQH6GwJ0e2Pv6a/g2R2dqW30F6Trfoh/9XkNKCERu7ktuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928852; c=relaxed/simple;
	bh=TA26KGjfUYtHcpviYZWDnnwFJwB1nA6T2oAA/scN6hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNsrRS5AkXHbcf3wzmVDUPRK3N9HImPyL+DMoELpf/yPYunja9HD1RyJYLz/Z9HSI7GMjpdhI5+lzI5+a2xh5fhm6n/BJZvHmgGGt1nfUvZ8kLIq3bTYUw+L5UQLLmsB1mYKTUe1iqflCvcU7eRlLqfhEn2nrr7hnnolgxfljsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nTcLD1z/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so6588903a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733928849; x=1734533649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ktlO6czYcyYSCmYggj2K8QrV0XdcUJX5mHC3XGXDtU=;
        b=nTcLD1z/hx6Mz0dpJu78nxwyu9yUzZLsjYihxO0rpUMK8albX8aKyeh+/yHyxHGeAH
         EknDZiMcTt/XD0iR/35YWwntvbRDxMM0veWkpw2yj6g2G0Omr83w14ktMuN6Kx/rimRP
         0dqNXx32rCFLwuX2pH9dxIzpl8ovmFikn/WncVpVReWp6J2SdBaFQh/CZJoCZhaBvMYL
         WnwBHPF/TvtLEHJBomfGcDMXmH0EEGcYiMmrfNnMDsCFqLkYlBtXnCMGHlQIu+7LbKwY
         HkxM7W2yOQtCP6OMQhFN2SzXpkUuuzIhQniLB9Wp44Ecl5Ef1avkf1MUb/+H0+7U/uj1
         GnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733928849; x=1734533649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ktlO6czYcyYSCmYggj2K8QrV0XdcUJX5mHC3XGXDtU=;
        b=ookVd5aEgfuo5YG7D87AlO/SFz5if43FYWFXE4meX2/ZGZjfhPlxhB56cI+2Mtk8pi
         9uu4k0jikz3CkznRU13EaMfs6xK5hNGQlDgGsAiWRcE2rmeuFayCm4dQYY7Ws2E/ljge
         yo6t/w8kZMnAae4rrIhNR8v2H7lu9L5zXojO7AoPCv6a9Eq1VmMeubaid2oqiDHP+cjb
         JtVnLxyk82EUbx5R3B54WnL7lqmrhohVHJLaCyv1dHaFWmEfUzhPc0dEpx0Q/akTS9Rq
         5rhbS9Dvh9AURx4oPPJdPlA+cCIw2i1I+QVW0n0wT6e75kCBfUIJGgwXA78Lwl70thwK
         xg6A==
X-Forwarded-Encrypted: i=1; AJvYcCXYkFOp65+vhdYRLTJZBzGNktpANOSx6jwgVXpLflp7Cckf92ON7cxH9zneXags4Ih4/AnTKaAGsrOu6h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZvVILSPVOHDHN3McUZuA6JpQKL0OqJ5np0xgHIZFU9u2DcNR
	/wDbI6yTmLKKkiTSY1nRAJlglmgZmcReOHYaD4u0jpCq/5JJWqo3FjEPBDyX/ks=
X-Gm-Gg: ASbGncuKT77cQeqz1rpv532CJVhmfyc6z/lIno8K2oT3Y8fQiYwU6wiHbCMeq7eDbE0
	2Xn+Oy5cvTrJSHXknO4+Vk8NEevX/NdaGv2d7pA3/akiMtXNgOlQci6TPsE4RHLuMWZS6YXLFZl
	nOkLcER/qOANDkyeVFBTO/ONg4cMp3J7155vs/bXq69jZRbGmvG5LxXxV9MjtjyAdrGK98BqBaE
	rBzq1A4wzdaQzLUB2XZCfYq7N4w3eYR1g8WltQol5C8mtxwiCEFuNl1MdklbpV7o1Y=
X-Google-Smtp-Source: AGHT+IExrTQgcrzFJ0AioGe6gUTXc8SXmmdedfxuT1544kYxd1QbVPq7wj4wcyNV0DI4WQLs6/DGMw==
X-Received: by 2002:a17:907:82a7:b0:aa6:9ee2:f4c9 with SMTP id a640c23a62f3a-aa6c1ae752bmr8454466b.23.1733928849467;
        Wed, 11 Dec 2024 06:54:09 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68770c4a4sm473262766b.163.2024.12.11.06.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 06:54:09 -0800 (PST)
Message-ID: <beaf4e8a-51a5-431e-8538-269d2db94f15@linaro.org>
Date: Wed, 11 Dec 2024 14:54:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] clk: qcom: common: Add support for power-domain
 attachment
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-0-7e302fd09488@linaro.org>
 <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-2-7e302fd09488@linaro.org>
 <fca39cde-b9c8-4f1d-a4d0-92a1d739b57f@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <fca39cde-b9c8-4f1d-a4d0-92a1d739b57f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2024 13:36, Vladimir Zapolskiy wrote:
>> +    struct dev_pm_domain_attach_data pd_data = {
>> +        .pd_names = 0,
>> +        .num_pd_names = 0,
>> +    };
> 
> Please remove the added local variable.
> 
>>       cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
>>       if (!cc)
>>           return -ENOMEM;
>> +    ret = devm_pm_domain_attach_list(dev, &pd_data, &cc->pd_list);
> 
> Please simplify it to
> 
>      ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);

My apologies, I cherry-picked the wrong version of this patch from my 
working tree to my b4/send tree.

---
bod

