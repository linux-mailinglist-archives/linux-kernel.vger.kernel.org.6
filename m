Return-Path: <linux-kernel+bounces-290228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB849550FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E111728427C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016181C3F36;
	Fri, 16 Aug 2024 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lVEypLZD"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26461B5825
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833787; cv=none; b=u3uYOMOP1OEcFkjEx6bTd+i+//Jg3WbKJ1TD+a1jUXeCmTtOwEMbWrVt0krDaLXZt8MpCXMQ8f8KY3Kv0Wbc6Bjy5hK8cL5ujhMQ/x7AoGvngInknuJ5bW6xte4eWhWfNBQwwayLO7e6zoR+KpiBulP4UplQR0R/stJH75ollZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833787; c=relaxed/simple;
	bh=f/lj35os5qXh/9+h4n3Es0pASBkLzdPRQpPfVJE4KEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UE9Wg4+OAS5axPgoKejhnSL5/qvuhxYMmDIK2nuZYDSOgYP5ZzRn41IUznlP7mxByJU286lmEcGmVO/pPAkP8EbxZsM4gdZI2xZazh1Mp3mjonjy4c1V2fhzIGOomDqa8gmu+q1YV9yxv2AwGpKxjdogaNJK5oluclawj5fzEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lVEypLZD; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2702ed1054fso208496fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723833785; x=1724438585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w+w1c74f+1d3M1TPYvu6zM80KBCv4i0JfxRRa+Nwnc=;
        b=lVEypLZDQC5qDUhncNZ5lZqvo/QqFHatKJ1Q+X+hZgoodyeiZGB/MkTpCTuoBnnGZG
         4kxkHGUSu9YBK48Yq5gtBlZPlD6PY+dUs9bCFx3q3JewfhTVM0ZRlEpiC9qQ3lp3IirE
         STWV1jvS5wfFfLy/OuQaPQPFmxuLLpG9lXP1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833785; x=1724438585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w+w1c74f+1d3M1TPYvu6zM80KBCv4i0JfxRRa+Nwnc=;
        b=ZyMwbTXc0rS6qXInGG9fEX+PAcpJn4n/lGBM3sOcysjGQJSphQFqo4Ez0bdQRG0dwG
         RgU8LIyenU2A6KgiZTg8pOkboCIslcWl8I6plW3cfW5u33R/GEI7PhxaZ4LrkJh8lYiH
         OpW9OSOcMic3+s3acBzYdoe5uC42kaoe3pmiyWvlgVh4y3qmErPAaik6QXnoHxlk7MHt
         22200Hmb1Xz/7LspPtrhFwdQyhqWvhMSloVOEWF0HCBUs7qdUzhenTBXD9P7oHUKwLrU
         OWexhP+b8c67pns9RvnMhB0zXzg/q1Tkyhbej7OaQlQqqjOD10izLC/wzHFlTkY2C/c9
         5YHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKZzgzT3HEuGCqqcGqTJ2ndkRd1dprxNJGrHaOE1Rfe0mY3UY+nxdHKOVkU3l6+TSmTZ5nvZddkzWoKWvc0jFmLo+J63FmyhLvEyLB
X-Gm-Message-State: AOJu0Yypnn4U/Asxzwn42x5PJaQs3mQub34/RF38RxcwHxqYGuEdfEwP
	W4/G+iFGzBuClgLH+MxjsmFlZIY2kRqk8gXJOJlwnZKCHSGZNDDERilRWIESGloi3OLz6gYp6zG
	oQnFkPS0jdfPku8k8/suHOkqGS6f51CqxwkDF
X-Google-Smtp-Source: AGHT+IEb9nVsoMnqEjofIHu2YYl869A1a2zA2NEvY38PukHL8QPgfqV7UILDW8gwQXnbjf6Pn9EQdZiQCl3TjHz66d0=
X-Received: by 2002:a05:6871:42c6:b0:270:2c7:e19c with SMTP id
 586e51a60fabf-2701c095fd0mr4658566fac.0.1723833784751; Fri, 16 Aug 2024
 11:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240808161226.b853642c0ecf530b5cef2ecc@linux-foundation.org>
 <CAKbZUD0_BSv6KOgaRuqjLWGnttzcprcUu5WysSZeX8FXAvui5w@mail.gmail.com>
 <CALmYWFs0v07z5vheDt1h3hD+3--yr6Va0ZuQeaATo+-8MuRJ-g@mail.gmail.com>
 <CABi2SkUYAc557wwOriwUW3tfTc_U9MDPQ4bE-Q+tTdNgGT3UuQ@mail.gmail.com>
 <CAKbZUD3_3KN4fAyQsD+=p3PV8svAvVyS278umX40Ehsa+zkz3w@mail.gmail.com>
 <CABi2SkVrEHbWa4AsffX9RXv_a-KjwZajkscZ3Bi4JWzJ4fr6wQ@mail.gmail.com>
 <CAKbZUD0ZA8q0QdSs_OwbdfSvM3Ze+0MaMQsn2dKM2pN6nn3J4g@mail.gmail.com>
 <CABi2SkVj8c7Cw_4DQ-U55Nkv5YCYR4WhjU3U_cw-cU2o7MAhMQ@mail.gmail.com> <CAKbZUD31EK2ah=vWJ46y4nL9OygzAa6ZxPnPHmWYO-sop5t+5Q@mail.gmail.com>
In-Reply-To: <CAKbZUD31EK2ah=vWJ46y4nL9OygzAa6ZxPnPHmWYO-sop5t+5Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 16 Aug 2024 11:42:52 -0700
Message-ID: <CABi2SkX01E9hF7vDvRK3D=A-0_XGx-oJoYR20f8VmSF-aGZfpw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:26=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
>
> On Fri, Aug 16, 2024 at 7:20=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wro=
te:
> >
> > On Fri, Aug 16, 2024 at 11:09=E2=80=AFAM Pedro Falcato <pedro.falcato@g=
mail.com> wrote:
> > >
> > > On Fri, Aug 16, 2024 at 6:07=E2=80=AFPM Jeff Xu <jeffxu@chromium.org>=
 wrote:
> > > > Please run this test on the latest kernel branch to verify:
> > > >
> > > > static void test_munmap_free_multiple_ranges(bool seal)
> > > > {
> > > >         void *ptr;
> > > >         unsigned long page_size =3D getpagesize();
> > > >         unsigned long size =3D 8 * page_size;
> > > >         int ret;
> > > >         int prot;
> > > >
> > > >         setup_single_address(size, &ptr);
> > > >         FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > > >
> > > >         /* unmap one page from beginning. */
> > > >         ret =3D sys_munmap(ptr, page_size);
> > > >         FAIL_TEST_IF_FALSE(!ret);
> > > >
> > > >         /* unmap one page from middle. */
> > > >         ret =3D sys_munmap(ptr + 4 * page_size, page_size);
> > > >         FAIL_TEST_IF_FALSE(!ret);
> > > >
> > > >         /* seal the last page */
> > > >         if (seal) {
> > > >                 ret =3D sys_mseal(ptr + 7 * page_size, page_size);
> > > >                 FAIL_TEST_IF_FALSE(!ret);
> > > >         }
> > > >
> > > >         /* munmap all 8  pages from beginning */
> > > >         ret =3D sys_munmap(ptr, 8 * page_size);
> > > >         if (seal) {
> > > >                 FAIL_TEST_IF_FALSE(ret < 0);
> > > >
> > > >                 /* verify none of existing pages in  the range are =
unmapped */
> > > >                 size =3D get_vma_size(ptr + page_size, &prot);
> > > >                 FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > > >                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > > >
> > > >                 size =3D get_vma_size(ptr +  5 * page_size, &prot);
> > > >                 FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > > >                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > > >
> > > >                 size =3D get_vma_size(ptr +  7 * page_size, &prot);
> > > >                 FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > > >                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > > >         } else {
> > > >                 FAIL_TEST_IF_FALSE(!ret);
> > > >
> > > >                 /* verify all pages are unmapped */
> > > >                 for (int i =3D 0; i < 8; i++) {
> > > >                         size =3D get_vma_size(ptr, &prot);
> > > >                         FAIL_TEST_IF_FALSE(size =3D=3D 0);
> > > >                 }
> > > >         }
> > > >
> > > >         REPORT_TEST_PASS();
> > > > }
> > > >
> > >
> > > FWIW this test does not work correctly on my end due to sealed VMAs
> > > getting merged. I hacked up setup_single_address to work around that,
> > > and the test does pass on both 6.10.5 and my local mseal changes
> > > branch.
> > Yes. you would need to comment out other tests and run this test only,
> > it didn't consider the case that sealed vma will merge with another
> > sealed vma (created from another test)
> >
> > The test didn't pass with the V2 patch (the seal =3D true) case.
>
> Because we... found a bug in my munmap changes. The fixed v3 I'm
> planning to send out does indeed pass.
>
OK, I think you got my point.
Glad to hear that you are doing more testing.

Thanks
-Jeff

> --
> Pedro

