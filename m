Return-Path: <linux-kernel+bounces-169785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E4E8BCD98
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B8F1C2283B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F41144303;
	Mon,  6 May 2024 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YCyP90g5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A9143C4E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714997763; cv=none; b=DC1C2dw70/0KhbPWfDWgXm7OCcK7HryXVwSmhdd+gTPWDpRQLIjoBSPaSmunMHENhhcTrOXSokIRL6/tHe+Sd4DYmGSorR8CBKOR0UbYttkJWdXF2+AtYNahNqZyaLfgrDjeAmf1XCQu5vbZF5bWZ9QTevimQphZ9vaLGOMJ3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714997763; c=relaxed/simple;
	bh=UWI7SZcBOgCHA8M9jnJU6XD2NRmEw9ukmCbYEbQq3A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQTzUvuQAisi+2H4Qr6STq2CGWb9dUVBmSCpoHlzAHvpTV2LZ8lx6Kj2vs5J9jGXLcPNANzLXR0qPRBBXeRnG00QiXADamJZgyMHOWf4HQRFmOU0ldoNonPaKDjsgBiiRLPYxs6TfZ5jc/ya6pY7jrVfRSwhgt07nRJqPclQeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YCyP90g5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714997762; x=1746533762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UWI7SZcBOgCHA8M9jnJU6XD2NRmEw9ukmCbYEbQq3A4=;
  b=YCyP90g5jShosYMbGTwgEXoXTcXK05SWfcEulNIut1H71uYKlyL4Zs2e
   rfvClZFOpuw9OClc4hpjTDZxqP3A61lp0oaPw/gNgUZ5RjHn13HpeS6z7
   4k41oV3lFYMMQyAws267bf3W3znGPPOLD4bMqhlWbjLubtUehIhLBpkJN
   M6V1vrZsWykHkyZkgKDhYkhsDJhgk5eFBeKBwP7G287YNAleQatuAcvOm
   Fl3WX7JTU9cebwN1ftz0WyvoOhM8w7s+TU149cAgz+FwEAD1lOZ7ICtC8
   Y6zlqdkxRoguskiTkPsDR7oXbCcmuIgzkMTix2t0maAAycTj8CPrLd9pL
   A==;
X-CSE-ConnectionGUID: CyzDtEFsSXiqf8VWlYY4aQ==
X-CSE-MsgGUID: sdYBnUS+RXCFzCw1YC3HFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14544143"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="14544143"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 05:15:58 -0700
X-CSE-ConnectionGUID: OKLBKEwtQieC/6PqpPobyQ==
X-CSE-MsgGUID: irIzFggdSm6mCpgEpf1how==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="32951441"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 06 May 2024 05:15:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DC7D5161; Mon, 06 May 2024 15:15:54 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kai Huang <kai.huang@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCHv3 1/4] x86/tdx: Factor out TD metadata write TDCALL
Date: Mon,  6 May 2024 15:15:50 +0300
Message-ID: <20240506121553.3824346-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506121553.3824346-1-kirill.shutemov@linux.intel.com>
References: <20240506121553.3824346-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDG_VM_WR TDCALL is used to ask the TDX module to change some
TD-specific VM configuration. There is currently only one user in the
kernel of this TDCALL leaf.  More will be added shortly.

Refactor to make way for more users of TDG_VM_WR who will need to modify
other TD configuration values.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 59776ce1c1d7..b926221f1264 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -77,6 +77,18 @@ static inline void tdcall(u64 fn, struct tdx_module_args *args)
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/* Write TD-scoped metadata */
+static inline u64 tdg_vm_wr(u64 field, u64 value, u64 mask)
+{
+	struct tdx_module_args args = {
+		.rdx = field,
+		.r8 = value,
+		.r9 = mask,
+	};
+
+	return __tdcall(TDG_VM_WR, &args);
+}
+
 /**
  * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
  *                           subtype 0) using TDG.MR.REPORT TDCALL.
@@ -902,10 +914,6 @@ static void tdx_kexec_unshare_mem(void)
 
 void __init tdx_early_init(void)
 {
-	struct tdx_module_args args = {
-		.rdx = TDCS_NOTIFY_ENABLES,
-		.r9 = -1ULL,
-	};
 	u64 cc_mask;
 	u32 eax, sig[3];
 
@@ -924,7 +932,7 @@ void __init tdx_early_init(void)
 	cc_set_mask(cc_mask);
 
 	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdcall(TDG_VM_WR, &args);
+	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit
-- 
2.43.0


