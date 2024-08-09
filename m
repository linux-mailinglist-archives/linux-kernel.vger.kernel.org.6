Return-Path: <linux-kernel+bounces-281317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFC94D571
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD3D1F220EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3146425;
	Fri,  9 Aug 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H7mEQOz9"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830827581F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224665; cv=none; b=PKuQCrfKo8+nLTtH4hfOpc8NtO4ErPalybV7WmSQY/XLIGtmlA0ndbFpT35l+PIx7mJMkWyOI+l8I0kqCtZwMnwlk0wSiiLUpyZIQcHVM3QI46tKhuMWAnZJLwQKdYsSYD3si4FxhPObWXQzV16VbQrewj6bOaCgU8W3z0YV5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224665; c=relaxed/simple;
	bh=q7+Ja/ge9FP7Xdt/XdTpoX+nqpRA+5gTvLT7VAnq/wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCEIjdALBtKW4ZvG2j5K+urxkiypwOXBdas++7LVbdqb8YbRDh2OitTJ1G3VYNFnvBOmlm5haPybJlJS0iDmPbHbclAqq3Ign7TeZgaa0dceqAGC6izhvsa3dWkNcqH33AhwybwTvTrFeJdwFED8vz2JzE1mJVAmp5rbGWR3Lo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H7mEQOz9; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-260e6298635so1345059fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723224662; x=1723829462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wWJES9dN+T0737KjEhk14QZogRDSeEDzNjYRNfc2PQ=;
        b=H7mEQOz9XuWdyU8YPWlq4w3jPCMytmBIcloIZbmE72KisVD7xmZ3nxIvowMYxu9h4r
         ZObn/4nwS7nVMde3aIbAq6/0aN8g+Q+ad/JeLk8T+3lvy47chO1WPsoNxSOTUU5C3jxg
         E0QeSO+1o1kmWFOl8GOGIKQs3F8ymwotMSjEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224662; x=1723829462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wWJES9dN+T0737KjEhk14QZogRDSeEDzNjYRNfc2PQ=;
        b=IA/6uFYtqEykNvI/T9TX7/oQdGfvHGYz4FO3DDio5alaBwyt9EWC8NEAwYHa2K3x5h
         qtFu4X8T7xIn1sjJMYKTTrlsMUFJ7l1unWQWIs0U2Iw8uZG63OHbZn7PnUvrUdCKGake
         Ywtxj/0cjfO2oi0fOD+8W00x39EJyRMhmZbXDwdLqbmTakJEoQ2XrzeN8SSQkh9w+f9c
         AuglAZDwI0z8dCswXQW55CT/tqg5VC5qAkrJmB5g+fxXJY9Y+zC2atsmLDiwH5Yk5fHG
         f3XCdy57F67UkWOlfuMnDro6DB2sa1USoY5Av25EeT6m2mfrkSthM/aQQ4HmWpEz8ga2
         Om3A==
X-Gm-Message-State: AOJu0YzaS0llpWjRbzMJLgRC12CIvnaxTj2ORSCCMRXCurKy4ZjzNzS4
	NRx/EBLEjBUoH1LWItylUwk9pcH0mNJw3CqE8aRLuqHl1UJFpnPTToLlIHgauUQxFsxrz3IFMrF
	5NpbU1VkvMZ0ACI+FLIqDsYZwuLnu8xhTczpd
X-Google-Smtp-Source: AGHT+IEBEPuSAY1tIMbqjh+/EoPcs7ZAb4YhPlN2g/kLHf6+IphnkfkzhOD5SjAmaDVQxwnIxl+YeieBGmZwVkZFbaU=
X-Received: by 2002:a05:6870:41d1:b0:261:184f:4ef1 with SMTP id
 586e51a60fabf-2692d38e91fmr2585320fac.15.1723224662473; Fri, 09 Aug 2024
 10:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com> <20240802061318.2140081-4-aruna.ramakrishna@oracle.com>
In-Reply-To: <20240802061318.2140081-4-aruna.ramakrishna@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 9 Aug 2024 10:30:51 -0700
Message-ID: <CABi2SkV6AfxDNnuSKr_PCydZSyvKSmzmEeMnAXw3w1=w-kz7ow@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] x86/pkeys: Update PKRU to enable all pkeys before XSAVE
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@linux.intel.com, 
	tglx@linutronix.de, mingo@kernel.org, linux-mm@kvack.org, 
	keith.lucas@oracle.com, rick.p.edgecombe@intel.com, jorgelo@chromium.org, 
	keescook@chromium.org, sroettger@google.com, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:13=E2=80=AFPM Aruna Ramakrishna
<aruna.ramakrishna@oracle.com> wrote:
>
> If the alternate signal stack is protected by a different pkey than the
> current execution stack, copying xsave data to the sigaltstack will fail
> if its pkey is not enabled in the PKRU register.
>
> We do not know which pkey was used by the application for the altstack,
> so enable all pkeys before xsave.
>
> But this updated PKRU value is also pushed onto the sigframe, which
> means the register value restored from sigcontext will be different from
> the user-defined one, which is unexpected. Fix that by overwriting the
> PKRU value on the sigframe with the original, user-defined PKRU.
>
> Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> ---
>  arch/x86/kernel/fpu/signal.c | 11 +++++++++--
>  arch/x86/kernel/signal.c     | 12 ++++++++++--
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 931c5469d7f3..1065ab995305 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -168,8 +168,15 @@ static inline bool save_xstate_epilog(void __user *b=
uf, int ia32_frame,
>
>  static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf=
, u32 pkru)
>  {
> -       if (use_xsave())
> -               return xsave_to_user_sigframe(buf);
> +       int err =3D 0;
> +
> +       if (use_xsave()) {
> +               err =3D xsave_to_user_sigframe(buf);
> +               if (!err)
> +                       err =3D update_pkru_in_sigframe(buf, pkru);
> +               return err;
> +       }
> +
>         if (use_fxsr())
>                 return fxsave_to_user_sigframe((struct fxregs_state __use=
r *) buf);
>         else
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 9dc77ad03a0e..5f441039b572 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -102,7 +102,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *re=
gs, size_t frame_size,
>         unsigned long math_size =3D 0;
>         unsigned long sp =3D regs->sp;
>         unsigned long buf_fx =3D 0;
> -       u32 pkru =3D read_pkru();
> +       u32 pkru;
>
>         /* redzone */
>         if (!ia32_frame)
> @@ -157,9 +157,17 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *r=
egs, size_t frame_size,
>                 return (void __user *)-1L;
>         }
>
> +       /* Update PKRU to enable access to the alternate signal stack. */
> +       pkru =3D sig_prepare_pkru();
I think, the better place to call sig_prepare_pkru() at begging of the
get_sigframe:

get_sigframe()
{
   /* ... */
    if (ka->sa.sa_flags & SA_ONSTACK) {
         if (sas_ss_flags(sp) =3D=3D 0) {
                // set pkru =3D 0 <--- set pkru =3D 0 here.
                entering_altstack =3D true;
         }
}
For two reasons:
- We probably don't want all signaling handling going through "PKRU=3D0"
, this includes the regular stack and nested signaling handling. The
best place is when "entering the altstack". IIUC, this feature only
enabled when sigaltstack() is used.
 - The thread might not have read-access to the altstack, so we will
want to make sure that pkru=3D0 is set before any read to the altstack.
And IIRC,  fpu__alloc_mathframe needs read-access to the altstack.
To help with testing, I will send a test case to demo the usage.
(please give me sometime to organize the test code, I'm hoping to send
out before the end of next week)

Also, could you please consider adding a new flag SS_PKEYALTSTACK (see
SS_AUTODISARM for example). Most existing apps that use sigaltstack()
don't use PKEY and  don't care about setting PKRU=3D0, and don't need to
overwrite the sig frame after XSAVE.  The flag will limit the impact
of this patch.

Thanks
Best regards,
-Jeff





>         /* save i387 and extended state */
> -       if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, ma=
th_size, pkru))
> +       if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, ma=
th_size, pkru)) {
> +               /*
> +                * Restore PKRU to the original, user-defined value; disa=
ble
> +                * extra pkeys enabled for the alternate signal stack, if=
 any.
> +                */
> +               write_pkru(pkru);
>                 return (void __user *)-1L;
> +       }
>
>         return (void __user *)sp;
>  }
> --
> 2.39.3
>

