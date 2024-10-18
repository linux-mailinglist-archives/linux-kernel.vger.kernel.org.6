Return-Path: <linux-kernel+bounces-371190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18929A37A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D25628277F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4143D18B482;
	Fri, 18 Oct 2024 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1SzSqOF"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63562905
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237970; cv=none; b=A09gI0NWZjsbOO1SghFenV5vJTxGc8wha7BxISphBCM35qMrb5SYP4QuVRKnWQWtDM6maldkl9dJnqLhPShYdtR/wCN/gmZ/IQEPePyDMD17r6HolvlaHMsBVA95vCX0wiGkUU2ElY6x8tL1pdvRfWK8H9LaR8SmxSG0gy4kdoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237970; c=relaxed/simple;
	bh=8jasdk6EOkFmMd9dLl5Wpi4sSqjURjaTzeAJajSK8Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfZRorT0EbWtyhwH4XlbpaESh5wfhMP3p577CimesHp+e+4YVjFx+7k2A9se9vjZwBeWoiUdt2jBbrjTeJipBp9Oqqdk25pSIhEP4tI/9QdW56w3+vwL7utY1vNam9FoukztkTep/9jVatfgXEOAXTKjDKBzk5VLyWLyHbDQ5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j1SzSqOF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e5ae69880so1428999b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729237968; x=1729842768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1yGhxObWkPiVeQcvLuPlgwyuxcYZynMlSzlofUMrMY=;
        b=j1SzSqOFmuGxKxppTdhkizKT7Nzn8qyn+qzndOJeuS9gowww5iVHtVCTKQWTiNE8CF
         RMty2DvW02/XsEyY2xJRlGsyYABU47E5Oa904GcxvEE9tjx0IFU08z6e+7bd9IR1PBKL
         bJTdlrwRQCUTGpLLLBH0LifmD52VOsLb0+T/ldJweZnUe1pWqsZIYNrJKvVOcZU+v36L
         FasXc76qzlLwuOh8rB94uPYJZQ1cUgLn965kmcEo7dubSndaphcc0d6RrXvHkMNdfxJz
         etnO2xTanOpiH3db0452LqwFJ1YCXEdIe2h4I1IL/fcF1gzi36HFk3drgpvPhGqZ3IsS
         P2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729237968; x=1729842768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1yGhxObWkPiVeQcvLuPlgwyuxcYZynMlSzlofUMrMY=;
        b=Z6/+ojy4+fubSWKUrGDRprppu7nQFkgoS9Yw29VE8m47aGqFwkJODdYCucFsv5rh/J
         HFnxkTXbjSDyEQnQuxGtGkzirRqKviiszd56AGf5DS57eHs3Md/3oHTzSWlSpXi+hIY7
         cdjMgwE5aGlUenRhxw/JeHP0MK+ZkC7cvHL9oUV0IDybKnMSYqKsALGVM+rC24nnw50v
         fp0+izsI0pc26y0tPIjNB02vTKm6nIcfeHD4kVthgofIs/9L3uOBqvXPxa0pRltvvuj2
         21odi5lR/pCLJBBSHmPZ3wGCNDtxfqmqCMfzTcyMpwozlEljCE3IqP/p7BRx/PchLo8q
         yBzg==
X-Forwarded-Encrypted: i=1; AJvYcCW/G0658x5CHE6asyTpqiS1kElnmFAuFN9RAv4NqhXBNRitWS9rCx7hE3iUwdcd3qpBAr+3/vYp9FSANYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKhT1k6x6ct0kXnpONq0sVcxIak91+Qb7aMa1TKuc0jowjruq
	4iiXG6ulOWrAkIbXh4yrL2P7bQafknq5EgG5F1oDDZw93Xiosn1U0fmtexXLLQsxG9C2Jrf0sld
	+uDcN7ltipgXd/SOvbzUHTMNmO4A4mDWSkM5G
X-Google-Smtp-Source: AGHT+IH3PrP9VsRJ3nvS8aEQcqASbYdwlqH4J+B/dk41Ji0HMXi6ZcNZ9cH/JTosM/7oFR0/OEVlS3FvI3i0rgU7I7k=
X-Received: by 2002:a05:6a21:3a94:b0:1d9:2453:4343 with SMTP id
 adf61e73a8af0-1d92c57e30dmr1939838637.41.1729237967749; Fri, 18 Oct 2024
 00:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017214251.170602-1-niharchaithanya@gmail.com> <CA+fCnZfT80jDpQ5Dh-4w+eGQGoJQYd-F6h=_qNP4aw81TUMOCw@mail.gmail.com>
In-Reply-To: <CA+fCnZfT80jDpQ5Dh-4w+eGQGoJQYd-F6h=_qNP4aw81TUMOCw@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 18 Oct 2024 09:52:09 +0200
Message-ID: <CANpmjNMG_YZa4ZB2xPYbf=fq9=tgn+8TOwURDiHPZtgXCe=iPg@mail.gmail.com>
Subject: Re: [PATCH] kasan:report: filter out kasan related stack entries
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Nihar Chaithanya <niharchaithanya@gmail.com>, dvyukov@google.com, 
	Aleksandr Nogikh <nogikh@google.com>, ryabinin.a.a@gmail.com, skhan@linuxfoundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Oct 2024 at 02:44, Andrey Konovalov <andreyknvl@gmail.com> wrote=
:
>
> On Thu, Oct 17, 2024 at 11:46=E2=80=AFPM Nihar Chaithanya
> <niharchaithanya@gmail.com> wrote:
> >
> > The reports of KASAN include KASAN related stack frames which are not
> > the point of interest in the stack-trace. KCSAN report filters out such
> > internal frames providing relevant stack trace. Currently, KASAN report=
s
> > are generated by dump_stack_lvl() which prints the entire stack.
> >
> > Add functionality to KASAN reports to save the stack entries and filter
> > out the kasan related stack frames in place of dump_stack_lvl().
> >
> > Within this new functionality:
> >         - A function save_stack_lvl_kasan() in place of dump_stack_lvl(=
) is
> >           created which contains functionality for saving, filtering an=
d printing
> >           the stack-trace.

save_stack_lvl_kasan() tells me that it's saving a stack trace
somewhere. But this is actually printing. So the name here is
misleading.

We usually name things as <subsys>_foo if it's a function similar to
foo but for that subsystem.

So you can name it kasan_dump_stack_lvl.

> >         - The stack-trace is saved to an array using stack_trace_save()=
 similar to
> >           KCSAN reporting which is useful for filtering the stack-trace=
,
> >         - The sanitize_stack_entries() function is included to get the =
number of
> >           entries to be skipped for filtering similar to KCSAN reportin=
g,
> >         - The dump_stack_print_info() which prints generic debug info i=
s included
> >           from __dump_stack(),
> >         - And the function print_stack_trace() to print the stack-trace=
 using the
> >           array containing stack entries as well as the number of entri=
es to be
> >           skipped or filtered out is included.
> >
> > Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
> > Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=3D215756
>
> Great start!
>
> One part that is missing is also filtering out KASAN frames in stack
> traces printed from print_track(). Right now it call
> stack_depot_print() to print the stack trace. I think the way to
> approach this would be to use stack_depot_fetch(), memcpy the frames
> to a local buffer, and then reuse the stack trace printing code you
> added.
>
> I've also left some comments below.
>
> Please address these points first and send v2. Then, I'll test the
> patch and see if there's more things to be done.
>
> On a related note, I wonder if losing the additional annotations about
> which part of the stack trace belongs with context (task, irq, etc)
> printed by dump_stack() would be a problem. But worst case, we can
> hide stack frame filtering under a CONFIG option.
>
> > ---
> >  mm/kasan/report.c | 92 +++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 90 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> > index b48c768acc84..c180cd8b32ae 100644
> > --- a/mm/kasan/report.c
> > +++ b/mm/kasan/report.c
> > @@ -39,6 +39,7 @@ static unsigned long kasan_flags;
> >
> >  #define KASAN_BIT_REPORTED     0
> >  #define KASAN_BIT_MULTI_SHOT   1
> > +#define NUM_STACK_ENTRIES 64
>
> If we keep this as 64, we can reuse KASAN_STACK_DEPTH.
>
> However, I wonder if 64 frames is enough. Marco, Alexander, Dmitry,
> IIRC you did some measurements on the length of stack traces in the
> kernel: would 64 frames be good enough for KASAN reports? Was this
> ever a problem for KCSAN?

It was never a problem and 64 was enough, even when unwinding through
interrupt handlers.

It should just use KASAN_STACK_DEPTH.

> >
> >  enum kasan_arg_fault {
> >         KASAN_ARG_FAULT_DEFAULT,
> > @@ -369,12 +370,99 @@ static inline bool init_task_stack_addr(const voi=
d *addr)
> >                         sizeof(init_thread_union.stack));
> >  }
> >
> > +/* Helper to skip KASAN-related functions in stack-trace. */
> > +static int get_stack_skipnr(const unsigned long stack_entries[], int n=
um_entries)
> > +{
> > +       char buf[64];
> > +       int len, skip;
> > +
> > +       for (skip =3D 0; skip < num_entries; ++skip) {
> > +               len =3D scnprintf(buf, sizeof(buf), "%ps", (void *)stac=
k_entries[skip]);
> > +
> > +               /* Never show  kasan_* functions. */
> > +               if (strnstr(buf, "kasan_", len) =3D=3D buf)
> > +                       continue;
> > +               /*
> > +                * No match for runtime functions -- @skip entries to s=
kip to
> > +                * get to first frame of interest.
> > +                */
> > +               break;
> > +       }
> > +
> > +       return skip;
> > +}
> > +
>
> Please also copy the comment for this function, it's useful for
> understanding what's going on.
>
> > +static int
> > +replace_stack_entry(unsigned long stack_entries[], int num_entries, un=
signed long ip,
> > +                   unsigned long *replaced)
> > +{
> > +       unsigned long symbolsize, offset;
> > +       unsigned long target_func;
> > +       int skip;
> > +
> > +       if (kallsyms_lookup_size_offset(ip, &symbolsize, &offset))
> > +               target_func =3D ip - offset;
> > +       else
> > +               goto fallback;
> > +
> > +       for (skip =3D 0; skip < num_entries; ++skip) {
> > +               unsigned long func =3D stack_entries[skip];
> > +
> > +               if (!kallsyms_lookup_size_offset(func, &symbolsize, &of=
fset))
> > +                       goto fallback;
> > +               func -=3D offset;
> > +
> > +               if (func =3D=3D target_func) {
> > +                       *replaced =3D stack_entries[skip];
> > +                       stack_entries[skip] =3D ip;
> > +                       return skip;
> > +               }
> > +       }
> > +
> > +fallback:
> > +       /* Should not happen; the resulting stack trace is likely misle=
ading. */
> > +       WARN_ONCE(1, "Cannot find frame for %pS in stack trace", (void =
*)ip);
> > +       return get_stack_skipnr(stack_entries, num_entries);
> > +}
>
> Hm, There's some code duplication here between KCSAN and KASAN.
> Although, the function above is the only part dully duplicated, so I
> don't know whether it makes sense to try to factor it out into a
> common file.
>
> Marco, WDYT?

I would keep it separate, and get it working for KASAN first. There
may need to be fixes that only apply to one or the other, since this
code has been a little fiddly in the past. Once it's settled and
working, we can think about refactoring.

