Return-Path: <linux-kernel+bounces-261124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 207AD93B300
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CD9285E26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417E115FCEA;
	Wed, 24 Jul 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hvU486/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UiOxD1iV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54515FA67
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832350; cv=none; b=CVdhg1kxjlhSLSFNtiT8a74pFYgOG2t+H6wMB5U3wcveJGi2AZWmL/kK+1+y1IN23VXvdD0QoINdCvwDY8djUZvkZ47okCT2BZdkM4oKeQnNz/+BWtPq+o1IODMVq0DchmwYajPeMGmtxFr4gXJOf+ndT/d7T2XCAzqAA759aiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832350; c=relaxed/simple;
	bh=oLYLmR+W97vwd13BBtasY/LODYEz4cAIAOdwqpewaZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=REQoeOfpApF9m3ip8VI9ltATnRyAzQLPHdd8TALArPIjcd6Uv3YDUpBCVcvZrgdyjLwdFmowOVvEsiioD3I4emV55/zbJ1c5RuIxExziPum9SRoiMnxM0B16J8mUZiG5Svjlu1OWavkutFLj4RarINZnx5rwRHKsSRbwt8Uip3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hvU486/u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UiOxD1iV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721832346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cWWob3dxFNx2OCHMKBA+KOE8DxxfEOr2Sed8rPRxhs=;
	b=hvU486/u4s1FiRrBCNk1y/Egsr0u3BumyRM6nNAnLP7+8yO5N2zseZfipaUq/8yQmdFYFT
	MAEep7Kv/DytQ2x3Jay/LV0oZfnFsMO6AurVk9mZ5Cz071W2gQMGD3ivo69pp4mbt/dBZ9
	g+88XDAlkqTwF6n3zelM+49o6mi6oq8QXZR2OGlEqZLLt0+ZZdpRVVS7LPfI5TG3da3tXH
	GukPKgq/FtWTccVcqp4MFOgV0dgMgVvmfvt/1NZMYUKmStlDAUSHx7R+oI9V6Q+meQvS2k
	1h74IPuBAE+It5Pq9+0s0rzqjBcXsfe9eYGbByZvMs1plO8bmRklVuwQr/dRaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721832346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0cWWob3dxFNx2OCHMKBA+KOE8DxxfEOr2Sed8rPRxhs=;
	b=UiOxD1iVW+YwZN3lenP4uc/pVxg2c9gxl2JtnejzYR+NQuUI6Ra0lSDPwYfghpwk/sfgzi
	IxdbhcaRedkKpiBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Rik van Riel <riel@surriel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Omar Sandoval <osandov@meta.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, kernel-team <kernel-team@meta.com>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
In-Reply-To: <ZqD54dcZUAirxTYg@pathway.suse.cz>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
 <87plrcqyii.fsf@jogness.linutronix.de>
 <93155b2ccafa43ed4845ae450451c6b8e27509cc.camel@surriel.com>
 <87r0brkvqd.fsf@jogness.linutronix.de>
 <d18ff73a0ef7536f654b63854dc891984319093f.camel@surriel.com>
 <877cdilrko.fsf@jogness.linutronix.de> <ZqD54dcZUAirxTYg@pathway.suse.cz>
Date: Wed, 24 Jul 2024 16:51:46 +0206
Message-ID: <871q3ix2zp.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-24, Petr Mladek <pmladek@suse.com> wrote:
> My quess is that it looked like:
>
> CPU A				CPU B
>
> 				printk()
> 				  console_try_lock_spinning()
> 				  console_unlock()
> 				    console_emit_next_record()
> 				      console_lock_spinning_enable();
> 					con->write()
> 					  spin_lock(port->lock);
>
> printk_cpu_sync_get()
>   printk()
>     console_try_lock_spinning()
>       # spinning and wating for CPU B
>
> 				NMI:
>
> 				  printk_cpu_sync_get()
> 				    # waiting for CPU A
>
> => DEADLOCK
>
>
> The deadlock is caused under/by printk_cpu_sync_get() but only because
> console_try_lock_spinning() is blocked. It is not a true "try_lock"
> operation which should never get blocked.
>
> => The above patch should solve the problem as well. It will cause
>    that console_try_lock_spinning() would fail immediately on CPU A.
>
> Note that port->lock can't cause any deadlock in this scenario.
> console_try_lock_spinning() will always fail on CPU A until
> the NMI gets handled on CPU B.
>
> By other words, printk_cpu_sync_get() will behave as a tail lock
> on CPU A because of the failing trylock.

But only in _this_ scenario. The port lock could be taken by CPU B for
non-console-printing reasons. Then you still have deadlock, due to
spinning on the port lock.

The documentation of printk_cpu_sync_get() clearly states that the owner
must never perform any activities where it waits for a CPU. I think
deferring printk on that CPU [0] is the only viable solution. Note that
in the case of emergency states, atomic consoles are not prevented from
printing when printk is deferred. This is appropriate because they do
not spin-wait indefinitely for other CPUs. Although I expect they would
not be able to print emergency messages because the console is likely in
an unsafe region at that time.

John Ogness

[0] https://lore.kernel.org/lkml/87plrcqyii.fsf@jogness.linutronix.de

