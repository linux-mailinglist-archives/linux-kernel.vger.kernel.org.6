Return-Path: <linux-kernel+bounces-387246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 224689B4E75
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE0CB258BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1043195FD1;
	Tue, 29 Oct 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eW8/+zlt"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8F198845;
	Tue, 29 Oct 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216883; cv=none; b=nWd2zSOuKly3fh5BniCRV572mXVLdIqHfMfHqSfGT7K9LMnPLETR2T+eD9/SeSXOdw0GB0iqjAPOgcJQx7KNRvXbWgu87aPM5rZRKAyi2TTPLBLkjVyAxnTecIkL6q8OWOP3Ky9aM0095Hm4PfbjA/KPqupxhO6jYa5/UHhePMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216883; c=relaxed/simple;
	bh=bXgI8yYLCD1cU3FeaaF3Pc33Ya+kYvFdAUU79xZRo6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gys1c51OTvHek4mmihWLRXtPkgJSUDLNNVWPDiOa6tJsy9szi+RmnAMPaW8JwF6XxivCPIqO9U89hFuwJMVUKQYmcj2KCpyH8c+DNZj79QKHrCV/jYUI52aKOlaaxePAnP43C+Jonx7K2MPP9LBBYOUmw8WM7ItomHd9ZUp7OHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eW8/+zlt; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TFlkPw017478;
	Tue, 29 Oct 2024 10:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730216867;
	bh=ZFCEJ4g+q7FVoJLDbzrDAqZ6+sS4Dyw5icfXHcV/0Cw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eW8/+zltOf6AUZmJdCcZcmXWRgxGDmUcS07w1c8oOMjOmA8xuJWYFNWv3SIfu1pK0
	 bZy9J39TEUw16AfvV4XhGyhqet27z2cq8GPmO6LI+SEdD310qssMnmamFaNMYL2IJL
	 PJ8UF71jEHBEYSaK892yvzUDQsKLHgrORGFMN1c0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TFlkLX007276;
	Tue, 29 Oct 2024 10:47:46 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 10:47:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 10:47:46 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TFlgsq083593;
	Tue, 29 Oct 2024 10:47:43 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
        John Ma
	<jma@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62x-phyboard-lyra: Fix indentation in audio-card
Date: Tue, 29 Oct 2024 21:17:40 +0530
Message-ID: <173021674668.3859929.14447889402443380777.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240926184849.3341986-1-jma@phytec.com>
References: <20240926184849.3341986-1-jma@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi John Ma,

On Thu, 26 Sep 2024 11:48:49 -0700, John Ma wrote:
> Corrected the indentation for the audio card node in the phyBOARD-Lyra.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62x-phyboard-lyra: Fix indentation in audio-card
      commit: 9130fc1b124cbcebeb11e3f7cf420a30fe545d26

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


