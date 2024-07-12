Return-Path: <linux-kernel+bounces-251218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB2F93023A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5687B283961
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC74762FF;
	Fri, 12 Jul 2024 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW5+6xRc"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF451C21;
	Fri, 12 Jul 2024 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720824464; cv=none; b=uLxrSTP6mQ4uFXGKr/W1TEjQ7Kr9d0Nk/VzUTN/KazpqDm+ml9AL4QogN43JZNoqKKiZX12ILGT30TTt8vM0HX9j+IXrqMqU0mVjkSy1hiVQ9+Kmk/nQpHOIh4KrKZrUOxdltlZb76R4w5qSQwmPX+gAz+ayaRizKEKb7gaBKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720824464; c=relaxed/simple;
	bh=93N5LhNbppX6DibUZOyQ9a4CYvTrdXRCEM5Ojg9KJEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e86Lt4qfG7+7W0cTUZqqQByAlXSe62E7vN4MtMYgjsZeqw0YVrP1SPsLto/l1Lg2URH5dDphWrrWKkPYHyCQ8wjQ8OIUICKmnhccunvtRhHd2Jk0qXyn2s9up/JIwMGifily68p67tY91+Nja9MwYuXmhCLnkx8IhPnjIXjDCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW5+6xRc; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b2c95b6c5aso13222576d6.2;
        Fri, 12 Jul 2024 15:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720824461; x=1721429261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ngiJf14XEWABtOeJ3ozB6Gsd22dnKoZDQl3XHj467I=;
        b=ZW5+6xRcNorfAjVn+i/5X+xVOynbXHoTm8NrMsMERnxr8/iUB1ZO0tHYn9Qc0fcV6/
         THBnZ1eoEMO2p0/EAJO5/4HSr+gYjr21/SE24c9ts8jn5a6s3D0FyXjZ5f6lFQ3nj4fD
         bvXZHPH4jL9yBjOkNZzZRC8L8gJ5FkvZB2CN75TOCrJEeK6ewRgzyEsozowZON9g001N
         pBi/1y5Aj0DBw9q//MRvrJonDoQfXjp9LQjmN3h/Ua0Kzt+pnSAgOfdvMw5hvHKU5lpp
         BdBDjSYAWr8IQIPtaxKl+h6lZv4KnY49rX8teqe9t92Nnfk2xXMx+ULg8rXPgfz1gJEP
         Mb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720824461; x=1721429261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ngiJf14XEWABtOeJ3ozB6Gsd22dnKoZDQl3XHj467I=;
        b=AEX9y//DycfgihFjxG+DVjjVJ2/grhEwt01LKfmw6TGGVdQiAkWDeZQB2brbCti14j
         IX/IZonRVmXW6XiTI8MEGe1lXf0MkF5ZtDQ1xSN0FN2KK+CPRMoX0ed2YXfcRwTRJkiU
         u7ewW4UJisuhnCeNQQwAcPK7tky1TkLz2KLRhhJwVSQ4rDc42F2+dVeQEMDsORAtJDJJ
         SpSNHUSrMAms3AL1CL+8uzLl+ugAQpP/bkSpVAteDM4QrJItTdUFQ+SVDJcQFpi1FDI+
         vJRx2ntAWxNKIOBbnxKsXAX9r+rV6uOWibb0qdkoiI3zrsww+xSkdXq0Lvg/6/PLFiTp
         buJg==
X-Forwarded-Encrypted: i=1; AJvYcCUANOk6fv4f/46u2UUM6BTftF4bFiS8tSY+gaP7HZw0Vawv49xVKj21iOlDXT/+dljzcmCe3NU/g871YvjxyrvcCd49BwjRf3DJI3jbrraQG38uo3BsCC7tGh8Zhm7tqZG3yvP7ho4D
X-Gm-Message-State: AOJu0Yy1qX84c5TJu2njf0RwVZNTF87dZ61G9k+iiHkNa8X4zCtLPGkD
	yBKVNee12fjmTvwGb61rC3SUvG9ZKjVud7CIagp67VgMfinHfX9WfPTngMVHYrAtZwN0EaEgipV
	RKvrM9zcAK1ZjULkM8yEkDh6mnJg=
X-Google-Smtp-Source: AGHT+IGTFXf8puoeZ5MyN9OXLWTgTyU6STMwzKLWRJXmrpsdd3JWi3k+aSwvASu4YXbdUjpZiK89WwJzJgF/GnYNF80=
X-Received: by 2002:a05:6214:1c86:b0:6b5:dd7d:f899 with SMTP id
 6a1803df08f44-6b61bc7e962mr146069556d6.1.1720824461341; Fri, 12 Jul 2024
 15:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-6-flintglass@gmail.com> <0afc769e-241a-404e-b2c9-a6a27bdd3c72@linux.dev>
 <CAPpoddfySkGpD5hKgqUAAMgMp2vWcivg1AzcyYh_NP1-ZsGkug@mail.gmail.com> <cc5ba793-59a4-4904-a1b3-723ebaa3a93e@linux.dev>
In-Reply-To: <cc5ba793-59a4-4904-a1b3-723ebaa3a93e@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 12 Jul 2024 15:47:30 -0700
Message-ID: <CAKEwX=Oqe8qz0YKi1pJaEgXAPC-7cXg7_NRfXb1_0VJp35X7AQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mm: zswap: store incompressible page as-is
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Takero Funaki <flintglass@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 6:26=E2=80=AFAM Chengming Zhou <chengming.zhou@linux=
.dev> wrote:
>
> On 2024/7/8 21:44, Takero Funaki wrote:
> > 2024=E5=B9=B47=E6=9C=888=E6=97=A5(=E6=9C=88) 12:56 Chengming Zhou <chen=
gming.zhou@linux.dev>:
> >
> >>>        comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->=
req), &acomp_ctx->wait);
> >>>        dlen =3D acomp_ctx->req->dlen;
> >>> -     if (comp_ret)
> >>> +
> >>> +     /* coa_compress returns -EINVAL for errors including insufficie=
nt dlen */
> >>> +     if (comp_ret && comp_ret !=3D -EINVAL)
> >>>                goto unlock;
> >>
> >> Seems we don't need to care about? "comp_ret" is useless anymore.
> >>
> >> Just:
> >>
> >> if (comp_ret || dlen > PAGE_SIZE - 64)
> >>          dlen =3D PAGE_SIZE;
> >>
> >> And remove the checkings of comp_ret at the end.
> >>
> >
> >>
> >> We actually don't need to hold mutex if we are just copying folio.
> >>
> >> Thanks.
> >>
> >
> > Thanks for reviewing.
> >
> > For comp_ret, can we consolidate all possible error codes as
> > incompressible data?
>
> Maybe we still want these debug counters? I'm not sure.

I'm a bit torn, but ATM I have no strong opinions on these two error
codes. If you do decide to consolidate these two, may I ask you to
separate it into its own patch so that we can review + discuss it
separately?

