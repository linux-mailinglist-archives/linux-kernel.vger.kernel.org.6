Return-Path: <linux-kernel+bounces-536048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9C6A47AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2440A188E00B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717522ACCA;
	Thu, 27 Feb 2025 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="mZCQsiU8"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B022A7FE;
	Thu, 27 Feb 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653769; cv=none; b=UJth7OzQN/7jZg49z665gKTzH6Hi5hSwKS2tovYnZzDeGuM9+Ancrb4MZDvz/COCL5chiSbpTm4gBcc6fvnEW/DAF8ufXXsPJE5Dp21tpt6StYZB4obYCQztQwwtMNLm2n/R676BjcRLXn8UTkgE95Jm2RuUNZOVcvoWSbY97xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653769; c=relaxed/simple;
	bh=MmrWQ7riJIz1EuHc2/QUcDBCKQYC92k/Y6lvzylxvRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSoqkAuRPYw/NuFeX2TV7R/PgDExqARAnaKfZdkW7oJsTPFip6VfNd/JchwPXiGuoFWx1ovnsqalAu4q+6c8E42wdc3h89v40Srj9HuxiXrPyN8GpU2cKq9erHYm3NL5lxMTZCF1sIV0zVebH5eH136GDWiwI5OjU1t62Ref2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=mZCQsiU8; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gCe2jlYqgmYdsKTqxHV+zNuMNWku2qaKvILRO2g7d1k=; b=mZCQsiU8HZvV7jkLzjo+lal+WH
	LsfjYGypihPdUloXEmpXdNrHBkHWx9rYAq4f8TF1eTVSj7VY4Q1KjO+X+Z2EkHhmgZcP0UaPQt9N1
	v5++30LaFz2OlWbladXzqwhkDsgVmWTNnxK92HabyCIKYJ5eTwwTkeIS/eKmcojIPANyirlFBkJBH
	vc/uGbfRUMyKCSd5BYWHDzqP2ybgkSq6aZvdB+mYX1aw9DSVbpIkWLvLDiDQlCJsF+Z/kjmkQ+iiW
	DyLqTeK0saCCFZJJnm+i2I5BzFRl+yHjRK8cFs76X8UuqWOIjTY9PXmb9aQVKZODZspjqIaBmJvmm
	0d+221uQ==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnbY8-00008f-2X; Thu, 27 Feb 2025 11:55:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	boris.brezillon@collabora.com,
	l.stach@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v7 00/15] Add eDP support for RK3588
Date: Thu, 27 Feb 2025 11:55:15 +0100
Message-ID: <174065370895.4124124.17821350735219515790.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224081325.96724-1-damon.ding@rock-chips.com>
References: <20250224081325.96724-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 24 Feb 2025 16:13:10 +0800, Damon Ding wrote:
> Picked from:
> https://patchwork.kernel.org/project/linux-rockchip/list/?series=927765
> 
> These patchs have been tested with a 1536x2048p60 eDP panel on
> RK3588S EVB1 board, and HDMI 1080P/4K display also has been verified
> on RK3588 EVB1 board. Furthermore, the eDP display has been rechecked
> on RK3399 sapphire excavator board.
> 
> [...]

Applied, thanks!

[01/15] drm/rockchip: analogix_dp: Use formalized struct definition for grf field
        commit: 2bf9f610494d75cfaf3c8a0cef93135ce83f7254
[02/15] drm/rockchip: analogix_dp: Expand device data to support multiple edp display
        commit: 718b3bb9c0ab87bc90914799e6999bf4b1ecc67b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

