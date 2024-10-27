Return-Path: <linux-kernel+bounces-383542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BFC9B1D0C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F4A1C20BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885BE136327;
	Sun, 27 Oct 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HvTiRPjD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avM1gUEr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020613D531
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730023299; cv=none; b=fP4wew9R7tXgpBbDE7SZKTiNc4msOrq0NvvxXYrv7ieYVF0ZLJJ8HSb+dA3Lqi0wkDTjOI6Gv+ckuTOCOBSrtbpSoJ6cW0rEwL3TQ7gy+gLgxmsHsfOPiVipriP5snkyw8U0mut9HLR5DuN6+sgGXMy7DcVkAIPdkvZF+vNWg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730023299; c=relaxed/simple;
	bh=VwOS3aKEnjqgGuo1ahQYpJ7O1V3XSOZ6/1d2ffvlL58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SleThFprXEKeKPa2iNn7uSLK5nTzJ50t+norzdAwiaaNHzN/U2lREmMwCF1qTgnY+yENSutFf3NLzHj8on3AwyRhSZ+jHwNbUefUu5uif2SV09s8zP7MfffVsHj+Be6haFeK5AYaszxsF6mNqsh6egerptxY57/Lr+6sGRA7jII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HvTiRPjD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avM1gUEr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730023294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7NVNIvB0/48et90ayphb0tBlaktmdq0J+1e4kqcntM=;
	b=HvTiRPjD0DsmxxZz0EJk4LcYAzavFTllAtV40WN20cvToaVPBio7LIoWjlXAHHsFA4dsvw
	S7LDkMmho+ZmQCoy6ijcj53Pcw+7Z7HWfsHFDvG86/4oGxlBHYY2vc3qCw7vUyn/ua0bLg
	JWDBYAeSQU1YMykUANXKLV1ppzJ+HPlUHfCdew4tftpqcEVv2e3TgoXfvGY3ZNjra9i+Tx
	SxvMA7EH4kLh1+wUtz0Lfe9XCRZFG8e5Sngr61sIwfYzVC5IjQD4S8aIOIgDxQmR953OUh
	/1kqT8zJrrSWBGESpGZVbDIgxc7l5rWlf66zla9sKb4wHAdV9iFk7t/lTq7dGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730023294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7NVNIvB0/48et90ayphb0tBlaktmdq0J+1e4kqcntM=;
	b=avM1gUErfQH+EH37JscZN0xPbvFFawrmqGdB81/GTVvOO1MTwD4tGQ8VSmhFybkv5Isu1W
	7KdG+xyrzJ2ucDDw==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Waiman
 Long <longman@redhat.com>
Subject: Re: [RFC PATCH 0/3] futex: Add support task local hash maps.
In-Reply-To: <20241026224306.982896-1-bigeasy@linutronix.de>
References: <20241026224306.982896-1-bigeasy@linutronix.de>
Date: Sun, 27 Oct 2024 11:01:33 +0100
Message-ID: <87froh50g2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Oct 27 2024 at 00:34, Sebastian Andrzej Siewior wrote:
> and adds support for task local futex_hash_bucket. It can be created via
> prctl() and each thread has to enable it via another prctl() interface.

That's a quick way to evaluate it.

> Individual threads may enable it but I guess this gets more complicated
> because the libc internal locks (or another lib) maybe be shared by
> multiple threads. So maybe it would be best to enable the local hash by
> the group leader and automatically enable for each thread on fork().

At the end we want to let the kernel automatically create the hash table
on first use of a private futex with a default size. That's a one off
latency. The prctl should only be there for preallocation and sizing.

And yes, you want to inherit when a new thread is created.

Thanks,

        tglx

