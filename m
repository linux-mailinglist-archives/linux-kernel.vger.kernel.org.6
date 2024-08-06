Return-Path: <linux-kernel+bounces-277090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25222949C44
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927F91F22F55
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9EF175D5F;
	Tue,  6 Aug 2024 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DGDjiH1X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oslLGRgO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB20158DC0;
	Tue,  6 Aug 2024 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986655; cv=none; b=sM9ZsS7y/wLg8Vb8cpGAG0FyEj+DI4bIfvkDd3kUKoIBPfvn86mL7jr8UIdtTpIS6TuN+viU9FLp43j9fhIbTiotMGLE5n5zCDmSs+m56F6mudUQysVrEpDlXE+mg+aHBItCYHJj/r6BP0+8em/N++8C9xedoLUtlYC2uDZTLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986655; c=relaxed/simple;
	bh=18Sxpdx4lVcJt9lQoC20MlzTq8vPCXIXtETa2CIv9Zk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M1T/STWItQ8U50roItqiH6jzIvutjNFi2YMf+BRngoz2XAGzkSnf1PU2+nEHDYGbHhkUO8eLAKRyehAFeDaLpl2JQRZmgV5RxlJRhONTvhIoR/hPXG1q6fv7StJKuu6enHuS5n7KmdPakJnG9VgqT+CEzodxAQQLjkNivL/kLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DGDjiH1X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oslLGRgO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722986649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twL9kWG4LmZQWC4HjggAN439garSwXGMqnD/GVecd+I=;
	b=DGDjiH1XLzRi59gVCKqDNkZCvNanFv5lW3G95DgP9y2uPdcagLkxrEJWeBSrWy1y8PNfZn
	TKLT0dAKTWa+/Im8JxykhqgIZcBmXgZQ1M/D5V+ERfsmRfc0smUxBxe+B3eXMSdPCBfUWa
	qpzL3GVjt0bqkokLMte+8WGfDXIGx6GvbuX4JZ8AGxIbVk+7DnuzAKdap5iJUNV0Za+DRz
	RZB50pwrFuAf3I3ZGrbB8Jtpzscv/8+QQTMsf9eNtLLENAzSwlwV4WUzRZoVm8NG9KWvAh
	48YQ+2KoeLeHVubBeUyhiWUriHZq9WqkYT0UuNsDAM+DAe/PR6fAh6sqgDfJRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722986649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twL9kWG4LmZQWC4HjggAN439garSwXGMqnD/GVecd+I=;
	b=oslLGRgOnW67BsgwFNBCu+wQXX4TVepHYAs7A/D1yLZR9L0C7S0YyTukY0D73mu1rmvZk4
	HDkt/HPOLaLpupBQ==
To: Vlastimil Babka <vbabka@suse.cz>, Linus Torvalds
 <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Helge
 Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
In-Reply-To: <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz>
Date: Wed, 07 Aug 2024 01:24:08 +0200
Message-ID: <87frrh44mf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cc+: Helge, parisc ML

We're chasing a weird failure which has been tracked down to the
placement of the division library functions (I assume they are imported
from libgcc).

See the thread starting at:

  https://lore.kernel.org/all/718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net

On Tue, Aug 06 2024 at 21:25, Vlastimil Babka wrote:
> On 8/6/24 19:33, Thomas Gleixner wrote:
>> 
>> So this change adds 16 bytes to __softirq() which moves the division
>> functions up by 16 bytes. That's all it takes to make the stupid go
>> away....
>
> Heh I was actually wondering if the division is somhow messed up because
> maxobj = order_objects() and order_objects() does a division. Now I suspect
> it even more.

check_slab() calls into that muck, but I checked the disassembly of a
working and a broken kernel and the only difference there is the
displacement offset when the code calculates the call address, but
that's as expected a difference of 16 bytes.

Now it becomes interesting.

I added a unused function after __do_softirq() into the softirq text
section and filled it with ASM nonsense so that it occupies exactly one
page. That moves $$divoI, which is what check_slab() calls, exactly one
page forward:

    -0000000041218c70 T $$divoI
    +0000000041219c70 T $$divoI

Guess what happens? If falls on it's nose again.

Now with that ASM gunk I can steer the size conveniently. It works up
to:

    0000000041219c50 T $$divoI

and fails for

    0000000041219c60 T $$divoI
    0000000041219c70 T $$divoI

and works again at

    0000000041219c80 T $$divoI

So I added the following:

+extern void testme(void);
+extern unsigned int testsize;
+
+unsigned int testsize = 192;
+
+void __init testme(void)
+{
+	pr_info("TESTME: %lu\n", PAGE_SIZE / testsize);
+}

called that _before_ mm_core_init() from init/main.c and adjusted my ASM
hack to make $$divoI be at:

    0000000041219c70 T $$divoI

again and surprisingly the output is:

    [    0.000000] softirq: TESTME: 21

Now I went back to the hppa64 gcc version 12.2.0 again and did the same
ASM gunk adjustment so that $$divoI ends up at the offset 0xc70 in the
page and the same happens.

So it's not a compiler dependent problem.

But then I added a testme() call to the error path and get:

[    0.000000] softirq: TESTME: 21
[    0.000000] =============================================================================
[    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16 size 192 sorder 0

Now what's wrong?

Adding more debug:

[    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16 size 192 sorder 0 21

where the last '21' is the output of the same call which made maxobj go
south:

 static int check_slab(struct kmem_cache *s, struct slab *slab)
 {
 	int maxobj;
@@ -1386,8 +1388,10 @@ static int check_slab(struct kmem_cache
 
 	maxobj = order_objects(slab_order(slab), s->size);
 	if (slab->objects > maxobj) {
-		slab_err(s, slab, "objects %u > max %u",
-			slab->objects, maxobj);
+		testme();
+		slab_err(s, slab, "objects %u > max %u size %u sorder %u %u",
+			 slab->objects, maxobj, s->size, slab_order(slab),
+			 order_objects(slab_order(slab), s->size));
 		return 0;
 	}
 	if (slab->inuse > slab->objects) {

I don't know and I don't want to know TBH...

Thanks,

        tglx

