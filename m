Return-Path: <linux-kernel+bounces-420677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC959D8208
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3640D281A11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF74A190696;
	Mon, 25 Nov 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmiHhwjB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1C19048D;
	Mon, 25 Nov 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526190; cv=none; b=aFXTmnMCYhwRZBTy0Xy7LnyCZegh08XO4w7KauK+4tPJBI+PFC3gg0FvcsVQs0COc+y5zXMRiZCkwR5HHp8/i3oQM0A7P065DD1GGkwFiD7Jnh9HOxR+HCO/v/RZiE8wP0etgboL6EAMrY2xwvUHAJjbV2k0sBiO8HpAlV5erS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526190; c=relaxed/simple;
	bh=0k7jgGvkFXzafjUapZMYG1Qcle4a+6D/0t/ThVVD23g=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=iXYT3rPA2Ysm3ESp6UOYdUYgKsFtZp+wUQwTWHqjAXOlWzNPvWtO9fFqgdQXYKRs0RztcH72wsVxMrJvIGvMb/zAzhdLISL04ssbcxLDlL2yiqAm00UPeF/zxpwl+cbt22eK/lWR369gV4yKnK3RjEBsmjA7UzbEedmq8SbNiTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmiHhwjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772EFC4CECE;
	Mon, 25 Nov 2024 09:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732526189;
	bh=0k7jgGvkFXzafjUapZMYG1Qcle4a+6D/0t/ThVVD23g=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=RmiHhwjBNeTuge8/ebrVQFewoge1S35Ob75fEqEVLj4IZb5EuKI7ZiYIUn0ZK60T0
	 y6MxkdbKCbojE/THM3VGgR2xTx1TY8QeDBmLixxXQ+CwJ8pAGojZZlVEEn85HuLnTA
	 slsTF9clpq3Vm1vecEd297c/C2GlytGzOD9vpLAD/4PVug9KJp80nzikGN02k7OB+h
	 l3wa4IeZzsbbFO6cESNxumWpnc+ooZaWV1x5DE1p4e59AvWx4Ow2/uT+1rt+Sba1dc
	 RlRl4T6APZhshFRXzu3wPZUea5LXWvXo5pVyRssie73KpTmcPQVd39/T4SK0eQW1vh
	 /N6nMYNpbm0PA==
Message-ID: <7e21ca957adf9bea6df99767cc28fe82@kernel.org>
Date: Mon, 25 Nov 2024 09:16:27 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 03/10] drm/tests: hdmi: return meaningful value from
 set_connector_edid()
In-Reply-To: <20241122-hdmi-mode-valid-v4-3-2fee4a83ab79@linaro.org>
References: <20241122-hdmi-mode-valid-v4-3-2fee4a83ab79@linaro.org>
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

On Fri, 22 Nov 2024 11:12:59 +0200, Dmitry Baryshkov wrote:
> The set_connector_edid() function returns a bogus 0, performing the
> check on the connector->funcs->fill_modes() result internally. Make the
> function pass the fill_modes()'s return value to the caller and move
> corresponding checks to the caller site.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

