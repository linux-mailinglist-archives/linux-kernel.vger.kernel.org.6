Return-Path: <linux-kernel+bounces-218411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E254C90BF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49433282EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 23:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7A1993AF;
	Mon, 17 Jun 2024 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP1aDvet"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82AB176AB9;
	Mon, 17 Jun 2024 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665242; cv=none; b=mOj1j/mwgo3EZLIHAPkR0nOXVXVZfgjv6sfwrq7vr/ZcRSlsK0M0K0/3ib+MvNxJbDWJugE9z9tE8fXnlcm2U3QaSBgz8wjOlcfsSvpJjbeuDf+2EO92Q9oA2D+fkIf3AOzYHjO8l8jZAk9E1JoYQxO6CZVjzq7Q8pEAhHHkET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665242; c=relaxed/simple;
	bh=52r+VNqOk9r6XHmWBmXIK85jU/dlGwP5kIbt3ewVgbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsIk8MkagHvtIqc/YoGkyI/2PgmSgC7ovg3JH/E1xDdcWYoaBDut3wzRvGxDgsi0CYoimRM8FcQl2ArAll/Lw/Rw/OmYWe6uYkx52JrUwNGyjCR+C63CZxEmSOUsg1VQmoVwNgPayaDTOKeuxbXBv1mkvqyKAx+GE56HNlOcBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aP1aDvet; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3cabac56b38so2877519b6e.3;
        Mon, 17 Jun 2024 16:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718665240; x=1719270040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIBZAAcfSWPqpyj4PFwTMWJwKxylSVJ2lDhErArdxhY=;
        b=aP1aDveteU8CJt60scXcrpnGk5+ikAn80kwtCOz8TDkhKiGYIHJUjTO0nzNe3fMW7C
         M1UcceFSF/hQPY3qH2F0Y5kAaVY6QI32Qo12u87JV3iz5uRidiNvbxice0dgbACjy2gY
         dJBPqJiLtlBS2OJp0FjEo71BRZHSPH1W6PoWAkstvtyatR1vDzGMJnDiIh0WkN+8WDq4
         QjNATX0bcflWxr/kDrOO+ziPL67OMTB4JnDZgMqIUzy2H3Mk0hmHfuT/RXZvZgIiKteM
         2aLjRGkb30j8eKMzJbdYzGA9ze8METZ2WnJQsZ1ZxF1cnsImN/PAoel52aXT4oGtYNrw
         n8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665240; x=1719270040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIBZAAcfSWPqpyj4PFwTMWJwKxylSVJ2lDhErArdxhY=;
        b=A7+ZV6V0imbe/kSMSH6ulXwkPi9iGWc5BWcHccpi4TrSddW1DYHKKPLQ11t2X+Twgs
         SJYgOyAcuY1M0j9M6YzMNPWghM/5P1dvz4AVxojmcjOIkjXtejMAlihdYo4Rf1NTiR66
         dD55FgCMXQHENdVjkVNuviVwj5oV5NCx90xX8N/6jfr2iIghDyntWRN3vO20cP5Aq4iG
         BTt7EE1FfstzeErufjOSNsdBWKksgEyF9c9/PalGhGFk7alvx9BiTljws2jz53lpClN0
         19VZR4R8SvkB9KDjipGdBcomi1CELOTqGp63UpTBpqsDGWf0eXcyPe7IoN21nWmgSwtX
         /lcg==
X-Forwarded-Encrypted: i=1; AJvYcCXJyFVcB59FtnS7IjcS3ua9OG4KUs4wXvUH6aKy3vM3moAhVApmtz5PppvlTp3M8oFP5joAlzc/KxASH3ryekI2/tZBLubr3Bxpw54G4qaMetXTJSAnDflGneV9dmddHV9UDffeDKu1dxphEUc=
X-Gm-Message-State: AOJu0YyiHq2o4vUTPLT5LJVr4Tf/BoCsWuLv8eJINlkNjNwMAE8wPw/H
	PWSsWcmY1wQgIkejbEP8dQgnRw3lOSgE5M/YdoGTs8eoYE5Vu3sq
X-Google-Smtp-Source: AGHT+IGUnvwFOHAhq49WQIixom92U9a3BTRySPv6Hko7y2YA97nL+Ra2Qk7gtctjI1kD7IqCjl/1DA==
X-Received: by 2002:a05:6808:1302:b0:3d2:2a0b:cf1b with SMTP id 5614622812f47-3d24e997b62mr14842708b6e.37.1718665238053;
        Mon, 17 Jun 2024 16:00:38 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc02e72sm469100885a.96.2024.06.17.16.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:00:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 3E8EA1200043;
	Mon, 17 Jun 2024 19:00:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 17 Jun 2024 19:00:36 -0400
X-ME-Sender: <xms:FMBwZu3QC7GAjQdCC7jBJbSaUrgVqROogRHyMW9nS_rJthYz9o3h9A>
    <xme:FMBwZhH_Lmj2yVDZfw_EOkLpBuS2H1NIUI7f30VlVsTzsOjrSPgzZ7RCaAzKuPuQM
    fgV86_-BkOvd1V7IA>
X-ME-Received: <xmr:FMBwZm44OG7oMttE7qx-M9Vxh7tjhb0apbjtnKtLX-HI5DrcU0mOAU2VlvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeelffektdeifefgkeffueeugeefhfevgfdutdeigfehgeejteeukeethedv
    keeuleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgrshgprhgrfidruggrthgrne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgv
X-ME-Proxy: <xmx:FMBwZv1G7h7VI3lrzxuszCoVTyjk-QyZtsqiWVzc8Hs27WXExVSgrA>
    <xmx:FMBwZhFMu1Iaqrok13nFNH2k673IRmHq4qd4U388c39NoaJgBjKkoA>
    <xmx:FMBwZo9Fqd5_3FKLf8vSH6klzhyCByjshfFbiLppM_dmW965_YEMWw>
    <xmx:FMBwZmmpAnfxtZkqynXoZ8nzcfVMTTpLpYqx1AiE1CvbEsU8pV9Y4w>
    <xmx:FMBwZpFE01M1zNtrzLJVp4eKthOwgiMDP4tp28gcuKFV_doonScv4Lqy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 19:00:35 -0400 (EDT)
Date: Mon, 17 Jun 2024 16:00:22 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org,
	russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: add firmware abstractions
Message-ID: <ZnDABsX7RmUvnKZf@boqun-archlinux>
References: <20240617203010.101452-1-dakr@redhat.com>
 <20240617203010.101452-3-dakr@redhat.com>
 <ZnCzLIly3DRK2eab@boqun-archlinux>
 <ZnC9xajuhN6nSQb-@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnC9xajuhN6nSQb-@cassiopeiae>

On Tue, Jun 18, 2024 at 12:50:45AM +0200, Danilo Krummrich wrote:
[...]
> >     /// A smart pointer owns the underlying data.
> >     pub struct Owned<T: Ownable> {
> >         ptr: NonNull<T>,
> >     }
> > 
> >     impl<T: Ownable> Owned<T> {
> >         /// # Safety
> > 	/// `ptr` needs to be a valid pointer, and it should be the
> > 	/// unique owner to the object, in other words, no one can touch
> > 	/// or free the underlying data.
> >         pub unsafe to_owned(ptr: *mut T) -> Self {
> > 	    // SAFETY: Per function safety requirement.
> > 	    Self { ptr: unsafe { NonNull::new_unchecked(ptr) } }
> > 	}
> > 
> > 	/// other safe constructors are available if a initializer (impl
> > 	/// Init) is provided
> >     }
> > 
> >     /// A Ownable type is a type that can be put into `Owned<T>`, and
> >     /// when `Owned<T>` drops, `ptr_drop` will be called.
> >     pub unsafe trait Ownable {
> >         /// # Safety
> > 	/// This could only be called in the `Owned::drop` function.
> >         unsafe fn ptr_drop(ptr: *mut Self);
> >     }
> > 
> >     impl<T: Ownable> Drop for Owned<T> {
> >         fn drop(&mut self) {
> > 	    /// SAFETY: In Owned<T>::drop.
> > 	    unsafe {
> > 	        <T as Ownable>::ptr_drop(self.as_mut_ptr());
> > 	    }
> > 	}
> >     }
> > 
> > we can implement Deref and DerefMut easily on `Owned<T>`. And then we
> > could define Firmware as
> > 
> >     #[repr(transparent)]
> >     pub struct Firmware(Opaque<bindings::firmware>);
> > 
> > and
> > 
> >     unsafe impl Ownable for Firmware {
> >         unsafe fn ptr_drop(ptr: *mut Self) {
> > 	    // SAFETY: Per function safety, this is called in
> > 	    // Owned::drop(), so `ptr` is a unique pointer to object,
> > 	    // it's safe to release the firmware.
> >             unsafe { bindings::release_firmware(ptr.cast()); }
> >         }
> >     }
> > 
> > and the request_*() will return a `Result<Owned<Self>>`. 
> > 
> > Alice mentioned the need of this in page as well:
> > 
> > 	https://lore.kernel.org/rust-for-linux/CAH5fLgjrt0Ohj1qBv=GrqZumBTMQ1jbsKakChmxmG2JYDJEM8w@mail.gmail.com		
> 
> I think in the `Page` case this is useful to create `Page` references from
> previously allocated memory.
> 
> In the case of `Firmware`, I agree it makes sense to use it once we have it,
> but other than for consistency, is there any advantage?
> 

To help people build future abstraction easier (and make review easier
as well). But I'm also waiting for a third use case, yes, I usually
wait for 3 cases to begin thinking about generalization ;-)

> > 
> > Just bring it up while we are (maybe not? ;-)) at it. Also I would like
> > to hear whether this would work for Firmware in the longer-term ;-) But
> > yes, I'm not that worried about merging it as it is if others are all
> > OK.
> 
> I think there's not too much to add here in the future, once we got an allocator
> API (I should get back to that soon), I want to add a method that copies the
> data to a new buffer allocated with a given allocator. And maybe we want to
> support a few other request_firmware_* functions in the future, but none of that
> should require the above abstraction.
> 

Thank you!

> > 
> > > +impl Firmware {
> > > +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> > > +        let mut fw: *mut bindings::firmware = core::ptr::null_mut();
> > > +        let pfw: *mut *mut bindings::firmware = &mut fw;
> > > +
> > > +        // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
> > > +        // `name` and `dev` are valid as by their type invariants.
> > > +        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
> > > +        if ret != 0 {
> > > +            return Err(Error::from_errno(ret));
> > > +        }
> > > +
> > > +        // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
> > > +        // valid pointer to `bindings::firmware`.
> > > +        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> > > +    }
> > > +
> > > +    /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> > > +    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> > > +        Self::request_internal(name, dev, bindings::request_firmware)
> > > +    }
> > > +
> > > +    /// Send a request for an optional firmware module. See also
> > > +    /// `bindings::firmware_request_nowarn`.
> > > +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> > > +        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
> > > +    }
> > > +
> > > +    fn as_raw(&self) -> *mut bindings::firmware {
> > > +        self.0.as_ptr()
> > > +    }
> > > +
> > > +    /// Returns the size of the requested firmware in bytes.
> > > +    pub fn size(&self) -> usize {
> > > +        // SAFETY: Safe by the type invariant.
> > > +        unsafe { (*self.as_raw()).size }
> > > +    }
> > > +
> > > +    /// Returns the requested firmware as `&[u8]`.
> > > +    pub fn data(&self) -> &[u8] {
> > > +        // SAFETY: Safe by the type invariant. Additionally, `bindings::firmware` guarantees, if
> > 
> > Does this "Safe by the type invariant" also covers the following safe
> > requirement of `from_raw_parts`?
> > 
> > 	The memory referenced by the returned slice must not be mutated for the duration of lifetime 'a, except inside an UnsafeCell.
> > 
> > in that `&[u8]` has the same lifetime as `&self`, and as long as
> > `&self` exists, no function can touch the inner `data`? If so, I
> > probably want to call this out.
> 
> Yes, nothing should ever modify the firmware buffer after it has been requested
> successfully. I can add this to the type invariant.
> 

Oh, you have an even easier (stronger) type invariant. Yes, please add
it and use it here. Thanks!

Regards,
Boqun

> > 
> > Regards,
> > Boqun
> > 
> > > +        // successfully requested, that `bindings::firmware::data` has a size of
> > > +        // `bindings::firmware::size` bytes.
> > > +        unsafe { core::slice::from_raw_parts((*self.as_raw()).data, self.size()) }
> > > +    }
> > > +}
> > > +
> > > +impl Drop for Firmware {
> > > +    fn drop(&mut self) {
> > > +        // SAFETY: Safe by the type invariant.
> > > +        unsafe { bindings::release_firmware(self.as_raw()) };
> > > +    }
> > > +}
> > > +
> > > +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, which is safe to be used from
> > > +// any thread.
> > > +unsafe impl Send for Firmware {}
> > > +
> > > +// SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
> > > +// be used from any thread.
> > > +unsafe impl Sync for Firmware {}
> > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > index dd1207f1a873..7707cb013ce9 100644
> > > --- a/rust/kernel/lib.rs
> > > +++ b/rust/kernel/lib.rs
> > > @@ -30,6 +30,8 @@
> > >  mod build_assert;
> > >  pub mod device;
> > >  pub mod error;
> > > +#[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
> > > +pub mod firmware;
> > >  pub mod init;
> > >  pub mod ioctl;
> > >  #[cfg(CONFIG_KUNIT)]
> > > -- 
> > > 2.45.1
> > > 
> > 
> 

