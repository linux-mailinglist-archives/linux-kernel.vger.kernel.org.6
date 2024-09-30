Return-Path: <linux-kernel+bounces-344008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B6798A276
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304702812D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEAE18E023;
	Mon, 30 Sep 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZN8gntLQ"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599B18DF9E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699470; cv=none; b=t7PG/PaYpgIC51M4tzGH0rDIyLI9imwAQJm1XNhOl6HfCqnmp+9aFOaedppZnxWx7JluK79R6mLyMS9AFJArFRGdPbwaPEUkXwL3dcw498D7+JuXWkoQkV71IOyIXhCy5Vx2RwN3Comd+A30uDoTYWKmxyhgDlyrL79w9hKb1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699470; c=relaxed/simple;
	bh=MRJIKxjY5fyLod+/9tQq0egZ9eZfCVxOGial3fiqCwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6XbseirO7EDQHWG5VNZUFhtJBoTqhT450Gd4/nrg5z8vGJy48jm6Nu/i6990/XU89AgF+ilXUI7yVuUEncZWg2dfT68IdQ/oE7sSl77mazZubl6xAp+OHdzC9ZiX8xEin7zUYqXvPbXU/P+h2laQH074HzRzpqw9gmuuxShc9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZN8gntLQ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 30 Sep 2024 08:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727699465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEnSsHQSaJnFQRxIVTDpWYtDfTPI71zTPYoZV+vzeZU=;
	b=ZN8gntLQdN71iIWUd8MRKqB83R1adTPt5ncch2HuZZREmp/BkWrgdHEGmpC4Wv4XBS2tTq
	8/Lo00cKjBqwkfR31lZUFU2ctSW276XCFNZGpTnb0T9N8Y6GmaOHt/pzAF4QNzsoO32ak6
	x5wG++SRA081UxJtmljvRs9CYkjDiB4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bcachefs: rename version -> bversion for big endian
 builds
Message-ID: <fo6bvxt5o5veelshcig3zrqyktwvpxzxpvz4bb3n6gyk2vwejk@fx7opeolkbvj>
References: <20240930003902.4127294-1-linux@roeck-us.net>
 <CAMuHMdWcPpBgsK0r0U=k8NyjTjUTwBTLe6Bg_ORD2zmSNoRgJA@mail.gmail.com>
 <obpogbufu5awsn2a6olh2ondrgwl7bgdowjcpv6jcpm2ey4s5h@obcml2w3csap>
 <CAMuHMdXZ_N+uvXROpNvvSO3AZ7A-7hQTE4FxEa=1aMX-NC5rbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXZ_N+uvXROpNvvSO3AZ7A-7hQTE4FxEa=1aMX-NC5rbA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 30, 2024 at 02:08:25PM GMT, Geert Uytterhoeven wrote:
> Hi Kent,
> 
> On Mon, Sep 30, 2024 at 12:11 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > On Mon, Sep 30, 2024 at 12:04:42PM GMT, Geert Uytterhoeven wrote:
> > > On Mon, Sep 30, 2024 at 2:39 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > Builds on big endian systems fail as follows.
> > > >
> > > > fs/bcachefs/bkey.h: In function 'bch2_bkey_format_add_key':
> > > > fs/bcachefs/bkey.h:557:41: error:
> > > >         'const struct bkey' has no member named 'bversion'
> > > >
> > > > The original commit only renamed the variable for little endian builds.
> > > > Rename it for big endian builds as well to fix the problem.
> > > >
> > > > Fixes: cf49f8a8c277 ("bcachefs: rename version -> bversion")
> > >
> > > Which is (again) not found on any mailing list, and has never been in
> > > linux-next before it hit upstream...
> > >
> > > > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >
> > > > --- a/fs/bcachefs/bcachefs_format.h
> > > > +++ b/fs/bcachefs/bcachefs_format.h
> > > > @@ -223,7 +223,7 @@ struct bkey {
> > > >  #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> > > >         struct bpos     p;
> > > >         __u32           size;           /* extent size, in sectors */
> > > > -       struct bversion version;
> > > > +       struct bversion bversion;
> > > >
> > > >         __u8            pad[1];
> > > >  #endif
> > >
> > > BTW, how does this work when accessing a non-native file system?
> > > Didn't we stop doing bi-endian file systems in v2.1.10, when ext2 was
> > > converted from a bi-endian to a little-endian file system?
> >
> > we byte swab if necessary
> 
> So you have to test 4 combinations instead of 2 (which you don't do,
> obviously ;-)
> 
> Ext2 was converted from a bi-endian to a little-endian file system
> because it turned out the conditional byte-swapping was more
> expensive than unconditional (not) byte-swapping. Given all the
> bcache structures are already tagged with __packed anyway, I guess
> this is even more true for bcachefs.
> 
> The proper way established +25y ago was to settle on one endianness
> layout for all on-disk data. That way you do not have to duplicate
> data and code for little vs. big endian, keep both paths in sync, and
> you can annotate everything with __[bl]eXX attributes to let sparse
> help you catch bugs.
> 
> Which endianness to pick is up to you. Ext2 settled on little-endian,
> XFS on big-endian.

If you peruse that code even slightly, you'll see that what we're doing
is treating the key as a multi word integer, so word order has to match
machine byte order in order for various things in the btree lookup code
to work.

But sure, try and tell me there's something about filesystems I don't
already know...

