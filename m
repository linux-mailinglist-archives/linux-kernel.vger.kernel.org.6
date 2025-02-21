Return-Path: <linux-kernel+bounces-525876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB55A3F6AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3922E1773AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27171FFC44;
	Fri, 21 Feb 2025 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqrLjbmQ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8915530C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146554; cv=none; b=TG8wIR60mMTW15UJpgmc14f73SydPbzb7hn8lTLYDwon+zpPQIl9UcstT326dk2A14YtTv0kii5DZqj/ycalsTna7fyInO01PVdnQZd/tMw51ZopKApNF8/aZE2ixOMsPPTfOTYqytFTqMZbT+ouYpzrJLjtZaHMzvFCiWZJOT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146554; c=relaxed/simple;
	bh=FWjn8X2FfaK8SSNwO/Xctdx2DZncST8IYUonlq7UEX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjuDqqxeYyO8Gjyriy4sWOsyYPfeYL7MvSX5u8mjgvaam5MWmPZD8yHwzyFlcPQQJkzDToWhGi6QpgObLpSqxC4aAtZIGDgjK278kor7YEprN0GryjK+eWTecRmG08m0szKrjCSYLxQRoV1nMQYfdFk4nzZjKzzXtyZcdXazZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqrLjbmQ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30797730cbdso21054391fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740146550; x=1740751350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJzAWSuxeWSihbhdsKRhtohvlqbTovub3PbCnjjBuIU=;
        b=VqrLjbmQHe/7oEAuVDt9Zhk3V0YXES6/lqdP5KhhW5Dv9GyORZpW4hv3j9scEf2KVC
         /nq2WMkx0c/+sqDdpA3/BzswEBqlugfAnDyjNRkpUVfoVuw79vXTfMKBDWTXqFje/ppJ
         PlcyTjg/godeMnDH89CzkVv+op9rpuAPbaTa+d4AOt6/oMooTkNZ3yYcVy020GbMdaTw
         dT+P/A1RpLm0WW1ayEPMI7DDMz7CqPK6sK5LOlmokEbJ0AX8y8rDDfzQUOQunwpGNUCC
         9GSsuI/fsFFcIl8AetniGgkmPzRm3MCmGIwI+ZxqoDw0gBUk4E01ZkW1eGn6JQc2wjZ+
         PqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740146550; x=1740751350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJzAWSuxeWSihbhdsKRhtohvlqbTovub3PbCnjjBuIU=;
        b=fCPPxfvl/95lbsoaSZPqkUN26SyEC6m5rKvZ8/oDXcB6NeMIqouK8rCvL54VFF0dsj
         WIAp6xlceGnuKki4ZYW487zthCZbjojaWIrMjbwwdVoN0LXrBEEjcstOIpjDDNLnVbtA
         u/RnWRK8K6Nag04vPassgc92aUY8XpydpGdWp2nl/JpYdEpmiWkdz8YggLP4Z+/gHVUa
         vjv4zaa3eAswgxcjrqUX8HJkc3sVqfKvOqjvTBH41SqkbrZLzA7pLes9i1Wn3GbEhPUP
         fkxamxlqKujqEnrfBuoVj7QGXYJfRWxFbH1wE9yfzslNVVHSP5i3wZ/8gwKpYPRd05Vk
         iQYA==
X-Forwarded-Encrypted: i=1; AJvYcCVUJGOgXHdFWOWPwLn8GmKWT2H3Sib9DFM6GFJeA54sH4xy25xgpNILH4BCMG4DOUlzDRjyNNEY3skb3eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKsXyYicSLWU9CqVWZRfNF2mm6QXHavBoHyaDxG06pGwjVL8a
	rq+oRtJ77dFjhhE6d8tofj/qftORQ0FUIMTo0m2TA4/zSL9ny8OHXgr+lJs6pkFYAfhWjsNhHTq
	++L0+UhyZpTi3YUxUt6dYoSC0NHwBbh0h
X-Gm-Gg: ASbGnct+OObCei4wY1ZRBJpG67vba4VuMa5VEjzzspW9wEHyX8gEvmzRoNcaWtLbp0O
	fknGj4SB2IRmgfSNMiZoX20LMCqh5EM3ZyIl/XwRkjlgb58+q9mjDz27aGlhjquIpg6zxghLsqN
	LGsvpQVyY=
X-Google-Smtp-Source: AGHT+IFwEPPGZor7NpDcd1tbv1ol/oavAwRIBy9sBDshbX9f1fAkSxGnrQcRs+pDoC6oyDzPcCWVefyV+BwS5Hy8xuo=
X-Received: by 2002:a2e:bc0e:0:b0:300:34b2:f8a3 with SMTP id
 38308e7fff4ca-30a59899cc8mr11285301fa.13.1740146549953; Fri, 21 Feb 2025
 06:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220200439.4458-1-ubizjak@gmail.com> <CAMzpN2i8uR7L9DmL1AX1R9p__x5KwAtdey_4iJ5ZP_frTqu9vQ@mail.gmail.com>
 <CAFULd4b8kgXfr1QcWud-n7PyuKKVUGTNd00GSZU=6va6Gr65EA@mail.gmail.com> <CAMzpN2hHb_T3gZfueeVRbOxUFt8+syWsm8iWQxF4PaUOQA-k=w@mail.gmail.com>
In-Reply-To: <CAMzpN2hHb_T3gZfueeVRbOxUFt8+syWsm8iWQxF4PaUOQA-k=w@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 21 Feb 2025 15:02:18 +0100
X-Gm-Features: AWEUYZmCBwkvlgfmIlzbKgd6ByWamu5dt1_-sUrxo3DfYSgPpL5XSQCwY4cRwUk
Message-ID: <CAFULd4ZGW-FYtEe-BJ53QVjHMLr1jyj_6vJhNEwqqwW6Z77+Tg@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/stackprotector: Move stack canary to struct pcpu_hot
To: Brian Gerst <brgerst@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:37=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Fri, Feb 21, 2025 at 8:25=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > On Fri, Feb 21, 2025 at 1:54=E2=80=AFPM Brian Gerst <brgerst@gmail.com>=
 wrote:
> > >
> > > On Thu, Feb 20, 2025 at 3:04=E2=80=AFPM Uros Bizjak <ubizjak@gmail.co=
m> wrote:
> > > >
> > > > Move stack canary from __stack_chk_guard to struct pcpu_hot and
> > > > alias __stack_chk_guard to point to the new location in the
> > > > linker script.
> > > >
> > > > __stack_chk_guard is one of the hottest data structures on x86, so
> > > > moving it there makes sense even if its benefit cannot be measured
> > > > explicitly.
> > > >
> > > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > Cc: Brian Gerst <brgerst@gmail.com>
> > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > ---
> > > >  arch/x86/include/asm/current.h | 13 +++++++++++++
> > > >  arch/x86/kernel/cpu/common.c   |  1 -
> > > >  arch/x86/kernel/vmlinux.lds.S  |  2 ++
> > > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/=
current.h
> > > > index bf5953883ec3..e4ff1d15b465 100644
> > > > --- a/arch/x86/include/asm/current.h
> > > > +++ b/arch/x86/include/asm/current.h
> > > > @@ -15,6 +15,9 @@ struct task_struct;
> > > >  struct pcpu_hot {
> > > >         union {
> > > >                 struct {
> > > > +#ifdef CONFIG_STACKPROTECTOR
> > > > +                       unsigned long           stack_canary;
> > > > +#endif
> > > >                         struct task_struct      *current_task;
> > > >                         int                     preempt_count;
> > > >                         int                     cpu_number;
> > > > @@ -35,6 +38,16 @@ struct pcpu_hot {
> > > >  };
> > > >  static_assert(sizeof(struct pcpu_hot) =3D=3D 64);
> > > >
> > > > +/*
> > > > + * stack_canary should be at the beginning of struct pcpu_hot to a=
void:
> > > > + *
> > > > + * Invalid absolute R_X86_64_32S relocation: __stack_chk_guard
> > >
> > > This should be R_X86_64_PC32 relocations.
> >
> > This is what the build system reports if any offset (including 0) is ad=
ded to
> >
> > PROVIDE(__stack_chk_guard =3D pcpu_hot);
> >
> > It is not a warning, but an error that fails the build.
> >
> > As was discussed in the previous thread, the above is required to
> > handle !SMP case, where mstack-protector-guard=3Dglobal (used by !SMP
> > builds) ignores the
> > -mstack-protector-guard-symbol option and always uses __stack_chk_guard=
.
>
> I got a warning from the relocs tool, but not a hard error.  What
> compiler/linker are you using?
>
> Does the attached patch build in your configuration?

Ah, the attached patch is similar to my previous approach, where the
build system *warned* on an offset (the patch was abandoned due to
Ard's request to put stack_canary to the *beginning* of struct
pcpu_hot, and this allowed for a simplified patch).

The attached patch builds for me without warning/error for both, SMP
and !SMP build.

You can put my Acked-by: on the patch, and if it is based on my
previous patch, I'd be grateful for a Co-developed-by tag.

Thanks.
Uros.

