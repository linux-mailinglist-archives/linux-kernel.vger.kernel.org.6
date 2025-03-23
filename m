Return-Path: <linux-kernel+bounces-573020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90EA6D1A6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C953AA9C9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5C21DD877;
	Sun, 23 Mar 2025 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYMGyJ2q"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6A01C6FE0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769571; cv=none; b=Z9Jtqb2QUnmkGt3MP8Eh1uCd1cRDibq30N02kAlbB+Fbd1oZc80aaNUO00m9glHPq/SZwWDwpQH4owWtjkwF1L+dtgSTLiwSTjQkFb/RhLPU2IzWQi4Lys95c5t4m87Wxl5dfLNt3rHr/oL5aA8RaeHsl+YsyVkHzzZzQRCTQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769571; c=relaxed/simple;
	bh=yWyEsUV61SIUGSRUBs0R2s8QMDXNnM8dfUs8hI7iDhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahF9MaNGs5nT8vKJgCZNhWky8j+OooGXwiBCiklX9aKUlDqeJ4HoSxhPJQhLaAxTZaKm6455zZIQgygrGEtkDF9IiRZ9+5Xk/8VbGmWN1qT9DgvAQPbnfsZZ5SsMfUpUtj0TbzXsAdYXi9ejP0jO0B7CabiBkIZDzJpjrBoc5v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CYMGyJ2q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbb12bea54so434335166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769565; x=1743374365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9y2iwGfLCsw/LkK7ASOWMxlU+K/ybzYKfyvSxQC13dg=;
        b=CYMGyJ2qx/SSOxrxrYL05VEaM9hVN5UqiThK8rKWJri6u4f4SD6LRLAdiOFpf+c6Kw
         uYrw8msKNc6pSP0ZygXin8UgmGTqB0i+zAi7hsixnyQF4XpgDtxPngX1gyUCEs9uz1Xb
         B8YL/RT8A2KGqoU/a/9BBhvu/+1oR59eR8+iYzPPlCI+Ku5cLxCmP9qk8ItlVSf94Hk1
         164BzjnVaBuV0X9BwoDg+N/HUrmQWvuP4GtTnl6DbyXEk0OoqcWJO9cYJcjVS+LHL1Gx
         BlXxVIjNMeF0hTMd6Uxk997Ahc2z1kmk6+F663qfSoCkgG0wY5GEQjOr4m7stKAWpSfr
         yoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769565; x=1743374365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9y2iwGfLCsw/LkK7ASOWMxlU+K/ybzYKfyvSxQC13dg=;
        b=iTZlMHy0ht1D/toxh3fGE3wOISQnyMVqgSfr6f7XES3y6Ss0Y3Z7vOTqgTA6MfUAw/
         tvyjZno+Cm6hE+n4bTgaLTMUA9+b+GU8ut+2FoWVJyH/xkbLnYGRulTtL4fUfx/Ik286
         9YKfyue0dh5pzF9Xo1xBaYZibWIkT9CwxITHKdrLwF6W4BjlRqtbHAvL8l1IqHPNYEz8
         foHbJzfHyU9wsxi/4WNkXg40XgAzrrOGhZ4gxJlJDTpdNOJ2xGZaR0gSvnn9LIqhJXrl
         AtlcRd8qkeB5zXQtS6wrcv23XLj8vMQuUAsF/ovy9TAKwSeN7Lyf8nSf3jL76PXdaQeX
         2CKg==
X-Forwarded-Encrypted: i=1; AJvYcCUNqyW++7Nw+0QJnPTq81To4EMpQY+3Hvbk5wUUZfegUQ6B/iJBXrHv0aivvPiIpR0f26TxaN7w4a4Bo9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrnrv29l8JMW2Myi1vHOOQhyhMF2rfdqGBjZDYL4h9UWBLEvlX
	1wpugEr6zkNG7NS4GLUF8rhLREF4rzrMLDVM0V4yVMB6gsRoKwkT4mSOE8NLEak=
X-Gm-Gg: ASbGncuHO7GiBslHdQNe2S1QOZfklz1p7W90XticCeS323ZNoAXJecYsBMkZ1iVxC2n
	IW3MJg7vhexPRqYNJG7CrqyQ4OOpd8zaJleWc1gr3bMNHpnwVtFHRAB//n9sAlidMA5w8DsGqh0
	zLagqAn9wulnFpoj4GL4xu5zruI/gXyf9KeOB+V2MjpVFm4DAVsE3cazQ8g99IzINqyn4QixBRF
	g7QuY+ew1/ZRRSho+yOmxur0h/553A+wfFifXi85i1yZAGYdCYVsjYAlAHqvLsR/jV8m0ijGuCC
	Qn1q/b2q5QF6b6vEX/5Yt/daayhwE+FkF6LYzjXrSkC+WhpNDMlEoK4VCQJtunOKwXYX7NcWv96
	1WOGFhOOn+U9vBxAKAzYz5y9VEhcU
X-Google-Smtp-Source: AGHT+IGsAC+lKGhqNteT46jfSAPWq5SZvMmaurRX3KpVQHgnAMqrYltc7UBx62PPecd7JPcN0qJQgA==
X-Received: by 2002:a17:907:9805:b0:abf:4c82:22b1 with SMTP id a640c23a62f3a-ac3f2297ac8mr1130529166b.32.1742769565476;
        Sun, 23 Mar 2025 15:39:25 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:25 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:19 +0000
Subject: [PATCH 03/34] firmware: exynos-acpm: export
 devm_acpm_get_by_phandle()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-3-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The upcoming Samsung S2MPG10 PMIC driver will need this symbol to
communicate with the IC.

Export it.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index a85b2dbdd9f0d7b1f327f54a0a283e4f32587a98..7525bee4c6715edb964fc770ac9d8b3dd2be2172 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -741,6 +741,7 @@ const struct acpm_handle *devm_acpm_get_by_phandle(struct device *dev,
 
 	return handle;
 }
+EXPORT_SYMBOL_GPL(devm_acpm_get_by_phandle);
 
 static const struct acpm_match_data acpm_gs101 = {
 	.initdata_base = ACPM_GS101_INITDATA_BASE,

-- 
2.49.0.395.g12beb8f557-goog


