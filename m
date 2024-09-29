Return-Path: <linux-kernel+bounces-343240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6287F98987C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 01:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243B91F217F5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA54180A80;
	Sun, 29 Sep 2024 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVn3EfQB"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C67175D32;
	Sun, 29 Sep 2024 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727654005; cv=none; b=py98qHgkwY+dzVNuncXiD4vLlJaWXINL3L9egRp/YOHZ9jZkyvIxTzMSAHi4TfLdXhZtn1QKwTQpa7rg35fMFEVvSUPAecBueekT+vyPd6IUZIR6Pno+Xd+qfzG6oTRISpassuVxxgNQFSWAG3E+6S6hsZbgd7on1L8j6Mh7DGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727654005; c=relaxed/simple;
	bh=UKRlj9fNkq2HxhGyfdf1m2RQP/aQuJaaWnuFF5+Td60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNd6X4fxkCK49/ue0fSCVeFdVlTq2C8z1EOhDpJgW/Qh7AWcPov3zGdjOVMDtxER4B/ZZgnHOkXbX0kyoKWveX54bllkgE0pN1Aq5ui74dZ9Jpp0Xg6OIOpERR3cUMAh4/jc5J19pzI1CCwLMY6+AdcBABEb/MbLvkIMO26oMNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVn3EfQB; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9aec89347so246366885a.0;
        Sun, 29 Sep 2024 16:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727654003; x=1728258803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAEKMLkD22MSDvK7Vrvcg2LidGBpc3vFN2oLL4LAdJQ=;
        b=ZVn3EfQB2APhY4OUJp1ZejTd1I+lNI78F0ausuwhlGPnbSMAnxMFO/8do3+si5vd5D
         oa9yUwjqE19k83toDbGC6ZaQnl3E2Kwwoeot1WZgYE3GuPtC7zZI/8F+UIq3V9LAXrbn
         b7rP3AdpuuxEHKRSSV5ynptqljfTk5OKjJrU2uoYc/KVc6p+QEwq2w9eKbiO7cF/deBN
         gWKBl9LbXEPUPvLEkhdOirF8hv2KIXqp8lnQKi04SRYHefAgwx6PpmE+glpxuwsPzerJ
         vE9izHc3ukRG5Icn5drc+J5KWd6savJaMc8PQUOj3wy2zi2liXb1t6kbLrpF0NQHNbKi
         3HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727654003; x=1728258803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAEKMLkD22MSDvK7Vrvcg2LidGBpc3vFN2oLL4LAdJQ=;
        b=ayWWvBQhPB2L/JaOyJ9v3MDwIH95ot8oamic/z6aRfZgMCf6S0iPVqQoRiyfRsXa7t
         sS4+B6ppm7VNqaYQZ0hcDxSXPtVU/571dKaOSx9QxgskbXLCrUWYax5o2v/ESoUTl9M5
         /ye9DtdJJhSoONq3zIpJE6M+1NT+ho0X7JzGA2un/aZymFt2jspMxpxtFRsaB78pFy+H
         GShMIEwTEOBW7FOpm9M0GUE/IkTC4rUE0XaHm/7BhAiBeYxRumz0ZgX3a647X2EJ5b8o
         DP+qd35cRKewtoDvREEK9EzFxo0FgU1Qphps+J2KLZfxfh0jYC6XuI/zK2f/PcqglS2R
         ALyg==
X-Forwarded-Encrypted: i=1; AJvYcCUncC3RmoY5y8UUFr0FaasBnKtLsFTFwijAq6F/B2MYI9CQskTxoDEIWY8PrJnWrKEYNTo6Edv2NFAZKZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8VbUeVZd4Hdr3vsWrq3UiMCDa72aAVjNn4Ra0yxBBdh+ThINU
	o0OGOjdFRK6FgtBEDTnY2kTkj0r45VccVMH3/GmI+EQqbhrzxmhT
X-Google-Smtp-Source: AGHT+IE3AlFTSmZRFXETlWkeqIHSyvDsuJb3Kq4JEYxwxzjbdjN5s8fx6qUx+YeHVOEnwXSWsnHhrw==
X-Received: by 2002:a05:620a:1917:b0:7ac:b89f:5308 with SMTP id af79cd13be357-7ae37824642mr1928490985a.7.1727654003115;
        Sun, 29 Sep 2024 16:53:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3782c6c0sm362741185a.88.2024.09.29.16.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 16:53:22 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id E574A1200043;
	Sun, 29 Sep 2024 19:53:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 29 Sep 2024 19:53:21 -0400
X-ME-Sender: <xms:cej5ZvyqnVwSdn4p53Wu1BKxMAPBpOw2znJ-hHxqbQZbXfkZWwfRlA>
    <xme:cej5ZnRRBocWrguTDHnN1PaMopBhBUKT3ZG2zSdKgldszpDKEr9tCDVaZAAjlK-5W
    X4jz6MIMuOQJZMorg>
X-ME-Received: <xmr:cej5ZpU-L9F2vhdY3bnZxtzqtk0ISz5oF8VCLl9nVxSFZeRkrbnbItH1_XKRsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeitdefvefhteeklefgtefhgeelkeefffelvdev
    hfehueektdevhfettddvteevvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegurghkrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghirh
    hlihgvugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghriiesihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrd
    guvg
X-ME-Proxy: <xmx:cej5Zpjvlq-MCaulvwYoq37yPPccNBLYNOH_uvfJu_G2dRoRzZ0ukg>
    <xmx:cej5ZhBY6kowMHkOfr3OM7-GCtv35AHjHJc6Bm9jUFbEB0YJorkOSg>
    <xmx:cej5ZiJ7jADF4Oamk7bwxgyIQ1xhyH87mB3lzP5_fK8nVd4qd-tmRQ>
    <xmx:cej5ZgCLZuQ4doivcV5hoJXcT8t_gXvINqtJNe5fRFFcjVdVAqonYg>
    <xmx:cej5Ztz7O42o7yztqtm92lzGzBua3R2od1K4JrH2zulrnsxlH927bIif>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Sep 2024 19:53:21 -0400 (EDT)
Date: Sun, 29 Sep 2024 16:52:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v6 2/3] rust: sync: Introduce lock::Backend::Context
Message-ID: <ZvnoOaOQudoVyBjF@boqun-archlinux>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916213025.477225-3-lyude@redhat.com>

On Mon, Sep 16, 2024 at 05:28:05PM -0400, Lyude Paul wrote:
> Now that we've introduced an `IrqDisabled` token for marking contexts in
> which IRQs are disabled, we need a way to be able to pass it to locks that
> require that IRQs are disabled. In order to continue using the
> `lock::Backend` type instead of inventing our own thing, we accomplish this
> by adding the associated Context type, along with a `lock_with()` function
> that can accept a Context when acquiring a lock. To allow current users of
> context-less locks to keep using the normal `lock()` method, we take an
> example from Wedson Almeida Filho's work and add a `where T<'a>: Default`
> bound to `lock()` so that it can only be called on lock types where the
> context is simply a placeholder value, then re-implement it through the new
> `lock_with()` function.
> 

Given that Backend::Context and "lock() where Context: Default" are
basically Benno's idea, I think it's fair to have a Suggested-by tag
here.

> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> 

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
> 
> V3:
> * Use explicit lifetimes in lock_with() to ensure self and _context have
>   the same lifetime (Benno)
> * Use () for locks that don't need a Context instead of PhantomData (Benno)
> V4:
> * Fix typo (Dirk)
> 
> ---
>  rust/kernel/sync/lock.rs          | 17 +++++++++++++++--
>  rust/kernel/sync/lock/mutex.rs    |  1 +
>  rust/kernel/sync/lock/spinlock.rs |  1 +
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index d6e9bab114b87..cc39a3dc3f20b 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -43,6 +43,9 @@ pub unsafe trait Backend {
>      /// [`unlock`]: Backend::unlock
>      type GuardState;
>  
> +    /// The context which must be provided to acquire the lock.
> +    type Context<'a>;
> +
>      /// Initialises the lock.
>      ///
>      /// # Safety
> @@ -125,14 +128,24 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
>  }
>  
>  impl<T: ?Sized, B: Backend> Lock<T, B> {
> -    /// Acquires the lock and gives the caller access to the data protected by it.
> -    pub fn lock(&self) -> Guard<'_, T, B> {
> +    /// Acquires the lock with the given context and gives the caller access to the data protected
> +    /// by it.
> +    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T, B> {
>          // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
>          // that `init` was called.
>          let state = unsafe { B::lock(self.state.get()) };
>          // SAFETY: The lock was just acquired.
>          unsafe { Guard::new(self, state) }
>      }
> +
> +    /// Acquires the lock and gives the caller access to the data protected by it.
> +    #[inline]
> +    pub fn lock<'a>(&'a self) -> Guard<'a, T, B>
> +    where
> +        B::Context<'a>: Default,
> +    {
> +        self.lock_with(B::Context::default())
> +    }
>  }
>  
>  /// A lock guard.
> diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
> index 30632070ee670..7c2c239944931 100644
> --- a/rust/kernel/sync/lock/mutex.rs
> +++ b/rust/kernel/sync/lock/mutex.rs
> @@ -93,6 +93,7 @@ macro_rules! new_mutex {
>  unsafe impl super::Backend for MutexBackend {
>      type State = bindings::mutex;
>      type GuardState = ();
> +    type Context<'a> = ();
>  
>      unsafe fn init(
>          ptr: *mut Self::State,
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index ea5c5bc1ce12e..97d85a5576615 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -92,6 +92,7 @@ macro_rules! new_spinlock {
>  unsafe impl super::Backend for SpinLockBackend {
>      type State = bindings::spinlock_t;
>      type GuardState = ();
> +    type Context<'a> = ();
>  
>      unsafe fn init(
>          ptr: *mut Self::State,
> -- 
> 2.46.0
> 

