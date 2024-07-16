Return-Path: <linux-kernel+bounces-253548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772D9322CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B987B22EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BAA196D8F;
	Tue, 16 Jul 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fMWpcdC2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437C195FE3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121931; cv=none; b=bdB2WfSLAZrQFKXOvXJX2P8YHPK3oMrSfNsB8Hw08C1MwL1FJ9OASZdh/oTvgogPxSzDyUJLd3PUX/Fzx3dGupi4MCgabA6Z0xgs0j6O/yTACWhJzszsmmBrkPXJC6+en4C9KBIrUTKGEM/IvvLkEZ0tOqJkHry37MZaRlldE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121931; c=relaxed/simple;
	bh=N5yTNttJ311Vt/2wANWpnoTPIiRTEBk6Ti979TJPBHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMdwXB3f2xO9viIhVvSlwFmhrfkRlqVDa3JO9r5KmPx5/lWSPtJBek2sisduN4gVTKEH7idyZQc/L+c6yc90g+fPBnR04kCdH2CxZhBRKqFP8mnlSX2a97ZSoY3JC0bIqUQF1zxv9kFhy8OU3Y89DRnHD/R8ciBygeMsN6zWoNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=fMWpcdC2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42671c659e4so4587225e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721121927; x=1721726727; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAjijZ3Ouy+myoSPyM0kcvwYwcmbq9gcUJaNSuUkTuU=;
        b=fMWpcdC2r7SNxIpQma0kVtUWL9vNTMeHj4aHi5hNBdpYCqJWw3w+/g9VZVCnGeEUUa
         jOmDpEiG56D8VsrHHRY+CoNxfz6dsNduYVi5ntCyy80P6vyfnuqUsk7uibIyvIYoJvVm
         XAbUVCohZZdaizQDyMmor6rrRYgJPt/4ZxuEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721121927; x=1721726727;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAjijZ3Ouy+myoSPyM0kcvwYwcmbq9gcUJaNSuUkTuU=;
        b=QruUq0/sgC5n7CNCRIXwlwfuYstNC1hg9Rh4k5wkj2nz+v15NSdf4c0G18EYu7bFKa
         bm8EI2LTjsGGdShSVvZa03VyhfaJ99YJ0aA4wI5mawub8gQBtWt9wkfd8C/A8Ds0/007
         QzS8AZWbOYfVrb/Fqxl8+6D7/alV2EEEKWZje+eoolWs2LE5cH7Js6DXCv3NDVeDBeTc
         kVI4r81vx4ihAbD9XGi8vbHVbOXHH2HyV+vDAE/r9ORuXcTBmqvX+40WqTPvX7PC17lD
         6uRVCqRAjyDUSGLQJ/juYA7Ta72bB9wJfKPtc6dlAvrxTrS+JFvm/U/yjL3VTLZdi3l7
         6zTA==
X-Forwarded-Encrypted: i=1; AJvYcCWNSoNKtHAgcV25RlqYPbLPSPEuRenuDO/Df/POXojYQoQJLm7cUooM/pSuIE1EQx/5JI5ydrGSgp2Do7D5ZwXfDMQY9Cz4ZB57aT3q
X-Gm-Message-State: AOJu0YyuT0hSNJczVb1FddGVRUA2ARlvrKjVhb+LbtkFa8KxAZ6PYhrF
	p/jYHFIkKeMADUCuerGnrdLWuVttsbSlTPj8IiVrNsL9z4fPRD2Mgtu/QPpTFAE=
X-Google-Smtp-Source: AGHT+IFGay76S/3XJ06wP8GTTOttfNCnYDciDC1gYt+NRZJcRu6rSafrrt9JDknFijALbCOHSZVL+A==
X-Received: by 2002:a05:600c:46d5:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-427b8a40e58mr9435005e9.3.1721121927154;
        Tue, 16 Jul 2024 02:25:27 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f27877dsm148597605e9.26.2024.07.16.02.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:25:26 -0700 (PDT)
Date: Tue, 16 Jul 2024 11:25:24 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	Danilo Krummrich <dakr@redhat.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>, ojeda@kernel.org,
	lyude@redhat.com, robh@kernel.org, lina@asahilina.net,
	mcanal@igalia.com, airlied@gmail.com,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
Message-ID: <ZpY8hI6nJyubiR3s@phenom.ffwll.local>
Mail-Followup-To: Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>, ojeda@kernel.org,
	lyude@redhat.com, robh@kernel.org, lina@asahilina.net,
	mcanal@igalia.com, airlied@gmail.com,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <d7719653-f270-493d-ac42-6a1291eb7dc0@redhat.com>
 <ZpTl-uUbzmvHGMEH@phenom.ffwll.local>
 <89FFB898-120A-431E-9B18-4D08AFAEFBFD@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89FFB898-120A-431E-9B18-4D08AFAEFBFD@collabora.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Mon, Jul 15, 2024 at 02:05:49PM -0300, Daniel Almeida wrote:
> Hi Sima!
> 
> 
> > 
> > Yeah I'm not sure a partially converted driver where the main driver is
> > still C really works, that pretty much has to throw out all the type
> > safety in the interfaces.
> > 
> > What I think might work is if such partial drivers register as full rust
> > drivers, and then largely delegate the implementation to their existing C
> > code with a big "safety: trust me, the C side is bug free" comment since
> > it's all going to be unsafe :-)
> > 
> > It would still be a big change, since all the driver's callbacks need to
> > switch from container_of to upcast to their driver structure to some small
> > rust shim (most likely, I didn't try this out) to get at the driver parts
> > on the C side. And I think you also need a small function to downcast to
> > the drm base class. But that should be all largely mechanical.
> > 
> > More freely allowing to mix&match is imo going to be endless pains. We
> > kinda tried that with the atomic conversion helpers for legacy kms
> > drivers, and the impendance mismatch was just endless amounts of very
> > subtle pain. Rust will exacerbate this, because it encodes semantics into
> > the types and interfaces. And that was with just one set of helpers, for
> > rust we'll likely need a custom one for each driver that's partially
> > written in rust.
> > -Sima
> > 
> 
> I humbly disagree here.
> 
> I know this is a bit tangential, but earlier this year I converted a
> bunch of codec libraries to Rust in v4l2. That worked just fine with the
> C codec drivers. There were no regressions as per our test tools.
> 
> The main idea is that you isolate all unsafety to a single point: so
> long as the C code upholds the safety guarantees when calling into Rust,
> the Rust layer will be safe. This is just the same logic used in unsafe
> blocks in Rust itself, nothing new really.
> 
> This is not unlike what is going on here, for example:
> 
> 
> ```
> +unsafe extern "C" fn open_callback<T: BaseDriverObject<U>, U: BaseObject>(
> + raw_obj: *mut bindings::drm_gem_object,
> + raw_file: *mut bindings::drm_file,
> +) -> core::ffi::c_int {
> + // SAFETY: The pointer we got has to be valid.
> + let file = unsafe {
> + file::File::<<<U as IntoGEMObject>::Driver as drv::Driver>::File>::from_raw(raw_file)
> + };
> + let obj =
> + <<<U as IntoGEMObject>::Driver as drv::Driver>::Object as IntoGEMObject>::from_gem_obj(
> + raw_obj,
> + );
> +
> + // SAFETY: from_gem_obj() returns a valid pointer as long as the type is
> + // correct and the raw_obj we got is valid.
> + match T::open(unsafe { &*obj }, &file) {
> + Err(e) => e.to_errno(),
> + Ok(()) => 0,
> + }
> +}
> ```
> 
> We have to trust that the kernel is passing in a valid pointer. By the same token, we can choose to trust drivers if we so desire.
> 
> > that pretty much has to throw out all the type
> > safety in the interfaces.
> 
> Can you expand on that?

Essentially what you've run into, in a pure rust driver we assume that
everything is living in the rust world. In a partial conversion you might
want to freely convert GEMObject back&forth, but everything else
(drm_file, drm_device, ...) is still living in the pure C world. I think
there's roughly three solutions to this:

- we allow this on the rust side, but that means the associated
  types/generics go away. We drop a lot of enforced type safety for pure
  rust drivers.

- we don't allow this. Your mixed driver is screwed.

- we allow this for specific functions, with a pinky finger promise that
  those rust functions will not look at any of the associated types. From
  my experience these kind of in-between worlds functions are really
  brittle and a pain, e.g. rust-native driver people might accidentally
  change the code to again assume a drv::Driver exists, or people don't
  want to touch the code because it's too risky, or we're forced to
  implement stuff in C instead of rust more than necessary.
 
> In particular, I believe that we should ideally be able to convert from
> a C "struct Foo * " to a Rust “FooRef" for types whose lifetimes are
> managed either by the kernel itself or by a C driver. In practical
> terms, this has run into the issues we’ve been discussing in this
> thread, but there may be solutions e.g.:
> 
> > One thing that comes to my mindis , you could probably create some driver specific
> > "dummy" types to satisfy the type generics of the types you want to use. Not sure
> > how well this works out though.
> 
> I haven’t thought of anything yet - which is why I haven’t replied.
> OTOH, IIRC, Faith seems to have something in mind that can work with the
> current abstractions, so I am waiting on her reply.

This might work, but I see issue here anywhere where the rust abstraction
adds a few things of its own to the rust side type, and not just a type
abstraction that compiles completely away and you're only left with the C
struct in the compiled code. And at least for kms some of the ideas we've
tossed around will do this. And once we have that, any dummy types we
invent to pretend-wrap the pure C types for rust will be just plain wrong.

And then you have the brittleness of that mixed world approach, which I
don't think will end well.

> > What I think might work is if such partial drivers register as full rust
> > drivers, and then largely delegate the implementation to their existing C
> > code with a big "safety: trust me, the C side is bug free" comment since
> > it's all going to be unsafe :-)
> 
> > with a big "safety: trust me, the C side is bug free" comment since it's all going to be unsafe :-)
> 
> This is what I want too :) but I can’t see how your proposed approach is
> better, at least at a cursory glance. It is a much bigger change,
> though, which is a clear drawback.
>
> > And that was with just one set of helpers, for
> > rust we'll likely need a custom one for each driver that's partially
> > written in rust.
> 
> That’s exactly what I am trying to avoid. In other words, I want to find
> a way to use the same abstractions and the same APIs so that we do not
> run precisely into that problem.

So an idea that just crossed my mind how we can do the 3rd option at least
somewhat cleanly:

- we limit this to thin rust wrappers around C functions, where it's
  really obvious there's no assumptions that any of the other rust
  abstractions are used.

- we add a new MixedGEMObject, which ditches all the type safety stuff and
  associated types, and use that for these limited wrappers. Those are
  obviously convertible between C and rust side in both directions,
  allowing mixed driver code to use them.

- these MixedGEMObject types also ensure that the rust wrappers cannot
  make assumptions about what the other driver structures are, so we
  enlist the compiler to help us catch issues.

- to avoid having to duplicate all these functions, we can toss in a Deref
  trait so that you can use an IntoGEMObject instead with these functions,
  meaning you can seamlessly coerce from the pure rust driver to the mixed
  driver types, but not the other way round.

This still means that eventually you need to do the big jump and switch
over the main driver/device to rust, but you can start out with little
pieces here&there. And that existing driver rust code should not need any
change when you do the big switch.

And on the safety side we also don't make any compromises, pure rust
drivers still can use all the type constraints that make sense to enforce
api rules. And mixed drivers wont accidentally call into rust code that
doesn't cope with the mixed world.

Mixed drivers still rely on "trust me, these types match" internally, but
there's really nothing we can do about that. Unless you do a full
conversion, in which case the rust abstractions provide that guarantee.

And with the Deref it also should not make the pure rust driver
abstraction more verbose or have any other impact on them.

Entirely untested, so might be complete nonsense :-)

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

