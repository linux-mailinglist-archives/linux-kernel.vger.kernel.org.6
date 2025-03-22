Return-Path: <linux-kernel+bounces-572184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C3EA6C7C7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 07:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D7117D656
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF41519BA;
	Sat, 22 Mar 2025 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="QA4cWYam"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFDEBA53
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625106; cv=none; b=HE81gjtzBt76vTyhbiBPnbNG09utfX7DGofcJgx4wjWldl3OrUKuoHPxchwsQ6l14zMfofx8ivk43rJATnnSYHvR/l/hs7oKf8jv/LQGpQ0EGfE+JW7/zHRaYcJFDyGmcMfxP8jHwGA8OKFydCaueIVACy8q8Nlt9cb9SX3IF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625106; c=relaxed/simple;
	bh=aAKSCPfQsXwLsVjuqIbNofPDvVHYRvE7xrzl3M3z7/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KX55H3EDgbnN0UOzQ62lxEdr3df+R0C/0c3sm4u1cxCMMdX/gHnrX9muHbSmjIUbHZl0aHFSTS0SbFXXUFG5ANjRO6Nfml7nMlkNZ+w0eAKswEpmkZ/HeaGovwm24lbeH+XsKX/OofIEuai8DdQsbRVwr255YmDVsEqTVCEhe00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QA4cWYam; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742624935;
	bh=ZUwDzUOO8B21ZdXUlMK7jpoccKcRIaUuh/idrOVRgTQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QA4cWYam8yzPDtPEzOJuX43jOD38n1L5/af5QmkDeQESy8vpfw72Wwfq2aejupf9V
	 9UTYj8cBb2QCIWSXvrtVWTn4cLMpULYP8X5fuIIhVsdmaBSGdnuHSEm4WX2+YrOBEB
	 wLPMyFim7FXk4kCDvYk07OuDTJqkIAy4gH1Yzfms=
X-QQ-mid: bizesmtpip2t1742624924t25799d
X-QQ-Originating-IP: EoFty24JGgb8Uv27sxTo45Myx+tTjSV1ie5YhBKGeFM=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 22 Mar 2025 14:28:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6533944679590139330
From: WangYuli <wangyuli@uniontech.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: wangyuli@uniontech.com,
	chenhuacai@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vincent.chen@sifive.com,
	palmerdabbelt@google.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] riscv: KGDB: Do not inline arch_kgdb_breakpoint()
Date: Sat, 22 Mar 2025 14:28:36 +0800
Message-ID: <CEF1937DAC500D66+20250322062836.362600-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N7JihbTpIyPvPSrqEYLxHxCEbLmgFfxpOk0S8bgDnTJ1m/Ve+qZ4zuEE
	7yw+yIa+3MlOlVYi0utsKQJC8+xvbxpJ0yyjx6dmrObwh/72ZVljJukZge1adwURJJs9zeP
	CjTJi/EwFpcFgZMpsyJ2uYHQ/OAd6zEGAxrPm0rSUVTmG9mjiaryxdv2VwYaMxLzU5jeR/8
	+ZQyP9xiffkbgxuALF+4rgWrvvZf2JD0EZNItXLBfRSsVOYuPfvg2Ujrkeozr+UOzFU5KpH
	Gy6+ejvSyVp/zp7eN0sq5xp2EunDzuj0w7yKj7gRJHK9fhwWAmWDqHpr/cRU4MPWjTi8H6P
	ywjNyShDsqNAEvbTLHj87yWTauYG1v6aHbf0eca1eiUZNko7RrGzyRu5H90yDCjZvfk8cF/
	R4GHtoNLDJgLFxTqmwHHtcU1d6qd+a8/jW7h5IkKrsTecgJfAZCkFn+x0s01WVxsbAPjfzJ
	95PhANTZJXcDuCHAtKlQMMtZ7j53K/71XssbsD6xmN/ko+dTHMap11G3fdzbq7W99MP60mh
	ZtHNynnsGyBspxPgX65QxIKSZGTSMfEmmTYWr5m794hJk17ezoTIC01hQnzYqKGDKlP4YC9
	2y1NsYatqhf5ayG75q99Mr/wtekTg413k0aemr5PCduaz4JyT6L0JPOmmXzzapg+WgKGHuF
	ui9/z8wPlMyClsH/3AGjltbvoK5jymXdmxwpMx8/QE6iekZtTpTnVIx9EjDatk8qZfcROHS
	RwApEfmkFvy4LTFM3T8ErWoD9HEvgictjWbeXtyft0e5iKUzGGsBa2NXgjQP5IEDPdp52Js
	3QDq3BQ0r8l8RLUKnnGMWt1h6JAqBRTGYEXe6HcqAdxTA+n93u/PzrnoS1BL5uLygQUVlYM
	wAcSjK4+Wnn6ATAtoie6Zy3jpmzkHru/ffyzan5qT+dn/JzNJjjEMYHEa89i1R2pGxjKLVa
	hJyULdpKKo30O5xYTyUkFMT30Q7B9GgVhkpl5h8yYiQq+rpFBHh6UtubRqibM4a/Iw5GIdW
	F5fwKZpj09b8DckLzI
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

The arch_kgdb_breakpoint() function defines the kgdb_compiled_break
symbol using inline assembly.

There's a potential issue where the compiler might inline
arch_kgdb_breakpoint(), which would then define the kgdb_breakinst
symbol multiple times, leading to fail to link vmlinux.o.

This isn't merely a potential compilation problem. The intent here
is to determine the global symbol address of kgdb_compiled_break,
and if this function is inlined multiple times, it would logically
be a grave error.

Fixes: fe89bd2be866 ("riscv: Add KGDB support")
Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/riscv/include/asm/kgdb.h | 13 +------------
 arch/riscv/kernel/kgdb.c      |  8 ++++++++
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/kgdb.h b/arch/riscv/include/asm/kgdb.h
index 46677daf708b..566ab1bc66fa 100644
--- a/arch/riscv/include/asm/kgdb.h
+++ b/arch/riscv/include/asm/kgdb.h
@@ -17,20 +17,9 @@
 #define BREAK_INSTR_SIZE	4
 #endif
 
-#ifndef	__ASSEMBLY__
-
+extern void arch_kgdb_breakpoint(void);
 extern unsigned long kgdb_compiled_break;
 
-static inline void arch_kgdb_breakpoint(void)
-{
-	asm(".global kgdb_compiled_break\n"
-	    ".option norvc\n"
-	    "kgdb_compiled_break: ebreak\n"
-	    ".option rvc\n");
-}
-
-#endif /* !__ASSEMBLY__ */
-
 #define DBG_REG_ZERO "zero"
 #define DBG_REG_RA "ra"
 #define DBG_REG_SP "sp"
diff --git a/arch/riscv/kernel/kgdb.c b/arch/riscv/kernel/kgdb.c
index 2e0266ae6bd7..5d1ce8dacaf5 100644
--- a/arch/riscv/kernel/kgdb.c
+++ b/arch/riscv/kernel/kgdb.c
@@ -254,6 +254,14 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 	regs->epc = pc;
 }
 
+noinline void arch_kgdb_breakpoint(void)
+{
+	asm(".global kgdb_compiled_break\n"
+	    ".option norvc\n"
+	    "kgdb_compiled_break: ebreak\n"
+	    ".option rvc\n");
+}
+
 void kgdb_arch_handle_qxfer_pkt(char *remcom_in_buffer,
 				char *remcom_out_buffer)
 {
-- 
2.49.0


