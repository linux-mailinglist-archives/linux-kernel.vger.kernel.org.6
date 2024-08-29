Return-Path: <linux-kernel+bounces-305976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1EB96374C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E8B2816DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C122EF4;
	Thu, 29 Aug 2024 01:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1ZWCHTk"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50B1C6B2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893345; cv=none; b=B7T4/ol8TMo6wKrv+4l7yDdNQFUG2VIu4PyqCWABfn7f376+uYJoRX9sUb135/gc2saztCp6/Pte398ci1MOnduJK+HAEUcs7Ha6XGk8wuqktI48faFPIgmMRhvh8aZwQcYOMK7HF8YbjyDkeHzEu2TCbpHV0DY9KVgpFn7vY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893345; c=relaxed/simple;
	bh=2/VB8quUYt2uT5KgpHetU9IRNh5nnyUMgsIX+0fJAHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUCYlTFYWNTscBXUmntBPCoHzWORBeHmMVNe4hTWB5gPXtrXXLd4sxu2y5dXZyJGrtfCnKHUmUwM5ypp+/CbJrxdKxYcls8jYS116mEonZiRoaG7dmL+Ad6ZYNDz3KjHS3UPB0yNDqrhnnd5LhxvtHfpk8O86o/gk/rMDiGYNuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1ZWCHTk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a867a564911so6232166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724893342; x=1725498142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/VB8quUYt2uT5KgpHetU9IRNh5nnyUMgsIX+0fJAHQ=;
        b=d1ZWCHTkk/DRqGzd7Vd7r63NY1J3EGhn5+e0+zFB5AZxt14XKRZWdCZ3Px90k5s52y
         18QQdOF6QXwpa+47d30Pfmo0u2jSphoT7CLJec1Dwb2ZGQsyfru29VAjH2BpfI4esM/g
         7gwGd5cpo7Uhxn4KYL+szZbh3dmCRTv2uQgVcLLQPt1f2T4CEo1dvVht2G+JhhX4j9Gc
         iNMofkKknwvoy2sY9+Gt7mk7mMvBirAxeViQrnkYVsTB8Ve1IcUAJNCMSdBqGV2xT5i/
         nBlwLA/5VIfHm+Mz4zL67dzy1YCgDrCHiiRZG1b9Y7wrsLakEzKT2RbZx0UJfuDuqjSE
         s0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893342; x=1725498142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/VB8quUYt2uT5KgpHetU9IRNh5nnyUMgsIX+0fJAHQ=;
        b=STFiSUPAvvDwjYOWYxgCoBNeBCA2NqyO9AJFtrneopstGNaI7esBfONNAayOHEgdcv
         64x39u3SWtiphqR+OynNbo0NpMGB8XFfsV8GZGk7b90HDwh9m5e3xtp9O1nVuy5Pv5wP
         XdTYaVkQD97gIzALtxQAsizZQdJpl09WA31k0IDXShi1C7hRBMwJLS0Yui1tCY4x8kk1
         094epRuMCC7n6jil83Ow42YScZnxePgM5WbT5WC59xV7LvbT6hycYpTRyAVtmL7ujdaj
         gbFX9G2K5OfZzEoZtiKkvCJD4WrZ4eqcQvatbJ1RfRKJsAnGOSEu3Q2D2JxP5wQy1T1f
         nP2g==
X-Gm-Message-State: AOJu0YzqnUevKDLEzeJ/OxgOvAEqzjls6E1ym1w52YKT5h+R5MbiVG/q
	MNRT8XUKRZJw/KeQH60VeIL2Cf3tvjT7eZWAv3TUzICCTBVuqujF5UIQa1phFbfA20fk0xgGCf3
	SA8Mu2QK8w9ARYub49Ees9xAvN3FBzFJuKOBv
X-Google-Smtp-Source: AGHT+IF1bPH1PJC2EWwNS8u4FKF7LLaeLWheuE1hROdXMI1FL11h/Ib+V0/gJKSPIa+Fca/UI49+n4gkTyPgfOdAs/M=
X-Received: by 2002:a17:906:f5a3:b0:a86:9258:aeed with SMTP id
 a640c23a62f3a-a897fad655fmr70664666b.61.1724893341386; Wed, 28 Aug 2024
 18:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZv3YnhxFo-rvHNB2_mro1+UuKOP69yXV8KmaeEz5F1mA@mail.gmail.com> <SJ0PR11MB567808155B93421F4EC004FDC9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB567808155B93421F4EC004FDC9962@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 28 Aug 2024 18:01:45 -0700
Message-ID: <CAJD7tkYBaHpJG8Uzo592cXYwNbzRJ0G8Ju71mkFA+T8uS3eARg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

[..]
> > > In the "Before" scenario, when zswap does not store mTHP, only allocations
> > > count towards the cgroup memory limit. However, in the "After" scenario,
> > > with the introduction of zswap_store() mTHP, both, allocations as well as
> > > the zswap compressed pool usage from all 70 processes are counted
> > towards
> > > the memory limit. As a result, we see higher swapout activity in the
> > > "After" data. Hence, more time is spent doing reclaim as the zswap cgroup
> > > charge leads to more frequent memory.high breaches.
> > >
> > > This causes degradation in throughput and sys time with zswap mTHP, more
> > so
> > > in case of zstd than deflate-iaa. Compress latency could play a part in
> > > this - when there is more swapout activity happening, a slower compressor
> > > would cause allocations to stall for any/all of the 70 processes.
> > >
> > > In my opinion, even though the test set up does not provide an accurate
> > > way for a direct before/after comparison (because of zswap usage being
> > > counted in cgroup, hence towards the memory.high), it still seems
> > > reasonable for zswap_store to support (m)THP, so that further performance
> > > improvements can be implemented.
> >
> > Are you saying that in the "Before" data we end up skipping zswap
> > completely because of using mTHPs?
>
> That's right, Yosry.
>
> >
> > Does it make more sense to turn CONFIG_THP_SWAP in the "Before" data
>
> We could do this, however I am not sure if turning off CONFIG_THP_SWAP
> will have other side-effects in terms of disabling mm code paths outside of
> zswap that are intended to be mTHP optimizations that could again skew
> the before/after comparisons.

Yeah that's possible, but right now we are testing mTHP swapout that
does not go through zswap at all vs. mTHP swapout going through zswap.

I think what we really want to measure is 4K swapout going through
zswap vs. mTHP swapout going through zswap. This assumes that current
zswap setups disable CONFIG_THP_SWAP, so we would be measuring the
benefit of allowing them to enable CONFIG_THP_SWAP by supporting it
properly in zswap.

If some setups with zswap have CONFIG_THP_SWAP enabled then that's a
different story, but we already have the data for this case as well
right now in case this is a legitimate setup.

Adding Chris Li here from Google. We have CONFIG_THP_SWAP disabled
with zswap, so for us we would want to know the benefit of supporting
CONFIG_THP_SWAP properly in zswap. At least I think so :)

>
> Will wait for Nhat's comments as well.
>
> Thanks,
> Kanchana
>
> > to force the mTHPs to be split and for the data to be stored in zswap?
> > This would be a more fair Before/After comparison where the memory
> > goes to zswap in both cases, but "Before" has to be split because of
> > zswap's lack of support for mTHP. I assume most setups relying on
> > zswap will be turning CONFIG_THP_SWAP off today anyway, but maybe not.
> > Nhat, is this something you can share?

