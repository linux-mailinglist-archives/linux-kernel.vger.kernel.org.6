Return-Path: <linux-kernel+bounces-238650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2B6924D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7A1284D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6BF4C6C;
	Wed,  3 Jul 2024 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I/+f4ipY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A384683
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719972145; cv=none; b=jHTKhDyNKhqKmHHvZm9JT/Ja6A0I2EdRC251NS7nqKaugURqKif7nHWLNKd56FIPYma1tZZrHAhWaEf8WFmMl1WBJdUK6tCFgpro430rbEveh9uNDtEubpSpXcdDofii/Qi3dTwrwV+sDXAAgnjvUc05ZsCWmpXVyeYGJ7ptLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719972145; c=relaxed/simple;
	bh=QfoIjRTn+ka2CQBVEdytcNNbpnUTel10PUxBa8/LBC8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MsNyJMpHuOvYAkjrHPGVa/b2vDqho0WNpg1tQe27NkOLsJBUK8nc/OoGRGnApp2C7egr8Nvt+3IBu7WP7tormow9B0RTJzhwH49qR/un7R5SiM42urRdeOWZYYDU5mcU5uY9fV+VqZVYpkkJlW7tCPDmAmIXDz3Ll2NHF6ocuaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I/+f4ipY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDACBC116B1;
	Wed,  3 Jul 2024 02:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719972145;
	bh=QfoIjRTn+ka2CQBVEdytcNNbpnUTel10PUxBa8/LBC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I/+f4ipYS7WoxO43yMqiWlwu3V3hgu2UIl6NOWmGnbai7wVyb7QXGe9mLtzYpH5U8
	 oYorKoy4dDax3OQt45+2sWuCfC8j8ptBDiqVkPmpdACTJO2rLAIVkWeZf5mFhbTOcN
	 N7zRMVFrruzjy3eNKzyG0Wc3uOznuESFycfp3Hfk=
Date: Tue, 2 Jul 2024 19:02:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, Nhat Pham
 <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, Chris Li
 <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: zswap: fix zswap_never_enabled() for
 CONFIG_ZSWAP==N
Message-Id: <20240702190224.99d97227a02bbbe4f140f845@linux-foundation.org>
In-Reply-To: <CAJD7tkYJwRF5B2-vQGkmEhgw9t20OcVbB7MNrQqvmTor8Vjptw@mail.gmail.com>
References: <20240629232231.42394-1-21cnbao@gmail.com>
	<20240701235210.5c187c85aa225292d034cafc@linux-foundation.org>
	<CAJD7tkYJwRF5B2-vQGkmEhgw9t20OcVbB7MNrQqvmTor8Vjptw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 04:58:05 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:

> > > --- a/include/linux/zswap.h
> > > +++ b/include/linux/zswap.h
> > > @@ -68,7 +68,7 @@ static inline bool zswap_is_enabled(void)
> > >
> > >  static inline bool zswap_never_enabled(void)
> > >  {
> > > -     return false;
> > > +     return true;
> > >  }
> >
> > Well, that code was as wrong as it's possible to get.
> >
> > But what effect does this have?  Seems "not much"?  Perhaps we'll
> > attempt a zswap_load() which later fails for other reasons?
> 
> Actually zswap_load() is a noop with !CONFIG_ZSWAP, so it doesn't have
> an effect there. The only effect is that with Barry's latest large
> folio swapin patches for zram, we will always fallback to order-0
> swapin, even mistakenly when !CONFIG_ZSWAP.
> 
> Basically the bug just makes Barry's in progress patches not work at all.

OK, thanks, I added this to the changelog:

The only effect of this issue is that with Barry's latest large folio
swapin patches for zram ("mm: support mTHP swap-in for zRAM-like
swapfile"), we will always fallback to order-0 swapin, even mistakenly
when !CONFIG_ZSWAP.

Basically this bug makes Barry's in progress patches not work at all.


