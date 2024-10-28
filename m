Return-Path: <linux-kernel+bounces-385237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 269479B346B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576301C21E55
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8721DE3C7;
	Mon, 28 Oct 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cou1LqZ8"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9F3185B68;
	Mon, 28 Oct 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128040; cv=none; b=IjP5ru+htzNMs+I5Fw2UXp9SA9v9O1mYoheA2+l47Ey1Kav62F2fyMIW2UM9/OxEWafdMPC5dhQialMoQN43Uzj2qqgozK7cNdF2A5iQQfiuQYsmqEc8bBQOGX+4pZ7yp+TXomuWz167GjJU9DHkbrcOrl4t40Xewij+pyokxpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128040; c=relaxed/simple;
	bh=pPn0EnD95ZwHyHewnp/9KIDT/ErS9JhnCtHj8sJY27Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzflEdXKD/mujmvmd+xQzR9kHXJw+UCrRyKNbvna6RIR9hAuQfWg5euY2/PF/Bnv9qUe5OWDP94FeZCCmGwBOVUs+lsQHzzdnjn7qwvYPSyDcUR9dscmYzsHbK3cn7ylKtsHLWCQbROzVMUxzmY8ZJgZ68giO64HDseDUDNEbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Cou1LqZ8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SF7CKb091667;
	Mon, 28 Oct 2024 10:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730128032;
	bh=1mE81JjZAIyv/w8C/GnaHDiDAA5IgxibD+gHZL58LzA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Cou1LqZ8Q5ZSsRkp+HAeYyc+CzquvL1Zw9Mn8cpdRCyzd5nEE+RnLGxLYpkYci/+0
	 EI+hXz8xOzcd6bgjbqYsqQChWYJK0wPPmIu4LqbLj2KZ31lIDorWZoL16VURqjqetx
	 rWeDuWXx9HXDio1qOJY47g/qBCUfbMTewqPRW3aQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49SF7CBb040690
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 10:07:12 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 10:07:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 10:07:11 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF5tcq129665;
	Mon, 28 Oct 2024 10:07:08 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, MD Danish Anwar <danishanwar@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 0/4] Add pa-stats Support
Date: Mon, 28 Oct 2024 20:35:22 +0530
Message-ID: <173012710990.558239.9508764901403650078.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014074527.1121613-1-danishanwar@ti.com>
References: <20241014074527.1121613-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi MD Danish Anwar,

On Mon, 14 Oct 2024 13:15:23 +0530, MD Danish Anwar wrote:
> This series adds ti,pa-stats node to AM64x and AM65x dts files.
> The driver and binding patches are already merged.
> 
> MD Danish Anwar (4):
>   arm64: dts: ti: k3-am65-main: Add ti,pruss-pa-st node
>   arm64: dts: ti: k3-am654-icssg2: Add ti,pa-stats property
>   arm64: dts: ti: k3-am64-main: Add ti,pruss-pa-st node
>   arm64: dts: ti: k3-am64: Add ti,pa-stats property
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am65-main: Add ti,pruss-pa-st node
      commit: aef4959ee000069d13461166eefe0de86a0bda8c
[2/4] arm64: dts: ti: k3-am654-icssg2: Add ti,pa-stats property
      commit: 6fb909467d5ac9439eb67c3b33ed301f9ff83357
[3/4] arm64: dts: ti: k3-am64-main: Add ti,pruss-pa-st node
      commit: 007f3e72c9138d5951aac58b993db0114eddfca7
[4/4] arm64: dts: ti: k3-am64: Add ti,pa-stats property
      commit: 30a9a1a26b9568f49aee24a888767105cb0855b2

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


