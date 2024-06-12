Return-Path: <linux-kernel+bounces-212248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62779905D46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4429B2292B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D1B85628;
	Wed, 12 Jun 2024 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIiDW9Q2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B390184A56
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225813; cv=none; b=LVaxZlXrXarjoBqcXEHOmyj2WFRQgAquqdQPzgfXpilk4ZziB0LJy7jxWkqtfFJzbCH3/mXqGm85UsS4Es9xEu/woTlAvhr0I3j6YLvqNZdg39fXLrdIWTMX+4Hxr5LUQO9T8eOiHaYCZSCki9oqgEkiUS567QTmn1u+XM4avwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225813; c=relaxed/simple;
	bh=IQd6EhwmkUzec/hTr5a0ftQ5MnlMNMSzRRLG53Sw3/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+xZgfrTV2+Zd5LWhaS/3Nf6jX3Ocrji8Mxe+12Vzrt5p5lGUX6fIGPc65rtrKt4I4GIUzPnw9qkJjQgM/2LbmDTQLADl6MNOaIo4tAtu6l7xCYnTBDwwp2Vmp+RC4K/yBAGgcQZ6cWuZknwEAO4yLRl/ra19ZmlDP4tWiQ5jjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIiDW9Q2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718225810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CjW6MuaeMCxR+zqk4ndNFKQwjLEZaxytJOm9txhJ9CU=;
	b=RIiDW9Q240cncGpBOi7rPaZqYOYINkG/J4Vy8DHBXMh6PcjuBi1tk9vBDLY5W3lTTXVnba
	5uNtnf2556dUgR5J+MuzVwtIugD0fkoMGnS4ook9BlAJzNsYP3sn+H5JuyF6ISVJuN+EV9
	RjnypcfyCz7s5h0Z8dqAk1yDv+vRE84=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-oKwHQ5UCOSSCJQXcqf6tow-1; Wed, 12 Jun 2024 16:56:47 -0400
X-MC-Unique: oKwHQ5UCOSSCJQXcqf6tow-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35f1fcd3bbcso177152f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225806; x=1718830606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjW6MuaeMCxR+zqk4ndNFKQwjLEZaxytJOm9txhJ9CU=;
        b=GlqoQ6AGsGhJrZPegvvKMXYrMwoGw81fMJ1PlIWxRsFZkT9pjux8Og8aVKa4b1SScp
         EsRjurE9eeTqzAIN7jn0y6tiTeu/kW/ZG95H7KgboEhDPEWMKa4OHLeN75tnKOXI4iod
         XUh+hrpSGBH4D289YTmO+s+fyQZT7T+Dh602fAp4BLxy+TJyyEOcY9Fw5zIqrVpyShDI
         Op/I5jHmL4FvDzuRGppOEVTwXNwyVVIr9jnfGXzT3hWVXisSRFNdjZ44MTfDaK4xaAa3
         L8EuiZRkUdpKmNXRBPlQDkjo9//joAHfuCmVIZaBS4Zg38mrspxZ4L7pi6FjXGIxpTUA
         U+1A==
X-Forwarded-Encrypted: i=1; AJvYcCX5BGGrW04juowLNxvkx+sRV6OUpDss3Bcx//q5o8FSvZmfVqLvIDrml65MpHDapVP3X2+yid89ctC28p/ClZv00bkRpmgelNHTWv+S
X-Gm-Message-State: AOJu0YzG6lOgEjhYnadzhjne7Ajkh7JwC7L7ocdeExEoCQm8fep3Iv6S
	p/zehYo3K5mrerGuBPmaxt8Qu0O/a7FgcEAzKiPiqpTVAlarH5HJQvQ0Gdhu3Nt7/PfhhFVhsDF
	ik2zTI1AZ+fWozT+wOpqwDqfWgEeBbdgmPZYhRahpJrarhUyFxyzPE7kg6fEgOA==
X-Received: by 2002:adf:e64b:0:b0:35f:444:8711 with SMTP id ffacd0b85a97d-35fdf7ae55amr2380226f8f.42.1718225806114;
        Wed, 12 Jun 2024 13:56:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeX8qg82cT9OUlPA3tjli0ojPtAyCRwc6S3mdQ6flGSlOo0z7mQnqtlVbSOxfGZUsybi4gcQ==
X-Received: by 2002:adf:e64b:0:b0:35f:444:8711 with SMTP id ffacd0b85a97d-35fdf7ae55amr2380207f8f.42.1718225805689;
        Wed, 12 Jun 2024 13:56:45 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1c2027cfsm11771099f8f.116.2024.06.12.13.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 13:56:45 -0700 (PDT)
Date: Wed, 12 Jun 2024 22:56:43 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rafael@kernel.org, mcgrof@kernel.org,
	russell.h.weight@intel.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: add abstraction for struct device
Message-ID: <ZmoLi57aT4EB_97W@pollux>
References: <ZmdID8AlXtoxUfC1@boqun-archlinux>
 <ZmhPW9yq7y6jbmIg@pollux>
 <2024061136-unbridle-confirm-c653@gregkh>
 <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
 <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>
 <2024061245-kangaroo-clothes-76e1@gregkh>
 <ZmnAOfCUFkZqhDji@pollux>
 <2024061214-dusk-channel-e124@gregkh>
 <ZmnKXoBYf0qOcPU4@pollux>
 <2024061254-scoured-gallantly-5e41@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061254-scoured-gallantly-5e41@gregkh>

On Wed, Jun 12, 2024 at 07:13:31PM +0200, Greg KH wrote:
> On Wed, Jun 12, 2024 at 06:18:38PM +0200, Danilo Krummrich wrote:
> > On Wed, Jun 12, 2024 at 05:50:42PM +0200, Greg KH wrote:
> > > On Wed, Jun 12, 2024 at 05:35:21PM +0200, Danilo Krummrich wrote:
> > > > On Wed, Jun 12, 2024 at 05:02:52PM +0200, Greg KH wrote:
> > > > > On Wed, Jun 12, 2024 at 04:51:42PM +0200, Danilo Krummrich wrote:
> > > > > > On 6/11/24 18:13, Boqun Feng wrote:
> > > > > > > On Tue, Jun 11, 2024 at 03:29:22PM +0200, Greg KH wrote:
> > > > > > > > On Tue, Jun 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > > > > > > ...hence, I agree we should indeed add to the #Invariants and #Safety section
> > > > > > > > > that `->release` must be callable  from any thread.
> > > > > > > > > 
> > > > > > > > > However, this is just theory, do we actually have cases where `device::release`
> > > > > > > 
> > > > > > > @Danilo, right, it's only theorical, but it's good to call it out since
> > > > > > > it's the requirement for a safe Rust abstraction.
> > > > > > 
> > > > > > Similar to my previous reply, if we want to call this out as safety requirement
> > > > > > in `Device::from_raw`, we probably want to add it to the documentation of the C
> > > > > > `struct device`, such that we can argue that this is an invariant of C's
> > > > > > `struct device`.
> > > > > > 
> > > > > > Otherwise we'd have to write something like:
> > > > > > 
> > > > > > "It must also be ensured that the `->release` function of a `struct device` can
> > > > > > be called from any non-atomic context. While not being officially documented this
> > > > > > is guaranteed by the invariant of `struct device`."
> > > > > 
> > > > > In the 20+ years of the driver model being part of the kernel, I don't
> > > > > think this has come up yet, so maybe you can call the release function
> > > > > in irq context.  I don't know, I was just guessing :)
> > > > 
> > > > Ah, I see. I thought you know and it's defined, but just not documented.
> > > > 
> > > > This means it's simply undefined what we expect to happen when the last
> > > > reference of a device is dropped from atomic context.
> > > > 
> > > > Now, I understand (and would even expect) that practically this has never been
> > > > an issue. You'd need two circumstances, release() actually does something that
> > > > is not allowed in atomic context plus the last device reference is dropped from
> > > > atomic context - rather unlikely.
> > > > 
> > > > > 
> > > > > So let's not go adding constraints that we just do not have please.
> > > > > Same goes for the C code, so the rust code is no different here.
> > > > 
> > > > I agree we shouldn't add random constraints, but for writing safe code we also
> > > > have to rely on defined behavior.
> > > 
> > > As the rust code is relying on C code that could change at any point in
> > > time, how can that ever be "safe"?  :)
> > 
> > That's the same as with any other API. If the logic of an API is changed the
> > users (e.g a Rust abstraction) of the API have to be adjusted.
> 
> Agreed, just like any other in-kernel code, so there shouldn't be
> anything special here.
> 
> > > Sorry, this type of definition annoys me.
> > > 
> > > > I see two options:
> > > > 
> > > > (1) We globally (for struct device) define from which context release() is
> > > >     allowed to be called.
> > > 
> > > If you want, feel free to do that work please.  And then find out how to
> > > enforce it in the driver core.
> > 
> > If we *would* define non-atomic context only, we could enforce it with
> > might_sleep() for instance.
> 
> might_sleep() isn't always correct from what I remember.
> 
> > If we *would* define any context, there is nothing to enforce, but we'd need to
> > validate that no implementer of release() voids that.
> 
> Trying to validate that might be hard, again, I don't think it's worth
> it.
> 
> > The former is a constaint you don't want to add, the latter a lot of work. What
> > if we at least define that implementers of release() must *minimally* make sure
> > that it can be call from any non-atomic context.
> > 
> > That'd be something we can rely on in Rust.
> 
> Determining if you are, or are not, in atomic context is almost
> impossible in C, I don't know how you are going to do that at build time
> in Rust.  Good luck!

We can't always enforce things, but we can still follow rules even if we can't
enforce them with tools or language features.

In particular, nothing prevents C code to define from which context things are
allowed to be called. When I was working on drm_gpuvm [1] this was one of the
major aspects I had to get right and documented; keyword dma_fence signalling
critical sections.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_gpuvm.c

> 
> > Oh, I fully agree with that. Let me try to explain a bit what this is about:
> > 
> > In Rust we have the `Send` and `Sync` marker traits. If a type (e.g. `Device`)
> > implements `Send` it means that it's safe to pass an instance of this type
> > between threads. Which is clearly something we want to do with a `Device`.
> > 
> > If I don't implement `Sync` for `Device` the compiler will prevent me from
> > sending it between threads, e.g. by disallowing me to put an instance of
> > `Device` into another data structure that is potentially passed between threads.
> > 
> > If I implement `Sync` I have to add a safety comment on why it is safe to pass
> > `Device` between threads. And here we have what Boqun pointed out: `Device` can
> > only be passed between threads when we're allowed to drop the last reference
> > from any thread. In the case of the kernel this can be any non-atomic context,
> > any context or any other subset. But I have to write something here that is
> > a defined rule and can be relied on.
> 
> You really have two things here, a matrix of:
> 	can transfer between threads
> 	can call in irq context
> that are independent and not related to each other at all.
> 
> Looks like Rust has built in support for the first.  And nothing for the
> second as that is a very kernel-specific thing.

The language documentation defines `Send` as "can be transferred between
threads", likely because it's written from a userspace perspective. But in
the kernel context it actually means can be transferred between any context,
thread, IRQ, etc.

If this isn't true, then we have to add a comment what is allowed (e.g. any
non-atomic context) and what's not allowed.

> 
> So let's not confuse the two please.  `Send` and `Sync` should be fine
> for a device pointer to be passed around, as long as the reference is
> incremented, as that's what all of the kernel C code does today.  Let's
> not worry about irq context at all, that's independent and can be
> handled at a later time, if at all, with a different "marking" as it's
> independent of the current two things.

That'd be great, but as mentioned above, we only have `Send`, but nothing like
`SendIrq`, hence `Send` really means any context.

Given your proposal, to just say it's fine to pass between (actual) threads and
ignore IRQ context for now, we have to implement `Send`, but document that IRQ
context is not covered.

We can either do that in the Rust abstraction as safety requirement, or we can,
as proposed previously, add a comment to the C `struct device` documentation
that implementers of release() must *at least* make sure that it can be called
from any non-atomic context. We can then refer to that.

- Danilo

> 
> thanks,
> 
> greg k-h
> 


