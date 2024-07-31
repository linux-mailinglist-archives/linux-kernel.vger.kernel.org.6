Return-Path: <linux-kernel+bounces-268369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36C79423D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5663FB23CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96F04C83;
	Wed, 31 Jul 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAMRvlAb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E7938C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385833; cv=none; b=Ih97qnnuzDmru2HocVpm+KTxDRjuDCFNuofmDvOSDRLc/TGanwfyHKTXfCPciUd2VmwXoaRnSM/bSxz1EbXRHIvxZ+QkNK0E5Wl6LYdTRd34iEdliNt+2XJDi/VaxTsUYcZokgCuAWew4jF1Usc83TPcZp8afwFbyuLvKo4AkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385833; c=relaxed/simple;
	bh=d8JIn2ZBV5v6QHx36vp89HRxtaEmlG8HaXXFjyYOxO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VSqHwU20l7LOP0FVOP+jQsrGrIpnSMevHFYwjBshlA+67LWDtxlX+1u6muBntNGJaHEBVObMxsg5asyCAveDwSeElbz9RM4DCZFp832R0eGREzv9UChymPgmqRm60gZMvN+vul5pnnTAr1TZpljmjlI95jR0cJZjhuC/amYOX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAMRvlAb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722385831; x=1753921831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d8JIn2ZBV5v6QHx36vp89HRxtaEmlG8HaXXFjyYOxO4=;
  b=kAMRvlAbFdEi3wiUGGqUUnjDxnnWMlI6PaA3I8MUlb/0KBkgTtiqZy9T
   esGrLleGck7GM1ZWB4ixTp/DwDl1TuRAb0xGl7SarEMBRkZEhB9A7/iq5
   rxt5N9iMWIl7tEpNC2XNsEf5fv+hM+JHJXfaWxOffJ6W776bgLMITO5kw
   nPbsISvPqc0WBAKI0LL8SF7b2wfW58iaHrn/hy4hiFF9y422g8CJyKkae
   hf2ElVM76q6wTeJHkP+lvvsakZUoB6zbKxnPXInoCQgdusCnBlm35f/hm
   zI4sqFAPTWur8ElPl0UL90TR6iu6Zg2kIOv/kz4FDenvT24gdq0rB+Woq
   w==;
X-CSE-ConnectionGUID: j8y4zT0ySX2BzMsotEoMJg==
X-CSE-MsgGUID: wLQ3hnhZR0m/CFlG0MkHWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="23156071"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="23156071"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:31 -0700
X-CSE-ConnectionGUID: qZuQNejkSsGM5VXM0quvzw==
X-CSE-MsgGUID: j3QBpmjZS4etI25fHRlklA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="77781796"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v2 0/5] Use user-defined workqueue lockdep map for drm sched
Date: Tue, 30 Jul 2024 17:31:14 -0700
Message-Id: <20240731003119.2422940-1-matthew.brost@intel.com>
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
 - Don't RFC

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
 include/linux/workqueue.h              | 25 +++++++++
 kernel/workqueue.c                     | 75 ++++++++++++++++++++------
 5 files changed, 97 insertions(+), 81 deletions(-)

-- 
2.34.1


