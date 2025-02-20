Return-Path: <linux-kernel+bounces-523325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD54A3D51B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E8A189E995
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA01F12F7;
	Thu, 20 Feb 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GxPXFHn+"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EB1F03D9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044608; cv=none; b=SjbNYzfAutYAmfgrTpOSPgKWQucgKjHBZCGsZbizmg02VS+PjaJYWa2jQDM97EL6/ZCNonSydOXmcIgOJ05rhoLDHTSmyAJypsAvMYDne/Jf5hXQ6xBDjb0xcRNMXtdqY6EXDGJF2iUv2GzZFH0qysU6HYZkXNnDDTra/Dpk/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044608; c=relaxed/simple;
	bh=h9b2FnWVwwciHoBg5V5JuZH2Ebp0YuSmbw/KY+eQtvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5XreOsCRekBq1d21XoGw8pqqHvSR+sOLqgJ+0uJZXxam49DVHVT7D40SO10mZ3b0UXpSBl3Wu8pfZyS4yzhp2P1a/NAdGR7RXVSxqwLscznL6B5vN1V+j/QIgpYpUvflNAr8BduuPBsNHWu8DFS3Z2wvc3e1seYbbwV4EeBYK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=GxPXFHn+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-439950a45daso3906435e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1740044605; x=1740649405; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=guAfwMbBAlVjvK3VuLHUF0DIE+spgkoUA/PzEWb2TpA=;
        b=GxPXFHn+SoVc3+NtuR4MCjgvSzQBMRVo9yDya5CuneMcM/W+klvz735Ln94+ugcRTB
         yybT9Kqn3i/cYAK0PWwfzlkTrnPeqdsD4hv2Y6knNhdlWJZWWzqFBqemuyiJ4QAodS8D
         00OTp340R18FSEv++ofKmg+4nBVm/s65xL+UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044605; x=1740649405;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guAfwMbBAlVjvK3VuLHUF0DIE+spgkoUA/PzEWb2TpA=;
        b=YuSj8+7U+mPO9JjuvJcFqWx7pACyX5azYLha7FUS8AMhSGRqflDSMUpge3nsuF1s7I
         yAecFbyGQwr2QOCn4ZuVc9tvmyEOHNyz/gTyC+FBTcgs8oed3ukrJnIA2xa6IGXD+war
         rcOZpk+2dL01a5T99XKpAdv4+t2mXf3v5ufM/WIo9zOxvPc51ACVATW/YQiGIkJG9WT/
         BHrGcAXHOwliCcT66v0JVVKYLszpWmHAIi1RFh3Kg5xMnUPq48uypf5gIDwm29wEyy4Z
         gn7X9F1j8cSWPZyyghwBDphj+YNH8c+YBu0jj9Iuus11qZtAGos2W0I12TgFWTDE0PCq
         WsrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2YHl1jBMJ4akXDRsV7QXB8Qo5F4IO7rH9M5GJVcWGdMntJIxHGE3RSm3ad4bteOZZWBGIO2+xA90XUNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZn872PPvhlnU8GSDnGBrirj3w59s25IyVvriMvmGdHuHBTtlm
	JVIUlqTE9FiVFeJ6VBcf7cJvsAkTOy3Y/tHPuv8pGGp8M51MeO7yYCHqlnxpkjA=
X-Gm-Gg: ASbGncsKzkaD+mWuY3lMCywp6TRCbVx840U8LY84yPwz0CFP5p6Bah9pOIXsbdbQ21s
	8LVhyR8d70eiJRosS5dvw7Ch6zhjfKLm3BGIDGpWVT9SCo9Ydy6l1PjkT5Iownfsnh9iIwsqkDR
	oIyK40LMhIzeB5fyzofGZxlOoaHytic9cPTQxwct2oefK1nGrL4vdLhN9n5CTEywLFYfVJeqXit
	YbpiL7TlBKdVS9zO2N4I/IB2P3uDj2fLIOUf21zaYV1kRtC6GTtgUYitMr1ZJKIoWFrG8mVXl6a
	3S0bGXcs1gtMyw+bwSxpwoQ9ciA=
X-Google-Smtp-Source: AGHT+IHHEsvn6oRv8+A2u/h+XLrPBcAp6Uc0A8BIJ/Z3QJPo/ZbtBgNqFitcwPB5Q9VlxDMnG5XX6w==
X-Received: by 2002:a05:600c:870f:b0:439:84ba:5773 with SMTP id 5b1f17b1804b1-43984ba5989mr146741085e9.31.1740044604425;
        Thu, 20 Feb 2025 01:43:24 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43990f53847sm85530425e9.1.2025.02.20.01.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:43:23 -0800 (PST)
Date: Thu, 20 Feb 2025 10:43:21 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	jose.exposito89@gmail.com, dri-devel@lists.freedesktop.org,
	arthurgrillo@riseup.net, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	nicolejadeyee@google.com
Subject: Re: [PATCH RFC v2 00/16] drm/vkms: ConfigFS interface
Message-ID: <Z7b5OcewxCEsDGo9@phenom.ffwll.local>
Mail-Followup-To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	jose.exposito89@gmail.com, dri-devel@lists.freedesktop.org,
	arthurgrillo@riseup.net, linux-kernel@vger.kernel.org,
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com, seanpaul@google.com,
	nicolejadeyee@google.com
References: <20241122-google-config-fs-v2-0-4b7e6f183320@bootlin.com>
 <Z0DC8nd1ZFN4A82-@louis-chauvet-laptop>
 <20241126-overjoyed-knowing-cuttlefish-c8d0f6@houat>
 <Z2GqEOiVkdgB3IXy@louis-chauvet-laptop>
 <20250219-versatile-smilodon-of-felicity-cbcc4d@houat>
 <Z7XZYVs6LL1gEzIF@phenom.ffwll.local>
 <4e0d66f7-6234-4265-bfbb-a919224ecb2a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e0d66f7-6234-4265-bfbb-a919224ecb2a@bootlin.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Wed, Feb 19, 2025 at 05:28:37PM +0100, Louis Chauvet wrote:
> Le 19/02/2025 à 14:15, Simona Vetter a écrit :
> > On Wed, Feb 19, 2025 at 10:28:56AM +0100, Maxime Ripard wrote:
> > > On Tue, Dec 17, 2024 at 05:42:56PM +0100, Louis Chauvet wrote:
> > > > Hi,
> > > > 
> > > > > > Hi all,
> > > > > > 
> > > > > > I am also currently working on MST emulation for VKMS. If someone can read
> > > > > > what I already did and at tell me if my implementation seems on the right
> > > > > > track it could be nice.
> > > > > > 
> > > > > > The current status is not very advanced: I can emulate a mst HUB, but not
> > > > > > a screen. I am currently working on properly emulating the HUB by using an
> > > > > > other hub.
> > > > > > 
> > > > > > You can find the branch for this work here:
> > > > > > https://gitlab.freedesktop.org/louischauvet/kernel/-/tree/b4/vkms-mst
> > 
> > Can't look at this because it's private.
> 
> Hi Maxime, Sima,
> 
> Normally, those should work:
> 
> https://gitlab.freedesktop.org/louischauvet/kernel/-/tree/vkms-mst
> https://github.com/Fomys/linux/tree/vkms-mst
> 
> I just re-tested, this is broken, probably because I never had the time to
> properly finish my last idea: simplifying vkms_connector by creating
> vkms_mst_emulator_root. With the rest of the code (i.e.
> vkms_mst_hub/display_emulator + vkms_connector), I was able to make this
> config working:
> 
> HUB1 -> HUB2 -> DISPLAY1
>      |       -> DISPLAY2
>      -> DISPLAY3
> 
> (working == it was listed properly by modetest + did not report any issue
> when using a connector with modetest -s)
> 
> Few things to note: no ConfigFS support, no eBPF support, poorly tested
> (there are probably multithread/recursion issues)
> 
> I had to stop working on it because I don't have anymore time, I plan to at
> least rebase + send an RFC once the VKMS+ConfigFS work is done.
> 
> > > > > I think this is exactly the kind of things where we'll want eBPF I
> > > > > think. There's no way you'll be able to model each possible test
> > > > > scenarios for MST through configfs, even more so with a stable
> > > > > interface.
> > > > 
> > > > I just spent some time to think about it. I agree that eBPF seems
> > > > applicable: we want to allows userspace to emulate any MST device, and we
> > > > don't want to create huge uAPI + whole emulation in the kernel.
> > > > 
> > > > As most of the protocol is similar accros device kind, I currently built
> > > > my code around the struct vkms_mst_sideband_helpers to specify only the
> > > > changed behavior (this way the "write to registers" "parse command"... is
> > > > only done in one place). The choice of function is not definitive at all
> > > > (it was just practical at this moment).
> > > > 
> > > > With eBPF, I know three different way to attach programs to the kernel:
> > > >   - Using a kprobe/attaching to a function: I can change the behavior of
> > > >     all the device, there is no way "attach prog1 to hub" and "attach prog2
> > > >     to screen1", it will be "attach prog1 to the function
> > > >     `vkms_mst_emulator_handle_transfer_write`, and all the device will be
> > > >     affected. This should be very easy to implement (maybe it already
> > > >     works without modification?), but very limited / make userspace stuff
> > > >     very ugly => Not ideal at all
> > > >   - Creating a whole architecture to attach eBPF programs in vkms: VKMS
> > > >     manage the list of attached eBPF programs, call them when it needs...
> > > >     This is probably the "most flexible" option (in the sense "VKMS can do
> > > >     whatever we need to fit our usecase"). This seems not trivial to
> > > >     implement (drm complexity + MST complexity + BPF complexity in the same
> > > >     driver seems a bad idea, espicially because VKMS don't have a lot of
> > > >     maintainance and I don't feel confident introducing more complexity)
> > > >     => Can work, require some work, but may bring more complexity in VKMS
> > > >   - Using BPF struct_ops: I can "simply" create/complete a struct ops for
> > > >     diverse mst callbacks (see the proposition bellow). I looked at some
> > > >     example, this seems to be "easy" to do, and the work in VKMS should be
> > > >     limited.
> > > >     => Can work, a bit less flexible than the previous solution, but avoid
> > > >     a lot of complexity
> > > > 
> > > > I don't know if I will be able to finish the implementation but I imagine
> > > > something like that may be a nice interface (may be not possible "as is"):
> > > > 
> > > > // vkms_mst.c struct_ops that can be filled by userspace with custom
> > > > // functions
> > > > // Known limitation: maximum 64 functions in this table
> > > > struct vkms_mst_ops {
> > > > 	// Completly overide the transfer function, so the userspace can
> > > > 	// do whatever he wants (even emulating a complex MST tree
> > > > 	// without using stuff in vkms)
> > > > 	handle_transfer(drm_dp_aux_msg);
> > > > 
> > > > 	// If default transfer function is used, those are the callback
> > > > 	// you can use (again, they will come with default
> > > > 	// implementation)
> > > > 	clear_payload_id_table(..);
> > > > 	link_address(..);
> > > > 	enum_path_ressources(..);
> > > > 	[...]
> > > > 
> > > > 	// Used to identify this kind of device, in my example the
> > > > 	// userspace could register "LG_screen", "dell dock", "HP screen",
> > > > 	// and then configure each mst device with the correct kind
> > > > 	name = "<unique name for this device kind>",
> > > > 
> > > > 	// If you want to use the default "hub" implementation, but only
> > > > 	// tweak one specific behavior, you can use this
> > > > 	base = "<name of the other structops>"
> > > > }
> > > > 
> > > > 
> > > > // Needed to implement eBPF struct_ops, called when userspace registers a
> > > > // struct_ops of type vkms_mst_ops
> > > > void register_struct_ops(new_ops...) {
> > > > 	vkms_registered_ops.append(new_ops).
> > > > }
> > > > 
> > > > // In vkms_connector.c
> > > > // Callback called by drm core to do transfer on the connector
> > > > void vkms_mst_transfer(aux, msg) {
> > > > 	mst_emulator = get_mst_emulator(aux);
> > > > 
> > > > 	ops = vkms_registered_ops.search_for(mst_emulator.name);
> > > > 	ops->handle_transfer(msg);
> > > > }
> > > > 
> > > > // mst_ebpf.c In the BPF program, userspace side
> > > > void handle_transfer(...) {
> > > > 	[...]
> > > > }
> > > > struct vkms_mst_ops {
> > > > 	handle_transfer = handle_transfer;
> > > > 	name = "lg-screen";
> > > > 	base = "default-screen"
> > > > }
> > > 
> > > I don't think MST is the right abstraction there. We should have MST
> > > related helper functions available to eBPF programs, but we should load
> > > them at the connector level, ie, implement a full blown connector
> > > atomic_check for example. It's more flexible and will allow to implement
> > > other use-cases people have been interested in (like panels).
> > 
> > So since I can't look at the code I'll just drop my thoughts here.
> > 
> > - I think validating the MST helpers implementation should be done with
> >    kunit tests. So these are out of scope for vkms testing I think
> >    entirely.
> 
> Yes, I agree with this, and it joins your last comment: the full dp-aux
> emulation does not belong only to VKMS. I had this idea only because my
> solution only use the normal core MST implementation (no special handling in
> VKMS, just pure dp-aux emulation), so technically you could also stress-test
> drm core with it.
> 
> > - Next up are the driver implementations. There we might want to be able
> >    to inject fake mst devices to stress-test driver corner cases. But I
> >    don't think that's a job for vkms either.
> 
> I agree, VKMS is not here to test other drivers.
> 
> > - Now for vkms itself, I think the interesting case here is being able to
> >    test compositors against funny mst corner-cases, but for that we don't
> >    really need an mst operation at all. So no dp-aux or anything like that,
> >    we just hotplug-create connectors with names and PATH property and MST
> >    type, without any of the kernel-internal presentations for hubs/branch
> >    points and all that stuff. Because userspace doesn't ever see that.
> 
> I knew that user space don't really see the MST information (apart from
> PATH), but I did not think about this solution. This may work well to test
> user space, I agree!
> 
> I think we are on the good track with José, he is trying to implement
> connector hot-creation through ConfigFS [1]. To add "MST emulation", we can
> "simply" add the PATH property through ConfigFS.

Yeah, I think that's the way to go. Well maybe with a change to always
include the PATH property, because currently that's true for all
hotpluggable connectors. And we probably want to keep that if we extend it
to hotpluggable bridges or similar.

> [1]: Few discussions here
> https://lore.kernel.org/all/Z5zJ1rEZyBEgd7DN@louis-chauvet-laptop/

Agreeing with you, connector hotplug is something we need to tackle as an
extension of the basic configfs support, since it's quite complex.

> > - Next up is expressing all the funny constraints that can result in,
> >    across different drivers. For that I think we want ebpf to implement the
> >    various atomic_check hooks, so that you can implement all the funny
> >    constraints of mst link bw limitations, but also host-side display
> >    limitations. And I concur with Maxime that this ebpf support should be
> >    entirely agnostic and just allow you to attach atomic_check
> >    implementations to connectors, planes and crtcs. And then maybe one for
> >    the overall commit, so that global constraints are easier to implement.
> 
> If I understand correctly, this has nothing to do with VKMS + MST?
> I don't clearly understand the use case: why do we want the user space to
> express hardware limitations? If you have already discussed this on the
> mailing list, can you share the discussion?

Not sure this was discussed in-depth, but when you get into more complex
output configurations, there's all kinds of funny hw constraints that pop
up. Examples:
- Multiple mst outputs on the same physical port share the overall
  bandwidth. So individually you might be able to light up each connector
  at max resolution, but if you try to light up all of them, there's a
  limitation. This is the mst specific case.
- There's also lots of display hw constraints, like a limited amount of
  clocks (fewer than crtc), or memory bw constraints for scanout, and
  similar things.

The idea is to express these constraints with ebpf programs, so that you
can validate that a compositor correctly handles these cases and doesn't
try an invalide configuration and then just fails instead of trying to
fall back to something that works.

So it's a much bigger issue, but multi-connector mst is a fairly important
case here.

Cheers, Sima

> > So summary: MST testing in vkms only needs to look like MST to userspace.
> > Internally we'll just hand-roll the entire connector hotplug and leave out
> > everything else. Because testing driver dp mst implementations and the
> > helpers is better covered through different means.
> >
> > Eventually we might want to implement fake i2c and dp-aux implementations
> > for additional features like TV remote control and fun stuff like that (I
> > forgot the CEA/HDMI name for these). But I think that's waaaayyyyyy down
> > the road.
> 
> I think I am not that far from a full dp-aux emulation, it is precisely what
> I tried to do in VKMS. I don't have the time to transform it to kunit tests.
> 
> Thanks a lot for your feedback!
> Louis Chauvet
> 
> > Cheers, Sima
> 
> -- 
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

