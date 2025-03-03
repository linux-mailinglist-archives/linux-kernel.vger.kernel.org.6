Return-Path: <linux-kernel+bounces-541933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2883BA4C38F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232B7188A4AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9383ECA5A;
	Mon,  3 Mar 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ljOeIPFo"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E812FF69
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012771; cv=none; b=MmeKWoYhOBiBFmiJy0B0goqn8DssuYnw9ybn/SyXbeT6DYHH0dzMx8nq/8bnQqW5X703aQvZhkBkdmfT6qNr7yepRj4XY/vgCffDxJwio4xke9/esKajY1aIU+K/g9TCmLllHmqmGshpRT14j2P3VYQDUJVOX7VuMgBlKLXhbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012771; c=relaxed/simple;
	bh=wuCxEcHiHWMbshLJqy+PE4V7Hlt/Y9N7pXTFmE39aXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY1j/dZx2P67WaWJ7EPT6t2nI9v892boIutnmNogFEqCwdgoPt8f+3CVK1/KAq93RiCjZ8C1Bo/ngb1HvwEa4JJu+iLv1VFvQDKQom4ltcPpGk+zQxnO6zCbHLKK0jmagc9p74/z/u2+0zuKEO8vom/M4JkTYPqjzi54uLf0xr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ljOeIPFo; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=zcWTq0+tIXCR7i1Bn8SpUwbeuy7hHsMrsLtvUfkNYic=; b=ljOeIPFoWhayaeSJ
	rHzpOtXpgkuRPEiKmG2zVC85wjomyNbcZ6lGe2Luo+7Vs5YvEcwxRqVn3fNs+ZJ048QDCVk7+g22f
	bvlZCLpvIaz19Atyeix5qtly+EMyojwJOzjHhe+gzVPNPPsvK3w7QHwE0c/fBu3Q7iwYLIQXVWp7z
	0KLfyg1j5o6Zrt1p5GBJ0r3x76+D/r8wRSWGJEZFaRSYxtcvVtMIm7U3RTwtDeGnYaEQUEf6PbpVe
	g7LjIQQ1uvnHNRfpSwXhfbs1Gx+Q/yGZoHUrxFdF7/tRdKv2nQzRpBPxp2r0cnn70NqZvnWLo0vjE
	rNw364LqKRK1RqZdlA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tp6x3-0028PG-0W;
	Mon, 03 Mar 2025 14:39:25 +0000
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
Subject: [PATCH 2/6] drm/amdgpu: Remove phm_powerdown_uvd
Date: Mon,  3 Mar 2025 14:39:18 +0000
Message-ID: <20250303143922.36342-3-linux@treblig.org>
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

phm_powerdown_uvd() has been unused since 2017's
commit 47047263c527 ("drm/amd/powerplay: delete eventmgr related files.")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   | 10 ----------
 drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index 90452b66e107..a59677cf8dfc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -149,16 +149,6 @@ int phm_apply_clock_adjust_rules(struct pp_hwmgr *hwmgr)
 	return 0;
 }
 
-int phm_powerdown_uvd(struct pp_hwmgr *hwmgr)
-{
-	PHM_FUNC_CHECK(hwmgr);
-
-	if (hwmgr->hwmgr_func->powerdown_uvd != NULL)
-		return hwmgr->hwmgr_func->powerdown_uvd(hwmgr);
-	return 0;
-}
-
-
 int phm_disable_clock_power_gatings(struct pp_hwmgr *hwmgr)
 {
 	PHM_FUNC_CHECK(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
index f4f9a104d170..915f1b8e4dba 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
@@ -396,7 +396,6 @@ struct phm_odn_clock_levels {
 };
 
 extern int phm_disable_clock_power_gatings(struct pp_hwmgr *hwmgr);
-extern int phm_powerdown_uvd(struct pp_hwmgr *hwmgr);
 extern int phm_setup_asic(struct pp_hwmgr *hwmgr);
 extern int phm_enable_dynamic_state_management(struct pp_hwmgr *hwmgr);
 extern int phm_disable_dynamic_state_management(struct pp_hwmgr *hwmgr);
-- 
2.48.1


