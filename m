Return-Path: <linux-kernel+bounces-244227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230192A12B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E0D283C1B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEE67E107;
	Mon,  8 Jul 2024 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhM/1KHn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C57D41C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720438130; cv=none; b=Xz3NZzNMEHKNKoqbqLwOyTFP0NLADHpQppYqUbaTE/xYxC9/DDQbUT9knXxBYKXjC9rmv/aqBX23Sq/nAgdfTTxFu5Has+so2YSbUgQqW6PAZReW2nF4kezBYaWkyGbrDtrqy/irfAtIcwg4vxdWJMjUDyUWRtqYPOY1oT7E+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720438130; c=relaxed/simple;
	bh=YLEz2nxMe8+wpWlmygRPdtARH+mr6uUxXFx2jMYYd8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSfNah5mT9seN5h02KLmhqEsmlxdhui05JvNqVIeh7KU7dUaNimo3A+VWE8XGS5xn+45i50LUd/uEWg00+lTQnzBRLrLEad50y+JfrEcNeXWUPdsZJE/KvnYIJA+vNnLiEGI4Y/HABY57xtjc7F1spkVXlaIqVwbq2kOaxYzOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhM/1KHn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720438127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggF5ejO/txQzvQN281lQIDXsDHvIvFc8LKda5u6H7Cw=;
	b=BhM/1KHnvmuLy8fe5dh1RNe152bGZvExkY9PLV3vQZMWTinbrpCV2xhu4ntXTMZGVSZwQQ
	b7Yl5QhGJIB8RoWuC7eu0rejQCq7t72/154njQTnGt+KJ8sPznQvfmDPkkHykVjGdYkPaw
	DShNMppb9dNcvKEQb3Mp2yEX0aWPWp0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-u5lednAiOKGbl4Nt9_EeiQ-1; Mon, 08 Jul 2024 07:28:46 -0400
X-MC-Unique: u5lednAiOKGbl4Nt9_EeiQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ee864483c2so36051501fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 04:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720438125; x=1721042925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggF5ejO/txQzvQN281lQIDXsDHvIvFc8LKda5u6H7Cw=;
        b=UPABNMM/3fUJXi3gYUYLuTFQ9tSf5KxZRWLGlF7aiJEQOuSt01mtADiwNMRSzsQqgh
         o2BVqpi4hdynVDIhQ8T6WjYEHvoDYc8rdcLbN2sr7yQZyipNeTUWhxMzfgLuaRjSYd23
         aNdFfitm0e1549JyVIlzM0XSkp2lXTwawvb9OsynOpaRgRxFWdMpjm/LPqeDNEhL9VBq
         2g5+lwH74SYQk/kQxWukeMEzDeiq89e262VB7w1sDQtV1g/Hm8of1FJx3kZmRggFDg2M
         eBk6n4ea+fYLzfYEC4pCwkp9r2xAvbBLeUJNohswWYWmDetShIK1RiTcz0MQ6QAANmSA
         ZKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVutuZw/yD4fcxX0zwRmDyh92WIzGcaiT00dhNNt5xX55OjMbdqfVk0AY+OLakYowedUmn+2YaImv2gat2TsAG1KlgX3aD7DSiJ0AGs
X-Gm-Message-State: AOJu0YxtztRChzTj+UOyZxEdLLqPHlj3Lj9JpZdtLU61t5Y+jA9L2ttx
	FK7CUkEvTC5WeVDLtRKSrgygiEVKLdMUGuCJ2pUV1hmxHuua30laV2PxggE7z8STQblRM48nrla
	uO55/HGrsQlTplzFje0yuohzpJzfX5IZYArKsys2yjl/PHNrPAoczyLYgqJGrBw==
X-Received: by 2002:a2e:818d:0:b0:2ee:8777:f86b with SMTP id 38308e7fff4ca-2ee8edd3edbmr75131741fa.35.1720438124879;
        Mon, 08 Jul 2024 04:28:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH1Nsdje5001n1qOWAw4XX9RASw+K0ZvlbBfsk3SL/6HvLcu8zL4MIKOBiacj2ApWr0nCz3Q==
X-Received: by 2002:a2e:818d:0:b0:2ee:8777:f86b with SMTP id 38308e7fff4ca-2ee8edd3edbmr75131551fa.35.1720438124455;
        Mon, 08 Jul 2024 04:28:44 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2518f9sm162467895e9.31.2024.07.08.04.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:28:44 -0700 (PDT)
Date: Mon, 8 Jul 2024 13:28:42 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH 2/2] firmware_loader: fix soundness issue in
 `request_internal`
Message-ID: <ZovNap1NBusREw_-@pollux>
References: <20240707003835.69090-1-dakr@redhat.com>
 <20240707003835.69090-2-dakr@redhat.com>
 <dd56a9d9-08fe-4bd4-83e2-dfdc44f8c637@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd56a9d9-08fe-4bd4-83e2-dfdc44f8c637@gmail.com>

On Sun, Jul 07, 2024 at 10:57:31PM +0200, Christian Schrefl wrote:
> Greetings.
> 
> On 07.07.24 2:38 AM, Danilo Krummrich wrote:
> > `request_internal` must be called with one of the following function
> > pointers: request_firmware(), firmware_request_nowarn(),
> > firmware_request_platform() or request_firmware_direct().
> > 
> > The previous `FwFunc` alias did not guarantee this, which is unsound.
> > 
> > In order to fix this up, implement `FwFunc` as new type with a
> > corresponding type invariant and unsafe `new` function.
> > 
> > Reported-by: Gary Guo <gary@garyguo.net>
> > Closes: https://lore.kernel.org/lkml/20240620143611.7995e0bb@eugeo/
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  rust/kernel/firmware.rs | 32 ++++++++++++++++++++++++++------
> >  1 file changed, 26 insertions(+), 6 deletions(-)
> > 
> > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > index 106a928a535e..d765ecc85d38 100644
> > --- a/rust/kernel/firmware.rs
> > +++ b/rust/kernel/firmware.rs
> > @@ -7,11 +7,24 @@
> >  use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> >  use core::ptr::NonNull;
> >  
> > -// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> > -// `firmware_request_platform`, `bindings::request_firmware_direct`
> > -type FwFunc =
> > +type RawFwFunc =
> >      unsafe extern "C" fn(*mut *const bindings::firmware, *const i8, *mut bindings::device) -> i32;
> >  
> > +/// # Invariants
> > +///
> > +/// One of the following: `bindings::request_firmware`, `bindings::firmware_request_nowarn`,
> > +/// `firmware_request_platform`, `bindings::request_firmware_direct`
> > +struct FwFunc(RawFwFunc);
> > +
> > +impl FwFunc {
> > +    /// # Safety
> > +    ///
> > +    /// Must be one of the functions listed in the type invariants.
> > +    unsafe fn from_raw(func: RawFwFunc) -> Self {
> > +        Self(func)
> > +    }
> Why not write methods that construct each possible FwFunc?

Thanks, this is a good idea indeed, will send a v2.

> That way the code that needs to know abut this invariant is only inside a single impl block.
> Something like:
> impl FwFunc {
>     fn request_firmware() -> Self {
>         // # Safety
>         // As per the Type Invariant `bindings::request_firmware` is a valid vaule.
>     	FwFunc(bindings::request_firmware)
>     }
> }
> 
> > +}
> > +
> >  /// Abstraction around a C `struct firmware`.
> >  ///
> >  /// This is a simple abstraction around the C firmware API. Just like with the C API, firmware can
> > @@ -48,7 +61,7 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> >  
> >          // SAFETY: `pfw` is a valid pointer to a NULL initialized `bindings::firmware` pointer.
> >          // `name` and `dev` are valid as by their type invariants.
> > -        let ret = unsafe { func(pfw as _, name.as_char_ptr(), dev.as_raw()) };
> > +        let ret = unsafe { func.0(pfw as _, name.as_char_ptr(), dev.as_raw()) };
> >          if ret != 0 {
> >              return Err(Error::from_errno(ret));
> >          }
> > @@ -60,13 +73,20 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> >  
> >      /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> >      pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> > -        Self::request_internal(name, dev, bindings::request_firmware)
> > +        // SAFETY: `bindings::request_firmware` is valid by the safety requirement of `FwFunc`.
> > +        let func = unsafe { FwFunc::from_raw(bindings::request_firmware) };
> > +
> > +        Self::request_internal(name, dev, func)
> >      }
> >  
> >      /// Send a request for an optional firmware module. See also
> >      /// `bindings::firmware_request_nowarn`.
> >      pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> > -        Self::request_internal(name, dev, bindings::firmware_request_nowarn)
> > +        // SAFETY: `bindings::firmware_request_nowarn` is valid by the safety requirement of
> > +        // `FwFunc::new`.
> > +        let func = unsafe { FwFunc::from_raw(bindings::firmware_request_nowarn) };
> > +
> > +        Self::request_internal(name, dev, func)
> >      }
> >  
> >      fn as_raw(&self) -> *mut bindings::firmware {
> 
> Cheers,
> Christian
> 


