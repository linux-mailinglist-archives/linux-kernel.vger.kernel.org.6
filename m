Return-Path: <linux-kernel+bounces-520765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E6EA3AEE9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF4C188FA84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1D1AA1C9;
	Wed, 19 Feb 2025 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBc9F342"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65B19F49E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928440; cv=none; b=QWPlLrM4Z/n8TRokQJ2KLWpf23awW0Q4LfQ2lOT+F2YGgZw4kXdooqQOiMoGbhapXQ3V2JYFumhqTqoYA0ELKHL/fO3s14p5+LSsA+Y5/DXFVffi5BopwRmbiaRYI7PrM1+9luQRnpLEnx/B+5lokdbStrkRTlNmorqqCRAzsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928440; c=relaxed/simple;
	bh=4qE5F9QWe3d5A9/GJCtcN7m+vBvm8zcYETmt15oXBYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GX29NFLECJSb2kSP3h8xgqN+zemiHpPaiVu0MfAVBA1+zS+ec4ohqy7FsazCnv5fltwIy6aYocp7XW+ELNF8qJLMlAYC6fQa4NnOqHGjYNeHteoGaoM/dTgQbyS1D8cBFqwSWCWm5dTHCcrhCr9HnEXexNVojFyLC3VnQB3zf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBc9F342; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f6cb3097bso168601825ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739928438; x=1740533238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aOyRwh3cs/Bv/kD6e4Ko51Wq3Y7FnlmGeIcwci8wsgs=;
        b=WBc9F342lfYIevxHs0qS3XG/3NIcYsMWlUs+1k5TmQKlMv1sUQTFJiu2ZwM3o8Yskz
         CerjFuZyokoT25mP9qI+zavc6Q0VcbdA/erqmnVkMQo9NSn8rZi3P2buhFsO6EMgh0Fk
         jjyEE5r43ECdMINv11AeDbVRP2g0GzhmKtbbq8Ix+/1wcdOJUrGPJQIAwkyYM03eNQye
         e9gbAV2d9cPjSIAVHYJogZCOfZlIrbVZw97iNlS8WiYiC1dU2KY5Zb15xn0nmySYMjqX
         ICHl28jH2AxdjW/+jq4cf8AhBBMJn5zu4jV5fSh11dQGwuAC29uSxzeLECt7zcGpFZR/
         p82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739928438; x=1740533238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOyRwh3cs/Bv/kD6e4Ko51Wq3Y7FnlmGeIcwci8wsgs=;
        b=xRYY4MCY5Ak3CQs80VdeYZyyYNtZq4AOOYeLTBW88QvKTZY2C3cE3Qb7M5KiGLoQ5d
         aN/mPG/bBGfDeTdMpkzt+08CwBn8TosIKnT3M4yKSzwWPvXYb7x/+O0cVVaDcNc/w50O
         FBFg5kXz+ijM5urKyU9Z2VmFGCFMTpRvkI+foVfVPtunJNa5s8a3EHpgGSWLTjZODpwc
         hygVlc0B+COiCFGshvlCAte0VCKeBEJDQ+l13toaBYstCC9bFFwORPAOtphxyG5TBZ3+
         Y5z20Jq5md7gsw1FurB0ZsVH4lTLcSxa1MJFvVQl93rltRadtsNkaon4x89hdZCYtvcO
         FTPA==
X-Forwarded-Encrypted: i=1; AJvYcCUk97j/6e1ktfxbqcC0KdRd9idCdf639DZzPUq/sI9Nl1uXoorSiwu0fFFkh2HjGJNI9Jp2TwKgs+YBLqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHHgrvPphB9O8FebqDpkAGRchlKXVuC9cnKzl28Wnit4BnBcL
	bSksGGvQKmaPSAVAFlJ4s6E0NPctG6/0ymcb6dYKe+p6lJcfrPTqT5t5mDIdCth7tHHYpF/kMZC
	aJw==
X-Google-Smtp-Source: AGHT+IF+YqB2BsGnTBgkZ7aSO4/b+DJSSz7i3scaotfvDL8sIJxSg/XtkrgUinD2Rx2q79WIomlg2wu4Wbk=
X-Received: from pgbfm14.prod.google.com ([2002:a05:6a02:498e:b0:ad5:4477:da5b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d9c:b0:1ee:d6ff:5abd
 with SMTP id adf61e73a8af0-1eed6ff5f5emr1048651637.14.1739928438279; Tue, 18
 Feb 2025 17:27:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Feb 2025 17:27:01 -0800
In-Reply-To: <20250219012705.1495231-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219012705.1495231-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219012705.1495231-7-seanjc@google.com>
Subject: [PATCH 06/10] KVM: SVM: Simplify request+kick logic in SNP AP
 Creation handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"

Drop the local "kick" variable and the unnecessary "fallthrough" logic
from sev_snp_ap_creation(), and simply pivot on the request when deciding
whether or not to immediate force a state update on the target vCPU.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8425198c5204..7f6c8fedb235 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3940,7 +3940,6 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 	struct vcpu_svm *target_svm;
 	unsigned int request;
 	unsigned int apic_id;
-	bool kick;
 	int ret;
 
 	request = lower_32_bits(svm->vmcb->control.exit_info_1);
@@ -3958,18 +3957,10 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 
 	target_svm = to_svm(target_vcpu);
 
-	/*
-	 * The target vCPU is valid, so the vCPU will be kicked unless the
-	 * request is for CREATE_ON_INIT.
-	 */
-	kick = true;
-
 	mutex_lock(&target_svm->sev_es.snp_vmsa_mutex);
 
 	switch (request) {
 	case SVM_VMGEXIT_AP_CREATE_ON_INIT:
-		kick = false;
-		fallthrough;
 	case SVM_VMGEXIT_AP_CREATE:
 		if (vcpu->arch.regs[VCPU_REGS_RAX] != sev->vmsa_features) {
 			vcpu_unimpl(vcpu, "vmgexit: mismatched AP sev_features [%#lx] != [%#llx] from guest\n",
@@ -4014,7 +4005,11 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 
 	target_svm->sev_es.snp_ap_waiting_for_reset = true;
 
-	if (kick) {
+	/*
+	 * Unless Creation is deferred until INIT, signal the vCPU to update
+	 * its state.
+	 */
+	if (request != SVM_VMGEXIT_AP_CREATE_ON_INIT) {
 		kvm_make_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, target_vcpu);
 		kvm_vcpu_kick(target_vcpu);
 	}
-- 
2.48.1.601.g30ceb7b040-goog


