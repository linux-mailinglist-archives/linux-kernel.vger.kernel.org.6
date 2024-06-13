Return-Path: <linux-kernel+bounces-212628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC7B90640E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44427284687
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4124C136E3F;
	Thu, 13 Jun 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WrtBFQHe"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F8132126
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260207; cv=none; b=aVKoQFlW/wlNdQQjwkkHdx/rQgf+dsdttl4TxiZwG8Qk/ky8bq9ITcU4cwh1pvEJH/5/6BRj5WLWMY7817tyh2uaiFCf8cFD7xOfBzkI9l5WzpulVk7ciNxQu73KBPYCZSvgL9cElhq3hTEHSaazvxaRSd8/DIv65TSX2627YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260207; c=relaxed/simple;
	bh=1ITf/IV+XppxHNGuHtacHUabz57Z4Wi5tu39fEnPP/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WToajPm/4e1gJCv/sgwZS2SagenF17tYGZfnH9brGDfbrPsNVRZskgE/AulZ6FBJraZAq8ainzcgT30mJngSwGO3ukB0jS3/E5RwQxNqPcq/BKqzphL1Kc8ZwiDF4LnDuM11PYslO6PETmFpALG8zlKuevkR8SbMK4EZN/XzeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WrtBFQHe; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D6TVvB060085;
	Thu, 13 Jun 2024 01:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718260171;
	bh=ePxVqcPlasZvJxLJiNsFZJ3UpFZrVewDI7flKTjFPp0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WrtBFQHeObjdboJ14vlISCC+fvFacefCJMZwAIH2aanbK6sccfbbPc5/FfN89S3Vd
	 FkRLE+QGmuQh2D469OMM56vz/pBvHnDsSG18iGamkjEMaJkXOcP9JwqJJ+7g7qot96
	 XleUQsjLJce9RSzEVpCyh/7ZsryTM68+yTPvm6xE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D6TV8P017688
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 01:29:31 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 01:29:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 01:29:31 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D6TPoh129167;
	Thu, 13 Jun 2024 01:29:26 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <quic_bjorande@quicinc.com>,
        <geert+renesas@glider.be>, <krzysztof.kozlowski@linaro.org>,
        <konrad.dybcio@linaro.org>, <shawnguo@kernel.org>,
        <neil.armstrong@linaro.org>, <arnd@arndb.de>,
        <m.szyprowski@samsung.com>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, Nathan Morrisson
	<nmorrisson@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <w.egorov@phytec.de>, <upstream@lists.phytec.de>
Subject: Re: [PATCH v2] arm64: defconfig: Enable TI LP873X PMIC
Date: Thu, 13 Jun 2024 11:59:03 +0530
Message-ID: <171826009034.225208.17115144830449712453.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606234145.3311068-1-nmorrisson@phytec.com>
References: <20240606234145.3311068-1-nmorrisson@phytec.com>
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

On Thu, 06 Jun 2024 16:41:45 -0700, Nathan Morrisson wrote:
> Enable the TI LP873X PMIC configs for the PHYTEC am642-phyboard-electra
> board.
> 
> 

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[1/1] arm64: defconfig: Enable TI LP873X PMIC
      commit: e05bc474310336e1ab03ed79112909dd0f74d039

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


