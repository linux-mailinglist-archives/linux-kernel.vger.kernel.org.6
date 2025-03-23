Return-Path: <linux-kernel+bounces-573024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AEFA6D208
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B97188DBAE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2BD1F2360;
	Sun, 23 Mar 2025 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ro5ATcEw"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489D1D6DB4
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769573; cv=none; b=oocOyEMtruMxF5GkZ4PqJwGSEB+KoWwV2P9tpX/nMbqTP78tF7ieyaVk0ewAb8ASr8Mjs+wgd852L7XOlIcDTH9/frxsbaQ/T0odOLDXcOnF+TAYd3x+brtz/vzV877ZmckPg2lMLXonVUIhjnxBzxs2Wdpk8imHmfuUa9yeAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769573; c=relaxed/simple;
	bh=SOWDFBYDVimh2JZdbpqs93MuJ5ZKdaya15zjUJJgJoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ef5i5AiMU9e5QZGS++aVIe8PgiIpZqheKBPD28YfvgmgF/7pVI7VCccy3mCFk3tOmWPfZc6A/jtGzHLDBX8ON2wOt5nwf9PMdyDyjN3cmM46vBwDGEH5N1kMrA3MjN5a2IiwvTkxePdIw7KzakSoN9II5Zn5wkIkEDasuw14S2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ro5ATcEw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso650959566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769568; x=1743374368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1WAgr4uwM04DZyOzCnLxT64GQbYEMMtR1/k9PjNmnI=;
        b=Ro5ATcEwOXJoVYOumsx3SzyVEZr0IG0MbaEdO3CqShFnuHHX7IA3m+53Mge+A4z2+K
         Y4gISwjjFDeTGH+A5hP5NV37c3Mfk1ZROF6AeKE66mHgWJ0rbvnyRe2h5SCxyavfrjP/
         xOX05pEBekJgjHGfLO4PmSIYxso5YMdkOI8ZpXp5oiQLCrqMWFfYaQgp8lVJ96JPsfBy
         KsOvSJRRe4uaTIPxXOF03cAA0oqbGCJ6CSP7YEO8x3Ncs1SsxqHmbjvwZR80nzm56bWY
         zroBW25Zsp9DOgHUsb+nRZLCF0rlB+LDEdvogubZegvgBkEOGZO7l1skyOEFAAdhvJr7
         9+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769568; x=1743374368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1WAgr4uwM04DZyOzCnLxT64GQbYEMMtR1/k9PjNmnI=;
        b=ONeHedLZ0JunDJiaLDJb79LJd+uLCyQ8rbUh8ei0s9laFqh62b8psUN7+f+nA2WVID
         CUGBeuiPH37cIBSsvH7R/T9J4e3dOEN+U+x0y1gAqoq7NVARr3HxvCTwQvct1rjT+XHI
         pLphInjc9K8iAHW8GvkVTWffHfR1MvzD62flnfAWJ2t5OUyja3I7l/fZLJt12ieJQbLY
         CS+KpmdfJr1ZjLVqXYTs8A6+LBcZKHf8MGni9HJjulMOSCtr3yj7ejse7+T3W7b+N1Wv
         EDhymtcEjpg+d2hqpSjRK6j8nWOcVbC+lnJc7lUDUjhEdsC25qTlot4r0MmNogvc+ejZ
         wWDg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZqIf96sSb/0BKDcDEIWnk8benjpOZK6mX7tnZiShMVNlE59fGaRE32wFoayjnPzukNyBk8L56or9lUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvhxbNcOUFkA+lY+gdqZhfCOhoA/AdED5MZshAnb+1LaokMBw1
	BKxNZ0rrm4K68pmePVfqgqczain+9xBkmXYQq2OcrRxbQQ4e+jce88uvd6nXQMs=
X-Gm-Gg: ASbGnct96yDpStHJH6sGmlP/mLmIAn7kkppVRN9CDyhSQv9+hlalB61yy/RIvIgm3sc
	ipbbiQ2M3Pw1izgnzb0a+bUBA1symqQPNRJpD2k784Ggc5UZS0cK0nE71eges1cdSBv0Re+OUth
	PxCmZCyTQaqrlZkn8/YGWdZQQpDzbgEXnroRCZnuisi4bq60LqwaW4mQjl5bh8J6EzQRD4r731a
	OOusS/pxmlZInUqKVZFSmEifXInpthdg/irr34pbUWAfClpMym26r7mnGPBrgr4ciJjmQiHpZEz
	U6HQtBtXDWLKgrKmzk1SkKIai7cZAJ78JToFvv5sw2t2PhvtQdrenTl4ZBCky2IbWC5h+4ogDDP
	ZHX+sl2+d+fBjcbhRbf+j2QAQocn8
X-Google-Smtp-Source: AGHT+IGESlPld0TIZcF+ERlnjIFgWzaZCupFw8MycHD7wowlazt/klJI/2hD2dVdJFw5afV/HysuBA==
X-Received: by 2002:a17:907:bd88:b0:ac4:491:1548 with SMTP id a640c23a62f3a-ac404911816mr803996166b.11.1742769568148;
        Sun, 23 Mar 2025 15:39:28 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:27 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:24 +0000
Subject: [PATCH 08/34] mfd: sec: fix open parenthesis alignment
 (of_property_read_bool)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-8-d08943702707@linaro.org>
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

As a preparation for adding support for Samsung's S2MPG10, which is
connected via SPEEDY / ACPM rather than I2C, we're going to split out
(move) all I2C-specific driver code into its own kernel module, and
create a (common) core transport-agnostic kernel module.

That move of code would highlight some unexpected alignment which
checkpatch would complain about. To avoid that, address the error now,
before the split, to keep the amount of unrelated changes to a minimum
when actually doing the split.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index 83693686567df61b5e09f7129dc6b01d69156ff3..b931f66f366571d93ce59c301265fe1c9550b37d 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -276,10 +276,12 @@ sec_pmic_i2c_parse_dt_pdata(struct device *dev)
 	if (!pd)
 		return ERR_PTR(-ENOMEM);
 
-	pd->manual_poweroff = of_property_read_bool(dev->of_node,
-						"samsung,s2mps11-acokb-ground");
-	pd->disable_wrstbi = of_property_read_bool(dev->of_node,
-						"samsung,s2mps11-wrstbi-ground");
+	pd->manual_poweroff =
+		of_property_read_bool(dev->of_node,
+				      "samsung,s2mps11-acokb-ground");
+	pd->disable_wrstbi =
+		of_property_read_bool(dev->of_node,
+				      "samsung,s2mps11-wrstbi-ground");
 	return pd;
 }
 

-- 
2.49.0.395.g12beb8f557-goog


