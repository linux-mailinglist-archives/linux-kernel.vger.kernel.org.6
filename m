Return-Path: <linux-kernel+bounces-402458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748BF9C27CE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320B12847D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F119A18DF86;
	Fri,  8 Nov 2024 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LA156LUY"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B4194C83
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731106490; cv=none; b=QP/AfqmwieO8mUtVObB8FTqJqfVv6iPBe1ATsiPcqqDwvQTV2nm32r4yKuyaek+znMtE7WI6nlUQ6e2dwfux8RJ2CCHFkWbq8W2WWX8iYY5yXXWgBGYhwQAjpEnxCYrHHQXTlZE48EPqmN3Y3bcgSs4x7Vm+9rV9yxZ0vf6kgwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731106490; c=relaxed/simple;
	bh=XTgfqzvVEJgSL3F6tF2AjJ65IStRvvSqyUo9L5oq5Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FD5ERizi+fXWCAGs/kGkDNqtTcHFqRhml4d37VokaJBZV9yrTV3z5CDaVIR9+I1zqJ1gUAnE5Xc6zh9KDR6VUakmQRwz3QQUfhT95/eJJkQciTP1pjk/dx9tX5W9PblgrJ8ekLGzgl7sNkbMo9lHqG3w2tTlEIaScarcFNNFES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LA156LUY; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d399891d6so756755e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 14:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731106488; x=1731711288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XTgfqzvVEJgSL3F6tF2AjJ65IStRvvSqyUo9L5oq5Xo=;
        b=LA156LUYVYLghNrNG1d0NvjiXSWU2eAqZFosKb/gRcUtGpl7Z0nr+7HijrzQHNNavJ
         EjO1ybsarlrYK4qdxE0i+1RQkAcVKcaK/1Wts+44Yme98zxegI6F8y+kR6E//PjZxm/V
         mYGTmVXuXiom37U5m7NVHmRuucQs3GpnJUxyUx58naVfTUrWhtsRPq4ryRm1BkkHkWFH
         efkXrb4zhZx725pnFtXhO4yMYohg1PwncJW001l6zh5Vl84FAyixitU3owi2bBsbGSsb
         utGIjcCmYNTsHw+5KjcFcCqdoBML/ei5S0Fj1r17sRnl17uARQ1WC6qRr9IoOyD2Z+Zn
         gJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731106488; x=1731711288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTgfqzvVEJgSL3F6tF2AjJ65IStRvvSqyUo9L5oq5Xo=;
        b=dkwMdf03EdBsKk+9iN1uegb+w1e0yOVbnLqlL5auVnbBsvgJ5WbICpgVsFReV1vgqn
         Ht8ZkiyBDG0v6NjMsnYzGM+1OL9J0Ok5zvrOLUC/Z1me7G9g4izO6iswlBnRV/xlluVc
         4oEz8Unp/Luk43+7AlZIYQfAQUgibwLZF1orJWNIpikBM5gR+KQSTd3r3WrB9fBiKZPq
         oktwAIPtErVW7ZTtfrNyulZLtDFwLwm/VWocAgcWE2PB16CoJXg5/k2KTnHnXARkZaXJ
         RpUbuTwuC47G0vVsttWFfCBUwjJ7pfcyhppycZmCP0vy81CNeMR3ToI31lx7hjIf/DQg
         GC3A==
X-Forwarded-Encrypted: i=1; AJvYcCU+pgGS8tY7tYQ6vflwjWV2jL7tegce3AZgLSry6QH8OKscr/ezKsltTVv2UJtoIOawP6P+nStYdVrSe0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0ExGfRq08g6LFJFgQD7UABce512NVtiYtDh0UHFP/48X7AhD
	j4Nm6izJGr1EPnmxHjEYchficf8vl107auGuH4qzvfrnxQNagGxsThGBlx6TJCgyvg4gDfYKvsm
	eJDIGVP68FG5lHllRg2AUPZHcH3aM4EQOnXcB
X-Google-Smtp-Source: AGHT+IEtiRf/T78bxWlsBc3bfUJoidKtGZy3ydKaQ6zD7zxf8cet8W15HcX4ar86tVuT+7NOnyb//BJIhfJ1TKwDVAQ=
X-Received: by 2002:a05:6122:1e12:b0:50d:918d:4da1 with SMTP id
 71dfb90a1353d-51401ba59e4mr5503150e0c.3.1731106487467; Fri, 08 Nov 2024
 14:54:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106192105.6731-1-kanchana.p.sridhar@intel.com>
 <20241106192105.6731-10-kanchana.p.sridhar@intel.com> <20241107172056.GC1172372@cmpxchg.org>
 <SJ0PR11MB5678FA2EA40FEFE20521AC6BC95C2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZrdrez2mohU_SRb3SYho5JGgwGYK4-imvfCNvSHfe=Eg@mail.gmail.com> <SJ0PR11MB5678E6DED92BDA697D572355C95D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678E6DED92BDA697D572355C95D2@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 8 Nov 2024 14:54:11 -0800
Message-ID: <CAJD7tkaCPMQUpvudJ+nQUrcvE9QmMwfQoU3AzCUjiGg61pnZaw@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] mm: zswap: Modify struct crypto_acomp_ctx to be
 configurable in nr of acomp_reqs.
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>, 
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com" <surenb@google.com>, 
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>, "zanussi@kernel.org" <zanussi@kernel.org>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> > > >
> > > > There are no other callers to these functions. Just do the work
> > > > directly in the cpu callbacks here like it used to be.
> > >
> > > There will be other callers to zswap_create_acomp_ctx() and
> > > zswap_delete_acomp_ctx() in patches 10 and 11 of this series, when the
> > > per-cpu "acomp_batch_ctx" is introduced in struct zswap_pool. I was trying
> > > to modularize the code first, so as to split the changes into smaller commits.
> > >
> > > The per-cpu "acomp_batch_ctx" resources are allocated in patch 11 in the
> > > "zswap_pool_can_batch()" function, that allocates batching resources
> > > for this cpu. This was to address Yosry's earlier comment about minimizing
> > > the memory footprint cost of batching.
> > >
> > > The way I decided to do this is by reusing the code that allocates the de-
> > facto
> > > pool->acomp_ctx for the selected compressor for all cpu's in
> > zswap_pool_create().
> > > However, I did not want to add the acomp_batch_ctx multiple reqs/buffers
> > > allocation to the cpuhp_state_add_instance() code path which would incur
> > the
> > > memory cost on all cpu's.
> > >
> > > Instead, the approach I chose to follow is to allocate the batching resources
> > > in patch 11 only as needed, on "a given cpu" that has to store a large folio.
> > Hope
> > > this explains the purpose of the modularization better.
> > >
> > > Other ideas towards accomplishing this are very welcome.
> >
> > If we remove the sysctl as suggested by Johannes, then we can just
> > allocate the number of buffers based on the compressor and whether it
> > supports batching during the pool initialization in the cpu callbacks
> > only.
> >
> > Right?
>
> Yes, we could do that if the sysctl is removed, as suggested by Johannes.
> The only "drawback" of allocating the batching resources (assuming the
> compressor allows batching) would be that the memory footprint penalty
> would be incurred on every cpu. I was trying to further economize this
> cost based on whether a given cpu actually needs to zswap_store() a
> large folio, and only then allocate the batching resources. Although, I am
> not sure if this would benefit any usage model.
>
> If we agree the pool initialization is the best place to allocate the batching
> resources, then I will make this change in v4.

IIUC the additional cost would apply if someone wants to use
deflate-iaa on hardware that supports batching but does not want to
use batching. I don't think catering to such a use case warrants the
complexity in advance, not until we have a user that genuinely cares.

