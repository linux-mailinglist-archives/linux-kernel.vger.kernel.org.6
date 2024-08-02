Return-Path: <linux-kernel+bounces-272608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCB3945EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F8671F2337A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F101E2885;
	Fri,  2 Aug 2024 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WXqbIFjz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B49D1DA26
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606399; cv=none; b=aR6dKPt8Pr9+/32RxWtf2vM1ZfXyYLabo3orphlfQKWQYV8wmNOKc7DUcRVCcW7r5zX948STxefItqKU8+0lSxxogW5xaG5W98enO+HkMo/9GkdgbP9am4IrqAaxicvtbwqLfO5XTu1c4aQwteQqHbAG4cb0DI3XMOXXQQOU3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606399; c=relaxed/simple;
	bh=4c9Ldky+3qywdMlPP+dyoq9OuhFiLIHUR2wWzTIlc9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8WdfpgeSMpVqEPslBZ0jf60q+GRutdvw0N9ZqDNV5XdhY13bpIP3gHQ4bGj9Rllc3nS7hRloDRdI06rnJQmTrnkSnJQnm+S9G/occNaeDH9MoulBxI6GugFTLIqWcapGq5MPMzjm8XT/kJD3p93A7CWP29+eZU7OfLycUGM5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WXqbIFjz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722606390;
	bh=4c9Ldky+3qywdMlPP+dyoq9OuhFiLIHUR2wWzTIlc9E=;
	h=From:To:Cc:Subject:Date:From;
	b=WXqbIFjzG1uB/AbIfD0r8lOiXH4luNOtGxADP0xm/KojkJzU9GZscyAoQxktWnWZF
	 Fwk3K1AfAhb9mwkm6FHR1QlUZvEN1QE8JeC9ayKPez2SOPL+CknjZqVpshqmoH11pQ
	 qgl7VvAY1XkoX/hxoTfAyt6840/ZNLau2GFIW+tH8HvLgS6gJ6S367G4mRFRnoKe/T
	 fd7HxTxEFaU4I2FHaHC//vAl6Euq5mKkAERXdcqtkZ+yeIFUnt09B960F1DwtnPhNI
	 4P4S6oy9QqEaLW1z/qcwpIWKleih+KXVezLnI9sCfD1yz/aNNPKNQHHCJv76SmO6OE
	 I7RE6BO6HPINQ==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 87CD33782215;
	Fri,  2 Aug 2024 13:46:29 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH] mfd: rk8xx: Add support for rk806 on i2c bus
Date: Fri,  2 Aug 2024 09:47:36 -0400
Message-ID: <20240802134736.283851-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ArmSoM Sige 5 board connects the rk806 PMIC on an i2c bus.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/mfd/rk8xx-i2c.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
index 69a6b297d7238..37287b06dab0d 100644
--- a/drivers/mfd/rk8xx-i2c.c
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -21,6 +21,17 @@ struct rk8xx_i2c_platform_data {
 	int variant;
 };
 
+static bool rk806_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RK806_POWER_EN0 ... RK806_POWER_EN5:
+	case RK806_DVS_START_CTRL ... RK806_INT_MSK1:
+		return true;
+	}
+
+	return false;
+}
+
 static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	/*
@@ -121,6 +132,14 @@ static const struct regmap_config rk805_regmap_config = {
 	.volatile_reg = rk808_is_volatile_reg,
 };
 
+static const struct regmap_config rk806_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RK806_BUCK_RSERVE_REG5,
+	.cache_type = REGCACHE_MAPLE,
+	.volatile_reg = rk806_is_volatile_reg,
+};
+
 static const struct regmap_config rk808_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -150,6 +169,11 @@ static const struct rk8xx_i2c_platform_data rk805_data = {
 	.variant = RK805_ID,
 };
 
+static const struct rk8xx_i2c_platform_data rk806_data = {
+	.regmap_cfg = &rk806_regmap_config,
+	.variant = RK806_ID,
+};
+
 static const struct rk8xx_i2c_platform_data rk808_data = {
 	.regmap_cfg = &rk808_regmap_config,
 	.variant = RK808_ID,
@@ -201,6 +225,7 @@ static SIMPLE_DEV_PM_OPS(rk8xx_i2c_pm_ops, rk8xx_suspend, rk8xx_resume);
 
 static const struct of_device_id rk8xx_i2c_of_match[] = {
 	{ .compatible = "rockchip,rk805", .data = &rk805_data },
+	{ .compatible = "rockchip,rk806", .data = &rk806_data },
 	{ .compatible = "rockchip,rk808", .data = &rk808_data },
 	{ .compatible = "rockchip,rk809", .data = &rk809_data },
 	{ .compatible = "rockchip,rk816", .data = &rk816_data },
-- 
2.46.0


