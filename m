Return-Path: <linux-kernel+bounces-184230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EEC8CA493
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1736E1F22464
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8CD13956B;
	Mon, 20 May 2024 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5PLBLSt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6901CD32
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245199; cv=none; b=cGMR/srut/87DllwwSs0B+qoUYdBF57CaZuV0I3HhlPMcuSPYtiJZ98kDu0HpIJUZZZNb82pnCMeg6jh4F5+SCKYiuRJ0jHssrQNrwnlw/rIozOEb2oXUr6aG24eWy3Hmn/S22dtSWTET75y2Ng77MTwQBXP+VxWLdSDqVyXZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245199; c=relaxed/simple;
	bh=v93/ual/g32vB/MEMraEt8b9ts3LdceCjM3EwpB5y20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLP3sHlk1rpb7iD/iDLBzgN0AJzpYC5sHZN3jnpGfMIE0GthE0RIBu+6gqg9lPw16H/NWd+WImdnkPoLBhg9oyZZOabg3fHWJm3PKZrj91VH/z6oPhbZFJ/wi9rN182EssGw7O1Lt3e7C8NAXlgrLeM6+ME3RgJ5yMutnWkwRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5PLBLSt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245198; x=1747781198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v93/ual/g32vB/MEMraEt8b9ts3LdceCjM3EwpB5y20=;
  b=X5PLBLSt6bj52vVFsHTH6qm5+95UU3cMqa2Imhbg6mdmNUyfEymoJ/mK
   NyYl0MsqTRsdWbJkae131ySB6Xmua0k/W43uF3J+Ew5mlOw/xDnsCsY0L
   thWyIwb/zDaRQkfvg9QtudnAv5h2azGmRzz8BDNB1eJwyEbz5TtwFSopo
   1hQrnWP4ZL3J6b9LUvM1UbiomXPLExtk6lDAXwZeG8yIGd6khpshDCMlY
   NVyf1iEYwN5cZmAqXMlRTsDoDmUL5aUD+ZX/mlJbZxlq1Y54lWHXzv6bm
   WRi0MelsqRRHoaXggYzxuAtVFimTRRWBMgdSrc9t1Pe4sU0cmCa8q3/Db
   A==;
X-CSE-ConnectionGUID: ejzUp/NKT42jj1ryMCs45Q==
X-CSE-MsgGUID: U/9F5LWzQGiZQymKEEMeuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199529"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199529"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:35 -0700
X-CSE-ConnectionGUID: 8wuCngyrRqutNflgnQSAEA==
X-CSE-MsgGUID: /viPDrVoQp+zeZMF0zFKDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593389"
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
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v6 03/49] tpm: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:34 -0700
Message-ID: <20240520224620.9480-4-tony.luck@intel.com>
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm.h          | 2 +-
 drivers/char/tpm/tpm_tis_core.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 6b8b9956ba69..7bb87fa5f7a1 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -28,7 +28,7 @@
 #include <linux/tpm_eventlog.h>
 
 #ifdef CONFIG_X86
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #endif
 
 #define TPM_MINOR		224	/* officially assigned */
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 13e99cf65efe..690ad8e9b731 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -210,7 +210,7 @@ static inline int tpm_tis_verify_crc(struct tpm_tis_data *data, size_t len,
 static inline bool is_bsw(void)
 {
 #ifdef CONFIG_X86
-	return ((boot_cpu_data.x86_model == INTEL_FAM6_ATOM_AIRMONT) ? 1 : 0);
+	return (boot_cpu_data.x86_vfm == INTEL_ATOM_AIRMONT) ? 1 : 0;
 #else
 	return false;
 #endif
-- 
2.45.0


