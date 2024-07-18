Return-Path: <linux-kernel+bounces-256243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F51934B59
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D8B1F21C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADBD13342F;
	Thu, 18 Jul 2024 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2eIZ8F7D"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15C12C49E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296690; cv=none; b=Vc0v8GvNwYlItqOhrEUgo5gaT7jpjeWWoBorwy+bpw0Aca3Qim6njYHu5NQYOIhjSYa8TBds6Z3wGhC9+qnfJ2pT9CZmZc2VQqZybVo58hyZRQC5WEXPbFqpImqwahLtfuDB7vy15im9oVH+9J68mjMNOaQGN3xG1cvXDUi1Oxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296690; c=relaxed/simple;
	bh=9cZe1kPmCTyObujoid9EqIB/vM/2BaIZArY0kMmMOUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh/EJoJplmFBMAg3Ns5lfh3oMXzoofpAEoX/qt2brasCCOrJCk69u918rT9xAx52rNzL+vJvlTkZpPo8/ySr9QCpuO3xNZsr7L5oMK2wWy0MwKEbOsVOv0TjMCUMcAbCzSj6FrM0Ay0XUWuBD40PWfBFyM9G2vEOdQCUdGP6i4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2eIZ8F7D; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e9f788e7bso180842e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721296687; x=1721901487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsHCgll+Hmm8fed0dFMQNF0ix1j3UG0Ow/yT3gZX+Ck=;
        b=2eIZ8F7DA5+sokV3TfhI7NXGPjnmd12plKpgIMVvyjG3Y3Xc1A/VHFS8SP/2Bu7J7u
         tksBjNNQ8pRRZwy9b5oiLSRzfIHn3IR5ZpFJ3Tp8eOkBDEecl0tIwg84QepG63Phphl2
         ib2USm4boJijeB3KJU8F2J/6Pecn2TIre0O867ekJX9wxDQhwsX5OSHtiwLl9MVkntsS
         C877L2ZqzZLynPSiZt9F/aW3wzWOIxuyVVaErMBz0FODUoNpBXIR3Ys6nS2XHcdLT9RO
         /W13UWmgzV5npCVf7jWkj5gSbZi9hV4f7KBJAh++cVKNa4E0a8lQByVOPPvv+2HD5qs6
         Xf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296687; x=1721901487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsHCgll+Hmm8fed0dFMQNF0ix1j3UG0Ow/yT3gZX+Ck=;
        b=CUXHyOOJn6yWyVWesEl6ImKn6P0zdnTL+X22ZqDYCJluD1hg6A2BYJforBf8/i3FtF
         w5294Sd5t/DykXuk1jo1Jjy1a5JTToj6KVmLtv9+GuHTEVYYOA2RfvzXVlnBedxJ/Rli
         m0VrvV4Sx3C/WJKVi3cBB4tKwvaBn0fd8HISuw9u0n/FPWZZxj2WgL1tvYeQH4KqgFJB
         yXp4jk3zocntmC4a1DPEuLgV0UNyeTdE+vSzLUiaJ9eXaNk/RUrihdl3k1q/ozHHf6Fw
         KI1Xz2ROIcJuGq+z6LeyKdPCuk5qu7mVpvc1cI8+LuRCnCF9ac4zOTNoPkLmwQC3E63A
         i70w==
X-Forwarded-Encrypted: i=1; AJvYcCVrDYrE2CIKVN1PUaA0CjEWkkBVEKc5oDIA7HS5REv0dTR4QoqKULga340AaRQGgF97wKcCDx75C2Mh6xhA0SGG6wTniTNrBhL8k4lG
X-Gm-Message-State: AOJu0YypTM212EQW5SjQG33wPYJ76CPJA6FAJiKpShOXYmd7E+1JwEoS
	SpTwP3wnA9pMUcO5d7G4HpFWaWewPwbbPumXzi2Oy0nEkyxPydJT9RNT3tyrWX4=
X-Google-Smtp-Source: AGHT+IHCNw6mvVs0JqyoFHW8EQrkH7lFTfsUSnH12CIgfhfeQ/Vay1c4tow8aO7Uajm253zXYZe4DA==
X-Received: by 2002:a05:6512:2385:b0:52d:b1e4:b337 with SMTP id 2adb3069b0e04-52ee53b284dmr3180536e87.21.1721296686619;
        Thu, 18 Jul 2024 02:58:06 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8d37:f44a:c212:e320])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3680dab3be3sm13837155f8f.24.2024.07.18.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 02:58:06 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 4/9] reset: amlogic: add driver parameters
Date: Thu, 18 Jul 2024 11:57:48 +0200
Message-ID: <20240718095755.3511992-5-jbrunet@baylibre.com>
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

To allow using the same driver for the main reset controller and the
auxiliary ones embedded in the clock controllers, allow to customise
the reset offset, same as the level offset. Also add an option to make
the level reset active low or high.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index a4705021b8f2..09b23f320f57 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -18,7 +18,9 @@
 
 struct meson_reset_param {
 	unsigned int reg_count;
+	unsigned int reset_offset;
 	unsigned int level_offset;
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


