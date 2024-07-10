Return-Path: <linux-kernel+bounces-248040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1336C92D79C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CA71C21046
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEEC197A82;
	Wed, 10 Jul 2024 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iv6jRJA3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42495195F00
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633243; cv=none; b=fsIyAAHYT0JsYrTtyvo012GES48hTvATjP+yfnD2C8MQ1G/tmOzOWNEArTqDjKxPfYizLJYGL2ya6IETgmuN4IihJmZFqU+Izh/+1oLvhzhe2g4Cr3QGG4bRjemUdzTyNYYfmzxleigKd1r8hAVn8I+n987p0vkG5J9/m58VUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633243; c=relaxed/simple;
	bh=gT1kZyMR8REP9kWEdfkKE1I79ZexnrQ/1Jy1jOPtfaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLGPjnIHjvOGJSk//b1k7fODzJR44ZmUQLoEZOwTf3lVBpRiSvuq6J3Rtrrd5z1rcFmsnHf+Vq8asnLlA2Td5iwbWW9TpYDuSQggbxOpjJHywqXwzd2nOnb3EXFss/P6J817e4/XL5Fd2ZSLT10PBO/xPwWvqZzGkjepv0M564w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iv6jRJA3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720633241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiwBXWCu9Pltwc4y/7ILoMmMAMPZUSZ0xuryBMxBzDk=;
	b=iv6jRJA366suo18GuYM35G8GbQsK0tQdwajLBg4IGkGiSe+rwRYueDPhv3Iw75esvgeVvf
	eBIRjFDYph3ohNPlzhVh6DvxmkEaTS8cEbvwCtLgTph4YmRezhVwgI3fgy5hegFLsubGsg
	UkQrfGTxPY5YK3FngWaxV9ldBokqzXc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-MKqk1dcQPc6y_aPx4mdHzg-1; Wed,
 10 Jul 2024 13:40:38 -0400
X-MC-Unique: MKqk1dcQPc6y_aPx4mdHzg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1D2D1955F30;
	Wed, 10 Jul 2024 17:40:36 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E32721955E85;
	Wed, 10 Jul 2024 17:40:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	seanjc@google.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH v5 4/7] KVM: x86/mmu: Account pf_{fixed,emulate,spurious} in callers of "do page fault"
Date: Wed, 10 Jul 2024 13:40:28 -0400
Message-ID: <20240710174031.312055-5-pbonzini@redhat.com>
In-Reply-To: <20240710174031.312055-1-pbonzini@redhat.com>
References: <20240710174031.312055-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Sean Christopherson <seanjc@google.com>

Move the accounting of the result of kvm_mmu_do_page_fault() to its
callers, as only pf_fixed is common to guest page faults and async #PFs,
and upcoming support KVM_PRE_FAULT_MEMORY won't bump _any_ stats.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c          | 19 ++++++++++++++++++-
 arch/x86/kvm/mmu/mmu_internal.h | 13 -------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index aa437aacf55f..8c2c5c0afba1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4291,7 +4291,16 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu))
 		return;
 
-	kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code, true, NULL);
+	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
+				  true, NULL);
+
+	/*
+	 * Account fixed page faults, otherwise they'll never be counted, but
+	 * ignore stats for all other return times.  Page-ready "faults" aren't
+	 * truly spurious and never trigger emulation
+	 */
+	if (r == RET_PF_FIXED)
+		vcpu->stat.pf_fixed++;
 }
 
 static inline u8 kvm_max_level_for_order(int order)
@@ -5935,6 +5944,14 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 
 	if (r < 0)
 		return r;
+
+	if (r == RET_PF_FIXED)
+		vcpu->stat.pf_fixed++;
+	else if (r == RET_PF_EMULATE)
+		vcpu->stat.pf_emulate++;
+	else if (r == RET_PF_SPURIOUS)
+		vcpu->stat.pf_spurious++;
+
 	if (r != RET_PF_EMULATE)
 		return 1;
 
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 8efd31b3856b..444f55a5eed7 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -337,19 +337,6 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	if (fault.write_fault_to_shadow_pgtable && emulation_type)
 		*emulation_type |= EMULTYPE_WRITE_PF_TO_SP;
 
-	/*
-	 * Similar to above, prefetch faults aren't truly spurious, and the
-	 * async #PF path doesn't do emulation.  Do count faults that are fixed
-	 * by the async #PF handler though, otherwise they'll never be counted.
-	 */
-	if (r == RET_PF_FIXED)
-		vcpu->stat.pf_fixed++;
-	else if (prefetch)
-		;
-	else if (r == RET_PF_EMULATE)
-		vcpu->stat.pf_emulate++;
-	else if (r == RET_PF_SPURIOUS)
-		vcpu->stat.pf_spurious++;
 	return r;
 }
 
-- 
2.43.0



