Return-Path: <linux-kernel+bounces-288767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E06C953E44
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0241F21A18
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2567D433BB;
	Fri, 16 Aug 2024 00:18:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8F32B2CC;
	Fri, 16 Aug 2024 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767526; cv=none; b=XLyOEobe0C1dyvO7q2wuMy3EodGRWxnL4MqhYHcSbCwnC3RXbAKSwkiVf/MK4uAu2PVOLHZfOSxlL9KqyGyD/4hxmFbAcBOWDskMsgs40hfvl0OnjbJeAuSu9FRpL/hk3x6WoU8ukyP4db+4VzMKMFIR8Kd6eCN8sd9xPN3kGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767526; c=relaxed/simple;
	bh=BtSkgtgYxYi3tCt26YMCMhnhtlsJLtRd+gmk5O5hj2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJUJWM8WC+YmdDUxle9mcnVpt9mYJJw+jzL5Y2iFdPKd0FgtHXv3m25V5HxzuEWg3/D8elkcpsNS2qGNhaWZ5LdB3kMXMvt46YUHhXdqGZFdw4dWwXTTJpaW2g4kNIyvVFw6qWHymjeKgPdWqKRS1a0dROGevB4iSJ7X6SQROoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EDB316F3;
	Thu, 15 Aug 2024 17:19:10 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B61E13F6A8;
	Thu, 15 Aug 2024 17:18:42 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Chris Morgan <macroalpha82@gmail.com>,
	John Watts <contact@jookia.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Philippe Simons <simons.philippe@gmail.com>
Subject: [PATCH v3 2/3] mfd: axp20x: AXP717: Add support for boost regulator
Date: Fri, 16 Aug 2024 01:18:23 +0100
Message-Id: <20240816001824.6028-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240816001824.6028-1-andre.przywara@arm.com>
References: <20240816001824.6028-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AXP717 also contains a boost regulator, to provide the 5V USB VBUS
rail when running on battery.

Add the registers to the MFD description to be able to use them from the
regulator driver.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: John Watts <contact@jookia.org>
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/axp20x.c       | 2 ++
 include/linux/mfd/axp20x.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index dacd3c96c9f57..16950c3206d7f 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -209,6 +209,8 @@ static const struct regmap_access_table axp313a_volatile_table = {
 };
 
 static const struct regmap_range axp717_writeable_ranges[] = {
+	regmap_reg_range(AXP717_MODULE_EN_CONTROL_2, AXP717_MODULE_EN_CONTROL_2),
+	regmap_reg_range(AXP717_BOOST_CONTROL, AXP717_BOOST_CONTROL),
 	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
 	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
 	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 8c0a33a2e9ce2..3758f986491c8 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -115,6 +115,8 @@ enum axp20x_variants {
 #define AXP313A_IRQ_STATE		0x21
 
 #define AXP717_ON_INDICATE		0x00
+#define AXP717_MODULE_EN_CONTROL_2	0x19
+#define AXP717_BOOST_CONTROL		0x1e
 #define AXP717_IRQ0_EN			0x40
 #define AXP717_IRQ1_EN			0x41
 #define AXP717_IRQ2_EN			0x42
-- 
2.39.4


