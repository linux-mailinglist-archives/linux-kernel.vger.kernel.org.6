Return-Path: <linux-kernel+bounces-342393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DBE988E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC75280E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2BB19DF98;
	Sat, 28 Sep 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nn/VKvLK"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AACA12E75
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727511239; cv=none; b=XSEUZ2ScwiC3QU9aT/0yV99NaJXSQ09b6VK/4VCsOyQsFh5r/s0jtdhytKcecBuU12LPRIx1xGrCP3vVAxWiQQ0vbMjGNBhKqfpAOpKbUw0lFPkeTCLVBnxG7AvJDslqnhdfKw4Uwz7sseamh1nf5pGmGhEqKHTndoNdqOG3BBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727511239; c=relaxed/simple;
	bh=PCfPUgekunsUPpNb7IEDB+/9AjSynlVl6jE+DpngVjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axThzCDg5zE32Du5pa+XM67ZJ2r82LvWhwyHcCQDmVRDDFIwkdDMQcXGMHxsKqNPgFuoUUJJ+5yu1iKGc2mzoCjJp0bAf/m0M16hZvaiY9AgZTDIHP8uDTdLZZ8GzajMqDZRjy/fqIcAxf2fKP5qEGu3RMCyacg41UG3FbPz8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nn/VKvLK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso423782766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727511236; x=1728116036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ex55oB2RndkmTH+vNm3pK4T3zGQ1Bq6pi9mDoc4Yk8=;
        b=Nn/VKvLKqHyG5iD4f37rL2aXKmvQDrwdZmXJ9gByxCWYS7cBCPeCUbOHfMdSPo7zlF
         aP0uv1Cr/4q/G+/MwdW5lbewvJgFi6JRx0ANH3ua8D+qkBmOwnOtb7P7CS3+utOOlhAc
         66xmSFI+OqUOUfGTAhAws5j0n3uGQmcZGaMYdNQgWBjzYF0s2jzipWfJBQ7FgJ7WE4e1
         8BnQeGNgs8TTbHADCcATQ8qLNeSsVlLMvl5EPfWyG9nnHouOO36rPq7A4VdIVSXaTuty
         GfCZwLdC+5ZacCxy7NLyD/btHpQdmoT4rVLyNUgiGbZzuS36vnYCfMDQDMjVtBA+u7Fi
         xvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727511236; x=1728116036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ex55oB2RndkmTH+vNm3pK4T3zGQ1Bq6pi9mDoc4Yk8=;
        b=qAJ2gCxSEw3BKknvO4HnBpmW9r830vpXdsdlL5w25xDN46uPzDM1su8MIYH4h2bUxg
         QzH6ngFmHXHjuaJnsf/sUBJAUxXSYnjXFKL6JCB2Ctq+07k7ZrNzt5WK+Xlgbe5E4w+z
         ciTZsAkK8e2PEvoDcMQGfZAFWqfbX89S8wQOjIdjAkgldjhIc3sxAyAQSKZ2h5UZ8D31
         mKyPJGYl7Y/tlVqYYyflpWA1cgllhl+aFA8iDltwvYeJp4hjuQmHqnbtgg+xzg9xvcEJ
         sS15QT1zLA0bC+RoN8xGrurY/0scikAeO+ziGetLJqfI8JjGG1vdpQqxngmwvg2nY9zq
         wY/g==
X-Gm-Message-State: AOJu0YwFSnksvyNIdpcGONs8hRyJU1OFOFKBFQ2DsztOUZGrUnx+2POp
	y5UYPkZMDboilGGuodpIHxBI1Y/6BTaZgIwfX9uOzxDPc1/LX5pjCt49HTH0jjBmO/rtrNswRuz
	3Hq7zuVV9PwM31pqdBF8CeaCv3PGK2qT7rThasmnZZ/O6DU9jg02S
X-Google-Smtp-Source: AGHT+IHJoQNvj4WuoG3BEUT6h2Z59xll4tEIN5d4r+tn2ZgXb1kCmUqkyjV2H8FNdl5OuW8kQgZzNUWmgeCCug3TXqw=
X-Received: by 2002:a17:907:9344:b0:a8d:55ce:fb7f with SMTP id
 a640c23a62f3a-a93c4c40561mr475735066b.62.1727511235478; Sat, 28 Sep 2024
 01:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com> <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Sat, 28 Sep 2024 01:13:19 -0700
Message-ID: <CAJD7tkbCrrpPBnm1vE2_pBZCjc1i3w37Pf-5hb1Bt7Xd552=FQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be atomic_long_t.
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
> For zswap_store() to support large folios, we need to be able to do
> a batch update of zswap_stored_pages upon successful store of all pages
> in the folio. For this, we need to add folio_nr_pages(), which returns
> a long, to zswap_stored_pages.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  fs/proc/meminfo.c     |  2 +-
>  include/linux/zswap.h |  2 +-
>  mm/zswap.c            | 19 +++++++++++++------
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 245171d9164b..8ba9b1472390 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -91,7 +91,7 @@ static int meminfo_proc_show(struct seq_file *m, void *=
v)
>  #ifdef CONFIG_ZSWAP
>         show_val_kb(m, "Zswap:          ", zswap_total_pages());
>         seq_printf(m,  "Zswapped:       %8lu kB\n",
> -                  (unsigned long)atomic_read(&zswap_stored_pages) <<
> +                  (unsigned long)atomic_long_read(&zswap_stored_pages) <=
<

Do we still need this cast? "HardwareCorrupted" seems to be using
atomic_long_read() without a cast.

Otherwise this LGTM:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

>                    (PAGE_SHIFT - 10));
>  #endif
>         show_val_kb(m, "Dirty:          ",
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 9cd1beef0654..d961ead91bf1 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -7,7 +7,7 @@
>
>  struct lruvec;
>
> -extern atomic_t zswap_stored_pages;
> +extern atomic_long_t zswap_stored_pages;
>
>  #ifdef CONFIG_ZSWAP
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0f281e50a034..43e4e216db41 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -43,7 +43,7 @@
>  * statistics
>  **********************************/
>  /* The number of compressed pages currently stored in zswap */
> -atomic_t zswap_stored_pages =3D ATOMIC_INIT(0);
> +atomic_long_t zswap_stored_pages =3D ATOMIC_INIT(0);
>
>  /*
>   * The statistics below are not protected from concurrent access for
> @@ -802,7 +802,7 @@ static void zswap_entry_free(struct zswap_entry *entr=
y)
>                 obj_cgroup_put(entry->objcg);
>         }
>         zswap_entry_cache_free(entry);
> -       atomic_dec(&zswap_stored_pages);
> +       atomic_long_dec(&zswap_stored_pages);
>  }
>
>  /*********************************
> @@ -1232,7 +1232,7 @@ static unsigned long zswap_shrinker_count(struct sh=
rinker *shrinker,
>                 nr_stored =3D memcg_page_state(memcg, MEMCG_ZSWAPPED);
>         } else {
>                 nr_backing =3D zswap_total_pages();
> -               nr_stored =3D atomic_read(&zswap_stored_pages);
> +               nr_stored =3D atomic_long_read(&zswap_stored_pages);
>         }
>
>         if (!nr_stored)
> @@ -1501,7 +1501,7 @@ bool zswap_store(struct folio *folio)
>         }
>
>         /* update stats */
> -       atomic_inc(&zswap_stored_pages);
> +       atomic_long_inc(&zswap_stored_pages);
>         count_vm_event(ZSWPOUT);
>
>         return true;
> @@ -1650,6 +1650,13 @@ static int debugfs_get_total_size(void *data, u64 =
*val)
>  }
>  DEFINE_DEBUGFS_ATTRIBUTE(total_size_fops, debugfs_get_total_size, NULL, =
"%llu\n");
>
> +static int debugfs_get_stored_pages(void *data, u64 *val)
> +{
> +       *val =3D atomic_long_read(&zswap_stored_pages);
> +       return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(stored_pages_fops, debugfs_get_stored_pages, NU=
LL, "%llu\n");
> +
>  static int zswap_debugfs_init(void)
>  {
>         if (!debugfs_initialized())
> @@ -1673,8 +1680,8 @@ static int zswap_debugfs_init(void)
>                            zswap_debugfs_root, &zswap_written_back_pages)=
;
>         debugfs_create_file("pool_total_size", 0444,
>                             zswap_debugfs_root, NULL, &total_size_fops);
> -       debugfs_create_atomic_t("stored_pages", 0444,
> -                               zswap_debugfs_root, &zswap_stored_pages);
> +       debugfs_create_file("stored_pages", 0444,
> +                           zswap_debugfs_root, NULL, &stored_pages_fops)=
;
>
>         return 0;
>  }
> --
> 2.27.0
>

