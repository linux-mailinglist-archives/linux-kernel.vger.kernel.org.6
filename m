Return-Path: <linux-kernel+bounces-380624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100E09AF3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814001F21B20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40617215033;
	Thu, 24 Oct 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzgqw8iV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A93147C91;
	Thu, 24 Oct 2024 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802386; cv=none; b=AkDS5XnlV9EbZ4AU7ke5YFkFJFKTcIpZsKnqiULuPpRzIU4KqnnZlZkDoozum6XvF7sRBMdZHj853p//xMUyQNNAoaqgUm57FhsnAF4QKvcQPjll9cdPWOnsCHAevOCSsp9tw8Uyi5pESV/PnD6/hbGutMcTYBJtP6Va/78OIeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802386; c=relaxed/simple;
	bh=fu1NI55gqVY8lwDobFa1EKGS2z61s5XU7//5aqHBG3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMaBWv47IT/aGBXlVCoWkr6HKGeWg3tRxwTHW4vYluYrQEPsJeF4/goaCezeHAS5jCKTmyOIeNX3bo0cBTUPZuTL1iJDjgBbfgGKpdgh0zky27Ew7+3IUe9CfMwa2pzmVLTf0PS4OA/NZTTrB41PUQJeQz03dTbt/5tHlKTIbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzgqw8iV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D80C4CEC7;
	Thu, 24 Oct 2024 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729802386;
	bh=fu1NI55gqVY8lwDobFa1EKGS2z61s5XU7//5aqHBG3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xzgqw8iVGQU0dI3OeuHLmVLmbJ/SEFjLNv6oxbdrHizj2AZDaCc3n9Vn4SxbyTUrs
	 T/qy1UKhHCnIdwOhjTrPnsCybxcQq7KfQ3XRLHHgCqjParoNauu523K51H21HrnyfN
	 HqJWMrzazZJfXjP4kM65OpfLBnBh9G8Do+HPWQ8qvqwsaxwqQXRjajFWwJIVj25PJf
	 S0duQysEtoqfpsCtOVRENsl9UybhyIS7YTliJcp6o81yrtGbcmiGMQwiAyDU0VywTY
	 QB4HlPDkRK68GrQc+X5pk5MZEzX0UTvfHpKSBfFDzZuq1+QJkGZuHBbI9ST696kQQJ
	 YPksUDIai5H6w==
Date: Thu, 24 Oct 2024 15:39:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
	Stephen Boyd <sboyd@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 04/37] dt-bindings: display: Add BCM2712 HDMI bindings
Message-ID: <172980238460.1011654.10730669025533473709.robh@kernel.org>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
 <20241023-drm-vc4-2712-support-v1-4-1cc2d5594907@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-drm-vc4-2712-support-v1-4-1cc2d5594907@raspberrypi.com>


On Wed, 23 Oct 2024 17:50:01 +0100, Dave Stevenson wrote:
> From: Maxime Ripard <mripard@kernel.org>
> 
> The BCM2712 HDMI controller uses a slightly different HDMI controller
> than the BCM2711, and a completely different PHY.
> 
> Let's introduce a new compatible for it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


