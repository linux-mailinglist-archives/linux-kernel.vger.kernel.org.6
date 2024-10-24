Return-Path: <linux-kernel+bounces-380185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E909AE9E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9C11C2505A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810CE1EABB3;
	Thu, 24 Oct 2024 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9EC93Ux"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74A83A14;
	Thu, 24 Oct 2024 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782604; cv=none; b=hasWzCWN2JChSmnXw/jwVehmQ2YdGj7g7GbDkU/Khbpvisqkt4p2OFnjSM1tuXqyOuhJ35OeddCE63D1ZHLwMOk3NqynlLZJD+13C9ONbJRbuSzLDPjXbZtjZ3AIaTE9rIU2xdu96tVt/BG69r5lCs3wBSCbq0Xlxhzd8u2h3eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782604; c=relaxed/simple;
	bh=VMFs9dmln36rULHELZnrUMSHBuywGkITllI3k0F8SzM=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=QMxxKCGcRqs2qPTTVEAd4Es4zeUMp6PY1Bu2rsnPOrZyFQDEZVXiIRt37USjE5GGXFKAnByH6rii6xAlfwkh6v6BqvVWivLw7z5Iy1ROLA+at+83NF/xi5+jTKjAfWJh8uGJN0vhtVTLr6iA9lZpbohyFt8dZPnvgeaJdomrWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9EC93Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FE0C4CEC7;
	Thu, 24 Oct 2024 15:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782604;
	bh=VMFs9dmln36rULHELZnrUMSHBuywGkITllI3k0F8SzM=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=Z9EC93UxAcJyaTtDojfNt/Fu3i3015IzTXL6vRFRwso6gj8phUyldJ7Ekf5kjNDVT
	 4N/K+qPmyTw5fFrBwxp3kO/DPWYf3HwhLRsY4Npr7VA/UacwXiNt3QDnAxHE+vk18x
	 6KT5LkITQb5Qdgy9o8vQfU0iWMsPJ99kHFbAP5lKaAZwW7Af4GRdW6hShEjy/k0J8Q
	 yJybhfMppI7PMbJiYREK5ZOQsy0qCVzxRSLnExvemUjkVWmv0Q/Hrq3buRE7NdpGxx
	 BMIAlMUmtHwn/xfV+Ci85xYy07nFTmncxUt6RTL1Q1OxR+by2JNsJDcdp2WqzPOim1
	 jevI+VjrTD1UQ==
Message-ID: <76a344eb23149909d13ea46c25b97684@kernel.org>
Date: Thu, 24 Oct 2024 15:10:01 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dave Stevenson" <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 28/37] drm/vc4: Enable bg_fill if there are no planes
 enabled
In-Reply-To: <20241023-drm-vc4-2712-support-v1-28-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-28-1cc2d5594907@raspberrypi.com>
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

On Wed, 23 Oct 2024 17:50:25 +0100, Dave Stevenson wrote:
> The default was to have enable_bg_fill disabled and the first
> plane set it if it wasn't opaque and covering the whole screen.
> However that meant that if no planes were enabled, then the
> background fill wasn't enabled, and would give a striped
> output from the uninitialised output buffer.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

