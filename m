Return-Path: <linux-kernel+bounces-272225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AE19458CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5451F232F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454EF1C0DCB;
	Fri,  2 Aug 2024 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MVdOPBOv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u9lMUYcr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448281BF33E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722583760; cv=none; b=DBvNY+Dg25G5vypBiNHFa79F6j25L1EUtA3Vn4QhsXbFRgS+BbuJ6+rvgc0eUgpDD30uE5psdxyH1+gtn8S0JWMqQ+5VAHTt35uRyLkHWsEWJGrV9p78wOZ4j2AOXqUeNWJb8egmbNglBaXSeaVeyXkkNQJDjLkojRxwx47gNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722583760; c=relaxed/simple;
	bh=arFmlIssz41HOUi1lzAdhXhOdq1Csd2hQ00qcki2REU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q1oEKv6LhxaDYHKPDkHXAzhLt2pcpznqHnESMu/VRDjdaCE5o6DN/xwARjLm4KwJQAYd5Rr4d/i61ZOtQBvMm5Jsr7F1AQYfA1K02aLgg8KlMtxqjfseByP6DnS6A7eX9KshAE4Vd39Gx+Qow0SkENZWeLypm/Z1CP4b7/mkE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MVdOPBOv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u9lMUYcr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722583758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ji4eNdgoYHTLRIuHuu8oySWq4ekKwNKlmags7l0M/64=;
	b=MVdOPBOv1jRnHbjqYjsEUzxD9Ynl3PZHUiroQneVQDIbDbbkCxksgxPMqkVr6j3MXHkf0I
	fEuxGbMdxJN1xkVfJDMwMzEbWT7yS1yX1wgAJqVfxvHLcmD6bbrVtU31RiNfhmscwAFkeU
	p/lJxqME79zNprUfxXBh7zpT0NVf9TxQJGFW/pT2O1UfYK0gRmV0WG/CB84zdKbQyisqR0
	lshOREU60IHDefOQJx0iGnORKQkKZxmMrXwFTQciRKMH8rs/k6SjWldYhVmH4+tO5qn3OY
	FngtgjysEWCsBmcL5TJOzTOZpM2riaM/U+m0UU+QhRDmwq+oQJhEPYeMDeQwfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722583758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ji4eNdgoYHTLRIuHuu8oySWq4ekKwNKlmags7l0M/64=;
	b=u9lMUYcrfJaYuuAFKVuhwlpU843Q8YaKKR17zY/5O/wWfwwvCt7OSYR1InnanMr/Sx7/cj
	EDd8WF1cjzP177Ag==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: preffer_ofload param: was: Re: [PATCH printk v3 11/19] printk:
 nbcon: Rely on kthreads for normal operation
In-Reply-To: <Zqush2SkFQpYxJ7q@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-12-john.ogness@linutronix.de>
 <ZqpAJgKeB0cIlTg7@pathway.suse.cz> <8734noz5jv.fsf@jogness.linutronix.de>
 <Zqush2SkFQpYxJ7q@pathway.suse.cz>
Date: Fri, 02 Aug 2024 09:35:17 +0206
Message-ID: <87bk2b8jsi.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-01, Petr Mladek <pmladek@suse.com> wrote:
> I believe that the parameter "prefer_offload" adds more harm than good
> because:
>
>    + It is a non-sense for nbcon consoles. They always prefer offload
>      except for emergency and panic. But emergency and panic is
>      handled transparently by nbcon_get_default_prio().
>
>    + It is confusing even for legacy consoles after introducing the
>      kthread. There will be three types of offload:
>
> 	+ do console_lock()/unlock() in IRQ work
> 	+ wake kthread
> 	+ wake kthread in IRQ work

I think the confusion comes from my intention of the function. I wanted
a caller to use it as:

"Tell me how to flush."

This requires input from the caller to know some information about what
the caller's intentions are.

If I change the function so that a caller uses it as:

"Tell me what flush mechanisms are available to me."

Then the function does not need to know the caller's intentions. It only
needs to know the caller's state, and that information is readily
available via global/per-cpu variables.

I will drop the @prefer_offload argument, simplifying the function to
only provide a list of available flush options. The caller will then
decide itself which option it wants to use. I believe this aligns with
your intentions as well.

John

