Return-Path: <linux-kernel+bounces-408260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7319C7CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0A0282900
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EFB2064E9;
	Wed, 13 Nov 2024 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4L/EkLH"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143E206072
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528713; cv=none; b=KxbkUgMTlq1HRucIVWuN1gg4j/CxN43CBpBlajs/OAh72miKjjSa1dGau1fTU0azdWYoTyabbPfruWoLCOPCq8MMPYN9QhnQnUIZXFJQQpa+TsorGI0FUtM66+tSJ9MRsO4gNXFv+YfIwpaEcs8m7zO5iZavQhSZ7pa7MttiWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528713; c=relaxed/simple;
	bh=EC+pDZ5Pzs78nKy+usl05MlS4gknkXiYTKY3s4SlyYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdAVa6IKeWzz1ZfnCgViOtupASBUnHh0YehlRVQHABruGKFODjdLuHlMyA4TU49Ch56mzrCu7QZqscUSg7KQoQ+wIUcmUrL/oPL14W3UjgJ/1hAFJ/2wKIbX6JDGJuiCQYoSqYvMfHUEpE8088IP7neABoR3j5IbNVl2OusgJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4L/EkLH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460c316fc37so48668071cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731528710; x=1732133510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnuzvvM7+zr3+XrrCjkOLSAzu/LOxRu1ibWMlulQy1M=;
        b=p4L/EkLHojIBM3MlPWrqei188rWcOikGYBPvlLe2NV+XjNBH0aUDPatlzKj5E5b+ne
         Y6un9LsAyeUpBe776tS9vPp6O13uCa9D0Q+FdWZCT6FtEkC4dFOM+fH+Nu6YEdhBLprA
         S+0UuVM07xkXtgIHWtUabXNKsI1Qu07AoXfCZ419nNklwTTJwkoiJKNTdq/O3OEg1TLN
         sXCt5vvTcXFJp2lnjKHI2IENsAsOdgeO7QEm7lohDlKui/uOHIkTd4ChQw7t3jKPiJx8
         LOJ3erhCjjAWv5wyuVHFLPnQuP8lkwXM9Ew0IO3VfB6JlLFd2v7vKk9Gu4vwYxTpSviT
         3CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731528710; x=1732133510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnuzvvM7+zr3+XrrCjkOLSAzu/LOxRu1ibWMlulQy1M=;
        b=XjKuF/DC1RHK/9bhFq3sC79afrh63Hgw+KXSY6gtpjjhh/f/M9gAWRMwSNNpZbai1b
         jLfj4fIkt5aX1Yr4ItQm71H2L3ilQTVevsuK0PZy+6kXybphgEZj/W0tnoO8bcYzOyk/
         VfxfI/5WbLPIKEwSqjZUUmc2OCtP76RfHpDe5xuNzqSvJ2RHbOFK2CIOf86RM0RwDv5U
         UzhoKUc5dQ7r11wZLy5oRJhjyKYaHmVXc5wQyg/NcG3JUx6cd2GJ1GaqbNNmBBK3O2ND
         MS4vsHFDi5AJ5BqgjBeZESHm+1AnCC+L5U1xP9vbBUXHFyuxW7BlrwVWFZ83JauLXhr9
         oy6A==
X-Gm-Message-State: AOJu0YznvIjy8ncnoTWcnFAl62nYmizCF/1KhbA711GrkpMsIoG3OE6s
	h1B9jWxSWH8JsQ8AgIz8Es5Z5MyawLZrd2V8/zWjlnMSB8I+MeuSQjVyAt5bu+6yCSzgjFZUUFo
	CU1XY96fFJ6OjHzm28wSHrKgdUP7zVY0fsXfA
X-Google-Smtp-Source: AGHT+IFxGinIkgupNAq5TJuq9cMmE43wy/u7zWYii1tRKnFOWLHSFiG7PcSXoP1tfGkXl1wVveKu+YnEh6f442SF9BQ=
X-Received: by 2002:a05:6214:4808:b0:6d3:77b8:cb3 with SMTP id
 6a1803df08f44-6d39e16a88cmr326199076d6.12.1731528710066; Wed, 13 Nov 2024
 12:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com> <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 13 Nov 2024 12:11:13 -0800
Message-ID: <CAJD7tkZHvHUi0KpEW+M0k5A-9UfAGJzm++gzaaxdCbLsLFVQJw@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in zswap_decompress().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:12=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi Yosry,
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Tuesday, November 12, 2024 10:22 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > hannes@cmpxchg.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> > usamaarif642@gmail.com; ryan.roberts@arm.com; Huang, Ying
> > <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-foundation.org;
> > Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> > <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
> > zswap_decompress().
> >
> > On Tue, Nov 12, 2024 at 9:59=E2=80=AFPM Sridhar, Kanchana P
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Yosry Ahmed <yosryahmed@google.com>
> > > > Sent: Tuesday, November 12, 2024 9:35 PM
> > > > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > > > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > > > hannes@cmpxchg.org; nphamcs@gmail.com;
> > chengming.zhou@linux.dev;
> > > > usamaarif642@gmail.com; ryan.roberts@arm.com; Huang, Ying
> > > > <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > foundation.org;
> > > > Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> > > > <vinodh.gopal@intel.com>
> > > > Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
> > > > zswap_decompress().
> > > >
> > > > On Tue, Nov 12, 2024 at 9:24=E2=80=AFPM Kanchana P Sridhar
> > > > <kanchana.p.sridhar@intel.com> wrote:
> > > > >
> > > > > This is a hotfix for a potential zpool memory leak that could res=
ult in
> > > > > the existing zswap_decompress():
> > > > >
> > > > >         mutex_unlock(&acomp_ctx->mutex);
> > > > >
> > > > >         if (src !=3D acomp_ctx->buffer)
> > > > >                 zpool_unmap_handle(zpool, entry->handle);
> > > > >
> > > > > Releasing the lock before the conditional does not protect the in=
tegrity
> > of
> > > > > "src", which is set earlier under the acomp_ctx mutex lock. This =
poses a
> > > > > risk for the conditional behaving as intended, and consequently n=
ot
> > > > > unmapping the zpool handle, which could cause a zswap zpool memor=
y
> > > > leak.
> > > > >
> > > > > This patch moves the mutex_unlock() to occur after the conditiona=
l and
> > > > > subsequent zpool_unmap_handle(). This ensures that the value of "=
src"
> > > > > obtained earlier, with the mutex locked, does not change.
> > > >
> > > > The commit log is too complicated and incorrect. It is talking abou=
t
> > > > the stability of 'src', but that's a local variable on the stack
> > > > anyway. It doesn't need protection.
> > > >
> > > > The problem is 'acomp_ctx->buffer' being reused and changed after t=
he
> > > > mutex is released. Leading to the check not being reliable. Please
> > > > simplify this.
> > >
> > > Thanks Yosry. That's exactly what I meant, but I think the wording go=
t
> > > confusing. The problem I was trying to fix is the acomp_ctx->buffer
> > > value changing after the lock is released. This could happen as a res=
ult of
> > any
> > > other compress or decompress that acquires the lock. I will simplify =
and
> > > clarify accordingly.
> > >
> > > >
> > > > >
> > > > > Even though an actual memory leak was not observed, this fix seem=
s
> > like a
> > > > > cleaner implementation.
> > > > >
> > > > > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > > > > Fixes: 9c500835f279 ("mm: zswap: fix kernel BUG in sg_init_one")
> > > > > ---
> > > > >  mm/zswap.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index f6316b66fb23..58810fa8ff23 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -986,10 +986,11 @@ static void zswap_decompress(struct
> > > > zswap_entry *entry, struct folio *folio)
> > > > >         acomp_request_set_params(acomp_ctx->req, &input, &output,
> > entry-
> > > > >length, PAGE_SIZE);
> > > > >         BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx-
> > > > >req), &acomp_ctx->wait));
> > > > >         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> > > > > -       mutex_unlock(&acomp_ctx->mutex);
> > > > >
> > > > >         if (src !=3D acomp_ctx->buffer)
> > > > >                 zpool_unmap_handle(zpool, entry->handle);
> > > >
> > > > Actually now that I think more about it, I think this check isn't
> > > > entirely safe, even under the lock. Is it possible that
> > > > 'acomp_ctx->buffer' just happens to be equal to 'src' from a previo=
us
> > > > decompression at the same handle? In this case, we will also
> > > > mistakenly skip the unmap.
> > >
> > > If we move the mutex_unlock to happen after the conditional and unmap=
,
> > > shouldn't that be sufficient under all conditions? With the fix, "src=
" can
> > > take on only 2 values in this procedure: the mapped handle or
> > > acomp_ctx->buffer. The only ambiguity would be in the (unlikely?) cas=
e
> > > if the mapped zpool handle happens to be equal to acomp_ctx->buffer.
> >
> > Yes, that's the scenario I mean.
> >
> > Specifically, in zswap_decompress(), we do not use 'acomp_ctx->buffer'
> > so 'src' is equal to the mapped handle. But, 'acomp_ctx->buffer'
> > happens to be equal to the same handle from a previous operation as we
> > don't clear it.
>
> Although, we never modify 'acomp_ctx->buffer' in zswap_decompress(),
> we only copy to it.

Duh, yes. I confused myself, sorry for the noise.

>
> >
> > In this case, the 'src !=3D acomp_ctx->buffer' check will be false, eve=
n
> > though it should be true. This will result in an extra
> > zpool_unmap_handle() call. I didn't look closely, but this seems like
> > it can have a worse effect than leaking memory (e.g. there will be an
> > extra __kunmap_atomic() call in zsmalloc, and we may end up corrupting
> > a random handle).
> >
> > >
> > > Please let me know if I am missing anything.
> > >
> > > >
> > > > It would be more reliable to set a boolean variable if we copy to
> > > > acomp_ctx->buffer and do the unmap, and check that flag here to che=
ck
> > > > if the unmap was done or not.
> > >
> > > Sure, this could be done, but not sure if it is required. Please let =
me know
> > > if we still need the boolean variable in addition to moving the
> > mutex_unlock().
> >
> > If we use a boolean, there is no need to move mutex_unlock(). The
> > boolean will be a local variable on the stack that doesn't need
> > protection.
>
> I agree, using the boolean variable to do the unmap rather than the check
> for (src !=3D acomp_ctx->buffer) is more fail-safe.
>
> I am still thinking moving the mutex_unlock() could help, or at least hav=
e
> no downside. The acomp_ctx is per-cpu and it's mutex_lock/unlock
> safeguards the interaction between the decompress operation, the
> sg_*() API calls inside zswap_decompress() and the shared zpool.
>
> If we release the per-cpu acomp_ctx's mutex lock before the
> zpool_unmap_handle(), is it possible that another cpu could acquire
> it's acomp_ctx's lock and map the same zpool handle (that the earlier
> cpu has yet to unmap or is concurrently unmapping) for a write?
> If this could happen, would it result in undefined state for both
> these zpool ops on different cpu's?

Why would this result in an undefined state? For zsmalloc, mapping
uses a per-CPU buffer and preemption is disabled between mapping and
unmapping anyway. If another CPU maps the object it should be fine.

>
> Would keeping the per-cpu mutex locked through the
> zpool_unmap_handle() create a non-preemptible state that would
> avoid this? IOW, if the above scenario is possible, does the per-cpu
> acomp_ctx's mutex help/is a no-op? Or, is the above scenario somehow
> prevented by the implementation of the zpools?

At least for zsmalloc, I think it is.

>
> Just thought I would bring up these open questions. Please do share
> your thoughts and advise.

I think moving the mutex unlock after the unmap won't make much of a
difference from a performance side, at least for zsmalloc. Preemption
will be disabled until the unmap is done anyway, so even after we
release the per-CPU mutex it cannot be acquired by anyone else until
the unmap is done.

Anyway, I think the fix you have right now is fine, if you prefer not
adding a boolean. If you do add a boolean, whether you move the mutex
unlock or not should not make a difference.

Please just rewrite the commit log and CC stable (in the commit log,
not in the email CC list).

Thanks and sorry for the confusion!

>
> Thanks,
> Kanchana
>
> >
> > >
> > > Thanks,
> > > Kanchana
> > >
> > > >
> > > > > +
> > > > > +       mutex_unlock(&acomp_ctx->mutex);
> > > > >  }
> > > > >
> > > > >  /*********************************
> > > > >
> > > > > base-commit: 0e5bdedb39ded767bff4c6184225578595cee98c
> > > > > --
> > > > > 2.27.0
> > > > >

