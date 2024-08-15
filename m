Return-Path: <linux-kernel+bounces-287812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ABF952CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499561C214A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1347DA95;
	Thu, 15 Aug 2024 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BNvAh2yJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF331AC8A5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718459; cv=none; b=TBcPnCspMn+3SJ24836Cg+HCIgOMgIydvvd7px7jwlvd/1+Ze8BYpLw0+B5rfB82b9qY0wpleMrmWuyhJ31irwutI5aFRlXhazdkr2WiUYGfH7NQ+E086+JFxGVdBVM+5OwFEmnj3+cnJwRIn70kygLK31l3FiZo0RwMZq1WbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718459; c=relaxed/simple;
	bh=qpG2Vyc8OwAGI26elCfEUSOblOm2FXo9cCuzUql+82M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5PpP2glO7rO2v5edhdkThvT5+qf2Dtkjh0qrmU1KvcdU2lDMsOorMV8W6FylHOq+xXYU1L8h9QCdMYnX5e2dPwDBbA/ujcGrNCido+9KQDWgj6Bsfg0O7wbeuVAffyzCYxRdY3sxgqeb5hUIjkocTsKGyoaZtbiHEkVghbCqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BNvAh2yJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZfYK7CYAUIxMbRcTcFjunsEAy/oAQUNbSaQ1fM7YYXY=; b=BNvAh2yJ2Ar5mFtoajYWdpn1vE
	cTvt45WFpfMt3Wa+9OH92u9nf4ZISyRgfbZP9dt+FPVs/jzsNwEj0JcLPl9qCvDz8kPZxeXath+7G
	p4iJnf6IkFLovBjYppTzUFIpzEOiog0k3kvM9Y3ArNz6IFUgn5NhZtmdq+S5IxFScLAKQhfnCyu+a
	XxSpdzFxjQwNSESHQK6jcW4E0U0Q5AAZHgGIFQ4MvnyOar9GoS6AVdvMgDREozm99I9xhUXzkU84W
	LdXkSR12fvCZ4wcjVLg2XRgyH7vm7SqXDD+0fn7+NkqmC4aNuqjyCT6NRfhZxJJHdr4iyz39CyG3T
	Tioa8Igw==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seXuF-0000nZ-IW; Thu, 15 Aug 2024 12:40:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Daniel Vetter <daniel@ffwll.ch>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Sandy Huang <hjc@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/4] Rockchip DW HDMI driver cleanup/improvements
Date: Thu, 15 Aug 2024 12:40:29 +0200
Message-Id: <172371788340.684432.15742063069748528028.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813-dw-hdmi-rockchip-cleanup-v1-0-b3e73b5f4fd6@collabora.com>
References: <20240813-dw-hdmi-rockchip-cleanup-v1-0-b3e73b5f4fd6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Aug 2024 00:15:07 +0300, Cristian Ciocaltea wrote:
> This series provides a few patches to cleanup/improve the Rockchip DW
> HDMI platform driver.
> 
> Note the patches were initially sent as part of [1], in an attempt to
> add support for the RK3588 HDMI TX Controller, but were removed in the
> next revision as the patchset followed a different development path,
> i.e. not relying on the existing driver anymore.
> 
> [...]

Applied, thanks!

[1/4] drm/rockchip: dw_hdmi: Use modern drm_device based logging
      commit: 1b8f576c69588ddee9e093d322449bb069e51f6c
[2/4] drm/rockchip: dw_hdmi: Simplify clock handling
      commit: d2a80cb57a017c97d40c35f6b0cc7d103065f0cd
[3/4] drm/rockchip: dw_hdmi: Use devm_regulator_get_enable()
      commit: 6a3283603c73e366c946195f0cfd30fe56d603be
[4/4] drm/rockchip: dw_hdmi: Drop superfluous assignments of mpll_cfg, cur_ctr and phy_config
      commit: ee689a9500efb4daeab45f44d43c782fc214dada

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

