Return-Path: <linux-kernel+bounces-380184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC1E9AE9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9757B233FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B991EABD7;
	Thu, 24 Oct 2024 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvPDyC2U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310A1EF08D;
	Thu, 24 Oct 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782579; cv=none; b=MKZnwfQ6OtqTVPYGp0Zr4v8TEvr8pm0TfLUWihfYNHaYg/SVykV7Snh5NhHTzvw9Pnx1yoJXG/UapfXs0+hVtmLdGkpbn/po9O6xZMkj16oeBjJc9meEqavDKH6bj3dCAhorcITixzu0j1d3ZR0kUlxElTk6u5bfWOIhBlV6VYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782579; c=relaxed/simple;
	bh=GIiZShzCqbp99Okh9K2VfkZMwriJp7KN0xaKA+283IY=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Mk2TGM8aiheVuJwDq4crAQtvMPCpxkpD1o55xEEmBmCICc+BPn3DUK8U2B55tIw4H0XbEf4zyTiEl1UVmVPeFaA/0vaVYANfek/h/sD6ss/dUf+xPzma8PGBRSznHRX+BNbvIH8AmTKtiiMeOko/VRTWrhzT0O/ECDqJHOM3vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvPDyC2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB4EC4CEE4;
	Thu, 24 Oct 2024 15:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782578;
	bh=GIiZShzCqbp99Okh9K2VfkZMwriJp7KN0xaKA+283IY=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=ZvPDyC2Un38oYBtXvX62d7ZiTOxbZfyC6ow/5abzyjUw3l5wdjqrX+maMLCxsR4Hd
	 sRNWXU9EdpeaIeGxfMMwYLRbm6VNHAJRUeD2vf5/cGiA2Y8ZpvTLygF1N71EpJJ2CY
	 5W84akyxhzpMGZY0Eulx8m+WnlIKA8CZUqE3GBza5Pi9rhTYPkJjG55F7QSngHM5NI
	 mfuVjIqjRpjLYkSR11vOuiePNEjHfHfr2GW6ABT8jDV0nb+Vu0pzBiOYA6aukTXLVo
	 9hcGC22txWIX0M1ttV5FEfeQjBKTvB/aE4IhyePcahWN12A1RaQarZy/1z65AQNd81
	 tTLlgpCR2iyuQ==
Message-ID: <66e7319a4805b42af2b2a4a20dc8faa9@kernel.org>
Date: Thu, 24 Oct 2024 15:09:36 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dave Stevenson" <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 26/37] drm/vc4: hdmi: Support 2712 D-step register map
In-Reply-To: <20241023-drm-vc4-2712-support-v1-26-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-26-1cc2d5594907@raspberrypi.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>, "Catalin
 Marinas" <catalin.marinas@arm.com>, "Conor Dooley" <conor+dt@kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Florian Fainelli" <florian.fainelli@broadcom.com>, "Javier
 Martinez Canillas" <javierm@redhat.com>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Michael Turquette" <mturquette@baylibre.com>, "Raspberry
 Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Ray Jui" <rjui@broadcom.com>, "Rob
 Herring" <robh@kernel.org>, "Scott Branden" <sbranden@broadcom.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Stephen Boyd" <sboyd@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Will Deacon" <will@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Wed, 23 Oct 2024 17:50:23 +0100, Dave Stevenson wrote:
> The D-step has increased FIFO sizes of the MAI_THR blocks,
> resulting in changes to the register masking. Add support for
> it.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

