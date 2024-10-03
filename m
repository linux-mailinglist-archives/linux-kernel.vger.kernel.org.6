Return-Path: <linux-kernel+bounces-349042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B67C98EFF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2FC2813A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D012199240;
	Thu,  3 Oct 2024 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcpEdCy4"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017110A1E;
	Thu,  3 Oct 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960659; cv=none; b=t831m9sqtHDb5GaOSdKDPdxztBZJYWQ7c+NCpA6P1HSyUjA1ANhHJMmSfXxhEiEo5cYuX0dGz+s2nTfAj3NEU5sxJaA8kc1fao6o9xj6q+prsTvGCTAgXsAZz9mXLyJHzd3S7eZvIWb2fw/eBc9zF0j6qOWtpNhZd1njrBcmfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960659; c=relaxed/simple;
	bh=fZ54/S+UshxewJJoGY6wjTgHN29+bc9ZdPvkT5pDaOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMUIHhBEy0tadVZYODZ7piuquWxdCsiGMiHBfc/KCRKSw0qidfT8vBVLaio0+hbFmcJS3UkY4ea5NAtEvvoYm7YLhntLhQFTqo/D+I5X3Kkz79Kah/xwss0XH4FnSFSC/b0YovVjCXWI3oczxIo22Vffb3j/hoY0a3In1pm/2hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcpEdCy4; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a9a30a0490so104030885a.3;
        Thu, 03 Oct 2024 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727960657; x=1728565457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/TEUUR0VXa/5AWqmPzfnGav/43FzaJvYoTaL3iblM4=;
        b=UcpEdCy4qBMtr0VlLuAozz06k0xlCj1rAsp8R+cj3oMYE+DTaaADpULgyuur4LEtm5
         5mn/9s1/rDv6Xon8rjUNlx/1Aai6pQbM12AS34DdA6xv5oGUkwYtCntobIeSht//I/1w
         /T5irUi+CTpPKoxGfPlMFVgshbDvUMuHHfBqvmz7z04VJTY/YyRqrHcpNn5TampDJaLH
         dO3vHe3HSAJ5C1Z+4FsrAcZyNnE13k8xgM48Gls3s7ZYERqe8Cx5+DLaeidWu5ZMi9u/
         /ADPvKpTPDZyjPuTbRI2hmH0uOOZCPagIXe7jUfHQ5D0ZbjEIj8HE8LiUf/LHDhq+Jer
         +YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960657; x=1728565457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/TEUUR0VXa/5AWqmPzfnGav/43FzaJvYoTaL3iblM4=;
        b=S6XB/UOcHVURrKe1bJuIAJHh/WZiUdCiscB3ipFSVvsx2pX28zGCjIt4mIon3LPTkr
         jwCPw6DNoWLEMUklLnxyXjQIHagjvt0eBo2HFQDICtWz9F2L46soyEWybyNpzi/5CVze
         y7ah4e/XktRa0Ag1u41tgWmF6mXpCq8ZnGEakjpCw6+zNb7Ddi1BXcPz4uscKScIkrnM
         v/h/EXx6h9usfoId7SfsR2SbGNREcDnenx4K+Nkfqwjd+UrUM2qDZ+PZGDqAYluHFwMI
         yFhPdrmcnEORUkWILvW4ZfaV2eqF19+RtYDaQXaSa/nZnMI5m5tHpX6vvb9MVdkiA1s3
         vRRg==
X-Forwarded-Encrypted: i=1; AJvYcCVytizj0S3QjnV33Bu2MKgBszEeKeXcQoURtW+5QPIatr9vcC4z5hBtIeMP8pN7+i6OW4uxuFf1T4xJPTE=@vger.kernel.org, AJvYcCWBdtn2AWiCrVv3wIUFea5B6Hq4Utr1mRTkaCUaB7qy/DEww18uqzNKXk1g7fpMbwry3DE++GrZum/KIYruWvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp9+S8qU3xz3PVgOjcvFA+YnAAY1iTkBbqA4eac9sGRfaYUfU+
	xSAVSp1XNztKf1pGNIvgeGXFhnc3xjHt+fZoy11k+ZeT1cQMr5tLFqrEIQ==
X-Google-Smtp-Source: AGHT+IGfVIGtzWxL3STNDYCHXBKRV6B6Ld/464X1y0AMp4N8EH1k/P8JiKJw/xanFDwWVwp3F5hGlQ==
X-Received: by 2002:a05:620a:4609:b0:7a9:dd6b:9c71 with SMTP id af79cd13be357-7ae626c849amr1139397285a.22.1727960656726;
        Thu, 03 Oct 2024 06:04:16 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b29e2b6sm49433485a.18.2024.10.03.06.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:04:16 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id DA3D11200068;
	Thu,  3 Oct 2024 09:04:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 03 Oct 2024 09:04:15 -0400
X-ME-Sender: <xms:T5b-ZgYTPmnkK6EjsBlb561LzxHDPMkY8_AmLiIAoDvb87vW0IVOyw>
    <xme:T5b-ZraZA5r7lC3PXbhBdD0Mr4FvokCOmB6F_CGoaS4pDnR6_OMwDfX7ZHKd7P7AV
    B4zATjgXIM8d9cXEQ>
X-ME-Received: <xmr:T5b-Zq9Oyk7tfH7jBxFbziL65ZwRJyErwAnnXkKkHUBFs8HyfKoRKTpkD4IMxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epughirhhkrdgsvghhmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepughirhhkrdgs
    vghhmhgvseguvgdrsghoshgthhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtth
    hopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehf
    rhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuh
    htrhhonhhigidruggvpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvght
X-ME-Proxy: <xmx:T5b-ZqomDN_3bXQA0cbqVliz_UuHya25LbKhNGWYaVqDCmSaq1q8Uw>
    <xmx:T5b-Zrr25C-WfrUoRL8AMgtOg1U2y25KzQLlC5v783kOnrk120mlqw>
    <xmx:T5b-ZoTFhlon_Gp00GhrT6U93WQki9ityWJlyRkZ6qPAoetXeXHe2Q>
    <xmx:T5b-ZrpCJKEEKO6w0zGI8hxvZHONj7dD_7tBwV3HoAXtxy8xeWvkFg>
    <xmx:T5b-Zg5SjAgePOk5eK37DMf5AVp4tmXWrWZtV6j9mFMZrFT1RZm9qoxr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 09:04:15 -0400 (EDT)
Date: Thu, 3 Oct 2024 06:03:09 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
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
Message-ID: <Zv6WDYZHikCCpUlB@boqun-archlinux>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
 <ZvwKTinnLckZm8aQ@boqun-archlinux>
 <b129cddc-862a-472b-b52a-2457b1a02d45@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b129cddc-862a-472b-b52a-2457b1a02d45@gmail.com>

On Thu, Oct 03, 2024 at 10:14:17AM +0200, Dirk Behme wrote:
> Am 01.10.24 um 16:42 schrieb Boqun Feng:
> > On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
> > > On 18.09.2024 00:27, Andreas Hindborg wrote:
> > > > Hi!
> > > > 
> > > > This series adds support for using the `hrtimer` subsystem from Rust code.
> > > > 
> > > > I tried breaking up the code in some smaller patches, hopefully that will
> > > > ease the review process a bit.
> > > 
> > > Just fyi, having all 14 patches applied I get [1] on the first (doctest)
> > > Example from hrtimer.rs.
> > > 
> > > This is from lockdep:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
> > > 
> > > Having just a quick look I'm not sure what the root cause is. Maybe mutex in
> > > interrupt context? Or a more subtle one?
> > 
> > I think it's calling mutex inside an interrupt context as shown by the
> > callstack:
> > 
> > ]  __mutex_lock+0xa0/0xa4
> > ] ...
> > ]  hrtimer_interrupt+0x1d4/0x2ac
> > 
> > , it is because:
> > 
> > +//! struct ArcIntrusiveTimer {
> > +//!     #[pin]
> > +//!     timer: Timer<Self>,
> > +//!     #[pin]
> > +//!     flag: Mutex<bool>,
> > +//!     #[pin]
> > +//!     cond: CondVar,
> > +//! }
> > 
> > has a Mutex<bool>, which actually should be a SpinLockIrq [1].
> 
> 
> Two understanding questions:
> 

Good questions. ;-)

> 1. In the main thread (full example for reference below [2]) where is the
> lock released? After the while loop? I.e. is the lock held until guard

With the current implementation, there are two places the lock will be
released: 1) inside CondVar::wait() and 2) after `guard` is eventually
drop after the loop.

> reaches 5?
> 
> let mut guard = has_timer.flag.lock();   // <= lock taken here?
> 
> while *guard != 5 {
>      has_timer.cond.wait(&mut guard);
> }                                                           // <= lock
> released here?
> 
> I wonder what this would mean for the interrupt TimerCallback in case we
> would use an irq-off SpinLock instead here?
> 
> Or maybe:
> 
> 2. The only place where the guard is modified (*guard += 1;) is in the
> TimerCallback which runs in interrupt context as we learned. With that
> writing the guard value can't be interrupted. Couldn't we drop the whole
> lock, then?
> 

No, because the main thread can run on another CPU, so disabling
interrupts (because of the interrupt handlers) doesn't mean exclusive
access to value.

Regards,
Boqun

> Best regards
> 
> Dirk
> 
> 
> [2]
> 
> //! #[pin_data]
> //! struct ArcIntrusiveTimer {
> //!     #[pin]
> //!     timer: Timer<Self>,
> //!     #[pin]
> //!     flag: Mutex<u64>,
> //!     #[pin]
> //!     cond: CondVar,
> //! }
> //!
> //! impl ArcIntrusiveTimer {
> //!     fn new() -> impl PinInit<Self, kernel::error::Error> {
> //!         try_pin_init!(Self {
> //!             timer <- Timer::new(),
> //!             flag <- new_mutex!(0),
> //!             cond <- new_condvar!(),
> //!         })
> //!     }
> //! }
> //!
> //! impl TimerCallback for ArcIntrusiveTimer {
> //!     type CallbackTarget<'a> = Arc<Self>;
> //!     type CallbackPointer<'a> = Arc<Self>;
> //!
> //!     fn run(this: Self::CallbackTarget<'_>) -> TimerRestart {
> //!         pr_info!("Timer called\n");
> //!         let mut guard = this.flag.lock();
> //!         *guard += 1;
> //!         this.cond.notify_all();
> //!         if *guard == 5 {
> //!             TimerRestart::NoRestart
> //!         }
> //!         else {
> //!             TimerRestart::Restart
> //!
> //!         }
> //!     }
> //! }
> //!
> //! impl_has_timer! {
> //!     impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
> //! }
> //!
> //!
> //! let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
> //! let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
> //! let mut guard = has_timer.flag.lock();
> //!
> //! while *guard != 5 {
> //!     has_timer.cond.wait(&mut guard);
> //! }
> //!
> //! pr_info!("Counted to 5\n");
> //! # Ok::<(), kernel::error::Error>(())
> 
> 
> 
[...]

