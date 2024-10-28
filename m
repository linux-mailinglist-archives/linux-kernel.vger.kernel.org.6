Return-Path: <linux-kernel+bounces-385236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D7F9B3469
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F59281550
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D4A1DE2C4;
	Mon, 28 Oct 2024 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zTWgVyui"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067715E5B8;
	Mon, 28 Oct 2024 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128039; cv=none; b=YmnpVZk+Fo8uAfvhxSb9HYq/ZHhlC3QNEAo9t13wfcELOZk+U1bZFf2EpYAhZPfY43fQBVOSH5AqHfR6R5RARG5gQDH98RCIyzoVf7jmraJmi434O0JiAG8HmDBTJJS9KdXFFbrouKB2JM4PcAKujmsqCfPGcSdGVXyE1AtFWhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128039; c=relaxed/simple;
	bh=7Pa1wCGudFtitnbO3ZUFpnmam+esQDIOGUpu5zc26EA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQf5FkrXFRlpMs2LYmas54Hh2zUh3VtvjIrZ3Q/UjOiucwHyha+sE5fwN3w7O2c2mUUZMMSndsgcfbrTwiXPvZ5bGo18yf2wd3NLMNbBPRQi9+chxNXLMOXRyCHt6Mg124Ke9ID7xQHsL60yZ8bgMlsfIY5qgdR7VIwSR2eICfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zTWgVyui; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SF73H2024330;
	Mon, 28 Oct 2024 10:07:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730128023;
	bh=XXoTPcPAuC4Or5OIrxCOXJyNM4EicI650U4SepBZM7c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=zTWgVyui9g0HfxoMLjVcXI/XyGYTr1TGL32EDlT+Rmihq90/3QP0//Cf+PFPsp1Ap
	 EEcfWzbpdbUVTzhONbfMXJvGttLpKc4Wq0ymy+eqMzqkki9M39lpZ7eL1z16oFETUn
	 KMHLUNAvZo4Hqg37XpvZt7AECAk//mqoPrEhNd4k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49SF73H3051581
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 10:07:03 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 10:07:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 10:07:02 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF5tcp129665;
	Mon, 28 Oct 2024 10:06:59 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Siddharth
 Vadapalli" <s-vadapalli@ti.com>, <mranostay@ti.com>,
        Andrew Halaney
	<ahalaney@redhat.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: ti: k3-j784s4-evm: SERDES0 lane cleanup
Date: Mon, 28 Oct 2024 20:35:21 +0530
Message-ID: <173012710985.558239.2190537617884915440.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-0-03850fe33922@redhat.com>
References: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-0-03850fe33922@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew Halaney,

On Wed, 10 Jul 2024 10:36:12 -0500, Andrew Halaney wrote:
> This fixes a splat caused due to overlapping lane usage of SERDES0 by
> PCIe1 and USB0. It also cleans up the dts a hair to be more readable.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j784s4-evm: Assign only lanes 0 and 1 to PCIe1
      commit: 84f78178b6fe37b5eb8b90b5bb1239abce0b64d8
[2/2] arm64: dts: ti: k3-j784s4-evm: Consolidate serdes0 references
      commit: cc5049007d722364bca4a4eeb619d5629733a004

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


