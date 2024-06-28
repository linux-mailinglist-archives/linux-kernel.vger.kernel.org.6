Return-Path: <linux-kernel+bounces-234163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6875491C304
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E88F1F22471
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA31C68BA;
	Fri, 28 Jun 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2PcboUDu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zvf8fbzd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A81DDCE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590183; cv=none; b=Wtsv3jxKpEZCdcCopbnPkT5mHpl1mSWUWL5P0EpPpjFK8cxW6ks1e7cBYWcvy+KenwSrwyKND/oAmQagEKOis/VRhAVraMlQv4ekRc7k05A9SlPqLjf2g/8V1YcAjxMlxk8HtEl7X2IJjDbox1qNbPIcuvZ8PR1dAh1peEwN9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590183; c=relaxed/simple;
	bh=655s8R/1J43801hRa3VEpTU9NL2419Nq/u45LRrDQos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CZLAh2Ea7yUItoImvaAHHE3URZvnghXnXZgwZUKBMnIEmNrEPh/aNEE0QMiDtiAPLZDmNB64P8Yg30yxU7kOv+AZN3r3I6g23k8OPB3Aa41suj6XGZfSjnz+cIqmqo+qNQcw/sGrG3qAfCjgZN6n3bYFyWeRQqUAjd6lsPsM45c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2PcboUDu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zvf8fbzd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719590179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrvW8EY76R6mLXVK5xxiLmcZNwxZX6BMeHh6A/z00cg=;
	b=2PcboUDuk6LGPdW4UaOqHl3DgsUpBB8Ae9AE2i0Tyf8p90FFM85BRGtf1LqkaFVZQTnOTj
	U4FB9dXi/kp2G3uUIeZ6k8Sc6zG1/ZU9TKJoLzLguiyAUFVkS+0hxXRBFDQeRFTztI9RSQ
	4XV9XnODGUdVdaY6Ewg5O5baBBdyQmk5srgxfLUCi4xGyzITVO1aJkKXwtZPrlAZPEk4Hd
	Xr956pgUXoXbeeVaZr898ovfFr9Xs5vYcuczzpo7Y92tUB4t65rIOVlYW/u5+LXH1pXTYq
	j4eHDJprQsVTbvzF7V4gjc1RFUw1TymkCdDuvpp+Bi+N6NSvr+umSkfJuqzHwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719590179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KrvW8EY76R6mLXVK5xxiLmcZNwxZX6BMeHh6A/z00cg=;
	b=zvf8fbzdNlU1YvOvEyr4rsgMBWrbcuDn/sj0C+gLE8otmv+UvOKSEDnfyDKvahPr+V3rml
	/MNprm/zYMrmI2Dw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 12/18] printk: Add kthread for all legacy
 consoles
In-Reply-To: <877ce9xim6.fsf@jogness.linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-13-john.ogness@linutronix.de>
 <Zn6iq3n2ggL138Gs@pathway.suse.cz> <87cyo1xnmw.fsf@jogness.linutronix.de>
 <Zn67hDCEHdgtYPv3@pathway.suse.cz> <877ce9xim6.fsf@jogness.linutronix.de>
Date: Fri, 28 Jun 2024 18:02:19 +0206
Message-ID: <874j9dxdr0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Petr,

Your comments are sending me into deep thought about this
situation. Some more comments from me...

On 2024-06-28, John Ogness <john.ogness@linutronix.de> wrote:
> On PREEMPT_RT, legacy consoles are not allowed to print from
> non-preemptible contexts because they use spinlocks (rtmutexes).

The above statement is not true for legacy _boot_ consoles
(earlycon/earlyprintk). These are lockless and are intended to execute
from any context (except NMI due to semaphore limitations).

I hate boot consoles because they don't use the Linux driver model and
rely fully on external synchronization. This has made the rework very
difficult and is actually the core reason why our work was reverted back
in 5.19-rc4. But for debugging early boot problems, they are quite
useful.

I have a new proposal. What if we allow boot consoles to always print in
the caller context (for any preemption model)? I hacked a quick test
together by providing console_flush_all() an extra argument for printing
_only_ on boot consoles. Then in vprintk_emit(), I always do a
boot-console-only-flush (under console_trylock) after storing the record
in the ringbuffer.

For PREEMPT_RT this is horrible. But I am OK with mandating that RT
scheduling cannot be guaranteed with boot consoles (just as it is
currently mandated that RT scheduling cannot be guaranteed in emergency
situations). Since the boot consoles are lockless, they pose no deadlock
threat to RT.

This has some nice features:

- We get early debugging in all preemption models.

- We get true synchronous printing when using boot consoles (which
  should make peterz happy).

- Boot consoles are then horrible enough that options such as
  "keep_bootcon" will really be avoided unless debugging kernel issues.

From the tests I have run so far, it looks good.

Looking to the future, I think this would also provide an excellent
foundation for the "sync" console option I would like. For nbcon
consoles with the "sync" option specified, it would work the same way,
flushing boot consoles and nbcon consoles directly in vprintk_emit().

Thoughts?

John

