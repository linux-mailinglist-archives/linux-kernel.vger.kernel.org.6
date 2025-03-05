Return-Path: <linux-kernel+bounces-547030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CDA501F6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0AB189733D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253C24C076;
	Wed,  5 Mar 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsGQM0ia"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206424A077
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184857; cv=none; b=JTbudSU2CoUcOmfi1oHwRcSjv8LlbFeOYM2/5HhSyDQDcxAmDefRAIVneY/z70EqoW3QaE7Lcm+uNrVuaIvdSfk0B9lmGIoTQafUrUSnzPmmsg2LZ52NWj+V+3IB75ZSA3B/S7jmufGUDRiUlghQDMKAuQE/yA9tYkG9WxMYrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184857; c=relaxed/simple;
	bh=AX+tj2pc687vNkVZN5TutAUbLg7Gdpmi9ojtB9nuDfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQv+DDvVl0GP0FmDNE3hBsk3hDwFU5k/3UjdovMuKVBIFdO7w3nIzvbaxiXswqtysCvZaP6i+gwSSBcijjcDokiFaGavcVTjy/X5N8K042Bdta8k9xfjug0aSyPO/vIVDQvgHsb7AVmggOJYEXjQ0bIYiABvnhBue4ZQCLdlfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fsGQM0ia; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bcbdf79cdso13529635e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741184854; x=1741789654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sJ7phtAchKalRzfMPp/9VjD+dUYfNbAqpxaF13GODMs=;
        b=fsGQM0iab1r77Fk9fRyhdjjBEX+wwBCm6iX9osRfWtFLEFWQZWfUL2ATeFirE5OYcx
         rJBj+3NjwR1nz8xC60n0Nd6RpJAZ4YF0Rk3PIDsrX1osdJOxQgvjQK04587zWH1Q2Ysm
         6pdZx4x8+JtEocwOgwoqYUlfPYxLK4dQ92+TUSOnNIag7E96wsYUETsuWuvOyWdDIYSk
         HudTcLgf9wcpstOZJ/g2N9OBpdhc8jGKIf9cKJvIJb/763qk0TuSms9FDzPrnDILpm6C
         GC4Rsm69ax/sxNUNarMCqlaNu0W/V51C8SM3bpvVNPPSnMUkWBVo067Dd6QpMY0fTr6n
         BMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741184854; x=1741789654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ7phtAchKalRzfMPp/9VjD+dUYfNbAqpxaF13GODMs=;
        b=NbVD50GdQZzdQhzzDr8oLwHkmd4xowMFJ76wK69GBdL2i7MlqK/tCIM+HEn+5/KZoF
         A1e208B8Uh+r1a0KS+aYG7yTWHHE9foEYtQ/RBeVY0MDRN/I2Hr4+BDx2ufSH707I6Yc
         O6X4Lh9h+rX766y+dig2WtF1CWgwbt5M4E0eN4+mfkfspqVF11arb4YfKHv1aYXoUpyq
         kDW5Ld5qpBSqH0uFM5GYE7DYXyrPiwlsKMQel75aHWTlCw8xZEbkvZ1sFUtItfJf52xA
         WRDZzE4wiN/ZXnGV806QxRBvDRDc4qOrbCX4laQttPUC1QZEasbVYVn2BRIr+L3KEWdj
         5RkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgfnx+1Bj8TxClLkz1ciNYKbT4GH3wQwXETogm23KRw910tBZSOCgjOAIXW2v4FRNv0d0YJjwSAF+SEw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PWkmE+3BXB4+QAeR68e//TZ7m43VJFWQkGO1qYeHTcY6hlnp
	tqg7Z0MuAFDFamrjDjrPWB8LkW88lkIjxNHlfsCkVQrlVItJ0VK7+KncFBgq6kk=
X-Gm-Gg: ASbGncvMTYoc6AoUQbHB0OT8CEumZkMYt2Cr3aNhHt9yiRdVJqZqdY9IwIPnIyTDdZy
	g+GYcLe9wvCrxBAyH9w1fdLARGLIzVCW3nN1NZhCdQ7nqYYXFgdn3InPdpnpGUEtPtW/MTQwnNx
	VCsChce6tICw6Sir7lsurHC5uhjKwNSRNKdKkdCGVBQHH2R6+DgQx4dJhnwv2XTYpo9KQd/JLtb
	H+DtdzDRMP75y3Wcq0CA/QywYEDDHbFyPwxfgh7odT0U4CVz306BaRWhlmUfsu8Xi52CRqOtEHm
	bpI0tiQeyGMvxZZzuBw3NlIgNQJTSDxrPS58Gwk3BLHHMNz75+GeYw==
X-Google-Smtp-Source: AGHT+IGCYa2sszNld+5UXNNTx4iNaBRX4ci2aOzVOLyC2rHLFiTrvLpSwYOYiufBagELwGqLV6kyUA==
X-Received: by 2002:a5d:64a2:0:b0:391:13d6:c9ec with SMTP id ffacd0b85a97d-3911f740312mr2628688f8f.20.1741184854656;
        Wed, 05 Mar 2025 06:27:34 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d906sm21408096f8f.90.2025.03.05.06.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:27:34 -0800 (PST)
Message-ID: <ac6ef67b-84bb-4679-a344-07bba50e054b@linaro.org>
Date: Wed, 5 Mar 2025 14:27:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: samsung: Drop unused clk.h and of.h headers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304-clk-samsung-headers-cleanup-v1-0-81718e38246e@linaro.org>
 <20250304-clk-samsung-headers-cleanup-v1-2-81718e38246e@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250304-clk-samsung-headers-cleanup-v1-2-81718e38246e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/25 6:45 PM, Krzysztof Kozlowski wrote:
>  drivers/clk/samsung/clk-gs101.c          | 1 -

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

