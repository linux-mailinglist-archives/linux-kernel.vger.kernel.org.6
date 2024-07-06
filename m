Return-Path: <linux-kernel+bounces-242988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653CA928FEC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 03:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00ED1C22348
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 01:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D459210A2A;
	Sat,  6 Jul 2024 01:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FFirQdfR"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5170A95B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720228359; cv=none; b=iJ95vZPyMkytHEO6Du0SDvoLVIgccZ+dcQzQhWvlHjLIwE2p/zYGzswilmnCOoWACjg1u1fy/P0McXwwH5QIanXiD0ygxDPQQ9+ZDyzzRWi6GiMTIrJ+ISOoIYvnRav65Wx5Gafiq9zBpSBz1O68qhKfNz/jt+C5NiW+Uf/0RxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720228359; c=relaxed/simple;
	bh=816rS1LbDDHATDQTUEobneLX9rO4Id+0jacMAd+X4kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g04HHEkmo78QLUNoET7NBBVi8jbi0QsoQHEg27qL2Rz5oRLZKQoMWuN84XUACVr/cyHX17rO8LWhP58gQpIyEWckHpvDP3GZcp4HbLALqfkXqf+7wZjeihCeTzrmilCPG5/XQ10VJYFQDoR7X9xzPQsM73EKXMIbSCZPecTgAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FFirQdfR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=l5JcqvwpauG1MaLapU7aLgFKkaqUviY9iW4gOJf2wGk=; b=FFirQdfRI+woOVRRIB8oKh129H
	0U9nrpYOfaRYOAl4k7nk3Nc2emA2njzGqHLC1xHYztHMKzzozA/WYwXpevLq/gE8URnd9wVWVNxLV
	Lyx5BdABJvUl9h+N4mmLUDGIxCz7kLE0ZDelcf/qB11grA5VW7ktE+3+b+2BYoVDthq8uRUPJ84yC
	ci/Z6XkfUQfJsw5rvANXvw70Erag/mQqjttJLCWGJJRg2KN9BG941voEifhidjEtg4iMBP4MFFHK9
	/5UpOnUFWEYXZcLjn667A3DjJyAT0q0lNHoo2OpDf61aK3hgPmKtzQSaXfLwlnmN6MgZyjuX3+zO4
	fj6adT0g==;
Received: from [191.19.134.16] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sPtyc-00BhBm-0K; Sat, 06 Jul 2024 03:12:34 +0200
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
Subject: [PATCH v8 2/2] drm/amdgpu: Enable async flip on overlay planes
Date: Fri,  5 Jul 2024 22:12:14 -0300
Message-ID: <20240706011214.380390-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240706011214.380390-1-andrealmeid@igalia.com>
References: <20240706011214.380390-1-andrealmeid@igalia.com>
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
2.45.2


