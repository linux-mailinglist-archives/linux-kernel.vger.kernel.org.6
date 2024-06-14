Return-Path: <linux-kernel+bounces-214356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F02908339
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4416E1F233F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118E1482FD;
	Fri, 14 Jun 2024 05:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qo1GS5QL"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AEE146D6D;
	Fri, 14 Jun 2024 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342101; cv=none; b=dMyIHUwJw1lpZsn+7ew+RGhF0KRonwzxnT8W+e/1JCxHVU+VTafz1H0lI/zWEIWpRPmbVflgZ/5Ircyg0nEkzojHBuQOX1Ggx34VivFqrWzXoxiGSQ4zcFhy73hnFbzG00l5hGcyv4zNOxZ0FMVv9+tcTm/mZu4eQPLDly0Fo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342101; c=relaxed/simple;
	bh=XUJaffq5gWlrQrUCm8mpwlS/x1y63KiRJJbkpM2PUk4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5W/b0nvfVdpJ4X2/q0+baiW6TsbI7wKuIbzv0ttqZi3zgy0zK2SCeiEt4Tn20GVa3CxFnUiyq6Xyj03DHDemb3SI75VX9zPJyFHSFVeI7/r1IsHZ/1wIa21uyR32HfcC1uLjJ941rq7rfw6CITUtNZPIHYC1tQ1+71tbLxi+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qo1GS5QL; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E5EelT016520;
	Fri, 14 Jun 2024 00:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718342080;
	bh=pLZ+J0Uv5wri3Ffm5wOW0FEKQXP4puGs29LO2x/ZLmo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qo1GS5QLlkdt1yh48bAnACPZRm8CyDMRSI+CqMgMn/tdmmlTvF60DKGbTrBtKpcVw
	 pgbLq95536VNl0FNrXZij5pWrIN43rl90bSxDEofWyiSFeKVDxrM578G38ECW2Jeqz
	 +/M6DbYf1n/ywQQdp0iC/no3KIzDPFsJxodLMBZ0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E5Ee2M129782
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 00:14:40 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 00:14:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 00:14:40 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E5EZ5N085824;
	Fri, 14 Jun 2024 00:14:36 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <francesco@dolcini.it>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <sabiya.d@ti.com>, <u-kumar1@ti.com>, <danishanwar@ti.com>,
        <srk@ti.com>
Subject: Re: [PATCH v4 0/4] Add PCIe DT support for TI's J784S4-EVM and AM69-SK
Date: Fri, 14 Jun 2024 10:44:33 +0530
Message-ID: <171826022277.240984.16790260886500529482.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240529082259.1619695-1-s-vadapalli@ti.com>
References: <20240529082259.1619695-1-s-vadapalli@ti.com>
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

On Wed, 29 May 2024 13:52:55 +0530, Siddharth Vadapalli wrote:
> TI's J784S4 SoC has two x4 Lane and two x2 Lane Gen3 PCIe Controllers.
> This series adds the device-tree nodes for all 4 PCIe instances in the
> SoC file (k3-j784s4-main.dtsi). The J784S4-EVM board has only PCIe0 and
> PCIe1 instances of PCIe brought out while the AM69-SK board has PCIe0,
> PCIe1 and PCIe3 instances of PCIe brought out. The device-tree overlay
> to enable PCIe0 and PCIe1 in Endpoint mode of operation on J784S4-EVM is
> also included in this series.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
      commit: 8e05ce691af29db0c7f0d468c8d7c6e13273a9e6
[2/4] arm64: dts: ti: k3-j784s4-evm: Enable PCIe0 and PCIe1 in RC Mode
      commit: 27ce26fe52d4dcb5bf58cdf5527e2f3a498c1fdf
[3/4] arm64: dts: ti: k3-j784s4-evm: Add overlay for PCIe0 and PCIe1 EP Mode
      commit: 7c4270de2806f80c06dc80c2cf2c8d6eb7c44c59
[4/4] arm64: dts: ti: k3-am69-sk: Add PCIe support
      commit: 2f79e7408ac1b22ce8abc4a22b92793a57a3077d

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


