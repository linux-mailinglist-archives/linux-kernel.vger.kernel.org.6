Return-Path: <linux-kernel+bounces-349029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7698E98EFB9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DCE281DDC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9465A19882C;
	Thu,  3 Oct 2024 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTrE65RJ"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51978194C89;
	Thu,  3 Oct 2024 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959962; cv=none; b=Ku8Is8XvVRd66hHDOQMNJxQZ67OCjR5JOOPIld/iEfUsk2eMeDJ6OLBDVWBQmXAr+9KSduH0urRcym4O98pwnDGeNgbiWogP/TbDuEF2098Y8D0WoL6oRUPBa/KRrONEneREpNRg0s/+aSXLjXDgJPW03gpLebp/8Gm0fj4GkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959962; c=relaxed/simple;
	bh=khLVJd/khrbcyKvfeyjZKxNO2vMzh5KkYv65lpoHlhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDqteB9z2LJM5K591W70/HLlHuAiJB0HL1VqiUtxjBoDckuVjah2W8iG4ca5ow/72HCdOxB7V+sWoZ8Gss7Z9GCcWvaUNGm5hSQ0Bz05aPwOIt8YYPlnbGSNaFZBN8tdk0257BgOPMXwPwvXszkYvHaPozhftk8W21p26P2EZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTrE65RJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb4c013b78so8133656d6.1;
        Thu, 03 Oct 2024 05:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727959960; x=1728564760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sN9S/YhRYTLZ2H8silYoJ8/74mtShWONNXIjmQBTqZc=;
        b=FTrE65RJEbOvqeuwB6UC7udO50yiT4t19MANEIowgjHF45POFYc76IW4bLIwmQpYnu
         ACNPq2qVLRGrj64j2x72+0NJlmXs+ATyYJuUuG7SyG3xGFdzvgIPby7rlfLqAiwQXSrx
         4WzcNdoLyRJ6y0C/DGogKzOxNJlyFNTVI49ZOosJe9ejPVUP4cvyTOZfEJJ+O8Yn3/q8
         ChD3XTfjYdyKgSJmk7pDH+rM1aPvGIeBmvZhKcf916gNERCPKnzWrTcryXL6IDFcuRaA
         DmAGVQQuFzKBn7PSh5QHcoLUwHkGLFJSB/EjyHDxlshbv4IWX2wjCtGQ38XCgpLxsnrT
         hocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727959960; x=1728564760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sN9S/YhRYTLZ2H8silYoJ8/74mtShWONNXIjmQBTqZc=;
        b=TQGtiZiAPgyGyoVX7fbXlv6df1JMmLlnCPN9OUxQ+22Z8xQkwB1kCyAPmDEEL8Y1oy
         dl9qn5IBRxdoS+FhyfdXzY4e7GHcswpPNLQvlFjuFq24oRaJ0aUQL4281D5IqkNffaIn
         o1o9i2aC6rDotR+djrTvtho4Pjgvfi6/jqxymW4r/5Xs34K9YlHnbbcMo9ywzn/m8zEA
         zuKWrcoQpa14mX/S5XZrce9CShhhDop2q13H4PbGYidy+JNJhyLK9DJymCkYHY0IEWdl
         63j/aq5Xfym94HYP45XTPw9Aeg8OyI+R8WDzEhekH8k7Lvz6cIidvhapxdlq0c4mu1vy
         UDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv43M1yGfDdkh6YedaP4wpZ4awPZoqnF5oUofg9SHmo1OSAK7UfRZTgF74f0+dHJ7zAe6f3bb2RprHhQ0=@vger.kernel.org, AJvYcCWbJJo1ZRbmaH8YcnZxz085H3xVSZXBdjlfneIkjEbsq70+JnRrY57ShMtSqi56rxbztFsUYCddb9deELA0Hfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYKgqNOJ4Ymn37UFHQ2G9esTgDgIu9AAkDNnZUSE7UCIwOFHFb
	+bpUw21/pYppHQiyFoe6BLpKcBSw1UctNcEiCWxHcOa4d5FIQadh
X-Google-Smtp-Source: AGHT+IHRZabhu2MeY/IlSax4oabkiDy7Y/cgar7eg5004ZKQ82AFd4jrQU+9WPBQ6DPx8BVfBq43rg==
X-Received: by 2002:a05:6214:3b8a:b0:6cb:7e7a:ae92 with SMTP id 6a1803df08f44-6cb81b98887mr93423186d6.45.1727959960117;
        Thu, 03 Oct 2024 05:52:40 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb937d1a7asm6165586d6.99.2024.10.03.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 05:52:39 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id C10EE1200043;
	Thu,  3 Oct 2024 08:52:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 08:52:38 -0400
X-ME-Sender: <xms:lpP-ZlrP8NVIWEcEdm9xifVHvqYvH4X_QG6Gr6FBzTwIZIIkPmyhqA>
    <xme:lpP-ZnpBwey1O0GVmRGiGcgS_noll847aDMMIfBB9yUsl3S3hfT2rPpEJ-7l7KmAV
    jaHDmgvK3ru7Te7yQ>
X-ME-Received: <xmr:lpP-ZiPV9I6XuiMZZUe-lg_m2iwnWH01ulvzqmk-9xCOEJB1BN917lnxISTRPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeffvdehfeejjeeliefgtdduuddtjeejveeuveeu
    geefleefkeekuefgudeuhfefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlfi
    hnrdhnvghtpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonh
    grlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghnghep
    pehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdefpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihig
    rdguvgdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegurghkrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrg
    hnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggr
    ugdrohhrgh
X-ME-Proxy: <xmx:lpP-Zg6e4_Cx3ge9tPpd80lsKQSva1Pp-YCPZsOUAUm0ixmaBWROmA>
    <xmx:lpP-Zk6kFiYQJV6jghUoNX6qkYIDkWHvQGVggA4dWUvFgpM3S6ohPA>
    <xmx:lpP-ZoilECxcpgW9tymybJQK1J340sgp5ipFOftwS3wn4a83RBMG0g>
    <xmx:lpP-Zm48zLMZyibNKr2E5Qrsi58SSt3vMxUdBaHM1fnUDmLmb30kxA>
    <xmx:lpP-ZrJbWS6ro400DkTQ7xqOpIct63ZezZdsP0lwkxOf9zz2BL1K--4I>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 08:52:38 -0400 (EDT)
Date: Thu, 3 Oct 2024 05:51:31 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Benno Lossin <benno.lossin@proton.me>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v6 3/3] rust: sync: Add SpinLockIrq
Message-ID: <Zv6TU_p4WMELMj_G@boqun-archlinux>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-4-lyude@redhat.com>
 <8734lew7jn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734lew7jn.ffs@tglx>

On Wed, Oct 02, 2024 at 10:53:32PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 16 2024 at 17:28, Lyude Paul wrote:
> > A variant of SpinLock that is expected to be used in noirq contexts, and
> > thus requires that the user provide an kernel::irq::IrqDisabled to prove
> > they are in such a context upon lock acquisition. This is the rust
> > equivalent of spin_lock_irqsave()/spin_lock_irqrestore().
> 
> This fundamentally does not work with CONFIG_PREEMPT_RT. See:
> 
>    https://www.kernel.org/doc/html/latest/locking/locktypes.html
> 
> for further information. TLDR:
> 
> On RT enabled kernels spin/rw_lock are substituted by sleeping locks. So
> you _cannot_ disable interrupts before taking the lock on RT enabled
> kernels. That will result in a 'might_sleep()' splat.
> 

One thing I was missing when I suggested Lyude with the current API is
that local_irq_save() disables interrupts even on RT. I was under the
impression that local_irq_save() will only disable preemption per:

	https://lwn.net/Articles/146861/

but seems it's not the case right now: we move the RT vs non-RT games
and hardware interrupt disabling vs preemption/migration disabling to
local_lock_*() I guess?

> There is a reason why the kernel has two distinct spinlock types:
> 
>     raw_spinlock_t and spinlock_t
> 
> raw_spinlock_t is a real spinning lock independent of CONFIG_PREEMPT_RT,
> spinlock_t is mapped to raw_spinlock_t on CONFIG_PREEMPT_RT=n and to a
> rtmutex based implementation for CONFIG_PREEMPT_RT=y.
> 
> As a consequence spin_lock_irq() and spin_lock_irqsave() will _NOT_
> disable interrupts on a CONFIG_PREEMPT_RT=y kernel.
> 
> The proposed rust abstraction is not suitable for that.
> 
> At this phase of rust integration there is no need to wrap
> raw_spinlock_t, so you have two options to solve that:
> 
>    1) Map Rust's SpinLockIrq() to spin_lock_irqsave() and
>       spin_unlock_irqrestore() which does the right thing
> 
>    2) Play all the PREEMPT_RT games in the local irq disable abstraction
> 
> #1 is the right thing to do because no driver should rely on actually
> disabling interrupts on the CPU. If there is a driver which does that,
> then it's not compatible with RT and should use a local lock instead.
> 
> local locks aside of being RT compatible have the benefit that they give
> scope to the protected region/data, while a plain local_irq_disable()
> does not.
> 
> Don't even think about exposing this 'with_irq_disabled' interface
> unless you are trying to move actual core code like the scheduler or low
> level interrupt handling to rust.
> 
> Create explicit interrupt safe interfaces which map to the underlying
> locking primitives instead.
> 

Then we should have a SpinLockIrq<T> type, and a function:

	fn with_locked<U>(&self, cb: impl FnOnce(&mut T) -> U) -> U {
	    <spin_lock_irqsave()>
	    let ret = cb(...);
	    <spin_lock_irqrestore()>
	    ret
	}

FYI, the reason that we cannot have a SpinLockIrq::lock() return a guard
that holds the irq state is because:

	https://github.com/Rust-for-Linux/linux/issues/998

namely:

	// interrupts are enabled here.
	let a = spin_lock_irq1.lock();
	let b = spin_lock_irq2.lock();

	drop(a); // releasing spin_lock_irq1 and restore the irq state.
	// `b` exists with interrupts enabled, which breaks the
	// invariants of b.

(technically we can, but that requires a rework of how nested
irq_save()s are handled, that's another can of worms)

Regards,
Boqun

> Thanks,
> 
>         tglx
> 
> 

