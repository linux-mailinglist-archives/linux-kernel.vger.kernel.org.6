Return-Path: <linux-kernel+bounces-224769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B98259126AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627771F26B99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1A115625B;
	Fri, 21 Jun 2024 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="nS3HPKaY"
Received: from out187-2.us.a.mail.aliyun.com (out187-2.us.a.mail.aliyun.com [47.90.187.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7D15574B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976485; cv=none; b=hKZpbx/yuAm3yHlnQphtqeMz595wd/ngWer+4BvdB+bO06/m9rksLXqLRxK11cSBpM06vnujX9259PPnj5BTGT7DM/rVm7mt1x8RWqaeS4KuP4PHjUWUWUSpwHGuXrDDnMTdpZmxV+9KUkU3FYLDEmZHMKe8+o1GT7Qi5kCn3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976485; c=relaxed/simple;
	bh=V8nD0aZIWjQ1RGuuSK6v6Ej+VnG3WFnQxTyN/L+x8Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aGq63/MlReKnGBj+MqYubD+71qLXabeYsdDpEZ6gDhhMpXikwLNKM/vYxDOOj0RJVxC2DfBbVY2GYaSOR376+R8s+MzpUY8TdJsKcWzq2VpHClpH4WaokqNiwjdcymfRiS+QcytqdiuZ2ux1W+Hc99gvn5J2tSeGv8H5iJQRaKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=nS3HPKaY; arc=none smtp.client-ip=47.90.187.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1718976471; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=k63JWzWe+8PbWwvyDn6fRY3NFMeICzBo2dStvYMNoVo=;
	b=nS3HPKaYL1yjxkokIbFvipIlFtsX4HKTnGos32qySpTT/sNY/gGXgAUX1YMARA9oe0A3uqAt+zJAsXZwYAsoc087LARE2v5+oQ7ozoIgiq3ISVPr4ZfkdRUnvgEEetlRb+fvYg1V25w6+WmKTyc1K3JT0RApZNNMwSNzZud/8A4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037088118;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.Y72lyhN_1718975537;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.Y72lyhN_1718975537)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 21:12:18 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: linux-kernel@vger.kernel.org
Cc: "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
  "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
  "Thomas Gleixner" <tglx@linutronix.de>,
  "Ingo Molnar" <mingo@redhat.com>,
  "Borislav Petkov" <bp@alien8.de>,
  "Dave Hansen" <dave.hansen@linux.intel.com>,
   <x86@kernel.org>,
  "H. Peter Anvin" <hpa@zytor.com>,
  "Xin Li" <xin3.li@intel.com>,
  "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
  "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
  "Paolo Bonzini" <pbonzini@redhat.com>
Subject: [PATCH 1/2] x86/fred: Always install system interrupt handler into IDT
Date: Fri, 21 Jun 2024 21:12:01 +0800
Message-Id: <2f632ef59c8c9cc27c3702bc2d286496ed298d65.1718972598.git.houwenlong.hwl@antgroup.com>
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

In sysvec_install(), the system interrupt handler is not installed into
the IDT when the FRED feature is present, but FRED can be disabled
in trap_init(). However, sysvec_install() can be used
before trap_init(), e.g., the HYPERVISOR_CALLBACK_VECTOR handler is
registered in kvm_guest_init(), which is called by setup_arch() before
trap_init(). If FRED is disabled later, then the spurious_interrupt()
handler will be used due to the handler not being installed into the
IDT. Therefore, always install system interrupt handler into IDT.

Fixes: 3810da12710a ("x86/fred: Add a fred= cmdline param")
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/include/asm/idtentry.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index d4f24499b256..daee9f7765bc 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -470,8 +470,7 @@ static inline void fred_install_sysvec(unsigned int vector, const idtentry_t fun
 #define sysvec_install(vector, function) {				\
 	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
 		fred_install_sysvec(vector, function);			\
-	else								\
-		idt_install_sysvec(vector, asm_##function);		\
+	idt_install_sysvec(vector, asm_##function);			\
 }
 
 #else /* !__ASSEMBLY__ */
-- 
2.31.1


