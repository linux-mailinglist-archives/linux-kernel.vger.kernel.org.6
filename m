Return-Path: <linux-kernel+bounces-537097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A66A4880F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40887A6FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5E5238163;
	Thu, 27 Feb 2025 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWH+8CWv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B171D935C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681907; cv=none; b=I36P1Yl/S+9YMbzySoplalJnOrt28EXpbZew5Cjyqq6urSVS0t/V1LDnsTNVyZMHktVS+T9u62NC83uzNYG7CEX6OpHSqU8wk1vtOmIsWDhjSDphDzgLT2FIbT5w8fJ5gbVVmHhxo8LsJ+sPOIQlTgBfAvEzu51YLLu8kLdM8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681907; c=relaxed/simple;
	bh=3Mo6QvOYgZrjIhBnudSMoqNWevu5iB+1oLz/Ha58nMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CE8Qqd1mlAmsp90diX47UeIlLn6EPPbqOjRBEL8LpwfT4L0SiPN7ZDvvmUsHVIbzKYdkJuZflHY/NGPVOYAqyNTBpaSGH29t60ohc16A5YX3OzQDTIp4IpmsgHMKVqA0WnSIlZyVaBuA90CvpWGsb2tMa5zZ/jkZ24LZ6O2AIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWH+8CWv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681905; x=1772217905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Mo6QvOYgZrjIhBnudSMoqNWevu5iB+1oLz/Ha58nMU=;
  b=GWH+8CWv9v91PRUDWKXDCCr/aqNEL+e4HYMW37jGI8wOq/8G8iUVEPbA
   ifZMTdJfstpxZWvAG3/Af3Nq6tJy+bjWPwr30wK2eXbWBCtQL8SOHdFpz
   VZ6RFryN8JK5y6X2WWmfDeF8ZrzK9F8pvXz1VHG4Zy0FnS+4OOMdFu7Hh
   Ju41ajhXxszH5NK6LNzbDMG2gmuqAARIn6SEG4fRxpuXsQZ3C0U20mYOH
   SH62Jq8XO7F9IFnsOuGotgCIQp3dDX7QEObVJ2zT8n+e3MRe/bQR+j6O5
   AXl3JL0dPLCk+i3Gqq24N02ZDxdbBEcMQc2Md6CJ8EGzPfATjRsCRjfkX
   Q==;
X-CSE-ConnectionGUID: vFyLELEoRsOzFVNWKqwdrw==
X-CSE-MsgGUID: hvdjHUwGQYaI6gtTIZYh+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720851"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720851"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:05 -0800
X-CSE-ConnectionGUID: dXEE5YOxSkiVmGtM4WR8Nw==
X-CSE-MsgGUID: 20sEpciyTveraR1zdx5B7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767360"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:03 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 00/11] x86: Support Intel Advanced Performance Extensions
Date: Thu, 27 Feb 2025 10:44:45 -0800
Message-ID: <20250227184502.10288-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patch series introduces support for Intel's Advanced Performance
Extensions (APX). The goal is to collect early feedback on the approach
taken for APX. Below is a brief overview of the feature and key
considerations.

== Introduction ==

APX introduces a new set of general-purpose registers designed to improve
performance. Currently, these registers are expected to be used primarily
by userspace applications, with no intended use in kernel mode. More
details on its use cases can be found in the published documentation [1].

== Points to Consider ==

In terms of kernel support, some aspects need attention:

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
  higher offsets, as discussed in the following section. Although MPX
  feature usage support was removed [2], its state components (#3 and #4)
  remain supported.

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

  - PATCH1: Clean up xstate enabling messages.
  - PATCH2: Introduce the feature order table.
  - PATCH3: Remove the offset sanity check, as the checked rule is no
            longer true.
  - PATCH4: Adjust XSAVE size calculation.
  - PATCH5: Modify the xstate copy function.

* PART2: APX Enabling

  - PATCH6:  Remove MPX support.
  - PATCH7:  Enumerate the APX CPUID feature bit.
  - PATCH8:  Update xstate definitions to include APX.
  - PATCH9:  Ensure MPX and APX are mutually exclusive.
  - PATCH10: Register APX in the supported xstate list.
  - PATCH11: Add a self-test case for APX.

== Testing ==

The first part is agnostic to the new feature, and the changes should
preserve the same functionality for the currently supported features. The
xstate tests -- covering context switching and ABI compatibility for
signal and ptrace -- were executed to ensure there is no regression.

PATCH11 applies to the same test set and builds on the xstate selftest
rework [3]. Since no hardware implementation is available at this time,
an internal Intel emulator was primarily used to verify the test cases.

---

The patches are based on the x86/fpu branch [4], where the selftest
rework has landed (Thanks, Ingo!). The series can be found here:
    git://github.com/intel/apx.git apx_rfc-v1

Thanks,
Chang

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/advanced-performance-extensions-apx.html
[2] Commit 45fc24e89b7c ("x86/mpx: remove MPX from arch/x86")
[3] https://lore.kernel.org/lkml/20250226010731.2456-1-chang.seok.bae@intel.com/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/fpu

Chang S. Bae (11):
  x86/fpu/xstate: Simplify print_xstate_features()
  x86/fpu/xstate: Introduce xstate order table and accessor macro
  x86/fpu/xstate: Remove xstate offset check
  x86/fpu/xstate: Adjust XSAVE buffer size calculation
  x86/fpu/xstate: Adjust xstate copying logic for user ABI
  x86/fpu/mpx: Remove MPX xstate component support
  x86/cpufeatures: Add X86_FEATURE_APX
  x86/fpu/apx: Define APX state component
  x86/fpu/apx: Disallow conflicting MPX presence
  x86/fpu/apx: Enable APX state support
  selftests/x86/apx: Add APX test

 arch/x86/include/asm/cpufeatures.h   |   1 +
 arch/x86/include/asm/fpu/types.h     |   9 ++
 arch/x86/include/asm/fpu/xstate.h    |   5 +-
 arch/x86/kernel/cpu/cpuid-deps.c     |   1 +
 arch/x86/kernel/cpu/scattered.c      |   1 +
 arch/x86/kernel/fpu/xstate.c         | 131 ++++++++++++++++-----------
 tools/testing/selftests/x86/Makefile |   3 +-
 tools/testing/selftests/x86/apx.c    |  10 ++
 tools/testing/selftests/x86/xstate.c |   3 +-
 tools/testing/selftests/x86/xstate.h |   1 +
 10 files changed, 108 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/x86/apx.c


base-commit: bd64e9d6aafd12e5437685d2a06360f86418d277
-- 
2.45.2


