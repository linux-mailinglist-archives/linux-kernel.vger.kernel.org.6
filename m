Return-Path: <linux-kernel+bounces-361951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA6399AF4B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0D52847A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FF61E0B76;
	Fri, 11 Oct 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAsh+QD/"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F8B1D12F0;
	Fri, 11 Oct 2024 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688905; cv=none; b=VMpMQKD1msX60/GAZy8s5Yvxq65OXIs8kUD7uPr86Dnc/ZP4JQ6sjpDXiR0KTxOSKCiu/IZiympbz00NRxOFmD7+Fks8FWcQ3ClcIr/1wdSn6Okx0JQvHStptNtLz+v5I26/D6L20zDxMnpTGnq+07rFIvS4QodQ9YoAxYnGa8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688905; c=relaxed/simple;
	bh=C2AlNqnSBUVSOqLqeF0NP7mqJIjEeaeU+F+j/KS6Xro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPd0qmlH2xAZSgN7yMZ2YgOZbWyLxD1jK/L7Xv4LIieQXnri7gtq9drdYZRP947XOrlnS+Ov+JHNQPXM8JWj9VKpDZsHYbsVIF07+9LB2nHoOHdDomQVg4a55eF5SStg25YMnTsnyFsO0URVpvNtr/gWVkmpT+CJoQuRYcMt+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAsh+QD/; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4603ee602a0so19178681cf.2;
        Fri, 11 Oct 2024 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728688902; x=1729293702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh1JVWfYHU1MRqZ8OPdmnVMTIa6p8cHwgjzEzl4fHpw=;
        b=eAsh+QD/bw85OnOUy/lhJdE1XfUjxxvsmMzvJEDg31H0QDFVVQ1KA46A5C7CFed18K
         7MNa1hElNR7MmHbnTNGqusdILxTZVlhCZJe+saN7HyEg8QYhZ4OR/RJCoxVqB3waqU6E
         UKtNTYBUeomX8GQ1ifOdtRu0JkfHzvAPyy8hUE+hGp5BmCYOVj7i5Iq8MimSBOBds0fT
         NfFuutZLDsInTuvhlnBnY5syzwiwU+i5DOlj9/M37b708RPDDn19TqB/+UnV5NVm/TyL
         +2al2wkIyh/Y9uRn0u2WnhnG/+ExAvEONvylF830Z8nOfhXquNLiA6UGUSzh+9jD1sMp
         v0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728688902; x=1729293702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh1JVWfYHU1MRqZ8OPdmnVMTIa6p8cHwgjzEzl4fHpw=;
        b=XP2WQLL1MbUFmmCEllmLXKJmf/MHJMmMQPOUEzG2UlF7DXzY9PrOscNZ1qv2IW3qvu
         asx///E/0j3WSIxek0ULCd1CaM2881NBVEj4v5QfH5yU63XE97CsHMGQtHRghS8/3WIO
         MmXRcIKCo23Tirpapgh6daL0nMXrVaNyIkPO2XoEcEZHn4VY0m0L2sU0Og+vSrr5M6JE
         CxYDwgB0vguCpm9LrD2nB4QbKYnOAmwC23x3f+gE5d65Kvkqasz/DnsHXeBzgZ8E39YN
         D12CdVGye+reyr2E97D3eJdfmFE6ox4mpHYHnlRwb3NQo1QJMwgAcm36hYSlDV3Ta16H
         kySw==
X-Forwarded-Encrypted: i=1; AJvYcCUfcq3M3k5d7PbEK6Hj0AcM5+SYGZKqcUZmK0p4+L9JJRPf/p+61Sx1Alxx0f376ce/0Mdni9cI7g/Qv9Q=@vger.kernel.org, AJvYcCXWn3BW01iSTQp6fmiacjcFMJIMOm3VETHF+ZBqQ/nIoj3tlyOfOIqlk8V+DnYvLYhKvP692UTV6Gwq1zj7B2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZOTS5XABEC/ka/y+JEQJaMJhho9bvrXL2XAQPuDIjHLR+ilM
	1saAJKsT6Xsg6XoYGKa3Xyv/CIw6VW0xVEXasZXIGGUxWnUHXsWw
X-Google-Smtp-Source: AGHT+IHG69WWoO6Ckqz9xb3uwl928GP1mezK4t2J1VmkQcDI7lcfGbSrWurhg28RoK9emwmhfu67gw==
X-Received: by 2002:a05:622a:4b07:b0:460:4e67:d67b with SMTP id d75a77b69052e-4604e67e375mr45776721cf.5.1728688902088;
        Fri, 11 Oct 2024 16:21:42 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460428995c3sm20082351cf.81.2024.10.11.16.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 16:21:41 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 283581200043;
	Fri, 11 Oct 2024 19:21:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 11 Oct 2024 19:21:41 -0400
X-ME-Sender: <xms:BbMJZ2cE7krxAficiopxTamR5BlzaKDw-x_6srlitWwg9KIl0ZsTug>
    <xme:BbMJZwOGNmhI-rTtYuIqEYRk-c29nLboC3mN4Se2Jzm6fnUsMV2psaz9G2yKJQIhx
    Oa_NOEt3lYP10SGcA>
X-ME-Received: <xmr:BbMJZ3gZwneqLRZ4_N0kIQ3wK49YZOA_BMCkQi9rClRu9LpVRC2Ej7ooFtU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefledgvddvucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:BbMJZz8UCjCcfzD4sKtANhuvjmXYm9zK_onke4RcUSPCanrCq1hRyg>
    <xmx:BbMJZyv90grnkgJUoLdRQudAbCTqpO_1c9edLlGYv_1OljwUamHp6w>
    <xmx:BbMJZ6EJ1VkUcACm3wB6V88nb4-QwWpiowOG2ACN4J1tV2r_bL-DYg>
    <xmx:BbMJZxNRZZdziaTuBoM4Q5uZ6VWjSyDlDagQiqKUipjd5Wdbqo_FpQ>
    <xmx:BbMJZ_NjL72WkJemuTmIDgUKvXtUV4tljRiY0CCV48d3vrNFklRmBBYc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 19:21:40 -0400 (EDT)
Date: Fri, 11 Oct 2024 16:21:31 -0700
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
Message-ID: <Zwmy-2Yc7vGboYvl@boqun-archlinux>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
 <ZvwKTinnLckZm8aQ@boqun-archlinux>
 <87a5falmjy.fsf@kernel.org>
 <dae08234-c9ba-472d-b769-1d07e579a8ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dae08234-c9ba-472d-b769-1d07e579a8ac@gmail.com>

On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
> Hi Andreas,
> 
> Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
> > 
> > Dirk, thanks for reporting!
> 
> :)
> 
> > Boqun Feng <boqun.feng@gmail.com> writes:
> > 
> > > On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
> > > > On 18.09.2024 00:27, Andreas Hindborg wrote:
> > > > > Hi!
> > > > > 
> > > > > This series adds support for using the `hrtimer` subsystem from Rust code.
> > > > > 
> > > > > I tried breaking up the code in some smaller patches, hopefully that will
> > > > > ease the review process a bit.
> > > > 
> > > > Just fyi, having all 14 patches applied I get [1] on the first (doctest)
> > > > Example from hrtimer.rs.
> > > > 
> > > > This is from lockdep:
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
> > > > 
> > > > Having just a quick look I'm not sure what the root cause is. Maybe mutex in
> > > > interrupt context? Or a more subtle one?
> > > 
> > > I think it's calling mutex inside an interrupt context as shown by the
> > > callstack:
> > > 
> > > ]  __mutex_lock+0xa0/0xa4
> > > ] ...
> > > ]  hrtimer_interrupt+0x1d4/0x2ac
> > > 
> > > , it is because:
> > > 
> > > +//! struct ArcIntrusiveTimer {
> > > +//!     #[pin]
> > > +//!     timer: Timer<Self>,
> > > +//!     #[pin]
> > > +//!     flag: Mutex<bool>,
> > > +//!     #[pin]
> > > +//!     cond: CondVar,
> > > +//! }
> > > 
> > > has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
> > > irq-off is needed for the lock, because otherwise we will hit a self
> > > deadlock due to interrupts:
> > > 
> > > 	spin_lock(&a);
> > > 	> timer interrupt
> > > 	  spin_lock(&a);
> > > 
> > > Also notice that the IrqDisabled<'_> token can be simply created by
> > > ::new(), because irq contexts should guarantee interrupt disabled (i.e.
> > > we don't support nested interrupts*).
> > 
> > I updated the example based on the work in [1]. I think we need to
> > update `CondVar::wait` to support waiting with irq disabled.
> 
> Yes, I agree. This answers one of the open questions I had in the discussion
> with Boqun :)
> 
> What do you think regarding the other open question: In this *special* case
> here, what do you think to go *without* any lock? I mean the 'while *guard
> != 5' loop in the main thread is read only regarding guard. So it doesn't
> matter if it *reads* the old or the new value. And the read/modify/write of
> guard in the callback is done with interrupts disabled anyhow as it runs in
> interrupt context. And with this can't be interrupted (excluding nested
> interrupts). So this modification of guard doesn't need to be protected from
> being interrupted by a lock if there is no modifcation of guard "outside"
> the interupt locked context.
> 
> What do you think?
> 

Reading while there is another CPU is writing is data-race, which is UB.

Regards,
Boqun

> Thanks
> 
> Dirk
> 
> 
> > Without
> > this, when we get back from `bindings::schedule_timeout` in
> > `CondVar::wait_internal`, interrupts are enabled:
> > 
> > ```rust
> > use kernel::{
> >      hrtimer::{Timer, TimerCallback, TimerPointer, TimerRestart},
> >      impl_has_timer, new_condvar, new_spinlock, new_spinlock_irq,
> >      irq::IrqDisabled,
> >      prelude::*,
> >      sync::{Arc, ArcBorrow, CondVar, SpinLock, SpinLockIrq},
> >      time::Ktime,
> > };
> > 
> > #[pin_data]
> > struct ArcIntrusiveTimer {
> >      #[pin]
> >      timer: Timer<Self>,
> >      #[pin]
> >      flag: SpinLockIrq<u64>,
> >      #[pin]
> >      cond: CondVar,
> > }
> > 
> > impl ArcIntrusiveTimer {
> >      fn new() -> impl PinInit<Self, kernel::error::Error> {
> >          try_pin_init!(Self {
> >              timer <- Timer::new(),
> >              flag <- new_spinlock_irq!(0),
> >              cond <- new_condvar!(),
> >          })
> >      }
> > }
> > 
> > impl TimerCallback for ArcIntrusiveTimer {
> >      type CallbackTarget<'a> = Arc<Self>;
> >      type CallbackTargetParameter<'a> = ArcBorrow<'a, Self>;
> > 
> >      fn run(this: Self::CallbackTargetParameter<'_>, irq: IrqDisabled<'_>) -> TimerRestart {
> >          pr_info!("Timer called\n");
> >          let mut guard = this.flag.lock_with(irq);
> >          *guard += 1;
> >          this.cond.notify_all();
> >          if *guard == 5 {
> >              TimerRestart::NoRestart
> >          }
> >          else {
> >              TimerRestart::Restart
> > 
> >          }
> >      }
> > }
> > 
> > impl_has_timer! {
> >      impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
> > }
> > 
> > 
> > let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
> > let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
> > 
> > kernel::irq::with_irqs_disabled(|irq| {
> >    let mut guard = has_timer.flag.lock_with(irq);
> > 
> >    while *guard != 5 {
> >        pr_info!("Not 5 yet, waiting\n");
> >        has_timer.cond.wait(&mut guard); // <-- we arrive back here with interrupts enabled!
> >    }
> > });
> > ```
> > 
> > I think an update of `CondVar::wait` should be part of the patch set [1].
> > 
> > 
> > Best regards,
> > Andreas
> > 
> > 
> > [1] https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/
> > 
> > 
> 

