Return-Path: <linux-kernel+bounces-568560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B0A69777
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE8F7A2219
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43F1E991B;
	Wed, 19 Mar 2025 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dl4I27XB"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7FC1D54D6;
	Wed, 19 Mar 2025 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407695; cv=none; b=obqMWd1Jg4Y6TtIOweTvTcBCMb2BQwkHVKAfCBBFgpsFI0mcb6bKuzfBpRbd0qgucEdc9Rkq4+RSUGrFPV0eyPjhpAemOBkZ4WgQrw9oqxBzsiuMJZwL4hreQUkqoxb9G8YOR29K3SSw+YDJCynzzbSOBnRD0SY/nSk+lkO+gwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407695; c=relaxed/simple;
	bh=zqnzsxiP89SgvtjiQFzuFFa7snDt35vKEJJvRGx0NfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ivEGgB1/6BUH7RqQM61ZgR8Y5l+wsL9NLajymHZY7AnV8I8/FgT4svFEZh3DJk/88bVZpnsHEDIxPyumJ+eLIq0PldDN9z2I+wPniPafN0ROW0tPrtoEPFNwCJEr4WUCdNemLOSDuYmaWh6KlaBCgmsYw6vLOV7pL5z3fI8/rJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dl4I27XB; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94D7644549;
	Wed, 19 Mar 2025 18:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742407685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZPIFVslvH9l06L8tnbNSF2qR6hGErPXH8fPWX2MidI=;
	b=dl4I27XBcpPofhry0JbmcrWGxoLtOpTw8nB68wQqjPsZjOJzq6kON/ApeSqIo8db8178LJ
	s38hr0Exy3OFWsHR3pOAeQryWaCIqF2ZDWcxpdF600XrKrdpbbetFk4zQSCBwJatepGd1k
	wWJNwyBl8vl4OjBroZN9BiEmWuYLYDTGuq1NpCFdoDRazNL9tNoI/wZVzCKS+0Er1qidnW
	z+cKIwqKybBt3d1s9XttfTzmjzSxtySNInLM4fV6yMIb13yDO14AEVFihhA6k+bhKtkmr9
	a80p/rXc+Z5DjVYf5OS7WLHxHy7sX30Mt2NXmBwB3x5MItCsiYPmPHQ+RLw5Eg==
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
Subject: Re: [PATCH v3 2/3] hexdump: Allow skipping identical lines
In-Reply-To: <Z9rzy9WQcy_MgH9v@smile.fi.intel.com> (Andy Shevchenko's message
	of "Wed, 19 Mar 2025 18:41:47 +0200")
References: <20250319-perso-hexdump-v3-0-a6ba3a9f3742@bootlin.com>
	<20250319-perso-hexdump-v3-2-a6ba3a9f3742@bootlin.com>
	<Z9rzy9WQcy_MgH9v@smile.fi.intel.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 19:08:04 +0100
Message-ID: <87tt7oyjuj.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeitdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfelkedvveffleeuhfeigfdvvefhgfejgffghfeiteegteeiudegfedtjeehkeefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehpmhhlrgguvghksehsuhhsvgdrtghomhdprhgtphhtthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoheplhhinhhugiesrhgrshhmuhhsvhhil
 hhlvghmohgvshdrughkpdhrtghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdguvg
X-GND-Sasl: miquel.raynal@bootlin.com


>>  For printing small buffers (up to 64 bytes long) as a hex string with a
>>  certain separator. For larger buffers consider using
>> -:c:func:`print_hex`.
>
> Instead of fixing this (see also comment in previous patch), just add the text
> like
>
> :c:func:`print_hex` is  especially useful since duplicated lines can be skipped
> automatically to reduce the overhead with the
> ``DUMP_SKIP_IDENTICAL_LINES`` flag.

Why are you bothered here? I am sorry but this part of the review is
absolutely pointless. I have no words to emphasize how high the
nitpicking level is. Please refrain yourself.

>> +:c:func:`print_hex`, especially since duplicated lines can be
>> +skipped automatically to reduce the overhead with the
>> +``DUMP_SKIP_IDENTICAL_LINES`` flag.
>
> Also, can  we also put a sub name spaces to the flags, like for HEX/ASCII
>
> DUMP_DATA_HEX
> DUMP_DATA_ASCII

They just refer to the way the data is dumped, so "data" is in the name,
that's true. The fact that they share the same namespace is fortunate
but not super relevant either. I am following the hints discussed in v2
regarding the naming, I am not too attached to these, but they felt
correct, so I use them.

> This SKIP  will start a new sub name space.

Yes. And?

I would have probably chosen a common name space from day 1 if I was
creating these now, but they are already two enums named
"DUMP_PREFIX". I guess we all agree it would be stupid to prefix all
enums "DUMP_PREFIX" anyway? And because you disgusted me from attempting
brave tree-wide changes, I will not rename them.

>
> ...
>
>>  #include <linux/errno.h>
>>  #include <linux/kernel.h>
>>  #include <linux/minmax.h>
>
>> +#include <linux/string.h>
>>  #include <linux/export.h>
>
> It's more natural to put it here, with given context it makes more order
> (speaking of alphabetical one).

If I learned something on these mailing lists, it is that what is
natural for me might not be for others. The alphabetical order is not
respected. You already pointed that in your first review, so I chose
another place which felt more relevant... to me.
e, k, m, s, u. This is the alphabetical order. export.h is not at the
correct place, I am very sorry.

