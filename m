Return-Path: <linux-kernel+bounces-212897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CBD9067EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B612B23DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA03713D88D;
	Thu, 13 Jun 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pprg/9s8"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8839FCE;
	Thu, 13 Jun 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269165; cv=none; b=ArbEZV0S/fDODLeEOjeI2M+WgEJ3rW30NTCjxdczRM7Q1JPmR573oBsAJHcdsWn+Ejh7NFysOwuLvmB5wHsKCwwadcHUPMCl9LPy/+0XBUnpTsDyvILGTpkqo1+D73E4DdcIkb3uq3EGXI9RhKxlaKtOvoiowbLoTNH2XrFfwGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269165; c=relaxed/simple;
	bh=UMAGO/DnnoTgFBvlhMsi45hfygM/PqnyTx3jSdBVsRU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCj9RXNeNKlHdyo7uXtZN6BUujCgFlHUYLuMBVzABurF3sbbYrAPd0fze7OzHng3Er2H8z8D29rXwdvkDVSP+4nGfdNMh+nYqWNW68756iabBPjj2+kdA4fFBMUnmk6YJdTST5z84vPIElbzaCO9vvjpXf2pkwSZnun0/rhr+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pprg/9s8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8xG46016924;
	Thu, 13 Jun 2024 03:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718269157;
	bh=w/R80ZWo1k91cDIfpMyOqD2qZkg/5IChQj9Gili/TA4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pprg/9s8PU7Fv5LQ71JyouVy76+qQE235vsLhZ/eC2/OHJtBoFfGCTE2Ddh5T5LtK
	 SwwedUOq9B9hu/GTLm5RocVRWDhmLodD5eMgf4tghrhmB32wP9TDnkXyKJFkiIEcKk
	 4Vmo7W2H7AnwLtugEwbk2woL5sVA6XUjzqjbhsCk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8xGjb080457
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:59:16 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:59:16 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:59:16 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8xCHJ101379;
	Thu, 13 Jun 2024 03:59:13 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, MD Danish Anwar <danishanwar@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v2 0/3] Add PRU system events for virtio and MII mode support
Date: Thu, 13 Jun 2024 14:29:09 +0530
Message-ID: <171826022275.240984.10533854041193926530.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240529064420.571615-1-danishanwar@ti.com>
References: <20240529064420.571615-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi MD Danish Anwar,

On Wed, 29 May 2024 12:14:17 +0530, MD Danish Anwar wrote:
> and MII mode support for ICSSG on AM64x.
> 
> These patches were previously posted as individual patches, clubbed them
> into one series. No functional changes from previous revisions of all
> patches. Rebased all patches on latest linux-next tagged next-20240529.
> 
> Patch [1/3]
> v1 https://lore.kernel.org/all/20240423100608.1421652-1-danishanwar@ti.com/
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am64-main: Add PRU system events for virtio
      commit: 53a3960410c2e703fda2f98706668570eff5ecd4
[2/3] arm64: dts: ti: k3-am65-main: Add PRU system events for virtio
      commit: 8ec9ce361d55d995c4619346e0b9c56b9ba6e5d2
[3/3] arm64: dts: ti: k3-am642-evm-icssg1-dualemac: add overlay for mii mode
      commit: 4d0101e8c69b3324f30bb596d56b5242ffbc6972

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


