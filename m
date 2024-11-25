Return-Path: <linux-kernel+bounces-421667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4147D9D8E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB25B169390
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF35B1C9DD8;
	Mon, 25 Nov 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="CRcJ9f2+"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBAE14F9CF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732571254; cv=none; b=baV56CczhAwISGrhS0dPeE0O6FZ9AvpyIC4oLq8GISGnQ1SuPluah8G3oqYhtazmKb0F1cRLn6cFJoTT8AoPBuGpMiT1KFqIdZR4IGVrKTBThHtdIbTzn6biNkG9udHti//xQ3DtJOW1Frd3f+OV/PAIp+/CKV2vfoLtyWrffJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732571254; c=relaxed/simple;
	bh=BCFEI089OstDC4wCknzDn8MmVL/CYY0GGcM3o69XVxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB6YvGSR7cz80OJ6HXNM47NZY19M+vZpucnMuIfcUIqdOhUvRRZ0+hIrpaN3Hzg3ZlKVhH05XT1sPs1b6cmdXlcPmNtba5sFOpyp+9FDCQuH7/OhibAgFQ6COOiUu/bxGSt64tczIgy5PEYSt0lcz/YzVGmpcsCGWMCldP7UVn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=CRcJ9f2+; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d41d46162eso30412616d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1732571250; x=1733176050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XqWF7E0ew5gNQ6985xZJ/5/jCKh2abtLrhXPLjbHCyE=;
        b=CRcJ9f2+ZA8k13PJZzUlQaNpBe456mQtAV9DJ9f864z7seaKTUPWPtbrxN4g6h4Htr
         i6Ev6okjqvmmRoKJ0o8alcNtovWjojl9+ZdiTgExwE37sFeuvvgYsR4FKhJ3tuCFImkj
         1WuIVHquLIsOEoQctlUSrmy5gV8dHaluaGeoSN8k++w0GCHboq2QlVXEfkR6zQ00HX+I
         /7CisfOLgVCs/trBi3+30l2j3S54D2b4mC6fak4dCD96NyldVWClibMM9m5DmRnOZCsm
         HvJ2eQbxiT+XOJUbqffchd5kxifyKGr/UF33PabY09pMcI2hFf1/s+VhBxFU57s/D65N
         kjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732571250; x=1733176050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqWF7E0ew5gNQ6985xZJ/5/jCKh2abtLrhXPLjbHCyE=;
        b=f6qp116OB7C/0p25PJfomtknud9FeDpDr05I8NDQhq7xnu3cKIFWuAgJqqZSmWgQ5P
         wvrFqgAC3pErLw+d6p2eWNNe3U5OTCfJA6BzJ9X9Qdfz0j/aRPKN0t8Fq8IQ2QIDesWY
         oc32y0lC47E0z0WCZtzGvRxcwfNnWEqNqD1BYD0YuLJbxB83/zZp9x2X5ecT1SxJc4RW
         rW7gFOlC2Yz9ZosbcknNprjo25o00fylZ4q8erXEHKIRvFPNthHy4qkQGLDrWbbSV9MZ
         aWm7c+Y4qQ+IJA2OtkY7hzjjTxn8JeExYqUcbuKuC1A62fCP4uCliYDklKupdf1Fx6pD
         s2fg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2iJRBM0sfC1aaYflVzxEGMcKvRpYgBU05HbLsG7O+nI3ceRfnv7gl4tQ/IRxw0zLyci8LKMXk75rZqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOTa4ybozP+qXlmCnwaPTqb7MlImOlSTo0gwvx62pxNuO9S6wQ
	6R+llTFG2tX7M5/4a0FgUNkyOD82dRE1WOCR/a5fYvuvzaQ+H/I4NDDEDGGMDvg=
X-Gm-Gg: ASbGncuOCvna2UvirfzvRTjDUHp76Tol0ynfNOY5yERdUXAko6Ym+5+EbZ0UYEEEr+U
	s2Teyq+NwErMuj2wIald8o2f4OrwF7mA9VeegKXeaeNsyvLfxsh0sRmRsgmCxies/Q2FU8K7p6C
	AtfDxY9RpufLmHD2YMZZIfuS07d7O+gaG/jnHPQcX4rBHaeAHedn1/oL+k8S16Iydpfhmi4K7KJ
	+5zVYH5JTuXpl0/xX2DeAdqWn9vVVXA//8wmmmW9wYHB7t4
X-Google-Smtp-Source: AGHT+IGhSINo662ZCmiw+KQ9F9w1c9zeHSlcbXLmFv0aSFwhD9uNu7MMnjUNn7TV9kplOqArqzYj3A==
X-Received: by 2002:a05:6214:629:b0:6d4:3c10:5065 with SMTP id 6a1803df08f44-6d451345419mr187969176d6.32.1732571249894;
        Mon, 25 Nov 2024 13:47:29 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a831bbsm47429646d6.27.2024.11.25.13.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 13:47:28 -0800 (PST)
Date: Mon, 25 Nov 2024 16:47:24 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	chengming.zhou@linux.dev, usamaarif642@gmail.com,
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com,
	akpm@linux-foundation.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	clabbe@baylibre.com, ardb@kernel.org, ebiggers@google.com,
	surenb@google.com, kristen.c.accardi@intel.com,
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Subject: Re: [PATCH v4 10/10] mm: zswap: Compress batching with Intel IAA in
 zswap_batch_store() of large folios.
Message-ID: <20241125214724.GA2405574@cmpxchg.org>
References: <20241123070127.332773-1-kanchana.p.sridhar@intel.com>
 <20241123070127.332773-11-kanchana.p.sridhar@intel.com>
 <CAJD7tkb0WyLD3hxQ5fHWHogyW5g+eF+GrR15r0PjK9YbFO3szg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkb0WyLD3hxQ5fHWHogyW5g+eF+GrR15r0PjK9YbFO3szg@mail.gmail.com>

On Mon, Nov 25, 2024 at 12:20:01PM -0800, Yosry Ahmed wrote:
> On Fri, Nov 22, 2024 at 11:01 PM Kanchana P Sridhar
> <kanchana.p.sridhar@intel.com> wrote:
> >
> > This patch adds two new zswap API:
> >
> >  1) bool zswap_can_batch(void);
> >  2) void zswap_batch_store(struct folio_batch *batch, int *errors);
> >
> > Higher level mm code, for instance, swap_writepage(), can query if the
> > current zswap pool supports batching, by calling zswap_can_batch(). If so
> > it can invoke zswap_batch_store() to swapout a large folio much more
> > efficiently to zswap, instead of calling zswap_store().
> >
> > Hence, on systems with Intel IAA hardware compress/decompress accelerators,
> > swap_writepage() will invoke zswap_batch_store() for large folios.
> >
> > zswap_batch_store() will call crypto_acomp_batch_compress() to compress up
> > to SWAP_CRYPTO_BATCH_SIZE (i.e. 8) pages in large folios in parallel using
> > the multiple compress engines available in IAA.
> >
> > On platforms with multiple IAA devices per package, compress jobs from all
> > cores in a package will be distributed among all IAA devices in the package
> > by the iaa_crypto driver.
> >
> > The newly added zswap_batch_store() follows the general structure of
> > zswap_store(). Some amount of restructuring and optimization is done to
> > minimize failure points for a batch, fail early and maximize the zswap
> > store pipeline occupancy with SWAP_CRYPTO_BATCH_SIZE pages, potentially
> > from multiple folios in future. This is intended to maximize reclaim
> > throughput with the IAA hardware parallel compressions.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> 
> This is definitely not what I suggested :)
> 
> I won't speak for Johannes here but I suspect it's not quite what he
> wanted either.

It is not.

I suggested having an integrated code path where "legacy" stores of
single pages is just the batch_size=1 case.

https://lore.kernel.org/linux-mm/20241107185340.GG1172372@cmpxchg.org/

> What we really need to do (and I suppose what Johannes meant, but
> please correct me if I am wrong), is to make the existing flow work
> with batches.
> 
> For example, most of zswap_store() should remain the same. It is still
> getting a folio to compress, the only difference is that we will
> parallelize the page compressions. zswap_store_page() is where some
> changes need to be made. Instead of a single function that handles the
> storage of each page, we need a vectorized function that handles the
> storage of N pages in a folio (allocate zswap_entry's, do xarray
> insertions, etc). This should be refactoring in a separate patch.
> 
> Once we have that, the logic introduced by this patch should really be
> mostly limited to zswap_compress(), where the acomp interfacing would
> be different based on whether batching is supported or not. This could
> be changes in zswap_compress() itself, or maybe at this point we can
> have a completely different path (e.g. zswap_compress_batch()). But
> outside of that, I don't see why we should have a completely different
> store path for the batching.

+1

