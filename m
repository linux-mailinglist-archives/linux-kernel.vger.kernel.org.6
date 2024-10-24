Return-Path: <linux-kernel+bounces-379188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DA49ADB37
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FAE1F22780
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F47617107F;
	Thu, 24 Oct 2024 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy+BqPJE"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D81C01;
	Thu, 24 Oct 2024 05:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746334; cv=none; b=s9W5SEMDc133wWIAzYD9BRrpLrS64VnbU0ulPz1OUP0/IEoCMfxLNfnPbYUqcd8K9x3F3v9k8KqRlAWRrJyk+l+E5qhO0jND+9amdlgTZiIQ7e8OvkcQPc2rVmWqdTQb2Jga+NKULrJBXrBXuwZ0f7HepmjtH6QBFyfJBJQ2fCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746334; c=relaxed/simple;
	bh=3GdWZI4rN9PzAf70JPGws41Cu2zBOhxDyX0i8m0pRXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0akIDcimDtYwmIDxhwZB5lmzgOfQ3ddzXX09/VirJxPr68yq3PilIT9mSZZStO/ayIsjMEbfxWNnBRWmzEq66CupE4brMcogFtIvlo9+h0E1du2gwm0Q73+4K41cbeUwX3ZBFtcoNmNk3igskSGRNNUdb3t8w/QkOis9yIUyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy+BqPJE; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbd1ae26a6so2705816d6.1;
        Wed, 23 Oct 2024 22:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729746331; x=1730351131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LU6zWTxMemrmV1/tq1c5hy6KSI2S/PziqX1LsIFOl0=;
        b=fy+BqPJEGYxLKx7BoBE/3UVFNBdFjBQPObrjjhehRAQoGXUeyL6qexapffBvypYVqu
         GK0EzleE5Gt7XnWny8R7hnrciFInzcU2J2179mW7Z4YTGJcusiwm+6ohv45mwdpnoQ9R
         hLH2GPa9ytzzjFop/saKRMx5U1LB82OGKO8tkn8iDvp2zT+fUWrKSI+HQ5Av4iZHXu8F
         L8871AVrozZxGcICgxZrdMqBXfbbuIy4ADHDH1tt6oOITg70pnHhSpXX/tDRofOE8K6r
         VYjHnGie/CymPTSgsQfu2vo1+RzutWmeWPfeWRLc1bTwEFF2Nii0IB98sQ4tJ3lGf2ch
         6fmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729746331; x=1730351131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LU6zWTxMemrmV1/tq1c5hy6KSI2S/PziqX1LsIFOl0=;
        b=BETkSKm1R0DdMKPYpwT7GIytsJedOG6Mpz9qWLciOYtsIzJEUm8dvbER6JnYFvIQ8V
         vWGHWxsmPlu/2+pzAG9O9zhZxGrWKSenUjqe4rzxX95dx8Mhjj1LlAa2lDk/AAmzM7q1
         Y+Dfnp/rlOZDw9r//r2ZQjG2aal0sFmUslge+WAxlRUAWo9MGlLvE6+BUxpnReNyAjJM
         PnKvgvEX37UB+Qs/oF5bU/0zZi6NFKaU7ZxAPvB0hX+73g0BLUwSD8C+PV8Tuga9kHta
         rtl1k8EuJ+0ZBdS5ubRwtEpYKWvh2tXu238hjJD2XG5B9WRmwEJONe6H+UwNEF9/2n7l
         4y3g==
X-Forwarded-Encrypted: i=1; AJvYcCUZgjYfWgsnJO+eDL0YQEK1/HjZlp6wRL30xopSD2P2CEb0ZGC6DvpUBCmFFCPtozBCvFDqaYx0Orve9Eh4/1Q=@vger.kernel.org, AJvYcCXPxl6Z0MQJMWsH2CEvWGNScNkVcW3Dd3s364Mlbf5k+ShU/2YXP4Dipf3i7o2VZhobAASjdEjNH0LgJAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs9ghHhuHVeUXJEM+KFhvmX3g2Z1gUKHV8r8F1BDFcFFCVJWOq
	e/uyrYYk0d0t4hp74t7z4C2Dj8o5yeozkxnA6PbqlY9HCUfXAcHw
X-Google-Smtp-Source: AGHT+IE+cAGG+wI4nDNeQfD4AnRER263XL4pr2BFYANfq4PdTQSnCA9r/Dxn/voqdTq7fVRi8lCKKg==
X-Received: by 2002:a0c:fe09:0:b0:6cc:74e0:4fef with SMTP id 6a1803df08f44-6d08d3ff46bmr7430486d6.1.1729746330989;
        Wed, 23 Oct 2024 22:05:30 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00999ab0sm46761086d6.93.2024.10.23.22.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 22:05:30 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id DDE92120006A;
	Thu, 24 Oct 2024 01:05:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 24 Oct 2024 01:05:29 -0400
X-ME-Sender: <xms:mdUZZ-VVNah9XS8u1ByX7EuyyTzznOHXOdLSTCJc58TPSUFcTUxW0w>
    <xme:mdUZZ6ls85buPwX6FjunU8YvcPwPFX5EQirtJoPG1n17Hs-cs69v3f3gvjjCStdSi
    iaykWcCT_lAVohxgQ>
X-ME-Received: <xmr:mdUZZyZycapfj_T-XRuT2efW3ogEdr4Jp2vDE2RpedrTb_zp9yr0TjGZON8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopeguihhrkhdrsggvhhhmvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehlhihuuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehruhhsthdqfhhorhdqlh
    hinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrhesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtoheprghirhhlihgvugesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:mdUZZ1Uqx_KuRv81jDtyo9TUV8Ftie9sseb0mz8F7VViPAJXCRlSFQ>
    <xmx:mdUZZ4kodUcLeLqwQYZifea50YU4ZlYqFyKt7ig6MOgeRFINCADzZg>
    <xmx:mdUZZ6f0f1zwT7TKx-IVYPw8MbAzfnQhs4gIgwF8ZPgZ3U0pRtGiTw>
    <xmx:mdUZZ6HG2iacU563Lu3Xh0Lvyb2FA9N81BlXB0ZeNloBGGbTpCWOdg>
    <xmx:mdUZZ2kFuNwRVOdPyAeJreTi-ko0v4dtsw3q2TyXfI8LKQNBCaOLFOFK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 01:05:29 -0400 (EDT)
Date: Wed, 23 Oct 2024 22:05:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dirk Behme <dirk.behme@gmail.com>, Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, will@kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>, aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <ZxnVmCqk2PzsOj2h@Boquns-Mac-mini.local>
References: <20241018055125.2784186-2-boqun.feng@gmail.com>
 <87a5eu7gvw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5eu7gvw.ffs@tglx>

On Wed, Oct 23, 2024 at 09:34:27PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 17 2024 at 22:51, Boqun Feng wrote:
> > Currently the nested interrupt disabling and enabling is present by
> > Also add the corresponding spin_lock primitives: spin_lock_irq_disable()
> > and spin_unlock_irq_enable(), as a result, code as follow:
> >
> > 	spin_lock_irq_disable(l1);
> > 	spin_lock_irq_disable(l2);
> > 	spin_unlock_irq_enable(l1);
> > 	// Interrupts are still disabled.
> > 	spin_unlock_irq_enable(l2);
> >
> > doesn't have the issue that interrupts are accidentally enabled.
> >
> > This also makes the wrapper of interrupt-disabling locks on Rust easier
> > to design.
> 
> Clever!
> 

Thanks! ;-)

> > +DECLARE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
> > +
> > +static inline void local_interrupt_disable(void)
> > +{
> > +	unsigned long flags;
> > +	long new_count;
> > +
> > +	local_irq_save(flags);
> > +
> > +	new_count = raw_cpu_inc_return(local_interrupt_disable_state.count);
> 
> Ideally you make that part of the preemption count. Bit 24-30 are free
> (or we can move them around as needed). That's deep enough and you get
> the debug sanity checking of the preemption counter for free (might need
> some extra debug for this...)
> 
> So then this becomes:
> 
> local_interrupt_disable()
> {
>         cnt = preempt_count_add_return(LOCALIRQ_OFFSET);
>         if ((cnt & LOCALIRQ_MASK) == LOCALIRQ_OFFSET) {
>         	local_irq_save(flags);
>                 this_cpu_write(..., flags);
>         }
> }
> 
> and
> 
> local_interrupt_enable()
> {
>         if ((preempt_count() & LOCALIRQ_MASK) == LOCALIRQ_OFFSET) {
>         	local_irq_restore(this_cpu_read(...flags);
>                 preempt_count_sub_test_resched(LOCALIRQ_OFFSET);
>         } else {
>                 // Does not need a resched test because it's not going
>                 // to 0
>                 preempt_count_sub(LOCALIRQ_OFFSET);
>         }
> }
> 

Yes, this looks nice, one tiny problem is that it requires
PREEMPT_COUNT=y ;-) Maybe we can do: if PREEMPT_COUNT=y, we use preempt
count, otherwise use a percpu?

Hmm... but this will essentially be: we have a irq_disable_count() which
is always built-in, and we also uses it as preempt count if
PREEMPT_COUNT=y. This doesn't look too bad to me.

> and then the lock thing becomes
> 
> spin_lock_irq_disable()
> {
>         local_interrupt_disable();
>         lock();
> }
> 
> spin_unlock_irq_enable()
> {
>         unlock();
>         local_interrupt_enable();
> }
> 
> instead having to do:
> 
> spin_unlock_irq_enable()
> {
>         unlock();
>         local_interrupt_enable();
>         preempt_enable();
> }
> 
> Which needs two distinct checks, one for the interrupt and one for the

No? Because now since we fold the interrupt disable count into preempt
count, so we don't need to care about preempt count any more if we we
local_interrupt_{disable,enable}(). For example, in the above
local_interrupt_enable(), interrupts are checked at local_irq_restore()
and preemption is checked at preempt_count_sub_test_resched(). Right?

Regards,
Boqun

> preemption counter. Hmm?
> 
> Thanks,
> 
>         tglx

