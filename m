Return-Path: <linux-kernel+bounces-276338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D0949241
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B611C21721
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9921C16F;
	Tue,  6 Aug 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MhY5m2Tm"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892F20FAAE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952406; cv=none; b=nNtWuDqECzD5PXLQppSPJCWGL6yBR0jcxyVYbMiP1qSHl49QFgLPyKDeIfRAIV5Xa2y8bB5PHDh7QciYNZE2j9dvh5Epe4ntNG5ER+fhMg6K1EsU5IikPPmbQi5ZVz2AGToc0o2XtYfNdMOSdQUlLQPDfdFRzMwL11C9O+tykdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952406; c=relaxed/simple;
	bh=YKjaVlnYwvDMUwIRefdrh3hf3jE7tZ0320zK6xR2zzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2ss4CdP8fnOTMmRxKc/AeSW81D21f7z0ebNOXL0jLIGbr39PYAe/41/i3YC4ITLiZ9d9zm/lShtLyn48vnBDGTIW2YpcsDvmlpzJCuVsIecxn4a20bs7ZTR/8ApoA6w0SAOutOBpCfb2Vl4yVw1XOme1FT+lBOatlyjBg7qfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MhY5m2Tm; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uIfFCH4RzJWnyQJXqXggUAjhA0rEwWO5SWfx9Tsr9MI=; b=MhY5m2TmOCEDBORFXKqSbybdbu
	NWXGMREia9Tur5p4rtJXB7/RvcQv5ZIiVeQysvjG8MAAbEIpOj7pUzCgVKdNLaD18Z0am2we1ON7H
	2yn7T15P43egeA0GHJBLAfft1G0Uwt5/zx8HCTGYuWY5W3shn7DACOlnwG1onv56n9S7kUy6LG1YK
	L1UArUj453kz+SsPolWwW2J5FiV6OdGqZDjSInw6fxIN56E0HjGEcaI8JyxNeML+iiIcZNWum1U0F
	6g28ZE5rM1deG2qF66ErZZsdKR4nZG9KSm1ri9pu3k/0+rIaJJQx91NjDBJvkt6EfGC5u33stDc2O
	7U/USB3A==;
Received: from [179.118.186.198] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sbKcm-008buR-K8; Tue, 06 Aug 2024 15:53:17 +0200
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
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RESEND v8 2/2] drm/amdgpu: Enable async flip on overlay planes
Date: Tue,  6 Aug 2024 10:53:00 -0300
Message-ID: <20240806135300.114469-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240806135300.114469-1-andrealmeid@igalia.com>
References: <20240806135300.114469-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

amdgpu can handle async flips on overlay planes, so allow it for atomic
async checks.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8a4c40b4c27e..125402964289 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1175,8 +1175,7 @@ static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 					      struct drm_atomic_state *state)
 {
-	/* Only support async updates on cursor planes. */
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+	if (plane->type != DRM_PLANE_TYPE_CURSOR && plane->type != DRM_PLANE_TYPE_OVERLAY)
 		return -EINVAL;
 
 	return 0;
-- 
2.46.0


