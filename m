Return-Path: <linux-kernel+bounces-218606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E862F90C280
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870AC1C211BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709EB33C9;
	Tue, 18 Jun 2024 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kte8CN72"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE61EA8D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681506; cv=none; b=Ak9Gqghs386kTPURG5iTw2Ha6dWSbDMOVpIjW+CUfNJikqlopz7TuMcQ5xHpSZXbl0UAyQJ+91C2vnqBFl3tylxjrLo3eq2ovULQZtZ9dQ8ydKVtGX0Mcy006Gpic4Oq0JDaBbFgBSoZLo9von/MtebjZUqq6aSj341vMqn2oeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681506; c=relaxed/simple;
	bh=+91YChcmT78DkkQdESwdBoVq16V3YevURpScs6fmxNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9+QbLsdoVOVP3OlG8HbHUHIpcCBZiLn2Ddnw1rTqvZMLx/IMsRimcKRLNQggn9AAEm6ZyhrHlLvCKZIzSRpmK4RcyMREbYRY09LQB0+okPN4ENWDRZjY/WRfAObK7VusrsAE0mqU2YW8gMVmBfezmfejPyiViTQ+GhEJvuXYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kte8CN72; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/MN1Hl8sdbddlbB+6TTRZym24LsOWb8o0B+8s+1qKtw=; b=kte8CN72VMNP+uPsvf9GTU44Hf
	oEorvy+eOGFCKaIdrf3uEos/NTWrU5px1G9pmR/gn34Pw17a7s0Thb7G1T/kXltSl4GVDYpsLn1vz
	vZDhR7uiwevR2TG0ivrCxMA+UJBzA9q5/ZfDdV59gaANTFWcJEn2rPqLKXdwx0ghTwJFOiZb3foiJ
	Rbv4b8NaE6R5IfcpE6BON3FdDRijObJE/3Bwx8LzzHn/LACJH0Xqj7Z3vCjd5D97RPlN0Z7ShIWJK
	L9wMNN53sLgYMGH3NyQDcpwdw9sq+y7X31T5ERwz1a+N3VAv09pGyRaxuxQ4Ql9f9dnn0/6ECFL/W
	vyopYPFg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJPZJ-00000002jdv-3QF1;
	Tue, 18 Jun 2024 03:31:37 +0000
Date: Tue, 18 Jun 2024 04:31:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [PATCH] mm: fix hard lockup in __split_huge_page
Message-ID: <ZnD_mcxk_PCyWNmQ@casper.infradead.org>
References: <20240618020926.1911903-1-zhaoyang.huang@unisoc.com>
 <ZnD8qYvpyhYtWeHd@casper.infradead.org>
 <CAGWkznG2Ts0khArZ_X5EYKG7n9=HmcO8d16KVUZ+uQffEc3vrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznG2Ts0khArZ_X5EYKG7n9=HmcO8d16KVUZ+uQffEc3vrw@mail.gmail.com>

On Tue, Jun 18, 2024 at 11:27:12AM +0800, Zhaoyang Huang wrote:
> On Tue, Jun 18, 2024 at 11:19 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Jun 18, 2024 at 10:09:26AM +0800, zhaoyang.huang wrote:
> > > Hard lockup[2] is reported which should be caused by recursive
> > > lock contention of lruvec->lru_lock[1] within __split_huge_page.
> > >
> > > [1]
> > > static void __split_huge_page(struct page *page, struct list_head *list,
> > >                 pgoff_t end, unsigned int new_order)
> > > {
> > >         /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> > > //1st lock here
> > >         lruvec = folio_lruvec_lock(folio);
> > >
> > >         for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
> > >                 __split_huge_page_tail(folio, i, lruvec, list, new_order);
> > >                 /* Some pages can be beyond EOF: drop them from page cache */
> > >                 if (head[i].index >= end) {
> > >                         folio_put(tail);
> > >                             __page_cache_release
> > > //2nd lock here
> > >                                folio_lruvec_relock_irqsave
> >
> > Why doesn't lockdep catch this?
> It is reported by a regression test of the fix patch which aims at the
> find_get_entry livelock issue as below. I don't know the details of
> the kernel configuration.
> 
> https://lore.kernel.org/linux-mm/5f989315-e380-46aa-80d1-ce8608889e5f@marcinwanat.pl/

Go away.

