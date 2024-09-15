Return-Path: <linux-kernel+bounces-329847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CAA9796AC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05F51C20E96
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF701C6898;
	Sun, 15 Sep 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMxf6mYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C01CF93;
	Sun, 15 Sep 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726404832; cv=none; b=F1NWDLBtUlruQEy72h737VLFyYQeQWg0A4NclPLKaadsig24BlpifOf451C6Xc8ZnX73E8smMPam++ocYbqgMXR235XJruMInWRFueMgDFo8y7pZPj0Lv6fz860dw+3aoywkMttAXbhNeXrke/JKaUmD7sRXPufzJHRdtZJMEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726404832; c=relaxed/simple;
	bh=LPJ5SATag2i0d8UFpP+hkORo0mZC23PbErfvFGCVqJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9nUJ7JZaMvSS0EyIW3JZfAZoQu0r8PLPy81KkZuSdMa1UaUbwF3cltRZgVuBm77ePQcrwdf/2mraX3boY+7n+kAkSSdENSN2Fcg/ecE2oTB9QOagwa7aj00r8B+de2mdmupSz1dY+xOGQAMIWleA/3pWGAsyl9/zUr9PlAwhzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMxf6mYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717F5C4CEC3;
	Sun, 15 Sep 2024 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726404832;
	bh=LPJ5SATag2i0d8UFpP+hkORo0mZC23PbErfvFGCVqJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMxf6mYI3/Svo9TsCtzjNWE1vej95mXh2wk9matrrdRv3nG7QqtYJPKpEKeRjhEmI
	 oKgfYRkJcVVCg9cZrDz6rgbKMdpfLkpcu3mSPBDaU3kdAgjHs+917hso7w3eRDHsye
	 BJxcjCQk1n7xj8TApOhO+OXve7noX8QgmxAw02nfpX3i7n09SV9hvmqbayEu3xcW+4
	 NzMugVQ3ji3NOemBG3qibn9zG0CliflB9sTx/nyRY9cZAmENsjRfeD1QD6LOq38Rf5
	 BszHw+9SaApfNT6NDik/aTV5dCJji76rZ5K5e9WD+0fy9x+mP6hXVa+x0h7VkmaMvp
	 0IXuKrkctidCQ==
Date: Sun, 15 Sep 2024 12:53:48 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>,
	Hugues Bruant <hugues.bruant@gmail.com>,
	intel-gfx@lists.freedesktop.org,
	Brian Norris <briannorris@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3] firmware: coreboot: Don't register a pdev if
 screen_info data is present
Message-ID: <ZubY3NtRJWWTS1ON@google.com>
References: <20240913213246.1549213-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913213246.1549213-1-javierm@redhat.com>

On Fri, Sep 13, 2024 at 11:32:29PM +0200, Javier Martinez Canillas wrote:
> @@ -27,8 +28,10 @@ static int framebuffer_probe(struct coreboot_device *dev)
>  	int i;
>  	u32 length;
>  	struct lb_framebuffer *fb = &dev->framebuffer;
> +	const struct screen_info *si = &screen_info;
>  	struct platform_device *pdev;
>  	struct resource res;
> +	unsigned int type;
>  	struct simplefb_platform_data pdata = {
>  		.width = fb->x_resolution,
>  		.height = fb->y_resolution,
> @@ -36,6 +39,20 @@ static int framebuffer_probe(struct coreboot_device *dev)
>  		.format = NULL,
>  	};
>  
> +	/*
> +	 * On coreboot systems, the advertised LB_TAG_FRAMEBUFFER entry
> +	 * in the coreboot table should only be used if the payload did
> +	 * not pass a framebuffer information to the Linux kernel.
> +	 *
> +	 * If the global screen_info data has been filled, the Generic
> +	 * System Framebuffers (sysfb) will already register a platform
> +	 * device and pass that screen_info as platform_data to a driver
> +	 * that can scan-out using the system provided framebuffer.
> +	 */
> +	type = screen_info_video_type(si);
> +	if (type)
> +		return -ENODEV;

Given that `type` and `si` aren't used in otherwhere, the local variables can
be dropped.

I haven't had chance to see how to fix the 0-day build errors properly.  If you
have chance to send the next versions, please drop the local variables.

