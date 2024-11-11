Return-Path: <linux-kernel+bounces-403876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C97B9C3C28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69BB1F22239
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494F915B554;
	Mon, 11 Nov 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKHBPUQe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935B183CA2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321440; cv=none; b=UkrDzJKmeO+5nmEBKZ3ntNyX19bihMvrozQaV5z5kRvLE/GxlV+Oh2c1OF8kyJGMFug5vHX6U9I/2V1HO+aTzCmFsQljd6J/N7+2WQJthoPcXIDJXFyfYoJUy0mABjLhH1YpPAK1Jz275+kP4yH1RvCOqoks8TO1zw5mycqETSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321440; c=relaxed/simple;
	bh=jNP3EEmQCRYGu8RVX1ba7R/suetM+TihlMSotd59zHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=neipiVkaG/YMrm8yleNNAeEgioSQnNBYnbSweP1b9M6W7Qg0lJ5EP/Ytr91DS8PPPrgm9tlrH1RqVLy5KbtSGiQidd78u3/AuhqLdVhfyEtWmRVwIexx+5Hlc95PP+xVyMZdZy8TAFxXpQb41p3azta6jdnQvvlkC3YtR/AnUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKHBPUQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86C0C4CED5;
	Mon, 11 Nov 2024 10:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731321438;
	bh=jNP3EEmQCRYGu8RVX1ba7R/suetM+TihlMSotd59zHY=;
	h=From:To:Cc:Subject:Date:From;
	b=jKHBPUQefIWzQGovAC+9QQCjuqX7+leHBXJqOsNjgQVSuF6OiCpOvaHlnDumrDreH
	 l2Sk+t9JTwk7SoJJPguosMtJAkKG6CDeAekLy7lKKSH2wryDDqNbimLwO//CQB4Idx
	 a77AcUqMxzLlJSEA78CqGMWrwmOnNSo2qQXNOpky4nQnB1cKdvGWtidhTnv/2C8ocF
	 f8Rh98ltcCqJBU8Xgvj74dIudRl4SRHRVdVGkf0eW34ixl/xgPLdeqpFll9FUIxJwK
	 dZICPzDmfB4A46avMMOYb0Li9M5siGskf591O0h/7RUw/2jPKHmj9YjdUcjhENPNE1
	 C5GEMWT8gvBKw==
From: Arnd Bergmann <arnd@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Yang Li <yang.lee@linux.alibaba.com>,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: stm32: work around constant-value overflow assertion
Date: Mon, 11 Nov 2024 11:37:02 +0100
Message-Id: <20241111103712.3520611-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

FIELD_PREP() checks that a constant fits into the available bitfield,
but if one of the two lookup tables in stm32_impedance_tune() does
not find a matching entry, the index is out of range, which gcc
correctly complains about:

In file included from <command-line>:
In function 'stm32_impedance_tune',
    inlined from 'stm32_combophy_pll_init' at drivers/phy/st/phy-stm32-combophy.c:247:9:
include/linux/compiler_types.h:517:38: error: call to '__compiletime_assert_447' declared with attribute error: FIELD_PREP: value too large for the field
  517 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   68 |   BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
  115 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
      |   ^~~~~~~~~~~~~~~~
drivers/phy/st/phy-stm32-combophy.c:162:8: note: in expansion of macro 'FIELD_PREP'
  162 |        FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_VSWING, vswing_of));
      |        ^~~~~~~~~~

Rework this so the field value gets set inside of the loop and otherwise
set to zero.

Fixes: 47e1bb6b4ba0 ("phy: stm32: Add support for STM32MP25 COMBOPHY.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/st/phy-stm32-combophy.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-combophy.c b/drivers/phy/st/phy-stm32-combophy.c
index 765bb34fe358..49e9fa90a681 100644
--- a/drivers/phy/st/phy-stm32-combophy.c
+++ b/drivers/phy/st/phy-stm32-combophy.c
@@ -122,6 +122,7 @@ static int stm32_impedance_tune(struct stm32_combophy *combophy)
 	u32 max_vswing = imp_lookup[imp_size - 1].vswing[vswing_size - 1];
 	u32 min_vswing = imp_lookup[0].vswing[0];
 	u32 val;
+	u32 regval;
 
 	if (!of_property_read_u32(combophy->dev->of_node, "st,output-micro-ohms", &val)) {
 		if (val < min_imp || val > max_imp) {
@@ -129,16 +130,20 @@ static int stm32_impedance_tune(struct stm32_combophy *combophy)
 			return -EINVAL;
 		}
 
-		for (imp_of = 0; imp_of < ARRAY_SIZE(imp_lookup); imp_of++)
-			if (imp_lookup[imp_of].microohm <= val)
+		regval = 0;
+		for (imp_of = 0; imp_of < ARRAY_SIZE(imp_lookup); imp_of++) {
+			if (imp_lookup[imp_of].microohm <= val) {
+				regval = FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_OHM, imp_of);
 				break;
+			}
+		}
 
 		dev_dbg(combophy->dev, "Set %u micro-ohms output impedance\n",
 			imp_lookup[imp_of].microohm);
 
 		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
 				   STM32MP25_PCIEPRG_IMPCTRL_OHM,
-				   FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_OHM, imp_of));
+				   regval);
 	} else {
 		regmap_read(combophy->regmap, SYSCFG_PCIEPRGCR, &val);
 		imp_of = FIELD_GET(STM32MP25_PCIEPRG_IMPCTRL_OHM, val);
@@ -150,16 +155,20 @@ static int stm32_impedance_tune(struct stm32_combophy *combophy)
 			return -EINVAL;
 		}
 
-		for (vswing_of = 0; vswing_of < ARRAY_SIZE(imp_lookup[imp_of].vswing); vswing_of++)
-			if (imp_lookup[imp_of].vswing[vswing_of] >= val)
+		regval = 0;
+		for (vswing_of = 0; vswing_of < ARRAY_SIZE(imp_lookup[imp_of].vswing); vswing_of++) {
+			if (imp_lookup[imp_of].vswing[vswing_of] >= val) {
+				regval = FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_VSWING, vswing_of);
 				break;
+			}
+		}
 
 		dev_dbg(combophy->dev, "Set %u microvolt swing\n",
 			 imp_lookup[imp_of].vswing[vswing_of]);
 
 		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
 				   STM32MP25_PCIEPRG_IMPCTRL_VSWING,
-				   FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_VSWING, vswing_of));
+				   regval);
 	}
 
 	return 0;
-- 
2.39.5


