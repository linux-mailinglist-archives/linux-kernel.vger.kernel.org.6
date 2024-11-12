Return-Path: <linux-kernel+bounces-406157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098429C5FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765D0B26A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F881FF050;
	Tue, 12 Nov 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zcyyV+WB"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93FF1FEFA8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424342; cv=none; b=VTUTm2EWU3z/bvWHa0w+xKnIfQNpVgpxOLBp+Da4pfYh91E9S43uMlijUuoGO56daYGfkvmVqwUYgfpJbawRmmmZNQ+C11GRnoV9BiznIt6QMsrGrvzDmc9d5maVMomWbghtiO2zSS8EZT5xp8GCnU4reQ85A9xl9UwK2NT/iBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424342; c=relaxed/simple;
	bh=9wF6tTg205YmPGn3VOm3qDqUJhPIhge8PfjW0tNtfVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3IxS4XVqjf+HxeVHsr+vMjYgon2Qs9P1LJczdJUHN+nPWO+T5NRMFgFOrVPnqSF7gvwtaKbXoi1xwYVOYNYtEhFQs8Mlo8dTXwWFOskvIyWMqDWm1hRxbmQai6RYqr+ke5C4wJSjv3qpbGD35Zlneliitq6H7SlfXRGoRkMEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zcyyV+WB; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315ee633dcso126225e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731424339; x=1732029139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AZJf54hz7xE0bBIr2JsyytkNQasf60PHx9P3JAB4nkQ=;
        b=zcyyV+WBZRSC0MhAF4iNVaMXySEamo/44ap1RPcS60Tw9P2Nw0kUM1D8nCRXomkytH
         3X4D2WY5m5OVglLY941b24nrGAe7BE0rdbk/6DmKmf3LURPp8nerTUk61o7E8uDhgxUw
         9W05Rw5Tu0xIr3abtAhIMeJURQa+M0lAE4OWIRRemwUxLbrv3YGMjNvb3DfTZdSslWHf
         Hmrw4lIM05njsglITuLNOSDm37xxn6uCGcrI7tkGE/JVHunnJDNXNYfY5UJQTyBtSaVL
         OuGfNUar68wb2LKcpH8t3IoffILMr3H6lN5Qb0lCsO8uT/siyHuvHxum+7MvWDV57Qgj
         RTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731424339; x=1732029139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZJf54hz7xE0bBIr2JsyytkNQasf60PHx9P3JAB4nkQ=;
        b=e9mxj6GD68kTRAc3zkAD3RbYtwcU15KyibbIA4UEvNJfUVcdUJlpwQpVjhvEqsb/6h
         MplpXG3mzvAkuZzahzAsXQUJy5oYh6QI9CvrlFACRXIaI6CmgVvPzMZFGPQeSjIFAemj
         SESdFsNy0Sf8tH1DmUQ/x3p0r6rHR8kSGRjnSsOxP7Kcueuz2Lynuy7S8ua3edKUGpAK
         +h3S53ttgPxJNjwylYgpeUIqowyNrj0jReriJUsmniclxqo+4ncF8PEFjEfZSN/aIsPT
         IrIYk+jd/y1/wtm30C00CCk5ql3UT0L9JrJyLo2TIK+eJRgqcZwfrM5deuOyinQLvOqB
         hMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkIbz917pIP3/FcbXk4+Xr4BuFwPF+fD6dXHRfDQC5HEqLn61BHpgzoo5/0sBefgR7JspBZJG3Tl44qDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVGxsh4QQ+A4P+WR8FK71DFMvSX8fCzu2mwGcXMSNHg9H7qvVX
	+xYVlq0H3T2iIPCuOQNTMz9uzQRnCQG9+G+J/EGSZL6YKoW4FsTMYEk0y6PvyX3jeZbfmZHQzm4
	qLY2wCuHzErz6u4k3eo33kZdUYsiYBWRp6m8P/ORMQeCl52p1xA==
X-Gm-Gg: ASbGnctJIyG+m9Bh/k8aRn37qu58y7m3V/5q+pMfG1BK8QcQYS0sRRhbGzMx00kEcK6
	xc024T1IDL3j71dHMHeI6oXhYlF0TAkbHGntdpbv6tgzcm6vWfUd8Mazr4ZEo
X-Google-Smtp-Source: AGHT+IFh1KG/4r/Jpj1n/ObwJscWvvtlsw0RsVTQkd1D68bpc9mkzBX4Z2VDq640KrO3IpXCu88faLISFm3MEsJl7tM=
X-Received: by 2002:a05:600c:1395:b0:431:43a1:4cac with SMTP id
 5b1f17b1804b1-432cf0fbec4mr2190145e9.3.1731424338902; Tue, 12 Nov 2024
 07:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112105032.793274-1-james.clark@linaro.org> <875xosts24.wl-maz@kernel.org>
In-Reply-To: <875xosts24.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 12 Nov 2024 15:11:42 +0000
Message-ID: <CA+EHjTyqunj19TLcaSp5DacRNWDsh-OpdRjpFOJfp0t8CBGEUw@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Don't save FP traps in default cptr_el2 value
To: Marc Zyngier <maz@kernel.org>
Cc: James Clark <james.clark@linaro.org>, broonie@kernel.org, kvmarm@lists.linux.dev, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc and James,

On Tue, 12 Nov 2024 at 15:01, Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 12 Nov 2024 10:50:31 +0000,
> James Clark <james.clark@linaro.org> wrote:
> >
> > kvm_get_reset_cptr_el2() is called at vcpu init before the vcpu is
> > loaded. Since the linked commit, the fp state was moved from the vcpu to
> > host data but it shouldn't be accessed at this point.
> >
> > Move the bits that require guest_owns_fp_regs() out of the default value
> > and into just before they're used in activate and deactivate traps. This
> > fixes the following bug when nvhe && vcpu_has_sve() == true:
> >
> >  BUG: using smp_processor_id() in preemptible [00000000] code: lkvm/118
> >  caller is debug_smp_processor_id+0x20/0x30
> >  CPU: 0 UID: 0 PID: 118 Comm: lkvm Not tainted 6.12.0-rc1+ #35
> >  Hardware name: FVP Base RevC (DT)
> >  Call trace:
> >   dump_backtrace+0xfc/0x120
> >   show_stack+0x24/0x38
> >   dump_stack_lvl+0x3c/0x98
> >   dump_stack+0x18/0x28
> >   check_preemption_disabled+0xe0/0xe8
> >   debug_smp_processor_id+0x20/0x30
> >   guest_owns_fp_regs+0x1c/0xb0
> >   kvm_arch_vcpu_ioctl+0xcfc/0xe10
> >   kvm_vcpu_ioctl+0x6c4/0x8a0
> >   __arm64_sys_ioctl+0x9c/0xe0
> >   invoke_syscall+0x4c/0x110
> >   el0_svc_common+0xb8/0xf0
> >   do_el0_svc+0x28/0x40
> >   el0_svc+0x4c/0xc0
> >   el0t_64_sync_handler+0x84/0x100
> >   el0t_64_sync+0x190/0x198
> >
> > Fixes: 5294afdbf45a ("KVM: arm64: Exclude FP ownership from kvm_vcpu_arch")
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> >
> > I'm only mildly confident that the logic here is equivalent to before.
> > Someone with a bit more context about the FP stuff can say, or if there
> > is a neater way to fix this issue altogether.
> >
> >  arch/arm64/include/asm/kvm_emulate.h | 15 +++++++++------
> >  arch/arm64/kvm/hyp/nvhe/switch.c     |  3 ++-
> >  2 files changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > index cf811009a33c..0eefb9fb08a0 100644
> > --- a/arch/arm64/include/asm/kvm_emulate.h
> > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > @@ -629,16 +629,12 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
> >                       val |= CPACR_EL1_SMEN_EL1EN;
> >       } else if (has_hvhe()) {
> >               val = CPACR_ELx_FPEN;
> > -
> > -             if (!vcpu_has_sve(vcpu) || !guest_owns_fp_regs())
> > +             if (!vcpu_has_sve(vcpu))
> >                       val |= CPACR_ELx_ZEN;
> >               if (cpus_have_final_cap(ARM64_SME))
> >                       val |= CPACR_ELx_SMEN;
> >       } else {
> >               val = CPTR_NVHE_EL2_RES1;
> > -
> > -             if (vcpu_has_sve(vcpu) && guest_owns_fp_regs())
> > -                     val |= CPTR_EL2_TZ;
> >               if (cpus_have_final_cap(ARM64_SME))
> >                       val &= ~CPTR_EL2_TSM;
> >       }
> > @@ -648,8 +644,15 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
> >
> >  static __always_inline void kvm_reset_cptr_el2(struct kvm_vcpu *vcpu)
> >  {
> > -     u64 val = kvm_get_reset_cptr_el2(vcpu);
> > +     u64 val = vcpu->arch.cptr_el2;
> >
> > +     if (has_hvhe()) {
> > +             if (!guest_owns_fp_regs())
> > +                     val |= CPACR_ELx_ZEN;
> > +     } else if (!has_vhe()) {
> > +             if (vcpu_has_sve(vcpu) && guest_owns_fp_regs())
> > +                     val |= CPTR_EL2_TZ;
> > +     }
> >       kvm_write_cptr_el2(val);
> >  }
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> > index cc69106734ca..296c4155e1fc 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> > @@ -60,7 +60,8 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
> >                       val |= CPTR_EL2_TFP | CPTR_EL2_TZ;
> >
> >               __activate_traps_fpsimd32(vcpu);
> > -     }
> > +     } else if (!has_hvhe() && vcpu_has_sve(vcpu))
> > +             val |= CPTR_EL2_TZ;
> >
> >       kvm_write_cptr_el2(val);
> >       write_sysreg(__this_cpu_read(kvm_hyp_vector), vbar_el2);
>
> I think this is papering over the real issue, which is that we
> conflate reset value for the host and what is required for the guest
> to run.
>
> CPTR_EL2 is state-dependent, as you found out. And that really only
> means one single thing: it cannot be initialised outside of the vcpu
> being either loaded or run, both of which require being in a
> non-preemptible section.
>
> There is also another thing: VHE rebuilds the guest's CPTR_EL2 view
> from scratch, while the nVHE takes the saved state, mutates it in
> funny ways before applying it, and pKVM does all sorts of interesting
> manipulations before hitting the nVHE code.
>
> What I would really like to see is:
>
> - when entering the guest, we recompute the run-time value of CPTR_EL2
>   from scratch, just like VHE does.
>
> - when exiting the guest, we reset the value using the current helper,
>   which takes the guest state into account.
>
> - pKVM should be converted to using the plain nVHE code.
>
> - vcpu->arch.cptr_el2 should be killed.
>
> I think Fuad has already started on some of that. Fuad, do you mind
> adding that to your current rework and post something shortly?

Yes, this is a bit of a mess currently. I've been reworking it as part
of the work on pKVM. I'll post something shortly that will make it
more inline with how VHE handles this.

Cheers,
/fuad

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

