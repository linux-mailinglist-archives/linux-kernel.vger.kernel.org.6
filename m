Return-Path: <linux-kernel+bounces-218574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF9790C22A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6921B2849AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7FE19B58F;
	Tue, 18 Jun 2024 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="H6yx/qfQ"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB619B584
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679680; cv=none; b=LZf98pKguDMzwKjbMvqyuc9KCnIkzODASpm34a0IS3Mc5++3CZaNE/8M8rd9vo3seSWSx67eXM9yO6Xc/mD0PB4DfrcQiBrPc+HtRlT8bx6TDKoki02eU/L4VNGhumDMlpS6x2y2PfBpjUOTKIegE+EEMdfqVyK1T9WwtEbKG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679680; c=relaxed/simple;
	bh=wwRF8BVro0PY/mFf8Gls+l3FmL1tIna+9uT1f8Jrhv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlzmchPwOLnW8roYQtW1gx+yRFJfp/4QaI2lsOgChJsPWnJtXaGCU0UJDNT48s6F2O+pLAk4dLJZlqMExwN3j72wRn1qaRfjPDhNPq93zo21rrA0mfeyhl7hBzsSQDkWkDuhEdMJvEqqKqMbJbgYK53i9+5RKzJal8Pg70br+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=H6yx/qfQ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UGSCYUB1C9SdI44irIlb8YiYD3kMwObaC0KqVFpWgGg=; b=H6yx/qfQJfvSRu2Pdl6igXFlym
	7pGCGJTUu/ZSAFO2v07RFsgsVaje2wtinzQdgDn4OVeMltJWMkbpvNtvLvO+2eWIGt73ywX+ajA7u
	TlvwfdUnxazVHQAMkMX4+wyTDDeXFxMDji0Zli626u8+ikx6Z5uTfyjOuBcl61QCJTJAEtG5cmYgk
	qmEHEo0SwBWOgTbm+GBTy/uh/c+viryW57QtNr0oK+IGcxi6SotTMe5eP5/ipJOpSgDtg5Ce0NxiW
	4LV3+oYrZTqV2J5dWiD25Pmzdthn4s6aMJaWBpbxrhclQ7SkrkFzHSyac/6ISpG1ZM92lh1f4acM+
	jx7PagZw==;
Received: from [191.8.29.108] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sJP5v-004YXc-TL; Tue, 18 Jun 2024 05:01:16 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
Subject: [PATCH v7 5/9] drm/i915: Enable async flips on the primary plane
Date: Tue, 18 Jun 2024 00:00:20 -0300
Message-ID: <20240618030024.500532-6-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618030024.500532-1-andrealmeid@igalia.com>
References: <20240618030024.500532-1-andrealmeid@igalia.com>
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
 drivers/gpu/drm/i915/display/i9xx_plane.c          | 3 +++
 drivers/gpu/drm/i915/display/skl_universal_plane.c | 1 +
 2 files changed, 4 insertions(+)

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
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 860574d04f88..8d0a9f69709a 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -2371,6 +2371,7 @@ skl_universal_plane_create(struct drm_i915_private *dev_priv,
 		plane->async_flip = skl_plane_async_flip;
 		plane->enable_flip_done = skl_plane_enable_flip_done;
 		plane->disable_flip_done = skl_plane_disable_flip_done;
+		plane->base.async_flip = true;
 	}
 
 	if (DISPLAY_VER(dev_priv) >= 11)
-- 
2.45.2


