Return-Path: <linux-kernel+bounces-443848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB49EFCA9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7651886F45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441B819CC21;
	Thu, 12 Dec 2024 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EI14KV3X"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028CB188713
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032561; cv=none; b=C0ylFwjn8ASHyHUlg8CKNkACKBVpcl+QsUtFyKH4xpLK25JEq5WFST5Y7YbenpRc/N4OBz8ofa5Ru4dgE/ZDM4YYM99PCMnYu4isDj+bLdzyvUcU6YMa1jrTSM9tV30UhkEzrZ+Xf+6fCcHNetlX9+57v0E7urhUGgFhHZRuTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032561; c=relaxed/simple;
	bh=8X2ml8a4omEZYrDIcf4Zr9KxwLsTCG9M47AiEeG4vsQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XNiwWMTBNIRG0w3H7uW/+uS7S7Z2rDkcSOfY0RAO/BMtSyR31cJkbdg57Aay9cuilp2xTLBamy3HtyeErbhwSZ4rSAvAzevKxSz1at+MrKH82oD/t2dbjSLsDV/AteZAnRNOd3yp00G8thTo/XD09Z3gxs+PHVTWGGR5b7UFfx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EI14KV3X; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fd4c36920eso704443a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734032559; x=1734637359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r95T7TRiWNq18LGJGEI5Uci5iW7usHmFMdrIwmgRTRE=;
        b=EI14KV3Xtnoa4nmoV0q4MwPwLyri9mxKfecqgt2WwAcSePdn4J1a5FooicBxeshGOV
         YSJ6qSrDymxSZmrA18PXeWNadfeTwbE59LvjOql+dLlDiiSK7q/CF0F62pKxHuq0sdSW
         ck9DSQqwKXyB1038U50FMTlnGli5PBFKGY0EsEZo3xQt2+UJeGOnpQHMMIn2JpJGZ3El
         KcK1bJuqd31D09zJcdppClcGQvpRlwmBiqWxgLvFIRWy1k/dvdP9/HeuQ9GzxcbKr+Bz
         XmLSr52i91t5eKutPbnFIL9JSLJvAYnIKMSK3FtfM9WL7Rcx3EX8XS2/RFaTEy/ohdzU
         5MVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032559; x=1734637359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r95T7TRiWNq18LGJGEI5Uci5iW7usHmFMdrIwmgRTRE=;
        b=ZamjmP6SfhNPIVX+meVnzd2GFFx/OyFYgyUD6nUUR08lWZ4x3BH4pC/IYetqmnRTII
         RG73ishO5B9zJJ7oLFraFJFb4wwT+Yl1dbML56HuYX5C00i55DXUj+MghbePo12t/LHD
         QdEeOBKq/2QaCp5xq/1KOKz/3VcGL6US6SBlUl3AF7BZhzpnTEQf/5p+rWyRkc5kqVdO
         RgEQ/7Xo6qN6nCrd5e1/aTO/vBMef3FlP3LDfP433v4XUCd4qhvnCT/8wTc9B2PKyqhy
         jLAn2KYm4Fud0zxRQFkSoCY7HM56lfN7AcNJ4QDVnhwMQoLT9YqSSCHpoJiJ+qIvRMGl
         FhUg==
X-Forwarded-Encrypted: i=1; AJvYcCXoorNRpsDRtHd5YG3Lf+Igq/U+0C2FzAEldIHwdIiNUWmBvLz2RTdNraa2/tUCKQwYzCCOZP2gv5AU0WE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3Glob80Wx76yCtjyULvKM9xMU440csNkEnsMZ5jM5hBDryLz
	LYU8z4ooKqnX+1U1zVebzG8oYLq8gnsHyROzL0iFYR4w8czISoJStdlxJVoxgxMKn+UEeDceZ7g
	oFw==
X-Google-Smtp-Source: AGHT+IG9o1Bf/No1iOsbt/K+mxuDw079R1+4DmqDcuQXHnaGDppsF0EXdHVH5jysLyJxiUW8ZQrl14ifYsg=
X-Received: from pjf7.prod.google.com ([2002:a17:90b:3f07:b0:2ea:aa56:49c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b4d:b0:2ef:316b:53fe
 with SMTP id 98e67ed59e1d1-2f127fee811mr11048291a91.22.1734032559314; Thu, 12
 Dec 2024 11:42:39 -0800 (PST)
Date: Thu, 12 Dec 2024 11:42:37 -0800
In-Reply-To: <20241212164137.GA71156@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111102749.82761-1-iorlov@amazon.com> <20241111102749.82761-4-iorlov@amazon.com>
 <Z1nWykQ3e4D5e2C-@google.com> <2b75550c-0dc7-4bcc-ac60-9ad4402c17f8@gmail.com>
 <Z1o1013dUex8w9hK@google.com> <20241212164137.GA71156@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
Message-ID: <Z1s8rWBrDhQaUHuw@google.com>
Subject: Re: [PATCH v2 3/6] KVM: VMX: Handle vectoring error in check_emulate_instruction
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, pdurrant@amazon.co.uk, 
	dwmw@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Thu, Dec 12, 2024, Ivan Orlov wrote:
> On Wed, Dec 11, 2024 at 05:01:07PM -0800, Sean Christopherson wrote:
> > > Hm, by the way, what is the desired behaviour if EMULTYPE_ALLOW_RETRY_PF is
> > > set? Is it correct that we return an internal error if it is set during
> > > vectoring? Or KVM may try to unprotect the page and re-execute?
> > 
> > Heh, it's sneaky, but EMULTYPE_ALLOW_RETRY_PF can be set if and only if
> > RET_PF_WRITE_PROTECTED is set.  Hmm, that makes me think we should do the below
> > (EMULTYPE_WRITE_PF_TO_SP was a recent addition).
> > 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 2e713480933a..de5f6985d123 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -9077,7 +9077,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> > 
> >         if ((emulation_type & EMULTYPE_ALLOW_RETRY_PF) &&
> >             (WARN_ON_ONCE(is_guest_mode(vcpu)) ||
> > -            WARN_ON_ONCE(!(emulation_type & EMULTYPE_PF))))
> > +            WARN_ON_ONCE(!(emulation_type & EMULTYPE_WRITE_PF_TO_SP))))
> >                 emulation_type &= ~EMULTYPE_ALLOW_RETRY_PF;
> > 
> 
> What if we are handling a write to write-protected page, but not a write to
> the page table? We still can retry after unprotecting the page, so
> EMULTYPE_ALLOW_RETRY_PF should be enabled, right?

Gah, I got my enums mixed up.  I conflated RET_PF_WRITE_PROTECTED with
EMULTYPE_WRITE_PF_TO_SP.  Ignore the above.

FWIW, KVM _can't_ unprotect and retry in the EMULTYPE_WRITE_PF_TO_SP case.  From
kvm_unprotect_and_retry_on_failure():

	/*
	 * If the failed instruction faulted on an access to page tables that
	 * are used to translate any part of the instruction, KVM can't resolve
	 * the issue by unprotecting the gfn, as zapping the shadow page will
	 * result in the instruction taking a !PRESENT page fault and thus put
	 * the vCPU into an infinite loop of page faults.  E.g. KVM will create
	 * a SPTE and write-protect the gfn to resolve the !PRESENT fault, and
	 * then zap the SPTE to unprotect the gfn, and then do it all over
	 * again.  Report the error to userspace.
	 */
	if (emulation_type & EMULTYPE_WRITE_PF_TO_SP)
		return false;


> >         r = kvm_check_emulate_insn(vcpu, emulation_type, insn, insn_len);
> > 
> > That said, let me get back to you on this when my brain is less tired.  I'm not
> > sure emulating when an exit occurred during event delivery is _ever_ correct.
> > 
> 
> I believe we can re-execute the instruction if exit happened during vectoring
> due to exception (and if the address is not MMIO, e.g. when it's a write to
> write-protected page, for instance when stack points to it).

Unprotect and re-execute is fine, what I'm worried about is *successfully*
emulating the instruction.  E.g. 

  1. CPU executes instruction X and hits a #GP.
  2. While vectoring the #GP, a shadow #PF is taken.
  3. On VM-Exit, KVM re-injects the #GP (see __vmx_complete_interrupts()).
  4. KVM emulates because of the write-protected page.
  5. KVM "successfully" emulates and also detects the #GP
  6. KVM synthesizes a #GP, and because the vCPU already has injected #GP,
     incorrectly escalates to a #DF.

The above is a bit contrived, but I think it could happen if the guest reused a
page that _was_ a page table, for a vCPU's kernel stack.

> KVM unprotects the page, executes the instruction one more time and
> (probably) gets this exception once again (but the page is already
> unprotected, so vectoring succeeds without vmexit). If not
> (e.g. exception conditions are not met anymore), guest shouldn't really
> care and it can continue execution.
> 
> However, I'm not sure what happens if vectoring is caused by external
> interrupt: if we unprotect the page and re-execute the instruction,
> will IRQ be delivered nonetheless, or it will be lost as irq is
> already in ISR? Do we need to re-inject it in such a case?

In all cases, the event that was being vectored is re-injected.  Restarting from
scratch would be a bug.  E.g. if the cause of initial exception was "fixed", say
because the initial exception was #BP, and the guest finished patching out the INT3,
then restarting would execute the _new_ instruction, and the INT3 would be lost.

In most cases, the guest would never notice, but it's still undesriable for KVM
to effectively rewrite history.

As far as unprotect+retry being viable, I think we're on the same page.  What I'm
getting at is that I think KVM should never allow emulating on #PF when the #PF
occurred while vectoring.  E.g. this:

  static inline bool kvm_can_emulate_event_vectoring(int emul_type)
  {
	return !(emul_type & EMULTYPE_PF);
  }

and then I believe this?  Where this diff can be a separate prep patch (though I'm
pretty sure it's technically pointless without the vectoring angle, because shadow
#PF can't coincide with any of the failure paths for kvm_check_emulate_insn()).

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 07c6f1d5323d..63361b2da450 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9107,6 +9107,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
                if (r == X86EMUL_RETRY_INSTR || r == X86EMUL_PROPAGATE_FAULT)
                        return 1;
 
+               if (kvm_unprotect_and_retry_on_failure(vcpu, cr2_or_gpa,
+                                                      emulation_type))
+                       return 1;
+
                if (r == X86EMUL_UNHANDLEABLE_VECTORING_IO) {
                        kvm_prepare_event_vectoring_exit(vcpu, cr2_or_gpa);
                        return 0;


