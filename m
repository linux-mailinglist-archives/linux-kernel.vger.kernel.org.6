Return-Path: <linux-kernel+bounces-278034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E31994A9C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909C21C22DF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882774429;
	Wed,  7 Aug 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmvVK08r"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F86A8DB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040156; cv=none; b=oWXT/SnGvrWKBjZbxW0QcMz3k55cc/oBR0pG70FKFviavFSn8E5TGfnx43wTcC6Xk62ToWDBBTdMRs3thY+6p61SSU8ITTjSg1zqKICcFpw01ziD/PlUmgN+sxd2Yglb1VMd4feHFJyjLnlUgacc2WZy0gQ+EXaAFZTzQsSzOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040156; c=relaxed/simple;
	bh=6ddTzYAj9rsPHx1C292ov1Tuj2jOdzex9L9hVeTedyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZGxS/aG9SyT3YXx9o84BcGChSRNzpFLFdD78xP36Wovx6e+KBYiRjCDxgxIeJqEoiFVYNr3fCUfyMEWnsM6gLZrxXWKamma+ysY18KmOWWBYkCINSXGm57PeEBKm9Oxa6bXoza+sTBcgvPnQowGrAnnbGarKzpRe3HdndAFqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MmvVK08r; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so33213a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723040152; x=1723644952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ddTzYAj9rsPHx1C292ov1Tuj2jOdzex9L9hVeTedyg=;
        b=MmvVK08rKDQDjTfxCdVxppKUnRpMpGglIwApkhs9i4+e21tVfvvMSXV3pbEejQsm5v
         KnmVxTW4TCzC/D/Ih8Vvyt5hFXXQBAgDCiBoS/QFy5XYv1OuE0aWR/J2iGO4MGhu6OEU
         kFMlHUL0DWI50DHcgnrxrWN1UmNOfYHOXhhQz4P4mnrfTiMiuB8DwauEKlooy7K6VELQ
         kWNXSPp3jCM1HGvK2igEAe5vAjxNst9FrHj2CEqXb6eduT4vvb5cWQMWET3+SEnXLqKQ
         FDg6cd83hiwGWnHE8V5wQmJ7yrP/e3Q3wJK1P726UoB+PXQvpJ7pKjAm2QQ0ne8CI2ZH
         G3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040152; x=1723644952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ddTzYAj9rsPHx1C292ov1Tuj2jOdzex9L9hVeTedyg=;
        b=TqkzinTddqCBHekniikDQEDI7gi0hLLLAlsBQhDhGvNso1W+l6Tq4jCv//wahbUdvC
         M7NKFMI713cV97A5pwwy22zp06iHIFFJpFUIpRa6ZQ5MYL80+Aa2uFn9ugdGIdjov+7Y
         E0LGzg2A8LOPthNba0Xo6HjjqljzmhozOhIh6NEDQib39oLbKByCBIIL/eekToPnRazU
         8UMDz8AAflrvwYRPhncBJzGH+zqOtJw8MdqCjklnAE7bgwNV/IIFNFVcWSc3PtBxUjkt
         con9OciFTrH0IkL7GNWLA9XQ7vxmVvbv3IcLt+fyAnSaGvSNgCNKKqC0TusviNnhIOLL
         DYUA==
X-Forwarded-Encrypted: i=1; AJvYcCUXZgoEFOU8/9JeUFpM33i2QWK9IL0rgiv57cxIHs0MP+Y2dbaV8XPQsrgarrbISRZkE9OtpJYihz9Ff66YB/VSaVYnBe5wDRDKY/dh
X-Gm-Message-State: AOJu0Yx7ngVM7s8teEhgk/ykVz11VtWvuBwikFJfPCu2K6n+cLg3Z9kF
	GJwgQdOnom0RXW/6s+9D4etcKncDuZrUZJwBnO+RpZONLvndKfF3SM0cK/kNiBhWcef1HUImk8A
	PiZh+maaRUtUs87WnBTjv+QImfHfuKjvL61gd
X-Google-Smtp-Source: AGHT+IFZEI+BQjciQFiwSscSHRSoqwvmbsc3l1lva3qfpczM4gs08GmAUgqx0PNk8BMs04bD3Or5J7uxxQe4NEClYSk=
X-Received: by 2002:a05:6402:27c7:b0:5b4:df4a:48bb with SMTP id
 4fb4d7f45d1cf-5bba25bf4fdmr195347a12.0.1723040152143; Wed, 07 Aug 2024
 07:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
 <CALmYWFuN5SxCrkFfgeP_uFThz-a=+VExjy2eqn5tQZSyaCjswg@mail.gmail.com>
 <CAKbZUD1BGV5PMwtGwN1kLHTa6=bfEztrcBW7onzSgxwAAgTjXQ@mail.gmail.com>
 <CALmYWFvyOCbn=ug77ma95ypjXnkV0tzStHWTz1mjpS+iKqK8ww@mail.gmail.com> <CAKbZUD0ABKRuKUcBM+LWUwcDBc1eo61hHuP1xTk5Z8bUL8=qzQ@mail.gmail.com>
In-Reply-To: <CAKbZUD0ABKRuKUcBM+LWUwcDBc1eo61hHuP1xTk5Z8bUL8=qzQ@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 7 Aug 2024 07:15:14 -0700
Message-ID: <CALmYWFub6CZ45N_u=X91czq7fGkSK_5dtK3bgjUfQsGopSCqSg@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm: Optimize mseal checks
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 5:57=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 2:40=E2=80=AFAM Jeff Xu <jeffxu@google.com> wrote:
> >
> > On Tue, Aug 6, 2024 at 5:49=E2=80=AFPM Pedro Falcato <pedro.falcato@gma=
il.com> wrote:
> > >
> > > On Tue, Aug 6, 2024 at 11:25=E2=80=AFPM Jeff Xu <jeffxu@google.com> w=
rote:
> > > >
> > > > On Tue, Aug 6, 2024 at 2:28=E2=80=AFPM Pedro Falcato <pedro.falcato=
@gmail.com> wrote:
> > > > >
> > > > > Optimize mseal checks by removing the separate can_modify_mm() st=
ep, and
> > > > > just doing checks on the individual vmas, when various operations=
 are
> > > > > themselves iterating through the tree. This provides a nice speed=
up.
> > > > >
> > > > > While I was at it, I found that is_madv_discard() was completely =
bogus.
> > > > >
> > > > Thanks for catching this!
> > > > Is it possible to separate this fix out from this series and send i=
t
> > > > separately and merge first ?
> > >
> > > Sure. This series is definitely too risky to catch this release, so
> > > sending it out as a fix (tomorrow, it's late here) sounds ok.
> > >
> > Do you mind if I send out a fix ? (I will also include a test case to
> > cover that )
>
> No need, I'll handle it before the end of the day.
>
> >
> > > >
> > > > > Note that my series ignores arch_unmap(), which seems to generall=
y be what we're trending towards[2]. It should
> > > > > be applied on top of any powerpc vdso ->close patch to avoid regr=
essions on the PPC architecture. No other
> > > > > architecture seems to use arch_unmap.
> > > > >
> > > > > Note2: This series does not pass all mseal_tests on my end (test_=
seal_mremap_move_dontunmap_anyaddr fails twice). But the
> > > > > top of Linus's tree does not pass these for me either (neither do=
es my Arch Linux 6.10.2 kernel),
> > > > > for some reason (mremap regression?).
> > > > >
> > > > I just sync to Linus's main and I was able to run the test (except =
two
> > > > pkeys related test are skipped because I m on VM)
> > >
> > > Okay. Fun bug.
> > >
> > > I was really confused as to why no one could repro this except me :)
> > >
> > > It looks like recently[1] glibc started consuming the new_address
> > > variadic argument when MREMAP_DONTUNMAP. As to the why,
> > > MREMAP_DONTUNMAP also seems to take new_address as a hint (this is no=
t
> > > documented in the man page, and strace also doesn't know this).
> > > However, this trips up some checks that were always fine before
> > > (because glibc always passed NULL, and musl still does):
> > >
> > > if (offset_in_page(new_addr))
> > > if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
> > > if (addr + old_len > new_addr && new_addr + new_len > addr)
> > >
> > > ^^ These all look at the address without looking at MREMAP_FIXED, and
> > > return -EINVAL if they fail.
> > >
> > > So, test_seal_mremap_move_dontunmap_anyaddr passes 0xdeadbeef For Som=
e
> > > Reason (why are you testing mremap in mseal_test.c??), it trips up
> > > offset_in_page(new_addr) in mremap_to, and we crash and burn.
> > >
> > > As to why no one else could repro this: I guess you're not running a
> > > glibc new enough ;)
> > >
> > That makes sense, mystery resolved.
> >
> > I added sys_ functions for mmap/munmap/mprotect, etc, so that the test
> > does not depend on libc, but I didn't do that for mremap, I think the
> > fix will be to add sys_mremap as well.
>
> I disagree, I don't understand why you're doing this test.
The test is for testing the return error code should be EPERM in case
of sealing.

> And even if
> you are rightfully doing the test, the test is wrong (and
> mremap_dontunmap.c tests agree, and always pass 0 as new_address).
the new_address don't need to be 0.
E.g.
mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0xdead0000);
Will success and relocate memory to 0xdead0000


> The manpage needs to be updated to reflect this, and this test either
> needs the 0xdeadbeef removed, or the whole thing.
>
> Adding a sys_mremap wrapper is inconsequential here, because you'll
> need to decide whether to pick up new_address from the flags argument
> and, if you do, it'll fail with the same error, but for everyone.
>
I will send a patch and you can try on your sys (since I don't have
the new glibc installed)

> --
> Pedro

