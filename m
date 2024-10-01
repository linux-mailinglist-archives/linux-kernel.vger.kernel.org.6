Return-Path: <linux-kernel+bounces-346318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E398C31C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1074D1C21068
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA251CB30A;
	Tue,  1 Oct 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrvInt21"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F219CC3F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799059; cv=none; b=m2+TiaO5FYyXoEwFjjkH4mtQFfnN18qH1Qs7SUvaBpzCU7Mu1s1RQ4Wa9w+SffQNQuMhFccjv3RkeVCfB8zBqalTopJW3tanxHvbhz78MGXqXmK8aDTK9ciR5cyFgGHoWInd2WhqIyi34d9TdH8D/EDnTdmB3DUPx2Q2iYl1BF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799059; c=relaxed/simple;
	bh=+pCd4ak/QdXr4lgFycw8H1+0AT0iji+uienfRo4t41s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cINO+P/FztdUo+gfS3a4LWdaX+sPZvdRNvBe7MM9KdN7uNHs+/R7TI/XYUE3el+Egj7aEmcSPSXfVma1l/UNFxETcyRBAtxFkf+JYoeDsJgrUmfyMMb4Jar2/8/FhjVP4JodF6It1pe8rBGPgHlCaLDENzQqojAnzAiEcUmVzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrvInt21; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727799057; x=1759335057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+pCd4ak/QdXr4lgFycw8H1+0AT0iji+uienfRo4t41s=;
  b=QrvInt21LzFTce/jqOSAuf31Oigx31yTorVzAUUdyGZzJClyLe1x3XmW
   DE2pFA66loVU9Vqg/PFE3HDTAza9QeQBlKXYeFzRgihrfTKhJV+Ft0W4S
   hTHy++xYQvYILpCbflcgLaX2BgI85fxqnGw3IHL4wmmzV4VDP2Y9Fbh44
   p4YLuk0TMEI1bdvOyDA+/y/3VK1PwA1Y0Xik/vRvv7eka8lVXnfY9D/jL
   GU3EwHIFsSBg5wklsKKu24K9Clle1rRcbElFOwvbP5ki9t7tzU+p6vbtz
   VHzxDWB5O89tJZLvml/B3glQ75gdKPRLg8bf5OPWhmt2NV6gouZip9xwZ
   Q==;
X-CSE-ConnectionGUID: CA3J9MIrSMOnHZosrCUCuA==
X-CSE-MsgGUID: GsSkMaVLS86gLrL3HUYt5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37539365"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37539365"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:10:57 -0700
X-CSE-ConnectionGUID: JibjC4z1SoyXuKu/qcUEGw==
X-CSE-MsgGUID: TE1hDm7LS9uVmcavagvqLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78585963"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.136.21])
  by orviesa003.jf.intel.com with ESMTP; 01 Oct 2024 09:10:57 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC 0/7] x86/microcode: Support for Intel Staging Feature
Date: Tue,  1 Oct 2024 09:10:35 -0700
Message-Id: <20241001161042.465584-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

I'd like to ask initial feedback on this series enabling the staging
feature. Thanks!

== Latency Spike Issue ==

As microcode images have increased in size, a corresponding rise in load
latency has become inevitable. This latency spike significantly impacts
late loading, which remains in use despite the cautions highlighted in
the documentation [1]. The issue is especially critical for continuously
running workloads and virtual machines, where excessive delays can lead
to timeouts.

== Staging for Latency Reduction ==

Currently, writing to MSR_IA32_UCODE_WRITE triggers the entire update
process -- loading, validating, and activation -- all of which contribute
to the latency during CPU halt. The staging feature mitigates this by
refactoring all but the activation step out of the critical path,
allowing CPUs to continue serving workloads while staging takes place.

== Cache Flush Removal ==

Before resolving this latency spike caused by larger images, another
major latency issue -- cache invalidation [2] -- must first be addressed.
Originally introduced to handle a specific erratum, this cache
invalidation is now unnecessary because the problematic microcode images
have been banned. This cache flush has been found to negate the benefits
of staging, so this patch series begins by removing the WRINVD
instruction.

== Validation ==

We internally established pseudocode to clearly define all essential
steps for interacting with the firmware. Any firmware implementation
supporting staging should adhere to this contract. This patch set
incorporates that staging logic, which I successfully tested on one
firmware implementation. Multiple teams at Intel have also validated the
feature across different implementations.

Preliminary results from a pre-production system show a significant
reduction in latency (about 40%) with the staging approach alone.
Further improvements are possible with additional optimizations [*].

== Call for Review ==

This RFC series aims to present the proposed approach for community
review, to assess its soundness, and to discuss potential alternatives
if necessary. There are several key points to highlight for feedback:

  1. Staging Integration Approach

     In the core code, the high-level sequence for late loading is:

     (1) request_microcode_fw(), and
     (2) load_late_stop_cpus()->apply_microcode()

     Staging doesn't fit neatly into either steps, as it involves the
     loading process but not the activation. Therefore, a new callback is
     introduced:

       core::load_late_locked()
       -> intel::staging_microcode()
          -> intel_staging::staging_work()
             -> intel_staging::...

  2. Code Abstraction

     The newly added intel_staging.c file contains all staging-related
     code to keep it self-contained. Ideally, the entire firmware
     interaction could eventually be abstracted into a single MSR write,
     which remains a long-term goal. Fortunately, recent protocol
     simplifications have made this more feasible.

  3. Staging Policy (TODO)

     While staging is always attempted, the system will fall back to the
     legacy update method if staging fails. There is an open question
     regarding staging policy: should it be mandatory, without fallback,
     in certain usage scenarios? This could lead further refinements in
     the flow depending on feedback and use cases.

  4. Specification Updates

     Recent specification updates have simplified the staging protocol
     and clarified the behavior of MSR_IA32_UCODE_WRITE in conjunction
     with staging:

     4.1. Protocol Simplification

     The specification update [3] has significantly reduced the
     complexity of staging code, trimming the kernel code from ~1K lines
     in preliminary implementations. Thanks to Dave for guiding this
     redesign effort.

     4.2. Clarification of Legacy Update Behavior

     Chapter 5 of the specification adds further clarification on
     MSR_IA32_UCODE_WRITE. Key points are summarized below:

     (a) When staging is not performed or failed, a WRMSR will still load
     the patch image, but with higher latency.

     (b) During an active staging process, MSR_IA32_UCODE_WRITE can
     load a new microcode image, again with higher latency.

     (c) If the versions differ between the staged microcode and the
     version loaded via MSR_IA32_UCODE_WRITE, the version loaded through
     the MSR takes precedence.

     I'd also make sure there is no further ambiguity in this documentation
     [3]. Feel free to provide feedback if anything seems unclear or
     unreasonable.

As noted [*], an additional series focused on further latency
optimizations will follow. However, the staging approach was prioritized
due to its significant first-order impact on latency.

This series is based on 6.12-rc1. You can also find it from this repo:
    git://github.com/intel-staging/microcode.git staging_rfc-v1

Thanks,
Chang

[1]: https://docs.kernel.org/arch/x86/microcode.html#why-is-late-loading-dangerous
[2]: https://lore.kernel.org/all/20240701212012.21499-1-chang.seok.bae@intel.com/
[3]: https://cdrdv2.intel.com/v1/dl/getContent/782715
[*]: Further latency improvements will be addressed in the upcoming
     ‘Uniform’ feature series.

Chang S. Bae (7):
  x86/microcode/intel: Remove unnecessary cache writeback and
    invalidation
  x86/microcode: Introduce staging option to reduce late-loading latency
  x86/msr-index: Define MSR index and bit for the microcode staging
    feature
  x86/microcode/intel: Prepare for microcode staging
  x86/microcode/intel_staging: Implement staging logic
  x86/microcode/intel_staging: Support mailbox data transfer
  x86/microcode/intel: Enable staging when available

 arch/x86/include/asm/msr-index.h              |   9 +
 arch/x86/kernel/cpu/microcode/Makefile        |   2 +-
 arch/x86/kernel/cpu/microcode/core.c          |  12 +-
 arch/x86/kernel/cpu/microcode/intel.c         |  77 ++++++++-
 arch/x86/kernel/cpu/microcode/intel_staging.c | 154 ++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h      |   5 +-
 6 files changed, 247 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/microcode/intel_staging.c

-- 
2.43.0


