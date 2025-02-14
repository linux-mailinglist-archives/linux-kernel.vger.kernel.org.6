Return-Path: <linux-kernel+bounces-515069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7268A35F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E3B3A56C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B945264A78;
	Fri, 14 Feb 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbnUz+SR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EF0263F3D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739540673; cv=none; b=Reb6juXDFtBTskYA76cTxxyGg81xYuopFjelZUP3H1Uw2rMyXRbjzQ2dObCy42KqYZo6Twr22Z2xvFa1QF4FPDdOhaR5eGisKjjk+5FgnpCYoeXEqJhoHNw90vd6VlO84VAgHmhSAUt1FfM+pmgzezEKVJXvBG3iYIPnNInidGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739540673; c=relaxed/simple;
	bh=3RYhKJF0Pcxuz6PmZ9Ku/CakibUNucj8a9d8k/flz+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foOy/hVpwaMcuQgmlsZhXQRpRsYM57wBaTzUbT2G39Nf14RXOIe3Ni9kh01liA4aqFRiieuj9D828Ww/r9bs//d26bPy4vsiYGA+xgzGDoH4wAOmsE0ssuTdnoQTYhdv7UxVJ8XrRNOUBaXX0R5+x24OG8273AlM4UT2qhuU9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbnUz+SR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739540671; x=1771076671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3RYhKJF0Pcxuz6PmZ9Ku/CakibUNucj8a9d8k/flz+k=;
  b=mbnUz+SRDN/S9bqOrFqW9VeEquvMsf/SyX0ViNaOcGzLEfSvXBimP0nC
   2vqdSnAQeK+ok+MQyZIfGHlNKdtwsjnoXkQeQhc/w2tTD1pEDQQwGc1DY
   49u26/eFKBmyl+dxx9MTx30Fl+GCEZjfPfUL+NQA5IjiaryUVliQPJyyy
   EjlloSmaD579PFL7gqjBs2e3Xl8dvOxEFWEtNMWnuMM2Dl8ofmaWJmWgs
   5mqLhEtXsf88JZfpfplJ6b3ZBV8R+OhHVTdlEdBgURXqaNmMPURTJdoKq
   ccJIzfgu6nLJ/zwWQ/m8yqoiTMopoTMjUvtyWBFpBqNakxBPMZGMX0UWZ
   A==;
X-CSE-ConnectionGUID: GU5BkeUeQK239NMK0sOuRw==
X-CSE-MsgGUID: RN7vPTbYSdq27kau4ivnag==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50932930"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="50932930"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:44:30 -0800
X-CSE-ConnectionGUID: 1NA1ghsyRSO2lTDuOrvutg==
X-CSE-MsgGUID: Nf+kADmATGuhC/6MLlYvag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118395453"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 14 Feb 2025 05:44:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E740717A2; Fri, 14 Feb 2025 15:44:25 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] hrtimers: Replace hrtimer_clock_to_base_table approach with switch-case
Date: Fri, 14 Feb 2025 15:43:33 +0200
Message-ID: <20250214134424.3367619-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang (and GCC as well) complains about overlapped initialisers
in the hrtimer_clock_to_base_table definition. With `make W=1`
and CONFIG_WERROR=y (which is default nowadays) this breaks
the build:

  CC      kernel/time/hrtimer.o
kernel/time/hrtimer.c:124:21: error: initializer overrides prior initialization of this subobject [-Werror,-Winitializer-overrides]
  124 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,

kernel/time/hrtimer.c:122:27: note: previous initialization is here
  122 |         [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,

(and similar for CLOCK_MONOTONIC, CLOCK_BOOTTIME, and CLOCK_TAI).

Replace hrtimer_clock_to_base_table approach with switch-case to make
the compiler happy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: dropped 'rfc', rewrote to use switch-case (Thomas)

 kernel/time/hrtimer.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index deb1aa32814e..453dc76c9348 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -117,16 +117,6 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 	.csd = CSD_INIT(retrigger_next_event, NULL)
 };
 
-static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
-	/* Make sure we catch unsupported clockids */
-	[0 ... MAX_CLOCKS - 1]	= HRTIMER_MAX_CLOCK_BASES,
-
-	[CLOCK_REALTIME]	= HRTIMER_BASE_REALTIME,
-	[CLOCK_MONOTONIC]	= HRTIMER_BASE_MONOTONIC,
-	[CLOCK_BOOTTIME]	= HRTIMER_BASE_BOOTTIME,
-	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
-};
-
 static inline bool hrtimer_base_is_online(struct hrtimer_cpu_base *base)
 {
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
@@ -1587,14 +1577,19 @@ u64 hrtimer_next_event_without(const struct hrtimer *exclude)
 
 static inline int hrtimer_clockid_to_base(clockid_t clock_id)
 {
-	if (likely(clock_id < MAX_CLOCKS)) {
-		int base = hrtimer_clock_to_base_table[clock_id];
-
-		if (likely(base != HRTIMER_MAX_CLOCK_BASES))
-			return base;
+	switch (clock_id) {
+	case CLOCK_REALTIME:
+		return HRTIMER_BASE_REALTIME;
+	case CLOCK_MONOTONIC:
+		return HRTIMER_BASE_MONOTONIC;
+	case CLOCK_BOOTTIME:
+		return HRTIMER_BASE_BOOTTIME;
+	case CLOCK_TAI:
+		return HRTIMER_BASE_TAI;
+	default:
+		WARN(1, "Invalid clockid %d. Using MONOTONIC\n", clock_id);
+		return HRTIMER_BASE_MONOTONIC;
 	}
-	WARN(1, "Invalid clockid %d. Using MONOTONIC\n", clock_id);
-	return HRTIMER_BASE_MONOTONIC;
 }
 
 static enum hrtimer_restart hrtimer_dummy_timeout(struct hrtimer *unused)
-- 
2.45.1.3035.g276e886db78b


