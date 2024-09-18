Return-Path: <linux-kernel+bounces-332467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4244397BA26
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D2F28301F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A3E178376;
	Wed, 18 Sep 2024 09:29:50 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2017838F
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651790; cv=none; b=qvchtpsaRgSYN2vkOowa6p5tu4GoEc434gEeUOiVe2KaVewUhuhECKYNRIkW/BKEZrTEPANU28uQl97uK+XdQanZpQSBlOoIadrn5WwNEx+WipnN8+LLUpSpmXCtYyu87Yp62Z8pQI4g52qC91dFHhc94RRpdSxkeAYDapboy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651790; c=relaxed/simple;
	bh=MgHGrf7HrxJHFRc0/SbqKiJIySQQ5FWGfV4B2c7Wy68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZuU4lG/NSFzQxzeRsit8YMzs69PPc1rlukg4fjXP2yP9/QHbjSA/h9bbtHkNN9hroVDSOsWd9hk/ojbCUkFHCw7AVMbtVJzdePEeN3ImkF5tswbIsIrQXDc7l0nk4R8BD/eWpZ8iPBeQMSsv4t6Mo+8NsFUDyd02qPraSY2gbv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp89t1726651683t84gv24a
X-QQ-Originating-IP: 2cSalAEC57Ir0tNB+adryuEtmrRLVj/FTop5tP6gk0g=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Sep 2024 17:28:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14219157519028918696
From: Luming Yu <luming.yu@shingroup.cn>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	jialong.yang@shingroup.cn,
	luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: [RFC PATCH] powerpc/tlb: enable arch want batched unmap tlb flush
Date: Wed, 18 Sep 2024 17:25:16 +0800
Message-ID: <9BC3D1299ECE8428+20240918092515.2121-2-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Yu Luming <luming.yu@gmail.com>

ppc always do its own tracking for batch tlb. By trivially enabling
the ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH in ppc, ppc arch can re-use
common code in rmap and reduce overhead and do optimization it could not
have without a tlb flushing context at low architecture level.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/Kconfig                |  1 +
 arch/powerpc/include/asm/tlbbatch.h | 30 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 arch/powerpc/include/asm/tlbbatch.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e94e7e4bfd40..e6db84dd014a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -175,6 +175,7 @@ config PPC
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP	if PPC_RADIX_MMU
 	select ARCH_WANTS_MODULES_DATA_IN_VMALLOC	if PPC_BOOK3S_32 || PPC_8xx
 	select ARCH_WEAK_RELEASE_ACQUIRE
diff --git a/arch/powerpc/include/asm/tlbbatch.h b/arch/powerpc/include/asm/tlbbatch.h
new file mode 100644
index 000000000000..484628460057
--- /dev/null
+++ b/arch/powerpc/include/asm/tlbbatch.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ARCH_PPC_TLBBATCH_H
+#define _ARCH_PPC_TLBBATCH_H
+
+struct arch_tlbflush_unmap_batch {
+	/*
+         *
+	 */
+};
+
+static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
+{
+}
+
+static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+						struct mm_struct *mm,
+						unsigned long uarddr)
+{
+}
+
+static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
+{
+	/*ppc always do tlb flush in batch*/
+	return false;
+}
+
+static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
+{
+}
+#endif /* _ARCH_PPC_TLBBATCH_H */
-- 
2.42.0.windows.2


