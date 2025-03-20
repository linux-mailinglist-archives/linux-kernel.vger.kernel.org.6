Return-Path: <linux-kernel+bounces-570134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA85A6ACAC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3713B241A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62EE1E766E;
	Thu, 20 Mar 2025 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnC7JQ5t"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637731DE3A8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493757; cv=none; b=N8uvVsLA5eT4f+yQzttqPfrqh3JU1lvnPwSZ9MewUVMPZ3r429KN7Dj0h5kZrwjZXfU8KVIRFOtoc7XIdq5VoNOOVMhZ1rFvTYhQAEWwfQCuH56sLsBpYG/oCyxIalC2jnix/p4E3Q3/cR9I3/C7SfBdaNTs64gq+bMmm0JIfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493757; c=relaxed/simple;
	bh=oM33WRSpS1ZT6iV5eF4SIitxcbY0yJad9WF43Cg7Ad8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7Wpf8al8p9TwpHA5Y85yAFsjSAVU62P1VzhMMiEcHwnYdQIXWB502lLwkB34MPpZmcUj/EA4cnMyhB0xcdJxx/dkFUgpwm5YWcMyXhMbYy2TLiKc0I8rx/w4lx75dLnQ6xoXMkqbHRs9hJee7vSTUz6qjvgvRTr54apAk23sZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnC7JQ5t; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso1990044a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742493753; x=1743098553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xg3QOvbC3nSIk4vN/a1/Hciy8XEyCa9EwBTeMqF5I+w=;
        b=VnC7JQ5t3pZ6lZuiuMN5QlE4BKZ2XUkkWMo4CXDX7cns9UMcnyITTNrerdvaaBZatx
         rab4+kwGvBmqBKAQExXOIgjowGG5xR8gfEXyCFJyXOSCWqLyorU2yLNIdiHmtoPjZbT1
         9m36M60XkX4Vj04sJ5Cb62yF4kruh9cSrXyMfBBo1Kua10U0dPeqZxSPA/uldCkx1QjS
         +bLCqWM5O45/Gnc9GUvmZJMutABqhwaW9nIWzTLtLFMv59ngpviz4oOFguC7D/XhDMmR
         AbhjPYNecJeM6FBLGVTSfQx37XvYWVtokkfhbfbii9K+Gqv8F12Vw3YUjMBs0epw2g4M
         M9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493753; x=1743098553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xg3QOvbC3nSIk4vN/a1/Hciy8XEyCa9EwBTeMqF5I+w=;
        b=IZQ0mgvFbZo28AlfOuN2w7ufQYwiekc7z+mmxNIRGsXrYQKKRB0nprMJTGX0oOlprw
         JJNsxQsrY/BPWq94r3GNkL/ZIH0fr0i9uLoK06OptPx3e6K/jHN7HgZO0XZvKofr3ujQ
         2wJtA9gXLmULQOpUp3CkLtPjRISnF53aLoamNM1MI00CNxNIZQC+n6PxQ9hvH0jpLh6g
         asLIJ3zl6FNi41Jw/SRAKFem8lPRcfgvuXHIroFNRb9ZKFPy+ap/krOPBZJY1gxq33qU
         m0Ane3Gr5coOzJVdyQzXxKYNqKnICI0IZldKdMNXz6AOyJDbWiqWtwISJDpXRjuB2cy9
         0EBA==
X-Forwarded-Encrypted: i=1; AJvYcCV4ARKXQwEN2vrq+l/qPdgxyh9ayFiXfnh5+kNk06LVsVx7vM5zB6FNvxeVahtVPydFBvSc9D0VEOtvBic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOeR5qGShHHS03r7eJ4n9HNvVTPf1XaRtlvggNE332kQ9DKhV5
	qPMwF6MFWg0IaRcf3inm/tcyHynk1vmLgCTtZ9cHf53xeDmiQxjXcdlWv0VH2qqDe/RyjTDktr/
	FIjdaZO0Hb3bOhKTTospWbUjOH00=
X-Gm-Gg: ASbGncs+ROKpWkEOHlyTqngGNbHPzZrgIR97iLjVt/LATrBL9LZIzIl+nP5IKTTwsF/
	XxIICR+4M7gonVpxKxsj/8fvglZjQWoanCfj7kvv/Sfsl/i1CiAzV14UgG5Dz91QoBetv3Uti7j
	r83ZFQiEoHWff6ZGI7v8XivH+JSA==
X-Google-Smtp-Source: AGHT+IHlU4lbc3u/81maqT1QuvudN/ZPRDmeR5yN1yzj56w7FkyIndX/YszFonHsQYpwYnWXi9B8hoeeG938rIio3Kw=
X-Received: by 2002:a05:6402:1d55:b0:5eb:1e0b:2bd with SMTP id
 4fb4d7f45d1cf-5ebcd478787mr252610a12.19.1742493753049; Thu, 20 Mar 2025
 11:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320142213.2623518-1-herton@redhat.com> <CAGudoHGr6y-WQY9CZ7mppeX87cgN0dG07ivK+MaoUow3ymArDw@mail.gmail.com>
 <CAJmZWFFyvqivwSMGA-T2HnOTr1GtYAvvWVZ8YuASC+cfSsB42w@mail.gmail.com>
In-Reply-To: <CAJmZWFFyvqivwSMGA-T2HnOTr1GtYAvvWVZ8YuASC+cfSsB42w@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 20 Mar 2025 19:02:21 +0100
X-Gm-Features: AQ5f1JoN9tEPnY9wb14-qIAtwZBJuZK56Yeo9YxcGX1tuzOXFv1S9IkTW-off5o
Message-ID: <CAGudoHEDAzOrndyJeb7L95cMPmHHk0O5wk=tRCe35FE6GVYs1w@mail.gmail.com>
Subject: Re: [PATCH] x86: write aligned to 8 bytes in copy_user_generic (when
 without FSRM/ERMS)
To: Herton Krzesinski <hkrzesin@redhat.com>
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, olichtne@redhat.com, atomasov@redhat.com, 
	aokuliar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 6:51=E2=80=AFPM Herton Krzesinski <hkrzesin@redhat.=
com> wrote:
>
> On Thu, Mar 20, 2025 at 11:36=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com=
> wrote:
> >
> > On Thu, Mar 20, 2025 at 3:22=E2=80=AFPM Herton R. Krzesinski <herton@re=
dhat.com> wrote:
> > > diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.=
S
> > > index fc9fb5d06174..b8f74d80f35c 100644
> > > --- a/arch/x86/lib/copy_user_64.S
> > > +++ b/arch/x86/lib/copy_user_64.S
> > > @@ -74,6 +74,24 @@ SYM_FUNC_START(rep_movs_alternative)
> > >         _ASM_EXTABLE_UA( 0b, 1b)
> > >
> > >  .Llarge_movsq:
> > > +       /* Do the first possibly unaligned word */
> > > +0:     movq (%rsi),%rax
> > > +1:     movq %rax,(%rdi)
> > > +
> > > +       _ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
> > > +       _ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
> > > +
> > > +       /* What would be the offset to the aligned destination? */
> > > +       leaq 8(%rdi),%rax
> > > +       andq $-8,%rax
> > > +       subq %rdi,%rax
> > > +
> > > +       /* .. and update pointers and count to match */
> > > +       addq %rax,%rdi
> > > +       addq %rax,%rsi
> > > +       subq %rax,%rcx
> > > +
> > > +       /* make %rcx contain the number of words, %rax the remainder =
*/
> > >         movq %rcx,%rax
> > >         shrq $3,%rcx
> > >         andl $7,%eax
> >
> > The patch looks fine to me, but there is more to do if you are up for i=
t.
> >
> > It was quite some time since I last seriously played with the area and
> > I don't remember all the details, on top of that realities of uarchs
> > probably improved.
> >
> > That said, have you experimented with aligning the target to 16 bytes
> > or more bytes?
>
> Yes I tried to do 32-byte write aligned on an old Xeon (Sandy Bridge base=
d)
> and got no improvement at least in the specific benchmark I'm doing here.
> Also after your question here I tried 16-byte/32-byte on the AMD cpu as
> well and got no difference from the 8-byte alignment, same bench as well.
> I tried to do 8-byte alignment for the ERMS case on Intel and got no
> difference on the systems I tested. I'm not saying it may not improve in
> some other case, just that in my specific testing I couldn't tell/measure
> any improvement.
>

oof, I would not got as far back as Sandy Bridge. ;)

I think Skylake is the oldest yeller to worry about, if one insists on it.

That said, if memory serves right these bufs like to be misaligned to
weird extents, it very well may be in your tests aligning to 8 had a
side effect of aligning it to 16 even.

> >
> > Moreover, I have some recollection that there were uarchs with ERMS
> > which also liked the target to be aligned -- as in perhaps this should
> > be done regardless of FSRM?
>
> Where I tested I didn't see improvements but may be there is some case,
> but I didn't have any.
>
> >
> > And most importantly memset, memcpy and clear_user would all use a
> > revamp and they are missing rep handling for bigger sizes (I verified
> > they *do* show up). Not only that, but memcpy uses overlapping stores
> > while memset just loops over stuff.
> >
> > I intended to sort it out long time ago and maybe will find some time
> > now that I got reminded of it, but I would be deligthed if it got
> > picked up.
> >
> > Hacking this up is just some screwing around, the real time consuming
> > part is the benchmarking so I completely understand if you are not
> > interested.
>
> Yes, the most time you spend is on benchmarking. May be later I could
> try to take a look but will not put any promises on it.
>

Now I'm curious enough what's up here. If I don't run out of steam,
I'm gonna cover memset and memcpy myself.

--=20
Mateusz Guzik <mjguzik gmail.com>

