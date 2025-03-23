Return-Path: <linux-kernel+bounces-572963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B43A6D0DE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE72E16ECAF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C14A19E83E;
	Sun, 23 Mar 2025 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="COGGpNiS"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E919ADBA
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742758998; cv=none; b=dsF1Hi663uVK72ZStJZM8h4lLFxfbB0qXpcfNT+oxyQjArib6hbqIkn6dTc9fETeoO6gI4YiQO8M8BjznORMV7tb1NkHk7xHhfyjPPb45T0XhLPGZOTAvVbu8o6ue80aKC/R2yL7CmcB4CJaV5mcKpFmy4CpBePsGWP855o+jBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742758998; c=relaxed/simple;
	bh=RE3gTWt8vybVXKrWd7W2DnLzx+ugzOyXiV/rlbLG9bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYkCgxIVUrTVG+YQtLpg8g0oV8Upp5aGpYJCZc63NJekXzeS4SUV0j2sw10ufXNa9awupG53kOzob7jR2Ixpr/HF14ynEPUuOcMe1AMB0pdau8D+xfOUeGLetdKTdMv6xAkuMyuOtYWHCPawaMgrDPqHORQrrFN6TsBBy1Om6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=COGGpNiS; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Sun, 23 Mar 2025 15:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1742758983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yiTcoVcywtNu482adnyxpvL2GYMUY5vhWbT9wgfALrY=;
	b=COGGpNiSGwbjGd/AFOZzHBsAlaw2UAU/u4y/l9RNv3VbOsqVe1K2zD3A2HqP32mjxPPVs/
	tVnou30Pv6VXc02us/pQxO0+AWLmmEetYwLpCpTtA4p5Cz8t2Nx3XJqRRA0j1H4MUj7+H6
	tIvDA8peCoY79bfy1DhaMh904W6JA4MjJzipMyut5BClhw8L6AedGlcRNWMCvzVKCjXxug
	xMGrwvTDy3cuvF97G1+bktPo1BkT96THLSFD/dSPTk03CdI6P30IILtiesfEcrNpUlZ0HO
	zUkxPJcadOGGDj9OikYXA67HnbuwW97YI17akVSYF6qM2Rdv0cwKOe1Nu+3vAw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?=22Bj=F6rn_Roy_Baron=22?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Sergio Lopez Pascual <slp@sinrega.org>,
	Ryan Houdek <sonicadvance1@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	asahi <asahi@lists.linux.dev>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-doc <linux-doc@vger.kernel.org>,
	Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v3] drm: Add UAPI for the Asahi driver
Message-ID: <Z-BkP2Kt0NYKJwfC@blossom>
References: <20250314-agx-uapi-v3-1-3abf7e74ea2f@rosenzweig.io>
 <195b507d4b3.b25d0dad175771.7566427576910952468@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <195b507d4b3.b25d0dad175771.7566427576910952468@collabora.com>
X-Migadu-Flow: FLOW_OUT

> I'm good with this. There's a slim possibility that upstream may
> evolve in ways that make the current UAPI tricky to implement.
> However, given that it's based on prior art from the nouveau, Intel,
> and panfrost teams and that you've been shipping it in production for
> a while, I think that possibility is pretty remote.

Yeah, I'm not too worried about that... the uAPI isn't being designed
around the kernel driver, so unless we're deprecating GEM or something
we should be good!

>  > +    /** @DRM_ASAHI_GEM_BIND: Bind/unbind memory to a VM. */ 
>  > +    DRM_ASAHI_GEM_BIND, 
> 
> I was about to complain about the GEM_BIND name but I actually prefer
> it. Given that it binds a single GEM object to a given range in a
> given VM, I think it makes sense to have it be an option on the GEM
> object. If and when you implement a bind queue, you can use VM_BIND
> for the new multi-bind ioctl and that will be an operation on the VM
> that says "bind all this stuff, here's some fences to know when."

Sounds good.

>  > +    /** @vm_user_start: VM user range start VMA */ 
>  > +    __u64 vm_user_start; 
>  > + 
>  > +    /** @vm_user_end: VM user range end VMA */ 
>  > +    __u64 vm_user_end; 
> 
> Does this have to be chosen by the kernel? Are there fixed addresses chosen by the firmware which need to be respected? Or is this just the range of valid GPU addresses? I also see kernel start/end being passed in at VM creation. I'm confused. At the very least, this needs a much better comment than the one above.

Added a bunch of comments in v4.

>  > +    /** 
>  > +     * @vm_kernel_min_size: Minimum kernel VMA window size within user 
>  > +     * range 
>  > +     */ 
>  > +    __u64 vm_kernel_min_size; 

>  > +    /** 
>  > +     * @max_commands_per_submission: Maximum number of supported commands 
>  > +     * per submission 
>  > +     */ 
>  > +    __u32 max_commands_per_submission; 
> 
> Pain. But we have this in nouveau as well, so...

This mirrors firmware limits. Either we have to split in userspace or
kernelspace. And at least if we split in userspace, there are no
surprises about where oversynchronization happens.

>  > +    /** 
>  > +     * @firmware_version: GPU firmware version, as 4 integers 
>  > +     */ 
>  > +    __u32 firmware_version[4]; 
> 
> There's a part of me that's like "This should never matter. You shouldn't expose that detail to userspace!" but let's be real...

TBH, I agree. If we need it for something later we can revisit but by
design this should never matter and current Mesa doesn't do anything
with it anyway.

Dropped in v4.

>  > + 
>  > +    /** 
>  > +     * @user_timestamp_frequency_hz: Timebase frequency for user timestamps 
>  > +     */ 
>  > +    __u64 user_timestamp_frequency_hz; 
> 
> Why is this different? What are user timestamps and how are they different from GPU timestamps?

I've added comments in v4 to clarify.

This does raise the question of, maybe drm_asahi_get_time should be
returning time in nanoseconds instead? I'm tempted to make that change
in v4. That would let us get rid of one of the parameters.

In practice the firmware-written "user" timestamps are themselves in
nanoseconds but we don't want to make that uAPI. We can't scale those in
the kernel (what if we write timestamps and then immediately
vkCmdCopyQuery them? We don't want to force a CPU roundtrip/stall just
for that.)

The kernel-read timestamps on current systems are from a 24MHz SoC-wide
reference clock, which both the GPU and CPU share. We can scale these in
the kernel to nanos, which is what userspace does itself currently.
Kind of bikeshed territory but meh?

>  > +    /** 
>  > +     * @DRM_ASAHI_FEATURE_SOFT_FAULTS: GPU has "soft fault" enabled. Shader 
>  > +     * loads of unmapped memory will return zero. Shader stores to unmapped 
>  > +     * memory will be silently discarded. Note that only shader load/store 
>  > +     * is affected. Other hardware units are not affected, notably including 
>  > +     * texture sampling. 
>  > +     */ 
>  > +    DRM_ASAHI_FEATURE_SOFT_FAULTS = (1UL) << 0, 
>  > +}; 
> 
> This makes me a little nervous. Why isn't this a bit you can set on VM creation? If it's something that's chosen by the kernel and which userspace can query but not change, that seems problematic from a backwards compatiblity PoV.

As far as we know, the fault control register must be set during GPU
initialization and cannot be changed once we're booted. So, we can
override it only via a kernel command line parameter.

macOS enables soft fault in all production builds. We do too these days,
but we have a kernel cmdline flag to disable soft fault / enable hard
faults to aid debugging.

Mesa queries this parameter to determine whether it can speculate
aggressively loads out of control (CAN_SPECULATE) -- it can with
production Asahi systems but not when I'm running CTS on my dev box.

Maybe more problematically, Mesa also currently gates sparseBuffer on
this flag, although I'm probably going to rewrite the sparse buffer
implementation in the coming months to avoid that dependence for various
reasons.

Should I avoid releasing an upstream Mesa with sparseBuffer advertised
until the dependence is dropped, to avoid a theoretical uAPI break if we
wanted to change this policy later? (where the regression is "old Mesas
in containers lose sparseBuffer/FL12").

