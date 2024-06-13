Return-Path: <linux-kernel+bounces-212895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683B09067E8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3641F26519
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F6813D529;
	Thu, 13 Jun 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LHDIpdlc"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26739FCE;
	Thu, 13 Jun 2024 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269109; cv=none; b=dXCgZrN/0rVaSNwPlj0pHh9XCECRz55xvPJE1JUiGtW1FWNIDhXCvy/YbvDylxJz/2ndRIhzos6fukVrHD6PON7YGArNJ6aKBRXrEqhKz4X09Y82ORzJ636ubADekAciS09/KyF6FphPWtqLmd0/hzj4OUzvz/P/y6f+D2/UVN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269109; c=relaxed/simple;
	bh=0hOjvSSMVIgZBS90qozyICkk5mFdk3cSGEv8KWsjlUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnmT2rR6OR7rYNjQU77u8vZ1Ps1/S7nSNbPG+wnZDz3ricUQxPdbk36Hkfheyf7M/QP0Z762LEa40eyi19jz5Pt+HXI2TTP2tGs5GXA5cKMF4/t0X/+sVvpWgeAP/eBI2kHywtEUSjUN3OuFgkLUIJPvFbNHTYUchQqg37IV5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LHDIpdlc; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8wHtk027248;
	Thu, 13 Jun 2024 03:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718269097;
	bh=f0LpFIGuIa1RyClhUEfR0yiLa3jkhy3DhCep5RUow+c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LHDIpdlcZ6mC9sMigN4VDErqT/XNsCI19XveZ4TDZiuDsY+6TmcGxqkMz302XwlgU
	 +PdVWvnCyvgLv2K2G4RICGVU/689hqoPGB2uLn5mNdiaetKwwWBTW0xPSkMCkwdzBC
	 Du2QpBH36mW0Bn7U8sKTdktdgksZG//gCVa0bPcg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8wH6I105291
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:58:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:58:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:58:17 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8wDaF109892;
	Thu, 13 Jun 2024 03:58:14 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Nathan Morrisson <nmorrisson@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: am62-phyboard-lyra: Add overlay to increase cpu frequency to 1.4 GHz
Date: Thu, 13 Jun 2024 14:28:10 +0530
Message-ID: <171826022276.240984.4393145001355238158.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240425221925.1781226-1-nmorrisson@phytec.com>
References: <20240425221925.1781226-1-nmorrisson@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nathan Morrisson,

On Thu, 25 Apr 2024 15:19:25 -0700, Nathan Morrisson wrote:
> The am625 is capable of running at 1.4 GHz when VDD_CORE is increased
> from 0.75V to 0.85V. Increasing the voltage while the AM625 is
> running has not been validated by TI, so we provide an overlay so that
> people may choose to run at 1.4 GHz if they need the additional
> performance.
> 
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: am62-phyboard-lyra: Add overlay to increase cpu frequency to 1.4 GHz
      commit: 7a5775a3da906dab059b8de60a2b88f6016cb4b8

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


