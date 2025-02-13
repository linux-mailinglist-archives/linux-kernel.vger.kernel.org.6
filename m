Return-Path: <linux-kernel+bounces-512197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6508AA33579
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437AD188A397
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD03420100E;
	Thu, 13 Feb 2025 02:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gq4X4yc3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD91FFC49
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413406; cv=none; b=rejafqIYqkAqzpjV9zHZIknQMlh6yvJlb8YquMDaoKGdIdPmRI4jRE7b9pjpxfBh1Vgevgb78z0MYGfI5ZXw6BUFaHnTNlG5l+JqxjcFZkCnhwxo8IhV0HV2/BU7Eom6LglCC00gsmyZnlx0AX6U/SZcIkXQHiYV1sTLUNydP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413406; c=relaxed/simple;
	bh=ZSAnzdkmdJLNYcSofFL/U+XQeXOXxAeEjjNHEi9bfVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LooyRUF447xOoq7hSvBevffIEFGtU+AsqUXu/QK3NAmSIPy0uEs1s067S6X1i8rguZk6B41C+T0AWoFhQdVUGPw7kZszOR/AYv9ln1B0ytksYCFQwmio9Wo/3vS2ldFrMIDlUcacvR2qbyeKNysS2UJ7RsWJgZKiWWldkBN2Dzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gq4X4yc3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739413405; x=1770949405;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ZSAnzdkmdJLNYcSofFL/U+XQeXOXxAeEjjNHEi9bfVw=;
  b=Gq4X4yc3JAl0QeJLrFeRIJfApai+4/GTKj55ayBihcnpdJDc10t2bVYm
   ZZVRxT25HSBsfsvuIedWOIgbZI61KiA24pYsEZHPH9dwvMcFeDl2yWz6h
   jT/7DgV94VXjLlFlbHWN7ak60OE32BMUObLmuYAodKtZb0b+xEMSXjhk8
   Kqm6crUYo1JxOFCCPepFznhWcL8jFiiu4slb7O05xj4B2Qmv27Newf1S5
   RjGzdljozaZn/l7e9jMchsz2Xhhg0jDD9yRSOmRZaunp4puk7LmkBHP/V
   ok3uLIYrYm5R8REZzDROrq2/mNtxRfX09/R/yBt/tJLAvfeG+JRV6ihL1
   w==;
X-CSE-ConnectionGUID: OS1YE8GIRpKQPpSiEtuMDA==
X-CSE-MsgGUID: xUczwo/HSFOWznQi1VX7zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62566638"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="62566638"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 18:23:25 -0800
X-CSE-ConnectionGUID: shBFnaT5SPC9HQaY/L+M2Q==
X-CSE-MsgGUID: hMMj0999S5ayvn3/EaqEzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113905844"
Received: from rtice-desk1.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.116.160])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 18:23:23 -0800
From: Cedric Xing <cedric.xing@intel.com>
Date: Wed, 12 Feb 2025 20:23:06 -0600
Subject: [PATCH 3/4] x86/tdx: Add tdx_mcall_rtmr_extend() interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-tdx-rtmr-v1-3-9795dc49e132@intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
In-Reply-To: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 Cedric Xing <cedric.xing@intel.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: b4 0.13.0

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

The TDX guest exposes one MRTD (Build-time Measurement Register) and
three RTMR (Run-time Measurement Register) registers to record the
build and boot measurements of a virtual machine (VM). These registers
are similar to PCR (Platform Configuration Register) registers in the
TPM (Trusted Platform Module) space. This measurement data is used to
implement security features like attestation and trusted boot.

To facilitate updating the RTMR registers, the TDX module provides
support for the `TDG.MR.RTMR.EXTEND` TDCALL which can be used to
securely extend the RTMR registers.

Add helper function to update RTMR registers. It will be used by the
TDX guest driver in enabling RTMR extension support.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c           | 36 ++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/shared/tdx.h |  1 +
 arch/x86/include/asm/tdx.h        |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 32809a06dab4..9267fffecbef 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -35,6 +35,7 @@
 /* TDX Module call error codes */
 #define TDCALL_RETURN_CODE(a)	((a) >> 32)
 #define TDCALL_INVALID_OPERAND	0xc0000100
+#define TDCALL_OPERAND_BUSY	0x80000200
 
 #define TDREPORT_SUBTYPE_0	0
 
@@ -135,6 +136,41 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
 }
 EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);
 
+/**
+ * tdx_mcall_rtmr_extend() - Wrapper to extend RTMR registers using
+ *			     TDG.MR.RTMR.EXTEND TDCALL.
+ * @index: Index of RTMR register to be extended.
+ * @data: Address of the input buffer with RTMR register extend data.
+ *
+ * Refer to section titled "TDG.MR.RTMR.EXTEND leaf" in the TDX Module
+ * v1.0 specification for more information on TDG.MR.RTMR.EXTEND TDCALL.
+ * It is used in the TDX guest driver module to allow user extend the
+ * RTMR registers (index > 1).
+ *
+ * Return 0 on success, -EINVAL for invalid operands, -EBUSY for busy
+ * operation or -EIO on other TDCALL failures.
+ */
+int tdx_mcall_rtmr_extend(u8 index, u8 *data)
+{
+	struct tdx_module_args args = {
+		.rcx = virt_to_phys(data),
+		.rdx = index,
+	};
+	u64 ret;
+
+	ret = __tdcall(TDG_MR_RTMR_EXTEND, &args);
+	if (ret) {
+		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+			return -EINVAL;
+		if (TDCALL_RETURN_CODE(ret) == TDCALL_OPERAND_BUSY)
+			return -EBUSY;
+		return -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_mcall_rtmr_extend);
+
 /**
  * tdx_hcall_get_quote() - Wrapper to request TD Quote using GetQuote
  *                         hypercall.
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index fcbbef484a78..7b95c3113e79 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -12,6 +12,7 @@
 
 /* TDX module Call Leaf IDs */
 #define TDG_VP_VMCALL			0
+#define TDG_MR_RTMR_EXTEND		2
 #define TDG_VP_INFO			1
 #define TDG_VP_VEINFO_GET		3
 #define TDG_MR_REPORT			4
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b4b16dafd55e..6c73ab759223 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -64,6 +64,8 @@ bool tdx_early_handle_ve(struct pt_regs *regs);
 
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
+int tdx_mcall_rtmr_extend(u8 index, u8 *data);
+
 u64 tdx_hcall_get_quote(u8 *buf, size_t size);
 
 void __init tdx_dump_attributes(u64 td_attr);

-- 
2.43.0


