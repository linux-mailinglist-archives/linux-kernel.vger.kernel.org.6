Return-Path: <linux-kernel+bounces-247770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2322292D44F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE5D1C23523
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77EF19408B;
	Wed, 10 Jul 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="HHcjhS1b"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26905811FE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622118; cv=none; b=gQzX2LN8xmq4IKtcs8AcGu6ScH58HTfE9sRbeLJybKUCbXuILEJNoOTi1PIELYc4vZJZbkfMZBSdXqUUQqUwBAW4Qqi/It7kGaYCggMTpsjZac4QnjuULg12IW7BrctnRsPLfyU6WQvbAgY9Zh7fnVRsFlINUyx1xqFZoZzquTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622118; c=relaxed/simple;
	bh=9jooIyIr/HyUzJS6LzsDZvXen5wuwqO3O1aOewsFVTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1GK0PKtZb6ciy0P/OrJLl4Vh6gs5MHfqvB7dwegbivtRbpZnQ9UiJLT/9fcjJWwI97cExVMc5j3SIf1xwmjN1Oe4+3vdRm8YfoI6tGp0xweddBZlykPJwGyjFUgOnSmnOgPbBSQr5LbEePeT2stJw4cyaSjH+GF1+FKPLiLBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=HHcjhS1b; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4267300145eso16242055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720622113; x=1721226913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+0yIikCD08oMheZij8lHE8qY8gpPceCppKq1cqRcAo=;
        b=HHcjhS1bwMk35gRgCF4G1qD8VGQysTf469DwI/x32PEieXI4qWHD0bLUQ8ZKJht3vD
         6vbYikbf9kyxgyLG+hypL1sH69a2wtvcXVFBZo/V3x5G42HMvwDZLOZM1zAICAGjFxiu
         GDuKEkL5yDP+NEQYjnxD/J3oH8gaTmefp9GxfIUVerP00uUebddeWlyQ2pru7l01dlXa
         QZrc0b5Vd6IxAgVzl5ns8hy8IlHri9LWCCgCgo6d0RU9sHPAZC4liYZehGqKa/ZHI05A
         DQdduYgaaD/zKjoOc0t47zCImunFGzuUfmdOZ/AzO4X23/gxHDneuCB6jTbwO5tbQXqo
         pjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622113; x=1721226913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+0yIikCD08oMheZij8lHE8qY8gpPceCppKq1cqRcAo=;
        b=ZZ4S4rwewa5ehADeGBPv0EIqZgOirDCiGPQhWWPYsOtg76dlk3ZiRqcbSEC119dh3y
         KDt9SaoI0FPjxRlIJN3xIDJz8XMpx6/LNqFTQ5YWYsTHQFznwoxgBE+EXEia0JePrHy0
         eP2P+9UWIMYbv5qzeaold46TKX3Z2Jg1bb0LnJdDBQ+WJP2E8K/mha8jQdr9fZQlR037
         swd5WAB6z0Vgpu77ijs+qprLYL4i6dPvnNTev+GrCMksyT7Qh2vVV1JtfC+XokDx1rv3
         NXisEPx5CvNcDYPOcCZGbU/VuYlOT5Wr7x0QbZuMc/n/aSs4xZgMBQdqKuzcAgsJoOOY
         FQoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE91cn+98OlODw42vhj0peUA0VJImv7HhWCS0o6CUIjk5nj110oeD+XrfoXGJs+nvt/5v/OWSyjjlp0nWGCmAbNvRtmWOczuGlcusB
X-Gm-Message-State: AOJu0YzJQH4sldhbVfoPKjXPJLdGSVImPevHR22AiPHdpz7iaS7yDvSt
	gQr7cYk+lq1NKXyJiH6hQgK0AIVK22kRfxEruVc0JcyKB4+2VCTiQY+0PbL3tTI=
X-Google-Smtp-Source: AGHT+IGGyG6eoSg+EDRDbPNkiAakf/Y71Bv3rcFVrUCzswdv8GYcPnvEmlqukEaNZ6hBPV6Mku68+A==
X-Received: by 2002:a05:600c:4312:b0:426:6857:3156 with SMTP id 5b1f17b1804b1-426707f8580mr44315485e9.27.1720622113357;
        Wed, 10 Jul 2024 07:35:13 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e097bsm85925025e9.6.2024.07.10.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:35:13 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] clk: mxs: Use clamp() in clk_ref_round_rate() and clk_ref_set_rate()
Date: Wed, 10 Jul 2024 16:33:10 +0200
Message-ID: <20240710143309.706135-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use clamp() instead of duplicating its implementation.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/clk/mxs/clk-ref.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mxs/clk-ref.c b/drivers/clk/mxs/clk-ref.c
index 3161a0b021ee..2297259da89a 100644
--- a/drivers/clk/mxs/clk-ref.c
+++ b/drivers/clk/mxs/clk-ref.c
@@ -66,12 +66,7 @@ static long clk_ref_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	tmp = tmp * 18 + rate / 2;
 	do_div(tmp, rate);
-	frac = tmp;
-
-	if (frac < 18)
-		frac = 18;
-	else if (frac > 35)
-		frac = 35;
+	frac = clamp(tmp, 18, 35);
 
 	tmp = parent_rate;
 	tmp *= 18;
@@ -91,12 +86,7 @@ static int clk_ref_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	tmp = tmp * 18 + rate / 2;
 	do_div(tmp, rate);
-	frac = tmp;
-
-	if (frac < 18)
-		frac = 18;
-	else if (frac > 35)
-		frac = 35;
+	frac = clamp(tmp, 18, 35);
 
 	spin_lock_irqsave(&mxs_lock, flags);
 
-- 
2.45.2


