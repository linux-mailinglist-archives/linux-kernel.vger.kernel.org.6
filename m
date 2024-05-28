Return-Path: <linux-kernel+bounces-192623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8311D8D1FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB961F24207
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AF172BDA;
	Tue, 28 May 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYDx4h4+"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E865172BC4;
	Tue, 28 May 2024 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909011; cv=none; b=bVMMoc3lYMso5B7Cvl/mgIyulwcpDVosUfFF5xqbQWHwLeWIt6adH3UkSOffAqHCgpZHw3V/HY5zZ5S8AnPcd/Dqnoxlt+ZVwfjBMQ0zZf/l+1rflAc7jKIv8AGw8wjguZk0ISXn2hwA0Fbzg5bQEwYF2hie2spNN64IpEOEdIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909011; c=relaxed/simple;
	bh=zGhvYyzg4TBjlNHPIDWkcuBT3/adI/nJFY6Eb/G0qgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j94EOqpovU/V96cIZDB1sITa2UEZJWDxQ9TkybMdH1HW26KEYXSROslJ4v+Eyw0AKUCXtOVQeay24p8V4GtZM9RxA/WdCECSX0jTYIEYISDYhYk2bA1McCeIRJXfeqbptsIHGi/8yptHzXsVdh7q1L+FEJ++Lmn307QxdJdfMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYDx4h4+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-794c1a4e5f7so74190385a.1;
        Tue, 28 May 2024 08:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716909009; x=1717513809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRZWYeB0fD6zRAa1X7ZW5C+oaSxKDPRxmfSuKhNPBnM=;
        b=RYDx4h4+o4GbYJT0G90D4SO/CVptVbVZTxSQVahHcTUAuGvSxK796BNI5K3egZR5P9
         blFVDZMenCENmK7myW1FPkAgZHEu5gYnkxzwmVllAT0TcXsjm08mbXk4dBpG9vMqRnJs
         DlqZgG1IUugUiYbSlDdNK4a01/US3Minxk4Nc/B2ccfa3uY4FvVfjc3VE29wn1bbAN4Y
         FPR9WbYgwxnGt4EH/HVTvctD6Ogt8U5Psh+8RG9RXYKz6+blBURsiFX6dkoIiBP5k3na
         6abwIMUB111TS6mBzoxvsv3jvPUlvTzlfZ8pHQqDeeaME27Yp9/NbVvlotKDgrE/PUb4
         WkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909009; x=1717513809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRZWYeB0fD6zRAa1X7ZW5C+oaSxKDPRxmfSuKhNPBnM=;
        b=QXhy9jSpOb8hGsoLFdMpRrp59W8WmDFm4fp8/4NIUeFi+5/VvjFxoqosfxijwHYeOW
         rvZkfZf7EFDXS7PqeiDI5me920c9ik4q83QflqcKD6LVYp+n2PPUKl8AIZuTyEh795yg
         nEOH0vcv0MkPr0nhiGjYX6O5KAjU+UjH9OGxPuvPXPqA1DCyc/qEmgSgBwR/LYg1GnJ8
         1I6cbHqT+m1Q9/ZDyP0IJVBK09Gw8+yvpO3xGdD+UV2GiQ1pATmu+pL9lz+kG+vkbR4C
         UlwA6VR8OQPlu20oG7fwV+R7r3WLD3EcllCWgZIU8Ad+R3jrTJ/jAJrC2c+QOT63uZps
         kHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsoYLcccO3aFLwYn4DvFZNBTZBx0sOSLMY9Ia5hsstSPXFJr/VPD8uYFP7IZvVbuj5Tmq0Ol+nWrXsnvSeQrn/SRN4tXmyjS3g2LID4106kw4fmGgaqYYZ5IEk+sAioVShSbtlcXUf
X-Gm-Message-State: AOJu0Yz+VNXC78Bu/64dGaQcMR6fVFMj9fvJhOKHqPo5OZBnM3k1cqEk
	eG/dvRmgTqOHQQTvgM/9+wC2qYUqvZXiXujfcN6WhPZGq8EmH2seQENz/smjSJLSrZLyzOoPob9
	MIm54D6ouwp+HSvGGvZrDvPBgzH0=
X-Google-Smtp-Source: AGHT+IFUL3bM81SmgiYNB/JHjWRWku3KWP8wV6G7gltSzCArRZIYx2k5WWiPJ7GHMhiD57xPk0hyE0T/VbvxnsDASBQ=
X-Received: by 2002:a05:6214:5c08:b0:6ab:891c:54eb with SMTP id
 6a1803df08f44-6abcd0ae9b6mr131026016d6.34.1716909008451; Tue, 28 May 2024
 08:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528043404.39327-2-flintglass@gmail.com> <20240528043404.39327-3-flintglass@gmail.com>
In-Reply-To: <20240528043404.39327-3-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 May 2024 08:09:57 -0700
Message-ID: <CAKEwX=MwrRc43iM2050v5u-TPUK4Yn+a4G7+h6ieKhpQ7WtQ=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 9:34=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> This patch fixes an issue where the zswap global shrinker stopped
> iterating through the memcg tree.

Did you observe this problem in practice?

>
> The problem was that `shrink_worker()` would stop iterating when a memcg
> was being offlined and restart from the tree root.  Now, it properly
> handles the offlining memcg and continues shrinking with the next memcg.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>  mm/zswap.c | 76 ++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 56 insertions(+), 20 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a50e2986cd2f..0b1052cee36c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -775,12 +775,27 @@ void zswap_folio_swapin(struct folio *folio)
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
> +
> +       if (READ_ONCE(zswap_next_shrink) =3D=3D memcg) {
> +               /* put back reference and advance the cursor */
> +               memcg =3D mem_cgroup_iter(NULL, memcg, NULL);
> +               WRITE_ONCE(zswap_next_shrink, memcg);
> +       }

Hmm could you expand on how your version differs from what's existing?
What's the point of all these extra steps? The whole thing is done
under a big spin lock anyway.

> +
>         spin_unlock(&zswap_shrink_lock);
>  }
>
> @@ -1312,25 +1327,38 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>
>  static void shrink_worker(struct work_struct *w)
>  {
> -       struct mem_cgroup *memcg;
> +       struct mem_cgroup *memcg =3D NULL;
> +       struct mem_cgroup *next_memcg;
>         int ret, failures =3D 0;
>         unsigned long thr;
>
>         /* Reclaim down to the accept threshold */
>         thr =3D zswap_accept_thr_pages();
>
> -       /* global reclaim will select cgroup in a round-robin fashion. */
> +       /* global reclaim will select cgroup in a round-robin fashion.
> +        *
> +        * We save iteration cursor memcg into zswap_next_shrink,
> +        * which can be modified by the offline memcg cleaner
> +        * zswap_memcg_offline_cleanup().
> +        */

I feel like the only difference between this loop and the old loop, is
that if we fail to get an online reference to memcg, we're trying from
the next one (given by mem_cgroup_iter()) rather than from the top
(NULL).

For instance, consider the first two steps:

1. First, we check if memcg is the same as zswap_next_shrink. if not,
then reset it to zswap_next_shrink.
2. Advance memcg, then store the result at zswap_next_shrink.

Under the big zswap_shrink_lock, this is the same as:

1. Advance zswap_next_shrink.
2. Look up zswap_next_shrink, then store it under the local memcg variable.

which is what we were previously doing.

The next step is shared - check for null memcg (which again, is the
same as zswap_next_shrink now), and attempt to get an online
reference.
The only difference is when we fail to get the online reference -
instead of starting from the top, we advance memcg again.

Can't we just drop the lock, then add a continue statement? That will
reacquire the lock, advance zswap_next_shrink, look up the result and
store it at memcg, which is what you're trying to achieve?

>         do {
>                 spin_lock(&zswap_shrink_lock);
> -               zswap_next_shrink =3D mem_cgroup_iter(NULL, zswap_next_sh=
rink, NULL);
> -               memcg =3D zswap_next_shrink;
> +               next_memcg =3D READ_ONCE(zswap_next_shrink);
> +
> +               if (memcg !=3D next_memcg) {
> +                       /*
> +                        * Ours was released by offlining.
> +                        * Use the saved memcg reference.
> +                        */
> +                       memcg =3D next_memcg;
> +               } else {
> +iternext:
> +                       /* advance cursor */
> +                       memcg =3D mem_cgroup_iter(NULL, memcg, NULL);
> +                       WRITE_ONCE(zswap_next_shrink, memcg);
> +               }
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

Why are we removing this comment?

>                  * Note that if we got an online memcg, we will keep the =
extra
>                  * reference in case the original reference obtained by m=
em_cgroup_iter
>                  * is dropped by the zswap memcg offlining callback, ensu=
ring that the
> @@ -1345,16 +1373,18 @@ static void shrink_worker(struct work_struct *w)
>                 }
>
>                 if (!mem_cgroup_tryget_online(memcg)) {
> -                       /* drop the reference from mem_cgroup_iter() */
> -                       mem_cgroup_iter_break(NULL, memcg);
> -                       zswap_next_shrink =3D NULL;
> -                       spin_unlock(&zswap_shrink_lock);
> -
> -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> -                               break;
> -
> -                       goto resched;

I think we should still increment the failure counter, to guard
against long running/infinite loops.

> +                       /*
> +                        * It is an offline memcg which we cannot shrink
> +                        * until its pages are reparented.
> +                        * Put back the memcg reference before cleanup
> +                        * function reads it from zswap_next_shrink.
> +                        */
> +                       goto iternext;
>                 }
> +               /*
> +                * We got an extra memcg reference before unlocking.
> +                * The cleaner cannot free it using zswap_next_shrink.
> +                */
>                 spin_unlock(&zswap_shrink_lock);
>
>                 ret =3D shrink_memcg(memcg);
> @@ -1368,6 +1398,12 @@ static void shrink_worker(struct work_struct *w)
>  resched:
>                 cond_resched();
>         } while (zswap_total_pages() > thr);
> +
> +       /*
> +        * We can still hold the original memcg reference.
> +        * The reference is stored in zswap_next_shrink, and then reused
> +        * by the next shrink_worker().
> +        */
>  }
>
>  /*********************************
> --
> 2.43.0
>

