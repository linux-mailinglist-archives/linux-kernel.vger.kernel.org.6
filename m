Return-Path: <linux-kernel+bounces-550907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677B0A5659A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09E91735C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04468212B39;
	Fri,  7 Mar 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YmgbTYzp"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C59211A20;
	Fri,  7 Mar 2025 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343965; cv=none; b=djS4pZZJNqumKFcYOvSoPnvSwmNqEAhyvYyueHKiAM2F5VlkNlVkZ94ph7loGnE46v0FKencUS/iMV1Fc3eP7tNS+2YVK0cMjGgdNiA7gssFnVtukAqWUirXYSUacJqsgxAdEd/afQF7CZD2RRaeAE6EpNOf/GH7fM4SUp5L7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343965; c=relaxed/simple;
	bh=HxWFlzYZ/kTUSwmC8giaqnJl4ApMkmawbxezqzBZsMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOJ639Y5P0H4V10Dy94GemTSH9Mr01F6LJXbl3Kwh0L6uqZ2DTrEr0WZ1iHTF7C02jlcbhfszfOWPv/BZXjopdSdoxHxGxXasRfS+l5VhOk1ocwi9L4JE3O329j1N1CiuqC/N5ucpobV35wHXPUXuxsywavwIaktm41Lp5a50wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YmgbTYzp; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527AdAd94040303
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 04:39:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741343951;
	bh=YU88KIu28z7FJc3ACej39tJ8cAKVnj4yM8ha3DZROns=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YmgbTYzpuzp2KYj0yx0UEIjAjZFY/Ns7gVzjbZXvDPQOF90datY/E1DWIswto0oDP
	 cTn89tlo+BCHcA/MGcdgi9li1WjQ3h7q7ExNliNOjzZaHdE24hvTnXRqDFruBu7K1k
	 DF46X4VLGzHEKqt1gxVt9U2OhsroZ113B0TdFVXI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 527AdA44004468
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Mar 2025 04:39:10 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 04:39:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 04:39:10 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527Ad65t082496;
	Fri, 7 Mar 2025 04:39:07 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Daniel Schultz
	<d.schultz@phytec.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <w.egorov@phytec.de>,
        <upstream@lists.phytec.de>
Subject: Re: [PATCH v2] arm64: dts: ti: am64-phyboard-electra: Add DT overlay for X27 connector
Date: Fri, 7 Mar 2025 16:09:03 +0530
Message-ID: <174133309360.1072814.5781136460553851194.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250128100356.462934-1-d.schultz@phytec.de>
References: <20250128100356.462934-1-d.schultz@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Daniel Schultz,

On Tue, 28 Jan 2025 02:03:56 -0800, Daniel Schultz wrote:
> Add a device tree overlay for SPI1 , UART3 and GPIO1 on
> X27 connector.
> 
> By default, not all interfaces on the X27 connector are accessible
> due to being disabled or set to alternative pin mux configurations.
> This overlay activates and configures these interfaces to support
> connections with external devices.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: am64-phyboard-electra: Add DT overlay for X27 connector
      commit: 638ab30ce4c63edae4934dcaa7a61f37b96efe6c

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


