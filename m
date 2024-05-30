Return-Path: <linux-kernel+bounces-195122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BE78D47E9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5781F24681
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AEF1850B8;
	Thu, 30 May 2024 08:58:40 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9E18508F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059520; cv=none; b=LkGKIHkUfNFIRh54s24YbtX6G8bklPGaVp/VOedKcPzmgiLj32gtxBbIen2znErwWjU1sVDvyF9BZWg9vJtxrRax06P2yzQHW8wrePqi/r8VCHVfmxmZ7UkEvwrE44QZCkCti/p+uFM9IHCdxExhfNz5umFIL4yYt2DGfoAxoc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059520; c=relaxed/simple;
	bh=/LiSEQG+njMYAteIWAP1DID2MkGU7RNK5JsYIWD5POA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cV/C9dUNFaC2alJvPK2BLsgLkvcf3l/yduIUS6D4Pln7pO3+So6HcR/1iNWnjf9NyligRKt9OUPxc8rdgYJouV1G3biKpAlNHS1umS2g2iRtHHakiFBM6/GOJMyKf2OI1+/ZYh5c5TDaV5hRPp5qj3b+4PeiAcOe+GFkJf3Lnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id cc94fb57-1e62-11ef-8e2e-005056bdf889;
	Thu, 30 May 2024 11:58:36 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-mips@vger.kernel.org
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 09/11] pinctrl: keembay: Convert to use func member
Date: Thu, 30 May 2024 11:55:18 +0300
Message-ID: <20240530085745.1539925-10-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530085745.1539925-1-andy.shevchenko@gmail.com>
References: <20240530085745.1539925-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert drivers to use func member embedded in struct function_desc,
because other members will be removed to avoid duplication and
desynchronisation of the generic pin function description.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/pinctrl/pinctrl-keembay.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-keembay.c b/drivers/pinctrl/pinctrl-keembay.c
index b1349ee22799..245a74ed97ee 100644
--- a/drivers/pinctrl/pinctrl-keembay.c
+++ b/drivers/pinctrl/pinctrl-keembay.c
@@ -1566,7 +1566,7 @@ static int keembay_add_functions(struct keembay_pinctrl *kpc,
 		unsigned int grp_idx = 0;
 		int j;
 
-		group_names = devm_kcalloc(kpc->dev, func->num_group_names,
+		group_names = devm_kcalloc(kpc->dev, func->func.ngroups,
 					   sizeof(*group_names), GFP_KERNEL);
 		if (!group_names)
 			return -ENOMEM;
@@ -1576,20 +1576,20 @@ static int keembay_add_functions(struct keembay_pinctrl *kpc,
 			struct keembay_mux_desc *mux;
 
 			for (mux = pdesc->drv_data; mux->name; mux++) {
-				if (!strcmp(mux->name, func->name))
+				if (!strcmp(mux->name, func->func.name))
 					group_names[grp_idx++] = pdesc->name;
 			}
 		}
 
-		func->group_names = group_names;
+		func->func.groups = group_names;
 	}
 
 	/* Add all functions */
 	for (i = 0; i < kpc->nfuncs; i++) {
 		pinmux_generic_add_function(kpc->pctrl,
-					    functions[i].name,
-					    functions[i].group_names,
-					    functions[i].num_group_names,
+					    functions[i].func.name,
+					    functions[i].func.groups,
+					    functions[i].func.ngroups,
 					    functions[i].data);
 	}
 
@@ -1619,17 +1619,17 @@ static int keembay_build_functions(struct keembay_pinctrl *kpc)
 			struct function_desc *fdesc;
 
 			/* Check if we already have function for this mux */
-			for (fdesc = keembay_funcs; fdesc->name; fdesc++) {
-				if (!strcmp(mux->name, fdesc->name)) {
-					fdesc->num_group_names++;
+			for (fdesc = keembay_funcs; fdesc->func.name; fdesc++) {
+				if (!strcmp(mux->name, fdesc->func.name)) {
+					fdesc->func.ngroups++;
 					break;
 				}
 			}
 
 			/* Setup new function for this mux we didn't see before */
 			if (!fdesc->name) {
-				fdesc->name = mux->name;
-				fdesc->num_group_names = 1;
+				fdesc->func.name = mux->name;
+				fdesc->func.ngroups = 1;
 				fdesc->data = &mux->mode;
 				kpc->nfuncs++;
 			}
-- 
2.45.1


