Return-Path: <linux-kernel+bounces-215162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39097908EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480A31C23B84
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC8917BB23;
	Fri, 14 Jun 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e8l9VEx1"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8B170847
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379405; cv=none; b=nJOOXuLjBco3WjYihWvYhPYAlVwswKfwtw4fMj6mkpoZD24HFaFY3c+WiOG1xXBR9r1YmIXMXHlv4NTvAoe+ruK0IH7W6U5KuciX0lUx5ruFuSa/ZelhK0O6OkAHo27a/gNfvfK5vYXuPMXVY9O+gSZnIpV4AlsyOzWBc7I0czs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379405; c=relaxed/simple;
	bh=ZHewzGEOD8B2TSiTqvZxHdujWviyk/QQ4/H/mWQ3LiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GB0TKbW384Hc4z4k1bK79VlLHD0O956YzwhZpZHEKddptHVLj0KwAfZMOW2eGRCMJQMn+VBDbIyxYEpR5YyZ09Bl1Kt8hwGXXNY4Ujf/LZ9j8LnQvWjWIrKV4ccszWEg1FlMqyeIwhRWtrJJGxkxIosNAEaxPnl9z/q6O/hVuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e8l9VEx1; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iMbXibmuv4tLW3BVBfl9Ydvrc3EWU1itn+Bz/2WUIe4=; b=e8l9VEx1/3TjTxvs/xWpRIwe8p
	1tqhvk9qf6m1hEaLAaTIlV9ShiJ12mPE8Wm+ODs3NWB30oGpB1+sOSVks6v13OM+y298aMcYntEUN
	1Qg24/ef4CwLycGX+BiqfImAC8INTkXhUlS6aRt/mzNKlFXkDOkqaPaIM/SaAGhoIaaDRdl3Mgwlk
	+NZmZZewqrV8akaBOvITagORzP9urp7tFO2N91jFt6ELMVbfWXow/IM/wLbllle3eYMs4+ALm5n/O
	uJVoIpdaOuSCv8cvRXQsYeI/W7NOuOD1WGVolQCrJFhxkwGQCSXeiKPxw6TrQp+Hr6xJ/sComZTgN
	SooEgaCQ==;
Received: from [179.118.191.115] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sI8yn-003B8v-Ge; Fri, 14 Jun 2024 17:36:41 +0200
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
Subject: [PATCH v6 7/8] drm/vc4: Enable async flips on the primary plane
Date: Fri, 14 Jun 2024 12:35:34 -0300
Message-ID: <20240614153535.351689-8-andrealmeid@igalia.com>
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
 drivers/gpu/drm/vc4/vc4_plane.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 07caf2a47c6c..e3d41da14e6f 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -1672,8 +1672,10 @@ struct drm_plane *vc4_plane_init(struct drm_device *dev,
 					  DRM_COLOR_YCBCR_BT709,
 					  DRM_COLOR_YCBCR_LIMITED_RANGE);
 
-	if (type == DRM_PLANE_TYPE_PRIMARY)
+	if (type == DRM_PLANE_TYPE_PRIMARY) {
 		drm_plane_create_zpos_immutable_property(plane, 0);
+		plane->async_flip = true;
+	}
 
 	return plane;
 }
-- 
2.45.2


