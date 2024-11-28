Return-Path: <linux-kernel+bounces-424485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AC9DB4F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4E2163319
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D61925B3;
	Thu, 28 Nov 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XwedqdPJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04B17BA5;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787048; cv=none; b=eey3TRqO9qG1ddtjRUfYPejD/paRJqqRv0HOQQNJAA2CrWJlmKPTM8sK23K9VMm2rrj+3BAHOscOlcQKjGeDTDLB7JKvlLD3V1BdqJLIk6lwa0R0GLMNlqChqsJWFQLAYDMUIXXoFz5UKIxgbIY3CM6EIQ2at7XKOQLh5dqjYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787048; c=relaxed/simple;
	bh=eujJA45cOWzSmPTpJqfQMojlmB6zj3e3t7Jg0VqWyZ0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=E/aGCh7AbjmqCxFlA44K1wjtMMRS46x+uy/Yb4bf92w/gRohOqlZ+mvszvIPO67ILVM3mWCA81/Q/rtnWtTtASFkfITYUSoAmh5gxrfiYFa4a7JKPuj1Q3L4CyZPhd6m/SxlT1bvTxWPcAuOWILQy/fAUGmUfsE5D1HU/SJDs/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XwedqdPJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=1E58lGeShwswOTOQLOjpYCtc7pMebJYGn4GvdYK70QU=; b=XwedqdPJGej3sI1Xu9hiTch2oL
	SI4c4FpScJ2m/J3Ov/CL/P7seWQTg4Glq2n/QZrC8PwqzReC9NWjLqlVxwzv/rE37DPsEAFgrGVr2
	XY2mwo5UkLe2g80j1/P0YgKnbMijmEulwK/SXm7G8OIWc2Q0lV+SWCKZl0oGkymHzmzTzaNvXxJXV
	mwTq8/hqbEoWfLjAheXWcUm8kwOv/23u9QthhsmSh4Cvl0uuMeLiiCebDeWdrvcq3K2vKL0QOFvYy
	+6+g/76lJ+GEEZwqR7GwNm0ZU6mjKg8/fm4L1z8L63Q4lWYzX1IW9RWwQdUrH7sL3115434CidCYR
	VbDLLBPA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb47-00000002Tpx-0TSH;
	Thu, 28 Nov 2024 09:44:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 270DF301BD5; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094312.028316261@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:39:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/16] x86: Convert unreachable() to BUG()
References: <20241128093851.469225872@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Avoid unreachable() as it can (and will in the absence of UBSAN)
generate fallthrough code. Use BUG() so we get a UD2 trap (with
unreachable annotation).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/process.c |    2 +-
 arch/x86/kernel/reboot.c  |    2 +-
 arch/x86/kvm/svm/sev.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -838,7 +838,7 @@ void __noreturn stop_this_cpu(void *dumm
 #ifdef CONFIG_SMP
 	if (smp_ops.stop_this_cpu) {
 		smp_ops.stop_this_cpu();
-		unreachable();
+		BUG();
 	}
 #endif
 
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -883,7 +883,7 @@ static int crash_nmi_callback(unsigned i
 
 	if (smp_ops.stop_this_cpu) {
 		smp_ops.stop_this_cpu();
-		unreachable();
+		BUG();
 	}
 
 	/* Assume hlt works */
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3820,7 +3820,7 @@ static int snp_begin_psc(struct vcpu_svm
 		goto next_range;
 	}
 
-	unreachable();
+	BUG();
 }
 
 static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)



