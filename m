Return-Path: <linux-kernel+bounces-305565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A572963087
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC791B213F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1951AB513;
	Wed, 28 Aug 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sFjfGOGD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E4328DB;
	Wed, 28 Aug 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871534; cv=none; b=VEQg6dcCTrsMiUJYPeRPob7S8ha2c5nzKDQ7u1M5cVbD3YHk4m6YTg0Gl7Jxr91o2jEub0ERNELw+ktwnvA2muSfCOUdPtO3irp0/+LKIsBH44b34XpuXO91ZJa7BK9VDXEUQEE9lG8lw8ePI/JbhtjIIKrWVVid2yUlq7GrJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871534; c=relaxed/simple;
	bh=zoB+5dltGl4SeMjFiwf4Bz8rfttU134J1Ael6y0wd+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYuFXo/Q0ELd0HZe92680CkB7kHwRcLKGVdXXh0ADEatklVvH6uMpT0MrbiYx0ze3qs/fgvZFiFHPqAt9Pg3fmGF17qbLy/G64Bn804R8hJQNF+he0+qRJUfEo5YlFesW7PO/umR/nZ/pjMp/dcktu9N7zZOED7ZeVqAnzGGl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sFjfGOGD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SIwhGT100627;
	Wed, 28 Aug 2024 13:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724871523;
	bh=oKu6Epfr3/VrPNrtu3gQBk1GOWEbuQRg5gkYsXVsHds=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sFjfGOGDuJw1AhGY/hzJ/R5ymg8T11L2RU10Ilz+eiHo4j4e8xJLuIeThOONMm+OI
	 OBDup36KHzy3YK9pzhxTYLR1UedHqGcNLiystvgUkHQkRuYeZeepDPR/0BNhz2NUiC
	 bIMAsiAIbGg0WL8U58Ig4LmULLqGMS/ZjcbHTdAM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SIwhwp061887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 13:58:43 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 13:58:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 13:58:42 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SIwgtv051528;
	Wed, 28 Aug 2024 13:58:42 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Beleswar Padhi <b-padhi@ti.com>
CC: Nishanth Menon <nm@ti.com>, <u-kumar1@ti.com>, <tony@atomide.com>,
        <bb@ti.com>, <d-gole@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/7] Reserve Timer Nodes to avoid clash with Remoteproc firmware
Date: Wed, 28 Aug 2024 13:58:39 -0500
Message-ID: <172487140504.3441749.10326233588807171364.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826104821.1516344-1-b-padhi@ti.com>
References: <20240826104821.1516344-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Beleswar Padhi,

On Mon, 26 Aug 2024 16:18:13 +0530, Beleswar Padhi wrote:
> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
> use timers. At the same time, if Linux probes the timers, some
> instability is observed while booting remote cores. Therefore, change
> the status of the timer nodes to "reserved" to avoid any clash.
> 
> NOTE: This series has been rebased on top of a sibling series[0] as both of them
> introduce changes in the same files. Thus, please apply [0] before applying this
> series.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/7] arm64: dts: ti: k3-j7200-som-p0: Change timer nodes status to reserved
      commit: f7d6dacb233e1fe7e99e766abddd2a0247957d80
[2/7] arm64: dts: ti: k3-j721e-som-p0: Change timer nodes status to reserved
      commit: 96b2d17bfe407faae341053e1f376c7429c03c22
[3/7] arm64: dts: ti: k3-j721e-sk: Change timer nodes status to reserved
      commit: a8d1241bd6e57add2807c3127f987f8929bb45a1
[4/7] arm64: dts: ti: k3-j721s2-som-p0: Change timer nodes status to reserved
      commit: 1cf3a036f91a2e5a6187f7cea8f9bfab1d9b504f
[5/7] arm64: dts: ti: k3-am68-sk-som: Change timer nodes status to reserved
      commit: ce25e4c7dff5c9a392ad5a5c38c4fc7031305cd2
[6/7] arm64: dts: ti: k3-j784s4-evm: Change timer nodes status to reserved
      commit: d8087ca36a29fa81cc80dd0a9b347b2877cc9b3d
[7/7] arm64: dts: ti: k3-am69-sk: Change timer nodes status to reserved
      commit: bdebd509e43e508386488ba7a35cf714dffa0088

I dropped the fixes tag while applying: the behavior you are
considering here is firmware specific. While I understand it is
important for the board, the reported "fixes" tag has nothing to do
with the board, it is a SoC timer introduction which is not where the
bug is.

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


