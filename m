Return-Path: <linux-kernel+bounces-383767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9589B1FFB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607951F21408
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9F17C9F8;
	Sun, 27 Oct 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wuQ0ELyP"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D1126C18
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730058942; cv=none; b=i5mmZJDsh5t+ktDTCpx+DWHM/5FvXaAvbLegBeqA9U70w95zvd7wzE5YU7Ld5crqZA/nAc7GEtXeRMNLt1Egkh6DzFwMqqRxrp/8MDu5AZv+hfidkn9isaGAQ8jLYG0Q73utYU21fviU/JSHx7/YSYkK9p8uAIlXLGy0MHMMApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730058942; c=relaxed/simple;
	bh=YsdYH84ia/r50m5pkpbMCMIaheqADio7tevqfeKZsqA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qa8N+WXftKaJxA2wRtdOr5EjlzWn0lnXjwOgK07Wb/nLTFW6lFmC2CgI+blrGNrPcdLjwm36YX1I16VfQRpZsgoiYGovLbQB3NcjyMQpvPQCwRGrM0OnG5hmT22j0NQQayA8C9kgBUj6UEIGXRQR3bWQlr7AvXrfZBogrHM2ipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wuQ0ELyP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315b0bd4ddso4224005e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730058939; x=1730663739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27FjbLkvpsH6g9Edehxh385tMv9CQXY+0f2sWNF8DhE=;
        b=wuQ0ELyPh86ig/gxmva6XbuGKQPi8EnnLODvA0gkiDfUEldNIORhTl6rVMdUqU53OJ
         SSTIKLdR9NnZKtlFukmVdCk5PE73E9bCS5Rm1LxEnyGa8GxSr+j+ATwdl3d3h8ASHNB9
         0gIuApZvb4geLCGtEBMLuNehw7CxhY6rjG2XKnCpvyWY6sUt+byxylrXF51hmGI9Fg5+
         UxPozsfEgva6V5RzouOcheovBUwskyQyRzZuCTkBT2Y57/PYzUedC1GLi94r3ieasb8p
         lyDWl02KZvf2ThOJuUmLbYEjP+/oQpHp9I+0JrHmmzkFD3cJLBSnkRZpiTKwyPGv2icn
         OQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730058939; x=1730663739;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27FjbLkvpsH6g9Edehxh385tMv9CQXY+0f2sWNF8DhE=;
        b=TL5ASjAeDPmp2TzZ/QSXH4BkQUeLdgxSam5twGmmP7CYwy3m8bJMcK17CJexfqtrQG
         XYXIMuyJAhU+m/ag6GEEkFdJWOr5u96s9fxNy+QvB9ZHaELRT37gh5O8ryD9qKLZkRGT
         MM2PXa5O/0SZd7Q9RgCu9WrRMuhjG8BVgQtjYmthRr8veLwEwIdUoP/8kiCOliYlzOgj
         YZydX9CMnymeAooXlU/YpedsfFUTJGrrxssYOqwCcPEHojXOJVxm5u6dDo6yO1pRVkc3
         0laqpHnUGgW+6IjannfRZ8YYDcZncNysqjBMIug/it5dTaAEQiIuk85icLmTwD/C0TzD
         3Xbw==
X-Forwarded-Encrypted: i=1; AJvYcCU4r5EAX3dHowI8XdQIUrrMigtCV/3vVpvW4esle/4bQYFpZh2imNzkTqteO7UkUAKHywG2gnN/d+kpSxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYV7az2maGwQkf6q5JJm7Ham/JwGlll0yyAppQQ5+tZwVKp/nj
	HxQ3S4uW3sISzwRB1yQURKAcESDQQKEy+zWaYfoOOZD/k3GWoy4pnV5i+Rkt19E=
X-Google-Smtp-Source: AGHT+IEYf9GlikS+9SRXkW34PJ/4J9ZywFzKp4RfuuNjQIqBExM3fQopO3FwUg5OJt8GXxV7i8FZgw==
X-Received: by 2002:a05:600c:1d1f:b0:42c:df54:18f6 with SMTP id 5b1f17b1804b1-4319aca7abdmr19494075e9.3.1730058938975;
        Sun, 27 Oct 2024 12:55:38 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431934be328sm85548215e9.0.2024.10.27.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 12:55:37 -0700 (PDT)
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
In-Reply-To: <20241026-exynos9810-v3-2-b89de9441ea8@gmail.com>
References: <20241026-exynos9810-v3-0-b89de9441ea8@gmail.com>
 <20241026-exynos9810-v3-2-b89de9441ea8@gmail.com>
Subject: Re: (subset) [PATCH v3 02/10] dt-bindings: hwinfo:
 samsung,exynos-chipid: Add Samsung exynos9810 compatible
Message-Id: <173005893509.10219.7382293678249920610.b4-ty@linaro.org>
Date: Sun, 27 Oct 2024 20:55:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 26 Oct 2024 23:32:33 +0300, Markuss Broks wrote:
> Add the compatible for Samsung Exynos9810 chipid to schema.
> Exynos9810 is a flagship mobile SoC released in 2018 and used in
> various Samsung devices, including Samsung Galaxy S9 (SM-G960F),
> S9 Plus (SM-G965F), and Note 9 (SM-N960F).
> 
> 

Applied, thanks!

[02/10] dt-bindings: hwinfo: samsung,exynos-chipid: Add Samsung exynos9810 compatible
        https://git.kernel.org/krzk/linux/c/18910d6b16bb4e71ee5aea5986a6577f347d69ec

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


