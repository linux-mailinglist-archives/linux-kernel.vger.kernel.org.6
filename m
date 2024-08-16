Return-Path: <linux-kernel+bounces-290214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A4B9550D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FFC1C2192A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8691C1C3F34;
	Fri, 16 Aug 2024 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdHUQGVn"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488321C3F32
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832793; cv=none; b=k+aqtMyywzniFkrZUqrpDpgb721yB2NM6eQvsB86N3dsABpz4/oIveqfnUkKXIsPr3ZrAamNu3aAuZbfHifhFgaTUSddtAfdM+C+ZORfHePk4JGJ8EFxYMbzRKENzdq5kqnAGEG8CluvEA9exDCrLc18aH1d3yikMLWhvgTdevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832793; c=relaxed/simple;
	bh=BhwRktBKLU5tLipL0EaNg17E7+pmd/lMK8WBt0c6la8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYHl2m2+qSJ/OJqrR8hn2qmlvaX4gbhzXBmZahCxVK5lOuKRme7C1epphO4C/RhIKyN3oGj6CuTrmijo+tcI9aQr95+9rFqrEYaJR2K4aRJ+pwzvh6q/f4W+n8ahvd4+B3qR0xqiv8OLrsbBYd9N5lKy8uawmP/1om9osD/Q8Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdHUQGVn; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f521a22d74so725287e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723832791; x=1724437591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRtyNVp4sSPMWOktbEPPlaUvj1Iz2cz/TE5aSmWxWyM=;
        b=TdHUQGVnVwgaKJWayy+XR8uaLmyEXWUDrO+iuShU38cbDAwuf3pHIzver+yQIZoPwR
         esiAXxamzH4mnT3AsON8E026wTEZrFGd/UnocduGzigjV5/3X9ynQH0kZtoyEWPE2dNI
         eWG/s8KOTS5f68Sxr19y1GQYKPXLLNQJlf/fb9mLNMH1lyFoub13olqD+ddWAxSo+ieB
         nKfsivdsqpU/rffzDBTtK4LZYvvct7ijNOhQI1OAblyZpra086TEMkSuj/s2/7ItWnaq
         1bsg/JqBpqDgVi3UKLEM0L+kzliCiqdGvaE9kA1Iqbor9DHFjzdr019I251O+9bsbI/n
         9gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832791; x=1724437591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRtyNVp4sSPMWOktbEPPlaUvj1Iz2cz/TE5aSmWxWyM=;
        b=BdPL66adOmEs+o9s00iTR2/Q2WqpBr8vB3rPDMQ47SiTFZZ0YDf2wg9YS2FaG7pv8d
         FwkwPy2kj2sWNa9dduN6AWrZ4BbG/EzNC/I2yv33Z6rbFum0bN/5rbXBs1EsHbvY1kWO
         34774p+FPYJePWlzolhfT1wM2fJd5wUjAzzsG8cSTg0dGf6sqoQ/o/QQI8ZSkKk6ML4H
         9CklWGJeRnD4PwKWzMd7sP8mF7lgr0Xy2h+M4eulziQdB6xWY7BHGlH5XeIwxQZWtYy4
         TbPYul28kInQvfYptzaTpjttBxcFMsxBwWVeH737pha3XmxBhPHaNH3w4ZcVAWBiIyPb
         WPUg==
X-Forwarded-Encrypted: i=1; AJvYcCWjhKtTcD4Ks8/lzXWeEfO1ruQ8LJ2m/0bsLQbCiHNUf78/XkFBrM3c+z4s//FA8auyf+1WfUM4pMtA2G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQReJlC2HuQNOffTfM6IhRb+/Gs4SoBJDVrN1cGELki+lFqGps
	QYq0TE2kHfkSbXEg2RwDb3w+bLLXYvNZQGMNfOU973RNwd5gxHHWa50nBU3eg950npN3nXaeboI
	kUSZsyfQROhfm3WE8HkZeHdDB/U8=
X-Google-Smtp-Source: AGHT+IFcwopDgVqc2oP6paySVJV30W6WQmNkQ48NQq2A8zBLaFIFS5VPsUKIF6HCQ72zitT8My2qhJwlB1pMlSRz+dw=
X-Received: by 2002:a05:6122:d99:b0:4ed:14e:9342 with SMTP id
 71dfb90a1353d-4fc6c5c2b6fmr4723680e0c.1.1723832790902; Fri, 16 Aug 2024
 11:26:30 -0700 (PDT)
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
 <CAKbZUD0ZA8q0QdSs_OwbdfSvM3Ze+0MaMQsn2dKM2pN6nn3J4g@mail.gmail.com> <CABi2SkVj8c7Cw_4DQ-U55Nkv5YCYR4WhjU3U_cw-cU2o7MAhMQ@mail.gmail.com>
In-Reply-To: <CABi2SkVj8c7Cw_4DQ-U55Nkv5YCYR4WhjU3U_cw-cU2o7MAhMQ@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 16 Aug 2024 19:26:19 +0100
Message-ID: <CAKbZUD31EK2ah=vWJ46y4nL9OygzAa6ZxPnPHmWYO-sop5t+5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Jeff Xu <jeffxu@chromium.org>
Cc: Jeff Xu <jeffxu@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:20=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Fri, Aug 16, 2024 at 11:09=E2=80=AFAM Pedro Falcato <pedro.falcato@gma=
il.com> wrote:
> >
> > On Fri, Aug 16, 2024 at 6:07=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> w=
rote:
> > > Please run this test on the latest kernel branch to verify:
> > >
> > > static void test_munmap_free_multiple_ranges(bool seal)
> > > {
> > >         void *ptr;
> > >         unsigned long page_size =3D getpagesize();
> > >         unsigned long size =3D 8 * page_size;
> > >         int ret;
> > >         int prot;
> > >
> > >         setup_single_address(size, &ptr);
> > >         FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > >
> > >         /* unmap one page from beginning. */
> > >         ret =3D sys_munmap(ptr, page_size);
> > >         FAIL_TEST_IF_FALSE(!ret);
> > >
> > >         /* unmap one page from middle. */
> > >         ret =3D sys_munmap(ptr + 4 * page_size, page_size);
> > >         FAIL_TEST_IF_FALSE(!ret);
> > >
> > >         /* seal the last page */
> > >         if (seal) {
> > >                 ret =3D sys_mseal(ptr + 7 * page_size, page_size);
> > >                 FAIL_TEST_IF_FALSE(!ret);
> > >         }
> > >
> > >         /* munmap all 8  pages from beginning */
> > >         ret =3D sys_munmap(ptr, 8 * page_size);
> > >         if (seal) {
> > >                 FAIL_TEST_IF_FALSE(ret < 0);
> > >
> > >                 /* verify none of existing pages in  the range are un=
mapped */
> > >                 size =3D get_vma_size(ptr + page_size, &prot);
> > >                 FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > >                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > >
> > >                 size =3D get_vma_size(ptr +  5 * page_size, &prot);
> > >                 FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > >                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > >
> > >                 size =3D get_vma_size(ptr +  7 * page_size, &prot);
> > >                 FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > >                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > >         } else {
> > >                 FAIL_TEST_IF_FALSE(!ret);
> > >
> > >                 /* verify all pages are unmapped */
> > >                 for (int i =3D 0; i < 8; i++) {
> > >                         size =3D get_vma_size(ptr, &prot);
> > >                         FAIL_TEST_IF_FALSE(size =3D=3D 0);
> > >                 }
> > >         }
> > >
> > >         REPORT_TEST_PASS();
> > > }
> > >
> >
> > FWIW this test does not work correctly on my end due to sealed VMAs
> > getting merged. I hacked up setup_single_address to work around that,
> > and the test does pass on both 6.10.5 and my local mseal changes
> > branch.
> Yes. you would need to comment out other tests and run this test only,
> it didn't consider the case that sealed vma will merge with another
> sealed vma (created from another test)
>
> The test didn't pass with the V2 patch (the seal =3D true) case.

Because we... found a bug in my munmap changes. The fixed v3 I'm
planning to send out does indeed pass.

--=20
Pedro

