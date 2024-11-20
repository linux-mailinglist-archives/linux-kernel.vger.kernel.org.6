Return-Path: <linux-kernel+bounces-415220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01859D3307
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB961F23889
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBC3156C69;
	Wed, 20 Nov 2024 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="seo2NImb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C93F9C5;
	Wed, 20 Nov 2024 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732078628; cv=none; b=fh+KkiiW/sTTiG1it4j+DpZdyZc1L7IWwtpakIPJVlw08iqpQnhga1KKW4TO6U7+2F/B2ELBx7r85s1rGN/0aXfrFBe60+HvB240L8q8dyt3jmilwOkE6cvzOQ3ik96PDGy4zXbkf+LvBv0VMPJCfzeyvxqbHAuSgNfqTWO7YWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732078628; c=relaxed/simple;
	bh=in9rf0KMkbvGfFzwgRKs4N5iiZNsbwTbxmK2iORJtDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krPrBqbauaN3Zm8N7lVk+Uuajq3C1UsVLSkFEE4ij94iY7sPpK5E9ntqLNkc0wum7jBADouBlwZExwjnAYkjLhKmJ8LcB+5e4dX9maHsXhmkK9RyvtFmhJvlA2lItImewlp+b72ezlBciZz/tjqxR8sN2PnHWOsPjcBwEdQJmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=seo2NImb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I/P/E1mTF7l9r/I4oklTVyXLlBinMJv55qNUKb4iWuk=; b=seo2NImbxcoGX+KPaqpLm0bG8+
	vr4+60f/7XdGWo4oVr90gmbg6Oo08eBACGBx6VqY3JvoGXpZGOXcKtgpHWotI7Kj1QS6RcA+UBBU4
	+POSQd0+qVHYw3jiXk5wIrZ29JyT6jHBSMSIZi+dc5OPIm+kexGu8Eb6TcS8wthF6GAojmG/zVqsY
	TJHk/Z1FaT7EeL8OJCzBZI/7EqopxbOkPA51IwCvyNR74/Y/9pemqP+HtRWCqLceYrQ+A6N0kph4c
	c+rC+cLNsIe7heVneM/VObsBnts5ikDErerl/tky89iRc09kRX15XDempZPPGt2djVmkLv9KExWqq
	P4FdK3tw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDclx-00000004rno-3GHX;
	Wed, 20 Nov 2024 04:57:01 +0000
Date: Wed, 20 Nov 2024 04:57:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	airlied@redhat.com
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
Message-ID: <Zz1sHZLruF5sv7JT@casper.infradead.org>
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119112408.779243-1-abdiel.janulgue@gmail.com>

On Tue, Nov 19, 2024 at 01:24:01PM +0200, Abdiel Janulgue wrote:
> This series aims to add support for pages that are not constructed by an
> instance of the rust Page abstraction, for example those returned by
> vmalloc_to_page() or virt_to_page().
> 
> Changes sinve v3:
> - Use the struct page's reference count to decide when to free the
>   allocation (Alice Ryhl, Boqun Feng).

Bleh, this is going to be "exciting".  We're in the middle of a multi-year
project to remove refcounts from struct page.  The lifetime of a page
will be controlled by the memdesc that it belongs to.  Some of those
memdescs will have refcounts, but others will not.

We don't have a fully formed destination yet, so I can't give you a
definite answer to a lot of questions.  Obviously I don't want to hold
up the Rust project in any way, but I need to know that what we're trying
to do will be expressible in Rust.

Can we avoid referring to a page's refcount?

