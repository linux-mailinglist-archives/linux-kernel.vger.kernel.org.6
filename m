Return-Path: <linux-kernel+bounces-448302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05A9F3E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119FA188CFF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E91D63E9;
	Mon, 16 Dec 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qvaNRGwU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BDA1DACBF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392259; cv=none; b=V0pSr2BA38ww/Frz+FcRnqU8P02uphQ90ifDJ/1RBbzVmnqjrYyiMWTlb0c9nuEebKsk/TzdtR5vO+3EeQYaHrliS8hCzUuBjKs0S9SX7g0eif4goWV5wBlb+pQ6BkdNopiX1dziN8zYMvpMmeeEXxjOfyTPfGXl0aj/PNRvmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392259; c=relaxed/simple;
	bh=zkbYTmuZfQnBujK5vcetFookFFHLMepfdATcSMt8Pnk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3WTR5o6RBD1rNgoKX3t0lJ8U6Rdh1iCsrzgmDf/LssPd9cMktBNwIkyEaK3+Jb3JnD6+vuUe/inNH2jMPgPkaaX29AU+NmT7RffY/EmsOU+yHHgUcBqEuuGEUeAtinfrBIXqs/D2l7nF9WjsKn0rrTrAz3Es32IUwZRpm/XASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qvaNRGwU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=siK05iL8Sl6AWnRvb8/748kKl/nChwb5EZxS4049r5c=; b=qvaNRGwUFC5FsBbeIs6VVrSnBe
	WbdfBwGzFPGSuxtAJlPzlK3kEAsmjb3fbEYVnEQPt0u2zYf9NRL/ttY09zBY2hMIHU4u3m6aGDKII
	jkkzC7rJlMsFboQaNYUbNnRpJmg5RWJZKBwCxmSqjXkpjFmLcDTAAWAV4JllqeMO6JJCh7ASYUMtE
	ezZGQz/5KZZeKbL2Rdr8m8AsmR4b/oAng2yu1xaUfCKil0/pWZ1qi/Dm1yb5IPeiiJP+eeiesmw82
	/xpgrD+l9ZN+m0Y3mvxYmmArGtoVytSqpPNVbulOqP+Y0OpE5O98zHpUfoJbXBZBWYgJc78/fyGGn
	q9pBrmJA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-000000034nU-1cjU;
	Mon, 16 Dec 2024 23:37:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeW3-00b8;
	Mon, 16 Dec 2024 23:37:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	David Kaplan <david.kaplan@amd.com>,
	Tao Liu <ltao@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Rong Xu <xur@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bsz@amazon.de,
	nathan@kernel.org
Subject: [PATCH 1/9] x86/kexec: Disable global pages before writing to control page
Date: Mon, 16 Dec 2024 23:24:08 +0000
Message-ID: <20241216233704.3208607-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The kernel switches to a new set of page tables during kexec. The global
mappings (_PAGE_GLOBAL==1) can remain in the TLB after this switch. This
is generally not a problem because the new page tables use a different
portion of the virtual address space than the normal kernel mappings.

The critical exception to that generalisation (and the only mapping
which isn't an identity mapping) is the kexec control page itself —
which was ROX in the original kernel mapping, but should be RWX in the
new page tables. If there is a global TLB entry for that in its prior
read-only state, it definitely needs to be flushed before attempting to
write through that virtual mapping.

It would be possible to just avoid writing to the virtual address of the
page and defer all writes until they can be done through the identity
mapping. But there's no good reason to keep the old TLB entries around,
as they can cause nothing but trouble.

Clear the PGE bit in %cr4 early, before storing data in the control page.

Fixes: 5a82223e0743 ("x86/kexec: Mark relocate_kernel page as ROX instead of RWX")
Co-authored-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219592
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 8bc86a1e056a..9bd601dd8659 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -70,14 +70,20 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	kexec_pa_table_page(%rip), %r9
 	movq	%r9, %cr3
 
+	/* Leave CR4 in %r13 to enable the right paging mode later. */
+	movq	%cr4, %r13
+
+	/* Disable global pages immediately to ensure this mapping is RWX */
+	movq	%r13, %r12
+	andq	$~(X86_CR4_PGE), %r12
+	movq	%r12, %cr4
+
 	/* Save %rsp and CRs. */
+	movq	%r13, saved_cr4(%rip)
 	movq    %rsp, saved_rsp(%rip)
 	movq	%rax, saved_cr3(%rip)
 	movq	%cr0, %rax
 	movq	%rax, saved_cr0(%rip)
-	/* Leave CR4 in %r13 to enable the right paging mode later. */
-	movq	%cr4, %r13
-	movq	%r13, saved_cr4(%rip)
 
 	/* save indirection list for jumping back */
 	movq	%rdi, pa_backup_pages_map(%rip)

base-commit: 35aafa1d41cee0d3d50164561bca34befc1d9ce3
-- 
2.47.0


