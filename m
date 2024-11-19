Return-Path: <linux-kernel+bounces-414619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81419D2B03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870851F238F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231E21D1F6F;
	Tue, 19 Nov 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bP/W67pM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6331D04A5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033928; cv=none; b=eDdoRodnYsMTsd0fxHt4XRWQvzu7i2/EGwgQAmDlO0sinwqmD3+CvUYGdyB7o7gdGb/0vOSCeS4F4vlZ9VnYfOq2+wHF54GgtlK/FfgsZI4cV7sq1soamBklNmZ6+OhSKBPLJ8B0Uwzq9e/et9HXk3PeFumYGRYCecGcBo1c54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033928; c=relaxed/simple;
	bh=I8k0F0QiD8jJvP3np/mgV1ix1z/ehcWpSoNtSt5TcEQ=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=P+DXPQluycJuIKMpZm3DnoCEkNCx4FPbQ6yCni2vhhsy4fCR9PRDc260YdBUwT70oHzyUEUamE5k6Z5iLE9NJTeQXnrItoNGGmRhAVD9CTgZnWsQO9LtYjnc2eHwjiZw595bjrCNdLYBhIXg9OopkYJUl6z+btAcz8efLvN29Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bP/W67pM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=h/mnugnYftitJTxGPEXN/E3BRMTm4cTRJ4TLn82el4Y=; b=bP/W67pMX2DCXyaAz/cVAYD1KO
	6dSCYQbG4p+79PtpZViWOMZve5PuH6ITBOzpKsRtuZ+vgFKFvRdCNgz7ISkULIomPue3FA2ZvwXws
	535h+L4owZQq4lBigVhw2PlGV0ndjAF6xLibY2bEtnZXiX6D9PLDhkZHFVjDbx/PuNlhCJxK1FAGC
	Q8OS1lrLFr4rIRWwoBInUIwZPncA/uz7ivIgsA54qgXMjVrbzZfMPi76lxNEufZPVwsM2fGmuRyDv
	/Mg4mMiBF9xNZokZRhERjXT5m0y4a+RLu/oZtcl4uvpalyX+CNHFRHCIyyahSPsWGmmNpq6IUsisq
	QORQV3uQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDR90-00000004IUI-3K1o;
	Tue, 19 Nov 2024 16:32:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EAAA230119C; Tue, 19 Nov 2024 17:32:02 +0100 (CET)
Message-Id: <20241119163035.758732080@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 19 Nov 2024 17:25:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "To:riel"@surriel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 5/7] x86/mm: Allow temporary mms when IRQs are on
References: <20241119162527.952745944@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andy Lutomirski <luto@kernel.org>

EFI runtime services should use temporary mms, but EFI runtime services
want IRQs on.  Preemption must still be disabled in a temporary mm context.

At some point, the entirely temporary mm mechanism should be moved out of
arch code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/a8a92ce490b57447ef56898c55133473e481896e.1641659630.git.luto@kernel.org
---
 arch/x86/mm/tlb.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -679,18 +679,23 @@ void enter_lazy_tlb(struct mm_struct *mm
  * that override the kernel memory protections (e.g., W^X), without exposing the
  * temporary page-table mappings that are required for these write operations to
  * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
- * mapping is torn down.
+ * mapping is torn down.  Temporary mms can also be used for EFI runtime service
+ * calls or similar functionality.
  *
- * Context: The temporary mm needs to be used exclusively by a single core. To
- *          harden security IRQs must be disabled while the temporary mm is
- *          loaded, thereby preventing interrupt handler bugs from overriding
- *          the kernel memory protection.
+ * It is illegal to schedule while using a temporary mm -- the context switch
+ * code is unaware of the temporary mm and does not know how to context switch.
+ * Use a real (non-temporary) mm in a kernel thread if you need to sleep.
+ *
+ * Note: For sensitive memory writes, the temporary mm needs to be used
+ *       exclusively by a single core, and IRQs should be disabled while the
+ *       temporary mm is loaded, thereby preventing interrupt handler bugs from
+ *       overriding the kernel memory protection.
  */
 temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 {
 	temp_mm_state_t temp_state;
 
-	lockdep_assert_irqs_disabled();
+	lockdep_assert_preemption_disabled();
 
 	/*
 	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
@@ -722,7 +727,7 @@ temp_mm_state_t use_temporary_mm(struct
 
 void unuse_temporary_mm(temp_mm_state_t prev_state)
 {
-	lockdep_assert_irqs_disabled();
+	lockdep_assert_preemption_disabled();
 
 	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
 	cpumask_clear_cpu(smp_processor_id(),



