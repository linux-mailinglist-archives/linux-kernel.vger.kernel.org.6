Return-Path: <linux-kernel+bounces-380201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CDD9AEA1E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622D11C22A19
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D6E1EF0A1;
	Thu, 24 Oct 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UV0Y7R/6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BF1D5176;
	Thu, 24 Oct 2024 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782887; cv=none; b=PQpoi3qpFQ0FyB/z0SLxLKKi+X+3WWwJo2bF+pAPZcSO4j0aMFEbB0ilJJrf2dMq6oUxnvxn66SsQyhAa8s1Pxqhtl+X5BNVdeHT6tduVU1GliDbI9QwpOflsscI2ct9mxJvM/5sObwglJWtDMbrhyEJKgELXTiAzqzk4iw6/KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782887; c=relaxed/simple;
	bh=Fhhtx0SKw8R7fwmiWBICVYOc8q6+cAez3j0Ek1hM190=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=dq8ZQAhQdvQRo/R9mai1qEXF9Pcv8edK7L/MROa2k/9qNa5GJHw82X6G40QMiWkflWUBFkpVVcZJz/g9mo+lN33Tx7TyluRtaBPoTGu8QY72zacB1AdJdRWnbN/LpjuK59eTC3MUQ4E8y0BBdsAvuTdoZ0NwaidqRSTgTUHIIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UV0Y7R/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B0DC4CEE4;
	Thu, 24 Oct 2024 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782886;
	bh=Fhhtx0SKw8R7fwmiWBICVYOc8q6+cAez3j0Ek1hM190=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=UV0Y7R/6YQiFBOZvJUQydU4Yxt+U9SxMjlRxZMea1owRTDM7Fti6imYGZVsIfWN41
	 oDctMYnTbJkbl3KGUJT+O1oXccwmPXnsC/EhPzxPzT/Lle/JOhuEXOXAKocPRREOom
	 pTNzMTAIv3X/bQqAFV5AaPLK7Zc5DyqeJeVz0+nyoasRrT5zawOKBSgfqyI+m3RHVg
	 3mYcbqSAiNv+U5FoLoYpHzXS3BCnWzINmPdSbeXL41n/j6FBSHLIdYaHnatCaxhwMR
	 igF5ds7OCBby6INyeeOz0c9DLocUYF1KlKyHVDOlzuu+hvA8E5RVkxbLwbENIzdlIE
	 YbwEs/93bZDJw==
Message-ID: <baa171fd4e0cd7ddf2d4ce593b690ed3@kernel.org>
Date: Thu, 24 Oct 2024 15:14:44 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dave Stevenson" <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 02/37] drm/vc4: Use of_device_get_match_data to set
 generation
In-Reply-To: <20241023-drm-vc4-2712-support-v1-2-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-2-1cc2d5594907@raspberrypi.com>
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

On Wed, 23 Oct 2024 17:49:59 +0100, Dave Stevenson wrote:
> Use of_device_get_match_data to retrieve the generation value
> as set in the struct of_device_id, rather than manually comparing
> compatible strings.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

