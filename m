Return-Path: <linux-kernel+bounces-571130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA9EA6B993
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9142C3B46E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CD222173E;
	Fri, 21 Mar 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="k70HpNTv"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AC1F09A8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555302; cv=none; b=HEuGqXJjGGPAe4m65V80z3SvR+74kpKjF5UnqFW3AI/VhUsVHjy9E+SWmoDgmVwYgzJRzlzAHMlds1EasFEZrhdZe5VCI/jKWIgDKctRhcQ0/0903nkZtGuDckpi2JmvxXhDSrKG/Eo90L1lADXeO8eloNGm6DMdVK6Pc0DDzmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555302; c=relaxed/simple;
	bh=YxheuH5qC+gbNFpr0EE4TkJ0s9iDCQtv8J9bv2AWTPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+qIbvqwVYEtz7wwDa1fMW/krRpPFY7D1RZUchFscEcwKCq3N3sAguA61TbfIS4Gs60krTod19nHmc2Gw54lmkPT1uiTgaRuhTBocy2yzAlgtK5mSF7virRsc7vOb46Lx3TJUnxN321x07vamhV5Y7kUJB54rgUePHB5TQ55Mew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=k70HpNTv; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742555297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gXu86VZaLBNYnHRfrq34BCX66En+zpOOpN6qaFsLboA=;
	b=k70HpNTvLGIyji0//Mk9SdHtq06g3/dIKNx3dfql7tZVrwd0YfhtdScJ1GXgmZw5bcvpvz
	cXOUyf93QvvsqlxfRownHK/770PC5ilYC7FWOZDL0iyGi1nYPkt7TGhqcVKNecjY1fXILQ
	Dg9Y78D+Nyj+UWfP1AD4SNnxI6NWesI=
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/amd/pm: Prevent division by zero
Date: Fri, 21 Mar 2025 14:08:15 +0300
Message-ID: <20250321110817.10274-1-arefev@swemel.ru>
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
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
index 379012494da5..56423aedf3fa 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
@@ -307,10 +307,10 @@ int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t speed)
 	int result = 0;
 
 	if (hwmgr->thermal_controller.fanInfo.bNoFan ||
-	    speed == 0 ||
+	    (!speed || speed > UINT_MAX/8) ||
 	    (speed < hwmgr->thermal_controller.fanInfo.ulMinRPM) ||
 	    (speed > hwmgr->thermal_controller.fanInfo.ulMaxRPM))
-		return -1;
+		return -EINVAL;
 
 	if (PP_CAP(PHM_PlatformCaps_MicrocodeFanControl))
 		result = vega10_fan_ctrl_stop_smc_fan_control(hwmgr);
-- 
2.43.0


