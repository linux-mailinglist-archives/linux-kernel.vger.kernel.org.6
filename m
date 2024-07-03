Return-Path: <linux-kernel+bounces-238873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5534F92526C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D37290577
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780862E646;
	Wed,  3 Jul 2024 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zIstOysY"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F1262A3;
	Wed,  3 Jul 2024 04:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981449; cv=none; b=nkBDafkukIPCK3iJhO/+D1c7t0MetPpErbdvRL/rTMX6cmVo++n9dafhYuBnmiG3C23BTomrbNXmmR+9deeSBFUWl5qsa1qFnfQCYoxQEAFAIMhmgJGxXkDFh8LRY6z8TaP368iTRviS4W8JEq0bGmkPb7twF10z2Gm//5H4dNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981449; c=relaxed/simple;
	bh=Fpyen95ydLgYW4ieCKD+3fqVjA0d5rhMmWFO15Wj1gY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sx28E9voUUNrk2jj+53XYrT74fl+LrXdQz4GiZNlKdMIRQJN4AIDrQO5OIiUYZmwD+TQ8mUL/j1pEtM8y+sYELfYVRFhcRmv9Z0kTzlaxuk39So5X/3TseMgo+GQx90JXmLpaGl+Mw5BqauHII4IaJOh4Q1P5YKE7EEpzOm23IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zIstOysY; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4634bJR7090105;
	Tue, 2 Jul 2024 23:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719981439;
	bh=NmGrZkn6T7bzYtKVbSm+ruhlTM+ZCFmHseCRAhNHEKA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=zIstOysY2gT0MmgIZyYmprod1nUYQKzrfGfAtiu6mwizeG1HjbKgwPrJaY71swwaK
	 OKe2VNtgNBOlZsIbx1BEcpI8mbHq5pSPz5U2xeRpCLzunb5RZPYhLyz/km+h5bTy+T
	 1X0YoM+Aks+BLgMJZjdpjn3Xj1nXnc3fyc18eTV0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4634bJjq027740
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 23:37:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 23:37:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 23:37:18 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4634bFGG011328;
	Tue, 2 Jul 2024 23:37:15 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <w.egorov@phytec.de>,
        Garrett Giordano
	<ggiordano@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH v2 1/4] arm64: dts: ti: k3-am62a: Enable AUDIO_REFCLKx
Date: Wed, 3 Jul 2024 10:07:06 +0530
Message-ID: <171984950182.3152309.13258458514527438759.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626155244.3311436-1-ggiordano@phytec.com>
References: <20240626155244.3311436-1-ggiordano@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Garrett Giordano,

On Wed, 26 Jun 2024 08:52:41 -0700, Garrett Giordano wrote:
> On AM62a SoCs the AUDIO_REFCLKx clocks can be used as an input to
> external peripherals when configured through CTRL_MMR, so add the
> clock nodes.
> 
> Based on: Link: https://lore.kernel.org/lkml/20230807202159.13095-2-francesco@dolcini.it/
> 
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am62a: Enable AUDIO_REFCLKx
      commit: fe6a73eee30173695d3a56e30033d7bb1f4c79eb
[2/4] arm64: dts: ti: Add am62x-phyboard-lyra carrier board
      commit: f1b3adade0459a9a2d9fb0964f975e9541fb1ac9
[3/4] dt-bindings: arm: ti: Add bindings for PHYTEC AM62Ax based hardware
      commit: 567c373f441b29414157c00cfff09f1c60e83bf6
[4/4] arm64: dts: ti: Add basic support for phyBOARD-Lyra-AM62Ax
      commit: d69383885576954033b537c29c7d259f18e75293

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


