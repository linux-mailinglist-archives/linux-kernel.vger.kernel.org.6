Return-Path: <linux-kernel+bounces-346063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1084698BEFF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3E41C23F53
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A51D1C689F;
	Tue,  1 Oct 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDrL9gYR"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FEC17FD;
	Tue,  1 Oct 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791624; cv=none; b=Wt/DCDmXUj9Uj8xcsw4h8PxjSMEIgqAKjzLC1rZ77L7H8ODuQaxtXMTN0aqwl3SY/XlzVdT9UlXXQb6wvmE0rqJMGEW08knglbKWSIcHkupchDP+uUQwnVdAtWZ1E0wup0whnK3wefSpaDojvAJmAERyPfaQJIGPq7tlGz7ejY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791624; c=relaxed/simple;
	bh=JRFZrG/5NUng0sccWPPm8RiEYNy1MorF0Bs/T0dYICg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQ/7yyOS+QKIdmDYv3t8e7n4p13kvZZOXavA9nI4LpXqcBCvUNoP5XhQzmqLNcdwk48ipD2O7OfRZEyBlJaFAzW7SDpSJ4BRiGLiwJRr1P38lTE8koCNvTRZ1299IAHkqHiIa2rBqWzYkILTYKjm2IyRkgSCYfm6NcKERj0e7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDrL9gYR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cbc38a997so33809775e9.1;
        Tue, 01 Oct 2024 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727791621; x=1728396421; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JRFZrG/5NUng0sccWPPm8RiEYNy1MorF0Bs/T0dYICg=;
        b=jDrL9gYR7zO6htQ73n3lGKmNgWcD88Pocmp84ehPNlh6RJb+5IGXtxUuEhPlt2O+Jo
         tp8z2HBdkyvLtoPK+WrCbY/7DukG7CguJewT4Z8rY2+YBggWZLbzVAwl0mdo/NwE+ky8
         HDR8NWJPdFW4aFKVr84JNQEdkl0Ktf5RBeuMWe9OGVYNr/t6jezW1NlZkHICWwyVJvok
         fc18dNfSJm+oCLx96tphKQni0xv6nnamPu4Cclzo22t4+u+myVZ3Csa/vjbyInJig06y
         R74K73dHz1vD2UO+IyQXkWSYYwvK3sYhpeAUz2DU0ihhWHH5lOBlJ9WT58YVF+yBsmlO
         dh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791621; x=1728396421;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRFZrG/5NUng0sccWPPm8RiEYNy1MorF0Bs/T0dYICg=;
        b=d6rdDov3bhGbn6pV8HtwzfLNGPv9s26J8torPnKp/zLx5g5r/w/DUPttpNm2DGz99V
         jjXPQ/1q+qXCmMU7y8nkt06zXPhMm/8Tg4HglWwP3/a81E/Is06nw1bWrxtCpVbhiqO3
         1NT5sU8BLojUeAQJW9lwar//Eaty1pj/waFWP0O0jrMf7I7to03dpeVDlwv8lPlYCwx+
         Z/QBVJ3u9MqHbn/D5TLy+z0JKySJL/uvnv2giJGPoN+oq/0sL4uD0z9ruCyJ7NSZDW99
         CFnOqvZaOXz/TpRfthgwEuwTylIfR/3y9coLU9a0kZ/vLXdUoBWwkgqlg6a7dWme43jO
         Upzg==
X-Forwarded-Encrypted: i=1; AJvYcCV4tbwT4UFxeRsKXTsWcg/BopMIncFyuYTLKmWCPKJRAVjYOZu7WLRU3r7aw52OediNdk0LQz2y4r1y@vger.kernel.org, AJvYcCXNFRB6u3jK84IHXymNirJLq6KXf9nVJeYk+iynRQUGhkqERThSlKR1OxWVHNNpZdQ9NY9Qo/KG3CnxGuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX99P16FYPbNRFAJIApwW6SUhUVbYYpoOFOy9y7MpRgJhwoJlv
	Y4pd8mU30/FYCNdU7tSqdxyaA1oNl1NFhzS96Fpi/I0kdFH4B90D
X-Google-Smtp-Source: AGHT+IFoFXZDGK/A4lVFzGr8ixo72USnBmWQQQQlE+tQLDgXYafG8FOKyH14msFuzbu+dzjkvf0I5A==
X-Received: by 2002:a05:600c:3504:b0:42c:b68f:38fb with SMTP id 5b1f17b1804b1-42f7133c837mr22807575e9.7.1727791620563;
        Tue, 01 Oct 2024 07:07:00 -0700 (PDT)
Received: from [192.168.216.101] (public-gprs35668.centertel.pl. [91.94.11.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddb1fsm181483205e9.3.2024.10.01.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 07:07:00 -0700 (PDT)
Message-ID: <2f91f72fad8a71164957ba359b26a4a2d8b05ed6.camel@gmail.com>
Subject: Re: [PATCH v3] usb: gadget: u_ether: Use __netif_rx() in
 rx_callback()
From: Hubert =?UTF-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ferry Toth
 <ftoth@exalondelft.nl>, Hardik Gajjar <hgajjar@de.adit-jv.com>, Kees Cook
 <kees@kernel.org>, Justin Stitt <justinstitt@google.com>, Richard Acayan
 <mailingradian@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 16:06:57 +0200
In-Reply-To: <20240927141200.xMZ53xm5@linutronix.de>
References: <155be9e56e650dd7f7baf1c7e193e1a3d85e7141.camel@gmail.com>
	 <20240917143618.jPgAwF3M@linutronix.de>
	 <1be4dce841c6e5de076864102aca2e131d1aafe1.camel@gmail.com>
	 <a7a132ff61a4533ce463ec088e15e3156c3ce39b.camel@gmail.com>
	 <20240927141200.xMZ53xm5@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-27 at 16:12 +0200, Sebastian Andrzej Siewior wrote:
> On 2024-09-27 15:33:35 [+0200], Hubert Wi=C5=9Bniewski wrote:
> > On Thu, 2024-09-26 at 21:39 +0200, Hubert Wi=C5=9Bniewski wrote:
> > > I'm a bit at loss here. The deadlock seems to be unrelated to netif_r=
x()
> > > (which is not being called in the interrupt context after all), yet
> > > replacing it with __netif_rx() fixes the lockup (though a warning is =
still
> > > generated, which suggests that the patch does not completely fix the
> > > issue).
> >=20
> > Well, never mind. After some investigation, I think the problem is as
> > follows:
> >=20
> > 1. musb_g_giveback() releases the musb lock using spin_unlock(). The lo=
ck
> > is now released, but hardirqs are still disabled.
> >=20
> > 2. Then, usb_gadget_giveback_request() is called, which in turn calls
> > rx_complete(). This does not happen in the interrupt context, so netif_=
rx()
> > disables bottom havles, then enables them using local_bh_enable().
> >=20
> > 3. This leads to calling __local_bh_enable_ip(), which gives off a warn=
ing
> > (the first backtrace) that hardirqs are disabled. Then, hardirqs are
> > disabled (again?), and then enabled (as they should have been in the fi=
rst
> > place).
> >=20
> > 4. After usb_gadget_giveback_request() returns, musb_g_giveback() acqui=
res
> > the musb lock using spin_lock(). This does not disable hardirqs, so the=
y
> > are still enabled.
> >=20
> > 5. While the musb lock is acquired, an interrupt occurs. It is handled =
by
> > dsps_interrupt(), which acquires the musb lock. A deadlock occurs.
>=20
> This all makes sense so far.

I have done more testing on this. It seems that this deadlock possibility
reported by lockdep is not the cause, but just a symptom.

For now, my conclusion is that the problem lies in the MUSB gadget driver
itself. Interrupts (in peripheral mode) on Rx endpoints are handled by
musb_g_rx(), which pulls requests from EP request queue. If there is no
request queued, it just returns without clearing the RXPKTRDY flag in the
RXCSR register (but the interrupt flag in the glue layer register has been
already cleared by the glue layer IRQ handler). This makes the received
packet wait for the next interrupt. If the Rx FIFO is full, no more packets
are received and no more interrupts are generated. The EP stays locked up
forever (or until the RXPKTRDY flag is cleared manually :)).

From what I have learned, the request queue being empty just happens
sometimes and it is not en error.

This bug became exposed by the new behaviour of netif_rx(). When BHs are
enabled, hardirqs are enabled too (for a moment) which causes the Rx
interrupt to be handled before a request is enqueued. If there are enough
such unhandled packets, the EP gets locked up.

> > Replacing netif_rx() with __netif_rx() apparently fixes this part, as i=
t
> > does not lead to any change of hardirq state. There is still one proble=
m
> > though: rx_complete() is usually called from the interrupt context, exc=
ept
> > when the network interface is brought up.
>=20
> __netif_rx() has an assert which should complain if you use
> __netif_rx(). Further in this case you pass the skb to backlog but never
> kick it for processing. Which means it is delayed until a random
> interrupt notices and processes it.

Now I see that it was a bad idea. I just found this using git bisect.

> > I think one solution would be to make musb_g_giveback() use
> > spin_unlock_irqrestore() and spin_lock_irqsave(), but I would need to p=
ass
> > the flags to it somehow. Also, I am not sure how that would influence o=
ther
> > drivers using musb.
>=20
> I would also suggest to do this since the other solution is not safe/
> correct. There is the ->busy assignment which should cover for the most
> cases. If you drop the lock without enabling interrupts then the
> interrupt can't do anything to the EP and other enqueue/ dequeue
> invocation is not possible if run on UP. On the other hand am335x was
> used on PREEMPT_RT and it runs a UP machine into SMP so that should be
> covered :)
>=20
> While looking at it, dequeue/ enqueue during complete callback looks
> safe due to the busy flag.

I think it is not needed now. After I have modified the interrupt handling
code to clear the RXPKTRDY flag if there is no request queued and the FIFO
is full, neither __local_bh_enable_ip() nor lockdep complain (tested on SMP
and UP, with and without PREEMPT, on AM3358 and A64).

It would probably by nicer to ensure that no MUSB interrupts are handled
when a MUSB request callback is invoked from musb_g_giveback() (e.g. by
disabling MUSB interrupts before releasing the lock and enabling them after
acquiring it), but that could cause some side effects if the callback
relied on MUSB interrupts being enabled. And since there are no warnings
and everything works... I guess it is time to submit another patch then and
to forget about this one.

Thank you for your time!
--=20
Hubert Wi=C5=9Bniewski <hubert.wisniewski.25632@gmail.com>

