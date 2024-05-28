Return-Path: <linux-kernel+bounces-192628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8988D1FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9731C22584
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437C2172786;
	Tue, 28 May 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp2uU/tO"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2F172773;
	Tue, 28 May 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909099; cv=none; b=WWj3jH2MxWgb2rTyciTy7PB5qnK3gjWljDgHuOYSRORzypLA3GkPHa3dnz9dCf5K/GNnnE+NM6oV1zrOJ8nssNH7jze25VZRUbzNp7AO44Zbq/FGZjQzAou4qhyaPIPJkleVTsz9oE4PeDgEPJ26fjW9E1IAwAGUELHu463LWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909099; c=relaxed/simple;
	bh=tyb/05DTPxIxbf2eFGFh22eIdOGGrLEjZtXusY8lNt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EP5gQ0iVRxco7Pll99S3Q1njf+P/eWvohTBvZiwwyuNkSDrqDx21v/V2/iRqZK0qG0VfZ4y72sG+IOvC33imBSP5HPrpccY0mnReCchv4oY9EY2QxBaZ9ir8DO7E5kyIoXXhqQd3ySnRGyiSNJgabm1I5dhr58ezMXPk8TIkmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp2uU/tO; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b97b5822d8so419073eaf.3;
        Tue, 28 May 2024 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716909097; x=1717513897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeEH13/IspqIN0QZgGiY2O/zNhcX61BWbHyoVtOdlDs=;
        b=Mp2uU/tOmIWicgZcPMxd2HGKywwb+4NEBh1X+TVwObKaZ40C1wypcb1/Q3tW89k2Sd
         KQ+aD29i5ecYSj6g+6vWHYLgI2PTvFOBk54IudshOJPVCil5GU5Gzqo+fKFFY6Hh/5U2
         xNmzhVOaTtvoPzYRzZNNqP7mIYWe1ezzaPtjjbMieZAJn8xMCceJewoeTyGCXPAM4zuj
         RmPJ1aJ0pguZnx/cUKapHbyKekNcTQAIv3pa5f6goXW6rGxeanXuWn+zYkfhXvYWwv15
         woSK4ypeE10ah1XsMAUupqp5TR55ISsGg2IqHLOifryVsjY3Rq6rBHvTeZjZKKvTFoCQ
         uoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909097; x=1717513897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeEH13/IspqIN0QZgGiY2O/zNhcX61BWbHyoVtOdlDs=;
        b=CbXNjiRGjkQ8kjOB+p/swS8g+EkSvXwd7QgofsHva5MiiDMwrxCMeYvi/teXJBqLFV
         bfjUn7PrBUfJjlFRBMBafyqiyihXqWILJA19h8KSdxyC/rV7NT+/rxd4XDvmpVjEjhWL
         zAa0iFurGikjyntHmiNlxZXsz5hJc4AKgr1vmTdO2Dd3RAUKONkhFHtS7JChfPEPWNYq
         0VsIm/GbOVWrA5olyE6wGwQM3bSoyGYbYXckGfK49WmS9NJXksCiFgQkmKfbHVEbqxfY
         1MxAU7R8OfpfvVT52vgsxNTP4sIRPVAXx7uSnz+Mr9txUTllPEO7UWvGp8vXFMSCtWnw
         XYEA==
X-Forwarded-Encrypted: i=1; AJvYcCVX7Md+A4Z34JY8H0jSNNd00NEzHzG+zL7nkkUbyRioKZXwZXTNbg7lqgtI39imy6M6sNW1Cd+Crur3E8ou0+KfqT8xgJnNefE1p+AUbWoKVWvqkFTURdy0rH2AEjC4qlyzAvPHZlyF
X-Gm-Message-State: AOJu0Yw1U6aLW9D+PHsY3TDG6lZw2JQX/t1DQ0SYGC9DRnpq2bGOiym9
	uapvwzBQ2vbBrjdGNI8l+dfQtBlxPR2wwErp/B7HftuozXhe9dSf9aoqiG7UN8Wp/BnnNdVX0vG
	tVA+dGYl8FDIwARaFRHec8kykZdo=
X-Google-Smtp-Source: AGHT+IGCx7NWJ9+Jl2b5wiPsUNKoKYfa0J+bDBc8UFoMl8a0+PE+dUE+66EoIjeAUoZevVR8Ks3mh2G/I3New8Rk9l4=
X-Received: by 2002:a05:6218:2615:b0:183:86c4:75d0 with SMTP id
 e5c5f4694b2df-197e50d264dmr965356655d.8.1716909096666; Tue, 28 May 2024
 08:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528043404.39327-2-flintglass@gmail.com> <20240528043404.39327-4-flintglass@gmail.com>
In-Reply-To: <20240528043404.39327-4-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 28 May 2024 08:11:25 -0700
Message-ID: <CAKEwX=NnigYafFtQ63mknr_Gi7AVG5rp514GHi0a1K5PiNUxSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: zswap: fix global shrinker error handling logic
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
> This patch fixes zswap global shrinker that did not shrink zpool as
> expected.
>
> The issue it addresses is that `shrink_worker()` did not distinguish
> between unexpected errors and expected error codes that should be
> skipped, such as when there is no stored page in a memcg. This led to
> the shrinking process being aborted on the expected error codes.
>
> The shrinker should ignore these cases and skip to the next memcg.
> However,  skipping all memcgs presents another problem. To address this,
> this patch tracks progress while walking the memcg tree and checks for
> progress once the tree walk is completed.
>
> To handle the empty memcg case, the helper function `shrink_memcg()` is
> modified to check if the memcg is empty and then return -ENOENT.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>
> ---
>  mm/zswap.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0b1052cee36c..08a6f5a6bf62 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1304,7 +1304,7 @@ static struct shrinker *zswap_alloc_shrinker(void)
>
>  static int shrink_memcg(struct mem_cgroup *memcg)
>  {
> -       int nid, shrunk =3D 0;
> +       int nid, shrunk =3D 0, stored =3D 0;
>
>         if (!mem_cgroup_zswap_writeback_enabled(memcg))
>                 return -EINVAL;
> @@ -1319,9 +1319,16 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>         for_each_node_state(nid, N_NORMAL_MEMORY) {
>                 unsigned long nr_to_walk =3D 1;
>
> +               if (!list_lru_count_one(&zswap_list_lru, nid, memcg))
> +                       continue;
> +               ++stored;
>                 shrunk +=3D list_lru_walk_one(&zswap_list_lru, nid, memcg=
,
>                                             &shrink_memcg_cb, NULL, &nr_t=
o_walk);
>         }
> +
> +       if (!stored)
> +               return -ENOENT;
> +
>         return shrunk ? 0 : -EAGAIN;
>  }
>
> @@ -1329,12 +1336,18 @@ static void shrink_worker(struct work_struct *w)
>  {
>         struct mem_cgroup *memcg =3D NULL;
>         struct mem_cgroup *next_memcg;
> -       int ret, failures =3D 0;
> +       int ret, failures =3D 0, progress;
>         unsigned long thr;
>
>         /* Reclaim down to the accept threshold */
>         thr =3D zswap_accept_thr_pages();
>
> +       /*
> +        * We might start from the last memcg.
> +        * That is not a failure.
> +        */
> +       progress =3D 1;
> +
>         /* global reclaim will select cgroup in a round-robin fashion.
>          *
>          * We save iteration cursor memcg into zswap_next_shrink,
> @@ -1366,9 +1379,12 @@ static void shrink_worker(struct work_struct *w)
>                  */
>                 if (!memcg) {
>                         spin_unlock(&zswap_shrink_lock);
> -                       if (++failures =3D=3D MAX_RECLAIM_RETRIES)
> +
> +                       /* tree walk completed but no progress */
> +                       if (!progress && ++failures =3D=3D MAX_RECLAIM_RE=
TRIES)
>                                 break;
>
> +                       progress =3D 0;
>                         goto resched;
>                 }
>
> @@ -1391,10 +1407,15 @@ static void shrink_worker(struct work_struct *w)
>                 /* drop the extra reference */
>                 mem_cgroup_put(memcg);
>
> -               if (ret =3D=3D -EINVAL)
> -                       break;
> +               /* not a writeback candidate memcg */
> +               if (ret =3D=3D -EINVAL || ret =3D=3D -ENOENT)
> +                       continue;
> +

Can we get into an infinite loop or a really long running loops here
if all memcgs have their writeback disabled?

>                 if (ret && ++failures =3D=3D MAX_RECLAIM_RETRIES)
>                         break;
> +
> +               ++progress;
> +               /* reschedule as we performed some IO */
>  resched:
>                 cond_resched();
>         } while (zswap_total_pages() > thr);
> --
> 2.43.0
>

