Return-Path: <linux-kernel+bounces-534808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE49A46B65
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5EB16C9D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA66F256C92;
	Wed, 26 Feb 2025 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="HtYbCdnM"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA672561D6;
	Wed, 26 Feb 2025 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599377; cv=none; b=Saw0O4JbOEtzgnPVtHCKA1pmgmAal0dM8jqaHGl9tdU1UXiqmso4tagCwqVuJCSReC6OpQGRsuPOXTPjLVYR9iwZFYbBGCmHdCKIBkS15SWjcSRxTnYZgYi5pc1c9VsbG7YHMJMvWjgiPArjlyrE6/JZyy9A6bmOQZ5gM8yvr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599377; c=relaxed/simple;
	bh=n6yiWQQ6ilUdoTOKFWhYXpr9uk0w0EjIkCbTKC39bZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbFxQR5WBVmVFb/TUzZBphtzOddKAhvUOcJ4xy6LKLyHsfEa0xN+YGMH+leik/R3IO++yf4ojJYk68mkzZ1oer4pwqUnOY5Wp2lbxfIGUGEPpQoyz0a41gGhR2zRdpxz1lpBoDHkYuGsNL1jyMOT31WtERwqJoFiM37EhfL+vD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=HtYbCdnM; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ku5yxor34R97PptL/bWBzHcwxaDWA+nD2jWwQfiBU9k=; b=HtYbCdnMWAHo6NFA5XsdBmmcQn
	Ef+KnVrFRzpAsTGw9UzBFFmaD2Q00/+VRBjXFYuaW+hpLtCd/vBh99Q9N976u37SktbAWc6uwfRS2
	2v7SQfe3BRISiN/ARIVCmqGsWLpfM5WR49VN5jJQJJdtHZyrlnoafQhotz1eeMA6oT0DQX7DsbFrl
	0h2BC8REVdZUbikN1il1qv8kITxjOIymx18KTgFCTUql7kjDeTk0T3G2zJH/VdRFKCt6OH7UmfGCy
	bLg5pk7idc8F5BYsRFLBJWUmysbtopf0Vjk3tM1m8LhA9V0O1lYUZOmNUUVLSQ4Qdqa1hQmawVsK+
	OMWCylFg==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnNPM-0002zz-4B; Wed, 26 Feb 2025 20:49:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Support clock and reset unit of Rockchip RK3528
Date: Wed, 26 Feb 2025 20:49:15 +0100
Message-ID: <174059933845.4008853.13382525452883280453.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217061142.38480-5-ziyao@disroot.org>
References: <20250217061142.38480-5-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 17 Feb 2025 06:11:41 +0000, Yao Zi wrote:
> Similar to previous Rockchip SoCs, reset controller on RK3528 shares
> MMIO region with clock controller, combined as CRU. They're represented
> as a single node in dt.
> 
> For the reset controller, only bindings are included in this series
> because it's hard to test the reset controller without support for some
> peripherals (e.g. pinctrl). I'd like to first make dt and basic
> peripherals available, then submit the driver.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: clock: Document clock and reset unit of RK3528
      commit: e0c0a97bc308f71b0934e3637ac545ce65195df0
[2/5] clk: rockchip: Add PLL flag ROCKCHIP_PLL_FIXED_MODE
      commit: 651aabc9fb0f354ad2ba5fd06a6011e652447489
[3/5] clk: rockchip: Add clock controller driver for RK3528 SoC
      commit: 5d0eb375e6857d270f6376d161ef02a1b7183fa2
[4/5] arm64: dts: rockchip: Add clock generators for RK3528 SoC
      commit: 858cdcdd11cf9913756297d3869e4de0f01329ea
[5/5] arm64: dts: rockchip: Add UART clocks for RK3528 SoC
      commit: b9454434d0349223418f74fbfa7b902104da9bc5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

