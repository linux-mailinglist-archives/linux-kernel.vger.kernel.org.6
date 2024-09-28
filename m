Return-Path: <linux-kernel+bounces-342392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449DB988E69
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7485B1C20DB4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176C19DF98;
	Sat, 28 Sep 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJDQQbmW"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAD12E75
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727511165; cv=none; b=rxEfPcXbzB2K4DnVHEtrHuftBpq11Jzsg/mFPpeHSM7NT4ianXx8hXI+AZQMi8IOIYQjlD/sfRaFBlP3M5uF8UgwVHEqR7E2AUOxe0yK0JY5RPidcMxK9RhvctpSWx8MLY3/u9XjxF4fjXAw/I6jny9/bp4pHAPTIWmnEGIH4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727511165; c=relaxed/simple;
	bh=dIGpCRt4md8gbhmXuRt/NsFaXFa6x6DEi9MZ1xgv8r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGT8nYZT6ghomwPXgt8LBY0AqGRRlm4bbIlcEjhlSSPuKrcaFOD9KoD8FyWc/j3D2OArG9/eLHvqnQwkAhSR/oyLKl7vmGcvvVKG0KIH4OpDgUpWbYHm36Yp5fZB8meARsPmogo88IO4x/E7UG67ZZpaqzh5qB8zV8IfSwa9U8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJDQQbmW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso321197666b.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727511162; x=1728115962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Samd0mUAzWlzelumq96uezolPu6N8J4V2/Xoj2xIqfQ=;
        b=nJDQQbmWc4WuLlgZHolZ29TMSKegz17O3yNGppc8B6mkBuh2u0Wr67AWgiooARi+qX
         H81iEoM0rnEeWf6JvCcGUfH08ziXV+XO0++6etQkwWTFJXedKqGIUyz9KeSzliDnNIyI
         wQP3k+bfpTkeYeuLoPXcUrfYq0xNnl09FPhOOAw1YhIWFYs7vHuU4HG3jITb931FdB8T
         b0nQNaGZxX8jsl+REhroooSzSvtBr1sOiBWDXuP/xqGuYhlAl9uiC2G2r6PNKzfXO518
         0FZexBrJTh+I/91z32VU4r9EUvhAbBWBvsu0SExm3DAgxHWpvR5hq8e0E89P+X7mF5JY
         Dd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727511162; x=1728115962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Samd0mUAzWlzelumq96uezolPu6N8J4V2/Xoj2xIqfQ=;
        b=WDvsU4LV0eono4RS1kMec035rQNSDnkGS9IYa9uYl3TvrXHExugSkOBuzaIh84Qtt3
         DsxZJKvyg8zqdE7ydhR0BrZdvMgUlL1QtK0oxRHKA89z0VY6HyAL7Ynx35JEPkasG8Tu
         5roinuYbbMoZsskEFjopjuyBaHY98DKLZBK/Q34fzv0UKSRkyQ8h3b1kL5kypEWU1Mog
         EuYT3uOwPadEGvHqgR0Q+/WWyOtIssYEdFNpjhSg3opWSI08kRyL7ajHIW62ez9SS0mC
         JMS8R5A6FVpVTNyTzQ8jZrd+QBORaZAkHOHy+EjJ15AmLrZ0rbGGXxDs9AP4W37uTkyN
         WrSg==
X-Forwarded-Encrypted: i=1; AJvYcCUgb3QyhGU5JRMaNTuAChjZimmoup/5Rbcdx1Ck9j0jesFuHh7Om2zD90urOV5ZXM9/8yu1d9xOK85s/bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCAZpImB38RNYVXFj2vBFkUVV5AuOr7LOiBijI/lo3PP5ncm8a
	9d+Ydj4yxul9W0/c4pZXjeS42BdRtEVMXBAUA7gsUU4qdMgorPnUoTbsslU5p0uBXt0XFH51SjQ
	44lfPh3Pg4yJFwchNTa6fYN6cMY7xf/Pe57LBXk/eT6aAXte5ke8h
X-Google-Smtp-Source: AGHT+IFty7FKqvcT4C7Q34oUTNws54WXjoXhfG6q3VK0rE1eH8IpvJ53SMpi9glnL4Jkh1DXThecgIWksBjhtG8ER20=
X-Received: by 2002:a17:907:7da7:b0:a8d:439d:5c3c with SMTP id
 a640c23a62f3a-a93c48efd0fmr608359466b.8.1727511161494; Sat, 28 Sep 2024
 01:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928021620.8369-1-kanchana.p.sridhar@intel.com>
 <20240928021620.8369-6-kanchana.p.sridhar@intel.com> <CAJD7tka0qyRWhgHrC9p1ytfDKVPr9bBTFCYy7HC4DZ-Ovfu7VQ@mail.gmail.com>
 <ZveLM6EINpVWwJZD@casper.infradead.org>
In-Reply-To: <ZveLM6EINpVWwJZD@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Sat, 28 Sep 2024 01:12:04 -0700
Message-ID: <CAJD7tkZJkeoTBfs7aEphR_cg728cB0o9+_Uwq=w_=iCzCc1=4g@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] mm: zswap: Modify zswap_stored_pages to be atomic_long_t.
To: Matthew Wilcox <willy@infradead.org>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, usamaarif642@gmail.com, shakeel.butt@linux.dev, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 9:51=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Sep 27, 2024 at 07:57:49PM -0700, Yosry Ahmed wrote:
> > On Fri, Sep 27, 2024 at 7:16=E2=80=AFPM Kanchana P Sridhar
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > > For zswap_store() to support large folios, we need to be able to do
> > > a batch update of zswap_stored_pages upon successful store of all pag=
es
> > > in the folio. For this, we need to add folio_nr_pages(), which return=
s
> > > a long, to zswap_stored_pages.
> >
> > Do we really need this? A lot of places in the kernel assign the
> > result of folio_nr_pages() to an int (thp_nr_pages(),
> > split_huge_pages_all(), etc). I don't think we need to worry about
> > folio_nr_pages() exceeding INT_MAX for a while.
>
> You'd be surprised.  Let's assume we add support for PUD-sized pages
> (personally I think this is too large to make sense, but some people can'=
t
> be told).  On arm64, we can have a 64kB page size, so that's 13 bits per
> level for a total of 2^26 pages per PUD.  That feels uncomfortable close
> to 2^32 to me.
>
> Anywhere you've found that's using an int to store folio_nr_pages() is
> somewhere we should probably switch to long.

There are a lot of them: rmap.c, shmem.c, khugepaged.c, etc.

> And this, btw, is why I've
> moved from using an int to store folio_size() to using size_t.  A PMD is
> already 512MB (with a 64KB page size), and so a PUD will be 4TB.

Thanks for pointing this out. I assumed the presence of many places
using int to store folio_nr_pages() means that it's a general
assumption.

Also, if we think it's possible that a single folio size may approach
INT_MAX, then we are in bigger trouble for zswap_stored_pages, because
that's the total number of pages stored in zswap on the entire system.
That's much more likely to exceed INT_MAX than a single folio.

>
> thp_nr_pages() is not a good example.  I'll be happy when we kill it;
> we're actually almost there.

Yeah I can only see 2 callers.

