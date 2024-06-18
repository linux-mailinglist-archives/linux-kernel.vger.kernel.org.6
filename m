Return-Path: <linux-kernel+bounces-220205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2F90DE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2E81C236A4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C17176ADE;
	Tue, 18 Jun 2024 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rw5MiVuX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B29176AB2;
	Tue, 18 Jun 2024 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745267; cv=none; b=uWrqkJKskf5PemO2kjIgWuSB0wcTK1qfGcQbr7IU8oi3bku2D5/j/zrULGVbnhUxxzXd5nuj12Y17HxhSQB66Brqqe6epqwVJS6tYllzDzaUtPPnnF0llZ7rux6I/ZAS8XzxRUjNOtXtxUZ7ReO7uLvC7z4tKDmwz2TeL8Kc90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745267; c=relaxed/simple;
	bh=z9XvycQfjh13D3iusq5+A1VVeBIk2Ofyo59g4rSmQHU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GKczZ/eOYCwDijd7z0HsGC9XmiQh64xw/GKrs4NO6Iu269rWwc3hQkmotol3X5pd/pOhKQ2kE11okXVmXEbqW1umhqAYG/Xu9FjWdVVFShYuGC3PydqED46GS2no0D30JlsT9ceY5t0o52igbXuLCSPnG2HQRnNLuoZmpYZgzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rw5MiVuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A933EC32786;
	Tue, 18 Jun 2024 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718745265;
	bh=z9XvycQfjh13D3iusq5+A1VVeBIk2Ofyo59g4rSmQHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rw5MiVuX3wIP8cGngGfu7tr1Y2f8+/hZRIv3MFq9Hhbk683v6sG0QeBYio9TQfq6e
	 dFsmxt1OzzToGd+ZDSGKrY5A9KIM25NvyeghgRwMCdjd9kB6zF6jcGvBT2xG+jjpl5
	 csStnF0f/UZsBOGt4DmcsL3ckzZ6HxbzD6wxLzCs=
Date: Tue, 18 Jun 2024 14:14:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Omar Sandoval
 <osandov@osandov.com>, David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Hao Ge <gehao@kylinos.cn>,
 linux-debuggers@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm: convert page type macros to enum
Message-Id: <20240618141424.0bd414c8fcc537e7709eadcd@linux-foundation.org>
In-Reply-To: <878qz31ajh.fsf@oracle.com>
References: <20240607202954.1198180-1-stephen.s.brennan@oracle.com>
	<20240607212738.bf55318aebd7172fadaa11c5@linux-foundation.org>
	<87ikygo1yb.fsf@oracle.com>
	<87bk3z1f76.fsf@oracle.com>
	<20240617142951.08a9cdc791c8edeeca50509b@linux-foundation.org>
	<878qz31ajh.fsf@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 15:14:58 -0700 Stephen Brennan <stephen.s.brennan@oracle.com> wrote:

> > -#define PAGE_TYPE_BASE	0xf0000000
> > -/* Reserve		0x0000007f to catch underflows of _mapcount */
> > -#define PAGE_MAPCOUNT_RESERVE	-128
> > -#define PG_buddy	0x00000080
> > -#define PG_offline	0x00000100
> > -#define PG_table	0x00000200
> > -#define PG_guard	0x00000400
> > -#define PG_hugetlb	0x00000800
> > -#define PG_slab		0x00001000
> > +enum pagetype {
> > +	/*
> > +	 * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
> > +	 * allow owners that set a type to reuse the lower 16 bit for their own
> > +	 * purposes.
> > +	 */
> 
> This comment is a bit out of place now, because it refers to David's
> change which has not yet been applied. Maybe it should continue to read
> 
> "Reserve	0x0000007f to catch underflows of _mapcount"
> 
> until "mm: allow reuse of the lower 16 bit of the page type with an
> actual type" changes it?

Updated, thanks.

The post-Stephen code is now

/*
 * For pages that are never mapped to userspace,
 * page_type may be used.  Because it is initialised to -1, we invert the
 * sense of the bit, so __SetPageFoo *clears* the bit used for PageFoo, and
 * __ClearPageFoo *sets* the bit used for PageFoo.  We reserve a few high and
 * low bits so that an underflow or overflow of _mapcount won't be
 * mistaken for a page type value.
 */

enum pagetype {
	PG_buddy	= 0x00000080,
	PG_offline	= 0x00000100,
	PG_table	= 0x00000200,
	PG_guard	= 0x00000400,
	PG_hugetlb	= 0x00000800,
	PG_slab		= 0x00001000,

	PAGE_TYPE_BASE	= 0xf0000000,
	/* Reserve 0x0000007f to catch underflows of _mapcount */
	PAGE_MAPCOUNT_RESERVE	= -128,
};


And the post-David code is now:

/*
 * For pages that are never mapped to userspace,
 * page_type may be used.  Because it is initialised to -1, we invert the
 * sense of the bit, so __SetPageFoo *clears* the bit used for PageFoo, and
 * __ClearPageFoo *sets* the bit used for PageFoo.  We reserve a few high and
 * low bits so that an underflow or overflow of _mapcount won't be
 * mistaken for a page type value.
 */

enum pagetype {
	PG_buddy	= 0x40000000,
	PG_offline	= 0x20000000,
	PG_table	= 0x10000000,
	PG_guard	= 0x08000000,
	PG_hugetlb	= 0x04008000,
	PG_slab		= 0x02000000,

	PAGE_TYPE_BASE	= 0x80000000,

	/*
	 * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
	 * allow owners that set a type to reuse the lower 16 bit for their own
	 * purposes.
	 */
	PAGE_MAPCOUNT_RESERVE	= ~0x0000ffff,
};



