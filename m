Return-Path: <linux-kernel+bounces-380189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1469AE9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AE71F21D55
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4388B1EABB9;
	Thu, 24 Oct 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eecpF2i6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBD1B393E;
	Thu, 24 Oct 2024 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782679; cv=none; b=SQ0QwQ5a/zZ/mMRPYnBlhVmwRGSffMdoZeet35j+K9cFnY2Z7g3wkwohqZWb6SrY4/tXfZXaMmXWcwmud2WcKkr7nzB3MLDz/xb445csZ9nLUCTD1o0HCNOP7rW0AQf0lKrxKakzIM7nl4AoqR5VlzquzpUzb9AmGGe60bfVqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782679; c=relaxed/simple;
	bh=I76Gec9xgruH7NQkJwJSzMFNiwa11T/xDsEdrENqZqc=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=UiokGu5diYAF0E0j03KJ4jr489dCyANN/HwlI12sfd8AsCSjjA4fvLV4UKjpWRtJx863V91CxkkqZBLNS+B22ZiuNGaDBOrSFukVtY2rRQX4wbT56wqjazcplGwLItnKQdnFHsMwKFvYb12gTOuiC4d+EUkt5eM+DPBJsU5M6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eecpF2i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2673C4CEC7;
	Thu, 24 Oct 2024 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782679;
	bh=I76Gec9xgruH7NQkJwJSzMFNiwa11T/xDsEdrENqZqc=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=eecpF2i6nIOyz1a7oqzObncQ22J0O0Li2FE+nn49+jrs8lQ31Zm3M6QoqBuLBpPZT
	 yJXvJVHaKsqyAIcnf9GESQF/M3UErCbD5Cw1qwi7TZM96TsRyivmRuHNq4twPmtdri
	 l9gYBKyoO9Zlv6R1wcscx91VUsQWDLFtVTLe2GVky3TZ2FWhxhG2uA8N8Sot+fdUk3
	 OnJ03gBx4abnmCD4+Fd7eENwa/aEuGVrY7tg0phennnE1coK1bIs5FD8JBhJhhASR2
	 iC/bqhMPNaTvkLDuDIeYMA0DaUlPM/IiTisRcDr4JuHFfdKFio+oDT9n2JUV3HOr8q
	 6xfQ6wjA2u3HQ==
Message-ID: <9202d665c15915cb087d8be5f02fee4c@kernel.org>
Date: Thu, 24 Oct 2024 15:11:16 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dave Stevenson" <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 29/37] drm/vc4: Drop planes that are completely
 off-screen or 0 crtc size
In-Reply-To: <20241023-drm-vc4-2712-support-v1-29-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-29-1cc2d5594907@raspberrypi.com>
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

On Wed, 23 Oct 2024 17:50:26 +0100, Dave Stevenson wrote:
> It is permitted for a plane to be configured such that none
> of it is on-screen via either negative dest rectangle X,Y
> offset, or an offset that is greater than the crtc dimensions.
> 
> These planes were resized via drm_atomic_helper_check_plane_state
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

