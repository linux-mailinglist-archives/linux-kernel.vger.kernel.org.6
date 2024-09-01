Return-Path: <linux-kernel+bounces-310384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93046967C12
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE35A1C20FAB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8A278C6C;
	Sun,  1 Sep 2024 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cg6s0aFA"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14720DF4;
	Sun,  1 Sep 2024 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725222225; cv=none; b=psfxqWhCn5y3PVhDQaoLuHNn1vjRtPZ6JAXmWI+PpiqrXMnYum8X6RjY/3qWt6gAmDd7n+/opHQfnSdGyIVZIWyHDI2nqt8mYohsdf1kEDRjR1rlbOnh4pbpEzF91SZXF96Vxbk46CxCVtbNoz4Va4W4lwcy5Glt70kV5v/U7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725222225; c=relaxed/simple;
	bh=mhS9wq/z1LmRJm25oMawrdaABZQXIXK+jjXel794nKk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U56EZscOuAGgkmBVccLxYfcFFIingV3ScuxWyfKvb0o78HKAbzvSBqmlgGqzNqSt8BhLHMohljfUOeG4oSRkEmQTPrKIM5O1WdIOEtSc0SWXTWlxK4UWaSQzH7FqlX2W95f/T0YeGO6FLMhZJy26jNO16REb2qbDuigbS/Vz2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cg6s0aFA; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481KNQbv022550;
	Sun, 1 Sep 2024 15:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725222206;
	bh=P63PBx57TLR3J3nlihP0rfAAdQSDZKmFeLSsxI2ky2k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cg6s0aFACZC49WR87Z0XVIBYcfL1xk5vCepikG98ZPIjjn8AE7BJPDiPHAvmxHv3D
	 9nvxe1DGMKQnzKazMEziZfhKyw5v/6KySpS4EtrBXNncxIQ1VPbbaMWO62chr9jwUu
	 Hog86MeeUiDPHWu5YLgO/T79l9w5hiHIReVt+0QQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 481KNQQC016796
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Sep 2024 15:23:26 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 15:23:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 15:23:26 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481KNQkg126828;
	Sun, 1 Sep 2024 15:23:26 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Nishanth Menon
	<nm@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Dhruva Gole <d-gole@ti.com>,
        Roger
 Quadros <rogerq@kernel.org>
Subject: Re: [PATCH V2] arm64: dts: ti: k3-am642-evm-nand: Rename pinctrl node and gpio-hog names
Date: Sun, 1 Sep 2024 15:23:23 -0500
Message-ID: <172522211850.998098.12472787357819086145.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830113137.3986091-1-nm@ti.com>
References: <20240830113137.3986091-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth Menon,

On Fri, 30 Aug 2024 06:31:37 -0500, Nishanth Menon wrote:
> Rename the pin mux and gpio-hog node names to match up with binding
> rules. This fixes dtbs_check warnings:
> 'gpmc0-pins-default' does not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'
> 'gpio0-36' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
> 
> While at it, change the phandle name to be consistent with the pinctrl
> naming.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-evm-nand: Rename pinctrl node and gpio-hog names
      commit: 47ca0776e3637e8cfbf84483a0b0c22fbdf3a9f7

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


