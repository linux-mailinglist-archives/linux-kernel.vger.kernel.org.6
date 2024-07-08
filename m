Return-Path: <linux-kernel+bounces-244410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F7792A3F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DF51C219C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAA913AA26;
	Mon,  8 Jul 2024 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMZSQhar"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95785270;
	Mon,  8 Jul 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446301; cv=none; b=j+KtAwa/5Oa7bXk01mLyarpNzC/FPMKtVrQ40+UfDlPoSPbXl45eM/S2mK+mutodOj+bRlkV7VWEx+Z+fXNEM6Z3irOWKutCpbfp3mk/9nVPgKDwMpe6pTac4pgUuJwGDLsKcRGrLR5pHAKsFynA2YapW4DzxHllsFnJGwaP51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446301; c=relaxed/simple;
	bh=47u4T5Is6Hg3oW455uKA/icqv/0zuyBXIRGCvD2r4kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBOWVE6jUHfl20JzRFtcpwrRFRw+xIBkwoyqZm3JarTFwclGrV7kbXSYbYDDz7Yp2pXTdLM5K1Wg/UM+ACeeoGin9G2rqtnyzOStg5XHxYTzZFS+ERk2gtxhcXu9leQfZDev49hFwEyiZ6hRwiZ2Cw5efO9DDndCzN1V5dB+sfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMZSQhar; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so4423561276.2;
        Mon, 08 Jul 2024 06:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720446298; x=1721051098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNklU3B3LCdHJNFvg0ZFjz1p4iX08ixeg8SfmCVM7gg=;
        b=LMZSQharGkcx8tY80N2LMU3mJ0je6sIIJQqutBU41PBJJoCSMZVlSMBd2iDXsHoBle
         y+RZVyINgXjBN17tof21aHOKXclEjsyAGZo0BNgikunFa//Kb4E3d2AvqiVNPvE4+plr
         3U0AvWiKnCQgQpcwqmKljYNKR+cMZwJQ6RbkzkBkxBmn8UUU64lUhFtG9oO6nsiZckxR
         SO7PoMvb5Uzhm3CjLuPcrBmfHSmUKY94N353qiaKs7lVaLi1kmD/+qerGnfe1Eu9fxA9
         ugCzDVCqrdeDL4GQ0Ko+s+7CCwrgyWKSs1SLdqetcU9AsVdzj77pMcX4toPCe9f/9i3B
         YMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720446298; x=1721051098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNklU3B3LCdHJNFvg0ZFjz1p4iX08ixeg8SfmCVM7gg=;
        b=mPoDPfunmINNFChPBqbL1E08eKXy/zfpvz3/VQkpkI3F8GR4eY5HFKKyRwzUEROdGT
         rMrRnAN3BzuXHnpfm9qPgD+sBnlpgWsu0M5W3hXAeQTW/bWhqpeB+KFPRwvwkdJ6NbtC
         /8tJDdraNjBeuIJJdzvkOjxEbtPl3BZJMZxj7CaBfoccQdyI0kMolB45jGJHIQZIDMrN
         wThXreNIU0PUQfbGuNo4Ff+y+Bz5Hhf/vUvrCm/2xJRaSsbGnfyPzMY7uWbKhhSwDlBc
         CECWT1dpwHKWk/yNbyqX3vEQixMyoN3JMNbJHMg7FLXltCta+TANu0Hu75wgq16Pd0GO
         ezRw==
X-Forwarded-Encrypted: i=1; AJvYcCXNrwEXbfk9W0qc9XTTeq91nqi8dxPo0Uze6OEqkmSi3hjgtoofkbwAsfyYYcMahg5MqEZPp1zyBcKyrojgtJ9sUKrEVVTRKdw8iGx2lsErq+azuqE9+OPCtYKyeWAFV/Hf8VBFFyQa
X-Gm-Message-State: AOJu0Yy5MLf6uc7ziK0QZSkZzFtWtjYEF1FQ6chZmzrXpukVSEJ5LPNX
	ilw8iongFvtaXtU4CPjmKrlg6TR+8fzXOCX4dB2PpGgHqMkWBx7xHHVHrjOEj5akLOmrsi0mbOr
	Ev6Ptkgg7lkiqdITHkDMePekOlMo=
X-Google-Smtp-Source: AGHT+IG5pai14Ca8ZcqWdXxJhzsZ+YHnwUk7ftYSJ9kAfE0rgLhoSEmET5QIX/7olaCy1Gi7HDL+KOrFes0D/JETECw=
X-Received: by 2002:a05:6902:1185:b0:dfe:fd16:cbc6 with SMTP id
 3f1490d57ef6-e03c192b9c2mr18529559276.14.1720446298355; Mon, 08 Jul 2024
 06:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-6-flintglass@gmail.com> <0afc769e-241a-404e-b2c9-a6a27bdd3c72@linux.dev>
In-Reply-To: <0afc769e-241a-404e-b2c9-a6a27bdd3c72@linux.dev>
From: Takero Funaki <flintglass@gmail.com>
Date: Mon, 8 Jul 2024 22:44:47 +0900
Message-ID: <CAPpoddfySkGpD5hKgqUAAMgMp2vWcivg1AzcyYh_NP1-ZsGkug@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mm: zswap: store incompressible page as-is
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Nhat Pham <nphamcs@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=888=E6=97=A5(=E6=9C=88) 12:56 Chengming Zhou <chengmin=
g.zhou@linux.dev>:

> >       comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req=
), &acomp_ctx->wait);
> >       dlen =3D acomp_ctx->req->dlen;
> > -     if (comp_ret)
> > +
> > +     /* coa_compress returns -EINVAL for errors including insufficient=
 dlen */
> > +     if (comp_ret && comp_ret !=3D -EINVAL)
> >               goto unlock;
>
> Seems we don't need to care about? "comp_ret" is useless anymore.
>
> Just:
>
> if (comp_ret || dlen > PAGE_SIZE - 64)
>         dlen =3D PAGE_SIZE;
>
> And remove the checkings of comp_ret at the end.
>

>
> We actually don't need to hold mutex if we are just copying folio.
>
> Thanks.
>

Thanks for reviewing.

For comp_ret, can we consolidate all possible error codes as
incompressible data?
if we do not need to distinguish -EINVAL and the others, diff v2..v3
can be like:

@@ -62,8 +62,6 @@ static u64 zswap_pool_limit_hit;
 static u64 zswap_written_back_pages;
 /* Store failed due to a reclaim failure after pool limit was reached */
 static u64 zswap_reject_reclaim_fail;
-/* Store failed due to compression algorithm failure */
-static u64 zswap_reject_compress_fail;
 /* Compressed page was too big for the allocator to (optimally) store */
 static u64 zswap_reject_compress_poor;
 /* Store failed because underlying allocator could not get memory */
@@ -1043,10 +1041,6 @@ static bool zswap_compress(struct folio *folio,
struct zswap_entry *entry)
        comp_ret =3D
crypto_wait_req(crypto_acomp_compress(acomp_ctx->req),
&acomp_ctx->wait);
        dlen =3D acomp_ctx->req->dlen;

-       /* coa_compress returns -EINVAL for errors including
insufficient dlen */
-       if (comp_ret && comp_ret !=3D -EINVAL)
-               goto unlock;
-
        /*
         * If the data cannot be compressed well, store the data as-is.
         * Switching by a threshold at
@@ -1056,7 +1050,8 @@ static bool zswap_compress(struct folio *folio,
struct zswap_entry *entry)
         */
        if (comp_ret || dlen > PAGE_SIZE - 64) {
                /* we do not use compressed result anymore */
-               comp_ret =3D 0;
+               mutex_unlock(&acomp_ctx->mutex);
+               acomp_ctx =3D NULL;
                dlen =3D PAGE_SIZE;
        }
        zpool =3D zswap_find_zpool(entry);
@@ -1083,12 +1078,11 @@ static bool zswap_compress(struct folio
*folio, struct zswap_entry *entry)
 unlock:
        if (alloc_ret =3D=3D -ENOSPC)
                zswap_reject_compress_poor++;
-       else if (comp_ret)
-               zswap_reject_compress_fail++;
        else if (alloc_ret)
                zswap_reject_alloc_fail++;

-       mutex_unlock(&acomp_ctx->mutex);
+       if (acomp_ctx)
+               mutex_unlock(&acomp_ctx->mutex);
        return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
 }

@@ -1886,8 +1880,6 @@ static int zswap_debugfs_init(void)
                           zswap_debugfs_root, &zswap_reject_alloc_fail);
        debugfs_create_u64("reject_kmemcache_fail", 0444,
                           zswap_debugfs_root, &zswap_reject_kmemcache_fail=
);
-       debugfs_create_u64("reject_compress_fail", 0444,
-                          zswap_debugfs_root, &zswap_reject_compress_fail)=
;
        debugfs_create_u64("reject_compress_poor", 0444,
                           zswap_debugfs_root, &zswap_reject_compress_poor)=
;
        debugfs_create_u64("written_back_pages", 0444,

