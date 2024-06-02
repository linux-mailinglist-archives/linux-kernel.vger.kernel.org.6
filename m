Return-Path: <linux-kernel+bounces-198287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77C8D762D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46941B217A4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1E041C92;
	Sun,  2 Jun 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIWxWhRz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5343ABD
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717338074; cv=none; b=ZlyG9WR1xl7hKF3y80oh/6+bVKkNaUo7SCVAjfIvUiK3l9jrAoZOAnyxkD81YiqAYVAO6gPrLeBXYkeFYwI0EFaAqbvOqAHH5HMxNks/NyGDnPjTUcfTt8GT7bs3p/BjO41yqzN9ByOaZ/Jxx2qU80m8nGPHirwWSTp6+OE4yqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717338074; c=relaxed/simple;
	bh=oadUV7GI47XB1/5yBXbfmigyApPprinWQqP+x7Kl/Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lktXqJYXNfxLLxFqqJvASL0bTW7Zn2CP85535bawcM4BkY43PYZ3U9IXG7sf6hrOvwr8N0fu+142JdMfFu6y04s/Mk+kd1zNNdZmeWk5W6Yhnx3KsCAdWY5TBwUsRCdOABeEs0CecrDytjGMKgyRCvo71gggk1D4SgnpYGcef1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIWxWhRz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717338073; x=1748874073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oadUV7GI47XB1/5yBXbfmigyApPprinWQqP+x7Kl/Hk=;
  b=MIWxWhRzhdvTuAaxFgyQlBoZxSuaUyXybfEtL1+OFJzWzJEcbjSo6La4
   sd0ExKruzrCfAzcFmsHumPYLpazURjETka0Dxn3MsNO0+0UTaoYpLAZXx
   Elm8NWZFznb9wznY0/9LodGm+V0vmrqSLyUyr3JZxB26aypVi0ZYcC3CW
   3um8TQ+4yFMUBNlspGoZmmvD9JEAGLKgMqRykt0p4wzyVbcDIrRScMAOJ
   QjGAwQ3ue+AK8wcOrz6QToRDM3ypZqG5J+VB7kZMJaeyfNyaX1MWzTY1V
   mM60y7Xc6SbyOcOt4ppCNXLG0eTIjAv9LnqWGMAAn7EXEypQdMOxtZWmo
   A==;
X-CSE-ConnectionGUID: dJr8wl1wS1q2ROpxX4t9sg==
X-CSE-MsgGUID: MpRVUxDOTBmf6l42hau10A==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25238383"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="25238383"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 07:21:12 -0700
X-CSE-ConnectionGUID: x7cBwlDkQniQF7ZWg474Ag==
X-CSE-MsgGUID: 9l107NcSSH+Iotuu6PVigA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="59808440"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 02 Jun 2024 07:21:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EF6921CB; Sun, 02 Jun 2024 17:21:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Lewis Huang <lewis.huang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/amd/display: Fix too big frame size
Date: Sun,  2 Jun 2024 17:21:03 +0300
Message-ID: <20240602142103.3259613-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compilation fails on arm with:

  link_factory.c:743:1: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Fix the frame size by allocation one of the big structures.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../gpu/drm/amd/display/dc/link/link_factory.c    | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index cf22b8f28ba6..78f1b2102839 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -456,10 +456,10 @@ static bool construct_phy(struct dc_link *link,
 	struct dc_context *dc_ctx = init_params->ctx;
 	struct encoder_init_data enc_init_data = { 0 };
 	struct panel_cntl_init_data panel_cntl_init_data = { 0 };
-	struct integrated_info info = { 0 };
 	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
 	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
+	struct integrated_info *info;
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
@@ -672,12 +672,16 @@ static bool construct_phy(struct dc_link *link,
 	}
 
 	if (bios->integrated_info)
-		info = *bios->integrated_info;
+		info = kmemdup(bios->integrated_info, sizeof(*info), GFP_KERNEL);
+	else
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		goto device_tag_fail;
 
 	/* Look for channel mapping corresponding to connector and device tag */
 	for (i = 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {
 		struct external_display_path *path =
-			&info.ext_disp_conn_info.path[i];
+			&info->ext_disp_conn_info.path[i];
 
 		if (path->device_connector_id.enum_id == link->link_id.enum_id &&
 		    path->device_connector_id.id == link->link_id.id &&
@@ -698,14 +702,15 @@ static bool construct_phy(struct dc_link *link,
 
 			if (link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) {
 				link->bios_forced_drive_settings.VOLTAGE_SWING =
-						(info.ext_disp_conn_info.fixdpvoltageswing & 0x3);
+						info->ext_disp_conn_info.fixdpvoltageswing & 0x3;
 				link->bios_forced_drive_settings.PRE_EMPHASIS =
-						((info.ext_disp_conn_info.fixdpvoltageswing >> 2) & 0x3);
+						(info->ext_disp_conn_info.fixdpvoltageswing >> 2) & 0x3;
 			}
 
 			break;
 		}
 	}
+	kfree(info);
 
 	if (bios->funcs->get_atom_dc_golden_table)
 		bios->funcs->get_atom_dc_golden_table(bios);
-- 
2.43.0.rc1.1336.g36b5255a03ac


