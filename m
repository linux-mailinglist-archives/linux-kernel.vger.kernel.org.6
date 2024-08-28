Return-Path: <linux-kernel+bounces-305560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED73696307B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A576C1F21C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110801AAE04;
	Wed, 28 Aug 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dlPlM6Oh"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688C154C19;
	Wed, 28 Aug 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871219; cv=none; b=QL9OkQ1Cg+XLzHcnlhjFYXH3zx1jwB9PgrKrV1Sf2/tf9keKzcX3Uf4lZXKRjxyUpNKbMyBUaEvSk87I7RPyoVPcFlui5bQFx1StBCbaajEjphEc50ImX6SgxiXW4U5dUN6H/7Umr1+BAIRdwyy7aHuvx9zoYAZCSnr98lRJXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871219; c=relaxed/simple;
	bh=H1XuPPB8v900dqjawnDHbkZVV/UCHi52+icAflQG6Vk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m52aYetdp5K68XTxwDUgSRhdRhz6H6Gdvp/1vUWoKbpifXsWxc1fxdPN8t4GbUOn28bz4Qrx2V1OEQJ5eTIjlgM0694xuWThixDamnNq+/ehIV97qmUF/9cioOqXZkPNWkdBROPbIWdITwWEX1cjnang1VUA6eC07xKi3CnKiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dlPlM6Oh; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SIrUpZ051715;
	Wed, 28 Aug 2024 13:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724871210;
	bh=z9uAqw/+IP1IRKtdfwhh5ngrNSdW4CojfSTM8EbSRWE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dlPlM6Oh61oicmZ5Cd63S9nj+GG6ezcUIJ5DEmIZagA2+DA1tcI6TEHev7/2yOx/b
	 g7L0tb3w/f+8SFHV7pJ2qhlffxe1rK36EBvMmkvBKboUlWB4VHIkic5afAMqa+q/8Y
	 pdbSQqFG4HQsQeTFDq11NxtJttKPqdjOMkR03Qkk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SIrUFh011132
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 13:53:30 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 13:53:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 13:53:30 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SIrUBG046548;
	Wed, 28 Aug 2024 13:53:30 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Beleswar Padhi <b-padhi@ti.com>
CC: Nishanth Menon <nm@ti.com>, <u-kumar1@ti.com>, <s-anna@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/7] Switch MAIN R5F clusters to Split-mode for TI K3 Platforms
Date: Wed, 28 Aug 2024 13:43:24 -0500
Message-ID: <172487055957.3438526.15757529252683657587.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826093024.1183540-1-b-padhi@ti.com>
References: <20240826093024.1183540-1-b-padhi@ti.com>
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

On Mon, 26 Aug 2024 15:00:17 +0530, Beleswar Padhi wrote:
> TI's K3 Platforms (J7200-EVM, J721E-EVM, J721E-SK, J721S2-EVM, AM68-SK,
> J784S4-EVM, AM69-SK) have multiple R5F clusters in the MAIN domain. All
> of these clusters are configured for LockStep mode at the moment. Switch
> all of these R5F clusters to Split mode by default to maximize the
> number of R5F cores.
> 
> v3: Changelog:
> * Nishanth
> 1) Refactored changes to board level DTS files instead of SoC level dtsi files.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/7] arm64: dts: ti: k3-j7200-som-p0: Switch MAIN R5F cluster to Split-mode
      commit: 936fa8b91abac356b8c8afd70959dba8420ddc18
[2/7] arm64: dts: ti: k3-j721e-som-p0: Switch MAIN R5F clusters to Split-mode
      commit: 956d1f88a7df31cd7264b07d9ff7fe886aa96ae5
[3/7] arm64: dts: ti: k3-j721e-sk: Switch MAIN R5F clusters to Split-mode
      commit: 17613194f8f765c5559c2a1aab56b76ffbc4a2ee
[4/7] arm64: dts: ti: k3-j721s2-som-p0: Switch MAIN R5F clusters to Split-mode
      commit: ab630a7f429195a02185faec448603d2ae4b12d5
[5/7] arm64: dts: ti: k3-am68-sk-som: Switch MAIN R5F clusters to Split-mode
      commit: e1f2bf759c533fb86380ded089a16fba24222832
[6/7] arm64: dts: ti: k3-j784s4-evm: Switch MAIN R5F clusters to Split-mode
      commit: 10ef034f94ef7916c89f40e3b3844bcd066a7a58
[7/7] arm64: dts: ti: k3-am69-sk: Switch MAIN R5F clusters to Split-mode
      commit: 34d0e51ad34b0b1f8d6020020bf7e4e8e4f5cbe1

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


