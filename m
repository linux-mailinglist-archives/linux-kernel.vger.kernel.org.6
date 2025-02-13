Return-Path: <linux-kernel+bounces-513289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2642A34885
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E9A188A02B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ABF1CBEAA;
	Thu, 13 Feb 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqNNeqxW"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D971B18F2FC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461660; cv=none; b=P/MHcrkSsrhzBc9etUBlfLQbUhoxFKKqi1p/LxW+H9cRuvWWMsDhqWYw94ZWIwon5t31zAHXcjZoInMkRFYSs6/MYk2iKH1jm76VlIkYK1I7UM9xNwc2Pe54LEJ3ScZuV4k5WkMNC32l1OigX7RfWFp5MA9nbgWqFlrNH6pYJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461660; c=relaxed/simple;
	bh=hIy5pXh4y/8Q0gYHXdsOqbcgQADp5AC8VTtbqfxyj04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OSkZHlQ+GwzCEJ3dVPYSuI7b7igqZneX/Yh9tUH/XEEbqi7K3dVuci8IyCYfUiU8Bb9wxyBrtb+rnovapKuYEFCnlf15+0AS418HLTG1bnmHeTsPd7aBPG8TUVtkJ/OjiNcTkp0M7fJICE3fetwPeuNW9MdzYnAPcnt5W2VIxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqNNeqxW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa6409c0baso3542045a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739461658; x=1740066458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmNpP4YGEk282karFXTLw7N03fUwb/8MuF654Jepnhw=;
        b=ZqNNeqxWLUG5Rwx4awZZXcmo0L+HR2MWcWET0uq9XHh1W2mGG2q7tfXoN4QRY9ZjkP
         SfB1crro1UYbI0+PQjYTGj4sSHTQDD4Q2UqZLPOrG6s4Zq/+ADuYCpwCNE1utFsYM9x5
         BaG8XfRralEvsLNoCYzLfQqOtPgVbSEDVsE5YKmFnNKJ09Dj68ULhRWkBFbeK1meYmld
         /iozPzCnrYRQ4q0uVGZTVw5bw/Km6qtfSn3Zvpe6KUd5YxXNd47JGeRYAEFRefjz39yT
         aKygASU2CRFxoqs4tEfDO/uBg3semFO1Hn0kFl/vETVvAWU0WEttO0aemQV9yx4Ga8WJ
         UTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739461658; x=1740066458;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hmNpP4YGEk282karFXTLw7N03fUwb/8MuF654Jepnhw=;
        b=YEU/9c0watHzHG9Nbq530b0xQ4BrRicT2ebf+L5cI5EprDPFbUa0KTDbvs1UvYY5hs
         19wHb5I9i4NqNCUINlXm/saCkE3w/tPAWqvs0eNR7jSQDMb3JtHGiRtfR/k849DFqpR+
         hXU41fKuWMN2kSoMHm2+LmCAF7ow0GFXafM1CppcUD2UqLzNjk0Pqj98AjFMLzhna87W
         2f+TBhoH5D7jDdwfwiWVGs/kIiFlpt7METsq1SmyHOLvwr1pfYu6hy6PAO7sXw16Nhvf
         IyLGZ75aTXqfcy9kNgKTX3tZH2aMwxRtOZ6SQrUtjF4ybKmYHsUwHMd5kUE5B2anAcUU
         h8pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOPdm0J8jyJznvGfYp0Qn1UAJiKKFOdWixaqf99+0RJ5zkUt6vB1qBHfAL4JSPu6ePGXMrs/BB7Ueo1sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUtITIx5wywGsaKT/KdJYioccU/PlODQlIEh+SVMya9DYC9mWk
	an8syjmpOzfzsu5u/5HEuzqKsV0Fex2vJy4q/UOa9Gjd9BrOjdlYSYiv78Gae02r09GMY3yDLP4
	Q8Q==
X-Google-Smtp-Source: AGHT+IGaLcjab1UGvr0Z7pZ5+q0nKr8aYvYSyIXe+h+lvbdZI1DyQMlmxV/07FFHeYIbV83NKEBsUYCxYZk=
X-Received: from pfbmb19.prod.google.com ([2002:a05:6a00:7613:b0:730:451c:475c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fd0:b0:732:23ed:9457
 with SMTP id d2e1a72fcca58-7322c39b70amr11735578b3a.12.1739461658165; Thu, 13
 Feb 2025 07:47:38 -0800 (PST)
Date: Thu, 13 Feb 2025 07:47:31 -0800
In-Reply-To: <CADrL8HXZed987KOehV7-OroPqm8tQZ0WH0MCpfDzaSs-g_2-ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67689c62.050a0220.2f3838.000d.GAE@google.com> <20250212221217.161222-1-jthoughton@google.com>
 <Z60lxSqV1r257yW8@google.com> <CADrL8HXZed987KOehV7-OroPqm8tQZ0WH0MCpfDzaSs-g_2-ag@mail.gmail.com>
Message-ID: <Z64UE0Uh_3DT1jFA@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in vmx_handle_exit (2)
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: syzbot+ac0bc3a70282b4d586cc@syzkaller.appspotmail.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025, James Houghton wrote:
> On Wed, Feb 12, 2025 at 2:50=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, Feb 12, 2025, James Houghton wrote:
> > > Here's what I think is going on (with the C repro anyway):
> > >
> > > 1. KVM_RUN a nested VM, and eventually we end up with
> > >    nested_run_pending=3D1.
> > > 2. Exit KVM_RUN with EINTR (or any reason really, but I see EINTR in
> > >    repro attempts).
> > > 3. KVM_SET_REGS to set rflags to 0x1ac585, which has X86_EFLAGS_VM,
> > >    flipping it and setting vmx->emulation_required =3D true.
> > > 3. KVM_RUN again. vmx->emulation_required will stop KVM from clearing
> > >    nested_run_pending, and then we hit the
> > >    KVM_BUG_ON(nested_run_pending) in __vmx_handle_exit().
> > >
> > > So I guess the KVM_BUG_ON() is a little bit too conservative, but thi=
s
> > > is nonsensical VMM behavior. So I'm not really sure what the best
> > > solution is. Sean, any thoughts?
> >
> > Heh, deja vu.  This is essentially the same thing that was fixed by com=
mit
> > fc4fad79fc3d ("KVM: VMX: Reject KVM_RUN if emulation is required with p=
ending
> > exception"), just with a different WARN.
> >
> > This should fix it.  Checking nested_run_pending in handle_invalid_gues=
t_state()
> > is overkill, but it can't possibly do any harm, and the weirdness can b=
e addressed
> > with a comment.
>=20
> Thanks Sean! This works, feel free to add:
>=20
> Tested-by: James Houghton <jthoughton@google.com>
>=20
> I understand this fix as "KVM cannot emulate a nested vm-enter, so if
> emulation is required and we have a pending vm-enter, exit to userspace."
> (This doesn't seem overkill to me... perhaps this explanation is wrong.)

Sort of.  It's a horribly convoluted scenario that's exists only because ea=
rly Intel
CPUs supported a half-baked version of VMX.

Emulation is "required" if and only if guest state is invalid, and VMRESUME=
/VMLAUNCH
VM-Fail (architecturally) if guest state is invalid.  Thus the only way for=
 emulation
to be required when a nested VM-Enter is pending, i.e. after nested VMRESUM=
E/VMLAUNCH
has succeeded but before KVM has entered L2 to complete emulation, is if KV=
M misses a
VM-Fail consistency check, or as is the case here, if userspace stuffs inva=
lid state
while KVM is partway through VMRESUME/VMLAUNCH emulation.

Stuffing state from userspace doesn't put KVM in harm's way, but KVM can't =
emulate
the impossible state, and more importantly, it trips KVM's sanity check tha=
t detects
missed consistency checks.  The KVM_BUG_ON() could also be suppressed by mo=
ving the
nested_run_pending check below the emulation_required checks (see below), b=
ut that
would largely defeat the purpose of the sanity check.

Just out of sight in the below diff is related handling for the case where =
userspace,
or the guest itself via modifying SMRAM before RSM, stuffs bad state.  I.e.=
 it's
the same scenario this syzkaller program hit, minus hitting the nested_run_=
pending=3Dtrue
window.

		/*
		 * Synthesize a triple fault if L2 state is invalid.  In normal
		 * operation, nested VM-Enter rejects any attempt to enter L2
		 * with invalid state.  However, those checks are skipped if
		 * state is being stuffed via RSM or KVM_SET_NESTED_STATE.  If
		 * L2 state is invalid, it means either L1 modified SMRAM state
		 * or userspace provided bad state.  Synthesize TRIPLE_FAULT as
		 * doing so is architecturally allowed in the RSM case, and is
		 * the least awful solution for the userspace case without
		 * risking false positives.
		 */
		if (vmx->emulation_required) {
			nested_vmx_vmexit(vcpu, EXIT_REASON_TRIPLE_FAULT, 0, 0);
			return 1;
		}

The extra wrinkle in all of this is that emulation_required is only ever se=
t if
the vCPU lacks Unrestricted Guest (URG).  All CPUs since Westmere support U=
RG,
while KVM does allow disabling URG via module param, AFAIK syzbot doesn't r=
un in
environments with enable_unrestricted_guest=3D0 (other people do run syzkal=
ler in
such setups, but syzbot does not).

And so the only way guest state to be invalid (for emulation_required to be=
 set),
is if L1 is running L2 with URG disabled.  I.e. KVM _could_ simply run L2, =
but
doing so would violate the VMX architecture from L1's perspective.

static inline bool vmx_guest_state_valid(struct kvm_vcpu *vcpu)
{
	return is_unrestricted_guest(vcpu) || __vmx_guest_state_valid(vcpu);
}

static inline bool is_unrestricted_guest(struct kvm_vcpu *vcpu)
{
	return enable_unrestricted_guest && (!is_guest_mode(vcpu) ||
	    (secondary_exec_controls_get(to_vmx(vcpu)) &
	    SECONDARY_EXEC_UNRESTRICTED_GUEST));
}

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f72835e85b6d..42bee8f2cffb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6492,15 +6492,6 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, =
fastpath_t exit_fastpath)
        if (enable_pml && !is_guest_mode(vcpu))
                vmx_flush_pml_buffer(vcpu);
=20
-       /*
-        * KVM should never reach this point with a pending nested VM-Enter=
.
-        * More specifically, short-circuiting VM-Entry to emulate L2 due t=
o
-        * invalid guest state should never happen as that means KVM knowin=
gly
-        * allowed a nested VM-Enter with an invalid vmcs12.  More below.
-        */
-       if (KVM_BUG_ON(vmx->nested.nested_run_pending, vcpu->kvm))
-               return -EIO;
-
        if (is_guest_mode(vcpu)) {
                /*
                 * PML is never enabled when running L2, bail immediately i=
f a
@@ -6538,10 +6529,16 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu,=
 fastpath_t exit_fastpath)
                        return 1;
                }
=20
+               if (KVM_BUG_ON(vmx->nested.nested_run_pending, vcpu->kvm))
+                       return -EIO;
+
                if (nested_vmx_reflect_vmexit(vcpu))
                        return 1;
        }
=20
+       if (KVM_BUG_ON(vmx->nested.nested_run_pending, vcpu->kvm))
+               return -EIO;
+
        /* If guest state is invalid, start emulating.  L2 is handled above=
. */
        if (vmx->emulation_required)
                return handle_invalid_guest_state(vcpu);


