Return-Path: <linux-kernel+bounces-337654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACEC984CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD351C2321F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6307146018;
	Tue, 24 Sep 2024 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysEvRu6N"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF5313D518
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213922; cv=none; b=khzOCFqX/O4JXo02FTuufEDkPgzBXsqApBvMV9JV6oK/aEvkCR+oiOZQNMHvv5NXuoNedR4KBEPJnYhcqnHftjfG4yiODvtT07knE6xRXb0U623ZoXBnTf+9My4/g4W6kgiNZ5onnmOOTy5C0BYpm8LsolMbAJTCLtBVyD+3g7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213922; c=relaxed/simple;
	bh=ozoQZZObFZv1yOfVBJhZ+kmgx62mKlG4i5tmwzryp/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOsCLVMLvxUuBuZLBM2XPlVolM2iyKxb7HaUrJsmlPXFMv7avZpAw/t9cpiH/kEoBC/X3tH7QiAXPjtMkFElSpyDyPIZS2k8qUG0PVK2J3XKZJxgy6s2u6PlJbRfXVD9TO9RjVr7y2wQKZnh/8mRTHVTtfJ1hT5rxj87NffMrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ysEvRu6N; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c42384c517so7343868a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727213918; x=1727818718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LU6c6CF0GzjYRCInPnHkkX8mDRzVLIkYu1GL6EK21U=;
        b=ysEvRu6NBNd/AcChRq40///g1RJX4u0SknAfT5OaEUQHW8Hwj+tQM7CcGaj4vnuTD9
         HkTClrm4CafBV3n/196yBErvWK8pow16WFOKZKZbYkH3TWrp5H1/GcUanyHclvprtN68
         DY7nJNl3YNXIdB7HSiI4vElplNzVVJgw53g4yYGYtSCZW6H0n2CQjesNZCKL2lEd5JxX
         bqExCLkloIQtbocLalA1t9SoB49NKXRwrjOX2CMdgE5j0l4y6qb+N423IarNLezjEtTf
         wqvIWadJQlPGUmMbSOPBK1ltmOqndNeIVz2R0LSnuUm3DcJnsOxaP8QWYQhEMkw0XoMk
         CysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727213918; x=1727818718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LU6c6CF0GzjYRCInPnHkkX8mDRzVLIkYu1GL6EK21U=;
        b=WZIiKP6eXLWGm8Wb2lUTx79nsVQOyO6oupUAhkZZVyXKIHfdJB+DTt/+T10fyyRglb
         3vdtwJbuDR3WmzroC3o3K3wp3HAP3yN4dnkNLpcfUAWT/olPg4cY9QtnoQooLzBNddXV
         obEv6gMVDtXVSHJJDe0AMM1lDiYK2TIgzyHxbMElKU/D+L8SZUhMYwfajTnyKD0kIwH1
         0Y1pvzxYC8+xGoP08/dnpCkOm6THTX7tZlC3PhGTZrTmMzPO4qJLnTtjXz+9D1OyEkBK
         h7ZJfQUGKJ6wMUc4ZnThXR2ShfV56lIFplbWhNZ7t9Ss6fkpLf7F9ShOlOtf4MufDkxL
         KBsw==
X-Forwarded-Encrypted: i=1; AJvYcCUVMf7EjOYUvflsyLRhN2XBkM5R/AszWCTWwRbC8+tKsrZBIKVMdkDPLC82b2xGhf0PI+06AetsGdoxEWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLD+DILa5g8HQdr1/fhfCruE5rMFu6n7jVdlufBYd1/paRfI+G
	n9Ig6snyMewvbQcXPwscuKO9Saf1gPvSp3CNszw117ylyjeMBkL0cqsARqzmZxpPjXifPDhVwdJ
	Zd6qn8PihGyLUUjMvs0TfjgjCooEIxJVED/ZJ
X-Google-Smtp-Source: AGHT+IHtceRrJ0msQPdS0aETwSLXd+v7dkQ50Ac2Rrp7RKGIHW4YCyLCPHXApNCX5AzVjGPOPr4TojuoYGkwUVDgzO8=
X-Received: by 2002:a17:907:1c1f:b0:a8a:926a:d02a with SMTP id
 a640c23a62f3a-a93a05e7ea0mr49373066b.49.1727213918103; Tue, 24 Sep 2024
 14:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <CAKEwX=O4PJmLRLog3NGzy+r6+1XTXs_r9Nxs73CJeFeN0pcr+Q@mail.gmail.com>
In-Reply-To: <CAKEwX=O4PJmLRLog3NGzy+r6+1XTXs_r9Nxs73CJeFeN0pcr+Q@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 14:38:00 -0700
Message-ID: <CAJD7tkYCXexrP_2xjXqFDpJALCgi84aA7wGOo=6mfuUSpMO-ng@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 1:51=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Sep 24, 2024 at 12:39=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Mon, Sep 23, 2024 at 6:17=E2=80=AFPM Kanchana P Sridhar
> > > +        * The cgroup zswap limit check is done once at the beginning=
 of an
> > > +        * mTHP store, and not within zswap_store_page() for each pag=
e
> > > +        * in the mTHP. We do however check the zswap pool limits at =
the
> > > +        * start of zswap_store_page(). What this means is, the cgrou=
p
> > > +        * could go over the limits by at most (HPAGE_PMD_NR - 1) pag=
es.
> > > +        * However, the per-store-page zswap pool limits check should
> > > +        * hopefully trigger the cgroup aware and zswap LRU aware glo=
bal
> > > +        * reclaim implemented in the shrinker. If this assumption ho=
lds,
> > > +        * the cgroup exceeding the zswap limits could potentially be
> > > +        * resolved before the next zswap_store, and if it is not, th=
e next
> > > +        * zswap_store would fail the cgroup zswap limit check at the=
 start.
> > > +        */
> >
> > I do not really like this. Allowing going one page above the limit is
> > one thing, but one THP above the limit seems too much. I also don't
>
> Hmm what if you have multiple concurrent zswap stores, from different
> tasks but the same cgroup? If none of them has charged, they would all
> get greenlit, and charge towards the cgroup...
>
> So technically the zswap limit checking is already best-effort only.
> But now, instead of one page per violation, it's 512 pages per
> violation :)

Yeah good point about concurrent operations, we can go 512 pages above
limit * number of concurrent swapouts. That can be a lot of memory.

>
> Yeah this can be bad. I think this is only safe if you only use
> zswap.max as a binary knob (0 or max)...
>
> > like relying on the repeated limit checking in zswap_store_page(), if
> > anything I think that should be batched too.
> >
> > Is it too unreasonable to maintain the average compression ratio and
> > use that to estimate limit checking for both memcg and global limits?
> > Johannes, Nhat, any thoughts on this?
>
> I remember asking about this, but past Nhat might have relented :)
>
> https://lore.kernel.org/linux-mm/CAKEwX=3DPfAMZ2qJtwKwJsVx3TZWxV5z2ZaU1Ep=
k1UD=3DDBdMsjFA@mail.gmail.com/
>
> We can do limit checking and charging after compression is done, but
> that's a lot of code change (might not even be possible)... It will,
> however, allow us to do charging + checking in one go (rather than
> doing it 8, 16, or 512 times)
>
> Another thing we can do is to register a zswap writeback after the
> zswap store attempts to clean up excess capacity. Not sure what will
> happen if zswap writeback is disabled for the cgroup though :)
>
> If it's too hard, the average estimate could be a decent compromise,
> until we figure something smarter.

We can also do what we discussed before about double charging. The
pages that are being reclaimed are already charged, so technically we
don't need to charge them again. We can uncharge the difference
between compressed and uncompressed sizes after compression and call
it a day. This fixes the limit checking and the double charging in one
go.

I am a little bit nervous though about zswap uncharing the pages from
under reclaim, there are likely further accesses of the page memcg
after zswap. Maybe we can plumb the info back to reclaim or set a flag
on the page to avoid uncharging it when it's freed.

