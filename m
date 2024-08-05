Return-Path: <linux-kernel+bounces-275177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6505948170
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69FB11F23236
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392615FA9E;
	Mon,  5 Aug 2024 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dInRZRRX"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFA15F3FE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722881494; cv=none; b=O/XkEdrs1VyP79+vrKehPsUniVSZ2MnOMfKT2VXIvbEkVl9Lp1khP36zB2oxIvQIIfi2hxbnIL6b3KNntKt/NFwIaXu+rzTEitpcAQXe2hJS1juKm44BZoZ9cng5UZQsCSL6YlIa6HKxVoEt6DxT6LFh7RAukMr+E//lWPgL3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722881494; c=relaxed/simple;
	bh=IT6rj+N8w+2hUYnj1MvwmIb1amJCyMYhdpB43jZbqJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6Zra3RvSMio9uZvhoT8CDthfe+Q1bTankowhtV2SKxYtBcKOBr4ElcSEzVDLldkhN8zqGRHr+KF5jvjCM5/HsMuH2AVs19SZWQKHQeqpJ7z9nYz+bc9ZT3LM9AImIpl1BuSzRXwJSPa0ddx7nBOrG4eS2qTOEhMjxwiFiU8Ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dInRZRRX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so2175a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722881490; x=1723486290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hnQGBE87+KnmPa4Bs70BMJXJl5MSqY0q2M1s2nGpdw=;
        b=dInRZRRXJHqW9U9qI9zH0Z+D5QAM5vdDuazzByGCea7S1/9ulqE3xnuEKiqQcyVeIp
         QzXjkz1soCR7zHIGUz4DluEwxHP35rBnSoU7iwU0YyNjbaTYF0IChN7XDnTarXb1Pqrx
         ia0CvE0t7CUwfTWEI+3HKeQD6WSXpQpxKzN9U+n5vSjNZSY3hBmUBhHV46DccAJLlKTB
         bMFeqMwzvNJRGmOSz4DT2yXSs0WpVFbOzwi1n2D2ElChGK2ahdMdKHhoYVoXdf0JQ1fH
         m8qHiIyiAILud5nW5vVdo59ltUAlJ9Cckmbkbp5RUDUjZI+dq5NzvhsRu/CnzG36ZZyG
         YGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722881490; x=1723486290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hnQGBE87+KnmPa4Bs70BMJXJl5MSqY0q2M1s2nGpdw=;
        b=LMF2m5HihqLTVGDWlY4O7DIuEjAH2hsQghcLlfMPPGzx1Q7OqRNybrtVIQy/5hI/7t
         4vksRN8Ma1Pua9CVgDYVJPIdiE/uio3vcw5F+vTrpe2MV9yrKMudarWVVei7D/t4TgaP
         8ttmk4QXSMJePXuABKkMq4J1vjJf3NCAB5Xe2bpepq8ReRud6NYXxIccbAh6HZ0c8Klr
         dxUYyH2tw9YdCilZZPnSqafDvXjg0iLlaQqrw2Hrsh5W47PsLUkenJTRc9/WArOVYdqj
         7zBh2+H96q6sniwwPMoBjC7cf5rio+frrvSVCLw85p38hO7ZQXDc+pn5ikwfeyj4QgDb
         gBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8VjFn6Fos+sYnrurU/Mav+5UW+X9014pIZNohhtVACxZL6XcsPIbJhXa1a9SpOo+Q083gDT6Kg3Rrm4135zvxL47MltgDS2DTmTem
X-Gm-Message-State: AOJu0Yw13EheRFSIo2f1UF1QKri3+jmIY0ac95M6lk3rhI8n9a+MjsPe
	98wYwb+Z9jNhhpESsvsfqu1iQp84LSS+68VSd9SUiOuZEBY+uvVHK7WTAyHdHy8sfEcA8eU4SNd
	If+9J2XuLHCcL6c09XTIsBmnRGeGKsq0hPKAN
X-Google-Smtp-Source: AGHT+IHOh15hiLMYv55kABw3lnkiR4f9+1YSJisRrpIM2LvSrRhIYzH6Y0g9dC77hX8fJN2A9rRSSiJUQoJUICoipCI=
X-Received: by 2002:a05:6402:35cd:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5bb98174dddmr8049a12.2.1722881489512; Mon, 05 Aug 2024 11:11:29
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
In-Reply-To: <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 5 Aug 2024 11:10:52 -0700
Message-ID: <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 6:33=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Sun, Aug 4, 2024 at 9:33=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, 4 Aug 2024 at 01:59, kernel test robot <oliver.sang@intel.com> =
wrote:
> > >
> > > kernel test robot noticed a -4.4% regression of stress-ng.pagemove.pa=
ge_remaps_per_sec on
> > > commit 8be7258aad44 ("mseal: add mseal syscall")
> >
> > Ok, it's basically just the vma walk in can_modify_mm():
> >
> > >       1.06            +0.1        1.18        perf-profile.self.cycle=
s-pp.mas_next_slot
> > >       1.50            +0.5        1.97        perf-profile.self.cycle=
s-pp.mas_find
> > >       0.00            +1.4        1.35        perf-profile.self.cycle=
s-pp.can_modify_mm
> > >       3.13            +2.0        5.13        perf-profile.self.cycle=
s-pp.mas_walk
> >
> > and looks like it's two different pathways. We have __do_sys_mremap ->
> > mremap_to -> do_munmap -> do_vmi_munmap -> can_modify_mm for the
> > destination mapping, but we also have mremap_to() calling
> > can_modify_mm() directly for the source mapping.
> >
> > And then do_vmi_munmap() will do it's *own* vma_find() after having
> > done arch_unmap().
> >
> > And do_munmap() will obviously do its own vma lookup as part of
> > calling vma_to_resize().
> >
> > So it looks like a large portion of this regression is because the
> > mseal addition just ends up walking the vma list way too much.
>
> Can we rollback the upfront checks "funny business" and just call
> can_modify_vma directly in relevant places? I still don't believe in
> the partial mprotect/munmap "security risks" that were stated in the
> mseal thread (and these operations can already fail for many other
> reasons than mseal) :)
>
In-place check and extra loop, implemented properly, will both prevent
changing to the sealed memory.

However, extra loop will make attacker difficult to call munmap(0,
random large-size), because  if one of vma in the range is sealed, the
whole operation will be no-op.

> I don't mind taking a look myself, just want to make sure I'm not
> stepping on anyone's toes here.
>
One thing that you can't walk around is that can_modify_mm must be
called prior to arch_unmap, that means in-place check for the munmap
is not possible.
( There are recent patch / refactor by Liam R. Howlett in this area,
but I am not sure if this restriction is removed)

> --
> Pedro

