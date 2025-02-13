Return-Path: <linux-kernel+bounces-513931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6CDA35066
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE897A25EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702E26983C;
	Thu, 13 Feb 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J80q+q+P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41215266B6F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739481424; cv=none; b=aeTov3cIyPff4szKTxX6bvLtNpdqo4PKKIw/Alq7uBCltbnZHnYy6eb4eVevB3UqexfKRE+MM+PYAswdNYXLj1eRJBdwiai+KOrLI2JGjtEg3mjld+aib79SKyvIGxBf9xk2Ie483zObwFaEmGPXV4AYLPiWd90Meq9sz3v+yIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739481424; c=relaxed/simple;
	bh=Un2UlhEVBthfHvpKKGwNEa3ysX4b7bWuxH0qmz6lk2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tYgbVc4YHMHkWey5DICBx+Xf0yvJ3ZyqWcVZDaETYjFL+Jzze8V2Wlxcr04d7BqgfpdULiRjsZMmXQIP66d3bTLcDKhZeVDAHn77LsV2ZdVken/uCefJmATxk05WrRWAMsLALMLTVEYXdq0/JuU2YVGR5dlvt0/+kT62fNsdARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J80q+q+P; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739481423; x=1771017423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Un2UlhEVBthfHvpKKGwNEa3ysX4b7bWuxH0qmz6lk2k=;
  b=J80q+q+PlbDPQf0rKdCa9znrL6lsmd7qrytD5Eyh/qEiP5r/KfmJ/pZc
   axYL9WL0B+faMCLgnKjKsJsqEFDxGitNGtvO0Eco9VfOYKYFGpMpIOHms
   PaiwsG2QSnVKpOHICBtrpplpfEo/3Y2LX9d6H7gxvGzod8mXQfCclSPQp
   7D2FJQpOrsiGofgxTpAU/7yqJgQ3Yzlv4/mBlgho1MDnxM63Tmjs8Aznx
   VXX5NSZCTx9hGW+MouxoAZI4JFR7aXQT1sbj0okl+L26Gw9wNIrhA6wSp
   Sm5cZfK17NtmhnWV9kP0H2IQqAB7SGAOviuE68cgwrRPveEY3PL22O6TG
   w==;
X-CSE-ConnectionGUID: LcRn75bXQ2Whjd68sCDdjg==
X-CSE-MsgGUID: t0s4C4WHSvu+SocmvZ9Few==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="44142407"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="44142407"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 13:16:58 -0800
X-CSE-ConnectionGUID: 6iwdQMz4SfGPlckAvqhQuQ==
X-CSE-MsgGUID: PjvPLpbmS+OOy16gbzzyoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118469497"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 13 Feb 2025 13:16:59 -0800
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
Subject: [PATCH V3 3/5] perf: Extend the bit width of the arch-specific flag
Date: Thu, 13 Feb 2025 13:17:16 -0800
Message-Id: <20250213211718.2406744-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250213211718.2406744-1-kan.liang@linux.intel.com>
References: <20250213211718.2406744-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The auto counter reload feature requires an event flag to indicate an
auto counter reload group, which can only be scheduled on specific
counters that enumerated in CPUID. However, the hw_perf_event.flags has
run out on X86.

Two solutions were considered to address the issue.
- Currently, 20 bits are reserved for the architecture-specific flags.
  Only the bit 31 is used for the generic flag. There is still plenty
  of space left. Reserve 8 more bits for the arch-specific flags.
- Add a new X86 specific hw_perf_event.flags1 to support more flags.

The former is implemented. Enough room is still left in the global
generic flag.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/perf_event_flags.h | 41 +++++++++++++++---------------
 include/linux/perf_event.h         |  2 +-
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 1d9e385649b5..70078334e4a3 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -2,23 +2,24 @@
 /*
  * struct hw_perf_event.flags flags
  */
-PERF_ARCH(PEBS_LDLAT,		0x00001) /* ld+ldlat data address sampling */
-PERF_ARCH(PEBS_ST,		0x00002) /* st data address sampling */
-PERF_ARCH(PEBS_ST_HSW,		0x00004) /* haswell style datala, store */
-PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
-PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
-PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
-PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
-PERF_ARCH(PEBS_CNTR,		0x00080) /* PEBS counters snapshot */
-PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
-PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
-PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
-PERF_ARCH(PEBS_VIA_PT,		0x00800) /* use PT buffer for PEBS */
-PERF_ARCH(PAIR,			0x01000) /* Large Increment per Cycle */
-PERF_ARCH(LBR_SELECT,		0x02000) /* Save/Restore MSR_LBR_SELECT */
-PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
-PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
-PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
-PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
-PERF_ARCH(NEEDS_BRANCH_STACK,	0x40000) /* require branch stack setup */
-PERF_ARCH(BRANCH_COUNTERS,	0x80000) /* logs the counters in the extra space of each branch */
+PERF_ARCH(PEBS_LDLAT,		0x0000001) /* ld+ldlat data address sampling */
+PERF_ARCH(PEBS_ST,		0x0000002) /* st data address sampling */
+PERF_ARCH(PEBS_ST_HSW,		0x0000004) /* haswell style datala, store */
+PERF_ARCH(PEBS_LD_HSW,		0x0000008) /* haswell style datala, load */
+PERF_ARCH(PEBS_NA_HSW,		0x0000010) /* haswell style datala, unknown */
+PERF_ARCH(EXCL,			0x0000020) /* HT exclusivity on counter */
+PERF_ARCH(DYNAMIC,		0x0000040) /* dynamic alloc'd constraint */
+PERF_ARCH(PEBS_CNTR,		0x0000080) /* PEBS counters snapshot */
+PERF_ARCH(EXCL_ACCT,		0x0000100) /* accounted EXCL event */
+PERF_ARCH(AUTO_RELOAD,		0x0000200) /* use PEBS auto-reload */
+PERF_ARCH(LARGE_PEBS,		0x0000400) /* use large PEBS */
+PERF_ARCH(PEBS_VIA_PT,		0x0000800) /* use PT buffer for PEBS */
+PERF_ARCH(PAIR,			0x0001000) /* Large Increment per Cycle */
+PERF_ARCH(LBR_SELECT,		0x0002000) /* Save/Restore MSR_LBR_SELECT */
+PERF_ARCH(TOPDOWN,		0x0004000) /* Count Topdown slots/metrics events */
+PERF_ARCH(PEBS_STLAT,		0x0008000) /* st+stlat data address sampling */
+PERF_ARCH(AMD_BRS,		0x0010000) /* AMD Branch Sampling */
+PERF_ARCH(PEBS_LAT_HYBRID,	0x0020000) /* ld and st lat for hybrid */
+PERF_ARCH(NEEDS_BRANCH_STACK,	0x0040000) /* require branch stack setup */
+PERF_ARCH(BRANCH_COUNTERS,	0x0080000) /* logs the counters in the extra space of each branch */
+PERF_ARCH(ACR,			0x0100000) /* Auto counter reload */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c381ea7135df..238879f6c3e3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -144,7 +144,7 @@ struct hw_perf_event_extra {
  * PERF_EVENT_FLAG_ARCH bits are reserved for architecture-specific
  * usage.
  */
-#define PERF_EVENT_FLAG_ARCH			0x000fffff
+#define PERF_EVENT_FLAG_ARCH			0x0fffffff
 #define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000
 
 static_assert((PERF_EVENT_FLAG_USER_READ_CNT & PERF_EVENT_FLAG_ARCH) == 0);
-- 
2.38.1


