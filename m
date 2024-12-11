Return-Path: <linux-kernel+bounces-440908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A39EC648
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F21166018
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4521C5CD6;
	Wed, 11 Dec 2024 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="D5ozumfP"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F701C5F03
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904045; cv=none; b=NxOUZa/3P43F+ofn1jL4n6zOm/LNKWzm7RNPdkfAyPogf+z8ZivbZankyA8QKppXoDnl6M4zyqdCOaPx60oo7v0Jsqfz7c6KdLm4W+3PA8vHHN5PD8n4pbupGJ+5eXQ9dhUYPvaQRFe8J0F3kYGyHP/tuS1kbDX7n630kz4k6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904045; c=relaxed/simple;
	bh=tbaXJkYg2VExW7HYxQytNUpKVfqkWC6/74C2FG8mxxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zce7uknpR/D7dVcVBlUGCz+DFffPxOBTiD+dwWFS83y2c+ZmUGXgH3pkh4JEYcKTiCax9nH3xwuqrDyOUmR3zi3nS5F5nnkgLQ+iTkHA7dQ5J+BTOhn5eAJj37HcL1bmiWoWMyb2J8YDcLhns9TzKyb64Yiet7/LXj+ANFIb/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org; spf=pass smtp.mailfrom=atishpatra.org; dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b=D5ozumfP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30229d5b21cso22243241fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1733904040; x=1734508840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrdQyx+9sJgMOUwBwVMN1glWXum3hUhQnd/9M2jQnTU=;
        b=D5ozumfPp4Or9enlQ7oxVH+iM3YdyZs5oDXfDGsl8YRrozClicT+I08VhRWGA5IZcG
         zlbiP+wbx2Lr47hsdYnG1/kfQ5QqRJi7XMm67pkHhVWQIUU2p13R2Og48cH/kCYAGwdQ
         v1O6IW42nMS6HhlYm1Rds6/vGr0AiS+SjSbxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904041; x=1734508841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NrdQyx+9sJgMOUwBwVMN1glWXum3hUhQnd/9M2jQnTU=;
        b=mgtlGtLdjXAKoIkQWYPVxb6u2eNpprLJYGFNxLlw9AfMDwTAZOWicmNZl2JcNoUV5k
         /4ZG1LML09aY5N0WhhS8LTnpIO+9vxOciLJOm/fV2iV7gEDgrW3YrhHZnVAihcXCxHGe
         eYZ6swmO9heZf+UYVrNx+OvroFsg9zjHU3b7Y2RQuZv8L8m7zX3GpJUUpFb1rCwFEOwb
         WcII8ntr0Aeabwl3GmY+iSeW/IAWEtCgaVBLn99WA3ABOOr5+y6M5cmxERK2qcId0m/A
         NCUgkKCkLORYpKyRZi6Oy+OAgI6bsw4Y60PNVKiFjREU9avtGWjNFgaOuTy+Mos8qsoz
         gUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbFY3cO5HBaRoYidrZKxjgSpf7em0KqzCmMHyFWcMYVYZoFDIoAq32bI+eDcw8WgTX9jQD/+IQAiUrTe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQExKQEiTB3ftH7b8BGfTDw/xdT+16Flgh8nwFTboHw4p4Snn
	bE7JU3kQgV6JEJjFzYCbWku95wg8UMjAjPsMHDDcH/hMwQByPiP2KpM5KvFMYG9gQ53lh4r+R+/
	t3k1G5dqBkQ2M7Skn8JsaV8raOWRchttYW5Dv
X-Gm-Gg: ASbGncut1FDcPkNVUb9qDPhCMyYo6WjmccY/WGe0KSM8BbhibBKYbTI+3nVg8tk6nC8
	D/FPisq7MLOsH1zrGnm45SbzMpP9anOu3
X-Google-Smtp-Source: AGHT+IEhXnfeK6yO+W2v4MmlALgxJLxT2l4+DlzKO1Sr/OCd9GCNnNzwop5M3W30nNLemrP0ZOnN3mjY5YVh2yw5dBo=
X-Received: by 2002:a05:6512:1110:b0:53e:3729:eaec with SMTP id
 2adb3069b0e04-5402a5dad39mr512830e87.22.1733904040239; Wed, 11 Dec 2024
 00:00:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83c2234d582b7e823ce9ac9b73a6bbcf63971a29.1724911120.git.zhouquan@iscas.ac.cn>
 <b5128162-278a-4284-8271-b2b91dc446e1@iscas.ac.cn> <380f4da9-50e9-4632-bdc8-b1723eb19ca5@sifive.com>
 <CAAhSdy1zSTWuTW1KohUDXr9UXUx-QL1A30AUkTGoL7W2L7JWLQ@mail.gmail.com> <d161a6ea-6975-4427-8de8-93d4ee9e80fb@sifive.com>
In-Reply-To: <d161a6ea-6975-4427-8de8-93d4ee9e80fb@sifive.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Wed, 11 Dec 2024 00:00:28 -0800
Message-ID: <CAOnJCUJr8_EWrtU_9i1U+6KRNRhqyt__sS5J5Q+vueOfchNM2w@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Redirect instruction access fault trap to guest
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Quan Zhou <zhouquan@iscas.ac.cn>, ajones@ventanamicro.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 9:39=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2024-09-12 11:32 PM, Anup Patel wrote:
> > On Fri, Sep 13, 2024 at 6:09=E2=80=AFAM Samuel Holland
> > <samuel.holland@sifive.com> wrote:
> >>
> >> On 2024-09-12 4:03 AM, Quan Zhou wrote:
> >>>
> >>> On 2024/8/29 14:20, zhouquan@iscas.ac.cn wrote:
> >>>> From: Quan Zhou <zhouquan@iscas.ac.cn>
> >>>>
> >>>> The M-mode redirects an unhandled instruction access
> >>>> fault trap back to S-mode when not delegating it to
> >>>> VS-mode(hedeleg). However, KVM running in HS-mode
> >>>> terminates the VS-mode software when back from M-mode.
> >>>>
> >>>> The KVM should redirect the trap back to VS-mode, and
> >>>> let VS-mode trap handler decide the next step.
> >>>>
> >>>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> >>>> ---
> >>>>   arch/riscv/kvm/vcpu_exit.c | 1 +
> >>>>   1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> >>>> index fa98e5c024b2..696b62850d0b 100644
> >>>> --- a/arch/riscv/kvm/vcpu_exit.c
> >>>> +++ b/arch/riscv/kvm/vcpu_exit.c
> >>>> @@ -182,6 +182,7 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, s=
truct
> >>>> kvm_run *run,
> >>>>       ret =3D -EFAULT;
> >>>>       run->exit_reason =3D KVM_EXIT_UNKNOWN;
> >>>>       switch (trap->scause) {
> >>>> +    case EXC_INST_ACCESS:
> >>>
> >>> A gentle ping, the instruction access fault should be redirected to
> >>> VS-mode for handling, is my understanding correct?
> >>
> >> Yes, this looks correct. However, I believe it would be equivalent (an=
d more
> >> efficient) to add EXC_INST_ACCESS to KVM_HEDELEG_DEFAULT in asm/kvm_ho=
st.h.
> >>
> >> I don't understand why some exceptions are delegated with hedeleg and =
others are
> >> caught and redirected here with no further processing. Maybe someone t=
hought
> >> that it wasn't valid to set a bit in hedeleg if the corresponding bit =
was
> >> cleared in medeleg? But this doesn't make sense, as S-mode cannot know=
 which
> >> bits are set in medeleg (maybe none are!).
> >>
> >> So the hypervisor must either:
> >>  1) assume M-mode firmware checks hedeleg and redirects exceptions to =
VS-mode
> >>     regardless of medeleg, in which case all four of these exceptions =
can be
> >>     moved to KVM_HEDELEG_DEFAULT and removed from this switch statemen=
t, or
> >>
> >>  2) assume M-mode might not check hedeleg and redirect exceptions to V=
S-mode,
> >>     and since no bits are guaranteed to be set in medeleg, any bit set=
 in
> >>     hedeleg must _also_ be handled in the switch case here.
> >>
> >> Anup, Atish, thoughts?
> >
> > Any exception delegated to VS-mode via hedeleg means it is directly del=
ivered
> > to VS-mode without any intervention of HS-mode. This aligns with the RI=
SC-V
> > priv specification and there is no alternate semantics assumed by KVM R=
ISC-V.
> >
> > At the moment, for KVM RISC-V we are converging towards the following
> > approach:
> >
> > 1) Only delegate "supervisor expected" traps to VS-mode via hedeleg
> > which supervisor software is generally expected to directly handle such
> > as breakpoint, user syscall, inst page fault, load page fault, and stor=
e
> > page fault.
> >
> > 2) Other "supervisor unexpected" traps are redirected to VS-mode via
> > software in HS-mode because these are not typically expected by supervi=
sor
> > software and KVM RISC-V should at least gather some stats for such trap=
s.
>
> Can you point me to where we collect stats for these traps? I don't see a=
ny code
> in kvm_riscv_vcpu_exit() that does this.
>

It doesn't exist today. But we should add it for debug purposes IMO.

> > Previously, we were redirecting such unexpect traps to KVM user space
> > where the KVM user space tool will simply dump the VCPU state and kill
> > the Guest/VM.
>
> Currently we have 5 exception types that go through software in HS-mode b=
ut
> never kill the guest: EXC_INST_ILLEGAL, EXC_LOAD_MISALIGNED,
> EXC_STORE_MISALIGNED, EXC_LOAD_ACCESS, and EXC_STORE_ACCESS. Are those
> considered "expected" or "unexpected"?
>
> > The inst misaligned trap was historically always set in hedeleg but we
> > should update it based on the above approach.
>
> What are the criteria for determining if a trap is "supervisor expected" =
or
> "supervisor unexpected"? Certainly any trap that can be triggered by misb=
ehaved
> software in VU-mode should not kill the guest. Similarly, any trap that c=
an be
> triggered by a misbehaved nested VS-mode guest should not kill the outer =
guest
> either.
>
> So the only reason I see for not delegating them is to collect stats, but=
 I
> wonder if that is worth the performance cost. I would rather make misalig=
ned
> loads/stores (for example) faster in the guest than have a count of them =
at the
> hypervisor level.
>

These are not in a hot path where updating a stats counter will affect
the performance.
I think we should use both kvm stats (for monitoring from the host)
and SBI PMU firmware counters (for monitoring within the guest)
which will help both guest and the host performance bottlenecks.

I will send a patch.

> Regards,
> Samuel
>


--=20
Regards,
Atish

