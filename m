Return-Path: <linux-kernel+bounces-546220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3878A4F7E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E582316A9F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4226AD9;
	Wed,  5 Mar 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jRTO0s8y"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5FF86324
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159841; cv=none; b=se/9EL1iOqbl/kYBsgUhzTrn16fWM5CpdBx9zRDq3dSOUgb5vjA5eCz282lT/9KveoHWQ3xPeXYEa+wnMf0+1N2aBzO5LlNi7NIId0vHK8UtmYfueYXh9Nhca/2p6DZSwA7pICYB7oX0FfARrMBNcTejKoAenzfAeFxomwkjOJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159841; c=relaxed/simple;
	bh=E9d/ZYRDweWef9J6nm+N37n6i90JPaipsMFkzvOxEHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMx6vM9L2gYPnp0kTbjM1AzV39JNr+w6WBOE1wx8nWzdajWAuxMMW9fwg8r2ROwr3rnx0Sye77PxRnDtcl7digCciFB5AGpjUzoxe4/Ap4JO2jQn4otV+vvv7hWszIDjAMbR1iG4ytaGfTJo5UhPei9ogVvuijW6InNOYS4iDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=jRTO0s8y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so43746685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 23:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741159838; x=1741764638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eIPjoywVHzslmjO8vs+eTHuxI6qCJTL5FwNFg9NfBw=;
        b=jRTO0s8yBID2JL6Q4Ibt7Q6zqZv72n+v6fKAaEP9vsvcRdv302j81GRZfFA+NPMhGX
         NCbYYSbxnZSmPL6VRdHgqgxuIXEvyImCfhQz6hV95IKiyy3FJuRuCTyXxKKDVUqR0OVX
         JEtEM7smY6vqKMfGmZYjODH5b4UbIDtoltkk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159838; x=1741764638;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eIPjoywVHzslmjO8vs+eTHuxI6qCJTL5FwNFg9NfBw=;
        b=SFZuv9mwuiM1cxE4vI8OEAe+pIl3PetNXivJgBDnIFz2Vc3FPOBnz1aWfgeT4d0pNv
         wAYKS/1nujKbRKa+6YOLo3ppJzPKPDE0Bm7j9/fWb0T3Rj3VlmixZa1HxK8OgNNGLPcS
         J7Rl/PaZkIduda77S3AvW3a0RghdNEGZ5SqdwCyzmABFO1Fze3zpAI7+e999lYI0+CyY
         QklB2nbUU/PPL+pHW72ssfVkcYkDRzWkmQwyRQa57DWSFU7iuURUVXM0+dJTuMg/e6DM
         q6q8g9GVnk9BoBpJJHEt4zN/fcQnlAVCmxK7SZX84k0WJnOZEWWgyZcf4WtoGH8xYv4t
         gJrA==
X-Forwarded-Encrypted: i=1; AJvYcCVD2hjGMgeX0T8lHFUECad/uJ04PfceEQ62JQy0lf7gLfI3aRKJB2/VZdo1OH25dkYprHk5nI3Ik49yXcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEW2ubmh5YtBH+gv7fc1qbqQhvuwC30EPG3PKD51OhYldbo3Hc
	qTWRwh2cbhjIaKI9Yiu9g4TEbbdV3N7CAN14e37F8Seg5MFqYY6ftXH02xU7I/g=
X-Gm-Gg: ASbGncu0SWl9CiQuZ8fpBMHys4qTDQkPeOsePWKfEn/iC8buKdbP1eNa/3hwMFKGuwE
	dSki9e6O/5eHRL+IAdVh1A/UUQtGuokG5GOSTt4UFbu4wZBRtxX0hEn4fXto6e3JZkP7eCsQc5t
	gp/IfeiB7jb21Tx0gmiF/u9uM7gi0DT9n6z+Eza/EaUHqteT/SQEdsQr1gQ3SAfbCICu1IQoUc5
	wyJVjT+QTKaofQUaHdBwpyChYXJAvqgv99uQH5yi0mf+7U/lJgShr9KMR2aa21o0RkeLGtOSOAR
	L3dJaODE03IqnF+8yghwNFtOE7/1khmQLhWWysqSuaTsLe6IELdCR4GM
X-Google-Smtp-Source: AGHT+IGLEHkW+RyaKKz2KrNndnwh4djhORTNBKpw376Kno8bWHtJQuS7EruIxE2wip3vv6xuWjSI3w==
X-Received: by 2002:a05:600c:1d0f:b0:43b:d203:da18 with SMTP id 5b1f17b1804b1-43bd295494bmr11723085e9.13.1741159837590;
        Tue, 04 Mar 2025 23:30:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426cbc2sm8898505e9.4.2025.03.04.23.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:30:37 -0800 (PST)
Date: Wed, 5 Mar 2025 08:30:34 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
Subject: Re: [RFC PATCH 0/3] gpu: nova-core: add basic timer subdevice
 implementation
Message-ID: <Z8f9mgD4LUJN_dWw@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
References: <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
 <2025022644-fleshed-petite-a944@gregkh>
 <D82UB3V6NZ55.3OEPPW2W8MFZV@nvidia.com>
 <Z8GViQzZJVFPxfNd@phenom.ffwll.local>
 <20250228184013.GF39591@nvidia.com>
 <Z8cmBWB8rl97-zSG@phenom.ffwll.local>
 <20250304164201.GN133783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304164201.GN133783@nvidia.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Tue, Mar 04, 2025 at 12:42:01PM -0400, Jason Gunthorpe wrote:
> On Tue, Mar 04, 2025 at 05:10:45PM +0100, Simona Vetter wrote:
> > On Fri, Feb 28, 2025 at 02:40:13PM -0400, Jason Gunthorpe wrote:
> > > On Fri, Feb 28, 2025 at 11:52:57AM +0100, Simona Vetter wrote:
> > > 
> > > > - Nuke the driver binding manually through sysfs with the unbind files.
> > > > - Nuke all userspace that might beholding files and other resources open.
> > > > - At this point the module refcount should be zero and you can unload it.
> > > > 
> > > > Except developers really don't like the manual unbind step, and so we're
> > > > missing try_module_get() in a bunch of places where it really should be.
> > > 
> > > IMHO they are not missing, we just have a general rule that if a
> > > cleanup function, required to be called prior to module exit, revokes
> > > any .text pointers then you don't need to hold the module refcount.
> > > 
> > > file_operations doesn't have such a cleanup function which is why it
> > > takes the refcount.
> > > 
> > > hrtimer does have such a function which is why it doesn't take the
> > > refcount.
> > 
> > I was talking about a bunch of other places, where it works like
> > file_operations, except we don't bother with the module reference count.
> > I've seen patches fly by where people "fix" these things because module
> > unload is "broken".
> 
> Sure, but there are only two correct API approaches, either you
> require the user to make a cancel call that sanitizes the module
> references, or you manage them internally.
> 
> Hope and pray isn't an option :)
> 
> > gpu drivers can hog console_lock (yes we're trying to get away from that
> > as much as possible), at that point a cavalier attitude of "you can just
> > wait" isn't very appreciated.
> 
> What are you trying to solve here? If the system is already stuck
> infinitely on the console lock why is module remove even being
> considered?
> 
> module remove shouldn't be a remedy for a crashed driver...

I mean hotunplug here, and trying to make that correct.

This confusion is is why this is so hard, because there's really two main
users for all this:

- developers who want to quickly test new driver versions without full
  reboot. They're often preferring convenience over correctness, like with
  the removal of module refcounting that's strictly needed but means they
  first have to unbind drivers in sysfs before they can unload the driver.

  Another one is that this use-case prefers that the hw is cleanly shut
  down, so that you can actually load the new driver from a well-known
  state. And it's entirely ok if this all fails occasionally, it's just
  for development and testing.

- hotunplug as an actual use-case. Bugs are not ok. The hw can go away at
  any moment. And it might happen while you're holding console_lock. You
  generally do not remove the actual module here, which is why for the
  actual production use-case getting that part right isn't really
  required. But getting the lifetimes of all the various
  structs/objects/resources perfectly right is required.

So the "stuck on console_lock" is the 2nd case, not the first. Module
unload doesn't even come into play on that one.

> > > But so is half removing the driver while it is doing *anything* and
> > > trying to mitigate that with a different kind of hard to do locking
> > > fix. *shrug*
> > 
> > The thing is that rust helps you enormously with implementing revocable
> > resources and making sure you're not cheating with all the bail-out paths.
> 
> Assuming a half alive driver with MMIO and interrupts ripped away
> doesn't lock up.

Rust's drop takes care of that for you. It's not guaranteed, but it's a
case of "the minimal amount of typing yields correct code", unlike C,
where that just blows up for sure.

> Assuming all your interrupt triggered sleeps have gained a shootdown
> mechanism.

Hence why I want revocable to only be rcu, not srcu.

> Assuming all the new extra error paths this creates don't corrupt the
> internal state of the driver and cause it to lockup.

Yeah this one is a bit scary. Corrupting the state is doable, locking up
is much less likely I think, it seems to be more leaks that you get if
rust goes wrong.

> Meh. It doesn't seem like such an obvious win to me. Personally I'm
> terrified of the idea of a zombie driver half sitting around in a
> totally untestable configuration working properly..

Yeah agreed. I might really badly regret this all. But I'm not sold that
switching to message passing design is really going to be better, while
it's definitely going to be a huge amount of work.

> > It cannot help you with making sure you have interruptible/abortable
> > sleeps in all the right places. 
> 
> :(
> 
> > > Like, I see a THIS_MODULE in driver->fops == amdgpu_driver_kms_fops ?
> > 
> > Yeah it's there, except only for the userspace references and not for the
> > kernel internal ones. Because developers get a bit prickle about adding
> > those unfortunately due to "it breaks module unload". Maybe we just should
> > add them, at least for rust.
> 
> Yeah, I think such obviously wrong things should be pushed back
> against. We don't want EAF bugs in the kernel, we want security...

Maybe the two different use-cases above help explain why I'm a bit more
pragmatic here. As long as the hotunplug case does not gain bugs (or gets
some fixed) I'm fairly lax with hacks for the driver developer use-case of
reloading modules.

> > You've missed the "it will upset developers part". I've seen people remove
> > module references that are needed, to "fix" driver unloading.
> 
> When done properly the module can be unloaded. Most rdma driver
> modules are unloadable, live, while FDs are open.
> 
> > The third part is that I'm not aware of anything in rust that would
> > guarantee that the function pointer and the module reference actually
> > belong to each another. Which means another runtime check most likely, and
> > hence another thing that shouldn't fail which kinda can now.
> 
> I suspect it has to come from the C code API contracts, which leak
> into the binding design.
> 
> If the C API handles module refcounting internally then rust is fine
> so long as it enforces THIS_MODULE.

You could do contrived stuff and pass function pointers around, so that
THIS_MODULE doesn't actually match up with the function pointer. Sure it's
really stupid, but the idea with rust is that for memory safety stuff like
this, it's not just stupid, but impossible and the compiler will catch
you. So we need a tad more for rust.

> If the C API requires cancel then rust is fine so long as the binding
> guarantees cancel before module unload.

Yeah this is again where I think rust needs a bit more, because the
compiler can't always nicely proof this for you in all the "obvious"
cases.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

