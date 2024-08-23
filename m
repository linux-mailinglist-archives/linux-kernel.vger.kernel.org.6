Return-Path: <linux-kernel+bounces-299299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0423495D276
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3752E1C23511
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E68A189B8F;
	Fri, 23 Aug 2024 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flsasWVd"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89E218593A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429306; cv=none; b=OugfMGG4SdhHDqPRZ9RKG+B8ph+aW1As8lpy/Y2ooKtUDbxj6orALpwSgzel79tPnlZOALrGvbLg4WQ+Z3M/x3wQ5xMeRD2N8IZz/k2WNsE61Wao+AKhdk5AZ0azOVyPE+V552slvQC/FXJlpSt18J6YFsYAwTU63dsNdM869I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429306; c=relaxed/simple;
	bh=+ZasLi+hclkNjCek93y8gPQorkAqqJ6TQAwzl8Op0MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUlaI2VvbnS3qJPE0eI4EQ+/jpwll82YBvE+LJMxfH8bRRV4n8aRikyaA1Nd4MVqw1Y5Xd1qcTHFO7H1c5u3bEYdxD2V3VbiSPkyo4GQEJp4VuQbWGPdyk3+zVu/7RhI4vlPJF+UCuIk3OzUZeVgr1j/03sOAwpCKJUflSwu5Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flsasWVd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-533521cd1c3so2555914e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724429303; x=1725034103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60mDZjLohoH/Srn+FzsRdN5LB7GzcubV5MgxDtoHqBs=;
        b=flsasWVdJf8RXK13cmJ4paEj2JezKBnQg+JB3YTIwPwslJRtq5ntgk8IN/tpFY79nQ
         fi+ZcWy2CXkeGxYSej/+XLQy6UtRoj7Ep2IX9qAT+6DMFzFlw5OxQCrw6mx2uc+nTTYD
         n+sexqZDnyGRsy+OiXXocyofevXcBmu23HLJrl4LASXgY0zw/EeDPPUhCN32UgzySVx5
         ZFph8oqts6n3NLlBkTxIrE/ju+x5u/peXeRjA9hQRk4idO/3KaHxYZCdYrMM4SEzX/QT
         sJPH1aFZefs8AmO8XYHKHkdMWtY+NrvZ+BgSmy8mn2rDBmAoIaS5SwRBPcbJLv26wocp
         NcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429303; x=1725034103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60mDZjLohoH/Srn+FzsRdN5LB7GzcubV5MgxDtoHqBs=;
        b=uxFW5ekWO1BEpPsAaDLikSsRhgsVMmxpixuLkGfH2gvETIaMkiK7yJA416SyPLGi8M
         tFM7UsRXe/zOMlEBFQCoEnT0hz+Kf2it2ucoRsknjCsGdU+GKoMY2IPJdfFOKAfUoSPr
         6PH1jEQoOoeEvfK5r82acWkD6MuDMCz3V8nNN+QJCuLIVjIL5Xim4FeNnv66wBi9m+Ux
         X9acOHfFDgdvzC6mvbJBMutoW7XvPcRuABVGpRLKjFII3YuJBi7wY5hOILUCfdiiaCPS
         l3bsEctMHxC1uGbbC4+2dB08saeYxRpokrUDeh5pFZKydHL+q8zYOlNi8LIIo5XOLUYo
         r47A==
X-Forwarded-Encrypted: i=1; AJvYcCXwejiX5YTCxD3mQGZfBP0PV+bbZK1cbfmVExDwUif+Yen+CLFRfUWuAxNmUhkk32TDahkOjJNJl5pbUEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDomQxIbXClyYOe2glwDF+OVQDCXvw0Is/vpo99y4A0xrcLi4
	eFiCP6wp1OqaC4qgTb7pMGHLCGVMDB6C2v8VnkyNiyleKTib9wLw3NJGu7zFr4bqNfWKv+p3IpO
	pbWYfkUzvoRAcL1Q4E8osoLUohzK9/bHD4eAd
X-Google-Smtp-Source: AGHT+IFzWoZ4n+2CZWNfhdJAMZParmTzQohv9bRH0x15mgayHZBeNg5k4entByf4z9D7oSlR7pVx0fhye36Aap4RFO0=
X-Received: by 2002:a05:6512:234b:b0:533:4505:5b2a with SMTP id
 2adb3069b0e04-534388510cdmr2797061e87.28.1724429302210; Fri, 23 Aug 2024
 09:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
 <CAKEwX=PEye=VcXF=r-A9B47VsNtpLLxz5cJiswzuQXBio8rizA@mail.gmail.com> <Zsig_AZDT5zOO1Wg@casper.infradead.org>
In-Reply-To: <Zsig_AZDT5zOO1Wg@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 23 Aug 2024 09:07:44 -0700
Message-ID: <CAJD7tkbO938ETJn0FOG_vVU4V2_dBanio1QG56cp6ctFHpSeNw@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Matthew Wilcox <willy@infradead.org>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 7:47=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Aug 23, 2024 at 10:35:19AM -0400, Nhat Pham wrote:
> > On Fri, Aug 23, 2024 at 9:13=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > >
> > > That said, zswap could handle this better.  There's no need to panic =
the
> > > entire machine over being unable to read a page from swap.  Killing j=
ust
> > > the process that needed this page is sufficient.
> >
> > Agree 100%. It is silly to kill the entire host for a swap read error,
> > and extra silly to kill the process because we fail to writeback - for
> > all we know that page might never be needed by the process again!!!
> >
> > >
> > > Suggested patch at end after the oops.
> > >
> > > @@ -1601,6 +1613,7 @@ bool zswap_load(struct folio *folio)
> > >         bool swapcache =3D folio_test_swapcache(folio);
> > >         struct xarray *tree =3D swap_zswap_tree(swp);
> > >         struct zswap_entry *entry;
> > > +       int err;
> > >
> > >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > >
> > > @@ -1638,10 +1651,13 @@ bool zswap_load(struct folio *folio)
> > >         if (!entry)
> > >                 return false;
> > >
> > > -       if (entry->length)
> > > -               zswap_decompress(entry, folio);
> > > -       else
> > > +       if (entry->length) {
> > > +               err =3D zswap_decompress(entry, folio);
> > > +               if (err)
> > > +                       return false;
> >
> > Here, if zswap decompression fails and zswap load returns false, the
> > page_io logic will proceed as if zswap does not have the page and
> > reads garbage from the backing device instead. This could potentially
> > lead to silent data/memory corruption right? Or am I missing something
> > :) Maybe we could be extra careful here and treat it as if there is a
> > bio read error in the case zswap owns the page, but cannot decompress
> > it?
>
> Ah; you know more about how zswap works than I do.  So it's not a
> write-through cache?  I guess we need to go a bit further then and
> return an errno from zswap_load -- EIO/ENOENT/0 and handle that
> appropriately.

It should work if we just return true without calling
folio_mark_uptodate(), this is what we do if we get a large folio in
zswap_load(). Returning true means that the page was found in zswap,
so we won't fallback to reading from the backing device. Not marking
the folio uptodate will cause an IO error IIUC.

>
> > The rest seems solid to me :)

