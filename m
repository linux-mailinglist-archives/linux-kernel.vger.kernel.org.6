Return-Path: <linux-kernel+bounces-513928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C8DA35063
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91424188E6AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA92661B1;
	Thu, 13 Feb 2025 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCyaOVSO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC6128A2C1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481421; cv=none; b=pULk5BetpAGiq3scC5GFBXhAStSNtY5LYv8bbct6hnQrnmIdh7xXxpncLzpDw/CpJzbY76XNmck0d7QUmm0KRUeWilGv+8ytd6nMO6giUDCV/P4mx2rrXoI/B/4/r9p9D3w0BV3FQfxHj4TVsakSCoG+hAAzU/18stfPelF+3jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481421; c=relaxed/simple;
	bh=ENdJiPoZx9QTcrQUqtR8e/9fSv4sDxcF8PbfHredjzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ov/ie4UgIzYx8gSi7XqdZuaHO9WJyY+wUIM2mNNzS6nfKi/xIR0BdZjsYveEWrXwTJmwyh0Vo7itw0vT3xxkUVn7DYSBiIvRsnV0EWnKtdNnRlb2UVyu1BOlZmcihqsDU1CsDLuCgBkE8E/9B8I9McB5waBX61ZCK/duvmziiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCyaOVSO; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739481419; x=1771017419;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ENdJiPoZx9QTcrQUqtR8e/9fSv4sDxcF8PbfHredjzM=;
  b=MCyaOVSO2YWDfN3CVgT7W5tCnlJjKsHPMHqg3ycpUs3HsqUjKd0hBYbR
   olevDcIJggAAV1kWwojc5aYsb/pOtCqi4+dJjGO7zOyuBTSIJd26P3/qs
   tkVsEpj9pnXf4+rKBuMh8gz0cF9onPRkpQYWF6is0XzvcUfsocXSxPE0t
   f97zTa5dfA/OjnSkrJ/IgJW3NS3v6LUZkpdltUER7tG8SMp3VIMViPg8a
   i1puEmHjZPRc4hVXhUwqMq1JXTQ9WzUXmvKSCJ7t3IscG21ac4rNugaA6
   GqjC6eEK5pgJT42liVpREWAQRiRWq9jVCWc201u/BpQPKjEBq7DygmTMT
   A==;
X-CSE-ConnectionGUID: hrxqGMDURZGI9zz8EF78rQ==
X-CSE-MsgGUID: U8nzXFRnR3uSLJiitWCRTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44142393"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44142393"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 13:16:58 -0800
X-CSE-ConnectionGUID: QpybzptHQtW3KPQsrAVrsA==
X-CSE-MsgGUID: 3tgLdcHZSlKwek0z+FmhFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118469488"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 13 Feb 2025 13:16:58 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 0/5] Support auto counter reload
Date: Thu, 13 Feb 2025 13:17:13 -0800
Message-Id: <20250213211718.2406744-1-kan.liang@linux.intel.com>
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

Changes since V2:
- Rebase on top of several new features, e.g., counters snapshotting
  feature. Rewrite the code for the ACR CPUID-enumeration, configuration
  and late setup.
- Patch 1-3 are newly added for clean up.

Changes since V1:
- Add a check to the reload value which cannot exceeds the max period
- Avoid invoking intel_pmu_enable_acr() for the perf metrics event.
- Update comments explain to case which the event->attr.config2 exceeds
  the group size

The relative rates among two or more events are useful for performance
analysis, e.g., a high branch miss rate may indicate a performance
issue. Usually, the samples with a relative rate that exceeds some
threshold are more useful. However, the traditional sampling takes
samples of events separately. To get the relative rates among two or
more events, a high sample rate is required, which can bring high
overhead. Many samples taken in the non-hotspot area are also dropped
(useless) in the post-process.

The auto counter reload (ACR) feature takes samples when the relative
rate of two or more events exceeds some threshold, which provides the
fine-grained information at a low cost.
To support the feature, two sets of MSRs are introduced. For a given
counter IA32_PMC_GPn_CTR/IA32_PMC_FXm_CTR, bit fields in the
IA32_PMC_GPn_CFG_B/IA32_PMC_FXm_CFG_B MSR indicate which counter(s)
can cause a reload of that counter. The reload value is stored in the
IA32_PMC_GPn_CFG_C/IA32_PMC_FXm_CFG_C.
The details can be found at Intel SDM (085), Volume 3, 21.9.11 Auto
Counter Reload.

Example:

Here is the snippet of the mispredict.c. Since the array has a random
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
usually samples both branches and branch-misses events. E.g.,
perf record -e "{cpu_atom/branch-misses/ppu, cpu_atom/branch-instructions/u}"
               -c 1000000 -- ./mispredict

[ perf record: Woken up 4 times to write data ]
[ perf record: Captured and wrote 0.925 MB perf.data (5106 samples) ]
The 5106 samples are from both events and spread in both Loops.
In the post-process stage, a user can know that the Loop 2 has a 21%
branch miss rate. Then they can focus on the samples of branch-misses
events for the Loop 2.

With this patch, the user can generate the samples only when the branch
miss rate > 20%. For example,
perf record -e "{cpu_atom/branch-misses,period=200000,acr_mask=0x2/ppu,
                 cpu_atom/branch-instructions,period=1000000,acr_mask=0x3/u}"
                -- ./mispredict

(Two different periods are applied to branch-misses and
branch-instructions. The ratio is set to 20%.
If the branch-instructions is overflowed first, the branch-miss
rate < 20%. No samples should be generated. All counters should be
automatically reloaded.
If the branch-misses is overflowed first, the branch-miss rate > 20%.
A sample triggered by the branch-misses event should be
generated. Just the counter of the branch-instructions should be
automatically reloaded.

The branch-misses event should only be automatically reloaded when
the branch-instructions is overflowed. So the "cause" event is the
branch-instructions event. The acr_mask is set to 0x2, since the
event index of branch-instructions is 1.

The branch-instructions event is automatically reloaded no matter which
events are overflowed. So the "cause" events are the branch-misses
and the branch-instructions event. The acr_mask should be set to 0x3.)

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

Kan Liang (5):
  perf/x86: Add dynamic constraint
  perf/x86/intel: Track the num of events needs late setup
  perf: Extend the bit width of the arch-specific flag
  perf/x86/intel: Add CPUID enumeration for the auto counter reload
  perf/x86/intel: Support auto counter reload

 arch/x86/events/core.c             |   3 +-
 arch/x86/events/intel/core.c       | 260 ++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c         |   3 +-
 arch/x86/events/intel/lbr.c        |   2 +-
 arch/x86/events/perf_event.h       |  33 ++++
 arch/x86/events/perf_event_flags.h |  41 ++---
 arch/x86/include/asm/msr-index.h   |   4 +
 arch/x86/include/asm/perf_event.h  |   1 +
 include/linux/perf_event.h         |   4 +-
 9 files changed, 320 insertions(+), 31 deletions(-)

-- 
2.38.1


