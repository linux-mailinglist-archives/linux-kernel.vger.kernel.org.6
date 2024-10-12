Return-Path: <linux-kernel+bounces-362635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6040099B77E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 00:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57C01F21D8F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E119AD97;
	Sat, 12 Oct 2024 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRoZtndp"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B113D897;
	Sat, 12 Oct 2024 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728771985; cv=none; b=MfipJHy4tbShsyd5oRdJrPSDeb/zVh+vraMIrliVjFWubNFur3mTXaz2Zz4dubmrhsVX7RfkPT+lO4vUdxbVDQhr1hln2Ua16D1pHyBd98TH9DBkfLlZjZcnMkKwDrfEj7ptgU0NwMx7Ju29PJnMJyHtaSzM1bNZpwdxbGvaDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728771985; c=relaxed/simple;
	bh=epAriPY3WLAExXjkcan2mYIIr2HDZQ681EWkhmSKC5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwKrzQPzKLx7K1q8Y0PObbSrgpWGZe1wHgjXYvHi3mugaNXh/2pAcZJx/P1/jnI+OaxRn27tvv5xiPMdgeENwfNKAu0Zk1MXTCii6m3xrASC/2XunLJ6HlVi/70ToLr7FDk0iWIekHhrTQeW1tRrLIcP+9Pti8M4T7RXdptPtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRoZtndp; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460391553ecso29375781cf.1;
        Sat, 12 Oct 2024 15:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728771982; x=1729376782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTODEmh12WV27DmJevPolR2loY5BXrBdlVbSmnzD1QY=;
        b=NRoZtndpfI+tiQfDJEq0/VZSY8WYLA/6HrFufnM/gri44DIUxG5f1GhCh5VPZsucqb
         GLB4s1KRKrxQ7wZJSwtudo2MkNUzvxOSJ01JN+B5b+eJBSFmehAruJjvHqecBWwx/TB1
         db3tKKerYuVjsgmz+XQd0pc2xLTBglDURKlKFVfDQAPey6dBG8Xj3dKtCph5HykbivuX
         VIx7e+VkBdUrmoXbMOFwhQNcOabHmLnUulJ6FMM4Gr6Qyq9zb9UaRHU39ynn3NNd2ksN
         Fa4T32jPhIuiANGQGtTdR8bgv6c/6EVmbJTEmeqtnEIEvYr6XfAsiIhjc5I16BkeaEAU
         540A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728771982; x=1729376782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTODEmh12WV27DmJevPolR2loY5BXrBdlVbSmnzD1QY=;
        b=FMF4mxIj8Ro7F4OqoUP6JN4ARee6sDWUdl8sQyyait7mduYTP6DQaDS50LHolj1OVi
         2bwAquV+FF9wl0x+GNwbwfxP7D7eoJSKd99NTn4NTO+bA6RybbEnbVSB5hSZeOGGLzDB
         mV1HJ5MPatsnvKZ3NAqcBCO6Oklkv0E06RoTDowdMm0rXkMTfDfeoIDW+VPf5nDecJmf
         wC7D7P5SMczbcn0gxHNeab23dYMfKqAqp2QsD2zVU1A13myTZM/mJJVCisFaLCqU0vgh
         a2SPY8rQP1dNEbM6Z20xxeqnPVkPA+hTdybOdJIIAgHVwuqVT6umHtoJ9CunXHlu7NTE
         3eiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwcbQ85nVW5PBxDCiwoFzQqYC3lbpjhYGPmysFCBtd7/kkNawH4N7z3DambSJ+JgOoB3Xls/LsKaBVVCw=@vger.kernel.org, AJvYcCWizdB6ZLP0Ebfq9mzAFt1GBWjaBQsW4Ry8J5yWhGmik/RVnh8CkU5h/8spX1PoctejT4qF9COO/FLsf7wjGPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdVs+wt4AgjJSSl8jvZmtmo/zeqmjpcUYNzIXY8UcoS1N9eRQw
	ZgOqlgUf6HbD1vN2vHS1FazfJzVCJXQweFsFfdNmdk4X7pJCweEy
X-Google-Smtp-Source: AGHT+IHo+K4CHdxiWrn+d0YLQNlnpkyWalifOQGqBS4uhKoB6SYjRuTpR96I9kFz1YMa0au8Bvq2Ug==
X-Received: by 2002:ac8:6f0c:0:b0:458:3cb6:13cb with SMTP id d75a77b69052e-460584f2a22mr71586321cf.56.1728771981991;
        Sat, 12 Oct 2024 15:26:21 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148c70a4sm264784285a.22.2024.10.12.15.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 15:26:21 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id E64A0120007C;
	Sat, 12 Oct 2024 18:26:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 12 Oct 2024 18:26:20 -0400
X-ME-Sender: <xms:jPcKZ_rIoIWNT9dAG7hvQ_dPmN6__pvkGtNMBwptPldW_YCh_fJcgg>
    <xme:jPcKZ5pKdLSLVaudcvR26gT01_EL76kOJx9uJY8HiYI_G2QVGrTzTkFPpyrJt_1ME
    XvPirNCsx-4T57Eow>
X-ME-Received: <xmr:jPcKZ8N34pkR_gnuhLAStn_40aKZ5Wa_HxQg598uVHL-BGJnIT9FuypTaN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegvddguddtucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:jPcKZy6crcP4IF9qB1RyU9PJlMyQuWlev7zV4Y68dOKEsseFlcu_Vg>
    <xmx:jPcKZ-6X6GVmCfbanRuWrnD4GtifvaU5zznAFZZqiKsII3S0x9mmaw>
    <xmx:jPcKZ6gg11DFzb-zClOG4bSOorU4diiL1IZVJr-lsJ0fMqs7iHuVQA>
    <xmx:jPcKZw5pbfBWrGg_ZkYf_U5gHdHQH1hR2dCcyfJWZ3Q9yHbdbubPZQ>
    <xmx:jPcKZ9IbkbAl2rIeVZ2nBkaIVcfZUAllvk0LLlmU3LFqzK9Vu0oz0A7a>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 18:26:20 -0400 (EDT)
Date: Sat, 12 Oct 2024 15:26:19 -0700
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
Message-ID: <Zwr3i4x7J5qyjFog@Boquns-Mac-mini.local>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
 <ZvwKTinnLckZm8aQ@boqun-archlinux>
 <87a5falmjy.fsf@kernel.org>
 <dae08234-c9ba-472d-b769-1d07e579a8ac@gmail.com>
 <Zwmy-2Yc7vGboYvl@boqun-archlinux>
 <d2ce38a3-9a32-4f4c-88f2-22864b66afe5@gmail.com>
 <ZwooHrqIiirl1so7@boqun-archlinux>
 <4dd93603-04fa-4da4-b867-bd12ece4b391@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd93603-04fa-4da4-b867-bd12ece4b391@gmail.com>

On Sat, Oct 12, 2024 at 09:50:00AM +0200, Dirk Behme wrote:
> On 12.10.24 09:41, Boqun Feng wrote:
> > On Sat, Oct 12, 2024 at 07:19:41AM +0200, Dirk Behme wrote:
> > > On 12.10.24 01:21, Boqun Feng wrote:
> > > > On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
> > > > > Hi Andreas,
> > > > > 
> > > > > Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
> > > > > > 
> > > > > > Dirk, thanks for reporting!
> > > > > 
> > > > > :)
> > > > > 
> > > > > > Boqun Feng <boqun.feng@gmail.com> writes:
> > > > > > 
> > > > > > > On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
> > > > > > > > On 18.09.2024 00:27, Andreas Hindborg wrote:
> > > > > > > > > Hi!
> > > > > > > > > 
> > > > > > > > > This series adds support for using the `hrtimer` subsystem from Rust code.
> > > > > > > > > 
> > > > > > > > > I tried breaking up the code in some smaller patches, hopefully that will
> > > > > > > > > ease the review process a bit.
> > > > > > > > 
> > > > > > > > Just fyi, having all 14 patches applied I get [1] on the first (doctest)
> > > > > > > > Example from hrtimer.rs.
> > > > > > > > 
> > > > > > > > This is from lockdep:
> > > > > > > > 
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
> > > > > > > > 
> > > > > > > > Having just a quick look I'm not sure what the root cause is. Maybe mutex in
> > > > > > > > interrupt context? Or a more subtle one?
> > > > > > > 
> > > > > > > I think it's calling mutex inside an interrupt context as shown by the
> > > > > > > callstack:
> > > > > > > 
> > > > > > > ]  __mutex_lock+0xa0/0xa4
> > > > > > > ] ...
> > > > > > > ]  hrtimer_interrupt+0x1d4/0x2ac
> > > > > > > 
> > > > > > > , it is because:
> > > > > > > 
> > > > > > > +//! struct ArcIntrusiveTimer {
> > > > > > > +//!     #[pin]
> > > > > > > +//!     timer: Timer<Self>,
> > > > > > > +//!     #[pin]
> > > > > > > +//!     flag: Mutex<bool>,
> > > > > > > +//!     #[pin]
> > > > > > > +//!     cond: CondVar,
> > > > > > > +//! }
> > > > > > > 
> > > > > > > has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
> > > > > > > irq-off is needed for the lock, because otherwise we will hit a self
> > > > > > > deadlock due to interrupts:
> > > > > > > 
> > > > > > > 	spin_lock(&a);
> > > > > > > 	> timer interrupt
> > > > > > > 	  spin_lock(&a);
> > > > > > > 
> > > > > > > Also notice that the IrqDisabled<'_> token can be simply created by
> > > > > > > ::new(), because irq contexts should guarantee interrupt disabled (i.e.
> > > > > > > we don't support nested interrupts*).
> > > > > > 
> > > > > > I updated the example based on the work in [1]. I think we need to
> > > > > > update `CondVar::wait` to support waiting with irq disabled.
> > > > > 
> > > > > Yes, I agree. This answers one of the open questions I had in the discussion
> > > > > with Boqun :)
> > > > > 
> > > > > What do you think regarding the other open question: In this *special* case
> > > > > here, what do you think to go *without* any lock? I mean the 'while *guard
> > > > > != 5' loop in the main thread is read only regarding guard. So it doesn't
> > > > > matter if it *reads* the old or the new value. And the read/modify/write of
> > > > > guard in the callback is done with interrupts disabled anyhow as it runs in
> > > > > interrupt context. And with this can't be interrupted (excluding nested
> > > > > interrupts). So this modification of guard doesn't need to be protected from
> > > > > being interrupted by a lock if there is no modifcation of guard "outside"
> > > > > the interupt locked context.
> > > > > 
> > > > > What do you think?
> > > > > 
> > > > 
> > > > Reading while there is another CPU is writing is data-race, which is UB.
> > > 
> > > Could you help to understand where exactly you see UB in Andreas' 'while
> > > *guard != 5' loop in case no locking is used? As mentioned I'm under the
> > 
> > Sure, but could you provide the code of what you mean exactly, if you
> > don't use a lock here, you cannot have a guard. I need to the exact code
> > to point out where the compiler may "mis-compile" (a result of being
> > UB).
> 
> 
> I thought we are talking about anything like
> 
> #[pin_data]
> struct ArcIntrusiveTimer {
>       #[pin]
>       timer: Timer<Self>,
>       #[pin]
> -      flag: SpinLockIrq<u64>,
> +      flag: u64,
>       #[pin]
>       cond: CondVar,
> }
> 
> ?
> 

Yes, but have you tried to actually use that for the example from
Andreas? I think you will find that you cannot write to `flag` inside
the timer callback, because you only has a `Arc<ArcIntrusiveTimer>`, so
not mutable reference for `ArcIntrusiveTimer`. You can of course use
unsafe to create a mutable reference to `flag`, but it won't be sound,
since you are getting a mutable reference from an immutable reference.

Regards,
Boqun

> Best regards
> 
> Dirk
> 
> > > impression that it doesn't matter if the old or new guard value is read in
> > > this special case.
> > > 
> > 
> > For one thing, if the compiler believes no one is accessing the value
> > because the code uses an immutable reference, it can "optimize" the loop
> > away:
> > 
> > 	while *var != 5 {
> > 	    do_something();
> > 	}
> > 
> > into
> > 	
> > 	if *var != 5 {
> > 	    loop { do_something(); }
> > 	}
> > 
> > But as I said, I need to see the exact code to suggest a relevant
> > mis-compile, and note that sometimes, even mis-compile seems impossible
> > at the moment, a UB is a UB, compilers are free to do anything they
> > want (or don't want). So "mis-compile" is only helping we understand the
> > potential result of a UB.
> > 
> > Regards,
> > Boqun
> > 
> > > Best regards
> > > 
> > > Dirk
> > > 
> > > 
> > > > Regards,
> > > > Boqun
> > > > 
> > > > > Thanks
> > > > > 
> > > > > Dirk
> > > > > 
> > > > > 
> > > > > > Without
> > > > > > this, when we get back from `bindings::schedule_timeout` in
> > > > > > `CondVar::wait_internal`, interrupts are enabled:
> > > > > > 
> > > > > > ```rust
> > > > > > use kernel::{
> > > > > >        hrtimer::{Timer, TimerCallback, TimerPointer, TimerRestart},
> > > > > >        impl_has_timer, new_condvar, new_spinlock, new_spinlock_irq,
> > > > > >        irq::IrqDisabled,
> > > > > >        prelude::*,
> > > > > >        sync::{Arc, ArcBorrow, CondVar, SpinLock, SpinLockIrq},
> > > > > >        time::Ktime,
> > > > > > };
> > > > > > 
> > > > > > #[pin_data]
> > > > > > struct ArcIntrusiveTimer {
> > > > > >        #[pin]
> > > > > >        timer: Timer<Self>,
> > > > > >        #[pin]
> > > > > >        flag: SpinLockIrq<u64>,
> > > > > >        #[pin]
> > > > > >        cond: CondVar,
> > > > > > }
> > > > > > 
> > > > > > impl ArcIntrusiveTimer {
> > > > > >        fn new() -> impl PinInit<Self, kernel::error::Error> {
> > > > > >            try_pin_init!(Self {
> > > > > >                timer <- Timer::new(),
> > > > > >                flag <- new_spinlock_irq!(0),
> > > > > >                cond <- new_condvar!(),
> > > > > >            })
> > > > > >        }
> > > > > > }
> > > > > > 
> > > > > > impl TimerCallback for ArcIntrusiveTimer {
> > > > > >        type CallbackTarget<'a> = Arc<Self>;
> > > > > >        type CallbackTargetParameter<'a> = ArcBorrow<'a, Self>;
> > > > > > 
> > > > > >        fn run(this: Self::CallbackTargetParameter<'_>, irq: IrqDisabled<'_>) -> TimerRestart {
> > > > > >            pr_info!("Timer called\n");
> > > > > >            let mut guard = this.flag.lock_with(irq);
> > > > > >            *guard += 1;
> > > > > >            this.cond.notify_all();
> > > > > >            if *guard == 5 {
> > > > > >                TimerRestart::NoRestart
> > > > > >            }
> > > > > >            else {
> > > > > >                TimerRestart::Restart
> > > > > > 
> > > > > >            }
> > > > > >        }
> > > > > > }
> > > > > > 
> > > > > > impl_has_timer! {
> > > > > >        impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
> > > > > > }
> > > > > > 
> > > > > > 
> > > > > > let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
> > > > > > let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
> > > > > > 
> > > > > > kernel::irq::with_irqs_disabled(|irq| {
> > > > > >      let mut guard = has_timer.flag.lock_with(irq);
> > > > > > 
> > > > > >      while *guard != 5 {
> > > > > >          pr_info!("Not 5 yet, waiting\n");
> > > > > >          has_timer.cond.wait(&mut guard); // <-- we arrive back here with interrupts enabled!
> > > > > >      }
> > > > > > });
> > > > > > ```
> > > > > > 
> > > > > > I think an update of `CondVar::wait` should be part of the patch set [1].
> > > > > > 
> > > > > > 
> > > > > > Best regards,
> > > > > > Andreas
> > > > > > 
> > > > > > 
> > > > > > [1] https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/
> > > > > > 
> > > > > > 
> > > > > 
> > > 
> 
> 

