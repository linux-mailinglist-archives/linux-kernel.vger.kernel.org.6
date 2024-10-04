Return-Path: <linux-kernel+bounces-349887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE20D98FCB6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C621B22600
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110E3D982;
	Fri,  4 Oct 2024 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a4Z1ToyV"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1E3139E
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 04:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728015617; cv=none; b=KS2FrdCTVt//7OsMpr9kT4HTrboEbSvmm6ZpfdXdgbPqKcY/OwucVY2R6NyWSlqBJKzlLthYWHxBLrM/zKszj/UQBo87zCxQSy5FBPXPu+tF3+pZ9F9vxTTorw1fa3UN/IXvNGnMWGoc7/V0pOXUjsTfHi1PX/bnFxmsxibvMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728015617; c=relaxed/simple;
	bh=EPerfQLBTzpoZ0CyvXOBDt2VSVBYdLTxEBe/Oiaer/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gr8PL1z2ZB5mgW4CFjy1PpYHHGlWXHaqfvOVG4EevdjdQ4c0mgqQZb5jS6m9bjBE238dzpsiQBHpt/2mXpn/GSqSPPktw3i255K+SsH+kD7eH/IzF8b8+RMAW1ZBpeLZESzS863stC8P1Ne1qSIRgwwMlbInJTY/n9tod+0OKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a4Z1ToyV; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2876025c7b1so53477fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 21:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728015614; x=1728620414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9D6a3sjkcgkIB7stodJ55CiLUsQO/kpb3sBj9c0NCvU=;
        b=a4Z1ToyV8KZoQEj1oLvDDwZAtB0YT4W9CwkIOcLkt6USwtpXOS1bLkg3aXxsjVfvCO
         7xtdYisdctFXnJ5T/V+cO2uHdJd7dv9llV9XVeEJninhlvLTMmhcOVZY6xD77KsW4xBb
         uDkRO7Om8ulGdqor2LXhiiQAzSvpL7Ek2MFd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728015614; x=1728620414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9D6a3sjkcgkIB7stodJ55CiLUsQO/kpb3sBj9c0NCvU=;
        b=bZf0Q/hv1fF5Tk474iTE5cXTBP09Ag+1BsUHcFWPbtUnj54jZro4mZU1t8O4fZpU1d
         bhoU2iEl0MfrUCizx+uZ2gyd8Cb2dnIcFa2a/YU7yMu0hIoAkvF8UlKO0SqOgquj4mLz
         2S50b8gMYxnHnhhZqf4GlIpcIYJmE+gnUexiI39JFIY9LmIsrBJ1b2p6nxVmWBgu9+1h
         6CEV1zxRzsXJvRUjo0bfFQD90suMf4GpCfLrf16GKpPsd6Ak08HEpFYAru8CQiDvhQJW
         i0tWuMm/zW87bm8yh0zsRwFK4UWEajebs2iYmQhVFB5F7Z2YwHQI1xEtq6tNeR4YU1DV
         +5rA==
X-Gm-Message-State: AOJu0Yy281DQ1Pt42wcZnDSohmj9qIoPKmFhZs8vPaxEjI5ODyHnfYCS
	W84QRjlYGFgmXN+RcvRmWsxpzpI9STopsLfPeT06bRtRXbAamlEtIUu7rAlKMJfgBhL8sO8POAh
	PmN/Y+4h5AYQStJac/4/gx5jWfjlwmm7ti53N
X-Google-Smtp-Source: AGHT+IH8SmjSEXOSyI1LK1xSB5a+42f9VjYQMxJbHcL7+k2zMTyV6ZhyWGSnSIcxRw+nD46Z5BgGJbXgnWutgcyIF0s=
X-Received: by 2002:a05:6870:b28f:b0:27b:9f8b:277c with SMTP id
 586e51a60fabf-287c2007b9dmr321825fac.11.1728015614440; Thu, 03 Oct 2024
 21:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com>
 <20240802061318.2140081-4-aruna.ramakrishna@oracle.com> <CABi2SkV6AfxDNnuSKr_PCydZSyvKSmzmEeMnAXw3w1=w-kz7ow@mail.gmail.com>
 <CABi2SkWjF2Sicrr71=a6H8XJyf9q9L_Nd5FPp0CJ2mvB46Rrrg@mail.gmail.com> <EA166994-BD63-4147-9904-7189F5135149@oracle.com>
In-Reply-To: <EA166994-BD63-4147-9904-7189F5135149@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 3 Oct 2024 21:20:01 -0700
Message-ID: <CABi2SkUR5U0e3i9PzVQWRu0G8Vbu+9c8TFSyuC+cO7OsgaSwCg@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] x86/pkeys: Update PKRU to enable all pkeys before XSAVE
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Keith Lucas <keith.lucas@oracle.com>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aruna

On Thu, Oct 3, 2024 at 4:29=E2=80=AFPM Aruna Ramakrishna
<aruna.ramakrishna@oracle.com> wrote:
>
>
>
> > On Aug 26, 2024, at 5:53=E2=80=AFPM, Jeff Xu <jeffxu@chromium.org> wrot=
e:
> >
> > Hi Aruna
> >
> > On Fri, Aug 9, 2024 at 10:30=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> w=
rote:
> >>
> >> On Thu, Aug 1, 2024 at 11:13=E2=80=AFPM Aruna Ramakrishna
> >> <aruna.ramakrishna@oracle.com> wrote:
> >>>
> >>> If the alternate signal stack is protected by a different pkey than t=
he
> >>> current execution stack, copying xsave data to the sigaltstack will f=
ail
> >>> if its pkey is not enabled in the PKRU register.
> >>>
> >>> We do not know which pkey was used by the application for the altstac=
k,
> >>> so enable all pkeys before xsave.
> >>>
> >>> But this updated PKRU value is also pushed onto the sigframe, which
> >>> means the register value restored from sigcontext will be different f=
rom
> >>> the user-defined one, which is unexpected. Fix that by overwriting th=
e
> >>> PKRU value on the sigframe with the original, user-defined PKRU.
> >>>
> >>> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> >>> ---
> >>> arch/x86/kernel/fpu/signal.c | 11 +++++++++--
> >>> arch/x86/kernel/signal.c     | 12 ++++++++++--
> >>> 2 files changed, 19 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signa=
l.c
> >>> index 931c5469d7f3..1065ab995305 100644
> >>> --- a/arch/x86/kernel/fpu/signal.c
> >>> +++ b/arch/x86/kernel/fpu/signal.c
> >>> @@ -168,8 +168,15 @@ static inline bool save_xstate_epilog(void __use=
r *buf, int ia32_frame,
> >>>
> >>> static inline int copy_fpregs_to_sigframe(struct xregs_state __user *=
buf, u32 pkru)
> >>> {
> >>> -       if (use_xsave())
> >>> -               return xsave_to_user_sigframe(buf);
> >>> +       int err =3D 0;
> >>> +
> >>> +       if (use_xsave()) {
> >>> +               err =3D xsave_to_user_sigframe(buf);
> >>> +               if (!err)
> >>> +                       err =3D update_pkru_in_sigframe(buf, pkru);
> >>> +               return err;
> >>> +       }
> >>> +
> >>>        if (use_fxsr())
> >>>                return fxsave_to_user_sigframe((struct fxregs_state __=
user *) buf);
> >>>        else
> >>> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> >>> index 9dc77ad03a0e..5f441039b572 100644
> >>> --- a/arch/x86/kernel/signal.c
> >>> +++ b/arch/x86/kernel/signal.c
> >>> @@ -102,7 +102,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs=
 *regs, size_t frame_size,
> >>>        unsigned long math_size =3D 0;
> >>>        unsigned long sp =3D regs->sp;
> >>>        unsigned long buf_fx =3D 0;
> >>> -       u32 pkru =3D read_pkru();
> >>> +       u32 pkru;
> >>>
> >>>        /* redzone */
> >>>        if (!ia32_frame)
> >>> @@ -157,9 +157,17 @@ get_sigframe(struct ksignal *ksig, struct pt_reg=
s *regs, size_t frame_size,
> >>>                return (void __user *)-1L;
> >>>        }
> >>>
> >>> +       /* Update PKRU to enable access to the alternate signal stack=
. */
> >>> +       pkru =3D sig_prepare_pkru();
> >> I think, the better place to call sig_prepare_pkru() at begging of the
> >> get_sigframe:
> >>
> >> get_sigframe()
> >> {
> >>   /* ... */
> >>    if (ka->sa.sa_flags & SA_ONSTACK) {
> >>         if (sas_ss_flags(sp) =3D=3D 0) {
> >>                // set pkru =3D 0 <--- set pkru =3D 0 here.
> >>                entering_altstack =3D true;
> >>         }
> >> }
> >> For two reasons:
> >> - We probably don't want all signaling handling going through "PKRU=3D=
0"
> >> , this includes the regular stack and nested signaling handling. The
> >> best place is when "entering the altstack". IIUC, this feature only
> >> enabled when sigaltstack() is used.
> >> - The thread might not have read-access to the altstack, so we will
> >> want to make sure that pkru=3D0 is set before any read to the altstack=
.
> >> And IIRC,  fpu__alloc_mathframe needs read-access to the altstack.
> >> To help with testing, I will send a test case to demo the usage.
> > Apologies, I remembered it wrong, the fpu__alloc_mathframe doesn't
> > need read-access to altstack.
> >
> > But I think the best place to set pkru=3D0 is still when the stack
> > entering altstack, as shown above. the reason is: The signal stack can
> > be nested, i.e. trigger another signaling inside signal handler and we
> > don't need to set pkru=3D0 multiple times (only the first time enter
> > sigaltstack)
> >
> >> (please give me sometime to organize the test code, I'm hoping to send
> >> out before the end of next week)
> >>
> > the test code is placed at [1]
> > [1] https://github.com/peaktocreek/pkeytest
> >
> >> Also, could you please consider adding a new flag SS_PKEYALTSTACK (see
> >> SS_AUTODISARM for example). Most existing apps that use sigaltstack()
> >> don't use PKEY and  don't care about setting PKRU=3D0, and don't need =
to
> >> overwrite the sig frame after XSAVE.  The flag will limit the impact
> >> of this patch.
> >>
> > Thanks
> > -Jeff
> >
>
> Hi Jeff,
>
> I apologize for the delay in my response. I haven=E2=80=99t had a chance =
to optimize
> this patchset or try new test cases.
>
Not a problem, I understand.

> I agree with your first suggestion that we can set pkru to 0 only when
> entering_altstack =3D true, as that is the intention of this flow anyway.
>
> I=E2=80=99m not so sure if SS_PKEYALTSTACK is really necessary - theoreti=
cally it seems
> logical to not do this for applications that do not use pkeys but use alt=
stack, but
> it adds extra code/checks for possibly insignificant performance gain. I =
have not
> tested this yet.
>
One of the reasons that I'm thinking about is that signaling handling
has real-time requirements for some real-time systems, and applying
PKRU=3D0 without checking will increase cost to those systems and might
be viewed as a regression.

Thanks
-Jeff

> I=E2=80=99ll try to retest and send out a new patchset on top of the prev=
ious ones that have
> been merged to 6.12.
>
> Thank you for your feedback, and your attention to detail - I appreciate =
it.
>
> Thanks,
> Aruna
>
>

