Return-Path: <linux-kernel+bounces-383770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3E19B2006
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDF91F210D7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A736018132F;
	Sun, 27 Oct 2024 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCPwgDrW"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521017C217
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059202; cv=none; b=bluCwBvu27HQs6BGgjXGt1Oggjwb9x0FNL1DhRkRV1DHIOMCCDWd46q8sVfGPDY0vIUQ7FXGyapSbBSpeaz0hGsWNN75VpC/sJOTpnfvKSU3pFRYKzghxhVygAxiZgyzLMMTcZA8aqYwQPVdY1uDd7mC9/M+U+CfTxyUuJDckiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059202; c=relaxed/simple;
	bh=LYehHJ4s3dtf/pKCMIKLZGe01G+7wT/0gQA9iTil0Ok=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gDfMf02w5ItW8ZPB3EOV0S/CXJ0L9eLzDDfnbSzL75oPFJTtfwgmePb5daohE7LsbnvppzkaxnLi9rR3WkpUlP9hUsg3QWwT4g7VpUlrHQwCB1OV+YbUZBSSjlH7kER9QCL5PYCv3Xuzq3f2/HxwXbZsw+01qIAchj4GKqs4+Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hCPwgDrW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43159469053so3862975e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730059198; x=1730663998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z43MNvtr+jq6zZy/Ceg3w8kHzHBw2gUNp+Mcx1ypN08=;
        b=hCPwgDrWO2t60yxxu5DUywOs6M8hkDh+VoRZWxw9rLMzTh/HrAMT0/5VfchIGLfv1P
         i/oNshQPQk8NHI3iAXMCHh+MY7RbQrBZy5JQfS1zaXrmmAUCX6lGSZpY6TekpZohsYDi
         SDq46Df8i53zaYMvjO1PrGQ55iTDiO2Rp4Ga1fYW3jJAoYrYo3GUxcgfTyKObIQGSDMK
         U6+Nj0MjvsySNrOWpEOQFaAGiIYeYbEiQiPHPP+eCeTlr5ok1gi/KEMC6Rtn0jsF+GG2
         rySCRpkg3MgdxMGFkfzrHId4dtiK0yDwyMtIpe5HYSldIlHiGFJTQaXrRTmBzH0OzYQJ
         TtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059198; x=1730663998;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z43MNvtr+jq6zZy/Ceg3w8kHzHBw2gUNp+Mcx1ypN08=;
        b=Eoc9ynlTOwQKNfsHcNZlTv5KvD0o5A6jhNzdxMS8cruOXzlMAJopoZFU10Mv+lRGXX
         g5zBgu/2+FRppWPeHu/oz5oekeDEwzUtnGX2sQ6G8mOMYVaTOnPisABfoHTKMqSA4LM5
         5EEnKauGrvHRCgfKBTx2+7PummAcA3O0PEPkC1ebkyLXytKeQcvO4Vy5wtm8PGbpQVol
         /b8P9sis4HH3PY9UJn+W19y7BKnly5RU8+3jvkYiR/sQDda7YOnoHM8y6fKYM2B3/9w4
         dCZ97OgRJvhOL8OxNsOkami66iQOwK3wmXE622KyAc6RExNiSzjGS9PgtXY+wIn9UOe0
         VrVw==
X-Forwarded-Encrypted: i=1; AJvYcCXeuTamkSPsI/d7gAu/qQVpqy2++M3O4cOILgdxLA0J+P0l+n5eU5iJ1j6QaCTcK9PMoqfUR3Y+GgesEqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo99rS7bHu6GABS8u+VFYRIfiMshrv+ZSgRjZS+oKC8AnVK3mo
	o4bPn33Xyr9+4lZqMN1fPvUYknw+2agLx6r2a7/n+68+JXvP0aY3ijT1SCmzff8=
X-Google-Smtp-Source: AGHT+IENeIZ6Q2creRcBv5NlAj4Kk+mWXSMXHI7UEuySjpU9jJIS4txaEKNvMA/dJM33aIeSmrHz6w==
X-Received: by 2002:a05:600c:468d:b0:42c:aeee:da86 with SMTP id 5b1f17b1804b1-4319ad75782mr20378395e9.8.1730059196577;
        Sun, 27 Oct 2024 12:59:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b6f838sm7506639f8f.83.2024.10.27.12.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 12:59:56 -0700 (PDT)
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
In-Reply-To: <20241026-exynos9810-v3-1-b89de9441ea8@gmail.com>
References: <20241026-exynos9810-v3-0-b89de9441ea8@gmail.com>
 <20241026-exynos9810-v3-1-b89de9441ea8@gmail.com>
Subject: Re: (subset) [PATCH v3 01/10] dt-bindings: arm: cpus: Add Samsung
 Mongoose M3
Message-Id: <173005919374.11546.17517915253250206692.b4-ty@linaro.org>
Date: Sun, 27 Oct 2024 20:59:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 26 Oct 2024 23:32:32 +0300, Markuss Broks wrote:
> Add the compatible for Samsung Mongoose M3 CPU core to the schema.
> Mongoose M3 (codenamed Meerkat) is the big core in Exynos9810 SoC,
> designed by Samsung. It implements ARMv8.2-A ISA.
> 
> 

Applied, thanks!

[01/10] dt-bindings: arm: cpus: Add Samsung Mongoose M3
        https://git.kernel.org/krzk/linux/c/608c8f408dac3d1fd96191494f1a32ba2b1e133d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


