Return-Path: <linux-kernel+bounces-256244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0572C934B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3797B1C21E30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358513A869;
	Thu, 18 Jul 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AWpNlOPf"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2F12C7FB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296690; cv=none; b=nCn/jqFxDTNSs4XV92eK4gFZaKsANV+O9IaQ+uvybxPbkyqiqAjjXVbsvdWyh6npBkgX5AqitO7P2uQVUOT2XHA2DG9Yo+Z5bwG2jf2nfb9qGn2sh7tCHY0TGGPdzhw7gsIGqz+ckJxBspcOu+4pW2cganY/FNm04EQMfPkYDps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296690; c=relaxed/simple;
	bh=5V9s/8uzgo6Nj/XypJWT48nWu3rbfdd76bKMSCUv6fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AS3ecZ+t09dmxtQ8O1qf5DEqRAvdvJlVB3uwwWW3YmZfZkIE+i975Xp+lUDEIVGsIzIeH2mMfNIUhOC5OQhjL8Qq35bE28Zm+P4zdfGiBa3O+PM7ceqg+LW2GIOaj2l8kt6ap/458UZN4kboyuXrQozXmXfuFBQv2cT6BMjExVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AWpNlOPf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36799fb93baso436874f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721296687; x=1721901487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anoJ0A/eyMlcq4ZsnQ8nc5h5FKEq9eY7wJHK/pAFmYw=;
        b=AWpNlOPfqCWv0ZzDdspuvs7tSG5SsQakSyLDj0qhLsG0idP2d8YuLydZ3VssmkMHPx
         ciEzF5H1LobvYH4CJmctSysFGWFpPxnlkEKcx9MTtl5IoxYwN0L9MTzV4AESJ66C2MMF
         uhnfWz+lLaIpQMHV1ca+SW/wqTVUVCbdSTnWQmwB1oKdJNkNdWC5/dD7L8TypKhZ4SXS
         BFFnaiAAvXfJ2nxPT+mw8Wi9FmihnWOpcw4q1woUN1pJ3nkIwkj7QrgsADzmYYMWL+kk
         VlQbjP0xa9tukHgYk5+D0mL6FxfsKlnyV9KLsm3ppzs8FhLvYKtNi207DxuyjMcnbtsW
         lvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296687; x=1721901487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anoJ0A/eyMlcq4ZsnQ8nc5h5FKEq9eY7wJHK/pAFmYw=;
        b=CQqPq57fUx9Nv23vHxJRUIcCVFExO+TURGxztXA60j9LerSO5kgbqKppB+KCfAsWm8
         7inRuynlrSU3vb8vL4zOihequlbL3RZ+C5ob4lt9Mm1w/NcVuO3YyyAawg70YdP0FDwj
         8e/Qv7v4UOmhAblbB4UzkYxBC/n85VgpPT1D0cCKdnO7ErkMvlStCGhmMT8Efr9x1MCu
         jwdD5QgvaojzpVZmKzjQJtIVIBUrCA9sKapMLjGazZM8bG5i7Ncze8kJKQUzPzXgIhn2
         2sAGzBMqSN+MilUjeNod12miA1HUJ38FEhE8mfo0nkhyKGJ80ajaAn2VlHLSFvfg5TUo
         2mTg==
X-Forwarded-Encrypted: i=1; AJvYcCVHkJkagD/jU7EIOZdCbC4i7/Tb6iC0BikdHalSk1RZSBcVpTVRwzcEDSlaBFMQ2jqHumnmV61Zo49ZGxsJTP/ATrmf2nRzzXhDekr9
X-Gm-Message-State: AOJu0Yxl6hipS/DB7H8kOTnOwpgUCFbDLb57YLFQbn5hr43R83OgvyJC
	r3ZFtMP6KKxUO9rJdHVwtGTvA4f0Xmb+XQ2QH56WTcH65Bn4/Z6SPaI27GZ3G3A=
X-Google-Smtp-Source: AGHT+IGAJ2huYI+q7mn5ECdgrCiYMeaEBMdk8eW0Vl4o6RXhiCLf/tX+GMgpIK5T1/Tj+4ER838TOA==
X-Received: by 2002:a05:6000:44:b0:367:9d2c:9602 with SMTP id ffacd0b85a97d-368316f8052mr4039827f8f.49.1721296687407;
        Thu, 18 Jul 2024 02:58:07 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8d37:f44a:c212:e320])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3680dab3be3sm13837155f8f.24.2024.07.18.02.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 02:58:07 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 5/9] reset: amlogic: use reset number instead of register count
Date: Thu, 18 Jul 2024 11:57:49 +0200
Message-ID: <20240718095755.3511992-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240718095755.3511992-1-jbrunet@baylibre.com>
References: <20240718095755.3511992-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

The reset driver from audio clock controller may register less
reset than a register can hold. To avoid making any change while
switching to auxiliary support, use the number of reset instead of the
register count to define the bounds of the reset controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 09b23f320f57..5a5e1c2358b6 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 
 struct meson_reset_param {
-	unsigned int reg_count;
+	unsigned int reset_num;
 	unsigned int reset_offset;
 	unsigned int level_offset;
 	bool level_low_reset;
@@ -88,21 +88,21 @@ static const struct reset_control_ops meson_reset_ops = {
 };
 
 static const struct meson_reset_param meson8b_param = {
-	.reg_count	= 8,
+	.reset_num	= 256,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x7c,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_a1_param = {
-	.reg_count	= 3,
+	.reset_num	= 96,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_s4_param = {
-	.reg_count	= 6,
+	.reset_num	= 192,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
 	.level_low_reset = true,
@@ -149,8 +149,7 @@ static int meson_reset_probe(struct platform_device *pdev)
 				     "can't init regmap mmio region\n");
 
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = data->param->reg_count * BITS_PER_BYTE
-		* regmap_config.reg_stride;
+	data->rcdev.nr_resets = data->param->reset_num;
 	data->rcdev.ops = &meson_reset_ops;
 	data->rcdev.of_node = dev->of_node;
 
-- 
2.43.0


