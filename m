Return-Path: <linux-kernel+bounces-362973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1990E99BBEE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 23:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DCA1C20E95
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F6214F9E2;
	Sun, 13 Oct 2024 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyIr9xwX"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A8136345;
	Sun, 13 Oct 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728853596; cv=none; b=UJJ/sug/9P/a6om7wTy/M3uoYCcT+hZMjrAMYNjJOCSoKUJ0Bp5VaYPwQCLYPnUyp4F/WWwb4oVRHW8qgd8d/eWj4H3S+VxNdiUTa9AmMUOHZTFIN9kaM/bW+7n6f3aH/JfPSZxR2o1GgajHbgnYY656qpzsB9vf0QVWsjk5u00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728853596; c=relaxed/simple;
	bh=4enJs+9RxNE+8mra+dRMKLHtA4hTVRm1HaNbX6EyVok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWxexyodMV00QsPdlux2oH8IjkDvf2Kelbb+9MLxPvGIKoxlZiddIc3xBbUg1R5hajK+jn95ZzlBpfgR5I8Drn6mmwdZU1zaU75oOs6NfmFqflgJ2jp5pJcP8WzxUuBofeFQbnG1yXeHwcdfr+tJO9mxZjbRuK9wOXKbhx+CA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyIr9xwX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7afcf50e2d0so172629885a.3;
        Sun, 13 Oct 2024 14:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728853593; x=1729458393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsunMYkfbJcInqW9YDQzMawO9br1XEya0LYUq1wZSso=;
        b=IyIr9xwXfwWSW9mPNvgPLqEuw6OEjHe6vZMM4rDImMGK/s0cgioREaPSGzh7/bRXz2
         PrNlPQI7MJeG+GWl9LZ6P9az65X+OvAQelvSJSx4tlU79lcvv3/m2ZmmRVxGyw+uU/Hs
         FiAAE7gtaI2lHGGkjovsKQqAeeklqJFTdNVGtWfQWGEvzExaPqLBx3ONsmPHCm9lGfe+
         tAjwcZ0RIhzGh3QikxjDkGZYQz2Pl/bJH0e7kSgoAHZG5Bj3fPpGVXf8DTzi5paXo5En
         dx7qphf5LLBYUXn7QdQWQLccc0fSymEubQxNjQuMZePzzO/NbLUwQve3vHkoZVJon6UP
         82cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728853593; x=1729458393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsunMYkfbJcInqW9YDQzMawO9br1XEya0LYUq1wZSso=;
        b=kZjOzjsDdeHud3MxqY1IaMyeYGoYeCR2gIuBjusrLAKnbOg2EBVUm/1udRayLl9orm
         8WviNp3CQDEokpn/vvRW+25QHLYC59s9VbFV8WEO/oaqg77yIPAzufVluAes1oeidfAw
         zSXSoZnBP8OYkwZNtErU0P1XRhucn2io9enejv0yt2pMVtdLrisJ4BLhBeLN9AjQhiCU
         it9wlXcpxqUrKqNCTcn6HVEiqx3op643i2LiT4IPXaVJ4MQkcQCvc+5H4MaZEstx472Q
         FkrqdcSluCX8SNvAhiGut+hOrhMjjmU+QXmnh4jLxtBjnHwnMKJid3LqMdBz2vInkv8k
         NL6g==
X-Forwarded-Encrypted: i=1; AJvYcCU7DdpmS3QZAlCjYszCcpAH1n7ZWteDUh8x5oHdLVij79Czw0JVI3PCgIq3bKtdw23trKOraQXB4nrLArg+9TE=@vger.kernel.org, AJvYcCXld9E0M/WkBJDydEr/826Zp6UAT9S86dtnoffte6pwphuMIFdhXJu96ZYZa2as1n/v6vjRrcRwE0Q3Vsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQey5dYU7jLY1+vcY6u/bLsEFeb5l35e+tbbW+g8xD3OzMaDU
	QeZmiYYYGwv2TeYw7DGVicz4dv3Ja9WqBoa8vbCxVZ3sJlVPaio+
X-Google-Smtp-Source: AGHT+IH3wyivp7AnI21rgqNvRf9ks6SjPA2swaVQ8uj8VmLPqX6iWNH9xNYxGXNGE0uebX1Ob648SA==
X-Received: by 2002:a05:620a:8006:b0:7b1:1cc2:8238 with SMTP id af79cd13be357-7b11cc28247mr1540714685a.39.1728853593059;
        Sun, 13 Oct 2024 14:06:33 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1149894efsm344451685a.131.2024.10.13.14.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 14:06:32 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id D7B861200076;
	Sun, 13 Oct 2024 17:06:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 13 Oct 2024 17:06:31 -0400
X-ME-Sender: <xms:VzYMZ0r4O1jLCuv096rwTyGtVFe54Bih4I9D-Fo-yD_PnnqLpzR88g>
    <xme:VzYMZ6pPycpeLnxWUVqyHCG4EOfq_WQhOjTGOfwQHwhS8zxz3wsZsElkK5kIQ467q
    _a9D9bMxsWajzYDEA>
X-ME-Received: <xmr:VzYMZ5P_YQlAn3cDp93JHN0yGigS9AQ4j1qTFUT4oSGHIH7rza8-75Gpuwc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegfedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopeguihhrkhdrsggvhhhmvgesghhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhn
    uggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhihuhguvgesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepughirhhkrdgsvghhmhgvseguvgdrsghoshgthhdrtgho
    mhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlh
    gvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnnhgrqdhmrghr
    ihgrsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:VzYMZ75Pv2QIOxdHzX9r0FxV-pPpfNbKF_qk87AGE6WIchA0wwi9_Q>
    <xmx:VzYMZz5shUr5jAVaiZBz54mDad9BMVADq1pUMdnAvwIHC-hLD8V3jw>
    <xmx:VzYMZ7hmHagvKB0YJQzn4g5y80zFFu8zwbzSDlEwZTBtDXE8z5Cziw>
    <xmx:VzYMZ96dC7Ntiwvs-XW0RVsKLKT2ujbuDn7BAw3LqtFrKarRUhObaw>
    <xmx:VzYMZ2J4IMGTXA73fiiUvulPQn2_vsF5w8f3Iuu_f7iheL8qBySRwwN6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Oct 2024 17:06:31 -0400 (EDT)
Date: Sun, 13 Oct 2024 14:06:30 -0700
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
Message-ID: <Zww2Vhsl9sutNm0s@Boquns-Mac-mini.local>
References: <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
 <ZvwKTinnLckZm8aQ@boqun-archlinux>
 <87a5falmjy.fsf@kernel.org>
 <dae08234-c9ba-472d-b769-1d07e579a8ac@gmail.com>
 <Zwmy-2Yc7vGboYvl@boqun-archlinux>
 <d2ce38a3-9a32-4f4c-88f2-22864b66afe5@gmail.com>
 <ZwooHrqIiirl1so7@boqun-archlinux>
 <4dd93603-04fa-4da4-b867-bd12ece4b391@gmail.com>
 <Zwr3i4x7J5qyjFog@Boquns-Mac-mini.local>
 <c19edf2d-2b53-403f-abcc-a5e81e7613f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19edf2d-2b53-403f-abcc-a5e81e7613f8@gmail.com>

On Sun, Oct 13, 2024 at 07:39:29PM +0200, Dirk Behme wrote:
> On 13.10.24 00:26, Boqun Feng wrote:
> > On Sat, Oct 12, 2024 at 09:50:00AM +0200, Dirk Behme wrote:
> > > On 12.10.24 09:41, Boqun Feng wrote:
> > > > On Sat, Oct 12, 2024 at 07:19:41AM +0200, Dirk Behme wrote:
> > > > > On 12.10.24 01:21, Boqun Feng wrote:
> > > > > > On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
> > > > > > > Hi Andreas,
> > > > > > > 
> > > > > > > Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
> > > > > > > > 
> > > > > > > > Dirk, thanks for reporting!
> > > > > > > 
> > > > > > > :)
> > > > > > > 
> > > > > > > > Boqun Feng <boqun.feng@gmail.com> writes:
> > > > > > > > 
> > > > > > > > > On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
> > > > > > > > > > On 18.09.2024 00:27, Andreas Hindborg wrote:
> > > > > > > > > > > Hi!
> > > > > > > > > > > 
> > > > > > > > > > > This series adds support for using the `hrtimer` subsystem from Rust code.
> > > > > > > > > > > 
> > > > > > > > > > > I tried breaking up the code in some smaller patches, hopefully that will
> > > > > > > > > > > ease the review process a bit.
> > > > > > > > > > 
> > > > > > > > > > Just fyi, having all 14 patches applied I get [1] on the first (doctest)
> > > > > > > > > > Example from hrtimer.rs.
> > > > > > > > > > 
> > > > > > > > > > This is from lockdep:
> > > > > > > > > > 
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
> > > > > > > > > > 
> > > > > > > > > > Having just a quick look I'm not sure what the root cause is. Maybe mutex in
> > > > > > > > > > interrupt context? Or a more subtle one?
> > > > > > > > > 
> > > > > > > > > I think it's calling mutex inside an interrupt context as shown by the
> > > > > > > > > callstack:
> > > > > > > > > 
> > > > > > > > > ]  __mutex_lock+0xa0/0xa4
> > > > > > > > > ] ...
> > > > > > > > > ]  hrtimer_interrupt+0x1d4/0x2ac
> > > > > > > > > 
> > > > > > > > > , it is because:
> > > > > > > > > 
> > > > > > > > > +//! struct ArcIntrusiveTimer {
> > > > > > > > > +//!     #[pin]
> > > > > > > > > +//!     timer: Timer<Self>,
> > > > > > > > > +//!     #[pin]
> > > > > > > > > +//!     flag: Mutex<bool>,
> > > > > > > > > +//!     #[pin]
> > > > > > > > > +//!     cond: CondVar,
> > > > > > > > > +//! }
> > > > > > > > > 
> > > > > > > > > has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
> > > > > > > > > irq-off is needed for the lock, because otherwise we will hit a self
> > > > > > > > > deadlock due to interrupts:
> > > > > > > > > 
> > > > > > > > > 	spin_lock(&a);
> > > > > > > > > 	> timer interrupt
> > > > > > > > > 	  spin_lock(&a);
> > > > > > > > > 
> > > > > > > > > Also notice that the IrqDisabled<'_> token can be simply created by
> > > > > > > > > ::new(), because irq contexts should guarantee interrupt disabled (i.e.
> > > > > > > > > we don't support nested interrupts*).
> > > > > > > > 
> > > > > > > > I updated the example based on the work in [1]. I think we need to
> > > > > > > > update `CondVar::wait` to support waiting with irq disabled.
> > > > > > > 
> > > > > > > Yes, I agree. This answers one of the open questions I had in the discussion
> > > > > > > with Boqun :)
> > > > > > > 
> > > > > > > What do you think regarding the other open question: In this *special* case
> > > > > > > here, what do you think to go *without* any lock? I mean the 'while *guard
> > > > > > > != 5' loop in the main thread is read only regarding guard. So it doesn't
> > > > > > > matter if it *reads* the old or the new value. And the read/modify/write of
> > > > > > > guard in the callback is done with interrupts disabled anyhow as it runs in
> > > > > > > interrupt context. And with this can't be interrupted (excluding nested
> > > > > > > interrupts). So this modification of guard doesn't need to be protected from
> > > > > > > being interrupted by a lock if there is no modifcation of guard "outside"
> > > > > > > the interupt locked context.
> > > > > > > 
> > > > > > > What do you think?
> > > > > > > 
> > > > > > 
> > > > > > Reading while there is another CPU is writing is data-race, which is UB.
> > > > > 
> > > > > Could you help to understand where exactly you see UB in Andreas' 'while
> > > > > *guard != 5' loop in case no locking is used? As mentioned I'm under the
> > > > 
> > > > Sure, but could you provide the code of what you mean exactly, if you
> > > > don't use a lock here, you cannot have a guard. I need to the exact code
> > > > to point out where the compiler may "mis-compile" (a result of being
[...]
> > > I thought we are talking about anything like
> > > 
> > > #[pin_data]
> > > struct ArcIntrusiveTimer {
> > >        #[pin]
> > >        timer: Timer<Self>,
> > >        #[pin]
> > > -      flag: SpinLockIrq<u64>,
> > > +      flag: u64,
> > >        #[pin]
> > >        cond: CondVar,
> > > }
> > > 
> > > ?
> > > 
> > 
> > Yes, but have you tried to actually use that for the example from
> > Andreas? I think you will find that you cannot write to `flag` inside
> > the timer callback, because you only has a `Arc<ArcIntrusiveTimer>`, so
> > not mutable reference for `ArcIntrusiveTimer`. You can of course use
> > unsafe to create a mutable reference to `flag`, but it won't be sound,
> > since you are getting a mutable reference from an immutable reference.
> 
> Yes, of course. But, hmm, wouldn't that unsoundness be independent on the
> topic we discuss here? I mean we are talking about getting the compiler to

What do you mean? If the code is unsound, you won't want to use it in an
example, right?

> read/modify/write 'flag' in the TimerCallback. *How* we tell him to do so
> should be independent on the result what we want to look at regarding the
> locking requirements of 'flag'?
> 
> Anyhow, my root motivation was to simplify Andreas example to not use a lock
> where not strictly required. And with this make Andreas example independent

Well, if you don't want to use a lock then you need to use atomics,
otherwise it's likely a UB, but atomics are still WIP, so that why I
suggested Andreas to use a lock first. But I guess I didn't realise the
lock needs to be irq-safe when I suggested that.

Regards,
Boqun

> on mutex lockdep issues, SpinLockIrq changes and possible required CondVar
> updates. But maybe we find an other way to simplify it and decrease the
> dependencies. In the end its just example code ;)
> 
> Best regards
> 
> Dirk
> 
> 
> > Regards,
> > Boqun
> > 
[...]

