Return-Path: <linux-kernel+bounces-198843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62688D7E35
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C21F24FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106AA7E777;
	Mon,  3 Jun 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfxWJskT"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB34776F17
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406002; cv=none; b=pvwBqKIMc+Bxus5JP421JgX5AXFH+djK2ozCV8IMH40S/ingoWBgrXahrt1Hy6Gf7kGZpAYM9PJYMyhnPtqaST+i9Kb77Kx9QWBr0gJicRYpGWZRvBW3YtZdejaDxnNTIC8FAgfYZYsPr4yOk2G2TpsB+/eH9amQDJWI9qaVWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406002; c=relaxed/simple;
	bh=UUJ/u6Jum1hxyaC0tZphU6l6+SwdIUNR2yTzwcgGj/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PL/IgQyRbECboHwW+AKoYmFowyk6QZc3mNFULIK2yhsBe1Exkvho5GSFlF1Ab+lNgWYyn6qIOlvUc8LaDXZK7gT8lXNn4qNJwk9F8UaSED0r/x83Jrs03eKmmK2O90HMEWZwGQsYdTtgxPOcfBkmvLjq4pd6T86Tpv+TmldDEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfxWJskT; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ae1059a62fso22212966d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717406000; x=1718010800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vAMkiFmM1PgwLYJXTqfVoK4qXe/84aecwt6VcYF0jA=;
        b=rfxWJskTSDCjrh3h2nieV04ArG3TlS5BRqvP+JgxVAya36/qLIr3yB6yDaY6kY1dxw
         pARM7nbF9rEg8EpA5fh/r//yOD7PGRVSYZtv4c0X3mQsxJ9Le+AlQm4YW4aeNsYeuHre
         q2n7KOvfjOGdNcaq3FWgiNUd9A8T8kKEJk4vFKlPdaLXoMU5IovFnijKh/NFOQn0LK/u
         wCW6fn2PSY7OOdnqf2uU3reVFL7FCG+JOwnDGMqD7VEUtfu1yM40NJfAGYjFNlBz4EdN
         LC6Tmz1+SnvsjCTKYXiW4AC67xjPNZCktT2zbmnMiZ3FIW/tP746UvTnCy5s2IFtddtY
         xzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717406000; x=1718010800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vAMkiFmM1PgwLYJXTqfVoK4qXe/84aecwt6VcYF0jA=;
        b=jLjCpMS1VgWqWScX7LuRtVM2u25zO5JNhtfYUbnwZe3CnZfeuEszXtXzJ+3WxH5vZY
         H/GjWyRIHojIHrKlQzlFfCi8oF8JO7+FpEU7S050tYtWH8dSsd/WZjYDBoW1MG5RLFQl
         roIlVOjQDTMGY4bJcB2/0Qyw2asedzBnoCjVt/ljQgSLFK67/ECTdmx3Z1Hk7EQSohFc
         S+9UpwlEpsoGSZuXdL3ZgOPN1dKGFpe+nRH2bZ74+quzHQfURen86/h1v4bkZNqx3r9u
         xTacLurCqDAZUhfeiL9dIWSH4XXpi7Ckseks65H1QILbczWbzuPjWuAdK6+Jkml8s0T4
         NFbw==
X-Forwarded-Encrypted: i=1; AJvYcCUxOmJCVxKw8FqnfuDMNDZwBPQVOgCuxOtOtSdQkqyk3T8JZjWmw3bsNDRtOl+AF1rxW7wfGG3d+R9sNFaXwA4SvnUXNM57fZhWqDZL
X-Gm-Message-State: AOJu0YwpmphlIDvv8a48fF/TcjsKOioiEuy/sAHt3SYcowl9qeGadRuH
	m2rBDq3a+II+mWECqowePicHHL5RXCni6gvC0NyxMTNf5BreLzWkJdAPG2VISB5VxFJMMcbWQif
	YNb8G8cPEgn4+cVKJaqrel8i2I5n9N2BANy8e
X-Google-Smtp-Source: AGHT+IGqq0cvFr6S2FwTQ2uRwFai5j3ZKERTTAH2hrIr3+mXsUbWQBgzIzKF98yyF10YV36n4zlwP7k6cd1/9ppj1ok=
X-Received: by 2002:a05:6214:5890:b0:6af:c308:ee31 with SMTP id
 6a1803df08f44-6afc30938f9mr25119606d6.49.1717405999358; Mon, 03 Jun 2024
 02:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <986294ee-8bb1-4bf4-9f23-2bc25dbad561@efficios.com>
 <vu7w6if47tv3kwnbbbsdchu3wpsbkqlvlkvewtvjx5hkq57fya@rgl6bp33eizt>
 <944d79b5-177d-43ea-a130-25bd62fc787f@efficios.com> <7236a148-c513-4053-9778-0bce6657e358@efficios.com>
 <jqj6do7lodrrvpjmk6vlhasdigs23jkyvznniudhebcizstsn7@6cetkluh4ehl>
 <CAG_fn=Vp+WoxWw_aA9vr9yf_4qRvu1zqfLDWafR8J41Zd9tX5g@mail.gmail.com> <63zx2cnrf5u2slmabde2wptxvq6a3opvrj2zrkcolw3gdkjdpf@bttdonbctura>
In-Reply-To: <63zx2cnrf5u2slmabde2wptxvq6a3opvrj2zrkcolw3gdkjdpf@bttdonbctura>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 3 Jun 2024 11:12:37 +0200
Message-ID: <CAG_fn=W86C4F=nqYqrOCbNgioN5QjOrMjmU9jXYmx-fnZXQXag@mail.gmail.com>
Subject: Re: Use of zero-length arrays in bcachefs structures inner fields
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brian Foster <bfoster@redhat.com>, 
	Kees Cook <keescook@chromium.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-bcachefs@vger.kernel.org, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:02=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, May 28, 2024 at 01:36:11PM +0200, Alexander Potapenko wrote:
> > On Fri, May 24, 2024 at 7:30=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Fri, May 24, 2024 at 12:04:11PM -0400, Mathieu Desnoyers wrote:
> > > > On 2024-05-24 11:35, Mathieu Desnoyers wrote:
> > > > > [ Adding clang/llvm and KMSAN maintainers/reviewers in CC. ]
> > > > >
> > > > > On 2024-05-24 11:28, Kent Overstreet wrote:
> > > > > > On Thu, May 23, 2024 at 01:53:42PM -0400, Mathieu Desnoyers wro=
te:
> > > > > > > Hi Kent,
> > > > > > >
> > > > > > > Looking around in the bcachefs code for possible causes of th=
is KMSAN
> > > > > > > bug report:
> > > > > > >
> > > > > > > https://lore.kernel.org/lkml/000000000000fd5e7006191f78dc@goo=
gle.com/
> > > > > > >
> > > > > > > I notice the following pattern in the bcachefs structures: ze=
ro-length
> > > > > > > arrays members are inserted in structures (not always at the =
end),
> > > > > > > seemingly to achieve a result similar to what could be done w=
ith a
> > > > > > > union:
> > > > > > >
> > > > > > > fs/bcachefs/bcachefs_format.h:
> > > > > > >
> > > > > > > struct bkey_packed {
> > > > > > >          __u64           _data[0];
> > > > > > >
> > > > > > >          /* Size of combined key and value, in u64s */
> > > > > > >          __u8            u64s;
> > > > > > > [...]
> > > > > > > };
> > > > > > >
> > > > > > > likewise:
> > > > > > >
> > > > > > > struct bkey_i {
> > > > > > >          __u64                   _data[0];
> > > > > > >
> > > > > > >          struct bkey     k;
> > > > > > >          struct bch_val  v;
> > > > > > > };
> >
> > I took a glance at the LLVM IR for fs/bcachefs/bset.c, and it defines
> > struct bkey_packed and bkey_i as:
> >
> >     %struct.bkey_packed =3D type { [0 x i64], i8, i8, i8, [0 x i8], [37=
 x i8] }
> >     %struct.bkey_i =3D type { [0 x i64], %struct.bkey, %struct.bch_val =
}
> >
> > , which more or less looks as expected, so I don't think it could be
> > causing problems with KMSAN right now.
> > Moreover, there are cases in e.g. include/linux/skbuff.h where
> > zero-length arrays are used for the same purpose, and KMSAN handles
> > them just fine.
> >
> > Yet I want to point out that even GCC discourages the use of
> > zero-length arrays in the middle of a struct:
> > https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html, so Clang is not
> > unique here.
> >
> > Regarding the original KMSAN bug, as noted in
> > https://lore.kernel.org/all/0000000000009f9447061833d477@google.com/T/,
> > we might be missing the event of copying data from the disk to
> > bcachefs structs.
> > I'd appreciate help from someone knowledgeable about how disk I/O is
> > implemented in the kernel.
>
> If that was missing I'd expect everything to be breaking. What's the
> helper that marks memory as initialized?

There's kmsan_unpoison_memory()
(https://elixir.bootlin.com/linux/latest/source/include/linux/kmsan-checks.=
h#L37).
include/linux/kmsan.h also has several more specific helpers for
various subsystems - we probably need something like that.
I was expecting kmsan_handle_dma() to cover disk IO as well, but
apparently I was wrong.

