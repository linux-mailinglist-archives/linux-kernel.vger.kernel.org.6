Return-Path: <linux-kernel+bounces-181340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348568C7AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90004B2284B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C81E533;
	Thu, 16 May 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0S/FMLLt"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6C79C0
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878312; cv=none; b=b00SLNT76X6LIMkFID1FlXfYNZLPvoV/9yFcNwHdd47FYI8IEK7k1DC2ZZp85Bv42nDmagn/R3RzUU7/XQDxHNMwo+IFg3XAIyc7PjJ5wbQNmv/F3MS9oYOdcOAkte4gFmmJNnwZkvfxclmLCqGCdrkf8nybQMZsmYW+n70rxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878312; c=relaxed/simple;
	bh=HiwHUDNOqaO7gJLaH4Ty8qKZ6uj6Ygys0Vm63BVU3TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JFyUsXKwpsldnzAP40uLKnBsGJ5tLkcn4BpgNbZikMv0tS6jEBfIsrAHhVIvaP9Hq0pVQl/0Mk/hoDv1PvQANXlOL9OLRnI08GWc2XeZ6AlhkHL65HlMxeg7dgc5Gc7qCA6zrQ6x/v5Drp+XCNDkrc8vyUYtJiK5lAICmzzymmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0S/FMLLt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41ff3a5af40so1585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715878309; x=1716483109; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onRIPguZVTKnH89R9mkjKZKxwfRC8K+qmiRpCHzudec=;
        b=0S/FMLLtr/2qruuPh85VLKOPvrTmzoqsD8+2SnSx1uERc1+ANC3GiH/rQ/1FwO2OMf
         nFy97a3NeoEtIF1iYetv2esDSj+Rmn/iwfLTTCpsvt4V2IbuGOBNo6p89/N68F/jqqTN
         qBi7F5ei+baGqnL7qTwK9GvIDWrNVe9xDvXdhl3/4d0z5p8YlU0gFyVlKF+2jfkH8fye
         JTeCyIT5oDWTTl8KWRfvnWU8fXVXqyVEy9sMVu2lhtyq7FvNoVQQMu2KqJ+8tyM93vKU
         nDojzC88NIIoQLNLjGlM+zGMEj/5cs1e+NIyKJSzLtn9xO1cTB09rk3pBOkIiED0cXUh
         DLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715878309; x=1716483109;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onRIPguZVTKnH89R9mkjKZKxwfRC8K+qmiRpCHzudec=;
        b=sgvFZgUiO85F2KVZ5u+IXDJYxOjKEg03Dls0s59hQY8CAAlEjuW4jBVCo70qJ+KDTj
         6Ebfet4jM+eZvhdftkQ7Q0jleULZ4ICopd8ck5zg35yObfYauxOOgICU37pMDr7okV0P
         A9Kr6JXB6BpG6k7hmtfAwQKY1pIAfMkV13I7c6ruAiaoyBvPGRZ83nhe10rlH9BLZAjW
         0z5rg4LLRiiHSPEVixcCurFI7xDIlBZPiJtZS+GgJYFGI0rUHrB1Fp/rsk+HMPNFktDJ
         WP+FHUBUAFJ6Iw9sflzWE3aA5Q2DHbbABxE7uz5ytAYMG1M2SfbTb9fOyRu4yNzkuEFS
         70ug==
X-Forwarded-Encrypted: i=1; AJvYcCWhRpayRJ5QZv3taF00o1q2gAtX9lJ1cXrY0ATO2OF4B1ER2mPEkkuV1JMyO0nVAgpyumJHWesYiW2ngqMREtCrghuNeFvTgJdHn3tk
X-Gm-Message-State: AOJu0YyvBRAUO1dwVb/XylowlYKrM2V+8xGfNpUSHb4N5C7zkO4a4e5v
	ZBsKpmEPo4m2MqDArCJA+rRJpngsgZn6vbKCB3P+FWYSXattauareIxHZJcEPMENJ64YRH7fwwM
	eXlnWvIUTR/8xXtxMPVBgMO/hEC5kVAeVQ3c=
X-Google-Smtp-Source: AGHT+IEtjZ9BDFF4UXQQ+nrOQN0XGRAp0bc3xjYZiRXnK81siroeleNET7wr5DctMi1WpgetmZ17HV2nwiWezX0TGvA=
X-Received: by 2002:a05:600c:34c2:b0:41b:e55c:8dca with SMTP id
 5b1f17b1804b1-4200f8c6eeamr11617495e9.7.1715878309151; Thu, 16 May 2024
 09:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515-dma-buf-ecc-heap-v1-0-54cbbd049511@kernel.org>
 <CANDhNCoOKwtpstFE2VDcUvzdXUWkZ-Zx+fz6xrdPWTyciVXMXQ@mail.gmail.com> <ZkXmWwmdPsqAo7VU@phenom.ffwll.local>
In-Reply-To: <ZkXmWwmdPsqAo7VU@phenom.ffwll.local>
From: John Stultz <jstultz@google.com>
Date: Thu, 16 May 2024 09:51:35 -0700
Message-ID: <CANDhNCo5hSC-sLwdkBi3e-Ja-MzdqcGGbn-4G3XNYwCzZUwscw@mail.gmail.com>
Subject: Re: [PATCH 0/8] dma-buf: heaps: Support carved-out heaps and ECC related-flags
To: John Stultz <jstultz@google.com>, Maxime Ripard <mripard@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T.J. Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 3:56=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wro=
te:
> On Wed, May 15, 2024 at 11:42:58AM -0700, John Stultz wrote:
> > But it makes me a little nervous to add a new generic allocation flag
> > for a feature most hardware doesn't support (yet, at least). So it's
> > hard to weigh how common the actual usage will be across all the
> > heaps.
> >
> > I apologize as my worry is mostly born out of seeing vendors really
> > push opaque feature flags in their old ion heaps, so in providing a
> > flags argument, it was mostly intended as an escape hatch for
> > obviously common attributes. So having the first be something that
> > seems reasonable, but isn't actually that common makes me fret some.
> >
> > So again, not an objection, just something for folks to stew on to
> > make sure this is really the right approach.
>
> Another good reason to go with full heap names instead of opaque flags on
> existing heaps is that with the former we can use symlinks in sysfs to
> specify heaps, with the latter we need a new idea. We haven't yet gotten
> around to implement this anywhere, but it's been in the dma-buf/heap todo
> since forever, and I like it as a design approach. So would be a good ide=
a
> to not toss it. With that display would have symlinks to cma-ecc and cma,
> and rendering maybe cma-ecc, shmem, cma heaps (in priority order) for a
> SoC where the display needs contig memory for scanout.

So indeed that is a good point to keep in mind, but I also think it
might re-inforce the choice of having ECC as a flag here.

Since my understanding of the sysfs symlinks to heaps idea is about
being able to figure out a common heap from a collection of devices,
it's really about the ability for the driver to access the type of
memory. If ECC is just an attribute of the type of memory (as in this
patch series), it being on or off won't necessarily affect
compatibility of the buffer with the device.  Similarly "uncached"
seems more of an attribute of memory type and not a type itself.
Hardware that can access non-contiguous "system" buffers can access
uncached system buffers.

thanks
-john

