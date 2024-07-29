Return-Path: <linux-kernel+bounces-265103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0685093ECA5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06BD281332
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537388248C;
	Mon, 29 Jul 2024 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxe35vGg"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ADC1B86D6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722228089; cv=none; b=BYOWSuzabylmx05T43rh4kmid19pZvTkDO7V4IRTCAe40xyJTCeCMpHgZAmZ/kRijdx2o20Njog/FTYhzxRXpUroE5zOfzahkndlOo11gW0SbtcWmm+/EhtSE5I8M1uyGWO+PZgAZP6b4oG6YPb5PSxa7SuFzsV/Vb8crvvIqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722228089; c=relaxed/simple;
	bh=TxCdXQbt+FYKJwFmb+VaHqTIx+1OvckkeV2C8PBGeC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDYRp15ciAoc+TUO+RxIAVq29ohfgrnXJvAf9FZdvQLzkj6Td4a4GlgstCwS74scbEsBNWLrOoX4tUiDpXkm5PMlbXcXeh+ez54oBPwjrI0aZBbBQq5TpC1h8WJiwXej1wb0CfZtoXQpmxLbmrkbXIMGYgo2lPiO2DEPA+lIwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxe35vGg; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-493d7455231so442936137.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722228087; x=1722832887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvMehHFovVJWeBpH4SDKvqU5fsitO2FHmL29ZzK4oEA=;
        b=Cxe35vGgNjrxosDlwHHSClvnUwSCxctsgHoyepzygqCCVL/dBcLBvg3QVtab4OWB9I
         bVBgAX+K6KAuwk2VeIKhhG1aq0TuJQaoxxhadcRQAWv40oXpWIvwsenTG8uWV5ip8gQR
         RfNPcT5IM5fGjDjHwIyFfI3H8oagQR6vXeN4HotQ904A1gyGkLhuJuVk773tCRZCxpxO
         UkBTk3j+OKBzd5VaHOv4t0Yn1d5im1+qenJpzkSTnowb1cNdztXAnwUmijLCjdPOMs07
         9+r3AV0Yhm1two/GjSEj3XtF1Bp8zghkSVZIWcHoei1I2MVVrAHmUes27pte6ymBlVNC
         wP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722228087; x=1722832887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvMehHFovVJWeBpH4SDKvqU5fsitO2FHmL29ZzK4oEA=;
        b=CvaqLaIF02AnDaOXycsH7Kl6S8vIuCqvHlJIx0kN/7Y7FAXJKj856CkL4UwJsLe34t
         DvwtlNxKySgS3l46fSf0z2cv19OB0fNjX9XotURhVFGSTZjmQEMIBmu4cz0xPgjGtzWx
         uGtRRhjBub69JTkV0S+s0DtxsneREsw5G8VHL16IitZVfdjuGn7Yp4tl5vFkZ0/UMPYG
         oRDJpnjsf5y3YliXmis4XY2Otr8PUapqZuGpRKXCNxPe7WNAiRae20JuV3WwqFaxVGeo
         CHgEZses2UrWHjGBMxEqzTwiwoEPkNyzO4J/HJ4hWIy0uhOlfR5EAp7ZKPSVkp2EDR6a
         3rxA==
X-Forwarded-Encrypted: i=1; AJvYcCW7gRdHlQs+MmnyevZai7oJAzezM1EV9ExtkFNE8pxMNJ4R4H57xUfOyTDJEujnicVGhmAru+bPyk5x1BRy59aaWFWRra0Xk4CX4LGL
X-Gm-Message-State: AOJu0YxtUYERXW8DcPLopO98Jeu7r9qIQPHqH/7GHEL8FY4GacTEBMrr
	fGlFAd36lo4+X03UWXDi0sGTNDks0BnqwKtYhZJ4DbL3OhQdXtkvPtVvQD0unth+Qiv8m/gr7lu
	dSpcjng23h+Y27zB/zfvJULf2U68=
X-Google-Smtp-Source: AGHT+IEGUlbD6eLPUKNik9e3P1JeR0U0VL6y3soem8DsRydlwQrTBk+IkxA8QN5IelQ2sITl6PKNPtCOSCRgj+MVrEc=
X-Received: by 2002:a05:6102:3f0e:b0:493:e585:6ce3 with SMTP id
 ada2fe7eead31-493fadd965emr7177806137.31.1722228087038; Sun, 28 Jul 2024
 21:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-4-21cnbao@gmail.com>
 <ZqcRqxGaJsAwZD3C@casper.infradead.org>
In-Reply-To: <ZqcRqxGaJsAwZD3C@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 29 Jul 2024 16:41:16 +1200
Message-ID: <CAGsJ_4xQkPtw1Cw=2mcRjpTdp-c9tSFCuW_U6JKzJ3zHGYQWrA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm: support large folios swapin as a whole for
 zRAM-like swapfile
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com, Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 3:51=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
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

I don't understand why the code is designed in the way the page
is the first page of this folio. Otherwise, we need lots of changes
later while mapping the folio in ptes and rmap.

>

Thanks
Barry

