Return-Path: <linux-kernel+bounces-279038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C1A94B82B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A6C1C23BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A18184114;
	Thu,  8 Aug 2024 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVZbyA0L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E238188CA7
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103277; cv=none; b=YYcg3gWsxAl5huaF159v59I17TKq8y/xtiRzcw4xhig+xLlGnvoorpLpZYWaNX71Ifj4Amj1YoLnaYFQiq9lP9kfr1N3Zb6WS6Cqdyn3z2sLoFUW5OzFuHDX2WZJhR5IqUdMfOrLfh5Ay0v1rFW2jX1ksuuXLWJ8mWxK84z2m9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103277; c=relaxed/simple;
	bh=kRefNyGkY58doqRLS+Q3D+2QDtqbzSeMiWn5qKzcAFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cgcz9OLDX72jBI5qQB32Wyqxgysn54pdlSzhTZ2wKBwt1bseB3I3jmq1SAFH1pKeJgYPZBGCtNbUtc9HR4bK6NFJbwEr7LgFrAetD9AYbVtCRBjLEn049XDAMceZjCSlhGqz0yyngy2Qx3+/RUpNSoimldJcBOJuwJIJ8eWMg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVZbyA0L; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723103275; x=1754639275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRefNyGkY58doqRLS+Q3D+2QDtqbzSeMiWn5qKzcAFA=;
  b=YVZbyA0LAWVVKKESfB0Lmtyxx5C+5ckAV4PlDxs7XZQunuTAZfOWOxuG
   ZAbV062q4uj7D/Ku8PCDocGxomHyykKPY/1djKOXcoITbZpmxWhhcpH6y
   5RDap9smn13TaR/yMlthEv5KnF9DS1gygwb/lOAqafaLghknuztp1PLhI
   0uID1eit9wO9xhPjaI1bUzJhD+mWYgOe1AbnVk6A4L+76jyPSFVIiyD2O
   iJ+VB/qsVbP6CS94610hVpq1YEWsJPM/kLXzwYraIZvZKEMUGd5xUf/cH
   qp5jZnYJQp1sZbKKPiLU6HBmY2SPT+SeR9s5h73O3RJ0Gn6VoOD0N2FTE
   g==;
X-CSE-ConnectionGUID: fUFfFmb6RxqzJfp4j/RuRw==
X-CSE-MsgGUID: Xy61wjYeTdiskhIgCAY7lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="38720978"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="38720978"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 00:47:55 -0700
X-CSE-ConnectionGUID: Sh2Szmc/R2K0jeZyEtVSjw==
X-CSE-MsgGUID: 7RKhpyrNQlyYysawyexD4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57090931"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2024 00:47:52 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 1/4] perf/x86: Refine hybrid_pmu_type defination
Date: Thu,  8 Aug 2024 14:02:07 +0000
Message-Id: <20240808140210.1666783-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
References: <20240808140210.1666783-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use macros instead of magic number to define hybrid_pmu_type and remove
X86_HYBRID_NUM_PMUS since it's never used.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/events/perf_event.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ac1182141bf6..5d1677844e04 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -674,19 +674,16 @@ enum hybrid_cpu_type {
 	HYBRID_INTEL_CORE	= 0x40,
 };
 
+#define X86_HYBRID_PMU_ATOM_IDX		0
+#define X86_HYBRID_PMU_CORE_IDX		1
 enum hybrid_pmu_type {
 	not_hybrid,
-	hybrid_small		= BIT(0),
-	hybrid_big		= BIT(1),
+	hybrid_small		= BIT(X86_HYBRID_PMU_ATOM_IDX),
+	hybrid_big		= BIT(X86_HYBRID_PMU_CORE_IDX),
 
 	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
 };
 
-#define X86_HYBRID_PMU_ATOM_IDX		0
-#define X86_HYBRID_PMU_CORE_IDX		1
-
-#define X86_HYBRID_NUM_PMUS		2
-
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
-- 
2.40.1


