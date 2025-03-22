Return-Path: <linux-kernel+bounces-572650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CFA6CCAE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674783AA6EA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7882343C9;
	Sat, 22 Mar 2025 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="WAozlYR8"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184E522A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742678973; cv=pass; b=tsEdGks3YiRbpjlq8ohwbFfMSFH7729Owg6BNDzoH4KAcAZTqITSmTMh9g9b8U2lu3zdgE9rAQha42IVbIbmLmI9bfmYrhUpEo6/s2M8o29nv1I4uZYexD4lfM72uHU8Gdy/YGyu0aD63FcfRydgp4DUU55mmT68BbCVy+Ko21s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742678973; c=relaxed/simple;
	bh=dSI6wdkjoLt/f9xKg8EHVHdORm6ZaoxPx25QSs5vQ6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qe/5fwEP4DNPWGNb/ferOKDe9YUko9i44nFpZTINUxc2lEmZ2NFjm5g7FpU5Oz9+FYKa5lr12BU66x5VWJP1FSJocivfnGS/cUJXnSm3izAuJBdMeNzFU2B8RLXLnhMToqBsvg7cAM1WUlEnRlUyCp5A2NDmxturvd0Kmy6bU+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=WAozlYR8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742678947; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZjqiARckQj8Q5FCCTSOuKI7w7BzUqMYUFoXhUKddxfkaTGbEMlp+Ks7bThcFAjSaksGq7ZSWwNamby9IfaFKARMCyH/p29EQtsUENDp2L9mvb5doo5MR4d35U/gI84kZaO/ue+FF12Aka6q8FbA5gwA+uIehZntR42sbl2tflK8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742678947; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e7NaXGdN2bcSEdKF9Rgw4qLX1QH7j7xPDpb1nqrJX0M=; 
	b=OO/57Nj90J/w5CqT/AWF9yaMTil3E/g2SkdSNODN+oIHgsb7dHFwVzxnqPyE4DH/pwlPZ8wU51IIwwCICA5pucMkdJrFkL4SKxOuGNHVA8ENDspnsq2wqzxwrIQk+ZmLVqXhSHTX3oDVIrEG4L54ACWhAfTdH+qESiASwdEQStQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742678947;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=e7NaXGdN2bcSEdKF9Rgw4qLX1QH7j7xPDpb1nqrJX0M=;
	b=WAozlYR86G9HOI5EBtdioq0gmeyryiP803EZiYe1bGGl/wflK1uvXR4Sz2zt4T6N
	iCQX29mQVi5/PN+UFyYvjPxiDeJXWvwo2ydV9T9GgX74mwLhsi4TPwv8EuBL3jNHRRU
	TuwlCr5a++kiL3rMeiEoqkGtCM3+rH6GRlkEPyDQ=
Received: by mx.zohomail.com with SMTPS id 1742678945132474.9358248680762;
	Sat, 22 Mar 2025 14:29:05 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Qiang Yu <yuq825@gmail.com>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v20 00/10] Add generic DRM-shmem memory shrinker (part 1)
Date: Sun, 23 Mar 2025 00:25:58 +0300
Message-ID: <20250322212608.40511-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

This a continuation of a year-old series that adds generic DRM-shmem 
shrinker [1]. The old series became too big with too many patches, more
reasonable to split it up into multiple smaller patchsets. Here is
the firtst part that makes preparatory DRM changes.

[1] https://lore.kernel.org/dri-devel/20240105184624.508603-1-dmitry.osipenko@collabora.com/

Changelog:

v20:- Rebased on recent drm-misc. Added r-bs that were given to v19.

Dmitry Osipenko (10):
  drm/gem: Change locked/unlocked postfix of drm_gem_v/unmap() function
    names
  drm/gem: Add _locked postfix to functions that have unlocked
    counterpart
  drm/gem: Document locking rule of vmap and evict callbacks
  drm/shmem-helper: Make all exported symbols GPL
  drm/shmem-helper: Refactor locked/unlocked functions
  drm/shmem-helper: Remove obsoleted is_iomem test
  drm/shmem-helper: Add and use pages_pin_count
  drm/shmem-helper: Use refcount_t for pages_use_count
  drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
  drm/shmem-helper: Use refcount_t for vmap_use_count

 drivers/gpu/drm/drm_client.c                  |  10 +-
 drivers/gpu/drm/drm_gem.c                     |  26 ++--
 drivers/gpu/drm/drm_gem_framebuffer_helper.c  |   6 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        | 145 +++++++++---------
 drivers/gpu/drm/drm_internal.h                |   4 +-
 drivers/gpu/drm/drm_prime.c                   |   4 +-
 drivers/gpu/drm/imagination/pvr_gem.c         |   4 +-
 drivers/gpu/drm/lima/lima_gem.c               |   4 +-
 drivers/gpu/drm/lima/lima_sched.c             |   4 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |   2 +-
 drivers/gpu/drm/panfrost/panfrost_dump.c      |   4 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   2 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       |   2 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c   |   6 +-
 drivers/gpu/drm/panthor/panthor_gem.h         |   4 +-
 drivers/gpu/drm/panthor/panthor_sched.c       |   4 +-
 drivers/gpu/drm/tests/drm_gem_shmem_test.c    |  28 ++--
 include/drm/drm_gem.h                         |  15 +-
 include/drm/drm_gem_shmem_helper.h            |  45 ++++--
 19 files changed, 167 insertions(+), 152 deletions(-)

-- 
2.49.0


