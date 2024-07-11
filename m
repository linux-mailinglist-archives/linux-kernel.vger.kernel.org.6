Return-Path: <linux-kernel+bounces-249614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625F892EDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2BE283C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2016DEAE;
	Thu, 11 Jul 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UNMBB7gt"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2516D9BE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719096; cv=none; b=Qnl4VRb+vOV2KZIRw43gXRlJm2/PJzMM/BT2LynIxD3YQFI1md5IR3D3NFVQ1JRd+7KOTVrd9PQdUN+aciT31QuW5OLlFkOGeiDy5ty9c9u27XX79/zb8YdTsD4dnNBH+KL+VA1craCA7QZ1K5vkVX5GrLZjvnGhbTJOl7mN8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719096; c=relaxed/simple;
	bh=EbbiXRBL8HrzAg+yUgeovOpjQ3huWrUXPU/7EhK8zmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Um8+XkVtSF5+5lwAnAdOlFECl0zbHdWYncfcyjVaRojBz2R6O6yi3+KFWPjkPo+Rz7HhH/bdGPEgY7PBalDKVqsfCwSNp26sMl7I8HSoHkx6SLajIOia5pUk6lthU/tUw2XxkSz+NPILWC3iI1ZSjYwtRg7xr2LuSilKDZsW3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UNMBB7gt; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id RxdPsAr1uHTrpRxdmsVLtc; Thu, 11 Jul 2024 19:31:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720719094;
	bh=A0NOwSSCnj3xicr3sw3iyD9fFy6aCRNZ4cGMskLj1QM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UNMBB7gtc7++sYbZbHSmEkl0Q2G25m2AmSWlZTsaAR2p4ORz/j+s2vd8g970Gb/KG
	 ZmmfG+DPhLZJ4/hZoWgw/5iWuK7XlnYwSIaMMhY39sAZafDKtFNhgRgzUMQntGxhOC
	 k2Uor2s6qs/UV9T/sovoP7xKHNHfTxMQhmahyLsAZk6oFrl0S27efy2rfTdb56TSEx
	 4AnieTSKpAf/sQfI56rmKM/TN+JEUU1RJccjAiBlm41+Obhg92kQgcgZCIN4TG6oIG
	 6froEreYKDt1lt3i34WeJZDFOa6y6zLT1i53kwPex0k0BaifIUEPBDQ9rel75nbFMB
	 SyGyBsAU5y3uw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jul 2024 19:31:34 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/4] phy: cadence-torrent: Constify struct cdns_torrent_vals_entry
Date: Thu, 11 Jul 2024 19:31:07 +0200
Message-ID: <dcc4e539999a840b3fd8f40fd8fd7523390232ac.1720718240.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720718240.git.christophe.jaillet@wanadoo.fr>
References: <cover.1720718240.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct cdns_torrent_vals_entry' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  85130	  13214	     16	  98360	  18038	drivers/phy/cadence/phy-cadence-torrent.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  92234	   6078	     16	  98328	  18018	drivers/phy/cadence/phy-cadence-torrent.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/phy/cadence/phy-cadence-torrent.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 6551dcf99639..6787d64ee982 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -432,7 +432,7 @@ struct cdns_torrent_vals_entry {
 };
 
 struct cdns_torrent_vals_table {
-	struct cdns_torrent_vals_entry *entries;
+	const struct cdns_torrent_vals_entry *entries;
 	u32 num_entries;
 };
 
@@ -4611,7 +4611,7 @@ static struct cdns_torrent_vals pcie_100_no_ssc_rx_ln_vals = {
 	.num_regs = ARRAY_SIZE(pcie_100_ext_no_ssc_rx_ln_regs),
 };
 
-static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
+static const struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_NONE), &sl_dp_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_PCIE), &pcie_dp_link_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_USB), &usb_dp_link_cmn_vals},
@@ -4647,7 +4647,7 @@ static struct cdns_torrent_vals_entry link_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_QSGMII), &usxgmii_sgmii_link_cmn_vals},
 };
 
-static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
+static const struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_NONE), &sl_dp_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_PCIE), &dp_pcie_xcvr_diag_ln_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_DP, TYPE_USB), &dp_usb_xcvr_diag_ln_vals},
@@ -4683,7 +4683,7 @@ static struct cdns_torrent_vals_entry xcvr_diag_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_QSGMII), &usxgmii_sgmii_xcvr_diag_ln_vals},
 };
 
-static struct cdns_torrent_vals_entry pcs_cmn_vals_entries[] = {
+static const struct cdns_torrent_vals_entry pcs_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_NONE), &usb_phy_pcs_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_PCIE), &usb_phy_pcs_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_SGMII), &usb_phy_pcs_cmn_vals},
@@ -4691,7 +4691,7 @@ static struct cdns_torrent_vals_entry pcs_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USB, TYPE_DP), &usb_phy_pcs_cmn_vals},
 };
 
-static struct cdns_torrent_vals_entry cmn_vals_entries[] = {
+static const struct cdns_torrent_vals_entry cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_cmn_vals},
 	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_cmn_vals},
 
@@ -4773,7 +4773,7 @@ static struct cdns_torrent_vals_entry cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &ml_usxgmii_pll0_156_25_no_ssc_cmn_vals},
 };
 
-static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
+static const struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_tx_ln_vals},
 	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_tx_ln_vals},
 
@@ -4855,7 +4855,7 @@ static struct cdns_torrent_vals_entry cdns_tx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &ml_usxgmii_156_25_no_ssc_tx_ln_vals},
 };
 
-static struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
+static const struct cdns_torrent_vals_entry cdns_rx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_rx_ln_vals},
 	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_rx_ln_vals},
 
@@ -4966,14 +4966,14 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	},
 };
 
-static struct cdns_torrent_vals_entry j721e_phy_pma_cmn_vals_entries[] = {
+static const struct cdns_torrent_vals_entry j721e_phy_pma_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_NONE), &ti_usxgmii_phy_pma_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_PCIE), &ti_usxgmii_phy_pma_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_SGMII), &ti_usxgmii_phy_pma_cmn_vals},
 	{CDNS_TORRENT_KEY_ANYCLK(TYPE_USXGMII, TYPE_QSGMII), &ti_usxgmii_phy_pma_cmn_vals},
 };
 
-static struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
+static const struct cdns_torrent_vals_entry ti_tx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_tx_ln_vals},
 	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_tx_ln_vals},
 
@@ -5089,7 +5089,7 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 };
 
 /* TI J7200 (Torrent SD0805) */
-static struct cdns_torrent_vals_entry ti_j7200_cmn_vals_entries[] = {
+static const struct cdns_torrent_vals_entry ti_j7200_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_cmn_vals},
 	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_cmn_vals},
 
@@ -5171,7 +5171,7 @@ static struct cdns_torrent_vals_entry ti_j7200_cmn_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &j7200_ml_usxgmii_pll0_156_25_no_ssc_cmn_vals},
 };
 
-static struct cdns_torrent_vals_entry ti_j7200_tx_ln_vals_entries[] = {
+static const struct cdns_torrent_vals_entry ti_j7200_tx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_tx_ln_vals},
 	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_tx_ln_vals},
 
@@ -5253,7 +5253,7 @@ static struct cdns_torrent_vals_entry ti_j7200_tx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_156_25_MHZ, CLK_100_MHZ, TYPE_USXGMII, TYPE_QSGMII, NO_SSC), &usxgmii_156_25_no_ssc_tx_ln_vals},
 };
 
-static struct cdns_torrent_vals_entry ti_j7200_rx_ln_vals_entries[] = {
+static const struct cdns_torrent_vals_entry ti_j7200_rx_ln_vals_entries[] = {
 	{CDNS_TORRENT_KEY(CLK_19_2_MHZ, CLK_19_2_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_19_2_no_ssc_rx_ln_vals},
 	{CDNS_TORRENT_KEY(CLK_25_MHZ, CLK_25_MHZ, TYPE_DP, TYPE_NONE, NO_SSC), &sl_dp_25_no_ssc_rx_ln_vals},
 
-- 
2.45.2


