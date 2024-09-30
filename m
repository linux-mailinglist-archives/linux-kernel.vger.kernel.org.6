Return-Path: <linux-kernel+bounces-343758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAE3989F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03A91F21EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C904188737;
	Mon, 30 Sep 2024 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kxn1lB80"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC86183098
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691123; cv=none; b=hkOs0JLIZknauo3lXnUFwbZMW/PtJ0PDF1cKuuPwRC9cKqynsZMF69kObFLK793aUhoYNVwRIPuAPOhxaU2dDnK76IpacXOvaMEnpqbp8qpY6nIqdYuTnTdwOEucdYSiZ2LWfT4w1OoMjtkukvSanq2iRe/u6BYKaYOrSAJV1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691123; c=relaxed/simple;
	bh=mvMp1cfrgRErkBTHgkQd06z417VNMxn4Pp6PsZR9Ink=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHsOsh4Sch4P6LZY3erytTsGK7l9uBtpoWHV3o5PddExMdMxYXNXgIbeoEkCAennrd6AiVeDMe4VEahhNPnJSjTqrI6Klw2vVh+o/L8/+v+PobD4M/uwk/TkC+czpXiO38gEOUQU8OzHknqyHOvvF1ZrAvA6m9CwKkU2/49xY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kxn1lB80; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 30 Sep 2024 06:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727691117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwjQXfaoEArCHX8Me75J2cpE/c/nfg9+6nxbmi9kJJM=;
	b=kxn1lB80JmZyc2+0HcxV6lVI2djPnTAeVTmVem3WJcr1kc3jlF9qEj7uBPk6i/M/M3nJIx
	uKaa2Jt30LjNGP39C3Q62A3UG6spoRoIdAOhxbSkuuVhiDP496X3X8mq5iSfxczHKJwRWf
	KFJd9L43/Oz30EX2e1ukLknHe3e7qq0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bcachefs: rename version -> bversion for big endian
 builds
Message-ID: <obpogbufu5awsn2a6olh2ondrgwl7bgdowjcpv6jcpm2ey4s5h@obcml2w3csap>
References: <20240930003902.4127294-1-linux@roeck-us.net>
 <CAMuHMdWcPpBgsK0r0U=k8NyjTjUTwBTLe6Bg_ORD2zmSNoRgJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWcPpBgsK0r0U=k8NyjTjUTwBTLe6Bg_ORD2zmSNoRgJA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 30, 2024 at 12:04:42PM GMT, Geert Uytterhoeven wrote:
> On Mon, Sep 30, 2024 at 2:39 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > Builds on big endian systems fail as follows.
> >
> > fs/bcachefs/bkey.h: In function 'bch2_bkey_format_add_key':
> > fs/bcachefs/bkey.h:557:41: error:
> >         'const struct bkey' has no member named 'bversion'
> >
> > The original commit only renamed the variable for little endian builds.
> > Rename it for big endian builds as well to fix the problem.
> >
> > Fixes: cf49f8a8c277 ("bcachefs: rename version -> bversion")
> 
> Which is (again) not found on any mailing list, and has never been in
> linux-next before it hit upstream...
> 
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> > --- a/fs/bcachefs/bcachefs_format.h
> > +++ b/fs/bcachefs/bcachefs_format.h
> > @@ -223,7 +223,7 @@ struct bkey {
> >  #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> >         struct bpos     p;
> >         __u32           size;           /* extent size, in sectors */
> > -       struct bversion version;
> > +       struct bversion bversion;
> >
> >         __u8            pad[1];
> >  #endif
> 
> BTW, how does this work when accessing a non-native file system?
> Didn't we stop doing bi-endian file systems in v2.1.10, when ext2 was
> converted from a bi-endian to a little-endian file system?

we byte swab if necessary

