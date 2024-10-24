Return-Path: <linux-kernel+bounces-380203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B20999AEA24
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20CF1C215B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168F41C8788;
	Thu, 24 Oct 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWjQjEyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A73833C9;
	Thu, 24 Oct 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782963; cv=none; b=nnzQqpnmPVvGnY0xcSDPcVQIzp+hc7KZhBuCROIGFtus9YBl197DoW/Dmau84AavoNwbWfjbStz5kN+kKnHWxiMJX5+M5DeitLkBU8z1RPq0TjP9AGDysGyyRJ+ItIBeUGPKZB13W9wxG9NZshkiXQHCcYEviLC2ZoKHfyJS1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782963; c=relaxed/simple;
	bh=/gnpu4B8t4IL7ynEXrUUxsgwtBS+XtHTbgdzxW9txJc=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=hVEcAENYubLS2oKICyjr4wfImmbrcXsC3FY+BogfOsq84VZWTQNUA4Kj8cuIcjUJvjV5fMEx7Jr3BHo5qz/xWuG8C2Cf7RjTQSnsIA7i524SO1FPBMg6Bv/zSPuNxgB5yvUuLVhaUJkByW+xdjueNBOuQVB0bO5vxTXqgIkEOZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWjQjEyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC13C4CEC7;
	Thu, 24 Oct 2024 15:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782962;
	bh=/gnpu4B8t4IL7ynEXrUUxsgwtBS+XtHTbgdzxW9txJc=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=EWjQjEylN9jN2AYF2Z+Buio7/U4Het2kbl4zvp7VcNMpe6uoxAQnKKAheRPTROr1y
	 4KXRC7fWnDWpF3EOlNWbZhf7g5pYMZrH/GOJ7zGGnEop5veigljsQuodcz56osmzJ5
	 myqrlmGwY+71MRipkTD0WB6g4wWycrRyhrgFd2ChRzAia1fuC8CZR3SvriCiaElllI
	 rBTRXObrnyhUHOEXb32JT8kEDLsDSaMEqCHVStep7+CGKa6NSuVeXQvSlqKDW1EdXV
	 puab9WgqJpvvQXLLnMUHWE05nGDShEetrFoMi9HspQhyDJfo+j8dBPImpNV5++Wcsr
	 DMxmwgT9KrjOA==
Message-ID: <499656b677fc13544f5e0e46e5e887ec@kernel.org>
Date: Thu, 24 Oct 2024 15:16:00 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dave Stevenson" <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 03/37] drm/vc4: Fix reading of frame count on GEN5 / Pi4
In-Reply-To: <20241023-drm-vc4-2712-support-v1-3-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-3-1cc2d5594907@raspberrypi.com>
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

On Wed, 23 Oct 2024 17:50:00 +0100, Dave Stevenson wrote:
> The frame count values moved within registers DISPSTAT1 and
> DISPSTAT2 with GEN5, so update the accessor function to
> accommodate that.
> 
> Fixes: b51cd7ad143d ("drm/vc4: hvs: Fix frame count register readout")
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

