Return-Path: <linux-kernel+bounces-369936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6E49A24A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B9B1F224A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD6A1DE4D5;
	Thu, 17 Oct 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfkODlVK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980231DE3AB;
	Thu, 17 Oct 2024 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174284; cv=none; b=Ot69Pt6M3hjgz/vZjj/lypfI6Q8LGTdiI8BdnsmXeFfSYOEDsTxBSC41X3ou5DXWi3W0QQ/Uc9NQsr3tIlu4bw9udbH5dHBJoHhE76ELbKw2D/rvfIn0GWv+yrE+Q0JtH22t3EAmHpohdTITG2izJYmS7qCwUMeTY264EjNEXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174284; c=relaxed/simple;
	bh=P7LRMT5V/UAyFIi2zjmQ8b9UCs/nHWtLwIpUD5KHXEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mHFq0PiIGgxR4R7KRDsOzZJNUT9IQSlh/KDRsnxr3uSAAql4xN95/+SrwX68wVo75X7KfINKliBV58BJtVdth6dA3UB6xW3PjqvvTGMHqg6JJ41MjS1utrFUY1C6wnXuRSaDHE0n8f7KwONYiX4yQFMU83hmn0Sl6C3G4bgXuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfkODlVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D9CC4CEC7;
	Thu, 17 Oct 2024 14:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729174284;
	bh=P7LRMT5V/UAyFIi2zjmQ8b9UCs/nHWtLwIpUD5KHXEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GfkODlVKHsJs4WEAUl905tfbJfpPdYBTdfoCoXofZmItiDs/4HizBJj9RBBE48ih4
	 W/Bw42A/lq2IeoXZimuhybKEs82zyRTvZ2hQavgauH4bYRUpq9qCJXsrScAXdQd55G
	 LTcTeJk4AWepF1iEiBuMrsgT/Gv8jOdPIFG2ifE5OdizRABk/MXNwWf10w70yXmnZJ
	 lg/0JK44YH1o8vC8sr6Tvk4V0ZcrG5iteD+p0fDStyxAllIS3RNrzzf4MSDWnVEglL
	 crgkUosfeNtf1VmdwcV8CaMztC+8OS9ox8qc8abN24hGoiBBkP1+be/pT+n8Rcu0aF
	 cltg8Ev5uxTdQ==
From: Maxime Ripard <mripard@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>, 
 Algea Cao <algea.cao@rock-chips.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241016-b4-rk3588-bridge-upstream-v10-0-87ef92a6d14e@collabora.com>
References: <20241016-b4-rk3588-bridge-upstream-v10-0-87ef92a6d14e@collabora.com>
Subject: Re: [PATCH v10 0/3] Add initial support for the Rockchip RK3588
 HDMI TX Controller
Message-Id: <172917428139.3344404.160573495360164649.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 16:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 16 Oct 2024 23:06:50 +0300, Cristian Ciocaltea wrote:
> The Rockchip RK3588 SoC family integrates the Synopsys DesignWare HDMI
> 2.1 Quad-Pixel (QP) TX controller, which is a new IP block, quite
> different from those used in the previous generations of Rockchip SoCs.
> 
> The controller supports the following features, among others:
> 
> * Fixed Rate Link (FRL)
> * Display Stream Compression (DSC)
> * 4K@120Hz and 8K@60Hz video modes
> * Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
> * Fast Vactive (FVA)
> * SCDC I2C DDC access
> * Multi-stream audio
> * Enhanced Audio Return Channel (EARC)
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


