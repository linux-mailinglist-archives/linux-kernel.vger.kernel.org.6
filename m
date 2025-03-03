Return-Path: <linux-kernel+bounces-541940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B88DFA4C39D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46AE416F2D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7A6214A98;
	Mon,  3 Mar 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="LaFLFzVF"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDDB214A78
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012786; cv=none; b=YPzXonI/XvoOOjiNAwx/TkXdzz4MJKLZqCxXSa4Tj4zk02wFzIqdcPhH4vf1beQ/tvA/YeW2XJjZQei1lOdWswPGhOPSFpFFFZvXvgby7CE76/q56v4PwoybvJBecpzlxDNPEbf3RkyRI76wfHw2UWKxhwk0gJXGpUinXyj577s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012786; c=relaxed/simple;
	bh=bDltFn72XGX7/YGKM/jJc61Zk89Uap7Gcrzn0no2Mj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC7/5WbnwkIZ79+NYZo0uuOS0mvK2/JTyPkczamXGqbUAc1LS2+r1l/ABWBzc0KT46pVjb9MQtGWdmfY2uY7p+FiWh+6xAv0wE4AWL9kQ3cUh5DiZXm+kwrBs6PhLvHfr3inxF286G+f7M3++9UvO+2GgXjyu+6wDLu+z0h4ihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=LaFLFzVF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=NCcGpHSW32vENYyHk+1Go1rb3MBFVM15qU2VwPxGLTQ=; b=LaFLFzVFca63tNHt
	MFHhSQTdHARen5gH5yOeqOLa3VG6YqaBHlCXpqlPLlpoxWXOSIn8kbhLof3VXLRZvdmv+8gQyk4rm
	8Cc6AoVCi442tCpUZDIaJYcRReofzgvKEJUPyOL84WCBPmzUGmac9QPMCKp5tiiw87PmNiXtZ/J65
	AYiuxY5I5LdHPZmDoUTtaIplSoP9xF5ToT7bZHRYsXIqC1XHTnW3eFgADE9VLPx6ODx+CLZ9jldM1
	QhT3LP6VBaYQcPqsXL2kjaqpF4E1dt6tiZikN4RcJ3XEgZFdFwBdY/CSI4sSzTMbRSBsBJLERL68b
	+nunWdvbPnbLp6Px9g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tp6x2-0028PG-19;
	Mon, 03 Mar 2025 14:39:24 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	austin.zheng@amd.com,
	jun.lei@amd.com,
	kenneth.feng@amd.com,
	linux-kernel@vger.kernel.org
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/6] drm/amdgpu: Remove ppatomfwctrl deadcode
Date: Mon,  3 Mar 2025 14:39:17 +0000
Message-ID: <20250303143922.36342-2-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303143922.36342-1-linux@treblig.org>
References: <20250303143922.36342-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

pp_atomfwctrl_get_pp_assign_pin() and pp_atomfwctrl_get_pp_assign_pin()
were added in 2017 by
commit 0d2c7569e196 ("drm/amdgpu: add new atomfirmware based helpers for
powerplay")
but have remained unused.

Remove them, and the helper functions they used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c | 78 -------------------
 .../drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h |  3 -
 2 files changed, 81 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
index 82d540334318..6120f14caab0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
@@ -158,84 +158,6 @@ int pp_atomfwctrl_get_voltage_table_v4(struct pp_hwmgr *hwmgr,
 	return result;
 }
 
- 
-static struct atom_gpio_pin_lut_v2_1 *pp_atomfwctrl_get_gpio_lookup_table(
-		struct pp_hwmgr *hwmgr)
-{
-	const void *table_address;
-	uint16_t idx;
-
-	idx = GetIndexIntoMasterDataTable(gpio_pin_lut);
-	table_address =	smu_atom_get_data_table(hwmgr->adev,
-			idx, NULL, NULL, NULL);
-	PP_ASSERT_WITH_CODE(table_address,
-			"Error retrieving BIOS Table Address!",
-			return NULL);
-
-	return (struct atom_gpio_pin_lut_v2_1 *)table_address;
-}
-
-static bool pp_atomfwctrl_lookup_gpio_pin(
-		struct atom_gpio_pin_lut_v2_1 *gpio_lookup_table,
-		const uint32_t pin_id,
-		struct pp_atomfwctrl_gpio_pin_assignment *gpio_pin_assignment)
-{
-	unsigned int size = le16_to_cpu(
-			gpio_lookup_table->table_header.structuresize);
-	unsigned int offset =
-			offsetof(struct atom_gpio_pin_lut_v2_1, gpio_pin[0]);
-	unsigned long start = (unsigned long)gpio_lookup_table;
-
-	while (offset < size) {
-		const struct  atom_gpio_pin_assignment *pin_assignment =
-				(const struct  atom_gpio_pin_assignment *)(start + offset);
-
-		if (pin_id == pin_assignment->gpio_id)  {
-			gpio_pin_assignment->uc_gpio_pin_bit_shift =
-					pin_assignment->gpio_bitshift;
-			gpio_pin_assignment->us_gpio_pin_aindex =
-					le16_to_cpu(pin_assignment->data_a_reg_index);
-			return true;
-		}
-		offset += offsetof(struct atom_gpio_pin_assignment, gpio_id) + 1;
-	}
-	return false;
-}
-
-/*
- * Returns TRUE if the given pin id find in lookup table.
- */
-bool pp_atomfwctrl_get_pp_assign_pin(struct pp_hwmgr *hwmgr,
-		const uint32_t pin_id,
-		struct pp_atomfwctrl_gpio_pin_assignment *gpio_pin_assignment)
-{
-	bool ret = false;
-	struct atom_gpio_pin_lut_v2_1 *gpio_lookup_table =
-			pp_atomfwctrl_get_gpio_lookup_table(hwmgr);
-
-	/* If we cannot find the table do NOT try to control this voltage. */
-	PP_ASSERT_WITH_CODE(gpio_lookup_table,
-			"Could not find GPIO lookup Table in BIOS.",
-			return false);
-
-	ret = pp_atomfwctrl_lookup_gpio_pin(gpio_lookup_table,
-			pin_id, gpio_pin_assignment);
-
-	return ret;
-}
-
-/*
- * Enter to SelfRefresh mode.
- * @param hwmgr
- */
-int pp_atomfwctrl_enter_self_refresh(struct pp_hwmgr *hwmgr)
-{
-	/* 0 - no action
-	 * 1 - leave power to video memory always on
-	 */
-	return 0;
-}
-
 /** pp_atomfwctrl_get_gpu_pll_dividers_vega10().
  *
  * @param hwmgr       input parameter: pointer to HwMgr
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
index e86e05c786d9..0d62903d5676 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
@@ -217,9 +217,6 @@ struct pp_atomfwctrl_smc_dpm_parameters {
 int pp_atomfwctrl_get_gpu_pll_dividers_vega10(struct pp_hwmgr *hwmgr,
 		uint32_t clock_type, uint32_t clock_value,
 		struct pp_atomfwctrl_clock_dividers_soc15 *dividers);
-int pp_atomfwctrl_enter_self_refresh(struct pp_hwmgr *hwmgr);
-bool pp_atomfwctrl_get_pp_assign_pin(struct pp_hwmgr *hwmgr, const uint32_t pin_id,
-		struct pp_atomfwctrl_gpio_pin_assignment *gpio_pin_assignment);
 
 int pp_atomfwctrl_get_voltage_table_v4(struct pp_hwmgr *hwmgr, uint8_t voltage_type,
 		uint8_t voltage_mode, struct pp_atomfwctrl_voltage_table *voltage_table);
-- 
2.48.1


