Return-Path: <linux-kernel+bounces-342322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D7988D8D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6772827EE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C315D42A81;
	Sat, 28 Sep 2024 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFHMZ74t"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E60C219EA
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727490588; cv=none; b=kK0GUGEUGQxJiNTo94bS0mC318aaU3QxZOtvEvd9+TbL9t+WIkGMFrRa0hLad4b7q0a+24Z3P3q9ECgciGKWF8l+OJw50PLSLA7mmBdqQ/9AWHlWLW7cGMZAnvinv3LgupE4XK6WcvHKMtqQJpXbJxXFkgJ/iqzQm8gF54ogkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727490588; c=relaxed/simple;
	bh=QxbFC+p4j7vh6HzPF+sTBRKY6UbQwhR6nvVLvK4rg6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NX0dmd55UX/QGlYpBMn8sFhz/be8Wvf4OU3QRywdRznb676dCevd9q25pxozcxpW/vzXVg1N4H+Bx/CUDGIcEsFaiCHRzGJOz+ZzxV9s3rs75QagAmO3+2CB2zuluyLC18Br/q0065xgoumjNFwr5bBVHrlKtdC7WCKGtsHTdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFHMZ74t; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso394545166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727490585; x=1728095385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLvTzJd1/fYfqRazDuQvbjfT4R459nXI36EJOkl5TP8=;
        b=tFHMZ74tPfcoD4vsU27I/kEtbKpBsxN8yRlngEKD0Lnto+J8TjZ/kr2RCkh6Ud3Gyo
         6c9N0yq8JvwpkI5ojbNmKGbuYiuDhARC9ANk1hhQ42rUAyj68Y1CHDyy+iUdIARfzse6
         aNV8f1KnTg4s1hcG5GTeqt5Pfh34sa//KyB/AVzKyQ2iiX3RVNz6A85XbqM77/riIQrT
         B3bRNlDg/aNi4YS2YO1tNc+P8y0Y3X+bo2l31napjG3PTeSoXMroa7nIWUqdsWjajQFF
         wB2aNbEos/I+P2EMgbiZj+nx1xK6w+0SMXzafyPjzFAlAkLqNvpTyrGags7UKNDm2+J6
         BwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727490585; x=1728095385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLvTzJd1/fYfqRazDuQvbjfT4R459nXI36EJOkl5TP8=;
        b=u4ZylFuAXcU4zv1c/Q0NpxM0FO9gAG7+UKTOZs9AnhMXTK18DcrmdT8urdb3DRFbff
         DYmwUm9bo2TusYD6gWBywsLp40d+MnPg+acj7Xg8vKPZYouolhIHwY4T+DEvrKsJ3ume
         j/i3gMR0kn2ELPK6sh0rjveS+HPczRbbAaglYITt4FeQBJGm3v6Ued9W0PGuK3dH7EMA
         WVmoq6Z6YOYH1QGIZfQe340m/lCcerlfvuGeKYUqbwDNXMQuh5Pai7PyiMyiU8EkEv7a
         zScQ+3JhFbkzzQjzc56ijT8dZL7wJkIlCQMntSSDnpZq88X4cFmoJPr1n3ww6BONDgOW
         i6MQ==
X-Gm-Message-State: AOJu0YzQbZW9ykGe7l00vpF7ZQMOVBeHD0SIfTo3syR2zHjIl0NpbmOr
	jm7D/xS28A3/WihsjGOAv+w1BA/++KDEsOAcigTCYClV+bOfT6t2G15NHHzNmXetyXwAsMDWfQz
	ockYGiMcKf7nKXJydW2LY6Rd+lF3OmaYOOUqS
X-Google-Smtp-Source: AGHT+IE7qLTp1kd4j7cINYu1fPxZ1tWTYsqwTgD5igF/GycFheEqf1NsDQfaIRIVmD7nq1gIklzAX2R8DBEnLV0O1yo=
X-Received: by 2002:a17:907:6d1a:b0:a86:a41c:29b with SMTP id
 a640c23a62f3a-a93c48e80bdmr503811166b.8.1727490584553; Fri, 27 Sep 2024
 19:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com> <20240928021620.8369-4-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240928021620.8369-4-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 27 Sep 2024 19:29:07 -0700
Message-ID: <CAJD7tkZKSX3bLjhtQ+uEB+mrpJ+Q_HysvnQ88hWuf3fqvFx=Zg@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] mm: zswap: Rename zswap_pool_get() to zswap_pool_tryget().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 7:16=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Modify the name of the existing zswap_pool_get() to zswap_pool_tryget()
> to be representative of the call it makes to percpu_ref_tryget().
> A subsequent patch will introduce a new zswap_pool_get() that calls
> percpu_ref_get().
>
> The intent behind this change is for higher level zswap API such as
> zswap_store() to call zswap_pool_tryget() to check upfront if the pool's
> refcount is "0" (which means it could be getting destroyed) and to handle
> this as an error condition. zswap_store() would proceed only if
> zswap_pool_tryget() returns success, and any additional pool refcounts th=
at
> need to be obtained for compressing sub-pages in a large folio could simp=
ly
> call zswap_pool_get().
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index fd7a8c14457a..0f281e50a034 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -403,7 +403,7 @@ static void __zswap_pool_empty(struct percpu_ref *ref=
)
>         spin_unlock_bh(&zswap_pools_lock);
>  }
>
> -static int __must_check zswap_pool_get(struct zswap_pool *pool)
> +static int __must_check zswap_pool_tryget(struct zswap_pool *pool)
>  {
>         if (!pool)
>                 return 0;
> @@ -441,7 +441,7 @@ static struct zswap_pool *zswap_pool_current_get(void=
)
>         rcu_read_lock();
>
>         pool =3D __zswap_pool_current();
> -       if (!zswap_pool_get(pool))
> +       if (!zswap_pool_tryget(pool))
>                 pool =3D NULL;
>
>         rcu_read_unlock();
> @@ -462,7 +462,7 @@ static struct zswap_pool *zswap_pool_find_get(char *t=
ype, char *compressor)
>                 if (strcmp(zpool_get_type(pool->zpool), type))
>                         continue;
>                 /* if we can't get it, it's about to be destroyed */
> -               if (!zswap_pool_get(pool))
> +               if (!zswap_pool_tryget(pool))
>                         continue;
>                 return pool;
>         }
> --
> 2.27.0
>

