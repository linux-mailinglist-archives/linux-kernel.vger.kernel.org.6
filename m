Return-Path: <linux-kernel+bounces-288344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DD4953905
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86F81F2201D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D0058AD0;
	Thu, 15 Aug 2024 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Pvls6HWN"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B64778C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743107; cv=none; b=iwCO0rVDO3vT6lkmVk8c8sHLAqRBqhW5pcXe4nD7F1wpitmlz15JGKtxKKW1YAgZBo7qQ8QcHT6Mgln5HKTQcqFlrO6gLv1pxdvWZ5Csbxl+HU3j3ewtlq7NERe4YGwd2A1u3Vpwvpo3x/G4+PKjtepc4WOKCqw4pgF+wiDq5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743107; c=relaxed/simple;
	bh=U5fIQeQLfIT0ATjZNW21f7EO1KgU4U9we658Kegz5wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XP8GpsLwsc6AZx174Qvl/rbBnJ76wb+ys2QQ9VHkfDBl7g7xTdzTebaSbw9MZGLE+d6TTjmWA7EZh6FzJsgE+coyqgIY/ZDfI5cR0owx7WXNjoFn8vXm8lzJLj0bjOysPv+pHr9ubLNjeJ2niYT2Kl6z8zHpIOn0g5rUlhzf3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Pvls6HWN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sIqbPZiRjTrgtxDOdljm9mWZF6jTEwBez60mkfjEyt8=; b=Pvls6HWN8l5GaiaDcc4IV0GFI0
	Pus+1D2WrPk64VPX8x33SMmVLSB3wXemWYDEjQ1e/Qa9ntKX17Y+yCYRlG6svngd78oKxCXbwG0Rh
	WG7bS7uAYSEsv66cguoIuGyGLzfI8htBJvzRdSr0aUNImX0ZcoeM0ZYRsm2PUQmYrkvk/JhGyP9rc
	LsOFL6aSrmSYu7gzD0EL40sxCCVcdjJYP1ToLsPCEad1KnRR0trriP2lUiCF3FtNBv/1e6UrCYdWl
	qw/GSaQwOCyFMBAmsC72zyzymTBh+X3C3g0VOra/TAOt4aZJMdnalJ7+HBacznfCoA/TiprlZmrq3
	OaK6ScQg==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seeK3-0006A2-RC; Thu, 15 Aug 2024 19:31:39 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: dri-devel@lists.freedesktop.org,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 00/13] rockchip: Enable 4K@60Hz mode on RK3228, RK3328, RK3399 and RK356x
Date: Thu, 15 Aug 2024 19:31:38 +0200
Message-Id: <172374306461.802599.8555618948226226004.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240615170417.3134517-1-jonas@kwiboo.se>
References: <20240615170417.3134517-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 15 Jun 2024 17:03:51 +0000, Jonas Karlman wrote:
> This prepares and enable use of HDMI2.0 modes, e.g. 4K@60Hz, on RK3228,
> RK3328, RK3399 and RK356x.
> 
> Patch 1-3 fixes some issues to help support use of high-resolution modes.
> 
> Patch 4 fixes reading of EDID on RK3328 when using a forced mode.
> 
> [...]

Applied, thanks!

[03/13] drm/rockchip: vop: Allow 4096px width scaling
        commit: 0ef968d91a20b5da581839f093f98f7a03a804f7
[04/13] drm/rockchip: dw_hdmi: Fix reading EDID when using a forced mode
        commit: a5d024541ec466f428e6c514577d511a40779c7b
[05/13] drm/rockchip: dw_hdmi: Allow High TMDS Bit Rates
        commit: 1213b65e436d64611cf74ef8f005b22f6793275f
[06/13] drm/rockchip: dw_hdmi: Add max_tmds_clock validation
        commit: 5f5f657a9c3efe16a2e1455b840c5009f9c75af5
    Fixed the double rk3228 in the commit message.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

