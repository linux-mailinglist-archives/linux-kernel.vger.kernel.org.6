Return-Path: <linux-kernel+bounces-417645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67B49D570C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3406DB21CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ADA13A268;
	Fri, 22 Nov 2024 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jkltob6i"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166BA31;
	Fri, 22 Nov 2024 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732238661; cv=none; b=a5KZ993oc+fO2VC5SWhTMb3/iXEREWE2c5CsCQWwvbJcXiikQ3YHOhwglXy7fXhYofephx5OgwljTJxWteQH8lW7SWRvEDHzBYJTO2LulsSs3MdLzeHSykIS+xoNCxFeAoo+zrJ1zOGGXvq5sZXBGmXkPJ2TR+MA72y9M7evobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732238661; c=relaxed/simple;
	bh=kOg+AXkIwrGc0jcfu6liT0X/5A6Luw9dbp85HX0Nef8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfI0uF89EVw4ixp89sQYsvK1DMonT/U9WAlEQVBoJv5aU902SDeyZLmZihOuB095gIGQkhHtVbqzzyfZ9abJ1JMpdJ1BFlegDLNhHZdmt8e2p4vj1BVwbUcsiD35sizW5JAr7AVTfguRs+Y86OXNpE0bsWw0zt3z08K5SNw6jcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jkltob6i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L8dwXGS0ROHzKBrOTtEiehHoZ7cBRiaYIE7gMz7q2dU=; b=jkltob6i+2RvV1xOh4YM42YZRE
	8ql5OwLKBumi+6DtUFAk33tD+s3wfCm+ahUwFmkXw2jPMuOkQEk0T4j7Ulvi2t9JCqvp3x4Rv93EM
	KVU9iA34a6XL4EalJBo3CYTngv5WsolEe503E7HyrA6fW0Dygi40hWzgi2xckHucf7/JDC3sI8Nzo
	QrwDRETxlApONVO+VRxHbuJlxApkhsxVjuz0a2QEZx6d3787GoXA3e/+Ynd02pAzhfnOD1SnTiEQp
	QwrENbJhxG6LYh5Zu75BFZtXNzX4DsXlT1X4IG2GK/JyV3QFdB0UbbA92o3l9Rb6YORV+VG34JIqG
	e5kzE2mA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEIP8-000000071C3-2FUp;
	Fri, 22 Nov 2024 01:24:14 +0000
Date: Fri, 22 Nov 2024 01:24:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
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
	airlied@redhat.com, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
Message-ID: <Zz_dPsVZOMdkLjMA@casper.infradead.org>
References: <Zz4MQO79vVFhgfJZ@tardis.local>
 <Zz4WFnyTWUDPsH4m@casper.infradead.org>
 <Zz4boXyYpdx4q35I@tardis.local>
 <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>
 <Zz59qgqKruqnouTl@tardis.local>
 <650846e4-b6a0-472d-a14e-4357d20faadb@gmail.com>
 <Zz-FtcjNm0TVH5v9@tardis.local>
 <Zz-GHlkhrz35w2YN@tardis.local>
 <Zz-ts0s3jHsNP73f@casper.infradead.org>
 <0195fb77-c55a-40d5-8fe2-5844158f4f63@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0195fb77-c55a-40d5-8fe2-5844158f4f63@gmail.com>

On Fri, Nov 22, 2024 at 01:18:28AM +0200, Abdiel Janulgue wrote:
> We need an abstraction of struct page to construct a scatterlist which is
> needed for an internal firmware structure. Now most of pages needed there
> come from vmalloc_to_page() which, unlike the current rust Page abstraction,
> not allocated on demand but is an existing mapping.
> 
> Hope that clears things up!

That's very helpful!  So the lifetime of the scatterllist must not
outlive the lifetime of the vmalloc allocation.  That means you can call
kmap_local_page() on the page in the scatterlist without worrying about
the refcount of the struct page.  BTW, you can't call page_address() on
vmalloc memory because vmalloc can allocate pages from HIGHMEM.  Unless
you're willing to disable support for 32-bit systems with highmem ...

