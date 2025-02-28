Return-Path: <linux-kernel+bounces-538379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7414A497CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698C43BB9D4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699125F97B;
	Fri, 28 Feb 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RUk45548"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040E1B4250
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739984; cv=none; b=rFzeq7wGACf+eQevakTUOuViGjAa0Jj3xbkxXWqZYc9W6FeG4rtaHNG9iLYuJ0yWrcUaGcweTrDygIhjzYf0HPK8X9E1A/nTazTZhYQEjyApF3bRMxaQsPT2IyJsFIKq56FnZmDRP50lWfquAAZp/Z7Oa+ROVhZnz7G20KrRpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739984; c=relaxed/simple;
	bh=etzCuJOZIdAqEw0MayW324uOf86sWw2yZObHOVHQCfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwMWOppKg9H25pLfcE3w6vHYT0TL81nIHam5J8o63K7rdpy5SuaBZ3kEiEdz3P2OXMqVtsdlA65FP8kuWRMfcYLW2j7uk8U64Zrbdlr+fTKEKbLmrqAXTCKwAAQpu37GVmGboxxsUh6ilLOQBd8DM1NyS+Lc0razSPFcGBUQQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=RUk45548; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so13826025e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1740739981; x=1741344781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fGKkYkU92AKIEtoBhTzOtqV6Umxi/0b1IQGfdOiR18=;
        b=RUk45548NQvW9HA3EkjSKTJaJbuEbCvy+Q+qBiTsh9V+wInO4TI9/ZpIszs689B1x/
         Js6qiGIW9howt1vAiX4GbBYmzVveMQouY66jaUei4nrSmt7wpP+XgXNAfOzsWFmx1Ohg
         3Qjg0no4XzOZqdzupT6hL/3YUh0x86p7skZjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740739981; x=1741344781;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fGKkYkU92AKIEtoBhTzOtqV6Umxi/0b1IQGfdOiR18=;
        b=S+uM2Uh/nq2iVttIdnPTS/R9zkN6ZwIS7QhbssRpwzClkVAlsCD8oF/T/A1L1UFrv5
         tTK2eNr3mn4N1Xo4D+fG/DGJ09/3chI56mLEOt3g3WXXqpzZ3H2I/EWb3ujb/y8oya/a
         /zbFW/N+pSbwr1Ieo0uqSN5UAWkzbXhdcPOHgIJPhD3uFzWhCvVNzTl/t1EBgAVhiCwc
         dk5J8LBJDDpbFKcPmfghfpdNIPLakzyTx6DBf7ya+4YiERY3FZoglPr8EjUQzZNKq/mP
         mbCeZqIjeVdzZ6VV4MPUPay3OM44bLNWjqgOmShtAd1LMJy40tngH9MOuPA2DP0+lhhB
         BSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0FRBeXOhGo/s7ea2kpzAnTi31ZAHENXQ8zmeqIDr/D+fhzy6ufbu2QJxSZGQ5zXRzJ4V7WGLtktw1Tzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSci76sLrAIKndlBh34ez9P1EIxUPhHcLO36ZrquunrizTDZ1c
	S9ge0G+rqQfcPsAcigYC6JKMAJVN/nEurQUvvjKdT0844KDo6sUPBdfxKE8HEek=
X-Gm-Gg: ASbGncuKVEsx/4KGtdxY0d/GsNztCYWWiDMrLfyuYOQw/3Nti5lvdL+kT8nOYo7B2xl
	7EiVpXlO1Vmvhwfjl8gGNWFsLQZNU358GJ7uiUwnfVOe/xZe5zQwrZW5UfccJRihUQUfeSDCmzC
	G4hByUIwN40vWtdmkGFe4yvnISN92zATkLW5+2dnjCLQj6opevGshxXgpljIJZbaBAdvh7GbLxJ
	ifrm8AlsLz9LEnbE0dzVkmLbkMywsuC4p16nEYRvDCj23ZxNJvrysdXA071Rkj5XsHG+Ntrl5h+
	6ISmgD8wA8UDmkpqdUEPIjLn/C4F/74RQAW1zQ==
X-Google-Smtp-Source: AGHT+IGzMK22OAqSxJRJToDbcyGmm49ADbSw6MIeJDyMnFgiltwXHFIghIXm6aj4rubMHLy1CtzTYg==
X-Received: by 2002:a05:600c:468e:b0:439:8e3e:b0d6 with SMTP id 5b1f17b1804b1-43ba67045femr23509435e9.13.1740739980068;
        Fri, 28 Feb 2025 02:53:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5393e5sm83131255e9.20.2025.02.28.02.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:52:59 -0800 (PST)
Date: Fri, 28 Feb 2025 11:52:57 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <Z8GViQzZJVFPxfNd@phenom.ffwll.local>
Mail-Followup-To: John Hubbard <jhubbard@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Dave Airlie <airlied@gmail.com>, Gary Guo <gary@garyguo.net>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ben Skeggs <bskeggs@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	paulmck@kernel.org
References: <20250225210228.GA1801922@joelnvbox>
 <20250225225756.GA4959@nvidia.com>
 <Z75WKSRlUVEqpysJ@cassiopeiae>
 <20250226004916.GB4959@nvidia.com>
 <Z75riltJo0WvOsS5@cassiopeiae>
 <20250226172120.GD28425@nvidia.com>
 <Z7-IHgcVVS8XBurW@cassiopeiae>
 <20250226234730.GC39591@nvidia.com>
 <2025022644-fleshed-petite-a944@gregkh>
 <D82UB3V6NZ55.3OEPPW2W8MFZV@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D82UB3V6NZ55.3OEPPW2W8MFZV@nvidia.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Wed, Feb 26, 2025 at 05:34:01PM -0800, John Hubbard wrote:
> On Wed Feb 26, 2025 at 5:02 PM PST, Greg KH wrote:
> > On Wed, Feb 26, 2025 at 07:47:30PM -0400, Jason Gunthorpe wrote:
> >> The way misc device works you can't unload the module until all the
> >> FDs are closed and the misc code directly handles races with opening
> >> new FDs while modules are unloading. It is quite a different scheme
> >> than discussed in this thread.
> >
> > And I would argue that is it the _right_ scheme to be following overall
> > here.  Removing modules with in-flight devices/drivers is to me is odd,
> > and only good for developers doing work, not for real systems, right?
> 
> Right...I think. I'm not experienced with misc, but I do know that the
> "run driver code after driver release" is very, very concerning.
> 
> I'm quite new to drivers/gpu/drm, so this is the first time I've learned
> about this DRM behavior...

It's really, really complicated, and not well documented. Probably should
fix that. The issue is that you have at least 4 different lifetimes
involved here, and people mix them up all the time and get confused. I
discuss 3 of those here:

https://lists.freedesktop.org/archives/intel-xe/2024-April/034195.html

The 4th is the lifetime of the module .text section, for which we need
try_module_get. Now the issue with that is that developers much prefer
convenience over correctness on this, and routinely complain _very_ loudly
about "unnecessary" module references. They're not, but to break the cycle
that Jason points out a bit earlier you need 2 steps:

- Nuke the driver binding manually through sysfs with the unbind files.
- Nuke all userspace that might beholding files and other resources open.
- At this point the module refcount should be zero and you can unload it.

Except developers really don't like the manual unbind step, and so we're
missing try_module_get() in a bunch of places where it really should be.

Now wrt why you can't just solve this all at the subsystem level and
guarantee that after drm_dev_unplug no code is running in driver callbacks
anymore:

In really, really simple subsystems like backlight this is doable. In drm
with arbitrary ioctl this isn't, and you get to make a choice:

- You wait until all driver code finishes, which could be never if there's
  ioctl that wait for render to complete and don't handle hotunplug
  correctly. This is a deadlock.

  In my experience this is theorically possible, practically no one gets
  this right and defacto means that actual hotunplug under load has a good
  chance of just hanging forever. Which is why drm doesn't do this.

- You make the revoceable critical sections as small as possible, which
  makes hotunplug much, much less likely do deadlock. But means that after
  revoking hw access you still have arbitrary driver code running in
  callbacks, and you need to deal with.

  This is why I like the rust Revocable so much, because it's a normal rcu
  section, so disallows all sleeping. You might still deadlock on a busy
  loop waiting for hw without having a timeout. But that's generally
  fairly easy to spot, and good drivers have macros/helpers for this so
  that there is always a timeout.

  drm_dev_unplug uses sleepable rcu for practicality reasons and so has a
  much, much higher chance of deadlocks. Note that strictly speaking
  drm_device should hold a module reference on the driver, but see above
  for why we don't have that - developers prefer convenience over
  correctness in this area.

> > Yes, networking did add that functionality to allow modules to be
> > unloaded with network connections open, and I'm guessing RDMA followed
> > that, but really, why?
> >
> > What is the requirement that means that you have to do this for function
> > pointers?  I can understand the disconnect issue between devices and
> > drivers and open file handles (or sockets), as that is a normal thing,
> > but not removing code from the system, that is not normal.
> >
> 
> I really hope that this "run after release" is something that Rust for
> Linux drivers, and in particular, the gpu/nova*, gpu/drm/nova* drivers,
> can *leave behind*.
> 
> DRM may have had ${reasons} for this approach, but this nova effort is
> rebuilding from the ground up. So we should avoid just blindly following
> this aspect of the original DRM design.

We can and should definitely try to make this much better. I think we can
get to full correctness wrt the first 3 lifetime things in rust. I'm not
sure whether handling module unload/.text lifetime is worth the bother,
it's probably only going to upset developers if we try. At least that's
been my experience.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

