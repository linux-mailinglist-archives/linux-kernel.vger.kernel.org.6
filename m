Return-Path: <linux-kernel+bounces-227861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3405915765
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0A01F23EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2AF1A01C9;
	Mon, 24 Jun 2024 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DfVk7ryb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EE1EB56;
	Mon, 24 Jun 2024 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258650; cv=none; b=ovtXGEB5mAK2MxVzdCW+1BAOOE5qkWDU/UCuPOQI19Q8JSs7AVDsOga1qZGb+I88lptnKEOQwzcKZ6TjG0OGsjoLbrc1CGPi4uC8q7WQUApl9tSSnwP8QG2hLaSI1rX3RkcV6j3VJDFbj/RzzzdFU/6agzi4i7SPyCJqOMqcjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258650; c=relaxed/simple;
	bh=s+NHv3ns0rqlyrer4kI3azjaudKLNVpbnW/XG1CSgKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP+Uup1xGujJSyHeQeoix9Brb0v8VzbA9mx9RhnHyeq/UJeOdgvMSgD0hLlSgol1jK9/zsfiu0M0kxAAXXbM+6o9KaLN3YkxCvfYTr/B7BlWxR75hnrYNBCOl1EqoNLhqAFDMOjKhJyLBqiwejK6fjgVFFzJX7swu7liLUryjuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DfVk7ryb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=1HOmhYkqorxtw73lg/pG0orZL1FyfjnL9NoN4K798Og=; b=DfVk7rybxn+Cc8wqcCH/+tjnW7
	WEsL9Bccp/JiwYUmuwjrkbC4Esa9isSp+GUVUE8MLHpF3hBD4q86WCPsxJPEn9yYtrxisP+41KOrD
	0yOM9UcyfkldRSGfNj4JGDoJ8whIf+BJJzqTiWLwXNCt/xQc7s87t4IDb+ZpOI3SUpmQGrMavtOFc
	GoUMoO7LEzVlh5raAjEtPBz36cSNDbkTFE6RvsypfaUK15YZJuXFl8coFVVxjgDXTcSWKY//EyPJB
	pLJuLKyOlTXP8iTkVBMW3JEVO0+xLALfBF/KQguBBoRUUtJfriJRCf7PCfFAOduR9VE91+k0Asi4D
	BCqE4Vvg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLpi9-0000000AO9F-0rfX;
	Mon, 24 Jun 2024 19:50:45 +0000
Date: Mon, 24 Jun 2024 20:50:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Usama Arif <usamaarif642@gmail.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
Message-ID: <ZnnOFSNKKMf5IpCU@casper.infradead.org>
References: <202406241651.963e3e78-oliver.sang@intel.com>
 <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <Znm74wW3xARhR2qN@casper.infradead.org>
 <CAJD7tkbF9NwKa4q5J0xq1oG6EkTDLz8UcbekSfP+DYfoDSqRhQ@mail.gmail.com>
 <ZnnBVBItTNWZE42u@casper.infradead.org>
 <CAJD7tkaC6d_RkhRhMpEeS1zTEtoQYw56J3LLdzD1aM9_qu-3BA@mail.gmail.com>
 <ZnnId18scFvE_a6K@casper.infradead.org>
 <CAJD7tkZZHxXR9cFE=ZHQOnYXakrhXg0+ScT2ExxihovSgDz7_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZZHxXR9cFE=ZHQOnYXakrhXg0+ScT2ExxihovSgDz7_g@mail.gmail.com>

On Mon, Jun 24, 2024 at 12:34:04PM -0700, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 12:26 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Jun 24, 2024 at 11:57:45AM -0700, Yosry Ahmed wrote:
> > > On Mon, Jun 24, 2024 at 11:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Jun 24, 2024 at 11:53:30AM -0700, Yosry Ahmed wrote:
> > > > > After a page is swapped out during reclaim, __remove_mapping() will
> > > > > call __delete_from_swap_cache() to replace the swap cache entry with a
> > > > > shadow entry (which is an xa_value).
> > > >
> > > > Special entries are disjoint from shadow entries.  Shadow entries have
> > > > the last two bits as 01 or 11 (are congruent to 1 or 3 modulo 4).
> > > > Special entries have values below 4096 which end in 10 (are congruent
> > > > to 2 modulo 4).
> > >
> > > You are implying that we would no longer have a shadow entry for such
> > > zero folios, because we will be storing a special entry instead.
> > > Right?
> >
> > umm ... maybe I have a misunderstanding here.
> >
> > I'm saying that there wouldn't be a _swap_ entry here because the folio
> > wouldn't be stored anywhere on the swap device.  But there could be a
> > _shadow_ entry.  Although if the page is full of zeroes, it was probably
> > never referenced and doesn't really need a shadow entry.
> 
> Is it possible to have a shadow entry AND a special entry (e.g.
> XA_ZERO_ENTRY) at the same index? This is what would be required to
> maintain the current behavior (assuming we really need the shadow
> entries for such zeroed folios).

No, just like it's not possible to have a swap entry and a shadow entry
at the same location.  You have to choose.  But the zero entry is an
alternative to the swap entry, not the shadow entry.

As I understand the swap cache, at the moment, you can have four
possible results from a lookup:

 - NULL
 - a swap entry
 - a shadow entry
 - a folio

Do I have that wrong?

