Return-Path: <linux-kernel+bounces-407227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3215E9C6A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4211F22EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED92189F47;
	Wed, 13 Nov 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="idA6PtSu"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C08C189910
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486036; cv=none; b=FLPCtqw2QOClGcLCoOhR5ckjROHWM+y878CBcpR5Xo1iHSi6ts+77OiSPePC7+33X4G2GdD9mN1nCzIjVPAn7ompwJCqKnZCrPA5eDRJ8ISy42zuXl8aTn+ktiyqSG0lrAkAWzzWhO7eueHKnwKIQzQvRBSC7BpfF8APUt6Vkuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486036; c=relaxed/simple;
	bh=k3Zf8UxcDVj2q+es+GMPzaqxrfN2MXe2/zNTjjlUD+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYYJolM2ITWMQc8kBKgNYYrLhnB30QsNFrH31VKiDsbb/1/wG/NO65E1KwWagq1t+Dyk+XajE49qLsfUMR6ZfB/ngCiyyST4IGePULSIydzq4tZUDBWe2hONROhEAzHLFfPtz0+pS1e1O0zt8pVbxAAyVAwXpN1jSy5w2DEcDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=idA6PtSu; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
Date: Wed, 13 Nov 2024 19:15:59 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1731486030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5UNEWkaaWi2aH87Bu/nkPPrIJzqMJy0nOzkhi0xcK50=;
	b=idA6PtSuL7Dp9RxF1Bk6TI7/3VnRiu3fNXfySYDOyaDq5JaEfZYHUTmS6PF5ZJcxqYfT3p
	HB2st5Z5LNBKsVWpxNGXK0rXZNRXCVEfrcxv+AVAg/q9Rcq06JNxViVMSQ4FROMPp0H87U
	Wdu0zLoI7zkmv1c0HAIzT5taFlZXz7RCAn+Sm3xYMHJ5JxwDHnzoQXfpZUgE8YZTt8YXSZ
	hIofh7rDKlVtAEPuvfpBRtSX0O/uEYjA94VVNLGETrumTo7wqRc13ePRp9cx+m0IfclD8y
	Kuvy4F2jB0Nnye0lU1ojPCjWw0sqN95IckT5MPrmfgv82F5Pfeu5jXRyVa+JvQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Parthiban <parthiban@linumiz.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Samuel Holland <samuel@sholland.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Workaround TCON TOP conflict between DE0 and
 DE1
Message-ID: <ZzRgP7-hHWE8JH8K@titan>
References: <20241108-tcon_fix-v1-1-616218cc0d5f@jookia.org>
 <20241108115357.691b77b0@donnerap.manchester.arm.com>
 <Zy4SKCBwce3q0yj5@titan>
 <b26b9d86-4ff9-4543-85ce-176dccfbfa05@linumiz.com>
 <Zy4c9BFcrz2JVU6k@titan>
 <ZzNCsFiAiACFrQhE@titan>
 <f0d5b314-cfcc-4856-8d6e-09e437c075ec@linumiz.com>
 <ZzPluoI7xSTwhNcm@titan>
 <2ef6afa0-2756-493b-83a4-62e73a8e2af9@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ef6afa0-2756-493b-83a4-62e73a8e2af9@linumiz.com>
X-Migadu-Flow: FLOW_OUT

Hi,

On Wed, Nov 13, 2024 at 11:40:14AM +0530, Parthiban wrote:
> No, Mixers in upstream refers to RT-Mixers inside the DE. It's only the
> quirk for R40/D1 setting the DE ports using mixer numbering.

After an hour or two of spelunking the code base, I'm still not sure about this.

Confusables:

- sun8i_tcon_top_de_config uses 'mixer' instead of DE
- The datasheet for TCON TOP mentions DEs
- The DT documentation for TCON TOP only mentions mixers
- Only mixers are passed to the TCON TOP DT
- Allwinner's tcon_de_attach works on systems without two DEs
- Allwinner's tcon_de_attach special cases systems with two DEs
- Allwinner's tcon_de_attach implies theres two TCON TOPs for two DEs

However sun8i_r40_tcon_tv_set_mux seems to clear this up:

- The register value is found using the remote endpoint reg
- tcon_top_mixer0_out specifies 0 and 2 for lcd0 and tv0
- tcon_top_mixer1_out also specifies 0 and 2 for lcd0 and tv0
- The 'mixer' is engine->id
- engine->id is found using sun4i_tcon_find_engine
- It gets the id from the endpoint number
- mixer0 has id 0
- mixer0 has id 1
- there's one engine struct per mixer and display-backend

It really seems like the code means mixers here.

> > Hmm. Are you sure? Looking at the Allwinner drivers it has the method
> > de_top_set_de2tcon_mux in
> > drivers/video/fbdev/sunxi/disp2/disp/de/lowlevel_v33x/de330/de_top.c
> > which I think means it's for DE3? But I don't see it called anywhere?
> 
> Missing in the upstream. 

So if Allwinner and mainline don't use it, what does?

> So far there is no real user for DE1 in upstream. DE_PORT_SELECT_REG value for
> DE1 can be negate of DE0, so that they won't conflict or cause timing issues.

If my thoughts are correct, this would break use of mixer0 and mixer1 at the
same time.

> Also DE_PORT_SELECT_REG mentions only about TV and LCD muxing, but missing HDMI,
> DSI and so.
> 
> Otherwise, if I get DE1 working in A133, I will try to add quirk to set DE0 and
> DE1 port mapping in that case to respective connector.
> 
> Thanks,
> Parthiban

Thanks,
John Watts.

