Return-Path: <linux-kernel+bounces-339241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DEB9863CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1632DB22E25
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C280019DF41;
	Wed, 25 Sep 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="AVuH250i"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB919CD18
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274471; cv=none; b=k0RufXrnBO06XAZszvuCwQAyiGBGPMkCCgmvpraFpBj9JFHd8hNgUtktCXffrlQscoSZjl/lU35yIEkEQohVIUTL5ArF2bkxEmHhjrxUuOQJ7EBxaGyVQVwqT73xD/LEN9cs7rcSAFve9SDqxKfTsjl6eLRu8IfMxAWI8SKzn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274471; c=relaxed/simple;
	bh=ZzzS60uv4ljHoqQHnDejqf+hAYHuRqdqRY36I/hxpF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFjfw7nAe5AnpURTDGyhUBkSTegCx3HYfiHZ+kcXB6FiT3yfzQv7UIxIV9WpagOCPz2mrRDSPfsIvANZoGDvYaMkLZaGAhGxUSZPM54Rf9OPEbq2HdD/hWib+ofG+PdPcMdcE2uUf63R6cPdYJoTGAPRayTC31WcH9dsNrtqnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=AVuH250i; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e28ac7b12bso1978368b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1727274467; x=1727879267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9xuDs0O2NIXp8UPqHHqSImvA0i85ajjStdE4N4dJtc=;
        b=AVuH250i7oln710SKRDZsgy/h52zrqItyk4CFu2VgeokBR8n98i9xYPoCVjUOj0xHR
         TRKEX+BUM+CA93YOp7WRG+eyCaQDbjSOkbT4J0pf5rtNXy7K/mjvI/suSxbTaKWQ/z7R
         S5rVVf3e6Q/eJbo7d4QQVSthMKgb4lEgGeqK/oMQufeejZ2Asdh4TSs13s4AeQSzKdVJ
         JnLejjXX6UIRG5RslhSsPaEct/kzh5a0qW5kT/GazUe4thDrUXgrpMRuttrWisKwV8Mt
         G6d+6Fnu179ftVpV5x9XppIzbRb/or/nm/B89fmlnbspezmU/04XQfmnmLzsEZVQEF4y
         AB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274467; x=1727879267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9xuDs0O2NIXp8UPqHHqSImvA0i85ajjStdE4N4dJtc=;
        b=XOlT1BuLXK3nsgoF1o7JbU/+jFlxIgSMcjYZ8WnLMFkuxAveCp5rRZKjKOpq54tlt8
         EtUbp3i3Jg8/gDF9z0zSsZwxeDcRon1r+waZqQfryahV/Ia51W8TQmBtmRE31utEkbYs
         fJdns+wzI14Qc571lNz0R6KLfOjSALnAkOpJJViY5XpcR5seoIDToWwROBZb6lui9lk3
         xKkNimp8DpGS04693hsbREDrOpuRRtiYNez7PQetrWnyoQxq0CFVJfczXv43yZwqbOM9
         pE/TuXLW6UuOjKf7gXCS43M9poAK8J7TjoKkk/wkDbVdCYb1hOCS/sqgyTswMC9zJLgG
         5Htw==
X-Gm-Message-State: AOJu0Yz6UU7jljqb4R+6Ht3DCUTdvSjbJEH4mJh8DtQy3/K713a4PirT
	8RnrHMgNrbTLR0XV2qPO1T46KRdtBe07fiubxo7KcJkirwRqvpIbnHP1HkSdsQ0=
X-Google-Smtp-Source: AGHT+IEaTCjLpPOwjeSEBlfUhCYq6QmFy5hAPP5pogiSTL8OV99sTcjYg3h7Qxvi1xGvnwwxGYbXtA==
X-Received: by 2002:a05:6808:13c6:b0:3e2:92ca:92d3 with SMTP id 5614622812f47-3e29b7d23b1mr2090942b6e.34.1727274467067;
        Wed, 25 Sep 2024 07:27:47 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257af1asm16612941cf.36.2024.09.25.07.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:27:45 -0700 (PDT)
Date: Wed, 25 Sep 2024 10:27:41 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, yosryahmed@google.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com,
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
Message-ID: <20240925142741.GD875661@cmpxchg.org>
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924011709.7037-7-kanchana.p.sridhar@intel.com>

On Mon, Sep 23, 2024 at 06:17:07PM -0700, Kanchana P Sridhar wrote:
> zswap_store() will now store mTHP and PMD-size THP folios by compressing

The hugepage terminology throughout the patches is a bit convoluted.

There is no real distinction in this code between PMD-size THPs and
sub-PMD-sized mTHPs e.g. In particular, I think "mTHP" made sense when
they were added, to distinguish them from conventional THPs. But using
this term going forward just causes confusion, IMO.

We're going through a big effort in the codebase to call all of these
things simply "folios" - which stands for "one or more pages". If you
want to emphasize the "more than one page", the convention is to call
it a "large folio". (If you need to emphasize that it's PMD size -
which doesn't apply to these patches, but just for the record - the
convention is "pmd-mappable folio".)

So what this patch set does is "support large folios in zswap".

> @@ -1551,51 +1559,63 @@ static bool __maybe_unused zswap_store_page(struct folio *folio, long index,
>  	return false;
>  }
>  
> +/*
> + * Modified to store mTHP folios. Each page in the mTHP will be compressed
> + * and stored sequentially.
> + */

This is a changelog, not a code comment ;) Please delete it.

>  bool zswap_store(struct folio *folio)
>  {
>  	long nr_pages = folio_nr_pages(folio);
>  	swp_entry_t swp = folio->swap;
>  	pgoff_t offset = swp_offset(swp);
>  	struct xarray *tree = swap_zswap_tree(swp);
> -	struct zswap_entry *entry;
>  	struct obj_cgroup *objcg = NULL;
>  	struct mem_cgroup *memcg = NULL;
> +	struct zswap_pool *pool;
> +	bool ret = false;
> +	long index;
>  
>  	VM_WARN_ON_ONCE(!folio_test_locked(folio));
>  	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
>  
> -	/* Large folios aren't supported */
> -	if (folio_test_large(folio))
> +	/* Storing large folios isn't enabled */
> +	if (!zswap_mthp_enabled && folio_test_large(folio))
>  		return false;
>  
>  	if (!zswap_enabled)
> -		goto check_old;
> +		goto reject;
>  
> -	/* Check cgroup limits */
> +	/*
> +	 * Check cgroup limits:
> +	 *
> +	 * The cgroup zswap limit check is done once at the beginning of an
> +	 * mTHP store, and not within zswap_store_page() for each page
> +	 * in the mTHP. We do however check the zswap pool limits at the

Use "folio" and "large folio" as appropriate here and throughout.

