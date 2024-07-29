Return-Path: <linux-kernel+bounces-265171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF093ED89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482B6B20D16
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F531839E3;
	Mon, 29 Jul 2024 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBuU6W1z"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3632264D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722235013; cv=none; b=t8ZIH9P9w+5m3srA5tesXY3KZuYdQmJItcqcOk7glv9mDcrdcUHBkcwpwcUvMR8GJtjw7kqFUnyEkxHeyWMyMJHdUBom4+2cEDsemAWb+WFzhTvj4puQhsrsPZQs0l9BhwMFJrloAZ3Mp4F3D9ltqv4OfLdbzu8KE1Tn2SiH1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722235013; c=relaxed/simple;
	bh=HyVCJuppO0gu61GNUZCvqtDQ3sxJ6HCMw20g347y4bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwDyDK2XbFRcEHxgi5znzBa3scGOg9vlU14FD3Gn95nXLXfGmVRjmhjWJug09AgmKtE9s2DK2c5gdM7JWW0TtbVgqudDtmrpSmv8W2vM1B5YS0W83GzSPGgeGdrb3l6yCeJW0JlIabLqKL1oCcaH2uIVrME+0RX5BV0Z2hV9544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBuU6W1z; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so46748081fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 23:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722235010; x=1722839810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGJ+4r8n52fnwh3nw7DAkXbq0FHhAsWnzXendtK6RBg=;
        b=WBuU6W1zkB3kbFu8JlciC6sNF7ziqE5COxAb6F/WgTZJBFDszTqgBEYpdlILfg4iZv
         lef+tWw/CSC3pgf4T7qtglUqPJIj5cLjZ6oDIViJI90AFXU985W9AgnmtAxrfrP1C9mh
         zRe+uNY8ncC13pVUyABpz60zUbX/C2tSOWLmLSWRd8Res+dgTw1lpW7hk5un067X+ASu
         Si9rftXp2E2ID5Ue0nprjAlUWp3cP/wpexv6rFN0fwFL0QPWwL6UuZ08ao1eYJwaDmhT
         US+IX8ywbhbk7cqF+GuarKbhKyb+UHpt5yDWUQAiN4w9zDwo1BK8RpL/xviJ3rnMy772
         AiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722235010; x=1722839810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGJ+4r8n52fnwh3nw7DAkXbq0FHhAsWnzXendtK6RBg=;
        b=WjRpAPc6nDVHyBBkfdYnwa/HK+RhQoomUHhWm4yzAxtL5r4lXs3U4eppgEVkktMLcU
         OKfL+HFFrmyN7ZebeC6zfhjZ9Bt32PURpBguuY5Bs4dQqT/s8NkUIC1pWM+7GTg2JENY
         +C2BiMauOvEp5qvXeMnZsCA//jEniIFSXmnD5nmbMV/GcFm8gpofG0RIsvh2fTBYZFZq
         RH9EUWHg014tnrVXQ9m6+Y5H3o+72n1W6d1A0Sjkk0+MlhyPemZRdUKq3KmzopSvn6fY
         o9VJPtTgRl0KZudS2e7915rTK3t++dwnGx86J36lQbbvz3iGwB8J6X3GSXktL1n+B4z8
         /tLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQDPpiAF5GEX2trMLnG9OwhUlcSx1m1U9yHuod2kclJRVbEeKpahQKrBh8x/N7AOSp8Imr/iUeFi/bCTqn9ZBud/N+0GX54gCGo4eh
X-Gm-Message-State: AOJu0YzsgoRM0qSjLlj+4e128kBadJaHKn4M32W+i+scpp5/J2SPeCTq
	a7feZXzAglM8quvTZGY7xpMGQ711ksy6blxP9hMUYsp/h0/UZqKP59T5mDL7UJq2sDcn+fBCEab
	6sNtR1XV1lg2H0cfJRgVTjLhN3jc=
X-Google-Smtp-Source: AGHT+IF3rX1Ul358zrZGvQPbgOWmn3EgG2QUYS0e4gVJuMRnufLSVdig55Pb5IcTiegWh4ITw/28v+WXlQ3lQA2JNNc=
X-Received: by 2002:a2e:9f43:0:b0:2ef:1ba9:dc5a with SMTP id
 38308e7fff4ca-2f12ee29a87mr57743991fa.28.1722235009945; Sun, 28 Jul 2024
 23:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org>
In-Reply-To: <ZqcRqxGaJsAwZD3C@casper.infradead.org>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Mon, 29 Jul 2024 14:36:38 +0800
Message-ID: <CANzGp4J3et+yo8v8iDngvAb3nrn-gSDh0_j0=65OEiw9jKJbPQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
To: Matthew Wilcox <willy@infradead.org>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	ying.huang@intel.com, baolin.wang@linux.alibaba.com, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com, Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=B8=80 11:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jul 26, 2024 at 09:46:17PM +1200, Barry Song wrote:
> > -                     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
> > -                                             vma, vmf->address, false)=
;
> > +                     folio =3D alloc_swap_folio(vmf);
> >                       page =3D &folio->page;
>
> This is no longer correct.  You need to set 'page' to the precise page
> that is being faulted rather than the first page of the folio.  It was
> fine before because it always allocated a single-page folio, but now it
> must use folio_page() or folio_file_page() (whichever has the correct
> semantics for you).
>
> Also you need to fix your test suite to notice this bug.  I suggest
> doing that first so that you know whether you've got the calculation
> correct.

>
>
This is no problem now, we support large folios swapin as a whole, so
the head page is used here instead of the page that is being faulted.
You can also refer to the current code context, now support large
folios swapin as a whole, and previously only support small page
swapin is not the same.

--=20
Thanks,
Chuanhua

