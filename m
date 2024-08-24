Return-Path: <linux-kernel+bounces-300177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F2895DFDE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89493B218EF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2B7DA8A;
	Sat, 24 Aug 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ykd4nN9m"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0337C57323;
	Sat, 24 Aug 2024 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529052; cv=none; b=rKMjVla1/85cQXHjaGzqmwjQu4KHVc2144IOUMEX22ZVbH5rtAY2mS8eJz4tMr0uKIikRXotWA3S9C4PLYfKyPDamRIcM1Bq/lDUtmi9lt5WBn3/FVQbfAbPNlHyYkdZo2X/ZCHg/5RfVZlUb7tIHP7Q6Y0ltkkyNnVBg7W+dOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529052; c=relaxed/simple;
	bh=oS7X5Df06uMJH/17sD8XTZRm/LG+bl2OYVTOgMjrYH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqQ4RRXHpsK/6R4NrzjnkP7NhBaVwwlyBV5NoTR18cMwkIi2Oxku/os3bzoUCVDwGT5qoVIPWRLYuaO/ctyswFq+lmM80YWZnpd60EbSUOUL1eFLEAfuIYw18FILeaFDUWLVUZLe9KQ8yRo+pJHeEsIvZjtc05L6YBZOborjuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ykd4nN9m; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OJocXe026856;
	Sat, 24 Aug 2024 14:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724529038;
	bh=UuKNRoxREauNkzvoYYLLJIyspWJIG5kqXU0LNKzrkKo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ykd4nN9mTCxSt5XKg1ZbuoM5o9s8Xtg7NSjhb6llnjOr/H+ahQV7e+Ux7wUsVP8vx
	 4pSpn7s8MU/wHrthkECRZZAeB21cGcEvbO1DOCDfAAcVyZdxp3GpvrUHPVqyxszpLx
	 26B5HyhEV84nTuhQVOKY6AblXI52zeEZ3x732Q9U=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OJoclQ102039
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 14:50:38 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 14:50:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 14:50:38 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OJocqJ128983;
	Sat, 24 Aug 2024 14:50:38 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@ew.tq-group.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am642-tqma64xxl-mbax4xxl: add PRU Ethernet support
Date: Sat, 24 Aug 2024 14:50:36 -0500
Message-ID: <172452902456.505244.11666015185034453215.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807121922.3180213-1-matthias.schiffer@ew.tq-group.com>
References: <20240807121922.3180213-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Matthias Schiffer,

On Wed, 07 Aug 2024 14:19:21 +0200, Matthias Schiffer wrote:
> Add PRU Ethernet controller and PHY nodes, as it was previously done for
> the AM64x EVM Device Trees.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-tqma64xxl-mbax4xxl: add PRU Ethernet support
      commit: 7439fec041c22262ee18b3cccef42c69e0a05362

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


