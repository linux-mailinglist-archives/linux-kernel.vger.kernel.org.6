Return-Path: <linux-kernel+bounces-228441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7075915FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6FE21C2090D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E88A146A83;
	Tue, 25 Jun 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEKZBC4P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73347A62
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300302; cv=none; b=RxQKFTRxxHe4X3XzjIwChvHm8YkCSBd1UdhsGxQi70siOfcbUKXY7UbtRBYrWX7hYCTzXtqzWEWBCiANesCYVLtqOZI1feWLsuwQCJwH4INOl6odseCz+I54cLLvU7mQEJM6oGtXVUQ/sYcOPRaS9zVy/30zgZv40L4LMFR4ScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300302; c=relaxed/simple;
	bh=05UkyNvzxPOHuB+H1sIZnJVrMIWtz2bLdebzpFOnY+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CDPRscc52tnk15eEQAAyc8EmV3D6RyP77iqw2z7teps7LvfyH9y+8t8hC9rrHs9N8XD0+QJyjqLJxTx1ss6bN/Lv93eHcX03drP157GJaxV61uqhRP0nLD7YLkItlA5nxhvjB0A+6IMmeUg0Lfl6jW0bIP+z4tADib+N/kPcmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEKZBC4P; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719300301; x=1750836301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=05UkyNvzxPOHuB+H1sIZnJVrMIWtz2bLdebzpFOnY+Q=;
  b=mEKZBC4PcEj+U+wOzfA1H3LOeoqKezSvxcuCY1bLdKrNPz1KXVkYMvbJ
   eaBD4LzbAqj2RYLbQC153YYF18D0LXAS1FlJd6epZyQNeUNnPVAzN+BRx
   yJX2lCi5XEiROm8hlQtjvmrqc/n7YnZaaY8oKclNcW2sqXCY6VM8RpHcq
   SZLRFeXfpwMO23GXgrbAkTFgawOnpfpyCbxR5kYBIoMkMxKqBp7YO7wnM
   VjHRMz/VpTwG0BGcMhc4/XlBD9PJAkRGIER+KscE6M1G2yHZbWZgH+qrZ
   X8U3Q9fl5zkwWNqE2O2upN1lApoKOuefNQ0/nOpcf73r/ZASzD5qWhK7i
   w==;
X-CSE-ConnectionGUID: /+AyIFCPRoOv4x/shvvG/g==
X-CSE-MsgGUID: EHFrAh9bRsWHkcKULM8Adw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="20075517"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="20075517"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 00:25:00 -0700
X-CSE-ConnectionGUID: l3gYqzlOSC+llV1ydiVV6Q==
X-CSE-MsgGUID: obcw5HxvQ5CfagXj+4yM2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48523240"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orviesa005.jf.intel.com with ESMTP; 25 Jun 2024 00:24:57 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Mike Galbraith <efault@gmx.de>,
	Tim Chen <tim.c.chen@intel.com>,
	Yujie Liu <yujie.liu@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] sched/fair: Enhance sync wakeup for short duration tasks
Date: Tue, 25 Jun 2024 15:21:49 +0800
Message-Id: <cover.1719295669.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a respin of the previous work to inhit task migration[1].
 
Many workloads suffer from high Cache-to-Cache latency on large system. Especially
when different tasks access the same cache line, which brings false sharing.

This patch set leverages the WF_SYNC flag, and inhits task wakeup migration
for short duration ones. This can help reduce the chance to trigger the
cache false sharing.

The main concern of this proposal in the last discussion is that, it could
break idle-cpu-first task wakeup strategy. Usually an idle CPU can beat other
non-idle CPU in terms of latency. Based on this, the new proposal takes the
CPU number into consideration, if it is a low-core-count system, the bar to
inhit the task migration is much higher or even impossible. Vice versa. Meanwhile,
only when there is no idle Core in the system, this inhiting task migration will take
effect.

According to the test on 4 different platforms, it has shown good improvement for
Client/Server workloads, like netperf, tbench. And not saw any performance regression
on my 8 CPUs laptop. Please refer to PATCH 2/2 for detail.

Comments and tests would be appreciated.

[1] https://lore.kernel.org/lkml/cover.1682661027.git.yu.c.chen@intel.com/

Chen Yu (2):
  sched/fair: Record the average duration of a task
  sched/fair: Enhance sync wakeup for short duration tasks

 include/linux/sched.h   |  3 ++
 kernel/sched/core.c     |  2 ++
 kernel/sched/fair.c     | 74 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched/features.h |  1 +
 4 files changed, 75 insertions(+), 5 deletions(-)

-- 
2.25.1


