Return-Path: <linux-kernel+bounces-279830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D76494C25B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A225B24087
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B318FC8C;
	Thu,  8 Aug 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QBah4X24";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKgKnf0X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD28003F;
	Thu,  8 Aug 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133529; cv=none; b=j/pPNDz1pszfDJHfkmdNi3a5FPmIU87fUz32AWoh4aj977glbfZcYs7T1BMMJD+LVZ7emENNKoPgcoxrNLUIsMfGcTKiOY3auX995c4SGIag9AaVKTHPCoIEeRqrQgrPORYMrmlgM4do70qylZHNi9Tm5dJELPepTC39xw4L4wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133529; c=relaxed/simple;
	bh=NBOphetkuK1QDK/ZU1SMUqcKu9vqXMvp2ldGj9c2lno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uAwJKnWYIWR//xe4p0FxxerFzN63ZqvGFFZCOD3EuN0QOJQRZ2RT8h7magLGSlGwW1ogvm3yBzQMG3c/pO0tXbXYWbEmBJ1KN7wAXGFzuSBQtsCJ7qkE6tjf7PMa45SwMBTed+gqR03gJiQj3aZFupoHNEs7/oRSI2qHTgVTvVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QBah4X24; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKgKnf0X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723133525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rbK1kwOMlzSlhFlVjG+CRVMzNiTCxjOS9hUbnipGmdo=;
	b=QBah4X243vmf/D1560ypXArNinqDTFJcnqMuKQQxQLAtNK0yQh3WrNjRNe84QFqLu4iW25
	bOVgqcleOOWm9RPUcFfXhO3JuOR7YMR2Ydq+mBm+AlVceevQpQ16NBr0btw09FCyCMK2P7
	QOgfwpxqLgBrEuvBDVeAV7b0nJJ+cGDzVcUISm7NqVW1DDRJmwNAuk9340KlRcPFdrPBUd
	aKTtcvUdWo+wS91hlqnCroVOaQ/spdxusG0GY567a3WPMN0gM6vYpJl2M4vakW7TUF60Hs
	TJd5onynjl2X7pelfBjY1I62qz5ynp7rqZ7UMwZxCmBXqvrcxReI3kB8WSb/rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723133525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rbK1kwOMlzSlhFlVjG+CRVMzNiTCxjOS9hUbnipGmdo=;
	b=bKgKnf0XUFwW6ZAvvBYIPk8zC6dvtPVqkOyOoVKmXPtDHmwoGA38WJqwoqqzqwQ0Ba+/ni
	zFY84uSmrFVwHkDQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
In-Reply-To: <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
Date: Thu, 08 Aug 2024 18:12:05 +0200
Message-ID: <87a5hnyox6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 08 2024 at 08:53, Linus Torvalds wrote:
> On Thu, 8 Aug 2024 at 02:57, Thomas Gleixner <tglx@linutronix.de> wrote:
> Hmm. There's a few patterns there:
>
>  - the incorrect Maxobj is always 16, with wildly different sizes.

Which means that the size value is rounded up to the next power of 2

>> [    0.000000] Order: 1 Size:  384 Nobj: 21 Maxobj: 16 21 Inuse: 14

   8192/16 = 512

>> [    0.000000] Order: 0 Size:  168 Nobj: 24 Maxobj: 16 24 Inuse:  1

   4096/16 = 256

>> [    0.000000] Order: 3 Size: 1536 Nobj: 21 Maxobj: 16 21 Inuse:  1

  32768/16 = 2048

>> The maxobj column shows the failed result and the result from the second
>> invocation inside of the printk().

> I actually went into the gcc sources to look at the libgcc routines
> for the hppa $$divU routine, but apart from checking for trivial
> powers-of-two and for divisions with small divisor values (<=17), all
> it is ends up being a series of "ds" (divide step) and "addc"
> instructions. I don't see how that could possibly mess up. It does end
> up with the final addc in the delay slot of the return, but that's
> normal parisc behavior (and here by "normal" I mean "it's a really
> messed up instruction set that did everything wrong, including branch
> delay slots")
>
> I do note that the $$divU function (which is what this all should use)
> oddly doesn't show up as defined in 'nm' for me when I look at
> Guenter's vmlinux file. So there's some odd linker thing going on, and
> it *only* affects the $$div* functions.
>
> Thomas' System.map shows some of the same effects, ie it shows $$divoI
> (signed integer divide with overflow checking), but doesn't show
> $$divU that is right after it. The reason I was looking was exactly
> because this should be using $$divU, and clearly code alignment is
> implicated somehow, but the exact alignment of $$divU wasn't obvious.
>
> But it looks like "$$divU" should be somewhere between $$divoI and
> $$divl_2, and in Guenter's bad case that's
>
>   0000000041218c70 T $$divoI
>   00000000412190d0 T $$divI_2
>
> so *maybe* $$divU is around a page boundary? 0000000041218xxx turning
> into 0000000041219000?

It uses $$divU which is at $$divoI + 0x250. I validated that in the
disassembly.

Thanks,

        tglx


