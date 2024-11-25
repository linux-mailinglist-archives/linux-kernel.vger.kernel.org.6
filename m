Return-Path: <linux-kernel+bounces-420674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B59D8202
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E6C1620D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD018D64B;
	Mon, 25 Nov 2024 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpPx+Qo2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1776026;
	Mon, 25 Nov 2024 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526141; cv=none; b=uyLdhApl3QiR+JgFUZpR8J4kCDeoOWM224MsUCMN9Nvwcc6j0DhLt+wBfil/KXffhxXyBByuOGP2aXngBTclVyDUCyIUzThTW1bY6kxVxevdYb52oT2EEwtqMzA+m8vlM2DYKDMfWVloHq71a8Ww7nhpT5c2eQlKg4JzxMrHj8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526141; c=relaxed/simple;
	bh=IRcmX+kFalTpcSK8+zzcKFRuZILPS7wKDDgoGabM+io=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=cX2d1OsY2si89izgLV3HEls9WxqXByn+2w/9dkF4d9u1/CRMiw9DJgzWOq973P9alvfsTppT1iN5X6kdfdgg8OrJFciAsIcj48MOADA78IflpwO4jYLgzDKom5s4+O2DVB8sJEvOdJdZyosHBMwC1FJYVA4Ay9RGuj4XSmcvAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpPx+Qo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF05CC4CED3;
	Mon, 25 Nov 2024 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732526141;
	bh=IRcmX+kFalTpcSK8+zzcKFRuZILPS7wKDDgoGabM+io=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=QpPx+Qo202rIesU6hZWyg4cz5JxOXDshswbouHI57nf7BX4EHA3I0vZbXhmJvP7sW
	 iKdvFvojGpDjfq4E3akvfGt0iYJUtIJKHrtNcuBCVLBP+bRWeCJ0zRCdr3VApwC+Cv
	 KMHXl/5iNeU9Ptt1GRX1qy4ubTBEJMZ/zr10SnHNx3wfb2jd+xkCcYZBxeu0lB25UO
	 seArg2dYg5S1tyDQD8/bjOgGJcmBP4IkTsOlT/+eQ0pvXRXfZA+NQ7EtTMiht48wy6
	 9NwGpOsyd6as6csAH2QitozGdCZUJoTIipGrxZTpRE2nP+n5SHw5IQ3pBG7ViY9UFI
	 bhGDoCkkUoJvA==
Message-ID: <0f588822988dafd9a8acd3ca86731be6@kernel.org>
Date: Mon, 25 Nov 2024 09:15:38 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 10/10] drm/sun4i: use
 drm_atomic_helper_connector_hdmi_check()
In-Reply-To: <20241122-hdmi-mode-valid-v4-10-2fee4a83ab79@linaro.org>
References: <20241122-hdmi-mode-valid-v4-10-2fee4a83ab79@linaro.org>
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

On Fri, 22 Nov 2024 11:13:06 +0200, Dmitry Baryshkov wrote:
> Replace sun4i_hdmi_connector_atomic_check(), which performs just TMDS
> char rate check, with drm_atomic_helper_connector_hdmi_check(), which
> performs additional checks basing on the HDMI Connector's state.
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

