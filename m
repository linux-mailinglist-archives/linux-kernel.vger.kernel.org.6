Return-Path: <linux-kernel+bounces-349813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09C398FBCF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 03:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3152E1F22546
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F944748D;
	Fri,  4 Oct 2024 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc1fLjsX"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81521156CF
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 01:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728003990; cv=none; b=cZbv8XEVPQHrFCuENR7jsu+r9u3W7RMNgKVxuAUOR5XtHHRvaIE5aeWiHaop1NZFwnV3u8+7jLlePM4XXbgOWGwWQqLq4xgYST8AvFKcrA4GxyUsiCzGhLpPVz75ZlLZO7bbha7s4vlFobMh0hQqMEsbjor3ozK+i4Y/9DCtlVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728003990; c=relaxed/simple;
	bh=aHGFsSfV9XfWx27RCSjVsbamQhQkbSY6tZ8XWnMT7e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/V8FqgvjzsEXknQge1c+cl7ULZi/rjJAUji8kpCASThWI+KSXBAax40NtH++IXiuOPB6/3kiL5ko2uQUsCDmnaZgDTnSrZmEtpNMU4QaBeo/MkURK9IBkOYTfDXXNqM6W5NxhgWkOJzUB2YtvUdgpwq8qNOjd7UgfZttJWcQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc1fLjsX; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e18aa9f06dso1180262a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 18:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728003989; x=1728608789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0MKM8RY4WB/OtS3QV8HYE66wVq4ICJcjlSk60orFw5E=;
        b=Bc1fLjsX4iL20cb/+UkQJJ4xeOFViQenxHwUyzp1FmRQLgfzKRZB51foDMmtAfSP7v
         Pp1qPU2ts39Ne25QelXvwNEshB+Fx01edwZPg+i2DIswyyl8nFpdLj8PY4tSq+osN/2Z
         NAX4rOIDwMZm0xfQ6PTYgedTV1fC5TddziGnX+apeN40R1nAVpxQ6/yz/DBbRTVCAQmu
         6mClkshOCP2TBHFWrUYJjzOfTXflG3/8rf2mrQfQvxcg2xsVzMo5VmfMnnA0Twd/9dWo
         5dLqa6mZ7IlIXMwCGTK+Bs/wN/wn7RwZJLn9/iHEcwcSQwurA4pVaeuMcP0QJmQDFAiQ
         1yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728003989; x=1728608789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MKM8RY4WB/OtS3QV8HYE66wVq4ICJcjlSk60orFw5E=;
        b=WefCcpsGFEUuYJ/xmGGQ6iP5kXRM0AFC5QTpfkqwmI/xPJ6gevMv2b6Zrqq9EjI0r6
         5/pm+LDtHOaldwkygkdDECGgTj3b10Nkl+U8W07mFtbwKPQwv4P/eBsD3IEQ8/czsP+D
         NP0IZ+2BMoeo3boao1/b3NwWCtIS/bNP6xsFCzuF5Q8ugQFGCjyvPq17j9GwgYyBEnHp
         qldaxSHPulObgj8xuN9k3ET29e/RDBJ52DEC80oGFcJ1+TZfQd+PwTcTITXVsmzAergk
         ROPKLTpFJcahep7/zzw05CLd0WNKupVRRAJtC0Mwzmhk7YxOwW4cxAfXu8tXBCwtWG9b
         QCFw==
X-Forwarded-Encrypted: i=1; AJvYcCXsciItXWMKdcfCT00PELO3CWlL/P6Ih4CWt959sqfos7Pn0Is4eXDFlspwN/Az2XdZHqxd1hniKRYZMzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwonfXnMdV9eyykNWN7qzbobuwtbphxkcmBiy0DfTA+uj1oS59/
	DuhHrf2Maafrr45iFhcbEQ6oaxXWOfPIMSuACxxgLP62FZ+ZmGiZ0N8/Vf5G
X-Google-Smtp-Source: AGHT+IHwF8QgszAa+3JDFqSJKcd/5/5sO19rtoHRsn+mDj++CQ5sQCWk7+OvQqlR0Eb+5nDmm597Jw==
X-Received: by 2002:a17:90a:8a13:b0:2d8:89ff:db1a with SMTP id 98e67ed59e1d1-2e1e5b49179mr1423648a91.8.1728003988669;
        Thu, 03 Oct 2024 18:06:28 -0700 (PDT)
Received: from jayDESKTOP.. (210006200231.ctinets.com. [210.6.200.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e862328csm187341a91.44.2024.10.03.18.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 18:06:28 -0700 (PDT)
From: Wu Hoi Pok <wuhoipok@gmail.com>
To: 
Cc: Hoi Pok Wu <wuhoipok@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/radeon: add late_register for connector
Date: Fri,  4 Oct 2024 09:05:59 +0800
Message-ID: <20241004010601.3387-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch is to solve null dereference in 'aux.dev', which is
introduced in recent radeon rework. By having 'late_register',
the connector should be registered after 'drm_dev_register'
automatically, where in before it is the opposite.

Fixes: 90985660ba48 ("drm/radeon: remove load callback from kms_driver")
Tested-by: Hans de Goede <hdegoede@redhat.com>
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
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


