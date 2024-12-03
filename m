Return-Path: <linux-kernel+bounces-430237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E1A9E2EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22203B3985A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1905220125D;
	Tue,  3 Dec 2024 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0hLgnPM"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67591F75A5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262279; cv=none; b=YGRfJfo/KYjTWiMu+0wCN9TG04Jli21DFo0XgRCOzod0H9VhfSnnmNLMpvc4xO1GLz14tQahmq+AytlaJyZVT7Id6wTlAXtsaZrwFDTk4LBKcIiWurSIDE/RZoW+bGsqIu1nzcZ86WvIBOdIZc4WUvzbFvoYl8wm2gguppOqLnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262279; c=relaxed/simple;
	bh=P3yEmkWYGA79algR4tDOhbLBkOs5sl45A0XdKdNUM3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n96cy+B9SKuebtyaIE5o+5WsUy+gN34cEILQbA0tnQXnR+cBtJmHRo829e8p+jur4N3NkS4V3eZmdrcpbh/tYeKKqfZsUmom/1wse6Fty1qIPDRrbFFu2kyL8B7qopWKYOiq1poPJCF8SA9N73N/anvx8XZaZQd6kNSwcb/K88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w0hLgnPM; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46695dd02e8so63611381cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262276; x=1733867076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vm0D9iLih6NVgJOSSK56eoyE8s/0Ie0xteOxyeVsYIs=;
        b=w0hLgnPMsycx391yugiXm+7C04OWI/TKubbjT1ialJhIZnc0aQlsFmkwGWA9ipOsDd
         9zeXX+7i9ku3f9yhxajfRQEzkBqoQMiYafmkV9831SkT1X7H5CsTCQSpPBYY16lfqktg
         aQbvOct1GuITGfELAM3VEApnFAcCZVLV/76xXl/NvY+jyc/j3ISncnW0VF0eFREVpbaC
         7GdGMOHHhlMJWFGInZo1+HO0xNWmK6pdaezrnZfD/VyJN/asXxHb0xbgVDPpiVW9LmcD
         9AOE++5CwB9dZrRK0UKwYOTiFGFPlhRK4KFqAruolC2UY/H3RY9lxN6lodeSlko3qdoE
         ZQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262276; x=1733867076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vm0D9iLih6NVgJOSSK56eoyE8s/0Ie0xteOxyeVsYIs=;
        b=MPvo/P2lcyTF7RvpDK5ckWLHH/eVqaPJebPBB/c80JuTJg6VAjH/BLb/W4gpc2XHXL
         B5bMPjTErZoi0qdXe3F/+JE4tB4kX5JBRmwNweA7MmIVWzble9eb7ajAGKrldlNB8v3Q
         UbFeua5Jzww0/Q2WWYpzHlCTxPceMnfljWQuaMsM5tGj37/Yap7h2fhi+nqS8K6WTNJx
         V3cb8aGjNaqq6zgLFBPPG/tS0y1YhTD3EhRzZidsxV2I4KVi/Xso4lMl1NU3pnR4BH4u
         c6RV8vzwWPuqQbUYzJl5i9JLDB+ohFEHl1CEUM61ddsuRAvhyo7MOzYLF+lWGSZ4m+JH
         wF8w==
X-Forwarded-Encrypted: i=1; AJvYcCUl39dh6X9Vfuyv4CFB2mLvt+Kjh6jB6Z/wJzd5MHKrsTNrU4QEqdlrsg61LaGq4BgexOvOEt70ZUxKEIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0CxEps/Br5cD72WVfVBYA6Bmp3K3Jn3N9/WmskVFCopbvRT9i
	wUEzIsyEMMy0EyOmFGTZQduHGjuFdfBYwZby79ue3HXHAr6jKf7x+oj3z+PlTSRLksgFBjN5pvm
	80C2JWojVCSPHrtni8fPfu23+a+6jEwoYwl9HJdiO78zqnbAldQC8
X-Gm-Gg: ASbGncv+WzMdXceGmPhyHnPkkxc1DaZu1/OherKhKDdySkI8WiSJySN+5gVowcLf1rk
	OwO9U8oUiOeVAqwrsSZBtwv0z/ic4
X-Google-Smtp-Source: AGHT+IElgjsMKzyb8pB6S2q5z1oqGiduDeQK5SqLnhC4d+BQTcWkNixPgmGxlQy2kLoTb/AFWhq1uk9LZWaoSMS148s=
X-Received: by 2002:a05:6214:5183:b0:6d8:a84b:b50d with SMTP id
 6a1803df08f44-6d8c46bd285mr28938446d6.33.1733262276441; Tue, 03 Dec 2024
 13:44:36 -0800 (PST)
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
In-Reply-To: <SJ0PR11MB5678AAEF4F62773847E6307FC9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 3 Dec 2024 13:44:00 -0800
Message-ID: <CAJD7tkbui2MTkkGA6_+RDA0oZW2m3rMnUTKp1Fp6tPqp2QLgKw@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] mm: zswap: Allocate pool batching resources if
 the crypto_alg supports batching.
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Nhat Pham <nphamcs@gmail.com>, 
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

On Tue, Dec 3, 2024 at 1:37=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Herbert Xu <herbert@gondor.apana.org.au>
> > Sent: Tuesday, December 3, 2024 12:01 AM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: Nhat Pham <nphamcs@gmail.com>; linux-kernel@vger.kernel.org; linux-
> > mm@kvack.org; hannes@cmpxchg.org; yosryahmed@google.com;
> > chengming.zhou@linux.dev; usamaarif642@gmail.com;
> > ryan.roberts@arm.com; ying.huang@intel.com; 21cnbao@gmail.com;
> > akpm@linux-foundation.org; linux-crypto@vger.kernel.org;
> > davem@davemloft.net; clabbe@baylibre.com; ardb@kernel.org;
> > ebiggers@google.com; surenb@google.com; Accardi, Kristen C
> > <kristen.c.accardi@intel.com>; Feghali, Wajdi K <wajdi.k.feghali@intel.=
com>;
> > Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v4 09/10] mm: zswap: Allocate pool batching resourc=
es if
> > the crypto_alg supports batching.
> >
> > On Tue, Dec 03, 2024 at 12:30:30AM +0000, Sridhar, Kanchana P wrote:
> > >
> > > > Why do we need this "can_batch" field? IIUC, this can be determined
> > > > from the compressor internal fields itself, no?
> > > >
> > > > acomp_has_async_batching(acomp);
> > > >
> > > > Is this just for convenience, or is this actually an expensive thin=
g to
> > compute?
> > >
> > > Thanks for your comments. This is a good question. I tried not to imp=
ly that
> > > batching resources have been allocated for the cpu based only on what
> > > acomp_has_async_batching() returns. It is possible that the cpu onlin=
ing
> > > code ran into an -ENOMEM error on any particular cpu. In this case, I=
 set
> > > the pool->can_batch to "false", mainly for convenience, so that zswap
> > > can be somewhat insulated from migration. I agree that this may not b=
e
> > > the best solution; and whether or not batching is enabled can be dire=
ctly
> > > determined just before the call to crypto_acomp_batch_compress()
> > > based on:
> > >
> > > acomp_ctx->nr_reqs =3D=3D SWAP_CRYPTO_BATCH_SIZE;
> >
> > With ahash request chaining, the idea is to accumulate as much
> > data as you can before you provide it to the Crypto API.  The
> > API is responsible for dividing it up if the underlying driver
> > is only able to handle one request at a time.
> >
> > So that would be the ideal model to use for compression as well.
> > Provide as much data as you can and let the API handle the case
> > where the data needs to be divided up.
>
> Thanks for this suggestion! This sounds like a clean way to handle the
> batching/sequential compress/decompress within the crypto API as long
> as it can be contained in the crypto acompress layer.
> If the zswap maintainers don't have any objections, I can look into the
> feasibility of doing this.

Does this mean that instead of zswap breaking down the folio into
SWAP_CRYPTO_BATCH_SIZE -sized batches, we pass all the pages to the
crypto layer and let it do the batching as it pleases?

It sounds nice on the surface, but this implies that we have to
allocate folio_nr_pages() buffers in zswap, essentially as the
allocation is the same size as the folio itself. While the allocation
does not need to be contiguous, making a large number of allocations
in the reclaim path is definitely not something we want. For a 2M THP,
we'd need to allocate 2M in zswap_store().

If we choose to keep preallocating, assuming the maximum THP size is
2M, we need to allocate 2M * nr_cpus worth of buffers. That's a lot of
memory.

I feel like I am missing something.

>
> Thanks,
> Kanchana
>
> >
> > Cheers,
> > --
> > Email: Herbert Xu <herbert@gondor.apana.org.au>
> > Home Page: http://gondor.apana.org.au/~herbert/
> > PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

