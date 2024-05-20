Return-Path: <linux-kernel+bounces-184241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F268CA49E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B1D282031
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBD013B29C;
	Mon, 20 May 2024 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlqWPu/f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C0513A877
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245204; cv=none; b=EihsAS8tstDHlIZ+bLhXleMRORktj5AGfV/LbPCzpNv+4ZKa9mVs16DabygmT5qPEe7rt4POcI9VfV5XyGTdDdoqqzQfwOMpA1uMTGHaKisuQfFiD98VtBeIBJu3bJfdTeA8NJGWpY+BLA7U/dQgF3sqWOegMmbDVxxqvN0Wz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245204; c=relaxed/simple;
	bh=Sbt9Xz2Ynh3GTpeHeMDFV/YANtnFR7us28NjBssk4I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwGsS7MXSOQzOqNFZ8EssVfzdDr1ci7p4nCO+6vCGGVoK21f39XBojOYxpRBL6Wf415QBFRrvNbOaivD9vSDapv5kMP3u/toial+yhz7+y3dq8bSDLMhbLPY6XhYMZmAMn/YnXPVD1JmF0acIwemyVYw7bpTAupf12yV5dEjo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlqWPu/f; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245203; x=1747781203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sbt9Xz2Ynh3GTpeHeMDFV/YANtnFR7us28NjBssk4I0=;
  b=HlqWPu/f5Obu4XbrRboJm3rpvxGRcj8DjFVoEwRqD2u4dn/IyTDzAIbc
   9nqIQhJf1Embgdfp3QUX61OXLQwSKsN0zHUCeOn8KHIB7Oyrefe1442Ln
   yjCH9+h2IPxWZKiKmrOxdnCq8LiLlynOOlTbZF8Eqb3P8084Vqml36pF/
   /60FpLIytN6CMO/56C8CLzCPK4TuDsllt4mJZuxPsd8FSfIh7BYwx3X7X
   eMXzEmL5RShuMJiNweZA3roWja7O2KLQIPsvYbUL9+c8PdPM0AdPIQQdj
   tLl2sbqdSzcFvgnyAAB30WfXcWXa8YT+4h7QmA1JtsEYP/uWgMVZ3WOiL
   A==;
X-CSE-ConnectionGUID: Tr6h2YsMTUWx1+VFgUkL2Q==
X-CSE-MsgGUID: UcjgTQ6ERm+ONhwB8G0bHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199656"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199656"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
X-CSE-ConnectionGUID: /RMzd/acQ9ebCVb/gmjdGw==
X-CSE-MsgGUID: FryFEtdER5ub3QC3eqCGwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593424"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:36 -0700
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
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 14/49] ASoC: Intel: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:45 -0700
Message-ID: <20240520224620.9480-15-tony.luck@intel.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/platform_data/x86/soc.h         | 12 ++++++------
 drivers/thermal/intel/intel_soc_dts_thermal.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/platform_data/x86/soc.h b/include/linux/platform_data/x86/soc.h
index a5705189e2ac..f981907a5cb0 100644
--- a/include/linux/platform_data/x86/soc.h
+++ b/include/linux/platform_data/x86/soc.h
@@ -20,7 +20,7 @@
 static inline bool soc_intel_is_##soc(void)			\
 {								\
 	static const struct x86_cpu_id soc##_cpu_ids[] = {	\
-		X86_MATCH_INTEL_FAM6_MODEL(type, NULL),		\
+		X86_MATCH_VFM(type, NULL),			\
 		{}						\
 	};							\
 	const struct x86_cpu_id *id;				\
@@ -31,11 +31,11 @@ static inline bool soc_intel_is_##soc(void)			\
 	return false;						\
 }
 
-SOC_INTEL_IS_CPU(byt, ATOM_SILVERMONT);
-SOC_INTEL_IS_CPU(cht, ATOM_AIRMONT);
-SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
-SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
-SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
+SOC_INTEL_IS_CPU(byt, INTEL_ATOM_SILVERMONT);
+SOC_INTEL_IS_CPU(cht, INTEL_ATOM_AIRMONT);
+SOC_INTEL_IS_CPU(apl, INTEL_ATOM_GOLDMONT);
+SOC_INTEL_IS_CPU(glk, INTEL_ATOM_GOLDMONT_PLUS);
+SOC_INTEL_IS_CPU(cml, INTEL_KABYLAKE_L);
 
 #undef SOC_INTEL_IS_CPU
 
diff --git a/drivers/thermal/intel/intel_soc_dts_thermal.c b/drivers/thermal/intel/intel_soc_dts_thermal.c
index 9c825c6e1f38..718c6326eaf4 100644
--- a/drivers/thermal/intel/intel_soc_dts_thermal.c
+++ b/drivers/thermal/intel/intel_soc_dts_thermal.c
@@ -36,7 +36,7 @@ static irqreturn_t soc_irq_thread_fn(int irq, void *dev_data)
 }
 
 static const struct x86_cpu_id soc_thermal_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT, BYT_SOC_DTS_APIC_IRQ),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT, BYT_SOC_DTS_APIC_IRQ),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, soc_thermal_ids);
-- 
2.45.0


