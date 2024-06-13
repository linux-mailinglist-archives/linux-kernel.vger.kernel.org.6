Return-Path: <linux-kernel+bounces-213528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD93907673
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EB11F21FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059491494CD;
	Thu, 13 Jun 2024 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pnEt3aK4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qleynsmI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA213CF85
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292097; cv=none; b=rXZ56Mpl8yjxR2FS169DH5hjyHi8GJr3DVxD3JO+0haWJ8kxqYV5jqP07re1bSAxYz7hvF96AULR6BpAbO3vwdHoFq01c2wVwtrluRBJoZX1qsSOKecbge5Ga4lsGz8tYxxuN18OecTBZyxhuyn1nvozA12NrSPoVzd65dZJ1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292097; c=relaxed/simple;
	bh=iIrB4ExCt8BUVfEVtMt1w8/a6BsbAd07dBKrkPoLw6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ErBKxstcM9SXuYNRnm1OhLM8ycULkMByV0Q2KGUJEa84xGeREywe5mQXWzPdjbtaxcj9IFqQG8BaD3Sq7yNc9ADLKQ9H6ZrwBTvPqyUT7r5rJ9ZYa+xBw3PRqqvDCdzHsJuKM3mzl5+akyhrVX+QfFMyRtQ/ilKC6w0N1b3rNP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pnEt3aK4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qleynsmI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718292094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aywo/MKB8or5V5hzcLoPZZQeZHEBi9nR93fDmZDQq5w=;
	b=pnEt3aK41An9rW+8tAxPcg825WB3bQmcfTIzxyILP/ZYNrVk+ZCW2dBBfdN5PT8AOr234i
	D+ksfgnMw6QtWUSFiCRUEyG+e6fv4zVy3eZtMXAuyfu5sxrr7NpOA+JsQubolrtOg/aiGv
	+nZIwYWUfK+Ga4FVmFf8DPYv+Vc6a+n9tRxsA01FieI5sLdbea+aw1Ve9GpMyChVJB2WWb
	SjG5FASwSUbHIsdgMINAfLbD4E8wbZVeGR31EtwQU1HT7MPO6nqyPmwVITbYHLepXuEuqx
	2aVjqjonOVx4XTmbDRR0iQjwvGwrnYdA4k3TXI1NIeiPJ1x/avJy3qnL01QfSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718292094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aywo/MKB8or5V5hzcLoPZZQeZHEBi9nR93fDmZDQq5w=;
	b=qleynsmIUAOWSmvsVv020dVUNcecZsvrchPTOFh1hZPGQfVdejRJFmnfsC9tjkCLWZQX2Q
	ujHqEC5FsiJBmZDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/18] printk: nbcon: Introduce printing kthreads
In-Reply-To: <87sexipmrk.fsf@jogness.linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
 <20240603232453.33992-5-john.ogness@linutronix.de>
 <ZmMIOWEAMgXz4j-U@pathway.suse.cz> <87ed95j8yh.fsf@jogness.linutronix.de>
 <ZmhkVAC_3FMohrEr@pathway.suse.cz> <87sexipmrk.fsf@jogness.linutronix.de>
Date: Thu, 13 Jun 2024 17:27:33 +0206
Message-ID: <87jzis50n6.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-06-11, Petr Mladek <pmladek@suse.com> wrote:
> Honestly, if the system is not able to start the kthread then
> it is probably useless anyway. I would prefer if printk keeps working
> so that people know what is going on ;-)

I have been looking into and thinking about this some more. I do not
like the idea of the system doing some sort of fallback if some of the
kthreads fail to start. Not only does it complicate the code, but it
greatly increases the variants of how the system during runtime.

I (strongly) suggest the following:

- The kthread is created in nbcon_alloc(). If the kthread fails, then
  nbcon_alloc() fails and the console will not register.

- nbcon_kthread_should_wakeup() will return false if the console is not
  registered or if @have_boot_console=1.

Then there would be no need to ever check con->kthread. Instead we can
rely on the global state of the system transitioning to relying on
threading.

I think it is totally appropriate that register_console() fails if the
kthread cannot be created, just as it already fails if the kmalloc() for
the pbufs fails.

Any objections?

John

P.S. There are other minor details involved, such as calling
kthread_stop() before removing a console from the list. But I have gone
through all these and it appears to generally simplify things a lot.

