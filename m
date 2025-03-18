Return-Path: <linux-kernel+bounces-567067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE187A680A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29248189DB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508E1207E02;
	Tue, 18 Mar 2025 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qyjvjCTC"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BAD46426
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339665; cv=none; b=o2P7KQVeVFftcyRAxRPkSUt4fR6q6FawdBlQ9ALqF50Vq9SaurIKCbG0uAipuBj8BFwrlVjH7mVx5SIKqWhvquSJ8fbJbLwNkrWDSEZBuvsGqbgi9o3bs/vShH8rzjYBjgo6owl5JyZHc2qPbu5Ks24sym97DmbOoXEjm0l2AH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339665; c=relaxed/simple;
	bh=RRawIH7MSBCWqs5s3zUm1vn0teMZ1dhswZ90zh7oT6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmTTdbfv5A2ZjX0jgPjBDZebbdvrQhfVv9XRSuO4NETxTjKn2J2iNTCx75KB1X1Iafj/EqGFk4RhzHhXWSyKIB2CUEZVinTpFk9eqeH0EUdYNnbH5OH8OhYXKcqLibkdQMtuIH2nFLOXWmlLaaicREoDDMk12QWbQCznbrGJZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qyjvjCTC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 23:14:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742339651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dEiwYqhjF6BNFFV7jF/tNDaFFyAW5VoJIlRl5arxgCo=;
	b=qyjvjCTCIdIj6tib4Mpx1MGZVLigYMqTgWhVDJLgUnsBfKxMAVv5fc4xqsqz3ChWfTd9e6
	lPCdLPV8yHofkDykLWTZU+hTpDbLx/coTbGEGswaJ2onXy/8xpE3exzSWBbdK0/+N+bA9E
	veji6WTR2Lcpt+1zwEQft4Ud9/V+tnk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"nphamcs@gmail.com" <nphamcs@gmail.com>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"21cnbao@gmail.com" <21cnbao@gmail.com>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"clabbe@baylibre.com" <clabbe@baylibre.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"surenb@google.com" <surenb@google.com>,
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>,
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Subject: Re: [PATCH v8 12/14] mm: zswap: Simplify acomp_ctx resource
 allocation/deletion and mutex lock usage.
Message-ID: <Z9n-OnGPK7BOdGxR@google.com>
References: <Z8n5CCmELvpUwi3B@google.com>
 <PH8SPRMB004414B5E1E0765C18F9A89DC9D52@PH8SPRMB0044.namprd11.prod.outlook.com>
 <Z8tJOi5G_3dpK31v@google.com>
 <PH8SPRMB00447B066A769C76F57F8800C9D42@PH8SPRMB0044.namprd11.prod.outlook.com>
 <Z88h1mPkYNM6yOGE@google.com>
 <SA3PR11MB812082535F1E6D63BC0F1412C9DF2@SA3PR11MB8120.namprd11.prod.outlook.com>
 <Z9mB5IbNEdNdtmUp@google.com>
 <SA3PR11MB81206531E9B3C7F13F5740A2C9DE2@SA3PR11MB8120.namprd11.prod.outlook.com>
 <Z9nECMZW67F8XYoV@google.com>
 <SA3PR11MB8120A474C20104FF22CCE396C9DE2@SA3PR11MB8120.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA3PR11MB8120A474C20104FF22CCE396C9DE2@SA3PR11MB8120.namprd11.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 18, 2025 at 09:09:05PM +0000, Sridhar, Kanchana P wrote:
[..]
> > > > >
> > > > >     The only other fallback solution in lieu of the proposed simplification
> > that
> > > > >     I can think of is to keep the lifespan of these resources from pool
> > creation
> > > > >     to deletion, using the CPU hotplug code. Although, it is not totally
> > clear
> > > > >     to me if there is potential for deadlock during pool transitions, as
> > noted
> > > > above.
> > > >
> > > > I am not sure what's the deadlock scenario you're worried about, please
> > > > clarify.
> > >
> > > My apologies: I was referring to triggering direct reclaim during pool
> > creation,
> > > which could, in theory, run into a scenario where the pool switching would
> > > have to wait for reclaim to free up enough memory for the acomp_ctx
> > > resources allocation: this could cause the system to hang, but not a
> > deadlock.
> > > This can happen even today, hence trying to see if a better design is
> > possible.
> > 
> > I think the concern here is unfounded. We shouldn't care about the
> > performance of zswap compressor switching, especially under memory
> > pressure. A lot of things will slow down under memory pressure, and
> > compressor switching should be the least of our concerns.
> 
> Sounds good. It then appears that making the per-cpu acomp_ctx resources'
> lifetime track that of the zswap_pool, is the way to go. These resources
> will be allocated as per the requirements of the compressor, i.e., zswap_pool,
> and will persist through CPU online/offline transitions through the hotplug
> interface. If this plan is acceptable, it appears that acomp_ctx_get_cpu_lock()
> and acomp_ctx_put_unlock() can be replaced with mutex_lock()/unlock() in
> zswap_[de]compress()? I will incorporate these changes in v9 if this sounds Ok.

Sounds good to me. Thanks!

