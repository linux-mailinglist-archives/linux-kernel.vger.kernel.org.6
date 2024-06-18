Return-Path: <linux-kernel+bounces-218572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559B190C21E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B39A1C21895
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4C1EEF9;
	Tue, 18 Jun 2024 03:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TOXgrg8m"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1DB1D9503
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679663; cv=none; b=fPH0DZ5bungqOQ5Kn5w6DcuQHsYzmmoq3D0CUhLTvw/1uJZJXAf38Wo4YMGvByptKeIK1FGGXyWY8RvFboSqsAkeJ/hN9K8mcTsOxLm0wdOob+2nbPcmaOQ+gz/cTVtxjsVQeMewfmDgFmnIcADCtDorh+2/NtsOTSr+QASyKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679663; c=relaxed/simple;
	bh=tuwUheo4RqKv532bDB7QRYKxm9cHiNGCPnbRZZwcuHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CYCvH8pXB8JUfkPKDlDfD9rb2unYtAAyiTbKjfmVruFmwi/kJxTYkL9f+G0o6ijNETM398X/F5WJhlo/MHCVdKE3uARvXG6VbArZb61o8Z2DUOqgbBrHTN27+pIrTVBL9ZdpO5EIRYKdSnLS5COOjtxvat+tFRW25CW7R+MTViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TOXgrg8m; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=T4HuY6PmfyfwRldxWRxLwZWSx9bfqjA6Fv0hOEqe/jk=; b=TOXgrg8mCJy+bfOq6mAmSoPVCf
	y4/10/mCbkrjmaZUavWjnepUwae8wBI6AEFnVM1d4SZbtvYRA05ZxyqvK2DljQFWWkJSQfr74Lyv2
	8gocY36eZlJPY9Bk+TBMl2ZusSRugRv5Hp8aL4Pab0RNH64khYminFCl8z3g5GBM+XwS2ZqS5xPy1
	nBjESfoWF69H3l+6DJ3saonhcTki1AmGgAtTK8XtOBNvNR8wcwDbwKaeqAEGQ8FhmiyIvLPt7cq8v
	eZ543QcYxUz61Ier6cnj7Z73BJzNPtsLjnn0dxfDCt6xOmL4yKpOSlOXRZYXRrsk8yVeQF1Df6bWT
	oRMSaY8Q==;
Received: from [191.8.29.108] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sJP5f-004YXc-AH; Tue, 18 Jun 2024 05:00:59 +0200
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
Subject: [PATCH v7 3/9] drm/amdgpu: Enable async flips on the primary plane
Date: Tue, 18 Jun 2024 00:00:18 -0300
Message-ID: <20240618030024.500532-4-andrealmeid@igalia.com>
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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8a4c40b4c27e..0c126c5609d3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1705,6 +1705,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
 		drm_plane_create_zpos_immutable_property(plane, 0);
+		plane->async_flip = true;
 	} else if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
 		unsigned int zpos = 1 + drm_plane_index(plane);
 		drm_plane_create_zpos_property(plane, zpos, 1, 254);
-- 
2.45.2


