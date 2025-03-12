Return-Path: <linux-kernel+bounces-558070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6FA5E14C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB7E166576
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15082571A3;
	Wed, 12 Mar 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO4wMvjL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B528256C7F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795107; cv=none; b=MA6h0HZ7Rhi+wUlgS01j2J2CFm0gwCGZkgJ7Wx5ip/niSA1sq3JYBvY54U5uOypAeashQxQSxLvCqWbUO7aXb+DdrEbmxHsVsclVDu2+zNkgZ1nOh3VvNePtodDKHmzAG5VK2owWThyXZK5u36yo/4LEJCxhv9mRVudAMVOHny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795107; c=relaxed/simple;
	bh=mGzsdd4n+9rU4Flpsz/PjxM975tzpYkjRrs7VBzcZe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CVkUpgsOYBn4wwBef+Enb/J0BqOnaMALX3Uef9dsxR2i7MXtxxDC7oUCXFKYHo8bsoxbmE6AJRkAnvA3Iusd3tVgO9SmJRGhOHAriIhRg7lnQESPVkCCsycrZVCf+ak4Vs97puDijI8JM+hzlrynVzDOyRFPOR0JiOTqFAKgbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO4wMvjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC9DC4CEEA;
	Wed, 12 Mar 2025 15:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741795107;
	bh=mGzsdd4n+9rU4Flpsz/PjxM975tzpYkjRrs7VBzcZe4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iO4wMvjL0n81mulDSPGIErIKgPIp6w59ocSwCvEGoq/9FpMk0oxmTMQWXeh3Iwl5T
	 TnsVPLWlyKWINjm9up9Zwzy6n2LvScMvheCrUCm9zekxE5geGWZO+hrbULpausCcGE
	 oxFWbPD/wxbpMyvD5UXUReu7+8Coo0pe0mmNa/7lDriH3Voc0p5jNdGjhf5Nrb0I/+
	 FuuQTk2J4fsrMdfV8FwMFcmP9+5LkeD1NoZmw/BdvGr5YNr8fa0DnO6hhiyjJWhQ2a
	 kWCOwvA1l0Debo898AkxMush2eRf2rX9k7iAgM+09cCiYjGb1wrTl380TCNyWqQ6TL
	 Gc/TvUEkdmVpw==
From: Vinod Koul <vkoul@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com, 
 sebastian.reichel@collabora.com, yubing.zhang@rock-chips.com, 
 Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20250302115257.188774-1-andyshrk@163.com>
References: <20250302115257.188774-1-andyshrk@163.com>
Subject: Re: [PATCH] phy: rockchip: usbdp: Avoid call hpd_event_trigger in
 dp_phy_init
Message-Id: <174179510386.536552.5606148469623251433.b4-ty@kernel.org>
Date: Wed, 12 Mar 2025 16:58:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 02 Mar 2025 19:52:25 +0800, Andy Yan wrote:
> Function rk_udphy_dp_hpd_event_trigger will set vogrf let it
> trigger HPD interrupt to DP by Type-C. This configuration is only
> required when the DP work in Alternate Mode, and called by
> typec_mux_set. In standard DP mode, such settings will prevent
> the DP from receiving HPD interrupts.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: rockchip: usbdp: Avoid call hpd_event_trigger in dp_phy_init
      commit: 28dc672a1a877c77b000c896abd8f15afcdc1b0c

Best regards,
-- 
~Vinod



