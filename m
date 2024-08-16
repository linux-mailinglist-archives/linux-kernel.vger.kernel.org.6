Return-Path: <linux-kernel+bounces-290204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 433B19550B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0EA1F23455
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF651C2329;
	Fri, 16 Aug 2024 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UoUxW7KC"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982778B50
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832426; cv=none; b=eTolxMC+twSmVRa6tXU7EJ1BdC5T1MeEpGi4gYQgyFgBpE9/ddAcE2E154KS4+2+HmqSJ5CrgfdhojFkO+N/A1mDc6GsOLRIrZBUEZCvs4LjgbBprVJgXGIy44gJjgZu+O/bwiYALQ2qAxB4iL4Uhox8VpihELisPOVj8s2dd+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832426; c=relaxed/simple;
	bh=n/FXMFtOMSOKWHPC5EaF2MRbry0sjl3NmT0Egf/WIbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSO4r7js3VHAqjGE21/hHvhiFUhUgUSpXK8Lt4PuSeXn36pVq1E5FqqGLVlBUiADj8dO/6xappnSHV0aAVXheUKteHj+bQ1sNFl7S4PpFjPBirH5z6X2C3AYScqBk/+E1jnUZulcOG+mGb0QX1ALALgUMPcNUwuWatMyEUUnvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UoUxW7KC; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-260f033fda3so1370996fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723832423; x=1724437223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPb+ESAaq2wrltkCUy/I577774QCbBTFaaMwP+kYFKM=;
        b=UoUxW7KCBBj5oza7v6iklgL3Vll1yazXcra5QA0XEWSs1lja4VBt83JNe/EhlztCHN
         lvgp1v09e4c280rVz8vCI3i0SEjmGspxrJ9949y9RvUnk0ehtcJNVPJPFjP3Uwm0V8k+
         hWBUh8dReQhHWIMLOfyNgJc1tKBSiOX5G+NRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832423; x=1724437223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPb+ESAaq2wrltkCUy/I577774QCbBTFaaMwP+kYFKM=;
        b=r6n94RWgORd1rfdNvYcyWJ1hwuJt/4WtIMLAz0vGbCYvvTiWiG/W+Sf3guxgRvNII2
         CKKiN0/nb3UT7ZrRGGIpncHJgngfb1g54l7bYkjKJcv0oImfGj/GzLGtNBy8fat5ri2T
         XcjJnnBtgnlr4bYnzpwZrC3l+f/yLJFyjnpSV3YqfWHooOlSFoXePE5+ABTGZqCirk+H
         nxV/Ri7n2zkRLSpE5ZUqlSJ+BWGBhJQU9qecQCLGzenxB9Wpem6qdrvLft9LqCLQmgtT
         6lHKVE+hDH7/zzi1HtUNaJSlCiUNMcslAbEr2u8oi5dLFZCrjmE5iYXUnMCkQDjQtGHT
         /1fw==
X-Forwarded-Encrypted: i=1; AJvYcCUsiJ9hZwjoromMG6rrtwq4O+dHp+Yy9jOptAvwZhp7GrcNLuehFj07pRE4VB2BeK/5TtCobonkKkIX1eeO6gsiaS70YqNgLpY1mF5z
X-Gm-Message-State: AOJu0YxGRhf9jHOPCla2xONbvN7Rs5FRzbKVnWLGC4a+WML7rHayQoIx
	jZv68tsn7oZzJvFVDq1ypBQBZIIPlyWqOAG3lxLD3y1/R4piOtHDwhgt8Pb4yVF8xX4wZX2jPDO
	wdgpmT2heo9Hz9hYdY4As5/TLxrQORHFWvgCY
X-Google-Smtp-Source: AGHT+IFh6uaaGAPXUqIFgzUea3SoJXHOqApu/hbIQHCcwYCPdKTsA88ruKomvfRzGZOMDVrdfjZErMZfrsa7e4nKwfI=
X-Received: by 2002:a05:6870:a117:b0:265:b32b:c45f with SMTP id
 586e51a60fabf-27033c40e26mr558194fac.0.1723832423583; Fri, 16 Aug 2024
 11:20:23 -0700 (PDT)
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
 <CABi2SkVrEHbWa4AsffX9RXv_a-KjwZajkscZ3Bi4JWzJ4fr6wQ@mail.gmail.com> <CAKbZUD0ZA8q0QdSs_OwbdfSvM3Ze+0MaMQsn2dKM2pN6nn3J4g@mail.gmail.com>
In-Reply-To: <CAKbZUD0ZA8q0QdSs_OwbdfSvM3Ze+0MaMQsn2dKM2pN6nn3J4g@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 16 Aug 2024 11:20:11 -0700
Message-ID: <CABi2SkVj8c7Cw_4DQ-U55Nkv5YCYR4WhjU3U_cw-cU2o7MAhMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:09=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail=
.com> wrote:
>
> On Fri, Aug 16, 2024 at 6:07=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wro=
te:
> > Please run this test on the latest kernel branch to verify:
> >
> > static void test_munmap_free_multiple_ranges(bool seal)
> > {
> >         void *ptr;
> >         unsigned long page_size =3D getpagesize();
> >         unsigned long size =3D 8 * page_size;
> >         int ret;
> >         int prot;
> >
> >         setup_single_address(size, &ptr);
> >         FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> >
> >         /* unmap one page from beginning. */
> >         ret =3D sys_munmap(ptr, page_size);
> >         FAIL_TEST_IF_FALSE(!ret);
> >
> >         /* unmap one page from middle. */
> >         ret =3D sys_munmap(ptr + 4 * page_size, page_size);
> >         FAIL_TEST_IF_FALSE(!ret);
> >
> >         /* seal the last page */
> >         if (seal) {
> >                 ret =3D sys_mseal(ptr + 7 * page_size, page_size);
> >                 FAIL_TEST_IF_FALSE(!ret);
> >         }
> >
> >         /* munmap all 8  pages from beginning */
> >         ret =3D sys_munmap(ptr, 8 * page_size);
> >         if (seal) {
> >                 FAIL_TEST_IF_FALSE(ret < 0);
> >
> >                 /* verify none of existing pages in  the range are unma=
pped */
> >                 size =3D get_vma_size(ptr + page_size, &prot);
> >                 FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> >                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> >
> >                 size =3D get_vma_size(ptr +  5 * page_size, &prot);
> >                 FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> >                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> >
> >                 size =3D get_vma_size(ptr +  7 * page_size, &prot);
> >                 FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> >                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> >         } else {
> >                 FAIL_TEST_IF_FALSE(!ret);
> >
> >                 /* verify all pages are unmapped */
> >                 for (int i =3D 0; i < 8; i++) {
> >                         size =3D get_vma_size(ptr, &prot);
> >                         FAIL_TEST_IF_FALSE(size =3D=3D 0);
> >                 }
> >         }
> >
> >         REPORT_TEST_PASS();
> > }
> >
>
> FWIW this test does not work correctly on my end due to sealed VMAs
> getting merged. I hacked up setup_single_address to work around that,
> and the test does pass on both 6.10.5 and my local mseal changes
> branch.
Yes. you would need to comment out other tests and run this test only,
it didn't consider the case that sealed vma will merge with another
sealed vma (created from another test)

The test didn't pass with the V2 patch (the seal =3D true) case.

-Jeff

>
> --
> Pedro

