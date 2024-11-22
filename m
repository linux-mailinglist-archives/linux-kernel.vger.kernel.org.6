Return-Path: <linux-kernel+bounces-418831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B89D65F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EF02859F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AA71E048B;
	Fri, 22 Nov 2024 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eqPlq+8P"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FA1A3034
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315674; cv=none; b=GM97HbBAHxl/sMTX9WAuWdoAC4/Wpc/0oyEZuBeESqDhhwLFVJV0OnqiH/AzeRcn88PuJ2dW/JfepAZoQcHFkqgqC0Ohm8wet6KxCdbUIb6RLnA8qUefhyYw4CJpvjplgoSgaWFtGbpKwS3MOHhyKlAz5TVb5obQeC2Q2iki6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315674; c=relaxed/simple;
	bh=8Rz20baMO9chwr7g9P6Po0JLe92g35121XuVgdhLAP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYhuw9Www8Lr0m0UCKlaD9AebHPfZApAam6F5kdc5jhh1F3M6C0a9UnkUilJ1049Ar77QZBURCUZr08m8g9iolWZAhdvq9JJofGIW5I29EwZ1UFZG+wwVOqhdtW6IGizZ7M0MOInogDMmNgvUdmssw/B8P7b/EfcDltEi6UVFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eqPlq+8P; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JN/n6oVdrchdFC0rEj9EsgKyog6/YyewaWd3kp8GrwA=; b=eqPlq+8Pcnn9Wm6QN/urM3oJlU
	/8Z/I/qLC3p8juCl8bKwHxS0W35gQExd/FT0b4Zapz6vZSPgBm0RbBshNbgiHmqgRw5Tc9Rq32qHi
	r1e5SwhtUrCnrtShNKCXaV8WKRjP35ewfXGpTEmSjRgvxpFERgCqphf3MyBMAGDH5LFG15A+iMw2B
	jozuJMz8kyg5YqdfoKYSobRNEEXhSS8e1kqL6SVjR62MXrXuVZciFl9Y2X4u4YoAd7ojZJliOqOOZ
	t0KqIuTOdhSm4s3zSJK1Phemaew0ngdCyw6Z4VvT/giAySZYoZJNYbtBSemSQ8tbQnpTRGFlK1fq0
	M91XDnYw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQv-00000000maN-3CPb;
	Fri, 22 Nov 2024 22:47:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iim-2L1u;
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
Subject: [RFC PATCH v2 16/16] [DO NOT MERGE] x86/kexec: enable DEBUG
Date: Fri, 22 Nov 2024 22:38:25 +0000
Message-ID: <20241122224715.171751-17-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 67f6853c7abe..ebbd76c9a3e9 100644
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
@@ -191,6 +193,8 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	pushw	$0xff
 	lidt	(%rsp)
 	addq	$10, %rsp
+
+	int3
 #endif /* DEBUG */
 
 	/*
-- 
2.47.0


