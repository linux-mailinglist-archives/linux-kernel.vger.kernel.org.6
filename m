Return-Path: <linux-kernel+bounces-310405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05848967C4C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 23:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12F4281B4B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 21:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723E713AD05;
	Sun,  1 Sep 2024 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NhsY6n/Z"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73FB53E22;
	Sun,  1 Sep 2024 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725225348; cv=none; b=kGOri4gc9zIUMHWPWEAB1CdW6xF3bHh/v8jt1O6Oelb9TmGIc91RF045Dghp91rdoC+Emg3P1b6RZOhD5V/sCK6uWSWhCZxIMvdycjNVlvS2MIxq1PfoImLN4NiaENZP16lEa4IMViS5Z13je++uoIZN1Dkq+lAIdonEL1wwO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725225348; c=relaxed/simple;
	bh=lRidtMEWLd9+QwbEUXUvDHAs+HY9t5mjG5L8fjcyWq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdbkQ9skD8HxZG79tn4XPS7ElrFrCPf1kGH15ZqQWk9Xh01yeaGUisz2J4LG/GM+RTqVMy9MI72W+n/20lbLyJZMNzy+WNbA5Gb0K3eN1D8WRwKGOAGqGEH77EROCPDnUM+DdfZYFESPJE5xUBdqdynG1oH4WKHVvuGrjZSAbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NhsY6n/Z; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481LFdGE085501;
	Sun, 1 Sep 2024 16:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725225339;
	bh=PBrrMAd7KEbZhXrYvNWs11hT4u7Pvv65Fz+cZMwgh+c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NhsY6n/Z8i6mdnsQEYZ6HmnjeQappDzC0MOzrv8AhE+ThL2TTFyVNs6CgCkIiILZK
	 uqkysqqo+i+0KxGHCZOjGEym/qIdkCyLe88o//o+LZUQr6gU/10lGlw82zQfcwtJxP
	 mLMSk3xNRJNykr6G56eoCJjTvuQtCZM/N6c3sEus=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 481LFdGv022102
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Sep 2024 16:15:39 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 16:15:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 16:15:39 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481LFdGN071033;
	Sun, 1 Sep 2024 16:15:39 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Beleswar Padhi <b-padhi@ti.com>
CC: Nishanth Menon <nm@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
        <vaishnav.a@ti.com>, <afd@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 0/2] Add Remoteproc Support for TI's J722S SoCs
Date: Sun, 1 Sep 2024 16:15:37 -0500
Message-ID: <172522532253.1011545.14727446934564211822.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830161742.925145-1-b-padhi@ti.com>
References: <20240830161742.925145-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Beleswar Padhi,

On Fri, 30 Aug 2024 21:47:40 +0530, Beleswar Padhi wrote:
> The K3 J722S SoCs have one single-core Arm Cortex-R5F processor in each
> of the WAKEUP, MCU and MAIN voltage domain, and two C71x DSP subsystems
> in MAIN voltage domain. Thus, this series adds the DT Nodes for the
> remote processors to add support for IPC.
> 
> This series also enables IPC on the J722S-EVM platform based on the
> above SoC by adding the mailbox instances, shared memory carveouts and
> reserving the conflicting timer nodes (as they are used by remoteproc
> firmware).
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j722s-main: Add R5F and C7x remote processor nodes
      commit: 05b1653c4fc148189743e4b3cbef798e49db61f0
[2/2] arm64: dts: ti: k3-j722s-evm: Enable Inter-Processor Communication
      commit: 5b035d14a508efd065895607ae7a6f913b26fef8

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


