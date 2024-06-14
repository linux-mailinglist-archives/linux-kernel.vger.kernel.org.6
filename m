Return-Path: <linux-kernel+bounces-215161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5A2908EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C438D1F23DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C116F91E;
	Fri, 14 Jun 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IaEN/oB6"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BEE16F0D5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379397; cv=none; b=UYwbFLT87x09izh4sgd1wyPbcdIodmibUaqiGt411j0IqxZVMahW4H8I4U/bEw68quame0ltQVyrnIoBzJBK/znWlltD/8O3e9UkXYZ8FTzqJdq0BAsmXeHqZI7hzJfw8nQgtCPNi+mdXrn0tkinSWooZ3uScKLLOIpskxp7qIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379397; c=relaxed/simple;
	bh=B9dNKu0g1GOvL1g8mOZK4aOrZsmlnULWwgMOQQakRgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eTwQDAypGAfH0hA1obmSe/T3z12a6e++PsID4QGgaHZKCeJYazlmf2+N1zJeLymftHBJCWNyoiLB7acnan9FLXIe2Zh7ijop3k+9rNazysbZz0kkePuVQI2eDhuZ34igCqpdkvdAxzS6JNDFZOi/HFmffmr6nxZ8Ywb2CcKrSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IaEN/oB6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DKE9E8EfN4qFoXgS2Nhr4CIKzmxCOJoEG4cKtj5vuJs=; b=IaEN/oB63jOJZPzaLtrY3GcTEr
	O2HwdvD0tELiCl8UT8ClfthshVPMcQjTs4roGd3avMcu/rpj5oOMw1xfjUluVHCPu23C+2vyt2ynX
	GS+/rJP7mm6UJuE0TowPo0nhB0LGZ+/RhpvIAC6gGSalh5fntHV8Ztdo7yCFztMgNO+EUzGaOwDXX
	YDRNij7OtLLhDeropi8r9FYTwqLCGjnQbsyYYrksowqXkzlyJlmdq5mUYihHwg6t0GSOVlptQ4TAT
	ruwfSc0SZhsRQkYFgO+LVvZ7VcLg3J9fjIetGINtzbeVlPa8Hjy6m+/Q8h/1dk9hiUV+aOxPvkcGK
	OmfZvXsQ==;
Received: from [179.118.191.115] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sI8yf-003B8v-Kq; Fri, 14 Jun 2024 17:36:34 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Melissa Wen <mwen@igalia.com>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6 6/8] drm/nouveau: Enable async flips on the primary plane
Date: Fri, 14 Jun 2024 12:35:33 -0300
Message-ID: <20240614153535.351689-7-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614153535.351689-1-andrealmeid@igalia.com>
References: <20240614153535.351689-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This driver can perfom async flips on primary planes, so enable it.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 4 ++++
 drivers/gpu/drm/nouveau/dispnv50/wndw.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index 4310ad71870b..fd06d46d49ec 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -1285,6 +1285,7 @@ int
 nv04_crtc_create(struct drm_device *dev, int crtc_num)
 {
 	struct nouveau_display *disp = nouveau_display(dev);
+	struct nouveau_drm *drm = nouveau_drm(dev);
 	struct nouveau_crtc *nv_crtc;
 	struct drm_plane *primary;
 	int ret;
@@ -1338,6 +1339,9 @@ nv04_crtc_create(struct drm_device *dev, int crtc_num)
 	if (ret)
 		return ret;
 
+	if (drm->client.device.info.chipset >= 0x11)
+		primary->async_flip = true;
+
 	return nvif_head_vblank_event_ctor(&nv_crtc->head, "kmsVbl", nv04_crtc_vblank_handler,
 					   false, &nv_crtc->vblank);
 }
diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.c b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
index 7a2cceaee6e9..55db0fdf61e7 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.c
@@ -763,6 +763,10 @@ nv50_wndw_new_(const struct nv50_wndw_func *func, struct drm_device *dev,
 			return ret;
 	}
 
+	if (type == DRM_PLANE_TYPE_PRIMARY &&
+	    drm->client.device.info.chipset >= 0x11)
+		wndw->plane.async_flip = true;
+
 	return 0;
 }
 
-- 
2.45.2


