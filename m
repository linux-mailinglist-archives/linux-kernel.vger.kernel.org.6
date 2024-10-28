Return-Path: <linux-kernel+bounces-384492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893DE9B2ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C326B212EF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0110F1925B6;
	Mon, 28 Oct 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFucrraw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD2155C97
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730105925; cv=none; b=mUj+IQV0VN5b6A7VZnXcqNRPorga7JnWXDaCX0f1VYRHsRwADGyUyENbYcX2IvfG+lGrYQXmvpolIPlPg8VNp3pcfThqiT7lr7wVyUeLnTQRJDx9abdJAoTdWo85QR8is/xsUq5gpsaIo6rA4TXBlr2As0lgYsj1bIlAR+2cV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730105925; c=relaxed/simple;
	bh=KIBZkEQKwG2vsUBvKGjwFPZYZDY9aZXu2ruXx2f15ho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W52LXGZdkSc1pueE9GysFTzi+QbJjSFMFOfSeK+iu8F0tbmcRVpPuYL1zMoehq5V2VtMTeoJcYvsqVT+edUQbYR9vfkvlLyXY8UZa28mz9WusY7dLOubggKneOTJRd5WtjqIKtgIzksRNUtP4xcePY9a98oUt5cPucLrOtN2Oq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFucrraw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730105923; x=1761641923;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KIBZkEQKwG2vsUBvKGjwFPZYZDY9aZXu2ruXx2f15ho=;
  b=BFucrraw4hmSPYR62eMbEwTVaaH0oeZq2XdjLGld6Xec9JN22GKcNUrQ
   i00IxQQe2e7+C64J1YzNl9dvUMmCSeBqv+JF9Ne9xdHQjBXJ2v28iQ4wr
   +tzPBmJe76revm7svVXjNFZE0vDyJRKwEP8N0KIH5q5WHbCaCPjTxqmnE
   ve9qj2W9dpbKRqUKrBYNN9cG7MbKZ+5+/6EcvGHGV/o2zQQJfMONxff9q
   uECFzaDgI1szI9t8cXCxJkdXyhlodf3WYF3IwYv8OInJlKnv1mjT4JqBR
   itA3QJyD94cKH77+eX2LnaMxNl/g216tHL2QYnCdz7/972XRDvtp6jBpB
   Q==;
X-CSE-ConnectionGUID: 8w5CcSwXSxaCtwl04uNW5g==
X-CSE-MsgGUID: o1hpaFeQSY2qZXv+Ll/fXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29904811"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29904811"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 01:58:42 -0700
X-CSE-ConnectionGUID: 3xGqxhKITtGP8LFkIYidmQ==
X-CSE-MsgGUID: yStzSllZQA6rLRRdaYPPSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="81657512"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2024 01:58:35 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Nam Cao <namcao@linutronix.de>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg
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
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
Date: Mon, 28 Oct 2024 10:58:34 +0200
Message-ID: <87y128txhh.fsf@ubik.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:

> This is the forth part of a 5-part series (split for convenience). All 5
> parts are:
>
> Part 1: https://lore.kernel.org/lkml/cover.1729864615.git.namcao@linutronix.de
> Part 2: https://lore.kernel.org/lkml/cover.1729864823.git.namcao@linutronix.de
> Part 3: https://lore.kernel.org/lkml/cover.1729865232.git.namcao@linutronix.de
> Part 4: https://lore.kernel.org/lkml/cover.1729865485.git.namcao@linutronix.de
> Part 5: https://lore.kernel.org/lkml/cover.1729865740.git.namcao@linutronix.de

Which one do I need to click on to see the actual hrtimer_setup*()
implementations? Why is it even a separate series? Please, don't make
people click on things.

> To use hrtimer, hrtimer_init() (or one of its variant) must be called, and
> also the timer's callfack function must be setup separately.

"callback", right?

> That can cause misuse of hrtimer. For example, because:
>   - The callback function is not setup
>   - The callback function is setup while it is not safe to do so

These are not examples, these are hypotheticals. Do either of these
things actually happen in the codebase?

> To prevent misuse of hrtimer, this series:
>   - Introduce new functions hrtimer_setup*(). These new functions are
>     similar to hrtimer_init*(), except that they also sanity-check and
>     initialize the callback function.

No, it doesn't. This series only converts some drivers. I'd like to see
the sanity-checking in question, since it's the big selling point.
But IMO, "switching to a cleaner hrtimer API" or some words to that
effect is a better justification than sanity checking.

I'm not objecting to the idea, it's just carried out weirdly.

>   - Introduce hrtimer_update_function() which checks that it is safe to
>     change the callback function. The 'function' field of hrtimer is then
>     made private.

Also not in this series.

>   - Convert all users to use the new functions.
>   - Some minor cleanups on the way.

Thanks,
--
Alex

