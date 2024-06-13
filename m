Return-Path: <linux-kernel+bounces-212876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE43906771
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA159B259FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0AF13F449;
	Thu, 13 Jun 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b7bAbsYD"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1FC13DDDC;
	Thu, 13 Jun 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268502; cv=none; b=b3F8qJHaD0pxmJ+M4jMy+ARenodTcXhV1KplXEpD7MTkY2tRSaq8d4TzHJDsdenfJsyDwqHznInEe6JtOlKp28OS4V381TP2aU81pIOksB6mFcDS4MSy/hwf2PDH5lbY90LWBaNSAZ08GqA7WiaM03zPflC8kUvX+V+1BJflMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268502; c=relaxed/simple;
	bh=FAmGzD3t6TRqM7xMa1IQOFMD+3VCjtakuHap2yhphMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myiOydOtPvz0JxeJkdL1Ezf7dgxSjh+6sTJNvAN78pZLcW+cXftde7FzhHtE0o+8KdWppOQYjnMBpWualaxBAWeAvM0MchgV8EBaD/syGxa3VlMFf5XYkC8sed1t4BjsRYGN4MnWnqVGDhHtLZQ55HsiyQQ8W+f28VFyjgYmoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b7bAbsYD; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8mExF025371;
	Thu, 13 Jun 2024 03:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718268494;
	bh=rijIbF+MLCfoGpALyFiglb4qu5p2oJO5G70j6C7Trn0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=b7bAbsYDxIfH/nSsgHqeXW98WywAI66VbIPWDr3NSZ9QCVQGUOuJdFkF90EjsWidh
	 Kj7/ZlVdHuJp9GILbVOiC7mDJBoEB0fTHwBixhWA40S1j1E5Nci6p8wqtLyD5cQZDw
	 LzumlB775UhBMykD0biSB86itRntyqNuPl22GlnE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8mEjG100486
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:48:14 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:48:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:48:14 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8mA45087048;
	Thu, 13 Jun 2024 03:48:10 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
        <r-gunasekaran@ti.com>, <srk@ti.com>,
        Chintan Vankar
	<c-vankar@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 0/5] Add CPSW2G and CPSW9G nodes for J784S4
Date: Thu, 13 Jun 2024 14:18:07 +0530
Message-ID: <171826022268.240984.16809992484526751856.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240502091002.3659435-1-c-vankar@ti.com>
References: <20240502091002.3659435-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Chintan Vankar,

On Thu, 02 May 2024 14:39:57 +0530, Chintan Vankar wrote:
> This series adds device-tree nodes for CPSW2G and CPSW9G instance
> of the CPSW Ethernet Switch on TI's J784S4 SoC. Additionally,
> two device-tree overlays are also added:
> 1. QSGMII mode with the CPSW9G instance via the ENET EXPANSION 1
>    connector.
> 2. USXGMII mode with MAC Ports 1 and 2 of the CPSW9G instance via
>    ENET EXPANSION 1 and 2 connectors, configured in fixed-link
>    mode of operation at 5Gbps link speed.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-j784s4-evm: Add alias for MCU CPSW2G
      commit: 674a20618b0de1afb62622b5051a5371117a1bfd
[2/5] arm64: dts: ti: k3-j784s4-main: Add CPSW2G and CPSW9G nodes
      commit: 01bd39357b70ed41fb52b26c7e5b42de328fcdd4
[3/5] arm64: dts: ti: k3-j784s4-evm: Enable Main CPSW2G node and add aliases for it
      commit: c2834656bb6d434bf0df0de7710210fbfe7ff927
[4/5] arm64: dts: ti: k3-j784s4: Add overlay to enable QSGMII mode with CPSW9G
      commit: 4ad0beeb7ae69ae11ec53c897d0b1af1df60454c
[5/5] arm64: dts: ti: k3-j784s4: Add overlay for dual port USXGMII mode
      commit: 838ceca36b2188899a0100461799f179c53de550

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


