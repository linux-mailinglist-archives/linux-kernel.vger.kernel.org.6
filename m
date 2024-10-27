Return-Path: <linux-kernel+bounces-383773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC55B9B200F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DE6281584
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695B017C9F8;
	Sun, 27 Oct 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Afu21NHv"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB043187850
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059209; cv=none; b=dGwORa0Z/UTuHqepQuWePAenq7fXeuaSVQRgMV4YN/3T2fgvDYlh5HwZ4/awpMbAvObFz/SoNhmCP0RNRCFaBk69ADSr9d5Dkb2K7nPpgC9yKNnw7/oiO7pZk7OhdG6gvdvNEUx6FKWj7iGIM8oXdFDH2GAqasymDO2k3ejmD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059209; c=relaxed/simple;
	bh=7r4lUdgWtrljUsn0D4B4TgWrqztK0jELsrteGPPSmP0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hkbtsePqfURabHn+kxTD/vC6krvZDwI4PTTov+1Bdub8jQaj9GbElJbYJi3UvXm7ZxLKqturNQHHTDOuGu5YO7jYnw6sNvyTgatSrV0fwDh/aMAo3zwmHD6bw5HDRWKa0xg/EhOSxE23PT/j0mCOfgW+nUUigom2JlqMFK3zdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Afu21NHv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43159555f29so2901305e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730059206; x=1730664006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mobaSIAoCTzFS8IdkU952cZj7+uyOxNJc709mhx9JSw=;
        b=Afu21NHvIPG3Q8Rx7HPgNm64f7RzAwATDdSHa2HNn5XrxTlw6/LH1B8QjnLvIh8THC
         AMBzXx1dtv0GoAkZjfgUjEYPRjM/S/msExmOqwVENHgNop29GgcSz3b8B6URjL0n9JMx
         1pE7eU50+NAlxU2sZUS4caiI2oaZ/h2w4sTS3Dzt9GIX2NiUZlM6ZMCSed/LUFqavktY
         2cdv4RHJFCi9HT138wDBanHSwbG24cpz+2ipT5PWWvV/JrF2YcHou5YmN8mChEuVLuFL
         fUDy/b++y6xEcq1eP/A8UEPsjoKBunf1aJeS+c7G8/6XZh7PyI1HU/+YuHQfpKi6z5E1
         +M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059206; x=1730664006;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mobaSIAoCTzFS8IdkU952cZj7+uyOxNJc709mhx9JSw=;
        b=omZJ4W1dsQRX0NEXazQzM2IFEPVHYyVqusTXv+817+gmoV898O6nR+xc77vIeK4rzX
         C4/jxMwuaDzoYdVSuLg8jF42bN6wXduxQ09nU7eOoZvRJZffgshbkDX7NEOev9ObXgXo
         CAFq/AH/cCvVqEtCjJelSwHb/K0J8FWywzsqpLbpcE3XHPiLC4fF9Nd+Ip1ERhEPlQaF
         ygqHnVPkLpLLvuY62cQ3N0125FLbzaLiib7aKkt7oHGiI6cVtEybgXTWwkJ9gRhxRN7f
         1Q5chfyk6LRyPdOmgas2fwR15QNmc54bNyYaGR2VrUnXUUktsXr8nPH1+rO4OyIb3sCx
         JRSA==
X-Forwarded-Encrypted: i=1; AJvYcCW9QgTgCFvCedxrAHOQsdnShJQkZdxucW3Nsciw9BaBCL+1kK23ZYXWoc2mWzLgPtZbKRp9rYwfUoxAvYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpUnJhjlFHmXBz/Hydb+k/gNvvsMK58TAxczknGBfjD/OnpbP
	ZRvqYAjvvB2p0PD5vc1t7z1CqJo4eilQEH6nDY3iiiOE83b+vYYbU1BYN5KxkBjE1rUZmMgjD6E
	fw8E=
X-Google-Smtp-Source: AGHT+IEPzymzHIjiOc4zVdkC5xXbX8anEIX0QF8UPHvqXkly7pCIAWv4SBr/ppPEUQlnckjyhxDKQg==
X-Received: by 2002:a05:600c:4455:b0:431:40ca:ce51 with SMTP id 5b1f17b1804b1-4319ad280e9mr20127915e9.5.1730059205991;
        Sun, 27 Oct 2024 13:00:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b6f838sm7506639f8f.83.2024.10.27.13.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 13:00:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Tomasz Figa <tomasz.figa@gmail.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Markuss Broks <markuss.broks@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Maksym Holovach <nergzd@nergzd723.xyz>
In-Reply-To: <20241026-exynos9810-v3-9-b89de9441ea8@gmail.com>
References: <20241026-exynos9810-v3-0-b89de9441ea8@gmail.com>
 <20241026-exynos9810-v3-9-b89de9441ea8@gmail.com>
Subject: Re: (subset) [PATCH v3 09/10] arm64: dts: exynos: Add Exynos9810
 SoC support
Message-Id: <173005920218.11546.3963593817214010231.b4-ty@linaro.org>
Date: Sun, 27 Oct 2024 21:00:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 26 Oct 2024 23:32:40 +0300, Markuss Broks wrote:
> Exynos 9810 is an ARMv8 mobile SoC found in various Samsung devices,
> such as Samsung Galaxy S9 (starlte), S9 Plus (star2lte),
> Note 9 (crownlte) and perhaps others.
> 
> Add minimal support for this SoC, including basic stuff like:
> - PSCI for bringing up secondary cores
> - ARMv8 generic timer
> - GPIO and pinctrl.
> 
> [...]

Applied, thanks!

[09/10] arm64: dts: exynos: Add Exynos9810 SoC support
        https://git.kernel.org/krzk/linux/c/6c1fe47df5a79f1efc2d5c73e506c8d34692527a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


