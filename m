Return-Path: <linux-kernel+bounces-520766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E841A3AEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ADCC170DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FD61ADC8A;
	Wed, 19 Feb 2025 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEyyk16+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC851A9B27
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928442; cv=none; b=saeTOO76uqDglqIWnO9QqtT6A9nJx6jK4WJcLgkz3G/XLilKYWjYk29twm8uhbIci12hijWmDDayFS8tRlaIqn0x6IyG7GFWUeNnJrJRa27rwwGkhRC3GLcMSbnoysR9IZRJmncsmmyhjJR/u0Z8r3JyJakYsA25drIbL5fqfbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928442; c=relaxed/simple;
	bh=s1acMDP18PsE7/Eq2XXMzX6JJbDeaq52rCargDhMXVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dwCy1+gL72ib1fnYElRrlQ3Ve6ojwOpSB/gXR2/seE2OpJ8sDy2/S8BBHRU48h3DoGrp4Dzp8Y8TB0t23lpuiss8mdb8hgOcfx19+/g1r0LYkcdp5cea7SihcJaSTlSCyvT2ptUeqeHZNwefdftjm1a4kZ7ApJkh1bEteoXWGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEyyk16+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220f0382404so95242675ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739928440; x=1740533240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=la9yfbVfV6p6xAkEmRZs2B8ThoXww+XPdL9PDAJx5b0=;
        b=aEyyk16+3xbp9mm0QlzWWdSZItvqIHQeyh/hI4HxnDJyFg4E6fTk5Cu+CAbhS93yd9
         sQTB+HgP/2XBj9wJNvejT2P2JQ36Cs5yMrlYqw1iIxmf++lPC8oLiXvOMGrEL4DgHSNF
         J/vagjONBh327iGC8FBgTFCjsMJMd+jSvWYubZ9PfKX6tEXtA9NghXs/T9sAD1bgy2dr
         2uPPDFTZI7tEm0EKpRmmUteuOoCDH6EGMAtFiiNoSFiKebCms+XKzve69rK/CftqGBpx
         mqSHQJBHQEcVHGB1XBdwEnFFFv6bmkCwSRQoaCd7sj0t7tvg2Odz6QPImdPwnPFQuRd0
         E6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739928440; x=1740533240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=la9yfbVfV6p6xAkEmRZs2B8ThoXww+XPdL9PDAJx5b0=;
        b=XotLiHgXKZ6bJ+TV0x23qTPyrfVyOj2x+BmsK5BfiP3X38pPn90u49oSGxUD0zQjiy
         Fk3jDgM/MRG1nIjd/cdVKBSbrdxchhpXsHuyayeUeHp43h/ilppN9PJU2lw1hLh+D47t
         e6+Kx602LR1if+Pluy2rFjFvQRdX6MLVQuXl/wJwAyuSwIsrRbpD5/+9CMmwqXIjPMZg
         9ponYJxQMV7xYQ6SZb9MpuoszKvsJDIEtnH2ArWnF5/AvjySc6fjP1UhtppfJvwgtGM5
         15CFN5vmfnkRnekG3QLosa5TaEK9aJXNVEszR4OVF5zIb3p8fNWYf2x8hnCB4BM/qFep
         I4pw==
X-Forwarded-Encrypted: i=1; AJvYcCUJDByPgnsJGYwT7Q1cO5XsgrvJQ3xxTvRjTdDMbOyUb5/2gBaxkuNHsuk5rH41y9QBBaZP7FRwl6oCJcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhkJUburbhUyh83FyjNrAAfRG2joyQcdsZrvrtMbVBTB+HcceS
	ewzzgMz8tTSPCmTGFUkh/APWaHkBz7lEz4HuO2ElXCpPwpU9OtfQxc/Dg9AuHPASxrpk+u9d4yF
	+1w==
X-Google-Smtp-Source: AGHT+IHkXB6WyKPBJKTh2FvvXDOK0Y0JhEwaJSEgphJr1aevmbiNAoPEzD1CfLmn3KRzQKfiDHHBVaTNaV0=
X-Received: from pgar9.prod.google.com ([2002:a05:6a02:2e89:b0:ae1:b40f:fc2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918f:b0:1e1:aef4:9ce8
 with SMTP id adf61e73a8af0-1eed4ff47fbmr1819361637.28.1739928440119; Tue, 18
 Feb 2025 17:27:20 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Feb 2025 17:27:02 -0800
In-Reply-To: <20250219012705.1495231-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219012705.1495231-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219012705.1495231-8-seanjc@google.com>
Subject: [PATCH 07/10] KVM: SVM: Use guard(mutex) to simplify SNP AP Creation
 error handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"

Use guard(mutex) in sev_snp_ap_creation() and modify the error paths to
return directly instead of jumping to a common exit point.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 7f6c8fedb235..241cf7769508 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3940,7 +3940,6 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 	struct vcpu_svm *target_svm;
 	unsigned int request;
 	unsigned int apic_id;
-	int ret;
 
 	request = lower_32_bits(svm->vmcb->control.exit_info_1);
 	apic_id = upper_32_bits(svm->vmcb->control.exit_info_1);
@@ -3953,11 +3952,9 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 		return -EINVAL;
 	}
 
-	ret = 0;
-
 	target_svm = to_svm(target_vcpu);
 
-	mutex_lock(&target_svm->sev_es.snp_vmsa_mutex);
+	guard(mutex)(&target_svm->sev_es.snp_vmsa_mutex);
 
 	switch (request) {
 	case SVM_VMGEXIT_AP_CREATE_ON_INIT:
@@ -3965,15 +3962,13 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 		if (vcpu->arch.regs[VCPU_REGS_RAX] != sev->vmsa_features) {
 			vcpu_unimpl(vcpu, "vmgexit: mismatched AP sev_features [%#lx] != [%#llx] from guest\n",
 				    vcpu->arch.regs[VCPU_REGS_RAX], sev->vmsa_features);
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
 		if (!page_address_valid(vcpu, svm->vmcb->control.exit_info_2)) {
 			vcpu_unimpl(vcpu, "vmgexit: invalid AP VMSA address [%#llx] from guest\n",
 				    svm->vmcb->control.exit_info_2);
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
 		/*
@@ -3987,8 +3982,7 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 			vcpu_unimpl(vcpu,
 				    "vmgexit: AP VMSA address [%llx] from guest is unsafe as it is 2M aligned\n",
 				    svm->vmcb->control.exit_info_2);
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
 		target_svm->sev_es.snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
@@ -3999,8 +3993,7 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 	default:
 		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
 			    request);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	target_svm->sev_es.snp_ap_waiting_for_reset = true;
@@ -4014,10 +4007,7 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 		kvm_vcpu_kick(target_vcpu);
 	}
 
-out:
-	mutex_unlock(&target_svm->sev_es.snp_vmsa_mutex);
-
-	return ret;
+	return 0;
 }
 
 static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_gpa)
-- 
2.48.1.601.g30ceb7b040-goog


