Return-Path: <linux-kernel+bounces-416137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24809D40B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A0B1F21DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0453E156F21;
	Wed, 20 Nov 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QPD4+th3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93AD19C543;
	Wed, 20 Nov 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732122141; cv=none; b=JTqD/Y/nMJUfWhoRb7C+dWCsoEY/7l+e19TIvOtIXAk4OW2B0BURKggifxo/BiPhyIfp0/SfIt0EoovThfh0LXs+wD4hcW9pLNsqJRBefuxrnZ97DNfCLBvuvVAox9Na8vyBX9btCPMJPdYTapv5gT7ct33LrNedWTl3hcYHQJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732122141; c=relaxed/simple;
	bh=cuZreQyOoH1OuzZFnRAMY0hUSMFFrHwTGswopfEe+Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcrodmcysoV75Iywt5hUW/kbvO9Ee5frJjxZuCtjhMiatBTOOshpKlMSPDhVFLLSwwjZoceM19mWPV7/VZ7VmqQzeo0TeNXhCas3zyS8jDUeA8dXvuLy27d0WuKpSI/EKEMXoyMNCkjNozbWeF3AgGAnFMktosJZhnJSR//HF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QPD4+th3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zYAMajNMtocU0CffdSuW1w5BhKd5VeQZLt1Tp6ZRjHg=; b=QPD4+th3XvJ/Zv02g13zjI3s5V
	L8VxOyPaPSlG1Sbd2k/rpk3aVcZ7glBSuv4nzP4vmqtVwBsm1VQEZqvTNZKOwRElx+Lv5MMyuo4Jn
	IxEUComnwuqO3SPte5+1HPPMBwlqAnCpD3P+tD7IKXRjW9Oa/84gVu3NAX6t1A/1MbMoSY5gO0ZFi
	OQMSurxwYvDAQXIn3uji2saB+6Dwk3AbBI/dUPkUFCy2Y8ZeFZV2g0dbDztpv++HDWqu4dvxmVfcQ
	7+pz8lyevbXNUba4X0fPaGbw7AI2QA6z/UJsI+2ytco/sMFMGOzu+MUI/JMpdxNmijCuV9Xu3Sg6z
	LoKpCrEA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDo5n-00000005THA-07M3;
	Wed, 20 Nov 2024 17:02:15 +0000
Date: Wed, 20 Nov 2024 17:02:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
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
	airlied@redhat.com
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
Message-ID: <Zz4WFnyTWUDPsH4m@casper.infradead.org>
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <Zz1sHZLruF5sv7JT@casper.infradead.org>
 <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zz4MQO79vVFhgfJZ@tardis.local>

On Wed, Nov 20, 2024 at 08:20:16AM -0800, Boqun Feng wrote:
> On Wed, Nov 20, 2024 at 10:10:44AM +0100, Alice Ryhl wrote:
> > On Wed, Nov 20, 2024 at 5:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Nov 19, 2024 at 01:24:01PM +0200, Abdiel Janulgue wrote:
> > > > This series aims to add support for pages that are not constructed by an
> > > > instance of the rust Page abstraction, for example those returned by
> > > > vmalloc_to_page() or virt_to_page().
> > > >
> > > > Changes sinve v3:
> > > > - Use the struct page's reference count to decide when to free the
> > > >   allocation (Alice Ryhl, Boqun Feng).
> > >
> > > Bleh, this is going to be "exciting".  We're in the middle of a multi-year
> > > project to remove refcounts from struct page.  The lifetime of a page
> > > will be controlled by the memdesc that it belongs to.  Some of those
> > > memdescs will have refcounts, but others will not.
> > >
> 
> One question: will the page that doesn't have refcounts has an exclusive
> owner? I.e. there is one owner that's responsible to free the page and
> make sure other references to the page get properly invalidated (maybe
> via RCU?)

It's up to the owner of the page how they want to manage freeing it.
They can use a refcount (folios will still have a refcount, for example),
or they can know when there are no more users of the page (eg slab knows
when all objects in a slab are freed).  RCU is a possibility, but would
be quite unusual I would think.  The model I'm looking for here is that
'page' is too low-level an object to have its own lifecycle; it's always
defined by a higher level object.

> > > We don't have a fully formed destination yet, so I can't give you a
> > > definite answer to a lot of questions.  Obviously I don't want to hold
> > > up the Rust project in any way, but I need to know that what we're trying
> > > to do will be expressible in Rust.
> > >
> > > Can we avoid referring to a page's refcount?
> > 
> > I don't think this patch needs the refcount at all, and the previous
> > version did not expose it. This came out of the advice to use put_page
> > over free_page. Does this mean that we should switch to put_page but
> > not use get_page?

Did I advise using put_page() over free_page()?  I hope I didn't say
that.  I don't see a reason why binder needs to refcount its pages (nor
use a mapcount on them), but I don't fully understand binder so maybe
it does need a refcount.

> I think the point is finding the exact lifetime model for pages, if it's
> not a simple refcounting, then what it is? Besides, we can still
> represent refcounting pages with `struct Page` and other pages with a
> different type name. So as far as I can see, this patch is OK for now.

I don't want Page to have a refcount.  If you need something with a
refcount, it needs to be called something else.

