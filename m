Return-Path: <linux-kernel+bounces-557917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A75A5DF51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529BF16E65A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6F25178E;
	Wed, 12 Mar 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k49P0ETX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A824E4DD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790595; cv=none; b=RS50AHxgT6sOkubyeoWyB0hxDEd2CxnKfaOP3H9kLDAX11a9LJohu5zkgT1rlrsl3rwnjyw6uFkdhEcXaZ/ip0cN9HOHfPfB3G3WNN+mMUD+tdTnpRryeroyRlISOf13OBFDSuOy/x1W9LB3MSRYYTiSz5HHa/ZoDrTd5tf5pC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790595; c=relaxed/simple;
	bh=Ks73S6L9OvvNUoK0H+nNyrYA1kjHjOe1RbEQ2TxmbZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FD9Vz108YAzB+Pm/YXNA5RNLqYhvTcitAOAMvPLI6pfcixe1Nn1rHFdeoT/2kTdE/ha8RrKVTV+Oo6CvV3MQaqXA4vKHYL4HCjP8K02cQEAbDMERAgpjXdUNfjp9CY4i9jeK5XgyA3J4OZiB5hgI7Lqz5r6mT5393uj0xI1xfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k49P0ETX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qp5MUfxf+oIzYOLbQwnOjHsqB6Ar6RASj1HyEhE99qw=; b=k49P0ETXliA0XX6kn82w6hNg23
	S9B/Jk3XcTx62r3X+AgrBf798mgnDOSJ4pY9B+bsXVdJSED7+AN6rFQL7LgSmq5t/ZNCZjy5Af/mk
	cngj6qFga/dUmCtw9+nHGNzmGjHrturGnr0hhpbVtrAP+kMliBAB6FSawqXVuzcRlbxFlEYsBfBPd
	ZFAOI6A6ykC6dJXjJLYk75V8czDygBUVeD2MipZVK0ewrhkdv3Zp33cCipKQSCKf1K8LAOoBQDDOQ
	+7cnGulWpjkgmel/JPYE4eQMfuH7bM84v+HnIUYbCUIJZnDov+vRM8MYyMrVvWgaL8uvzMmZYyJmE
	xp43lrpQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-0000000CxJG-3ivn;
	Wed, 12 Mar 2025 14:42:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uUg-2mAN;
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
Subject: [PATCH v7 7/8] [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
Date: Wed, 12 Mar 2025 14:34:19 +0000
Message-ID: <20250312144257.2348250-8-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 17d41e6e1a4b..2b7fc59af373 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -158,7 +158,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	lidt	(%rsp)
 	addq	$10, %rsp
 
-	//int3
+	int3
 
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
-- 
2.48.1


