Return-Path: <linux-kernel+bounces-266939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA7940A10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A881C233BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA2118FDA5;
	Tue, 30 Jul 2024 07:39:42 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6041684AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325182; cv=none; b=ATUogvsgxZiMFYS2AfjZfFQOSdw2c8dc+ptttKwW+qvsqgsrPpdzSzlVMmzWuEWSPBLcnZQ/dSSVjK7tjZ+ybJjofpQRRaP1Ub24xgNbpmK55/f/sQyqngWWLBEZxwZbFi4Y4nI7VidHPSzDNxQgMNEbWmOgVsZxBt9Ae7hBFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325182; c=relaxed/simple;
	bh=EjEB5RI5QMvwwrw/it3cYtsJwwpNE1hOTlZhP++XRqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEALrDgsFxBdt8HkBkltECpuBx8vL6fcREtZ8SU8IMl7f+g+yvRLShbrWdeMMMZ76in/ArAXvE2m96WQYXtiFDvweYi/qIZgEkXuNHraKmcb53zGcrvJG4VBF+jTRj0XB+QDX8hFzWsn4J2ybZdVuTxJra7kWKFkeYJAF8zSOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from qiao.. (unknown [210.73.53.31])
	by APP-01 (Coremail) with SMTP id qwCowABHTEijmKhmfLARAg--.42862S2;
	Tue, 30 Jul 2024 15:39:15 +0800 (CST)
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	surenb@google.com,
	alexghiti@rivosinc.com,
	akpm@linux-foundation.org,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	qiaozhe@iscas.ac.cn
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC] riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()
Date: Tue, 30 Jul 2024 15:38:22 +0800
Message-ID: <20240730073822.27732-1-qiaozhe@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABHTEijmKhmfLARAg--.42862S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1fGw45Gr1DArWDKw48WFg_yoW8CFW3pF
	Wak3y3ZrsagrnayFZ7Ar1UXa1rCa4rtanrur9rKas0kr47ur15Kws5Z3Z5X34jyr18WFyr
	Ar4YkFyrZFyDuwUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
	zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx
	8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GF
	4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0Xo7DUUUU
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

Hello everyone, recently while learning about the Riscv architecture's
handling of page fault exceptions in the Linux kernel, I found that
there is no handling of VM_CAULT_SIGSEGV in mm_fault_erroneous (), but
rather a BUG() is executed directly. Therefore, I simultaneously analyzed
the processing procedures of arm64, powerpc, and sh architectures for
this area and found that all three architectures have processing for
VM_CAULT_SIGSEGV. Therefore, I added relevant processing methods for
VM_CAULT_SIGSEGV on the riscv architecture.

As a beginner, I am not sure if this processing method is correct and
would like to hear the opinions of my seniors.

Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
---
 arch/riscv/mm/fault.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 5224f3733802..868163b904e2 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -61,26 +61,27 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 
 static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
 {
+	if (!user_mode(regs)) {
+		no_context(regs, addr);
+		return;
+	}
+
 	if (fault & VM_FAULT_OOM) {
 		/*
 		 * We ran out of memory, call the OOM killer, and return the userspace
 		 * (which will retry the fault, or kill us if we got oom-killed).
 		 */
-		if (!user_mode(regs)) {
-			no_context(regs, addr);
-			return;
-		}
 		pagefault_out_of_memory();
 		return;
 	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
 		/* Kernel mode? Handle exceptions or die */
-		if (!user_mode(regs)) {
-			no_context(regs, addr);
-			return;
-		}
 		do_trap(regs, SIGBUS, BUS_ADRERR, addr);
 		return;
+	} else if (fault & VM_FAULT_SIGSEGV) {
+		do_trap(regs, SIGSEGV, SEGV_MAPERR, addr);
+		return;
 	}
+
 	BUG();
 }
 
-- 
2.43.0


