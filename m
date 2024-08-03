Return-Path: <linux-kernel+bounces-273318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7387946752
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 06:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5309F28267E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 04:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164A12B9A6;
	Sat,  3 Aug 2024 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPOMoSLF"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285B6225DA
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722658498; cv=none; b=p40S5VYhVimY0eh4eBQdR9WSsoTB6De9dakKbpjNnuOIvKp0sSEDCAHhBymViOHScpp+QTY6+G6YDlpoq5OVWObNy2NHuiYgZpx/Gyl927OW9OVhJU96flZe7cFgR8wt5WXSykorE1ST73CjjjLOaKQ2lqRI7icx94inewtfX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722658498; c=relaxed/simple;
	bh=nEEtWSo1PsNPKdpT9wCPBJNJ6ySmT7t6mz+8Sp2UJCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElZBvdYttGZ9NUJuDhLMH4p1coMSXlx0VQ+W5wvuthsmoWxQYGkiP3Xkg866E6a1gK87nzVNxU80fAcOUY0W8SOSu7LEWjUKkvAoe2R58g6zbKl115VqG5vFihWQYMmBQxRf43Rqr+LQNJdUHRur8XEylGCKjNMLzc3339S+r+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPOMoSLF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so1069067666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 21:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722658494; x=1723263294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3VJn+k5RR3eFH5H5UkduuJdBdQKbGUZ1f4tj4+JJqU=;
        b=iPOMoSLF3TfgHcmlGbYA/GPTxNmtWJZG6RIGZHKwntOszHjlYGOg3d8yIWdY7Q2FZw
         8NBAqoZI6nPaQzm3EHgw361r9n4Bd2TTo/gfCpWTbR6ogCNE4bZLznxIP//L8oGxHRrs
         3V2Cwug5pPk6TbH8Z4UzjtOm0YfninLN322EDea8Yjd5533OPNzAMnmg1rKzQmjNQeIk
         c91OPl0f7N0sD83oE30n/4GwHmpMlqagbiEMLykvfQHTAC8EZY6Tv+tyGCcpPpiABcjs
         nQIhME6ckuUBVmtr3dxrVpt/wGzbaHP/IRAv0VElLcYFDR3sF2T24Nfplh+/FBk69ldF
         jRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722658494; x=1723263294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3VJn+k5RR3eFH5H5UkduuJdBdQKbGUZ1f4tj4+JJqU=;
        b=mYe6DbKBpV2LJ3+qqthjCTVqSJaaOFV+9L9ON/FqQ0aNPBzRlcSz72CN6pRNe+7ZBt
         Jg1wLRj2x7HQzXTuur2NTtKaApmtxjNYcStnt+V03nY/vnsIS5TKXuyn7on6qTP5/dhE
         dl3UHbUCwqSa7eb/DK+oalcoO5S5Bcxdo4T9iM6z8F7NTnPRn6QNc9SRU1slVD4kTbdM
         JWvEmUsypf7p/wTuhrdy9U7DM1rQdgbYzMjUGTXSG3vbsLM8tLZF+fq/pLFBiIUZMOlG
         sA4mX+4qZiN1SsPZDu4ZSdO7RHTgRADKikyHnYoXdgY+0UVeg2gcRGWCt3vBrB3m0uYF
         4vVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOuCqQ7cZXQ7FgQp/mFVluTeZm0rFER6oc6Bfh9zI7OeUbny69Kdt4Vl0lcg9J4imySeXxzJCz0mihfwh0RokL1CubUnDSJs2xCqal
X-Gm-Message-State: AOJu0YzEaCBHWNbfW/pg5dRSxO2CKV2Jlgb4ZIXBBjUKx7QWcsM3X5ku
	vmu7TzsVETA1nRE2psq1keNLZnTp28qZtIMrkXEpuWWAqsssoJ16/Eb673k1U2IBO4aXOoyxmIH
	JZyIn+KsoXGQYqWLL4vCRuFvuqDbmt5ST2CcD
X-Google-Smtp-Source: AGHT+IEoMBpJZeESnd2W4YFmxshI61AgRv6W4RcOIJNoZalizIpnQjegykPGDNtfsMZsnz7LWshTQxgWgDf0htFSqGw=
X-Received: by 2002:a17:906:da8a:b0:a77:dd1c:6274 with SMTP id
 a640c23a62f3a-a7dc5124d64mr281729466b.69.1722658493451; Fri, 02 Aug 2024
 21:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731004918.33182-1-flintglass@gmail.com> <20240731004918.33182-2-flintglass@gmail.com>
In-Reply-To: <20240731004918.33182-2-flintglass@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Aug 2024 21:14:17 -0700
Message-ID: <CAJD7tkaScz+SbB90Q1d5mMD70UfM2a-J2zhXDT9sePR7Qap45Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:49=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.
>
> The problem was that shrink_worker() would restart iterating memcg tree
> from the tree root, considering an offline memcg as a failure, and abort
> shrinking after encountering the same offline memcg 16 times even if
> there is only one offline memcg. After this change, an offline memcg in
> the tree is no longer considered a failure. This allows the shrinker to
> continue shrinking the other online memcgs regardless of whether an
> offline memcg exists, gives higher zswap writeback activity.
>
> To avoid holding refcount of offline memcg encountered during the memcg
> tree walking, shrink_worker() must continue iterating to release the
> offline memcg to ensure the next memcg stored in the cursor is online.
>
> The offline memcg cleaner has also been changed to avoid the same issue.
> When the next memcg of the offlined memcg is also offline, the refcount
> stored in the iteration cursor was held until the next shrink_worker()
> run. The cleaner must release the offline memcg recursively.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Acked-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>  mm/zswap.c | 68 +++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 44 insertions(+), 24 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index adeaf9c97fde..3c16a1192252 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -765,12 +765,25 @@ void zswap_folio_swapin(struct folio *folio)
>         }
>  }
>
> +/*
> + * This function should be called when a memcg is being offlined.
> + *
> + * Since the global shrinker shrink_worker() may hold a reference
> + * of the memcg, we must check and release the reference in
> + * zswap_next_shrink.
> + *
> + * shrink_worker() must handle the case where this function releases
> + * the reference of memcg being shrunk.
> + */
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
>  {
>         /* lock out zswap shrinker walking memcg tree */
>         spin_lock(&zswap_shrink_lock);
> -       if (zswap_next_shrink =3D=3D memcg)
> -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_sh=
rink, NULL);
> +       if (zswap_next_shrink =3D=3D memcg) {
> +               do {
> +                       zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap=
_next_shrink, NULL);
> +               } while (zswap_next_shrink && !mem_cgroup_online(zswap_ne=
xt_shrink));
> +       }
>         spin_unlock(&zswap_shrink_lock);
>  }
>
> @@ -1304,43 +1317,50 @@ static void shrink_worker(struct work_struct *w)
>         /* Reclaim down to the accept threshold */
>         thr =3D zswap_accept_thr_pages();
>
> -       /* global reclaim will select cgroup in a round-robin fashion. */
> +       /*
> +        * Global reclaim will select cgroup in a round-robin fashion.
> +        *
> +        * We save iteration cursor memcg into zswap_next_shrink,
> +        * which can be modified by the offline memcg cleaner
> +        * zswap_memcg_offline_cleanup().
> +        *
> +        * Since the offline cleaner is called only once, we cannot leave=
 an
> +        * offline memcg reference in zswap_next_shrink.
> +        * We can rely on the cleaner only if we get online memcg under l=
ock.
> +        *
> +        * If we get an offline memcg, we cannot determine if the cleaner=
 has
> +        * already been called or will be called later. We must put back =
the
> +        * reference before returning from this function. Otherwise, the
> +        * offline memcg left in zswap_next_shrink will hold the referenc=
e
> +        * until the next run of shrink_worker().
> +        */
>         do {
>                 spin_lock(&zswap_shrink_lock);
> -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_sh=
rink, NULL);
> -               memcg =3D zswap_next_shrink;
>
>                 /*
> -                * We need to retry if we have gone through a full round =
trip, or if we
> -                * got an offline memcg (or else we risk undoing the effe=
ct of the
> -                * zswap memcg offlining cleanup callback). This is not c=
atastrophic
> -                * per se, but it will keep the now offlined memcg hostag=
e for a while.
> -                *
> +                * Start shrinking from the next memcg after zswap_next_s=
hrink.
> +                * When the offline cleaner has already advanced the curs=
or,
> +                * advancing the cursor here overlooks one memcg, but thi=
s
> +                * should be negligibly rare.
> +                */
> +               do {
> +                       memcg =3D mem_cgroup_iter(NULL, zswap_next_shrink=
, NULL);
> +                       zswap_next_shrink =3D memcg;
> +               } while (memcg && !mem_cgroup_tryget_online(memcg));

I took a look at refactoring the loop to a helper, but it's probably
not going to be any clearer because this loop has a tryget, and the
loop in zswap_memcg_offline_cleanup() only has an online check. Using
a tryget in the offline cleanup version would be wasteful and we'll
put the ref right away.

Instead, I think we should just move the spin_lock/unlock() closer to
the loop to make the critical section more obvious, and unify the
comments above and below into a single block.

Andrew, could you please fold in the following diff (unless Takero objects)=
:

diff --git a/mm/zswap.c b/mm/zswap.c
index babf0abbcc765..df620eacd1d11 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1364,24 +1364,22 @@ static void shrink_worker(struct work_struct *w)
         * until the next run of shrink_worker().
         */
        do {
-               spin_lock(&zswap_shrink_lock);
-
                /*
                 * Start shrinking from the next memcg after zswap_next_shr=
ink.
                 * When the offline cleaner has already advanced the cursor=
,
                 * advancing the cursor here overlooks one memcg, but this
                 * should be negligibly rare.
+                *
+                * If we get an online memcg, keep the extra reference in c=
ase
+                * the original one obtained by mem_cgroup_iter() is droppe=
d by
+                * zswap_memcg_offline_cleanup() while we are shrinking the
+                * memcg.
                 */
+               spin_lock(&zswap_shrink_lock);
                do {
                        memcg =3D mem_cgroup_iter(NULL, zswap_next_shrink, =
NULL);
                        zswap_next_shrink =3D memcg;
                } while (memcg && !mem_cgroup_tryget_online(memcg));
-               /*
-                * Note that if we got an online memcg, we will keep the ex=
tra
-                * reference in case the original reference obtained
by mem_cgroup_iter
-                * is dropped by the zswap memcg offlining callback,
ensuring that the
-                * memcg is not killed when we are reclaiming.
-                */
                spin_unlock(&zswap_shrink_lock);

                if (!memcg) {

> +               /*
>                  * Note that if we got an online memcg, we will keep the =
extra
>                  * reference in case the original reference obtained by m=
em_cgroup_iter
>                  * is dropped by the zswap memcg offlining callback, ensu=
ring that the
>                  * memcg is not killed when we are reclaiming.
>                  */
> -               if (!memcg) {
> -                       spin_unlock(&zswap_shrink_lock);
> -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> -                               break;
> -
> -                       goto resched;
> -               }
> -
> -               if (!mem_cgroup_tryget_online(memcg)) {
> -                       /* drop the reference from mem_cgroup_iter() */
> -                       mem_cgroup_iter_break(NULL, memcg);
> -                       zswap_next_shrink =3D NULL;
> -                       spin_unlock(&zswap_shrink_lock);
> +               spin_unlock(&zswap_shrink_lock);
>
> +               if (!memcg) {
>                         if (++failures =3D=3D MAX_RECLAIM_RETRIES)
>                                 break;
>
>                         goto resched;
>                 }
> -               spin_unlock(&zswap_shrink_lock);
>
>                 ret =3D shrink_memcg(memcg);
>                 /* drop the extra reference */
> --
> 2.43.0
>

