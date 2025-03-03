Return-Path: <linux-kernel+bounces-541935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 042BCA4C396
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E297F18879CE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DEF213E8B;
	Mon,  3 Mar 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DXWP884M"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745C212D66
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012772; cv=none; b=NzD4D3nGFQZcmW0ij3RVqnuh/JzbN/x//gdVKw5z6NAOPpOo0kcE25IsHJQs+gyXKMuFDi7hJcNBOkc/tKAW6YPzZgbXVuBQS3tT4uPxbf68TaZnCUepq8QJK2lwboP0eAJeMPsdyW8ILfflP4tsDCw/zqSMBql41iF8vu5MicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012772; c=relaxed/simple;
	bh=5mpCI9pZ8PWgc2rvH58GV05R+qnTGASobuPPyYIZp/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2bIp9PpDNnde/aGkdw101xPXHsiJOYV5JWkv/CtVNrQA9wBWoiTm2mvf43Xree1Bofuambsxa4H5wdWt4uVSwPbpCuA3KxJuxpiPTJuoPvHsCs0Wn6u2cHQlXyH7DzpGLdw4FcY4mUZtVY+EsJr/h4e0U39qu110wF8aBA3cA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DXWP884M; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=qbdK8IAgZW0guOrlqWaSI9e2yk+YFc7AzO9kJtOtkKA=; b=DXWP884ME7zSWaQT
	ibmvA8hYDJxaTuupNJ+p4U6szKySOsv8IY/tLkUC4NNAfnnlS4DUfv0kUo5/57G6BKSF9h27c+6Ba
	zALa8HLisBxxoUUCVHJiOr4Wn9q6kOBqXvVdYfL1vUXOjSk7cRPm8vHN08kc10v9trS5EK+O7H8pA
	VrquZOAwMigcKYPosfSojg1jOiEboldREKyzyg0kxRvFZh/boRUhmyxtjP5Iu8XyxLCqm1xhKShKh
	tMVZX66rSSjbu2I0tYbIiHFsmsknRGJPsWeuWpn3GHEyrkuh7+uqB2td31hxiQwnVrGRWVx31rUHZ
	KKV2UOusAKJJWobVEw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tp6x3-0028PG-3C;
	Mon, 03 Mar 2025 14:39:26 +0000
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
Subject: [PATCH 3/6] drm/amdgpu: Remove powerdown_uvd member
Date: Mon,  3 Mar 2025 14:39:19 +0000
Message-ID: <20250303143922.36342-4-linux@treblig.org>
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

With phm_powerdown_uvd() gone in the previous patch, there's
now no longer anything that reads the powerdown_uvd member of the
pp_hwmgr_func.

Remove it.

There are a few assignments to it; a boring NULL which can just go,
and two functions, but those functions are called explicitly anyway
so the assignments to the member go.

One of those (smu7_powerdown_uvd) wasn't static previously;
make it static.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c           | 1 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.h | 1 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c            | 1 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c            | 1 -
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h                   | 1 -
 6 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index a8c732e07006..9a821563bc8e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1642,7 +1642,6 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.apply_state_adjust_rules = smu10_apply_state_adjust_rules,
 	.force_dpm_level = smu10_dpm_force_dpm_level,
 	.get_power_state_size = smu10_get_power_state_size,
-	.powerdown_uvd = NULL,
 	.powergate_uvd = smu10_powergate_vcn,
 	.powergate_vce = NULL,
 	.get_mclk = smu10_dpm_get_mclk,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
index f2bda3bcbbde..5e4c80f7b20a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
@@ -55,7 +55,7 @@ static int smu7_update_vce_dpm(struct pp_hwmgr *hwmgr, bool bgate)
 	return smu7_enable_disable_vce_dpm(hwmgr, !bgate);
 }
 
-int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr)
+static int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr)
 {
 	if (phm_cf_want_uvd_power_gating(hwmgr))
 		return smum_send_msg_to_smc(hwmgr,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.h
index fc8f8a6acc72..e56abbadc78b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.h
@@ -28,7 +28,6 @@
 
 void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate);
 void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate);
-int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr);
 int smu7_powergate_acp(struct pp_hwmgr *hwmgr, bool bgate);
 int smu7_disable_clock_power_gating(struct pp_hwmgr *hwmgr);
 int smu7_update_clock_gatings(struct pp_hwmgr *hwmgr,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 632a25957477..8da882c51856 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5754,7 +5754,6 @@ static const struct pp_hwmgr_func smu7_hwmgr_funcs = {
 	.patch_boot_state = smu7_dpm_patch_boot_state,
 	.get_pp_table_entry = smu7_get_pp_table_entry,
 	.get_num_of_pp_table_entries = smu7_get_number_of_powerplay_table_entries,
-	.powerdown_uvd = smu7_powerdown_uvd,
 	.powergate_uvd = smu7_powergate_uvd,
 	.powergate_vce = smu7_powergate_vce,
 	.disable_clock_power_gating = smu7_disable_clock_power_gating,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 7e1197420873..9d3b33446adc 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -2044,7 +2044,6 @@ static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
 	.apply_state_adjust_rules = smu8_apply_state_adjust_rules,
 	.force_dpm_level = smu8_dpm_force_dpm_level,
 	.get_power_state_size = smu8_get_power_state_size,
-	.powerdown_uvd = smu8_dpm_powerdown_uvd,
 	.powergate_uvd = smu8_dpm_powergate_uvd,
 	.powergate_vce = smu8_dpm_powergate_vce,
 	.powergate_acp = smu8_dpm_powergate_acp,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 227bf0e84a13..c661185753b4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -257,7 +257,6 @@ struct pp_hwmgr_func {
 	int (*get_pp_table_entry)(struct pp_hwmgr *hwmgr,
 			    unsigned long, struct pp_power_state *);
 	int (*get_num_of_pp_table_entries)(struct pp_hwmgr *hwmgr);
-	int (*powerdown_uvd)(struct pp_hwmgr *hwmgr);
 	void (*powergate_vce)(struct pp_hwmgr *hwmgr, bool bgate);
 	void (*powergate_uvd)(struct pp_hwmgr *hwmgr, bool bgate);
 	void (*powergate_acp)(struct pp_hwmgr *hwmgr, bool bgate);
-- 
2.48.1


