Return-Path: <linux-kernel+bounces-362167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F45599B1C4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BD2282C26
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749E713D8AC;
	Sat, 12 Oct 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiX1Butm"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933B12CDA5;
	Sat, 12 Oct 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718892; cv=none; b=HTIIXACLWiDTdy/UmjOQFSL1gpmxRQuXdK62EkJmqUX79iZWUUgvFY71gzYpdh32rY8rG4KLQWMXtpmD7R5RS5ChQOvZ/tEZbz96wJhfO8CKl1TC7ijC9jBSTxUUzeJNGRj+CSGxaMuOL3BrgRS3fhPsAMl0jBCf67puIoMSy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718892; c=relaxed/simple;
	bh=C6vxUMuUgbc//o8xxgjgtkEkKNHObIzPQ6IDDSBZ+yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzOdYcAwWgx9K4capp41zYIR35M1cPMMfSDW+8T6jME5mV6PV6iA6W4M5FV+dYVj4C3LA5PzPVkQ9lh+h0+vxxT0qOxZKTbmCkIDETPJ19Edsxa5ywUT9rUfAPHZxxIBPoClZd03FYcfo3LvE0R8k3p2GMg27I65ThSiW2ApRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiX1Butm; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460391553ecso24782521cf.1;
        Sat, 12 Oct 2024 00:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728718890; x=1729323690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbn00snT5n8JNxO9dijqP+j0PzbaWVzK1UL6wiNYCPc=;
        b=eiX1ButmFRcAj/8ckjdbmWp+HCtVYN0yKGkRZB/8Qg6+7U6b7HZvCzQLMzRct8x5B5
         AZUkBk6XjOAjHJYXgql8Q1fIS53+Zue70WCqe+9qN88SfUd8S5YUnU1XZrRPkZRT0Ba/
         HXIuNodbEizeEYfzoKxdTkGqMMHiwNmx+5pqUGOPk/3Ns2fcXzG05RoJtIUtgAdG4XMw
         elzXXJSCe8LEeEgnIzAT6lWp4g3N7qFmT3ohFk7XmZuoy87jnoxQ6/SF1xlYQ+U0dkx+
         OqkrZCrq4C5PmllgkykTjKct7xfI641+Yk95li0W6eGAeGZkb4nVnmecCU2GrKq1RL+1
         YfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728718890; x=1729323690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbn00snT5n8JNxO9dijqP+j0PzbaWVzK1UL6wiNYCPc=;
        b=E7YV64xYi2q/xUauSbOOhXY7EAwMV9N6j9LpeUyaPww6UULIGzKw7MJes2SU+BNvJj
         ls30DvF9LXESJmhy1kqAByzOizvnAzFQTWZTzP9LiU1JrQ8g7resnWE4bK9XBQWCQxKz
         9Ay4WuJeK9DpsRHjlSIlamoM2Dg8XFqyhX2LOg//IiQbo6T5D74Z3hFrDcHzA2usFb/M
         lAWSYLZsNpE9xzOwohuFtBBnprqxZXhv4tWvB7qukg2aOfkzf5jILDQ6AkX7/OXYr8jL
         yIlzTKY2GT+SO1GRjOzFxyb0dSo9T/GRrzz9ZRrXYMpKuTcfZ2YjjAPxUuS6X1x5msV/
         sSkw==
X-Forwarded-Encrypted: i=1; AJvYcCVrghptC9J0iJAe4lxy17GecAj6+mgaExXcJF0pvBfFhcXcsYk551UBJ+zVndeQTzdao4ZW7Sm1/TdjQfozQ7Q=@vger.kernel.org, AJvYcCWUfYJ3QDkiN15AO2M4Rh118ablKFqhT1saPO66+e6roQRO+hjk8b3TPtgq19CUfvkacWEKz71gER7Byg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTkvnSjJsRa8Nf6cc9g06lbNfclcqfLAooZAnhkhQFaFuVSpwx
	iVADfln1QYAD0zE8OLN9FnXZvH4T04JTDQkNKzggynjcIYoPYg7N
X-Google-Smtp-Source: AGHT+IGnVA0oEIa/QkIGZB2guwOMqCZX0aTzylYTM52WpkC+pUQgN9CuV1JRqQhX0uUNCWZyeoBQ6w==
X-Received: by 2002:a05:622a:d2:b0:458:34df:1e5c with SMTP id d75a77b69052e-460583e8b4amr40066201cf.12.1728718889585;
        Sat, 12 Oct 2024 00:41:29 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46042894150sm22845191cf.85.2024.10.12.00.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:41:29 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id A168A1200066;
	Sat, 12 Oct 2024 03:41:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 12 Oct 2024 03:41:28 -0400
X-ME-Sender: <xms:KCgKZwkBSHRZ9qSozdOIHjZeS6tdaNcEb95IIxrp2LLxrt2hU_a4PQ>
    <xme:KCgKZ_2i2D3kebp5jDnLFwy3gxt8Y0FGi1ANb7B6HQQDUTAyMvbOVuk2QJhBEz2RC
    gZAO8bbz4Rdj4SU9A>
X-ME-Received: <xmr:KCgKZ-oLSZZVPj00nFUzKP_VRyri57nGk7QGA2G9-HyAr-JXRceqxYxJLGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epughirhhkrdgsvghhmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgu
    sghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlhihuuggvsehrvgguhhgrth
    drtghomhdprhgtphhtthhopeguihhrkhdrsggvhhhmvgesuggvrdgsohhstghhrdgtohhm
    pdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvg
    igrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhhnrgdqmhgrrhhi
    rgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:KCgKZ8m6acrBkFwMACg-RBpoAcpF5n48UFvlp1nwCU0V3D7j8ZdXOA>
    <xmx:KCgKZ-3hZOihHW7t9op52ZC21t0vVbQtMS2yOuTZHTmPxsV8iol5kg>
    <xmx:KCgKZzu8UeP4G9l7ZU6gai9O_kzwyh1n25EVdpj7fCEhCgKXesIs-A>
    <xmx:KCgKZ6W461thCfizwzQ2Mt6so6BpCYTzLRQjZB-UhQyJbwLHkqQyNw>
    <xmx:KCgKZx2pDkIZU397TJKR809gBnoa22XMJ1Sq0EUi878D73s04pQ4BZcj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 03:41:28 -0400 (EDT)
Date: Sat, 12 Oct 2024 00:41:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
Message-ID: <ZwooHrqIiirl1so7@boqun-archlinux>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
 <ZvwKTinnLckZm8aQ@boqun-archlinux>
 <87a5falmjy.fsf@kernel.org>
 <dae08234-c9ba-472d-b769-1d07e579a8ac@gmail.com>
 <Zwmy-2Yc7vGboYvl@boqun-archlinux>
 <d2ce38a3-9a32-4f4c-88f2-22864b66afe5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ce38a3-9a32-4f4c-88f2-22864b66afe5@gmail.com>

On Sat, Oct 12, 2024 at 07:19:41AM +0200, Dirk Behme wrote:
> On 12.10.24 01:21, Boqun Feng wrote:
> > On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
> > > Hi Andreas,
> > > 
> > > Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
> > > > 
> > > > Dirk, thanks for reporting!
> > > 
> > > :)
> > > 
> > > > Boqun Feng <boqun.feng@gmail.com> writes:
> > > > 
> > > > > On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
> > > > > > On 18.09.2024 00:27, Andreas Hindborg wrote:
> > > > > > > Hi!
> > > > > > > 
> > > > > > > This series adds support for using the `hrtimer` subsystem from Rust code.
> > > > > > > 
> > > > > > > I tried breaking up the code in some smaller patches, hopefully that will
> > > > > > > ease the review process a bit.
> > > > > > 
> > > > > > Just fyi, having all 14 patches applied I get [1] on the first (doctest)
> > > > > > Example from hrtimer.rs.
> > > > > > 
> > > > > > This is from lockdep:
> > > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
> > > > > > 
> > > > > > Having just a quick look I'm not sure what the root cause is. Maybe mutex in
> > > > > > interrupt context? Or a more subtle one?
> > > > > 
> > > > > I think it's calling mutex inside an interrupt context as shown by the
> > > > > callstack:
> > > > > 
> > > > > ]  __mutex_lock+0xa0/0xa4
> > > > > ] ...
> > > > > ]  hrtimer_interrupt+0x1d4/0x2ac
> > > > > 
> > > > > , it is because:
> > > > > 
> > > > > +//! struct ArcIntrusiveTimer {
> > > > > +//!     #[pin]
> > > > > +//!     timer: Timer<Self>,
> > > > > +//!     #[pin]
> > > > > +//!     flag: Mutex<bool>,
> > > > > +//!     #[pin]
> > > > > +//!     cond: CondVar,
> > > > > +//! }
> > > > > 
> > > > > has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
> > > > > irq-off is needed for the lock, because otherwise we will hit a self
> > > > > deadlock due to interrupts:
> > > > > 
> > > > > 	spin_lock(&a);
> > > > > 	> timer interrupt
> > > > > 	  spin_lock(&a);
> > > > > 
> > > > > Also notice that the IrqDisabled<'_> token can be simply created by
> > > > > ::new(), because irq contexts should guarantee interrupt disabled (i.e.
> > > > > we don't support nested interrupts*).
> > > > 
> > > > I updated the example based on the work in [1]. I think we need to
> > > > update `CondVar::wait` to support waiting with irq disabled.
> > > 
> > > Yes, I agree. This answers one of the open questions I had in the discussion
> > > with Boqun :)
> > > 
> > > What do you think regarding the other open question: In this *special* case
> > > here, what do you think to go *without* any lock? I mean the 'while *guard
> > > != 5' loop in the main thread is read only regarding guard. So it doesn't
> > > matter if it *reads* the old or the new value. And the read/modify/write of
> > > guard in the callback is done with interrupts disabled anyhow as it runs in
> > > interrupt context. And with this can't be interrupted (excluding nested
> > > interrupts). So this modification of guard doesn't need to be protected from
> > > being interrupted by a lock if there is no modifcation of guard "outside"
> > > the interupt locked context.
> > > 
> > > What do you think?
> > > 
> > 
> > Reading while there is another CPU is writing is data-race, which is UB.
> 
> Could you help to understand where exactly you see UB in Andreas' 'while
> *guard != 5' loop in case no locking is used? As mentioned I'm under the

Sure, but could you provide the code of what you mean exactly, if you
don't use a lock here, you cannot have a guard. I need to the exact code
to point out where the compiler may "mis-compile" (a result of being
UB).

> impression that it doesn't matter if the old or new guard value is read in
> this special case.
> 

For one thing, if the compiler believes no one is accessing the value
because the code uses an immutable reference, it can "optimize" the loop
away:

	while *var != 5 {
	    do_something();
	}

into
	
	if *var != 5 {
	    loop { do_something(); }
	}

But as I said, I need to see the exact code to suggest a relevant
mis-compile, and note that sometimes, even mis-compile seems impossible
at the moment, a UB is a UB, compilers are free to do anything they
want (or don't want). So "mis-compile" is only helping we understand the
potential result of a UB.

Regards,
Boqun

> Best regards
> 
> Dirk
> 
> 
> > Regards,
> > Boqun
> > 
> > > Thanks
> > > 
> > > Dirk
> > > 
> > > 
> > > > Without
> > > > this, when we get back from `bindings::schedule_timeout` in
> > > > `CondVar::wait_internal`, interrupts are enabled:
> > > > 
> > > > ```rust
> > > > use kernel::{
> > > >       hrtimer::{Timer, TimerCallback, TimerPointer, TimerRestart},
> > > >       impl_has_timer, new_condvar, new_spinlock, new_spinlock_irq,
> > > >       irq::IrqDisabled,
> > > >       prelude::*,
> > > >       sync::{Arc, ArcBorrow, CondVar, SpinLock, SpinLockIrq},
> > > >       time::Ktime,
> > > > };
> > > > 
> > > > #[pin_data]
> > > > struct ArcIntrusiveTimer {
> > > >       #[pin]
> > > >       timer: Timer<Self>,
> > > >       #[pin]
> > > >       flag: SpinLockIrq<u64>,
> > > >       #[pin]
> > > >       cond: CondVar,
> > > > }
> > > > 
> > > > impl ArcIntrusiveTimer {
> > > >       fn new() -> impl PinInit<Self, kernel::error::Error> {
> > > >           try_pin_init!(Self {
> > > >               timer <- Timer::new(),
> > > >               flag <- new_spinlock_irq!(0),
> > > >               cond <- new_condvar!(),
> > > >           })
> > > >       }
> > > > }
> > > > 
> > > > impl TimerCallback for ArcIntrusiveTimer {
> > > >       type CallbackTarget<'a> = Arc<Self>;
> > > >       type CallbackTargetParameter<'a> = ArcBorrow<'a, Self>;
> > > > 
> > > >       fn run(this: Self::CallbackTargetParameter<'_>, irq: IrqDisabled<'_>) -> TimerRestart {
> > > >           pr_info!("Timer called\n");
> > > >           let mut guard = this.flag.lock_with(irq);
> > > >           *guard += 1;
> > > >           this.cond.notify_all();
> > > >           if *guard == 5 {
> > > >               TimerRestart::NoRestart
> > > >           }
> > > >           else {
> > > >               TimerRestart::Restart
> > > > 
> > > >           }
> > > >       }
> > > > }
> > > > 
> > > > impl_has_timer! {
> > > >       impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
> > > > }
> > > > 
> > > > 
> > > > let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
> > > > let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
> > > > 
> > > > kernel::irq::with_irqs_disabled(|irq| {
> > > >     let mut guard = has_timer.flag.lock_with(irq);
> > > > 
> > > >     while *guard != 5 {
> > > >         pr_info!("Not 5 yet, waiting\n");
> > > >         has_timer.cond.wait(&mut guard); // <-- we arrive back here with interrupts enabled!
> > > >     }
> > > > });
> > > > ```
> > > > 
> > > > I think an update of `CondVar::wait` should be part of the patch set [1].
> > > > 
> > > > 
> > > > Best regards,
> > > > Andreas
> > > > 
> > > > 
> > > > [1] https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/
> > > > 
> > > > 
> > > 
> 

