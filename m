Return-Path: <linux-kernel+bounces-532746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16594A451C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0371617D666
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0551514E4;
	Wed, 26 Feb 2025 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="II5E9AvS"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB0145B27
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531119; cv=none; b=TDmUZJACPhhI9Lok7qcUauttkKATvfE006Jixv/z7rOpY4nZWdTD+wNzPW4TXC/52/9/AnyWLzpSmJTI/DB2lIIUlyclYGJlfdDFZ5hl0xd75YJ7BL6GPA6929OCoIjItAk6Dmw09rd3BxXSPKuPZ5JTNGVkjPZDNTkZdljCnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531119; c=relaxed/simple;
	bh=Rwu6otacily7zAJMZZsHQ5IaHhwQrS4AQ5CG0K6gCzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBO2mLN2rUxcR910UbuggwI846N5Ft82sAGYB0lUkw2y6axJaiP0Iikxb9NSazg0ihlPDBsetuiZljXGYQL5A+IXS08kXmgLXujjLOgOk9L/hknrXCyNJzLn97a5csW+5hdNBwyb8k8nhIriFet1OawXcn0Oufb/B4zOeQIs7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=II5E9AvS; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e44fda56e3so3778856d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740531114; x=1741135914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAM8inQvtY5DGj2G6NXvF7xge4FZGHFAkat8ef3nbFM=;
        b=II5E9AvSP+IOo0Atj4yhTsZ+vAYqVwsQDYianxyrQ4Khf5z51OShgK8RAUknaTG4pQ
         RmO06aBFW7EXckwrnn5G26wZrKmq/XLajyN1pROKPobWqReGvbzvsEx0fx8kCqINjNnD
         KIvae+HDkF8swRozgnqypf2nqC/ij45bFil8OBFYSuWMBZp2nX2JYLdDSr192Muqk42/
         I+W80+CxJvGzqRhxvOK9VFaOCiB/KXSePeBhAfpROJoHENG+OIeo3o87lB0djv3OM+/M
         A3SjadZo5I8iiQopg+nC8BvrXrBW6+5SSDQjfE78FjDHTQ0ZRuFTvSCOirz3YxUzJDuw
         4luQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740531114; x=1741135914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAM8inQvtY5DGj2G6NXvF7xge4FZGHFAkat8ef3nbFM=;
        b=MiVaHg5fHWkpaYgYrWm2D3ijhdEcZ+guHr4SOBXWnsCWyEwqRZ1EhwKQKSCV/4F86w
         VXZCFYs/NgAD3Xbmn0lJRTvIToB7yo5lL6iPC5MWqakn8uts8tCmPzYJY5/ni6tLDC3+
         dKpOT64XtHhqhSq5k9TI2soZd1xhq77cuqEdMVwB6mf9lPulTZt9M42QDPJ/MGz8NfVs
         0O9O/XveeVFYwKrpSolEEtkxM3Q4Vfs7G0nNiBgNvk/v4v82quHSfvOt/OmqwNX86Xot
         3Qnzunr1unNt/xQf7J3cDFrhkbPhik4sBqWrpC15574tRHBTYfQMHqaJqmPgM1oysh9e
         OMLw==
X-Forwarded-Encrypted: i=1; AJvYcCVz5Dji2pl3JPt144rS3TJY4iXLFMfhNDWyMnk/DoH6cJYWTaPL1tPLHAz33sii6/eISmvGWyzpRwCkeW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycgoL9XdWnE5VCczXfo4byZIUjixmzjy/hXLfLhKmbiyOfWidQ
	I8lXaSLZvi4A1WHhw1VgmzXbOD1rHbDwA4u6DVn3qH8TpJeDLIHJ3kS7IypWMSo=
X-Gm-Gg: ASbGncsPluaFJeeMJcAiGG+tropTPgqxFscSjTc7CPFN42e6Va19KfganJ3KGHTdtEx
	hKjnnUay7IPSbMT2ma9xHSuTRUZlkH9BcL7sSSm0sn/3pSkngPU7mLkoPNc6/OG/89rmY+Urx/R
	3CN2A9vXsNB2l/EOj1b3n4kj/ieSVwe8ysqCf1DDbHcqhfvPmG41DXrNUWJupoiQUW2kLFD33Dx
	bObgefCvyTOatx4nZg6Z9dbzyRSWyDiVhry2M6jIHVTSoFCFuslMJaj7pi3jmSQqP/2ev0hJzL2
	NrCiYfMaYnKj4bzXKNW5K9pC
X-Google-Smtp-Source: AGHT+IEHtCZgirfdLjKUhS5v7/WA0Xig1OgVsaRdpMj0BDfsQM7QTY7Gz4zxp9HVWykrQ/dSB7PPWA==
X-Received: by 2002:a05:6214:2401:b0:6e6:9b86:85d0 with SMTP id 6a1803df08f44-6e6a259c330mr319603746d6.8.1740531114354;
        Tue, 25 Feb 2025 16:51:54 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e87b09c5acsm16054256d6.52.2025.02.25.16.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 16:51:53 -0800 (PST)
Date: Tue, 25 Feb 2025 19:51:49 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, yosryahmed@google.com,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <20250226005149.GA1500140@cmpxchg.org>
References: <20250225213200.729056-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225213200.729056-1-nphamcs@gmail.com>

On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> Currently, we crash the kernel when a decompression failure occurs in
> zswap (either because of memory corruption, or a bug in the compression
> algorithm). This is overkill. We should only SIGBUS the unfortunate
> process asking for the zswap entry on zswap load, and skip the corrupted
> entry in zswap writeback.
> 
> See [1] for a recent upstream discussion about this.
> 
> [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zswap.c | 85 +++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 58 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb23..31d4397eed61 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -62,6 +62,8 @@ static u64 zswap_reject_reclaim_fail;
>  static u64 zswap_reject_compress_fail;
>  /* Compressed page was too big for the allocator to (optimally) store */
>  static u64 zswap_reject_compress_poor;
> +/* Load and writeback failed due to decompression failure */
> +static u64 zswap_reject_decompress_fail;

"reject" refers to "rejected store", so the name doesn't quite make
sense. zswap_decompress_fail?

>  /* Store failed because underlying allocator could not get memory */
>  static u64 zswap_reject_alloc_fail;
>  /* Store failed because the entry metadata could not be allocated (rare) */
> @@ -953,11 +955,12 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>  	return comp_ret == 0 && alloc_ret == 0;
>  }
>  
> -static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> +static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  {
>  	struct zpool *zpool = entry->pool->zpool;
>  	struct scatterlist input, output;
>  	struct crypto_acomp_ctx *acomp_ctx;
> +	bool ret = true;
>  	u8 *src;
>  
>  	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
> @@ -984,12 +987,19 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>  	sg_init_table(&output, 1);
>  	sg_set_folio(&output, folio, PAGE_SIZE, 0);
>  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
> -	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
> -	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
> +	if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait) ||
> +			acomp_ctx->req->dlen != PAGE_SIZE) {
> +		ret = false;
> +		zswap_reject_decompress_fail++;
> +		pr_alert_ratelimited(
> +			"decompression failed on zswap entry with offset %08lx\n",
> +			entry->swpentry.val);

Since this is a pretty dramatic failure scenario, IMO it would be
useful to dump as much info as possible.

The exact return value of crypto_wait_req() could be useful,
entry->length and req->dlen too.

entry->pool->tfm_name just to make absolute sure there is no
confusion, as the compressor can be switched for new stores.

Maybe swp_type() and swp_offset() of entry->swpentry? Those could be
easy markers to see if the entry was corrupted for example.

> +	}
>  	mutex_unlock(&acomp_ctx->mutex);
>  
>  	if (src != acomp_ctx->buffer)
>  		zpool_unmap_handle(zpool, entry->handle);
> +	return ret;
>  }
>  
>  /*********************************
> @@ -1018,6 +1028,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	struct writeback_control wbc = {
>  		.sync_mode = WB_SYNC_NONE,
>  	};
> +	int ret = 0;
>  
>  	/* try to allocate swap cache folio */
>  	mpol = get_task_policy(current);
> @@ -1034,8 +1045,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	 * and freed when invalidated by the concurrent shrinker anyway.
>  	 */
>  	if (!folio_was_allocated) {
> -		folio_put(folio);
> -		return -EEXIST;
> +		ret = -EEXIST;
> +		goto put_folio;
>  	}
>  
>  	/*
> @@ -1048,14 +1059,17 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	 * be dereferenced.
>  	 */
>  	tree = swap_zswap_tree(swpentry);
> -	if (entry != xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL)) {
> -		delete_from_swap_cache(folio);
> -		folio_unlock(folio);
> -		folio_put(folio);
> -		return -ENOMEM;
> +	if (entry != xa_load(tree, offset)) {
> +		ret = -ENOMEM;
> +		goto fail;
>  	}
>  
> -	zswap_decompress(entry, folio);
> +	if (!zswap_decompress(entry, folio)) {
> +		ret = -EIO;
> +		goto fail;
> +	}
> +
> +	xa_erase(tree, offset);
>  
>  	count_vm_event(ZSWPWB);
>  	if (entry->objcg)
> @@ -1071,9 +1085,14 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  
>  	/* start writeback */
>  	__swap_writepage(folio, &wbc);
> -	folio_put(folio);
> +	goto put_folio;
>  
> -	return 0;
> +fail:
> +	delete_from_swap_cache(folio);
> +	folio_unlock(folio);
> +put_folio:
> +	folio_put(folio);
> +	return ret;
>  }

Nice, yeah it's time for factoring out the error unwinding. If you
write it like this, you can save a jump in the main sequence:

	__swap_writepage(folio, &wbc);
	ret = 0;
put:
	folio_put(folio);
	return ret;
delete_unlock:
	delete_from_swap_cache(folio);
	folio_unlock(folio);
	goto put;

>  
>  /*********************************
> @@ -1600,6 +1619,29 @@ bool zswap_load(struct folio *folio)
>  	if (WARN_ON_ONCE(folio_test_large(folio)))
>  		return true;
>  
> +	/*
> +	 * We cannot invalidate the zswap entry before decompressing it. If
> +	 * decompression fails, we must keep the entry in the tree so that
> +	 * a future read by another process on the same swap entry will also
> +	 * have to go through zswap. Otherwise, we risk silently reading
> +	 * corrupted data for the other process.
> +	 */
> +	entry = xa_load(tree, offset);
> +	if (!entry)
> +		return false;

The explanation in the comment makes sense in the context of this
change. But fresh eyes reading this function and having never seen
that this *used to* open with xa_erase() will be confused. It answers
questions the reader doesn't have at this point - it's just a function
called zswap_load() beginning with an xa_load(), so what?

At first I was going to suggest moving it down to the swapcache
branch. But honestly after reading *that* comment again, in the new
sequence, I don't think the question will arise there either. It's
pretty self-evident that the whole "we can invalidate when reading
into the swapcache" does not apply if the read failed.

> +	/*
> +	 * If decompression fails, we return true to notify the caller that the
> +	 * folio's data were in zswap, but do not mark the folio as up-to-date.
> +	 * This will effectively SIGBUS the calling process.
> +	 */

It would be good to put a lampshade on this weirdness that the return
value has nothing to do with success or not. This wasn't as important
a distinction, but with actual decompression failures I think it is.

Something like this?

	if (!zswap_decompress(entry, folio)) {
		/*
		 * The zswap_load() return value doesn't indicate success or
		 * failure, but whether zswap owns the swapped out contents.
		 * This MUST return true here, otherwise swap_readpage() will
		 * read garbage from the backend.
		 *
		 * Success is signaled by marking the folio uptodate.
		 */
		return true;
	}

	folio_mark_uptodate(folio);

> +	if (!zswap_decompress(entry, folio))
> +		return true;
> +
> +	count_vm_event(ZSWPIN);
> +	if (entry->objcg)
> +		count_objcg_events(entry->objcg, ZSWPIN, 1);
> +
>  	/*
>  	 * When reading into the swapcache, invalidate our entry. The
>  	 * swapcache can be the authoritative owner of the page and
> @@ -1612,21 +1654,8 @@ bool zswap_load(struct folio *folio)
>  	 * files, which reads into a private page and may free it if
>  	 * the fault fails. We remain the primary owner of the entry.)
>  	 */
> -	if (swapcache)
> -		entry = xa_erase(tree, offset);
> -	else
> -		entry = xa_load(tree, offset);
> -
> -	if (!entry)
> -		return false;
> -
> -	zswap_decompress(entry, folio);
> -
> -	count_vm_event(ZSWPIN);
> -	if (entry->objcg)
> -		count_objcg_events(entry->objcg, ZSWPIN, 1);
> -
>  	if (swapcache) {
> +		xa_erase(tree, offset);
>  		zswap_entry_free(entry);
>  		folio_mark_dirty(folio);
>  	}

