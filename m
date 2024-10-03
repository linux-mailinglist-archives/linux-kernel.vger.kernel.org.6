Return-Path: <linux-kernel+bounces-349009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F39B98EF4B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232FE1F2136E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9F4189BA6;
	Thu,  3 Oct 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="KgNwlJXD"
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492918593A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958878; cv=none; b=VDaZcQQjIugwInF3zpXKOFMIpa5tq98CTQGmuDZlQ+3OFlWmcH5R1qq1ZiklcDFlEbw7Rxii3tPzcTto4X4qzXze11KsMIoUpZktLRRLxorSzmK4lXoVEwU0KG307D9txEn35eoV+ZAgh/DIIW/OOYiYpQdovC++KP557XBGPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958878; c=relaxed/simple;
	bh=5ylLSa6h6S3kzoT+7BCvuitoGGTbKRF4UgizyrnobTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gkUTfWd2AuWRPVYmnGy4a2a9m2ipAeS2arC0oRjqCQn7quzbMOew0b+k4A8dt4ShG7T/jpV7/iyvdiHKxWpDqRmkadphoVKIAC4Qcfi0evfws+0JKuS+nMJryjKtKs4TiQcObJelyjQ/1mJKZclRhyQ5f8eGyWvAKzHKELCbhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=KgNwlJXD; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4947; q=dns/txt; s=iport;
  t=1727958876; x=1729168476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zc/rAQF015YaK9o693t/zYK9OANf7ZhArgT03L7FmX4=;
  b=KgNwlJXDYOhrKfplwDYajwAjirYqFdPiDukD4PiyDf7CqTUt1GNmT0r3
   pQQdn7Qr1gv8ZaMQKy7pq1wTKlnAjIQJA75wpHwfzF2/nks09GszR2Sox
   SEGxYxOz+ci+LgZIt93FdYCgZ5yVPWUrUfW5+cvmGJtzdMGGLFBYD/RG2
   A=;
X-CSE-ConnectionGUID: AavTDHKjSKucg6DmFrYtzA==
X-CSE-MsgGUID: WGSFNnRjTQeja32XygjPXA==
X-IronPort-AV: E=Sophos;i="6.11,174,1725321600"; 
   d="scan'208";a="268654812"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:34:35 +0000
Received: from sjc-ads-7158.cisco.com (sjc-ads-7158.cisco.com [10.30.217.233])
	by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 493CYZkw013187
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 3 Oct 2024 12:34:35 GMT
Received: by sjc-ads-7158.cisco.com (Postfix, from userid 1776881)
	id ED1BBCC1280; Thu,  3 Oct 2024 05:34:34 -0700 (PDT)
From: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Wawrzyniak <bwawrzyn@cisco.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: xe-linux-external@cisco.com, Daniel Walker <danielwa@cisco.com>,
        Bartosz Stania <sbartosz@cisco.com>
Subject: [PATCH] phy: cadence: Sierra: Fix offset of DEQ open eye algorithm control register
Date: Thu,  3 Oct 2024 12:34:02 +0000
Message-Id: <20241003123405.1101157-1-bwawrzyn@cisco.com>
X-Mailer: git-send-email 2.28.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.217.233, sjc-ads-7158.cisco.com
X-Outbound-Node: rcdn-core-1.cisco.com

Fix the value of SIERRA_DEQ_OPENEYE_CTRL_PREG and add a definition for
SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG. This fixes the SGMII single link
register configuration.

Fixes: 7a5ad9b4b98c ("phy: cadence: Sierra: Update single link PCIe register configuration")

Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index aeec6eb6be23..dfc4f55d112e 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -174,8 +174,9 @@
 #define SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG		0x150
 #define SIERRA_DEQ_TAU_CTRL2_PREG			0x151
 #define SIERRA_DEQ_TAU_CTRL3_PREG			0x152
-#define SIERRA_DEQ_OPENEYE_CTRL_PREG			0x158
+#define SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG		0x158
 #define SIERRA_DEQ_CONCUR_EPIOFFSET_MODE_PREG		0x159
+#define SIERRA_DEQ_OPENEYE_CTRL_PREG			0x15C
 #define SIERRA_DEQ_PICTRL_PREG				0x161
 #define SIERRA_CPICAL_TMRVAL_MODE1_PREG			0x170
 #define SIERRA_CPICAL_TMRVAL_MODE0_PREG			0x171
@@ -1733,7 +1734,7 @@ static const struct cdns_reg_pairs ml_pcie_100_no_ssc_ln_regs[] = {
 	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
 	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
 	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
-	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x5E82, SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG},
 	{0x002B, SIERRA_CPI_TRIM_PREG},
 	{0x0003, SIERRA_EPI_CTRL_PREG},
 	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
@@ -1797,7 +1798,7 @@ static const struct cdns_reg_pairs ti_ml_pcie_100_no_ssc_ln_regs[] = {
 	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
 	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
 	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
-	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x5E82, SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG},
 	{0x002B, SIERRA_CPI_TRIM_PREG},
 	{0x0003, SIERRA_EPI_CTRL_PREG},
 	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
@@ -1874,7 +1875,7 @@ static const struct cdns_reg_pairs ml_pcie_100_int_ssc_ln_regs[] = {
 	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
 	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
 	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
-	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x5E82, SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG},
 	{0x002B, SIERRA_CPI_TRIM_PREG},
 	{0x0003, SIERRA_EPI_CTRL_PREG},
 	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
@@ -1941,7 +1942,7 @@ static const struct cdns_reg_pairs ti_ml_pcie_100_int_ssc_ln_regs[] = {
 	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
 	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
 	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
-	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x5E82, SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG},
 	{0x002B, SIERRA_CPI_TRIM_PREG},
 	{0x0003, SIERRA_EPI_CTRL_PREG},
 	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
@@ -2012,7 +2013,7 @@ static const struct cdns_reg_pairs ml_pcie_100_ext_ssc_ln_regs[] = {
 	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
 	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
 	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
-	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x5E82, SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG},
 	{0x002B, SIERRA_CPI_TRIM_PREG},
 	{0x0003, SIERRA_EPI_CTRL_PREG},
 	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
@@ -2079,7 +2080,7 @@ static const struct cdns_reg_pairs ti_ml_pcie_100_ext_ssc_ln_regs[] = {
 	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
 	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
 	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
-	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x5E82, SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG},
 	{0x002B, SIERRA_CPI_TRIM_PREG},
 	{0x0003, SIERRA_EPI_CTRL_PREG},
 	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
@@ -2140,7 +2141,7 @@ static const struct cdns_reg_pairs cdns_pcie_ln_regs_no_ssc[] = {
 	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
 	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
 	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
-	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x5E82, SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG},
 	{0x002B, SIERRA_CPI_TRIM_PREG},
 	{0x0003, SIERRA_EPI_CTRL_PREG},
 	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
@@ -2215,7 +2216,7 @@ static const struct cdns_reg_pairs cdns_pcie_ln_regs_int_ssc[] = {
 	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
 	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
 	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
-	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x5E82, SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG},
 	{0x002B, SIERRA_CPI_TRIM_PREG},
 	{0x0003, SIERRA_EPI_CTRL_PREG},
 	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
@@ -2284,7 +2285,7 @@ static const struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
 	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
 	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
 	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
-	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x5E82, SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG},
 	{0x002B, SIERRA_CPI_TRIM_PREG},
 	{0x0003, SIERRA_EPI_CTRL_PREG},
 	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
-- 
2.28.0


