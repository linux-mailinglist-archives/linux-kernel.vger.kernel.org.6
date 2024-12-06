Return-Path: <linux-kernel+bounces-434582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493D29E68A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCC4169DFE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5F1DEFFE;
	Fri,  6 Dec 2024 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBTHIT5Q"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6293D6B;
	Fri,  6 Dec 2024 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472970; cv=none; b=W2QJ2G+9ubix4+4FAJHxkp42xzxUpt9Da40lU9Qc5NEDysA8cpUnvTGw7hKZU/VIvmarQCYyTfoTGLure4urSjHEVCDSMPZAC+DNZk8oqhUYAzhaYdsfAj4f2cGZmKprkUOTePkdqTzwvh4sxtM0zn2t0TiRaW2ssD5H25FP/EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472970; c=relaxed/simple;
	bh=2DqBaoY/6bV8Ds/joIGrAijaxfMvq+z9HjNtk3xzO4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8wn6R0VQ2Ok74abtyO+7xJq5OZ87iZS6wv6CoIOu13YcTORbHmCV0ZC6OxpAymG7sxuvmEP/irBNYboCHGYUZaek2dj+bnHi5B0yeTPW8jRGtSJZpEwrqFW9lLessTmVxiRjnCt+QDY8f7wSRp5jaHUGkOJBR+rD6A57u5gkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBTHIT5Q; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6882c33acso108398485a.2;
        Fri, 06 Dec 2024 00:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733472967; x=1734077767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ7fz8+6bATAjuTMFpscyLNwpiLOhP1x779T9s2PTqo=;
        b=MBTHIT5QkFQfo5qkZ5UVSU8yiw09mzWQlzSno2SLzA5R/sqKblY9acDvcKoCh20ucV
         IvuMninL+dcdimHe4Sly0RFilhQgH+yvn8AepbrHb/qJBU2Virk6eS0NLbATyxFv8zC/
         ekBLU7UwTaZrYT9lRTcDYN7SvBiWI0bf6aFusN5VTiyDqlOchmJwLPwPBC9bYqRHaELX
         Yf8fh7M/q9NmqczRILWHTZ1krdUgzwyxalNJ6MGloRTLzeYk+HSACEJW1SXVeE4x8/Sn
         Mq+Cb/fKKJdNy+Q9hU+0SJlFN+fnymWxb7Qgu6NrR68PMyRcei34odis4qV/pRr6z3KV
         yhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733472967; x=1734077767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZ7fz8+6bATAjuTMFpscyLNwpiLOhP1x779T9s2PTqo=;
        b=Cc/yaM/O5xnvuL4mlNmkkYEIa8UuPz9q4Dc83MQzA+luLyvxOfQAvE6EnkeAoY5ymG
         XDD7clAqPsEaRKbhJXXBnJAWppDiohuRRiZ4GV5WRy3VUPXMDaHEIQnXNfTRl05X2BWH
         6Bz9jOFgFc0Pk4Xe0iJUaedOArGUm0HRWbHMAOnAco48hWN51nZ5X55cMOH8CfZCCYJI
         8rj3X0kLaG4DZgnjEjj4QO56bCpj/YxHZ5liLDCe+2/4t9YnKQWVO4bgkm05Dp0uBcXU
         eHV55oSdEqQUY3hkcSZa+cndxUKtTiDr3oQ4LIm7+XwHYixMl1RuZ/vvv52pHj3D2+IE
         Rxzg==
X-Forwarded-Encrypted: i=1; AJvYcCVD0iVjquBTZNvTMzvTisaIf/OMBssqQ3pX3nWMTYwYCUt7s99kdJXgeAr6lcnybyn0f3gDKDUggq5aTrA=@vger.kernel.org, AJvYcCXLEDYu2jfHIE3jy9uFDC1U+OvBvZ9fp0+vwfJJG+i1o/rFXJZFm68hLf5VurLcpZMR1VfaNGHz1Ihe0tTBmFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjI9iSEsn7Okfx8K75qk5Jwyp10suC60JI34kxCEQphpKzqQLv
	o8E1GtIF15+3xNIsE/wGJbEB4ADgoP2ObBJX3DnjGmyF8PpCRaz4
X-Gm-Gg: ASbGnctslgjCuseJ+8JCmsUeb5wIYveq+g4dW7Otl025+qcJ1hv3Kk6WZkFLUop5rg7
	Soum+RTH/QIZwoRx51geTuZldo7f23KNuUkU189DPb3XoSn16OGTe6OoD2qKZrSPd28sjGYJ6Sl
	YGo/xZZ2IO7qVJ3s3FNhpTu+XfCCrGN7yqd7Rte4sTSOfpDxqsQTwhx0sMNHj/J37Me+Ao+/aIJ
	a9k6kT03fE3owrSLPbw0/LOhnFyfoZR0UmDZXlTRFfZIVYtJWN4d1481uQCOzmmsC7zAoWHLIMK
	sLpClYyX3ay9SCeuCqecDoFqVuEGXDyZBz4zYn9l
X-Google-Smtp-Source: AGHT+IECmweIadw2XvYWlzBOFhVS+CyVHCZAq/2bjn+t0eQZCyvTC5f+bu3tGfHwIn5r4YIYRNFTgQ==
X-Received: by 2002:a05:620a:3951:b0:7b6:6756:eeef with SMTP id af79cd13be357-7b6bcabf9d9mr359928385a.1.1733472967393;
        Fri, 06 Dec 2024 00:16:07 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a9e7cbsm152370385a.118.2024.12.06.00.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:16:07 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 908641200074;
	Fri,  6 Dec 2024 03:16:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 03:16:06 -0500
X-ME-Sender: <xms:xrJSZ12ctgcbL0qukXoUofTCW53FxOrdxBM3FgDljbWjINmnratagQ>
    <xme:xrJSZ8E97mzX9U6PShI7LO-wtBV4JEQ0zYh3--zci6eMCn8uT7-fe-4KEjvNQVaix
    EaB86L41EFuWyVBXQ>
X-ME-Received: <xmr:xrJSZ14JOLBLBJISqDKUXC1IIkQyUVxTjwSfZD3ICFVM1F5b1YCqS8uyBjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepjefhieekkeffjeeggeeuvefftdegfeduteel
    geejledvffetiefhleefhedvgeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhu
    gihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdr
    uggvpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgr
    rhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrg
    hilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhm
    vg
X-ME-Proxy: <xmx:xrJSZy3d0csvrhIlH39FKkfb_26ao7oARQ1poNb3J7_e78gsm9v8gw>
    <xmx:xrJSZ4Fe0XwX-AvsPw6ixbQ4VlIJcZu7a82hyTdWCa8lYIvAqG2f-A>
    <xmx:xrJSZz-_3736NaM8UtYlmGZ9YzVjYr_DRr-DI33qHxBF41mqZvBrlw>
    <xmx:xrJSZ1mZyEB9V9_U6nJARVy8DkJ6K_dkEPaZy0O48Nb2b7zLZsJhdQ>
    <xmx:xrJSZ8EN7GNlncCwWDMvAlr_g7udD-pBC8_Ey6UclS4pYJsWs_z8iwbP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 03:16:06 -0500 (EST)
Date: Fri, 6 Dec 2024 00:15:27 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Message-ID: <Z1Kynwt4LpWdOiBN@boqun-archlinux>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-2-lee@kernel.org>
 <2024120648-finch-shrubbery-c6f5@gregkh>
 <20241206071646.GE8882@google.com>
 <20241206073309.GG8882@google.com>
 <Z1KvNQUUStyLjpwz@boqun-archlinux>
 <20241206080751.GN8882@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206080751.GN8882@google.com>

On Fri, Dec 06, 2024 at 08:07:51AM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Boqun Feng wrote:
> 
> > On Fri, Dec 06, 2024 at 07:33:09AM +0000, Lee Jones wrote:
> > > On Fri, 06 Dec 2024, Lee Jones wrote:
> > > 
> > > > On Fri, 06 Dec 2024, Greg KH wrote:
> > > > 
> > > > > On Thu, Dec 05, 2024 at 04:25:18PM +0000, Lee Jones wrote:
> > > > > > There are situations where a pointer to a `struct device` will become
> > > > > > necessary (e.g. for calling into dev_*() functions).  This accessor
> > > > > > allows callers to pull this out from the `struct miscdevice`.
> > > > > > 
> > > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > > ---
> > > > > >  rust/kernel/miscdevice.rs | 9 +++++++++
> > > > > >  1 file changed, 9 insertions(+)
> > > > > > 
> > > > > > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > > > > > index 7e2a79b3ae26..55340f316006 100644
> > > > > > --- a/rust/kernel/miscdevice.rs
> > > > > > +++ b/rust/kernel/miscdevice.rs
> > > > > > @@ -10,11 +10,13 @@
> > > > > >  
> > > > > >  use crate::{
> > > > > >      bindings,
> > > > > > +    device::Device,
> > > > > >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> > > > > >      prelude::*,
> > > > > >      str::CStr,
> > > > > >      types::{ForeignOwnable, Opaque},
> > > > > >  };
> > > > > > +
> > > > > >  use core::{
> > > > > >      ffi::{c_int, c_long, c_uint, c_ulong},
> > > > > >      marker::PhantomData,
> > > > > > @@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
> > > > > >      pub fn as_raw(&self) -> *mut bindings::miscdevice {
> > > > > >          self.inner.get()
> > > > > >      }
> > > > > > +
> > > > > > +    /// Returns a pointer to the current Device
> > > > > > +    pub fn device(&self) -> &Device {
> > > > > > +        // SAFETY: This is only accessible after a successful register() which always
> > > > > > +        // initialises this_device with a valid device.
> > > > > > +        unsafe { Device::as_ref((*self.as_raw()).this_device) }
> > > > > 
> > > > > A "raw" pointer that you can do something with without incrementing the
> > > > > reference count of it?  Oh wait, no, it's the rust device structure.
> > > > > If so, why isn't this calling the get_device() interface instead?  That
> > > > > way it's properly incremented and decremented when it "leaves the scope"
> > > > > right?
> > > > > 
> > > > > Or am I missing something here as to why that wouldn't work and this is
> > > > > the only way to get access to the 'struct device' of this miscdevice?
> > > > 
> > > > Fair point.  I'll speak to Alice.
> > > 
> > > Alice isn't available yet, so I may be talking out of turn at this
> > > point, but I just found this is the Device documentation:
> > > 
> > >   /// A `Device` instance represents a valid `struct device` created by the C portion of the kernel.
> > >   ///
> > >   /// Instances of this type are always reference-counted, that is, a call to `get_device` ensures
> > >   /// that the allocation remains valid at least until the matching call to `put_device`.
> > > 
> > > And:
> > > 
> > >   // SAFETY: Instances of `Device` are always reference-counted.
> > > 
> > > Ready for some analysis from this beginner?
> > > 
> > > Since this impl for Device is AlwaysRefCounted, when any references are
> > > taken i.e. in the Device::as_ref line above, inc_ref() is implicitly
> > > called to increase the refcount.  The same will be true of dec_ref()
> > 
> > No, inc_ref() is not called implicitly in Device::as_ref().
> > 
> > The thing that might "keep" the original `miscdevice::Device` alive is
> > the lifetime, since the returned `device::Device` reference has the
> > same life at the input parameter `miscdevice::Device` reference (i.e.
> > `&self`), so the returned reference cannot outlive `&self`. That means
> > if compilers find `&self` go out of scope while the returned reference
> > be still alive, it will report an error.
> 
> Okay, so is there something I need to do to ensure we increase the
> refcount?  Does inc_ref() need calling manually?
> 

When you convert a `&Device` into a `ARef<Device>`, Device::inc_ref()
will be called. You can do that with:

	ARef::from(Device::as_ref((*self.as_raw()).this_device))

You will also need to change the return type. And when an `ARef<Device>`
goes out of scope, dec_ref() will be called. 


I had an old patch for a bit document on this part:

	https://lore.kernel.org/rust-for-linux/20240710032447.2161189-1-boqun.feng@gmail.com/

maybe I should send a re-spin.

Regards,
Boqun

> -- 
> Lee Jones [李琼斯]

