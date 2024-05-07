Return-Path: <linux-kernel+bounces-172134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CCA8BEDEE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74AD1C24CDE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E70818732C;
	Tue,  7 May 2024 20:16:10 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603F187324
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112969; cv=none; b=KL+9fsACv99rzdjDR+oq0ppevQ7e3JLljc7wO80NEylbfzXc5bwKYR5uqGlXDuKvDV0JM3abq18BVUROpwhlEAuTlBTePffhq89jPHrvYr7D/DeImhk9LcSYHudAQhCV8CyFfrcOb6lPG9uG1RAhMx/0hWdVC19yzCwVwRfLRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112969; c=relaxed/simple;
	bh=vi09pAj5NzTXzGhJb/2e314Pdt//tBkobMEfvhiwVwE=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=vEW6jztmvNkzZQIu+L50ifHegSnZh6yARsq3QixrNXsOcrIPrSdlzULiIFH/ceqQPJyIEI4VEntt4KUeZoflvVx9tKwPRhsWGESsbt5k6Xvn2NH6ocZKra4n6+No9Dbzo2QgHi45iSw906pS+blW0zl+J+ExieoURHtfbmcDqiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68e76.unconfigured.pool.telekom.hu [::ffff:81.182.142.118])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000074965.00000000663A8ACE.001E3309; Tue, 07 May 2024 22:10:53 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Harry Wentland <harry.wentland@amd.com>,
  Leo Li <sunpeng.li@amd.com>,
  Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
  Alex Deucher <alexander.deucher@amd.com>,
  =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
  "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
  Daniel Vetter <daniel@ffwll.ch>,
  Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [RFC PATCH] drm/amd/display: Disable panel_power_savings sysfs entry for OLED displays
Date: Tue,  7 May 2024 22:09:19 +0200
Message-ID: <04db7855665f9cc92a730dd7ad0b7c47c8fd0091.1715112078.git.soyer@irl.hu>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

The panel_power_savings sysfs entry sets the Adaptive Backlight
Management level (abm_level). OLED displays work without backlight, so
it is unnecessary for them.

Before creating the sysfs entry, make sure the display is not an OLED
display.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d6e71aa808d8..d54065a76f63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6535,9 +6535,11 @@ static const struct attribute_group amdgpu_group = {
 static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
+	union dpcd_sink_ext_caps *ext_caps =
+		&amdgpu_dm_connector->dc_link->dpcd_sink_ext_caps;
 
 	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    amdgpu_dm_abm_level < 0)
+	    amdgpu_dm_abm_level < 0 && !ext_caps->bits.oled)
 		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
 
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
@@ -6642,10 +6644,12 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 		to_amdgpu_dm_connector(connector);
+	union dpcd_sink_ext_caps *ext_caps =
+		&amdgpu_dm_connector->dc_link->dpcd_sink_ext_caps;
 	int r;
 
 	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    amdgpu_dm_abm_level < 0) {
+	    amdgpu_dm_abm_level < 0 && !ext_caps->bits.oled) {
 		r = sysfs_create_group(&connector->kdev->kobj,
 				       &amdgpu_group);
 		if (r)

base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
-- 
2.45.0


