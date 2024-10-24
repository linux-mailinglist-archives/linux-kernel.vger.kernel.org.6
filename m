Return-Path: <linux-kernel+bounces-380636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E4E9AF3EF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4146F1C222E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E9F21730D;
	Thu, 24 Oct 2024 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srTVQ5aB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F02010E5;
	Thu, 24 Oct 2024 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802595; cv=none; b=JCTYT9rV2HBv1t+q1uI8qihYtqnbvSqnildNn5M5IYFdFCN7OEaHnQsn90qMPK7tlRCmqbuG44+npx3gw+YnjPKHQwBbit6XAwMY+hLI2QPlZ7RFTVSqfZGiT8qaOk+ch6upntzGqk4sER2kWjnka+PeaQm/wcHg8Odm/GhbvcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802595; c=relaxed/simple;
	bh=orvEes6Fv2Qup0AW3+pyjYH5D4wzwY5+810rtsKY0lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGaz9/KO2ih6dX0PIuGfZ9XoJsGdF6LOuyaXEzcOOdTuEinPSY+cBrr26JZ5imkhJpVz4hLxia+SfUt2Xg6w2+c99xHOshBn58jx6uk0CSV21DlP1TEXolk7PcCbI7TnSMr/bG0RAayK9caeI93y63JPw8+DkpkR5Xy9H6m6ipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srTVQ5aB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD185C4CEC7;
	Thu, 24 Oct 2024 20:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729802593;
	bh=orvEes6Fv2Qup0AW3+pyjYH5D4wzwY5+810rtsKY0lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srTVQ5aBOX2/rqg6m0A1ll5HXJrBk3zGKvOExnScO3mg/lp8MD3Uu/7GNare+rNI0
	 YFnATtetlZYcpBy9MUZVvBl9IJ6nDNsJo6QIEsDQeYA6CGJSNZHTWVNIVrnYOVQsSQ
	 s7vzczcpA6yXFsDYEMniUspOToVG5awASk+VHhr7JnqfwvuNqNITnC0TjdMZnRz3Bf
	 Bvu/lxuJ4etfUbCGAXsNSRI0f8dXKCSgVw52q4H3Ld9vglwLJ64RUalRfyTreeWugp
	 FiV16pcUS86F5I17ZVZZKIMGIt/WyykY89ouwtncDZ63QO/WqoQptPsAiXJLHAMv4+
	 EEUFKp110vS/A==
Date: Thu, 24 Oct 2024 15:43:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	dri-devel@lists.freedesktop.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	Stephen Boyd <sboyd@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Will Deacon <will@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Maxime Ripard <mripard@kernel.org>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-clk@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-rpi-kernel@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Subject: Re: [PATCH 09/37] dt-bindings: display: Add BCM2712 KMS driver
 bindings
Message-ID: <172980259231.1015965.14524192141045927759.robh@kernel.org>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
 <20241023-drm-vc4-2712-support-v1-9-1cc2d5594907@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-drm-vc4-2712-support-v1-9-1cc2d5594907@raspberrypi.com>


On Wed, 23 Oct 2024 17:50:06 +0100, Dave Stevenson wrote:
> From: Maxime Ripard <mripard@kernel.org>
> 
> The BCM2712 SoC comes with a new variation of the videocore display
> pipeline. Let's create a new compatible for it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


