Return-Path: <linux-kernel+bounces-240682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 533879270F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091981F23517
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479B1A38F0;
	Thu,  4 Jul 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ryyx9q92"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842A1A00EE;
	Thu,  4 Jul 2024 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079560; cv=none; b=GOdcdxMOa6fAqR21uAoGUnzpwoY7sxCvihfUX+4jeJB/13Zvl6ZhOs4x8nuzgSrOnjPxPDLadj6E056vtUwhUj/jjat6h5SqsnBbb2pD0W2a24/t0Is0NsFtkXTfpAGeYiV8WGRDh7xIShUAQ5e5KfsizhLGIPNWjV6rh3EuuH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079560; c=relaxed/simple;
	bh=vx7r9RithsTIhoBsWcjaukr8mhq/fU/31SBMkA8+NoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcIbxaMvqJ+YwWrnF6mMV1uDKyurwmF3Vrj9Yuu9fD0udYSnBL0rvVXIiecQgbPVwp39yuckd7ZIq1Ce/174XsKcJrsm157Zg3y9lp2RfDatpSS9mUT3wN2XAiR26B4Pm6e2bJEOWGWoI0ttHSp98p1L5GOms3pe2+B6IQCELvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ryyx9q92; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4647qXQk105647;
	Thu, 4 Jul 2024 02:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720079553;
	bh=dOWPr76nHuyM/N/Bfc2Za4VDRa5JsS3ea3bngrwNCKs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ryyx9q92STncayalwoDELA++yxbiyJH4m4e29iz3fabHowRfuAlM9TK9AndSnD7ST
	 HkjSxwv2cY2tQKC2vvgcFURu66OIZ1XDTfvDH79F/w4n/7+xhH7NYC2zjLFDcVTHiG
	 jKgJPg0Xa8FuZG5PzfICzwsI1RMUzM/Ys4yO6sFs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4647qXNQ115339
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 02:52:33 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 02:52:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 02:52:32 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4647qSjl005732;
	Thu, 4 Jul 2024 02:52:29 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <srk@ti.com>, <praneeth@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm: dts: k3-am642-evm-nand: Add bootph-all to NAND related nodes
Date: Thu, 4 Jul 2024 13:22:13 +0530
Message-ID: <171984950183.3152309.6737334326106721786.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628-am642-evm-nand-bootph-v2-1-387bfa1533a6@kernel.org>
References: <20240628-am642-evm-nand-bootph-v2-1-387bfa1533a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger Quadros,

On Fri, 28 Jun 2024 13:30:38 +0300, Roger Quadros wrote:
> NAND boot would require these nodes to be present at early stage.
> Ensure that by adding "bootph-all" to relevant nodes.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm: dts: k3-am642-evm-nand: Add bootph-all to NAND related nodes
      commit: 447f85b70f6553218e0aa7889e8615e4b31c8a2f

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


