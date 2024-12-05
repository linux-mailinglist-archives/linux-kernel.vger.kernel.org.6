Return-Path: <linux-kernel+bounces-433552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C742E9E59C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C8B286F19
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97A1224AF2;
	Thu,  5 Dec 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SptoOD4v"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3121D59D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412844; cv=none; b=eyBrrK9bkovm1ea6RX5BySHuRtH315aaOu38HJcAZQAkeTPvDI2kfWectIOHwqj64XXGwW6tB0KWKJCpgjqEnQHW71whv0Yeojn3kikGrBaiPz8K1llrL1nnd4BJQ7XpkRtkyHy3oPNdSxhzBwoVzHQtJzYhBv26ltS7FJOrab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412844; c=relaxed/simple;
	bh=Jszb8KFN5GzjUkCQ/IcBcaFlVglAOixLKBZmKX8ltN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OslFrlLTuTUM+31qPx6uScWNBDghmdI5VV0cUtI8AKMe18bkeVAbW7eqf9Pq/RUI+lJpLH51Bcfga4t9rYwbUqNucvPtt7do5eOZcjGw79BpXf+xp8edDSfN+ib12C1cd7oUaxMJxdTLqC9REpli0FWFPPOUql2Mf69JZmhq1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SptoOD4v; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AbThuJMqNCEqi5OCJ2hHO8LahRmj/ISCryb2ADbdx9M=; b=SptoOD4vVXlqoL/eqJzU7LUWkv
	ihnsJSSTJP87NrbjeppmUQjoENo8ensgBAe+clPXVvgILUgFmwyOXs9b9mLjQ5O2STiE67s9CYNzd
	IVlhXXjI2rmOtz87pVhOyWJvK6lSGEmtfneLq7bMYElvZORr9j5bBRrZYdPBYMSP51q21ipkzOHAQ
	tpbB51kr+CsRT88L+SeBw1JP0gjwhrfqjiCO0mptpfj10q6tEt6PfuNOBxZKOg0xpuyS0uQRh5Rll
	XsTPJXN/vowyoQ9QPlhgyC7HnR8OuGH6+/6haselKM1e0Wa1jVsO2nPTz1sJGIzKSWBOZpflVUuJj
	s2OcFGXw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-00000002wEu-35l5;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyLK-1WRd;
	Thu, 05 Dec 2024 15:33:45 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v5 04/20] x86/kexec: Only swap pages for preserve_context mode
Date: Thu,  5 Dec 2024 15:05:10 +0000
Message-ID: <20241205153343.3275139-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
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

There's no need to swap pages (which involves three memcopies for each
page) in the plain kexec case. Just do a single copy from source to
destination page.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index fea650f92606..50cc33f2ecb7 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -310,6 +310,9 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rdi, %rdx    /* Save destination page to %rdx */
 	movq	%rsi, %rax    /* Save source page to %rax */
 
+	testq	%r11, %r11    /* Only actually swap for preserve_context */
+	jz	.Lnoswap
+
 	/* copy source page to swap page */
 	movq	%r10, %rdi
 	movl	$512, %ecx
@@ -324,6 +327,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
+.Lnoswap:
 	movl	$512, %ecx
 	rep ; movsq
 
-- 
2.47.0


