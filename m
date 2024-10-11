Return-Path: <linux-kernel+bounces-361570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC2A99A9E8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440C51C23438
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A71BCA0A;
	Fri, 11 Oct 2024 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiUA1qAC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7500B84E0A;
	Fri, 11 Oct 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667547; cv=none; b=VQ631kwPV/qrapHAIBjzejUqKObcNT7aGSIuMdUA86zglbbgyudU1+GJoUU/2l/duxGDq+IXrbG48rEAGS1IkogUCEec5kXtUYElpPvU9WV8xkn0sPePGJvnzJsEezJ6E9ibSwPOZnfPxIA0xI8I5+6SGM3x+1tyROdSpGW5UKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667547; c=relaxed/simple;
	bh=ObF400hR0lx7SnM1OGa7c3QDb1u/UbS9efaTl1Yk/g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ha61aq7Kyv6AuoSun7ipkhkpJyO00oFiTWDzWiayawM0weHfozBLHWftuKm+dwQGInO94sawY3tTrJ7FZmwMkVcT1av562P3cOBDNbW6zCjMpCK0FiiuezoOgwOgRvlOK7oBo4lucblYvEXnMrjZx14mE+TA6VnFwgQUcruMm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiUA1qAC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728667546; x=1760203546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ObF400hR0lx7SnM1OGa7c3QDb1u/UbS9efaTl1Yk/g4=;
  b=DiUA1qACzOUI/qNNmQlh6msTf0PvZKErXxrFfw/t4nLDaoEx5/D1mz8+
   PVkp/RbNTl5Qf7A23nCNroeVS7rnoHdhBVEmTs2U/ETrpINzQNLnMEDui
   7/AgUtzkK6wrcByraPmdmdi3oFmkFdCdBgJMVUhA4gXzioKXdqgbSuoi7
   r0qvxoU9qgjg83axOZ9IWGGP9Rgt5FAeAyYtypHr3Dkb2Smfy5CmsFVey
   zDmby5EWHnfwNF+41/+BQrmtwi9aGG0JnpE5ds1aC9JajcsOs/SIrWV9R
   2Q+XmKmrz/ZPwAi9JQaMMEoJpprxopJevK8Hq4b/nr3HdfGeZobWQ/ReH
   Q==;
X-CSE-ConnectionGUID: HzqdlhoNTFKxmOzVOENCTg==
X-CSE-MsgGUID: OBlACRvCTvaADwGBvdcjqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53481836"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="53481836"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 10:25:44 -0700
X-CSE-ConnectionGUID: hWqe/KRATrSgzzgb5jdKmA==
X-CSE-MsgGUID: Tf8nG0vyQ06bfNCJOl/TFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="107808346"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 11 Oct 2024 10:25:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A844D807; Fri, 11 Oct 2024 20:25:39 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	David Gow <davidgow@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [rfc, PATCH v1 1/1] platform/x86: intel: Add 'intel' prefix to the modules automatically
Date: Fri, 11 Oct 2024 20:24:09 +0300
Message-ID: <20241011172531.3407093-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework Makefile to add 'intel' prefix to the modules automatically.
This removes a lot of boilerplate code in it and also makes robust
against mistypos in the prefix.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Send as RFC because TBH I rather want to have something like this to be
available on the level of Kbuild for any of the subdirectories in
question. Also I haven't done any comprehensive build tests on this,
let's see what CIs think about this...

 drivers/platform/x86/intel/Makefile           | 68 ++++++++-----------
 .../intel/{intel_plr_tpmi.c => plr_tpmi.c}    |  0
 2 files changed, 29 insertions(+), 39 deletions(-)
 rename drivers/platform/x86/intel/{intel_plr_tpmi.c => plr_tpmi.c} (100%)

diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 74db065c82d6..21e9e21e0142 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -17,50 +17,40 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)	+= uncore-frequency/
 
 
 # Intel input drivers
-intel-hid-y				:= hid.o
-obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
-intel-vbtn-y				:= vbtn.o
-obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
+intel-target-$(CONFIG_INTEL_HID_EVENT)		+= hid.o
+intel-target-$(CONFIG_INTEL_VBTN)		+= vbtn.o
 
 # Intel miscellaneous drivers
-obj-$(CONFIG_INTEL_ISHTP_ECLITE)	+= ishtp_eclite.o
-intel_int0002_vgpio-y			:= int0002_vgpio.o
-obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
-intel_oaktrail-y			:= oaktrail.o
-obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
-intel_sdsi-y				:= sdsi.o
-obj-$(CONFIG_INTEL_SDSI)		+= intel_sdsi.o
-intel_vsec-y				:= vsec.o
-obj-$(CONFIG_INTEL_VSEC)		+= intel_vsec.o
+intel-target-$(CONFIG_INTEL_ISHTP_ECLITE)	+= ishtp_eclite.o
+
+intel-target-$(CONFIG_INTEL_INT0002_VGPIO)	+= int0002_vgpio.o
+intel-target-$(CONFIG_INTEL_OAKTRAIL)		+= oaktrail.o
+intel-target-$(CONFIG_INTEL_SDSI)		+= sdsi.o
+intel-target-$(CONFIG_INTEL_VSEC)		+= vsec.o
 
 # Intel PMIC / PMC / P-Unit drivers
-intel_bxtwc_tmu-y			:= bxtwc_tmu.o
-obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
-intel_crystal_cove_charger-y		:= crystal_cove_charger.o
-obj-$(CONFIG_X86_ANDROID_TABLETS)	+= intel_crystal_cove_charger.o
-intel_bytcrc_pwrsrc-y			:= bytcrc_pwrsrc.o
-obj-$(CONFIG_INTEL_BYTCRC_PWRSRC)	+= intel_bytcrc_pwrsrc.o
-intel_chtdc_ti_pwrbtn-y			:= chtdc_ti_pwrbtn.o
-obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
-intel_chtwc_int33fe-y			:= chtwc_int33fe.o
-obj-$(CONFIG_INTEL_CHTWC_INT33FE)	+= intel_chtwc_int33fe.o
-intel_mrfld_pwrbtn-y			:= mrfld_pwrbtn.o
-obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
-intel_punit_ipc-y			:= punit_ipc.o
-obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
+intel-target-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= bxtwc_tmu.o
+intel-target-$(CONFIG_X86_ANDROID_TABLETS)	+= crystal_cove_charger.o
+intel-target-$(CONFIG_INTEL_BYTCRC_PWRSRC)	+= bytcrc_pwrsrc.o
+intel-target-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= chtdc_ti_pwrbtn.o
+intel-target-$(CONFIG_INTEL_CHTWC_INT33FE)	+= chtwc_int33fe.o
+intel-target-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= mrfld_pwrbtn.o
+intel-target-$(CONFIG_INTEL_PUNIT_IPC)		+= punit_ipc.o
 
 # TPMI drivers
-intel_vsec_tpmi-y			:= tpmi.o
-obj-$(CONFIG_INTEL_TPMI)		+= intel_vsec_tpmi.o
-obj-$(CONFIG_INTEL_PLR_TPMI)		+= intel_plr_tpmi.o
-
-intel_tpmi_power_domains-y		:= tpmi_power_domains.o
-obj-$(CONFIG_INTEL_TPMI_POWER_DOMAINS)	+= intel_tpmi_power_domains.o
+intel-target-$(CONFIG_INTEL_TPMI)		+= vsec_tpmi.o
+intel-target-$(CONFIG_INTEL_PLR_TPMI)		+= plr_tpmi.o
+intel-target-$(CONFIG_INTEL_TPMI_POWER_DOMAINS)	+= tpmi_power_domains.o
 
 # Intel Uncore drivers
-intel-rst-y				:= rst.o
-obj-$(CONFIG_INTEL_RST)			+= intel-rst.o
-intel-smartconnect-y			:= smartconnect.o
-obj-$(CONFIG_INTEL_SMARTCONNECT)	+= intel-smartconnect.o
-intel_turbo_max_3-y			:= turbo_max_3.o
-obj-$(CONFIG_INTEL_TURBO_MAX_3)		+= intel_turbo_max_3.o
+intel-target-$(CONFIG_INTEL_RST)		+= rst.o
+intel-target-$(CONFIG_INTEL_SMARTCONNECT)	+= smartconnect.o
+intel-target-$(CONFIG_INTEL_TURBO_MAX_3)	+= turbo_max_3.o
+
+define INTEL_OBJ_TARGET
+intel-$(1)-y := $(1).o
+obj-$(2) += intel-$(1).o
+endef
+
+$(foreach target-y, $(basename $(intel-target-m)), $(eval $(call INTEL_OBJ_TARGET,$(target-y),y)))
+$(foreach target-m, $(basename $(intel-target-m)), $(eval $(call INTEL_OBJ_TARGET,$(target-m),m)))
diff --git a/drivers/platform/x86/intel/intel_plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
similarity index 100%
rename from drivers/platform/x86/intel/intel_plr_tpmi.c
rename to drivers/platform/x86/intel/plr_tpmi.c
-- 
2.43.0.rc1.1336.g36b5255a03ac


