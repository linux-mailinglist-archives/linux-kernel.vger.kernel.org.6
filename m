Return-Path: <linux-kernel+bounces-359907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F50E999249
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DD61C2414B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F91CEAD5;
	Thu, 10 Oct 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7RQTQWN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E9198E75
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588454; cv=none; b=nJ/tGFNWYoj65Qa0Rfft5qwF+3oCLJLd3gPBXE4+8f5A5DuYGtlTa6Q7L0mYiKJDHpIfECtV92UmzaqOWwFvDqVKoAaLJogN7/7uyh0eiquX7R72uv7SabcohjlFNU8zmMM/NE0iQ1CkLo3Tjr2N5u+Q/7Vghra/fZJT18YmHSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588454; c=relaxed/simple;
	bh=60jWUxNJOImmNhqqihV7Nrwm8WDVjLhwppouxmKslPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kut5Ade9y8dyZ8BHSi1Jro5LbUFj0zyq7fhAGpkUXB7URuSljWe9JsAcC/xSwYZzk3DXgUhmvM0WCb/Uq7K86UFsA/SsLp85k/gKTHyn1FEwowAdvuooPx0j9L5upssaCpf40/Z+mwnMNq2lR6EPRD2hKlAQk7dRcIye11nYnRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7RQTQWN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728588452; x=1760124452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=60jWUxNJOImmNhqqihV7Nrwm8WDVjLhwppouxmKslPc=;
  b=G7RQTQWNKgLXUKGB8DCzwXIm++e0bNIyXB2Aj2Xf754mHb7yekkGGDb6
   8l3myn+RBH79ZZqM5vcqTyc/cjFc+fqVaCA5Efg0Jd0Ix9aNoTpayQm19
   +XL4hWm+S8QEdsFTee25l7EOHkIUsXn3DEuKcf1u68EalZUpUVpx0eZW9
   wBcnWBf2aT+02DwXlnXB4Qwjb7gbVJoj5gXlc2DuxuIwT628R16L22o8y
   e9F08Anjy7r1NTnc9enQAZkZXru46w2G9C/ZhpZIz7EtnXxQ1+epdO7A5
   mXqr6/CL8DpHLeRmX++IrAd5SunnOoQenolz2v/QZ8t+TLmpbbW0TbcvQ
   w==;
X-CSE-ConnectionGUID: 3Dyq57zuSnWEnRhwZArJoQ==
X-CSE-MsgGUID: jJIwl1V9S1+rNWIkdRfKuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31870229"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31870229"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 12:27:31 -0700
X-CSE-ConnectionGUID: 5bgkQ1JETg6fbgiC+wUN6w==
X-CSE-MsgGUID: kphbZT94SemJrAfUAbwKoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76614753"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 10 Oct 2024 12:27:31 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	ak@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: eranian@google.com,
	thomas.falcon@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/3] Support auto counter reload
Date: Thu, 10 Oct 2024 12:28:41 -0700
Message-Id: <20241010192844.1006990-1-kan.liang@linux.intel.com>
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

 arch/x86/events/intel/core.c       | 262 ++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h       |  21 +++
 arch/x86/events/perf_event_flags.h |   2 +-
 arch/x86/include/asm/msr-index.h   |   4 +
 arch/x86/include/asm/perf_event.h  |   4 +-
 include/linux/perf_event.h         |   2 +
 6 files changed, 288 insertions(+), 7 deletions(-)

-- 
2.38.1


