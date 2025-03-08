Return-Path: <linux-kernel+bounces-552656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F086A57C5F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6AD16BBC5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803601EB5DA;
	Sat,  8 Mar 2025 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="f4D5EpkM"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C71D934D;
	Sat,  8 Mar 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741455140; cv=none; b=et8nhwSQ/9p1JQmVPKiF21ZR3rb1Ud0ukzV+Gm17dWLW4kWBkboRH3crq5dIfLE93mDHRTpqVL+gZBu5i05BMoNk0URh24Nzs6sXhey7VrOE1I3XBuBcFD3pxZHZoSmtknL2cOZBsY5qwZPXpwuxgcNKZGu0sxhJkRBsMJB3wGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741455140; c=relaxed/simple;
	bh=g3aQIPUZnNnpTzLmnZxUelfGBtC6cBAFASBlsdAZOks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtaQXxrC/+F22JhaJ3igSFaK8jasa93WzXSmci/iX9s9zTTIudmveb1RQIV/m0xld8fbdV05YL6ITYBcLGO6UNjCa8NTj34D7Uzt0I2v+HFvMEujFbP9GDoeDkv/NM/BlY0y4WP5o+9M+Lq2BIG93H5v7rqJG8Vveab2zPruMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=f4D5EpkM; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8+6NAxcBm9mQhrCma2ihh2Vk+YbjWow6/geDHrsWJQY=; b=f4D5EpkMvO+Ut1Y3iM2P2I8FYa
	Dnd3iAhMmY65gRRvHT0/1MU5y9CHOxGzM/slj62CuSC2sE7wg6RkTVL4hn5D6y3p/vKr5iPDQQrz6
	iEPjv6+4WqB2oNGiRKs9SgOEqQA1M0gCD8oQ4SDzg3GbYziiO6rHyC55G94IpgmPee85PYviCyBO7
	Mrw4RBvNInZPJymlQMxpHmC9yh/14osJ6g5Rs1N8eVTSmoHVchzEjcwHUtUlI/tcJ+lIww8R4+GNs
	GbCIHcbubMEA9Gw+G4GCPTfi/lQYD6ODS64tdaEFL18eORPmucBdJr+LPboPwqxGzNSbg/ORtqRG8
	gQ2GZmAg==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqy1y-0004Tx-N9; Sat, 08 Mar 2025 18:32:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
Date: Sat,  8 Mar 2025 18:32:01 +0100
Message-ID: <174145503573.101861.9257226762854268898.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307100008.789129-1-amadeus@jmu.edu.cn>
References: <20250307100008.789129-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 07 Mar 2025 18:00:07 +0800, Chukun Pan wrote:
> Same as RK3568, RK3528 uses SCMI clk instead of standard ARMCLK.
> Add SCMI clk for CPU, GPU and RNG will also use it.
> 
> dmesg:
> [    0.061333] scmi_core: SCMI protocol bus registered
> [    0.125780] scmi_protocol scmi_dev.1: Enabled polling mode TX channel - prot_id:16
> [    0.126628] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
> [    0.127233] arm-scmi firmware:scmi: SCMI Protocol v2.0 'rockchip:' Firmware version 0x0
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
      commit: fbcbc1fb93e14729bd87ab386b7f62694dcc8b51

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

