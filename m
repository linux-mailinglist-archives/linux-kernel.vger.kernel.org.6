Return-Path: <linux-kernel+bounces-348036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB998E1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29661F25801
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018841D173A;
	Wed,  2 Oct 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HxBWEsHD"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FD31CFEA3
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890782; cv=none; b=IM79MfyMxnlMSTeQRO704rQ/FtWVap0vBtlZkcjLwb4+FavE9CXX6HBTdRdkPqsNz/udbD38XqJ/vMIM3WmtF3NwbsTaQcw+PABpdyAbnN9FkqF6dyEjfnqCNEcgfTHOY9G/PpIiXhdl69vGQw7YbegrjYsWI/Gskts07bRNtR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890782; c=relaxed/simple;
	bh=CiGTgCjOlyk3hZM74g8+7FcOFj9hl0bMj4TBEfGDgLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjR50BNYbj1txLlMUew+MSkJcFUMfND/EoAx+s1996JR/Jp0d9E06jvFOynYXwX2uqEMv4C/WxRBHLUa2enV5sBuGyhaH5qT9mc1R8K6PDJ7ND6kxP7cFvR45WUaXkA9gdu2eP/yNhDmJjiqVrBBJE5pDHg/UaaGqP8DFeuULqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HxBWEsHD; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53997328633so5200171e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727890778; x=1728495578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fcw0AUFxqpg2EROaTPkK5EUAJwDwpjeNdNVYK6kfU4w=;
        b=HxBWEsHD33l220fCDVMg95dxjH1TLri1px1IbhQdKR+JJa7m0WWhu2FR8OHRlRrPNa
         vctSAqlIzQknvoqRmtTUzpCGuxYPnEJH4iTGs0cMbtZk+6iX12/4XxTHuAkv+p4t8DUC
         p1MwXvIIBPqJyLSU1WGKoJy9dRbAg8QtEh/ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890778; x=1728495578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fcw0AUFxqpg2EROaTPkK5EUAJwDwpjeNdNVYK6kfU4w=;
        b=kDRw8CZiZlB2Df19FK0MIQLnIeZnivE5XlNh+wFBy49I375+2s9+h/8pRGoI17E3+E
         CMyklbAkhjVeM6sFrEgs+P5j03hF23Y/n6MfOg9N/LJwMUu1Ng6ostLSuz0PEbNGHqpN
         lDDvXN3NXPaCxDOduqICAOBzYf09UOWpInlI65JvDEqiAo6UxtyDTXd/oigfX3hnAgks
         6hEGdTQZiNEXhzTHpeNCjVBkCNZqv7LyC/fC8cHHALrHBsuM0fje4DgxVCF5m0hOBCHI
         5jJmrY0KwJQjCIGCQgtzTE7IrwqZ8cqxx4Ytgmtd3MfuBolZA7DDx87r3EGQ1/MfkgHW
         iU6w==
X-Forwarded-Encrypted: i=1; AJvYcCU3VifdCYuJhjG8OrN2NgyD2d6e47fDUHGHUT+4ChrdeAmUGEGAlN/VA2sWCig7PJPOBnApV1YEpgLWLiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxlfRDoPXWvCZ+pYZS2QVoGnbLRYESYHduyiKBQwzn3akq963y
	K2v2I2CJqdIuncKEbrik/q5WwSsppH5rz7YdPl/HUZvHoii+cpIqXqACBL2AyRI7yKZqre3UK9p
	d
X-Google-Smtp-Source: AGHT+IFkkGGRt6ZYa2ivnSyZfwRZZdbxsPXq/V+5krSg1JY/Dmo8BxXcr960M1AhDYCPCk4enAaMlw==
X-Received: by 2002:a05:6512:3089:b0:530:b773:b4ce with SMTP id 2adb3069b0e04-539a067bf98mr3609335e87.33.1727890778158;
        Wed, 02 Oct 2024 10:39:38 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a0439baasm1985772e87.214.2024.10.02.10.39.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 10:39:36 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso773971fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 10:39:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRJzJBOsC3RvX/vgPEXjz8ErzQR4mMXKra82w/xtceB4ECOBn+7STG9K3BsgGcyxkhVA/PuiG7SWsCnvg=@vger.kernel.org
X-Received: by 2002:a2e:a9a5:0:b0:2f3:f1ee:2256 with SMTP id
 38308e7fff4ca-2fae10b46a2mr39398791fa.44.1727890772630; Wed, 02 Oct 2024
 10:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241002010205.1341915-1-mathieu.desnoyers@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Oct 2024 10:39:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgztWbA4z85xKob4eS9P=Nt5h4j=HnN+Pc90expskiCRA@mail.gmail.com>
Message-ID: <CAHk-=wgztWbA4z85xKob4eS9P=Nt5h4j=HnN+Pc90expskiCRA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] sched+mm: Track lazy active mm existence with
 hazard pointers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Alan Stern <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com, Mateusz Guzik <mjguzik@gmail.com>, 
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, rcu@vger.kernel.org, linux-mm@kvack.org, 
	lkmm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 18:04, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Hazard pointers appear to be a good fit for replacing refcount based lazy
> active mm tracking.

If the mm refcount is this expensive, I suspect we really shouldn't
use it at all.

The thing is, we don't _need_ to use the mm refcount - the reason the
lazy-tlb handling uses it is because we already had that refcount and
it was easy to extend on existing logic, not because it's really
required any more.

The lazy-tlb activation is basically "I'm switching to a kernel
thread, so I'll re-use the TLB state of the previous thread".

(And yes, it also has a secondary case of "I'm exiting, so I will turn
the mm I already have into a lazy one").

But in the actual task switch case, the previous thread hasn't _lost_
that mm, so we don't actually need to take the refcount at all.

We really just need to make sure to invalidate it before it's torn
down, but we do that *anyway* as part of TLB flushing.

(The exit case is actually different: we are setting it up to be lost,
although delayed - and the lazy count is the delay).

The only thing the refcount means is that we don't actually have to be
as careful when we actually *really* get rid of the MM. We can be a
bit laissez-faire about things because even if we weren't to
invalidate the lazy mm, it does have its own refcount, so we don't
much care.

But in reality, we're actually very careful about the active_mm
_anyway_, because of a fairly fundamental issue: the TLB shootdown and
PCID handling that we need to do even when mm's aren't lazy.

So we actually keep track of things like "which CPU's have seen this
MM state" in all the TLB code.

And even the exit case doesn't actually need the special thing - it
*does* need the "this CPU is still using this MM", but we have that
too as part of the TLB code - entirely independently of 'active_mm'.

So in many ways, I'm pretty sure not just the refcount, but all of
'active_mm', is largely pointless to begin with.

And if the refcount really is this big of a deal:

> nr threads (-t)     speedup
>    192               +28%

then we should probably just strive to get rid of 'active_mm' altogether.

Look, at least on x86 we ALREADY has a better replacement: it's the
percpu 'cpu_tlbstate'.

It basically duplicates all we do with active_mm and the whole "keep
track of old mm state" (the 'loaded_mm' member is basically the true
'active' mm), except it has some additional fixes:

 - it has some extra housekeeping data that the architecture wants
(for PCID updates etc)

 - it's actually atomic wrt the low-level code in ways that
'current->active_mm' isn't

So I think the real issue is that "active_mm" is an old hack from a
bygone era when we didn't have the (much more involved) full TLB
tracking.

               Linus

