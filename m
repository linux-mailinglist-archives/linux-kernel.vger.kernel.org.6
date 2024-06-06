Return-Path: <linux-kernel+bounces-203797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C55A8FE098
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346CC1F257A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9689713C819;
	Thu,  6 Jun 2024 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sVreaeaK"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6F413AD3A;
	Thu,  6 Jun 2024 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661365; cv=none; b=ucB2oK+AyLxtW8rdW2PgkX22ujy4ooWl0eA66aFPxW4TnQhQfPmwz/3S4TMtgBqkSVxo+YgvGOL6FEChUl/9P8O9e+JrMtR4bV7h5//2sDPW8viiPovPPTKIrOw6WvkdE4163XJBZLeMTouxmeShc3XXM5X5PSRHKQUVJmrEHQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661365; c=relaxed/simple;
	bh=JwRCxkjzBxoZ+RTPlY+R88A3hli0uy+86d7yQBlTUzg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=u/npWJys/zATnVP8fCC+aD98B74N0dCwZ5BoS8f0ncJZQVnMmfxGGBGQ61rrAzxo/3CIBzC4svx8hCZWmQKNwoaqHrsJzYUDQXql2LcBKOihC/RenSwrnwRT3RmlahVvXw7n5PDhH4+qjcyyt086P/fpq7gxOz/ZFkzrOpQ+zSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sVreaeaK; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45689BwJ089368;
	Thu, 6 Jun 2024 03:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717661351;
	bh=pHoOXJrDm+n+sdwoGca+WOQtOOaj32WL9daPT0XNCF4=;
	h=From:Subject:Date:To:CC;
	b=sVreaeaKgkyA23Egj09+ZJi6LsOxmh0JJjX+0zAVaI+X8qvLHMAzeMleE60qZeVfP
	 RI/fmIA8fZ9jaIihRW44ntL8sE3KQWTpKZAlj1RIsoHRbs0+H+zYpJ8aakxXloCVJj
	 /bkRVhfDeSmnkYN6Ss1Lx+1mJQPM0qtxsq42m+Zg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45689BcR016058
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Jun 2024 03:09:11 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Jun 2024 03:09:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Jun 2024 03:09:10 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45689AZr017363;
	Thu, 6 Jun 2024 03:09:10 -0500
From: Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v2 0/7] arm64: dts: ti: McASP fixes
Date: Thu, 6 Jun 2024 13:37:39 +0530
Message-ID: <20240606-mcasp_fifo_drop-v2-0-8c317dabdd0a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtuYWYC/3WNQQ7CIBBFr9LMWgwdEI0r72GapsBgZ9FCoGk0T
 e8udu/yveS/v0GhzFTg3myQaeXCca6ApwbcOMwvEuwrA0rU0kgtJjeU1AcOsfc5JmFuyjqlW0S
 DUFcpU+D3UXx2lUcuS8yf42Btf/Z/a22FFFKRJbwEffX2sfDZxQm6fd+/I3jRPKsAAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh
 Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Drop McASP AFIFOs for all AM62 based platforms, as the extra buffering
is not needed with BCDMA already having internal buffering.

Also fix the pinmux for McASP1 on AM62P.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Changes in v2:
- Drop [tx|rx]-num-evt properties instead of setting to 0
- Add Fixes tag for am625-phyboard-lyra-rdk
- Link to v1: https://lore.kernel.org/r/20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com

---
Jai Luthra (7):
      arm64: dts: ti: k3-am62x: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62a7: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62p5: Drop McASP AFIFOs
      arm64: dts: ti: k3-am625-beagleplay: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62-verdin: Drop McASP AFIFOs
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62p5-sk: Fix pinmux for McASP1 TX

 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi            | 4 ----
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts        | 2 --
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts | 2 --
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts               | 2 --
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts               | 4 +---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi        | 2 --
 6 files changed, 1 insertion(+), 15 deletions(-)
---
base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
change-id: 20240604-mcasp_fifo_drop-683bc3412262

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


