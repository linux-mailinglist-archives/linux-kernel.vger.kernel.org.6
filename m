Return-Path: <linux-kernel+bounces-214357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4317990833B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BDD1F22F44
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8A3132103;
	Fri, 14 Jun 2024 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xokVQM8j"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB7146D76;
	Fri, 14 Jun 2024 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718342115; cv=none; b=NwXnMum47pDrCR52L44GHjs1hkOq5JCLRsPwgI73l/eRwhQ44GVlssuqoubKa7MrC/dbxmzwYRdwnzLtSsauvHDmP+k1aK4xtG5qtxF89ZItyu3FW0l/5NxbLd5CxZIYJVMrfbrU1aLtryddmAt84f/lOmjYXJ1zVdVQd0TbNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718342115; c=relaxed/simple;
	bh=REPEg95+d+iTc0idDXfd78laK40EBF5beq+k9Ezn8cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J05Uzvxsphn932btwIScRtHlLZRaueIgotPNOVBiUOywsnaSTN97OkoIhAIDgLCaP3GgxzQEq+atE/5VQhGqW1SUbUsLXgPJgVdbqavb+CEzMbt0ihz1gvq1rPnSKloXiUbO0pnnGARuyGpwCV+XQyI07B4K+GAZyapJyJOmarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xokVQM8j; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E5F7we013061;
	Fri, 14 Jun 2024 00:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718342107;
	bh=ig4vo30RhDa2qdHlP6Cw2HLQ0WlbRQq5FAqPujvx3CE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xokVQM8jTq6zjiPFAvDQbGNF9rPf9HBdFKnppyi6RkwX/Lf3/haHALFUYp43XNmSQ
	 zchI8+FG069OGqMsyVUU7HYThZcJ9wcFlqwEPzidSFpI3Q41E5ZmtfWsw+NLx/VHxZ
	 lJx9g3ocxgCMq60R6OEnGW9eXL5rbCsA3H66IAgY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E5F7SO121849
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 00:15:07 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 00:15:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 00:15:07 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E5F4OU061708;
	Fri, 14 Jun 2024 00:15:04 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bhavya
 Kapoor <b-kapoor@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <nm@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add support for multiple CAN instances
Date: Fri, 14 Jun 2024 10:45:02 +0530
Message-ID: <171826022273.240984.17865327503994572008.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240411201747.18697-1-b-kapoor@ti.com>
References: <20240411201747.18697-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya Kapoor,

On Fri, 12 Apr 2024 01:47:47 +0530, Bhavya Kapoor wrote:
> CAN instances 0 and 1 in the mcu domain and 16 in the main domain are
> brought on the evm through headers J42, J43 and J46 respectively. Thus,
> add their respective transceiver's 0, 1 and 2 dt nodes to add support
> for these CAN instances.
> 
> CAN instance 4 in the main domain is brought on the evm through header
> J45. The CAN High and Low lines from the SoC are routed through a mux
> on the evm. The select lines need to be set for the CAN signals to
> reach to its transceiver on the evm. Therefore, add transceiver 3
> dt node to add support for this CAN instance.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-evm: Add support for multiple CAN instances
      commit: 4b5156e1a413eaa2094b3281d6ea4e6b31cea01b

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


