Return-Path: <linux-kernel+bounces-185203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D678CB1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BF41C21FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351F51C68C;
	Tue, 21 May 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iH22YBEn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD2B1CD18
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307813; cv=none; b=iJIQeJABXCohhHcjypBUDvZ4ya9VIJOyASCfGdccbpQrDQmuw+UHlavzmJPrl9Ox3H4c9zcuuXdjomN8+YiwGe9CCobDJRtOybGBcVkvwcr93KbgCRQRhwD85B3+EwSOjX2ZPbtHUN4mzoEcQ47muj6G17w13035itKfusW+C7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307813; c=relaxed/simple;
	bh=68M2NDRggCs0VFE9AYWoncMfFrGsX4y4CaXof55Z9lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBR+CjDlNUzqJE8cyLLc+XdshWIgmx+bnUUkNE0Pqe7Whca+RWuxo0wbeJaizPTlOnro/+6nD6TJ3i4Zv/nVn269l7Gt2dBqOInv8cIlNhixOIJhWA4d/6nIG/wAnRQVpA7mDgKvJ7ZtWIqecznjX6pXPZfkOsCc+FnqBsgOll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iH22YBEn; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716307811; x=1747843811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=68M2NDRggCs0VFE9AYWoncMfFrGsX4y4CaXof55Z9lY=;
  b=iH22YBEnb+PRB7VhHisRWVd/ppgozKGHIjA9Lc98Ar94uHikSVJHP+aw
   1YXakqH7sL9mJlPbzeRzUgyAH1YofgQkrpRpnk0vroCNSqqtrUOiGBhB7
   LkQN+YNIGFYw2IJ2nE49L0S2aDATFgGfOo4ukNMrI9TAki7jy5m3T+uAK
   UDxnXbjyRuSbPSLhxQSjPgtCDxkUheGlTOaBVNsnHhhrQR7Z0ryKC3ew6
   JByO+Pme9gJ+3vMRO7Pcg8pcB0PuNBz586vZ3wVzyOX5tAdunSH6lG8CP
   2b/ro0jPeZadRjY8LiiFjOKkHTO2JrF5EhD/jxvER5P4rS4LJH+8fKmu/
   Q==;
X-CSE-ConnectionGUID: uDIkjjYfTXipXgu3TYwoNA==
X-CSE-MsgGUID: jaEBVVzVQYCM3Ye0VvTd2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12357959"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="12357959"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:10:11 -0700
X-CSE-ConnectionGUID: a8tXbICTTXeHaECMbbl+Zg==
X-CSE-MsgGUID: m5Lpxi2PS32s4xtVNbvnjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33129766"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 09:10:10 -0700
From: Tony Luck <tony.luck@intel.com>
To: andy@kernel.org
Cc: ak@linux.intel.com,
	arnd@arndb.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	mjguzik@gmail.com,
	patches@lists.linux.dev,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	tglx@linutronix.de,
	tony.luck@intel.com,
	trenn@suse.de,
	ubizjak@gmail.com,
	x86@kernel.org
Subject: [PATCH v6.1 16/49] x86/platform/intel-mid: Switch to new Intel CPU model defines
Date: Tue, 21 May 2024 09:10:01 -0700
Message-ID: <20240521161002.12866-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <Zkyrtgj7yQR8H-Bz@smile.fi.intel.com>
References: <Zkyrtgj7yQR8H-Bz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

N.B. Drop Haswell. CPU model 0x3C was included by mistake
in upstream code.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Andy Shevchenko <andy@kernel.org>
---
 arch/x86/platform/intel-mid/intel-mid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 7be71c2cdc83..f83bbe0acd4a 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -22,6 +22,7 @@
 #include <asm/mpspec_def.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
+#include <asm/cpu_device_id.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
 #include <asm/io.h>
@@ -55,9 +56,8 @@ static void __init intel_mid_time_init(void)
 
 static void intel_mid_arch_setup(void)
 {
-	switch (boot_cpu_data.x86_model) {
-	case 0x3C:
-	case 0x4A:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_ATOM_SILVERMONT_MID:
 		x86_platform.legacy.rtc = 1;
 		break;
 	default:
-- 
2.45.0


