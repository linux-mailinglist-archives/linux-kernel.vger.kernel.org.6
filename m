Return-Path: <linux-kernel+bounces-341827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82379886B6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAA81C21703
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB21A81727;
	Fri, 27 Sep 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4MN/eTRM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JVxAljrY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DE4D8DA;
	Fri, 27 Sep 2024 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446326; cv=none; b=oznjOammhBdvvFXS9LdVXvpXxPaJP7BiXK5O15q2TEYfBgwVKQ2/3Z2mgFzOiU4PgIAJ73G99xgJuiQ1PJUqm40Oz4vUCLZ86cp+zrBCt8ROX/yjmDnkNKmG03fhFrPBfs5rdx6BuHUvC82zbzI8djNGR5IHuJ4F37wfKj0ViOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446326; c=relaxed/simple;
	bh=oiUM/4inJp7Fa5pCAfvFPT0TrFUocY70hwR78e9Nu84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqHujM8GXYSFrjh/l0meeU+pl3hnE1APYEkLer5JZZRXwAqTXEaRgutrMX+KKFnpq76ThvvQekK8fWwY8DyouCvcIvinMX6dqvlUxPuXl7IJEJ1HyU+vkdkTquhpcPhJq5G1gVJ6MoqKu6L6JZI6I0cgXKUQl+zovHauJOOwC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4MN/eTRM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JVxAljrY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 27 Sep 2024 16:12:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727446322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiUM/4inJp7Fa5pCAfvFPT0TrFUocY70hwR78e9Nu84=;
	b=4MN/eTRMB8WX0xKjc59W9Qkl9ywkCX17+IJX4qZUMl+3lDm1rVHa7dkPeZ4HkdwsOr5t2Q
	KG6pGABf+Qe0FI5RuyyujzV5+YqJO5OBZ62D8OJkXjGyMAazWyEBku1PuwQkarKm/r3Y3S
	aXswOVMIrME4WbIoCO7tEOLewIyE3qnn8kj+sUcCHfr80p+gQo2kEsnEKcAnFt4hx4WFBS
	POF/3OmlSjjj2jipo41cxxneDFxK02zPwoOfKS+sWm2qXsaVplcLiX60bHcHaD2st78w9M
	rEOcdzhxfOJ4agIVUtV9gs4WWk19KqPWLgzFRiWXVTD0rMH6/Q5r8xeP/DP1GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727446322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiUM/4inJp7Fa5pCAfvFPT0TrFUocY70hwR78e9Nu84=;
	b=JVxAljrYd4gKXhYqGAQ6INuEiUcwePBYHB2Zk7vq9Nify3Z49AOesId02dUroTWBm1B5D2
	ryRTJb9nd0Lf4FBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Hardik Gajjar <hgajjar@de.adit-jv.com>, Kees Cook <kees@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Richard Acayan <mailingradian@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: u_ether: Use __netif_rx() in
 rx_callback()
Message-ID: <20240927141200.xMZ53xm5@linutronix.de>
References: <155be9e56e650dd7f7baf1c7e193e1a3d85e7141.camel@gmail.com>
 <20240917143618.jPgAwF3M@linutronix.de>
 <1be4dce841c6e5de076864102aca2e131d1aafe1.camel@gmail.com>
 <a7a132ff61a4533ce463ec088e15e3156c3ce39b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a7a132ff61a4533ce463ec088e15e3156c3ce39b.camel@gmail.com>

On 2024-09-27 15:33:35 [+0200], Hubert Wi=C5=9Bniewski wrote:
> On Thu, 2024-09-26 at 21:39 +0200, Hubert Wi=C5=9Bniewski wrote:
> > I'm a bit at loss here. The deadlock seems to be unrelated to netif_rx()
> > (which is not being called in the interrupt context after all), yet
> > replacing it with __netif_rx() fixes the lockup (though a warning is st=
ill
> > generated, which suggests that the patch does not completely fix the
> > issue).
>=20
> Well, never mind. After some investigation, I think the problem is as
> follows:
>=20
> 1. musb_g_giveback() releases the musb lock using spin_unlock(). The lock
> is now released, but hardirqs are still disabled.
>=20
> 2. Then, usb_gadget_giveback_request() is called, which in turn calls
> rx_complete(). This does not happen in the interrupt context, so netif_rx=
()
> disables bottom havles, then enables them using local_bh_enable().
>=20
> 3. This leads to calling __local_bh_enable_ip(), which gives off a warning
> (the first backtrace) that hardirqs are disabled. Then, hardirqs are
> disabled (again?), and then enabled (as they should have been in the first
> place).
>=20
> 4. After usb_gadget_giveback_request() returns, musb_g_giveback() acquires
> the musb lock using spin_lock(). This does not disable hardirqs, so they
> are still enabled.
>=20
> 5. While the musb lock is acquired, an interrupt occurs. It is handled by
> dsps_interrupt(), which acquires the musb lock. A deadlock occurs.

This all makes sense so far.

> Replacing netif_rx() with __netif_rx() apparently fixes this part, as it
> does not lead to any change of hardirq state. There is still one problem
> though: rx_complete() is usually called from the interrupt context, except
> when the network interface is brought up.

__netif_rx() has an assert which should complain if you use
__netif_rx(). Further in this case you pass the skb to backlog but never
kick it for processing. Which means it is delayed until a random
interrupt notices and processes it.

> I think one solution would be to make musb_g_giveback() use
> spin_unlock_irqrestore() and spin_lock_irqsave(), but I would need to pass
> the flags to it somehow. Also, I am not sure how that would influence oth=
er
> drivers using musb.

I would also suggest to do this since the other solution is not safe/
correct. There is the ->busy assignment which should cover for the most
cases. If you drop the lock without enabling interrupts then the
interrupt can't do anything to the EP and other enqueue/ dequeue
invocation is not possible if run on UP. On the other hand am335x was
used on PREEMPT_RT and it runs a UP machine into SMP so that should be
covered :)

While looking at it, dequeue/ enqueue during complete callback looks
safe due to the busy flag.

Sebastian

