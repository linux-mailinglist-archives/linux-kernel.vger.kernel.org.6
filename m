Return-Path: <linux-kernel+bounces-434567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9779A9E6865
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B33928383D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B61A1DDA0F;
	Fri,  6 Dec 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys/uve95"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D5C328B6;
	Fri,  6 Dec 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472096; cv=none; b=B9hBLPaJfGgSwv4UmbO1OqD9vLjL2QHLGGaptklDPpZKOSxeR2jY6y6aSDsEbicFhHQgxW82CAWkhO/Ij99xdpNw1rMkkAIxNVJSSPxNtdn2dOm/o5AsEnLO5sDsDJ+ICnsNf6w06HluEUxnqVZTJzrKegtym9VzbJ+ERhDdXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472096; c=relaxed/simple;
	bh=IjIcdXDC1t9HGrswdrraere4Q3lIz5rZuHgPc5SNyiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=st99isQkKrw7DoktFPnOceJD7QFWpKaSaJVcFdYoC72wIa23B5O+EpPGEDUyn0mUrA2YSxgDtqJ4D8wyKC0g3QmtIF5h8FLExtB62c2SUM9FLFNEdutT0+eWnXBJGgOu4djyJdd3/6uFIlwx6c0Ttcm7aOIHCSUivJi7oqgROL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys/uve95; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6844074e7so101077985a.2;
        Fri, 06 Dec 2024 00:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733472094; x=1734076894; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vtAp8644DxrNcSjxtskpD/XpaRyon/A2+WI/Qf6lmrw=;
        b=Ys/uve95osfn2IwoRF0OU/5l5zJmC61uzAPaWNwOEI2oQCAdP5llS/2+6pleQNWzjF
         nmiY4mczDRT8sSZx2mwtShFW8Yy1Fpd8K3b8uSjUYWaY5S0tLJrJIfdcQhRDXugwJ0kA
         9VPO85dd1w/7nZnlf5GDefu+UFRsV1mhRyDdE+ipwDd89WnrDN3NZ4Qggh6yEH7VetaU
         8xo0sSpPihxuxiX8GlcxiCRvuIeXGSle6V6+3U6S5t+xCEVbhEVTeWWmprP52Jp9Nmev
         PzWpgwrQJSuANpUG+kLf8m6TnF9/Q6eiFMIs68hzXWMbBpzu2rS9/UNbvWh0KICovnHh
         62CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733472094; x=1734076894;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtAp8644DxrNcSjxtskpD/XpaRyon/A2+WI/Qf6lmrw=;
        b=M5OtMA7RovAoR5vPkb8Zz7WuZqIoQYzW/PybsGpvd7I7fZE2e6xxcGAgkAXFjTjLPF
         JbtHI8BZHNqcmSr5ATHP5mZ4unWTdxb601453pVJq/sEMFWEitcqkHmIy60XmgSQ5UH7
         iIUl3MLlpt+5SQWgnetcLbNsPyVpbeb3g2LDevtrfi9nbOwJ5XXU0nExrqUjOLM7PlzJ
         ewQ0wFoLRpyFYtFO46Az+/9PrA771u5ZB0rbNyk1lCLNXhuhtCVJExgsBax06JrH15fb
         gmvUjkqrqmhvKw0UYD4odDzpHx+R3EadrKtIjQxuhlI4/6uadIZG7N2v6L4as5b4HG6p
         7osA==
X-Forwarded-Encrypted: i=1; AJvYcCUB/ugQwLYdlEH5XA2M+xAHrGJwJkHuD3F81FBACuNrcfIDJi7lJb2PZStzW3rY0npwP9O0jrhtOVfgd0cMG5Y=@vger.kernel.org, AJvYcCX6db9Fjspx01muQPMbMZAvGhfa7POrjSXnx05rYJUmccVSQbP3L/6kuim6DL3kQz8rbhjECR8bq7WCAN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OUCb60ZM8hYgN8b7Hv7Ct14hj4vXAY1CpSEEEXnjmYheOeAI
	2FhEAqZvh+mKqc6x70k7baxImKtL5/O8PSgPFkyiJpV6/6ZeeJWS
X-Gm-Gg: ASbGncuxAsuXnI2zxQI0dcHeDtTRPby1RWeyWXSfwlsaHVBacrm9YzYji5/B2j4P0wV
	jgUWZw23p91e8si5kJ0J5+t/SCCwOcMb2ck6uehaNCF9RftcMITK5+yeW67hCeRsfdKkWx1E22b
	2LK0WkpAZiDhKK6933dA/fLb1VpIWD0kVgDwp7D2myR9zmmw7GNPqUsDqLi9lHIM9Ff3fWYkxx0
	8qhDAYDjIBAm9Cv6aZX9uqXsd8sygQzjQyl0OitjGebp0uLBl6lc6DDr1Ae64IzWBKEYTRzd531
	5xyh9+dJUB9ghxylS3vB+W3g5XpaCtWtb7pbsPeH
X-Google-Smtp-Source: AGHT+IHs7f4+B0o5x2uA3OKCQm6e0/bV5+AGYgFZ3MGasWfEStUzGCeTghIno4CnvAcCoF8eIjtqgA==
X-Received: by 2002:a05:6214:5199:b0:6d8:a39e:32a4 with SMTP id 6a1803df08f44-6d8e7142e67mr25233726d6.25.1733472093594;
        Fri, 06 Dec 2024 00:01:33 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6739a9sm16469156d6.3.2024.12.06.00.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:01:33 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 87A211200043;
	Fri,  6 Dec 2024 03:01:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 06 Dec 2024 03:01:32 -0500
X-ME-Sender: <xms:XK9SZxTjuihVOgrYdMD6ZeiNhpHRpwAGz8pOQOo4pEgvU5TNAvNW4g>
    <xme:XK9SZ6zD_DUKYqHCmoD7Z0um2LROAbY2fvp29xuPRSKnt4N4kbgGaDLAIx7RPbit7
    mZZGpaYJCUXUojKgw>
X-ME-Received: <xmr:XK9SZ20wXJbcRqQjk5Sk_WTbk45P6SbmFGGgHCzAnXQjxQ7ygp0kHBsYvUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeejgeektdeuvefhfeffffehfefhheefjeeu
    veevleduheetleduheetjeeihfevnecuffhomhgrihhnpegtrghsthdrrghsnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
    pdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
    gvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhho
    uhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdp
    rhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgi
    drghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihg
    uhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:XK9SZ5D4IUjeVpW7C1IfrAwZ4yua0lVAnM7BOJtPtEpnDexDDdc2KA>
    <xmx:XK9SZ6j5y3zdCs1sagznzN6QXRvW_BzydJfWofavI-lLlKV0PSkx1w>
    <xmx:XK9SZ9rY7LxOqqKXVDvl05x-sL0DieQ9-5fl-Gqc6B7n38VLdQ7uxg>
    <xmx:XK9SZ1jCQaPHx2H9ru3ZX9KQ_wERVXafMMh08QVoGCeZ-j9TUmNwBg>
    <xmx:XK9SZ1ScaxkBv_KsS_kSiZwOJe7uylNtUKxe3D1X7r7QPuN8znIACz-Z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 03:01:32 -0500 (EST)
Date: Fri, 6 Dec 2024 00:00:53 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out
 miscdevice::this_device
Message-ID: <Z1KvNQUUStyLjpwz@boqun-archlinux>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-2-lee@kernel.org>
 <2024120648-finch-shrubbery-c6f5@gregkh>
 <20241206071646.GE8882@google.com>
 <20241206073309.GG8882@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206073309.GG8882@google.com>

On Fri, Dec 06, 2024 at 07:33:09AM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Lee Jones wrote:
> 
> > On Fri, 06 Dec 2024, Greg KH wrote:
> > 
> > > On Thu, Dec 05, 2024 at 04:25:18PM +0000, Lee Jones wrote:
> > > > There are situations where a pointer to a `struct device` will become
> > > > necessary (e.g. for calling into dev_*() functions).  This accessor
> > > > allows callers to pull this out from the `struct miscdevice`.
> > > > 
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > ---
> > > >  rust/kernel/miscdevice.rs | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > > > index 7e2a79b3ae26..55340f316006 100644
> > > > --- a/rust/kernel/miscdevice.rs
> > > > +++ b/rust/kernel/miscdevice.rs
> > > > @@ -10,11 +10,13 @@
> > > >  
> > > >  use crate::{
> > > >      bindings,
> > > > +    device::Device,
> > > >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> > > >      prelude::*,
> > > >      str::CStr,
> > > >      types::{ForeignOwnable, Opaque},
> > > >  };
> > > > +
> > > >  use core::{
> > > >      ffi::{c_int, c_long, c_uint, c_ulong},
> > > >      marker::PhantomData,
> > > > @@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error> {
> > > >      pub fn as_raw(&self) -> *mut bindings::miscdevice {
> > > >          self.inner.get()
> > > >      }
> > > > +
> > > > +    /// Returns a pointer to the current Device
> > > > +    pub fn device(&self) -> &Device {
> > > > +        // SAFETY: This is only accessible after a successful register() which always
> > > > +        // initialises this_device with a valid device.
> > > > +        unsafe { Device::as_ref((*self.as_raw()).this_device) }
> > > 
> > > A "raw" pointer that you can do something with without incrementing the
> > > reference count of it?  Oh wait, no, it's the rust device structure.
> > > If so, why isn't this calling the get_device() interface instead?  That
> > > way it's properly incremented and decremented when it "leaves the scope"
> > > right?
> > > 
> > > Or am I missing something here as to why that wouldn't work and this is
> > > the only way to get access to the 'struct device' of this miscdevice?
> > 
> > Fair point.  I'll speak to Alice.
> 
> Alice isn't available yet, so I may be talking out of turn at this
> point, but I just found this is the Device documentation:
> 
>   /// A `Device` instance represents a valid `struct device` created by the C portion of the kernel.
>   ///
>   /// Instances of this type are always reference-counted, that is, a call to `get_device` ensures
>   /// that the allocation remains valid at least until the matching call to `put_device`.
> 
> And:
> 
>   // SAFETY: Instances of `Device` are always reference-counted.
> 
> Ready for some analysis from this beginner?
> 
> Since this impl for Device is AlwaysRefCounted, when any references are
> taken i.e. in the Device::as_ref line above, inc_ref() is implicitly
> called to increase the refcount.  The same will be true of dec_ref()

No, inc_ref() is not called implicitly in Device::as_ref().

The thing that might "keep" the original `miscdevice::Device` alive is
the lifetime, since the returned `device::Device` reference has the
same life at the input parameter `miscdevice::Device` reference (i.e.
`&self`), so the returned reference cannot outlive `&self`. That means
if compilers find `&self` go out of scope while the returned reference
be still alive, it will report an error.

Regards,
Boqun

> once it goes out of scope.
> 
>   // SAFETY: Instances of `Device` are always reference-counted.
>   unsafe impl crate::types::AlwaysRefCounted for Device {
>       fn inc_ref(&self) {
>           // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
>           unsafe { bindings::get_device(self.as_raw()) };
>       }
> 
>       unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>           // SAFETY: The safety requirements guarantee that the refcount is non-zero.
>           unsafe { bindings::put_device(obj.cast().as_ptr()) }
>   }
> 
> -- 
> Lee Jones [李琼斯]

