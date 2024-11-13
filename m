Return-Path: <linux-kernel+bounces-407131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E89C6938
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4A01F2367A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27781178384;
	Wed, 13 Nov 2024 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcUgdZG5"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510BBA34
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731478953; cv=none; b=ed2jJObnHOXGSYVMc8bvc2kTnIev017OwWrnn1gZSMR5M34czbIlpp9bmbpLHW9aibOen8Y0PoolV5Kv7X4bd2Foz7xN5fAbCsBTHOb6u3QFPEyNkiShzdE0tM80epVTgRLLQfokeNwWZXelhNuqd0RYbZA2GnBacJhr2sWbURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731478953; c=relaxed/simple;
	bh=UWzYBbxLt/5+vds8mSiAIVMuGofjk5LzMxFmEKfmJ6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jqr+dO9/Ej8U9f6IIW/gHteM3aAWZsWwFsxkCqUx9wPCO3rfuC8/oG8Yd4g6EEvAviURlNYi3mU1Uttk3DPWU1O5abbpu3AFUIO9693leiL0Run2b/ne6MSAEmeRYVkUx0Y8sDnMc7ckEqIid3DzD6OL2DUQwbhsNLCRvAIfG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jcUgdZG5; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d2e71de18so2851547e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731478950; x=1732083750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OS1dBSTD/d7MdmWEB3ioT+o20JOJetm7ko1itzjkB8=;
        b=jcUgdZG5t9Kc9JKVxy68BtjrmpvsmaYa+3DckhqZyCat41NNyKKpVn44sacnenoYpI
         ixa6dMy4k/phZnNe83idNQSd4k4bfU1EXRIoGReWXDWm1Aw2/oRXbqR4HCy5fY/38sCb
         qs810Yypxk/ILjWiiZ7RhCEQO7rC9fskGsS4gTkMoqqcGSd8XBjZyqmwSkRZ3DL+D5B9
         BrZFPyUmSH0djvI39HubO+alYcO1iTTdKaqr+uwkKZFZJ9TNBh4g6sJwLTj9L0dEvvA1
         97Al0OyU5l7fbXYXmEdKry5uvJyKrKyfba8v+GSW3vDkUQBiWz0rzMuX2zTGjDSt7eJ/
         bRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731478950; x=1732083750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OS1dBSTD/d7MdmWEB3ioT+o20JOJetm7ko1itzjkB8=;
        b=BC/wFDFfCiCRdcNa4acpqqKHPz8+QkO79DWYD/6mXg3AHuGhdHuMB3yuENMaP7M62P
         5zZjKmkutokS0a1yp+lNfs4O/INYmgKgK9X7H3kkP2Bppu6TqGEhW99rS8AnbJ2AcAmf
         nB4R37cdEyXjAIlPPhsJGZA2X3KgBusxqj6N7EiOuzi3nhfFSwNT9DVLpZM2eEsOtb8I
         mjytohB44SsjlKU3a6sjRJoqr6GvPJtxiUg6viyOEMsxgpRAGA++ihOIZEpY0xBEyE96
         saqWIZIkskqQHkhb5rARV3BAlQ7SBqic+QfFFYfnY2DpQcvVVF4n7A/jGcuTIfAG8lDf
         FsUA==
X-Gm-Message-State: AOJu0Yx1R4/Fj2ENEhyg0lBnXl7D9k7CojyA7TYTEsoa7w/GUpY977c5
	MCbT9x7kznT8kEa+QpzYESJ3l/uiE4+YNu8VTrks4b4GQyWSAgFdraZd5e0x/ZIWFF8/BHHLsOE
	9h8Vu+ZPtM8rvnyf+BWGQGBGK/XFN9GgLe6YC
X-Google-Smtp-Source: AGHT+IG2yb5waITtZc4S+F4tVrhABeWZlltTyROL5h4zXO140BIbtCHIs7QWzk9+EN4YfOvSgLFIrqgr25IcNP17XHk=
X-Received: by 2002:a05:6122:1821:b0:50d:57df:1522 with SMTP id
 71dfb90a1353d-51401b94c0emr18733458e0c.6.1731478949905; Tue, 12 Nov 2024
 22:22:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com> <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
In-Reply-To: <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 12 Nov 2024 22:21:53 -0800
Message-ID: <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
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

On Tue, Nov 12, 2024 at 9:59=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Tuesday, November 12, 2024 9:35 PM
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
> > On Tue, Nov 12, 2024 at 9:24=E2=80=AFPM Kanchana P Sridhar
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > > This is a hotfix for a potential zpool memory leak that could result =
in
> > > the existing zswap_decompress():
> > >
> > >         mutex_unlock(&acomp_ctx->mutex);
> > >
> > >         if (src !=3D acomp_ctx->buffer)
> > >                 zpool_unmap_handle(zpool, entry->handle);
> > >
> > > Releasing the lock before the conditional does not protect the integr=
ity of
> > > "src", which is set earlier under the acomp_ctx mutex lock. This pose=
s a
> > > risk for the conditional behaving as intended, and consequently not
> > > unmapping the zpool handle, which could cause a zswap zpool memory
> > leak.
> > >
> > > This patch moves the mutex_unlock() to occur after the conditional an=
d
> > > subsequent zpool_unmap_handle(). This ensures that the value of "src"
> > > obtained earlier, with the mutex locked, does not change.
> >
> > The commit log is too complicated and incorrect. It is talking about
> > the stability of 'src', but that's a local variable on the stack
> > anyway. It doesn't need protection.
> >
> > The problem is 'acomp_ctx->buffer' being reused and changed after the
> > mutex is released. Leading to the check not being reliable. Please
> > simplify this.
>
> Thanks Yosry. That's exactly what I meant, but I think the wording got
> confusing. The problem I was trying to fix is the acomp_ctx->buffer
> value changing after the lock is released. This could happen as a result =
of any
> other compress or decompress that acquires the lock. I will simplify and
> clarify accordingly.
>
> >
> > >
> > > Even though an actual memory leak was not observed, this fix seems li=
ke a
> > > cleaner implementation.
> > >
> > > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > > Fixes: 9c500835f279 ("mm: zswap: fix kernel BUG in sg_init_one")
> > > ---
> > >  mm/zswap.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index f6316b66fb23..58810fa8ff23 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -986,10 +986,11 @@ static void zswap_decompress(struct
> > zswap_entry *entry, struct folio *folio)
> > >         acomp_request_set_params(acomp_ctx->req, &input, &output, ent=
ry-
> > >length, PAGE_SIZE);
> > >         BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx-
> > >req), &acomp_ctx->wait));
> > >         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> > > -       mutex_unlock(&acomp_ctx->mutex);
> > >
> > >         if (src !=3D acomp_ctx->buffer)
> > >                 zpool_unmap_handle(zpool, entry->handle);
> >
> > Actually now that I think more about it, I think this check isn't
> > entirely safe, even under the lock. Is it possible that
> > 'acomp_ctx->buffer' just happens to be equal to 'src' from a previous
> > decompression at the same handle? In this case, we will also
> > mistakenly skip the unmap.
>
> If we move the mutex_unlock to happen after the conditional and unmap,
> shouldn't that be sufficient under all conditions? With the fix, "src" ca=
n
> take on only 2 values in this procedure: the mapped handle or
> acomp_ctx->buffer. The only ambiguity would be in the (unlikely?) case
> if the mapped zpool handle happens to be equal to acomp_ctx->buffer.

Yes, that's the scenario I mean.

Specifically, in zswap_decompress(), we do not use 'acomp_ctx->buffer'
so 'src' is equal to the mapped handle. But, 'acomp_ctx->buffer'
happens to be equal to the same handle from a previous operation as we
don't clear it.

In this case, the 'src !=3D acomp_ctx->buffer' check will be false, even
though it should be true. This will result in an extra
zpool_unmap_handle() call. I didn't look closely, but this seems like
it can have a worse effect than leaking memory (e.g. there will be an
extra __kunmap_atomic() call in zsmalloc, and we may end up corrupting
a random handle).

>
> Please let me know if I am missing anything.
>
> >
> > It would be more reliable to set a boolean variable if we copy to
> > acomp_ctx->buffer and do the unmap, and check that flag here to check
> > if the unmap was done or not.
>
> Sure, this could be done, but not sure if it is required. Please let me k=
now
> if we still need the boolean variable in addition to moving the mutex_unl=
ock().

If we use a boolean, there is no need to move mutex_unlock(). The
boolean will be a local variable on the stack that doesn't need
protection.

>
> Thanks,
> Kanchana
>
> >
> > > +
> > > +       mutex_unlock(&acomp_ctx->mutex);
> > >  }
> > >
> > >  /*********************************
> > >
> > > base-commit: 0e5bdedb39ded767bff4c6184225578595cee98c
> > > --
> > > 2.27.0
> > >

