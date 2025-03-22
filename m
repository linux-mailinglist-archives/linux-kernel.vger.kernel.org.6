Return-Path: <linux-kernel+bounces-572443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB474A6CA56
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C88187A8E14
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD291D5CD4;
	Sat, 22 Mar 2025 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/+VhtbD"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83161800
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742650279; cv=none; b=Qp7sLKdJe/w4Iy2V1/Gk+NfyKZlbaWeT6SVBCkpOF+eJozdQ4ZitDUMpa/lZ6B/6SRk71VPsvkzh+N56iNZhPNq04hEwHs9T48ganWQijI2ycNWtmY9+XSqQ7B4I1a5j3XHY+2D/W/sXHxQ9bVrWSlSb7c83e0jcMlaGQF5tNAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742650279; c=relaxed/simple;
	bh=9AKMQQ+tewuD42GUxuwY6D+8ksq5o6EIjh1oOrHM9SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVdxPPqguOQP0HA+Tzp2YiliZeLhkBqa5LSzI2+LlXrMMGky9TqnvcMxDpSVXNG8oQbuBFSv3USJ+kNOGRTdFRsYAR6L77joeNuKGxgfrnWHuRe+6FyMK1QsAQwOy1Wahft4jJA9lHQgsvhucL4PQj6INSVQpomM79lTXY7LjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/+VhtbD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-307c13298eeso33832461fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742650275; x=1743255075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AKMQQ+tewuD42GUxuwY6D+8ksq5o6EIjh1oOrHM9SU=;
        b=E/+VhtbDPnoJEilS1i4++4k6b3rqGQfT+AFKW0M/P6E/9ZSILgM5VVJqe1IxnpdoJW
         ZgxdLoIUM8o4vKj83Ns/wM3Dnyhs2S4muQhCtxbS/x+aZXieWPuqiuOmVJOn45Y+qjIZ
         ZWCIyiyk2vOYmq4tJl/vzGOl0YTEStGsLd+MkVi3vuTnkKF3vGxzkbc5qX9JCnsBYfX0
         2Ou8Stn/JRyxKixSuyX7tzdxjhGBq/cUMwOYYHry6MtaaU3BD8UxENE46KgiYT2aR2OG
         E+MEK9dgsiCun8mWvetrR/cLf01SPRy9LTxqTgyQhg7Vg0dtAkPHEtGNt34WMGNgoOw8
         5aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742650275; x=1743255075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AKMQQ+tewuD42GUxuwY6D+8ksq5o6EIjh1oOrHM9SU=;
        b=BjjxvRhjYc3boj5dzpTcZlkeAOcQ9tmS9v/Hgt2KofipBO0NpxyOHhmbSu0QKvVWL5
         35VXPF3a5SxcG46gGdsYryUZnVWLtu5NZ5+6AWtr6N7F1mRGKyCyG8fwIpZI8gcvmwzF
         2JE6XAPwOlodSoKmbZod96aOIW4mIxn4llCpnnADFvJUhGkfJhNmIV5HjhgMm1Z2RbU5
         CW1FzzGM4PhClN46rKUcKNDsYuf/HKCf88+wRNam8DxDtjwE/Abm+N3jjbxcQPDiFSga
         5UdVtI/HAt3hyRq1goIyB5tRxt5a6jpLVNDUtq7HNwz/NTsTvqM08hfPKX6TiEZnN14G
         Kraw==
X-Forwarded-Encrypted: i=1; AJvYcCWTsBR+Eh99WzwLGYwCh/HRa5AA3mpaPAZDpdyj6ASFy+TK4VVOd3qe6tSNoRo8WDANOfRDbAHcoJPalsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6lWdf91SJaiZY+k1E6YJu5ujvzQ8JAr0wFlrDzLySs39kBUD
	lqg6b82XQJe5N5SspgRIiO0nVm5L/6SEn+s4arQqTeHktNCf3S0RCo4x/9RIGNwdwjW42DTB4sc
	jldPSuhVxSwTzKGhWRrBQ2l77Yno=
X-Gm-Gg: ASbGncstZ3rNJc6j0KJiw27hF/mzeYvI4nT7SL2pl/CrHYj8PMLcg2zWGyfKIWZx3oM
	1vl7vpbhxi/c33O6ijEyAfW50iNTBqMD04t1N9YkTfQ6JujD+d0gEKSz/js/LJx86nz3FUXMOKP
	uD/nsIrUXp+RTla0WWSanc12iTe66SwsUxMS2sH0NMIIoV5iJiWxkDK9oALqw=
X-Google-Smtp-Source: AGHT+IGPzq3nYNGL3ZBSwQY3JKgMl2ON0JW2nZj8jlBsh91Zm9Er2pL0kCBYyD20GpQjP8X4W9Ce6ZC2ve2l+h3z6EA=
X-Received: by 2002:a05:651c:88:b0:30b:9f7b:c186 with SMTP id
 38308e7fff4ca-30d727135d2mr39193871fa.1.1742650275143; Sat, 22 Mar 2025
 06:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4378DDFE-3263-497A-8364-433DC1984FEE@live.com>
 <CAJ-ks9=zN0pUAt9ELckna+3GcnDfhjF3jgiM1FHXLji9pWc2wQ@mail.gmail.com>
 <PN3PR01MB95976F630E0E4004CDC5310DB8DB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAJ-ks9mcuwSEQ=h1niGO5WkvNdkTwm0JeKtvp1RaioEb8WmuOQ@mail.gmail.com> <93CEB4B8-818B-4302-93C3-6EA25717D617@live.com>
In-Reply-To: <93CEB4B8-818B-4302-93C3-6EA25717D617@live.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:30:38 -0400
X-Gm-Features: AQ5f1JqXFfbJNhQhHsXNlTnzHmzZGw8QYh0ChG-0NqTni58gvS7ZfqAJo-JEyEU
Message-ID: <CAJ-ks9=imoiGnYuFj7V0M3j8ecFrNRvPXQj6cWsfnGNRQuVpEA@mail.gmail.com>
Subject: Re: [PATCH] printf: add tests for generic FourCCs
To: Aditya Garg <gargaditya08@live.com>
Cc: Kees Cook <kees@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 6:04=E2=80=AFAM Aditya Garg <gargaditya08@live.com>=
 wrote:
>
> Hi
>
> > On 21 Mar 2025, at 8:22=E2=80=AFPM, Tamir Duberstein <tamird@gmail.com>=
 wrote:
> >
> > On Fri, Mar 21, 2025 at 10:23=E2=80=AFAM Aditya Garg <gargaditya08@live=
.com> wrote:
> >>
> >>
> >> Can you give me some docs for running the Kunit tests? The patch is ba=
sically a port of the original version.
> >
> > I use:
> >
> > tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=3D1 p=
rintf
> >
> > You can probably just use:
> >
> > tools/testing/kunit/kunit.py run printf
> >
> > It would also be useful to see raw output:
> >
> > tools/testing/kunit/kunit.py run printf =E2=80=94raw_output
>
>
> Here are the requested outputs:
>
> -------------------------------------------------------------------------=
-------------------------------------------------------
> Failed test:
>
> [...]

OK, it's not great but no worse than before.

Acked-by: Tamir Duberstein <tamird@gmail.com>

