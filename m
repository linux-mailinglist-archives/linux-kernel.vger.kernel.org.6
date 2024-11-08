Return-Path: <linux-kernel+bounces-401787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7469C1F32
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D804B22BA1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F751F426F;
	Fri,  8 Nov 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5KQxzZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478C1E0B66;
	Fri,  8 Nov 2024 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076052; cv=none; b=gjAFtwlE1mXfp7aCVP3v2sFbRvAgy1nNf8HPpruE2n+t7ubjaCPYykqPsJFQ48t9+jFn9uyNsFPdfraif29UH9M+fE5p1eBDltKZuB+cQIpB26OShy2tXuMBpjgGzZkkKGDwQhAklt4FYwwFSlxPZQ79IE5e8pclfgh4hB2eqBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076052; c=relaxed/simple;
	bh=TaXxmL3Sbql1QbTmuvBM7Dof2vpIsU/GkgSL8ibpxg8=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=ShWBBgkrqIZFOmgZrCJRQ8crq2pcKqRIhueO5lvI0x5uFIht8R9Mfxer27YIV5VdWARFyz4xByxhqdqVLwW3jvXH1FDZttr32vwl6gc3JOQfThxCMfFiulQ/IRRfkY/1ErlYILU9Zig/E2w7JIxfAVhTVXbWWZayOb4kIzrg98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5KQxzZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B668EC4CECD;
	Fri,  8 Nov 2024 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731076052;
	bh=TaXxmL3Sbql1QbTmuvBM7Dof2vpIsU/GkgSL8ibpxg8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=R5KQxzZlAFfVQAq5dzIpTD/ohWpQth+/2cFBONVNNdTC16HlhikPnefvAhxuQXuqq
	 PoTz8ycYmBwDfUAt/gB9CImJwKceEmSByVoGp23CAKwY2vT6OTKMuBZpAJrBrvzVQ+
	 HSKM9o9ItSRwvd2LkHsBvzBO/EnXU3UUQ9e2qc7DsP+96UkDGqeZOMoV5WOVlJNglR
	 xULy4jp0GzoINpxVf3BjGYkyzPjMn4tjzl88bR3gjh+54Px9txMbSIik39g8NHTWjk
	 BThA67HdclpWhpzRIM+k2sjlWvLd+KUKOe77FYVfYh0o7bIuibMwG5SCQehtnXvABn
	 AmJibhtw2CsPw==
Message-ID: <6d729a59f8a6f6f0c7454d506c7dd3ef@kernel.org>
Date: Fri, 08 Nov 2024 14:27:29 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 6/6] drm/bridge: dw-hdmi-qp: replace mode_valid with
 tmds_char_rate
In-Reply-To: <20241101-hdmi-mode-valid-v2-6-a6478fd20fa6@linaro.org>
References: <20241101-hdmi-mode-valid-v2-6-a6478fd20fa6@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Chen-Yu Tsai" <wens@csie.org>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Raspberry Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Robert
 Foss" <rfoss@kernel.org>, "Samuel Holland" <samuel@sholland.org>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Fri, 1 Nov 2024 02:25:09 +0200, Dmitry Baryshkov wrote:
> Replace .mode_valid() callback with .hdmi_tmds_char_rate_valid(). It is
> more generic and is used in other mode validation paths. The rate
> validation for .mode_valid() will be performed by the
> drm_bridge_connector code.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

