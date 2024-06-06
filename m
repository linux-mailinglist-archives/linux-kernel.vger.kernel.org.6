Return-Path: <linux-kernel+bounces-204487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AE58FF04D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24873B2937A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDC919CD13;
	Thu,  6 Jun 2024 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVpOSaIb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD3198E8D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684617; cv=none; b=hHmX7J2wR3iJxN1DjAKEv49Xo/S5OmzVGhvarHa/46/FGYwdlcFRGGr1aK9ROUcWrujXgOytGn6Xqyuh6jzyyDHyONti1A0rhxMr2RuXqmpy+rPm7GVKJjKlhIFQSF05RK36lborXy9qB/kb/S8EJL/OPX9t85ANfRn3sPQMib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684617; c=relaxed/simple;
	bh=HoQgcM1v61QTQaw7hxevdOwl+gFbD0LvX+R34v7HQUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVyAsbHTJguSF6vCjf23o9CuKEV57rVGYs9cdiu6B9y+UEUzVXppAvovmHwkbghW8wzt1t7lHaSj1rJ/nLjZ/xTKkoXTVxVK/arYjAgeiTc4PAqpLqof7UWMXUaF82PxByFB63AhFqJBFpk9SpUVwNk0RNHiqY4bTSYQCJiaIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVpOSaIb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42163fed884so1965625e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684614; x=1718289414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJGZ6Uu/K+CEvU7SenPD0ND/ZswoEpORmUYwGdFQeI8=;
        b=HVpOSaIb3v7P6Hhh4zvOD/Le1vKG1oqQ+LzAMjIwxhsdDYwq0BcxMghMQcvszVK+9f
         MF8abLOX/lyOhOoh36V7y7z7Ezr7nO42/DL148P33vF2UdGGNK95cLpo//dkeBytZHLd
         jLGwmE7Ey2pGx130Rdx47kmpoXUvvJYX0Pa2GHg1r4vw/evIpynn/JKXqXm9/0wYMKDo
         MO68G80wjHzic4tWZQ3KqWDSfy5byubVYUrCHr0nRKREU2x20glHNLoxfL7ikMxonRWy
         Tc/WYG2qZUhyxnaEYISEHkNn4vuvuK0yePAW+lBm/WkwDHwfTboqpjURSZwmyaM2IT4P
         Y0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684615; x=1718289415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJGZ6Uu/K+CEvU7SenPD0ND/ZswoEpORmUYwGdFQeI8=;
        b=hxAsthrE3QHMF7F3yj7DShZy06f9j6lQ/PvdlsDgR6/hXCj56+2rcCBO3NvhYcnjcx
         2BsKgqlR9zX6effGi4KmGNXBUN8WFb9rhsgmE0+YnnlSm9N488BlzheWpS/RCVrhvkt+
         jQhmbekvEnY7iYlN5jcbmENiQVQzo68gDqVo6zGYzR6pIFpqPaK1eIRnM/Kw8aS2U6Fg
         y0H86Y/Jv4FMmBZ1IMHkbJmDEZuZvpKaQYN1ZTPC9gUzfSFExcuJM6G9hMTTNhQVz/jv
         UkA20HeS0c/EIFigGGdRDydRNTPH52nea82gINH6OWZf+XU6GB2C7h6tIILrvCiXXxJL
         lSRw==
X-Forwarded-Encrypted: i=1; AJvYcCU7P0N5w31IysQFK0nKh917SPIclBP3l6V1mLUz0oZa13C8uN3SyhlZRzioWiMETRBDnPeSBXqMDYS77X7geX3rGeAPVKgZ6r8w80uO
X-Gm-Message-State: AOJu0YyRj5TGGT9VQERKRdyp9h2fm90HsAchwR8hrNRuipNxlZjHqpvG
	EprbUcPZiWroXV9sj1LJ40ajc4KN+pZBhS5m1rtozIqwax1lx58KGA9aCuWg/78=
X-Google-Smtp-Source: AGHT+IHZn6oC9SB1W5aaL9cA3jdYYQVK4SRCy28QGjtvWm+2YyXB7pITSCWXefonmyHypnDRsqTmMQ==
X-Received: by 2002:a05:600c:3b9e:b0:420:2cbe:7f00 with SMTP id 5b1f17b1804b1-42156357f60mr46822585e9.39.1717684614611;
        Thu, 06 Jun 2024 07:36:54 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158148ffasm59540865e9.38.2024.06.06.07.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:36:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com,
	llvm@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] mfd: wm8994: Fix Wvoid-pointer-to-enum-cast warning (again)
Date: Thu,  6 Jun 2024 16:36:48 +0200
Message-ID: <20240606143648.152668-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606143648.152668-1-krzysztof.kozlowski@linaro.org>
References: <20240606143648.152668-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'type' is an enum, thus cast of pointer on 64-bit compile test with
clang and W=1 causes:

  wm8994-core.c:625:17: error: cast to smaller integer type 'enum wm8994_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Year ago this was solved, although LKML discussion suggested warning is
not suitable for kernel.  Nothing changed in this regard for a year, so
assume the warning will stay and we want to have warnings-free builds.

Link: https://lore.kernel.org/all/20230814160457.GA2836@dev-arch.thelio-3990X/
Link: https://lore.kernel.org/all/20230810095849.123321-1-krzysztof.kozlowski@linaro.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mfd/wm8994-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index d5ac066f9db4..094c0b3dbd97 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -622,7 +622,7 @@ static int wm8994_i2c_probe(struct i2c_client *i2c)
 	wm8994->dev = &i2c->dev;
 	wm8994->irq = i2c->irq;
 
-	wm8994->type = (enum wm8994_type)i2c_get_match_data(i2c);
+	wm8994->type = (kernel_ulong_t)i2c_get_match_data(i2c);
 
 	wm8994->regmap = devm_regmap_init_i2c(i2c, &wm8994_base_regmap_config);
 	if (IS_ERR(wm8994->regmap)) {
-- 
2.43.0


