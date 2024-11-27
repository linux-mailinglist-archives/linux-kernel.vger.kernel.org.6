Return-Path: <linux-kernel+bounces-423844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00799DAD80
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7444B166367
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBBF202F64;
	Wed, 27 Nov 2024 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c6yI3hXu"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4F1FE45C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734246; cv=none; b=G+AwEVGvv8Zcu5Dk1bEV1HD8/O7M056KLNfYwBGpa0oMUnBXqabb+Ua6wJjTCSpCDeOzJe4mcDKUigNrO5axnEZOKImP0wN42BVW6sQS2L8fp7YDVI3/35EcDJkMEFCekmREOlTlZhhKo0VRC+YcEtdhAHBRevmSpn9LQn2yn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734246; c=relaxed/simple;
	bh=D+JloHBMt0oC8r70FErtjAFnRxiGxH8EaihhtPNVCeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJmomyjQDBljsuFJ0a1/JASVU2CY6VOKxQD5+i6tvSzEQCkhR3ZhXb7yHJAKfV3ZitlZPO9jA5ZL6p3JH5PquO/sR4/7AEtENDgAdvy1EGHLkpV/TuSNsaC5FUzjUjMOAfCOqrg5aMT/fBbtvK+RVA4QnZJpdxqgQ6249im7xTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c6yI3hXu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=r3AYqthkhqE/hpsX8OlsrIm8YbRRATEjfUq8IVBi2fg=; b=c6yI3hXuTHaVrvxd1yVnHBVNij
	96A37jM/iCQUDKVKAlMQN8W8+Yr5+O/MCkQEvvGDHyzlceX95tnVQ54UTGjTo95FsiCzt8tHlqxjc
	c7qG6T1XRoLA4sUABomX1yNBJDmi7TQO5p1nmcSXdtWaeC40ulDx7Om9isCCmryt1PDt9CFinKN6D
	unqbwGZsLVdRZlU1D5ss+qnhvrbroS/4iJgXIL6lrH23QI6ZibbR1wH16QYsNmVFcgNrYbypb3sVK
	etkrF/ftkKgYc/ACKnfRrGfJFJ1B6aUf/mUu/cX/rfcI0BSjIRQHATtN5B0LP33wtqiSTfY2TMOKx
	wN42K1VA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKF-00000001Sul-17l5;
	Wed, 27 Nov 2024 19:03:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKE-00000000BjT-3JcL;
	Wed, 27 Nov 2024 19:03:46 +0000
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
Subject: [RFC PATCH v4 20/20] [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
Date: Wed, 27 Nov 2024 19:00:34 +0000
Message-ID: <20241127190343.44916-21-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
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
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 01a31e4a0664..ff8a813a9f9b 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -152,7 +152,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	lidt	(%rsp)
 	addq	$10, %rsp
 
-	//int3
+	int3
 #endif /* CONFIG_KEXEC_DEBUG */
 
 	/*
-- 
2.47.0


