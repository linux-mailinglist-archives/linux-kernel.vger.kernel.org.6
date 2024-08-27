Return-Path: <linux-kernel+bounces-302923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94C496050F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E4C281453
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1641990CF;
	Tue, 27 Aug 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JW9LPz1N"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AC013B293;
	Tue, 27 Aug 2024 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749321; cv=none; b=ewcLZPYTTDHu4KMP/VbB0HBwkr1xIKhmgqBL0eWRIScLWbhbLCguak8rD35iWWd63MvMIoEu1aw7Wgf2vOJ738TZuMcQe2cEhS7d2Rp187+/90Ge3i1AKPko3QDj8v8q6AB6HtoIHZn5T62PzZUPCDr9bdj2xkxtu+AQ6gR5lQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749321; c=relaxed/simple;
	bh=ZLpYLaolmOE6fOikl7lbht2tvgu8R0+s66V2JnVzJuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTKFYCOnrtQ2NVqazTfXjxPXzGS0laJwR5t64OzHmgF9v+RHy4eXuHswuwUFfOwUI2BTndpKrhJuwIpHz14Ckiaa0uGvZZa2pHVUx+Cqnr8O8B7N0aT3yWfppcRpK2YMSVe35Cvo4yzdAjOWY/x25CjPZiyTvkRjipTiCIaL13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JW9LPz1N; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC28DC0009;
	Tue, 27 Aug 2024 09:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724749310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=70TA7iyrRtSGBBWX4Dp+NsHo/WZwGM3JN2PcpntFqI0=;
	b=JW9LPz1NOhWgP2fitZ1XuRqyyynBTm6NmfDTsNwmxk1TcqrSuu1tdVV2VZ5D+ciIzKhDHN
	H1Is6pmShviU7xPv3Pxr2hSfHs++SAD1bRABjyhkF3EJSAUJMQAZVYx/mxcxSbLJvSKo14
	he0o+TZok4LvVh8WCqAEusikqrxAQh1HlhHzSMbXrhmtGoZndzW6RRMoOUe8zZcXphhUPK
	oQFZvRN9UkC+YxdrMgSa6BteTLUCASFzjuUJ4nGnDg/kxTepIm0GTTvbaZNZE5KNV8icGr
	4d2HG9zbDit7huVxUO+Nc8syopyLJwsND1ViPF3eFe6XjZGkG/Wxul2ywquR+w==
Date: Tue, 27 Aug 2024 11:01:47 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jonathan Corbet <corbet@lwn.net>, John Ogness
 <john.ogness@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] hexdump: Allow skipping identical lines
Message-ID: <20240827110147.29a7481a@xps-13>
In-Reply-To: <Zsy8JPaiGknBypw9@smile.fi.intel.com>
References: <20240826162416.74501-1-miquel.raynal@bootlin.com>
	<Zsy8JPaiGknBypw9@smile.fi.intel.com>
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

Thanks for your feedback.

andriy.shevchenko@linux.intel.com wrote on Mon, 26 Aug 2024 20:32:20
+0300:

> On Mon, Aug 26, 2024 at 06:24:14PM +0200, Miquel Raynal wrote:
> > Hello!
> >=20
> > While working on NAND issues, I used print_hex_dump() a lot to compare
> > data. But I am mostly working on embedded systems where the kernel
> > messages go through a serial console. Sometimes network support is an
> > option, sometimes not. Anyway, I often print buffers both in kernel
> > space and user space to compare them, and they may be full of 0's or
> > 1's, which means lines are repeated a lot in the output and this is slow
> > *and* hard to compare.
> >=20
> > I initially hacked into lib/hexdump.c for my own purpose and just
> > discarded all the other users, but it felt like this might be a useful
> > feature for others and decided to make it a public patch.
> >=20
> > * First patch changes the "ascii" parameter into a "flags" variable now
> >   accepting the value: DUMP_FLAG_ASCII.
> > * Second patch adds a new flag to skip the identical lines, because this
> >   must be an opt-in parameter, I guess. =20
>=20
> This is quite a long to look into, can you please add a summary here which
> includes (but not limited to) the following:
> 1) examples before and after (ah, I see you have that in the patch 2,
>    but would be still good to have in the cover letter);

No problem, I can make this part of the cover letter as well.

> 2) excerpts of the code for before and after (since the type of the ascii
>    parameter had been changed).

In patch 1/2 there is the Coccinelle script, but I must admit the
syntax is not super clear, so I will improve this by showing the two
main user cases with a proper human-readable diff.

> Also here is the formal NAK till the series gains the test cases.

What test cases are you talking about?

Thanks,
Miqu=C3=A8l

