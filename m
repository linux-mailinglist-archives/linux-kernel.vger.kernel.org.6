Return-Path: <linux-kernel+bounces-179201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694AC8C5CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9852D1C21AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B6181BBE;
	Tue, 14 May 2024 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P5UIieNZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58263180A77
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722926; cv=none; b=reXVKDvrUZ+783D9Qb5cpwVROqyFg9XpDo+hkGnTw9ZUvJuJepbXayZdiOpQbgHjO3ZqRDy092k+I1ycDfYWOww3XT59lLhAOmEDu5lPRynj21Mh09zg2y1HXNVcg2rNsAnBIVxlmkbXHgU+TvWWnUp+QPNcWKjx9YhImkp7DMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722926; c=relaxed/simple;
	bh=x41lt0y2/QQyRA72DsKY8/rDqXNocvlTMgmU6V5lH0I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u4xzqqyrYkbD3wJxXbdb+hidXZ/eKB/3pxLOxkvNEfheXngkODE1HPnnQE7cRA9+/6aZ8YDb/XVUmjMdx/lcdl5K++VL0Yj9JAHaSkgegLc/30hVWZ331RwIdK3jLZRwSZ6H0yGcEegBsrMtxoSdaDBawbe0WXS9H8L57YjNwzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P5UIieNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF82EC2BD10;
	Tue, 14 May 2024 21:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715722926;
	bh=x41lt0y2/QQyRA72DsKY8/rDqXNocvlTMgmU6V5lH0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P5UIieNZ0IdpOVfPq5FxAu27iLPTufnjnFL1dLaAqkJ5lR/DYq1p6bfBWt8BHIQE9
	 sSaZEkF6zWQ5F85/BD1R6J6tYPT0fmeTg5oG/UoG/ptjPj79piaR69ajMN1ZkF/s2Z
	 xsWKJgYelqGa2xrkO8vGfVg0wQgYl8JqT0RpvEhI=
Date: Tue, 14 May 2024 14:42:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yang Shi <shy828301@gmail.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com,
 xuyu@linux.alibaba.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved
Message-Id: <20240514144204.88790f125b0275ef68acf6de@linux-foundation.org>
In-Reply-To: <CAHbLzkq+NBjwjSvU1fQe56nLf5mmGp65TH8hDpb66EFLENctKA@mail.gmail.com>
References: <20240511035435.1477004-1-linmiaohe@huawei.com>
	<20240514141439.55fba39c81c1af55c9a100e1@linux-foundation.org>
	<CAHbLzkq+NBjwjSvU1fQe56nLf5mmGp65TH8hDpb66EFLENctKA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 14 May 2024 15:28:12 -0600 Yang Shi <shy828301@gmail.com> wrote:

> On Tue, May 14, 2024 at 3:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Sat, 11 May 2024 11:54:35 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> >
> > > When I did memory failure tests recently, below panic occurs:
> > >
> > >  kernel BUG at include/linux/mm.h:1135!
> > >  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > >  CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-dirty #14
> > >
> > > ...
> > >
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -208,6 +208,7 @@ static bool get_huge_zero_page(void)
> > >               __free_pages(zero_page, compound_order(zero_page));
> > >               goto retry;
> > >       }
> > > +     __SetPageReserved(zero_page);
> > >       WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
> > >
> > >       /* We take additional reference here. It will be put back by shrinker */
> > > @@ -260,6 +261,7 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
> > >               struct page *zero_page = xchg(&huge_zero_page, NULL);
> > >               BUG_ON(zero_page == NULL);
> > >               WRITE_ONCE(huge_zero_pfn, ~0UL);
> > > +             __ClearPageReserved(zero_page);
> > >               __free_pages(zero_page, compound_order(zero_page));
> > >               return HPAGE_PMD_NR;
> > >       }
> >
> > This causes a bit of a mess when staged ahead of mm-stable.  So to
> > avoid disruption I staged it behind mm-stable.  This means that when
> > the -stable maintainers try to merge it, they will ask for a fixed up
> > version for older kernels so you can please just send them this
> > version.
> 
> Can you please drop this from mm-unstable since both I and David
> nack'ed a similar patch in another thread.
> https://lore.kernel.org/linux-mm/20240511032801.1295023-1-linmiaohe@huawei.com/

That appears to link to the incorrect email thread?

