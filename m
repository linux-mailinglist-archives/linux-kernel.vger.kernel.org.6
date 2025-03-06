Return-Path: <linux-kernel+bounces-548873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37221A54A63
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88971188E98A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38220B1EB;
	Thu,  6 Mar 2025 12:11:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751A2080E9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263077; cv=none; b=j5iFx0tfXZ09E8hOZaJFVttm1/T6x4U7HXPy3D8fw7Yh/owxzeWGcIondkoJmYUtQMYFPSnTmFZD64q3Z2BMCsOGKYA44ut+ZsER3wKMd6SvCnmhh70U8NNZkHiGui72W0H5leGHeZq1xMlFtxlsIXbRFLePfrtxQUO/+ojae+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263077; c=relaxed/simple;
	bh=JKhcgobEGzwQL0hpfOh1SDpSUKttz7q1NphBeIB9ums=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NOdAG/fGZ4L+Nz8OJ/G07GjKIgWpjY1uKGq4GGPShamfiar/vpz7re2FZbpDlvs1ZzsJGKwh8IP750UImCD3gpG31gS9qyEDiH175i+yyFk5leB6PH/F8FaJ9/vHSDxCKXYUOlKAGmjQKmw2N6+13xQf3WkexRoMWn7BFx2JeNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC0CC1007;
	Thu,  6 Mar 2025 04:11:26 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D0723F673;
	Thu,  6 Mar 2025 04:11:11 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: 
Date: Thu,  6 Mar 2025 12:11:01 +0000
Message-Id: <20250306121110.1647948-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH v6 0/9] coresight: change some driver' spinlock type to raw_spinlock_t

In some coresight drivers, drvdata->spinlock can be held during __schedule()
by perf_event_task_sched_out()/in().

Since drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this,change type drvdata->spinlock in some coresight drivers,
which can be called by perf_event_task_sched_out()/in(),
from spinlock_t to raw_spinlock_t.

from v5:
   - Fix build failure for coresight-tmc


Yeoreum Yun (9):
  coresight: change coresight_device lock type to raw_spinlock_t
  coresight-etm4x: change etmv4_drvdata spinlock type to raw_spinlock_t
  coresight: change coresight_trace_id_map's lock type to raw_spinlock_t
  coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
  coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
  coresight-funnel: change funnel_drvdata spinlock's type to
    raw_spinlock_t
  coresight-replicator: change replicator_drvdata spinlock's type to
    raw_spinlock_t
  coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
  coresight/ultrasoc: change smb_drv_data spinlock's type to
    raw_spinlock_t

 .../hwtracing/coresight/coresight-config.c    |   8 +-
 .../hwtracing/coresight/coresight-config.h    |   2 +-
 drivers/hwtracing/coresight/coresight-core.c  |   2 +-
 .../hwtracing/coresight/coresight-cti-core.c  |  44 +--
 .../hwtracing/coresight/coresight-cti-sysfs.c |  76 +++---
 drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  26 +-
 .../coresight/coresight-etm4x-core.c          |  18 +-
 .../coresight/coresight-etm4x-sysfs.c         | 250 +++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
 .../hwtracing/coresight/coresight-funnel.c    |  12 +-
 .../coresight/coresight-replicator.c          |  12 +-
 .../hwtracing/coresight/coresight-syscfg.c    |  26 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |  14 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  48 ++--
 .../hwtracing/coresight/coresight-tmc-etr.c   |  44 +--
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +-
 .../hwtracing/coresight/coresight-trace-id.c  |  22 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |  12 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
 include/linux/coresight.h                     |   4 +-
 21 files changed, 314 insertions(+), 314 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


