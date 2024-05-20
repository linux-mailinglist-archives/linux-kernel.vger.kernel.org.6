Return-Path: <linux-kernel+bounces-184243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE7E8CA4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3548028222D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFC313B5A6;
	Mon, 20 May 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkqdPm0i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544413A88F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245205; cv=none; b=MZFaCrEYFqjVP6CRGaC0Cp/mBcRrkJi4Su8h9l2DFqzUKnkhMudNVtq9LLxNBR3czp8v17NYIfnx9uhikqIWcs008jeBmpDuS8t4WxMW4179T0xGCyS93gI5XslrDz4Fb5El+ohGuTa76jJ0QfyUBjzPBsYndRX22p2H7he7vUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245205; c=relaxed/simple;
	bh=FIC0xFut5c+dBJm8+57uC03WUNJXEVf8utVvAkqVtLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGOVsgLkPUNfzuDbCtjjAotjjg55fVn0urOkCOFt5VQXc56ydm8zaN6X74Hck2gwAr/A9QcPpYxEMOanxE7jpRj/3a9aqmjRPSOH+f2r8bKdlUWCDE5WD8mvRNQehT7J1gYtbTBMvLJ14MIMdxBuBrjRG/2oISVJw3fUizHmeC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkqdPm0i; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245203; x=1747781203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FIC0xFut5c+dBJm8+57uC03WUNJXEVf8utVvAkqVtLQ=;
  b=ZkqdPm0iMcTWZgVKSeS73s8Vu8kI9UDNifJwruyMiXnAJqXVrVSiGU/v
   A9CjvmrDa2GB0KJeXhuRLs355hgE0h8kS4G1vXbxwPePXSvbXhrR9ze9v
   KhDNevckf5/hCLJ9jX83w4MAF40+svmue+QlAGmGEpCt5rjy/ItwojbDx
   dnqKCwAr8QWcOMbnHfqNE2lU2P3YuU9P/WbzcCjuzhLhcs1H4iQRLmqI7
   dmGA+y/euYyK4TNxQWBHYncX6TyWB5M2H59KgmJk5HkcUcBdujShf0ufz
   9vhnhuRsio4h5RHD2aI0qFxkgeDE3ev5DLd8sghUckMo/AVAxs+Dp8XyR
   w==;
X-CSE-ConnectionGUID: ++PNyATGQ2KLOAZb/Q6YrQ==
X-CSE-MsgGUID: mbDMhmQsR/+woDAquWBD0A==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199667"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199667"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:37 -0700
X-CSE-ConnectionGUID: ZhCNIb8YTK+0/oIxg1IvcA==
X-CSE-MsgGUID: lyNRLwAaS5CUUXjAkoDAaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593427"
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
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 15/49] thermal: intel: intel_tcc_cooling: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:46 -0700
Message-ID: <20240520224620.9480-16-tony.luck@intel.com>
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
 drivers/thermal/intel/intel_tcc_cooling.c | 30 +++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 6c392147e6d1..63696e7d7b3c 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -49,21 +49,21 @@ static const struct thermal_cooling_device_ops tcc_cooling_ops = {
 };
 
 static const struct x86_cpu_id tcc_ids[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE, NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE, NULL),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE, NULL),
+	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_COMETLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
 	{}
 };
 
-- 
2.45.0


