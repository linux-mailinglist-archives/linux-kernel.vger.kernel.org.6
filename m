Return-Path: <linux-kernel+bounces-224748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A573C912671
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7401C25A00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D4155308;
	Fri, 21 Jun 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="N0l3VN2H"
Received: from out187-22.us.a.mail.aliyun.com (out187-22.us.a.mail.aliyun.com [47.90.187.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D38153828
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975559; cv=none; b=szyM5iQSRC0GHscejNuN9LppnERmGZ8MZr7dmXdhCqjp9+yqxaSo/EkqtSjZPQPPJNOY+nAQo6SJGqSLevmz1DGP11S3LPnekkswR5Y/Ej743x2gC/lWx38fF3zJy5vznSSEV4A9gNx/Zn1aURYtBMAF6lyeGREYxx33j4jVt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975559; c=relaxed/simple;
	bh=+xMg+CT+lZw5iQTZjzgT5GAw+4YOR7iBvRuzydoe7Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0RGScDN4zt4P/IVBAwsSIv7f00uID3HszzF8pqHlsEtlscyWcFC1M3EwwzdiRuv8+Qf1qKX9PHIC30yRsDgTxE47ISQbgHAfCAcMD3ctqLOZzhZagyoWAW2TmLx453BwEDrTKOlWCYP29hE6ZxbOjuNZp4TSpfZt7t8qID3lMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=N0l3VN2H; arc=none smtp.client-ip=47.90.187.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1718975544; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vyY1llCOBdHXh3JAy94cv9WtqjgU56cRwhmb6UBepy4=;
	b=N0l3VN2H0qDnKurzOdzmkXAfdkVprXgn4VJ5nj7hhCiMk14J4ygNyo/TrPGiVDiIEmHSoOTbk0XJkrx1DGfq7o8rwpp5mf+x8sLfqdrhfvnefDnBucrEH+4ayzTjaphoTDGe04FX7T/2s1lH9ZfSx1jjDOBZxpk4IkLmHpR3z04=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070043001;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.Y74rBf5_1718975542;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.Y74rBf5_1718975542)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 21:12:23 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: linux-kernel@vger.kernel.org
Cc: "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
  "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
  "Xin Li" <xin@zytor.com>,
  "H. Peter Anvin" <hpa@zytor.com>,
  "Andy Lutomirski" <luto@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,
  "Ingo Molnar" <mingo@redhat.com>,
  "Borislav Petkov" <bp@alien8.de>,
  "Dave Hansen" <dave.hansen@linux.intel.com>,
   <x86@kernel.org>,
  "Peter Zijlstra" <peterz@infradead.org>,
  "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
  "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
  "Paolo Bonzini" <pbonzini@redhat.com>
Subject: [PATCH 2/2] x86/fred: Add a page fault entry stub for FRED
Date: Fri, 21 Jun 2024 21:12:02 +0800
Message-Id: <8a1cfeb12f3c334a768ad3ed35dc3bfda5cf6f90.1718972598.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page fault handler is installed into the IDT before FRED setup is
done. During this gap, the handler would retrieve the wrong CR2 from the
stack if FRED is present and a #PF is triggered. Similar to the debug
entry, a page fault entry stub for FRED should be added.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/entry/entry_fred.c     |  2 +-
 arch/x86/include/asm/idtentry.h | 12 ++++++++++++
 arch/x86/mm/fault.c             | 19 +++++++++++++++----
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index f004a4dc74c2..73ea483fec87 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -181,7 +181,7 @@ static noinstr void fred_hwexc(struct pt_regs *regs, unsigned long error_code)
 {
 	/* Optimize for #PF. That's the only exception which matters performance wise */
 	if (likely(regs->fred_ss.vector == X86_TRAP_PF))
-		return exc_page_fault(regs, error_code);
+		return fred_exc_page_fault(regs, error_code);
 
 	switch (regs->fred_ss.vector) {
 	case X86_TRAP_DE: return exc_divide_error(regs);
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index daee9f7765bc..a0fd9cfa08d6 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -86,6 +86,7 @@ static __always_inline void __##func(struct pt_regs *regs)
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
 	asmlinkage void asm_##func(void);				\
 	asmlinkage void xen_asm_##func(void);				\
+	void fred_##func(struct pt_regs *regs, unsigned long error_code);\
 	__visible void func(struct pt_regs *regs, unsigned long error_code)
 
 /**
@@ -180,6 +181,17 @@ noinstr void fred_##func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_RAW_ERRORCODE(func)				\
 __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
 
+/**
+ * DEFINE_FRED_RAW_ERRORCODE - Emit code for raw FRED entry points
+ * @func:	Function name of the entry point
+ *
+ * @func is called from the FRED event dispatcher with interrupts disabled.
+ *
+ * See @DEFINE_IDTENTRY_RAW_ERRORCODE for further details.
+ */
+#define DEFINE_FREDENTRY_RAW_ERRORCODE(func)			\
+__visible noinstr void fred_##func(struct pt_regs *regs, unsigned long error_code)
+
 /**
  * DECLARE_IDTENTRY_IRQ - Declare functions for device interrupt IDT entry
  *			  points (common/spurious)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b323cc..712dcf491daa 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1490,12 +1490,10 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 	}
 }
 
-DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
+static noinstr void __exc_page_fault(struct pt_regs *regs, unsigned long error_code,
+				     unsigned long address)
 {
 	irqentry_state_t state;
-	unsigned long address;
-
-	address = cpu_feature_enabled(X86_FEATURE_FRED) ? fred_event_data(regs) : read_cr2();
 
 	prefetchw(&current->mm->mmap_lock);
 
@@ -1541,3 +1539,16 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 
 	irqentry_exit(regs, state);
 }
+
+DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
+{
+	__exc_page_fault(regs, error_code, read_cr2());
+}
+
+#ifdef CONFIG_X86_FRED
+DEFINE_FREDENTRY_RAW_ERRORCODE(exc_page_fault)
+{
+	/* FRED #PF stores CR2 on the stack. */
+	__exc_page_fault(regs, error_code, fred_event_data(regs));
+}
+#endif
-- 
2.31.1


