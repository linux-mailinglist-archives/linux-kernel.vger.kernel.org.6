Return-Path: <linux-kernel+bounces-225562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8895191323D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 08:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279AA1F21D98
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A114B078;
	Sat, 22 Jun 2024 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m2ny6oge"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D28F66;
	Sat, 22 Jun 2024 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719036874; cv=none; b=U6K2g9tuEYtQeQ6Kv1z06VdDXBxa9NO5b5OIJ5YRYKY43DenxjAzK+wqlzQ+0Q8kRhXbRFNP1SJ/cisQyb25eimwM3mdk35GYYGI5CA/Kx88/QriSxkqMtQjZwS5Kw+3dAkbmxdwczRpSTXohRWDDmFn66lzSIeUCOxZItWV/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719036874; c=relaxed/simple;
	bh=rE8s4/lVGqOH2HVvCPHLjv2fnvzZ8VW5ODWWL4pLeVs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUahLA2yKP0Rbo01coNXjCWHkFHy4XXYCP0/A3OFFwNCeXiX08GSoPUSs8a+ge6/9GRu3qabfs9y6WmHEJU7RxRSM7IV2HxdcEw6IqoXGxTQjVTh5QtaUkPIPb0O/rTwpZNu+Ezb3ajxp0wFM5jcGZ65KcB9eaihzLGRyYaSjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m2ny6oge; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45M6EObw087734;
	Sat, 22 Jun 2024 01:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719036864;
	bh=zuRNlVx5I+17kIxkSzgYpuIh6L4ea6JU89TLnbXSr40=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=m2ny6ogeZdkC2jIJkQnjIpGp3JEhJdFFv0EQ5GoBIYSsJU9UDCapbKpy8/srcEjp/
	 1eCS4tKA2bDAHB9MxpOwWdIQRw3yMq1Tv9zbV0h2pLmfDRFZX8ytS48I1gaWwRYrxr
	 24yK5ry8fbwDpfKE8kUe+kELnvZP/4KcYeikebNY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45M6EO5W118797
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 22 Jun 2024 01:14:24 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Jun 2024 01:14:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 22 Jun 2024 01:14:23 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45M6EKj2128067;
	Sat, 22 Jun 2024 01:14:20 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <a-bhatia1@ti.com>,
        <u-kumar1@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e: Add overlay for J721E Infotainment Expansion Board
Date: Sat, 22 Jun 2024 11:44:07 +0530
Message-ID: <171898028152.2272421.10198050525742682172.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613093706.480700-1-j-choudhary@ti.com>
References: <20240613093706.480700-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jayesh Choudhary,

On Thu, 13 Jun 2024 15:07:06 +0530, Jayesh Choudhary wrote:
> J721E common processor board can be interfaced with the infotainment
> expansion board[0] to enable the following audio/video interfaces in
> addition to the peripherals provided by the common processor board:
> - Two Audio codecs each with three Stereo Inputs and four Stereo Outputs
> - Audio input over FPD Link III
> - Digital Audio Interface TX/RX
> - HDMI/FPD LINK III Display out
> - LI/OV Camera input
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e: Add overlay for J721E Infotainment Expansion Board
      commit: 9c0fa304fa561abfe83d328ffc4f638c0152bead

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


