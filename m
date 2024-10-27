Return-Path: <linux-kernel+bounces-383857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0BA9B2101
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF51C20C87
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA811885BE;
	Sun, 27 Oct 2024 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K59S0Lsa"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007618EBF;
	Sun, 27 Oct 2024 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730067609; cv=none; b=QC/V6rVdNgrtTyhCjDE5ysKF64z3tvAA5+trgTLQDx5+NCWyJbts0l+qatdBUfe1tmDeaVmOTrIVXPfbBcyAji/i2o4jSOLUxxxS6p2Ur7HgBRvuhes8jovu0ZCRgutCIol4CCODKUb0A/xZhfj8+bIlO1hJBsM5J3l22q5yLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730067609; c=relaxed/simple;
	bh=D2fzt15oN40rPfOx05cCSxCIdosrthcOMzQY+rwabv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szVzX79BsI7M7zAU4ypbkKy2iZ6Z4pm5vIQTodLptq6W/QoSBYvNbhY9rNByzaEa7AET+E2Pj6WFTygL+rOQ0SUafu6ET11dALisDW8kqTqPc/QgKuIp9AtGNI72Twd62gPufHku9MtTy14qL3b683YJXCb65ZvnERk0o8sWnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K59S0Lsa; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460c0f9c13eso32630071cf.0;
        Sun, 27 Oct 2024 15:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730067606; x=1730672406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DWIM30hSmiFkVWlDf1md4/nYtdvjo5qOjKey5YjI/w=;
        b=K59S0LsaJctHG2Z4mO7ojeMJmna1nV1FCV2Da60vSN3+DbCv6pZ0nNsw126XmrOx+3
         OdZg8znowepasWmPSkYAyjKaE8caFJinLtHpdIvD/f2qoB1DNc+nKr/U+xEnbvujXFTH
         wwDa6XWRqdpcoIXN39INnOQsEud2tXstG56qIwUQCX9iQPl5J9+7V3AMM8+4Uw5160bz
         rc0IerYyBmPdf8AZFILM/tmU/8+guVLD6OpKRzoM9q5WZADMFmd7/r3oXDZjaS1cYjct
         o9yfRZnu8QMXCIxKrh1bjgugAYBfBRuPoYWawUQTP2d1ZBZbGhqm8SS5TGI0x2MdELTJ
         l7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730067606; x=1730672406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DWIM30hSmiFkVWlDf1md4/nYtdvjo5qOjKey5YjI/w=;
        b=B3NcSGURLTG5rVkUFdtdP2W7PYWiJYK78sfQDtp/rEgrcgLSQqHMm9Qa1EJjCy2MSd
         bJYqcU98klj7AOM1Hx3ambQh+68D7tr+NVC9P8KujWkevNmMsKSAqRBxQr7U96aEHptB
         95XuIEipi21NY7FKJNaXLiIIaSFqVUIrsdK9AL6fV0P5iUfK9qMRl/PGyCKMYdKIG8U2
         VovoWAGpxavhngEfejm6nSMXkQeoW+EYHvg11RaasEU+7UnDNPz/0e8xUwx0ETEEIwe1
         M2T2Y0SOIKhRuAub1WljTuqu3yIBFkSncp1L7HguB4nsgTEMOaBIueeyu2ivHPWiYGt7
         Ywdw==
X-Forwarded-Encrypted: i=1; AJvYcCUdZl/GS9pYAT7fshDZRXI6MtyVj0c74tPCdFahjH3yvGtDJdDZXpZFN9a5B3scgL6pyGxlyCD5nXcbqwo=@vger.kernel.org, AJvYcCV2s7JURfX9xmU53KSPGlfu/Gg9/gS9KFFX9Xj61H2Iig+FB5Dhta473M/1DRMP48u7jmRNk1MJWash5qIz8RY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOZAMdJAa3ONyVnLARu9cGSky+OXQJT/Oh5KXO6u/5Lv2jm/7
	Q7lX6zxMri9baMDyU3qVTwoY+6MQOWxYmy/A/UMuA65EfMgR+Mpb
X-Google-Smtp-Source: AGHT+IEG1QvJ/g9ScTXJuJpuzLdjUd2+GPkNkIVDSjZVlb0UQBGYNwbT+U2Sbup1kXCuopmvWGhV7g==
X-Received: by 2002:ac8:5884:0:b0:45f:560:86de with SMTP id d75a77b69052e-4613b426930mr134001411cf.7.1730067606470;
        Sun, 27 Oct 2024 15:20:06 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613237f394sm28646771cf.65.2024.10.27.15.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 15:20:05 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id E414E1200043;
	Sun, 27 Oct 2024 18:20:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 27 Oct 2024 18:20:04 -0400
X-ME-Sender: <xms:lLweZzR3-Q1-vEia1n6vHmXRM15-iGZ0WbzpgVmFLFixZNqF7ubNKg>
    <xme:lLweZ0yVNli_wPGA5vRFfCaX-0h1L9kE2cvksjZWPL1m7t7CrraR6gDvH_k2ftMMP
    i0zXXPMjvpMCDj4dw>
X-ME-Received: <xmr:lLweZ40x0BpMDi9HcVdTZpyuowuDyB0QbSGigluX17JPq6CNAh_vFtpTf28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprggsughivghlrdhjrghnuhhlghhuvgesghhmrghilhdrtghomhdprhgtphht
    thhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegu
    rghkrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghirhhlihgvugesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhish
    esghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:lLweZzAzCbAZK5xk2FymnSrqpmniVkEdPFsj5frN-Uv20Z9GP9kZ5Q>
    <xmx:lLweZ8iva0SeRPQ2b1oH59RVoYwJTSJs5cLvcyrXjzfLtAiOnEOc6A>
    <xmx:lLweZ3okDt-wuNHsDY9PvS_F-PvPLhKSgxvJJwVEzoTHL59ccpMOLg>
    <xmx:lLweZ3i14IygYn5NbPlbFsG7qIO3_harNik7Mc18ljb2737jd_r3UA>
    <xmx:lLweZ_TgB0Iil_lIoa74CtCVnUUu8Nc5mR0dMxxJweYReMw0774oo4vH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Oct 2024 18:20:04 -0400 (EDT)
Date: Sun, 27 Oct 2024 15:20:03 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, aliceryhl@google.com,
	dakr@redhat.com, linux-kernel@vger.kernel.org, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 5/5] rust: firmware: implement `Ownable` for Firmware
Message-ID: <Zx68k94GrHb3Kz3-@Boquns-Mac-mini.local>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-6-abdiel.janulgue@gmail.com>
 <ZxjDUxUiKfE_7tvq@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxjDUxUiKfE_7tvq@pollux>

On Wed, Oct 23, 2024 at 11:35:15AM +0200, Danilo Krummrich wrote:
> On Wed, Oct 23, 2024 at 01:44:49AM +0300, Abdiel Janulgue wrote:
> > For consistency, wrap the firmware as an `Owned` smart pointer in the
> > constructor.
> > 
> > Cc: Danilo Krummrich <dakr@redhat.com>
> > Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > ---
> >  rust/kernel/firmware.rs | 31 ++++++++++++++++++-------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > index dee5b4b18aec..6da834b37455 100644
> > --- a/rust/kernel/firmware.rs
> > +++ b/rust/kernel/firmware.rs
> > @@ -4,8 +4,8 @@
> >  //!
> >  //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
> >  
> > -use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> > -use core::ptr::NonNull;
> > +use crate::{bindings, device::Device, error::Error, error::Result, str::CStr,
> > +            types::{Opaque, Owned, Ownable}};
> >  
> >  /// # Invariants
> >  ///
> > @@ -52,10 +52,11 @@ fn request_nowarn() -> Self {
> >  /// # Ok(())
> >  /// # }
> >  /// ```
> > -pub struct Firmware(NonNull<bindings::firmware>);
> > + #[repr(transparent)]
> > +pub struct Firmware(Opaque<bindings::firmware>);
> >  
> >  impl Firmware {
> > -    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> > +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Owned<Self>> {
> 
> I think it's fine to implement this for consistency, but I'm not sure I like
> that drivers have to refer to it as `Owned<Firmware>`.
> 

May I ask why not? ;-)

Ideally, we should not wrap a pointer to particular type, instead we
should wrap the type and then combine it with a meaningful pointer type,
e.g. Box<>, ARef<>, Owned<> ... in this way, we de-couple how the
lifetime of object is maintained (described by the pointer type) and
what operations are available on the object (described by the wrapper
type).

If later on, a firmware object creation is doable in pure Rust code for
some condition, we can then have a function that returns a
`KBox<Firmware>` (assume using kmalloc for the object), and it will just
work (tm).

Regards,
Boqun

> Anyway, if we keep it this way the patch also needs the following change.
> 
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index 6da834b37455..1db854eb2422 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -115,8 +115,8 @@ unsafe fn ptr_drop(ptr: *mut Self) {
> 
>  // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, which is safe to be used from
>  // any thread.
> -unsafe impl Send for Firmware {}
> +unsafe impl Send for Owned<Firmware> {}
> 
>  // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
>  // be used from any thread.
> -unsafe impl Sync for Firmware {}
> +unsafe impl Sync for Owned<Firmware> {}
> 
> >          let mut fw: *mut bindings::firmware = core::ptr::null_mut();
> >          let pfw: *mut *mut bindings::firmware = &mut fw;
> >  
> > @@ -65,25 +66,26 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> >          if ret != 0 {
> >              return Err(Error::from_errno(ret));
> >          }
> > -
> > +        // CAST: Self` is a `repr(transparent)` wrapper around `bindings::firmware`.
> > +        let ptr = fw.cast::<Self>();
> >          // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
> >          // valid pointer to `bindings::firmware`.
> > -        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> > +        Ok(unsafe { Owned::to_owned(ptr) })
> >      }
> >  
> >      /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> > -    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> > +    pub fn request(name: &CStr, dev: &Device) -> Result<Owned<Self>> {
> >          Self::request_internal(name, dev, FwFunc::request())
> >      }
> >  
> >      /// Send a request for an optional firmware module. See also
> >      /// `bindings::firmware_request_nowarn`.
> > -    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> > +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Owned<Self>> {
> >          Self::request_internal(name, dev, FwFunc::request_nowarn())
> >      }
> >  
> >      fn as_raw(&self) -> *mut bindings::firmware {
> > -        self.0.as_ptr()
> > +        self.0.get()
> >      }
> >  
> >      /// Returns the size of the requested firmware in bytes.
> > @@ -101,10 +103,13 @@ pub fn data(&self) -> &[u8] {
> >      }
> >  }
> >  
> > -impl Drop for Firmware {
> > -    fn drop(&mut self) {
> > -        // SAFETY: `self.as_raw()` is valid by the type invariant.
> > -        unsafe { bindings::release_firmware(self.as_raw()) };
> > +unsafe impl Ownable for Firmware {
> > +    unsafe fn ptr_drop(ptr: *mut Self) {
> > +        // SAFETY:
> > +        // - By the type invariants, we have ownership of the ptr and can free it.
> > +        // - Per function safety, this is called in Owned::drop(), so `ptr` is a
> > +        //   unique pointer to object, it's safe to release the firmware.
> > +        unsafe { bindings::release_firmware(ptr.cast()) };
> >      }
> >  }
> >  
> > -- 
> > 2.43.0
> > 
> 

