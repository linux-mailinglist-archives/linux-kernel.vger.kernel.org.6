Return-Path: <linux-kernel+bounces-342333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92259988DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31902832F2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF75199E82;
	Sat, 28 Sep 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFxYVwr5"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DAF19992D
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727492310; cv=none; b=sNKpcKZg2osX3gnYnJi53LlUnV9YE5yWSBxWhU6HItpz/TfaAtSEeUX8Ln/i0vCN2HhmXSxJC6fofy3OGsjupnqSgkdYK42kKP/HcL8pp+nMtVmZqjeN6viHf/8LTzwyM2H0ht3+peKkW1dcVeMT85uOXfmICXLWp9d7dvRqLVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727492310; c=relaxed/simple;
	bh=0ERr88NPJD74t2sV7m4BpPqdzeEqKfXo0Y0vU+DsUUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNIBiPuYl7JpV3/7qd13pNdSonobLbJt5jIfX8l5h+npxC1MnQks+MtPMCZNxSQ/Vb0e16a9HLC+VnX2Tw21zOUszMVfrAq4Kod4klrEAKHUAONLUF2ZcoNeceBvPMx5WNZspo9eeI2mbI8UDK6DzSw9mAwQq71q0ZHNFcmeF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFxYVwr5; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86e9db75b9so446476866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727492307; x=1728097107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBnslGHNkgK0iSD95MbBwxYtaH03aQzOnJDIdBQN0rk=;
        b=fFxYVwr5J/IpIg1pD3IubboxOn6D7XA/d/qrjj6EE9eNvZriCZopvnKF11EQRGOhnU
         3lNfr72aQt+tlCcc4n6/JyUnm6d2nEA8+uFOSRZ/04qZ64maRlmA6Xp9cE0txIYSqYmY
         XWuCo6bKGone9cB+iv3qd5BZRXdS+vI4WHdSnPn9pp7cRz1TSr7jExh80Ndi1rEdaQqv
         QrjT7Kirv2+FRorBPZpOTTkjNuOaX20IlQTZfuQVaz3EDy1TxNZ6vIro0PD7rU+kB9pQ
         kjBYxpSEILaGQjAy51aNlDZ7x3oAvfYp5EVFPPnUxX9dBFAr0fIVzEFv/HtNsos2I2PM
         njKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727492307; x=1728097107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBnslGHNkgK0iSD95MbBwxYtaH03aQzOnJDIdBQN0rk=;
        b=UM1Y/Nw40+a2QMxfHtSvcpNJ/C/rSFEGvhBvZuKLPxAsHpKrmyuIGz5BFdzG4GT5FK
         taxUQeao8+r0a2b/ZrEcrKBWpkubnY8w+lwHpsqQFIjzRjpZGW76jNCrWlpQ0z3x1wAt
         bKIEsl6DYBB7I0ALTlSvvLePwYfdB+R8qVcGDclX5wdlKfD0vcm/qIcG4NlYg8OiemGB
         V7Ylzs8DId35/RX+0TKCHWJvbe2FMMyaEgYsnMVSrDs/gamzDfy/eYgfcXSb8GUxTEDe
         tpvyZhudlPuKCVLwmpd8aWBjZuG8JE47Emkz8Ymg8ayeStjIoOM7UQ8uIkwzpFkkRxxa
         tJaA==
X-Gm-Message-State: AOJu0Yw9AY62fFT9bx8nDJxfmQWpaBQ1eP4T779iOakLL9DZx7q3cVWc
	4GOa0j7lhQW0JquGpkI2KSuWoffBle/6nwQWojeWbNYSkX4xft2Eby1oB0CdoTv0Ev4vw36NIXN
	gRtwijpEI4we15eJJIV3bw7GxPZIjjmCWE71ztNQCFrHYgs5j+DX8
X-Google-Smtp-Source: AGHT+IHz1mc7wzRpBmD+b6Xl5CBMCT4PuOVm744FyVXy2jW4DjjiSTdUedMAyy3WPUqWtFYCtXSK9uKEhnOaTqbMvbs=
X-Received: by 2002:a17:907:a01:b0:a8d:e49:c530 with SMTP id
 a640c23a62f3a-a93c4a671bbmr565728466b.42.1727492306965; Fri, 27 Sep 2024
 19:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com> <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240928021620.8369-6-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 27 Sep 2024 19:57:49 -0700
Message-ID: <CAJD7tka0qyRWhgHrC9p1ytfDKVPr9bBTFCYy7HC4DZ-Ovfu7VQ@mail.gmail.com>
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

Do we really need this? A lot of places in the kernel assign the
result of folio_nr_pages() to an int (thp_nr_pages(),
split_huge_pages_all(), etc). I don't think we need to worry about
folio_nr_pages() exceeding INT_MAX for a while.

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

