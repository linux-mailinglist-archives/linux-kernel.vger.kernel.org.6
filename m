Return-Path: <linux-kernel+bounces-535267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6169EA470BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6437B3AFA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7A914B945;
	Thu, 27 Feb 2025 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkBqQnb3"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B113E02A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618814; cv=none; b=qwv78+TzjCmF+3sI1qfL0klYWKG2Ns9BiAKN4Fnyu8GuGqkcwUEPYrs6jFSWevB+POESIA9vGcPcxpYHGcamwQKnGrRRcW+Czq5Gfv/CnjqatInjJ9zk24glaHyya9XQqxh2bQBNeb6ytk2Cp0o8KHscqhi0t1K030gGBTi1//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618814; c=relaxed/simple;
	bh=2H0CR+H3pcVCHgYY2mSN7jD4ZAwKWrOUyMZK1n/NR30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tO92GqoIp+XxPe47ymHHYZUHxobBTYvkZ2gWmjTcJOE8AIYhPYy8gxFWbQ7bZdX0zMnFBIZUzDZlXMlup05ZwHQt5OOgzr9FjZP1ztXb0tbtRuRCTeOorcQt7ioV3yoCriktFioJOXBAhF8aSANRlG1lwkiGVfzZ3eS+fYWKHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkBqQnb3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so869603a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740618812; x=1741223612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=U4QTUkGjoxdHKZ3Aw96WsHi8pQ/OYPAaRSw+vwAV2pA=;
        b=rkBqQnb3aD7fQ/DcA8AcgMB9TYkOXHgJ4NMchaqiFKggZx6DscBkWUBpT99ccuZy4b
         BP1mWtkJSH6e9P4HsPnpqW7wqVcuSwB42MMB3B+L+a9TuRsvOvWAOzwthhecRQD1S8sk
         muxzxupCrM3ZTltIAA+iNvKkAnLDAHNCa+fs0Ldd+Lts5HwwP791fMLErpKwrS3U7xZF
         jB7bjAETnrk33obqJIuOvXRnqbmRuFmeTfMJzrkG6U77Dp/ld7iSzqPTu3H90J+AQwnc
         Q+GgEM7T1T0KF8L61xsE5sNMATn7nZIRJ+IfBt0qptYA0Rk6aLdnUHZZLh5Ykqvm1Vsl
         yl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740618812; x=1741223612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4QTUkGjoxdHKZ3Aw96WsHi8pQ/OYPAaRSw+vwAV2pA=;
        b=T/x6IPi3EGCrQKBBGD1KBcWvMiXFqu7rqWJIQl1DhpyvKd3JYck2YEwsMQHsJMCLNC
         0Ap1U2JDeYfm7C05JsgGAIJEIgpS2VTkjrI/cv02QlKkjNKRxlQjU55VP/EybHsgO8j6
         KYGc/6UUUDn0Yfo0BJmM9uoqBkbfrc33pB4tSGmCyiA/trq8W0TRPyHRHnI/zyQtGsIg
         RIKoQPOgXqH3srHtT+LJXX1NXtUpmZMY0g5r+cV5lzpBaez5S2GFYkR5hQIrEur6V52w
         xT+mhNYc/uefCjJ9VqZonTbkENTZLlSSYOnMXQ13qj6CNh3wiqhhOt9uMsvuJpP2x99g
         /sgg==
X-Forwarded-Encrypted: i=1; AJvYcCViFQXPcFC5KLnJJ1Di7P+9iPKPl54/RagjC6d1wO42/KUP6U1LUXVH2+YWpcCHgRKy3TsD4wHwWvpYOps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6oh8YhHyfA0VcYnbcrMI/eqYdrKhfrrbvEWpeodqTokjQTOY
	3hBmUyKpUAf3aK04dR9U6Y/HdVvyih5V40EX7b5Wzw1REGlST6ne34Zv5Ys5RA8StJIetPI3q8p
	A9g==
X-Google-Smtp-Source: AGHT+IEbf/Xd9EiLaKii1/R3daJnFR38nVtwLJP6WsLc/Li9JipSYGiZgwqvYoonvp4o+UkYpf7+iM9YoFA=
X-Received: from pjz12.prod.google.com ([2002:a17:90b:56cc:b0:2f4:465d:5c61])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7286:b0:1f0:e8a3:719
 with SMTP id adf61e73a8af0-1f10ae8de07mr8836586637.30.1740618811970; Wed, 26
 Feb 2025 17:13:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:13:19 -0800
In-Reply-To: <20250227011321.3229622-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227011321.3229622-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227011321.3229622-4-seanjc@google.com>
Subject: [PATCH v2 3/5] KVM: SVM: Manually context switch DEBUGCTL if LBR
 virtualization is disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, rangemachine@gmail.com, 
	whanos@sergal.fun
Content-Type: text/plain; charset="UTF-8"

Manually load the guest's DEBUGCTL prior to VMRUN (and restore the host's
value on #VMEXIT) if it diverges from the host's value and LBR
virtualization is disabled, as hardware only context switches DEBUGCTL if
LBR virtualization is fully enabled.  Running the guest with the host's
value has likely been mildly problematic for quite some time, e.g. it will
result in undesirable behavior if BTF diverges.

But the bug became fatal with the introduction of Bus Lock Trap ("Detect"
in kernel paralance) support for AMD (commit 408eb7417a92
("x86/bus_lock: Add support for AMD")), as a bus lock in the guest will
trigger an unexpected #DB.

Note, suppressing the bus lock #DB, i.e. simply resuming the guest without
injecting a #DB, is not an option.  It wouldn't address the general issue
with DEBUGCTL, e.g. for things like BTF, and there are other guest-visible
side effects if BusLockTrap is left enabled.

If BusLockTrap is disabled, then DR6.BLD is reserved-to-1; any attempts to
clear it by software are ignored.  But if BusLockTrap is enabled, software
can clear DR6.BLD:

  Software enables bus lock trap by setting DebugCtl MSR[BLCKDB] (bit 2)
  to 1.  When bus lock trap is enabled, ... The processor indicates that
  this #DB was caused by a bus lock by clearing DR6[BLD] (bit 11).  DR6[11]
  previously had been defined to be always 1.

and clearing DR6.BLD is "sticky" in that it's not set (i.e. lowered) by
other #DBs:

  All other #DB exceptions leave DR6[BLD] unmodified

E.g. leaving BusLockTrap enable can confuse a legacy guest that writes '0'
to reset DR6.

Reported-by: rangemachine@gmail.com
Reported-by: whanos@sergal.fun
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219787
Closes: https://lore.kernel.org/all/bug-219787-28872@https.bugzilla.kernel.org%2F
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2280bd1d0863..3924b9b198f4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4265,6 +4265,16 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 	clgi();
 	kvm_load_guest_xsave_state(vcpu);
 
+	/*
+	 * Hardware only context switches DEBUGCTL if LBR virtualization is
+	 * enabled.  Manually load DEBUGCTL if necessary (and restore it after
+	 * VM-Exit), as running with the host's DEBUGCTL can negatively affect
+	 * guest state and can even be fatal, e.g. due to Bus Lock Detect.
+	 */
+	if (!(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) &&
+	    vcpu->arch.host_debugctl != svm->vmcb->save.dbgctl)
+		update_debugctlmsr(0);
+
 	kvm_wait_lapic_expire(vcpu);
 
 	/*
@@ -4292,6 +4302,10 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
 		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
 
+	if (!(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) &&
+	    vcpu->arch.host_debugctl != svm->vmcb->save.dbgctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
+
 	kvm_load_host_xsave_state(vcpu);
 	stgi();
 
-- 
2.48.1.711.g2feabab25a-goog


