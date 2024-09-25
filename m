Return-Path: <linux-kernel+bounces-339160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A39860E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4773289579
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C271AFB17;
	Wed, 25 Sep 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="B8WiRAYB"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBF18E366
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727271618; cv=none; b=lXpWpMfcL/FP+MYvdaoIbo6FOGgtXHxN+RJ4q1h5Pu+dvoEpLOA+4hpi2+9TqgkDdY7x0TfBJa4CA/3B4xEhxfYswROgRu1bX7CErQR9UkF7RTtotYP72XVrqX2tzIAgyT4/LzC8GXoTUGF57uQDxXv5N8yWrvMZVSyyMlzOnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727271618; c=relaxed/simple;
	bh=rwlboLF0urY4ENda3BUjKli8BiGjCS4nCC9iiKOxH+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPCTcs8wqcYPyDQw2f42zucKTsAH6Rj/LHGGlU91pmKaDKZChrWV1iy5FS9ubOz5FzH+JVmY0ySygksUSK33hF3tJIMQa8VIcSyF9+Nn/GfpBEZxPNU7QtOSiuxYuzZ/++aRtYvwmGGjrss/Zx/yEVmSopUKSyh5PAP3VJUwQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=B8WiRAYB; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-709339c91f9so2433324a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727271613; x=1727876413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=McGeQoVVUHZQD/E8iEOOr96UUUB38k+tRv+wS5Bnr4I=;
        b=B8WiRAYBweN9uJU3t8eoLU55bH06awt+A26K6LBEbviihGfdR03F79Dvm0g5WJjk77
         iWRpbaYchw8ys8kDQhLxmac/4CElcjYd9CeBIIsHMGdH5h07Muf7j3QzgGZdpYoqVusf
         4oYxoEHRgKUpmQzNd5OzD60IyYVWftXk8qJNF61dsVunEZr6uSf/dI/QRt4AiQVybGex
         +sxUWNpf0mJBMhF7nrItrLgyo5NkkX71/QVUVUDwiVTtD570kcM5jwUq0YuSHcSFCIdP
         4ARURFpQM5pGt5kv41rnZ8sFGBJ3g3cV5tCGi7TJZOFS6EVv4HlMZJfoSfziLX4odLrb
         J+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727271613; x=1727876413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McGeQoVVUHZQD/E8iEOOr96UUUB38k+tRv+wS5Bnr4I=;
        b=KT+K7VFaaxOXriF1lb+PcoQufFClKciFoRfJ0bzqDmd4+qD7AVSaZt2k3Xa7gfPplg
         UtRwr1QbD1XVgJStaqQMewvrV/rL3om+W5tPDbHyS9Y55VH+vc5GfzCXr12p9iKLslWa
         7HsILV4SyxBRnq7yAXdIgBx2FIaKCCKk3GZpxyi/Hmsxbiis+mGiPFIG81hc6tOKkVnk
         tEVCAFm5WrWtroy52m8IH4Lzuf1bHrIBPMUO6/MeAKvhM0CVzIbtOATFmsdWpLC6COSB
         cXAb9QuQs/17nQBeaQUaJSRn9LB9brSXuuX+pW+SJgyK6YVEk5byCEy+iMI6lWtUpXr+
         XlUA==
X-Forwarded-Encrypted: i=1; AJvYcCVSuTPj+4sqiGa+P+/Pz3hBFSV42iGQUwRk5NqjuuqyJPmQkJlAtf+D5mddC197GG+UIclvTz99Ze8Nxeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/Npekzkme7uqRTYzs1ExMeD1rCs7ESSrRNO5p6bdBAnvOSTS
	wWebP7YiSmE+eM+UfyZld372+A4UTGyj0/da8U1QLZ/67xGhWn/+/wW3fvgaCog=
X-Google-Smtp-Source: AGHT+IEBmiQhFGvJNTAGZVGuqfzWCKOHZFFZnC2VkTDxztLf+BWSeTA2UrM+rjv/sR1j2EDO6SIEqg==
X-Received: by 2002:a05:6359:4588:b0:1bc:58ba:bbb3 with SMTP id e5c5f4694b2df-1bea8652868mr124101455d.23.1727271613387;
        Wed, 25 Sep 2024 06:40:13 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a3e67sm16459206d6.2.2024.09.25.06.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:40:12 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:40:08 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Message-ID: <20240925134008.GA875661@cmpxchg.org>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
 <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>

On Tue, Sep 24, 2024 at 12:38:32PM -0700, Yosry Ahmed wrote:
> On Mon, Sep 23, 2024 at 6:17 PM Kanchana P Sridhar
> <kanchana.p.sridhar@intel.com> wrote:
> >
> > zswap_store() will now store mTHP and PMD-size THP folios by compressing
> > them page by page.
> >
> > This patch provides a sequential implementation of storing an mTHP in
> > zswap_store() by iterating through each page in the folio to compress
> > and store it in the zswap zpool.
> >
> > Towards this goal, zswap_compress() is modified to take a page instead
> > of a folio as input.
> >
> > Each page's swap offset is stored as a separate zswap entry.
> >
> > If an error is encountered during the store of any page in the mTHP,
> > all previous pages/entries stored will be invalidated. Thus, an mTHP
> > is either entirely stored in ZSWAP, or entirely not stored in ZSWAP.
> >
> > This forms the basis for building batching of pages during zswap store
> > of large folios by compressing batches of up to say, 8 pages in an
> > mTHP in parallel in hardware, with the Intel In-Memory Analytics
> > Accelerator (Intel IAA).
> >
> > A new config variable CONFIG_ZSWAP_STORE_THP_DEFAULT_ON (off by default)
> > will enable/disable zswap storing of (m)THP. The corresponding tunable
> > zswap module parameter is "mthp_enabled".
> >
> > This change reuses and adapts the functionality in Ryan Roberts' RFC
> > patch [1]:
> >
> >   "[RFC,v1] mm: zswap: Store large folios without splitting"
> >
> >   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.roberts@arm.com/T/#u
> >
> > Also, addressed some of the RFC comments from the discussion in [1].
> >
> > Co-developed-by: Ryan Roberts
> > Signed-off-by:
> > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > ---
> >  mm/Kconfig |   8 ++++
> >  mm/zswap.c | 122 +++++++++++++++++++++++++----------------------------
> >  2 files changed, 66 insertions(+), 64 deletions(-)
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 09aebca1cae3..c659fb732ec4 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -59,6 +59,14 @@ config ZSWAP_SHRINKER_DEFAULT_ON
> >           reducing the chance that cold pages will reside in the zswap pool
> >           and consume memory indefinitely.
> >
> > +config ZSWAP_STORE_THP_DEFAULT_ON
> > +       bool "Store mTHP and THP folios in zswap"
> > +       depends on ZSWAP
> > +       default n
> > +       help
> > +         If selected, zswap will process mTHP and THP folios by
> > +         compressing and storing each 4K page in the large folio.
> > +
> >  choice
> >         prompt "Default compressor"
> >         depends on ZSWAP
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 8f2e0ab34c84..16ab770546d6 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -127,6 +127,14 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
> >                 CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
> >  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
> >
> > +/*
> > + * Enable/disable zswap processing of mTHP folios.
> > + * For now, only zswap_store will process mTHP folios.
> > + */
> > +static bool zswap_mthp_enabled = IS_ENABLED(
> > +               CONFIG_ZSWAP_STORE_THP_DEFAULT_ON);
> > +module_param_named(mthp_enabled, zswap_mthp_enabled, bool, 0644);
> > +
> >  bool zswap_is_enabled(void)
> >  {
> >         return zswap_enabled;
> > @@ -1471,9 +1479,9 @@ static void zswap_delete_stored_offsets(struct xarray *tree,
> >   * @objcg: The folio's objcg.
> >   * @pool:  The zswap_pool to store the compressed data for the page.
> >   */
> > -static bool __maybe_unused zswap_store_page(struct folio *folio, long index,
> > -                                           struct obj_cgroup *objcg,
> > -                                           struct zswap_pool *pool)
> > +static bool zswap_store_page(struct folio *folio, long index,
> > +                            struct obj_cgroup *objcg,
> > +                            struct zswap_pool *pool)
> 
> As I mentioned earlier, the patch that introduced zswap_store_page()
> should have directly used it in zswap_store(). This would make this
> patch much clearer.
> 
> >  {
> >         swp_entry_t swp = folio->swap;
> >         int type = swp_type(swp);
> > @@ -1551,51 +1559,63 @@ static bool __maybe_unused zswap_store_page(struct folio *folio, long index,
> >         return false;
> >  }
> >
> > +/*
> > + * Modified to store mTHP folios. Each page in the mTHP will be compressed
> > + * and stored sequentially.
> > + */
> >  bool zswap_store(struct folio *folio)
> >  {
> >         long nr_pages = folio_nr_pages(folio);
> >         swp_entry_t swp = folio->swap;
> >         pgoff_t offset = swp_offset(swp);
> >         struct xarray *tree = swap_zswap_tree(swp);
> > -       struct zswap_entry *entry;
> >         struct obj_cgroup *objcg = NULL;
> >         struct mem_cgroup *memcg = NULL;
> > +       struct zswap_pool *pool;
> > +       bool ret = false;
> > +       long index;
> >
> >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> >
> > -       /* Large folios aren't supported */
> > -       if (folio_test_large(folio))
> > +       /* Storing large folios isn't enabled */
> 
> The comment is now stating the obvious, please remove it.
> 
> > +       if (!zswap_mthp_enabled && folio_test_large(folio))
> >                 return false;
> >
> >         if (!zswap_enabled)
> > -               goto check_old;
> > +               goto reject;
> >
> > -       /* Check cgroup limits */
> > +       /*
> > +        * Check cgroup limits:
> > +        *
> > +        * The cgroup zswap limit check is done once at the beginning of an
> > +        * mTHP store, and not within zswap_store_page() for each page
> > +        * in the mTHP. We do however check the zswap pool limits at the
> > +        * start of zswap_store_page(). What this means is, the cgroup
> > +        * could go over the limits by at most (HPAGE_PMD_NR - 1) pages.
> > +        * However, the per-store-page zswap pool limits check should
> > +        * hopefully trigger the cgroup aware and zswap LRU aware global
> > +        * reclaim implemented in the shrinker. If this assumption holds,
> > +        * the cgroup exceeding the zswap limits could potentially be
> > +        * resolved before the next zswap_store, and if it is not, the next
> > +        * zswap_store would fail the cgroup zswap limit check at the start.
> > +        */
> 
> I do not really like this. Allowing going one page above the limit is
> one thing, but one THP above the limit seems too much. I also don't
> like relying on the repeated limit checking in zswap_store_page(), if
> anything I think that should be batched too.
> 
> Is it too unreasonable to maintain the average compression ratio and
> use that to estimate limit checking for both memcg and global limits?
> Johannes, Nhat, any thoughts on this?

I honestly don't think it's much of an issue. The global limit is
huge, and the cgroup limit is to the best of my knowledge only used as
a binary switch. Setting a non-binary limit - global or cgroup - seems
like a bit of an obscure usecase to me, because in the vast majority
of cases it's preferable to keep compresing over declaring OOM.

And even if you do have some granular limit, the workload size scales
with it. It's not like you have a thousand THPs in a 10M cgroup.

If this ever becomes an issue, we can handle it in a fastpath-slowpath
scheme: check the limit up front for fast-path failure if we're
already maxed out, just like now; then make obj_cgroup_charge_zswap()
atomically charge against zswap.max and unwind the store if we raced.

For now, I would just keep the simple version we currently have: check
once in zswap_store() and then just go ahead for the whole folio.

