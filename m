Return-Path: <linux-kernel+bounces-393698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB1B9BA42E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66332817AE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E5149E16;
	Sun,  3 Nov 2024 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FiIENKfb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438825D477
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730612443; cv=none; b=CVOSTgA+qKhjUmvRhT6Uply8QNYXSmlfIa1jE7u4sbx3fjHIWrjAo3eBhTNv0xsiuNiTDJ0r32s5p+kd4WBTlUaINwZBO39ZjLBwYSa8U/8LEaFcpc0cyiFoJNO4+rg9nbOUQ7CJU4UFZq8IfJFGnzaNGotT7rAVmdeiNcK6FR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730612443; c=relaxed/simple;
	bh=eUvK7XxVTKcmyk5TF3HA5xYJw2+OI3G56q7owZOQKMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJDjR7nPw3M0OWlKexHtwhlLYAlw4pc5L9AV1J7wFzxL9WTFu9qsBuXMQaNfhEefBRWZTsOvnkdMZWISwkrGM35KSWRC7raRNMCS+VCzwAlyjcfzO9lkA5KkYMPSBOuJNLD/0g8ERlkqnuZQO99XqW+y/WX3sHL7BktTrupf8Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FiIENKfb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jRI3DZMe9TgAyx+MV1am49R5haSFhnpyNVcm2C5PrAA=; b=FiIENKfbArtWxRSphJlRQI/Su/
	wG0CYZp3+Xq0Cgr125LEeVC4uV7kLzDm68Ny8EuwpeabS40vxeEeM1B1VXiptzWFYe3AkgFrTN+eN
	U2/qnPMaqRezocIJMZQTAicperZx62gW0fwCNGp/0cupnXni5dmLyV2htrJJzfPk6yEuxvSRwkNqT
	JSOcE78pO/xDEb0nLG5+VGP+xpneFSyaCCItwgfl9mfh8+RlyWKQtmr9f4OBtWndCw+2hacY22SMO
	Ea6zU3OC4N+vXdLEwlHQ0Zw5UERJdgJrIueNVm8NKzJ0k/feSUK+WeCCqW0FIiJwwwyK4/WWJf2eW
	HaONILMw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLa-0000000HSiP-2uPj;
	Sun, 03 Nov 2024 05:40:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLb-0000000FvLX-07z2;
	Sun, 03 Nov 2024 05:40:23 +0000
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
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH 7/7] [DO NOT MERGE] x86/kexec: enable DEBUG
Date: Sun,  3 Nov 2024 05:35:32 +0000
Message-ID: <20241103054019.3795299-8-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241103054019.3795299-1-dwmw2@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1c18cffe5229..bba37db6d437 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -14,6 +14,8 @@
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
 
+#define DEBUG
+
 /*
  * Must be relocatable PIC code callable as a C function, in particular
  * there must be a plain RET and not jump to return thunk.
@@ -195,6 +197,8 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	pushw	$0xff
 	lidt	(%rsp)
 	addq	$10, %rsp
+
+	int3
 #endif /* DEBUG */
 
 	/*
-- 
2.44.0


