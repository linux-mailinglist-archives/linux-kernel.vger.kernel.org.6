Return-Path: <linux-kernel+bounces-388119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D35789B5ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3E11C22792
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F68E197543;
	Wed, 30 Oct 2024 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yb8vUdjr"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89F1946C9;
	Wed, 30 Oct 2024 04:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263872; cv=none; b=XY/rC6uMpUFF+dBBzJVuLnFqRHco80Riiibougdfd9WLJO6FSLGdaawxczRiZmpLo4F+hxBrA2QJHgqe1zQuez/AuagaPSJyPxUDGHtXg1tcN1HMA27k8vFnrLhY1eea1GvsInn7Q28j3sekQBQWg/1uKeqYs5zZPpmHnbj9u4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263872; c=relaxed/simple;
	bh=wXw5RRUfD52VAkLthpT6NnxbBXEJ1c2qozoRf3L+ugo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBp+rIz3N9JFVVIr7HET3sDn23BX1Q7btA4fZeu4kgAUEM8ZIOh/S/YaEodwbLbdoSTfVsOUg1tv9H1xNdwyD0AfZX4eXpFeoIbaivBjh4UpIw2ICFwgKdK/VWXZYDcwMGn0sUDif4BjhbHh5v6tKv1lE53/VNka0s3jyLUX54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Yb8vUdjr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49U4p4Jm090231;
	Tue, 29 Oct 2024 23:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730263864;
	bh=E8tXovtfoixcxi7B8JqfwoOyVvh02/h3f6Kwr8P3V4g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Yb8vUdjr7376F9jAQjJMzL6GX+gq4XhQVVcQNsRrCV7ipeQWfHG+xy8A4GX16pVDQ
	 cdBcLFZFBQp1DKJrTqftyhP75UX0QMZzb2riG/WFprmf3tE1bMgtOpY26TyVmR8Odw
	 ieTbAlcHCw3Y1pYD4nYbrt5PI62B/NGNXECeU0lc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4p4eF085037;
	Tue, 29 Oct 2024 23:51:04 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 23:51:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 23:51:04 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4p0BO061271;
	Tue, 29 Oct 2024 23:51:01 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm: Add overlay for PCIe0 EP mode
Date: Wed, 30 Oct 2024 10:20:58 +0530
Message-ID: <173021674667.3859929.9064799464954390534.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240930103413.3085689-1-s-vadapalli@ti.com>
References: <20240930103413.3085689-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Siddharth Vadapalli,

On Mon, 30 Sep 2024 16:04:13 +0530, Siddharth Vadapalli wrote:
> Add overlay to enable the PCIe0 instance of PCIe on AM642-EVM in
> Endpoint mode of operation.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-evm: Add overlay for PCIe0 EP mode
      commit: 34d7b8419323f6e35cecb445ec39ba5fd30a2d27

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


