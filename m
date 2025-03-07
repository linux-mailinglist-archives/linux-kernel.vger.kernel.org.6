Return-Path: <linux-kernel+bounces-551124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320AA56879
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ABF2177A64
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F02219A97;
	Fri,  7 Mar 2025 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hDdyBC3G"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297028E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352958; cv=none; b=QT3VrPNXuX+1PEipm6Qvn12FWQycqVT+RSybmy9ba2ohcIqvbNU64vGmAo9qLLw1IrSUbo7P9jKDH9ps7Io3Xr6vCWQMLn+L5fC2EL/tNlaPqv8wqZStYRiKWf+RbnpOoAzlS13MIMchWm44sl+sCvM3UVmZrcYuLlZMvbFm2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352958; c=relaxed/simple;
	bh=b/c+EwYUHehXR7B1azTRJ4LvPuPfsGVQQ98vVvUU8KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHqxYJoP/pQNijBAABcB1yweqtDFdJMfsRbmzWHqwMChx7Hx7zE0ioBZyqW85gzkMM3SwplrRag0kc3jSunuWStohNVkkvjvZIDmlkz8o7edKfAmBGbZks/1QDrDHVPqkzwz6OnwR2KEPiPF1HV+Pw7eOxckLsLqPYSiUT3g2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hDdyBC3G; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso20644275e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741352955; x=1741957755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLXbK1kB32hdkos1OXYsIkc5qxoXTv1ZW+nI08u1/9M=;
        b=hDdyBC3GnngCcTiqKIWlXvHtJr6oFMxs0w7+XF9Ej962ECGzRbyN4x9sQD7SSXxtHi
         oHYpG5VwYhYOQsMH/RcYHaGz9+n2hXavCj++w8mlr6kqc2Y62MtmW/A4DmXnIJAaA0Rx
         IcH3T+JtiWhwlYeSIBSnskR11qjY5xQ+rtZ9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741352955; x=1741957755;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLXbK1kB32hdkos1OXYsIkc5qxoXTv1ZW+nI08u1/9M=;
        b=eCXXF3qpVh9D3T81YZJTQV8YDOkcndMB8OAG8Y0Egu3fJZTm/qNKqUOqIUVTEeHce6
         kFvrbI0wBIGbT6k8Goo3ZEswsuFI/BCPAqqtN7ZHuCv9//jK1oG785ij81SZuP6Rmaew
         xbNeWgtORG9BPWT0rWvEUXhpHjppaW2mCcIZsu/Id8rqNl8g50HkWaZdWhrqrMcBQ0B3
         LAixc+MJ5C3GUwgg2A46WQSZ88zKfGVaa2AC2mIMzko1YtG1U59ibceKbcDc+jNIes7e
         yuDCVq65hXd3vUJw+Tb3dM99uOuNvI7ztg2rSNhN0p/Uf/rXRFxVt8ei+HYw+2mIpGX0
         A/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQDpA7+dVRU+awDarr7QMKNNMyQBzA9WDBPv+18kAGbvg02uexIKNpFPPYwCbNzw5PP2fRGxQAGZgNW0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwgFyGTG+TMDP1OmHLHg4toIFa0+HmMnJXS9FMoSj6QGBILbq
	Yvf7p9/pRbPo3rg5WBF9IVMsLFVKEqigHttio5m8y38MgY4iUtofRk7PaM2BOZM=
X-Gm-Gg: ASbGncvA4zYYCifBtrOuV0mxxE+Zr+aaxn1o8xMid11TPm0vHfloAdcc55JHnvClRQJ
	1yJmFEsisxvsE2U8DUw2ek68D13zQvYe9ykg2juP40LhTsiFc5Non0Sf9yK5lm6iV6XvpXC9CPn
	qUc4wT/ZXKevwiDwqRzPlaF5skIhKAqMcNDD3fxrY+nXOsjAQUCpY95QG6Z4CCPOSjo1Qid5+KX
	bXO74jak0DQbMMXNIcavEFFOWmvueeKGnUYoIxiQIELzukMa2ZgSpxz1fq2QnplZGNxtJI1tknC
	CcMriwIo8SORGWFqEZRaaIZ3Iz0RKcetJMrv6wo0iTvOTBk282YoFTQl
X-Google-Smtp-Source: AGHT+IGXKnB7QtBKk8gCa+TlzYNbGzQEnm9bXI6Rnch3Ew5gX/H5UMUN/1g1KPRfZAkAjvrureRPLg==
X-Received: by 2002:a5d:6c63:0:b0:390:f0f3:138a with SMTP id ffacd0b85a97d-39132d5b4bfmr3104340f8f.27.1741352954934;
        Fri, 07 Mar 2025 05:09:14 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcb8sm5384143f8f.33.2025.03.07.05.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:09:14 -0800 (PST)
Date: Fri, 7 Mar 2025 14:09:12 +0100
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
Message-ID: <Z8rv-DQuGdxye28N@phenom.ffwll.local>
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
References: <Z8GViQzZJVFPxfNd@phenom.ffwll.local>
 <20250228184013.GF39591@nvidia.com>
 <Z8cmBWB8rl97-zSG@phenom.ffwll.local>
 <20250304164201.GN133783@nvidia.com>
 <Z8f9mgD4LUJN_dWw@phenom.ffwll.local>
 <20250305151012.GW133783@nvidia.com>
 <Z8l8HgZOV7sDWqBh@phenom.ffwll.local>
 <20250306153236.GE354511@nvidia.com>
 <Z8rKVZolu8n6lB1P@phenom.ffwll.local>
 <20250307123255.GK354511@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307123255.GK354511@nvidia.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Fri, Mar 07, 2025 at 08:32:55AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 07, 2025 at 11:28:37AM +0100, Simona Vetter wrote:
> 
> > > I wouldn't say it is wrong. It is still the correct thing to do, and
> > > following down the normal cleanup paths is a good way to ensure the
> > > special case doesn't have bugs. The primary difference is you want to
> > > understand the device is dead and stop waiting on it faster. Drivers
> > > need to consider these things anyhow if they want resiliency against
> > > device crashes, PCI link wobbles and so on that don't involve
> > > remove().
> > 
> > Might need to revisit that discussion, but Greg didn't like when we asked
> > for a pci helper to check whether the device is physically gone (at least
> > per the driver model). Hacking that in drivers is doable, but feels
> > icky.
> 
> I think Greg is right here, the driver model has less knowledge than
> the driver if the device is alive.

Maybe I misremember, but iirc he was fairly fundamentally opposed to
trying to guess whether the hw is gone or not in the ->remove callback.
But maybe that's more from the usb world, where all the hotremove race
conditions are handled in the subsystem and you only have to deal with
errno from calling into usb functions and unwind. So much, much easier
situation.

> The resiliency/fast-failure issue is not just isolated to having
> observed a proper hot-unplug, but there are many classes of failure
> that cause the device HW to malfunction that a robust driver can
> detect and recover from. mlx5 attempts to do this for instance.
> 
> It turns out when you deploy clusters with 800,000 NICs in them there
> are weird HW fails constantly and you have to be resilient on the SW
> side and try to recover from them when possible.
> 
> So I'd say checking for a -1 read return on PCI is a sufficient
> technique for the driver to use to understand if it's device is still
> present. mlx5 devices further have an interactive register operation
> "health check" that proves the device and it's PCI path is alive.
> 
> Failing health checks trigger recovery, which shoot downs sleeps,
> cleanly destroys stuff, resets the device, and starts running
> again. IIRC this is actually done with a rdma hot unplug/plug sequence
> autonomously executed inside the driver.
> 
> A driver can do a health check immediately in remove() and make a
> decision if the device is alive or not to speed up removal in the
> hostile hot unplug case.

Hm ... I guess when you get an all -1 read you check with a specific
register to make sure it's not a false positive? Since for some registers
that's a valid value.

But yeah maybe this approach is more solid. The current C approach we have
with an srcu revoceable section is definitely a least worse attempt from a
very, very bad starting point.

I think maybe we should also have two levels here:

- Ideal driver design, probably what you've outlined above. This will need
  some hw/driver specific thought to get the optimal design most likely.
  This part is probably more bus and subsystem specific best practices
  documentation than things we enforce with the rust abstractions.

- The "at least we don't blow up with memory safety issues" bare minimum
  that the rust abstractions should guarantee. So revocable and friends.

And I think the latter safety fallback does not prevent you from doing the
full fancy design, e.g. for revocable resources that only happens after
your explicitly-coded ->remove() callback has finished. Which means you
still have full access to the hw like anywhere else.

Does this sounds like a possible conclusion of this thread, or do we need
to keep digging?

Also now that I look at this problem as a two-level issue, I think drm is
actually a lot better than what I explained. If you clean up driver state
properly in ->remove (or as stack automatic cleanup functions that run
before all the mmio/irq/whatever stuff disappears), then we are largely
there already with being able to fully quiescent driver state enough to
make sure no new requests can sneak in. As an example
drm_atomic_helper_shutdown does a full kernel modesetting commit across
all resources, which guarantees that all preceeding in-flight commits have
finished (or timed out, we should probably be a bit smarter on this so the
timeouts are shorter when the hw is gone for good). And if you do that
after drm_dev_unplug then nothing new should have been able to sneak in I
think, at least conceptually. In practice we might have a bunch of funny
races that are worth plugging I guess.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

