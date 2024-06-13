Return-Path: <linux-kernel+bounces-213191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9979906FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B451F22ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5591A143C7A;
	Thu, 13 Jun 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0Qrorxk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EBA44C6F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281357; cv=none; b=sIlb+UMpzSX49uNiquApTMKT6wzW7ht1PVszk/OgBucK7eHMxRf2dI9TIIYsEzsPr9ORhvhdFZH22T2lQXHNrSvh9eEQbjcwtSBCozOLn7Z/Ltyz2cgW+M34UozwwE4ZvtkFdmrq6+BnzdF/zTAnJRc5p3gafRfvxKcqIvt0tnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281357; c=relaxed/simple;
	bh=tFRzojTDUSFvsvrvIfBq83Iefr9prpj0FsVzc4sRZcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSEpZb0zxF/erhMDi/l4Dt3LtzJdtjoXSQoOfWjW1STJAHoBdw8SiYJoIMmGyfa39Ch9jK8eNlkv+D10xn7JfwE1FjzBZhsPsljz1It7FmTVjEHLKY7keW6soMsnoObyrn81+5ljZluzZOOsqDLTZead+ijsJJSASnr7UoUsSsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0Qrorxk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718281354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bREAov0qeqdC1R+IP3cuQHiAdwt4/67Pzt58ig6NBc=;
	b=T0QrorxkJ8SBUnxodgAJS5LDXK1Db6wbRC8+dWtS4ut/9HhdqplJ379b/KK0Kd0b6dZ60D
	y4i9sUrlcyTvzAtzEaNWGXtacJVCeUm0WpQ6xKSdamQ2ZPiywq2FjG7+lNYVq742chAL7+
	dKcY7zBaZurjFutR8SgSElUEzviBADE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-vKUkstL5OQGYKKDsb8sg4A-1; Thu, 13 Jun 2024 08:22:33 -0400
X-MC-Unique: vKUkstL5OQGYKKDsb8sg4A-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52bbd8ac2c1so668596e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718281351; x=1718886151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bREAov0qeqdC1R+IP3cuQHiAdwt4/67Pzt58ig6NBc=;
        b=LuY4DieihH8V7Zbyi+3islEbTyIoNBI0b92uDi8r+njRp78st1fRyYenhs16gf+IwG
         aH2niabnbA9jxT/hZ+MuVH34Acl+K5BFPOcuMMib0cCYVDWCp3QHweNJ6lflFwAqfObC
         WBLzrm5O/juKYuaRsNAc+YCjHDkNCbap5przie1fdEsTszMMpnusXHDQTaATOTkoETio
         bn/UFhOQPO54LqWcCaZccLDbkcv78oA6GvKiGYZzJcCf853ruDtvm7W3rREKZhE3LvpN
         xIWG/Qk2pFuvuJseOupcqPfMbIFqwKoWJitKyQnKe/OMKxzsIUAKdpYnTOJAhUoUIDwf
         v6UA==
X-Forwarded-Encrypted: i=1; AJvYcCV6mpsKsQuXPVqoEV8Gw2bZ/IgbH0K9hocIjSXDolJWoBYMbp8Ml/zThw/I/IBstIhFQOM2H9/H/QFAQ4zIfs0PotjL90XLhFh5rXVb
X-Gm-Message-State: AOJu0YymfNfPYE0drnpkpgM6//NIYqRH4K2wBTryygR34ManoKQcthxb
	vAmoZFXIW9Wadm/hBz+l526rTGe0R1Ws3QQocZmdfSRCKjpEj6WtObsoSuLRWcuvNw/odIIhon5
	PKOT8nAXKDZgc8iYyX6/K8CpKnKeMtN3qz2tBbz+S0bUxscMAx8L/q7fCK8CgZg==
X-Received: by 2002:a05:6512:1095:b0:52c:90ba:96f9 with SMTP id 2adb3069b0e04-52c9a3fe0b1mr3885824e87.46.1718281351575;
        Thu, 13 Jun 2024 05:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcn6oO67nyAU+DJNaPbAgvWuyctBbodumVqTuS6V/O2nuBxav+b+bW9vkQfhc9KiQd2ydG4w==
X-Received: by 2002:a05:6512:1095:b0:52c:90ba:96f9 with SMTP id 2adb3069b0e04-52c9a3fe0b1mr3885786e87.46.1718281350865;
        Thu, 13 Jun 2024 05:22:30 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602efc4sm23256965e9.15.2024.06.13.05.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:22:30 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:22:27 +0200
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
Message-ID: <Zmrkg7oOceWWV4nz@pollux>
References: <2024061136-unbridle-confirm-c653@gregkh>
 <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
 <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>
 <2024061245-kangaroo-clothes-76e1@gregkh>
 <ZmnAOfCUFkZqhDji@pollux>
 <2024061214-dusk-channel-e124@gregkh>
 <ZmnKXoBYf0qOcPU4@pollux>
 <2024061254-scoured-gallantly-5e41@gregkh>
 <ZmoLi57aT4EB_97W@pollux>
 <2024061345-troubling-visiting-830a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061345-troubling-visiting-830a@gregkh>

On Thu, Jun 13, 2024 at 07:47:13AM +0200, Greg KH wrote:
> On Wed, Jun 12, 2024 at 10:56:43PM +0200, Danilo Krummrich wrote:
> > > > Oh, I fully agree with that. Let me try to explain a bit what this is about:
> > > > 
> > > > In Rust we have the `Send` and `Sync` marker traits. If a type (e.g. `Device`)
> > > > implements `Send` it means that it's safe to pass an instance of this type
> > > > between threads. Which is clearly something we want to do with a `Device`.
> > > > 
> > > > If I don't implement `Sync` for `Device` the compiler will prevent me from
> > > > sending it between threads, e.g. by disallowing me to put an instance of
> > > > `Device` into another data structure that is potentially passed between threads.
> > > > 
> > > > If I implement `Sync` I have to add a safety comment on why it is safe to pass
> > > > `Device` between threads. And here we have what Boqun pointed out: `Device` can
> > > > only be passed between threads when we're allowed to drop the last reference
> > > > from any thread. In the case of the kernel this can be any non-atomic context,
> > > > any context or any other subset. But I have to write something here that is
> > > > a defined rule and can be relied on.
> > > 
> > > You really have two things here, a matrix of:
> > > 	can transfer between threads
> > > 	can call in irq context
> > > that are independent and not related to each other at all.
> > > 
> > > Looks like Rust has built in support for the first.  And nothing for the
> > > second as that is a very kernel-specific thing.
> > 
> > The language documentation defines `Send` as "can be transferred between
> > threads", likely because it's written from a userspace perspective. But in
> > the kernel context it actually means can be transferred between any context,
> > thread, IRQ, etc.
> > 
> > If this isn't true, then we have to add a comment what is allowed (e.g. any
> > non-atomic context) and what's not allowed.
> 
> That isn't good, you are going to have to change how `Send` works here
> if you think it's safe to do stuff in all of those different contexts,
> as that is almost never going to be true.
> 
> Why not just stick with "accessed from another thread" and leave it at
> that, as again, the combinations here are a matrix, not a boolean yes/no
> type of thing.

I probably didn't phrase this very well, let me try again.

What the compiler can do for us currently is to check whether a data structure
is kept only in it's current context or whether it is send to another one - it
can't distinguish context types though.

So, the actual definition of `Send` isn't really "can be send across threads",
but "is not restricted to be kept in a single context".

This means that if something is "is not restricted to be kept in a single
context", but limited to certain context type, we, unfortunately, just have to
make it `Send`, but document the restriction.

> 
> > > So let's not confuse the two please.  `Send` and `Sync` should be fine
> > > for a device pointer to be passed around, as long as the reference is
> > > incremented, as that's what all of the kernel C code does today.  Let's
> > > not worry about irq context at all, that's independent and can be
> > > handled at a later time, if at all, with a different "marking" as it's
> > > independent of the current two things.
> > 
> > That'd be great, but as mentioned above, we only have `Send`, but nothing like
> > `SendIrq`, hence `Send` really means any context.
> > 
> > Given your proposal, to just say it's fine to pass between (actual) threads and
> > ignore IRQ context for now, we have to implement `Send`, but document that IRQ
> > context is not covered.
> > 
> > We can either do that in the Rust abstraction as safety requirement, or we can,
> > as proposed previously, add a comment to the C `struct device` documentation
> > that implementers of release() must *at least* make sure that it can be called
> > from any non-atomic context. We can then refer to that.
> 
> As someone who has written comments in code for functions that are
> always ignored, I am happy to see you think that this is actually going
> to do anything :)

One advantage we have in Rust is, that if something has a specific requirement
we mark it as `unsafe` and the user of the API has to put it in an `unsafe`
block, which we require a sfety comment for, where the user of the API has to
explain why this is the correct thing to do in this case.

In other words we can technically enforce that people read the comment and
explain how they ensure to fulfill what the comment asks for.

> 
> Heck, I have put huge messages in kernel code for when people implement
> the api wrong[1], and they still ignore that at runtime.  Only way to get
> it noticed is if you break someone's build.

You only see the ones who still do it wrong. You probably don't have visibility
of the ones who did it right due to your effort to write it down. :-)

> 
> So you all need to really define what `Send` means, as it sounds like a
> userspace thing that isn't going to fit in well within the kernel model.

Please see the explanation above.

> 
> thanks,
> 
> greg k-h
> 
> [1] See the pr_debug() calls in kobject_cleanup() as proof, people just
>     create an "empty" release function to shut them up, thinking that is
>     the correct solution when obviously it is not...
> 


