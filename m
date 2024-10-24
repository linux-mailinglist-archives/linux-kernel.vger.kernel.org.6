Return-Path: <linux-kernel+bounces-380181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921089AE9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568A3281B69
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34E1D86C0;
	Thu, 24 Oct 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVaIwfYm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7871B983F;
	Thu, 24 Oct 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782562; cv=none; b=hm2P24tncGNFFkDX7uCKas0s4FG7bTiXK1vN6H31NvuxZpD9iohNkUDfRj/cVnZOzrHP7KpCeCqud8Z/BzbrBNzTD9Xlq94qpI221LlJvT7hSUo7QhTS2KDmvnxBCS8BivhEmslfFEGNo+oik2mDnIyqSxbZXWpdlCmScprSoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782562; c=relaxed/simple;
	bh=ojYx0PQYtL8ocNe8PCalEPMZedU+ieflQax3vzhR5e0=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=ktjg0mcZo/Ye5iPZPjVQCf2QRr8ugkdckaYUMI2JVGZyETZd8+/Sm8QSJDupvqz0i2dBLvf2fgMFS6sjJTgLVWkykvh12vC7fO4Wpd2yYta+XVlLSEtEC7WjqtJu8b4d1ejSMsG/ldMwlTrjsi0woUKzndC5R/zTOIfszZdvnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVaIwfYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314CDC4CEE3;
	Thu, 24 Oct 2024 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782561;
	bh=ojYx0PQYtL8ocNe8PCalEPMZedU+ieflQax3vzhR5e0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=hVaIwfYmQk52sKxzCADhMo0WcbOetCF2g/REWq7oymjGx8oRznaiKgKrGPKVmxD6k
	 PQT7/n9GQAnqpln1MfosQhKztUZg7X2MGKQTBYttK+vdGWxXLQHPVRshralR0mIGEY
	 v8DKcZD84N6WtUowmVQU/LS00nA/JYP7l3lxmKLAKcNqdnHkVDf8zi9uMLFuaRaswO
	 rbrSS41iWYkqBh7Ze1XQ6gH5cxF666cxMZiPJDRJp3rt45BLxOP5VRxMEPtbNDfN0B
	 pVLq26dqM8iFN9nnKp1bmf83dNRkQCdzL1WOaTBhy+gRFvRNfV67d33AiaqBuByYaT
	 mcuFPQ5XcnmHw==
Message-ID: <c7a4b58f0b557fab0c2b7824d50583e4@kernel.org>
Date: Thu, 24 Oct 2024 15:09:19 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dave Stevenson" <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 25/37] drm/vc4: plane: Add support for 2712 D-step.
In-Reply-To: <20241023-drm-vc4-2712-support-v1-25-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-25-1cc2d5594907@raspberrypi.com>
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

On Wed, 23 Oct 2024 17:50:22 +0100, Dave Stevenson wrote:
> There are a few minor changes in the display list generation
> for the D-step of the chip, so add them.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

