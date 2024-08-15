Return-Path: <linux-kernel+bounces-287817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A750952CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2AC1C211DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2325A1A4F22;
	Thu, 15 Aug 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="T9wp4ksg"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28041A256C;
	Thu, 15 Aug 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718470; cv=none; b=j3LjBbSlpU9h9ncE6G0fs/mbcdWGQqcLvikJJjaI4qZiKYdEWCbOXLGzpYXToYAMw0w7iS0aSnvo7Obeu2b4MbPJW5oqHAu6j2jmNykRIJxHNVahrIlBjHfZ2BmJ3MpUpmk9loWZ8eCWg65evagV+Bx6J6q7bARME238RRgQBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718470; c=relaxed/simple;
	bh=9vL15Wc/OuOKW0BohAgcdwIWrpUTWG4fyCBKZ6hDm8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2qXnm79GLUVbxPDlNgz+5055VYIOUminW27PoNYfss07C8ZiJ7GzzaKAhInVsHn9C0X5MoM7o16my68miOcgWV4fcEufcJGmgsNVlBVB/x/LPlOIkZUNairppYssjKkw4zdQjO91WMnt+Bgf3Yt9ILZDU+RjWEXEB8RtgkEbSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=T9wp4ksg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GgTI0NyTQzsStScrcGO6aMDCmPA8tFa+LOqjkXlw7B4=; b=T9wp4ksgpK8kyWUBawTO2KYM1Y
	Py9VnW/j4d3UV7Sc5w3+L/RKZMIk7NBvlQm4xkBvOPQ2VsHUszJRQwTgD6G2x/0+2kWrP7GFXYoEQ
	cie44dv3b3mE8nKJfvGfDH8ASdZqD6rFpcHuIsH+E45wNfJXq69vfxZBLZoc9PtY9Zg1r864hruXx
	65l5Wr11sIb3oQAqF0SBsfEqegb2fP2FNeH740fWj90A9pcsnDK5VbmJsVddW0Yjw+HQJkbB2BrNW
	lsQrY+gqNJuS7bsXvco5YCd4sqJ5AEI6++dB0J48I/JqaGxpA5JrW+UtUXCux1kKV9err0jUt17Mt
	iNCLug3Q==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seXuG-0000nZ-Lf; Thu, 15 Aug 2024 12:40:36 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Maxime Ripard <mripard@kernel.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Mark Yao <markyao0591@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Robert Foss <rfoss@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Alexandre ARNOUD <aarnoud@me.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Algea Cao <algea.cao@rock-chips.com>,
	Luis de Arquer <ldearquer@gmail.com>,
	linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH v3 0/5] Add initial support for the Rockchip RK3588 HDMI TX Controller
Date: Thu, 15 Aug 2024 12:40:30 +0200
Message-Id: <172371788339.684432.3349154890008070129.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240807-b4-rk3588-bridge-upstream-v3-0-60d6bab0dc7c@collabora.com>
References: <20240807-b4-rk3588-bridge-upstream-v3-0-60d6bab0dc7c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 07 Aug 2024 14:07:22 +0300, Cristian Ciocaltea wrote:
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

Applied, thanks!

[4/5] drm/rockchip: Explicitly include bits header
      commit: ab03974df27e471ff03402265292f1bafafb5df6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

