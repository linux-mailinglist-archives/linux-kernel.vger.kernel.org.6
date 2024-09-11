Return-Path: <linux-kernel+bounces-324365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3195974BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99351B26082
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8FA41AAC;
	Wed, 11 Sep 2024 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Y9NEqcl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vbS44RKB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48C13C83D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040505; cv=none; b=lQr1VMv8ZbE0S3X9NaVceC4PtwFgjHrLyO6kLDLbpX/jFl7DWOtmhNOY2bZEM1gMLRyEsiTYEJb9mfMkM3NLvpkM9lmxCsZeqIIMySUFsvTc68V4i2d4Lu1DQpmoNEFLJ0qvtSgKRWQ2AJ1hYb/096jqwLgAdlpB8Qj8/S8incI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040505; c=relaxed/simple;
	bh=lAU8+HOeecikhhDBSTKPSrwcQQ1cUPVSRefjJxTMne8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pPGs1tFL7gCggbx5GywVYQb+WFZAeXPrHHopKuhHipjnte92HmOxhjDVIpm98/Y0Mxm+eI31C6csa6IKumnTXlbuPiwV4pepJRbeJIRd0gnjVc1uDe+tkAdT66Z3Dq6Ais/UElFZT5xxlYCKaDbHgUP+1fAXfsOaMFDrlYRzjLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Y9NEqcl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vbS44RKB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726040501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1DBykUr9SDlwpv5CynH2sqJyTqVcYBrWcGijQsZAHKU=;
	b=2Y9NEqclxnO9/vYIEQPOspvOO75Y4+jdFXX7SKnDHrqtJd3uUqSUddF1HjNXZB/ASvDAvS
	U+Y0r/DWWdPv7h55LmMcfEZ/rd3fgtD5q2kFNbAGJRTwJ9N79u2/1IhCBPq+T7yk5Asl4O
	hwlUOXi+kk7FhejBMi00fUZxD6IehWl1Aygm0XFLPzVU4MdGVlRU8vMnhSVhwJKeUnPxLw
	++kRVZ+qUQdht34TlfM6rJOjw43Mlc53Z4V0BnhAi4xM+KIutR/13RuBpMjaKST4y63quo
	JVXBmVBdkhOBKOBwZFhy58Y5pVE2GQopRxsT8+N7CWVQCMNittekMFnElKqC0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726040501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1DBykUr9SDlwpv5CynH2sqJyTqVcYBrWcGijQsZAHKU=;
	b=vbS44RKBM9Fj0j2iGrQ1X0Tpj2LyTgjc2/lwqwFhNXP/8W8jjzxWJg9PufqFz1GJ6V2hB2
	/mdRI4TnR3gpQXCA==
To: Joe Perches <joe@perches.com>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jonathan
 Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: Re: [PATCH v2 10/15] checkpatch: Remove broken sleep/delay related
 checks
In-Reply-To: <ba245a06048af9eee61cea8c8fb79a331900cc73.camel@perches.com>
References: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-flseep-v2-10-b0d3f33ccfe0@linutronix.de>
 <ba245a06048af9eee61cea8c8fb79a331900cc73.camel@perches.com>
Date: Wed, 11 Sep 2024 09:41:41 +0200
Message-ID: <875xr2eix6.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Joe Perches <joe@perches.com> writes:

> On Wed, 2024-09-11 at 07:13 +0200, Anna-Maria Behnsen wrote:
>> checkpatch.pl checks for several things related to sleep and delay
>> functions. In all warnings the outdated documentation is referenced. All
>> broken parts are listed one by one in the following with an explanation why
>> this check is broken. For a basic background of those functions please also
>> refere to the updated function descriptions of udelay(), nsleep_range() and
>> msleep().
>> 
>> Be aware: The change is done with a perl knowledge of the level "I'm able
>> to spell perl".
>> 
>> The following checks are broken:
>> 
>> - Check: (! ($delay < 10) )
>>   Message: "usleep_range is preferred over udelay;
>>             see Documentation/timers/timers-howto.rst\n"
>>   Why is the check broken: When it is an atomic context, udelay() is
>>                            mandatory.
>> 
>> - Check: ($min eq $max)
>>   Message:  "usleep_range should not use min == max args;
>>              see Documentation/timers/timers-howto.rst\n"
>>   Why is the check broken: When the requested accuracy for the sleep
>>                            duration requires it, it is also valid to use
>>                            min == max.
>
> There is a runtime setup cost to use usleep_range.

Sure, it's because of hrtimers. This is also documented in the new
documentation.

> I believe udelay should generally be used when there
> is a specific microsecond time delay required.

The aim of the whole series is to cleanup the outdated documentation of
the usage of delay/sleep related functions. Please read the new
documentation which is provided by the last patch of the queue, when to
use which function. Also updated function descriptions itself contain
important information about usage. If you have any concerns about
correctness of the new documentation or if there is something missing,
please let me know.

As several comments in the kernel and also checkpatch contain several
links to the outdated documentation file (which will be also moved to a
more self explaining file name by the last patch), I need to update
those places to be able to move the file. Also checkpatch.

>> 
>> - Check: ($delay > 2000)
>>   Message: "long udelay - prefer mdelay;
>>             see arch/arm/include/asm/delay.h\n"
>>   Why is the check broken: The threshold when to start using mdelay() to
>>                            prevent an overflow depends on
>>                            MAX_UDELAY_MS. This value is architecture
>>                            dependent. The used value for the check and
>>                            reference is arm specific. Generic would be 5ms,
>>                            but this would "break" arm, loongarch and mips
>>                            and also the arm value might "break" mips and
>>                            loongarch in some configurations.
>
> It likely won't "break", just perhaps be inefficient.

If running on loongarch with HZ>=1000 MAX_UDELAY_MS is 1. When keeping
the above check, then there is the risk of an overflow. I'm not sure if
an overflow is the same than beeing inefficient. Same for mips with HZ>=1000.

When using the generic value of 5, also arm would have the risk of an
overflow as MAX_UDELAY_MS for arm is 2.

So my general questions here are:

- What do you think about the change of this patch in general or do you
  want to have things changed?
- Should I only make changes to the commit message so that it's more clear?

This would really much help me to make progress with this queue.

Thanks a lot for your support!

	Anna-Maria


