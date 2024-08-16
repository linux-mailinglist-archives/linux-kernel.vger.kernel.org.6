Return-Path: <linux-kernel+bounces-290191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF195508E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF9E287626
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1141C379A;
	Fri, 16 Aug 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElQdQKxg"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C90B1BE860
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831799; cv=none; b=of88KHTxcIueCyFJUdZRUdWn7ySqjpUSJbyAVqrO7fY9SsEqdmKsZfLG6w6z5vQRMhB1vlqEWpI81YyD9LcTdS3tZ0YsmplO3Pmq8osccKjxP07VdsrnOhn8s0I4jm1gEXlpxvEc3wCBx+39NrmmPtG1hHOhixrdlDCPZbmIl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831799; c=relaxed/simple;
	bh=lJhyzLAL1aPGd9matGw1kcgWnNHk3dZ1XLPMMUFZUH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq37d8g9bUO9OjPrBMLwBytYuNR7axSV7AwySWS4AEu0gmTMMKii39grCONUVn/TlZmn2v1VeOLdejr3xUZlnlNq/tVkDL2wSgDQZUBftDzhQ6B18x3zcu7iJr2/9JBy/o/W7HIv5/Z5hVCYCxoTFUYH8mDiQ8oNsRBR5zCO0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElQdQKxg; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4929fd67c7bso698635137.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723831797; x=1724436597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXT+EkhrklWLGFU9rN71QI1DWSXDXH6Sll6gVrnThPY=;
        b=ElQdQKxgzKzKMMnSpQq3d0CNJ1uJ9t4fRIHAnHKHmHeokLN08Dp5gTxY9D2Cm3jM6E
         MYejuLxNFswLWraVMQUulDLr3QjiWXELrNRGGFO90Ss8LV3hlvwx4fV3VqzU/2aK5dE4
         H95yxru7B2gdnfV/RCj0Jb2VDuIEDj2ehMBUGRLTYDU6hHjtHwAcIMKpL2LiyofO/nMi
         zzo/ZVFpcJaSwsHwAZ2OYuOeu2c91B6T+a6+7dEtEQSy/2hYyk5TYmN0Gk65laFLUBnh
         9nkiGaerZpCFHWyCWEM2zi2YPFq0ogyfMguRbK8iDxxh+Ff2yeDftx8VpAMp+pFWdfBn
         oK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831797; x=1724436597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXT+EkhrklWLGFU9rN71QI1DWSXDXH6Sll6gVrnThPY=;
        b=G6H6Esl1r1IZD2+I/nlZuNkxDD1UUDJdms6ObL8Ckz+yutFwa+kYGCa8WQPc6vRIE2
         ekzmECC0/tpMhJ3D5+w1XuSEx2cfJr19lPFMdnbXrZOTP81WpECYxg5/s62+PMaK37Vh
         x4eKVsYdF0Fxf3AKYLBvMp3D2d6jRnkoy39uqFwPOypl57FLsSzxM9ykw99g0ZryP2um
         azUxMPciVJuzrTfFZERT0zVHE1C5c85UP3cWUztAuaBVpCo7Lxtuk8KmGmmncLzBmkQH
         6FdPNoQAGZFNf1EMD+pM5KD7N5vMWWdwufqCydwUPS7sLOjJFD+VVLzVCidfWQp60oXc
         jf8w==
X-Forwarded-Encrypted: i=1; AJvYcCV4CL7LX7naFOTqAAZ0WGvCP3AwZMrywRJRQQArAf64igAYJtnNg24u/3T6FtNErIPc9JC1OKM4y1C+LiEmy+4JlUB3VRe+pHmZ4PW5
X-Gm-Message-State: AOJu0Ywok2nh1fN0sSplKJMBrCGwkbgG0YcDzW0noGLqKAqOfYmGhfS7
	dApiW6zFvOni77MXHiK0JIjqDyKxuK4HzdoGzqpODgI/38efIczWsbg9g7t5ucHi0E+a3OEwNpt
	S+DqtsEidS2zTElgzgcAFuaU7T1k=
X-Google-Smtp-Source: AGHT+IF6bpgzYv6bEGMmO6lcZP53YsDNKH3SbarJRk7qsMyOgpwPwpioZkOEHvWDwwtIj2+y8IVgv92PvQw80CDQTRs=
X-Received: by 2002:a67:f84d:0:b0:497:7b07:8d37 with SMTP id
 ada2fe7eead31-4977b07961dmr3360779137.29.1723831796876; Fri, 16 Aug 2024
 11:09:56 -0700 (PDT)
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
 <CAKbZUD3_3KN4fAyQsD+=p3PV8svAvVyS278umX40Ehsa+zkz3w@mail.gmail.com> <CABi2SkVrEHbWa4AsffX9RXv_a-KjwZajkscZ3Bi4JWzJ4fr6wQ@mail.gmail.com>
In-Reply-To: <CABi2SkVrEHbWa4AsffX9RXv_a-KjwZajkscZ3Bi4JWzJ4fr6wQ@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 16 Aug 2024 19:09:44 +0100
Message-ID: <CAKbZUD0ZA8q0QdSs_OwbdfSvM3Ze+0MaMQsn2dKM2pN6nn3J4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mm: Optimize mseal checks
To: Jeff Xu <jeffxu@chromium.org>
Cc: Jeff Xu <jeffxu@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 6:07=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
> Please run this test on the latest kernel branch to verify:
>
> static void test_munmap_free_multiple_ranges(bool seal)
> {
>         void *ptr;
>         unsigned long page_size =3D getpagesize();
>         unsigned long size =3D 8 * page_size;
>         int ret;
>         int prot;
>
>         setup_single_address(size, &ptr);
>         FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
>
>         /* unmap one page from beginning. */
>         ret =3D sys_munmap(ptr, page_size);
>         FAIL_TEST_IF_FALSE(!ret);
>
>         /* unmap one page from middle. */
>         ret =3D sys_munmap(ptr + 4 * page_size, page_size);
>         FAIL_TEST_IF_FALSE(!ret);
>
>         /* seal the last page */
>         if (seal) {
>                 ret =3D sys_mseal(ptr + 7 * page_size, page_size);
>                 FAIL_TEST_IF_FALSE(!ret);
>         }
>
>         /* munmap all 8  pages from beginning */
>         ret =3D sys_munmap(ptr, 8 * page_size);
>         if (seal) {
>                 FAIL_TEST_IF_FALSE(ret < 0);
>
>                 /* verify none of existing pages in  the range are unmapp=
ed */
>                 size =3D get_vma_size(ptr + page_size, &prot);
>                 FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
>                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
>
>                 size =3D get_vma_size(ptr +  5 * page_size, &prot);
>                 FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
>                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
>
>                 size =3D get_vma_size(ptr +  7 * page_size, &prot);
>                 FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
>                 FAIL_TEST_IF_FALSE(prot =3D=3D 4);
>         } else {
>                 FAIL_TEST_IF_FALSE(!ret);
>
>                 /* verify all pages are unmapped */
>                 for (int i =3D 0; i < 8; i++) {
>                         size =3D get_vma_size(ptr, &prot);
>                         FAIL_TEST_IF_FALSE(size =3D=3D 0);
>                 }
>         }
>
>         REPORT_TEST_PASS();
> }
>

FWIW this test does not work correctly on my end due to sealed VMAs
getting merged. I hacked up setup_single_address to work around that,
and the test does pass on both 6.10.5 and my local mseal changes
branch.

--=20
Pedro

