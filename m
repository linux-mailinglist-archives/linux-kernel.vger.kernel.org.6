Return-Path: <linux-kernel+bounces-192102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22598D1867
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097DEB2675F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E87B16B737;
	Tue, 28 May 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnq0Z0NU"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422141667FE
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891659; cv=none; b=oNKgWXi/5O/78q7yiqFUs1jlONR+5Z+AI7zlA41qsVUfRn3VA8zu53tIEqrD7e92DNaUNHG1cxkSqnfcoF1cX2Xmn+f/03JFvoTL2kI+q1oVHXtrk8jVNPqgtx8L1cRVXJthK28x/zxhFeFL8O5ojU3UWy5t72VbCfwa4FWYuk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891659; c=relaxed/simple;
	bh=RIajptdCcq/rafFhvv82Wc0kj1l/1DfJzTJxG03pLEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnbH+CEVIgxwL6svNFAauX/mQgoG7xA09Ws2HzAtR7S1dqoiCl+DCj0muMzd7Q+JSPgZYE6fcHLGrrjQvaLmljuwaGdQFdPf2TRPUdWeKLyiE1GJ5OnOMLH68SsCB+u7LmtSbP0HrVPu3FIZvrVCgxyIfm63iqK7/q9o+RyFLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnq0Z0NU; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62a08b1a81bso5911747b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716891657; x=1717496457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL61El2MUvMXM1QO7xxPZA2/oELsPgEiA0VxGFI8MCw=;
        b=nnq0Z0NU7GaT7doqKlPYzZSxwkd7cs1mtUEq5YZii4yyI0jSWAfw+KW+aYEwpGEJWC
         hJeVpwgPnLsZ2WhL4UO0516YTJEyJ6ngmGIDavxSxymEfEy72egI9tidrEgjz6KgpwIV
         lUcvxWQHe01cJHpjfMTFmAGyEWBHwKKQ1qLMIIVfNU4Yg7yEkxcWCfnncVKkqW1tx8n7
         PV2nFZUGQAhg5ZSLoPiZgC2bohiDOtQVI8UkKRCvEmTNFyTpmpjnyCcpIhlnAdU7DSk4
         9vy452L2AIYRZnMMXjkzCJHrd1lxLqikDBrgDnhgSbUo1yht1N/tELksWUJI2WZFAUmS
         sffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716891657; x=1717496457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL61El2MUvMXM1QO7xxPZA2/oELsPgEiA0VxGFI8MCw=;
        b=LV014wD868pJBbRLK3kxY/hVGzHdSl239Q6C0EBYNVX97FiImZwk8AnqgCXxUCuP0h
         BdQa10Egrexh39MhOXtOJ/k3KvtCAnER9zYyf7YdWsIAKY5xA7Hrioq89MT3np8j+K0D
         iZ2D2tziZL5GizqaSWij+k5jsPx/8uBHmOl0LYdGfb4LfSQXK0WU/g6QEsvtKQPfdid3
         59Ux7MGa8G1Ne6Wi2ZqdL0tIOYP+m+q/Oljfw88yjnMMgk0+CEAT/IutBKdMhMb9JKoy
         dUqcQG6gmYoMHcsB4oHiPxsBl/kaC6pc83ZXb9aw5guQWlhMnYjd5bM8+UjjAkh/a0YG
         gIZg==
X-Forwarded-Encrypted: i=1; AJvYcCXcCy5OAeBkrrSMBAm1n5GuEVLKEjGyXg5r37ycRZAdErdJn76zCjAHsAir+DV7jbaE5Hp4Go+3e3pMVOuWmZcu1dxlosjmw29WUy6R
X-Gm-Message-State: AOJu0Yz5b8Oe5RihNcpuAkGzN23s+024ALAR6VhUjHqbIad/xdxPXTF6
	sF8ogSkEputAzk8ePFLq2iHPzt7aO0clwpl9T80UgDRHrXRGUVagShZopaNaPBXu/x2FLhi3PAB
	gO0y1JsvYD7llKCgmrI1mKw5Zpmb+RkYdjFKn
X-Google-Smtp-Source: AGHT+IGVefpydQUP287F0eKALWCJSpkCj+j+25zdNrdIpDbUXLUcnBDJt6zW3qBe07KpY0NpzvdOvUjXQ8IToL/ELxo=
X-Received: by 2002:a25:ad0b:0:b0:df4:db5c:99f4 with SMTP id
 3f1490d57ef6-df77224071fmr10979349276.53.1716891656941; Tue, 28 May 2024
 03:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524232804.1984355-1-bjohannesmeyer@gmail.com>
In-Reply-To: <20240524232804.1984355-1-bjohannesmeyer@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 28 May 2024 12:20:15 +0200
Message-ID: <CAG_fn=U2U5j8VxrkKGHEOdbpheVXM08ExFwkqNhz4qv2EtTjWg@mail.gmail.com>
Subject: Re: [PATCH] kmsan: introduce test_unpoison_memory()
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 1:28=E2=80=AFAM Brian Johannesmeyer
<bjohannesmeyer@gmail.com> wrote:
>
> Add a regression test to ensure that kmsan_unpoison_memory() works the sa=
me
> as an unpoisoning operation added by the instrumentation. (Of course,
> please correct me if I'm misunderstanding how these should work).
>
> The test has two subtests: one that checks the instrumentation, and one
> that checks kmsan_unpoison_memory(). Each subtest initializes the first
> byte of a 4-byte buffer, then checks that the other 3 bytes are
> uninitialized. Unfortunately, the test for kmsan_unpoison_memory() fails =
to
> identify the 3 bytes as uninitialized (i.e., the line with the comment
> "Fail: No UMR report").
>
> As to my guess why this is happening: From kmsan_unpoison_memory(), the
> backing shadow is indeed correctly overwritten in
> kmsan_internal_set_shadow_origin() via `__memset(shadow_start, b, size);`=
.
> Instead, the issue seems to stem from overwriting the backing origin, in
> the following `origin_start[i] =3D origin;` loop; if we return before tha=
t
> loop on this specific call to kmsan_unpoison_memory(), then the test
> passes.

Hi Brian,

You are right with your analysis.
KMSAN stores a single origin for every aligned four-byte granule of
memory, so we lose some information when more than one uninitialized
value is combined in that granule.
When writing an uninitialized value to memory, a viable strategy is to
always update the origin. But if we partially initialize the granule
with a store, it is better to preserve that granule's origin to
prevent false negatives, so we need to check the resulting shadow slot
before updating the origin.
This is what the compiler instrumentation does, so
kmsan_internal_set_shadow_origin() should behave in the same way.
I found a similar bug in kmsan_internal_memmove_metadata() last year,
but missed this one.

I am going to send a patch fixing this along with your test (with an
updated description), if you don't object.

> Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
> ---
>  mm/kmsan/kmsan_test.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index 07d3a3a5a9c5..c3ab90df0abf 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -614,6 +614,30 @@ static void test_stackdepot_roundtrip(struct kunit *=
test)
>         KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  }
>
> +/*
> + * Test case: ensure that kmsan_unpoison_memory() and the instrumentatio=
n work
> + * the same
> + */
> +static void test_unpoison_memory(struct kunit *test)
> +{
> +       EXPECTATION_UNINIT_VALUE_FN(expect, "test_unpoison_memory");
> +       volatile char a[4], b[4];
> +
> +       kunit_info(
> +               test,
> +               "unpoisoning via the instrumentation vs. kmsan_unpoison_m=
emory() (2 UMR reports)\n");
> +
> +       a[0] =3D 0;                                     // Initialize a[0=
]
> +       kmsan_check_memory((char *)&a[1], 3);         // Check a[1]--a[3]
> +       KUNIT_EXPECT_TRUE(test, report_matches(&expect)); // Pass: UMR re=
port
> +
> +       report_reset();
> +
> +       kmsan_unpoison_memory((char *)&b[0], 1);  // Initialize b[0]
> +       kmsan_check_memory((char *)&b[1], 3);     // Check b[1]--b[3]
> +       KUNIT_EXPECT_TRUE(test, report_matches(&expect)); // Fail: No UMR=
 report
> +}
> +
>  static struct kunit_case kmsan_test_cases[] =3D {
>         KUNIT_CASE(test_uninit_kmalloc),
>         KUNIT_CASE(test_init_kmalloc),
> @@ -637,6 +661,7 @@ static struct kunit_case kmsan_test_cases[] =3D {
>         KUNIT_CASE(test_memset64),
>         KUNIT_CASE(test_long_origin_chain),
>         KUNIT_CASE(test_stackdepot_roundtrip),
> +       KUNIT_CASE(test_unpoison_memory),
>         {},
>  };
>
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/20240524232804.1984355-1-bjohannesmeyer%40gmail.com.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

