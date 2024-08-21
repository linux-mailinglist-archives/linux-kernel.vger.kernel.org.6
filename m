Return-Path: <linux-kernel+bounces-295415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FE959AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8141C224C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FCD8121B;
	Wed, 21 Aug 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FB2sN5Ff"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AE61A4AA3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239800; cv=none; b=R9KH63/Xdq2jiWLRQMUouSjGBlgKwR0V9mvr5p6nSxLk+1P0i9ilZ8OBGZZhNZlP4qY4Tf1iS1YI46OQOO45LQ+Oun9GQWTIaCFWAv4HQE0ZCpnfuhMJJUmy8Uxjjne+aF6lQ5sn+TwAYVWR1jCnSRrpTJPwaU1DLz05gxiixE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239800; c=relaxed/simple;
	bh=m+CLdBxtyQcHsJRv5HEzVlWDHJ20bSh7BFIyAkmTMZ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f7GnzUWoDot1GA9ueW/m9J9dVnQhDGV34hXgRftPpN/ciYk1Ifit5P2Dj4QlR0+RlmJ7z60ZaIwkTS0aYjRyrl5/EU7OsOwatZhtThEXtNL2FYUSHURwQVkBopuSIgJqB7Yyv5GGBjR28vWrwhJPwFGHcwWjnCQQwELYgsbnqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FB2sN5Ff; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42808a69a93so1170825e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724239797; x=1724844597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Nhb9aCRPnIRxYdi43lW45nHyvT8LZCG2EHeZTQSoU=;
        b=FB2sN5Ff3oYYHFm237uhzzKMzEFcKS+5HsvnhYRgnosDMgXeiuJBbU2eFZCgqVnNJZ
         0qQ6nDMjNszDLNJdv6ZBpsEWsRfbAec1R3gBfdzdwplhAL238PHb5jYMO57W/uj5P3MG
         DVpYfNDmGHS3xMI5ijTYss71OSBqFzXfT33GJz3zm5j2CLjc5B4KuQeEYStgbX/HgipZ
         4IdrsGLh/8WV4DjlWrf+dcleQyNzWj7k8sPERlMSAF4t7EEgZ9VoXxVDle0Jhfv/1UAv
         94woB+rd7Kw06l3LxR/XkFT/88ZoOkezeRy+hM6qgbKiv32LmeT2EYDSao/i682Xo4IY
         SkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239797; x=1724844597;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9Nhb9aCRPnIRxYdi43lW45nHyvT8LZCG2EHeZTQSoU=;
        b=cIyxa8RMi1dPWhaaN8OPM6aHDtNtO8T5UNq98Mt2xuSk1eMVBzLKpcBUbuBSO1+OKJ
         7aUSJEmw8V8NHn1EG5shw/jA5KA5X6GPdhaylkKOu58gLXyHL+HyAnJecx1cGmxNW2n/
         Ud4gBpwalRVZLpzb6zSmbN/ACUm5TVa/MGZHkdtYAjNfHq2EUicAefyw6KNLkRCetj/p
         4YoimwL5LVEyCaMluQbBOc1kpMVCS7StjfEzhBshNq+Y3QG+UVyc2SWPYm1jfsQbCQme
         Zkqc5lR3sChrdQ5eSqr+AZ6SAEDH3wNCf23rrAw2oG9Otgy5NVYLDtlzwQq2rWocfxEg
         Eijg==
X-Forwarded-Encrypted: i=1; AJvYcCVIwOMLZBlQ6vWoTnKOjm685/B6KQ7rrZM2MYcJ2caLfI/U3JYGzwMb7zpEjObD2I9gA/AxgClW6xfw6lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrsRIvXNtE4CkFdPxvX1t1eGoW2rovR2YeDr5M3k/XfsiyKrum
	UL/YNuSuDwhb5/8Y8wZHgLH8Rtt48OW5hFES2XNuMhrN9uV7Y7bjOT5Ki9fY0dMOp+tVVh/kOP6
	n
X-Google-Smtp-Source: AGHT+IHFCih6rgdtihcItSj9CaK/vi0+zF54jDaNOHe4v5hoay0YsgCBA8ZRKEh7xPbzOpfr6L+x0A==
X-Received: by 2002:a5d:6d85:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-372fd82898emr770310f8f.7.1724239796967;
        Wed, 21 Aug 2024 04:29:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abed910fdsm22253605e9.7.2024.08.21.04.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 04:29:56 -0700 (PDT)
Message-ID: <754863f6-0fc3-4223-940a-4ca33bfbe633@linaro.org>
Date: Wed, 21 Aug 2024 13:29:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: exynosautov9: Add dpum SysMMU
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Kwanghoon Son <k.son@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20240819075546epcas1p355a3c85ffcea2c43e8f1b2c69a0f3b4e@epcas1p3.samsung.com>
 <20240819-add_sysmmu-v1-1-799c0f3f607f@samsung.com>
 <172423973836.252925.2617927566866963313.b4-ty@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <172423973836.252925.2617927566866963313.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2024 13:28, Krzysztof Kozlowski wrote:
> 
> On Mon, 19 Aug 2024 16:55:45 +0900, Kwanghoon Son wrote:
>> Add System Memory Management Unit(SysMMU) for dpum also called iommu.
>>
>> This sysmmu is version 7.4, which has same functionality as exynos850.
>>
>> DPUM has 4 dma channel, each channel is mapped to one iommu.
>>
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: exynosautov9: Add dpum SysMMU
>       (no commit info)

I should reply here - unapplied. Does not build.

Best regards,
Krzysztof


