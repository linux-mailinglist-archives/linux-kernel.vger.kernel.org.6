Return-Path: <linux-kernel+bounces-332921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B2297C0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E365B2110B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158281CA68E;
	Wed, 18 Sep 2024 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loEJqjYK"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3576135417
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691388; cv=none; b=T98ZYroJdWxQFjy22rQ0fGILbu0a5s+DFANf3z2i07dTm95b2vDNcmq4Wc52QXgWt98wsgpUNdM7IJSoCfsIgHDae8eIVdxYHj1zT2FUI5dNOHCKGHTdI6NwozKGJA2GHLf3WKofqz5vlXcbSx+H/jG6O37X6qGhX2aoP0TFJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691388; c=relaxed/simple;
	bh=qfziQGIDdI9Vsv6F5w/gesgrncqGYldLl3toi32XYOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Mqn0JCdHrQkzPvyjLPSDG+ptkI2Dzgr6iJEL5YloCGljwljSCkJb2OLD1h9PX7kTfnw1rjTUF7Do6M6RUx82urJOh018F9BcbCtAQGUiFiE8clAWYzRl3n9qecNUZsUJ+xHqIQop0gjA2rHoRTCKZFoEriRJ3NYfIYfuPaaydTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loEJqjYK; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-49bd27b3507so38133137.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726691385; x=1727296185; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0+Veg0ajsYwcOQjqw+fgqS5nYmrOd6UXKJLeJklo8Q=;
        b=loEJqjYKQcmUG9EktZ5jpxOEPREca56b5B7niQkpou6V7HmOPSAduZaHtEu09AaJhK
         Q2fTQFKxyv8FNYML9vRoWEXVsm2w+dNv4Rm9Q6Hjx2t0qHXvcczYzE8e5Jj59BSh19/5
         TDV93xzXDEvA62468W+tluua3auu7hCNQFNUNRNKljgJbj0vakEnRu8Kwm16xmufj0v0
         v3yTDAaK8ALLK8bMiuQEXu9R+8JP2nYPx9oevi1PDXJi45EERlLZyKBvQjqnJ6HJyUdu
         FnrhlniWcaZUyKukl/SIUseDYAGc/MZe8jv7vPBf31mviv4pl92+QUNxn5ETxAYmgMzA
         UkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726691385; x=1727296185;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0+Veg0ajsYwcOQjqw+fgqS5nYmrOd6UXKJLeJklo8Q=;
        b=Um7fyOS+Cre++LCVtdgLNEfcNaLYmhNXGVCM8OLVAmOAz6e+JCBIRHsqG6JlRHZ3kU
         tqkIJOTHR3nlBp6AqEARPdDp1d1xMH3oNnomOnEELCHsc8loD4Z+AnshEW+t88TPSIg+
         m071a2oBSoYRLvr0FStxBi2e9qepwwaeSKkim/SSJdCvTeCz+QPOFJ01BbbGqjkLxBGl
         mcerPjNrmyrgWoM3JLfAOWJyCogXdRcuRJKpD2bz9vW7dE3qoOqCkKWw8sZKMahRLFJB
         jeqSvTyoIjlT3wNBQxfpPx8EBuTnTYzIE7aGhc3OOrUrhFHMpvun4JJvoBmoPrtsrCMk
         Libw==
X-Forwarded-Encrypted: i=1; AJvYcCX+VHor+YptBxx+JkocHlFVNxYHWpECkv2OI8ECbHKKUCP6hFoaM5fF6eF6QWI5LqHRB8fEBKtUvd1QrCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK++Z7rQG0yoBsa5yhYerHqs9zz4UyFM0oOIJMZzK9k0+dALeG
	oj2+OuMwjvwW+WeWDboHxDLVFUGWrpJw2tEtmR9KNv3VVyQjzFrzV18RGP9rqKcptikvBZHwKNu
	Xy0elSKUBIMIh7NBwMiEnGlmE/Dc=
X-Google-Smtp-Source: AGHT+IEVrC+ErbrSJv9jeauTLrJtajhjtGNAO2ZDnBfXorHFZ062AREFhdCHG4ssi+Vfk/BSL/g1/dDRj/uTYjW9/78=
X-Received: by 2002:a05:6102:38d1:b0:49b:f5ed:4bcb with SMTP id
 ada2fe7eead31-49d4157db8cmr16663527137.24.1726691385640; Wed, 18 Sep 2024
 13:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjAwxidmwCT5ZwbZRhf9GwshYbzQZ4N8K3B8KGLi5DnRzj8wQ@mail.gmail.com>
In-Reply-To: <CALjAwxidmwCT5ZwbZRhf9GwshYbzQZ4N8K3B8KGLi5DnRzj8wQ@mail.gmail.com>
From: Sitsofe Wheeler <sitsofe@gmail.com>
Date: Wed, 18 Sep 2024 21:29:19 +0100
Message-ID: <CALjAwxiytz=FUy4Fu8j-hOa2BKXpYL0ZyjMHyOGRE0OdsfKDkA@mail.gmail.com>
Subject: Re: Kernel hang when amdgpu driver is loaded on old radeon card
To: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"

(CC'ing Hans de Goede who recently wrote a blog post
(https://hansdegoede.dreamwidth.org/28552.html ) which sounds like the
same issue I'm seeing)

On Sun, 15 Sept 2024 at 21:30, Sitsofe Wheeler <sitsofe@gmail.com> wrote:
>
> Hello,
>
> (Apologies if I have CC'd the wrong people/places - I just went by
> what get_maintainer.pl -f drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> said)
>
> I recently upgraded from Ubuntu 20.04 (5.15.0-119.129~20.04.1-generic
> kernel) to Ubuntu 24.04 (6.8.0-44-generic kernel) and found that while
> booting the kernel hangs for around 15 seconds just before the amdgpu
> driver is loaded:
>
> [    4.459519] radeon 0000:01:05.0: [drm] Cannot find any crtc or sizes
> [    4.460118] probe of 0000:01:05.0 returned 0 after 902266 usecs
> [    4.460184] initcall radeon_module_init+0x0/0xff0 [radeon] returned
> 0 after 902473 usecs
> [    4.465797] calling  drm_buddy_module_init+0x0/0xff0 [drm_buddy] @ 122
> [    4.465853] initcall drm_buddy_module_init+0x0/0xff0 [drm_buddy]
> returned 0 after 29 usecs
> [    4.469419] radeon 0000:01:05.0: [drm] Cannot find any crtc or sizes
> [    4.473831] calling  drm_sched_fence_slab_init+0x0/0xff0 [gpu_sched] @ 122
> [    4.473892] initcall drm_sched_fence_slab_init+0x0/0xff0
> [gpu_sched] returned 0 after 31 usecs
> [   18.724442] calling  amdgpu_init+0x0/0xff0 [amdgpu] @ 122
> [   18.726303] [drm] amdgpu kernel modesetting enabled.
> [   18.726576] amdgpu: Virtual CRAT table created for CPU
> [   18.726609] amdgpu: Topology: Add CPU node
> [   18.726787] initcall amdgpu_init+0x0/0xff0 [amdgpu] returned 0
> after 528 usecs
>
> I've checked and the problem still exists in 6.11.0-061100rc7-generic
> (which is close to vanilla upstream).
>
> The graphics card I have is:
> 01:05.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] RS880M [Mobility Radeon HD 4225/4250] (prog-if 00 [VGA
> controller])
> 01:05.0 0300: 1002:9712 (prog-if 00 [VGA controller])
> Subsystem: 103c:1609
>
> At first I thought the problem was related to the change
> https://github.com/torvalds/linux/commit/eb4fd29afd4aa1c98d882800ceeee7d1f5262803
> ("drm/amdgpu: bind to any 0x1002 PCI diplay [sic] class device") which
> now means my card is claimed by two drivers (radeon and amdgpu). That
> change complicated things because:
> - The amdgpu module and its dependencies remain permanently present (which
>   never used to happen)
> - It took some time for me to realise that the amdgpu driver hadn't suddenly
>   grown the ability to support this old card :-) There is a nice table on
>   https://www.x.org/wiki/RadeonFeature/#decoderringforengineeringvsmarketingnames
>   that shows it is part of the R600 family and
>   https://www.x.org/wiki/RadeonFeature/#featurematrixforfreeradeondrivers shows
>   that R600 is only supported by the radeon driver.
>
> However, testing a 5.16.20-051620-generic kernel showed that while the
> amdgpu module is loaded, there is no 15 second hang... So far my
> testing has the following results:
> - 5.16.20-051620-generic - amdgpu loaded, no hang
> - 5.18.19-051819-generic - amdgpu loaded, no hang
> - 6.0.0-060000-generic - amdgpu loaded, hang
> - 6.2.0-060200-generic - amdgpu loaded, hang
> - 6.8.0-44-generic - amdgpu loaded, hang
> - 6.11.0-061100rc7-generic - amdgpu loaded, hang
>
> To work around the problem I've taken to blacklisting amdgpu in
> /etc/modprobe.d/ which makes the hang disappear.
>
> Does anyone else see this issue? Is there something better than my
> current workaround? What do other drivers that want to bind to such a
> large set of devices do? Further, while I'm already using
> initcall_debug, is there any other kernel boot parameter to make
> what's happening more visible?
>
> --
> Sitsofe



-- 
Sitsofe

