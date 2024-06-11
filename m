Return-Path: <linux-kernel+bounces-210045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7358D903E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17801F226E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443E17DE11;
	Tue, 11 Jun 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aUivzDZW"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16F17D8B2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115238; cv=none; b=oO5ZTgU7Uj3ZziRSgOjGHqe6lBmYeUKGYc9YMXtum0Xqwz+HpL2Yw6Ky/HRLHmT+/R33WK5f7k71X5grCBWravCAXxztEEvFgTeTd+tOJi+54W6cTExBl+r/zmSuSPQtWGMxKDuU6Vh/Km23MXZju2OOk/B7/2GC8gX9N0MtP48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115238; c=relaxed/simple;
	bh=DenBAvY1VgHb5IE7Lt78+EUBNFqsgXe3l0GramNtKiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZ8cZ386gGoaAzv/If5g2HYcF0Jg6lGPWWkrO3Rt3RNByjUeT1dpjBPySeuY5pXzvAk2eTzbPzj4wNHVlDfEr8o0D5tc4IvsReJd+VADVgcjEUfINOlMs7S1tcicPm8QMReYBgvs1bvD118wFXQtUEnHdWVrXM8eNFNdMTXTqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aUivzDZW; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f9774a556cso697756a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718115236; x=1718720036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy8oHMpwAzTnrA6hIQed17Wxd5v4cl8lNZdtIYkbZh4=;
        b=aUivzDZWNQ8SqyNsbBG3+4fNSTd21gRLOewQWkR8CmKrEEtlA5k8BTZ2V0tCo3OsNN
         1LyesWDclfUe4hEDsrXOl9FIyaWsbAXXk4Du839UG3R+QWUv2vNQX0y6SZgfewHPrb3D
         HZSy/Y6Fc25NHT2o1qnlAhs0pX+FZQvohHN+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718115236; x=1718720036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy8oHMpwAzTnrA6hIQed17Wxd5v4cl8lNZdtIYkbZh4=;
        b=e6jWlhCs+KCWCGLjXemaaWKHUzZC9A22G1ydvqocU93KxDqZETFUDbZGUGSJOiTgyo
         YX+D4TVWy8tk//4m6ZjEJOE5H2BNhhPtE4IlK8BgTiyXUad5tKMIJraSjWB814G1ZTZ4
         +Kz5hW/wKkufdwF3IfCJd8Ahj2CHFUdSnr+BBaeOfMiBkcdJ4wRCCogGOdImY8eQfOHN
         o18PFGHUwX+mzuArV/AYxZefVQULK+PXlN2Vbqj5jZN2PQraxWhNTYV8zHvCqe21ojzV
         OaFOyC8AZaemE//QhLYFU83D9WwIS+kO4/6JaRERBd9VP5IDqYDF//+6pRA1O/rg/nTx
         1QWw==
X-Forwarded-Encrypted: i=1; AJvYcCVf1AyBdiu1O81qFfuB6B9FW38LECXovzepuTBqq2bbXKYV9ikXv3kCQ0mzENczwcifvvTccCG8+/Br7kovJgGW7R7Hysp0KTQnjpAj
X-Gm-Message-State: AOJu0YwUt7VVMiYO4kxhsDwCKuwCrOMRsHWwqEZCRxrxM32BzQ64bGGW
	DkkZsGDcdRCC2AD4yQ4hvIQ2GWDOow90CWD342GR1yV4ALHvtpZaLZpMaGyrvl7YRkKgMqxuYq2
	pJATlfINdMSj3gTup0iEQqvyRSjv/dHQah1eA
X-Google-Smtp-Source: AGHT+IEyLXp50AVlWar+ASEL8EEFzsgHFJzCmH5iDrtEytk/RBAQaUrOjGAzA/S0A1NSW/DgR87CGNyjYAUP4RRKdUg=
X-Received: by 2002:a05:6870:ec94:b0:254:9ded:a3b7 with SMTP id
 586e51a60fabf-2549dedd4b0mr9558744fac.56.1718115236307; Tue, 11 Jun 2024
 07:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608021023.176027-1-jhubbard@nvidia.com> <CABi2SkVoNyXLrfU71gnv1qVUAADpUmFXiDoKKPc54MLb5JpB+Q@mail.gmail.com>
 <a8f9d4e2-8a12-4e5d-bd22-9c92955135f4@nvidia.com> <CABi2SkU8=tjWhD-e=OdiVr+YeU+BZZLB_vMfkNb-VWpbP2xcng@mail.gmail.com>
 <95005e7c-3705-48c5-8ee2-3d9b0688fcbc@nvidia.com>
In-Reply-To: <95005e7c-3705-48c5-8ee2-3d9b0688fcbc@nvidia.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 11 Jun 2024 07:13:44 -0700
Message-ID: <CABi2SkXN1jsnrawCwADxWB0Whj+e-m7+9c=5Lo3gY5CYVrnpkQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make headers"
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, 
	Rich Felker <dalias@libc.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:26=E2=80=AFPM John Hubbard <jhubbard@nvidia.com>=
 wrote:
>
> On 6/10/24 9:45 PM, Jeff Xu wrote:
> > On Mon, Jun 10, 2024 at 9:34=E2=80=AFPM John Hubbard <jhubbard@nvidia.c=
om> wrote:
> >> On 6/10/24 9:21 PM, Jeff Xu wrote:
> >>> Hi
> >>>
> >>>
> >>> On Fri, Jun 7, 2024 at 7:10=E2=80=AFPM John Hubbard <jhubbard@nvidia.=
com> wrote:
> >>>>
> >>>> Eventually, once the build succeeds on a sufficiently old distro, th=
e
> >>>> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and =
then
> >>>> after that, from selftests/lib.mk and all of the other selftest buil=
ds.
> >>>>
> >>>> For now, this series merely achieves a clean build of selftests/mm o=
n a
> >>>> not-so-old distro: Ubuntu 23.04:
> >>>>
> >>>> 1. Add __NR_mseal.
> >>>>
> >>>> 2. Add fs.h, taken as usual from a snapshot of ./usr/include/linux/f=
s.h
> >>>> after running "make headers". This is how we have agreed to do this =
sort
> >>>> of thing, see [1].
> >>>>
> >>> What is the "official" way to build selftests/mm ?
> >>
> >>   From Documentation/dev-tools/kselftest.rst, it is:
> >>
> >>     $ make headers
> >>     $ make -C tools/testing/selftests
> >>
> >>> I tried a few ways, but it never worked, i.e. due to head missing.
> >>
> >> You are correct. Today's rules require "make headers" first. But
> >> I'm working on getting rid of that requirement, because it causes
> >> problems for some people and situations.
> >>
> >> (Even worse is the follow-up rule, in today's documentation,
> >> that tells us to *run* the selftests from within Make! This
> >> is just madness.
> >
> > That is hilarious! :)
>
> :)
>
> >
> >>   Because the tests need to run as root in
> >> many cases. And Make will try to rebuild if necessary...thus
> >> filling your tree full of root-owned files...but that's for
> >> another time.)
> >>
> >>>
> >>> 1>
> >>> cd tools/testing/selftests/mm
> >>> make
> >>>
> >>> migration.c:10:10: fatal error: numa.h: No such file or directory
> >>>      10 | #include <numa.h>
> >>>         |          ^~~~~~~~
> >>> compilation terminated.
> >>>
> >>> 2>
> >>> make headers
> >>> make -C tools/testing/selftests
> >>>
> >>> make[1]: Entering directory
> >>> '/usr/local/google/home/jeffxu/mm/tools/testing/selftests/mm'
> >>>     CC       migration
> >>> migration.c:10:10: fatal error: numa.h: No such file or directory
> >>>      10 | #include <numa.h>
> >>>
> >>
> >> Well, actually, for these, one should install libnuma-dev and
> >> numactl (those are Ubuntu package names. Arch Linux would be:
> >> numactl).
> >>
> >> I think. The idea is: use system headers if they are there, and
> >> local kernel tree header files if the items are so new that they
> >> haven't made it to $OLDEST_DISTO_REASONABLE.
> >>
> >> Something like that.
> >>
> > But I don't want to install random packages if possible.
>
> Well...keep in mind that it's not really random. If a test program
> requires numa.h, it's typically because it also links against libnuma,
> which *must* be supplied by the distro if you want to build. Because
> it doesn't come with the kernel, of course.
>
Agreed.

> So what you're really saying is that you'd like to build and run
> whatever you can at the moment--the build should soldier on past
> failures as much as possible.
>
Yes. That is what I meant. It would be a convenient feature.

> >
> > Can makefile rule continue to the next target in case of failure though=
 ?
>
> That could be done, in general. The question is if that's really what
> we want, or should want. Maybe...
>
> > right now it stopped  at migration.c , if it continues to the next targ=
et, then
> > I don't  need to use gcc to manually build mseal_test.
>
> Let me take a peek at it in the morning.
>
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
>

