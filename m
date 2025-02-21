Return-Path: <linux-kernel+bounces-525196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BBFA3EC48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7594E19C5893
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ACD1FC7E3;
	Fri, 21 Feb 2025 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6dPec//"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F69A1FC0FB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116624; cv=none; b=oITttCsP8EOAgFvBFGwwB060l+YXTguZu628CCr/ju0vSchcxALpDcj/1X9bJKZYhHvuShEREAaOqApHLrzBCGC7LPn8z5AShqR5PIoo+Ep1QmEO9175Xg0hl54CDgvrfRXOWuxvkgUYaNcejriKjZOlCNyWESagZmA8LsumcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116624; c=relaxed/simple;
	bh=1a8ijpCYc6RmVjTqi7drawTGlzgmOc63SH03Xi08U2s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=ua5YusoyPzhe4gYg9UnYSMSRdMLhjxkCL01Hr4WaXEQbC1hw/SLU3nM5kq8O9y6lsq17lgv5KwtINlepnW2Sou8Tz3q+1wEzeht8xyo3H7SfUEQV89Ao5KEHhDNYuxLTVGuQcVvHSfYpGm8pWJBCxdO3kUopPEFhrDhOKi/EuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6dPec//; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220c1f88eb4so27835465ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740116622; x=1740721422; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Udbv9b6jdKxC3izwrmuI5snJMV9vCpcArcbYsxBnyHI=;
        b=a6dPec//qB6IEhMf0ZhX5kHD25xGPhE00jELOmiIozUiWvy1RC0sKS4xYTy8r1/dYQ
         RrLz24dJQBp8Gkb2gxvVfjXKk24fZExSOr3EWAqfS/3fLzrAscDYK6G4xegtZnS9BIQ4
         5B3E2GpjEn4cEiLJukzJjL312yKTAr7DTQFeDZWVKtaAFdTTht2xVheAA+t9bzSznIrM
         II8vlghDkCOTzpb80vPgYNMtDBOvPyHi15hD9Jt5VNPRTob5KtL8x9ByoYPHgtcBAuj3
         UK/8lFSRVD86uuoFtp74/+INjrDsVpOUe/kxQKl7RZBXQCcOCrMzewQLUJ3t9Yzg9F0B
         FNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740116622; x=1740721422;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Udbv9b6jdKxC3izwrmuI5snJMV9vCpcArcbYsxBnyHI=;
        b=mSpFyzTsLJy9gTUZcluVMhfVZmwzXefJ4MzjShzyX0hZM+UrVcFEU80pgo5tCb+fqC
         8fHgz/b/K6AtJ8AY11tWBAkVQ+tWj9tAZCCUK+MvATyRZPda9GkmdwVdANKAAb1+wzRi
         4Gi7YzSg3Qez3TUudmgOCjugK9eVvbf+CcRsTP9VQX7qpjiFzuNi+mEvbuQHBeZjI9SI
         f3mJkzb3yoSxioZ5eEEFpNkA0LYd0sp6fTKV3HuHptDjNLkc2r5atK/jOu7e9Q9KR/G2
         oxvB2t+09epoWNJtLuax1T4nH0KdQ+E3MwKfYyJ6qTVVwUnKLB4EoSpXcZoOaX1gFhwV
         ZU3A==
X-Forwarded-Encrypted: i=1; AJvYcCV1wEFXFRIQP6J8yEBPtz0Nvu8cgAh1CJHJ3kd85CR7VYt3ba2KSbDyiE1EsIV/nIQK3a+TBMgn0eoTsp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXem9wH+68nrl0mqj5pgIMJ1XrjdntAPsqQk4b1xiyXvH3Cfku
	p+e+vq6bLwuso0z5eYGvrtbueDb3S0tufxivZxYonkjFIfNa67GJBFOIjvXCfPD583Keaxee+5E
	c2blE2c4X9Q==
X-Google-Smtp-Source: AGHT+IHMoc9h+uPEnyZwMQWn8CzNzAyDDl2T1OAcnERx4Ce7JVL+Csh6R44GQLlYoTpR1L9zhIJjNNB278WFDA==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:62aa:45ca:6f53:8c2a])
 (user=suleiman job=sendgmr) by 2002:a17:902:d0c1:b0:21f:449e:8995 with SMTP
 id d9443c01a7336-2219ff50decmr12925ad.3.1740116622506; Thu, 20 Feb 2025
 21:43:42 -0800 (PST)
Date: Fri, 21 Feb 2025 14:39:26 +0900
In-Reply-To: <20250221053927.486476-1-suleiman@google.com>
Message-Id: <20250221053927.486476-2-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221053927.486476-1-suleiman@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Subject: [PATCH v4 1/2] KVM: x86: Advance guest TSC after deep suspend.
From: Suleiman Souhlal <suleiman@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ssouhlal@freebsd.org, 
	Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"

Advance guest TSC to current time after suspend when the host
TSCs went backwards.

This makes the behavior consistent between suspends where host TSC
resets and suspends where it doesn't, such as suspend-to-idle, where
in the former case if the host TSC resets, the guests' would
previously be "frozen" due to KVM's backwards TSC prevention, while
in the latter case they would advance.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0b7af5902ff757..452dd0204609af 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1398,6 +1398,7 @@ struct kvm_arch {
 	u64 cur_tsc_offset;
 	u64 cur_tsc_generation;
 	int nr_vcpus_matched_tsc;
+	bool host_was_suspended;
 
 	u32 default_tsc_khz;
 	bool user_set_tsc;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02159c967d29e5..06464ec0d1c8d2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4971,7 +4971,37 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
-		adjust_tsc_offset_host(vcpu, vcpu->arch.tsc_offset_adjustment);
+		unsigned long flags;
+		struct kvm *kvm;
+		bool advance;
+		u64 kernel_ns, l1_tsc, offset, tsc_now;
+
+		kvm = vcpu->kvm;
+		advance = kvm_get_time_and_clockread(&kernel_ns,
+		    &tsc_now);
+		raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
+		/*
+		 * Advance the guest's TSC to current time instead of only
+		 * preventing it from going backwards, while making sure
+		 * all the vCPUs use the same offset.
+		 */
+		if (kvm->arch.host_was_suspended && advance) {
+			l1_tsc = nsec_to_cycles(vcpu,
+			    vcpu->kvm->arch.kvmclock_offset +
+			    kernel_ns);
+			offset = kvm_compute_l1_tsc_offset(vcpu,
+			    l1_tsc);
+			kvm->arch.cur_tsc_offset = offset;
+			kvm_vcpu_write_tsc_offset(vcpu, offset);
+		} else if (advance)
+			kvm_vcpu_write_tsc_offset(vcpu,
+			    vcpu->kvm->arch.cur_tsc_offset);
+		else
+			adjust_tsc_offset_host(vcpu,
+			    vcpu->arch.tsc_offset_adjustment);
+		kvm->arch.host_was_suspended = 0;
+		raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock,
+		    flags);
 		vcpu->arch.tsc_offset_adjustment = 0;
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 	}
@@ -12638,6 +12668,7 @@ int kvm_arch_enable_virtualization_cpu(void)
 				kvm_make_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu);
 			}
 
+			kvm->arch.host_was_suspended = 1;
 			/*
 			 * We have to disable TSC offset matching.. if you were
 			 * booting a VM while issuing an S4 host suspend....
-- 
2.48.1.601.g30ceb7b040-goog


