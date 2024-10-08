Return-Path: <linux-kernel+bounces-355653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD2B99555B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B461C24A0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E91E1034;
	Tue,  8 Oct 2024 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="T/aLDl8c"
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247181E1026
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407445; cv=none; b=QPSP/xaR+yEZzx3RVREAfgaF9jLEpsa7okvwsL+4Rm44w5VIKg1Gss44eouDG/+8HWj5HiEN0iRL4FpCAxjATzr6j1jtORuwmiSEkaRKUqaCvZMnavaVyY8YkDMwBKPQsfn8+W6n52lJZ8MRVsDysAjmxhuAPcqx3SeukHEgOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407445; c=relaxed/simple;
	bh=pl2uWE5xIbAzAogviQsXJiRZoszKxQQgtQC9w/Fu4tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=my1gwySyL6+cMdT6gXqCSKVqnvR+9hCWeMYN70peWguwIjVaiiCdS840ILob+lGMINnMjwW14xoaa5ID8NvMMFBG8netIX2b+6x7696oP9+hQdWiOzYaFxa+0a6/JQn6uQzP6NqDUbziYOXG1W64rOpjt17h2ubjT/zMuNzV0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=T/aLDl8c; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5044; q=dns/txt; s=iport;
  t=1728407443; x=1729617043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cgf0xBsMQs7AQN/5YQYdocnpHKvx2IgkCpijo5VHKqc=;
  b=T/aLDl8crT5KTlkWUqx4Lc5hXqL2Bozw+AqUX6lFXDtdfL5clk4oWL6l
   HqdWTUE0Ym1+bhkeoZ1pY2ENJJN2y51at5mVIrgnq5pZfEWqO1l1FRtdq
   U40u9JGEMucTAWM3nCGn7ENX/Z95AHX2tsDdCKLgVf5pCmkx/PzE4wxkI
   U=;
X-CSE-ConnectionGUID: ev9OfBmXS8qNpg0KMJ/GeA==
X-CSE-MsgGUID: MN48UY+2SzmGx+SNBbKxAg==
X-IPAS-Result: =?us-ascii?q?A0AZAADpZgVngY7/Ja1aHAEBAQEBAQcBARIBAQQEAQGBe?=
 =?us-ascii?q?wcBAQsBhBlDSIxylUeSJIElA1YPAQEBD0QEAQGFBwKKFwImNAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQUBAQUBAQECAQcFFAEBPQUOO4YIhlwCAQMyAUYQGTgrK?=
 =?us-ascii?q?wYBEoMBgmUDrUOCLIEB3jOBbBiBMAGNQnCEdycbgUlEglCBPm+DeocNBJYrV?=
 =?us-ascii?q?w+CVoN1FolskURIgSEDWSECEQFVEw0KCwkFiTWDAAUhKYFrgQoWgnWCTAKCV?=
 =?us-ascii?q?4FnCWCEOoI7cGWBBy2BEYEfOkeBO4E2LxskC16BQ4EbARYGFQSBJUc/gktrT?=
 =?us-ascii?q?jkCDQI3giUkZIJWhhNAAwsYDUgRLDUGDhsGPm4HrGNGglKBDnxBbJNhsweEI?=
 =?us-ascii?q?qE8GjOEBaZFmHYigjShYYRmgWc6gVtwFYMiUhkPjlnHVEYyOwIHCwEBAwmOC?=
 =?us-ascii?q?AEB?=
IronPort-Data: A9a23:y6K616zhafqHgfwBiux6t+fXxirEfRIJ4+MujC+fZmUNrF6WrkUGy
 TYcWmjXOfuNZ2HzL9ElbN+xoRsG78ODzYBgHABoq1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCKa/FH1a+iJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 IqaT/H3Ygf/h2csajJMsMpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJEwobKoW0ONHOjFX0
 +QXcBMoTFesisvjldpXSsE07igiBNPgMIVavjRryivUSK57B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2cOXWjOX9PYH46tO23j2blYSxegFmUvqEwpWPUyWSd1ZC3b4KFJIXWFZ09ckCwg
 0Sar1nIQUshJtmw2Xm+1Fimpf/mknauMG4VPOblrqEx2gL7KnYoIAYUXFi7qPW0okW3V99ZI
 EFS8S0rxYAx9VerSd/VXBCipnOA+BkGVLJ4De499QWlyafO5QudQG8eQVZpbN0gqd9zXTw7/
 luIhM/yQz1pvqecRX+U+vGTtzzaESFQImgcZCkIVwIH/vH/occ4iRenZtJiFrOly974Azf9x
 xiUoyUkwbYel8gG0+O851+vvt63joLCQghw4kDcWXioq1skIoWkfIevr1Pc6J6sMbp1UHGMo
 ikjleKb3NteFLeVm3SuZcdKM7yAsqPt3CLnvXZjGJwo9jKI8nGlfJxN7DwWGKuPGphYEdMOS
 BGP0T699KNu0G2Wgbibir9d6vjGL4C7SrwJtdiNMrKih6SdkifcrEmCgmbJhgjQfLAEy/1XB
 HtiWZ/E4YwmIapm1iGqYOwWzKUmwCszrUuKGsqrlEv4gOfFPSXEIVvgDLdoRr1phE9jiFiEm
 +uzy+PQk32zrcWnOHCOqt9JRbz0BSZqVcmqwyCoSgJzClE7QD56UaC5LUIJcI1+lKMdjfbT4
 ny4QQdZzlG57UAr2i3UAk2PnIjHBM4lxVpiZHREFQ/xhxAejXOHtvZ3m20fJ+h/rLQLID8dZ
 6VtRvhs9dwRG22Zq25CPPEQbuVKLXyWuO5HBAL9CBBXQnKqb1WhFgPMFuc3yBQzMw==
IronPort-HdrOrdr: A9a23:sf+asqxvDJ1WD+d5msMMKrPwEb1zdoMgy1knxilNoNJuHfBw8P
 re+8jzuiWUtN98YhwdcJW7Scu9qBDnhPpICPcqXYtKNTOO0ADDEGgh1/qG/9SKIUPDH4BmuZ
 uIWpIObuEYdWIK7voTJGKDYq4dKB7tytHQudvj
X-Talos-CUID: =?us-ascii?q?9a23=3Ai/3Q42t+u3ZJdW/e6bbJ3eaU6IsobCz6wl3VE3T?=
 =?us-ascii?q?oEEBxR+W2bH3X165Nxp8=3D?=
X-Talos-MUID: 9a23:JyRRlQRWZnJ9zPcRRXTJom0yCfYruZ+8DW8d0q4gkcOnJQV/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="270861480"
Received: from rcdn-l-core-05.cisco.com ([173.37.255.142])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Oct 2024 17:10:36 +0000
Received: from sjc-ads-7158.cisco.com (sjc-ads-7158.cisco.com [10.30.217.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-05.cisco.com (Postfix) with ESMTPS id 995DF18000238;
	Tue,  8 Oct 2024 17:10:35 +0000 (GMT)
Received: by sjc-ads-7158.cisco.com (Postfix, from userid 1776881)
	id 1AFF0CC1280; Tue,  8 Oct 2024 10:10:35 -0700 (PDT)
From: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Swapnil Jakhade <sjakhade@cadence.com>,
	Aswath Govindraju <a-govindraju@ti.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: xe-linux-external@cisco.com,
	Daniel Walker <danielwa@cisco.com>,
	Bartosz Stania <sbartosz@cisco.com>,
	Bartosz Wawrzyniak <bwawrzyn@cisco.com>
Subject: [PATCH v2] phy: cadence: Sierra: Fix offset of DEQ open eye algorithm control register
Date: Tue,  8 Oct 2024 17:09:59 +0000
Message-Id: <20241008171000.2665935-1-bwawrzyn@cisco.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <ZwN+8xpOl4+Ggaha@vaman>
References: <ZwN+8xpOl4+Ggaha@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.217.233, sjc-ads-7158.cisco.com
X-Outbound-Node: rcdn-l-core-05.cisco.com

Fix the value of SIERRA_DEQ_OPENEYE_CTRL_PREG and add a definition for
SIERRA_DEQ_TAU_EPIOFFSET_MODE_PREG. This fixes the SGMII single link
register configuration.

Fixes: 7a5ad9b4b98c ("phy: cadence: Sierra: Update single link PCIe register configuration")
Signed-off-by: Bartosz Wawrzyniak <bwawrzyn@cisco.com>
---
v2: Remove empty line in the commit message
v1: Fix offset of DEQ open eye control register
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


