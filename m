Return-Path: <linux-kernel+bounces-224983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E955991298D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956FC1F21061
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E398874402;
	Fri, 21 Jun 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WD4SxHiX"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2376A8DB;
	Fri, 21 Jun 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983475; cv=none; b=kqLBqsYL48z5fEK1uoyHHcX36j3O8JnTO6ygoIVl3w0VRmFn32w40jDIxPup+QSpm3QNCqXSs03U/UvvvcSU2nZqsrt+Mi5+Dfg5mzdUR/zDt1Qrycr9QFxDVi1O4WoYRHqIcjSdLgCECf8dF8ZbwvRBZpv8GesmRsuncQ29kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983475; c=relaxed/simple;
	bh=U51SDnYsZRXnIYo2p2aA1LhjSSf4gGMdG0FfGYc8Ah4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqr1soJSorDVd+vBybrRMhr0eWKpPAP5ct5/OfIFIXdCL7uD61qNm5a8iEgFHXJnqGPCIJe0/EIuHojTcl3lTgsm9NXAdBwWsc57FzHWBs6WevsSerZs+bvw6svK3bW9L2zD/LzC0zdQiX3gCWaMMxO+FbfXrbgmGKGeHfXxzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WD4SxHiX; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LFOQtw074753;
	Fri, 21 Jun 2024 10:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718983466;
	bh=Ff948z0YgaSDHsMFPYc5u1zXDh24wb1SYl9YbH4PUnY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WD4SxHiXC2ixcFjxWCMWqKFRJI7BJxO3muBOrAPjNSBBTrWdnkkBFRQg3/SKrO/+S
	 DfzRlqvB0346HKFXAX8f+c8+1xz+Wu/+uVPHRurSMF5rc/wQVxTajJxRODDDLjv8v3
	 euUGIGpoBdD9P8nd0F76boaXRuuYv4XbHPn6xXBY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LFOQPp009874
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 10:24:26 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 10:24:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 10:24:25 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LFOLJt076763;
	Fri, 21 Jun 2024 10:24:22 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Devarsh Thakkar
	<devarsht@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <praneeth@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <d-gole@ti.com>, <bb@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all for I2C1 instance pinmux
Date: Fri, 21 Jun 2024 20:54:14 +0530
Message-ID: <171898028156.2272421.18249578267583148135.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614123532.203983-1-devarsht@ti.com>
References: <20240614123532.203983-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Devarsh Thakkar,

On Fri, 14 Jun 2024 18:05:32 +0530, Devarsh Thakkar wrote:
> I2C1 controller controls io-expander which provides power to voltage
> regulator vdd_mmc1 for MMC SD using a gpio line.
> 
> Add bootph-all to the pinmux node for this instance, as this is used during
> SPL stage too by the bootloader while using SD boot mode as without this
> the SD boot mode fails with below error when using this device-tree in
> u-boot:
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all for I2C1 instance pinmux
      commit: 175133a32b48a092363828ce3041a0adaab01ffc

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


