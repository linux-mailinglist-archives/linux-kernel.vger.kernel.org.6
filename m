Return-Path: <linux-kernel+bounces-381534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3115A9B0092
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C5A1C2286F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24631FC7FF;
	Fri, 25 Oct 2024 10:53:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A971F8194
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853605; cv=none; b=Yg4ntyGX9s6C1uuIscIQJHe4dEOc23ePdxldyhlo0n2UBnjXA8xbhmp94fq01IKLLCEvefbKaA8durp+b6bp5LKPUUqoivsC1rCSG6lPyod7MKGleUChqs24c+FKB8SbOecP7D8y6aVLmtO9vWrpHv7wavinSrpltFUYw3bPUO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853605; c=relaxed/simple;
	bh=4eplxcpNV43NDIMT6KvgLcMP8I99OwtVqevNRGtDvaE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hR0EBzpuhBXrfmfMSz3gCTIdTHTXv57DPDx0eUZDy9B6XZFaVgSOv6Pvsd8gKmUvDcFbP8cqo4syLVISM0Z94zez7aZq+p5s4E+6dobMzdhuTV2NLuXJ+W5YRXnSYzwglTJ5IcRoLQ9cjgBBds1f+W/y3Bu+iz4TKqq3BratEKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AD94339;
	Fri, 25 Oct 2024 03:53:52 -0700 (PDT)
Received: from [10.57.55.246] (unknown [10.57.55.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 106F63F73B;
	Fri, 25 Oct 2024 03:53:19 -0700 (PDT)
Message-ID: <a1e9c342-01c9-44f0-a789-2c908e57942b@arm.com>
Date: Fri, 25 Oct 2024 11:53:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>,
 Sebastian Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, oe-kbuild-all@lists.linux.dev,
 kernel test robot <lkp@intel.com>, Valentin Schneider <vschneid@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, xiqi2@huawei.com
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCHv2] sched/uclamp: Fix unnused variable warning
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

uclamp_mutex is only used for CONFIG_SYSCTL or
CONFIG_UCLAMP_TASK_GROUP so declare it __maybe_unused.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410060258.bPl2ZoUo-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202410250459.EJe6PJI5-lkp@intel.com/
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
v2: __maybe_unused instead of ifdef (Peter)

 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 114adac5a9c8..9bad282e7950 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1399,7 +1399,7 @@ void set_load_weight(struct task_struct *p, bool update_load)
  * requests are serialized using a mutex to reduce the risk of conflicting
  * updates or API abuses.
  */
-static DEFINE_MUTEX(uclamp_mutex);
+static __maybe_unused DEFINE_MUTEX(uclamp_mutex);

 /* Max allowed minimum utilization */
 static unsigned int __maybe_unused sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
--
2.34.1

