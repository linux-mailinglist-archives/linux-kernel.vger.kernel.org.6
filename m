Return-Path: <linux-kernel+bounces-417521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981019D551C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFFF282F54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966281DD0F6;
	Thu, 21 Nov 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kXfaX916"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306021DC05D;
	Thu, 21 Nov 2024 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226491; cv=none; b=Z9nyh5umpJw+jAAutAF8YmjVV1in7TQ104eePfguQFGuxDxJ7mUKgWHORZ09z1OThzkyX9xZ3zKYcdjjOEWfoWK77RMXNbkNZTie8nrLwspWv4fkSxyj4vyWEb2zDIsgAhfw0ylWBckmS2DBb2r9v+aZQJfpoFx0b86Pb/3rcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226491; c=relaxed/simple;
	bh=pqEyDF5LLO1VwH1MXzcryDaT3vlXiFcbp4M1sDFbPsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2bcK2xuiuOQF/mWrBro7h6Ukn4Vh/HNToW3UgkTyLOMFUjDYPdkZo3uqgr0kc6T0RZVr3Is+W+IZrGIeg8B17zZXgrWF+HmUz+CLpFOL1yggfeJM3PNayHTLPYw90S7kioA44C4XYRTrdCTUxc2iK7fn0CD/CgVuLq7kAei8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kXfaX916; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OElOW/ym0iS6wv612P7RpAETtR98Co4NnCdEquW2kPI=; b=kXfaX916eTmUA8NIJkVhCtVOj9
	6/ZNIImqz2m3g+qE4BcfIGRDfrlySGNVRElRXrnE+/ONgXWXilGEVrMOcFnIyBMd9ClOfVocOQmQL
	eS9U6riV8LMWsruPnyXth28UhQAl1tE25R3UghuB43etl8byhT3QIlQ4RfkGCe2aXcMcafDILpkk0
	Ia4q5UTtAGCON/jH9YRRO6A+2sdgVymtGnT9V9z5rovnwMOkjqY/v2U2ao1gtrcKmwa7GVSot6qIB
	3GdMIWds0oIqKblJ5iicpvC06OQmnwbuq1hSgOWUEyVJTuBh2MdTJoTZ1g65+s3NnCKBNY3MoQMqh
	Qewqq69A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEFEp-00000006re3-21QZ;
	Thu, 21 Nov 2024 22:01:23 +0000
Date: Thu, 21 Nov 2024 22:01:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	airlied@redhat.com, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
Message-ID: <Zz-ts0s3jHsNP73f@casper.infradead.org>
References: <Zz1sHZLruF5sv7JT@casper.infradead.org>
 <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local>
 <Zz4WFnyTWUDPsH4m@casper.infradead.org>
 <Zz4boXyYpdx4q35I@tardis.local>
 <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>
 <Zz59qgqKruqnouTl@tardis.local>
 <650846e4-b6a0-472d-a14e-4357d20faadb@gmail.com>
 <Zz-FtcjNm0TVH5v9@tardis.local>
 <Zz-GHlkhrz35w2YN@tardis.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz-GHlkhrz35w2YN@tardis.local>

On Thu, Nov 21, 2024 at 11:12:30AM -0800, Boqun Feng wrote:
> On Thu, Nov 21, 2024 at 11:30:13AM +0200, Abdiel Janulgue wrote:
> > Hi Boqun, Matthew:
> > 
> > On 21/11/2024 02:24, Boqun Feng wrote:
> > > > > So if I understand correctly, what Abdiel needs here is a way to convert
> > > > > a virtual address to the corresponding page, would it make sense to just
> > > > > use folio in this case? Abdiel, what's the operation you are going to
> > > > > call on the page you get?
> > > > 
> > > > Yes that's basically it. The goal here is represent those existing struct
> > > > page within this rust Page abstraction but at the same time to avoid taking
> > > > over its ownership.
> > > > 
> > > > Boqun, Alice, should we reconsider Ownable and Owned trait again? :)
> > > > 
> > > 
> > > Could you use folio in your case? If so, we can provide a simple binding
> > > for folio which should be `AlwaysRefcounted`, and re-investigate how
> > > page should be wrapped.
> > > 
> > 
> > I'm not sure. Is there a way to get the struct folio from a vmalloc'd
> > address, e.g vmalloc_to_folio()?
> > 
> 
> I think you can use page_folio(vmalloc_to_page(..)) to get the folio,
> but one thing to notice is that folio is guaranteed to be a non-tail
> page, so if you want to do something later for the particular page (if
> it's a tail page), you will need to know the offset of the that page in
> folio. You can do something like below:

This is one of those things which will work today, but will stop
working in the future, and anyway will only appear to work for some
users.

For example, both vmalloc and slab allocations do not use the refcount
on the struct page for anything.  eg this will be a UAF (please excuse
me writing in C):

	char *a = kmalloc(256, GFP_KERNEL);
	struct page *page = get_page(virt_to_page(a));
	char *b = page_address(page) + offset_in_page(a);
	// a and b will now have the same bit pattern
	kfree(a);
	*b = 1;

Once you've called kfree(), slab is entitled to hand that memory out
to any other user of kmalloc().  This might actually work to protect
vmalloc() memory from going away under you, but I intend to change
vmalloc so that it won't work (nothing to do with this patch series,
rather an approach to make vmalloc more efficient).

One reason you're confused today is that we have a temporary ambiguity
around what "folio" actually means.  The original definition (ie mine) was
simply that it was a non-tail page.  We're moving towards the definition
Johannes wanted, which is that it's only the memdesc for anonymous &
file-backed memory [1].  So while vmalloc_to_folio() makes sense under
the original definition, it's an absurdity under the new definition.

So, Abdiel, why are you trying to add this?  What are you actually
trying to accomplish in terms of "I am writing a device driver for XXX
and I need to ..."?  You've been very evasive up to now.

[1] Actually Johannes wants to split them apart even further so that
anon & file memory have different types, and we may yet get there.
One step at a time.

