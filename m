Return-Path: <linux-kernel+bounces-568527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538FAA696DC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E55219C56A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018A2205E1A;
	Wed, 19 Mar 2025 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZWv9cmVI"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C061A316D;
	Wed, 19 Mar 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406795; cv=none; b=EiiSf33FRIhg0SmrQQtFiJPkGbBcCdIADhv50Meo2Rd/t8tGajYUM5AUrswo7/D9xUNfXeRHxrZRcHa8tHcM77jX8hD9nKjZuMNr83v4i1vg0wwG0cuntfYprD1u4sM/nOahetr8Q8XmRwNkYdO2h9h+o8yvCtrACbQlrZRyaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406795; c=relaxed/simple;
	bh=G0jfwKK6hYvsCBdHS73q746b5UMHR9Cw92CrVkMzlc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VOBBFQBZRJC2m89rOgMctv4HUsibkNyhZZ0GxGzdBCKQgMQk/0lvm4D3Bpol36I7eXpkDJ/zMZuPdVLxcKcCuT1RIhQREJUqjGhy8phIaLAKpAg93gCahaGkYh3h/UXpwnL/ONdXipWr0iYAfIS8Dk+9q9pGVo+G63TA6PWE7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZWv9cmVI; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C800A4443F;
	Wed, 19 Mar 2025 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742406784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4gOubC07LuDWaBDEbe/aCh2WgHFp0tvdeL/kxwU5nQ=;
	b=ZWv9cmVIk1hBGQMyBQ6s+W6CqZJilljOEJS5tjs6DR00mvNSolicUVMfhUP5cSr6/0/zqw
	3Mm6mcnpLezae6GboZYuAZn23wQlxL950lwNM56nqARqEFmeLmkK3gkzKM5V2rVecgL7bT
	RHhf6d/r92H8PvSt2Yz8cv1DQPhGABrZiG8TNyFVytY5IPPdgZBvXvRcRTqYGHdTWsbl3X
	WHPQHbCkzLHs+AM99G3BJvNbJaYU8bZBNHHwol2tkwzjl4l7+NQNmz9u8jHeYf2v/peNy+
	M5+nPOgACIarNEzhg+LHJ7DB2fWnKrsbus+m7IKCaQIeW+WczSU26ed6lTEH4Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>,  David Laight
 <david.laight.linux@gmail.com>,  Steven Rostedt <rostedt@goodmis.org>,
  Rasmus Villemoes <linux@rasmusvillemoes.dk>,  Sergey Senozhatsky
 <senozhatsky@chromium.org>,  Jonathan Corbet <corbet@lwn.net>,  John
 Ogness <john.ogness@linutronix.de>,  Andrew Morton
 <akpm@linux-foundation.org>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] hexdump: Simplify print_hex_dump()
In-Reply-To: <Z9ryxqRd0u4cZJoL@smile.fi.intel.com> (Andy Shevchenko's message
	of "Wed, 19 Mar 2025 18:37:26 +0200")
References: <20250319-perso-hexdump-v3-0-a6ba3a9f3742@bootlin.com>
	<20250319-perso-hexdump-v3-1-a6ba3a9f3742@bootlin.com>
	<Z9ryxqRd0u4cZJoL@smile.fi.intel.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 18:53:03 +0100
Message-ID: <87msdgzz40.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepphhmlhgruggvkhesshhushgvrdgtohhmpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehlihhnuhigsehrrghsmhhushhvi
 hhllhgvmhhovghsrdgukhdprhgtphhtthhopehsvghnohiihhgrthhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehjohhhnhdrohhgnhgvshhssehlihhnuhhtrhhonhhigidruggv
X-GND-Sasl: miquel.raynal@bootlin.com

On 19/03/2025 at 18:37:26 +02, Andy Shevchenko <andriy.shevchenko@linux.int=
el.com> wrote:

> On Wed, Mar 19, 2025 at 05:08:10PM +0100, Miquel Raynal wrote:
>> print_hex_dump() already has numerous parameters, and could be extended
>> with a new one. Adding new parameters is super painful due to the number
>> of users, and it makes the function calls even longer.
>>=20
>> Create a print_hex() to replace print_hex_dump(), with 'prefix_type' and
>> 'ascii' being merged into a 'dump_flags' parameter. This way extending
>> the list of dump flags will be much easier.
>>=20
>> For convenience, a print_hex_dump macro is created to fallback on the
>
> print_hex_dump()

It is a macro, not a function, so I don't feel bothered by the absence
of parenthesis. Anyway, that's really a nitpick, so if you want, I'll
add them.

>> print_hex() implementation. A tree-wide change to remove its use could
>> be done in the future.
>>=20
>> No functional change intended.
>
> ...
>
>>  For printing small buffers (up to 64 bytes long) as a hex string with a
>>  certain separator. For larger buffers consider using
>> -:c:func:`print_hex_dump`.
>> +:c:func:`print_hex`.
>
> Why replacement? I would rather expect

Because it is a replacement. I initially wanted a tree-wide change but
it is too heavy and painful to carry. So I am replacing print_hex_dump()
by print_hex() as it was discussed in v2, but keeping print_hex_dump()
possible. In practice it is a handy fallback on print_hex(), nothing
else.

> :c:func:`print_hex_dump` or :c:func:`print_hex` depending on your
> needs.

There is no need print_hex_dump() fills and print_hex() does not. It
is actually the opposite. We no longer need print_hex_dump().

>
> ...
>
>> +/*
>> + * Dump flags for print_hex().
>> + * DUMP_PREFIX_{NONE,ADDRESS,OFFSET} are mutually exclusive.
>
> This is confusing, taking into account two definitions to 0.
>> + */
>>  enum {
>> +	DUMP_HEX_DATA =3D 0,
>> +	DUMP_ASCII =3D BIT(0),
>> +	DUMP_PREFIX_NONE =3D 0, /* Legacy definition for print_hex_dump() */
>> +	DUMP_PREFIX_ADDRESS =3D BIT(1),
>> +	DUMP_PREFIX_OFFSET =3D BIT(2),
>>  };
>
> Can we rather add a new enum and leave this untouched?

No, because the DUMP_PREFIX_ADDRESS/OFFSET are needed in
both. DUMP_PREFIX_NONE is no longer really needed, that's why I mark it
legacy with a comment, it's presence or absence no longer matters with
print_hex().

> Also you can use bit mask and two bits for the value:
>
> 	DUMP_PREFIX_MASK =3D GENMASK(1, 0)

Why? What is the use case?

> and no need to have the above comment about exclusiveness and no need to =
change
> the values.

Exclusiveness has always been there, just look at the code, I'm not
adding anything new. Refusing to change values for an enumeration is
totally pointless, it has no impact, no cost, no consequence. I don't
see your point.

>
> ...
>
>> +extern void print_hex(const char *level, const char *prefix_str,
>> +		      int rowsize, int groupsize,
>> +		      const void *buf, size_t len,
>> +		      unsigned int dump_flags);
>
>> +static inline void print_hex(const char *level, const char *prefix_str,
>> +			     int rowsize, int groupsize,
>> +			     const void *buf, size_t len,
>> +			     unsigned int dump_flags)
>
> Hmm... Wouldn't you want to have a enum as a last parameter?

And this has already been discussed in v2, we need to pass multiple
flags and decided to go for an unsigned int|long, I do not think the
compiler will like it otherwise.

Regards,
Miqu=C3=A8l

