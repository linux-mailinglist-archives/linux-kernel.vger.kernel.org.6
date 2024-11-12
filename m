Return-Path: <linux-kernel+bounces-406864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E865F9C653B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E35C1F23807
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA26A21B441;
	Tue, 12 Nov 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="ylgF4mzc"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E782213135
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454527; cv=none; b=Nq/Ob7kFZwDUrRPb4p6s8iLbv0mC4zT2KCtZmsBSe6ak5W7gvKUhasr+OUU/5nzctwr5cBGCstTZWFQ0bd+4Ik83quT3a5TAWC6H5CDy4aEkbEeNm8nlXOylS1aJ6PzyzNBJECOGLJX3cvuWXLpRoSZfRdA3RGqrwJgIGZxAUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454527; c=relaxed/simple;
	bh=5QYxYmoaC0h97bCzFt7dyutECUXaQwbJKnIzfwNwwLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDjyEiykGb7AWAeMYd7NKos0mTaH9+C0/k3C7Cc+V1VtYJ2Y7Ce5DAD83eQdOfU8niWMnfZ8xXTed2Qn7LnISYZG33Jkc/xpGNcebR2AujvS7xRbG5r7MFksch6ww2TfKQjlG5YKVQ2g2HphZoIBoyR9jylNmK5CoELefFTau6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=ylgF4mzc; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
Date: Wed, 13 Nov 2024 10:33:14 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1731454521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gMbHqD+H0zd72SUEwYPmsE9R4wTLK4oFNYpLilDoG38=;
	b=ylgF4mzcsM/CWq/YKvClifTLZH7vCdLAWKIqWnIPHm1D13CdUREyoniFOn+mElVbgLLUyR
	Xz8KqJTTLDqDbgFRzFKuEpaY8K7sgvva0GGzq2I7veWNTf7CsjeyAJzCfwffGZiKK7L2g/
	+xH6RouQQVtZGcTwIJ08yjwnxzDkECI66BD28PLVZFY5QaF5DbO5Tyv7CIgxLhZOSifrJs
	CG3bnLO17WXI3WFwurYU9klwutqfWvMCsmna79NYtHZWSrl7exUSIwfl8cy8H1NZPhf3QS
	SIPSaGNgiza2lEJdNE7UH+rS3FOjXovzHJEGLDL+JnixRk3MFJuyMQBw8SZ01A==
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
Message-ID: <ZzPluoI7xSTwhNcm@titan>
References: <20241108-tcon_fix-v1-1-616218cc0d5f@jookia.org>
 <20241108115357.691b77b0@donnerap.manchester.arm.com>
 <Zy4SKCBwce3q0yj5@titan>
 <b26b9d86-4ff9-4543-85ce-176dccfbfa05@linumiz.com>
 <Zy4c9BFcrz2JVU6k@titan>
 <ZzNCsFiAiACFrQhE@titan>
 <f0d5b314-cfcc-4856-8d6e-09e437c075ec@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0d5b314-cfcc-4856-8d6e-09e437c075ec@linumiz.com>
X-Migadu-Flow: FLOW_OUT

Hi there,

On Tue, Nov 12, 2024 at 10:43:44PM +0530, Parthiban wrote:
> #define TCON_TOP_PORT_DE0_MSK                   GENMASK(1, 0)
> #define TCON_TOP_PORT_DE1_MSK                   GENMASK(5, 4)
> 
> references towards DE0 and DE1 is for DE itself, not the mixers in the
> current implementation.

So the datasheet says it's for DE0/DE1 but the Allwinner driver and mainline
driver assume it's for mixers. There's a conflation between mixer and DE in
this case, especially because everywhere mixer1 is used on the A133 it is
switched to DE1. I'm also unaware of the R40 having two DEs which kind of
confirms this might be a typo. If anyone has actually tested the second output
of this it would help find out if it actually means DE1 or mixer1.

> Handling for mixer0 <-> lcd1 and mixer1 <-> lcd0 also needs to set
> DE2TCON_MUX in de clock, which is missing now.

Hmm. Are you sure? Looking at the Allwinner drivers it has the method
de_top_set_de2tcon_mux in
drivers/video/fbdev/sunxi/disp2/disp/de/lowlevel_v33x/de330/de_top.c
which I think means it's for DE3? But I don't see it called anywhere?

This might be worth discussing in the DE3 patchset.

> sun8i_tcon_top_set_hdmi_src for R40 already sets these values via quirks.
> i.e controlling the port muxing. Also D1 quirks is same as R40. So the
> original changes to make the DE1 point to TVx can also done in this quirk
> without hardcoded value?

In this case I'm using an LCD which isn't HDMI, so I'm not too sure how much
this would help. Having it as a quirk also seems a bit overkill if this is a
general preventative fix, especially since Allwinner doesn't seem to test their
functionality. Relying on it seems like a mistake in this case.

My other thought is that when sun8i_tcon_top_de_config is called it could do
something. But I'm not sure what that something would actually be, given it may
be called twice in an (I assume) unknown order.

Say, if mixer1 is set as TV0 and and mixer0 is set as TV1 we would try to set mixer1
first, see that mixer0 is already set to TV0 then ... error? Even though the
final configuration doesn't have any conflicts.

I was thinking something like this for my next patch:

	/*
	 * Make sure that by default DE0 and DE1 are set to different outputs,
	 * otherwise we get a strange tinting or unusable display on the T113.
	*/
	reg = readl(regs + TCON_TOP_PORT_SEL_REG);
	reg &= ~TCON_TOP_PORT_DE0_MSK;
	reg |= FIELD_PREP(TCON_TOP_PORT_DE0_MSK, 0);
	reg &= ~TCON_TOP_PORT_DE1_MSK;
	reg |= FIELD_PREP(TCON_TOP_PORT_DE1_MSK, 1);
	writel(reg, regs + TCON_TOP_PORT_SEL_REG);

Perhaps this could be hidden behind a quirk? I would have to check to see which
chips have this behaviour, I'm not sure if it's a bug specific to the T113 or
D1/T113 or R40 too.

Also noting at the top of the file that DE0 and DE1 mean mixer0 and mixer1
might be good to reduce confusion.

What do you think? :)

> Thanks,
> Parthiban

Thanks for your input!

John Watts

