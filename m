Return-Path: <linux-kernel+bounces-212629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E92906410
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEF11C214BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C420F136E39;
	Thu, 13 Jun 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hU2o6stO"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712713440F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260215; cv=none; b=SR8GlMKloKLKyiIJCe+zKAIiDzptn/dXB5zFiv6hHzAelQ/pAHB7uzEoFap0HPlStXInnX9Rh3z7sRtam27TJCoFN0sybSeGIoIllqGvy04ZR4+gYi+2lzC5S7qx3naQcxeU7DTEmgwmQjN5HAAouFHRq7Grj3m2tE3x8+WwQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260215; c=relaxed/simple;
	bh=Rt9FmsrR6p/DkThfc/9GUVDhdHucLaaLWbor9rDeSuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiHsxDeq2htK3p0+P12+QgXDEt2SGOMd7lwiX9QLC5Q3FqL6t4jCQoiQWkKtRZW4eyqkAx/ByC+/yDlPPPpo46YNzwNAPQo0JFPJj4OS5vsw8omJDDMjbmT2tAzxWF4HxHxMovUFQ8vYdA80OD0DCcpAjP18vJsoXAMknYeMmtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hU2o6stO; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D6TpSX114132;
	Thu, 13 Jun 2024 01:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718260191;
	bh=d/tOUKZ8wfwXRT/iUoaNiINnpqWIMwUXk5ll5Lof1Io=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hU2o6stOjcdK4jDzR4uQ+UTbrMdK7by2zCoUbL164WCoqRjUXRz+ufCSuh15VCV8u
	 g2bAD+NI6FmD6QAm/v2PG5wsVIMKJKG3+/KFR4km521ZzGDh2QoiYrWgjkU2gkZQCp
	 OShVevjMYv5Obqt3Nyay+QOjB4W79Os0N6Xxa/Cs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D6TpZ0122281
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 01:29:51 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 01:29:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 01:29:51 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D6Tkn7129502;
	Thu, 13 Jun 2024 01:29:46 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <quic_bjorande@quicinc.com>,
        <geert+renesas@glider.be>, <krzysztof.kozlowski@linaro.org>,
        <konrad.dybcio@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <neil.armstrong@linaro.org>, <arnd@arndb.de>,
        <m.szyprowski@samsung.com>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <srk@ti.com>
Subject: Re: [PATCH] arm64: defconfig: Enable USB2 PHY Driver
Date: Thu, 13 Jun 2024 11:59:40 +0530
Message-ID: <171826009031.225208.1151814959113350287.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607061056.708946-1-s-vadapalli@ti.com>
References: <20240607061056.708946-1-s-vadapalli@ti.com>
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

On Fri, 07 Jun 2024 11:40:56 +0530, Siddharth Vadapalli wrote:
> The USB controller on TI SoCs such as AM65x needs the
> USB2 PHY driver to communicate with VBUS/ID comparator.
> So enable the OMAP USB2 PHY driver.
> 
> 

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[1/1] arm64: defconfig: Enable USB2 PHY Driver
      commit: 8a703a728a745a229cfd2b6ccb2ec68a83bd5d0b

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


