Return-Path: <linux-kernel+bounces-333586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB9297CB03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7570F282224
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC719D8BB;
	Thu, 19 Sep 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="wQVp6ZQz"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB01DFF7
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756257; cv=none; b=BMWc0Br9CY+HcMV8IhHWNfoPnKEqAx3hCloml6Rh+vFzSC/hbeoj0JSa1wcCY/7S9LFMucAcfRvZ/rZnnhNQZ+aRTgSiwMdmnsvMMzQ+uWNd37t73bqDx3j213b7UDNZcl+QxnISXTi8OVHYVcnFHxxhIXCa7yC0Rk9EEZrECI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756257; c=relaxed/simple;
	bh=PyG/LcArhwLxmgbrFEBAoGa9uNhjSk18IJ6o4wpsnFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuu8Q6JRww3tnTS08Eh40J3gwV7JZ7He93NkJb2gerIUaNbzzhYN29A+TF/uOzxfYCRZvuZDVR29aMzk6CVusfuoIOLIZAiEn1nQ/v2MmFIcMW98rQvXs9M+APBmTzwX71oPvMn6vONDzjkRWKBZojGCSgeIl2X9gYi+5E8/6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=wQVp6ZQz; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D9eVR5g8ZB7Jd+uzUOp2vC0WRbdOZROeW1n8Lscu0yA=; b=wQVp6ZQz6wvZtmI6Mh410E5Ao4
	RLEYEs47iIHWohzdAdrygUI1kUFnRyfSt2EExcVITVCOLEVWFIOuW/S7byCuE52pqeZZMsIex+qhy
	GtE3jyUwbCn4dz4EDjqNn6eQDyySBACq3utg+2iVNkNN1qhiEMfoEVgjQ3Spv1WXFdI0eyYglTs5G
	wYRcoIxCBW8PVWSOomITiy0OPLOcgaBHKLQzKgMRz4RufdD6h2lwgLZdKVgL5MBlRFdihFN7Kzl/f
	N5/sIVDSn4vMdzGe7bupDBJxQX9eOpgoMBS0wOrpgllQg+n4Ot7/4FpBqhqr19x9G2FVXQlykxmbk
	7Hm+rSIA==;
Received: from ip092042140082.rev.nessus.at ([92.42.140.82] helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1srIB3-0003XD-3R; Thu, 19 Sep 2024 16:30:37 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Maxime Ripard <mripard@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	Diederik de Haas <didi.debian@cknow.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/7] rockchip: Enable 4K60Hz mode on RK3228, RK3328, RK3399 and RK356x
Date: Thu, 19 Sep 2024 16:30:24 +0200
Message-ID: <172675621369.1213843.2178006732332922667.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908145511.3331451-1-jonas@kwiboo.se>
References: <20240908145511.3331451-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 8 Sep 2024 14:54:57 +0000, Jonas Karlman wrote:
> This prepares and enable use of HDMI2.0 modes, e.g. 4K@60Hz, on RK3228,
> RK3328, RK3399 and RK356x. Support for 10-bit and/or YUV output modes is
> not part of this series.
> 
> Patch 1 add hdmiphy rate validation in mode_valid so that HDMI2.0 modes
> can be enabled on RK3228 and RK3328.
> 
> [...]

Applied, thanks!

[1/7] drm/rockchip: dw_hdmi: Filter modes based on hdmiphy_clk
      commit: 3303a206ae7474b2f8a5d17d8df9de08bac16ca5
[2/7] drm/rockchip: dw_hdmi: Adjust cklvl & txlvl for RF/EMI
      commit: 6e94e2871eb706a17692acf7ef85ecf2789f6433
[3/7] drm/rockchip: dw_hdmi: Add phy_config for 594Mhz pixel clock
      commit: b60c86d305f46483d3ed0743e9ec97a76addcabc
[4/7] drm/rockchip: dw_hdmi: Set cur_ctr to 0 always
      commit: 7d324630f3515bd6e11cadeb1d748bd74ecc9664
[5/7] drm/rockchip: dw_hdmi: Use auto-generated tables
      commit: 7595c7ef17ffe70d0f4fdda01f87f105a12de66b
[6/7] drm/rockchip: dw_hdmi: Enable 4K@60Hz mode on RK3399 and RK356x
      commit: 28f0ae48e7fdbd6cdcf3972c8d8686a529ae1ede
[7/7] drm/rockchip: Load crtc devices in preferred order
      commit: 0c4558a1bc2df9b6e6fb311de9cab192b0943426

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

