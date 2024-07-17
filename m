Return-Path: <linux-kernel+bounces-254595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BCB933535
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0162EB223E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14162C9A;
	Wed, 17 Jul 2024 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4j1dWsVW"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AD7184F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721181285; cv=none; b=KMH4FeLD36s8uK4DHOlWUs62NyWf8X5Vf5quvaRdYfeWMe0r52XwU8HP6hTSsfIQ5HdD3MDf0xHgokS5r7iUuBIU/Efb0IcL3mfoHxwRXuY1Yi3Lxv5kk/cLMbqFm9FIgjpo1mHvhjsBK6hbjVYb+vqz7/x//rCKc/mBA2WrNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721181285; c=relaxed/simple;
	bh=ofldocloxqEKlH1IG/bsd+S+uZgiDu6IRrfkZJ3pHnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9Pc+2HZhO3yMIgXl0X/PXgy2H0mC7a5bAWo7YjwWYOeilK1RsOUvn4/oMCpbOzwo3EQGgd1Zceov0SuRlxEFnKY2MoWAMKnp7riCZz2WFnNtmeHZ2VCrExNzSqOj4TLqiG91Qrsg+XB8AGtn8SbP9xVEuaCOREkIsSi2FqI/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4j1dWsVW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e9f863c46so6878509e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721181282; x=1721786082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaDTjYso0r0FTjuPE33B/LDoFqVnRXhQgdUXwAuM1v0=;
        b=4j1dWsVWO2LafXMifE3jSK7VA5U/T+2BOEyXPnix8nCUUj8l/42Aym2hhHm/3eQzEB
         KR8syf+0EO66vVPynuPuDgD/1JXQY7JT8oflRGcUbm/TzLh1hy0X/xPG+s0TG4osy3JW
         myT0toAZSLSwDHi/EGBF3AgKMjuy0St12PlRlRA0pCHR1LmkEXQ8jHPsnZTf1iN3aZgh
         mB7nIwAdlUR8DA2azxmV6DB/GmuI8WC7k8OsSUMcBJOmxsnzXiJKAHL0PqEbaW96UOkm
         I0CNSW12P3KROn+8lFGiOv3QZ2Y3FP6tf9jqnlPhsnaTFu7psNLTp8cRyk80GBY9nICd
         OrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721181282; x=1721786082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaDTjYso0r0FTjuPE33B/LDoFqVnRXhQgdUXwAuM1v0=;
        b=gICGDPLSXgKt2UAPS9SslRA8dCX39nuJtfr5TBdfnn8IH8ELhNQT2Wah7AVyiumzNU
         A9vJU/rBgTpSPb+ybSRdkTblw7k8qeRWDhB22PiA8AJBM9rXnIBOOd31qtanI5a+dAw7
         WlZwhJ66Wx+CBgifRJRcnWJW+r0iU3+WqLvBqq72X893b4TIluBpsFwIruSy/L0oVZRh
         OhbnVtLczTMmQM9PXldpm+ODp2Qj38ccTd0uhxyQSeJwIoQgFtDk274pM0ZU85VfwC6C
         7pbj3Ou0vjZ8AgvRg5C0QsGXuB39iasncndJx8uWojkmX1jsC/NlhMWV8Oxc4oqbaKAh
         sXeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8kclAmTlZUvXDs+R4kAaxeLsw3hWF+q6XaW3XHTP1e4PuSBzhd5mAnC3W78bsHqGGggEBezeeVAz0UVtW6tUahbKx2R1rzSHOFMTu
X-Gm-Message-State: AOJu0YxehONtVPWeyu4B2M1VG5hCf8zwRPCn+Rs4Ll5EHa5oa1/J4XMM
	xBzKp/SVH+Hc1S3ST96K7M+nQoSjetXXVRI/ScBKtHWQXOr6u/hqZrmyL5MWJNW5Jy7zAGlDnSt
	+daO8tjLWue2SXG8Y58CJC4eT4NdGswUbPuGT
X-Google-Smtp-Source: AGHT+IGDigwv1plpX5owBug/I1nQwxp5ZVs5gvFB3KlseUnQAYTDpst/OZ3qmz+IfZxxyfpPX0NdzIL7KR7XE+E49LI=
X-Received: by 2002:a05:6512:3089:b0:52e:be0d:56dd with SMTP id
 2adb3069b0e04-52ee542d8e6mr130655e87.40.1721181281405; Tue, 16 Jul 2024
 18:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com> <20240706022523.1104080-2-flintglass@gmail.com>
In-Reply-To: <20240706022523.1104080-2-flintglass@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 16 Jul 2024 18:54:03 -0700
Message-ID: <CAJD7tkYEQQ539id2yPi+m7bR3EDa33LBLKV-y+XFuBPc3BhxcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 7:25=E2=80=AFPM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.
>
> The problem was that shrink_worker() would stop iterating when a memcg
> was being offlined and restart from the tree root.  Now, it properly
> handles the offlie memcg and continues shrinking with the next memcg.
>
> Note that, to avoid a refcount leak of offline memcg encountered during
> the memcg tree walking, shrink_worker() must continue iterating to find
> the next online memcg.

Please do not use the word "leak" here. It is confusing. The refcount
is not leaked, we just have a long-standing ref that should eventually
be dropped (although in theory, shrink_worker() may never me called
again). Leak makes it sound like we increment the refcount but
completely forget dropping it, which is not the case here.

>
> The following minor issues in the existing code are also resolved by the
> change in the iteration logic:
>
> - A rare temporary refcount leak in the offline memcg cleaner, where the
>   next memcg of the offlined memcg is also offline.  The leaked memcg
>   cannot be freed until the next shrink_worker() releases the reference.
>
> - One memcg was skipped from shrinking when the offline memcg cleaner
>   advanced the cursor of memcg tree. It is addressed by a flag to
>   indicate that the cursor has already been advanced.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>  mm/zswap.c | 94 ++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 73 insertions(+), 21 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a50e2986cd2f..29944d8145af 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -171,6 +171,7 @@ static struct list_lru zswap_list_lru;
>  /* The lock protects zswap_next_shrink updates. */
>  static DEFINE_SPINLOCK(zswap_shrink_lock);
>  static struct mem_cgroup *zswap_next_shrink;
> +static bool zswap_next_shrink_changed;
>  static struct work_struct zswap_shrink_work;
>  static struct shrinker *zswap_shrinker;
>
> @@ -775,12 +776,39 @@ void zswap_folio_swapin(struct folio *folio)
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
> +               /*
> +                * We advances the cursor to put back the offlined memcg.
> +                * shrink_worker() should not advance the cursor again.
> +                */
> +               zswap_next_shrink_changed =3D true;

I think this should be rare enough that it's not worth the extra complexity=
 imo.

> +
> +               do {
> +                       zswap_next_shrink =3D mem_cgroup_iter(NULL,
> +                                       zswap_next_shrink, NULL);
> +               } while (zswap_next_shrink &&
> +                               !mem_cgroup_online(zswap_next_shrink));
> +               /*
> +                * We verified the next memcg is online.  Even if the nex=
t
> +                * memcg is being offlined here, another cleaner must be
> +                * waiting for our lock.  We can leave the online memcg
> +                * reference.
> +                */
> +       }
>         spin_unlock(&zswap_shrink_lock);
>  }
>
> @@ -1319,18 +1347,42 @@ static void shrink_worker(struct work_struct *w)
>         /* Reclaim down to the accept threshold */
>         thr =3D zswap_accept_thr_pages();
>
> -       /* global reclaim will select cgroup in a round-robin fashion. */
> +       /* global reclaim will select cgroup in a round-robin fashion.
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
> +        * If we get an offline memcg, we cannot determine the cleaner ha=
s

we cannot determine if* the cleaner

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
> +                * To not skip a memcg, do not advance the cursor when it=
 has
> +                * already been advanced by the offline cleaner.
> +                */
> +               do {
> +                       if (zswap_next_shrink_changed) {
> +                               /* cleaner advanced the cursor */
> +                               zswap_next_shrink_changed =3D false;
> +                       } else {
> +                               zswap_next_shrink =3D mem_cgroup_iter(NUL=
L,
> +                                               zswap_next_shrink, NULL);
> +                       }
> +                       memcg =3D zswap_next_shrink;
> +               } while (memcg && !mem_cgroup_tryget_online(memcg));
> +
> +               /*
>                  * Note that if we got an online memcg, we will keep the =
extra
>                  * reference in case the original reference obtained by m=
em_cgroup_iter
>                  * is dropped by the zswap memcg offlining callback, ensu=
ring that the
> @@ -1344,17 +1396,11 @@ static void shrink_worker(struct work_struct *w)
>                         goto resched;
>                 }
>
> -               if (!mem_cgroup_tryget_online(memcg)) {
> -                       /* drop the reference from mem_cgroup_iter() */
> -                       mem_cgroup_iter_break(NULL, memcg);
> -                       zswap_next_shrink =3D NULL;
> -                       spin_unlock(&zswap_shrink_lock);
> -
> -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> -                               break;
> -
> -                       goto resched;
> -               }
> +               /*
> +                * We verified the memcg is online and got an extra memcg
> +                * reference.  Our memcg might be offlined concurrently b=
ut the
> +                * respective offline cleaner must be waiting for our loc=
k.
> +                */
>                 spin_unlock(&zswap_shrink_lock);
>
>                 ret =3D shrink_memcg(memcg);
> @@ -1368,6 +1414,12 @@ static void shrink_worker(struct work_struct *w)
>  resched:
>                 cond_resched();
>         } while (zswap_total_pages() > thr);
> +
> +       /*
> +        * We can still hold the original memcg reference.
> +        * The reference is stored in zswap_next_shrink, and then reused
> +        * by the next shrink_worker().
> +        */

This is unnecessary imo.

>  }
>
>  /*********************************
> --
> 2.43.0
>

