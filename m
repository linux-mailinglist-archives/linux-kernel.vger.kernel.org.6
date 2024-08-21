Return-Path: <linux-kernel+bounces-295905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86595A2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EE22822FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACD51534E6;
	Wed, 21 Aug 2024 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MES+8Yrr"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E314F9C5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257648; cv=none; b=gC3/fCK1Ct5Lp+PjqGfvbYOXenNXnGyWjHMx8wgdPfDBpoVfNRTV+qWqr7psHTopjkrJVU7e7j9RQNBK0LHcAAnf59yjH4GNPN1umsww2XW/cHwjPZUgiVDCa00nyJFke/LUSeL+NzvOcvnE3T4oQTyFjcx/IWo7n6tML6Gg5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257648; c=relaxed/simple;
	bh=CBjKOFlBu9QKNKkKLlOxMEg3XFG07+9FIyd5ELFEvhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DX5ZHpFXWo4wt0LL0p9r82CbpmQMWsIZL2R1NWlNjItIELQdvWGgURFd7CViSkb4Es99DTi096ZU0tDuPzAPz9Be6PdM7cbM01mQYrAZFADkGi9knAdJHLkKKzVnebn8McI/IbE0ZwVc5wDAUKTHJqR5fMqoNEaAof2ArDnMN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MES+8Yrr; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2611dcc3941so792213fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724257645; x=1724862445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Si3f0cgXJ9GhZQgrHEXWJqwMRCLXgXh7BKkzSMYJXtE=;
        b=MES+8YrrGkJZb+DkXH8ujElW5vx8j7GpxyQTlIduhmCkPVWxfuYVrBeVPkSS6hrcYF
         v91LOmktf0bwzFlhstzueb9xm/LH+WnblElXwwv/4TdIFyJ1HUzgc693y84PEjPmKj9Z
         aHJV/4M5XfbHHDF4iLiUOxDntfafDu/j9Ukyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257645; x=1724862445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Si3f0cgXJ9GhZQgrHEXWJqwMRCLXgXh7BKkzSMYJXtE=;
        b=nwEPOXQijbfothT8xiu2c6YcSqowWdiQXuuv6vrMU0WN03QQQaJm6ht4viONCqe6zr
         hJ5a6S9MELezSTKcMeWhyiHWoT9pG2MVgXa6+nyb/sDh9P7ovSxNvd8l7pqPhPHm0O/+
         FTesU6aa94u0OfvRdQ2K1wbHW0+Wk8wjn8K9ZziU7RqQVktrO2wZQnRMQlhCPQr1hL8Z
         w0/rrPY5WeMzmPDZtgjBfN2DgXHyzkxTq9ZuaX8nVgHkIF/XoU6iLDrxrFGPeXG5OF3l
         cnJJlhSCE5Z1Lzyq5hRfFZO/CZSPg3k0IvK9suPOjuTmTeAzcrn5G0TNgKJLP65UBYX8
         kSBw==
X-Forwarded-Encrypted: i=1; AJvYcCWcet80+CRvgXRSn9rt573XjNBMRE1yriNZbjTFhEL3024OBnTZI3+dL3tNNrMbW6K1Hz8lVdEszlMWbAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGXc8+dRS10XgGe1/0YybQUjXm7MeSLLe2v3Tl7e+DySWczZP
	LfEJoA+RxSao2a69gFGOslrDJOgIH8ZIJMh8uWOpDBi0SPPOQiS2r3pd6g3PXvmrA6GS6PRx146
	xjuoJBQtT/MB7c6loFmi+E/0TLaglfnI7iJMT
X-Google-Smtp-Source: AGHT+IF9LYNubb8DZ72K7h88tUTIb0v91ADOGuhtngf8RP61y4Nf6wvMOrvvCOwowYLDE697/Ka6vKadkTLmkDYLRA0=
X-Received: by 2002:a05:6870:818f:b0:26f:df8d:fc13 with SMTP id
 586e51a60fabf-2737eeb7326mr1734080fac.2.1724257645346; Wed, 21 Aug 2024
 09:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-7-d8d2e037df30@gmail.com> <CABi2SkWPiGJTv3FEPxD1OJYUAoePab8jG+CSd58UHqEsBeOYbA@mail.gmail.com>
 <CAKbZUD3Siwq4GZdOy-2n_txG2BMQ=m7PypB53sQxeLcBE4xYGA@mail.gmail.com>
In-Reply-To: <CAKbZUD3Siwq4GZdOy-2n_txG2BMQ=m7PypB53sQxeLcBE4xYGA@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 21 Aug 2024 09:27:12 -0700
Message-ID: <CABi2SkXaBv85JF6gTd1w-f_i700YSj5JoK8z605bzd6gbPjKkw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] selftests/mm: add more mseal traversal tests
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:20=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Wed, Aug 21, 2024 at 4:56=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wro=
te:
> >
> > Hi Pedro
> >
> > On Fri, Aug 16, 2024 at 5:18=E2=80=AFPM Pedro Falcato <pedro.falcato@gm=
ail.com> wrote:
> > >
> > > Add more mseal traversal tests across VMAs, where we could possibly
> > > screw up sealing checks. These test more across-vma traversal for
> > > mprotect, munmap and madvise. Particularly, we test for the case wher=
e a
> > > regular VMA is followed by a sealed VMA.
> > >
> > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > ---
> > >  tools/testing/selftests/mm/mseal_test.c | 111 ++++++++++++++++++++++=
+++++++++-
> > >  1 file changed, 110 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/=
selftests/mm/mseal_test.c
> > > index 259bef4945e9..0d4d40fb0f88 100644
> > > --- a/tools/testing/selftests/mm/mseal_test.c
> > > +++ b/tools/testing/selftests/mm/mseal_test.c
> > > @@ -766,6 +766,42 @@ static void test_seal_mprotect_partial_mprotect(=
bool seal)
> > >         REPORT_TEST_PASS();
> > >  }
> > >
> > > +static void test_seal_mprotect_partial_mprotect_tail(bool seal)
> > > +{
> > > +       void *ptr;
> > > +       unsigned long page_size =3D getpagesize();
> > > +       unsigned long size =3D 2 * page_size;
> > > +       int ret;
> > > +       int prot;
> > > +
> > > +       /*
> > > +        * Check if a partial mseal (that results in two vmas) works =
correctly.
> > > +        * It might mprotect the first, but it'll never touch the sec=
ond (msealed) vma.
> > > +        */
> > > +
> > > +       setup_single_address(size, &ptr);
> > > +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > > +
> > > +       if (seal) {
> > > +               ret =3D sys_mseal(ptr + page_size, size);
> > you are allocating 2 pages , and I assume you are sealing the second
> > page, so the size should be page_size.
> > ret =3D sys_mseal(ptr + page_size, page_size);
>
> Yes, good catch, it appears to be harmless but ofc down to straight luck.
> I'll send a fixup for this and the other mistake down there.
>
> >
> > > +               FAIL_TEST_IF_FALSE(!ret);
> > > +       }
> > > +
> > > +       ret =3D sys_mprotect(ptr, size, PROT_EXEC);
> > > +       if (seal)
> > > +               FAIL_TEST_IF_FALSE(ret < 0);
> > > +       else
> > > +               FAIL_TEST_IF_FALSE(!ret);
> > > +
> > > +       if (seal) {
> > > +               FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &pro=
t) > 0);
> > > +               FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > To test partial mprotect, the test needs to add the check for the
> > first page to be changed, Also to avoid the merge,  a PROT_NONE page
> > can to be added in front.
>
> No, I'm leaving partial mprotect to be undefined. It doesn't make
> sense to constraint ourselves, since POSIX wording is already loose.
>
> >
> > > +       }
> > > +
> > > +       REPORT_TEST_PASS();
> > > +}
> > > +
> > > +
> > >  static void test_seal_mprotect_two_vma_with_gap(bool seal)
> > >  {
> > >         void *ptr;
> > > @@ -983,6 +1019,41 @@ static void test_seal_munmap_vma_with_gap(bool =
seal)
> > >         REPORT_TEST_PASS();
> > >  }
> > >
> > > +static void test_seal_munmap_partial_across_vmas(bool seal)
> > > +{
> > > +       void *ptr;
> > > +       unsigned long page_size =3D getpagesize();
> > > +       unsigned long size =3D 2 * page_size;
> > > +       int ret;
> > > +       int prot;
> > > +
> > > +       /*
> > > +        * Check if a partial mseal (that results in two vmas) works =
correctly.
> > > +        * It might unmap the first, but it'll never unmap the second=
 (msealed) vma.
> > > +        */
> > > +
> > > +       setup_single_address(size, &ptr);
> > > +       FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > > +
> > > +       if (seal) {
> > > +               ret =3D sys_mseal(ptr + page_size, size);
> > ret =3D sys_mseal(ptr + page_size, page_size);
> >
> > > +               FAIL_TEST_IF_FALSE(!ret);
> > > +       }
> > > +
> > > +       ret =3D sys_munmap(ptr, size);
> > > +       if (seal)
> > > +               FAIL_TEST_IF_FALSE(ret < 0);
> > > +       else
> > > +               FAIL_TEST_IF_FALSE(!ret);
> > > +
> > > +       if (seal) {
> > > +               FAIL_TEST_IF_FALSE(get_vma_size(ptr + page_size, &pro=
t) > 0);
> > > +               FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
> > To test partial unmap, the test needs to add the check for the first
> > page to be freed, Also to avoid the merge,  a PROT_NONE page needs to
> > be in front.
>
> I'm not testing partial unmap. Partial unmap does not happen. I have
> told you this before.
>
ok.  Then this test should be as below ? (need to add PROT_NONE page
before and after)
  size =3D get_vma_size(ptr, &prot);
  FAIL_TEST_IF_FALSE(size =3D=3D 2 * page_size);
  FAIL_TEST_IF_FALSE(prot=3D=3D0x4)


> >
> > The test_seal_munmap_partial_across_vmas  shows the behavior
> > difference with in-loop approach and out-loop approach. Previously,
> > both VMAs will not be freed, now the first VMA will be freed, and the
> > second VMA (sealed) won't.
> >
> > This brings to the line you previously mentioned: [1] and I quote:
> > "munmap is atomic and always has been. It's required by POSIX."
>
> This is still true, the comment was a copy-and-paste mindslip. Please
> read the email thread. It has been fixed up by Andrew.
>
Which thread/patch by Andrew ? Could you please send it to me ? (I
might missed that)

> --
> Pedro

