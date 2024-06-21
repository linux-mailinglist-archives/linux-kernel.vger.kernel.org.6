Return-Path: <linux-kernel+bounces-224964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3936912932
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1615F1C24ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6668F548F7;
	Fri, 21 Jun 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vVnhNJm8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C5EAC8;
	Fri, 21 Jun 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982961; cv=none; b=d9O6SPQt2rUmVvYcAKKVWZ2Tpay2RGEDYW9XNDI/UKz4hgtsGwAskA3auod+7FI1vBQ9XLW6en+EJ7h/cNRzxraqC5eDRFyZSCJ17UT0ZsE4msPCX2YUnVCM5+I3xE2tOXlcF9hslT12sITkDlCcS2VlalxTm1OulYdSev0n5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982961; c=relaxed/simple;
	bh=7v8ej1iY9M+A2N+qWcvSGZRkoHNl4Z/1daZhWJzyN5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6SgASur9veOZqf9WxDpf2dQm1li3p284BLOqtfdPizt2OX23k1PZdUa1hFtkGLEYbLAsKa/d9kIFQfN7A0HiNzd1h3i4nBKtMs0uMF5Vpq6VwNHxk/Kh+4FYRtAZWbTjnVQ7P/x+annTmBA+OZOxJ3KnXdPFvD4Oz9+VMyx180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vVnhNJm8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LFFsZd073542;
	Fri, 21 Jun 2024 10:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718982954;
	bh=RRFPu7deYk9IDG+eVZrGypiMB6D2D6xdke4ksLDULzY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vVnhNJm8X2JBk16AoQCsMN9/udqMWhCuZQWXrFJ1Fipa44ZQUyEAF+hA70lZSeJJ0
	 xNyQHepC47H6OVbWKRlcrKx6VkxCRkspovJiP0QDuxNyN73h9MLCrx4XFBM41NiQry
	 Uv8EH6OPbf4Zt5mV/2WirI3nraHBb2BtiOShNiGA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LFFsIv040130
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 10:15:54 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 10:15:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 10:15:54 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LFFno2087600;
	Fri, 21 Jun 2024 10:15:50 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rogerq@kernel.org>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <u-kumar1@ti.com>, <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v7 0/8] Add PCIe, SERDES and USB DT support for J722S
Date: Fri, 21 Jun 2024 20:45:46 +0530
Message-ID: <171898028153.2272421.7541252743648207333.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615081600.3602462-1-s-vadapalli@ti.com>
References: <20240615081600.3602462-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Siddharth Vadapalli,

On Sat, 15 Jun 2024 13:45:52 +0530, Siddharth Vadapalli wrote:
> This series adds the device-tree support for enabling PCIe and USB
> functionality on J722S-EVM.
> 
> Since AM62P and J722S SoCs share most of the peripherals, the files have
> been renamed to indicate the same. The main domain peripherals on both
> SoCs that aren't shared are present in the "soc-main.dtsi" files.
> This change has been made based on Roger's feedback at:
> https://lore.kernel.org/r/f52d9569-a399-422f-9cf0-b0bf69b64d18@kernel.org/
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/8] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to am62p-j722s-common-{}.dtsi
      commit: 3ad6579f106db8f94fb8495063cb4b0f0eaaaa9a
[2/8] arm64: dts: ti: k3-am62p-j722s: Move AM62P specific USB1 to am62p-main.dtsi
      commit: 77044cfb9346d1601bfe8759b7d785c664a73f84
[3/8] arm64: dts: ti: k3-j722s: Add main domain peripherals specific to J722S
      commit: 731626cc3180b263216805f82e006ca1f1df02c3
[4/8] arm64: dts: ti: k3-j722s: Switch to k3-am62p-j722s-common-{}.dtsi includes
      commit: 18fb2b7c8a09ca454709b806efc5c38b8a012ab4
[5/8] arm64: dts: ti: k3-serdes: Add SERDES0/SERDES1 lane-muxing macros for J722S
      commit: 6f9323f6ad818008fc58d2f804ee4140c1b8424d
[6/8] arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support
      commit: 628e0a0118e69bed9dad14e7dbd8a8802652f5f2
[7/8] arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM
      commit: 485705df5d5fc0ad6bc5b3657fa63a96a421770d
[8/8] arm64: dts: ti: k3-am62p-j722s: Move SoC-specific node properties
      commit: ed07d82f9e3e8220d8e2f92afd323d718b860f21

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


