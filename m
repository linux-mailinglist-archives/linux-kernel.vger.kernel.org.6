Return-Path: <linux-kernel+bounces-245050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BC92ADB4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FFB8B21381
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24E12BAE1;
	Tue,  9 Jul 2024 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sg9JdJ0d"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E10273FD
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487522; cv=none; b=YE3xBsCdOEyPcodfxwqKmaIPhWE57C0xX2pQ1FDJx5JEo3NAJ7RjYSqbzRFAGpmRv/Hd5YYsVOdwEzjUxEZP+sQn/AKwqg/Zryp9nfzK9eqBfU4oz+ARiFvALPxP9IOhZ9yMKgqXQnEdANMXafAXPpgBNremuIcAmE3q1+aa8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487522; c=relaxed/simple;
	bh=segswjcoYurpFRT/s+7tNOMh4FxuciGMe9+Deb9pVuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmCWyqBrKvBF0iz9CmCHcKhMYHO8y5CdFtrTHRmHvfJ77xwC6Q0QkXxDhZDkH2dmU3u58JyUBBsDfCVpDs989JFQCQXbLah/Wo3iE4vP6dhfwX+bjZnMLN+3UtS5D0oH3reFoQVrlN1oJ31VvyPlNLOU5OL+9pRu1eMW/Daeb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sg9JdJ0d; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-651da7c1531so42116637b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 18:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720487519; x=1721092319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/Fb5WdZaI9jnQ9LZ7NxKgwHJ2tSaNsUuKqsQduTjY4=;
        b=Sg9JdJ0doSee4sY53iYwWGdy+tbebXkdw8WyL+ychKkA5tn2hPtimleEHulNHXxv6Q
         ly/M+xNlDn+XbM0ZYT1jLH4zDDJ6nU1oR56oPzoUGns2fOOq81Nx9BTkTxiLhN6Ajcy1
         JOuhYI1IPfGrZ3bJGNfkYqPDCUg0VJkdz9jq7mez8NjA2cGpCFGOdtZwzhVxV5zZC0mJ
         BcMLjhphaAyoKPRSR9u2kgebBlHMddKPJv6eD2e9umiu8NbImRsHh45bp9z4edToZcZk
         MMIzULgmy/SyoPJNQltyA98Vr+vYKznr+E87pinY7tNwmyM3LXKqTS/dPc3Xjnsf4JxP
         ihwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720487519; x=1721092319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/Fb5WdZaI9jnQ9LZ7NxKgwHJ2tSaNsUuKqsQduTjY4=;
        b=GNgW1KqdUfNeEaZZR84kQupbxd59H0VihCy7+/EWEXN3VGvb0IEoalv9oB0dQTKht7
         AxlaI6OadaVlKO8RH2ZYnjktS2ibv4RLallIiD0HWu5grQXE1W7dh3+Sf06f2xvLaTXH
         KBh6HV7c1l4wrhBwLJDn1cXodZCbPjwypoor7/cyRg4ngHzpWM/CIIk4pBr47b/ohfi9
         9vzCwxI1PnWOxi5/AYjoDqsGBrg9Zt9OKv1l1WdF52gVkQjrziGL1fMFuwGj5lURcSrT
         n6tH86oM0MCW14huN8iIdi/rrpdVc0aRiQXRFm4rwJ8FtIls8AKoNMU6xUdEYLNLyVrL
         QfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC5FDM8Ne8umwwWbyWTKlpBWe9myJmBUJsyVh+bx08YzJjAa84oq1yK2arImANpS/XUpA2vQNGQmpz50cDwLsDyCvafytnmKW3Sl4g
X-Gm-Message-State: AOJu0YyporQtCnoz83a/BAYF3/26RPWB3VRysUf5Sxs9F/AZpmS5Fa7M
	EniG3wBkFTWpPVhagCrfkfylaGfS3gILud6WQtKFaNBinWxbSdUanJAt3gB3zVV3sGBx5xWi/GY
	UGRWkAJKP4MJhTmGXPZOmm+W3IVhXruPvOlSP
X-Google-Smtp-Source: AGHT+IHENx7kQydr+wUv3AkNmXsWTBHZVEOCayL1qjN6tW39ihSmF+lN2t2SdV8b2OWRs9FgaivUY65wbnjFdgb1WkI=
X-Received: by 2002:a81:430b:0:b0:63b:d0df:ffe5 with SMTP id
 00721157ae682-658f11a576emr15765267b3.45.1720487519080; Mon, 08 Jul 2024
 18:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708063236.1096395-1-alexs@kernel.org>
In-Reply-To: <20240708063236.1096395-1-alexs@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 8 Jul 2024 18:11:46 -0700
Message-ID: <CAJuCfpEjB8wvodBDB__yR8pF5F3uGMPxue-tap68RYCO0O-K1Q@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: alignment memcg_data define condition
To: alexs@kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 11:27=E2=80=AFPM <alexs@kernel.org> wrote:
>
> From: "Alex Shi (Tencent)" <alexs@kernel.org>
>
> commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
> extensions") changed the folio/page->memcg_data define condition from
> MEMCG to SLAB_OBJ_EXT. The code works well, since config SLAB_OBJ_EXT is
> fold into MEMCG in init/Kconfig.
>
> But many related functions that deal with memcg_data still defined under
> MEMCG instead of SLAB_OBJ_EXT, and FOLIO_MATCH with memcg_data are define=
d
> under MEMCG too. That looks weird and incorrect with memcg_data raw
> meaning.
>
> So let's put memcg_data under MEMCG config to alignment the definition
> with FOLIO_MATCH and its usage in functions.
>
> Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>

Hi Alex,
I believe your change breaks this condition:

https://elixir.bootlin.com/linux/v6.10-rc7/source/mm/slab.h#L101

for the cases when CONFIG_SLAB_OBJ_EXT=3Dy but CONFIG_MEMCG=3Dn.
page.memcg_data will not be there to match slab.obj_exts.
You can test that by setting CONFIG_MEM_ALLOC_PROFILING=3Dy and CONFIG_MEMC=
G=3Dn.

Therefore sorry but NAK.

> ---
>  include/linux/mm_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index ef09c4eef6d3..c067db6fa711 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -180,7 +180,7 @@ struct page {
>         /* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
>         atomic_t _refcount;
>
> -#ifdef CONFIG_SLAB_OBJ_EXT
> +#ifdef CONFIG_MEMCG
>         unsigned long memcg_data;
>  #endif
>
> @@ -343,7 +343,7 @@ struct folio {
>                         };
>                         atomic_t _mapcount;
>                         atomic_t _refcount;
> -#ifdef CONFIG_SLAB_OBJ_EXT
> +#ifdef CONFIG_MEMCG
>                         unsigned long memcg_data;
>  #endif
>  #if defined(WANT_PAGE_VIRTUAL)
> --
> 2.43.0
>
>

