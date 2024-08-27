Return-Path: <linux-kernel+bounces-302416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D07A95FE17
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3F91C21C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBB646B5;
	Tue, 27 Aug 2024 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JPYxw15E"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C9138C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724720014; cv=none; b=VTVcnHMt2Pdwlfia9tXVU33RfFdYtbTBBUL7cJkWPVAr0ye5b6iyAKHzxek5o3SFcfS/V1jEa4XPCDnGmJuunJqO7pxxSjqyZt+Io5K+tlF+ZdG5yIPQZg5Jp7bvUqvW2uLp3HrUd9EEDxwVQasWVUju0YzLYZZ0Pc4WMcqs4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724720014; c=relaxed/simple;
	bh=zCO4VxXMqNH5LwQi9OXxddbNVR8XJylDn44lxUx/tn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APlBb+H/sgcB9KT1Dt22+wZyu19BfQTUlY0AOhp87wW2xXoQ8tFjIO2gEq5M22svF1IMrc9Kp3nP/XtIFdDxhCNxMiQ0uljVxJgcbRqCnHhg9oxHi/9guUXFC0qV+JUJWYuAG+or7tYv/S3OkMquN8VOzSJU93ae/RYaWb4JOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JPYxw15E; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-26456710cfdso770290fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724720012; x=1725324812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtuOQCHwx5HUQnS2vsYtjI8UWrxeqwGLR2irtHbOiFE=;
        b=JPYxw15EC8Zxl9/SWB1UImEBye5N819PZ3Z0IsGx7AIs6m4+ipsyOBsY6ruzeeF4HF
         fTMu3Jd2wXcRGWp0JIhViSdbn5tZp6dhNwQQyhIQM3ZzROvjdaKClrppHcc8COwX/DU/
         WWZ12nrM/e8eRf34ShXz2YLL7pqrc8X8z68Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724720012; x=1725324812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtuOQCHwx5HUQnS2vsYtjI8UWrxeqwGLR2irtHbOiFE=;
        b=HROXjCHyVzyQoR4OhJpF08SeiT2UJLMh6WGebL4QPK9dXfvRt568XQtGkir8QfQEEW
         /WhnREQpvuXO3z9+dxL5+AeFfc6Gvi9HFRWg/85ak2R+MeDwOqns4CfyofTewDUcXDSL
         4m1iRT9vWuLBQpUKxFysJA7yKEED3SvAQMldVQVUJYMF8gOGTOaBF+3F7T1OYVrxodaN
         /+6kwB23F+l7AaYUG8Md+IdgDJ4KHQp5SJwPrn5DZ3qj/6kgzsbtevkHK59aXBAaJ1Wo
         yt2IlyfyVfwJCpjnnj6+w3H2BKq6Xf/sv6yx5b4MDcWVzoJ7625U0xY6l7lFj+BAU1/4
         Celg==
X-Gm-Message-State: AOJu0YydOi142LQCqlfsRSBcy4zIQ15FC7+G6LQgOV5MAe6WUishpfz4
	kLBYoYiJTiaGgw/N5RcIZshrCm+Lsf2Gefl4vyNs34W/ns5bZ4+8uvmhIRfR/x5qyr8V/584HfW
	dOq8ao7J0lJ4FmjrZnJfmA1Vxxw7HjDvNqEdA
X-Google-Smtp-Source: AGHT+IEjCRa2q7PaKLyDpYx4ZA2zAuxQsjSc/D1uBOV536GrWwHdxkCRk9mOnCaKJd26BZOB4gIxB8tNLpiPp5eibo0=
X-Received: by 2002:a05:6871:691:b0:260:f1c4:2fe3 with SMTP id
 586e51a60fabf-273e6792bf4mr6456010fac.10.1724720011644; Mon, 26 Aug 2024
 17:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com>
 <20240802061318.2140081-4-aruna.ramakrishna@oracle.com> <CABi2SkV6AfxDNnuSKr_PCydZSyvKSmzmEeMnAXw3w1=w-kz7ow@mail.gmail.com>
In-Reply-To: <CABi2SkV6AfxDNnuSKr_PCydZSyvKSmzmEeMnAXw3w1=w-kz7ow@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 26 Aug 2024 17:53:19 -0700
Message-ID: <CABi2SkWjF2Sicrr71=a6H8XJyf9q9L_Nd5FPp0CJ2mvB46Rrrg@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] x86/pkeys: Update PKRU to enable all pkeys before XSAVE
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, 
	tglx@linutronix.de, mingo@kernel.org, linux-mm@kvack.org, 
	keith.lucas@oracle.com, rick.p.edgecombe@intel.com, jorgelo@chromium.org, 
	keescook@chromium.org, sroettger@google.com, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aruna

On Fri, Aug 9, 2024 at 10:30=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Thu, Aug 1, 2024 at 11:13=E2=80=AFPM Aruna Ramakrishna
> <aruna.ramakrishna@oracle.com> wrote:
> >
> > If the alternate signal stack is protected by a different pkey than the
> > current execution stack, copying xsave data to the sigaltstack will fai=
l
> > if its pkey is not enabled in the PKRU register.
> >
> > We do not know which pkey was used by the application for the altstack,
> > so enable all pkeys before xsave.
> >
> > But this updated PKRU value is also pushed onto the sigframe, which
> > means the register value restored from sigcontext will be different fro=
m
> > the user-defined one, which is unexpected. Fix that by overwriting the
> > PKRU value on the sigframe with the original, user-defined PKRU.
> >
> > Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> > ---
> >  arch/x86/kernel/fpu/signal.c | 11 +++++++++--
> >  arch/x86/kernel/signal.c     | 12 ++++++++++--
> >  2 files changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.=
c
> > index 931c5469d7f3..1065ab995305 100644
> > --- a/arch/x86/kernel/fpu/signal.c
> > +++ b/arch/x86/kernel/fpu/signal.c
> > @@ -168,8 +168,15 @@ static inline bool save_xstate_epilog(void __user =
*buf, int ia32_frame,
> >
> >  static inline int copy_fpregs_to_sigframe(struct xregs_state __user *b=
uf, u32 pkru)
> >  {
> > -       if (use_xsave())
> > -               return xsave_to_user_sigframe(buf);
> > +       int err =3D 0;
> > +
> > +       if (use_xsave()) {
> > +               err =3D xsave_to_user_sigframe(buf);
> > +               if (!err)
> > +                       err =3D update_pkru_in_sigframe(buf, pkru);
> > +               return err;
> > +       }
> > +
> >         if (use_fxsr())
> >                 return fxsave_to_user_sigframe((struct fxregs_state __u=
ser *) buf);
> >         else
> > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> > index 9dc77ad03a0e..5f441039b572 100644
> > --- a/arch/x86/kernel/signal.c
> > +++ b/arch/x86/kernel/signal.c
> > @@ -102,7 +102,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *=
regs, size_t frame_size,
> >         unsigned long math_size =3D 0;
> >         unsigned long sp =3D regs->sp;
> >         unsigned long buf_fx =3D 0;
> > -       u32 pkru =3D read_pkru();
> > +       u32 pkru;
> >
> >         /* redzone */
> >         if (!ia32_frame)
> > @@ -157,9 +157,17 @@ get_sigframe(struct ksignal *ksig, struct pt_regs =
*regs, size_t frame_size,
> >                 return (void __user *)-1L;
> >         }
> >
> > +       /* Update PKRU to enable access to the alternate signal stack. =
*/
> > +       pkru =3D sig_prepare_pkru();
> I think, the better place to call sig_prepare_pkru() at begging of the
> get_sigframe:
>
> get_sigframe()
> {
>    /* ... */
>     if (ka->sa.sa_flags & SA_ONSTACK) {
>          if (sas_ss_flags(sp) =3D=3D 0) {
>                 // set pkru =3D 0 <--- set pkru =3D 0 here.
>                 entering_altstack =3D true;
>          }
> }
> For two reasons:
> - We probably don't want all signaling handling going through "PKRU=3D0"
> , this includes the regular stack and nested signaling handling. The
> best place is when "entering the altstack". IIUC, this feature only
> enabled when sigaltstack() is used.
>  - The thread might not have read-access to the altstack, so we will
> want to make sure that pkru=3D0 is set before any read to the altstack.
> And IIRC,  fpu__alloc_mathframe needs read-access to the altstack.
> To help with testing, I will send a test case to demo the usage.
Apologies, I remembered it wrong, the fpu__alloc_mathframe doesn't
need read-access to altstack.

But I think the best place to set pkru=3D0 is still when the stack
entering altstack, as shown above. the reason is: The signal stack can
be nested, i.e. trigger another signaling inside signal handler and we
don't need to set pkru=3D0 multiple times (only the first time enter
sigaltstack)

> (please give me sometime to organize the test code, I'm hoping to send
> out before the end of next week)
>
the test code is placed at [1]
[1] https://github.com/peaktocreek/pkeytest

> Also, could you please consider adding a new flag SS_PKEYALTSTACK (see
> SS_AUTODISARM for example). Most existing apps that use sigaltstack()
> don't use PKEY and  don't care about setting PKRU=3D0, and don't need to
> overwrite the sig frame after XSAVE.  The flag will limit the impact
> of this patch.
>
Thanks
-Jeff

> Thanks
> Best regards,
> -Jeff
>
>
>
>
>
> >         /* save i387 and extended state */
> > -       if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, =
math_size, pkru))
> > +       if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, =
math_size, pkru)) {
> > +               /*
> > +                * Restore PKRU to the original, user-defined value; di=
sable
> > +                * extra pkeys enabled for the alternate signal stack, =
if any.
> > +                */
> > +               write_pkru(pkru);
> >                 return (void __user *)-1L;
> > +       }
> >
> >         return (void __user *)sp;
> >  }
> > --
> > 2.39.3
> >

