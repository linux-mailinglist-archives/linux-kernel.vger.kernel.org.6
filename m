Return-Path: <linux-kernel+bounces-573802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F765A6DCA3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AA63AA09D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ACC25F96A;
	Mon, 24 Mar 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="dgM8qoQK"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE52505C5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825464; cv=none; b=VWf5xkp4IiT5dlrEpsStAhTnkS+uLQBpGgAaJ51ciF/lu5aSOqVb2ujRI/xAkMtmM8rh5/YoYg2N50t88VGV/18vXJAna9Xrk1dxXb5QZwEW5It59LsGiDtzjv4qKK4DJh3cpOafjHk++8Z+pOTFkYFqhCziPFFtWDJRzLv5snA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825464; c=relaxed/simple;
	bh=NqNPPpCkaZkUwbNQKKvy64w/LnM2Bd6Jjp5jMp418XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3fONGA0CcB77olAcN+0+WiQicLO+ZJpAZkyMKxJjzL+WADAqKgLuOpMYT1Rmkdzc/H/RAHj2wWZPJ9senXg79s0F+BeET+C8fwyzBWQB9hMXA9H9B7I542mqojsuaNISQ5AwftdwyfT94vqLPXlmLWPGwRiGOg2QGSiog4XRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=dgM8qoQK; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Mon, 24 Mar 2025 10:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1742825449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5QavDf4YfF4g6incDfR8g3M+4C53fdbJxU8hmz4md/c=;
	b=dgM8qoQKNJIEi0dY32L6hBabt7HjG8XUm1NhIZaImSKprfR8JXsfBfhH9cTCPrcLg9wfGD
	o23+bo8cMWxTi36khM1fvKGG4apkYQpsaXdP8sgYZRtIQ6jZU1waJ/RfnEJxDXhZnj6hMt
	l4zSCzE8vSv3ylcINppjWvFaV7fjmBwjcieTx3E9R4I0dwULWMbcw+IcB7uU72j8Pi/ESl
	15pJTFdt9S+sGypIz635REFAIlyLDRUk/TZpfAg/E3oncgVQLclL0tPPh5xQu2kDhPTHMJ
	CFfNp00ClfbxNtP9JaOZCdso+fJ06mjS+jj+Drg6EAouBFLpdKHMNTre/Gp2cA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Message-ID: <Z-Fn4niI6_Yd06Ze@blossom>
References: <20250314-agx-uapi-v3-1-3abf7e74ea2f@rosenzweig.io>
 <195b507d4b3.b25d0dad175771.7566427576910952468@collabora.com>
 <195b582682b.121ba4d5e219032.3109114844776468245@collabora.com>
 <Z-B6uc7EEAdBPXmt@blossom>
 <260D98E1-7204-4535-A84F-D55A4527FF7E@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <260D98E1-7204-4535-A84F-D55A4527FF7E@collabora.com>
X-Migadu-Flow: FLOW_OUT

> >>>> +    /** 
> >>>> +     * @DRM_ASAHI_BIND_SINGLE_PAGE: Map a single page of the BO repeatedly 
> >>>> +     * across the VA range. 
> >>>> +     * 
> >>>> +     * This is useful to fill a VA range with scratch pages or zero pages. 
> >>>> +     * It is intended as a mechanism to accelerate sparse. 
> >>>> +     */ 
> >>>> +    DRM_ASAHI_BIND_SINGLE_PAGE = (1L << 2),
> >> 
> >> Does this require the BO to be a single page? If so, does it require offset==0? Or does it just take whatever page is at the specified offset?
> > 
> > I believe the intention is that it takes whatever page is at the
> > specified offset and just maps that a bunch of times. HK doesn't use
> > this yet though it probably should (this was added to help reduce
> > overhead when emulating sparse with scratch/zero pages, which is still
> > very new functionality in hk).
> > 
> > Accelerating this properly involves GPUVM patches - although even without
> > that, moving the loop into the kernel so it's only a single ioctl
> > (user-kernel roundtrip) seems worth keeping the flag for.
> 
> FYI: I will be posting a patch for the GPUVM abstraction soon.

Great to hear :) Although in this case, I meant that accelerating
DRM_ASAHI_BIND_SINGLE_PAGE requires patches to extend the actual C
implementation of drm/gpuvm, not just the Rust abstraction. Which is a
bit annoying for non-essential functionality with regards to upstreaming
things...

