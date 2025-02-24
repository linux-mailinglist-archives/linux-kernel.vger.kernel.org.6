Return-Path: <linux-kernel+bounces-530236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64942A430F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F40179160
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04520B7F2;
	Mon, 24 Feb 2025 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfzF5ziK"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5289A1DD9D3;
	Mon, 24 Feb 2025 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439929; cv=none; b=UD8QGYZ/JYqaNV52XlSKCCvm4szJWVmbzDeeQndBWsL+yyrLgWDGLYLu5gsPdq02nwOSBm5OAJgFA7mSbuRXjZe+Il3OdjT9FwT3Yw7O3XqLNUrkDWK+SYHOjAtE25bVlnRWlbNQWlt5gWV+47tzBC+sMe1/emxXbg6jcMV5Mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439929; c=relaxed/simple;
	bh=F3MG8xY6VjCDQHesydP8QZ5kcxhsuq6+AnHUMVjffuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+dsa84idl4cjKReY5oQjk/Rsbl/gEPmqPb/n864Rt9v1wtKU6f/grD2FUJixHqnBaZZpm1zE2LxhuOzsdUCcLd++ynXSZJal/3MbvDo9YfT3ol1o9MIgx0qqf64nvFkybuSUAqOhXy190zUVXC8sLB8Tn5ICBoNb/E20FAZnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfzF5ziK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471ea1a12dfso22591071cf.1;
        Mon, 24 Feb 2025 15:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740439926; x=1741044726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIAmrONTNVXApf7l3oUSj2/rCYyViYZtrUZljSBiPpw=;
        b=DfzF5ziK34ux7XbqklZBgbMzrKDkjjAxd2Pv0a9P+MBixpzkL4V2aGJZ33ZqtMkFia
         wtUI7U27AccklydMVrNkYFgy77Rhi8SrHYhdqU8LduCcgmluEa/aPN1M9wOmmTKWt7+6
         P4b/elKa6byPWdW59SzPMe/TwZ0LK0mg2/mDhyNXEZQwc042jQISdc6/WyE4j6rwUHtD
         xzIMaeq7cJ7hgASgQDzm/jBiTG3kAg5VIMPcrDRHLq2NIhtQOX4woq+DTp8pg8Inwhsy
         zq5VTXAcdS4j3Y4AJD8a9rpNCRwk2xSiHbCNpkEuU2uPTuj/Ncc9AyiV0o+2RpOTdbSz
         r4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740439926; x=1741044726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIAmrONTNVXApf7l3oUSj2/rCYyViYZtrUZljSBiPpw=;
        b=RUmObxuIiUo+x4ajAWFNq+QbNj4JzmW18sp0cgeG0zuCsRuqisR/BxidF5BVeWwMBR
         iUEt5xh3+u8aJUx2WFZduuYNmACxqlYb3K3mnmBcABc90lRs4/Hi0X1A54b602t8bgdL
         5PX7neFcX5IKoR86E87Pul3hHcNFfPcfyIdIOJWhhG7dVHAHC04yIWLRRbZwGAVkKnx+
         g8osRddi1DL66kv3xlbsYTXr07XrEVqbye5Em/qySgi8c+H8v3gkISw9pfPzqvxKqr8F
         tXYepFf1Zx96l8E/9aNzgEE24uqgw0dbg6u5hXyybISoqiQalL0ytlKmhQlE2T0BNh+V
         8PBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqRpG8ngK/f7UQKBU9PB5xuvqdavNM81TBjmpjOsejBwMdTejMM56m00tDWCW7wBzYuNUmZslhDz9pza/wYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydokYZT1U3BJ2p+X0UgcouK2iuRi8JtmTEzpD0W0yWru2JjKYI
	W1nbT3zsJDLVmm+wkaepmpPxtZMM1ONqyawLoEafsdVfPN/5UTES
X-Gm-Gg: ASbGncvvqb97ATJLAxKgDYq+Ewsh559LlnpjF1u68DmeRGaJwEOxB6IBTjX5UvAiWZg
	vpkiC/t9ZjF5urgfN33xxFM5BvIx6uxjxOWTpHJ+Ghi2WGGZjB9fJbKxaIu15Yfr855HCiTYb+1
	ak6WdJhCcZwO+uZEFPNdh05e4TY+ip2hh/xHR9i35a3xpO2y+7HVXO4TI1W31anLrBzkuuRVQ5i
	4QxEaPCmytKOd0WtNk9okGxG1SiDSVH1QkxgJZAd/TInj7V+Rs2I/5DQ7EytdG3TjgS2FdhFuy0
	tvk3EqcOww3n87TMBW50rgjh464T24dEOJnmaWa2jSO4+CV3S+R75a54uXvOEr9t4mrxMNY3yTr
	HHepTdV8Wu/8RcTxp
X-Google-Smtp-Source: AGHT+IFvWPtyqWI7use2nQ5ILVD33Q8VQPDJoDKK4cuqN8ZZZq9WZxc1ft6tL0NR/5XK61JAopcWhA==
X-Received: by 2002:ac8:5a48:0:b0:471:ea1a:1cf6 with SMTP id d75a77b69052e-472228c1923mr230598141cf.16.1740439926130;
        Mon, 24 Feb 2025 15:32:06 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e1543csm2515071cf.27.2025.02.24.15.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 15:32:05 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 389531200043;
	Mon, 24 Feb 2025 18:32:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 24 Feb 2025 18:32:05 -0500
X-ME-Sender: <xms:dAG9Z0K4i3BeHuVk4kc4Si0ZKlbBFJUedZ3KKVk5p0TFi_AjtSRwNg>
    <xme:dAG9Z0Lc1tMx98uE0uTZbJnduHh8KTM9hSjdjYvMzH2uB33PiIaSEMl_8oZ_mS6iM
    w7An1s-D1qOZUR3cg>
X-ME-Received: <xmr:dAG9Z0tsl3xF6SQ9o3sitscvj5bzNi2dBhtUcWWT4YtOubI0QgtmWpBZu5c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhush
    htqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehojhgvug
    grsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:dAG9Zxbqyzu_X-Z-wrjAdhQsc0zkkkQo5JSUWTLLr43u8awstyeFmg>
    <xmx:dAG9Z7YzrsaIK7ReufL2yrQv8DSxzmRe2gcCpf6uyBpWlI_L3F-RjA>
    <xmx:dAG9Z9AkUBtJo4lAWLDGyz_AGyzTLI0p6AYBgaMzNCYOldmH-9xltw>
    <xmx:dAG9ZxYekGQBLwApeaFaGuzNQ0MmZGlhZkL2f1NcxIkuiERLGhAhFg>
    <xmx:dAG9ZzpgXSVzBltTwFE7J6l2QH-qE-rXbS_SYWXQyqadCIVM1pkqLMEg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 18:32:04 -0500 (EST)
Date: Mon, 24 Feb 2025 15:31:25 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: sync: lock: Add an example for Guard::lock_ref()
Message-ID: <Z70BTQqudaR4LMi3@boqun-archlinux>
References: <20250223072114.3715-1-boqun.feng@gmail.com>
 <87wmdf22ae.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmdf22ae.fsf@kernel.org>

On Mon, Feb 24, 2025 at 09:08:09AM +0100, Andreas Hindborg wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
> 
> > To provide examples on usage of `Guard::lock_ref()` along with the unit
> > test, an "assert a lock is held by a guard" example is added.
> >
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> > This depends on Alice's patch:
> >
> > 	https://lore.kernel.org/all/20250130-guard-get-lock-v1-1-8ed87899920a@google.com/
> >
> > I'm also OK to fold this in if Alice thinks it's fine.
> >
> >  rust/kernel/sync/lock.rs | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index 3701fac6ebf6..6d868e35b0a3 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -201,6 +201,30 @@ unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
> >  
> >  impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
> >      /// Returns the lock that this guard originates from.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// The following example shows how to use [`Guard::lock_ref()`] to assert the corresponding
> > +    /// lock is held.
> > +    ///
> > +    /// ```
> > +    /// # use kernel::{new_spinlock, stack_pin_init, sync::lock::{Backend, Guard, Lock}};
> > +    ///
> > +    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lock<T, B>) {
> > +    ///     // Address-equal means the same lock.
> > +    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
> > +    /// }
> 
> This seems super useful. Perhaps add this method as part of the lock api
> instead of just having it in the example?
> 

I would like to have this (along with Alice's lock_ref()) for the
upcoming Rust locking PR. So I'm going to keep it as a test now, but
happy to see a patch (or write one if needed). Thoughts?

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 
> 
> 

