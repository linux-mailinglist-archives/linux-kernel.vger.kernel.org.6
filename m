Return-Path: <linux-kernel+bounces-384795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50709B2E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D938281D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0841DFD82;
	Mon, 28 Oct 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wBiwyxXM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R1U7gb83"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451BD1DACBE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113619; cv=none; b=rQOw4F3hsQwTlAAlzh6jaHy0g/J8DRNMamWHaCCmCtgPzAr/cRGL76Pxrv3U0ZYUp3QQ589jP3wa30kEeJWl2Hcs4GFCxRjcnnecz8txh8IMQa8s48p7sxEKDo0MNeIsdPxr7PQ1oh5L0wy70IFPuQoLEbgKhESSMv92Lc9AEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113619; c=relaxed/simple;
	bh=TdgphFSPKteIsDqV+/lLEg0Dpd20NwJCgR362Sjn2bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ixA2NQuXnRznqM+IRXG8qPpzxjqWy491WmbgUD2GT/2lINLTEYK7OmhAhtVySQt1G3UaxhxQ1eyiwnWQIa0ZpL1GzEMlzG6UXpQ4TGDZ4+nCEPdKJKEwGurE6JWWIRiamtRecdSPVV8mXqsJ3td1W4/4UdKnWBVGoH7xUUZ5/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wBiwyxXM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R1U7gb83; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730113615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7REK5NOZDqgsCM5qk3fIGAaj2sjad6iPteMIKPQL108=;
	b=wBiwyxXMCBbEY1L12/SoMKkg9SRIGZhjTlINtB/oqmGSxLKTdmVnX34iLCZZ5yGAdLjgxe
	JTd7nyqjVnBvr7lPSpxfLUKAEUdOqMoYGVV7UYlOSj4CuZP21Kp892tZYfUECOftZTRRnJ
	u3ojZ/PC39Rs8IqqRW9IVnUswwJ58MNuPMSBmDXRW+G+fChlUiK8XH12eT4OhZFzOr2zLc
	1lg13BsWLkvcu/7yhgKX7TVFrHmKTbkchFvul+bvxP9DCrrszqssUcEmVcdQDwWweCQIBW
	xyC+ffOxT5Us5anoBcEAHRCY9rXaeXEWhBoPuGdI6zC3qy0DkVGk9le5DXKHYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730113615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7REK5NOZDqgsCM5qk3fIGAaj2sjad6iPteMIKPQL108=;
	b=R1U7gb83+z0DkEO72zGSSZ3H+1rll/WGu/qihDQsoKTKVHm6paS28Ec67iomNQqoquH7bZ
	SbgvcKWnOutinHCQ==
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Nam Cao
 <namcao@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Andreas Hindborg
 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda
 <ojeda@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel
 <sre@kernel.org>, Will Deacon <will@kernel.org>, Jon Mason
 <jdmason@kudzu.us>, Jaehoon Chung <jh80.chung@samsung.com>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, Jassi Brar <jassisinghbrar@gmail.com>, Pavel
 Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Rob Clark <robdclark@gmail.com>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Zack Rusin <zack.rusin@broadcom.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Takashi Iwai
 <tiwai@suse.com>,
 alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 00/44] hrtimers: Switch to new hrtimer interface
 functions (4/5)
In-Reply-To: <87y128txhh.fsf@ubik.fi.intel.com>
References: <cover.1729865485.git.namcao@linutronix.de>
 <87y128txhh.fsf@ubik.fi.intel.com>
Date: Mon, 28 Oct 2024 12:06:54 +0100
Message-ID: <87v7xc32r5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 10:58, Alexander Shishkin wrote:
> Nam Cao <namcao@linutronix.de> writes:
>
>> This is the forth part of a 5-part series (split for convenience). All 5
>> parts are:
>>
>> Part 1: https://lore.kernel.org/lkml/cover.1729864615.git.namcao@linutronix.de
>> Part 2: https://lore.kernel.org/lkml/cover.1729864823.git.namcao@linutronix.de
>> Part 3: https://lore.kernel.org/lkml/cover.1729865232.git.namcao@linutronix.de
>> Part 4: https://lore.kernel.org/lkml/cover.1729865485.git.namcao@linutronix.de
>> Part 5: https://lore.kernel.org/lkml/cover.1729865740.git.namcao@linutronix.de
>
> Which one do I need to click on to see the actual hrtimer_setup*()
> implementations? Why is it even a separate series? Please, don't make
> people click on things.

Obviously part 1. The splitup was dont to avoid 500+ people which is
generally frowned upon.

>> That can cause misuse of hrtimer. For example, because:
>>   - The callback function is not setup
>>   - The callback function is setup while it is not safe to do so
>
> These are not examples, these are hypotheticals. Do either of these
> things actually happen in the codebase?

Right now not, but we had this in the past.

>> To prevent misuse of hrtimer, this series:
>>   - Introduce new functions hrtimer_setup*(). These new functions are
>>     similar to hrtimer_init*(), except that they also sanity-check and
>>     initialize the callback function.

> I'm not objecting to the idea, it's just carried out weirdly.

Right. There should have been a sectioning to explain what which part of
the series does. My bad.

Thanks,

        tglx


