Return-Path: <linux-kernel+bounces-312657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC105969970
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD00CB23F81
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E549B1A0BE5;
	Tue,  3 Sep 2024 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wt8jASzD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BSHiE6CA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047971A0BE1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356665; cv=none; b=S2FKrLrvNt986N28rU0k2idPygj/jkt8DIxQ55SC1BhivuKTSKLR8Ejo87Aqf+cTnJVNasQ1aDY3uMcladn/ZD96ZlGv69X+uIffuZl0fZJf6SlvPrZkzEyvIe9sztgmTll2Yx+lf5vpcBy+VUrrFOFQ9m2Zqz7AwIO4t69wAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356665; c=relaxed/simple;
	bh=bPGdF8a2tyJPTyOudhPZvnhr2VAPyeqH5gmgx3NRxFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VZmkA8zvt6Eqd79lcA0ZCGbDTRlrYubd966L6+AGmntcisZyFRg6QXHIHRSffKQjk75g4t3lMq3L76363auI7053GFMI6eWpZpKVJN5yB1ez+Om51mgT851SDkXZY4GKb3Sd3FWWVb+55vxnw7WGAtbABFBh8jT0IQvdE2siSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wt8jASzD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BSHiE6CA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725356662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KeFgQo6KaBROlBqh3WGf4AVHQye9DC7wuYdNQ5DHOtI=;
	b=wt8jASzDd6gh5TSeogH+gCWCnVOD+JfB4DDEK6UEkVR6+qYaoR05c1Mp+Rj7u39Gtr9X1C
	ffp4Xk2dcYakOB8YTBVzzxDDJuar4wJXvZXXvnDb76yAD3gCm4gCUPEqYGZWSbZ6/k9Tx0
	2bANEz7CxS2xiDq/dPJ89UkeZopEUiRFRetSweLrOAR/TQJBZgz4EbUEnOHN/s5N6HjX8j
	5+H7GT1Bw/9HkNyXJyq7WpAaxkhB69NmAL9+n6BlimeI0T1A85vs8VEXb5lqqwcbeS2nWD
	9XX9ZfdEo/clfJ7e8QXZmTeGMvHGdXw07HJAVyZ1Zd38JZEA9r/13lt/uEfNqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725356662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KeFgQo6KaBROlBqh3WGf4AVHQye9DC7wuYdNQ5DHOtI=;
	b=BSHiE6CAqGEe1Mw5jl6Jkm5NhqU7Rm30GvdcUN9rT6pafSjg4fmX9j4xse/2ULMWOII20F
	atuOIFBUlTvccGAA==
To: Zhen Lei <thunder.leizhen@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 2/5] debugobjects: Remove redundant checks in fill_pool()
In-Reply-To: <20240902140532.2028-3-thunder.leizhen@huawei.com>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-3-thunder.leizhen@huawei.com>
Date: Tue, 03 Sep 2024 11:44:21 +0200
Message-ID: <87plpl8422.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 02 2024 at 22:05, Zhen Lei wrote:
> The conditions for the inner and outer loops are exactly the same, so the
> outer 'while' should be changed to 'if'. Then we'll see that the
> second

We'll see nothing. Please write change logs in passive voice and do not
try to impersonate code.

> condition of the new 'if' is already guaranteed above and can be
> removed.

Yes, the conditions are the same. But a 'if' is not the same as a 'while'.

So you need to explain why the outer loop is not required and why it
does not make a difference in terms of functionality.

> @@ -142,8 +142,7 @@ static void fill_pool(void)
>  	 * READ_ONCE()s pair with the WRITE_ONCE()s in pool_lock critical
>  	 * sections.
>  	 */

The comment does not make sense anymore. Please fixup comments when
changing the code. It's a pain to read a comment and then see that the
code does something different.

> -	while (READ_ONCE(obj_nr_tofree) &&
> -	       READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
> +	if (READ_ONCE(obj_nr_tofree)) {
>  		raw_spin_lock_irqsave(&pool_lock, flags);
>  		/*
>  		 * Recheck with the lock held as the worker thread might have

Thanks,

        tglx

