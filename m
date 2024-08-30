Return-Path: <linux-kernel+bounces-309074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0160A9665DD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DCB1C23BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CEE1B81A1;
	Fri, 30 Aug 2024 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CiSoI/uv"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B111B790A
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032331; cv=none; b=B5twyzwoIhFwQ/UVLKsKyNAvr8T5QknUSMFmmf+GTRB6FuKOJzWVlF5ZqA0vKzsdTJEx1O3/GnClhY4kduIT8XASvWJgHY1oz/hvOevhfYH4lG80QGumGxhqrxaUNL+S9weveXt4kHTZuYZWWomCt65Er/meoc9cVOKJQNj1NAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032331; c=relaxed/simple;
	bh=SUwxwdTKpoD+McoYuZdYTN3po1Up3ZeUUvAKwl9UHF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5W5fMsYzEfIDaEvgBQzAG48NKHftgU4XHnKid4xZctAKGPbgbhSArpOh65CLmDY+oMEObUcjb8C9yv0KP55mwvzOWNxxtHS1CQCV4O/ZbOK48fr4qEgQiJS754zxvQU5V6sx00MrkJv6Vxz3/IeCmJiqCKhP2tU0bRQs9xeWLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CiSoI/uv; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-268e0b13471so128149fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725032328; x=1725637128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+4o4v4tcr8rbwr78IwtuGgqIqaHJtCiQhKM2B3jmuI=;
        b=CiSoI/uvufHcpelcebQGFY88JntjVmGPOTGbl+8LK6Q0W45x8kvDpXOrHyQuEs29PS
         7xX5jgTJZCWoG05AUkkdFmArCwnd6DASqM+DaMQfqD1H+kQH5um7HDRvK5n2gpFRfZ8D
         1Wc9Y6iMSyBP7pffgktQhbz47irtl3sUlkVgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032328; x=1725637128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+4o4v4tcr8rbwr78IwtuGgqIqaHJtCiQhKM2B3jmuI=;
        b=Dnfg3W7t1DR4krP5AvX2YFxstz3gJyWqmD1IU+9V14ajXv9mttqH78mU9ueaJvjfvA
         Kh9SKgHgzl5+OJjVouG9xuM9ee3OHlG9tZ/LJfpKnEKv3w76ZE7DTX+X74yUHQ55AjK+
         wArq2I1sMZz2ICVswl0OYK/m34BzqIUhK+Wh2Xn4/2b8Ac4M+IC8UhSsDWdhkK2LpYxH
         hIbBI4nqgxu+MPiRRaI14/oRGM56M8pT7/XxxGr0AKrbLOZvO/JncZdrKyTH+MkWY2H3
         zKW88+iSf8epvY2u6QdlujSgJXaoVGHisjtbRcPGuz9OULpyqWGak3fhbhsraV/naKnW
         tPyg==
X-Forwarded-Encrypted: i=1; AJvYcCVUD4P/kyqArtFS6uIQ4JsWDmoa53t1qGKrl6GVMpSoEM4Ei2YGbv46HIdJgL8+tSkSFoJut1PFMDTU8l8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUua6Ox5f5P/Ic1mXwlFRBY3EOo2Ufby7qlm7k9x86icmEqbw
	GnJyGo0ZZJO6Vpyceo0ZCuWaOxhwpezypwRnlqiQX6lLC+GJkhCRJuNqYhFh2Xl3K8gjjQOIsUv
	P9rxvqxjU5KlYH3I7BbM7h/dRjkB9Ho4nw23a
X-Google-Smtp-Source: AGHT+IEJiQTBdvk8h4QsAYlys8jQM2wMdP6B97VqSR8AYorWSjmSCBIEgEV5VPy0sNLSBaQCDqVav2FFWC5OzTvuD20=
X-Received: by 2002:a05:6870:218c:b0:277:6b90:1915 with SMTP id
 586e51a60fabf-277b0e4fcc6mr1280261fac.9.1725032328307; Fri, 30 Aug 2024
 08:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829214352.963001-1-jeffxu@chromium.org> <ixoelxclkikscysvlmfbvciyig7pqjbuwwhhgawk6fy4iookya@kmsjo3oetgw5>
In-Reply-To: <ixoelxclkikscysvlmfbvciyig7pqjbuwwhhgawk6fy4iookya@kmsjo3oetgw5>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 30 Aug 2024 08:38:36 -0700
Message-ID: <CABi2SkWxAVzbZ8A4YOTcOhOOZwj6j_7K2khMs1yFDht1_GuLvg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Increase mseal test coverage
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, lorenzo.stoakes@oracle.com, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Fri, Aug 30, 2024 at 5:31=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Aug 29, 2024 at 09:43:48PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > This series increase the test coverage of mseal_test by:
> >
> > Add check for vma_size, prot, and error code for existing tests.
> > Add more testcases for madvise, munmap, mmap and mremap to cover
> > sealing in different scenarios.
> >
> > The increase test coverage hopefully help to prevent future regression.
> > It doesn't change any existing mm api's semantics, i.e. it will pass on
> > linux main and 6.10 branch.
>
> I do want to be clear that we shouldn't confuse "test coverage" with bein=
g unequivocally good
> if it has the possibility to paint ourselves into an API corner where det=
ails that should be left
> unspecified are instead set in stone (e.g do we want to test how mprotect=
 behaves if it finds an msealed
> vma midway? no, apart from the property that really matters in this case =
(that sealed vmas remain untouched)).
>
I do not disagree with this. Let's look through code and comment on
the case directly if there is such a case.

Thanks.
-Jeff

> >
> > Note: in order to pass this test in mm-unstable, mm-unstable must have
> > Liam's fix on mmap [1]
> >
> > [1] https://lore.kernel.org/linux-kselftest/vyllxuh5xbqmaoyl2mselebij5o=
x7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt/#t
> >
> > History:
> > V2:
> > - remove the mmap fix (Liam R. Howlett will fix it separately)
> > - Add cover letter (Lorenzo Stoakes)
> > - split the testcase for ease of review (Mark Brown)
> >
> > V1:
> > - https://lore.kernel.org/linux-kselftest/20240828225522.684774-1-jeffx=
u@chromium.org/
> >
> > Jeff Xu (4):
> >   selftests/mm: mseal_test, add vma size check
> >   selftests/mm: mseal_test add sealed madvise type
> >   selftests/mm: mseal_test add more tests for mmap
> >   selftests/mm: mseal_test add more tests for mremap
> >
>
> nit: Please follow a more standard commit naming scheme like
>         selftests/mm: <change description>
> or
>         selftests/mseal: <change description>
>
> --
> Pedro

