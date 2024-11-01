Return-Path: <linux-kernel+bounces-393038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19EF9B9B3D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75CB7282853
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECAE16DED5;
	Fri,  1 Nov 2024 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1xLopFK"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509211D555
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730504331; cv=none; b=JY0eQT09V9EyBYTgF3tAN2F5lntVQEsdXQKk/q5eetPVtjxakHpi/nK2N1tmSMEMXbgxA4Thc4ftW1CJbSjfOaebakbTsbMtQiEzcbl8vkuT8eswd2DnWYHN+bWM+nTSSzRF3LzypkN9DUqAY4pj3+n0K7nhLalsf4A36jxpjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730504331; c=relaxed/simple;
	bh=xNwR6xox2tALSIcUV4hDPRvnR5puoyfvbnJ+TH9HHAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVZ4CvYb05gd9WG8XEmnoaHPqpGGGrpZP3q9W+kvA5ffwbFkRfP1QnUsF0McEyOrS6ZkPr0o1GPPIWaw0x2bugY5Ak2cRIuA5hE4Pyh8Ttjakj85GuzhzgGDUffFwtcpWPByLtZcwivQxSYK6S0yryegaroHAtA/XBgopr5RzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1xLopFK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1591072f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 16:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730504328; x=1731109128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7fKD6F8/BWM/aqkIjVZ9Hrc4vMUOZTXgZCF9mCVBq8=;
        b=d1xLopFK+1pPP+1UXfpLKZZwOVZ3nQ4chHuWpgCBzyZpGxYkCzwljPhEaQxwppjYbB
         EILURYtw8/7I0BVoEJBsMCcRmFUeuFqbRF9SfGEOGnKFJOEDN6d4+Dw979MCZro4x87N
         R+RA6aB2QsOi9ORvIQz0hFZkcUCpetcyud6DjXML6VTcujlQezFNeeBKnTLQcv9s9tYn
         mrkTmlOWBYqUZeOhvrYYUQYJGk0eOd8YQdP78zceT3p3bYdgULEStgmgtT01pH7Skk30
         UH63tGu7B4HivZI8pTowrnyRzsCinzgj+6vOoLWOGAjDD6T7fIpMt8PH+rSNg4G8CUld
         snRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730504328; x=1731109128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7fKD6F8/BWM/aqkIjVZ9Hrc4vMUOZTXgZCF9mCVBq8=;
        b=o5CVKndFn8bCoYjbh9HsUm2Gd3IsaK3O4+us+JhnoSVYKa/qQQbEbcnChpjEkqgJkh
         1PS95PDy9+lX3ajR7AW/RlJyEWAadJyw20xYmK53bn2Yw+3eWLYSrhjM/RORPhqRFM+3
         2FEkcSRpASo7a3nkFWJZcqrpcUj0uz9oe5nGEE8VYWFbVjbH9IahPif7/PBMvH7tGqub
         FBcYGQL3igleaLmXzZ8ohvb0F0rV50ArG9cXvIoM10/JiFAqehev3ZfDz20n9bjoa4oQ
         cGrEH+xiggEanXgJWpnorSY041XJsg0JCdTD+BN7FqL7lqaaChQjsVsPNm7HQ5hq9VVJ
         rcog==
X-Forwarded-Encrypted: i=1; AJvYcCVkQ+Di+998o4537Xgp+TanzDi2vPX+xHe+G1VASeEcGEMRnJHUlQNdBmK+Ydzw0UiAOxVxjl9laQHh1Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Zlt5bSa0eBSAaji8ahbjCM/Yoje0SlftPuGKpr283PhxCIE0
	9Ey6pMKKA31LJYyu07orvUQQ9AC6TMHwDRIi8u6B0R4n4vEeduRRJauRF40u8k4UQlF5iEK0Z6A
	BqGQRVDcDRHfMfGmSh3BqQnDPxuQ=
X-Google-Smtp-Source: AGHT+IHrJ9g0lcBbtnhjUni6drYwVaoLxB7mmcwBDwR/x216TC3SsjGhhKOWmgJTDSgYtLyin7atZNtGZ/Ao9fh/Jl0=
X-Received: by 2002:a05:6000:156e:b0:37d:33ab:de30 with SMTP id
 ffacd0b85a97d-381c7a3a535mr4042932f8f.8.1730504327558; Fri, 01 Nov 2024
 16:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101184011.3369247-1-snovitoll@gmail.com> <20241101184011.3369247-3-snovitoll@gmail.com>
In-Reply-To: <20241101184011.3369247-3-snovitoll@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 2 Nov 2024 00:38:36 +0100
Message-ID: <CA+fCnZd9V8okaozn-LBA3w=TsuVbTR=4Hey+w1+_CRDVQV_XEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: change kasan_atomics kunit test as KUNIT_CASE_SLOW
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, elver@google.com, arnd@kernel.org, 
	glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 7:40=E2=80=AFPM Sabyrzhan Tasbolatov <snovitoll@gmai=
l.com> wrote:
>
> During running KASAN Kunit tests with CONFIG_KASAN enabled, the
> following "warning" is reported by kunit framework:
>
>         # kasan_atomics: Test should be marked slow (runtime: 2.604703115=
s)
>
> It took 2.6 seconds on my PC (Intel(R) Core(TM) i7-7700K CPU @ 4.20GHz),
> apparently, due to multiple atomic checks in kasan_atomics_helper().
>
> Let's mark it with KUNIT_CASE_SLOW which reports now as:
>
>         # kasan_atomics.speed: slow
>
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  mm/kasan/kasan_test_c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index 3e495c09342e..3946fc89a979 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -2020,7 +2020,7 @@ static struct kunit_case kasan_kunit_test_cases[] =
=3D {
>         KUNIT_CASE(kasan_strings),
>         KUNIT_CASE(kasan_bitops_generic),
>         KUNIT_CASE(kasan_bitops_tags),
> -       KUNIT_CASE(kasan_atomics),
> +       KUNIT_CASE_SLOW(kasan_atomics),
>         KUNIT_CASE(vmalloc_helpers_tags),
>         KUNIT_CASE(vmalloc_oob),
>         KUNIT_CASE(vmap_tags),
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

