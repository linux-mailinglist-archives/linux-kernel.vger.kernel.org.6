Return-Path: <linux-kernel+bounces-309084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CF2966600
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872F11C21B87
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3323F1B790A;
	Fri, 30 Aug 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BYm89XT/"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7471B3B32
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032817; cv=none; b=DjLqvNOQj9qXPLCvjkVgI4zsK0RCG/ADRGYXWsYjO4gS4DhXs9sytNaoc6pw2ce/NicKqckILfwokQIMKutML4RafvkuF9Gslmmll08OcIQVWtM68UcoTKlbG8kERbFRIpesZ+7ZsnIWz00eJf45i9x9+QrQGBOHK6RfjkFDplo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032817; c=relaxed/simple;
	bh=TLYQmK+4gX5WbU9E7NXCP6yB0z2vPUME2uAjtju5Dkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hb7A/OlyD86swe47OwD4uy6X9UkAytiNaEiErPTiwuE/biFWFONKI7vxITaWWrlZfCys/5rXWupBYG7wHtyM6WIuEyIiZx0/DUok1GAcRp2KnbC7ov8IjJCY3XR+ftf0N3aCR70mf7ZQtDdo5Ny/OKQBZglyE7+FoeYeisDYBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BYm89XT/; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-26110765976so131535fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725032813; x=1725637613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8bk6NlnoUxn0Dwk2YP4Jj7Nsfj0s1LGq69qFBq4LJs=;
        b=BYm89XT/9RZ57D8ioxn61LgtVDSSnp1nClzDGe9i5cRLIqppfT1I/Q6m7CvNa0cgVN
         FWLlmm6/dYUtt1hk/A4wNLaokj1KiJoqOspqeFsTLomomgb0KDR+gCrbyRYcqHdirjqZ
         dpU+YK7x2pm6zrBX2y0LOyjALjjpj7s7NgNJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725032813; x=1725637613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8bk6NlnoUxn0Dwk2YP4Jj7Nsfj0s1LGq69qFBq4LJs=;
        b=rwI02Eggn86HdYPwPav8btB6H4JwXNYYDPOM6PXK7UOCEDOfvlp/lrlThmxCARZX6o
         EK9fRu+R02TyZ4WsC/9NOj76/MlPAfik+yXybIJKVnWMyOqHbn+UCp1GCIxeQbo1OeBN
         Jtl7s6vw3U3skwOAfeRZ3BtPfsWyPU/QxLt/Ix590s4DG9goXQy83XLsyhSoelDYdkNk
         0g1ntqbgtfv9wRV6vuJhRdlAxdFqrVc79iKEm39ZzGp8X5Q/blBNdW8pKgq6uchWJecI
         kiZnyX0D2lmzMKgbTl5lSt0bODDb86PdBiygmY99aGyYvP4/MmxOUmZmaZPadKleuY9j
         UyNg==
X-Forwarded-Encrypted: i=1; AJvYcCXdCAXFRiT8Jj3bhClN7OAE54jXID84c5Jb4hoPwcvW7G6Oq+4sAA8g9q8hQqv0M90Y8HaZgOik/FDif1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEttkQNtc8OG8pNlTXAt9yrYiioqNzclJJIwKeqN0h5s13+pim
	pKOYgJXjMfgmE96W+Grm2lPVKdA5zsaWg6RgTiQWgjg1fb2N5RCKerVtBLxXbmZB6GqRyE3ujFf
	c+0/1xdeCgRF/yEupXCHWV0xQzgEkHqCkru1Z
X-Google-Smtp-Source: AGHT+IEAjSF1X499v/FKP2PTPABhbt9CR+HTuwUDdQPyxVSzRisW3oW8eIPO3E4b/V5N3gxkpw61MmKTYe2iyF/kMgY=
X-Received: by 2002:a05:6870:f29c:b0:269:1020:a8a0 with SMTP id
 586e51a60fabf-277b0be0b23mr1403373fac.4.1725032813260; Fri, 30 Aug 2024
 08:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829214352.963001-1-jeffxu@chromium.org> <20240829214352.963001-3-jeffxu@chromium.org>
 <ggnces6muodr4q27yuprhyhjovn7vlaj4pdnmte44kg2of62sx@ihwlrb52hsmm>
In-Reply-To: <ggnces6muodr4q27yuprhyhjovn7vlaj4pdnmte44kg2of62sx@ihwlrb52hsmm>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 30 Aug 2024 08:46:41 -0700
Message-ID: <CABi2SkUESzc6yjf5TbfZM7gHDcx4wXC5R8+xtqgYZAmY1fm64A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] selftests/mm: mseal_test add sealed madvise type
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, lorenzo.stoakes@oracle.com, 
	broonie@kernel.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 5:52=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Aug 29, 2024 at 09:43:50PM GMT, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add a testcase to cover all sealed madvise type.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/mseal_test.c | 108 +++++++++++++++++++++++-
> >  1 file changed, 107 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > index adc646cf576c..ae06c354220d 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -2121,6 +2121,107 @@ static void test_seal_madvise_nodiscard(bool se=
al)
> >       REPORT_TEST_PASS();
> >  }
> >
> > +static void test_seal_discard_madvise_advice(void)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 4 * page_size;
> > +     int ret;
> > +     int sealed_advice[] =3D {MADV_FREE, MADV_DONTNEED,
> > +             MADV_DONTNEED_LOCKED, MADV_REMOVE,
> > +             MADV_DONTFORK, MADV_WIPEONFORK};
> > +     int size_sealed_advice =3D sizeof(sealed_advice) / sizeof(int);
> > +
> > +     setup_single_address(size, &ptr);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +     ret =3D seal_single_address(ptr, size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     for (int i =3D 0; i < size_sealed_advice; i++) {
> > +             ret =3D sys_madvise(ptr, size, sealed_advice[i]);
> > +             FAIL_TEST_IF_FALSE(ret < 0);
> > +             FAIL_TEST_IF_FALSE(errno =3D=3D EPERM);
> > +     }
> > +
> > +     REPORT_TEST_PASS();
> > +}
>
> This can replace some of the other 9 discard tests already there, no?
>
No, this  is focused on enumerating all types.

> > +
> > +static void test_munmap_free_multiple_ranges(bool seal)
> > +{
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +     unsigned long size =3D 8 * page_size;
> > +     int ret;
> > +     int prot;
> > +
> > +     setup_single_address(size, &ptr);
> > +     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > +
> > +     /* unmap one page from beginning. */
> > +     ret =3D sys_munmap(ptr, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     /* unmap one page from middle. */
> > +     ret =3D sys_munmap(ptr + 4 * page_size, page_size);
> > +     FAIL_TEST_IF_FALSE(!ret);
> > +
> > +     size =3D get_vma_size(ptr + page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +     size =3D get_vma_size(ptr +  5 * page_size, &prot);
> > +     FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +     FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +
> > +     /* seal the last page */
> > +     if (seal) {
> > +             ret =3D sys_mseal(ptr + 7 * page_size, page_size);
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +             size =3D get_vma_size(ptr +  1 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  5 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  7 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +     }
> > +
> > +     /* munmap all 8  pages from beginning */
> > +     ret =3D sys_munmap(ptr, 8 * page_size);
> > +     if (seal) {
> > +             FAIL_TEST_IF_FALSE(ret);
> > +
> > +             /* verify mapping are not changed */
> > +             size =3D get_vma_size(ptr + 1 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 3 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  5 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +
> > +             size =3D get_vma_size(ptr +  7 * page_size, &prot);
> > +             FAIL_TEST_IF_FALSE(size =3D=3D 1 * page_size);
> > +             FAIL_TEST_IF_FALSE(prot =3D=3D 4);
> > +     } else {
> > +             FAIL_TEST_IF_FALSE(!ret);
> > +
> > +             for (int i =3D 0; i < 8; i++) {
> > +                     size =3D get_vma_size(ptr, &prot);
> > +                     FAIL_TEST_IF_FALSE(size =3D=3D 0);
> > +             }
> > +     }
> > +
> > +     REPORT_TEST_PASS();
> > +}
>
> Unrelated munmap change.
will move.

>
> --
> Pedro

