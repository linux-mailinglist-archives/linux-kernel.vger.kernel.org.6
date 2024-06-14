Return-Path: <linux-kernel+bounces-215157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7521908F10
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09742B2624E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA78116A37C;
	Fri, 14 Jun 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aFh82x5B"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E104816D4F8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379371; cv=none; b=T3i69mnGdKKnEC1+xIklRh3Ba1JzhgD+3qcSp+CPiQKkYhjl0ULvLvMho62HC2SUFtP/pcQiZUwPX5Vnoigb17pqYznRAR0tEBuH4SXvysMBjVueMd/55bHWSY+U9WngnMlrn5nQyRMicmhZkNkgMFG2tSBH+2FOOtzr1Q5Q/Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379371; c=relaxed/simple;
	bh=0QddMAj+chbAGVELp6IRppqB/ssjTUpG6FHfntl6lLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGTE/bpiC/lztB+n3+aFywb9RDHsKjJDGTweJ/3qC+tiIT2IpvD4ILHKzsYAH2yMwv0KSrIALZOq5MUYug7cVHrfdOs5obKHi2ZbR3BGb/3m6KAnV5c7eHO4nIz+Gog53KwRMJm0n1WD0RK2jYbyJCnZAJKBW1/Kt6RAop/irnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aFh82x5B; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kmzOSqTKJaH0dvCeP0l9yACALP9ZDMY12Vpbbl/oZpo=; b=aFh82x5B16HfjMQDExiRAYOAAm
	f+p+YESYJxmGdkjJJFXxIDhcYx424j/smaqMdz5/3/77aQOwxYLMkU3TAiDIHnWA3uZbeVh+KJ3sG
	fZLfCLiAazI7zvQfh3PgDOBn3lC7zkMFUX+1P8dETPjZUtjjT5je5ozkwzmWO9uQJAV+1B3FVqHfj
	fJrMwntYMkrFJS+a0THptww0VlUiKdUlXTqyKCVNZGDmYVMBgCC4mvFPLMDCih6mtCipLYaOqMxhV
	C/BP6hP0UqoVg8a0V6OfZJyi5xnvMZNwv7vZ6GOHhLn6EpJuxPcmnoF3Hd+lUHHJNBUD5cfKaV8Po
	phSrk10g==;
Received: from [179.118.191.115] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sI8yA-003B8v-5N; Fri, 14 Jun 2024 17:36:02 +0200
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
Subject: [PATCH v6 2/8] drm: Support per-plane async flip configuration
Date: Fri, 14 Jun 2024 12:35:29 -0300
Message-ID: <20240614153535.351689-3-andrealmeid@igalia.com>
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

Drivers have different capabilities on what plane types they can or
cannot perform async flips. Create a plane::async_flip field so each
driver can choose which planes they allow doing async flips.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
 include/drm/drm_plane.h           | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 2e1d9391febe..ed1af3455477 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1079,9 +1079,9 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
 			break;
 		}
 
-		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
+		if (async_flip && !plane->async_flip) {
 			drm_dbg_atomic(prop->dev,
-				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
+				       "[PLANE:%d] does not support async flips\n",
 				       obj->id);
 			ret = -EINVAL;
 			break;
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


