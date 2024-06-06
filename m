Return-Path: <linux-kernel+bounces-204042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5BD8FE349
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DE61C262CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A113E3FF;
	Thu,  6 Jun 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oynOZHFf"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D11527AA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667070; cv=none; b=jJOrSFwkM51r3ATZcYzW1gJd2wKH5QOi1YJZlfWOD0pNxQxOO29r14mYG6jwLEy1FwokUu9RucbVbxYdecz2L+i7Xb2X9cXnk3dUkPA5LENkSkFSDynkV1u7ApEZoGsARhW43MVZPhcdMzQ9FPBWW/WBqnPe4PzqLrqJcE3bHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667070; c=relaxed/simple;
	bh=Pj3Bnmqstms8fZSSC1sofjL8XbwRm80mDXfwIAZA8e8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=as/L9kUyKuYsqmxAmRWD84m+VVVV8ozDPMhI4mA+GZ/vZhkitMNtrP2Nq3b+p/U9pkn0aQpWzJfgtuLz09LrVYDbvKgHidkw3eZhCxBFFYMnY/BL60ePmmXj4QS5GVJHusQQwynaFL9qQ9wLPFiLUTUO0w6rDSWfuY0rIGCfwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oynOZHFf; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717667064; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SSDpadhDayKYDhxfcnPmHvLUUqjwwCKH0DV0DmvwUWk=;
	b=oynOZHFfRtC0kEcoq0VXSQ/yrkDWddzjp6jXmKEFaWiJiRtCLKXaTziyXl/NQqNWRWUo+aqktZ3CGZr2hXGc/ui0h2D8Y7XE5d7YduF5DxMWO4ae/+BMjzFILrf3ng6gb7VADmP8rY3MEsJKsDuVPcBIVYsHwdlE+VinON8O6I0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7xs-ya_1717667055;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W7xs-ya_1717667055)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 17:44:24 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: alexander.deucher@amd.com
Cc: christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: clean up some inconsistent indenting
Date: Thu,  6 Jun 2024 17:44:14 +0800
Message-Id: <20240606094414.703-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c:529 dcn32_auto_dpm_test_log() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9294
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index ff5fdc7b1198..7300e793d506 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -525,25 +525,23 @@ static void dcn32_auto_dpm_test_log(
 
 	mall_ss_size_bytes = context->bw_ctx.bw.dcn.mall_ss_size_bytes;
 
-    dispclk_khz_reg    = REG_READ(CLK1_CLK0_CURRENT_CNT); // DISPCLK
-    dppclk_khz_reg     = REG_READ(CLK1_CLK1_CURRENT_CNT); // DPPCLK
-    dprefclk_khz_reg   = REG_READ(CLK1_CLK2_CURRENT_CNT); // DPREFCLK
-    dcfclk_khz_reg     = REG_READ(CLK1_CLK3_CURRENT_CNT); // DCFCLK
-    dtbclk_khz_reg     = REG_READ(CLK1_CLK4_CURRENT_CNT); // DTBCLK
-    fclk_khz_reg       = REG_READ(CLK4_CLK0_CURRENT_CNT); // FCLK
-
-    // Overrides for these clocks in case there is no p_state change support
-    dramclk_khz_override = new_clocks->dramclk_khz;
-    fclk_khz_override = new_clocks->fclk_khz;
-
-    num_fclk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_fclk_levels - 1;
-
-    if (!new_clocks->p_state_change_support) {
-	    dramclk_khz_override = clk_mgr->base.bw_params->max_memclk_mhz * 1000;
-    }
-    if (!new_clocks->fclk_p_state_change_support) {
-	    fclk_khz_override = clk_mgr->base.bw_params->clk_table.entries[num_fclk_levels].fclk_mhz * 1000;
-    }
+	dispclk_khz_reg    = REG_READ(CLK1_CLK0_CURRENT_CNT); // DISPCLK
+	dppclk_khz_reg     = REG_READ(CLK1_CLK1_CURRENT_CNT); // DPPCLK
+	dprefclk_khz_reg   = REG_READ(CLK1_CLK2_CURRENT_CNT); // DPREFCLK
+	dcfclk_khz_reg     = REG_READ(CLK1_CLK3_CURRENT_CNT); // DCFCLK
+	dtbclk_khz_reg     = REG_READ(CLK1_CLK4_CURRENT_CNT); // DTBCLK
+	fclk_khz_reg       = REG_READ(CLK4_CLK0_CURRENT_CNT); // FCLK
+
+	// Overrides for these clocks in case there is no p_state change support
+	dramclk_khz_override = new_clocks->dramclk_khz;
+	fclk_khz_override = new_clocks->fclk_khz;
+
+	num_fclk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_fclk_levels - 1;
+
+	if (!new_clocks->p_state_change_support)
+		dramclk_khz_override = clk_mgr->base.bw_params->max_memclk_mhz * 1000;
+	if (!new_clocks->fclk_p_state_change_support)
+		fclk_khz_override = clk_mgr->base.bw_params->clk_table.entries[num_fclk_levels].fclk_mhz * 1000;
 
 	////////////////////////////////////////////////////////////////////////////
 	//	IMPORTANT: 	When adding more clocks to these logs, do NOT put a newline
-- 
2.20.1.7.g153144c


