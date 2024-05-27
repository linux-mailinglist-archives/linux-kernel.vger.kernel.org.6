Return-Path: <linux-kernel+bounces-191455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD358D0F80
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E09B1C21C14
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18026169370;
	Mon, 27 May 2024 21:28:00 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90394168C11
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845279; cv=none; b=LVLrasodiDaBfI6wJMLb0pRFxBduarTEBnm9KiMcvr6l23K9pL/nVRZcU7W/nbKfv5yKt0cTwz2ShMN54eTTl9QGiGSopp05EuAQDJq6FspW0dCBRmXYdbUsm1ae9085i8VD3v5BQYtfjLdnAKp6erAKDTUiOBiyPHc9/Zc4ihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845279; c=relaxed/simple;
	bh=Ipd1r706hFJdBLXw3qskh6dO0fzpcVigdcqkKJK4BV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcXMtXVYgqRd3gIjxuJyAe6Wmezu4y0hpObx13G4iiQDmw3IsQK9clr1DVZcFS5Drh/0xqOwOBGRJ/awBvDTrhuEGqUdelk3fLXHDE2sEesU/feWRTOUVxkEzjmu7yAA49xc/03KYM7Es9KFHDmSsjQ2p4cRPvwzhteqP+ZZcN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id fae89320-1c6f-11ef-8e2a-005056bdf889;
	Tue, 28 May 2024 00:27:55 +0300 (EEST)
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
Subject: [PATCH v1 07/11] pinctrl: imx: Convert to use func member
Date: Tue, 28 May 2024 00:24:42 +0300
Message-ID: <20240527212742.1432960-8-andy.shevchenko@gmail.com>
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
 drivers/pinctrl/freescale/pinctrl-imx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 2d3d80921c0d..44921e3bdb94 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -266,7 +266,7 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 	npins = grp->grp.npins;
 
 	dev_dbg(ipctl->dev, "enable function %s group %s\n",
-		func->name, grp->grp.name);
+		func->func.name, grp->grp.name);
 
 	for (i = 0; i < npins; i++) {
 		/*
@@ -593,21 +593,21 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 		return -EINVAL;
 
 	/* Initialise function */
-	func->name = np->name;
-	func->num_group_names = of_get_child_count(np);
-	if (func->num_group_names == 0) {
+	func->func.name = np->name;
+	func->func.ngroups = of_get_child_count(np);
+	if (func->func.ngroups == 0) {
 		dev_info(ipctl->dev, "no groups defined in %pOF\n", np);
 		return -EINVAL;
 	}
 
-	group_names = devm_kcalloc(ipctl->dev, func->num_group_names,
-				   sizeof(char *), GFP_KERNEL);
+	group_names = devm_kcalloc(ipctl->dev, func->ngroups, sizeof(*func->func.groups),
+				   GFP_KERNEL);
 	if (!group_names)
 		return -ENOMEM;
 	i = 0;
 	for_each_child_of_node(np, child)
 		group_names[i++] = child->name;
-	func->group_names = group_names;
+	func->func.groups = group_names;
 
 	i = 0;
 	for_each_child_of_node(np, child) {
-- 
2.45.1


