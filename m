Return-Path: <linux-kernel+bounces-527980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C39A411F8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 22:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3588170141
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4A23F295;
	Sun, 23 Feb 2025 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK0npiNi"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE7224FA;
	Sun, 23 Feb 2025 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740347538; cv=none; b=nZgo70JXkaSkXFPzhPA11zTLsRLUigCBfTjyt96hGvSVzrI2N7/UyAFnn+n3MWqSySOb+sU9rsWiQPG7tESmd8efhezejXYMLcR6YRSmYai+fSnHqQnynX5VzFyQx9DKhmMn+9Nma6QhQUhYfpobq20AXTg2tHeSZs1Yw5BQozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740347538; c=relaxed/simple;
	bh=y0n5/Tp+S/o9eh9arUsfXxBzmYKvJcqgb1v9hG8wmQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ncl2D6O301H3dVxQwclZa0KHQeS/fTeiQ6WiT6rzyjLeibLLDMynt6wrXk/cF9oY11zc7y55hrWpw1XhJxtOjX5aydgdWjqcSVQeMoB6SSr4BYqKbqxaAkClggghmJFD9usyDl1BQp+/lWo5EFY/u/9aMcoaVv/sGE73F+SKt+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK0npiNi; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-472087177a5so51448231cf.2;
        Sun, 23 Feb 2025 13:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740347535; x=1740952335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81P3cXRxlQOkm85UxJIvdQMe4ZP31/sM22PCeOs5sTg=;
        b=nK0npiNi6Pgl6/0Kj78APJIimlRH9ulqqawcOW3tb9OOoY1yh7+DxQH8Ce7LqTR4CZ
         GCavXQCtIxrvnKitHWXPA57OUtlKSdWdFE8V2liqwBzEqofUbCHd0kojhPUYOkeaD7+8
         wneViemPuzw3Hr+uZMQr1lJ9SLXzoOUFedLhT1MWfddl1E8k/ZUUZDKdxiJQL5/h49FE
         jW0tmtOiaGR0zUkIz/0RfRBTouw6q/I5DK5miSJtqpQc/yWx49+xfJ110DtaNAOeCSdP
         T7leXhnZgNn0nsnAXgCtSojgzNJQqr/hZczalIhfHNwmHryZ+LlgEY1J0SyrL7q0bOPP
         ljug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740347535; x=1740952335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81P3cXRxlQOkm85UxJIvdQMe4ZP31/sM22PCeOs5sTg=;
        b=YjoYYXWYoKAJxG6jX66Uspbpti3AUesDqpuUZuH78dR4jq/v6UVqUQ1XLR0N3znbcq
         e/dVZe8IBWDTk0Hfx2X62LhuuIFe2Er0+kEaOX5DY2v8y7VNFc/0nFpQj/yFvdO6iUmy
         +POH5ZKTkIUVuNfA9iB6oVTmsB2xXbhi4+8wlCrFdUKl97UGG/E/4GM02pf3IjOVd0L4
         UOSSDKMqWLqvmFR0ZhKo50aeTCz4dY5ta2GWTXH49kdGUkbbtT+ZvrpzHE/r+UKFTMkS
         ycBMCnqpSFZ6bx6K8FY931NT54PuxYDXWCV/GVCRlvNgRyJ47na1K/FgBr9tTauGBd/J
         cCyg==
X-Forwarded-Encrypted: i=1; AJvYcCURgIKmIw6THuiR4f66CrTzSn3tCDh1QHUptyfe1fKYjeD8iTPOHd9wIFyVCCZVMm5IkszvfUO4YHJCTKgZvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznbO9fZj/a5H8+qlZR24oRUB4JXNHZqfoNYAuf5nKCIc7Rody/
	j369ZNBs30tDLrZr1KG9357OEaPTo9yQs0Z3S5VPuZL12v3/OAvB
X-Gm-Gg: ASbGncsfwP+W/Ji2pb5OYNHf324ckQXEs1/6uVePO4XUU/wvTXboHXJlIJnUo8Hfk09
	34/z5FfU7q9tpTo6wRdqzxdh574Ac5xRyu4TqaQreeHu97p8lXRKxcaBXEEkFUo/9dYmsn1iC3T
	Pa9mmERzVHbj22r7jXooFaul5k4TPm1aHGv6x5ScJGOVBPjzJRRYJT5Q909yFD9dqSr6B6lWbRc
	0IUvBI2bB0duuAjkcgCUhjMr6HodauXDsj4aT1ZIUy6JF86l9nVmFKLD0+6HTr4aEk1Neht4STG
	OdBAuRQ4IVLjZeqcFuwemZ4TABJAQLzIVgpfLoDSGwcv9n12C6VTdK6UpcPYG6BRXFz2FDPkhD9
	lAuuRgDHDJA2wk6fG
X-Google-Smtp-Source: AGHT+IGhgwp62YiKrfWTgQp8R2YxUhhNDVL8r4b/6glbYNkHu1CloNLRqkqJGJnpu5SLMhG01SWUYw==
X-Received: by 2002:ac8:59d0:0:b0:471:f222:3328 with SMTP id d75a77b69052e-4722298c130mr173387531cf.47.1740347534756;
        Sun, 23 Feb 2025 13:52:14 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f2228e4fsm82779551cf.9.2025.02.23.13.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 13:52:14 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 91E4A120006C;
	Sun, 23 Feb 2025 16:52:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 23 Feb 2025 16:52:13 -0500
X-ME-Sender: <xms:jZi7Z0zFjdu8Yx38zcAmQxqk8AJgGQhSMbPsaWg1K0yx5hXfV1uViA>
    <xme:jZi7Z4RlpexeIrzkBtoyQoRj82BimNtl88vViae8YJ4J9rSDEP68ztz7VUy8J3zW0
    alSwQHk8y9r_s-2GQ>
X-ME-Received: <xmr:jZi7Z2UpsWDS5IWqr2DQA4TS4309-gFHpxP721_3_MvPrOtPu2NAzeiIYOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejieelkecutefuodetggdotefrod
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
    hopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruh
    hsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhose
    hrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhjvg
    gurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:jZi7ZyjKnlqEuXluIUJ5J6gRGISDYhXlHb2G3k0FIONLsI1G1XYDzg>
    <xmx:jZi7Z2DHX4hd5qXhMQXHps0Pdljj7ReBbFW9pwQHpcYMlM8J-gY9Gg>
    <xmx:jZi7ZzLATqvcsZ2wH4ZzI7L5rvZbyCWmywkO7kYZNglCGMm4aVJ9KA>
    <xmx:jZi7Z9BS6q3u6hVe0Z_CaKwdtqNUd6hlFsK7rp1naPY1m6EkdOHDFQ>
    <xmx:jZi7Z2zvnFOEMzzVG51hgPEc9kEFRK82UIUwhX-sFLwbEMaulZfK3jn3>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 16:52:12 -0500 (EST)
Date: Sun, 23 Feb 2025 13:51:37 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: sync: lock: Add an example for Guard::lock_ref()
Message-ID: <Z7uYaRM6LuwfcS8n@boqun-archlinux>
References: <20250223072114.3715-1-boqun.feng@gmail.com>
 <f834d8bf-3860-4087-937d-d9937c1be3f2@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f834d8bf-3860-4087-937d-d9937c1be3f2@proton.me>

On Sun, Feb 23, 2025 at 10:54:59AM +0000, Benno Lossin wrote:
> On 23.02.25 08:21, Boqun Feng wrote:
> > To provide examples on usage of `Guard::lock_ref()` along with the unit
> > test, an "assert a lock is held by a guard" example is added.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> 

Thanks!

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
> > +    ///
> > +    /// // Creates a new lock on stack.
> 
> I would be inclined to write "new lock on the stack.", but maybe that is
> incorrect.
> 

Yes, "on the stack" is better.

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > +    /// stack_pin_init!{
> > +    ///     let l = new_spinlock!(42)
> > +    /// }
> > +    ///
> > +    /// let g = l.lock();
> > +    ///
> > +    /// // `g` originates from `l`.
> > +    /// assert_held(&g, &l);
> > +    /// ```
> >      pub fn lock_ref(&self) -> &'a Lock<T, B> {
> >          self.lock
> >      }
> > --
> > 2.39.5 (Apple Git-154)
> > 
> 

