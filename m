Return-Path: <linux-kernel+bounces-247914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF7992D645
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC861C22B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337C1194C8C;
	Wed, 10 Jul 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CXFEs00Z"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FC5194AC7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628742; cv=none; b=YnrwI/MqRvPSb0KrefHI8/zMXtEPiNi1A7GdChV6LopyTCr710uPLf0bh4s/zJFybqNEel1fVGZKQP7039G/ZE5/xMEhr5MdjxWa6zarCMhmssU+pz422BtOTUWVUKjktd4tL3JmIuNwjwn0AEpyOX66gF15+gge8MLYsxZLXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628742; c=relaxed/simple;
	bh=XhLKaJpFjJZQj7yn2g+fkx1VUJf2EFpLz+SlbAbTNhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T18iSDiCfUk+yirPUP9YeQn1p5hg+AQqrABinCcWZOaiV+E1/ohhSi+K383/LKJRUNrxXd24iIyBx0k7uI/hk2MAC+T2zSZUwQ69VrkozAbg2EzGfsHjpnPctjlV5Dzd7fjmmPbG5ReV1lhOXDwVnQuek5k9FoB36zbe7E16TLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CXFEs00Z; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-426717a2d12so6665135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720628739; x=1721233539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEvOpWPnO+AdwLbOiUNmMA/qUdgyKNblxOI/csLZzos=;
        b=CXFEs00Z5J8adHO87gz3RcJ7bmRRklG+NcgawE0SzldweQrbyWvBmyc2GRKK8wXT3p
         pMe3vdSW8fSE6h7By/iWb7DgCMdjeFbnNevvky4Z7yqa0DUzrouO/429ZEQ3PbpmtGQM
         3J6/LZPvJYxJmQXuLlTmu6u4B6pWBKq0evKRMk6bc44Qe31ONu9BIeSDyKZ7JRp8bWny
         JdDuqrOdy7+JhkSsYyO8Vw9ROh+0Sb1jPVr8MTkXOecauVm04KIMYgGOYmh3j5nWF1bg
         WtiAYCRA+2qJlwr8hNofyEdJBRQJhDHPh1FG7C4hmR/Uxfo5YX82IHI2pMmVc00GTRSE
         SwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628739; x=1721233539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEvOpWPnO+AdwLbOiUNmMA/qUdgyKNblxOI/csLZzos=;
        b=M+GMLUzPgTnCb4mfvWZEcDzlFoI+8x6BYR+oIFlvfAgkSY2xRRf2Ws/N+hbnDZYqA2
         E70ljPJDd9MTHkSoFRGKPSXid0dTniK4Eoft6XQ20Q6rtjhbR59kPKQUvdL04/whH1jf
         hSRjO5A/v24rxV/iTPOla51jlZr26M48MaSYU5WcI6UNkOulqa5b/qtOEDJxrZXN/pY/
         dDmADlYLECQsNXXN6Rz7Xz/RwqctEWgl8ndYKJCND/cMXF362ShHCEqPwqBSJ29VJ2nH
         J7mmpGpC1RlBCukeoqBOm6SH4Y/SRq/ik8kB2sCvq9QaE89JDatBYeMu4VYSh8ig8vPP
         QueA==
X-Forwarded-Encrypted: i=1; AJvYcCWvUemCUOjKyG9SGsaLqriaV2Uu3Neenr/L8Yh/l/+gF9H3j//p9JpCeicLd7NCz9Sh4rUUE7CejBI1RsptEemIR//b3rHci/RMsP7o
X-Gm-Message-State: AOJu0YyyDZ8DepgrAAIXng4DF69KxcMTokCWdHKGwyeynfQYvXpH15y+
	NYNV2bXZ6ThEyuuac8QrKVLQ0tErS1LNsaWD+jg+xwKfqklM119QDMqv5s+lHC0=
X-Google-Smtp-Source: AGHT+IGEAqgF56Q6WhhGNsntYmhXMllSRTjGVzvDJz7QmMwzchYfln7Fkm+0PHq8i2T834Jv9qxoxw==
X-Received: by 2002:a7b:c4c7:0:b0:426:6fb1:6b64 with SMTP id 5b1f17b1804b1-427981b7727mr1634915e9.7.1720628739119;
        Wed, 10 Jul 2024 09:25:39 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1c99:6356:8466:36cf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4266f6e09e5sm88693815e9.5.2024.07.10.09.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:25:38 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 2/8] reset: amlogic: add driver parameters
Date: Wed, 10 Jul 2024 18:25:11 +0200
Message-ID: <20240710162526.2341399-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710162526.2341399-1-jbrunet@baylibre.com>
References: <20240710162526.2341399-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

To allow using the same driver for the main reset controller and the
auxiliary ones embedded in the clock controllers, allow to customise
the reset offset, same as the level offset. Also add an option to make
the level reset active low or high.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 8f3d6e9df235..59126c9f194a 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -18,7 +18,9 @@
 
 struct meson_reset_param {
 	int reg_count;
+	int reset_offset;
 	int level_offset;
+	bool level_low_reset;
 };
 
 struct meson_reset {
@@ -46,6 +48,7 @@ static int meson_reset_reset(struct reset_controller_dev *rcdev,
 	unsigned int offset, bit;
 
 	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->reset_offset;
 
 	return regmap_update_bits(data->map, offset,
 				  BIT(bit), BIT(bit));
@@ -60,9 +63,10 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
 
 	meson_reset_offset_and_bit(data, id, &offset, &bit);
 	offset += data->param->level_offset;
+	assert ^= data->param->level_low_reset;
 
 	return regmap_update_bits(data->map, offset,
-				  BIT(bit), assert ? 0 : BIT(bit));
+				  BIT(bit), assert ? BIT(bit) : 0);
 }
 
 static int meson_reset_assert(struct reset_controller_dev *rcdev,
@@ -85,17 +89,23 @@ static const struct reset_control_ops meson_reset_ops = {
 
 static const struct meson_reset_param meson8b_param = {
 	.reg_count	= 8,
+	.reset_offset	= 0x0,
 	.level_offset	= 0x7c,
+	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_a1_param = {
 	.reg_count	= 3,
+	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
+	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_s4_param = {
 	.reg_count	= 6,
+	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
+	.level_low_reset = true,
 };
 
 static const struct of_device_id meson_reset_dt_ids[] = {
-- 
2.43.0


