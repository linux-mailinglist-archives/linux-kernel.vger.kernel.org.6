Return-Path: <linux-kernel+bounces-535329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26FA4715C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499951695A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743D51D5CE5;
	Thu, 27 Feb 2025 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CN7O9/qy"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAF1C6FF8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619555; cv=none; b=kdDbs05Pqk9Mo1iphmZg3FtQZRDUB+CINnXYcK6xMk2CCOToRHaE48nR9QXoW1+5KNJsaYfam+U/JrsOWvLMNGdVTGvcx6kCYN2CyLLcEiP5zCvxIMjAUow9xgndkpVuYpe8BL9fxpRPOoytbDXiBBLXW8QGnC/mVH4wwF3gadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619555; c=relaxed/simple;
	bh=dDR1QpQVcSQvKqFE0KvEiZ7AYWgfuYaS5/Kd55ia8vU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jq541uysl0qHad4pH37Ul9gNR8iipIkCOzgKh+g46nkWkdRdrxyYzk5iyVl79RZD4VaoFLnFkRnG4sv247kWymL5Ga/zgYvFn4MScJsHRFV11TjvnbJKKpgGyDY6/6i0MCBQdA48ip9phAn78db0xj7H4eyn5duCKaEMvWYTLp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CN7O9/qy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22328fb6cbfso7431975ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740619554; x=1741224354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HpoG9IAubpCDT+wLYzi42QtAGv2cg0ICoGBus9dCqMw=;
        b=CN7O9/qysEZ8W+P+Y8JduIxwXS2sDL4Me2lMWiDi7LESsP5BCCnccbncUpeSJTYcpi
         AAmcjnGBP/RZG2mCGZUXAJli5V2K0JjJxClbE8h7gN+Mv2UwF8Ol0Kmr40EDP8blk3ox
         VQBJvLq2wetwBcfB/3E6FhMIZ89PmZv4ZQ517KqAdNQC+jy+iGDrBE/QR9XsobDFT7rg
         jR+uqqx/hhkgPUPwN6ORVzSwixoEFVPiX5rq7x1agydCpHnnfzaBtEgptafHe5yDhA16
         8jevoINcvTB1L/WI5jekykFJU0LKVhHWqYiP2uPiZUaE3iLcZkcdJqqWYdOUSQG8mdoc
         IU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619554; x=1741224354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpoG9IAubpCDT+wLYzi42QtAGv2cg0ICoGBus9dCqMw=;
        b=DP4u5ouD89qh/LRbxB554YHqpbe7urTs1w1f2t6w039IytgEs0/3SOXy1kWWQR9hS/
         VHiJGRBCt4kiEBJmJs5WqIXIXmbFnxhgZ4JC2phW6MeXUIi9Er7C3yXK66l943sh58ZD
         YbdBhRLDmAzZdmrykZBDS3uZ23wG/t8gOMeyGmXMwE9AzSWKlLqP8g0/p+xAQahn5XJZ
         EINn4ODsohGk3Bl12TB9q4F+xMct5F2S/EG2LB3Kcrsc+Blc2YYwzkze2zdjKi0N6Ejl
         hZsOEWR+yzEW7JZifZ/BLKd2S37bG9Nl07HEDQd9WAXDNKJhYrakDW5Nt+3cbMQQJK/n
         kJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPh297yq2kZcfexarRHg02afxAxnkdw3TH0O4rVcrwP1wfz/zQ/O3KNLplGVZfamg8hB5sziGQgiadAqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEj3+44cx9Z18c9JTzt4et87/kG4Zfc1d8JerJdar9OR1tJl5N
	zMQGx5YqwjHyC/VkladIyA0Ncxoq9nGUxy4AJzRD0iXx5LolqTugk08JxKepirkumb59mk0dPqq
	rAA==
X-Google-Smtp-Source: AGHT+IGescKmvLpkcPFFde/D5wUCncfjV68Ld5mkBOALQrlPwQFVWlWLOcBp8zNKxty+sQjM+lwnvjXZb/A=
X-Received: from pjbsw3.prod.google.com ([2002:a17:90b:2c83:b0:2fa:15aa:4d2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c7:b0:220:cd7f:cde8
 with SMTP id d9443c01a7336-22307b5b218mr150692835ad.29.1740619553863; Wed, 26
 Feb 2025 17:25:53 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:25:37 -0800
In-Reply-To: <20250227012541.3234589-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227012541.3234589-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227012541.3234589-7-seanjc@google.com>
Subject: [PATCH v2 06/10] KVM: SVM: Simplify request+kick logic in SNP AP
 Creation handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"

Drop the local "kick" variable and the unnecessary "fallthrough" logic
from sev_snp_ap_creation(), and simply pivot on the request when deciding
whether or not to immediate force a state update on the target vCPU.

No functional change intended.

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index bad5834ec143..ccac840ee7be 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3938,7 +3938,6 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 	struct vcpu_svm *target_svm;
 	unsigned int request;
 	unsigned int apic_id;
-	bool kick;
 	int ret;
 
 	request = lower_32_bits(svm->vmcb->control.exit_info_1);
@@ -3956,18 +3955,10 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 
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
@@ -4012,7 +4003,11 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 
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
2.48.1.711.g2feabab25a-goog


