Return-Path: <linux-kernel+bounces-181064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CFF8C7705
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039D81C21908
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34160146D49;
	Thu, 16 May 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OD0cqvwS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2696E14658E
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864641; cv=none; b=BOMuRNsbBy6TbeZhoPbuF31klFMuakf5Cob9ymVpGyL+lCqPYjc6CZNWdhFMbJQ0X2/TuSDhve9P8Z45RgYf/w7pu8pwPlMcw/rh7jb6/5AHi4agaLrZswWm9LAem3u6qmgKtD46oW6Zcz/4Qac8W84fL5HZq2Glt0AEHph5pJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864641; c=relaxed/simple;
	bh=WGVi5aGdGAHMERiHO+uuNhv6KeyDPpakxxwg5naMK3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FlTBeJvKLn+Nwp2pGfES5KePSZEFrpIzUREhATpW1NlG/zjRXiS13oSjITKtGO3N9e1pUINO8nqkj1XpI60Hs88vZMfHfeq3znaxoIXVNU+11URiSPyRpUUKpXYvmlHv3Fiy0E9k4nsjUxIoDkFatgcIhg1YH3A9ZwK5NkX7wOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OD0cqvwS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715864640; x=1747400640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WGVi5aGdGAHMERiHO+uuNhv6KeyDPpakxxwg5naMK3I=;
  b=OD0cqvwSmd3nqExP0glxOBjDO+drwZknMFM6r1+1ZvBxdM2CcJF4fnum
   rDkq2fpv4yYGB9qvMVJ8CWck7O+az43dtPamLrBvViT7zKSzsIgrwOc5z
   kRSRm+ctmr0v22AK/22foK/nu9V+Q6GYd/8+u/LkjkzT/SKxlxlWMNpKA
   DHTpGR5ySF06Ctns50mA1TJq5rdNYPNkB0lEe0Y8tT/KfeemGAs+VF4uV
   NjV47TcnTN0FTjo6W2PJN0+EiAPaZaWsTIGw8YZPB2eC7i1/7/1mHuMsg
   CcfruLXrFnH/x6kS7PetcrnWMPdtY7XVXZaLWMSULYT/VVeKp9aEH8N+7
   Q==;
X-CSE-ConnectionGUID: U3q6PpaiSWOAwMpae/bWoA==
X-CSE-MsgGUID: sAzC+abyTKa1AbB43+mbkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22551061"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="22551061"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:03:59 -0700
X-CSE-ConnectionGUID: /cXk0nLgSPuffZMaA2Cp5w==
X-CSE-MsgGUID: VZU03uQxQqOyCS3ANyZY9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31523926"
Received: from unknown (HELO chenyu-dev.sh.intel.com) ([10.239.62.107])
  by fmviesa010.fm.intel.com with ESMTP; 16 May 2024 06:03:53 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Prem Nath Dey <prem.nath.dey@intel.com>,
	Xiaoping Zhou <xiaoping.zhou@intel.com>
Subject: [PATCH] x86/paravirt: Disable virt spinlock when CONFIG_PARAVIRT_SPINLOCKS disabled
Date: Thu, 16 May 2024 21:02:44 +0800
Message-Id: <20240516130244.893573-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Performance drop is reported when running encode/decode workload and
BenchSEE cache sub-workload.
Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS
is disabled the virt_spin_lock_key is set to true on bare-metal.
The qspinlock degenerates to test-and-set spinlock, which decrease the
performance on bare-metal.

Fix this by disabling virt_spin_lock_key if CONFIG_PARAVIRT_SPINLOCKS
is not set, or it is on bare-metal.

Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/kernel/paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5358d43886ad..ee51c0949ed8 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -55,7 +55,7 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
+	if (!IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) ||
 	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		static_branch_disable(&virt_spin_lock_key);
 }
-- 
2.25.1


