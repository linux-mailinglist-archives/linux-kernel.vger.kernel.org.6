Return-Path: <linux-kernel+bounces-313637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B795196A7F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E2C1F250C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3640C1DC75D;
	Tue,  3 Sep 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yphSwjfe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="za3HoJvd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1794174C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393710; cv=none; b=MLRwfjAv5gI44muEe4wjmkQxzdcqpzj811MAywn/Svs50SPM8mPgmCrOFYx/7cXfq4ZMbq0rFsb11geBLFmN5MDGIg7ieLZHug7W3rdi8CsjRYkpsh9NV/gXzIFd3pFHy5WqmsqxNcQIL5rqC4YtY0WYYJhPKvDLt8QGAZrmzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393710; c=relaxed/simple;
	bh=TrPaM5+CXKayRP35YFVm4Vt/gM6SWRYqzmM/YZC3YFc=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=GZTVNO7APHFiYcE66E5V36zY309tLX66CJr5PS1A0Mpp0HvndZbwNP/+lILU+SEH5fxyj4q9XRjOmyJqOCi1W/NEzer5i5mYCgtAmGR1mSE2ZP/HnZUpEJFdW47Z9pesfz85FM0G4vZDgczLmMOmPej5qXraVyXrLqdszI3gaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yphSwjfe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=za3HoJvd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725393706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=YPAn5r9CfAM+azpnz25ZNuWW1kaosDPI+T9/w7whZIQ=;
	b=yphSwjfe8lGGLFMhideC37G8+j5eEDPoTIv+7VDc6QLka8Q86J2Z+4WMDWOAiyYF+fch2e
	l6VCosL/8AyLOlx01+VAIZ5FQYcigk9MJHjfuEWW5Kqx3DXSMIdxDHwhkNWz/6N9QbDLSG
	yhI7mhbQfPrSoVhXJ3/pRMTr7az6sB9lM4Q+ASr1WnnwkJPyHluOHRBH4cbvSjxaRbqbtF
	spXr2Kc+K8/q5uT0lQalsOBpu91qgOj0/DUnt8fK2VHa/dCcs9EsnWZlE7AgKCSybRlK+9
	prsf8HpG5x0pHjFvLIBFQcB9N2qcSShN8x81LP76S8BYzhJ9ZeIB7k5qjmMPUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725393706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=YPAn5r9CfAM+azpnz25ZNuWW1kaosDPI+T9/w7whZIQ=;
	b=za3HoJvdq+Awfz5ys+aBBe20naMZwTpyw+qsqpLI7I65PYNRC0bFQApqIhchufjc6YqxIx
	wOwD8E1HdIaLEwAA==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
 "Peter Zijlstra
 (Intel)" <peterz@infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH] static_call: Fix a wild-memory-access bug in
 static_call_del_module()
In-Reply-To: <0f339f49-bb8d-e28d-c9d6-8f16bd62995d@huawei.com>
Date: Tue, 03 Sep 2024 22:01:45 +0200
Message-ID: <87y1487bh2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 02 2024 at 20:01, Jinjie Ruan wrote:
> On 2023/9/15 16:21, Jinjie Ruan wrote:
>> 
>> diff --git a/kernel/static_call_inline.c b/kernel/static_call_inline.c
>> index 639397b5491c..e7aa70d33530 100644
>> --- a/kernel/static_call_inline.c
>> +++ b/kernel/static_call_inline.c
>> @@ -256,8 +256,10 @@ static int __static_call_init(struct module *mod,
>>  			}
>>  
>>  			site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
>> -			if (!site_mod)
>> +			if (!site_mod) {
>> +				key->mods = NULL;
>>  				return -ENOMEM;

You fail to explain what setting key->mods to NULL prevents and why the
same problem does not happen when the kzalloc() five lines further down
fails.

Actually if you read the comment below carefully then you might find the
reason why the current code explodes and you might figure out why you
can't set the pointer to NULL.

>> +			}
>>  
>>  			/*
>>  			 * When the key has a direct sites pointer, extract
>> @@ -422,7 +424,7 @@ static void static_call_del_module(struct module *mod)
>>  			;
>>  
>>  		if (!site_mod)
>> -			continue;
>> +			break;

Now why does this "fix" things?

The unmodified kernel crashes dereferencing key->mods. That means there
is garbage in key->mods. But that garbage is not garbage:

struct static_call_key {
	void *func;
	union {
		/* bit 0: 0 = mods, 1 = sites */
		unsigned long type;
		struct static_call_mod *mods;
		struct static_call_site *sites;
	};
};

key->mods is actually key->sites, which holds the static call sites of
the key. It has bit 0 set.

As that code does not expect anything else than a valid static_call_mod
pointer it dereferences it unconditionally and crashes. See?

So why can't you set the pointer to NULL?

If that key is builtin and has actual builtin usage sites, then you
destroy the key. If the memory allocation fail was temporary then a
subsequent update of that static call will find no call site and the
kernel happily invokes the previous function.

Now that the root cause is properly analyzed, the proper fix is
obvious. See uncomplied below.

It does not need to do anything vs. the other kzalloc() fail because
that is harmless. The key has key->mods set, but key->mods->mod and
key->mods->next are both NULL in that case. So the inner loop breaks out
and continues to the next site which has the uninitialized one. If all
keys were already converted to mods _before_ this fail then the loop
simply iterates further, but will nowhere find a site_mod->mod == mod.

Thanks,

        tglx
---
--- a/kernel/static_call_inline.c
+++ b/kernel/static_call_inline.c
@@ -411,6 +411,17 @@ static void static_call_del_module(struc
 
 	for (site = start; site < stop; site++) {
 		key = static_call_key(site);
+
+		/*
+		 * If the key was not updated due to a memory allocation
+		 * failure in __static_call_init() then treating key::sites
+		 * as key::mods in the code below would cause random memory
+		 * access and #GP. In that case all subsequent sites have
+		 * not been touched either, so stop iterating.
+		 */
+		if (static_call_key_sites(key))
+			break;
+
 		if (key == prev_key)
 			continue;


