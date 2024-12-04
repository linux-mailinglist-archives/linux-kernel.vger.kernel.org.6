Return-Path: <linux-kernel+bounces-432001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99569E43BA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A99A284794
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C001C1A8F95;
	Wed,  4 Dec 2024 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="cdY9ee0j"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B7F1A8F79
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338232; cv=pass; b=tl4W/Yl+i4UyhR54+O6Vb+5ZgrsHXHvydT+iBDWhAdELO4S7gZWuLXU8r7H6ZslHrIKcWwHLzxiUEn8pVNFRHVMG3X/GCXdgErJnNbtn6u+mZWl/xXiuaKcPafac6hAm/QLpiA7LVes0/B1j7N0RXNKPDHGTGQ47tBRD3jwyoUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338232; c=relaxed/simple;
	bh=UQ8CyaT+G6CO1MNQZaoFu52GbCTwcPFKJbeg627E0uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kHUjkch4MofbXKfupN7EN+53Akh50X3YbO41QSoQJbrlQN2Yxg9LRss2l3FKVKhhVa+C9SkxDwxjKkfJQN6ZEAoSVoyxRJ15wdYQGeAyr2nInbXySPRwkb8e8WV25gWmWkaqXuBWxwvTrvWN8irAtKNpD5YpgpYtScNjuWoXDJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=cdY9ee0j; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733338208; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MRPg3ZF8WzrLlZbu5KDzi3farPM+wzZPYnFOr45MXpiRfIAAwsCL0Gh8IY8yYFAJnXOrmMEfQ4Yd/4AhYC2MilaFw9D5MJv+ENCoNcOHZIv7LH2mRXvX50VI5SJVTt4t5fjElJQZOyGGOAH6TCa3ZNKaNNO/69tqhdA2kphDlS4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733338208; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eMiDbUQjIGiB/p2gFdGIlZnBJvVTiZWBvpKaJbWxrdI=; 
	b=G4dLMvTuyezxuVglT36hPCIqRYDPupO8JSfmEcl/Kml3gQ9IR4WaeRhbTjaGq/nsnxa7Z9EsHgiHtO8AqQ/xAS6HtGZTZqVPOUEryWrdTtiXXJSk3YLC5yipdrYNkUCpQ1XORpjlBNb9wBZCHLVOG0UEQVeL19j1ixl3w+9fB9A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733338208;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eMiDbUQjIGiB/p2gFdGIlZnBJvVTiZWBvpKaJbWxrdI=;
	b=cdY9ee0j+52odUKqkZLPfEXuIX2mkqRjTt6lipZ7WoJ78zirAjLNeQnZtZ3mw3I1
	1oTuVXhNgjvfrok0iS7rqf7Pa0W+soV8CE9DbKcr4YJ1Xt5s4iB2mXGjDVD5enZGajv
	cU9BbTeAZod2uCM2A7bPBLQl7xylNVoQt+4q4JCE=
Received: by mx.zohomail.com with SMTPS id 1733338207712916.1794849849406;
	Wed, 4 Dec 2024 10:50:07 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/9] Some Panfrost fixes and improvements
Date: Wed,  4 Dec 2024 18:49:29 +0000
Message-ID: <20241204184945.1477677-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v3 of https://lore.kernel.org/dri-devel/20241128211223.1805830-1-adrian.larumbe@collabora.com/

This patch series is a collection of minor fixes and improvements I came up
with while working on driver related stuff.

Changelog:
v3:
 - Minor convenience fixes to patches 3 and 4 in the series
 - Move unmapping of maped range of BO to the function's error path
 in case of BO mapping failure, also for putting BO's pages
 - Split patch 6/8 into two: one makes sure the Job IRQ enablement mask
 isn't recalculated at every device reset and uses the same expression
 everywhere in the driver, and another one that breaks the enablement
 function into two stages.
v2:
 - Removed commit that provided an explicit fence cleanup function
 - Added commit for removing unused Panfrost device structure member
 - Refactored how optional job interrupt reenabling during reset is handled
 - Make the way errors and successful return values are delivered from inside
  panfrost_mmu_as_get more according to standard.
 - Simplify unmapping of already mapped area when mapping the pages of a BO
 - Fixing management of runtime-PM reference counts when failing HW job submission.

Adrián Larumbe (9):
  drm/panfrost: Replace DRM driver allocation method with newer one
  drm/panfrost: Handle inexistent GPU during probe
  drm/panfrost: Handle job HW submit errors
  drm/panfrost: Handle error when allocating AS number
  drm/panfrost: Handle page mapping failure
  drm/panfrost: Don't rework job IRQ enable mask in the enable path
  drm/panfrost: Make re-enabling job interrupts at device reset optional
  drm/panfrost: Add forward declaration and types header
  drm/panfrost: Remove unused device property

 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  4 +-
 drivers/gpu/drm/panfrost/panfrost_device.c    | 58 +++++------
 drivers/gpu/drm/panfrost/panfrost_device.h    | 13 +--
 drivers/gpu/drm/panfrost/panfrost_drv.c       | 68 +++++--------
 drivers/gpu/drm/panfrost/panfrost_dump.c      |  8 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  6 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  4 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c       | 64 ++++++++-----
 drivers/gpu/drm/panfrost/panfrost_job.c       | 95 ++++++++++---------
 drivers/gpu/drm/panfrost/panfrost_job.h       |  1 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c       | 95 ++++++++++++++-----
 drivers/gpu/drm/panfrost/panfrost_mmu.h       |  3 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c   | 31 +++---
 13 files changed, 254 insertions(+), 196 deletions(-)


base-commit: c6eabbab359c156669e10d5dec3e71e80ff09bd2
-- 
2.47.0


