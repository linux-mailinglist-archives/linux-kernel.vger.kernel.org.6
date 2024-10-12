Return-Path: <linux-kernel+bounces-362190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796099B1E8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53B01F26153
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64671428E3;
	Sat, 12 Oct 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM1IZ2qH"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7F9610D;
	Sat, 12 Oct 2024 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720082; cv=none; b=mrWzRKyPifiTmZlq0ZgQsk7HZqnx2vL5hbnpYd0/KPGBZ86+QLItnJF4Bo6ixJVAuqo0UAOyAW6JFHUg99lppt3P5zcwShaZfRurTP87i9e+KPc0hteZI5CkfahIyNg32nhbwQzYd2aMvqHYjDHaox1BlzfIEbHxDqT5exsahXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720082; c=relaxed/simple;
	bh=IJDHBz9gxk1+BvgPU+3ijYx3A0hJNPaOeK4omwunldI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGqVTQsY/OkY1MfQQ32QqafD590c9o/fcwIATCMIZV6VVJRj98TH+EQXaS2D0nxLXRnz1arC6y1dgZYVf4qRmoCPWOQzmDA1qdP3ww7aA75dOfRsK60feIbvurFaTqxQfgnXSzhvl9IXRVwPHGxxJ6gm7jmAPXDZQWiYKf1mWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aM1IZ2qH; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46040dadedfso27513601cf.1;
        Sat, 12 Oct 2024 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728720076; x=1729324876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4PpuJmq7wfeY6rEphTstUgxGG4tlgwzBu7GnWyXh0M=;
        b=aM1IZ2qHoBfegAW8wrmr5wiD5UGgolbglBzwoCRCnLnGKZLGxmKcpnDfEwlSliTL3e
         1WiARetRNoWdVvkAY1I3e/t8+zLu5j396My17u2urjMXqorCxsolhZZACzGKJbodNXpx
         MfcVNIloKOX0qnx6keAUcUeVtyj6ESrCQQs8gJNFSUTzrVgTAEbPFJIlB+QD3zTqEapH
         FC1JRpMCuKTPNbRgtIgJjZDAm4VskN9SpnDw5cyhATl/q/xZDNLgZ/7cTmBdbg9W3CsQ
         ZROaQ+GH6t1hIqkOpGs3+ssJ+8D57+vWBfwC6V7MxHoO26HgldgQ88SjvGTPfNsNkiNK
         XiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728720076; x=1729324876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4PpuJmq7wfeY6rEphTstUgxGG4tlgwzBu7GnWyXh0M=;
        b=hDWFNfHY6jOl7L1evsGvoXeQFPFCtERnGRcgHPK6NPLCZ1ui7RMlx6F2886J+tnGXQ
         sPMsid3gEnkx+z28GGZ0TNBYX+XT1rl91c8hOOWHlwcgTOgTbhUoZ+nejIAyFTQEwXQJ
         dHiGebwa7AGVCbAAQb2LZDvb1TesdNPjNQE8BQj2tYBMiiA9QS+WAEQV1/WhPMGeeTfI
         DVFD5ACiO0O1PG/cURM573pyaXNZ2XDrWRRTeJbYKLPfo9q4kDzTynwiZFQJLHM4bLBI
         YC6ccTeE23yoQgcYFBDyTRRRpShV5rvu9e4dH+sfSTlXDHKiIr0xfg+BprXjRGe4EyU1
         QcTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEZSStZ4mhaNIw4KhRkHiOTIWZG5zHdW6XxDxqn+Azlavec/Vf6oxh9iLCoKlqo2lc64HRjH0bz7t9DKw=@vger.kernel.org, AJvYcCUVZESCQWTwTkZ6DZ30DsK7JcrZYdf9HS/TPfTg+Q0hNxqeCxP1YlonCQadnjpYsVsfXCvCwiJGjNZBDF9akwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2HGzcX/Rbc2Hq6K47x9DjVGLd2/U02YRYQyKFRfhEgr0cm4g
	ZAVIsxPMi/O4vtKKMVnLuZqphFDh5Upai6tx80r0YsSibCNU1Zln
X-Google-Smtp-Source: AGHT+IE4c+uySQQIJ+Y1jPXa7SmgYRE8fWGq8NNgGsW2a+M1syKMsqrPTvLXZJSt+UgTLAgyDBkzrw==
X-Received: by 2002:a05:6214:5684:b0:6cb:600f:568b with SMTP id 6a1803df08f44-6cbeff384d1mr88302926d6.8.1728720076326;
        Sat, 12 Oct 2024 01:01:16 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85b7874sm23418856d6.35.2024.10.12.01.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 01:01:15 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5042F1200043;
	Sat, 12 Oct 2024 04:01:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sat, 12 Oct 2024 04:01:15 -0400
X-ME-Sender: <xms:yywKZ9ZPvJw-mWMtVgMF2jE1xjbmV7FPlzftrN68-xiNDdQTxrLlDQ>
    <xme:yywKZ0ZeJmF2G8I7_A94hlFmmwvFP5pPsvtZoGy6Cld7aLkqkkA7wwvWuxdiw7FWZ
    wZbMhOFdwJMAtHRAg>
X-ME-Received: <xmr:yywKZ_9f8WnoRJ6DNc67hH7OpqU-PX98onPOrP3K_cVrIsS_LHhe_7VMTYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegtddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehruhhs
    thdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gurghkrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrgh
X-ME-Proxy: <xmx:yywKZ7pl_N0dX4GYHpxJpCpBoZjri8kR2JzkSlodiXEbnACwa7SLtQ>
    <xmx:yywKZ4owmJeyP08ooG2VLLeBRpm0bf7ehnsPxFEZspqn_9yUv5c4HA>
    <xmx:yywKZxRDhzN-cgEJ8LnFNb2oHPlS9X8N9gUXlfNhnkjW2xFQeHWSVA>
    <xmx:yywKZwoZ6RcsozXjrAqc8zZa1F_x7DcrUi5QFvmlXwp7FHDSUNP3Zg>
    <xmx:yywKZx5yp2Qi5QnltgWX3SpP7OUSwfJV8ULbPQfnelHxDSNqdmscOht0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Oct 2024 04:01:14 -0400 (EDT)
Date: Sat, 12 Oct 2024 01:01:04 -0700
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
Message-ID: <ZwoswDGED0fWMd61@boqun-archlinux>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-4-lyude@redhat.com>
 <8734lew7jn.ffs@tglx>
 <0a802e5fc0623ac8ae4653a398d0dfd73c479b96.camel@redhat.com>
 <87a5fgunoc.ffs@tglx>
 <9f580260866a202d7608f902464b7fae087dd6c6.camel@redhat.com>
 <878quytyc0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878quytyc0.ffs@tglx>

On Tue, Oct 08, 2024 at 05:21:19PM +0200, Thomas Gleixner wrote:
> On Mon, Oct 07 2024 at 14:30, Lyude Paul wrote:
> > On Mon, 2024-10-07 at 14:01 +0200, Thomas Gleixner wrote:
> > So actually the new solution I suggested a little after that original email
> > wouldn't need to call local_irq_save() directly - sorry, I just explained it
> > kind of poorly and it hadn't been in my head for very long. I think you'll
> > like this solution a lot more though, lemme explain:
> >
> > Basically instead of having functions like with_interrupts_disabled, we would
> > instead introduce a new trait that can be implemented by locks with context
> > tokens: BackendWithContext:
> >
> > pub trait BackendWithContext: Backend {
> > type ContextState;
> >
> > unsafe fn lock_first(ptr: *Self::State)
> > -> (Self::Context, Self::ContextState, Self::GuardState);
> >
> > unsafe fn unlock_last(
> > ptr: *Self::State,
> > context_state: Self::ContextState,
> > guard_state: &Self::GuardState
> > );
> > }
> >
> > Where the idea is that a type like SpinlockIrq would define ContextState to be
> > a u64 (holding the flags argument from spin_lock_irqsave). lock_first() would

I would suggest we use a usize for the ContextState. And the name of
these two functions can be lock_with_context_saved()
unlock_with_context_restored(), _first() and _last() may be misleading,
because technically, you can have a nested lock_first(), e.g.

	let (c1, c1state, g) = unsafe { lock_first(...); }
	let (c2, c2state, g) = unsafe { lock_first(...); }

we will just need to make sure `unlock_last()` called in the reverse
ordering as a safety requirement. Then _first() and _last() doesn't make
sense.

Regards,
Boqun

> > use spin_lock_irqsave and create the token, unlock_last() would use
> > spin_unlock_irqrestore with the saved ContextState. Then we could use those
> > unsafe primitives to implement a method on Lock like this:
> >
> > impl<T: ?Sized, B: BackendWithContext> Lock<T, B> {
> > pub fn lock_with_new<'a>(
> > &self,
> > cb: impl FnOnce(Self::Context, &mut Guard<'a, T, B>) -> R
> > ) -> R;
> > }
> >
> > What lock_with_new would do is:
> >
> >  * call B::first_lock() (which would be spin_lock_irqsave)
> >  * call cb() with a LocalInterruptsDisabled token and a &mut to the Guard (so
> >    that the caller can't drop the lock before exiting the noirq context)
> >  * Call B::last_unlock() with the ContextState that was passed to first_lock()
> >    (which would be spin_unlock_irqrestore)
> >
> > So we'd absolutely still be modeling around the locking primitives
> > spin_lock_irqsave() and spin_unlock_irqrestore(). And subsequently we could
> > still nest lock contexts like normal. with_irqs_disabled() wouldn't be needed
> > in this arrangement - but we would still need the Interrupt tokens (which
> > would be fine since they're just for enforcing correctness anyway).
> 
> Makes sense.
> 
[...]

