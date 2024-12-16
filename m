Return-Path: <linux-kernel+bounces-448303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E179F3E50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B14161E68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DF21DC04B;
	Mon, 16 Dec 2024 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vyMpdeUQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314F1D5AB6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392259; cv=none; b=QC8Datejon/4O+9awDw7qi4koVaxPP1fm4MdjuTpI+U71Co9VBt4mmWAiMwOc8ahiCH5kUJRHUy2/DvDJhM38k+AM69b+xEba9zKk9gznuhCye/GEO0NJdDH63hmoJksdEvwSzZqb4oQ0SQHPpD2nHnjf5yi2n2OGjCssiLUZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392259; c=relaxed/simple;
	bh=K1W4o2sZdF5lVYRGfeks7NhzGm/Jy2da4/Mpm9653ds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTtNlGioBLNjq9aBi8FRvXr4Io8nuwQFD6GRGvsY2LeZ5LbstzAgoARP9KHph5XBovbzVtT4ICYlCIqhxs/RW2IdEGcu5SN2ixT8kGZEtUhLskttip15qxCAZDcLDZCugVbob6niByTFn7Vc5e980RCqrGJFoCWoS7U1uTJP3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vyMpdeUQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=CrhFZ3L2x07bub/40Vp59il27O/SizC8zFhP7HAHpi8=; b=vyMpdeUQOKLY34lxdul443TXiG
	SsMDdVpmb/GQZVDcjd8ZpZzYRiiaZy/H3uHDFcO/N+ZO9pYSVzqUDUMkCdfPv5vaADFjzdpBHrD4T
	J69AC1a41R3X6VWqPzkUEURqV6zbgPEIR0h5utxro0iKiHRxJ02vmxtSkrvm5J8MnYFU2vgflSgN7
	Oz5wxizXbR0DgaEHbku7Z5p0Rvt0ltgt+Wg5vXD2v1rJZ2MHUonMgtiQTwVdB40gQAAuhsu7NUNPA
	fRjhmyBKf9F3PrTqCT6MtUvAKXyrCxKpjfMQJgWMBaCbyH9aX/HZ+TA7uL1dENbB/lntQxAHroFm0
	eRvnKMrg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-000000034nW-1rMG;
	Mon, 16 Dec 2024 23:37:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeW6-0Alp;
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
Subject: [PATCH 2/9] x86/kexec: Ensure preserve_context flag is set on return to kernel
Date: Mon, 16 Dec 2024 23:24:09 +0000
Message-ID: <20241216233704.3208607-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The swap_pages function will only actually *swap*, as its name implies,
if the preserve_context flag in the %r11 register is non-zero. On the
way back from a ::preserve_context kexec, ensure that the %r11 register
is non-zero so that the pages get swapped back.

Fixes: 9e5683e2d0b5 ("x86/kexec: Only swap pages for ::preserve_context mode")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 9bd601dd8659..1a52e4339c1d 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -220,6 +220,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	kexec_pa_table_page(%rip), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
+	movq	$1, %r11	/* Ensure preserve_context flag is set */
 	call	swap_pages
 	movq	kexec_va_control_page(%rip), %rax
 	addq	$(virtual_mapped - relocate_kernel), %rax
-- 
2.47.0


