Return-Path: <linux-kernel+bounces-361638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B06899AAB7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159CA283EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7551C2327;
	Fri, 11 Oct 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NfhOYlYz"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE181BB6BB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669253; cv=none; b=URVPaIDwffQ7C/b9hAsB9IyLQB0bJv9oN+j3gfLkEXk+0iRy11QGP6xNYmRrRa9tLbV7GHzOiB8Br1pPpD8aGpgZ38/f2dYlp25HIJsk3v51+MHxUotIpANesF1Y1OJ2nD3XWk+NmnSUFQ6mFeZit6OL3XduzXd8sMxnOk5ayCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669253; c=relaxed/simple;
	bh=qjJpCZiPZXNYPLbj/e5/68U/1eHUjt8X51aHG6q35VA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbOkFBleKi1R2YqiCS1OEHdAVbugVxl2OfniVQjkEi/kyutP11iBPNr/jeY2tv6IlIVIPDhTECIRq//qrupW+VJiHgeTvBPK/jWYOTELH14SaTU4TVdb47wHdBCDQx5XaV3UUw7Di//CfJgnf6SFkqDIwkJ5sRxTbTNemq8ZRro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NfhOYlYz; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539d9fffea1so1116150e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728669250; x=1729274050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqgP/1pCCpSKuXinIt97h7bzJZWYuOT4pkGtBuCYT58=;
        b=NfhOYlYzTQnkxzhi+7XTI4Xes2LHvXGxtJn9IB0ChniY+dnPI0ZNIFlDuIvxEcoLvv
         vmV8uIKBmlAz1UBvf3W2ZT8zyQbIaB2/gRMzP2xBOMyuELgRJ/82wjAMszV1jP8opZ5H
         8VQc8kgSlEsbCCjbm+Y7sJiwpY5R9fMf+HO/TJr/H7iRwsTdpdqU6W9fAk07Dt7SkCcz
         aw9YtHjsxtLLc9hS3I9UhcRlV55bSY9crRtrLwFHvqRw4m/QpuiQUgiXWCAl0IWSzc2G
         mtywjFSbudbtZC0GLt0XU2X9iJBAcN4ETGvk5kycyDRNbBwvSc9ge9cgE4TppHRu1hia
         AM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669250; x=1729274050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqgP/1pCCpSKuXinIt97h7bzJZWYuOT4pkGtBuCYT58=;
        b=irT+3hO9Mgd8v8uoC/al6CXZiWgsTNYrGKvDlCelyOypP+LEW8N88HO97mofcq65re
         HXbi3Ih2H8wRGozGRQvPwmdLkN1N7rzbco/QYCZK9oFLhDqj2UkrJe4FsOdte0gh8DJr
         4zijxI5E++5IBszOQ6vGzu9mcyFoKd9rV91472AfMxoN5NMAjQtTymaEaxNuSuFZckFm
         rQtbTgWwQXUqgEroKuaNcrM34ZOy+/PWTX6zt50Ei2KAKpdqvGq+LU+qh3HQztJThn3E
         3bxRhXEgkk72Jhb81u6k2+DDemYL2MZBipJg/51Te7LHtGpjfHghRsOiS8p6jh5FaQqA
         Z1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVT+WABdJ1KYHv8BKA0xoW787hhSrGSNR6S9rTEL74dM9SiSZ9eBDCc24UxHnyzp4M3oGA1wGZEiZHSUiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tkh+NdIyppU3KTL47qTlLR/T7Ym4MYmv6BrBnp6Cjono4eRU
	91DYSFa3OsRwhNm5mXwnLcbFBDnsswJEy0yiA5l1jhTUC69I4h3m4zK+qfLerLsnXm7QSgcbbei
	KVZepgfGs0k1KoWLpBHdVV/dc3UAkK/1OssX5cg6o0QLKYNAMGOFi
X-Google-Smtp-Source: AGHT+IE4/pgk3+N8inlVBOFRVaQm590gXmHKPwVD060RWGiTTrhhVLw22lDhsmZT4Xjhs4+zlSvTHED2cAY3FKDysOA=
X-Received: by 2002:a05:6512:1588:b0:539:93b2:1383 with SMTP id
 2adb3069b0e04-539da5661c8mr1996729e87.46.1728669249759; Fri, 11 Oct 2024
 10:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011171950.62684-1-ryncsn@gmail.com>
In-Reply-To: <20241011171950.62684-1-ryncsn@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 11 Oct 2024 10:53:31 -0700
Message-ID: <CAJD7tkaZgEHUNce5c8LWpWXKnTZ7geOuBym41t+UoZax_nky7Q@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: avoid touching XArray for unnecessary invalidation
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, "Huang, Ying" <ying.huang@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 10:20=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> zswap_invalidation simply calls xa_erase, which acquires the Xarray
> lock first, then does a look up. This has a higher overhead even if
> zswap is not used or the tree is empty.
>
> So instead, do a very lightweight xa_empty check first, if there is
> nothing to erase, don't touch the lock or the tree.
>
> Using xa_empty rather than zswap_never_enabled is more helpful as it
> cover both case where zswap wes never used or the particular range
> doesn't have any zswap entry. And it's safe as the swap slot should
> be currently pinned by caller with HAS_CACHE.

You actually made me think whether it's better to replace
zswap_never_enabled() with something like zswap_may_have_swpentry()
that checks xa_empty() as well.

>
> Sequential SWAP in/out tests with zswap disabled showed a minor
> performance gain, SWAP in of zero page with zswap enabled also
> showed a performance gain. (swapout is basically unchanged so
> only test one case):
>
> Swapout of 2G zero page using brd as SWAP, zswap disabled
> (total time, 4 testrun, +0.1%):
> Before: 1705013 us 1703119 us 1704335 us 1705848 us.
> After:  1703579 us 1710640 us 1703625 us 1708699 us.
>
> Swapin of 2G zero page using brd as SWAP, zswap disabled
> (total time, 4 testrun, -3.5%):
> Before: 1912312 us 1915692 us 1905837 us 1912706 us.
> After:  1845354 us 1849691 us 1845868 us 1841828 us.
>
> Swapin of 2G zero page using brd as SWAP, zswap enabled
> (total time, 4 testrun, -3.3%):
> Before: 1897994 us 1894681 us 1899982 us 1898333 us
> After:  1835894 us 1834113 us 1832047 us 1833125 us
>
> Swapin of 2G random page using brd as SWAP, zswap enabled
> (total time, 4 testrun, -0.1%):
> Before: 4519747 us 4431078 us 4430185 us 4439999 us
> After:  4492176 us 4437796 us 4434612 us 4434289 us
>
> And the performance is very slightly better or unchanged for
> build kernel test with zswap enabled or disabled.
>
> Build Linux Kernel with defconfig and -j32 in 1G memory cgroup,
> using brd SWAP, zswap disabled (sys time in seconds, 6 testrun, -0.1%):
> Before: 1648.83 1653.52 1666.34 1665.95 1663.06 1656.67
> After:  1651.36 1661.89 1645.70 1657.45 1662.07 1652.83
>
> Build Linux Kernel with defconfig and -j32 in 2G memory cgroup,
> using brd SWAP zswap enabled (sys time in seconds, 6 testrun, -0.3%):
> Before: 1240.25 1254.06 1246.77 1265.92 1244.23 1227.74
> After:  1226.41 1218.21 1249.12 1249.13 1244.39 1233.01

Nice!

Do you know how the results change if we use xa_load() instead?

Or even do something like this to avoid doing the lookup twice:

XA_STATE(xas, ..);

rcu_read_lock();
entry =3D xas_load(&xas);
if (entry) {
    xas_lock(&xas);
    WARN_ON_ONCE(xas_reload(&xas) !=3D entry);
    xas_store(&xas, NULL);
    xas_unlock(&xas);
}
rcu_read_unlock();

On one hand, xa_empty() is cheaper. OTOH, xas_load() will also avoid
the lock if the tree is not empty yet the entry is not there. Actually
there's no reason why we can't check both.

I think the benefit of this would be most visible with SSD swap,
because zswap_load() will erase the entry from the xarray, and
zswap_invalidate() should always be able to avoid holding the lock.

>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Anyway, all of this is kinda orthogonal to this patch,

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7f00cc918e7c..f6316b66fb23 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1641,6 +1641,9 @@ void zswap_invalidate(swp_entry_t swp)
>         struct xarray *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
>
> +       if (xa_empty(tree))
> +               return;
> +
>         entry =3D xa_erase(tree, offset);
>         if (entry)
>                 zswap_entry_free(entry);
> --
> 2.47.0
>

