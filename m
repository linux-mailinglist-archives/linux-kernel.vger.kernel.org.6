Return-Path: <linux-kernel+bounces-524400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A6BA3E2C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9163A3FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F10212D66;
	Thu, 20 Feb 2025 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LgJ3PuFL"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E01CEEB2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072777; cv=none; b=Z3Eiij7c3jtMDCYXcHGa/vhRkYPzT87Zkssiln0tn6X+pozQzBcWPWYT+7wVDD9FQRCdW7A+TgK/CyWsXfLhtQIJTerTFYTwFjm23OXSAqJXkTA0KqYxM3nkbLYzdC3FPCVdOrUhfXn9HfHQmlpMPSKwBrsoH3q9ddpSPg1rLvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072777; c=relaxed/simple;
	bh=23Fp0bojuUGcLpNPJWrqZVqhQGZCU/4zxnmncuHGrFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra0JC9kTB7ke24lDQbFouN+l7FmLQEYUelOv3EvrlKGGtAMtbqwm6Djkp7FhyTIXOhBLQID61IbZDN3OOk0Mv1VMd1uBRCrXkUp5zOvI0AGTKviwOYGs3ndClULx8dRxBzhHflqkH50O6QGdor9BlEntUKBhIQ65AIofIU55lN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LgJ3PuFL; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Feb 2025 17:32:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740072773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xLm69d1JiwcbIZY6/XZSqzpJmY2k5MyhEqHGfOITQ9s=;
	b=LgJ3PuFLOrdaWsTT71dZDT4Wpah6l8pxu2DAGVwXprSS3+5upKrW4KsW9WV12UvGqwXSPL
	v4yh5KHpFtiBETrfIWZRsFnhxO1dKnnBNVS0svJ/Jzgu/LufyFsVlS5Ou7FHV1iqbEJU5W
	ooAdSfemj1nsxTESalAjavU8an1FqZ4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Barry Song <21cnbao@gmail.com>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"surenb@google.com" <surenb@google.com>,
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v5 02/12] crypto: acomp - Define new interfaces for
 compress/decompress batching.
Message-ID: <Z7dnPh4tPxLO1UEo@google.com>
References: <20241221063119.29140-1-kanchana.p.sridhar@intel.com>
 <20241221063119.29140-3-kanchana.p.sridhar@intel.com>
 <Z2_lAGctG0DDSCIH@gondor.apana.org.au>
 <SJ0PR11MB5678851E3E6BA49A99D8BAE2C9102@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkatpOaortT8Si5GfxprvgPR+bzxwTSOR0rsaRUstdqNMQ@mail.gmail.com>
 <SJ0PR11MB5678034533E3FAD7B16E2758C9112@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbRHkb7Znzto6=RRDQA9zXZSva43GukhBEfjrgm1qOxHw@mail.gmail.com>
 <Z3yMNI_DbkKBKJxO@gondor.apana.org.au>
 <CAJD7tkaTuNWF42+CoCLruPZks3F7H9mS=6S74cmXnyWz-2tuPw@mail.gmail.com>
 <Z7F1B_blIbByYBzz@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7F1B_blIbByYBzz@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 16, 2025 at 01:17:59PM +0800, Herbert Xu wrote:
> On Mon, Jan 06, 2025 at 07:10:53PM -0800, Yosry Ahmed wrote:
> >
> > The main problem is memory usage. Zswap needs a PAGE_SIZE*2-sized
> > buffer for each request on each CPU. We preallocate these buffers to
> > avoid trying to allocate this much memory in the reclaim path (i.e.
> > potentially allocating two pages to reclaim one).
> 
> Actually this PAGE_SIZE * 2 thing baffles me.  Why would you
> allocate more memory than the input? The comment says that it's
> because certain hardware accelerators will disregard the output
> buffer length, but surely that's just a bug in the driver?
> 
> Which driver does this? We should fix it or remove it if it's
> writing output with no regard to the maximum length.
> 
> You should only ever need PAGE_SIZE for the output buffer, if
> the output exceeds that then just fail the compression.

I agree this should be fixed if it can be. This was discussed before
here:
https://lore.kernel.org/lkml/CAGsJ_4wuTZcGurby9h4PU2DwFaiEKB4bxuycaeyz3bPw3jSX3A@mail.gmail.com/

Barry is the one who brought up why we need PAGE_SIZE*2. Barry, could
you please chime in here?

> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 

