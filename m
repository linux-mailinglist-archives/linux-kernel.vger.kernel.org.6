Return-Path: <linux-kernel+bounces-281603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B794D8B7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F9D1F22F44
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8A516B725;
	Fri,  9 Aug 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBKRwJjM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C616A947
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242465; cv=none; b=m1+hkLesxgQg6+KQAe7CDmd707hc8U+5XawIsMpde0N3aiBn+MVWjnLZU1ONhjRetjXJwJvt7XysZgvc5K4p51+zcJE37dwso3CUddhWql55uNA18y8fg7Zit362PGFGglCMamtJeC2F7ekFCdRoDLGvi2dSmGKLNkj7C5qCil0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242465; c=relaxed/simple;
	bh=eXVnnnar9saKdQimYvtgB6nNuDPP7ZZqNvvDa0T9rQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IgzpytmidRS/LXLDKZ16DiItU9aWtmYwWIOiL+nsWX6RPncBpUpIZqcP4xx2eP7WWjxpdBdwDcrHGtMw4JVFi9x3A4B6YghmXbyF+PgrsbWqiX0jZwdIJvdKaOYnG5U6zjW1LD0Ql1Tksn2ln0XLVYvv4RWEKmrPngb+RDHAEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBKRwJjM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723242464; x=1754778464;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eXVnnnar9saKdQimYvtgB6nNuDPP7ZZqNvvDa0T9rQ4=;
  b=TBKRwJjMvLJWsrJDcNfp16QD7jp/0nY9CR8MNFFeHFusS8V0rWo8MB+V
   8KmxUsZUhy9gCy232NvbP3RUUqDvA0/vueEAmNL4hWf85OyRmB9EZu/W0
   9DLqcNsxwcb86CvUEQNvpdO6+Q0uaDH18veNAorhEnSftLN6jDBwIIE+W
   emacTzRMIrPlmt53RY9aTdBPxTHGlcmW2SaHT2VD+VxXxj+vq76Vpi6Cj
   FFhvYHu/e9rhu5bln4MHKlqnJoDh6nbYgX/a/c0D8gPAbn9S/KkeRTs+b
   utq9Uhhhc4RlDCvXto1E4eIodMdxEKgm4fyTNvV6SAeEW+ftUKf5DyBfU
   A==;
X-CSE-ConnectionGUID: lCuoLSe2SjuGhrmEv4ss+g==
X-CSE-MsgGUID: 4jY8krJvTZmWYdVNWbrqyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25229636"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="25229636"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
X-CSE-ConnectionGUID: +Wr2FzcjTtudxBeyHgq/XQ==
X-CSE-MsgGUID: ySeNZa6ZR7qYyxhmgGEDeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62641781"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v3 0/5] Use user-defined workqueue lockdep map for drm sched
Date: Fri,  9 Aug 2024 15:28:22 -0700
Message-Id: <20240809222827.3211998-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

By default, each DRM scheduler instance creates an ordered workqueue for
submission, and each workqueue creation allocates a new lockdep map.
This becomes problematic when a DRM scheduler is created for every user
queue (e.g., in DRM drivers with firmware schedulers like Xe) due to the
limited number of available lockdep maps. With numerous user queues
being created and destroyed, lockdep may run out of maps, leading to
lockdep being disabled. Xe mitigated this by creating a pool of
workqueues for DRM scheduler use. However, this approach also encounters
issues if the driver is unloaded and reloaded multiple times or if many
VFs are probed.

To address this, we propose creating a single lockdep map for all DRM
scheduler workqueues, which will also resolve issues for other DRM
drivers that create a DRM scheduler per user queue.

This solution has been tested by unloading and reloading the Xe driver.
Before this series, around 30 driver reloads would result in lockdep
being turned off. After implementing the series, the driver can be
unloaded and reloaded hundreds of times without issues.

v2:
 - Split workqueue changes into multiple patches
 - Add alloc_workqueue_lockdep_map (Tejun)
 - Drop RFC
v3:
 - Drop __WQ_USER_OWNED_LOCKDEP (Tejun)
 - static inline alloc_ordered_workqueue_lockdep_map (Tejun)

Matt

Matthew Brost (5):
  workqueue: Split alloc_workqueue into internal function and lockdep
    init
  workqueue: Change workqueue lockdep map to pointer
  workqueue: Add interface for user-defined workqueue lockdep map
  drm/sched: Use drm sched lockdep map for submit_wq
  drm/xe: Drop GuC submit_wq pool

 drivers/gpu/drm/scheduler/sched_main.c | 11 ++++
 drivers/gpu/drm/xe/xe_guc_submit.c     | 60 +--------------------
 drivers/gpu/drm/xe/xe_guc_types.h      |  7 ---
 include/linux/workqueue.h              | 52 ++++++++++++++++++
 kernel/workqueue.c                     | 75 ++++++++++++++++++++------
 5 files changed, 124 insertions(+), 81 deletions(-)

-- 
2.34.1


