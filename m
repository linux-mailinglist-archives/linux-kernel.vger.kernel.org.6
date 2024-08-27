Return-Path: <linux-kernel+bounces-302939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C45296054B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F851F22414
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D17A19A29A;
	Tue, 27 Aug 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NlQ+zAP0"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93919752C;
	Tue, 27 Aug 2024 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750039; cv=none; b=N7hY0uIHk/EZkQwueMGxMVBBGpXhpdq+XEOCavgBLlJljs+6tdYMxwbbd6dHnTVNfnBbOAmsz5Zf9v7KoaVY02ZtmDlUGCcWPChxk+avSoeZjd8ue2r36IxNDXkXtF+rDe0vhd5iCLeZhdTN61BDaLhydp0fdZMGQ+phmPjj8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750039; c=relaxed/simple;
	bh=DcVSrrjynKbRxXS0XwiX+7IfWWMNyF+0fi4dKQ+Xsqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DyLUZUi+tQsTZSxyPVHEimUFySYdmi1vEl4/+WOrZBuToSW1coN96hiZnu49Fm3XV8mqeaz912vHr/93fYLyH6bbcu/2r55EWIGwXjJ8I863mICPgq/4bwOuX2PItvyVFMjn6f93BPEqa3c0VGgq/8VNTP8CEbrSnWKZ93UAPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NlQ+zAP0; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77BC3C0006;
	Tue, 27 Aug 2024 09:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724750035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgDeJKYsQBbTYnMqbAF25gViBY/ePcmfyH1BkbpcCUw=;
	b=NlQ+zAP0bIheb4MUSFf/XrzLm7aBRVV4cYsW8JL4GHMRWP5WVOvTLppgcFNL1lB2KBzxCx
	yNR/mXljzUJMzUXPAAIGM8QpQG3afO87mMAiYcgWIv7Y3UcFHNy9tnBjQlmJ9Zl0l7jJZj
	7eE/6o7Q1br/a7I4/4HCz1zekvBCez3cSx48TuCL83iESpFNxFS2hKGK20jMbdR4bgUnIY
	VKg7mWy/1MYp9AiITO67gEKg2zSUOP3i491tZIX81cdq9iJQh/6xrTUtGOzIjq4ajAqOhR
	Fv0WWp7Xh7GNaBHaXEXg5KZV7kdd+sjslH0J5ayIgEgV80ZUROVQB95DWK4dog==
Date: Tue, 27 Aug 2024 11:13:53 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, John Ogness
 <john.ogness@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hexdump: Allow skipping identical lines
Message-ID: <20240827111353.0341c571@xps-13>
In-Reply-To: <Zsy86HZ7uew9-Ef6@smile.fi.intel.com>
References: <20240826162416.74501-1-miquel.raynal@bootlin.com>
	<20240826162416.74501-3-miquel.raynal@bootlin.com>
	<Zsy86HZ7uew9-Ef6@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Mon, 26 Aug 2024 20:35:36
+0300:

> On Mon, Aug 26, 2024 at 06:24:16PM +0200, Miquel Raynal wrote:
> > When dumping long buffers (especially for debug purposes) it may be very
> > convenient to sometimes avoid spitting all the lines of the buffer if
> > the lines are identical. Typically on embedded devices, the console
> > would be wired to a UART running at 115200 bauds, which makes the dumps
> > very (very) slow. In this case, having a flag to avoid printing
> > duplicated lines is handy.
> >=20
> > Example of a made up repetitive output:
> > 0f 53 63 47 56 55 78 7a aa b7 8c ff ff ff ff ff
> > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > ff ff ff ff ff ff ff ff ff ff ff ff 01 2a 39 eb
> >=20
> > Same but with the flag enabled:
> > 0f 53 63 47 56 55 78 7a aa b7 8c ff ff ff ff ff
> > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > *
> > ff ff ff ff ff ff ff ff ff ff ff ff 01 2a 39 eb =20
>=20
> The problem here is that without offset we can't see how many lines were
> skipped.

Yes, this is intended, I prefer to mimic userspace tools behavior.

> Two ways to solve (that come to my mind immediately, maybe more and bette=
r):
> 1) make sure that new flag implies or expects (otherwise BUILD_BUG_ON() o=
r so)
>   the OFFSET to be set;

It depends what you are looking for. When I print a 2kiB page and want
to compare the output with some other dump, I will immediately see if
there are more or less skipped lines in the diff. When I want to just
grab the UBI header and skip all the ff's following while asking a full
buffer to be dumped (for kernel development reasons), the amount of
skipped lines is not of interest to me either. Of course this is my own
use case, but I guess there are others.

However this is true it is sometimes also useful to know where we are in
the dump, but the hexdump helpers already include all the interesting
bits for that through the 'prefix_type' parameter :

enum {
	DUMP_PREFIX_NONE,
	DUMP_PREFIX_ADDRESS,
	DUMP_PREFIX_OFFSET
};

See https://elixir.bootlin.com/linux/v4.20.17/source/include/linux/printk.h

I anyway understand the request and will change the example with
something more common, probably, by using one of the two other
prefixes.

> 2) [OR] add number of lines skipped in that * line.

As mentioned above, this is not the intended output.

> Personally I prefer the 1) as I think that you tried to follow the existi=
ng
> format of user space tools and there is a chance that there are other too=
ls or
> scripts that parse the dump to restore the binary contents.

Exactly. Also, just simply using the diff command over two dumps
without being polluted by any additions on one side or the other is very
convenient.

Thanks,
Miqu=C3=A8l

