Return-Path: <linux-kernel+bounces-415174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0415D9D324C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA85B222D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 02:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B13C47B;
	Wed, 20 Nov 2024 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U/ZRvCGO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F320B22
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732070727; cv=none; b=Wp/QW/jEXZF9DlUUu5iWRF23om7xTNz5r59Txl3RswdyeuEnaPoxEfQdAfDjGYg34UMAeSH3WtHytThuosy/gZ0Fu7WXZ92lOWHTO2Q2l0+DCJvu4ZIewCI5AKkRKMYoRcfaLypFpUkHrbQ12VC3yk55XlhbpHymQ6X72huc6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732070727; c=relaxed/simple;
	bh=YbDHL9FPP4Phk36bmR6yhe56OMyqr1qPt1bBYp3j7U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv2wxNaYOn2A/zmeJXP99r7vL2Td5YNk+/u3T6eXLSSD1mw6RiK9F0HTvkdroI6ZUmNR/qbTWnUBIAj14NmXACnFdMn7JGZbAVa0sl+B0Zoa1RX4C/ciJIU6ZonGxgweB/Xze/R0AfmmiXUDoLaNqbvYu8ffOPi9WOrm/3j4MSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U/ZRvCGO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V5PH0hbl9Yb9iMWpTd7os3cL3Qh/tgBO9RrS13b2+qA=; b=U/ZRvCGOSRpBKbQNEcIdr+ZMiA
	5mM+D289G9dHNOowlaUZ6IV0IO6uMpR9VggV1ur0OxTaI4NBdRwBxcJDvvwBhU3hh9MAeGfG3Oxth
	W134XQzJr97ajzhMtBmDj9VN+Q7xPZfz43bsqHyMNgG/0UrFCnlk9N3uVnuEYFqZnJjajpw5C8/Hf
	FAaMgFCQQ1Tl+pd5YmjLXdWX4Rz9lllBWo8v6uYahaXXkZ8ltGIV9EjomF5MdV1PKlWizqp+NWSe4
	SHFtQBtG7mWVCymfIO++3A+T7bxQcfXbOxrrlgk4Gw5+oWWJ9DovyYvMDdPe3CDqRyxTjJcur0dNZ
	tutv+MWw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDaiX-00000004m5b-2S6s;
	Wed, 20 Nov 2024 02:45:21 +0000
Date: Wed, 20 Nov 2024 02:45:21 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v4 4/9] binder: remove struct binder_lru_page
Message-ID: <Zz1NQXgk96vqHHFr@casper.infradead.org>
References: <20241119183250.3497547-1-cmllamas@google.com>
 <20241119183250.3497547-5-cmllamas@google.com>
 <ZzziucEm3np6e7a0@casper.infradead.org>
 <ZzzyBwWIDy6Z2W4k@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzzyBwWIDy6Z2W4k@google.com>

On Tue, Nov 19, 2024 at 08:16:07PM +0000, Carlos Llamas wrote:
> If you are planning to keep page->private, I think we can just hang our
> binder items in there. Something like...
> 
> 	struct binder_page_items *bp;
> 	struct page *p;
> 
> 	bp = kzalloc(sizeof(*bp), GFP_KERNEL);
> 	bp->alloc = alloc;
> 	INIT_LIST_HEAD(&bp->lru);
> 	bp->index = index;
> 
> 	p = alloc_page(...);
> 	p->private = (unsigned long)bp;
> 
> This would be absolutely fine in binder. Is this what you had in mind
> for current users of page->lru?

Something like that, yes.  Although you wouldn't even need to use
page->private for it; you'd be able to use page->memdesc directly,
and then not be in the way of shrinking to 8 bytes.

