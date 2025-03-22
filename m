Return-Path: <linux-kernel+bounces-572092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B928FA6C65F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6A81788B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BD823372E;
	Fri, 21 Mar 2025 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkr9BvQy"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979723371C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599067; cv=none; b=eK2LMQOPz9qv+cCrESNPcP2GtCLf8z/koCQxwCwlM7pjAL5YfdNE1e99E0vFfP/APLBkl3nKubHWTLwfjLfhNOZziTzmPtQLCP3wMRpIydPqHFcbApLV7LMG6sbG2tNDuZuzXpytDewwJ00FtkeyQhe02tyucJ4AZm+Bqhu0v4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599067; c=relaxed/simple;
	bh=lXrOKtzABjGhWs7Ij/i6BaRO/TDVJITftxkEaZ9HOcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ixEymlOLRCMW+uq6J/1X3oRNNJW5bkvXdvD9acbSYdUIBpvTkpt31S+chZFMEgodK6ueTk5kHa5zG3KaBSYiaH1nc6DvIB0/wWLMn/eV8zVSWTlH6fZQbT9wEyggM4jIFqSV2hHnZB4DBdOt9diD9WVOaOkzrkGxy70cggffzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkr9BvQy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso6251814a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742599065; x=1743203865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyLJOzYWzjCIZlosJUfQjcjVnmAe1GOmsaNGK/OHc9M=;
        b=jkr9BvQykSuOMo+liRLTXlPg4i8eKTGy1JJrdDLPkT4twknuUYqz0ePg/cL/Sx9jav
         rs7P6QYJwW4vcRIkEfZhRazLyyKKLr7WBpSC9PAVVXDxdTkT1JTXQCQ5e/ZPOCGyo6bg
         aK2+oDfC+Ycb9qFVlxnorYWyvcvdiNGLW3QXinOtDJvsWtrkrGRupGA0L8352WlHHmyY
         /LgpHxtzXmSc52BRUzPhZJh81COMqttKTmAi6bKLMJVRLCwWxQ1r8rm7WwRrv1kjMdxD
         j47LrrWsrpKGvzULlwWglEstUJ7VgaJqGseAviB1gsjyzh726jUiBIsC7pE8einGbvWL
         cpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742599065; x=1743203865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyLJOzYWzjCIZlosJUfQjcjVnmAe1GOmsaNGK/OHc9M=;
        b=dNY94wEipSO5rlS24ToWkBa13mNpXlCqGtHl+qE0KBW8erxweoJZF3rN6WN5le7BcD
         dgHMz9WUuaRuMH3W8UWQF0ytt2mO9klcfdAjyB4vsowi1RquHh9rH1sf+Dt4hD/iPbic
         AvVskYfkKRRPkLEhCa++VGg0yL7JHeg9Y+njBqBFI6hq3ApeaXtZ5eoSTgCdZBsvt/uX
         GA5RbO6yIL1HrPnsLule4KwNQIz+kbN4Qi9rtFK/SIrtkPt/61XaU6wTQS31qprpyGcn
         Lhyg9PIp2aI5kh28T13rILjBJHAX1Z900S6n2a/DU+LIH26NaMg7coUVGVMM2C8kRZyc
         Yyqw==
X-Forwarded-Encrypted: i=1; AJvYcCVsHdNZG63VZC0Z4lMfashqZjA09mIhe8hGZ7qRL7c6PXfXmCy7tPqTtVNjeyEoydq0BmQu38ex8MBldYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+q0d4WA+1rRb/JjfJSdW3uWSLXOGytuREHDgpUAyk4nSd5tF
	hwnyG087lrfwsY8gcfUkEQryfPaDnDWbIRk2x7t7XsxAFgeHoYt0iZCecHp7drXAy12M5tcfDTG
	zMg==
X-Google-Smtp-Source: AGHT+IHpmffoheyuElFouvvpNqd6iCMiNPs8uVvwlJYQzQ/8dOEH51DfQjENTXniALDbstnCy+o/Z2aFi8Q=
X-Received: from pgjh4.prod.google.com ([2002:a63:df44:0:b0:af5:91a1:e217])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a10c:b0:1f5:5614:18d3
 with SMTP id adf61e73a8af0-1fe42f07bb6mr9334872637.8.1742599065381; Fri, 21
 Mar 2025 16:17:45 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:17:43 -0700
In-Reply-To: <aeabbd86-0978-dbd1-a865-328c413aa346@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6053e8eba1456e4c1bf667f38cc20a0ea05bc72c.1742232014.git.thomas.lendacky@amd.com>
 <48899db8-c506-b4d1-06cd-6ba9041437f7@amd.com> <Z9hbwkqwDKlyPsqv@google.com>
 <8c0ed363-9ecc-19b2-b8d7-5b77538bda50@amd.com> <91b5126e-4b3e-bcbf-eb0d-1670a12b5216@amd.com>
 <29b0a4fc-530f-29bf-84d4-7912aba7fecb@amd.com> <aeabbd86-0978-dbd1-a865-328c413aa346@amd.com>
Message-ID: <Z93zl54pdFJ2wtns@google.com>
Subject: Re: [PATCH] KVM: SVM: Fix SNP AP destroy race with VMRUN
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 21, 2025, Tom Lendacky wrote:
> On 3/18/25 08:47, Tom Lendacky wrote:
> > On 3/18/25 07:43, Tom Lendacky wrote:
> >>>> Very off-the-cuff, but I assume KVM_REQ_UPDATE_PROTECTED_GUEST_STATE just needs
> >>>> to be annotated with KVM_REQUEST_WAIT.
> >>>
> >>> Ok, nice. I wasn't sure if KVM_REQUEST_WAIT would be appropriate here.
> >>> This is much simpler. Let me test it out and resend if everything goes ok.
> >>
> >> So that doesn't work. I can still get an occasional #VMEXIT_INVALID. Let
> >> me try to track down what is happening with this approach...
> >
> > Looks like I need to use kvm_make_vcpus_request_mask() instead of just a
> > plain kvm_make_request() followed by a kvm_vcpu_kick().

Ugh, I was going to say "you don't need to do that", but I forgot that
kvm_vcpu_kick() subtly doesn't honor KVM_REQUEST_WAIT.

Ooof, I'm 99% certain that's causing bugs elsewhere.  E.g. arm64's KVM_REQ_SLEEP
uses the same "broken" pattern (LOL, which means that of course RISC-V does too).
In quotes, because kvm_vcpu_kick() is the one that sucks.

I would rather fix that a bit more directly and obviously.  IMO, converting to
smp_call_function_single() isntead of bastardizing smp_send_reschedule() is worth
doing regardless of the WAIT mess.  This will allow cleaning up a bunch of
make_request+kick pairs, it'll just take a bit of care to make sure we don't
create a WAIT where one isn't wanted (though those probably should have a big fat
comment anyways).

Compiled tested only.

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5de20409bcd9..fd9d9a3ee075 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1505,7 +1505,16 @@ bool kvm_vcpu_block(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
-void kvm_vcpu_kick(struct kvm_vcpu *vcpu);
+
+#ifndef CONFIG_S390
+void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait);
+
+static inline void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
+{
+       __kvm_vcpu_kick(vcpu, false);
+}
+#endif
+
 int kvm_vcpu_yield_to(struct kvm_vcpu *target);
 void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu, bool yield_to_kernel_mode);
 
@@ -2253,6 +2262,14 @@ static __always_inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
        __kvm_make_request(req, vcpu);
 }
 
+#ifndef CONFIG_S390
+static inline void kvm_make_request_and_kick(int req, struct kvm_vcpu *vcpu)
+{
+       kvm_make_request(req, vcpu);
+       __kvm_vcpu_kick(vcpu, req & KVM_REQUEST_WAIT);
+}
+#endif
+
 static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
 {
        return READ_ONCE(vcpu->requests);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 201c14ff476f..2a5120e2e6b4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3734,7 +3734,7 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_wake_up);
 /*
  * Kick a sleeping VCPU, or a guest VCPU in guest mode, into host kernel mode.
  */
-void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
+void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait)
 {
        int me, cpu;
 
@@ -3764,12 +3764,12 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
        if (kvm_arch_vcpu_should_kick(vcpu)) {
                cpu = READ_ONCE(vcpu->cpu);
                if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu))
-                       smp_send_reschedule(cpu);
+                       smp_call_function_single(cpu, ack_kick, NULL, wait);
        }
 out:
        put_cpu();
 }
-EXPORT_SYMBOL_GPL(kvm_vcpu_kick);
+EXPORT_SYMBOL_GPL(__kvm_vcpu_kick);
 #endif /* !CONFIG_S390 */
 
 int kvm_vcpu_yield_to(struct kvm_vcpu *target)


