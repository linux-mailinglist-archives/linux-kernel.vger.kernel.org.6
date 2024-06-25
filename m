Return-Path: <linux-kernel+bounces-229278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040EA916DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37794B272F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18AE170838;
	Tue, 25 Jun 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmwD6rSk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02BF15382E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331578; cv=none; b=b7PbFGxGIS5SRUiS6Zki58yM6Kq8t2gAhg45p9tUdcPrwhd+707VRqc0Vvhea25n5bqBBADSlg4QvWUpCmplGDOTFKdf0I2QkfcVcEXSUILwpPoY2JELyL3DYMFGfDy8AsiuKkf0Y4C28K9QMDM8pwDLrXHG/w/2J2vrXLYgHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331578; c=relaxed/simple;
	bh=h09MbXzjs75XRlEGTEqAxyYxcxdNwSXO7b1gJP2XE2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+rYifM1rIpEZlri4Zk0ibjJoBETHrK+WxHumjdLbkZV9YeNHIdp9A4K0ORPgQzbTkMwoRTMZchRTAAvlH7UmAJVzfjKrmaXa0AJhqhEkiXd77rQM0K9LOmk6VPBDsQ+2zYJHXXGY5YuXsMaewUrwv1lIzboZBUL3JVCDQNlWa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmwD6rSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737C0C4AF0B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719331577;
	bh=h09MbXzjs75XRlEGTEqAxyYxcxdNwSXO7b1gJP2XE2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tmwD6rSk8Q099uQ+ymfIcI97a6J8yvtqiLi4TbnNjawoCJbWV4vhdmeOjzicSvy2Q
	 B50v/FGaswxNZ34buqi918I9i3xi82qP8IRzSx/bKkYjqqOtrABSASmS9+AsBzthTC
	 BOLSD1OqvEMTf1RVNdha9R9axFtmAFRimpjsgRKxQFi5Uowg4OsQ4Dslu1HdsF29zd
	 8tIfuZXukpYb+5DsW9JBdFeYon27i0rKk9tCQyo8VDdKtfJ9t56L2+VkWQyMXzAk1n
	 xbem0DLce5IhPywhf/coebHB9pmIX1gKcgNTHwFDokQTocPa6qM9UlDfLbuSzKaPXQ
	 FMWd7vagqlVcQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cd80e55efso7236342e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:06:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpFghZJMmqu5wtypqPgEPafKCYdIeIMZF60QAaeHjTBBMPa3nk7tUD2BuyO2bzg5mV69eGYQlTWjizePnXgHYLcoQoyVpxEW7wfy6W
X-Gm-Message-State: AOJu0YyrISnBe5erVSO/CASeeKf6zMVOlombA5ijO7+FxDZWmS+6qJeL
	MStOnxQRuRQCPNgKbR/Rlwgibx1K23rmlkA9gbYebiAZs5OSjV67si2cCwwrwcZIjkPmWKB0pUW
	W1BgnXdCgR1j973eHsJjvhqkCgg==
X-Google-Smtp-Source: AGHT+IEpP6+BBiiySTD3qWmFYC2HlHUVMgxsA+Xe+BW33VhWVg18kiDSkRdrL3YOFOoSRuRemIy7U/34Ad6BHARQR9E=
X-Received: by 2002:ac2:4d11:0:b0:52c:8342:6699 with SMTP id
 2adb3069b0e04-52ce1852897mr5644149e87.55.1719331575874; Tue, 25 Jun 2024
 09:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618232648.4090299-1-ryan.roberts@arm.com> <1cb60685-3c34-4441-81e1-a60adc70d1f2@arm.com>
In-Reply-To: <1cb60685-3c34-4441-81e1-a60adc70d1f2@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 25 Jun 2024 09:06:04 -0700
X-Gmail-Original-Message-ID: <CANeU7Qnmh6+7CSO3pTvTiJ6_4jA=+h2_KDtYz-Yx3pfT5-snyg@mail.gmail.com>
Message-ID: <CANeU7Qnmh6+7CSO3pTvTiJ6_4jA=+h2_KDtYz-Yx3pfT5-snyg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/5] Alternative mTHP swap allocator improvements
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 1:02=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 19/06/2024 00:26, Ryan Roberts wrote:
> > Hi All,
> >
> > Chris has been doing great work at [1] to clean up my mess in the mTHP =
swap
> > entry allocator. But Barry posted a test program and results at [2] sho=
wing that
> > even with Chris's changes, there are still some fallbacks (around 5% - =
25% in
> > some cases). I was interested in why that might be and ended up putting=
 this PoC
> > patch set together to try to get a better understanding. This series en=
ds up
> > achieving 0% fallback, even with small folios ("-s") enabled. I haven't=
 done
> > much testing beyond that (yet) but thought it was worth posting on the =
strength
> > of that result alone.
> >
> > At a high level this works in a similar way to Chris's series; it marks=
 a
> > cluster as being for a particular order and if a new cluster cannot be =
allocated
> > then it scans through the existing non-full clusters. But it does it by=
 scanning
> > through the clusters rather than assembling them into a list. Cluster f=
lags are
> > used to mark clusters that have been scanned and are known not to have =
enough
> > contiguous space, so the efficiency should be similar in practice.
> >
> > Because its not based around a linked list, there is less churn and I'm
> > wondering if this is perhaps easier to review and potentially even get =
into
> > v6.10-rcX to fix up what's already there, rather than having to wait un=
til v6.11
> > for Chris's series? I know Chris has a larger roadmap of improvements, =
so at
> > best I see this as a tactical fix that will ultimately be superseeded b=
y Chris's
> > work.
> >
> > There are a few differences to note vs Chris's series:
> >
> > - order-0 fallback scanning is still allowed in any cluster; the argume=
nt in the
> >   past was that swap should always use all the swap space, so I've left=
 this
> >   mechanism in. It is only a fallback though; first the the new per-ord=
er
> >   scanner is invoked, even for order-0, so if there are free slots in c=
lusters
> >   already assigned for order-0, then the allocation will go there.
> >
> > - CPUs can steal slots from other CPU's current clusters; those cluster=
s remain
> >   scannable while they are current for a CPU and are only made unscanna=
ble when
> >   no more CPUs are scanning that particular cluster.
> >
> > - I'm preferring to allocate a free cluster ahead of per-order scanning=
, since,
> >   as I understand it, the original intent of a per-cpu current cluster =
was to
> >   get pages for an application adjacent in the swap to speed up IO.
>
> [...]
>
> I've been having a play, trying to extend this to actively free swap entr=
ies to make sufficient space for a new allcoation if the entries are alread=
y in swap cache. (To be clear, I'm not pursuing this series for inclusion, =
but was just trying to put some numbers to the idea, which could later be a=
dded to Chris's series if it makes sense).
>
> However, I'm running into an unexpected issue; It was my previous underst=
anding that if the swap map for an entry is SWAP_HAS_CACHE, then there is a=
 folio in the swap cache and nothing is referencing the swap entry, so the =
entry can be freed with __try_to_reclaim_swap() - that's the pattern that t=
he existing oder-0 scanner uses.
>
> But I'm finding that __try_to_reclaim_swap() always returns 0, indicating=
 that no folio was associated with the swap entry. How can that be, if swap=
_map[offset] =3D=3D SWAP_HAS_CACHE ?

I saw that in my test too. Some swap entries remain as SWAP_HAS_CACHE
which contribute to the swap allocation failure rate.

One possibility is that the zram is hitting the synchronous IO case
for swap in, it does not put the folio in swap cache when serving the
swap in. In commit 13ddaf26be324a7f951891ecd9ccd04466d27458 from
Kairui, the SWAP_HAS_CACHE flag was added for synchronous IO, in order
to address a race in the swap in. But the SWAP_HAS_CACHE should be
cleaned up after swap in fault though. I did not have a chance to dig
deeper into the root cause of those SWAP_HAS_CACHE entries yet.

Chris

>
> Here is my code, for reference. Note that "evict" is always set true to b=
e very agressive for now, but the eventual idea is that it would only be se=
t to true when certain criteria are met (e.g. last attempt to allocate for =
order either failed or had to evict to succeed).
>
> With logging added, every single call to __try_to_reclaim_swap() returns =
0. (well it also live locks due to that with code as shown, but I hacked ar=
ound that in experiments). Any ideas, before I dig deeper?
>
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f6d78723f0fd..928d61e1d9d5 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -641,13 +641,25 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info=
_struct *si,
>  }
>
>  static inline bool swap_range_empty(char *swap_map, unsigned int start,
> -                                   unsigned int nr_pages)
> +                                   unsigned int nr_pages, bool *inc_cach=
ed)
>  {
>         unsigned int i;
> -
> -       for (i =3D 0; i < nr_pages; i++) {
> -               if (swap_map[start + i])
> -                       return false;
> +       bool hit_cache =3D false;
> +
> +       if (*inc_cached) {
> +               for (i =3D 0; i < nr_pages; i++) {
> +                       if (swap_map[start + i]) {
> +                               if (swap_map[start + i] !=3D SWAP_HAS_CAC=
HE)
> +                                       return false;
> +                               hit_cache =3D true;
> +                       }
> +               }
> +               *inc_cached =3D hit_cache;
> +       } else {
> +               for (i =3D 0; i < nr_pages; i++) {
> +                       if (swap_map[start + i])
> +                               return false;
> +               }
>         }
>
>         return true;
> @@ -760,6 +772,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap=
_info_struct *si,
>         struct swap_cluster_info *ci;
>         unsigned int tmp, max;
>         unsigned int stop =3D SWAP_NEXT_INVALID;
> +       bool evict =3D true;
>
>  new_cluster:
>         cluster =3D this_cpu_ptr(si->percpu_cluster);
> @@ -799,18 +812,48 @@ static bool scan_swap_map_try_ssd_cluster(struct sw=
ap_info_struct *si,
>          * natural alignment.
>          */
>         max =3D ALIGN(tmp + 1, SWAPFILE_CLUSTER);
> -       ci =3D lock_cluster(si, tmp);
> -       while (tmp < max) {
> -               if (swap_range_empty(si->swap_map, tmp, nr_pages))
> -                       break;
> -               tmp +=3D nr_pages;
> +scan_cluster:
> +       if (tmp < max) {
> +               ci =3D lock_cluster(si, tmp);
> +               while (tmp < max) {
> +                       if (swap_range_empty(si->swap_map, tmp, nr_pages,=
 &evict))
> +                               break;
> +                       tmp +=3D nr_pages;
> +               }
> +               unlock_cluster(ci);
>         }
> -       unlock_cluster(ci);
>         if (tmp >=3D max) {
>                 cluster_dec_scanners(ci);
>                 cluster->next[order] =3D SWAP_NEXT_INVALID;
>                 goto new_cluster;
>         }
> +       if (evict) {
> +               unsigned int off;
> +               int nr;
> +
> +               spin_unlock(&si->lock);
> +
> +               for (off =3D tmp; off < tmp + nr_pages; off +=3D nr) {
> +                       nr =3D 1;
> +                       if (READ_ONCE(si->swap_map[off]) =3D=3D SWAP_HAS_=
CACHE) {
> +                               nr =3D __try_to_reclaim_swap(si, off, TTR=
S_ANYWAY);
> +                               if (nr < 0)
> +                                       break;
> +                               else if (nr =3D=3D 0)
> +                                       nr =3D 1;
> +                               nr =3D ALIGN(off + 1, nr) - off;
> +                       }
> +               }
> +
> +               spin_lock(&si->lock);
> +               *scan_base =3D this_cpu_read(*si->cluster_next_cpu);
> +               *offset =3D *scan_base;
> +
> +               if (nr < 0)
> +                       tmp +=3D nr_pages;
> +
> +               goto scan_cluster;
> +       }
>         *offset =3D tmp;
>         *scan_base =3D tmp;
>         tmp +=3D nr_pages;
>
>

