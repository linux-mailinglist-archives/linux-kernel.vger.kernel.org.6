Return-Path: <linux-kernel+bounces-212868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE9906764
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D27628763A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E384713F447;
	Thu, 13 Jun 2024 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XXiQmdg+"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764DB13E3EF;
	Thu, 13 Jun 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268417; cv=none; b=uJEwKkzgtNub6Q0J2OPjmtIC6yRFV82U0SLPWmgSz1AZJpmpsAj/xQUmecKcMlsl5sKX/213t9SfnEHF/+x/dwLgCrHzahdf/qvtLsxudxbwodSNeHluEnIaEjI8mSpOpwtDUioBwNghKf1XoZtYbQRnjkmmRcYx1zOaJfQ79Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268417; c=relaxed/simple;
	bh=XJffr/5LB55gXVcg0eSyeFd0VSpe2GwmHjzw48Bdo18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4w8vsD7oL3JpubdojpZXKbed5ZvCIPVieUAUwQQpycySzf3dyiJ4QjuJHsYkW/TFgBZTIbhrd9cxSwKEgMAVYRoChNTrPsBMX8CvLOx9SIXpQux+rhi67PacUqOuX9eIx+HAi+XsjDiLP1Iwjv0RtSgmv4zA27vNx8JgPfVUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XXiQmdg+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8kkXI025178;
	Thu, 13 Jun 2024 03:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718268406;
	bh=90NYOlgMHjrlLG8SfZAMFu9wzG/J+xMs17o+vVUT5zg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XXiQmdg+ag1PzCv+VWVLutgeq2mfLL19AC1RrJqwvtyLPaDsTCsh978JMFCNG7/QQ
	 FCwiyEvvecnODl37OvELmwTXvvqJNqCH+o619Jv2PjT+HbBzcIDxJXfeK6Gy+HsInn
	 hFgLdHI6WK1nV9kf0631LSGP/uKhjCJH6Rh4yL38=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8kkUe074431
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:46:46 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:46:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:46:45 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8kfOL093985;
	Thu, 13 Jun 2024 03:46:42 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar
	<devarsht@ti.com>, Bryan Brattlof <bb@ti.com>,
        Aradhya Bhatia
	<a-bhatia1@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Jai
 Luthra <j-luthra@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] arm64: dts: ti: McASP fixes
Date: Thu, 13 Jun 2024 14:16:38 +0530
Message-ID: <171826022276.240984.17264900560475914548.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606-mcasp_fifo_drop-v2-0-8c317dabdd0a@ti.com>
References: <20240606-mcasp_fifo_drop-v2-0-8c317dabdd0a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jai Luthra,

On Thu, 06 Jun 2024 13:37:39 +0530, Jai Luthra wrote:
> Drop McASP AFIFOs for all AM62 based platforms, as the extra buffering
> is not needed with BCDMA already having internal buffering.
> 
> Also fix the pinmux for McASP1 on AM62P.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/7] arm64: dts: ti: k3-am62x: Drop McASP AFIFOs
      commit: 6ee3ca0ec7fabc63603afdb3485da04164dc8747
[2/7] arm64: dts: ti: k3-am62a7: Drop McASP AFIFOs
      commit: a931b81072921a11d5bb8e8201b6228b791d40a9
[3/7] arm64: dts: ti: k3-am62p5: Drop McASP AFIFOs
      commit: d3fe4b4e2e44de64ed1f1585151bf4a3627adbaf
[4/7] arm64: dts: ti: k3-am625-beagleplay: Drop McASP AFIFOs
      commit: 3b4a03357aee07a32a44a49bb6a71f5e82b1ecc1
[5/7] arm64: dts: ti: k3-am62-verdin: Drop McASP AFIFOs
      commit: fb01352801f08740e9f37cbd71f73866c7044927
[6/7] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Drop McASP AFIFOs
      commit: 554dd562a5f2f5d7e838f7b229a1c612275678db
[7/7] arm64: dts: ti: k3-am62p5-sk: Fix pinmux for McASP1 TX
      commit: e96e36ce1fdcf08a70e3f09cbe2da02b073c58ac

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


