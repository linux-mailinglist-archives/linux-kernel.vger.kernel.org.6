Return-Path: <linux-kernel+bounces-428495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E0F9E0F4E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB4228290E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5571DF736;
	Mon,  2 Dec 2024 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cIL9VA43"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C211DE3B2;
	Mon,  2 Dec 2024 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733182178; cv=none; b=M+9DlHCtx84Thzt5cnBjlTgoxKWGQhPHJBOXSbJwj6OF8SqLedsgric3RLIVGdZ/6fz2Y9BaTjHLfF46izuW01uCO6M7SsZFMIay3Gy/IxccwTR5/Xb57gQjc0afaRxj2uLaeiJSSL1yaaacJyLHyh05MbfHyrL+Kp6L0yzBJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733182178; c=relaxed/simple;
	bh=PFoRlAAODyKmegIF/6ngBCKDWr8zfpfWsU/bzYHuGQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCDp698riPGPrL8XTc3EI8mPWfg2fgDfo6B5D0ezK4aMnw8mj1J2/lTj9QIv/ijDrB7p2ztJ0MWiXUPEyIMPRDS90PkncHlEcxmfZsUb3B3kH0lEfZYpRha9MpAImo+1h1t7nh/CHEymWbu5yq0PFg8SVvsQwOfU0GzkipIeVDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cIL9VA43; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BChGZI6+CUoQhFa8aZUCtl71jkoFFpifvlCc4sRJtqI=; b=cIL9VA43cBBzteiJD+6dunHlot
	AP+1d54xkDHCIuxb5h+4MWzBikXAyUa3Zjs6TZZQgYAxXfp4Ys3O3uM/NY/bw84Kbryn0aqumR/RG
	Oqly4Ej7sdSGV/pNkT63XPIJRo48ky4LqOuhgbVh62ybVG2Q5Fu47RAPhUSQyKeF4MExfM0ogMLsN
	ZHVNHHnpJhv8Hh9dmym8JzPEc/BNMOHvBcBxKOpm1vArBVpxSoxOV5goeUSwYDbb+laia/t1+JTKb
	AELbqtaYXuNXF5qiuHpZJalEo8ijGkEGH1/C0DHgqCmzsAiauyznmbGSKwXdKgvVr5IrnkSRFUobW
	yCEOlWRg==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tIFr7-0000OB-UQ; Tue, 03 Dec 2024 00:29:30 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rk3308-rock-s0: Fix sdmmc access on v1.1 boards
Date: Tue,  3 Dec 2024 00:29:17 +0100
Message-ID: <173318214614.1403925.10666094873905910081.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119230838.4137130-1-jonas@kwiboo.se>
References: <20241119230838.4137130-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Nov 2024 23:08:36 +0000, Jonas Karlman wrote:
> BootROM leave GPIO4_D6 configured as SDMMC_PWREN function and DW MCI
> driver set PRWEN high on MMC_POWER_UP and low on MMC_POWER_OFF.
> Similarly U-Boot also set PRWEN high before accessing mmc.
> 
> However, HW revision prior to v1.2 must pull GPIO4_D6 low to access
> sdmmc. For HW revision v1.2 the state of GPIO4_D6 has no impact.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3308-rock-s0: Fix sdmmc access on v1.1 boards
      commit: b89a4235eb8cdf1b4bd2f9e4ed096d8adf8994e7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

