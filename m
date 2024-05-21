Return-Path: <linux-kernel+bounces-184245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B615C8CA4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1E31F2278D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632D913BADF;
	Mon, 20 May 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KjEMpm5v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9C13AD22
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245207; cv=none; b=pHttMBVkyS8Iauk2wohugJW1fhfj8wOCdaXZkKu8IV/nMtmsbwlaY8b1A0YMYeuvIgH12Q88+spAst8KDKLyuZF9YD4jKPMp+FhCa9oqu4+PZSH59RYXCayrYPzF49yU1O651+w0tJ0qf8oUkuh2EUQ9t0T5fWgXnmt8CHmGSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245207; c=relaxed/simple;
	bh=yaJboBMEPLKvR1jTeG+KSsAACemlTofNhMPhw7StcCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rgsa6ThjFuul/FFlCm3OOAfejLiejiKPic1RoyKEHpACM/regVBr+aVdcwRekrNrO2CI3otGeJWjZYVf7GPh6hV6TgS1LQbIh6KyqDZNVPhpKO3jPIDh/C/Wo3QBjZJ2RHQ8dh2YAbOSNmD5rrQzjcAmwwKX195+4x7q0AEgg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KjEMpm5v; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245205; x=1747781205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yaJboBMEPLKvR1jTeG+KSsAACemlTofNhMPhw7StcCg=;
  b=KjEMpm5vFSr19NBf9TNaO6wJZtTAheACIbjCsITj9bcaGCL4J8cxgioy
   9t98pbtoLioIRd27n48VYfA7R7PkL4HtbU4sNbkoQNrDtDBLBm/QTRmmJ
   7+GjtBcMOdWnJtKNg3OsW38ZGaUFKVLGH59fiqTZ6yYrEeGfKQwLgKrdk
   5h2/se1ql7jnJnuX4cVXe3dOwRDIYKpvF75gSDZGcKjMP4GAIwaFR9eQo
   GSBYYx6CTshJJHwGdva6iksOHlVALciP0NTBPiZsG+l2UaAhlVbb1lMtW
   kCXzoVaeNCjy6S7kgdllLBRwZ+cy3bEOWFKgfcPEkRFCtReIVf/eqjixF
   w==;
X-CSE-ConnectionGUID: jaDTYVhfRNCGAXUVS7vPRQ==
X-CSE-MsgGUID: E9wlgTPZSqms3zbLiw+e+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199701"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199701"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
X-CSE-ConnectionGUID: oug6AUxBQKuX+951Q1CcwQ==
X-CSE-MsgGUID: tzverJqoQd2OzgA4pIuA/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593436"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Luck <tony.luck@intel.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Thomas Renninger <trenn@suse.de>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 18/49] platform/x86: intel-uncore-freq: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:49 -0700
Message-ID: <20240520224620.9480-19-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520224620.9480-1-tony.luck@intel.com>
References: <20240520224620.9480-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 .../intel/uncore-frequency/uncore-frequency.c | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index b89c0dda9e5d..b80feaf5828f 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -197,34 +197,34 @@ static struct notifier_block uncore_pm_nb = {
 };
 
 static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M, NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,	NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,	NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,	NULL),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_COMETLAKE, NULL),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
+	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);
-- 
2.45.0


