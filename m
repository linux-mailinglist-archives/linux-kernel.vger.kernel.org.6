Return-Path: <linux-kernel+bounces-314399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F48996B2BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5DA284362
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCFA146013;
	Wed,  4 Sep 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJqqeXqz"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D066130ADA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434570; cv=none; b=UqGrQ348iaEaHOhVTO0119ak2F36CVwqpgtsPEbDwOzAaQKcz3peMoLaEjIe4G2MJAXSW2+F6PPCg5ZKdGRFMd+Qv67/JTBm0LYvkxyx29ptWVUqyOVlYA4OBVqi98XKJ+IekXzuXdmUK86rGirMqxCFE+4NbBvsRMshqGcbDvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434570; c=relaxed/simple;
	bh=N/8LmTci6kQ+TLkkRjdEv64Qu70jFmrtnuhHZjDcqPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTMO0iTI7Goo+57CpR2auXe94T/Sj6vWEEPncMtvA9+0OSkawduJ56NNuc2GfUTX6a41OOG5PPcrDm1JABNNs/QFj10H2em8/7RdrVyLPozAi3mG1KKIvttPqTAqqFnvV/oY50WWGIuIFuvqKo2kyI/mSJD//pf5/e/7hcGzKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJqqeXqz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86abbd68ffso77617966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725434567; x=1726039367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zOhdoj9/Ybg8aoB4iZX9Xi/vhy5Ul9rRLj5zkxP+T8=;
        b=kJqqeXqzMJox0+4Vw9pliV5UrhDLIs2Hau7WTAinHFnIZohWVXeIgQlkmH5M1A0oh6
         1AgO2mot0oB0Wpcgf36N8JEamEGJKzVuqNFbBCQ2sqJ7mIBcluniqajR1nZeziuKgzeO
         2oJGsuv4kYIRAqgYWl9LMyanUAMJSw/KpnVckT8gXmeS5aXiCbe/J7QSmmXSHktU/E3k
         uwWNa6GH3bHchxY2S/2Uz6wKrc7bRm5CMgT6gsW8NopJnutG2g90jHylvRyF7L6dueBI
         qfvP+mYx7LHbu0tpHabXVICF/Il+FAe9bOtEGrkH5/5NsezJApX96HSA6Itih5jG2/+z
         Sr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434567; x=1726039367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zOhdoj9/Ybg8aoB4iZX9Xi/vhy5Ul9rRLj5zkxP+T8=;
        b=bZjBEYLnPX2TtVzcBq0uPVcPgAD6x081e7Dt8exBYp56FJPi50XTdEGGzVy8BMhBQt
         4/Ors2/fA79+ej61VX7sKqFVlH7gFohkwtOJGdn1j32OpCfrBm74Q1Pvpkux7ZA05ndg
         bLAOdkH2gS8riGI8LpqwiAVxQHB25JJu0rl9CY79zKa1RXGnOtUTXLGiKjiclyHsNdId
         HJpM4t99FqBr9LOv2JMRXdfPGqtz6SFmPaR1127qjR/KVIAWdHA/7Ghir5W2Qohow08t
         brIq3zRsJftBXo82/DiXZe5nrz2MY/i3gnBN+GOTKBVzpyR9pQ19PjKJ6+treQC4R1Vm
         IT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmN4vvhf8biwSvNnZ5JITUWAJhTYPjfR5BQm74+k4yZfNrnmf0wkvHS2B4iSjDG0AUT9uDjDiPwFoJm8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs3EEabQVzvx40CBcmm9oThlkXSuGt278P4QkU9MvTvj2PIxXk
	xqQcumdNPldYk7vPF6sia0CDS+JlObyUhYea8jArohudWSwTiIm3nr1T7wOSLSC0kffB7PJvAtR
	Rrj2Puacgx2ZMORhCdJx9GlfpuoG9+l/dSZpr
X-Google-Smtp-Source: AGHT+IHEYMbhMil+VLa0ulIQ/lG8oz8wKI3Q/bEp6d4Bg4xqziiefjRg+TkGeLT3n9lyrgnQropMb8sPfdRtxgSeG10=
X-Received: by 2002:a17:907:868f:b0:a7d:8912:6697 with SMTP id
 a640c23a62f3a-a8a42f8afeemr108882766b.3.1725434566937; Wed, 04 Sep 2024
 00:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
 <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com>
In-Reply-To: <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Sep 2024 00:22:11 -0700
Message-ID: <CAJD7tkYqk_raVy07cw9cz=RWo=6BpJc0Ax84MkXLRqCjYvYpeA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Barry Song <21cnbao@gmail.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 12:17=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Sep 4, 2024 at 7:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > [..]
> > > > @@ -426,6 +515,26 @@ static void sio_read_complete(struct kiocb *io=
cb, long ret)
> > > >         mempool_free(sio, sio_pool);
> > > >  }
> > > >
> > > > +static bool swap_read_folio_zeromap(struct folio *folio)
> > > > +{
> > > > +       unsigned int idx =3D swap_zeromap_folio_test(folio);
> > > > +
> > > > +       if (idx =3D=3D 0)
> > > > +               return false;
> > > > +
> > > > +       /*
> > > > +        * Swapping in a large folio that is partially in the zerom=
ap is not
> > > > +        * currently handled. Return true without marking the folio=
 uptodate so
> > > > +        * that an IO error is emitted (e.g. do_swap_page() will si=
gbus).
> > > > +        */
> > > > +       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> > > > +               return true;
> > >
> > > Hi Usama, Yosry,
> > >
> > > I feel the warning is wrong as we could have the case where idx=3D=3D=
0
> > > is not zeromap but idx=3D1 is zeromap. idx =3D=3D 0 doesn't necessari=
ly
> > > mean we should return false.
> >
> > Good catch. Yeah if idx =3D=3D 0 is not in the zeromap but other indice=
s
> > are we will mistakenly read the entire folio from swap.
> >
> > >
> > > What about the below change which both fixes the warning and unblocks
> > > large folios swap-in?
> >
> > But I don't see how that unblocks the large folios swap-in work? We
> > still need to actually handle the case where a large folio being
> > swapped in is partially in the zeromap. Right now we warn and unlock
> > the folio without calling folio_mark_uptodate(), which emits an IO
> > error.
>
> I placed this in mm/swap.h so that during swap-in, it can filter out any =
large
> folios where swap_zeromap_entries_count() is greater than 0 and less than
> nr.
>
> I believe this case would be quite rare, as it can only occur when some s=
mall
> folios that are swapped out happen to have contiguous and aligned swap
> slots.

I am assuming this would be near where the zswap_never_enabled() check
is today, right?

I understand the point of doing this to unblock the synchronous large
folio swapin support work, but at some point we're gonna have to
actually handle the cases where a large folio being swapped in is
partially in the swap cache, zswap, the zeromap, etc.

All these cases will need similar-ish handling, and I suspect we won't
just skip swapping in large folios in all these cases.

