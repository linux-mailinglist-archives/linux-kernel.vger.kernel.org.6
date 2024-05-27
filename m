Return-Path: <linux-kernel+bounces-191460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D698D0F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52D22838FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83AE16A37C;
	Mon, 27 May 2024 21:28:03 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5407161306
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845283; cv=none; b=J86aRDzQGiebnBT+8Tryvx8bztKBxIrwvWCyTUsaRsst22cqbYjAHjnbOnkIu6CwxW37lt66ra+0BQKBH1WjUAGz6ON22aid38HEVKUfbOStXiFf97ke5RAvjUQMAZNGWa6vB62IwuZzuQ0P7tOvEzarVi9mz+wtZ/zOXUeO/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845283; c=relaxed/simple;
	bh=FrmTkfRDuYE6W4f7/PX+9pEDuWfj94rVrXbxlYtzyFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQFcEqgGehmQrkU88yZK9dn76SBL+sO7I24RwQZYa/eP4HZ+jVs8UyT7kmQeMwNhaDAnOYFw7Ko8GySeXFr5DxMEZ99MFO9JGqXjFUNIkHJw1gPlmHq6wMIDbp0BhhCOuSGMpc05MttKHE8YpGIANwKxv0ov0rRWvNC7FU5VVxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id fc9d09c8-1c6f-11ef-8e2a-005056bdf889;
	Tue, 28 May 2024 00:27:57 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 10/11] pinctrl: mediatek: Convert to use func member
Date: Tue, 28 May 2024 00:24:45 +0300
Message-ID: <20240527212742.1432960-11-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527212742.1432960-1-andy.shevchenko@gmail.com>
References: <20240527212742.1432960-1-andy.shevchenko@gmail.com>
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
 drivers/pinctrl/mediatek/pinctrl-moore.c | 10 +++++-----
 drivers/pinctrl/mediatek/pinctrl-moore.h |  4 +---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index d972584c0519..aad4891223d3 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -56,7 +56,7 @@ static int mtk_pinmux_set_mux(struct pinctrl_dev *pctldev,
 		return -EINVAL;
 
 	dev_dbg(pctldev->dev, "enable function %s group %s\n",
-		func->name, grp->grp.name);
+		func->func.name, grp->grp.name);
 
 	for (i = 0; i < grp->grp.npins; i++) {
 		const struct mtk_pin_desc *desc;
@@ -620,12 +620,12 @@ static int mtk_build_functions(struct mtk_pinctrl *hw)
 	int i, err;
 
 	for (i = 0; i < hw->soc->nfuncs ; i++) {
-		const struct function_desc *func = hw->soc->funcs + i;
+		const struct function_desc *function = hw->soc->funcs + i;
+		const struct pinfunction *func = &function->func;
 
 		err = pinmux_generic_add_function(hw->pctrl, func->name,
-						  func->group_names,
-						  func->num_group_names,
-						  func->data);
+						  func->groups, func->ngroups,
+						  function->data);
 		if (err < 0) {
 			dev_err(hw->dev, "Failed to register function %s\n",
 				func->name);
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.h b/drivers/pinctrl/mediatek/pinctrl-moore.h
index 5945e4fe021f..229d19561e22 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.h
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.h
@@ -45,9 +45,7 @@
 
 #define PINCTRL_PIN_FUNCTION(_name_, id)							\
 	{											\
-		.name = _name_,									\
-		.group_names = id##_groups,							\
-		.num_group_names = ARRAY_SIZE(id##_groups),					\
+		.func = PINCTRL_PINFUNCTION(_name_, id##_groups, ARRAY_SIZE(id##_groups)),	\
 		.data = NULL,									\
 	}
 
-- 
2.45.1


