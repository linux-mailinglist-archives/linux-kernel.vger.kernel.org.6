Return-Path: <linux-kernel+bounces-401773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C65949C1EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3E9B22041
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C097E1E5000;
	Fri,  8 Nov 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="dyRNsVDT"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8151401C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075353; cv=none; b=V8BjqkdxqxO2yP0WhZzvl1SKLLgKoSTDhUnwFX/Bg20itxsB7EkP9PfABSPBqg3sGOQZTi7wO0BNhLz/jZB+Ju3W3oNAqOW9gp69c/AEWrcis38AdNtayrcu11Tk0P31bZt8rpEYyX6OO99QXZcYE5NWszZA1wBsDTnev/XzR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075353; c=relaxed/simple;
	bh=ws+GTUComh8X1PZWMHIhgeWfmtmHHuB5QBXpYb87epw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBnt+ozMaYdP6xu//4UEhRVYdME7N3HJIhhuBfpFuPRcY1bfm+rpR62YZeL4eDutoyBJt7eixmIY3mOlR748TTn2uJ7VPbjti+44JCcncYfxHn2dmI6n9i+3F2ILpNrDLkSbLnI5//h0Uc4cTwsZI5+HVdqh2bl+bO8jKxFcarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=dyRNsVDT; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
Date: Sat, 9 Nov 2024 01:15:16 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1731075347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LsPCVms6hNNfLUkJTitnYnu1jKozUMg34GhP2YbGR/Y=;
	b=dyRNsVDTwaKej4kfRQld0HktPA9K31WMR+7RMV7BkZyFHohDGsgh1Ni/SdHK1cF+2R1gR3
	E44AMjR6bxQC7HScfiopeaR5sHe7tc5H73ez0wWQdpHXWy+DDSSuypMNYDuvBXu91X5OYX
	/zTcFle6IGlpjTeWpb1qWnbZ4sdt3OTUUJzLFXD85jv/Inx7Ng4nrf7Oa/tgwPYKYOHXfq
	q6Qyy6x94JDR5O6fGBJaN8B9vzCA5hihKqFw26GUNovZ5TwZAmuEy2myt3SLTCR/6xVmhU
	05FqmKXjfPLpUsWxlc8ivY1X3kFTZyT6Tj9eDu6viVNU/iM4CR6BdagzgqLxEw==
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
Message-ID: <Zy4c9BFcrz2JVU6k@titan>
References: <20241108-tcon_fix-v1-1-616218cc0d5f@jookia.org>
 <20241108115357.691b77b0@donnerap.manchester.arm.com>
 <Zy4SKCBwce3q0yj5@titan>
 <b26b9d86-4ff9-4543-85ce-176dccfbfa05@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26b9d86-4ff9-4543-85ce-176dccfbfa05@linumiz.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 08, 2024 at 07:36:16PM +0530, Parthiban wrote:
> To add, 0x20 will be DE0 <--> LCD0 and DE1 <--> TV0. Below note (copied from
> R40) states the priority of the DE selection, which fails to work? Not sure,
> may be disabling CORE1_SCLK_GATE and CORE1_HCLK_GATE in de2-clk helps.
> 
> With A133 following the same as T113 with single mixer without TV, still
> sets 0x20 in vendor kernel.
> 
> copied from R40:
> Note: The priority of DE0 is higher than DE1.
> If TCON_LCD0 selects DE0 and DE1 as source at the same time, then
> DE0 will be used for the source of TCON_LCD0.

Hi there,

Yes that was a pretty bad typo, I meant to say DE1 to TV0
The prioritization seems broken in the T113 at least, it's racy from
what I see in testing. I should note this in the patch too.

I looked at the datasheets and kernel code briefly: I can't seem to
figure out what SCLK/HCLK gating does and I don't think the kernel
touches these registers which are gated by default.

> Thanks,
> Parthiban

John Watts

