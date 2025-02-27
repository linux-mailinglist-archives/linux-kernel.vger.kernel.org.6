Return-Path: <linux-kernel+bounces-536426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9FDA47F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7032B188EAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0523027C;
	Thu, 27 Feb 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="HPp+4I/X"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDFD22FF4D;
	Thu, 27 Feb 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663514; cv=none; b=W40KYn1OX24PHgxuk/hYFUrCg6Mq76rFGKsH6aCkVYrfajkHb1tUMspem8Tg+xRJmk9uVsVOo5jJgSMjkEVo9yxmqrc3dRTvOP0PMJ2yh18hnJFNrQeZwy170hn6mhLApKOKdDKEaG4e9MPixGT3bqYBvnPkyM7MnxsxSdF7uQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663514; c=relaxed/simple;
	bh=BcR1yzRKIHg8CHQkoMsYQWWMhQnohC+WEJXIwJDIdqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tg8BYNon8Mv99eavOHnLLh5UnQDzl8KEs8aNynRjYqbGnOfG0KuguyAgwnYL/KHIzLiO3Vy0OLo66CZNeoqxiYUMo3mRTjECNZgdp+MQ7Xe9tEtP4nF5Hpy2n4YY7z72og68b99XsCyYjBVbavU504QXguxkjB1ITIj1NzCDHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=HPp+4I/X; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xM2HHa44z/uki5r/XsN4Skql5oqMCUJnloS/h7yO+wo=; b=HPp+4I/XmV10tmTEqe+vSHO4Tp
	ovIKFdNQLJxv6we0V7bj5VN1W3sLawocwFpQhBUoGba7W0m3Aaz2mjbnXehXJQ9u5U6V+1amJkm0A
	KDSwDp0eQmqSLsfyrLxm1iCQ4G7WS2DeqywTzVqL7XCAwejqNAUMh6SR7VMdC47iy3VgYJ9Vl73Oh
	mg2mHkcSjSXWO3NeH19wmEHAXbuLou6V0BbsSD8gtEF4a9MswAK+doGnoICisvZNuyXmdZxEz4qWi
	TOBfoRWjCU0CDgFOZONWo2sksyJDo1bGDK+r7GQEvJUi90hiyqH6zXZkHPh5vQvZxK/bSVylCpVPm
	DvUniP9Q==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tne5X-00018T-Ix; Thu, 27 Feb 2025 14:38:07 +0100
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
	kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/5] Improve Rockchip VOP2 display modes handling on RK3588 HDMI1
Date: Thu, 27 Feb 2025 14:37:51 +0100
Message-ID: <174066344868.4164500.9088227108064466339.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250223-vop2-hdmi1-disp-modes-v2-0-f4cec5e06fbe@collabora.com>
References: <20250223-vop2-hdmi1-disp-modes-v2-0-f4cec5e06fbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 23 Feb 2025 11:31:36 +0200, Cristian Ciocaltea wrote:
> As a followup to getting basic HDMI1 output support [1] merged upstream,
> make use of the HDMI1 PHY PLL to provide better VOP2 display modes
> handling for the second HDMI output port on RK3588 SoC, similarly to
> what has been achieved recently for HDMI0 [2].
> 
> Please note Heiko's fix [3] in of_clk_get_hw_from_clkspec() is also
> required for boards that do not provide HDMI0 output, that is to ensure
> devm_clk_get_optional() returns NULL instead of ERR_PTR(-EPROBE_DEFER),
> which otherwise would put rockchip-drm module in a permanent deferred
> probe mode.
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: rockchip: Enable HDMI1 PHY clk provider on RK3588
      commit: aadaa27956e3430217d9e6b8af5880e39b05b961
[4/5] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source to VOP2 on RK3588
      commit: b2e668a60ed866ba960acb5310d1fb6bf81d154f
[5/5] arm64: dts: rockchip: Enable HDMI1 on rk3588-evb1
      commit: 5c2d6181ae830e02856c603b8c08e80e9d419874

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

