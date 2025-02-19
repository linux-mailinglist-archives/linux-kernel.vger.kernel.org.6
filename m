Return-Path: <linux-kernel+bounces-521591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8BEA3BFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572C03A3038
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFB11DE3A5;
	Wed, 19 Feb 2025 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="g47ZphUr"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1121C9B97
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970920; cv=none; b=mjB2PBb6DQtT2JfeoQGfZlUbBAatlY26tgECBwTYGgOJLJy/659NEwyI02S017XKIocY0am0CjOS3g8xXkZZhPFv9gTxqPB51pWtnPoz6V7GWhWZnk3dX1DrU40GKr7uCzeTL8ax+zMWFHtqsC3K8jzpVulfSSe0JxkPu/HGgdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970920; c=relaxed/simple;
	bh=48tDZDMmOisvPO0EutqBUlaL4mxpjys/PVnDCWbeypw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mqq0qcneAvOquVwkGKraqC0gz88PDufUbjaVTwAEUoFdQGE/8OlP+YA3EF9n4hSvq9BUrU3BLtA1eB2W+RPTklZgnijbm6YKm6OnshQGQ9r6JLfBsWoDbXsZ+L//afstkEt/NeuNDCdeDnrNX7d7pcZ9OZbCWJQsfKZYofQeDWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=g47ZphUr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43994ef3872so11460095e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1739970917; x=1740575717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3OTecTEqjsSEAES6uxVof8pmBHhzPdqSrjoAkg3hp8=;
        b=g47ZphUr1hjowtDUrRKPe8l+8npuyUhoXjuyaiuyM9uRZGDA7qzs724X0v+Mm4l5Cq
         WkeFWCepoDcAgzjoWBbypaJeEeXyla33GnDEUrcPmbP2AgqJSBfvnHcWYxEQec1W4f+5
         t/OToh0jjecm0cLl0hEXH/1yBcO9citd2WrxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739970917; x=1740575717;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3OTecTEqjsSEAES6uxVof8pmBHhzPdqSrjoAkg3hp8=;
        b=DtyAVl74vTw72zwwcw3kPwXXdk1gGqsw1TWdQTFxkHbQX35mNELpzkwdwSByLzC6da
         VFNb4VuFjjApAZJ8sQhr0YviS0FLvuZpHGlBw4FZtueY76zK2MAG0dkWlXPPhuJalmQr
         NfQPCKfFnZS2X0uV7ivcgMLg27rxEtWxADbd+GuCfYbs+BaLK61y9mZJCYRmAyWEG0yp
         ZzafEX+JxoVH/0/nMBx5Oo8y/GgxKBWSzJfzd3PtvvVUDCmb0RE4m4ahdPzoewt0cWlL
         B+zs4NCWQyHjvpFle6xvnPiS5TSn9DDk2oiBXSFb2jW6XEMt4j0jGR2RnJ71225KOa15
         P1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWCcK/x1aKKgcTVsTpKg2LLHXQ85w9xSNN1EqPrpjdnCBRaZJl7DVBZXRj7Lam5blODdi8Th61BUTxA7/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2PmpVVlgPUxrbBoTOzBDTlqsxCYjVZiJwwpXPPY8Rh+/zmmO
	g4kgKS0ZVeOE/+eFBA7HkKcDktZaZKC4pd/1WVtMVY5mlTTQjcshIxIAA2Q8zl0=
X-Gm-Gg: ASbGnctVtK4ywRmJqihp0FBrUVZeALdFaA9wOp7cBeqeEbYTcFV14fURx74KoGSymhL
	ajvNmdGLsQ4BWykb4wjGOg/q8P4QcHJaPgvGZCGYqgNREe7qY5evZdqQtwmeDz20UuL0+nrZlTu
	soMXSmULUSPJf3XVh7++KBYmF3gcgEk/MKv8pF59lVwxNFuoPuE/lnFfqet2JWbrUhGbO8t/Ny0
	kGTUUlJyKejxrqDBAO2vykKUj+A8qc54M4EvuyEzCaHHuFiA+wQTFoJMkC+41VlxVzrYUZ7bW6M
	gjr4WMvkApae/omIzP/sT+QbqEE=
X-Google-Smtp-Source: AGHT+IGE7fvrbOOFHZ/7Gk+I4AqiWQLSX38+VDZB/IUMJXu/cJWtD29Bl/wyN9Kx93jnGX+OJlLjRA==
X-Received: by 2002:a05:600c:a4e:b0:439:88bb:d035 with SMTP id 5b1f17b1804b1-43988bbd4bemr105873155e9.5.1739970916658;
        Wed, 19 Feb 2025 05:15:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4118sm18300450f8f.18.2025.02.19.05.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 05:15:16 -0800 (PST)
Date: Wed, 19 Feb 2025 14:15:13 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@ffwll.ch>, jose.exposito89@gmail.com,
	dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH RFC v2 00/16] drm/vkms: ConfigFS interface
Message-ID: <Z7XZYVs6LL1gEzIF@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-versatile-smilodon-of-felicity-cbcc4d@houat>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Wed, Feb 19, 2025 at 10:28:56AM +0100, Maxime Ripard wrote:
> On Tue, Dec 17, 2024 at 05:42:56PM +0100, Louis Chauvet wrote:
> > Hi,
> > 
> > > > Hi all,
> > > > 
> > > > I am also currently working on MST emulation for VKMS. If someone can read 
> > > > what I already did and at tell me if my implementation seems on the right 
> > > > track it could be nice.
> > > > 
> > > > The current status is not very advanced: I can emulate a mst HUB, but not 
> > > > a screen. I am currently working on properly emulating the HUB by using an 
> > > > other hub.
> > > > 
> > > > You can find the branch for this work here:
> > > > https://gitlab.freedesktop.org/louischauvet/kernel/-/tree/b4/vkms-mst

Can't look at this because it's private.

> > > I think this is exactly the kind of things where we'll want eBPF I
> > > think. There's no way you'll be able to model each possible test
> > > scenarios for MST through configfs, even more so with a stable
> > > interface.
> > 
> > I just spent some time to think about it. I agree that eBPF seems 
> > applicable: we want to allows userspace to emulate any MST device, and we 
> > don't want to create huge uAPI + whole emulation in the kernel.
> > 
> > As most of the protocol is similar accros device kind, I currently built 
> > my code around the struct vkms_mst_sideband_helpers to specify only the 
> > changed behavior (this way the "write to registers" "parse command"... is 
> > only done in one place). The choice of function is not definitive at all 
> > (it was just practical at this moment).
> > 
> > With eBPF, I know three different way to attach programs to the kernel:
> >  - Using a kprobe/attaching to a function: I can change the behavior of 
> >    all the device, there is no way "attach prog1 to hub" and "attach prog2 
> >    to screen1", it will be "attach prog1 to the function 
> >    `vkms_mst_emulator_handle_transfer_write`, and all the device will be 
> >    affected. This should be very easy to implement (maybe it already 
> >    works without modification?), but very limited / make userspace stuff 
> >    very ugly => Not ideal at all
> >  - Creating a whole architecture to attach eBPF programs in vkms: VKMS 
> >    manage the list of attached eBPF programs, call them when it needs... 
> >    This is probably the "most flexible" option (in the sense "VKMS can do 
> >    whatever we need to fit our usecase"). This seems not trivial to 
> >    implement (drm complexity + MST complexity + BPF complexity in the same 
> >    driver seems a bad idea, espicially because VKMS don't have a lot of 
> >    maintainance and I don't feel confident introducing more complexity)
> >    => Can work, require some work, but may bring more complexity in VKMS
> >  - Using BPF struct_ops: I can "simply" create/complete a struct ops for 
> >    diverse mst callbacks (see the proposition bellow). I looked at some 
> >    example, this seems to be "easy" to do, and the work in VKMS should be 
> >    limited.
> >    => Can work, a bit less flexible than the previous solution, but avoid 
> >    a lot of complexity
> > 
> > I don't know if I will be able to finish the implementation but I imagine 
> > something like that may be a nice interface (may be not possible "as is"):
> > 
> > // vkms_mst.c struct_ops that can be filled by userspace with custom 
> > // functions
> > // Known limitation: maximum 64 functions in this table
> > struct vkms_mst_ops {
> > 	// Completly overide the transfer function, so the userspace can 
> > 	// do whatever he wants (even emulating a complex MST tree 
> > 	// without using stuff in vkms)
> > 	handle_transfer(drm_dp_aux_msg); 
> > 
> > 	// If default transfer function is used, those are the callback 
> > 	// you can use (again, they will come with default 
> > 	// implementation)
> > 	clear_payload_id_table(..);
> > 	link_address(..);
> > 	enum_path_ressources(..);
> > 	[...]
> > 
> > 	// Used to identify this kind of device, in my example the 
> > 	// userspace could register "LG_screen", "dell dock", "HP screen", 
> > 	// and then configure each mst device with the correct kind
> > 	name = "<unique name for this device kind>",
> > 
> > 	// If you want to use the default "hub" implementation, but only 
> > 	// tweak one specific behavior, you can use this
> > 	base = "<name of the other structops>"
> > }
> > 
> > 
> > // Needed to implement eBPF struct_ops, called when userspace registers a
> > // struct_ops of type vkms_mst_ops
> > void register_struct_ops(new_ops...) {
> > 	vkms_registered_ops.append(new_ops).
> > }
> > 
> > // In vkms_connector.c
> > // Callback called by drm core to do transfer on the connector
> > void vkms_mst_transfer(aux, msg) {
> > 	mst_emulator = get_mst_emulator(aux);
> > 
> > 	ops = vkms_registered_ops.search_for(mst_emulator.name);
> > 	ops->handle_transfer(msg);
> > }
> > 
> > // mst_ebpf.c In the BPF program, userspace side
> > void handle_transfer(...) {
> > 	[...]
> > }
> > struct vkms_mst_ops {
> > 	handle_transfer = handle_transfer;
> > 	name = "lg-screen";
> > 	base = "default-screen"
> > }
> 
> I don't think MST is the right abstraction there. We should have MST
> related helper functions available to eBPF programs, but we should load
> them at the connector level, ie, implement a full blown connector
> atomic_check for example. It's more flexible and will allow to implement
> other use-cases people have been interested in (like panels).

So since I can't look at the code I'll just drop my thoughts here.

- I think validating the MST helpers implementation should be done with
  kunit tests. So these are out of scope for vkms testing I think
  entirely.

- Next up are the driver implementations. There we might want to be able
  to inject fake mst devices to stress-test driver corner cases. But I
  don't think that's a job for vkms either.

- Now for vkms itself, I think the interesting case here is being able to
  test compositors against funny mst corner-cases, but for that we don't
  really need an mst operation at all. So no dp-aux or anything like that,
  we just hotplug-create connectors with names and PATH property and MST
  type, without any of the kernel-internal presentations for hubs/branch
  points and all that stuff. Because userspace doesn't ever see that.

- Next up is expressing all the funny constraints that can result in,
  across different drivers. For that I think we want ebpf to implement the
  various atomic_check hooks, so that you can implement all the funny
  constraints of mst link bw limitations, but also host-side display
  limitations. And I concur with Maxime that this ebpf support should be
  entirely agnostic and just allow you to attach atomic_check
  implementations to connectors, planes and crtcs. And then maybe one for
  the overall commit, so that global constraints are easier to implement.

So summary: MST testing in vkms only needs to look like MST to userspace.
Internally we'll just hand-roll the entire connector hotplug and leave out
everything else. Because testing driver dp mst implementations and the
helpers is better covered through different means.

Eventually we might want to implement fake i2c and dp-aux implementations
for additional features like TV remote control and fun stuff like that (I
forgot the CEA/HDMI name for these). But I think that's waaaayyyyyy down
the road.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

