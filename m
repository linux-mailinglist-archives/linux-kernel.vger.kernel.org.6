Return-Path: <linux-kernel+bounces-354795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085249942E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3427B23A93
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485701DFDB2;
	Tue,  8 Oct 2024 08:23:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F280604
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375804; cv=none; b=fxA46rQkH2azM8MJR5t7ZTdJv55jbVCY6XSXFaBuNlIzgvX+vzmEMgGXnMjavY9beC70/TO8L+JrCLzqROECEvzN/7rLdWQaLU76DFUFpvJdpLV3/uC7oX3R9bAoG1i+Fo2/OU78FezUZss4R8FzgSpnsIIWkMPPyFj05vh1hO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375804; c=relaxed/simple;
	bh=6C/94WHJF4aw74LdcNMI0NGxA2lciouALoHU3gKkY48=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UbKylSkWwPAL6w3NGKzQ6QYYT9YYPdzHiGwHdAMZ5+Kh8ZulMPBJk2PveoTNYva7+IA4Rb7v4DT4d2vSsUgqtIhGRdNPNaT6UgbColZpfKbpOjHjGITzerGjCq8STWsgmD6iogk/Cku0GV0SoOlr5fy409d6VHGjcSIqMzZWxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A7B7DA7;
	Tue,  8 Oct 2024 01:23:51 -0700 (PDT)
Received: from [10.1.26.27] (unknown [10.1.26.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B1523F640;
	Tue,  8 Oct 2024 01:23:20 -0700 (PDT)
Message-ID: <b2ad1f31-21b9-42a5-a735-b9496470348a@arm.com>
Date: Tue, 8 Oct 2024 09:23:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Valentin Schneider <vschneid@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched/uclamp: Fix unnused variable warning
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

uclamp_mutex is only used for CONFIG_SYSCTL or
CONFIG_UCLAMP_TASK_GROUP so ifdef that to fix the compile-time warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410060258.bPl2ZoUo-lkp@intel.com/
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..18d9622eac8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1394,7 +1394,9 @@ void set_load_weight(struct task_struct *p, bool update_load)
  * requests are serialized using a mutex to reduce the risk of conflicting
  * updates or API abuses.
  */
+#if defined(CONFIG_UCLAMP_TASK_GROUP) || defined(CONFIG_SYSCTL)
 static DEFINE_MUTEX(uclamp_mutex);
+#endif
 
 /* Max allowed minimum utilization */
 static unsigned int __maybe_unused sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
-- 
2.34.1

