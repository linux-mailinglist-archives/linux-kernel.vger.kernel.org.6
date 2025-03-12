Return-Path: <linux-kernel+bounces-557914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72C0A5DF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E231E1675D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C7624CEDF;
	Wed, 12 Mar 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K6NXXWyp"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F4F86358
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790593; cv=none; b=FjRhzoqIOZubhDsMG0mj5h6v3v+chYc+Q8IXgRNHPKVLCWX2xmQE/KQY7uUxWqC5COMnPplPa80F0rnQrwwAGkLJhysCibJaXpghXI7rSpL2S3KZePpNk5GWOJ6CN41tnZy8rXK3UWsBmKdrVme7uVZPJg3Oqk8fga04xXhkgys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790593; c=relaxed/simple;
	bh=yB/1DMedibvtTqcKz2b+elEi0esJF8P5TQBtkTwCVB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SskibMKANuqbSA7YNZsvRX6SJgI93SHb+P0w6XhakCkYFayO0EvSbowjoHddTqsxSnDh2dAO7UsQxi49gRzSJsmA4YGGf3LcZvThMBijucUDLfx34AzNKir69zDbA48an/EBkfUqhn1e5p6ySBN+zO87u3FpOARWH4hW+Z1HV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K6NXXWyp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oInsi2D7axo2egqLTm6zsJ7BfqLAvSOVJG6AQYZo6i4=; b=K6NXXWypJEHl+g3kj4kkSGqGfu
	up08gClhXsMJsUWf5e5D2727V1MfG1Tr+1UtL6FsLLem+iaWKM26oRNeTGwR2LLoHVsYi1sxIsRF3
	3molZPfDWGwrRfXIUvYO/Wvz6q4qBSten06E2YlZJD1dhmQrzoJYt0EsWCESGiVFN3/zILYKtwKtN
	qgLa8hWEO437Ljep2PIxBIN04pXPaGzweCVkFpR5KtlW4QleFhTzAQ/+MH33XIjiIJubAxVdUQyjk
	YFbUgTGdCFZ1PYPin3HOLhlICQcvnk2WezL79kLIQr2FYteEmyZTkncyVN8dtSujygRibdr7IYJlA
	rRtF6k0Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIS-00000002QEt-2cM2;
	Wed, 12 Mar 2025 14:43:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uUn-31Yp;
	Wed, 12 Mar 2025 14:42:59 +0000
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
Subject: [PATCH v7 8/8] [DO NOT MERGE] x86/kexec: Add CFI type information to relocate_kernel()
Date: Wed, 12 Mar 2025 14:34:20 +0000
Message-ID: <20250312144257.2348250-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
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
index 2b7fc59af373..999aca909803 100644
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


