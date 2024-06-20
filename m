Return-Path: <linux-kernel+bounces-222321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD190FFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D8E1F2231D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751041AB91C;
	Thu, 20 Jun 2024 08:53:31 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F421AB8F0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873611; cv=none; b=ZmR4TfgfmaE8f2Eo0XsNLvd4rU8I225zm7oWxEQrdsK5PXfvZukXhPlKFXx2B2DU23o/vuF4gT50UAtvxs6eo/BTwhxTOOM8P/o5w5NHK0iA2ssdTESo2htK+cpI3kXEGIqLkAipM8Stza7BYRJd+biUtFG8zV3Z9yuj/guv620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873611; c=relaxed/simple;
	bh=XY8l337fPNdm24l2P6AviuNktmLUwBaqE4HpOS4C/Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0BsQ6pSwxq8VExhj7GqElma6TgjvGumGI5JHp4mf2VVbsAEt7MXj6DIyDpv/zl7an2BN3RiAgoBMV5yRlSy9AEWcetxSyHVbXq9b922HpPK2vr0jwtOJTTjLp66u0jv1Xs82iiDsgCMkZTwrTnSeFErBkAfALupPiMDHUhF+20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz3t1718873509t77bppn
X-QQ-Originating-IP: wrjiMLAB4hMt+TR0SeF11oGDu37PiBlY+nuyZyiPodU=
Received: from HX01040022.powercore.com.cn ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 20 Jun 2024 16:51:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11677031928242655138
From: Jialong Yang <jialong.yang@shingroup.cn>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: luming.yu@shingroup.cn,
	shenghui.qu@shingroup.cn,
	Jialong Yang <jialong.yang@shingroup.cn>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] powerpc/mmiotrace: bind ioremap and page fault to active mmiotrace
Date: Thu, 20 Jun 2024 16:51:18 +0800
Message-Id: <4cb8e7e64c93454518075fc14bf05daf0dce8f7b.1718873074.git.jialong.yang@shingroup.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2bf90acf7d29641ba6643934ff8dbba897dbd2d9.1718873074.git.jialong.yang@shingroup.cn>
References: <2bf90acf7d29641ba6643934ff8dbba897dbd2d9.1718873074.git.jialong.yang@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1

Hacking the code in ioremap entry and page fault handler entry to
integrate mmiotrace.

Signed-off-by: Jialong Yang <jialong.yang@shingroup.cn>
---
 arch/powerpc/mm/fault.c      | 17 +++++++++++++++++
 arch/powerpc/mm/ioremap_64.c | 11 +++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 215690452495..b03cba73de92 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -22,6 +22,7 @@
 #include <linux/ptrace.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/mmiotrace.h>
 #include <linux/interrupt.h>
 #include <linux/highmem.h>
 #include <linux/extable.h>
@@ -50,6 +51,19 @@
  * do_page_fault error handling helpers
  */
 
+/*
+ * Returns 0 if mmiotrace is disabled, or if the fault is not
+ * handled by mmiotrace:
+ */
+static nokprobe_inline int
+kmmio_fault(struct pt_regs *regs, unsigned long addr)
+{
+	if (unlikely(is_kmmio_active()))
+		if (kmmio_handler(regs, addr) == 1)
+			return -1;
+	return 0;
+}
+
 static int
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long address, int si_code)
 {
@@ -422,6 +436,9 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	vm_fault_t fault, major = 0;
 	bool kprobe_fault = kprobe_page_fault(regs, 11);
 
+	if (unlikely(kmmio_fault(regs, address)))
+		return 0;
+
 	if (unlikely(debugger_fault_handler(regs) || kprobe_fault))
 		return 0;
 
diff --git a/arch/powerpc/mm/ioremap_64.c b/arch/powerpc/mm/ioremap_64.c
index d24e5f166723..f5f717bf35df 100644
--- a/arch/powerpc/mm/ioremap_64.c
+++ b/arch/powerpc/mm/ioremap_64.c
@@ -3,12 +3,15 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/mmiotrace.h>
 
 void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
 			       pgprot_t prot, void *caller)
 {
 	phys_addr_t paligned, offset;
 	void __iomem *ret;
+	phys_addr_t unaligned_phys_addr = addr;
+	const unsigned long unaligned_size = size;
 	int err;
 
 	/* We don't support the 4K PFN hack with ioremap */
@@ -28,8 +31,11 @@ void __iomem *__ioremap_caller(phys_addr_t addr, unsigned long size,
 	if (size == 0 || paligned == 0)
 		return NULL;
 
-	if (slab_is_available())
-		return generic_ioremap_prot(addr, size, prot);
+	if (slab_is_available()) {
+		ret = generic_ioremap_prot(addr, size, prot);
+		mmiotrace_ioremap(unaligned_phys_addr, unaligned_size, ret);
+		return ret;
+	}
 
 	pr_warn("ioremap() called early from %pS. Use early_ioremap() instead\n", caller);
 
@@ -52,6 +58,7 @@ void iounmap(volatile void __iomem *token)
 	if (!slab_is_available())
 		return;
 
+	mmiotrace_iounmap(token);
 	generic_iounmap(PCI_FIX_ADDR(token));
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.34.1


