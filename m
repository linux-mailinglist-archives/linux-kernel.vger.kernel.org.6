Return-Path: <linux-kernel+bounces-203470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE48FDBAF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE5F286556
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65009EEC5;
	Thu,  6 Jun 2024 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q+QJYzRN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653B1373
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635277; cv=none; b=PkNpTzY514wgrTNL7RJq5QCdOEhZY5fMpYDPXFiCd7Aja159Gi36ZekARgAUoydesQ3cX5djqvbsFriX/zM0/obcaBpknvgn/oWCtv3sSE1MGRSejgmChLQhTAG7zemtTyvViaoHapBy8CG+F4WjyMbuGDa+BcV+V/4LqtBZIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635277; c=relaxed/simple;
	bh=lzJtHlgCun8Ywse+qQtajmZ7QYd4hIobqe/lcYmoP90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ImCq3OjXRDhi6RphYgTelYpyWHTWYL66TCu4lS4sRQ1UsNjp71QQY1DYk2uvzwQWvYllL0OadX83VyKGyMkhSXFODJ4TQQbJA5j6k0TYyzPE/BPDBYgFzPA1ryul+MnxKQaxvS4MGP8uE/j3Hbwvgxfc5rm9EPyFNb0rxB2NKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q+QJYzRN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717635274;
	bh=lzJtHlgCun8Ywse+qQtajmZ7QYd4hIobqe/lcYmoP90=;
	h=From:To:Cc:Subject:Date:From;
	b=Q+QJYzRNDdNIbSd2bjvzdE1wxoxmzu2NfmaEuMUR7YIrQpCoVRQsbCcScQfQ1g/Y+
	 7qhPdZ9VQYPuj60zfPY+kiLAsqDJrUwqBgEejeVLj9ilC2gMH3kar4Uxq9pxHhS/gW
	 5OVo9fJxTjXJsiLhN+Mbbk09E0SXFhvUWf95gk5f9h7fYCy9QC+tk+OGhRPavzKA5c
	 BkRUJNgz3TZ8lGGqgjmtOW6kRN9tnwVnfnNKvYiylfdELKdIa+i10RXS/bZxISQjM0
	 syvPwYUfB6QLDV1J2dmMjLgboADFpKUtU9tLt8lg1VhWr7Yc09aZy85QvnsJnX/TKs
	 mVqccGx5/ceBQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AC85D37821C1;
	Thu,  6 Jun 2024 00:54:33 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] Support fdinfo runtime and memory stats on Panthor
Date: Thu,  6 Jun 2024 01:49:52 +0100
Message-ID: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series enables userspace utilities like gputop and nvtop to
query a render context's fdinfo file and figure out rates of engine
and memory utilisation.

Previous discussion can be found at
https://lore.kernel.org/dri-devel/20240423213240.91412-1-adrian.larumbe@collabora.com/

Changelog:
v3:
 - Fixed some nits and removed useless bounds check in panthor_sched.c
 - Added support for sysfs profiling knob and optional job accounting
 - Added new patches for calculating size of internal BO's
v2:
 - Split original first patch in two, one for FW CS cycle and timestamp
 calculations and job accounting memory management, and a second one
 that enables fdinfo.
 - Moved NUM_INSTRS_PER_SLOT to the file prelude
 - Removed nelem variable from the group's struct definition.
 - Precompute size of group's syncobj BO to avoid code duplication.
 - Some minor nits.


Adrián Larumbe (7):
  drm/panthor: introduce job cycle and timestamp accounting
  drm/panthor: add DRM fdinfo support
  drm/panthor: enable fdinfo for memory stats
  drm/panthor: add sysfs knob for enabling job profiling
  drm/panthor: support job accounting
  drm/drm_file: add display of driver's internal memory size
  drm/panthor: register size of internal objects through fdinfo

 Documentation/gpu/drm-usage-stats.rst     |   4 +
 drivers/gpu/drm/drm_file.c                |   9 +-
 drivers/gpu/drm/msm/msm_drv.c             |   2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c   |   2 +-
 drivers/gpu/drm/panthor/panthor_devfreq.c |  10 +
 drivers/gpu/drm/panthor/panthor_device.c  |   2 +
 drivers/gpu/drm/panthor/panthor_device.h  |  21 ++
 drivers/gpu/drm/panthor/panthor_drv.c     |  83 +++++-
 drivers/gpu/drm/panthor/panthor_fw.c      |  16 +-
 drivers/gpu/drm/panthor/panthor_fw.h      |   5 +-
 drivers/gpu/drm/panthor/panthor_gem.c     |  67 ++++-
 drivers/gpu/drm/panthor/panthor_gem.h     |  16 +-
 drivers/gpu/drm/panthor/panthor_heap.c    |  23 +-
 drivers/gpu/drm/panthor/panthor_heap.h    |   6 +-
 drivers/gpu/drm/panthor/panthor_mmu.c     |   8 +-
 drivers/gpu/drm/panthor/panthor_mmu.h     |   3 +-
 drivers/gpu/drm/panthor/panthor_sched.c   | 304 +++++++++++++++++++---
 include/drm/drm_file.h                    |   7 +-
 18 files changed, 522 insertions(+), 66 deletions(-)


base-commit: 310ec03841a36e3f45fb528f0dfdfe5b9e84b037
-- 
2.45.1


