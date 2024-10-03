Return-Path: <linux-kernel+bounces-348924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5114798EDBC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7E91F23AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCF2170A03;
	Thu,  3 Oct 2024 11:15:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDA17838C;
	Thu,  3 Oct 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954119; cv=none; b=EBP63kZ3fAnlh6PKroqMS7xrNkcPR48k6YOf9kMNyYFTbB6AWlH6kmgmCYEZUGJEnc2JKZx3r8R4sPkDsmuQQW96EFJR1XMqP1TFsYQS/aXhz7RH+VhjQCootW9dkYlszoY7zZ0vaELEQi+lzVsxrkv0BgSEJI1B0WonyZBkXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954119; c=relaxed/simple;
	bh=/FzFW9WXcSY1CgAMQDYyoTu481kZOYcSEgjBUguuwVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JmbtlvE5hFGmSe8R64gwA6dycZxmY3ZLxjc6ZzZOl7XEiLGSjuMlkL3cvqxxONrXHYl2Rav6Qk5d9g7+zSMRmpA5TPCUczT40lSb6g+My/A/LFIpJuRfzpnWErm5DgC6jW+/dEv0qXNJny3bXzW+mD0tORj96X9qzeSZLiynXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7D63497;
	Thu,  3 Oct 2024 04:15:46 -0700 (PDT)
Received: from e110479.arm.com (unknown [10.57.55.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4638F3F640;
	Thu,  3 Oct 2024 04:15:14 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Martin Botka <martin.botka@somainline.org>,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 5/5] regulator: axp20x: add support for the AXP323
Date: Thu,  3 Oct 2024 12:14:44 +0100
Message-Id: <20241003111444.543964-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003111444.543964-1-andre.przywara@arm.com>
References: <20241003111444.543964-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X-Powers AXP323 is a very close sibling of the AXP313A. The only
difference seems to be the ability to dual-phase the first two DC/DC
converters.

Place the new AXP323 ID next to the existing AXP313A checks, to let
them share most code.
The only difference is the poly-phase detection code, which gets
extended to check the respective bit in a newly used register.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 3ba76dbd0fb9..e3cc59b82ea6 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1341,6 +1341,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		step = 150;
 		break;
 	case AXP313A_ID:
+	case AXP323_ID:
 	case AXP717_ID:
 	case AXP15060_ID:
 		/* The DCDC PWM frequency seems to be fixed to 3 MHz. */
@@ -1527,6 +1528,15 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 		}
 		break;
 
+	case AXP323_ID:
+		regmap_read(axp20x->regmap, AXP323_DCDC_MODE_CTRL2, &reg);
+
+		switch (id) {
+		case AXP313A_DCDC2:
+			return !!(reg & BIT(1));
+		}
+		break;
+
 	default:
 		return false;
 	}
@@ -1565,6 +1575,7 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 						  "x-powers,drive-vbus-en");
 		break;
 	case AXP313A_ID:
+	case AXP323_ID:
 		regulators = axp313a_regulators;
 		nregulators = AXP313A_REG_ID_MAX;
 		break;
-- 
2.25.1


