Return-Path: <linux-kernel+bounces-396168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAF29BC8DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08161C23309
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D271D1E87;
	Tue,  5 Nov 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MaLeimXl"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC3D1D1E60;
	Tue,  5 Nov 2024 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798125; cv=none; b=CFsU/8I2NmMNO7L2jNFx6QpelTjRWAzv0Ba5cUVmBtxYpbNNEfH5Ddyjf2j2TFh/J6jymQSkWBAVce93W14bCp/kql/g2RgkBuVdwsEuYNJRWTdZ+/ho8nddA/aK5YnLVd0wjDrLi5TOywwm2Sqi7wXS0YuquDFfpnqzDUcnvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798125; c=relaxed/simple;
	bh=m+bQ9tIBJCLWVx/016PgDFwUnsqZVfRQBv3m7SRIxrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTAWPHZmwpz8K7SeQFB8fJPjErbbCDRScpVI65Em5bjGxqcBhd8/euC9tj84yarmy361SZ78a62dlSypo4AvJxXT1sKBS7BZBT6uuRttFLGQsVmU8z25xSHVBsIUeRqEePg12wJUHt2pkm/t2rRPL4EhayntoAMVZzxbWYhkUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MaLeimXl; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A59FBOX054211;
	Tue, 5 Nov 2024 03:15:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730798111;
	bh=v6chZfM4wCRiFoGVQY+FPUsIU4u2NVDd3s6mX1/3RoY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MaLeimXlshnLopr7IeQQezs3HP6wkXFm3VqxU9AuqGtX+yfWWEFvOs/TM6h9ckcFT
	 Rx3qI5OS0v1OKnHsJU02JYQk0FHuXYKbW890g2ZdnVvWXYqBkULv08KqFyqXnJyWdF
	 R/GJ20zXU0zxUupVa73UOSWTtWr2EMH6PfO/cajM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A59FB1A116459;
	Tue, 5 Nov 2024 03:15:11 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Nov 2024 03:15:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Nov 2024 03:15:10 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A59Er9M091006;
	Tue, 5 Nov 2024 03:15:07 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] arm64: dts: ti: k3-am62-verdin: Add Ivy carrier board
Date: Tue, 5 Nov 2024 14:44:49 +0530
Message-ID: <173079800515.66204.8061592597799138939.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240924120044.130913-1-francesco@dolcini.it>
References: <20240924120044.130913-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Francesco Dolcini,

On Tue, 24 Sep 2024 14:00:41 +0200, Francesco Dolcini wrote:
> Add support for the Toradex Verdin AM62 Ivy carrier board. Ivy is a carrier
> board designed for industrial environments, supporting industrial
> I/O interfaces such as CAN, RS485, RS232, Gigabit Ethernet, 0-25mA analog
> inputs, relays, PCIe and more. The board also includes a TPM for security
> applications.
> 
> https://www.toradex.com/products/carrier-board/ivy-carrier-board
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] dt-bindings: arm: ti: Add verdin am62 ivy board
      commit: 9db282063b2daf5558400feb7293043b66c5263b
[2/3] arm64: dts: ti: k3-am62-verdin: add label to som adc node
      commit: 25c8a5bebd652ad26d99701c9b2e979d7a1c11b4
[3/3] arm64: dts: ti: k3-am62-verdin: Add Ivy carrier board
      commit: 881f5e9d808243d27830b3ed294e2e8abda05e62

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


