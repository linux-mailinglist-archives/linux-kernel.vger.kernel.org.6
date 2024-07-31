Return-Path: <linux-kernel+bounces-269733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D994363E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1DF8B24EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5691E16EC1A;
	Wed, 31 Jul 2024 19:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVQLLpUX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530115ADB3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453254; cv=none; b=mK7Xot1ILFuPQ2fkHPFQuBwzGDPWoh8t5PT+h1HF+4qdQ8BclQSr9W2WonGN1pI9QKym8ZtmkOxLAWO5p4WmBr2kZxe39ipj9EgobL2Apltzkkag3T91W/hB0JzC9oV/PtD4E/Hzd/7QzBh1pB3eGEv8suUEhn4zzcG1Xlguz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453254; c=relaxed/simple;
	bh=7sNRiOzAd2MCPSZ1MUoYwLG/nCzZTO+B5b5rwbOiuB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/toDip6nxsWRWY2dSwSMynWRmZ/QGulUczzDDaHHfHVvtPWXYpYlzBG1voW5CePZH38AM4joDtEQE7mgVmOYiY2+n10jLoBTGiIR3t+e38JPJpnh6KQaMWC/P93tJuKly2Kvg/9Cwo3No+FbA1H817YkrGQBhKTmvWNAK7Wfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVQLLpUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F57FC116B1;
	Wed, 31 Jul 2024 19:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453254;
	bh=7sNRiOzAd2MCPSZ1MUoYwLG/nCzZTO+B5b5rwbOiuB4=;
	h=From:To:Cc:Subject:Date:From;
	b=SVQLLpUXnk/F6T9Md2ec3kGYV5Tad4sju+a1BhPhH3pwf81L/FlNxFZ1CCw+oXGwR
	 U/aNd7LIHF9ThDzinlQuVL8GS49TO+8DED0SMmKoBV/7VkJ/0AU6nK+bv3r5YwrZyO
	 WmXJaOSS84KgX6HUEBXpxYNbW68OrTHuT/5JaHRTyv5WtkH2uYBjM54cgoTsWlWZ4q
	 dSXJS+J3TsXDQNBvMlNuOLFh6HTtrLlTH8PAJ3PBl4iuFgT/cg5T3TOtZvabPBrUch
	 OisvJ5mXtrkObm50bneA0Wa6FpgrT/BAzQJHLmOt0wtyzBc0ia6pbD25iLRKa9Cepx
	 sBEWc2CcYg1rg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] memory: emif: Use of_property_read_bool()
Date: Wed, 31 Jul 2024 13:12:59 -0600
Message-ID: <20240731191312.1710417-21-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_read_bool() to read boolean properties rather than
of_find_property(). This is part of a larger effort to remove callers
of of_find_property() and similar functions. of_find_property() leaks
the DT struct property and data pointers which is a problem for
dynamically allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/memory/emif.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 8c5ad5c025fa..974ed641473e 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -864,7 +864,7 @@ static void of_get_custom_configs(struct device_node *np_emif,
 						be32_to_cpup(poll_intvl);
 	}
 
-	if (of_find_property(np_emif, "extended-temp-part", &len))
+	if (of_property_read_bool(np_emif, "extended-temp-part"))
 		cust_cfgs->mask |= EMIF_CUSTOM_CONFIG_EXTENDED_TEMP_PART;
 
 	if (!is_custom_config_valid(cust_cfgs, emif->dev)) {
@@ -880,13 +880,9 @@ static void of_get_ddr_info(struct device_node *np_emif,
 		struct ddr_device_info *dev_info)
 {
 	u32 density = 0, io_width = 0;
-	int len;
 
-	if (of_find_property(np_emif, "cs1-used", &len))
-		dev_info->cs1_used = true;
-
-	if (of_find_property(np_emif, "cal-resistor-per-cs", &len))
-		dev_info->cal_resistors_per_cs = true;
+	dev_info->cs1_used = of_property_read_bool(np_emif, "cs1-used");
+	dev_info->cal_resistors_per_cs = of_property_read_bool(np_emif, "cal-resistor-per-cs");
 
 	if (of_device_is_compatible(np_ddr, "jedec,lpddr2-s4"))
 		dev_info->type = DDR_TYPE_LPDDR2_S4;
@@ -916,7 +912,6 @@ static struct emif_data *of_get_memory_device_details(
 	struct ddr_device_info		*dev_info = NULL;
 	struct emif_platform_data	*pd = NULL;
 	struct device_node		*np_ddr;
-	int				len;
 
 	np_ddr = of_parse_phandle(np_emif, "device-handle", 0);
 	if (!np_ddr)
@@ -944,7 +939,7 @@ static struct emif_data *of_get_memory_device_details(
 
 	of_property_read_u32(np_emif, "phy-type", &pd->phy_type);
 
-	if (of_find_property(np_emif, "hw-caps-ll-interface", &len))
+	if (of_property_read_bool(np_emif, "hw-caps-ll-interface"))
 		pd->hw_caps |= EMIF_HW_CAPS_LL_INTERFACE;
 
 	of_get_ddr_info(np_emif, np_ddr, dev_info);
-- 
2.43.0


