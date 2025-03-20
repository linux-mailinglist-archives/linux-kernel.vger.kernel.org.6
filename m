Return-Path: <linux-kernel+bounces-570524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA90A6B1BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB3E4882C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5338C22256A;
	Thu, 20 Mar 2025 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PB3Gox4x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ABF21C9E5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514187; cv=none; b=ZPCXRQn8mom470sh+1w+2l10+vkBeANK7oDFSHnRXAXUlt8MH7z4q+Pg8nIuIXiXVbX82142kdk5bR1QTS7Jt6KWX8aGfNJZn+DFwD8WbeDISoWqHpZrkBlYwLHMAv4GC5GiY09bmlcvab5as9vJrWojUlAR/YjW15rGsHFhOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514187; c=relaxed/simple;
	bh=yTvo8FT/aWVw+Dudl0WD0tAqUlScIIyX7s+7XsL9gDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6ObbyKdZsSBt9IIvGRaLGhHMCtfCbttl6Dsmmp1NI8bpbp+/qEUgD9fxVsUi66+B+mZuyMgBrFbPpCK9wzUVI7g0Vi2kiNPieo2uk9z9DNVxfCihfLGM8c9ZnmglXeSzUXXmrRPuZ7udUMX50JaV6SjB5NzkqdJa6Ma4HqMEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PB3Gox4x; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514185; x=1774050185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yTvo8FT/aWVw+Dudl0WD0tAqUlScIIyX7s+7XsL9gDI=;
  b=PB3Gox4xaiemEZvA84SNV87roC8rVVEgKJtTYoOYJ3/9lH8bPTQbNgxk
   RltZ5qJkpp41bhKvFyvanREahUB+HRUPm5k0I+O0SkdYVNy5I9kk2KiyS
   05f0+4scMYJbOdf89FoKpekQL1t7M0LC3uObL4RZf3qzqHeVsOoT0Z4C9
   t+zBcSXS0+81BBY0/r75GcJ5I+HXgOT4ywJ0TQHzPHdEjoI8t/+2cM0Lf
   ee6Pokke6bXvuWIevQhaSttqXOpMJr/dtpVuP0uYzgh3kCSSYNxfJOk02
   7XrMWzX59djDXkxEGgw+96em05u2Jr0cw9b2x8rUc1VJJ7u+kG78KIoKV
   A==;
X-CSE-ConnectionGUID: WHyFQePbQouJCQwPmAuJrw==
X-CSE-MsgGUID: JHCJfOghRv+vsDFQJJP/Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502575"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502575"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:05 -0700
X-CSE-ConnectionGUID: XBOJxtfFRgGJH1q0/80q+g==
X-CSE-MsgGUID: 7EwS3jXbSyiRaVqu6OpoCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122962929"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2025 16:43:04 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v2 0/9] x86: Support Intel Advanced Performance Extensions
Date: Thu, 20 Mar 2025 16:42:51 -0700
Message-ID: <20250320234301.8342-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227184502.10288-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This is a revision of the previous posting [1]. The primary goal at this
stage is to present the scope of the code changes and still gather early
feedback on the approach to enabling this feature for userspace.

== Changes in this revision ==

A major update in this version is that the xstate ordering table is now
dynamically populated at boot time, thanks to Dave’s suggestion. Each
system will now generate its own table based on the available xfeature
set.

As a result, the MPX removal patch has been dropped from this series.
Previously, a conflict arose when listing both MPX and APX in a static
table. With the new dynamic approach, each feature can be enabled
exclusively without conflict. Patch 7 ensures their mutual exclusivity,
meaning the table will now reflect either one or neither of them.

Removing MPX entirely also seemed premature, given previous discussions
on the list [4]. For guest compatibility, setting MPX bits in XCR0 is
still expected on older systems.

Additional changes since the last posting:
*  Complete MPX feature bits for enforcing APX exclusivity (Dave).
*  Remove the first patch, as merged into the tip tree:
   69a2fdf44604 ("x86/fpu/xstate: Simplify print_xstate_features()")

Below is the original cover letter with minor updates:

== Introduction ==

APX introduces a new set of general-purpose registers designed to improve
performance. More details on its use cases can be found in the published
documentation [2].

This series primarily assumes the userspace usage only, though in-kernel
use cases may remain open for considerations.

== Points to Consider ==

Considering APX enabling by the kernel,

* New Register State

  APX register state is managed by the XSAVE instruction set, with its
  state component number assigned to 19, following XTILEDATA.

* XSAVE Buffer Offset

  - In the compacted format used (for the in-kernel buffer), the APX
    state will appear at a later position in the buffer.

  - In the non-compacted format (used for signal, ptrace, and KVM ABIs),
    APX is assigned a lower offset, occupying the space previously
    reserved for the deprecated MPX state.

    This should not bring any ABI changes. In the extended register state
    area, each state's size and offset are determined dynamically via
    CPUID.

* Kernel Assumptions:

  The kernel generally assumes that higher-numbered components have
  higher offsets, as discussed in the following section.

== Areas for Adjustment ==

With that in mind, here are a few key areas that need to be addressed to
properly handle the APX state. While these are thought to be pretty much
at this stage, I'd say it is still open to discover possible hindsights
in other areas.

1. Feature Conflict

   While a valid CPU should not expose both MPX and APX, a broken or
   misconfigured CPU could erroneously expose support for both. This hard
   conflict should be avoided up front.

2. XSAVE Format Conversion

   APX introduces an offset anomaly that requires special handling when
   converting between compacted and non-compacted layouts. The kernel
   relies on XSAVE instructions for context switching and signal
   handling. However, xstate copy functions must correctly translate the
   XSAVE format while ensuring sequential memory access, as enforced by
   struct membuf.

3. XSAVE Size Calculation

   The kernel calculates XSAVE buffer sizes based on the assumption that
   the highest-numbered feature appears at the end. If APX is the last
   bit set in the feature mask, the existing logic in
   xstate_calculate_size() miscalculates the buffer size.

4. Offset Sanity Check

   The kernel's boot-time sanity check in setup_xstate_cache() assumes
   offsets increase with feature numbers. The APX state will conflict
   with this assumption.

== Approaches ==

These two approaches are considerable:

Option 1, Consider APX as a one-off exception

  Initially, I thought this approach would result in fewer changes to the
  xstate code. However, it makes the code less comprehensive (or more
  complicated) and introduces a risk. If another feature similar to APX
  comes up, adding another exception seems to be inefficient and messy.

Option 2, Handle out-of-order offsets in general

  Rather than treating APX as an exception, this approach adapts the
  kernel to accommodate out-of-order offsets. By introducing a feature
  order table and an accompanying macro, the traversal logic is
  encapsulated cleanly, simplifying related code. This makes the kernel
  more resilient to future features with non-sequential offsets.

== Series Summary ==

This patch set addresses the above issues before enabling APX support
The chosen approach (Option 2) adjusts the kernel to handle out-of-order
offsets. Here’s a breakdown of the patches:

* PART1: XSTATE Code Adjustment

  - PATCH1:  Remove the offset sanity check.
  - PATCH2:  Introduce the feature order table.
  - PATCH3:  Adjust XSAVE size calculation.
  - PATCH4:  Modify the xstate copy function.

* PART2: APX Enabling

  - PATCH5:  Enumerate the APX CPUID feature bit.
  - PATCH6:  Update xstate definitions to include APX.
  - PATCH7:  Ensure MPX and APX are mutually exclusive.
  - PATCH8:  Register APX in the supported xstate list.
  - PATCH9:  Add a self-test case for APX.

== Testing ==

The first part is agnostic to APX and should preserve the same
functionality for the currently supported features. The xstate tests --
covering context switching and ABI compatibility for signal and ptrace --
were executed to ensure there is no regression.

Now, with dynamic population of the ordering table, MPX and APX states
can be separately enabled in different systems:

* APX: PATCH9 applies to the same test set and builds on the xstate
  selftest rework [3]. Since no hardware implementation is available at
  this time, an internal Intel emulator was primarily used to verify the
  test cases.

* MPX exposure in KVM guest was also validated from a Skylake machine.

---

The patches are based on the tip/master branch. The series can be found
here:
    git://github.com/intel/apx.git apx_rfc-v2

Thanks,
Chang

[1] https://lore.kernel.org/lkml/20250227184502.10288-1-chang.seok.bae@intel.com/
[2] https://www.intel.com/content/www/us/en/developer/articles/technical/advanced-performance-extensions-apx.html
[3] https://lore.kernel.org/lkml/20250226010731.2456-1-chang.seok.bae@intel.com/
[4] https://lore.kernel.org/lkml/547a1203-0339-7ad2-9505-eab027046298@intel.com/

Chang S. Bae (9):
  x86/fpu/xstate: Remove xstate offset check
  x86/fpu/xstate: Introduce xfeature order table and accessor macro
  x86/fpu/xstate: Adjust XSAVE buffer size calculation
  x86/fpu/xstate: Adjust xstate copying logic for user ABI
  x86/cpufeatures: Add X86_FEATURE_APX
  x86/fpu/apx: Define APX state component
  x86/fpu/apx: Disallow conflicting MPX presence
  x86/fpu/apx: Enable APX state support
  selftests/x86/apx: Add APX test

 arch/x86/include/asm/cpufeatures.h   |   1 +
 arch/x86/include/asm/fpu/types.h     |   9 +++
 arch/x86/include/asm/fpu/xstate.h    |   3 +-
 arch/x86/kernel/cpu/cpuid-deps.c     |   1 +
 arch/x86/kernel/cpu/scattered.c      |   1 +
 arch/x86/kernel/fpu/xstate.c         | 115 +++++++++++++++++++--------
 tools/testing/selftests/x86/Makefile |   3 +-
 tools/testing/selftests/x86/apx.c    |  10 +++
 tools/testing/selftests/x86/xstate.c |   3 +-
 tools/testing/selftests/x86/xstate.h |   2 +
 10 files changed, 113 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/x86/apx.c


base-commit: 758ea9705c51865858c612f591c6e6950dcafccf
-- 
2.45.2


