Return-Path: <linux-kernel+bounces-184232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A058CA495
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A411F1C21406
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE679139D13;
	Mon, 20 May 2024 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="esvVkENu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548405026E
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245200; cv=none; b=iEJcU4HvoH/I/+j0k4FothThbZVCWgJpcX0DKBvi92LVAbHT/4eDNbnaV1qplguv6AbMJGTUGUddHGhDjPA0lpcNFCgwuKtrAA3VNtEQEgzWJY4trr1SMlLQNKsJ5wGc4QGUIxo/tPC3gvmlTRue7Tdtfg75vFMnBaLuzRXMnG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245200; c=relaxed/simple;
	bh=R7lJm8y1wTPr9sOO4og3VXb29EESiuJx3kDAU5wPuLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv6zr5klD8s9w5aUhPtPiAZRNzBGwm/3FNzdMu95Zg2M7rNEnZlBv+PYodKnRHyMtya8221rj8QvVOjNKgxv75Ag5iz7zgRRcCYKuLIEuqqA0bQjm2tk03VRSAAdUWgpmJfp0pggLKNwu06jM3CGGfZl/C/AKvbFXNyLoUlunfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=esvVkENu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245198; x=1747781198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R7lJm8y1wTPr9sOO4og3VXb29EESiuJx3kDAU5wPuLo=;
  b=esvVkENuTE25h1bd6mfotyTf34BPPsdEryy214C3S58V+n8SH3qdnq7U
   kXgtG64jUvg3cAtLwxVY+auw3NyqC93FqSMsdlkxLwfp7iH0b2hv1oVaY
   4xmVBGl+ELXgyXvNgX/ikJZI4Ij7EGWObGCJxpRQLDGdc0vUTm33Pg14O
   GmQTxQiNBFfFBBwXMmCPHu0XUkdlTyqywPvQBBPgLY1wvHJC5yoAFgGBb
   Ck0+XyQfQHhkt4pJGVPM1hGAIhXcH2NMfGoKu6A92UvGyZP3SoFj7miBE
   lxaG3QL8m+L6c+HgsYV98UbIzajo2eEFGisSFXo4T23BbRAiWhalVxjxG
   w==;
X-CSE-ConnectionGUID: w3IDjXf+QQmeHTogPp8/6Q==
X-CSE-MsgGUID: PBNf28dIRDKP3Yb30IWBTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199551"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199551"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:35 -0700
X-CSE-ConnectionGUID: m5auZqylSLesyZVyyHIuXg==
X-CSE-MsgGUID: Q5vCGZJGRheBZu3aCQ6ysQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593396"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:35 -0700
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
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 05/49] media: atomisp: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:36 -0700
Message-ID: <20240520224620.9480-6-tony.luck@intel.com>
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
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 .../atomisp/include/linux/atomisp_platform.h  | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
index 0e3f6fb78483..fdeb247036b0 100644
--- a/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp_platform.h
@@ -18,7 +18,7 @@
 #ifndef ATOMISP_PLATFORM_H_
 #define ATOMISP_PLATFORM_H_
 
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 
 #include <linux/i2c.h>
@@ -178,22 +178,17 @@ void atomisp_unregister_subdev(struct v4l2_subdev *subdev);
 int v4l2_get_acpi_sensor_info(struct device *dev, char **module_id_str);
 
 /* API from old platform_camera.h, new CPUID implementation */
-#define __IS_SOC(x) (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && \
-		     boot_cpu_data.x86 == 6 &&                       \
-		     boot_cpu_data.x86_model == (x))
-#define __IS_SOCS(x,y) (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && \
-		        boot_cpu_data.x86 == 6 &&                       \
-		        (boot_cpu_data.x86_model == (x) || \
-		         boot_cpu_data.x86_model == (y)))
-
-#define IS_MFLD	__IS_SOC(INTEL_FAM6_ATOM_SALTWELL_MID)
-#define IS_BYT	__IS_SOC(INTEL_FAM6_ATOM_SILVERMONT)
-#define IS_CHT	__IS_SOC(INTEL_FAM6_ATOM_AIRMONT)
-#define IS_MRFD	__IS_SOC(INTEL_FAM6_ATOM_SILVERMONT_MID)
-#define IS_MOFD	__IS_SOC(INTEL_FAM6_ATOM_AIRMONT_MID)
+#define __IS_SOC(x) (boot_cpu_data.x86_vfm == x)
+#define __IS_SOCS(x, y) (boot_cpu_data.x86_vfm == x || boot_cpu_data.x86_vfm == y)
+
+#define IS_MFLD	__IS_SOC(INTEL_ATOM_SALTWELL_MID)
+#define IS_BYT	__IS_SOC(INTEL_ATOM_SILVERMONT)
+#define IS_CHT	__IS_SOC(INTEL_ATOM_AIRMONT)
+#define IS_MRFD	__IS_SOC(INTEL_ATOM_SILVERMONT_MID)
+#define IS_MOFD	__IS_SOC(INTEL_ATOM_AIRMONT_MID)
 
 /* Both CHT and MOFD come with ISP2401 */
-#define IS_ISP2401 __IS_SOCS(INTEL_FAM6_ATOM_AIRMONT, \
-			     INTEL_FAM6_ATOM_AIRMONT_MID)
+#define IS_ISP2401 __IS_SOCS(INTEL_ATOM_AIRMONT, \
+			     INTEL_ATOM_AIRMONT_MID)
 
 #endif /* ATOMISP_PLATFORM_H_ */
-- 
2.45.0


