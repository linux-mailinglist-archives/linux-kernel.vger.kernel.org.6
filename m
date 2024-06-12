Return-Path: <linux-kernel+bounces-211903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15238905892
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECD7282009
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5C318130E;
	Wed, 12 Jun 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5/awZH7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BB2206B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209127; cv=none; b=ocfqyUUpGMO5LwPiDsEUuLfmrZmtQROykisjlZvCZCaKZ9QfTydatrmH9dK0KBGwGeaxOeO6Vp+zSTFpOeEPxrdHJcw7dXnD8sjnVKMvTxLMapuNdpgPF4EbdI8GPUKVu3vABv7G8scY/u2ZX+Gt1gkle3ISicfqw3ZgarFeVUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209127; c=relaxed/simple;
	bh=LgKnBBEYF4slVo+dXiJdzqo+uxgB8E3xmIqLdhIJE+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of6LlmIKuCAA4M2tyOpZGrMGuf+MZPMl+Xrm8XI1E9EhkcQ/MZcWixW5jdtb617whYKysrKCbS+xKfTH9uA5ClpvTvNQ8BC7goaDDuWbdLamCaP8SVX3UUqawv9hv1Kdvv5iYJ+oEm/r6oU5vJpfcrKF6RTZeUcp+LyQtg6ID0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5/awZH7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718209124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qMiYnh/nE1O48BCYSy718f15eqeLpGiytLvAa6CcY8=;
	b=L5/awZH70yhJY7Xw4qkQQ5aZFuzwXIvsow6MdiKzmwLETQgAoM5lLtToJ1PytOeFXva/tZ
	96scPG9DQND0FG2Bw0awWbxcDMqWQop1V7c0X4QJESEYz+BU4crH/kvL3lIwUhX5ANoCvh
	RPnIFvAO+UNRohiYrtjvFjajOvCqpQw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-IXIh6P_WMEmKF9j0YirPoA-1; Wed, 12 Jun 2024 12:18:43 -0400
X-MC-Unique: IXIh6P_WMEmKF9j0YirPoA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4218447b900so201835e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209122; x=1718813922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qMiYnh/nE1O48BCYSy718f15eqeLpGiytLvAa6CcY8=;
        b=qTcSo8g4IEQnaUDbjJ5IL4Cen6tuwQWJ5fAAdYWOIuyCUGsrmzbxIInhjA1xej3lOe
         Yc0Ev7+0MFVL6w70WhPTDU/G8haesXy6/xcI7ZNGuS2fHCEF4Hkp5APkowDBLEs4SFQq
         4Kn7DmOD3u9seo+E9idgQS6OvoBTBgaf9ltMuWTWl+xnRnSRU9QUTDT5AM6mobnkisOy
         oDTZjJW8gzYQaPpwd6HcryDRC4qcle1MET+gtFb1wMvyUYmoMedNrqPOOKhkEDn8Cz8P
         3O6xyS+WjwWDQnJ03wIFK4PsemK0/E5T3hNq1Jacn95ShQ9oh/fOas9vWVVeqdpFlnXh
         7Bog==
X-Forwarded-Encrypted: i=1; AJvYcCUzzlqSzrpXIBhhJQoj1jo3X328d28bAFLqBo8B5fZfRX87PyiWYrlP1laiv61xrjJjFuJWy/QA479BoPIB4saw+Wgtrkm0Ztblfucv
X-Gm-Message-State: AOJu0YxM7hxTd69I/LDzodgvYZUopGuE7UdPQkyhmto82UTqpOlSVoSW
	mSTbII6wGeFzYzNlNMUgynWMwKDbSrqmF/czWcEHCUkNGEO0OiznTCwDMVRDRc/khAW23DNKHsw
	52eyo9dFLzXtDI6tOLoKXxs9HGMFd2bjUx38gzD2j6+0NwvdKGGognU6sWqS5tg==
X-Received: by 2002:a05:600c:4506:b0:421:8234:9bb4 with SMTP id 5b1f17b1804b1-422b87b395amr1600055e9.19.1718209121895;
        Wed, 12 Jun 2024 09:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSv5xyoQqVRyGx2f0ODUYvzJlCpL1gxp1l2+DKUowf2FaGESQ3k1Q8ar36J9dTQ6ZToCZxhQ==
X-Received: by 2002:a05:600c:4506:b0:421:8234:9bb4 with SMTP id 5b1f17b1804b1-422b87b395amr1599585e9.19.1718209121437;
        Wed, 12 Jun 2024 09:18:41 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e7060sm31120205e9.40.2024.06.12.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:18:40 -0700 (PDT)
Date: Wed, 12 Jun 2024 18:18:38 +0200
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
Message-ID: <ZmnKXoBYf0qOcPU4@pollux>
References: <20240610180318.72152-1-dakr@redhat.com>
 <20240610180318.72152-2-dakr@redhat.com>
 <ZmdID8AlXtoxUfC1@boqun-archlinux>
 <ZmhPW9yq7y6jbmIg@pollux>
 <2024061136-unbridle-confirm-c653@gregkh>
 <Zmh3oN9sWamaYHOD@Boquns-Mac-mini.home>
 <d74edb73-1dba-43f4-a50c-36354c39d758@redhat.com>
 <2024061245-kangaroo-clothes-76e1@gregkh>
 <ZmnAOfCUFkZqhDji@pollux>
 <2024061214-dusk-channel-e124@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061214-dusk-channel-e124@gregkh>

On Wed, Jun 12, 2024 at 05:50:42PM +0200, Greg KH wrote:
> On Wed, Jun 12, 2024 at 05:35:21PM +0200, Danilo Krummrich wrote:
> > On Wed, Jun 12, 2024 at 05:02:52PM +0200, Greg KH wrote:
> > > On Wed, Jun 12, 2024 at 04:51:42PM +0200, Danilo Krummrich wrote:
> > > > On 6/11/24 18:13, Boqun Feng wrote:
> > > > > On Tue, Jun 11, 2024 at 03:29:22PM +0200, Greg KH wrote:
> > > > > > On Tue, Jun 11, 2024 at 03:21:31PM +0200, Danilo Krummrich wrote:
> > > > > > > ...hence, I agree we should indeed add to the #Invariants and #Safety section
> > > > > > > that `->release` must be callable  from any thread.
> > > > > > > 
> > > > > > > However, this is just theory, do we actually have cases where `device::release`
> > > > > 
> > > > > @Danilo, right, it's only theorical, but it's good to call it out since
> > > > > it's the requirement for a safe Rust abstraction.
> > > > 
> > > > Similar to my previous reply, if we want to call this out as safety requirement
> > > > in `Device::from_raw`, we probably want to add it to the documentation of the C
> > > > `struct device`, such that we can argue that this is an invariant of C's
> > > > `struct device`.
> > > > 
> > > > Otherwise we'd have to write something like:
> > > > 
> > > > "It must also be ensured that the `->release` function of a `struct device` can
> > > > be called from any non-atomic context. While not being officially documented this
> > > > is guaranteed by the invariant of `struct device`."
> > > 
> > > In the 20+ years of the driver model being part of the kernel, I don't
> > > think this has come up yet, so maybe you can call the release function
> > > in irq context.  I don't know, I was just guessing :)
> > 
> > Ah, I see. I thought you know and it's defined, but just not documented.
> > 
> > This means it's simply undefined what we expect to happen when the last
> > reference of a device is dropped from atomic context.
> > 
> > Now, I understand (and would even expect) that practically this has never been
> > an issue. You'd need two circumstances, release() actually does something that
> > is not allowed in atomic context plus the last device reference is dropped from
> > atomic context - rather unlikely.
> > 
> > > 
> > > So let's not go adding constraints that we just do not have please.
> > > Same goes for the C code, so the rust code is no different here.
> > 
> > I agree we shouldn't add random constraints, but for writing safe code we also
> > have to rely on defined behavior.
> 
> As the rust code is relying on C code that could change at any point in
> time, how can that ever be "safe"?  :)

That's the same as with any other API. If the logic of an API is changed the
users (e.g a Rust abstraction) of the API have to be adjusted.

> 
> Sorry, this type of definition annoys me.
> 
> > I see two options:
> > 
> > (1) We globally (for struct device) define from which context release() is
> >     allowed to be called.
> 
> If you want, feel free to do that work please.  And then find out how to
> enforce it in the driver core.

If we *would* define non-atomic context only, we could enforce it with
might_sleep() for instance.

If we *would* define any context, there is nothing to enforce, but we'd need to
validate that no implementer of release() voids that.

The former is a constaint you don't want to add, the latter a lot of work. What
if we at least define that implementers of release() must *minimally* make sure
that it can be call from any non-atomic context.

That'd be something we can rely on in Rust.

> 
> > (2) We define it for the Rust abstraction only and just constrain it to
> >     non-atomic context to be able to give a safety guarantee. We can't say
> >     "might be safe from any context, but we don't know".
> 
> Why can't you say that?  Your "saftey" barrier ends/begins at the
> interaction with the rust/c layer.  You can't "guarantee" anything on
> the C side...

Not guarantee as in "technically enforce it", but guarantee as in "we have rules
that we follow".

The former would be best, but it isn't always possible. The latter we can always
do (and should IMHO).

> 
> > But again, this is really just a formality, the C code does it all the way and
> > practically there never was an issue, which means we actually do follow some
> > rules, it's just about writing them down. :)
> 
> Again, this has NEVER come up in 20+ years, so maybe it's just not an
> issue?  Not to say it isn't, but maybe do some tests and see what
> happens...

Oh, I fully agree with that. Let me try to explain a bit what this is about:

In Rust we have the `Send` and `Sync` marker traits. If a type (e.g. `Device`)
implements `Send` it means that it's safe to pass an instance of this type
between threads. Which is clearly something we want to do with a `Device`.

If I don't implement `Sync` for `Device` the compiler will prevent me from
sending it between threads, e.g. by disallowing me to put an instance of
`Device` into another data structure that is potentially passed between threads.

If I implement `Sync` I have to add a safety comment on why it is safe to pass
`Device` between threads. And here we have what Boqun pointed out: `Device` can
only be passed between threads when we're allowed to drop the last reference
from any thread. In the case of the kernel this can be any non-atomic context,
any context or any other subset. But I have to write something here that is
a defined rule and can be relied on.

- Danilo

> 
> thanks,
> 
> greg k-h
> 


