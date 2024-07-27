Return-Path: <linux-kernel+bounces-264223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E2893E05B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8BB281DC1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F594185E50;
	Sat, 27 Jul 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d1FzqFtg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158AC538A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722101644; cv=none; b=kUIRI0gE9nYP98CaLFrIGPUrt8Boviqx0vUfPg+3EP0Soo9ddOyhVX5iT32wk5jT2Dl0bbRZwOrVx8htmzQurorIqMl81a2FIskCdfImD22a8+LFsuIWQshZwZ6YzSmC3/NZcnq/pBvR3wcX5yBkprPzyfAFQ4NCA8+GnhokeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722101644; c=relaxed/simple;
	bh=xlVYA4FIasX2gV3GXStceke29uE+c5IdOd0It3o2Y3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGnf2DZX1gIEF1kvxm6bCcHuG5OHVgVjI8mqTxauWH8cLa43lBeEjRm/qGoVa2mFN8Vtp+aOjUGTWK/I1lI3glZFSHXt785cgO3o+z/kAXEuUDbr56/Svhxe3TvKEgqrkEtQ+SLu7wsYZkfphGXsCivXgLQ5KuRduKQehRwt8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d1FzqFtg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HS0ksnlZL3s+zWv6Trq4NFtCnIvD2qUV6Wcs5vzw3ZU=; b=d1FzqFtgfXrP5irXlBrEXa1BIA
	nrWpyGGNox3Y89PGNJn3SEM+ZBNR4umAz2dqT6IUYndgXGVACQuPZil0rRg070ZPPtxvEw98FHbqh
	Vk2TJsJFUPouhKFuDdV0KI4fIWKln2kK/cTVZnHzscD8lhL2U/a4zRCBWnpLsIrOR23QlzgjUvzKH
	jcIlAGqXYLY1lnuZk8YR7RIkDHS69i5wrMyQWuIsq5n9Itf2/eIv6WpxgL7nL+jvKlbUg+yPyhnrz
	sNpGeVDYycFu7OBSnVVyddwVrVgTcRKFn2zGWGLbr++LAjQeouRTL4Zqub1clG5XWYT0esIeKdQNa
	F70V5g9A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXlIn-0000000BYCn-1k0c;
	Sat, 27 Jul 2024 17:33:53 +0000
Date: Sat, 27 Jul 2024 18:33:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	David Laight <David.Laight@aculab.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@kernel.org>,
	"Jason@zx2c4.com" <Jason@zx2c4.com>,
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <ZqUvgRJZQUmyHpna@casper.infradead.org>
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local>
 <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>

On Fri, Jul 26, 2024 at 09:13:11PM -0700, Linus Torvalds wrote:
> but while that is certainly an impressive 82kB line, we have some good
> company in code VM header files, and I've also seen
> 
>   Longest line is include/linux/page-flags.h:507 (27kB)
>      'static inline __attribute__((__gnu_inline__))
> __attribute__((__unused__)) __attribute__((no_instrume...'
> 
> because the expansion from
> 
>     __PAGEFLAG(Locked, locked, PF_NO_TAIL)
> 
> does indeed generate some impressive stuff. It's all the functions for
> the locked bit handling generated from one line.

In the specific case of PageLocked, that can hopefully go away fairly
soon.  We only have 24 instances left in tree and five of those are
comments/docs.  The ones in fs (btrfs, crypto, f2fs, ocfs2 and pipe)
should be converted to folio soon.

Mostly they're just detritus.  We could probably remove the PageLocked
definition in the next merge window if we actually care.


But I have been wondering whether the way we define all the functions
around page/folio flags is sensible.  Every file which includes
page-flags.h (... which is most of them ...) regenerates the macros.
You can't grep for the definition of folio_test_locked().  There's
nowhere to put kernel-doc for folio_test_locked().

Would we be better off generating page-flags-generated.h from a more
compact definition file somewhere, rather than using the C preprocessor?

