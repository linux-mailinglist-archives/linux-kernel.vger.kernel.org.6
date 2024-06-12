Return-Path: <linux-kernel+bounces-212178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FBA905C63
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123B91C2175C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6709E84A50;
	Wed, 12 Jun 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Z1DlfMwK"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37D184A30
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222154; cv=none; b=Ro6BzwjV3qEVlx934Lit6RmobZutUwZBZgnaYscVSB6cje3DN1ZEpBJl2gTE19D8lMxWHwKlgRdLn/mJt8jFdkov51ioNoefPFNmymm3H9oLg5GPA4ZCdOT5kNsjUnj7ErIQus2Ks68S2jXIInI7TrN71IppQhI3dVUlUcV1QGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222154; c=relaxed/simple;
	bh=uKeP+wAXni5MOUXsaMG406PdThCXm4RY4vNFb5fsM8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhQGLCWk04/g5Z2EfUQRYTm8KuOzLS7aBNJ3GMwppWBAOY4aK/52n9TnjmxugE4TKXsFWrB8oLsZRSREPohnGUXQ5VjXXI+l0nSW7+7Dn1HS3eqYDX2IBMPxInxtH+Z2DHA1ondstFQtYKfXZMR0okWAFyfZjbCE7IoNaQ4meqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Z1DlfMwK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=z9r8+zo+4FzJ8W7BNm4EVq7tJIuBmkd8YYzubry2x7c=; b=Z1DlfMwKkSBovovn64D05AzEnZ
	/SnVdz89JrylCVzuIYa5F8K6Sl2Yt9/SfVMSy6knCuAh5i/reWDzNUhxSPkmLzwF5MdKGVcnp7wK5
	GkNk49vAMrUhPVUIuxiUG81dZNR3ZIoaQDF26XdwkO/Nfw81lnAEGkzZcqhUhP1BXdUeJukUaitEg
	/1Q/EYbMohJRxIPVOISW6XfAvp7BcKx56/BNMypc2j9GNd1/0O8oS9PBPVsFwBbAR3mykSkgSCK5b
	9hAUnBVf9kVSpFjiRLex5w94ZxtzdjiQrMsuOTfnjH1w5r1Z/U5n61IoKBovTQeBxo4kHMf0E5kAe
	mFWRNvsg==;
Received: from [191.204.194.169] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sHTml-002RtF-14; Wed, 12 Jun 2024 21:37:31 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com,
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
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 2/3] drm: Allow drivers to choose plane types to async flip
Date: Wed, 12 Jun 2024 16:37:12 -0300
Message-ID: <20240612193713.167448-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612193713.167448-1-andrealmeid@igalia.com>
References: <20240612193713.167448-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Different planes may have different capabilities of doing async flips,
so create a field to let drivers allow async flip per plane type.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
 drivers/gpu/drm/drm_plane.c       | 3 +++
 include/drm/drm_plane.h           | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 2e1d9391febe..dd4b1578f141 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1079,9 +1079,9 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
-		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
+		if (async_flip && !plane_state->plane->async_flip) {
 			drm_dbg_atomic(prop->dev,
-				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
+				       "[OBJECT:%d] This type of plane cannot be changed during async flip\n",
 				       obj->id);
 			ret = -EINVAL;
 			break;
diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 57662a1fd345..bbcec3940636 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -385,6 +385,9 @@ static int __drm_universal_plane_init(struct drm_device *dev,
 
 	drm_modeset_lock_init(&plane->mutex);
 
+	if (type == DRM_PLANE_TYPE_PRIMARY)
+		plane->async_flip = true;
+
 	plane->base.properties = &plane->properties;
 	plane->dev = dev;
 	plane->funcs = funcs;
diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 9507542121fa..0bebc72af5c3 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -786,6 +786,11 @@ struct drm_plane {
 	 * @kmsg_panic: Used to register a panic notifier for this plane
 	 */
 	struct kmsg_dumper kmsg_panic;
+
+	/**
+	 * @async_flip: indicates if a plane can do async flips
+	 */
+	bool async_flip;
 };
 
 #define obj_to_plane(x) container_of(x, struct drm_plane, base)
-- 
2.45.2


