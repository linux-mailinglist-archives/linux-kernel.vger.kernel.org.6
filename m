Return-Path: <linux-kernel+bounces-418818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE89D65E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8211614CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDCB19CC21;
	Fri, 22 Nov 2024 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jCMm6BNV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA618A6A9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315665; cv=none; b=iAhU+N7i/t281xnJnR9H1pr9hmdgxz6qGu6yyTWUih6ocQWusP/KCA3Bt5OmjMjNXDPdGuv8Ig4gtpd47Nm5q+QDLp5xPdBDtVxz88oAA03DEuU6XwjJMU21P4eUl56tC0/voSTHDlLfP8Z5Kfj1i0uN9alrYkLNzvPC8/I9SJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315665; c=relaxed/simple;
	bh=PsmoAGl847a9zQLItcMGgTXPyTmUHqs5pQtbYpPJSqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU+7R18Xo6Y5jkGBwsV57vxBUglAkMnhf80hb/oxERPDhU8g/KdySo1GWkQ90K1iMv+xBY5mSsswfXnX7ZWSyBYjHeSANyM7galdhnaoLm1JHqJ4jxQ3T0ui8QWA0u+g8UGqEWVXpB4c9PAuZsumX3sxctaYW1QCX3HhQMLaZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jCMm6BNV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=S0QVtAVD7M7pFpqYQRYpOlRlIpsQlWjl3XEa+4AG3hg=; b=jCMm6BNVrfGOtot4P6MWH5QfVr
	Jaa98yGLe9SXtDBP7HNJm6Bj4EXEkUldoFDGZMjV2WsTkMKvcq0gEHh0kHy21FKLqaw7eb+munQpl
	9w74HhVDAg4eQ7bZIWrVhQB+i6StbGjDlrAcusy/A22QCVNYoMQvD6UN40lqeyLXZnqNPRjhgsg3g
	OkmpX88v3OdYPkk6JkOqugHeJ41SGbOUeNxH5HV6XD5SlUUvtoTeDtXVDP/WyDDgpUe8+AHvklQQK
	/dgiDEx+D7xjXKej74Nk/9ZwPiJZic6d+rNmOWfVbTGXt/2uXS2v3KFnIvnKR5stFjjLb/Uu2CLXq
	LC7y+aYQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000008PHS-2CWY;
	Fri, 22 Nov 2024 22:47:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiC-034R;
	Fri, 22 Nov 2024 22:47:19 +0000
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
	jpoimboe@kernel.org
Subject: [RFC PATCH v2 04/16] x86/kexec: Only swap pages for preserve_context mode
Date: Fri, 22 Nov 2024 22:38:13 +0000
Message-ID: <20241122224715.171751-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
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

There's no need to swap pages (which involves three memcopies for each
page) in the plain kexec case. Just do a single copy from source to
destination page.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index ed2ae50535dd..92d5dbed3097 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -308,6 +308,9 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rdi, %rdx    /* Save destination page to %rdx */
 	movq	%rsi, %rax    /* Save source page to %rax */
 
+	testq	%r11, %r11    /* Only actually swap for preserve_context */
+	jnz .Lnoswap
+
 	/* copy source page to swap page */
 	movq	%r10, %rdi
 	movl	$512, %ecx
@@ -322,6 +325,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
+.Lnoswap:
 	movl	$512, %ecx
 	rep ; movsq
 
-- 
2.47.0


