Return-Path: <linux-kernel+bounces-303034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528D960664
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DBDB2354E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD019FA8A;
	Tue, 27 Aug 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYCjXj9u"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2DE19F475
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752573; cv=none; b=UqRGxFx8bZ1GlvOniZD06d6WTM8MHElsci9lSRC86CXhcCcMXzmQ0pfzB7WzwD88WyJFCmhfhNk3JqXRhq0uVsVROubAzvbCaM6sbVeW6R6+p0EaP//hTEyZ0Ur3e5IQfCOaaw8N+UKcltgWnr19Iwo+py16Or3pS4nQqqb8hgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752573; c=relaxed/simple;
	bh=NARynwCKnnv3T9J1Gl/DhTBzBUpASqlkAgDCanjFiKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piE/EqkwoRRYy8dGS/nADR+Q/6uyjT3IjBo7+F2xf689Qyo9z2W0ORlPRufe4+pY3ni13P2IJO/BubFVUTDNAyVR84cFK+j0KKP84PlCmd1AazY9qbvRvviBFuNRQxzhEdp4bmC4wrUc7Bsqc7lcMdJPyFO84/LkwR/h4cdIQO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OYCjXj9u; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201d5af11a4so46472425ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724752571; x=1725357371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWF2y1DaAfCI+OxvAbtfW9C6juMvoH4TVoXic04e7PQ=;
        b=OYCjXj9uZyk0CjLZJb3BonEzUHCklOV0xtcVNzC3OblsgThA39p3dPOCUgibefXYYy
         CYoi09/HXPlGYejWF90WRLNTgpvl9mU0KI4OFaffuFaAfbu4baSm5BTmPUFwWGzoL4il
         d2jYV8HaGR9O63Z2RlTqpQ8zkD+v06M2lf+xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752571; x=1725357371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWF2y1DaAfCI+OxvAbtfW9C6juMvoH4TVoXic04e7PQ=;
        b=Q610X8yWsbJ7eG8ML0Rehpp0Pvz49QcHxX+HHwnFpHUfDXOWweDqj3fVGjyt4flR3s
         TJ5nD/6nDqMS2fpN+dII82fmx09maC35XR0xEOqnDU5Epz04zMLbHehrkm6Lw5C+Dk7a
         mQusNnKnTSiGg+yDOGnXbUHep66IXuRUfD20JwSDrcLWLdOKBdxepkkgwFOSGqgBk9bG
         7DG6jKAISG62lY64byEF4Iw7ChjKKx2K3ltcml/470GVLt6fdJRprUFMApedfhcv/EIl
         3sqpYxFkTPpT1Naq84xn4K8PtRJv2fh9+5xJIG1pzxrp9jOUP27kJ2i5zq1lsV0uOWeU
         /L9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXR7ZBREZGL5qHCKBuVUN7vQ0LkSSMLZqIvEEsB7gfLrB/dZvzlDgIEKQ7kQ6tUNJo9JO1MfJCgFOrhWyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyts592OIY4MO4w7dceobmN0S04IYrppfhdGWp3zAip6j50EXkK
	Pe3cxA5ytUvLtLhqNjXb24B8LOvfje1tTJ8gXLMPrub2qte0oxNBNjp6t5ZvkQ==
X-Google-Smtp-Source: AGHT+IG1bfKL3An8XqshnrBPErEA+/k/utDPS4gPGGdrb8g9f7KtjCgE/tEqVtdEn/QXw5TVbNEMPg==
X-Received: by 2002:a17:903:bcd:b0:203:a12e:faa7 with SMTP id d9443c01a7336-204df45fdafmr21313875ad.27.1724752570967;
        Tue, 27 Aug 2024 02:56:10 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:3102:657e:87f4:c646])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560c2basm80006775ad.222.2024.08.27.02.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:56:10 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 7/8] regulator: fixed-helper: Add missing "Return" kerneldoc section
Date: Tue, 27 Aug 2024 17:55:47 +0800
Message-ID: <20240827095550.675018-8-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240827095550.675018-1-wenst@chromium.org>
References: <20240827095550.675018-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc complains about missing "Return" section for the function
regulator_register_always_on().

Add a "Return" section for it based on its behavior.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/fixed-helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/fixed-helper.c b/drivers/regulator/fixed-helper.c
index 2d5a42b2b3d8..72807af63126 100644
--- a/drivers/regulator/fixed-helper.c
+++ b/drivers/regulator/fixed-helper.c
@@ -26,6 +26,8 @@ static void regulator_fixed_release(struct device *dev)
  * @supplies: consumers for this regulator
  * @num_supplies: number of consumers
  * @uv: voltage in microvolts
+ *
+ * Return: pointer to registered platform device, or %NULL if memory alloc fails.
  */
 struct platform_device *regulator_register_always_on(int id, const char *name,
 	struct regulator_consumer_supply *supplies, int num_supplies, int uv)
-- 
2.46.0.295.g3b9ea8a38a-goog


