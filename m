Return-Path: <linux-kernel+bounces-392712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8C9B975D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06961C20E7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44391CDFDE;
	Fri,  1 Nov 2024 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b3q7wTKX"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799621AB523
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485453; cv=none; b=GV67CqUNpg+wHrU+qmuagkfLTl7xbsIbDbEBE6FdPpYn0V6KCVRBLwXfZFoxCL7sWpdr95slc+OQqLBoTD5AR9WLJo8b3r7RVd2YiZ/Sg+w/UP2G2fEsVrRmJA+vhtAwKjZ6CITEPF7TSsnNcv5dSPs6bOeiQxcU4m7qpjMG7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485453; c=relaxed/simple;
	bh=JSR7XBmTLuEqx+cUht/gOA3iQQvWivPINLdrax9VCeE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jn/8oaKCxAgK1+3d6Hetr+f43Sc5RI4emcxg5AwKHBSqYzPU3QCrk3On+8Xh3nqDgMTFLbxD1ApOZAWLNBIUuVSltHtVheJctXx3ri3gxgCNleEQPnWZ1TvCKXCh95QpkwEW1ReCfh05dhH6siVX5TDDuSw06bbMVH7lAwTi5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=b3q7wTKX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=J2THoAE38i/SY5H7J+EKG3Am7KaMgQ90RGTrVSMS9k8=; b=b3q7wTKXmOvzn75MQYxs12XTb8
	xH3xYcKk+Mr3vzTKmv0yp48aV7Y+tAxSDnk3yY39MGUPCYILY4JRco45pqLGsng5MUuKViWZ7foOd
	/D3PUe+qzDVlJp8yTgKppQm9YJkbtPGjVv7OwA3WGeDZGtZuLggIsmJ+nCC67Y2d7GSpgVCLCAlRa
	HD3dL1RJr9d2mt8V555a/3+nHalfdfWPqBihEpMnFtYwx7ZznwgLTIqaCrJDRjl50XLYJtYu0J6YR
	X+xcHoPBAIkjZl1rnIWbAlL1WF3p0jrabafU+ioDpyVLraR4aM9w0uyYZdhrH9Ju0/eQQGwceUbyS
	vWAwBwBQ==;
Received: from [189.78.222.89] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6wJX-000XDx-PK; Fri, 01 Nov 2024 19:24:04 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RESEND v9 0/2] drm/atomic: Ease async flip restrictions
Date: Fri, 01 Nov 2024 15:23:46 -0300
Message-Id: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALIcJWcC/3WNsQ6CMBRFf4W82ZpSMFAnB1kddDTEtKWFF7ElL
 SESwr/bdHc89+aeu0HQHnWAc7aB1wsGdDYCP2SgBmF7TbCLDIyyMqeUkdnZ9U1EWK16mREnUrN
 aGc2VKZSAOJu8NvhNyifcm0dzu0Ib8wHD7Pyanhae2v/ShRNKylMhc1nzqpLdBXsxojgq94F23
 /cfd+4eM7kAAAA=
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

As per my previous patchsets, the goal of this work is to find a nice way to
allow amdgpu to perform async page flips in the overlay plane as well, not
only on the primary one. Currently, when using the atomic uAPI, this is the only
type of plane allowed to do async flips, and every driver accepts it.

In my last version, I had created a static field `bool async_flip` for
drm_planes. When creating new planes, drivers could tell if such plane was
allowed or not to do async flips. This would be latter checked on the atomic
uAPI whenever the DRM_MODE_PAGE_FLIP_ASYNC was present.

However, Dmitry Baryshkov raised a valid point about getting confused with the 
existing atomic_async_check() code, giving that is a function to do basically
what I want: to let drivers tell DRM whether a giving plane can do async flips
or not. It turns out atomic_async_check() is implemented by drivers to deal with
the legacy cursor update, so it's not wired with the atomic uAPI because is
something that precedes such API.

So my new proposal is to just reuse this same function in the atomic uAPI path.
The plane restrictions defined at atomic_async_check() should work in this
codepath as well. And I will be able to allow overlays planes by modifying
amdgpu_dm_plane_atomic_async_check(), and anyone else have a proper place to
play with async plane restrictions as well.

One note is that currently we always allow async flips for primary planes,
regardless of the drivers, but not every atomic_async_check() implementation
allows primary planes (because they were writing targeting cursor planes
anyway...). To avoid regressions, my patch only calls atomic_async_check() for
non primary planes, and always allows primary ones.

Thoughts?

Changelog
 v8: https://lore.kernel.org/lkml/20240806135300.114469-1-andrealmeid@igalia.com/
 - Rebased on top of 6.12-rc1 (drm/drm-next)

Changelog
 v7: https://lore.kernel.org/dri-devel/20240618030024.500532-1-andrealmeid@igalia.com/
 - Complete rewrite

---
Changes in v10:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v9: https://lore.kernel.org/r/20241002-tonyk-async_flip-v9-0-453b1b8977bd@igalia.com

---
André Almeida (2):
      drm/atomic: Let drivers decide which planes to async flip
      drm/amdgpu: Enable async flip on overlay planes

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  3 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  | 39 ++++++++++++++++------
 2 files changed, 30 insertions(+), 12 deletions(-)
---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241002-tonyk-async_flip-828cfe9cf3ca

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


