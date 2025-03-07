Return-Path: <linux-kernel+bounces-550876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332DBA5653A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2A01894BB2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E420E302;
	Fri,  7 Mar 2025 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MHOvxVkk"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE881B392B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343324; cv=none; b=oIqNwr2UXiTFxxDfKe77oNZw93WDn0r2Ci/KGb4YKV9az5CnvkfSnjAtM5kK7+bQhALRvVBXCp9i4NrzjJ9UWE/UigZqhZsImlmg2s6OkSQ0KziP4vR18ZV3T+zysjEEfrC+ap5/iry1cdVeWGRDR+Svq4xSxbx9KOZNsv+UFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343324; c=relaxed/simple;
	bh=zXH71BfDtdTjFlS8jDiAJVkO9AR569+vdz/KAu3ChhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2BAgvTnTpk/lfaBL/wgql6XGqfffTRFJI6TdvlwqWzg3KMiYAhWMBZOSL5bFl5Kcgvon3Cmdsl3k6Dcf5dTh678PyPKIqS+M9weynpf9SxggZXyZlrf5+CqUoGLHnHsonuad8ZerjFG+tDBKW3Nr+FMJ88Z1Be5frDjS3+zHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=MHOvxVkk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so10133335e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741343320; x=1741948120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLOoQkl6hkv1bWsp3aSpxVd+aCFLRfs2J3JgKPuyRtU=;
        b=MHOvxVkk5O9JOyyyJFbgy2mPzFT2nnurZgPC/qViaASbu06kEa1bTM5Hl86CwAjX2c
         a/91unDnmK8S1/P+2ox2luz7RDMeDcPEEQr79aZMbeNvVOLNH8pWVZDed4RD8TJPZZP9
         iMM1gKLLFNf2fmV4Q/J21LX8oa2b2PGDLgaxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343320; x=1741948120;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLOoQkl6hkv1bWsp3aSpxVd+aCFLRfs2J3JgKPuyRtU=;
        b=tgnKbuOgYVl5FRHL0ljoqaHQ7uMpR4VkGDHotY4aDcd/7a3IEIfZudkPz5gUd/lYj2
         m7QVeuGrrbOplw6YEO1FsnhJBYFwUHCItAHr8kS55ZOCOf8NtyjWdbUEXHhMnwvx9S71
         OWPcrDkK82wivZ6X7qyAJoKgVk12qEwfyb27mP14PDf/qU/WrcPLAV2n0qRbuE7NJgmH
         QNxl/ETjA8DIyP8KlzsVo5ojZWgy0XKxMWP/v5sVAa1UT7RJkM83iH+1UENZ/JHaMHD7
         JvnqEHaONCQYG0gzSqywzVCcoIz9yvBtZ8xG2NkMi2EZFMH9hRkNdhEJtEEnIQ1Ua/Pp
         QJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5GoSbpCTMPBf2qSQAk5qeTuJ2PXVqXfQc0o14Cn2dKMR/q2SyIJoqFgP2htOibb+0+yhoT29sONS6Lrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZpZPKlW7Izn9ccXo3yF95WV7DdiYma3z8ltYMEZulWcvKDpR
	5x9nxGKUZ/jzoGrIlXXzP61RQD3LZiVKT2C1m+5Bc1RD4nREF5mcbvUbD8GgpOA=
X-Gm-Gg: ASbGncvNEcMk0ATHir3XZHJKcUpF1WQxOBvzPCH7kNgumUlZd4TXnn17dgUopFMXjmI
	ScGWObgruR9Eh0wXVKK0d8f4pPyx2J2afsPcWhiAopbIFCApTl0WLomTTUMn+zZ8O8golVR9jsK
	WLCB2gbcb7abzrKBCXjDMKbSYyIDghWIB1arB10sOJxlaBZG0blSjWuSyEtbTZccKuD657YrSQd
	dajabG7fHdvFI6Wps2jlIjI/ScZwcoPkxVLsGijPH7y4CSBEzX9lN1lq1IuyXrMZcPnHbG6b1SW
	uilqHj177d+ApSKf5jsRCSzhbmVxNrL/GX/wW9jqTeKa7lFqTKWbGxsd
X-Google-Smtp-Source: AGHT+IEXqPg4ntpIBJrKqJUmhFhVvUeMVHQTUghTZcJWrf+11xUWOEGUbhcEz08DJwh4IgeUGuaIlA==
X-Received: by 2002:a5d:64c5:0:b0:38f:4b15:32f1 with SMTP id ffacd0b85a97d-39132de3ef7mr1902737f8f.54.1741343320431;
        Fri, 07 Mar 2025 02:28:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd93cc2esm46469755e9.30.2025.03.07.02.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:28:39 -0800 (PST)
Date: Fri, 7 Mar 2025 11:28:37 +0100
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
Message-ID: <Z8rKVZolu8n6lB1P@phenom.ffwll.local>
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
References: <2025022644-fleshed-petite-a944@gregkh>
 <D82UB3V6NZ55.3OEPPW2W8MFZV@nvidia.com>
 <Z8GViQzZJVFPxfNd@phenom.ffwll.local>
 <20250228184013.GF39591@nvidia.com>
 <Z8cmBWB8rl97-zSG@phenom.ffwll.local>
 <20250304164201.GN133783@nvidia.com>
 <Z8f9mgD4LUJN_dWw@phenom.ffwll.local>
 <20250305151012.GW133783@nvidia.com>
 <Z8l8HgZOV7sDWqBh@phenom.ffwll.local>
 <20250306153236.GE354511@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306153236.GE354511@nvidia.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Mar 06, 2025 at 11:32:36AM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 06, 2025 at 11:42:38AM +0100, Simona Vetter wrote:
> > > Further, I just remembered, (Danilo please notice!) there is another
> > > related issue here that DMA mappings *may not* outlive remove()
> > > either. netdev had a bug related to this recently and it was all
> > > agreed that it is not allowed. The kernel can crash in a couple of
> > > different ways if you try to do this.
> > > 
> > > https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/#m0c7dda0fb5981240879c5ca489176987d688844c
> > 
> > Hm for the physical dma I thought disabling pci bust master should put a
> > stop to all this stuff?
> 
> Not in the general case. Many device classes (eg platform) don't have
> something like "PCI bus master". It is also not always possible to
> reset a device, even in PCI.
> 
> So the way things work today for module reload relies on the driver
> duing a full quiet down so that the next driver to attach can safely
> start up the device. Otherwise the next driver flips PCI bus master
> back on and immediately UAFs memory through rouge DMA.
> 
> Relying on PCI Bus master also exposes a weakness we battled with in
> kexec. When the new driver boots up it has to gain control of the
> device and stop the DMA before flipping "PCI Bus Master" off. Almost
> no drivers actually do this, and some HW can't even achieve it without
> PCI reset (which is not always available). Meaning you end up with a
> likely UAF flow if you rely on this technique.

Yeah this gets really hairy really fast. We might need some pragmatism
here of not being able to be better than C.

And the entire "load driver after previously the linux driver messed with
it already" is a very broad issue, from rebinding to module reload to
kexec. With some hw it's just not possible to do safely, and with a lot
more hw not reliably due to complexity. E.g. drm/i915/display can take
over the gpu if outputs are enabled and fully recover hw state into sw
state. But defacto that only works for configurations the fw/bootloader
leaves behind, and not in full generality. Plus we don't handle
misprogrammed hw at all.

> > For the sw lifecycle stuff I honestly didn't know that was an issue, I
> > guess that needs to be adressed in the dma-api wrappers or rust can blow
> > up in funny ways. C drivers just walk all mappings and shoot them.
> 
> I wonder what people will come up with. DMA API is performance path,
> people are not going to accept pointless overheads there.
> 
> IMHO whatever path the DMA API takes the MMIO design should follow
> it.

I think this needs to be subsystem specific, since very often there's
already data structures to track all mappings, and so easy to add a bit of
glue to nuke them all forcefully. Or at least data structures to track all
pending requests, and so again we can enforce that we stall for them all
to finish.

We'll probably end up with rust bindings being a lot more opinionated
about how a driver should work, which has the risk of going too far into
the midlayer mistake antipattern. I guess we'll see how that all pans out.

> > The trouble is that for real hotunplug, you need all this anyway. Because
> > when you physically hotunplug the interrupts will be dead, the mmio will
> > be gone any momem (not just at the beginnning of an rcu revocable
> > section), so real hotunplug is worse than what we're trying to do here.
> 
> There are two kinds of real hotunplug, the friendly kind that we see
> in physical PCI where you actually plonk a button on the case and wait
> for the light to go off. Ie it is interactive and safe with the
> OS. Very similar to module reloading.
> 
> And the hostile kind, like in thunderbolt, where it just goes away and
> dies.
> 
> In the server world, other than nvme, we seem to focus on the friendly
> kind.

Yeah gpus tend to hang out in external enclosures sometimes, so I'm not
sure we can ignore the hostile kind.

> > So randomly interrupts not happening is something you need to cope with no
> > matter what.
> 
> Yes
>  
> > But for a driver unbind you _do_ have to worry about cleanly shutting down
> > the hardware. For the above reasons and also in general putting hardware
> > into a well-known (all off usually) state is better for then reloading a
> > new driver version and binding that. Except that there's no way to tell
> > whether your ->remove got called for unbinding or hotunplug.
> 
> IMHO it doesn't really matter, the driver has to support the most
> difficult scenario anyhow. The only practical difference is that the
> MMIO might return -1 to all reads and the interrupts are dead. If you
> want to detect a gone PCI device then just do a register read and
> check for -1, which some drivers like mlx5 are doing as part of their
> resiliency strategy.
> 
> > pci device was physically unplugged or not, and so for developer
> > convenience most pci drivers go with the "cleanly shut down everything"
> > approach, which is the wrong thing to do for actual hotunplug.
> 
> I wouldn't say it is wrong. It is still the correct thing to do, and
> following down the normal cleanup paths is a good way to ensure the
> special case doesn't have bugs. The primary difference is you want to
> understand the device is dead and stop waiting on it faster. Drivers
> need to consider these things anyhow if they want resiliency against
> device crashes, PCI link wobbles and so on that don't involve
> remove().

Might need to revisit that discussion, but Greg didn't like when we asked
for a pci helper to check whether the device is physically gone (at least
per the driver model). Hacking that in drivers is doable, but feels icky.

> Regardless, I think the point is clear that the driver author bears
> alot of responsibility to sequence this stuff correctly as part of
> their remove() implementation. The idea that Rust can magically make
> all this safe against UAF or lockups seems incorrect.

Agreed, it's not pure magic. I do think it can help a lot though, or at
least I'm hoping.

> > > Ah.. I guess rust would have to validate the function pointers and the
> > > THIS_MODULE are consistent at runtime time before handing them off to
> > > C to prevent this. Seems like a reasonable thing to put under some
> > > CONFIG_DEBUG, also seems a bit hard to implement perhaps..
> > 
> > We should know the .text section of a module, so checking whether a
> > pointer is within that shouldn't be too hard.
> 
> It is legal to pass a pointer to a function in a module that this
> module is linked to as well. We do that sometimes.. Eg a fops having a
> simple_xx pointer. So you'd need to do some graph analysis.

Hm right, indirect deps are fine too ...

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

