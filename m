Return-Path: <linux-kernel+bounces-447259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 906839F2FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E71882016
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54052207646;
	Mon, 16 Dec 2024 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I1LoHCoq"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436A2066E9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348897; cv=none; b=DjHAKOXWM1kI926wiRx8TGGufSq45Ra0Y1Aq6slXPqGAoJaT6I+IpQS7X6AUTqza1xYffOUAwWrmkqcqUrxjTdS0TxuIjODKQHf4ytHPpkpNU6za9oriXUDHxqVt/e1aejSBNxCxMULMeaJIVzrrHTbcMSEDUIJgzjrYnyL9Xig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348897; c=relaxed/simple;
	bh=y5VdIlFmZrN99wi17sHDS/2XA6J1JYaGxHyZF4VUIi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EcAvRbhXVFS7hkgWEWxh8t/H//U1lRrbQImcl3UHTjbOLYgS/MXAj5KzGNhu3CnKXMLWMnIrySu2BQ5qAmZnX6lWDhc7Rl9mBobVW94vvEqVkdc0PnLKYAgoWeDFd7fDy5O61sAa9HJDGUIGhxfm0mEkfO9UAAYLHqp8L5nB8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I1LoHCoq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348890;
	bh=y5VdIlFmZrN99wi17sHDS/2XA6J1JYaGxHyZF4VUIi4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I1LoHCoq945+zGqi2IJw4PxdFgsNnMEsCh+MDvewdAwWOrbvQ6KLSiNTIbLg5yzn1
	 jcN/lq3bd/ulKW8+VJAlilAJWJHswSCyZg3KwsVTXZlMx816S/1SrZ9k6QbcliP1NA
	 lz2vqXg8r3nA+XBY8L+mzkSccVgIdg/yYTKDS9KM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:34:51 +0100
Subject: [PATCH 5/5] drm/amd/display: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-drm-v1-5-210f2b36b9bf@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Qiang Yu <yuq825@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 lima@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348889; l=1989;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=y5VdIlFmZrN99wi17sHDS/2XA6J1JYaGxHyZF4VUIi4=;
 b=CINJ3HLrSMhMcfUsU7NZIyH1+y1/TzIm0rkb5ETIxXa+H/f3F/O5bIuXKhuLkCFAOgO1NyygM
 0FozzyXfHeLAjv++M4Tndb+I24Twp4TVweWBj+rGRLNhapMZs6RYICv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index e339c7a8d541c962aa44ae25ad97b864285394b8..e27d077396327bbe25014aec5b978293b1c20dac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -614,7 +614,7 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
  *	incorrect/corrupted and we should correct our SRM by getting it from PSP
  */
 static ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
-			      struct bin_attribute *bin_attr, char *buffer,
+			      const struct bin_attribute *bin_attr, char *buffer,
 			      loff_t pos, size_t count)
 {
 	struct hdcp_workqueue *work;
@@ -638,7 +638,7 @@ static ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buffer,
+			     const struct bin_attribute *bin_attr, char *buffer,
 			     loff_t pos, size_t count)
 {
 	struct hdcp_workqueue *work;
@@ -698,8 +698,8 @@ static ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
 static const struct bin_attribute data_attr = {
 	.attr = {.name = "hdcp_srm", .mode = 0664},
 	.size = PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, /* Limit SRM size */
-	.write = srm_data_write,
-	.read = srm_data_read,
+	.write_new = srm_data_write,
+	.read_new = srm_data_read,
 };
 
 struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,

-- 
2.47.1


