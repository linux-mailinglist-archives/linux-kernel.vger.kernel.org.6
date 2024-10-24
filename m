Return-Path: <linux-kernel+bounces-380626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958D49AF3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAB41F21566
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FA216A1B;
	Thu, 24 Oct 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEJE8izB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBFD1B21AF;
	Thu, 24 Oct 2024 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802459; cv=none; b=gEPj851t3j+W/ElhkkBaRWlUuD0qwd5M4bE9gj92ZT2IZsI2sEldQFPbnWW/A31dTNN1C6Hej4JjW4zFXeQtt9epYBkxJXfBCdZL5q5kQUltg1+HC0WaST0DlMDk1GlDeqzZ+WEhqW4g/PTJqZYYn/FEtDbt5UTof2OgRCe9Q6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802459; c=relaxed/simple;
	bh=mMLwDduZ3xaKPZLGXPUhMR7+mEPMB7iB0xxVnV3jIAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REOF1V6UQhCPMgnjsIjvaCaWScRQ4pAoZc7MXaZzR4VLGGwMsupFv/hPih/b67mzkZvAUYR43ScXMx0/NTQOPOMxZkvGg2BFGlot/gR0wuUQgg4j7cqAmi+y1YZTfV8frwicAaLrJuP5FMwpUDZvw5VgFXb+rd6aY1U1WTEFx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEJE8izB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CF7C4CEC7;
	Thu, 24 Oct 2024 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729802459;
	bh=mMLwDduZ3xaKPZLGXPUhMR7+mEPMB7iB0xxVnV3jIAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sEJE8izBJ+cP82Efa7daFEyfmBgH8QvXEHr6eQ3e+5/ZURby2Zdg1uv4iK05E7/Zm
	 vpQboJImDbckilahc63B+vU8c75+KdIId4vZWDuFoMIoptGO5iHs/GVX3WMFCru76o
	 aNCuJVRliOZ9DDYRCfTqQwkN6s5SJhTtP0BWk0coYUxbKWgH4AN1HekU6hNZBePpUs
	 UIOMggTnoSPxtV8wLbnlPyU6JgO9QyIYK7ROez3Ng4s83KCIvVawXGn3OKEoGrOgAh
	 xVeWve4B3YNLDlD4G0J53rSmJbfdr6iFX5e7I5YniyOVWMcUmwr8CWw1HJSg9lzqz/
	 xbPoiSIRV0wFQ==
Date: Thu, 24 Oct 2024 15:40:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	linux-rpi-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>, linux-clk@vger.kernel.org,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	dri-devel@lists.freedesktop.org, Will Deacon <will@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Maxime Ripard <mripard@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH 06/37] dt-bindings: display: Add BCM2712 PixelValve
 bindings
Message-ID: <172980245756.1013194.11978023436348943569.robh@kernel.org>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
 <20241023-drm-vc4-2712-support-v1-6-1cc2d5594907@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-drm-vc4-2712-support-v1-6-1cc2d5594907@raspberrypi.com>


On Wed, 23 Oct 2024 17:50:03 +0100, Dave Stevenson wrote:
> From: Maxime Ripard <mripard@kernel.org>
> 
> The BCM2712 has 3 different pixelvalves that are similar to the ones
> found in the previous generations but with slightly different
> capabilities.
> 
> Express that using a new set of compatibles.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
>  .../devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


