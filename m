Return-Path: <linux-kernel+bounces-215160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6411908F05
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DEAB259A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3BF155392;
	Fri, 14 Jun 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="g2WEe20R"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D4616D4FC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379389; cv=none; b=SF+mDSw4j8Wysv7wHCftJo1lH8aU5Q5CQ7o8NNWhmpt1XvOy8Y88QDa6rVss1dUJzQt71ejU9QjAPc1ftT01FzExTI5OygGqMRejvtWooIv0tuwgD8jFAeKdlUtxOAeDz3FcymEAr4jnurExFE0j5ApQk3a0P4UhGWHTOy4pB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379389; c=relaxed/simple;
	bh=GhR6sYeDn1XaPbJaQyiGAJMfp3+6qJK9pLZBGDCCuPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cG5AP0fdPTAlgeBtQBXbE4TPRCNPiXJo7syr62w0qeypgodg3tfugXQhJwg6ZNp0yDIEY+Px/urA8gBhMkIJGjP2ZZiLuTB+XL+uigDKJcb9Mgas6sICD1SwjbLlJAkSM6VGzky2NEyUaUNkc6ZTs3VECjRaVMJgSiLxBNPnO7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=g2WEe20R; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WCQBKaM5/7WaKHxgT7dEJbGWb3sM+ygzUWYJFAvbV1Y=; b=g2WEe20Ri4+WMKGJEHCtLowPJb
	e1K7fp0ahqjoyRFByqwH8frtjGYH6PUCh1NoxuL0wD5CQqfvnU/hIWQ2gGCyFrZiV55KmJ+QIyiAC
	KnafVcC7owm35XIAUbpBEmosR6XEj2dyNJyvEbYJcbZoAIGs9aAk1qvLJdrgWnxC2PrD2+IXuDpnM
	V+I5ZGQrFOfifSa5jn4in/9UfngVuqMAJ4qsEwQhQWTN3G/1s3Gr1RaUZe56kWs5tGhzcUpRPJLy5
	K7bwdPja9PF3pPAXiX3cGwORdWl5FUQtOW210P1SHDnqTTscm6938n0Jc0Bl1wflvvAuuwWbOPBP0
	Y160FIvQ==;
Received: from [179.118.191.115] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sI8yX-003B8v-P6; Fri, 14 Jun 2024 17:36:26 +0200
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
Subject: [PATCH v6 5/8] drm/i915: Enable async flips on the primary plane
Date: Fri, 14 Jun 2024 12:35:32 -0300
Message-ID: <20240614153535.351689-6-andrealmeid@igalia.com>
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
 drivers/gpu/drm/i915/display/i9xx_plane.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/i9xx_plane.c b/drivers/gpu/drm/i915/display/i9xx_plane.c
index 0279c8aabdd1..0142beef20dc 100644
--- a/drivers/gpu/drm/i915/display/i9xx_plane.c
+++ b/drivers/gpu/drm/i915/display/i9xx_plane.c
@@ -931,6 +931,9 @@ intel_primary_plane_create(struct drm_i915_private *dev_priv, enum pipe pipe)
 
 	intel_plane_helper_add(plane);
 
+	if (plane->async_flip)
+		plane->base.async_flip = true;
+
 	return plane;
 
 fail:
-- 
2.45.2


