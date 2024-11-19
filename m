Return-Path: <linux-kernel+bounces-413664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5557A9D1D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8ABB21CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AE527473;
	Tue, 19 Nov 2024 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFUBkKkt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77EB5672
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978970; cv=none; b=WK8mCXhu2YTPMXQ0XVzm3atMPUbtS36WI+nW+ePzzgyRI0AXUrEc9JSj3CEHTsPXMbTITiE+MpwLMvf+4qGu3v7N6LmhRtFJvTboqmvMPp+Uem7EEMX/Kg7wQ1jfoJ1UEC3F3xwTW2t070Dz5Mt427vXX1uGQASxBoLIKStSLk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978970; c=relaxed/simple;
	bh=3pMm3Ue6P1qWaA1KaoMNrqQZGa9Huj8L4J3+h8WjYbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=pQJhkiFQw6FdMHbjW5VF1XP3Jl8hESIT/1J+nFvVjCDcb4GKRnYgzSrfyY2/+Hj1N40K/c9IK13KK6QeyLgo3TqwiRQSoZGYKh5n44anT2HNa5TYZ0u8djFVFIfkwly2Hs75lqCiv1SAcewQNNipg7dljsRF2ICG2YhrE85TsAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFUBkKkt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731978967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L18b2/xSUIajlm/HuShpy5h2B9YfsZl/5JQ3xGw/ud8=;
	b=iFUBkKktKiAjfC0+eCNQayMs24si0mCunPwm03uxoCxb58MIVxUQ1+UEsiwLsW1dh70sMa
	1PCPurwso+Wot4V6HtoxHAcXueA5cYsywQILdrteLg3JGQQJokQu6u893E4UCLCy2mfg5R
	ogPdRxMJ8gSLQU0gVWyXk3c2EEVtMpo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-EBE_ai3wO2C0vb20qc-1gg-1; Mon, 18 Nov 2024 20:16:05 -0500
X-MC-Unique: EBE_ai3wO2C0vb20qc-1gg-1
X-Mimecast-MFC-AGG-ID: EBE_ai3wO2C0vb20qc-1gg
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20d417fc584so42527385ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731978965; x=1732583765;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L18b2/xSUIajlm/HuShpy5h2B9YfsZl/5JQ3xGw/ud8=;
        b=lM/jcP0culV/sIjsyCKdUadgVMJQ5VN3e9Af/N7jxoMihydn9s0JwYFlUBJvTwjfvu
         fwEpB4gR2qgAYFZ/ciM0uJQ2pToulsRw7lDGLKJjHxC9RX6RmCwo+PgzfskCcWVLLzI3
         7cOMQItQY9h8cII4Y5AHE79XCBIR5V3mkBPYDRLg4AHVVlsD8uLY/5WQ+sBvnnjPs6Rq
         6tvQaJ1UUN4ToBECfUJRzEY2rus2YbqXzuy+YZwmSrwl0NSdpAbMpBWWBN946hhAv88m
         PXO6NIxDUgyvl1Mw9bNP6wh0g81HnaICi8qzNOfXXPlChUwbMFfQfrlBKOCD8JNAraju
         xMmw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Nb1c09Jq7pRSluVrmSTgI5nTvamvbfLh+SsXObzSoR8WKX4HxJ6v4mmVIpmuK2XJ3D/oyyCjv3pgSMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ANnQSK+OdqP29LfrlQMhr6gG4EpeBis+lt4zREazrOP0MGUt
	T962TcsSVywbNeGjz24s1XM1O5Uz7821TERlfxvqFHIvtI1QOiuF8evHRLDk0S9ROl1te6xG+Yd
	YN4xv8u7bHuWJzP2x7AEehnmWd7wA8PnQvYnxuSAMIsFtiMxOmdzvo5QrPD2H5Q==
X-Received: by 2002:a17:902:e54d:b0:20c:80d9:9982 with SMTP id d9443c01a7336-211d0eceb07mr218289355ad.47.1731978964785;
        Mon, 18 Nov 2024 17:16:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERcvwzst7pUKzOzWBWQqObtmxtzT8PM+xLo9oibjhsHZh/Zd3+Z5Y0hVr1Ox3ZMiwNZacGXA==
X-Received: by 2002:a17:902:e54d:b0:20c:80d9:9982 with SMTP id d9443c01a7336-211d0eceb07mr218289075ad.47.1731978964383;
        Mon, 18 Nov 2024 17:16:04 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a802:71b8:8bf1:7908:7779:c115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec9124sm63222775ad.101.2024.11.18.17.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 17:16:03 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
Date: Mon, 18 Nov 2024 22:15:40 -0300
Message-ID: <ZzvmvBdqJpAyUicm@LeoBras>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <ZzWrzC1QhhlNqLpl@smile.fi.intel.com>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-5-leobras@redhat.com> <87zfvwai62.ffs@tglx> <87v86kaf84.ffs@tglx> <ZdWMja3BfCZsbF_q@LeoBras> <87edd5hljz.ffs@tglx> <ZdghE6TNHgZ_bi19@LeoBras> <ZzVxIfb5KpL97P4Q@LeoBras> <ZzWrzC1QhhlNqLpl@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Nov 14, 2024 at 09:50:36AM +0200, Andy Shevchenko wrote:
> On Thu, Nov 14, 2024 at 12:40:17AM -0300, Leonardo Bras wrote:
> > On Fri, Feb 23, 2024 at 01:37:39AM -0300, Leonardo Bras wrote:
> > > On Wed, Feb 21, 2024 at 04:41:20PM +0100, Thomas Gleixner wrote:
> > > > On Wed, Feb 21 2024 at 02:39, Leonardo Bras wrote:
> > > > > On Mon, Feb 19, 2024 at 12:03:07PM +0100, Thomas Gleixner wrote:
> > > > >> >> Is scenarios where there is no need to keep track of IRQ handled, convert
> > > > >> >> it back to IRQ_HANDLED.
> > > > >> >
> > > > >> > That's not really workable as you'd have to update tons of drivers just
> > > > >> > to deal with that corner case. That's error prone and just extra
> > > > >> > complexity all over the place.
> > > > >
> > > > > I agree, that's a downside of this implementation. 
> > > > 
> > > > A serious one which is not really workable. See below.
> > > > 
> > > > > I agree the above may be able to solve the issue, but it would make 2 extra 
> > > > > atomic ops necessary in the thread handling the IRQ, as well as one extra 
> > > > > atomic operation in note_interrupt(), which could increase latency on this 
> > > > > IRQ deferring the handler to a thread.
> > > > >
> > > > > I mean, yes, the cpu running note_interrupt() would probably already have 
> > > > > exclusiveness for this cacheline, but it further increases cacheline 
> > > > > bouncing and also adds the mem barriers that incur on atomic operations, 
> > > > > even if we use an extra bit from threads_handled instead of allocate a new 
> > > > > field for threads_running.
> > > > 
> > > > I think that's a strawman. Atomic operations can of course be more
> > > > expensive than non-atomic ones, but they only start to make a difference
> > > > when the cache line is contended. That's not the case here for the
> > > > normal operations.
> > > > 
> > > > Interrupts and their threads are strictly targeted to a single CPU and
> > > > the cache line is already hot and had to be made exclusive because of
> > > > other write operations to it.
> > > > 
> > > > There is usually no concurrency at all, except for administrative
> > > > operations like enable/disable or affinity changes. Those administrative
> > > > operations are not high frequency and the resulting cache line bouncing
> > > > is unavoidable even without that change. But does it matter in the
> > > > larger picture? I don't think so.
> > > 
> > > That's a fair point, but there are some use cases that use CPU Isolation on 
> > > top of PREEMPT_RT in order to reduce interference on a CPU running an RT 
> > > workload.
> > > 
> > > For those cases, IIRC the handler will run on a different (housekeeping) 
> > > CPU when those IRQs originate on an Isolated CPU, meaning the above 
> > > described cacheline bouncing is expected.
> > > 
> > > 
> > > > 
> > > > > On top of that, let's think on a scenario where the threaded handler will 
> > > > > solve a lot of requests, but not necessarily spend a lot of time doing so.
> > > > > This allows the thread to run for little time while solving a lot of 
> > > > > requests.
> > > > >
> > > > > In this scenario, note_interrupt() could return without incrementing 
> > > > > irqs_unhandled for those IRQ that happen while the brief thread is running, 
> > > > > but every other IRQ would cause note_interrupt() to increase 
> > > > > irqs_unhandled, which would cause the bug to still reproduce.
> > > > 
> > > > In theory yes. Does it happen in practice?
> > > > 
> > > > But that exposes a flaw in the actual detection code. The code is
> > > > unconditionally accumulating if there is an unhandled interrupt within
> > > > 100ms after the last unhandled one. IOW, if there is a periodic
> > > > unhandled one every 50ms, the interrupt will be shut down after 100000 *
> > > > 50ms = 5000s ~= 83.3m ~= 1.4h. And it neither cares about the number of
> > > > actually handled interrupts.
> > > > 
> > > > The spurious detector is really about runaway interrupts which hog a CPU
> > > > completely, but the above is not what we want to protect against.
> > > 
> > > Now it makes a lot more sense to me.
> > > Thanks!
> > 
> > Hi Thomas,
> > 
> > I would like to go back to this discussion :)
> > From what I could understand, and read back the thread:
> > 
> > - The spurious detector is used to avoid cpu hog when a lots of IRQs are 
> >   hitting a cpu, but few ( < 100 / 100k) are being handled. It works by
> >   disabling that interruption.
> > 
> > - The bug I am dealing with (on serial8250), happens to fit exactly at
> >   above case: lots of requests, but few are handled.
> >   The reason: threaded handler, many requests, and they are dealt with in 
> >   batch: multiple requests are handled at once, but a single IRQ_HANDLED 
> >   returned.
> > 
> > - My proposed solution: Find a way of accounting the requests handled.
> > 
> >   - Implementation: add an option for drivers voluntarily report how 
> >     many requests they handled. Current drivers need no change.
> 
> >   - Limitation: If this issue is found on another driver, we need to 
> >     implement accounting there as well. This may only happen on drivers
> >     which handle over 1k requests at once.
> 
> > What was left for me TODO:
> > Think on a generic solution for this issue, to avoid dealing with that 
> > in a per-driver basis. 
> > 
> > That's what I was able to think about:
> 
> > - Only the driver code knows how many requests it handled, so without  
> >   touching them we can't know how many requests were properly handled.
> 

Hello Andy, thanks for reviewing!


> Hmm... But do I understand correctly the following:
> 
> - the IRQ core knows the amount of generated IRQs for the device (so it's kinda
> obvious that IRQ number maps to the driver);

Yes, I could understand that as well.

> 
> - the IRQ core disables IRQ while handling an IRQ number in question;

Not necessarily:
When on irqs are force-threaded, only a quick handler is called, returning 
IRQ_WAKE_THREAD, which is supposed to wake up the handler thread.

  * @IRQ_WAKE_THREAD:   handler requests to wake the handler thread

In this case (which is what I am dealing with), the actual handler will run 
in thread context (which I suppose don't disable IRQ for sched-out 
purposes).

> 
> - the driver is supposed to handle all IRQs that were reported at the beginning
> o.f its handler;

That I am not aware about. I suppose it depends on driver implementation.

But if this one is correct, and must be true for every handler, then my 
first approach should be the right fix. See [1] below.


Below I am assuming handled IRQs = 'handlers which returned IRQ_HANDLED':

> 
> - taking the above the amount of handled IRQs is what came till the disabling
> IRQ.

Sure

> IRQs that came after should be replayed when IRQ gets enabled.
> 
> ?

Not sure about this one as well.
You mean the ones that got queued for thread-handling, but somehow got 
paused since the interrupt got disabled?

If not, I guess once you disable an IRQ no interruption on that line happens,
so I don't think any interruption gets saved for later (at least not in 
kernel level).

But I may be wrong here, it's a guess.

> 
> > - I could try thinking a different solution, which involves changing only
> >   the spurious detector.
> > 
> >   - For that I would need to find a particular characteristic we would want 
> >     to avoid spurious detection against, and make sure it won't miss an
> >     actual case we want to be protected about.
> > 
> > Generic solutions(?) proposed:

[1] here:

> > - Zero irqs_unhandled if threaded & handles a single request in 100k
> >   - Problem: A regular issue with the interruption would not be detected 
> >     in the driver. 
> > 
> > - Skip detection if threaded & the handling thread is running
> >   - Problem 1: the thread may run shortly and batch handle a lot of stuff, 
> >   not being detected by the spurious detector. 
> >   - Problem 2: the thread may get stuck, not handle the IRQs and also not
> >   being detected by the spurious handler. (IIUC)
> > 
> > 
> > In the end, I could not find a proper way of telling apart
> > a - "this is a real spurious IRQ behavior, which needs to be disabled", and 
> > b - "this is just a handler that batch-handles it's requests",
> > without touching the drivers' code.
> > 
> > Do you have any suggestion on how to do that?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thanks!
Leo


