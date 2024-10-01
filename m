Return-Path: <linux-kernel+bounces-345077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C35CC98B1B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA711C223D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23C5C144;
	Tue,  1 Oct 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="emNIkE/3"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C42BA33
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745276; cv=none; b=nqSXmlH/Jyn1DPJcv2hWZEIlK342tYDRTyW5fRDqG0TwfP/7V+U2XiK5fX8nf7ygkkiJGy6P4yanOB3hn6HdZ6wIoW64eSfGW9mAVLimZM3NAfsC+GoUjk+X/wWZeO9bC5L76L3Ec06/v667thSZC/pQxUIhVnyDxMpDvxbrzM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745276; c=relaxed/simple;
	bh=8D2mdiwzBjuROyTQZkBeIDEydwgoxiku9yL7tdYwifM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAvXjsi0/Xmq80nmpF7czLlaGkMsWnMtSEMYTU4Q6hwLCl8NBWBi63b2R3EqemF8psahJNKPhyy55P2Ql05GBPnn71f169rzXG+N02i0Xt5u7HC+cUXmbstYpcVnGWn39OmDUNjEoUwXiS9thtsXmjLWAnj7GnbXC1LzgiCrKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=emNIkE/3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9ae0e116cso506561185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727745270; x=1728350070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0s1DjarmO4wOj63Wm0i8dMF+ZESKuDscREAVAOOO+n0=;
        b=emNIkE/3cB8Cl7SEgF2xCnlquwLJ6+7elbYxj1bsy2lXlmUsWovpkDT1cNt8gdMNnt
         zahiqrZ+jS99M35L2FJcu/0FfITkLEUK2jfPdnxdRyVLzHIIiI3EIVYmbbCL5tyciTBi
         ef9biZpNQxLuC0oYoVqoCugMbQC1rr81xw0cB6mIiBg/GkLoaSjvRX8Q14PzI8j8Kaor
         NsbmHDGFpgPzxwS0bpjKI0f/FYZZApIpio6yrjTu30CgU7VmmhGO3mysgp5TiD5bI2z+
         I0oJvjIirunRrlNhO7oozYs2pu1XScSqZbwjKeuG6dTL5xko1yVxMFTc8wtfC3ELLxux
         MnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727745270; x=1728350070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s1DjarmO4wOj63Wm0i8dMF+ZESKuDscREAVAOOO+n0=;
        b=Sl0afpKbpYcq/hBNeThtqjbfryzMD+vGRthkz0QfJuFAmIy6ehOyubiWk0uOyPE3Dp
         fVtbmIrTdHduRBetgI04pwv7cWrbbhOh7q0OM5qpu6aNLC+1mt2ZlB2vIs0++8EC4cKR
         1wZZjX6qyPds3/X84PkxxHivPlt+GQjXehYqEN7sPVAod4q+0OQROgsSwyRTt3oPtMtq
         FZ/WakEwl3XHUsRErvF9HnzOY+OSw5QjMx0nZcFVg32ZIvdfZkZnq4McxeC8+JUTmnm/
         /nQQCFrUW93kv9cS+vNIRj0/3fpxHrATWNECPt4urzEV78rfDU9J+K5AzEawNcLFg/EU
         MR7Q==
X-Gm-Message-State: AOJu0YyMNTh/15VDlaHoul1ItAs/MuGRJGheL5KCFGnsNTd9Uwm/n7Pc
	p+a6Bt8bZk618r5modMYG/pKU2ToI/FMiJTsqI0Yxr0angMHJzVwcpboEruXA70=
X-Google-Smtp-Source: AGHT+IHCSV2jRsOeNTYdq31Eeb3YuJQ7np5Z2rA9CMANG0M4kXbYHAYPp19mWIHmWlI1FzZwj5l3ng==
X-Received: by 2002:a05:620a:394f:b0:7ad:c2ab:c643 with SMTP id af79cd13be357-7ae3798d7c0mr2431225685a.63.1727745270474;
        Mon, 30 Sep 2024 18:14:30 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae37858425sm452506385a.135.2024.09.30.18.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 18:14:29 -0700 (PDT)
Date: Mon, 30 Sep 2024 21:14:24 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, willy@infradead.org,
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com
Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
Message-ID: <20241001011424.GB1349@cmpxchg.org>
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930221221.6981-7-kanchana.p.sridhar@intel.com>

On Mon, Sep 30, 2024 at 03:12:20PM -0700, Kanchana P Sridhar wrote:
>  /*********************************
>  * main API
>  **********************************/
> -bool zswap_store(struct folio *folio)
> +
> +/*
> + * Stores the page at specified "index" in a folio.

There is no more index and no folio in this function.

> + *
> + * @page:  The page to store in zswap.
> + * @objcg: The folio's objcg. Caller has a reference.
> + * @pool:  The zswap_pool to store the compressed data for the page.
> + *         The caller should have obtained a reference to a valid
> + *         zswap_pool by calling zswap_pool_tryget(), to pass as this
> + *         argument.
> + * @tree:  The xarray for the @page's folio's swap.

This doesn't look safe.

If the entries were to span a SWAP_ADDRESS_SPACE_SHIFT boundary, the
subpage entries would need to be spread out to different trees also.
Otherwise, it would break loading and writeback down the line.

I *think* it works right now, but at best it's not very future proof.
Please look up the tree inside the function for the specific
swp_entry_t that is being stored.

Same for the unwind/check_old: section.

> + * @compressed_bytes: The compressed entry->length value is added
> + *                    to this, so that the caller can get the total
> + *                    compressed lengths of all sub-pages in a folio.
> + */

With just one caller, IMO the function comment can be dropped...

>  	/* allocate entry */
> -	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
> +	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(page_folio(page)));

page_to_nid() is safe to use here.

> +bool zswap_store(struct folio *folio)
> +{
> +	long nr_pages = folio_nr_pages(folio);
> +	swp_entry_t swp = folio->swap;
> +	struct xarray *tree = swap_zswap_tree(swp);
> +	struct obj_cgroup *objcg = NULL;
> +	struct mem_cgroup *memcg = NULL;
> +	struct zswap_pool *pool;
> +	size_t compressed_bytes = 0;
> +	bool ret = false;
> +	long index;
> +
> +	VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> +
> +	if (!zswap_enabled)
> +		goto check_old;
> +
> +	/*
> +	 * Check cgroup zswap limits:
> +	 *
> +	 * The cgroup zswap limit check is done once at the beginning of
> +	 * zswap_store(). The cgroup charging is done once, at the end
> +	 * of a successful folio store. What this means is, if the cgroup
> +	 * was within the zswap_max limit at the beginning of a large folio
> +	 * store, it could go over the limit by at most (HPAGE_PMD_NR - 1)
> +	 * pages due to this store.
> +	 */
> +	objcg = get_obj_cgroup_from_folio(folio);
> +	if (objcg && !obj_cgroup_may_zswap(objcg)) {
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		if (shrink_memcg(memcg)) {
> +			mem_cgroup_put(memcg);
> +			goto put_objcg;
> +		}
> +		mem_cgroup_put(memcg);
> +	}
> +
> +	/*
> +	 * Check zpool utilization against zswap limits:
> +	 *
> +	 * The zswap zpool utilization is also checked against the limits
> +	 * just once, at the start of zswap_store(). If the check passes,
> +	 * any breaches of the limits set by zswap_max_pages() or
> +	 * zswap_accept_thr_pages() that may happen while storing this
> +	 * folio, will only be detected during the next call to
> +	 * zswap_store() by any process.
> +	 */
> +	if (zswap_check_limits())
> +		goto put_objcg;

There has been some back and forth on those comments. Both checks are
non-atomic and subject to races, so mentioning the HPAGE_PMD_NR - 1
overrun is somewhat misleading - it's much higher in the worst case.

Honestly, I would just get rid of the comments. You're not changing
anything fundamental in this regard, so I don't think there is a
burden to add new comments either.

> +
> +	pool = zswap_pool_current_get();
> +	if (!pool)
> +		goto put_objcg;
> +
> +	if (objcg) {
> +		memcg = get_mem_cgroup_from_objcg(objcg);
> +		if (memcg_list_lru_alloc(memcg, &zswap_list_lru, GFP_KERNEL)) {
> +			mem_cgroup_put(memcg);
> +			goto put_pool;
> +		}
> +		mem_cgroup_put(memcg);
> +	}
> +
> +	/*
> +	 * Store each page of the folio as a separate entry. If we fail to
> +	 * store a page, unwind by deleting all the pages for this folio
> +	 * currently in zswap.
> +	 */

The first sentence explains something that is internal to
zswap_store_page(). The second sentence IMO is obvious from the code
itself. I think you can delete this comment.

> +	for (index = 0; index < nr_pages; ++index) {
> +		if (!zswap_store_page(folio_page(folio, index), objcg, pool, tree, &compressed_bytes))
> +			goto put_pool;

Hah, I'm not a stickler for the 80 column line limit, but this is
pushing it ;)

Please grab the page up front.

Yosry had also suggested replacing the compressed_bytes return
parameter with an actual return value. Basically, return compressed
bytes on success, -errno on error. I think this comment was missed
among the page_swap_entry() discussion.

	for (index = 0; index < nr_pages; index++) {
		struct page *page = folio_page(folio, index);
		int bytes;

		bytes = zswap_store_page(page, object, pool, tree);
		if (bytes < 0)
			goto put_pool;
		total_bytes += bytes;
	}

