Return-Path: <linux-kernel+bounces-432227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB79E47EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD24728441E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97931F541A;
	Wed,  4 Dec 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="23fAOSxB"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E518E056
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351781; cv=none; b=POrsMM8c7pCIPgEjrbLBRO4DYNfMpeookUUg0RScuLaqSuxjoNPDpGp/rfU9TeGF+CrqKFjCCmYJNOLUQT1eYZ5pwB6wgcvPL0Bf7qi5pW2JuaowdN7gkaXwYckEuanijonl6CtY4WKzWjYuOG62lVOAIaWk1GsFcQgko82L1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351781; c=relaxed/simple;
	bh=y8PAwII+zOmKPr1Vni+Yw8XAi6kWucC9EB0LSh6GWLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lizurjR9aj2WmeoaQdamDLG0hsV3JPtnHfbxypKWma51wDjk6P7TlkDdhjZh7WShO0svYyKe5osLtJdZRdyTeZliubeWeYJQxYLTLVW4XkUGDn6gXRq4DPwjYmzNEP2DWESGHrbLnBXNTYpAk02JjaJu4iPgSKh1F560YLgDdSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=23fAOSxB; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8cb085d1bso3041536d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733351777; x=1733956577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS0FEsruGhh39Bjn4FTH2Nl4cCIzKoK/vUzX8vsG6WE=;
        b=23fAOSxBp/1k7ymyOsA1Hjk46tW706CCsVAI0DItQ3ot4PQ5GC6p9vHz8zFPjq18lL
         Axlyme0qxy0ITmmXORlYljE9WOZqu4hzWJMzPjYEp0aYnuu12CCehMPr30vGFF6BRCuY
         7gjo8eXUcA95x9OT4Y0R3lGwg4TDdFyu2ESZJq3Vp1lR4T4dXrg1fH2mGaXZuZCivPrS
         f51CSDCapay+rpPFTPXFYdh6CJjx3Lh6vOb5dS4MJVMI6HUx8L0li2BZVxj3Ack3izx/
         9xpfCU9J3BJHMurpezUV92fU805tykihMgejoKjFw5owWEwcdF+p43Up2NFvScB0QQ3o
         EM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733351777; x=1733956577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eS0FEsruGhh39Bjn4FTH2Nl4cCIzKoK/vUzX8vsG6WE=;
        b=uK+QBEUK+2SWZZnF2Sdvqw+zZJ6yXqzUC94iHeF3eaFRvJhFt6q7Gcid9HnXXapfis
         rfvn6T13sft7dpGkyRH1k5daZki9MXp04l1gJns5B6jklcQvwQbRZT/pBf4yAH5uk6Tq
         4XvGvPaXzbryqLwVqftioK7jeO3lx54vvzS3FJTuFAFT7lim99JAU8zGhxIDoHxjjkF+
         8UMBFt9BKG9OI3Z0SNVbyFipjIZObttChG0WmIo2z3rLpqApe8a3JJ+F8w5d0LYR7F7y
         0RzCQvAd2kcVQbTLQfKKuzVXDaD75Es4/abZx+ZiM6ZQ+uNyFKkW6IhkUZEzvIA3Pxh1
         hrog==
X-Forwarded-Encrypted: i=1; AJvYcCVWxXvVeYpQSeVPU2lbrireu9HLl9CY3T+ObRuREWjNdpt30NAi5VRC10iFkf6XK56lWcbwRBAL08jpPHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx84C0KmvwDp2XO+A07Sanjh9bf81Cai3jiYoFsTojCXQscRSr
	g6IskWW57jep/UtlWZw9ZJHaR9h0RZ3Ki8QbT4iS+9RsnHn7tdkntUa5l/plwlSOeRV2ptGPFUQ
	Sn3MWQ4bqxKpKNzS0iFDtv9wQBPAnE5al6w4c
X-Gm-Gg: ASbGnctstQdRHKnR8hA+Bc4LQDYt821pIcQIurIAfSNjqwToB5JV5MKztskVmde5reb
	4wen/8p/XBPE56cQmZwfCX8k1a//w
X-Google-Smtp-Source: AGHT+IEDQzyAy1CVJBsw8OwP0dkCUTIHEYHMvraP8G80iJxS11sgJQkYnJWtKFeWBlFBtQFtcyr8YTxgY3yg7BNQkkE=
X-Received: by 2002:a05:6214:c4e:b0:6d4:16e0:739a with SMTP id
 6a1803df08f44-6d8c45905f7mr106003306d6.17.1733351777220; Wed, 04 Dec 2024
 14:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123070127.332773-1-kanchana.p.sridhar@intel.com>
 <20241123070127.332773-10-kanchana.p.sridhar@intel.com> <CAKEwX=PmKWH4Z4Py9Jti9fcD6qCYJBBRrDF48qdmo8-i+LzzfA@mail.gmail.com>
 <SJ0PR11MB56783454B5985ACD48744772C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <Z066p53LoISwqkmX@gondor.apana.org.au> <SJ0PR11MB5678AAEF4F62773847E6307FC9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkbui2MTkkGA6_+RDA0oZW2m3rMnUTKp1Fp6tPqp2QLgKw@mail.gmail.com> <Z0-zboLmrybOt8pv@gondor.apana.org.au>
In-Reply-To: <Z0-zboLmrybOt8pv@gondor.apana.org.au>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Dec 2024 14:35:40 -0800
Message-ID: <CAJD7tkaJwti5vwUXP=T9MW4XXHmen+SCQXv=hWWN+-V3SJJSVA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] mm: zswap: Allocate pool batching resources if
 the crypto_alg supports batching.
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>, Nhat Pham <nphamcs@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"ying.huang@intel.com" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"clabbe@baylibre.com" <clabbe@baylibre.com>, "ardb@kernel.org" <ardb@kernel.org>, 
	"ebiggers@google.com" <ebiggers@google.com>, "surenb@google.com" <surenb@google.com>, 
	"Accardi, Kristen C" <kristen.c.accardi@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:42=E2=80=AFPM Herbert Xu <herbert@gondor.apana.org=
.au> wrote:
>
> On Tue, Dec 03, 2024 at 01:44:00PM -0800, Yosry Ahmed wrote:
> >
> > Does this mean that instead of zswap breaking down the folio into
> > SWAP_CRYPTO_BATCH_SIZE -sized batches, we pass all the pages to the
> > crypto layer and let it do the batching as it pleases?
>
> You provide as much (or little) as you're comfortable with.  Just
> treat the acomp API as one that can take as much as you want to
> give it.

In this case, it seems like the batch size is completely up to zswap,
and not necessarily dependent on the compressor. That being said,
Intel IAA will naturally prefer a batch size that maximizes the
parallelization.

How about this, we can define a fixed max batch size in zswap, to
provide a hard limit on the number of buffers we preallocate (e.g.
MAX_BATCH_SIZE). The compressors can provide zswap a hint with their
desired batch size (e.g. 8 for Intel IAA). Then zswap can allocate
min(MAX_BATCH_SIZE, compressor_batch_size).

Assuming software compressors provide 1 for the batch size, if
MAX_BATCH_SIZE is >=3D 8, Intel IAA gets the batching rate it wants, and
software compressors get the same behavior as today. This abstracts
the batch size needed by the compressor while making sure zswap does
not preallocate a ridiculous amount of memory.

Does this make sense to everyone or am I missing something?

