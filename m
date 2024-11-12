Return-Path: <linux-kernel+bounces-405800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C009C571A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858962833FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D41CD1E8;
	Tue, 12 Nov 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="a2/tyhe7"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672161CD1F6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412684; cv=none; b=QQIG/y9ecR+5WesaFg/eawgTMDtei0PYOB0g6jZGf7pVsrFq5WajgF/00IRbzzubRL9aYloge/gcyiknO0D/iFFjzuvLIzBhF9q7C/k2AhkTxvzvgladnxyh/0RSGhlLmToDqU6zzJ2qI+37MMi4JYzRQfJhBVdbeYY4u7oMe6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412684; c=relaxed/simple;
	bh=gamiLNTrf25mtswS6LdlmTYjTT5i/nU926ZrJK9h7Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7U2e2dNABITYxRNsj5/Qv30DlVbLOflMLUS7NuOcNzAyw2LK5eNgpOmgQjZCkQt0wzTzMzWWGWQW0l4nuH0q/jJjcp7t5oTASLtuYk8h/+LsYIGwGef2DLCS9/S7cxhaiSK2AnEmsGv4sfOoyGa7vJDRNS0TS6id3tV/zRPv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=a2/tyhe7; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
Date: Tue, 12 Nov 2024 22:57:36 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1731412678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLPANBLamjGfC5r6egRWAEDIhWpqsCbbZn+Iq+TVaHs=;
	b=a2/tyhe7fNibfAbbCny3Aikp3SsQnw6XH7Ov42dzBegj2EiTgNMN3Xtj9HxXtxU8+uGVBm
	nI9QJwwmQq3bac1SiNPQ53yBhbBEyJpPAlZrm8CZ4rAOzxF6iZ1FJVCbk2xF0Y9mw3Q3N8
	0PWbOjQIDg3RwbSIyV7Ve+qisx+cnXeNfaZRvcKs1sKx2WLVjquVBuWwRjFd96OsiKw4a5
	zJGLpuo/iZ/i7LfAsFL1Zmb+8W2cMl1QovdUVyShoYPgpXyfcsMFIFqpfd0XdqkFtzY2kO
	0SEGYCrQNR+RkH+svIeIYbE1elx45wTijw4bX2EApjeDRad+MCIup1tiKLtEPQ==
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
Message-ID: <ZzNCsFiAiACFrQhE@titan>
References: <20241108-tcon_fix-v1-1-616218cc0d5f@jookia.org>
 <20241108115357.691b77b0@donnerap.manchester.arm.com>
 <Zy4SKCBwce3q0yj5@titan>
 <b26b9d86-4ff9-4543-85ce-176dccfbfa05@linumiz.com>
 <Zy4c9BFcrz2JVU6k@titan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy4c9BFcrz2JVU6k@titan>
X-Migadu-Flow: FLOW_OUT

Hey everyone,

I'm not sure exactly where to add this but I discussed some of this with
Parthiban on #linux-sunxi a few days ago, so I want to write it down
before I work on the next version of the patch.

I had assumed for some reason in my mind that DE0 and DE1 here referred
to mixers, but they actually refer to chips that have multiple DEs. It
looks like at least with the A133 it has two DEs instead of two mixers.

This can be found by looking at the Allwinner BSP: SUN50IW10 requires
CONFIG_INDEPENDENT_DE and has a device tree with an extra reg and clock:

<0x0 0x06800000 0x0 0x3fffff>,/*de1*/
<&clk_dpss_top1>

However the tcon-top code seems to conflate mixers and DE in the
mainline code and the Allwinner code. So ... It seems like 'DE0' and
'DE1' really do mean mixers in this case. It's probably best to note
that down.

I thought a bit more about how to solve this properly- setting two
mixers to the same output is something people probably won't do in
practice, so the only way you could really arrive at this bugged state
is by setting it as the default state. This patch may be the correct
solution after all.

John Watts

On Sat, Nov 09, 2024 at 01:15:16AM +1100, John Watts wrote:
> On Fri, Nov 08, 2024 at 07:36:16PM +0530, Parthiban wrote:
> > To add, 0x20 will be DE0 <--> LCD0 and DE1 <--> TV0. Below note (copied from
> > R40) states the priority of the DE selection, which fails to work? Not sure,
> > may be disabling CORE1_SCLK_GATE and CORE1_HCLK_GATE in de2-clk helps.
> > 
> > With A133 following the same as T113 with single mixer without TV, still
> > sets 0x20 in vendor kernel.
> > 
> > copied from R40:
> > Note: The priority of DE0 is higher than DE1.
> > If TCON_LCD0 selects DE0 and DE1 as source at the same time, then
> > DE0 will be used for the source of TCON_LCD0.
> 
> Hi there,
> 
> Yes that was a pretty bad typo, I meant to say DE1 to TV0
> The prioritization seems broken in the T113 at least, it's racy from
> what I see in testing. I should note this in the patch too.
> 
> I looked at the datasheets and kernel code briefly: I can't seem to
> figure out what SCLK/HCLK gating does and I don't think the kernel
> touches these registers which are gated by default.
> 
> > Thanks,
> > Parthiban
> 
> John Watts

