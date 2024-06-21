Return-Path: <linux-kernel+bounces-224960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E7912923
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC761C23FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCDC55C0A;
	Fri, 21 Jun 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QrELT3mR"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8206374D1;
	Fri, 21 Jun 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982820; cv=none; b=DWO/aZqbcsOaZ9AxYx0w591vg3sOOXGpC1uPLwd5h8W8bCcIJCuhxkxs6ztjbFLDgtQaWg/SFIZLBUg2ReYaGmR3lNrtWRqfWn3ZsZOvi5MufMMprpSyoW/wm3MpnEKTr5PdZ5rkCvMdNSWDuIciV38uJH/U1b2omEPTqCKhMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982820; c=relaxed/simple;
	bh=BwE65gpWHWUOxU+0kh60zJUAZ9C+cBGgCLuKAwey8Mc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVfA7MPS2bb3lZhw/Z29Oiv1jJLYpkz8RIuVUyA7f8j9JnvkCO/L4+0Wv1kO4TF6gtv3IhVifsRMyJ5P6CEDsOOLmw0u4wPa/94S6IDXT7tQqMrxZtG0wMV8v9A4FqV0RwAx5nxj+kLpwyaXOYEG+WdjDDtMHZpDiafXsA9ce1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QrELT3mR; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LFDUwp035755;
	Fri, 21 Jun 2024 10:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718982810;
	bh=DNoQeDSASX9Lsn+pxPBzW+W6fYrlucLJ4moKWR2+lwA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QrELT3mR9emZBLS5YWGspleEZnF+qq8Jv7ZIEnkbavbmtvLRuorPq5GzqBJp+/Yxb
	 u64oEja7+DZkjnXSaua8BeBjHdguj69lljjO9lImYJJtWtF1FE3YdC3n2eAljhSiAJ
	 +vBGR8a8VfDesryZqr7NGHgiFvy4kGiisZqAIJZI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LFDUYN038813
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 10:13:30 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 10:13:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 10:13:29 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LFDPe7083431;
	Fri, 21 Jun 2024 10:13:26 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, MD Danish Anwar <danishanwar@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm: Enable "SYNC_OUT0" output
Date: Fri, 21 Jun 2024 20:43:19 +0530
Message-ID: <171898028156.2272421.2927874175187560582.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614100829.3919008-1-danishanwar@ti.com>
References: <20240614100829.3919008-1-danishanwar@ti.com>
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

On Fri, 14 Jun 2024 15:38:29 +0530, MD Danish Anwar wrote:
> The IEP0 SYNC_OUT0 pins are used for PPS out on AM64 EVM.
> Configure its PINMUX here.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-evm: Enable "SYNC_OUT0" output
      commit: 5fb89782a9e94936c14f2621637ef9df7c4ac0f0

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


