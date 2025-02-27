Return-Path: <linux-kernel+bounces-537362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD872A48AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB4B188D077
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1906C27427C;
	Thu, 27 Feb 2025 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b8SRXH8Z"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A527425C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693323; cv=none; b=a9toBjCZwCo05SWtDmdmEChaVgSBRb6s0ZrbfRsbtbKSHORJj/zuYenrVjjjCTsU8nIHdeAD9KvSKMh51h//P4dSneyrhpak1odCI/xTb23cJmYsH5Cl0QABk1jxDbQPIxasx3ktUexcv8JA5JTU5P8EAtEO24unJnSP4dGYO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693323; c=relaxed/simple;
	bh=Mz2SHy9YHroLqN+Sf9PvIMDQ8FygBfYr3eEDO7hcdzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9X55o00eFeW6jw10USmGI4RaTa3rbS4f1755aE41CIk5g6ajlStqWWhvBJmXTY5yJNKk95SMyyguZQE8tEPquWb3TUZd0vQebVutX53thFB6l+e+jQBD3/sHCztn+Sm9WKk8GtI0xtE1wP1dBg4/lkem2Cw2u9pdyBbx042Ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b8SRXH8Z; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 21:55:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740693318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFg2zuo548IMIIuv4McDGaoyHDjLrtngqpZZrXkgG2E=;
	b=b8SRXH8ZJOO3+adX0eOnYQGQkjoTal1FzaV2cTTaiSoKv62CyhPBwh+b7or0o2PFDYFsDf
	wkEdd2bhKp4lmV9BCBS9d1lPNiCoUbMFhI2xtxyyK3roOrp6Ejo6qCn6M/dXSPO+NfBlSF
	OuI9lGR1CgXmtof5HDPTTkgN52mCY4M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression
 failure
Message-ID: <Z8DfQahDy7ig643i@google.com>
References: <20250227001445.1099203-1-nphamcs@gmail.com>
 <Z7-9o81kBfw4tFSz@google.com>
 <CAKEwX=MR7bhebu+7qnoUrADL0C2Uqi3Ta7Beo=s0Aim28BSDVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=MR7bhebu+7qnoUrADL0C2Uqi3Ta7Beo=s0Aim28BSDVw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 01:46:29PM -0800, Nhat Pham wrote:
> On Wed, Feb 26, 2025 at 5:19 PM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> >
> > On Wed, Feb 26, 2025 at 04:14:45PM -0800, Nhat Pham wrote:
> > > Currently, we crash the kernel when a decompression failure occurs in
> > > zswap (either because of memory corruption, or a bug in the compression
> > > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > > process asking for the zswap entry on zswap load, and skip the corrupted
> > > entry in zswap writeback. The former is accomplished by returning true
> > > from zswap_load(), indicating that zswap owns the swapped out content,
> > > but without flagging the folio as up-to-date. The process trying to swap
> > > in the page will check for the uptodate folio flag and SIGBUS (see
> > > do_swap_page() in mm/memory.c for more details).
> >
> > We should call out the extra xarray walks and their perf impact (if
> > any).
> 
> Lemme throw this in a quick and dirty test. I doubt there's any
> impact, but since I'm reworking this patch for a third version anyway
> might as well.

It's likely everything is cache hot and the impact is minimal, but let's
do the due diligence.

> 
> >
> > >
> > > See [1] for a recent upstream discussion about this.
> > >
> > > [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> > >
> > > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > > Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  mm/zswap.c | 94 ++++++++++++++++++++++++++++++++++++++----------------
> > >  1 file changed, 67 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 6dbf31bd2218..e4a2157bbc64 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -62,6 +62,8 @@ static u64 zswap_reject_reclaim_fail;
> > >  static u64 zswap_reject_compress_fail;
> > >  /* Compressed page was too big for the allocator to (optimally) store */
> > >  static u64 zswap_reject_compress_poor;
> > > +/* Load or writeback failed due to decompression failure */
> > > +static u64 zswap_decompress_fail;
> > >  /* Store failed because underlying allocator could not get memory */
> > >  static u64 zswap_reject_alloc_fail;
> > >  /* Store failed because the entry metadata could not be allocated (rare) */
> > > @@ -996,11 +998,13 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
> > >       return comp_ret == 0 && alloc_ret == 0;
> > >  }
> > >
> > > -static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> > > +static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> > >  {
> > >       struct zpool *zpool = entry->pool->zpool;
> > >       struct scatterlist input, output;
> > >       struct crypto_acomp_ctx *acomp_ctx;
> > > +     int decomp_ret;
> > > +     bool ret = true;
> > >       u8 *src;
> > >
> > >       acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
> > > @@ -1025,12 +1029,25 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> > >       sg_init_table(&output, 1);
> > >       sg_set_folio(&output, folio, PAGE_SIZE, 0);
> > >       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
> > > -     BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
> > > -     BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
> > > +     decomp_ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
> > > +     if (decomp_ret || acomp_ctx->req->dlen != PAGE_SIZE) {
> > > +             ret = false;
> > > +             zswap_decompress_fail++;
> > > +             pr_alert_ratelimited(
> > > +                     "decompression failed with returned value %d on zswap entry with swap entry value %08lx, swap type %d, and swap offset %lu. compression algorithm is %s. compressed size is %u bytes, and decompressed size is %u bytes.\n",
> >
> > This is a very long line. I think we should break it into multiple
> > lines. I know multiline strings are frowned upon by checkpatch, by this
> > exist (see the warning in mem_cgroup_oom_control_write() for example),
> > and they are definitely better than a very long line imo.
> 
> My personal take is I prefer multi line strings, but was not sure what
> is the "preferred" or "official" style. Oh well.
> 
> >
> > > +                     decomp_ret,
> > > +                     entry->swpentry.val,
> > > +                     swp_type(entry->swpentry),
> > > +                     swp_offset(entry->swpentry),
> > > +                     entry->pool->tfm_name,
> > > +                     entry->length,
> > > +                     acomp_ctx->req->dlen);
> > > +     }
> > >
> > >       if (src != acomp_ctx->buffer)
> > >               zpool_unmap_handle(zpool, entry->handle);
> > >       acomp_ctx_put_unlock(acomp_ctx);
> > > +     return ret;
> >
> > Not a big deal but we could probably store the length in a local
> > variable and move the check here, and avoid needing 'ret'.
> 
> Ah the suggestion you made in an older version right? But sounds like
> we're just trading some one local variable for another?
> 
> That said, it *technically* move some work outside of the lock
> section. I'll just give it a try :)

My goal is not really to get rid of the local variable, but rather to
obviously return 'true' or 'false' directly rather than a 'ret' value.

> 
> >
> > >  }
> > >
> > >  /*********************************
> > > @@ -1060,6 +1077,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > >       struct writeback_control wbc = {
> > >               .sync_mode = WB_SYNC_NONE,
> > >       };
> > > +     int ret = 0;
> > >
> > >       /* try to allocate swap cache folio */
> > >       si = get_swap_device(swpentry);
> > > @@ -1081,8 +1099,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > >        * and freed when invalidated by the concurrent shrinker anyway.
> > >        */
> > >       if (!folio_was_allocated) {
> > > -             folio_put(folio);
> > > -             return -EEXIST;
> > > +             ret = -EEXIST;
> > > +             goto put_folio;
> > >       }
> > >
> > >       /*
> > > @@ -1095,14 +1113,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > >        * be dereferenced.
> > >        */
> > >       tree = swap_zswap_tree(swpentry);
> > > -     if (entry != xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL)) {
> > > -             delete_from_swap_cache(folio);
> > > -             folio_unlock(folio);
> > > -             folio_put(folio);
> > > -             return -ENOMEM;
> > > +     if (entry != xa_load(tree, offset)) {
> > > +             ret = -ENOMEM;
> > > +             goto delete_unlock;
> > > +     }
> > > +
> > > +     if (!zswap_decompress(entry, folio)) {
> > > +             ret = -EIO;
> > > +             goto delete_unlock;
> > >       }
> > >
> > > -     zswap_decompress(entry, folio);
> > > +     xa_erase(tree, offset);
> > >
> > >       count_vm_event(ZSWPWB);
> > >       if (entry->objcg)
> > > @@ -1118,9 +1139,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
> > >
> > >       /* start writeback */
> > >       __swap_writepage(folio, &wbc);
> > > -     folio_put(folio);
> > >
> > > -     return 0;
> > > +put_folio:
> > > +     folio_put(folio);
> > > +     return ret;
> > > +delete_unlock:
> > > +     delete_from_swap_cache(folio);
> > > +     folio_unlock(folio);
> > > +     goto put_folio;
> >
> > I think I suggested a way to avoid this goto in v1:
> > https://lore.kernel.org/lkml/Z782SPcJI8DFISRa@google.com/.
> >
> > Did this not work out?
> 
> Oh I thought your suggestion was the same as Johannes. Let me take a
> closer look...
> 
> >
> > >  }
> > >
> > >  /*********************************
> > > @@ -1620,6 +1646,20 @@ bool zswap_store(struct folio *folio)
> > >       return ret;
> > >  }
> > >
> > > +/**
> > > + * zswap_load() - load a page from zswap
> > > + * @folio: folio to load
> > > + *
> > > + * Returns: true if zswap owns the swapped out contents, false otherwise.
> > > + *
> > > + * Note that the zswap_load() return value doesn't indicate success or failure,
> > > + * but whether zswap owns the swapped out contents. This MUST return true if
> > > + * zswap does own the swapped out contents, even if it fails to write the
> > > + * contents to the folio. Otherwise, the caller will try to read garbage from
> > > + * the backend.
> > > + *
> > > + * Success is signaled by marking the folio uptodate.
> > > + */
> > >  bool zswap_load(struct folio *folio)
> > >  {
> > >       swp_entry_t swp = folio->swap;
> > > @@ -1644,6 +1684,17 @@ bool zswap_load(struct folio *folio)
> >
> > The comment that exists here (not visible in the diff) should be
> > abbreviated now that we already explained the whole uptodate thing
> > above, right?
> 
> Lemme take a stab at it :)

Take a look at the other thread between Johannes and I first. We
discussed more involved changes around this.

