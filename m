Return-Path: <linux-kernel+bounces-300183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F7895DFEA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337D51F21B67
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057CA811EB;
	Sat, 24 Aug 2024 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K+oZfTBu"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB8961FFC;
	Sat, 24 Aug 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529254; cv=none; b=bScMOIzrf8x54sm2Gh9dkTnWhbvQR84YENQQerUp9mBI5aJbMM4ASsweHnFePvKSdhaWjwi4GQf4b8GNG5ziv8ndB2l6FnESVqQxi6E6KNbpvo5U2yEW5+mhlQ7l8U2yvoUZhfTgOAJB+Ihz+EoqcBrNfUVdzGTZLZsiN6tifkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529254; c=relaxed/simple;
	bh=OQLlfrM8p6QrMwQwTWCnv4/gAhDgtO9U18PQKK8V+Ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjLovNlHzCl+AuSy+S0l/D1nKaZOIKGm+5BGMvS7jQRNnJ40fHxjqV/kPFU/QRgpYVBGM+yOK4R7b6bTR0Rd2PPtIFs8t5gypPoNz61dhUktxIFFKGxnsCiIhQQSrhpE2euX2j5ii2hf2EhN3R3VvnquvsTu4EwPwbmJNFFTIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K+oZfTBu; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OJs5rI123938;
	Sat, 24 Aug 2024 14:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724529245;
	bh=N+HINpgwrTrHC/YNNg+IA9p3NFv9RmAMfFWwAFeK4KU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=K+oZfTBuEo3LfSCLYz96e3JCeEDYxyDf1E/GEJfxsoNgYFHdWxCi0byrlHukKndpx
	 8Y0+0clc5vkO6vUVLXu3rja54HCi4Eu/uDM7jxBkNRdAsLJbY/KxK1MYb8H9I/V8qC
	 S4IXpJjaO2e+1NzGs+0Sds24Sg28MhmjCMdbLyBg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OJs5cR033322
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 14:54:05 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 14:54:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 14:54:04 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OJs4tf000734;
	Sat, 24 Aug 2024 14:54:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Judith Mendez <jm@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka
	<jan.kiszka@siemens.com>,
        Bhavya Kapoor <b-kapoor@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am654-idk: Add Support for MCAN
Date: Sat, 24 Aug 2024 14:54:02 -0500
Message-ID: <172452923383.505729.8023635627832942886.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821205414.1706661-1-jm@ti.com>
References: <20240821205414.1706661-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Judith Mendez,

On Wed, 21 Aug 2024 15:54:14 -0500, Judith Mendez wrote:
> There are two MCAN instances present on the am65x SoC [0].
> Since there are two CAN transceivers on the IDK application
> board for AM654 EVM [1], enable m_can0 and m_can1, add the
> two corresponding CAN transceiver nodes, and set a maximum
> data rate of 5 Mbps.
> 
> [0] https://www.ti.com/lit/ds/symlink/am6548.pdf
> [1] https://www.ti.com/lit/zip/sprr382
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am654-idk: Add Support for MCAN
      commit: f0f961ab9c9652c2f07bd7120a5b2b462ad6fd92

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


