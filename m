Return-Path: <linux-kernel+bounces-441166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331E29ECA87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EB71888A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D84239BAD;
	Wed, 11 Dec 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GPXVlF94"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A985239BA0;
	Wed, 11 Dec 2024 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913857; cv=none; b=Yl9l8B24egftSnpY3fkkDvYCqMg+efu+Jj9BFOlryts3VGwKjc6orD5isvqsUvoft5SIVYrsx8fnNa222RcDg9K5mofDtWP3/rEysviJ97XzqD1IE1/sBjvzhRgKMNbG94QNo2+AxTHnguN0biNmOnYVvG4VgvWrlcEfeGWeU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913857; c=relaxed/simple;
	bh=u3hWEDf3jNATqhRTwv5ZXzI4pW2CBusFMxBkF3C/zMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxDtAMIuOTparj8RQ1jd5jcFTKWBERpodLZ1+7eJvRVIbUPrc6wfxMlWPmrXJZu9XwcuUevB4wYcnNWStZrq8DrKPM69XpHL7KsLfMIMRBdkt4BE7SIaTmvkHHbqHJfSvHM4y591pRq2KNSGNjiv+rjpZ/q4RfAY7xLS/b5uf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GPXVlF94; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EV0DzN/aRpIaOzSPvYfCHGoC2ttPbO09aHLQyIdly64=; b=GPXVlF94a82JRfXo0MuftR38+o
	EPuKL7i9Bbdnlhjixyj/tPflX+n7eqReFh5PEE3ff4jbMdHlhRqNRovWS13UH3kY/aqf80tj5sCv4
	FkUaHkdorBrYAWxiVC2uLb1m50H/TloWhkQffIkRc0kAoAD4E4vv1tz5xBU6e5fCnlRZ4UM3SFM67
	wVJ9yp5ioiYBDStUdfNR41mtofEe27i+4qfV7uyEP5tR3JgWNl/VKTAa7nLLxR4xanoMIkvqibB0J
	wI4uYmjgn/93sKeen5ecCOF/05jNdGISz0yYyTrljgIlO/k14nMlVGlgerWbUTAZLAOvjvVqnfg90
	on7vqbcw==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tLKC8-0001Vg-Hx; Wed, 11 Dec 2024 11:43:52 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Alexandre ARNOUD <aarnoud@me.com>,
	kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/4] Add support for HDMI1 output on RK3588 SoC
Date: Wed, 11 Dec 2024 11:43:42 +0100
Message-ID: <173391381115.2426313.13144345816370660962.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
References: <20241211-rk3588-hdmi1-v2-0-02cdca22ff68@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 11 Dec 2024 01:06:13 +0200, Cristian Ciocaltea wrote:
> The patches provide the basic support to handle the second HDMI output
> port found on Rockchip RK3588 SoC.
> 
> For now I enabled it on Radxa ROCK 5B only, the board I've been using to
> validate this.
> 
> ** IMPORTANT **
> 
> [...]

Applied, thanks!

[1/4] drm/rockchip: dw_hdmi_qp: Add support for RK3588 HDMI1 output
      commit: 0f818db20c77506ddd870761785740f8230a4207

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

