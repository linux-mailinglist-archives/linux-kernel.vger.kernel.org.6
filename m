Return-Path: <linux-kernel+bounces-544891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECF6A4E69B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A9A423983
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50990266F12;
	Tue,  4 Mar 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="h7VZO1a/"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D76926738D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104653; cv=none; b=tSpiivYlIGS1giwEQ7NK+QLh35HQn6wlLdWu0GFLghBCZW2p2V/db/5WpEIs0Y8Z/vcvIfNDX7e3y66+dIPCJCChIXQS5xwf7B3CSsDlaRweXWYqMp1dNwKmYZNX+mWH7SGuMtQ/FRPuJru44rfcLW1bfgphBnQJ5/EIeDWGRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104653; c=relaxed/simple;
	bh=f/c/msyx1e3vxoDPGJKe0SJqzT6HzDxhGA9qQONgqPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoLNBDXHc6IkxQoQgHnLr7arpniaOpSzTA5borkys8BQzqJAAS2c+sMlkVkx9JS619Pw0EWirPDFlIAok0TkxltAG1/WiEgQ94cS96G1LfUSIRmK9dXG7dO8XAq1C3HaccDgnAFi5L0wIlOXhbo0GixbMsjT26L+RK9cut/824w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=h7VZO1a/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390eebcc331so2514442f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741104649; x=1741709449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIy9PeTTsN4YAiA2ClJKxcubBrW079aT6S1+RxVahlY=;
        b=h7VZO1a/xH/NrWcg39uqEMTPWcGttJPocZJUGcpS0MpqTeC1Sixu5X4RoqWggnfI32
         i10x6bLCLVUmz0P2cyi9PrbpdkFz4imDleBeUUXWnw8oI5apER4yxw9/Nbt9dEOKSX4y
         WGkY/lFE9+hUWSdIcRcFfHK8fjnOQjcHMwiDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741104649; x=1741709449;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIy9PeTTsN4YAiA2ClJKxcubBrW079aT6S1+RxVahlY=;
        b=Yzu5Nkz/uL/EUqG/oCMbs35KYgmvfSi6j2E0XQihZtptbx52WiNToyWZQ0IQ87/SNl
         ObbTap08QtEvPowcLja6DC2KMbdKpWbM3Fjd2wrxSAIEe/ufJPrCr1+aLqTAu6gv9n31
         wvvHgFNN7FEbm8epqEWb7x/v8F9N5GvS5H+rggJtyAlr3NCLkngdBWatBTW6dUaaMk58
         1K/yO8KtMZOxAi1JB6CyoIeyTRe4hDT9dMrOVo5tBd6bp+QRlINixlCw/PDUS8aTEChK
         4/XuK9Wi/c26kgp2MVdK37bLNkfWwVphRg+CBcAM9LEtvFazPgzfiURNMEC3HEb51mhJ
         S4tw==
X-Forwarded-Encrypted: i=1; AJvYcCUFzZdmHUKk2cOahEvypKY9Jnik2qbTfZ4Xy+ydPnq6EkIGhEXTMhJEMhJ7u3tOIgNMu0Yl3/2bGwbqoIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaW1X2/y/QpvqW0RISbQuMMBGWJGSX6UEU4NZ9UsYjDgaSOphv
	1BVIE3wpV9L40spnk6qSQobcMyNelt7lGBqrWb8WvawUT/sZplNFD5LU52pUlTs=
X-Gm-Gg: ASbGncvmoRxzyOJuxZi04suanOZxnhmcdDDHTYhPNHXQmlNOqsOJp+75/NkGX42MZo6
	ALNFkz+/LUtpCMcJabubK/JLnqw4ooiGwGFomeSXKcf8KsfuKSshjZs9ddUQKK/w53blk/vKWzv
	WO7o0ZeN5KNFar1kg1/p3kH15UkIBsA6KQqV4H39//fRleSHcLIIDrvAJjynb3zHN1MQqZy15W7
	R864ccyRNchVXBzDCMYl1O99d2pCjpg7aSKA+Bn0g62btK9tY6jsyqUX4MoTCOzDZ9KVxEcTsmy
	8wtCXqQ5vJB99ulWQdymZqMOqiyqwz7vkOIoWSPpl/QPg6kFCmevJYcd
X-Google-Smtp-Source: AGHT+IGYstbykxSLckXcDtbIvHnaqvWhbPG4L7oRKtT9m1rH0Ss1kauZrIqVjxI5p2CBcuWK44nyyA==
X-Received: by 2002:a05:6000:402b:b0:38f:3224:65e5 with SMTP id ffacd0b85a97d-39115605344mr3132563f8f.12.1741104649374;
        Tue, 04 Mar 2025 08:10:49 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db82sm17762968f8f.88.2025.03.04.08.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:10:47 -0800 (PST)
Date: Tue, 4 Mar 2025 17:10:45 +0100
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
Message-ID: <Z8cmBWB8rl97-zSG@phenom.ffwll.local>
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
References: <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com>
 <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
 <2025022644-fleshed-petite-a944@gregkh>
 <D82UB3V6NZ55.3OEPPW2W8MFZV@nvidia.com>
 <Z8GViQzZJVFPxfNd@phenom.ffwll.local>
 <20250228184013.GF39591@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228184013.GF39591@nvidia.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Fri, Feb 28, 2025 at 02:40:13PM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2025 at 11:52:57AM +0100, Simona Vetter wrote:
> 
> > - Nuke the driver binding manually through sysfs with the unbind files.
> > - Nuke all userspace that might beholding files and other resources open.
> > - At this point the module refcount should be zero and you can unload it.
> > 
> > Except developers really don't like the manual unbind step, and so we're
> > missing try_module_get() in a bunch of places where it really should be.
> 
> IMHO they are not missing, we just have a general rule that if a
> cleanup function, required to be called prior to module exit, revokes
> any .text pointers then you don't need to hold the module refcount.
> 
> file_operations doesn't have such a cleanup function which is why it
> takes the refcount.
> 
> hrtimer does have such a function which is why it doesn't take the
> refcount.

I was talking about a bunch of other places, where it works like
file_operations, except we don't bother with the module reference count.
I've seen patches fly by where people "fix" these things because module
unload is "broken".

> > Now wrt why you can't just solve this all at the subsystem level and
> > guarantee that after drm_dev_unplug no code is running in driver callbacks
> > anymore:
> > 
> > In really, really simple subsystems like backlight this is doable. In drm
> > with arbitrary ioctl this isn't, and you get to make a choice:
> 
> It is certainly doable, you list the right way to do it right below
> and RDMA implements that successfully.
> 
> The subsytem owns all FDs and proxies all file_opertions to the driver
> (after improving them :) and that is protected by a rwsem/SRCU that
> is safe against the removal path setting all driver ops to NULL.

I'm not saying that any of these approaches are bad. For some cases we
plan to use them in gpu code too even. The above is pretty much the plan
we have for dma_fence.

> > - You wait until all driver code finishes, which could be never if there's
> >   ioctl that wait for render to complete and don't handle hotunplug
> >   correctly. This is a deadlock.
> 
> Meh. We waited for all FDs to close for along time. It isn't a
> "deadlock" it is just a wait on userspace that extends to module
> unload. Very undesirable yes, but not the end of the world, it can
> resolve itself if userspace shutsdown.
> 
> But, IMHO, the subsystem and driver should shoot down the waits during
> remove.
> 
> Your infinite waits are all interruptable right? :)

So yeah userspace you can shoot down with SIGKILL, assuming really good
programming. But there's also all the in-kernel operations between various
work queues and other threads. This can be easily fixed by just rewriting
the entire thing into a strict message passing paradigm. Unfortunately
rust has to interop with the current existing mess.

gpu drivers can hog console_lock (yes we're trying to get away from that
as much as possible), at that point a cavalier attitude of "you can just
wait" isn't very appreciated.

And once you've made sure that really everything can bail out of you've
gotten pretty close to reimplementing revocable resources.

> >   In my experience this is theorically possible, practically no one gets
> >   this right and defacto means that actual hotunplug under load has a good
> >   chance of just hanging forever. Which is why drm doesn't do this.
> 
> See, we didn't have this problem as we don't have infinite waits in
> driver as part of the API. The API toward the driver is event driven..

Yeah rolling everything over to event passing and message queues would
sort this out a lot. It's kinda not where we are though.

> I can understand that adding the shootdown logic all over the place
> would be hard and you'd get it wrong.
> 
> But so is half removing the driver while it is doing *anything* and
> trying to mitigate that with a different kind of hard to do locking
> fix. *shrug*

The thing is that rust helps you enormously with implementing revocable
resources and making sure you're not cheating with all the bail-out paths.

It cannot help you with making sure you have interruptible/abortable
sleeps in all the right places. Yes this is a bit a disappointment, but
fundamentally rust cannot model negative contexts (unlike strictly
functional languages like haskell) where certain operations are not
allowed. But it is much, much better than C at "this could fail, you must
handle it and not screw up".

In some cases you can plug this gap with runtime validation, like fake
lockdep contexts behind the might_alloc_gfp() checks and similar tricks
we're using on the C side too. Given that I'm still struggling with
weeding out design deadlocks at normal operations. For example runtime pm
is an absolute disaster on this, and a lot of drivers fail real bad once
you add lockdep annotations for runtime pm. I'll probably retire before I
get to doing this for driver unload.

> >   This is why I like the rust Revocable so much, because it's a normal rcu
> >   section, so disallows all sleeping. You might still deadlock on a busy
> >   loop waiting for hw without having a timeout. But that's generally
> >   fairly easy to spot, and good drivers have macros/helpers for this so
> >   that there is always a timeout.
> 
> The Recovable version narrows the critical sections to very small
> regions, but having critical sections at all is still, IMHO, hacky.
> 
> What you should ask Rust to solve for you is the infinite waits! That
> is the root cause of your problem. Compiler enforces no waits with out
> a revocation option on DRM callbacks!
> 
> Wouldn't that be much better??

It would indeed be nice. I haven't seen that rust unicorn yet though, and
from my understanding it's just not something rust can give you. Rust
isn't magic, it's just a tool that can do a few fairly specific things a
lot better than C. But otherwise it's still the same mess.

> >   drm_dev_unplug uses sleepable rcu for practicality reasons and so has a
> >   much, much higher chance of deadlocks. Note that strictly speaking
> >   drm_device should hold a module reference on the driver, but see above
> >   for why we don't have that - developers prefer convenience over
> >   correctness in this area.
> 
> Doesn't DRM have a module reference because the fops is in the driver
> and the file core takes the driver module reference during
> fops_get()/replace_fops() in drm_stub_open()? Or do I misunderstand
> what that stub is for?
> 
> Like, I see a THIS_MODULE in driver->fops == amdgpu_driver_kms_fops ?

Yeah it's there, except only for the userspace references and not for the
kernel internal ones. Because developers get a bit prickle about adding
those unfortunately due to "it breaks module unload". Maybe we just should
add them, at least for rust.

> > We can and should definitely try to make this much better. I think we can
> > get to full correctness wrt the first 3 lifetime things in rust. I'm not
> > sure whether handling module unload/.text lifetime is worth the bother,
> > it's probably only going to upset developers if we try. 
> 
> It hurts to read a suggestion we should ignore .text lifetime rules :(
> DRM can be be like this, but please don't push that mess onto the rest
> of the world in the common rust bindings or common rust design
> patterns. Especially after places have invested alot to properly and
> fully fix these problems without EAF bugs, infinite wait problems or
> otherwise.
> 
> My suggestion is that new DRM rust drivers should have the file
> operations isolation like RDMA does and a design goal to have
> revocable sleeps. No EAF issue. You don't have to fix the whole DRM
> subsystem to get here, just some fairly small work that only new rust
> drivers would use. Start off on a good foot. <shrug>

You've missed the "it will upset developers part". I've seen people remove
module references that are needed, to "fix" driver unloading.

The other part is that rust isn't magic, the compiler cannot reasons
through every possible correct api. Which means that sometimes it forces a
failure path on you that you know cannot ever happen, but you cannot teach
the compiler how to prove that. You can side-step that by runtime death in
rust aka BUG_ON(). Which isn't popular really either.

The third part is that I'm not aware of anything in rust that would
guarantee that the function pointer and the module reference actually
belong to each another. Which means another runtime check most likely, and
hence another thing that shouldn't fail which kinda can now.

Hence my conclusion that maybe it's just not the top priority to get this
all perfect.

Cheers, Sima

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

