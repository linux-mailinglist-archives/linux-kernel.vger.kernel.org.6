Return-Path: <linux-kernel+bounces-561887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE46A6182A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DFD3B340E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B142036E0;
	Fri, 14 Mar 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="diV4G5/I"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B22920468F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973810; cv=none; b=ILl5aBS9qOqkiloLZY1OMeW5MHxSU/7JK+BGNU+r9cevkay4ExV9Grbu6WoWhiVclowq5INx9LshEicFh4HxPqX8QiWXrm0OGXHjC73+5PV+Mc7XkVV+mvnPiFeoTzsN19Z4So7y+ZgHJhtwkz/elrw4G6Iqbnlih9KHrs62DQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973810; c=relaxed/simple;
	bh=Dsh4VAnH63YeGPJh9gsY2uUxVF7+sifxwgt6NZTC81s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBJLTQM05k3P8yr5yIi3d1sp+QbZ7/I9EMHRFseOt8Mq92GoREQgQmo3D3Lsw9t0tjtYFRgOAD5uZ2fI3vuZ2EP6uf7qnoEJmQhTLmbfq+UZ7r0jxP2+bv0w151APtu4dTovjuln/KhCcIbfSDp/06/awyqi7HXoWoMo51+F7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=diV4G5/I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cqwZ/H/FVUiSZsArJsLCTQnCYNemua1WIXyd2bx7EII=; b=diV4G5/IEhJa8Q+vOrcbuKfaWR
	IHIuwgnvh8u5e1wr06gVYGwT3/CARtlqM2HGhbWNscS9xs2uFnzpjjRzKAuVxAgTWzlXWIklsDQWP
	lmcLnZGJnqRimalPkLl2g/bzS1hWe5WMvsSXfdTP16JX1g6OlJPPtvcBLtZsxwtsBaNDKyDxNTILL
	P3yUge1q1Jw+i1p+gr+4/oWNUz++hOPqhEnRUYciGwKsmoO3f/JkJMbM7e5OqIuEwLORT+xe6NrEx
	vY2wKo9KVH5SR5SPBK2kxwyQAqHgWRKYCTasm+RJzXLhTOJI1siUs7CnDEmfXkVSti3kMz9Jk+yp5
	cNjzFTig==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8ta-00000003tcr-2nQ2;
	Fri, 14 Mar 2025 17:32:35 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tZ-0000000CsWE-0VrL;
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
Subject: [PATCH v8 6/7] [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
Date: Fri, 14 Mar 2025 17:27:38 +0000
Message-ID: <20250314173226.3062535-7-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 4f8b7d318025..228301ac66e9 100644
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


