Return-Path: <linux-kernel+bounces-269473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D646D943328
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9289928691C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234317993;
	Wed, 31 Jul 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wgZ7BFsJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OC1OpGYM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781417591
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439512; cv=none; b=GfRuS8cubCp/6dHOyi0yDx6JhahlZirtsNX+74KA11Eg4I65AAEFQrlkLhCum/1I6+ohvO5HQnM88IiLd0a4/qpwUmLa046jp0qeAXUQ9XaSwifz9EDtMNbh93f2iTywxj0XkRbgw+6GUpT8QaB8HFnJvYuETZluM6eUniykc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439512; c=relaxed/simple;
	bh=MFBM6Ihkcvrvx1lmzqXm1xGPwf8T2lGFbHcnoc2Ci5k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qaL44F1LxuB+iUvpWqxu8JKbwwneT1FefiLa6aAmHt4mEfJIXABkOMmCQ2YnUHYyZ29moO3eTYfkNrAbg9u+Md/OvHWWUBZbxp35BihZ/qYx6mF6VOQSdbZSSrUA9iaPQpeAKPyDl4EDBhZYjHjUWbKI0kjjTwPUKRZW0fvsryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wgZ7BFsJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OC1OpGYM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722439503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnJq/uUeS4DFMUFjWZQFDR1vfc9pcpMjnLUl2iGWw7s=;
	b=wgZ7BFsJKIwjS/zGFkQUA1Wl7aaQptF5N0pwvKcCFgLUwSjrtxV5kZvvXZWL/I07TqLkdi
	XNIYO77ycf+lp+G73ShnieSIO8EG7uNdQP0/i2O8nwjX7dqZOerzzPuBp5OlAZCfSKUq0K
	oZm2x7M0B8OlmI9d4zpISM76P5C7j/b3hTq5M1iCxWhNN5/Rd5woFq/kYuW1ikB2jJkuaY
	j4xmVY5wQJ0CwGhiyccI3ISK/1rR0FWbTlYT9KmT6tVqASjJQOY5sxyGfVclhtyjYbK3w+
	SfjJPp8BXp8G6qRf9Zgcec57riSfp3TwBw+O0yg5ilmKLhl6pIUnaTNYBkMu1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722439503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XnJq/uUeS4DFMUFjWZQFDR1vfc9pcpMjnLUl2iGWw7s=;
	b=OC1OpGYM931u8Ni2/izQu6LFE78PTWXE2twOV6I5jyQ1dTWMtfBn6wh1xkv99cK6BsauBY
	L0jPCjRHWP0oWcDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 11/19] printk: nbcon: Rely on kthreads for
 normal operation
In-Reply-To: <ZqpE9urpKZxv4Ks3@pathway.suse.cz>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
 <20240722171939.3349410-12-john.ogness@linutronix.de>
 <ZqpE9urpKZxv4Ks3@pathway.suse.cz>
Date: Wed, 31 Jul 2024 17:31:02 +0206
Message-ID: <87plqtlh2p.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-31, Petr Mladek <pmladek@suse.com> wrote:
>> @@ -4102,8 +4139,10 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>>  			 * that they make forward progress, so only increment
>>  			 * @diff for usable consoles.
>>  			 */
>> -			if (!console_is_usable(c, flags, true))
>> +			if (!console_is_usable(c, flags, true) &&
>> +			    !console_is_usable(c, flags, false)) {
>
> This looks weird. nbcon console can't make progress when
> "write_atomic" is not implemented and the kthreads are not
> running.
>
> I should be:
>
> 			if (!((console_is_usable(c, flags, true)) ||
> 			      (console_is_usable(c, flags, false) && printk_kthreads_running))) {

I would prefer to have the printk_kthreads_running check within
console_is_usable() for the !use_atomic case.

> That said. Do we really want to support nbcon consoles without
> @write_atomic() callback?

We must. Graphic consoles will not be able to implement
write_atomic(). Network and USB consoles probably will not be able to
implement it either.

John

