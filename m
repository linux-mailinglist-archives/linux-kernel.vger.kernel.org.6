Return-Path: <linux-kernel+bounces-435292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B89E75BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0792E188A1F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568A20E31D;
	Fri,  6 Dec 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ifG1aZYp"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318820E30C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501874; cv=none; b=MdzVx/oQXVzFsZ59BqUyBZvY9e5vR++b/OxIgQnx387zel/4Q4z6mT53/nclRZ4IC7LAz5PPplrh9621owXXYWE6dG3GCm9lA+XW3AMC2m6jn+PfLyfr0m5d7ZjsJUkUndUa1o1W6ccAMNPPa0tmx7C5MbPkP4T69GcsVrRhhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501874; c=relaxed/simple;
	bh=e3BpOzvQSXPwHE2thKuh8Tl5jqUuAPK9fRZ9MgRnjQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzFy+RYz/+pwsJSi1a4k2cAR1S5Be0hv+Diaw0OntuA8b/QpqUKGwGzWX0HOmv9qTkBLsj1mvAkSZk1oSlVld7KcG/pAl8OQ3y0eqRZooV048HEpjfrb+sHNtJ/cls0WyQmzueIook/ezC5wu9SApw0JQaJk+x5eylGTrPprTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ifG1aZYp; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71d5aeefa71so244845a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733501872; x=1734106672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYNgFZy/4/b6RmhVrXOEIxOyzv8j9mBXffJS69QvJeY=;
        b=ifG1aZYpPk+MWWCYmZht4+g0CicuBCuyfgegfiVnMtry3AFYwq7U+CJx1cTwGiHm5a
         SmI6ZMbA+z3BVZomTkQSSuamRnHQ06X7yDMcLGNeYtDaQuRzBqwOPD6pH4bsrPJMJSKH
         fIorH20sVepB2p6+xKsqAgxatPnsqAYASIyCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501872; x=1734106672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYNgFZy/4/b6RmhVrXOEIxOyzv8j9mBXffJS69QvJeY=;
        b=YgWBHCF7+MGBTkMy5mXsiJIrG1F2HhjhmJ3apWGEYO5RJLc11s904DVGxAzVpYXRkK
         lOl80eWgEmbPyPtTtRe0n6m4S1PC7a9MoHFr+tLCudmc9v4f34zCzYkS1LLn0P2MYXhL
         NT6riQlRYmGbEa2xEWrH2lAR9MPEIhm3UJfEQKsCvmF+ctY6cshLr00qmWnqxbZPr5sP
         wsPGUKF7VAj6/NpBOvyaPfImE8usd7x5cseRbYN20D7W82VfZoTa6I8IRxOCv2zQDZTl
         GxzVJu2P5zj/wV6s2EfVNMgT52IWq1rPHDU9WvqjLln2swzIGmHIUhXh8Us3i8d/PGH5
         gTyg==
X-Forwarded-Encrypted: i=1; AJvYcCW0DzC0q7QFPLtpRWMS6FPNrpUCkVSZmAafpA0fZGCTL81jqM1CuN9IpxDWxpQXHHRvXfFKesTUR7VeZ7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoAkCl6el216LNuc32RP7lxN0YwbAgfKyDTwBWgzbjuo6hDqUk
	nG+b+Vu8RW3cr9OlUSE4wOvu0NTCx86MOmY2lZhb2BpFnoCPXktu3ppEfwKfGDxYa1T0cINb4Wi
	YEhw0EQrMYCXzp84himeZ9l7hUKQDi3pfCh5LOYRBksIC8lo=
X-Gm-Gg: ASbGncuQzRyDTdpQJ4boLvMI1pkMg3sQbSQuhIG8qgETPd8D8N5xJ5jD1KWeJ6DaSI4
	2kQgG2XAQ1AWBK2JxttV26pE1agOFvT5a+yfm9kf3aJ3E7uUQdac4svYEKFqqfQ+K
X-Google-Smtp-Source: AGHT+IHRb8erTdDUQTrHJbU0fhtYuKrytZ0PMTCzeH2gffX33C2JMd95VcEBOKpmWKnjXeUJ/vtlcF6fm2BIbgdb3Fs=
X-Received: by 2002:a05:6830:d0b:b0:71a:20da:f85f with SMTP id
 46e09a7af769-71dcf5c2a07mr815871a34.7.1733501872216; Fri, 06 Dec 2024
 08:17:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206013934.2782793-1-jeffxu@google.com> <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
 <d710d812-3dc0-406f-ac47-a782673d3d07@lucifer.local>
In-Reply-To: <d710d812-3dc0-406f-ac47-a782673d3d07@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 6 Dec 2024 08:17:40 -0800
Message-ID: <CABi2SkWkUmBdsUYhr-cE181oh=medLG0iXgHk6TYEuPgztxqOw@mail.gmail.com>
Subject: Re: [PATCH v1] mseal: move can_do_mseal to mseal.c
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, vbabka@suse.cz, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 1:13=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Dec 05, 2024 at 11:25:43PM -0500, Liam R. Howlett wrote:
> > * jeffxu@chromium.org <jeffxu@chromium.org> [241205 20:39]:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > No code logic change.
> > >
> > > can_do_mseal is called exclusively by mseal.c,
> > > and mseal.c is compiled only when CONFIG_64BIT flag is
> > > set in makefile. Therefore, it is unnecessary to have
> > > 32 bit stub function in the header file.
> >
> > There is no reason to keep this function at all; it is used in one
> > place, and that place uses three lines of code as well.
> >
> > In fact, having it separate from the comment about flags being reserved
> > makes the function very puzzling.
>
> I entirely agree. Jeff - please just make this inline to do_mseal():
>
Sure.

>         ...
>
>         /* Flags are reserved. */
>         if (flags)
>                 retrun -EINVAL;
>
>         ...
>
> If you do that then cool I'm happy for this patch to be taken.
>
> An aside - I actually think we need to move the bulk of this code to
> mm/vma.c - it makes absolutely no sense to keep the internals in this fil=
e,
> and that way we can userland test mseal functionality.
>
Is there a past discussion to read ? That will help me understand your
strategy of unit testing mm code.
Moving everything to vma.c, will lose log history, e.g. blame no
longer helps, did we consider alternatives ?


> I may submit a patch to this effect at some point.
>
> Thanks, Lorenzo
>
> >
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  mm/internal.h | 16 ----------------
> > >  mm/mseal.c    |  8 ++++++++
> > >  2 files changed, 8 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index 74dc1c48fa31..5e4ef5ce9c0a 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -1457,22 +1457,6 @@ void __meminit __init_single_page(struct page =
*page, unsigned long pfn,
> > >  unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup=
 *memcg,
> > >                       int priority);
> > >
> > > -#ifdef CONFIG_64BIT
> > > -static inline int can_do_mseal(unsigned long flags)
> > > -{
> > > -   if (flags)
> > > -           return -EINVAL;
> > > -
> > > -   return 0;
> > > -}
> > > -
> > > -#else
> > > -static inline int can_do_mseal(unsigned long flags)
> > > -{
> > > -   return -EPERM;
> > > -}
> > > -#endif
> > > -
> > >  #ifdef CONFIG_SHRINKER_DEBUG
> > >  static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
> > >                     struct shrinker *shrinker, const char *fmt, va_li=
st ap)
> > > diff --git a/mm/mseal.c b/mm/mseal.c
> > > index 81d6e980e8a9..e167220a0bf0 100644
> > > --- a/mm/mseal.c
> > > +++ b/mm/mseal.c
> > > @@ -158,6 +158,14 @@ static int apply_mm_seal(unsigned long start, un=
signed long end)
> > >     return 0;
> > >  }
> > >
> > > +static inline int can_do_mseal(unsigned long flags)
>
> It makes no sense for this to be inline.
>
> > > +{
> > > +   if (flags)
> > > +           return -EINVAL;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >  /*
> > >   * mseal(2) seals the VM's meta data from
> > >   * selected syscalls.
> > > --
> > > 2.47.0.338.g60cca15819-goog
> > >

