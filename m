Return-Path: <linux-kernel+bounces-571131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0490CA6B990
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46692188B792
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2339221F0D;
	Fri, 21 Mar 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="s9Nu6WHU"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804B1F152E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555303; cv=none; b=EpAcWBTgI2CnzeHbD0imTNinE3qd9kw6tXAH2e47mJNgAMbpCEq8rkB2dhUROjwDngtuBumKGkz1kqUuuMOW7d/hvP6vCSRz0rYLpvxmSzq4vUZh/g2s4iUq+2fB2O7Q2Dg9gUXvOVuXnAZJvdzTJEg/sQ3fCln/NfzmLvDKuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555303; c=relaxed/simple;
	bh=20CPGdQzPsjIaknmQRYWaju7DBTfaF0fWfsQ501jkeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sus37oPC0IK7GIc74sBI40KfyUJ6+bdNAYd45yoGALCamNpbqvXmOGQFwsNp+uu95D8wZmQOPY37ccrFgM+bUj+doLJ6GoHgMsovus/yqzohU3ObOuQF//V2tc6C4tvF6jBBd30p7XQMDuxkErchPV+kGPsWmUVYqzMufrRpq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=s9Nu6WHU; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742555298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOHLqhbZu+0FzqwJ8kMgQJhnp8r0yDBwvY5KCd76JIs=;
	b=s9Nu6WHUlp3vDbrlBDO3yruEW1r91JifOFZ1Ok83dX/exjvwYmPJua7rCJbK+5kl91cOX6
	tDi4c5mqG3DXVupMLNRWVfUVcTQgEOVvgmphQggKM4slJusRDb+Mz3RIONvqRWLtVVITp/
	RiIaJxJw3SysWuA9ncYEuwCtHMOjCdw=
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5/5] drm/amd/pm: Prevent division by zero
Date: Fri, 21 Mar 2025 14:08:16 +0300
Message-ID: <20250321110817.10274-2-arefev@swemel.ru>
In-Reply-To: <20250321110817.10274-1-arefev@swemel.ru>
References: <20250321110817.10274-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user can set any speed value.
If speed is greater than UINT_MAX/8, division by zero is possible.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c52dcf49195d ("drm/amd/pp: Avoid divide-by-zero in fan_ctrl_set_fan_speed_rpm")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
index a8fc0fa44db6..4182ea06f241 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
@@ -266,11 +266,11 @@ int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 
 	if (hwmgr->thermal_controller.fanInfo.bNoFan ||
 			(hwmgr->thermal_controller.fanInfo.
-			ucTachometerPulsesPerRevolution == 0) ||
-			speed == 0 ||
+			ucTachometerPulsesPerRevolution == 0) ||
+			(!speed || speed > UINT_MAX/8) ||
 			(speed < hwmgr->thermal_controller.fanInfo.ulMinRPM) ||
 			(speed > hwmgr->thermal_controller.fanInfo.ulMaxRPM))
-		return 0;
+		return -EINVAL;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		smu7_fan_ctrl_stop_smc_fan_control(hwmgr);
-- 
2.43.0


