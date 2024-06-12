Return-Path: <linux-kernel+bounces-212160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A523905C13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81721F22493
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BDA83CC1;
	Wed, 12 Jun 2024 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Pj8oAdlG"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473876A8DB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221065; cv=none; b=hUgism7Zwfhnze1q6PHPhx8X2n2h2ZFsq0ux+1RYwj4mAzrR+M/vfun0GipKnaBbHhe+Q0HCdfGomG8g9JK01ONj+J2Mf4owKRafe+Wm7cg7ELcw3KEzcCnDmcVQ+gC4Ss0uxDuMlYcOQXmLsVOtGqYhLvbsCmR3KcV2afaVro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221065; c=relaxed/simple;
	bh=bAgvQLjry72ucsu6tyvE+IoTpk3LdoXsF+98JxrZlGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfrBQqgQ8DZfWo/DbAG7u0e/HvshbAcS6YD+tkRuXPnOyIqzNRS+qZZmLsyIVXWYa0WHJHAeJeEKi421onSADsq3aIdcejgWIyIyhx9SvEN0ZwsuVnuDn0MjzPpvnQ271/2PrQS4ZDy7CYbjisHIk9QyJ9DWVPG+ZS6F8r4OAi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Pj8oAdlG; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rJP3bi32e6r8RV+D2X0N8VAFuxM3UDfcxB2VNYPJ2TI=; b=Pj8oAdlGr1ZqbcE2L91WeNekxr
	UJtQDy2roFDtBjZdT9mC+3YBbRvFn8Akid+p+qWIVSNiBkorGQXAywBjBl3PywJpv0B0Nrnyfx4Ql
	3QmcQ3OVRTLFMbqmN2S9Rw07Vm7tXgLhOXCwBpeD0agZtb8wB8Lo6Ed4LU9Gw3sw7BD0VFgXx9ClE
	S26I6mzsO+3y1fY89GpB8fbN8opQSeRA1j+1i+nY0aVJ0Qa0a3VJZZhQHzw1AobZV+quj0ItSHQCy
	GJZScBPIAZxwqbOJ1T7XHMemb9BczneTGknNwktnvaTeTNbF4ICoZgzVF99oH8YudzeOueMxWqekE
	cOaa+Knw==;
Received: from [191.204.194.169] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sHTmp-002RtF-F2; Wed, 12 Jun 2024 21:37:35 +0200
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
Subject: [PATCH v5 3/3] drm/amdgpu: Make it possible to async flip overlay planes
Date: Wed, 12 Jun 2024 16:37:13 -0300
Message-ID: <20240612193713.167448-4-andrealmeid@igalia.com>
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

amdgpu can handle async flips on overlay planes, so mark it as true
during the plane initialization.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 8a4c40b4c27e..dc5392c08a87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1708,6 +1708,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
 	} else if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
 		unsigned int zpos = 1 + drm_plane_index(plane);
 		drm_plane_create_zpos_property(plane, zpos, 1, 254);
+		plane->async_flip = true;
 	} else if (plane->type == DRM_PLANE_TYPE_CURSOR) {
 		drm_plane_create_zpos_immutable_property(plane, 255);
 	}
-- 
2.45.2


