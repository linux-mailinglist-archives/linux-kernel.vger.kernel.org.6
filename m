Return-Path: <linux-kernel+bounces-440606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF49EC1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BAE188637E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5973139CF2;
	Wed, 11 Dec 2024 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJNXKznR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7B2451E2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881338; cv=none; b=kQ9qc+xg9avCAluCgBWbgCZ4V9jEVvv7r/vX4wT9W7x+iAQlc0yFIZ2hljyKaO8yMzQHqXkcTkkzyb7jeoOoOcrSGbTaaJbJefGsZjwIuR+07VVITUXKhzdnBcouEOme/RJvtzFucZiAxV2qXYyFIouD3YtkvsqbBxzMd04LXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881338; c=relaxed/simple;
	bh=YvVO/6ECcK5moNtc721bDO38f7JVy4JjOXRob2i8jkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okDNC9paNJE/J82cdTPlmXI5Oa6bdBaL/28x0OSnNxKdgCgADgfePY0vsca3xDYqvaVwMxc8gRuQLJGGEhD59h0HgzOV+dBISwhbs0mKYL7XXmt/PaAdK+34EoWSzpWZvaDoVsPdo4cm4hpHxgRBSLbsV+Oo9U1UgTZuW7XWsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJNXKznR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733881335; x=1765417335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YvVO/6ECcK5moNtc721bDO38f7JVy4JjOXRob2i8jkU=;
  b=WJNXKznRpBi/clvy92jI/KZ0NHGDP6YKmV7TdARq5UQEZyhNk2gm+Ap0
   VrbWxBYtVdIu2acfnvukQp/p/qRT+KqWNuS4OiBCBx/Iw8t/piMQyRKt/
   HwXpi+PkWy7KKzouJcHnzq2YV54+3jW2uv8EfvT8Ani/W+GHihEnf4jTp
   1/DtfmXfsCBg0qiSiIfCeO/qzsHJemHIw4P1WBZrKEi8MGZ6eBx1KywJO
   Y7n11riKGDP0bejqyGS3P40jeXzWw8UG6d85gMp1iUl5jssKwxF3n2Z2Z
   zJwSZbf29KlIUYB9+Hyzz6japxe3okEtkr9qGYCBzimLT9aKoGLtiaPNz
   Q==;
X-CSE-ConnectionGUID: RejRRzR/Q4yhl6MgNQoZjQ==
X-CSE-MsgGUID: j+yhtLTkSTC67czdNPdSag==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33570533"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="33570533"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 17:42:15 -0800
X-CSE-ConnectionGUID: eXcp+Yy1TPG4d+RXIU5wkg==
X-CSE-MsgGUID: D//RJ2gERjSRSGgx+marYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96051715"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.134.127])
  by orviesa007.jf.intel.com with ESMTP; 10 Dec 2024 17:42:14 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH 0/6] x86/microcode: Support for Intel Staging Feature
Date: Tue, 10 Dec 2024 17:42:06 -0800
Message-ID: <20241211014213.3671-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001161042.465584-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Changes since the RFC posting [1]:

* Simplified the staging address discovery code. Leveraging the staging
  topology, stage only if package id changes (Thomas).

* Cleaned up the MSR read logic (Boris and Dave).

* Renamed functions to align with the do_something naming convention
  (Boris).

* Polished staging result messages (Boris).

* Dropped the WBINVD removal as mainlined now.

This series is based on 6.13-rc2. You can also find it from this repo:
    git://github.com/intel-staging/microcode.git staging_v1

I would appreciate further reviews and feedback.

Thanks,
Chang

---

Here is the original cover letter with minor updates -- removing the
WBINVD story and updating the function names:

== Latency Spike Issue ==

As microcode images have increased in size, a corresponding rise in load
latency has become inevitable. This latency spike significantly impacts
late loading, which remains in use despite the cautions highlighted in
the documentation [2]. The issue is especially critical for continuously
running workloads and virtual machines, where excessive delays can lead
to timeouts.

== Staging for Latency Reduction ==

Currently, writing to MSR_IA32_UCODE_WRITE triggers the entire update
process -- loading, validating, and activation -- all of which contribute
to the latency during CPU halt. The staging feature mitigates this by
refactoring all but the activation step out of the critical path,
allowing CPUs to continue serving workloads while staging takes place.

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

Here are several key points to highlight for feedback:

  1. Staging Integration Approach:

     In the core code, the high-level sequence for late loading is:

     (1) request_microcode_fw(), and
     (2) load_late_stop_cpus()->apply_microcode()

     Staging doesn't fit neatly into either steps, as it involves the
     loading process but not the activation. Therefore, a new callback is
     introduced:

       core::load_late_locked()
       -> intel::staging_microcode()
          -> intel_staging::do_stage()

  2. Code Abstraction:

     The newly added intel_staging.c file contains all staging-related
     code to keep it self-contained. Ideally, the entire firmware
     interaction could eventually be abstracted into a single MSR write,
     which remains a long-term goal. Fortunately, recent protocol
     simplifications have made this more feasible.

  3. Staging Policy (TODO):

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

[1]: https://lore.kernel.org/all/20241001161042.465584-1-chang.seok.bae@intel.com/
[2]: https://docs.kernel.org/arch/x86/microcode.html#why-is-late-loading-dangerous
[3]: https://cdrdv2.intel.com/v1/dl/getContent/782715
[*]: Further latency improvements will be addressed in the upcoming
     ‘Uniform’ feature series.

Chang S. Bae (6):
  x86/microcode: Introduce staging option to reduce late-loading latency
  x86/msr-index: Define MSR index and bit for the microcode staging
    feature
  x86/microcode/intel: Prepare for microcode staging
  x86/microcode/intel_staging: Implement staging logic
  x86/microcode/intel_staging: Support mailbox data transfer
  x86/microcode/intel: Enable staging when available

 arch/x86/include/asm/msr-index.h              |   9 ++
 arch/x86/kernel/cpu/microcode/Makefile        |   2 +-
 arch/x86/kernel/cpu/microcode/core.c          |  12 +-
 arch/x86/kernel/cpu/microcode/intel.c         |  53 +++++++
 arch/x86/kernel/cpu/microcode/intel_staging.c | 149 ++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h      |   7 +-
 6 files changed, 228 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/microcode/intel_staging.c

-- 
2.45.2


