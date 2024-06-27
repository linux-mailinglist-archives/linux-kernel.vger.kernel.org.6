Return-Path: <linux-kernel+bounces-232899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9497491AFA6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD2C284463
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9656719F470;
	Thu, 27 Jun 2024 19:27:49 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625D19D07B;
	Thu, 27 Jun 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516469; cv=none; b=CEdU5Fgl+kXwEGs4gtexOP77eYXjDQHwECEVRiXb2hwVW1MnKMkjVEsJIfPFKPYwaEwUJvW7/tOzfTrqLMhN7VuLeI7KcoAnITnQZiSaHfCWpcgzTm+Cdd65X2yEaE7R4EgEdN7Lzww1F8JTAy1kEzAPnpWZR1fVZe4yMR1YcZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516469; c=relaxed/simple;
	bh=v/KpyaavinuxAkCGEPei9KO4qGaKS4tLF18S/Uu0KcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8ikShbbKvObYWOmvxFbjOEqLn3A6MTpSKUze6YWP28K9OQ+yXd5rxMk7fdEIWexglmrjj/x0yW8HKdqD6i3jD5aLkdDpmeCClueHnB6T7O6CTMkGDVHO1je9PTeSseKGMphQNmnyIjVGLAFvEUxreihZ5FdEoiwThnd/57MLa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sMumK-0000wK-L0; Thu, 27 Jun 2024 21:27:32 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Furkan Kardame <f.kardame@manjaro.org>,
	Zhang Qing <zhangqing@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Lee Jones <lee@kernel.org>,
	Chris Zhong <zyw@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Riesch <michael.riesch@wolfvision.net>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v2 0/5] DT fixes for Rockchip RK809 audio codec support
Date: Thu, 27 Jun 2024 21:27:26 +0200
Message-Id: <171951643514.1057727.17430383742626789629.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
References: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 22 Jun 2024 00:57:17 +0300, Cristian Ciocaltea wrote:
> Rockchip RK809 MFD provides a RK817 compatible audio codec, supported by
> the rk817_codec driver.
> 
> This patch series fixes a few issues identified by dtbs_check for the
> boards making use of the codec: rk3566-quartz64-b, k3566-roc-pc,
> rk3568-evb1-v10, rk3568-lubancat-2, rk3568-odroid-m1, rk3568-rock-3a.
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: rockchip: Drop invalid mic-in-differential on rk3568-rock-3a
      commit: c5e56e620410696922cc01d4ab473fa03c627ca7
[4/5] arm64: dts: rockchip: Fix mic-in-differential usage on rk3566-roc-pc
      commit: 26067ce0934480d772b76cb674055ef66411bc09
[5/5] arm64: dts: rockchip: Fix mic-in-differential usage on rk3568-evb1-v10
      commit: 592d17ded2d569b60bd35d91889a79c70e5c6c5f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

