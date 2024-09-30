Return-Path: <linux-kernel+bounces-344378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE098A8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 133CFB29DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CC3192B6D;
	Mon, 30 Sep 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ED8CO3rj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CB518DF8A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710875; cv=none; b=a2hZbQirHITlZVF4tN/4uC/khVNXH7eDHp/hO/uSfe1RfozJR0j002VImty347CQQA3S+I14WSfEOB356p+2GfWVIJyXgXSvM4wCdeftBLEocZRU8sFpEJvUvJfhNDSXvl5ouEXmHK3k/iORBX1Lle1rFrPbeMkIGSAc411pP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710875; c=relaxed/simple;
	bh=iLyFR1h0+RGsPWVTDF0s05V4i6Fa+Mq4zmyJ9KRmUoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qtW94K+tlTYkx3WR6GEbbxnFVZf0e0nDibl5tKjnnI9JpLTyIv/qp5Hd3jgw8Ri1dTNvmyRcxmYli4snHrssenThXf0qPeFF9cUWPHNLzmp1oUqVlfSyUC2ZTq2Di+aaP5cycmNvzjPjAzShJ2zRzPgSXOQgoHmyga7POdXufr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ED8CO3rj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727710874; x=1759246874;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iLyFR1h0+RGsPWVTDF0s05V4i6Fa+Mq4zmyJ9KRmUoE=;
  b=ED8CO3rjDcFfE2xbZsKHkqdgg95kwgSg2YNkzlExu7uuBN0JIPdD5NZj
   R63c4I0/0iggEFyXaGuyj3Q4dnh4XEjV5a+wzocTTii+besqAvgqszxGs
   wMpH793xYxQd7QqkmIRzCLE3V5wLHpsoi307ROcOe5EqFycB7B52JGqcr
   7NUNf30nlfEhzLB8+qRcfO5ouHCPkCxkqUDKan6yBF92O/2lcfnJBbBzY
   MTwnzIwpDceQJHVIfgibhkTEYmySoY16ezE0tBBDVZC/n5j6l2/2GsFsU
   Vj4vu0SaPPB9YeJziQZ+xqF1yNpD7Mr/NyEP5Va8AwqlG7IZNOtwV5V0+
   A==;
X-CSE-ConnectionGUID: BhVcuJ55RF+giHz3VdA/cw==
X-CSE-MsgGUID: 6O0eaz1uSLGgk4mij6JvuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26272155"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26272155"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 08:41:13 -0700
X-CSE-ConnectionGUID: 8k05nbAHSYqcZHU1L9IoTg==
X-CSE-MsgGUID: TiBioWwsSLq+FYOxV+zs1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="78172475"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 30 Sep 2024 08:41:13 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org
Cc: eranian@google.com,
	ak@linux.intel.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/3] Support auto counter reload
Date: Mon, 30 Sep 2024 08:41:19 -0700
Message-Id: <20240930154122.578924-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The relative rates among two or more events are useful for performance
analysis, e.g., a high branch miss rate may indicate a performance
issue. Usually, the samples with a relative rate that exceeds some
threshold are more useful. However, the traditional sampling takes
samples of events separately. To get the relative rates among two or
more events, a high sample rate is required, which can bring high
overhead. Many samples taken in the non-hotspot area are also dropped
(useless) in the post-process.

Auto Counter Reload (ACR) provides a means for software to specify that,
for each supported counter, the hardware should automatically reload the
counter to a specified initial value upon overflow of chosen counters.
This mechanism enables software to sample based on the relative rate of
two (or more) events, such that a sample (PMI or PEBS) is taken only if
the rate of one event exceeds some threshold relative to the rate of
another event. Taking a PMI or PEBS only when the relative rate of
perfmon events crosses a threshold can have significantly less
performance overhead than other techniques.

The details can be found at Intel Architecture Instruction Set
Extensions and Future Features (053) 8.7 AUTO COUNTER RELOAD.

Examples:

Here is the snippet of the mispredict.c. Since the array has random
numbers, jumps are random and often mispredicted.
The mispredicted rate depends on the compared value.

For the Loop1, ~11% of all branches are mispredicted.
For the Loop2, ~21% of all branches are mispredicted.

main()
{
...
        for (i = 0; i < N; i++)
                data[i] = rand() % 256;
...
        /* Loop 1 */
        for (k = 0; k < 50; k++)
                for (i = 0; i < N; i++)
                        if (data[i] >= 64)
                                sum += data[i];
...

...
        /* Loop 2 */
        for (k = 0; k < 50; k++)
                for (i = 0; i < N; i++)
                        if (data[i] >= 128)
                                sum += data[i];
...
}

Usually, a code with a high branch miss rate means a bad performance.
To understand the branch miss rate of the codes, the traditional method
usually sample both branches and branch-misses events. E.g.,
perf record -e "{cpu_atom/branch-misses/ppu, cpu_atom/branch-instructions/u}"
               -c 1000000 -- ./mispredict

[ perf record: Woken up 4 times to write data ]
[ perf record: Captured and wrote 0.925 MB perf.data (5106 samples) ]
The 5106 samples are from both events and spread in both Loops.
In the post process stage, a user can know that the Loop 2 has a 21%
branch miss rate. Then they can focus on the samples of branch-misses
events for the Loop 2.

With this patch, the user can generate the samples only when the branch
miss rate > 20%.
perf record -e "{cpu_atom/branch-misses,period=200000,acr_mask=0x2/ppu,
                 cpu_atom/branch-instructions,period=1000000,acr_mask=0x3/u}"
                -- ./mispredict
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.098 MB perf.data (2498 samples) ]

 $perf report

Percent       │154:   movl    $0x0,-0x14(%rbp)
              │     ↓ jmp     1af
              │     for (i = j; i < N; i++)
              │15d:   mov     -0x10(%rbp),%eax
              │       mov     %eax,-0x18(%rbp)
              │     ↓ jmp     1a2
              │     if (data[i] >= 128)
              │165:   mov     -0x18(%rbp),%eax
              │       cltq
              │       lea     0x0(,%rax,4),%rdx
              │       mov     -0x8(%rbp),%rax
              │       add     %rdx,%rax
              │       mov     (%rax),%eax
              │    ┌──cmp     $0x7f,%eax
100.00   0.00 │    ├──jle     19e
              │    │sum += data[i];

The 2498 samples are all from the branch-misses events for the Loop 2.

The number of samples and overhead is significantly reduced without
losing any information.

Kan Liang (3):
  perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF
  perf/x86/intel: Add the enumeration and flag for the auto counter
    reload
  perf/x86/intel: Support auto counter reload

 arch/x86/events/intel/core.c       | 252 ++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h       |  21 +++
 arch/x86/events/perf_event_flags.h |   2 +-
 arch/x86/include/asm/msr-index.h   |   4 +
 arch/x86/include/asm/perf_event.h  |   4 +-
 include/linux/perf_event.h         |   2 +
 6 files changed, 278 insertions(+), 7 deletions(-)

-- 
2.38.1


