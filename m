Return-Path: <linux-kernel+bounces-348611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E449998E9A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01ED2877D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D248770F1;
	Thu,  3 Oct 2024 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGubBS9J"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599A74BF5
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 06:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727935620; cv=none; b=Z32Lf8gRRYtomep8YjSYOQjOLUZZJheuhR1uzBVE5FAHmiYo3khxxWrLSN90wBNNRkvvTiIPbwNMJbeQr0W+i2uIw/yS7pdRkZv1MmcCi+UE2s4l+jk+Qp5WkUSmV6okmRvcouMDhG29IPdSAqomj4KXS2zHsnu7Pog4EhqELY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727935620; c=relaxed/simple;
	bh=fEsCQM6BW8SNOJTUvU3QTqqXra1nbVT9I/v3S3I7xWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E+yp+kVt2SjNDhAQp1b3mduS+HIsCtWcfPs2tE/AKDxLRxHlD27PMf1e2tNf6Tp3JI9wHPTNNvlqBfluAFL/Y4cjBQML/qult49bphRDXqY8wx8vz4w0clwcsbCtTFn5I2VA8pwp3e6YH+NZbu6Eg+iusGYSuf9mfZcIP0+CGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGubBS9J; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0a5088777so492846a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 23:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727935618; x=1728540418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gizy/hHvKle/wUxwaQYiB0W0k117aCDj8y0fuH7eCC0=;
        b=GGubBS9JT+Nyt7scfalSRWgS9rlv73vnqwTaOfuopFcELbymoEehBJ3KwJLWSvYKci
         5vT0foH+I3YDsuqky2kCLRmcCirGN5Y3F/Sp4orio1otA3xmPoD2/7tEpwyqI0XCchFU
         AlvMNGqOD7dTrMg/AXfRbGgAECyNR0YY0ADa6MOVArebcLVqBUIB2tbhVPEhF3+rTfrb
         PS2ujbfBj1KP2h3fOfs8BxtSqAHxXB+e1bT/cZHllfzEcjZjhE+C7aBfd5tWlHtZkqMo
         QkGexYHOUtoz912BX25PwMf2EHrJHyKqPYoOpCVhK08eNb+KS996OIxoaY8tEsueTYQN
         AN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727935618; x=1728540418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gizy/hHvKle/wUxwaQYiB0W0k117aCDj8y0fuH7eCC0=;
        b=uOTRwBWHwv+IGgPThX7AIReWBsy643pgsPHSr39TIvbR62ysoZBjfCZL0Lrt2lOxlN
         tNNVxuT5s3rKS76eMOZpMdTanK3radnSXieoFSeXu85ECCyoAfICxNzRIJFfoZI96DBC
         C6f60Cn39I/UbgaYTDvjtq5PGfRy4Cu7zw4ENCgxD7Tdda0irq0C8KvOje3S8YIfvHWv
         HXrr1I7Kc/XOz6XODY8IB50hLb02paZE5o3T+R795e7+F5OOmcBFNMjFKnEtnl044jeB
         ZbLecBn2YBUiaIBrynI5n2InYDEMNfFQGOS72b6Tc5r5L7XpapH2Qophho9DjDAevziE
         q3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWl+YOqn4F5A6j0MSIh7JmqEvDMlecU5odhmykIwshKChJPwz+TE3EVoczpBuZvajv7M9HdD6oFiicxlIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQYsCfhDLaCE7alXiRSXx1vY0PWN8Za3+0yi3qCQm/9V/cSAb
	JgknD6OR4Bd9IyRyI4Qbjr2NqJ1dEo1iB2TUvh9CAtbYMVa/V5dS
X-Google-Smtp-Source: AGHT+IH28i2qJ6+/r9g3BIoTWHR1EDtmgHyOuIUkZIQ+s87HIus1gxI6hsudyMxwnt0IsASivdgL4w==
X-Received: by 2002:a17:90b:3b52:b0:2e0:8784:d420 with SMTP id 98e67ed59e1d1-2e1848013e7mr6502496a91.21.1727935617738;
        Wed, 02 Oct 2024 23:06:57 -0700 (PDT)
Received: from jayDESKTOP.. (210006200231.ctinets.com. [210.6.200.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bfad5e01sm620663a91.3.2024.10.02.23.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 23:06:57 -0700 (PDT)
From: Wu Hoi Pok <wuhoipok@gmail.com>
To: 
Cc: Hoi Pok Wu <wuhoipok@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/radeon: add late_register for connector
Date: Thu,  3 Oct 2024 14:06:46 +0800
Message-ID: <20241003060650.18454-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a fix patch not tested yet,
for a bug I introduce in previous rework of radeon driver.
The bug is a null dereference in 'aux.dev', which is the
'device' not registered, resulting in kernel panic. By having
'late_register', the connector should be registered after
'drm_dev_register' automatically.

Please help testing thank you.

Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
---
 drivers/gpu/drm/radeon/atombios_dp.c       |  9 ++-------
 drivers/gpu/drm/radeon/radeon_connectors.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeon/atombios_dp.c
index fca8b08535a5..6328627b7c34 100644
--- a/drivers/gpu/drm/radeon/atombios_dp.c
+++ b/drivers/gpu/drm/radeon/atombios_dp.c
@@ -228,10 +228,8 @@ void radeon_dp_aux_init(struct radeon_connector *radeon_connector)
 {
 	struct drm_device *dev = radeon_connector->base.dev;
 	struct radeon_device *rdev = dev->dev_private;
-	int ret;
 
 	radeon_connector->ddc_bus->rec.hpd = radeon_connector->hpd.hpd;
-	radeon_connector->ddc_bus->aux.dev = radeon_connector->base.kdev;
 	radeon_connector->ddc_bus->aux.drm_dev = radeon_connector->base.dev;
 	if (ASIC_IS_DCE5(rdev)) {
 		if (radeon_auxch)
@@ -242,11 +240,8 @@ void radeon_dp_aux_init(struct radeon_connector *radeon_connector)
 		radeon_connector->ddc_bus->aux.transfer = radeon_dp_aux_transfer_atom;
 	}
 
-	ret = drm_dp_aux_register(&radeon_connector->ddc_bus->aux);
-	if (!ret)
-		radeon_connector->ddc_bus->has_aux = true;
-
-	WARN(ret, "drm_dp_aux_register() failed with error %d\n", ret);
+	drm_dp_aux_init(&radeon_connector->ddc_bus->aux);
+	radeon_connector->ddc_bus->has_aux = true;
 }
 
 /***** general DP utility functions *****/
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 528a8f3677c2..f9c73c55f04f 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -1786,6 +1786,20 @@ static enum drm_mode_status radeon_dp_mode_valid(struct drm_connector *connector
 	return MODE_OK;
 }
 
+static int
+radeon_connector_late_register(struct drm_connector *connector)
+{
+	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
+	int r = 0;
+
+	if (radeon_connector->ddc_bus->has_aux) {
+		radeon_connector->ddc_bus->aux.dev = radeon_connector->base.kdev;
+		r = drm_dp_aux_register(&radeon_connector->ddc_bus->aux);
+	}
+
+	return r;
+}
+
 static const struct drm_connector_helper_funcs radeon_dp_connector_helper_funcs = {
 	.get_modes = radeon_dp_get_modes,
 	.mode_valid = radeon_dp_mode_valid,
@@ -1800,6 +1814,7 @@ static const struct drm_connector_funcs radeon_dp_connector_funcs = {
 	.early_unregister = radeon_connector_unregister,
 	.destroy = radeon_connector_destroy,
 	.force = radeon_dvi_force,
+	.late_register = radeon_connector_late_register,
 };
 
 static const struct drm_connector_funcs radeon_edp_connector_funcs = {
@@ -1810,6 +1825,7 @@ static const struct drm_connector_funcs radeon_edp_connector_funcs = {
 	.early_unregister = radeon_connector_unregister,
 	.destroy = radeon_connector_destroy,
 	.force = radeon_dvi_force,
+	.late_register = radeon_connector_late_register,
 };
 
 static const struct drm_connector_funcs radeon_lvds_bridge_connector_funcs = {
@@ -1820,6 +1836,7 @@ static const struct drm_connector_funcs radeon_lvds_bridge_connector_funcs = {
 	.early_unregister = radeon_connector_unregister,
 	.destroy = radeon_connector_destroy,
 	.force = radeon_dvi_force,
+	.late_register = radeon_connector_late_register,
 };
 
 void
-- 
2.46.2


