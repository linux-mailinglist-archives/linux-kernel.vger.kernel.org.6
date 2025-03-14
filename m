Return-Path: <linux-kernel+bounces-561871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F86A617D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC40F885E30
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC0B204C09;
	Fri, 14 Mar 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h8NSWW96"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7268C201002
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973565; cv=none; b=hwRFDVsImxSbMeR22Z00kNtgae1oe5cwoktJiUlKEDPelkO9bGl0iI8z1RFrpeljZexRIJoMUUtwkbccuj8D6H/E5phm1AuJi0crrrY6G7tbskQ8cn1nsGRCz9idbHHiuh8L7VWQgCIgXofvhu7JVgJNholXV6PI9qvv8rKxKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973565; c=relaxed/simple;
	bh=vAy0a/6TMYOoP2YK49H3iPUzcwOqZD68MfTy3bsmu/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aiq5iFkxbrOkhKnSLLIh66xB/gbMBY6mXSJJbfhN+wn19rZA1Nm1iw6DqIgIIumxeFFNmAfnp4cgZZ/0ykv92henzJtSUjwRC2zqHHcQKocJQiG6/gFgMsfkATLeXy1iHKo8cb6LCDKZ7u2CRJxl4sBeoXxdXZoMZR2CW0eGKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h8NSWW96; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7ZEU4ooB9JbXRgCaEf2/WOsbQmZpDXUsz2616q1hGqk=; b=h8NSWW9622lyf+TkR66+QUn3pB
	vnD9qJh9YuRa82X3/xejTJyv4mUvkP02rihXQkbmK9S7TSOHAABGDtKRRHlDRYrdEU4RlAO/8S3fE
	DcDjjNZLB5FK7pL7gWtdVbWck58neWnKh6XbdGCIWD6Pv/qO6tNprEj3VN1ZIBdPkFfb8JyBxEtIB
	6/evZ7cZ3tJC0hGc1NaK6/wjYhN/TtnpM9KV5whneVvCSs2tMHyluC+6Q71rzWr883CJu2uvYXgGr
	5S44TQNl/dX2pQ8l22tfnJP5WyVBCDevxUUtj5gBd/PzlSSYlvJ7mjBfb0v+/vDhpb+m0T2CVAw8R
	4V0G+bcw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tb-00000002vUA-3fSj;
	Fri, 14 Mar 2025 17:32:32 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tZ-0000000CsWL-0pvp;
	Fri, 14 Mar 2025 17:32:29 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v8 7/7] [DO NOT MERGE] x86/kexec: Add CFI type information to relocate_kernel()
Date: Fri, 14 Mar 2025 17:27:39 +0000
Message-ID: <20250314173226.3062535-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314173226.3062535-1-dwmw2@infradead.org>
References: <20250314173226.3062535-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

A previous commit added __nocfi to machine_kexec() because it makes an
indirect call to relocate_kernel() which lacked CFI type information,
and caused the system to crash.

Use SYM_TYPED_FUNC_START() to ensure that the type information is
present, and remove the __nocfi tag.

I still can't make objtool happy with this in both GCC and Clang builds
at the same time, so not yet for merging; only included in this series
to nerd-snipe the objtool maintainers.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   | 2 +-
 arch/x86/kernel/relocate_kernel_64.S | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 7abc7aa0261b..84f59f18dcb6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -380,7 +380,7 @@ void machine_kexec_cleanup(struct kimage *image)
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
-void __nocfi machine_kexec(struct kimage *image)
+void machine_kexec(struct kimage *image)
 {
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
 	relocate_kernel_fn *relocate_kernel_ptr;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 228301ac66e9..dbcef3430285 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -5,6 +5,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <linux/stringify.h>
 #include <asm/alternative.h>
 #include <asm/page_types.h>
@@ -59,8 +60,9 @@ SYM_DATA_END(kexec_debug_idt)
 
 	.section .text..relocate_kernel,"ax";
 	.code64
-SYM_CODE_START_NOALIGN(relocate_kernel)
+SYM_TYPED_FUNC_START(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
+	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	/*
 	 * %rdi indirection_page
-- 
2.48.1


