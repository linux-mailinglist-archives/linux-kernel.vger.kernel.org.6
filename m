Return-Path: <linux-kernel+bounces-515934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F82A36A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B61174F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F81519B8;
	Sat, 15 Feb 2025 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUMYj2e8"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C041126C10
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581576; cv=none; b=kMXt5n23uIX80lQ+ocVHWTVwJae2shMCcGB3APw0jNKcGhAQyNl0ZiCPPZdDx9R9hgqFyfU3x0tCO99NSzp1uL+6WK3d0IS0PhucSILo8l8/W9lvEBJjOGhjNU6RPCUmPp2QWKUBt0LVcNFynmYOKAsvCEcBF/uFHKOrNmUKIuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581576; c=relaxed/simple;
	bh=bSuqZiuVhGn+R3CBW88ZrNQnYfX6dqIbqMfitjYCmLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u8lL1gj7vtEZXyoTy5My76i1Xsw9KcSjPlQ2N7o0PDBNQPk9KXafZTVGqBDwytkwRhDW9RmgoAWgwzI2aZSmiOnUDT+lk4zJt//V0hnLH7anBoZQEBV8GWvgro9L4nrQkPUqGHMOmOWEV5CgsUVQad8OJRap/1izWNSV/q9owq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUMYj2e8; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc46431885so70558a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739581574; x=1740186374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zn5CjaOI/LVKyc7fUHXaWbf0DV9/drzUj0wLJyxdr5U=;
        b=JUMYj2e8ztRB9wvmZJVlppjf51+uPL+5ng/JYFX0Hvn1agTnbFH00Ec/JtXPLJxV2l
         689JmXF7zvRlYOqXYAKHKs8z0Qvcwla2aNXgN6qlmV6IbzT3sMg6DFf8MsIqBnIsc6h6
         Tse6QyqgUOwsoIgR5ggzN5aAFRAchNsND1+jbY6gQCrWtLiXZU08AutYA2Qg6C20eeEr
         Zo4fb3i/qZaz6A0vzgzTIKxi6MNDebPO9ZlxqIM8378I4j3Si4ouTeF7embzUrq9Hzcn
         JhyiAEeRdcXsrD6HGoLpT8cwAJlZFmOveYbkr7L8qVIQfNNN+TUFI0ae4IUU+piuildv
         3QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739581574; x=1740186374;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zn5CjaOI/LVKyc7fUHXaWbf0DV9/drzUj0wLJyxdr5U=;
        b=ZLTVZ2v/eyXsUuPfI2ZTtJ0gS+WFWusAKtk7XfYecxin4xHwjt+MlK91raWqTqF8Jh
         fGl0zJotU+iSATN3pgI5umS3/G8arBgdeSrrcoGydB2RVOjGQT+8Peq+uWfzUaU9ejXL
         Sj/CZhgjzoRzmxTNN7LBkSiQdYwrt6sX3qObywn13u8DA0CBKCFY8COIw2Ackt4Y8SRR
         Iba1UvCHo6b31Oad5EQj1qByVVP8sJ4B3Q5JsUFSdiGNqb9eqSFGRhvlUP2O6IyKfC/0
         L/jJjynzQULeOarKqRHptegk5pVF2gutRIuGsgIWQy4dWAkghoMfcx3c+aGv82LDmeyZ
         vPhA==
X-Forwarded-Encrypted: i=1; AJvYcCVnrb/Wi9gi2Iq8sTSWe2fxhO6B+gcnrhYZSSj5CTwaQUTCr5q1+Zop8AE0L7fr9v+ldfrL+T7NxPhU3Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpuVf+NE2xO5Y6rpw2vSv2WDKiHpkIPFwf9zIFU4jqkua1sLk9
	7WhISd8yM2WWLQ1TqHy7uS6DN4ApxvpdLLmkaotxdGvhg9j4I9jFkyuFnkO2oNaDZriiIN3pZTU
	69w==
X-Google-Smtp-Source: AGHT+IFIwMKT3tvPATCPjCIoh5AEF4qKbxWAMxjW2j21dZojwEmwm8bNWQma8rcOLanXENnhrxNv4XpJxno=
X-Received: from pjbpq11.prod.google.com ([2002:a17:90b:3d8b:b0:2ea:5469:76c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380f:b0:2fa:ba3:5451
 with SMTP id 98e67ed59e1d1-2fc4115089fmr1816354a91.35.1739581574696; Fri, 14
 Feb 2025 17:06:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:06:09 -0800
In-Reply-To: <20250215010609.1199982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215010609.1199982-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215010609.1199982-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86: Rename and invert async #PF's send_user_only
 flag to send_always
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rename send_user_only to avoid "user", because KVM's ABI is to not inject
page faults into CPL0, whereas "user" in x86 is specifically CPL3.  Invert
the polarity to keep the naming simple and unambiguous.  E.g. while KVM
often refers to CPL0 as "kernel", that terminology isn't ubiquitous, and
"send_kernel" could be misconstrued as "send only to kernel".

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/x86.c              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3506f497741b..0f1c57006da3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -999,8 +999,8 @@ struct kvm_vcpu_arch {
 		u64 msr_int_val; /* MSR_KVM_ASYNC_PF_INT */
 		u16 vec;
 		u32 id;
-		bool send_user_only;
 		u32 host_apf_flags;
+		bool send_always;
 		bool delivery_as_pf_vmexit;
 		bool pageready_pending;
 	} apf;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3b67425c3e3d..c8e2d905c172 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3561,7 +3561,7 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 					sizeof(u64)))
 		return 1;
 
-	vcpu->arch.apf.send_user_only = !(data & KVM_ASYNC_PF_SEND_ALWAYS);
+	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
 	vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
 
 	kvm_async_pf_wakeup_all(vcpu);
@@ -13394,7 +13394,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
 	if (!kvm_pv_async_pf_enabled(vcpu))
 		return false;
 
-	if (vcpu->arch.apf.send_user_only &&
+	if (!vcpu->arch.apf.send_always &&
 	    (vcpu->arch.guest_state_protected || !kvm_x86_call(get_cpl)(vcpu)))
 		return false;
 
-- 
2.48.1.601.g30ceb7b040-goog


