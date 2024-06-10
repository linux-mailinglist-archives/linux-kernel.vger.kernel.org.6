Return-Path: <linux-kernel+bounces-208690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B88C90282C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF02C1F23718
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3454757E3;
	Mon, 10 Jun 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XlTQC4ud";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7Cpm8oq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF311C92
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042440; cv=none; b=iBnhkNnIR1YK7LlxHJ2nMuZTKdiSHEGGU3AC8iSAYFm8BeyU8k9c+ZlJ3BN2DAA+BBpSTTyIaJFeUpaCemvANXnpTzf5lkVqDM+qdCHBSbOCNWvgbFdxvAqEaxwj94fH3egY1a22pDE9ApsQgXKK6wGuOLCj6fvRV0jS2JDs7fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042440; c=relaxed/simple;
	bh=Kzud7mDi/sRVDiToDacdZFm99lOJUCh1GoEbWtF9/G4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d99UJJ+OTwUfR9e5ua7MmwhITWngCKk5IqSwlkwruNywKQzB9ejUvvcR9A8W/Z20f/HYyVKJ/qfOEFdGM72c71/L10YOtozhm+I6EBPr5VYqgBKD+/3q/26b7xrpet6uQRdA6ynGTUuT6HzepJU9Up5fihf/8D/1wwlE1DugpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XlTQC4ud; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v7Cpm8oq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718042436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu3gjdhgicAYVTH3FjaDJi2aUNwjyAypvLFcNgDGEeM=;
	b=XlTQC4udf7OvxxOGii4XvwDLYiYQ0jiFvnlq29trCdSsx/PDvWUdQmZLMyiAICl1/dTwLv
	Tg/saumcZbx60LvZ6LUQ1xu5n9feC71sG9eTQhq57wSGyRODPypYLl7+qhVKKo3g7ees0O
	ZQvCQAuTYuC5trNw6wuvAm2BuXmYRsNW51NEWQv3ZA/LyAgYtXN/ReOcxY7bN5W2FqoAn/
	OG0Alwe+kQcQCV4fsat19lrMJ5OF9iW5aubA6aMWw5PzTR/E5hoM80YsoBumZW46HwvVnB
	d8ctED8pwDDXxM5dl5AdGWLzXkk7hYSEXZwcjQHRzEJz+R3PuJpQofxnwapD8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718042436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu3gjdhgicAYVTH3FjaDJi2aUNwjyAypvLFcNgDGEeM=;
	b=v7Cpm8oq11qJFQnlu7iKc+nZF2wazM26YmV1401nkSJ0LE6Fo7ep8mdhhMhvd6oGRvVoBS
	QrSe2sqyFfD/imDw==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Sam Sun <samsun1006219@gmail.com>, x86@kernel.org,
 syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Subject: Re: [patch 2/4] jump_label: Fix concurrency issues in
 static_key_slow_dec()
In-Reply-To: <20240610175756.GU8774@noisy.programming.kicks-ass.net>
References: <87bk49xf15.ffs@tglx> <20240610124258.109097511@linutronix.de>
 <20240610124406.422897838@linutronix.de>
 <20240610175756.GU8774@noisy.programming.kicks-ass.net>
Date: Mon, 10 Jun 2024 20:00:36 +0200
Message-ID: <87cyoowud7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 10 2024 at 19:57, Peter Zijlstra wrote:
> On Mon, Jun 10, 2024 at 02:46:36PM +0200, Thomas Gleixner wrote:
>
>> @@ -247,20 +247,25 @@ EXPORT_SYMBOL_GPL(static_key_disable);
>>  
>>  static bool static_key_slow_try_dec(struct static_key *key)
>>  {
>> +	int v;
>>  
>>  	/*
>> +	 * Go into the slow path if key::enabled is less than or equal than
>> +	 * one. One is valid to shut down the key, anything less than one
>> +	 * is an imbalance, which is handled at the call site.
>> +	 *
>> +	 * That includes the special case of '-1' which is set in
>> +	 * static_key_slow_inc_cpuslocked(), but that's harmless as it is
>> +	 * fully serialized in the slow path below. By the time this task
>> +	 * acquires the jump label lock the value is back to one and the
>> +	 * retry under the lock must succeed.
>
> Harmless yes, but it really should not happen to begin with. If this
> happens it means someone wants to disable a key that is in the middle of
> getting enabled for the first time.
>
> I'm tempted to want a WARN here instead. Hmm?

No strong opinion

