Return-Path: <linux-kernel+bounces-440717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547899EC344
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A82A18833CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CB320CCF1;
	Wed, 11 Dec 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IuQZbhcY"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9378920C027
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887536; cv=none; b=jqgErU/QkmGxyVY5bxOa5Iq6oQuYjjQtXGNPuRQ4evXiZlwXHOVjYwyKqwk4S05dLkGVUyqY7+zQWQ3xtmtMUxWC0NDEAwpwrB7J2KyqSVmOYjP67OWSH++npiVKonLQebvrWiV705um7lt31tQsfdWx9F4/8fVmgONdN3YH/28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887536; c=relaxed/simple;
	bh=YkWxvdtxN8ODAbCifJkk+TSvwpETSCaW6KnyvrW+GEA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JSsuKfI3bvU8C5n7SCZaMHIvCUbkezERV7GaRW+XQi1LyNAQPEo17F5i9ZvAlb/Ri4y1IDmW9A5A+We9yOuo5ptUlWfDKV5ciYJ4P7RbRHxcanR/P8EFez4t/MkybVQaOCd53UKcIdKl28u+f38xnJuCvkRuDNBo1GTyc1KkTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IuQZbhcY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+f1nfrUYcs1wSQhhCmsy52L607zRZwkgSeCEyoxcG8Q=; b=IuQZbhcY43mPZuHRZgEmA67lN5
	MjELu5RzmKigWNbWZApCcxPGdw6+D719bPVZ6fHk5y968JkEly+FI+0xEdrrzz+OIZ4d1FgDAuRyF
	vJf14zLsN/yglbIffz3qmVxDxxYtoc4XEOMFhEZ2PWZpzL+R5qFalD+M8dV1iMldg+kCepeAmYBXl
	OeZG23rhZAmm3bNW4z6Vz1KBrA4FsCA+W3VYjNPQCdvtCGeMxSDGfrJ4qo2/P7n0HqsVqL+MPoAXY
	212fOI+qbYO8AW4BxJT+wMe0Vm0AjdoWpd56IKjsyIsvGp9thM0HkkaGrLP09JOtNXLTwrBIzgrVd
	A5F1gVOA==;
Received: from [179.118.189.35] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tLDLq-001lyu-7z; Wed, 11 Dec 2024 04:25:26 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v10 0/2] drm/atomic: Ease async flip restrictions
Date: Wed, 11 Dec 2024 00:25:07 -0300
Message-Id: <20241211-tonyk-async_flip-v10-0-6b1ff04847c2@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABMGWWcC/3WNsQ7CIBiEX6VhFgO0WnDSuDg6uJnGAEL7xwoNN
 I1N03cXO7l0vO/y3U0omgAmokM2oWAGiOBdCpRsMqQb6WqD4ZkAYoQVlBCGe+/GF5ZxdPphW+g
 wZ1xbI7TNtURJ64Kx8Fk27+h6up0vqEq4gdj7MC5Pg1jK9c1BYIKLXa6o4qIs1fMItWxBbrV//
 z4WkxK6Yu455bQwVlll/s1qnucvQLo8EPMAAAA=
X-Change-ID: 20241002-tonyk-async_flip-828cfe9cf3ca
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, dmitry.baryshkov@linaro.org, 
 Simon Ser <contact@emersion.fr>, joshua@froggi.es, 
 Xaver Hugl <xaver.hugl@gmail.com>, Daniel Stone <daniel@fooishbar.org>, 
 ville.syrjala@linux.intel.com
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Hi,

The goal of this work is to find a nice way to allow amdgpu to perform
async page flips in the overlay plane as well, not only on the primary
one. Currently, when using the atomic uAPI, this is the only type of
plane allowed to do async flips, and every driver accepts it.

This patchset re-uses the per-plane function atomic_async_check() to
this purpose, so drivers can allow different plane types. There's a
`bool flip` parameter so the atomic_async_check() can do different
decisions if it's a complete page flip or a plane update.

igt test: https://lore.kernel.org/igt-dev/20241211031820.115844-1-andrealmeid@igalia.com/

Changelog
 v9: https://lore.kernel.org/r/20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com
 - Add a 'flip' flag to indicate where the atomic_async_check() is being called from.

 v8: https://lore.kernel.org/lkml/20240806135300.114469-1-andrealmeid@igalia.com/
 - Rebased on top of 6.12-rc1 (drm/drm-next)

 v7: https://lore.kernel.org/dri-devel/20240618030024.500532-1-andrealmeid@igalia.com/
 - Complete rewrite

---
André Almeida (2):
      drm/atomic: Let drivers decide which planes to async flip
      drm/amdgpu: Enable async flip on overlay planes

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 11 ++++---
 drivers/gpu/drm/drm_atomic_helper.c                |  2 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  | 37 ++++++++++++++++------
 drivers/gpu/drm/loongson/lsdc_plane.c              |  3 +-
 drivers/gpu/drm/mediatek/mtk_plane.c               |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  2 +-
 drivers/gpu/drm/tegra/dc.c                         |  3 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |  2 +-
 include/drm/drm_modeset_helper_vtables.h           |  7 +++-
 10 files changed, 49 insertions(+), 22 deletions(-)
---
base-commit: c40c32cf71b90d85386fcc066c19feb23eb42804
change-id: 20241002-tonyk-async_flip-828cfe9cf3ca

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


