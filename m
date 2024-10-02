Return-Path: <linux-kernel+bounces-348258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21E98E4B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5AC81F248FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA552178E4;
	Wed,  2 Oct 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jq7+Swt6"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AC219412A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903827; cv=none; b=KCJwcWGw66KkmvR9t4D189n/iq8K+fHtaKcvBnJ/k/Nc+bLmFLdfx6dg2WDfz1Ej0PiWlKPRXzcOmC3Psy8/LawfC8anSUfPCVsFk5/Vi4zBIKSYCVy1deiUO1nWLkdp9W5ieMNqgT8bXPlMdMknLojLZb+iJ5PrQK/et3T25tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903827; c=relaxed/simple;
	bh=2XhL24qpoYM2ra6XSs4x/LiUL18E4OUUWRXgmoWFa4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TmTvrW3FlZylpQeRgOLPHteD1BW4utBj9u6zEGfQE2pVsZoxbksG3Z5M8lL+t2wY4P63qKVLCRzP8IhBaXPwTXiJlwjMj7QVm75oOhi6tYOca+JSmJ3sh/h2a3OlZMRWDYGK6GEhQRNa/hM1QJPQ2ppzoaV8SRX6kL77vxL3lpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jq7+Swt6; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zw3CnjmaMmXgMlS66QKNCXXAJ2JyjAKjSarlVGPessY=; b=jq7+Swt6pPi+1CZq+aa73tlXFE
	UEg1rrTLgRk8uyVFpDOQwMlGNyi0GTHfmIXxXyvzRoaKi1mlmJLdXe4ehsTyWft4hmuxhtgty3Wgo
	7sUCXC5X5Te1e6uqmxgLztqoh1OTHK3RScBRpCP+FqmZVf10f56Uzw5e/GZCnsg2iH87np5DMmy/Z
	KS1Us5TtKWsMrX99XzwAl2y38CIZEMN6ER+4T5V4bXkOyLIszjaSH/63jS+E6CoqzN+ltoMbwOurz
	huCA4/nX3WL81aeRYnNZ6jrZ453hNSBU9l+mIPOsHbsajLJPT7WJsefJ7R49N4BMKw4FEGAqT1h6y
	JojBnn3w==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sw6i9-0042sU-RU; Wed, 02 Oct 2024 23:16:42 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v9 0/2] drm/atomic: Ease async flip restrictions
Date: Wed, 02 Oct 2024 18:16:04 -0300
Message-Id: <20241002-tonyk-async_flip-v9-0-453b1b8977bd@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABW4/WYC/x3MQQqAIBBA0avIrBPMWmhXiQiZxhoKE40oorsnL
 d/i/wcyJaYMnXgg0cmZ91BgKwG4uDCT5KkYtNJtrZSWxx7uVbp8Bxz9xlEabdCTRd+gg5LFRJ6
 vf9kP7/sBlsIyB2IAAAA=
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
X-Mailer: b4 0.14.1

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
André Almeida (2):
      drm/atomic: Let drivers decide which planes to async flip
      drm/amdgpu: Enable async flip on overlay planes

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  3 +-
 drivers/gpu/drm/drm_atomic_uapi.c                  | 39 ++++++++++++++++------
 2 files changed, 30 insertions(+), 12 deletions(-)
---
base-commit: e32cde8d2bd7d251a8f9b434143977ddf13dcec6
change-id: 20241002-tonyk-async_flip-828cfe9cf3ca

Best regards,
-- 
André Almeida <andrealmeid@igalia.com>


