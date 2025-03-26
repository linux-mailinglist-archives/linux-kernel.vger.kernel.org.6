Return-Path: <linux-kernel+bounces-577235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617A4A71A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D7E3B8342
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D21F419D;
	Wed, 26 Mar 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KiPHA4Sk"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFB1F4165
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002618; cv=none; b=TrxrP2phNyrgc7xRGICOrdo0UCGbWlCIabvYEw88IIzXkfHCCUrvC2GT4nc9fy6S1Hho5lixoSPrnceiTiSqpt3WNDd3P/xCr5HSKTpysflCRVMdT9OwzHOZW3lSMP8Je1OYSUKkijc5FiyqwszqvOENQKPXK0YIr73FjMzAJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002618; c=relaxed/simple;
	bh=ThbuFrBidcsv7ki8clsHCS9mlo8Lxr9wScaCYVrIqBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7bqLbqd5cL+IoMeBT/6s1oNAAkXiWqdZOV+e6KEAAI5ACKVO4v5aGsNbe6zAFI5bAQ9DDvdKeC0/eSNM3x0ccDlbvVD8NUJWalGjplLW+RQxVAZ1N97mlOTBUsvt4d/BbGyD9uqJyBVxKqH+sZhOHuzo6bYS80hXgVCNApcp10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KiPHA4Sk; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52QFNODR2227262
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 10:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1743002604;
	bh=guzCcx7sZr0haX4pTDAv49k4kG8TbtZrl1jzFabfe6c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KiPHA4SkRkVQbH7JUsHr/y8OnVj04Ye3GVpIKGAsc0rWzVV2sGm22QXNUfun8wYdF
	 8EI8HJxtmlJi8a2+T8mGwH0/C0RpqrNDujcskEYyX9dwwdyoeOYcEcbTQ8ohVMCIw+
	 Ev5dx1yPUlfTTL/0wpCOtdGwyMEESm77THnyKamA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52QFNOQ2004053
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Mar 2025 10:23:24 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Mar 2025 10:23:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Mar 2025 10:23:24 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52QFNNXW076869;
	Wed, 26 Mar 2025 10:23:23 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <mripard@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <sakari.ailus@linux.intel.com>, <u.kleine-koenig@baylibre.com>,
        <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>, <s-jain1@ti.com>,
        <r-donadkar@ti.com>, <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v2 2/2] phy: cadence: cdns-dphy: Update calibration wait time for startup state machine
Date: Wed, 26 Mar 2025 20:53:20 +0530
Message-ID: <20250326152320.3835249-3-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250326152320.3835249-1-devarsht@ti.com>
References: <20250326152320.3835249-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Use system characterized reset value specified in TRM [1] to program
calibration wait time which defines number of cycles to wait for after
startup state machine is in bandgap enable state.

This fixes PLL lock timeout error faced while using RPi DSI Panel on TI's
AM62L and J721E SoC [2].

[1] AM62P TRM (Section ):
https://www.ti.com/lit/pdf/spruj83

[2]:
Link: https://gist.github.com/devarsht/89e4830e886774fcd50aa6e29cce3a79

Cc: stable@vger.kernel.org
Fixes: 7a343c8bf4b5 ("phy: Add Cadence D-PHY support")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2: Introduced this as as separate patch

 drivers/phy/cadence/cdns-dphy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index c4de9e4d3e93..11fbffe5aafd 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -30,6 +30,7 @@
 
 #define DPHY_CMN_SSM			DPHY_PMA_CMN(0x20)
 #define DPHY_CMN_SSM_EN			BIT(0)
+#define DPHY_CMN_SSM_CAL_WAIT_TIME	GENMASK(8, 1)
 #define DPHY_CMN_TX_MODE_EN		BIT(9)
 
 #define DPHY_CMN_PWM			DPHY_PMA_CMN(0x40)
@@ -405,6 +406,8 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
 	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
 	writel(reg, dphy->regs + DPHY_BAND_CFG);
+	writel(FIELD_PREP(DPHY_CMN_SSM_CAL_WAIT_TIME, 0x14) | DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
+	       dphy->regs + DPHY_CMN_SSM);
 
 	ret = cdns_dphy_wait_for_pll_lock(dphy);
 	if (ret)
-- 
2.39.1


