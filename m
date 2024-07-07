Return-Path: <linux-kernel+bounces-243480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812F59296C2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 07:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EA3281C40
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBB9AD24;
	Sun,  7 Jul 2024 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="f4UZ+dfp"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72CF7482
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720331809; cv=none; b=L8dzfC4bTaLTbCyFfcNC+ywjZzcAbBJw2liJwPFJh/hn++LP0dUUYR0BH3U2ry8FnBcul1ePPOsvDRIiEdWfWcGXNOhc/jUQBA8Lz013n2kNz6NRPxSc0WZ6E8WDKRET515Bjn1vZmXTXUCzur4p4TUStXM6K1RDLugNfUdluwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720331809; c=relaxed/simple;
	bh=u2h4zXjm5+8RWz+q131yJ9n5hRdE/G52xfNU6ku39vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZML8MWFLdL7tzDWxG0qCtFco1t2UI/bUTSczMazxSCzOpXTp1z8Zukjb52Neu7BXqjG8WsaDCwMDSgyWyA9HZEdUk6A/QvAow5QXIWSn53WbyBAfM/lIsIPYtipwVLmC1Ci5MTsxpmPoubm5wBoySWrodeOn60F9UviIAyX5un4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=f4UZ+dfp; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id QKkEsyOxChEtDQKkZs8JLj; Sun, 07 Jul 2024 07:47:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720331272;
	bh=m5hfeJJaQd2sDlwjtKUNvEvzR4Fj1xT7GH3XV3uqVeI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=f4UZ+dfpSgIf++oPpNP1xmqTHIJ9Nns4VYsrkS0XHVn54a56e99lj7h89jST+8l1g
	 X/mHEiSgI/vq3+AnkdDeaydhwpCfzsCW/vO/5jwIjmGZjV+6a91J+paMzPTjA+b4rY
	 swubC7XIy2uB3jZ5S0HtPXo59GCyL6nczVfXq3Y8Q/KcOZ6ntgfgddqZLvfG3xX8xm
	 bUYYAhfCIRVV1RodZMpbsNxl3mVbH24/3fZNhWLpx8VXJCeJlhEjO4oFSCCSB7QNuV
	 Rbb3Hn3ZdbILHcBKki4B1K3Y7IxVtx9El5b3dwVYIdTFZ5/z9LAoTu9rr3cukQL+uw
	 aeEnuA3zVSEVA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Jul 2024 07:47:52 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	fchiby@baylibre.com,
	fparent@baylibre.com,
	s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 2/3] soc: mediatek: pwrap: Constify some struct int[]
Date: Sun,  7 Jul 2024 07:47:21 +0200
Message-ID: <f1fea00fbaa0fea298bf67732e019f9cc5c407ab.1720331018.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720331018.git.christophe.jaillet@wanadoo.fr>
References: <cover.1720331018.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These arrays are not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  45528	   8532	     16	  54076	   d33c	drivers/soc/mediatek/mtk-pmic-wrap.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  52664	   1384	     16	  54064	   d330	drivers/soc/mediatek/mtk-pmic-wrap.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Compile tested-only

Changes in v2:
  - Add R-b tag

v1: https://lore.kernel.org/all/626783bb264a8b3b0c8cd7e1d9f9b241f0a494b6.1719652155.git.christophe.jaillet@wanadoo.fr/
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 30 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 0da0cdec5050..d57553486383 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -483,7 +483,7 @@ enum pwrap_regs {
 	PWRAP_MSB_FIRST,
 };
 
-static int mt2701_regs[] = {
+static const int mt2701_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -569,7 +569,7 @@ static int mt2701_regs[] = {
 	[PWRAP_ADC_RDATA_ADDR2] =	0x154,
 };
 
-static int mt6765_regs[] = {
+static const int mt6765_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -601,7 +601,7 @@ static int mt6765_regs[] = {
 	[PWRAP_DCM_DBC_PRD] =		0x1E0,
 };
 
-static int mt6779_regs[] = {
+static const int mt6779_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -640,7 +640,7 @@ static int mt6779_regs[] = {
 	[PWRAP_WACS2_VLDCLR] =		0xC28,
 };
 
-static int mt6795_regs[] = {
+static const int mt6795_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -725,7 +725,7 @@ static int mt6795_regs[] = {
 	[PWRAP_EXT_CK] =		0x14c,
 };
 
-static int mt6797_regs[] = {
+static const int mt6797_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -758,7 +758,7 @@ static int mt6797_regs[] = {
 	[PWRAP_DCM_DBC_PRD] =		0x1D4,
 };
 
-static int mt6873_regs[] = {
+static const int mt6873_regs[] = {
 	[PWRAP_INIT_DONE2] =		0x0,
 	[PWRAP_TIMER_EN] =		0x3E0,
 	[PWRAP_INT_EN] =		0x448,
@@ -769,7 +769,7 @@ static int mt6873_regs[] = {
 	[PWRAP_WACS2_RDATA] =		0xCA8,
 };
 
-static int mt7622_regs[] = {
+static const int mt7622_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -881,7 +881,7 @@ static int mt7622_regs[] = {
 	[PWRAP_SPI2_CTRL] =		0x244,
 };
 
-static int mt8135_regs[] = {
+static const int mt8135_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -954,7 +954,7 @@ static int mt8135_regs[] = {
 	[PWRAP_DCM_DBC_PRD] =		0x160,
 };
 
-static int mt8173_regs[] = {
+static const int mt8173_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -1036,7 +1036,7 @@ static int mt8173_regs[] = {
 	[PWRAP_DCM_DBC_PRD] =		0x148,
 };
 
-static int mt8183_regs[] = {
+static const int mt8183_regs[] = {
 	[PWRAP_MUX_SEL] =			0x0,
 	[PWRAP_WRAP_EN] =			0x4,
 	[PWRAP_DIO_EN] =			0x8,
@@ -1087,7 +1087,7 @@ static int mt8183_regs[] = {
 	[PWRAP_WACS2_VLDCLR] =			0xC28,
 };
 
-static int mt8195_regs[] = {
+static const int mt8195_regs[] = {
 	[PWRAP_INIT_DONE2] =		0x0,
 	[PWRAP_STAUPD_CTRL] =		0x4C,
 	[PWRAP_TIMER_EN] =		0x3E4,
@@ -1104,7 +1104,7 @@ static int mt8195_regs[] = {
 	[PWRAP_WACS2_RDATA] =		0x8A8,
 };
 
-static int mt8365_regs[] = {
+static const int mt8365_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -1166,7 +1166,7 @@ static int mt8365_regs[] = {
 	[PWRAP_WDT_SRC_EN_1] =		0xf8,
 };
 
-static int mt8516_regs[] = {
+static const int mt8516_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -1251,7 +1251,7 @@ static int mt8516_regs[] = {
 	[PWRAP_MSB_FIRST] =		0x170,
 };
 
-static int mt8186_regs[] = {
+static const int mt8186_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
 	[PWRAP_DIO_EN] =		0x8,
@@ -1377,7 +1377,7 @@ struct pmic_wrapper {
 };
 
 struct pmic_wrapper_type {
-	int *regs;
+	const int *regs;
 	enum pwrap_type type;
 	u32 arb_en_all;
 	u32 int_en_all;
-- 
2.45.2


