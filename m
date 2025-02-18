Return-Path: <linux-kernel+bounces-520321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7A3A3A881
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5DE188E608
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBB814A09E;
	Tue, 18 Feb 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExL7F+OT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307C21B9C1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739909804; cv=none; b=ddB9DqbIgCDvKRIjl00HtCVUz45Wu6re41O5kobD9IFTGeQdxh68UimOAQ/3nZ/LWgKIJXlatcj0ZKI0wj5efPkh98Er+x2mibE39qxiPm1g7xJuHT0i6bI81tG+X40V8SEqp/7fB+95HbNC9qrB2nuJJMP2uahQHi7FQBTDMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739909804; c=relaxed/simple;
	bh=idglnYg0w6TMq5/Q3rM+SfsPyprLDYCNh6/Y3wtv4hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6jMpDJUt/r+7AxMpg2XVs24S0QE25LQFiGr1qfOMMpaYEZRyl9gGWobHZECw/RodMndom0GphcqbzJqCs2vO2Vd4191gmS5m7mpV2bWEUPn955cr+aU8XrAeWfESfg30lmiUBb1cGj1WtN+1zHfmxtFxvmFK9wsTgGeWJkbqGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExL7F+OT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739909803; x=1771445803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=idglnYg0w6TMq5/Q3rM+SfsPyprLDYCNh6/Y3wtv4hA=;
  b=ExL7F+OTGUtG2u0EQgyJQleEe8cXK0ZvXVFjlhbf4OhWBIQezvbxJ8xD
   Sn0xpGslSvgn7rz0M5PjF09VDSkCtf8oqNIwfqcjb2AvjeoXmsS/WRAOp
   AM/rYf37R39X7Eivpm20vMyekTjbFHp4WACOfuYxvITQGBF3t1ZfK9WDt
   NsTqm3cNFgbiWmJjP7Eqk/i5QL2RxCxJcrcJRwPVfZx753CqzldlG1wET
   W3jTVgeSDSsDkSrQ07e65rojORtPbwm1o8BLKiqF5gvJMa/Lu0SujoHm1
   1fGAME2myepyjctNVCQ1AxU9iSivfcOkErWtuHL8onaL3DSkHinKZbUuP
   g==;
X-CSE-ConnectionGUID: 3YbUsiLHS8SlauBfGKjZpg==
X-CSE-MsgGUID: nqT2Na4JTmqzgbiL+DiC+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44545046"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="44545046"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 12:16:41 -0800
X-CSE-ConnectionGUID: h6gGLmQ0SoChcMvathSbAQ==
X-CSE-MsgGUID: mY4sdKWhTHuTcOJ+XbY2tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="115155567"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.109.220]) ([10.125.109.220])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 12:16:40 -0800
Message-ID: <1aee0888-b87b-443c-84fa-3bc000cbebcf@intel.com>
Date: Tue, 18 Feb 2025 12:16:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] x86/microcode/intel_staging: Implement staging logic
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
 <20241211014213.3671-5-chang.seok.bae@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20241211014213.3671-5-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remember that the subject prefixes are logical areas of the code, not
filenames.

Bad:

	x86/microcode/intel_staging

Good:

	x86/microcode/intel


On 12/10/24 17:42, Chang S. Bae wrote:
> The staging firmware operates through a protocol via the MMIO interface.
> The protocol defines a serialized sequence that begins by clearing the
> hardware with an abort request. It then proceeds through iterative
> process of sending data, initiating transactions, waiting for processing,
> and reading responses.

I'm not sure how much value this adds. It's rehashing a few things that
are or should be blatantly obvious from the code.

For instance, mentioning that it's an "MMIO interface" is kinda obvious
from the ioremap() and variable named "mmio_base".

> To facilitate this interaction, follow the outlined protocol. Refactor
> the waiting code to manage loop breaks more effectively. Data transfer
> involves a next level of detail to handle the mailbox format. While
> defining helpers, leave them empty for now.

I'm not sure what's being refactored here.


> --- /dev/null
> +++ b/arch/x86/kernel/cpu/microcode/intel_staging.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#define pr_fmt(fmt) "microcode: " fmt
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +
> +#include "internal.h"
> +
> +#define MBOX_REG_NUM		4
> +#define MBOX_REG_SIZE		sizeof(u32)
> +
> +#define MBOX_CONTROL_OFFSET	0x0
> +#define MBOX_STATUS_OFFSET	0x4
> +
> +#define MASK_MBOX_CTRL_ABORT	BIT(0)
> +
> +#define MASK_MBOX_STATUS_ERROR	BIT(2)
> +#define MASK_MBOX_STATUS_READY	BIT(31)
> +
> +#define MBOX_XACTION_LEN	PAGE_SIZE
> +#define MBOX_XACTION_MAX(imgsz)	((imgsz) * 2)

The MBOX_XACTION_MAX() concept needs to be explained _somewhere_. The
concept as I remember it is:

	Each image is broken up into pieces which are at most
	MBOX_XACTION_LEN in length. So a 10*MBOX_XACTION_LEN
	will need at least 10 actions. The hardware on the other side of
	the mbox has very few resources. It may not be able to cache the
	entire image and may ask for the same part of the image more
	than once. This means that it may take more than 10 actions to
	send a 10-piece image. Allow a 10-piece image to try 20 times to
	send the whole thing.

Can we comment that here or in the loop?

That's a rather verbose comment, but it is a kinda complicated thing. I
remember trying to talk the hardware guys out of this, but they were
rather insistent that it's required. But in the end it does make sense
to me that the (relatively) svelte device on the other end of this
mailbox might not have megabytes of spare storage and it's a relatively
simple thing to have the CPU send some data more than once.

> +#define MBOX_XACTION_TIMEOUT	(10 * MSEC_PER_SEC)

I find these a lot more self-explanatory when they gave units on them.

#define MBOX_XACTION_TIMEOUT_MS	(10 * MSEC_PER_SEC)

plus:

	for (timeout = 0; timeout < MBOX_XACTION_TIMEOUT_MS; timeout++)
		msleep(1);

makes it a bit more obvious why there's an msleep(1) if the timeout is
obviously in milliseconds in the first place.

> +#define STAGING_OFFSET_END	0xffffffff

Should this get an explicit type?

> +static inline void abort_xaction(void __iomem *base)
> +{
> +	writel(MASK_MBOX_CTRL_ABORT, base + MBOX_CONTROL_OFFSET);
> +}
> +
> +static void request_xaction(void __iomem *base, u32 *chunk, unsigned int chunksize)
> +{
> +	pr_debug_once("Need to implement staging mailbox loading code.\n");
> +}

Can we comment this a little more please?

/*
 * Callers should use this after a request_xaction() to handle
 * explicit errors or timeouts when the hardware does not respond.
 *
 * Returns UCODE_OK on success.
 */
> +static enum ucode_state wait_for_xaction(void __iomem *base)
> +{
> +	u32 timeout, status;
> +

	/* Give the hardware time to perform the action: */

> +	for (timeout = 0; timeout < MBOX_XACTION_TIMEOUT; timeout++) {
> +		msleep(1);
> +		status = readl(base + MBOX_STATUS_OFFSET);

		/* Break out early if the hardware is ready: */
> +		if (status & MASK_MBOX_STATUS_READY)
> +			break;
> +	}
> +
> +	status = readl(base + MBOX_STATUS_OFFSET);

	/* The hardware signaled an explicit error: */
> +	if (status & MASK_MBOX_STATUS_ERROR)
> +		return UCODE_ERROR;

	/*
	 * Hardware neither responded to the action nor
	 * signaled an error. It must be out to lunch.
	 */
> +	if (!(status & MASK_MBOX_STATUS_READY))
> +		return UCODE_TIMEOUT;
> +
> +	return UCODE_OK;
> +}
> +
> +static enum ucode_state read_xaction_response(void __iomem *base, unsigned int *offset)
> +{
> +	pr_debug_once("Need to implement staging response handler.\n");
> +	return UCODE_ERROR;
> +}
> +
> +static inline unsigned int get_chunksize(unsigned int totalsize, unsigned int offset)
> +{
> +	WARN_ON_ONCE(totalsize < offset);
> +	return min(MBOX_XACTION_LEN, totalsize - offset);
> +}

I honestly forgot what this is trying to do. Is it trying to break up a
"totalsize" action into pieces that are at most MBOX_XACTION_LEN bytes
in size? But it is also trying to ensure that if it has 10 bytes left
that it doesn't try to request MBOX_XACTION_LEN?

Also, "chunk_size", please. "chunksize" is a bit less readable.

> +enum ucode_state do_stage(u64 pa, void *ucode_ptr, unsigned int totalsize)

"totalsize" is the length of the data at 'ucode_ptr', right? Would the
connection be clearer if we had:

	void *ucode_ptr,
	int ucode_len_bytes);

? Or even "ucode_len"?

> +{

Could we rename "pa" to "mmio_pa", please? It makes it much more clear
that it's not the "pa" of ucode_ptr or something.

> +	unsigned int xaction_bytes = 0, offset = 0, chunksize;
> +	void __iomem *mmio_base;
> +	enum ucode_state state;
> +
> +	mmio_base = ioremap(pa, MBOX_REG_NUM * MBOX_REG_SIZE);
> +	if (WARN_ON_ONCE(!mmio_base))
> +		return UCODE_ERROR;
> +
> +	abort_xaction(mmio_base);

Why is this aborting first? Why doesn't it have to wait for the abort to
complete?

> +	while (offset != STAGING_OFFSET_END) {
> +		chunksize = get_chunksize(totalsize, offset);
> +		if (xaction_bytes + chunksize > MBOX_XACTION_MAX(totalsize)) {
> +			state = UCODE_TIMEOUT;
> +			break;
> +		}

So, "xaction_bytes" is the number of bytes that we tried to send. If it
exceeds MBOX_XACTION_MAX(), then too many retries occurred. That's a
timeout.

Right?

I don't think that's obvious from the code.

> +
> +		request_xaction(mmio_base, ucode_ptr + offset, chunksize);
> +		state = wait_for_xaction(mmio_base);
> +		if (state != UCODE_OK)
> +			break;
> +
> +		xaction_bytes += chunksize;
> +		state = read_xaction_response(mmio_base, &offset);
> +		if (state != UCODE_OK)
> +			break;
> +	}

So, a dumb me would look at this loop and expect it to look like this:

	while (need_moar_data) {
		if (too_many_retries())
			break;

		send_data();
	}

But it doesn't. There's a two-step process to send data, make sure the
device got the data, and then read a separate response.  It _seems_ like
it's double-checking the response.

Could we comment it something more like this to make that more clear?

	while (need_moar_data) {
		if (too_many_retries())
			break;


		/* Send the data: */
		ret = hw_send_data(offset);
		if (ret)
			break;

		/*
		 * Ask the hardware which piece of the image it needs 	
		 * next. The same piece may be sent more than once.
		 */
		ret = hw_get_next_offset(&offset);
		if (ret)
			break;
	}


