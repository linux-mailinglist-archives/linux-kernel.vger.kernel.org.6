Return-Path: <linux-kernel+bounces-227808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15EF9156BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2B2284013
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23A71A01C6;
	Mon, 24 Jun 2024 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eja0Yu4X"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1D1A01C1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255251; cv=none; b=SazQ1wkBOEFJFh8mf0NDkEWoRakYRR0MRX/DlPorM3h62vUhAjlry3l0X2t45sS7QWU6lCGnwGoCH3SvYhqm1wFa+q+Rxzsb9lx8t3VptX9IxoLQdslj+Lr2XnpytlzgF2zsaGRb0VsdW9idO9XZNlZcaoOfYuRIQ/ABhS/N7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255251; c=relaxed/simple;
	bh=JITYgpOr9aslHmnHx9NrvwoZeu+k4ldEze9CbONSH20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxttIskr66DaEiS1FVBcQklq4Sqrg9gCGRHOc1lQswpPyAuNyeZUEfIJHNY/useIMFBbpBbDjbd07nCcrc557CjkUdNtzLCEOjU69+C4EGtQf/sMg843/eOjbWacf3eN9zqTD0xXvDzR8SCDsNYbiul9LzeFysNjMtCJYV8SQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eja0Yu4X; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cdf9f934fso2209649e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719255247; x=1719860047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JITYgpOr9aslHmnHx9NrvwoZeu+k4ldEze9CbONSH20=;
        b=eja0Yu4XvaFR2UVLG24rMr3SvhUj6zQMaeUIF+4LHX6JrJhViXyKxGHNzx2y/dDffQ
         a4NVHW7z+PbVAajMlWJYHDGYb+EQLKL3/rzqYqVCFrOwGo3XWSSkNY229R1Pg8ZREDxt
         rqhSz3M5cm5ifI/7233X1xLeYWETmpMYkS575YIk5nuiHKsYw68Gx+a95oXBJpDQX0LF
         1zL1wXCobCXDZEKUrZMx5Sg7qG12WXnea7SCgLD/68e+tBGNZYlnh/XrjjpMmuGBQoW4
         YC/5fWBDPy71dUXZoIumgGWXQPJYV+hMI4YcQezxYGA7f7PCk7iav4UwnZx6LNGuwWQf
         qU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719255247; x=1719860047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JITYgpOr9aslHmnHx9NrvwoZeu+k4ldEze9CbONSH20=;
        b=Wa/xnXBs/ncRqmgnSZugogy4zRhyeBvbON+kY7OCJUQo1DI8ttnLWS2J5fqqTx6Ya6
         tYOYpaSh+8POGzfc9eUGVROuu4EwlKvsa38TPwNyzlCRSnKkykRkAFz1frMgcrHg4rfx
         ztZP8HWjbcjHaVuk/6uga25RmpEAgAIHlvmHfYQUatL2ff7NuS42TNhrErv38hYpDWy2
         8LaTcok/N3dfYqfta19WCpgu/45X0AR88Te1ZF3S9xqlC/ivLhVe14uHjNSstSmRH+88
         obHRCGJynhIU0aD+hb68CDbNrEb/31MUEyQnDHL/xR3xAe8EX/YA1xFmo7qxVjbqRGlQ
         l2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6LuNnsnELxMXcVVjN8SN2SqreW4FzoVFZY42OsIVb6imS9AD8aodTWkJ1i/wJ3zRPvys5Zq8gTEENUPOGB95CUxt96IMfY9ojU8xb
X-Gm-Message-State: AOJu0YzvMrLNAbJMLFEuxGoXYsZ1Ur0Ya22hq13qA519q5smWpjuunQX
	FIUdmHaX5c3j3riQTXYceuC22KK+34uZ1sSJsTODTiaMNRzOnndM1OXdWGXv06qEswK3O5joAzZ
	kyrj1wFhoznLvcqRa6yz1aj3KDhtNUCs0k6Fl
X-Google-Smtp-Source: AGHT+IHN+UZEsY4/F0d/hc9WcI9bVuZWn15n0XvSIxPi4V2oZ1zThrKVoWzn+Cxvu/DteI9wNCqWv1/lFdtTFzA3stw=
X-Received: by 2002:a05:6512:2083:b0:52c:e040:7d9 with SMTP id
 2adb3069b0e04-52ce0680398mr3572378e87.59.1719255246629; Mon, 24 Jun 2024
 11:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406241651.963e3e78-oliver.sang@intel.com> <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org>
In-Reply-To: <Znm74wW3xARhR2qN@casper.infradead.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 11:53:30 -0700
Message-ID: <CAJD7tkbF9NwKa4q5J0xq1oG6EkTDLz8UcbekSfP+DYfoDSqRhQ@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 0fa2857d23: WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
To: Matthew Wilcox <willy@infradead.org>
Cc: kernel test robot <oliver.sang@intel.com>, Usama Arif <usamaarif642@gmail.com>, 
	oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:33=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Jun 24, 2024 at 05:05:56AM -0700, Yosry Ahmed wrote:
> > On Mon, Jun 24, 2024 at 1:49=E2=80=AFAM kernel test robot <oliver.sang@=
intel.com> wrote:
> > > kernel test robot noticed "WARNING:at_mm/page_alloc.c:#__alloc_pages_=
noprof" on:
> > >
> > > commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero pag=
es to be swapped out in a bitmap")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mast=
er
> >
> > This is coming from WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp), and
> > is triggered by the new bitmap_zalloc() call in the swapon path. For a
> > sufficiently large swapfile, bitmap_zalloc() (which uses kmalloc()
> > under the hood) cannot be used to allocate the bitmap.
>
> Do we need to use a bitmap?
>
> We could place a special entry in the swapcache instead (there's
> XA_ZERO_ENTRY already defined, and if we need a different entry that's
> not XA_ZERO_ENTRY, there's room for a few hundred more special entries).

After a page is swapped out during reclaim, __remove_mapping() will
call __delete_from_swap_cache() to replace the swap cache entry with a
shadow entry (which is an xa_value).

So I believe we cannot use a special xarray value without making
fundamental changes. We can, perhaps, try to pack an extra bit in the
shadow entry. In this case, we will need to change the swapin code to
check for this magic bit when looking up a folio in the swap cache,
and extra synchronization to make sure concurrent lookups do not
allocate and zero separate folios.

IOW, I think it's possible but probably with more complexity, and
perhaps not worth it.

