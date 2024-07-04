Return-Path: <linux-kernel+bounces-240686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0070927100
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799B61F21C94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B321A00EE;
	Thu,  4 Jul 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q3SHzsJA"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC31A3BAE;
	Thu,  4 Jul 2024 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079762; cv=none; b=QOuUub4m7Dn3PwCt10to4q/brgTDW1dAz8Mr9GPSWruWrxxjulGpbb03KCw1jIe9j/1LyK8LFJTFpYhof9Pv5SkBf9YF0pje1cCekzCEdB1MrwEvXGh/hizw3/F0HN/cUjab7AHikgg/7XReon1lcqRXbUTxke2XLmsJ+dbYYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079762; c=relaxed/simple;
	bh=KghN883jBh6Io5Y0eUMvv1zE2TWd+NJpL2wG6Pr2joM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBT71pu9IKEJhIOp9XSt8/1GJbWHNA1JhMNq6uBRFDhMmyqHWAffuX9FkqufZJZGWDgQcrAtuvmNHBlIQvB2RuzunuDbzsf/V9s0AKv0I2j5TKJ2F2ZujdukZ7WqkG141Ekp1BOTsgh+4mSnxQM47gOCqbGMjX88kOuPlqnp2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q3SHzsJA; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4647tu20106344;
	Thu, 4 Jul 2024 02:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720079756;
	bh=NvsVZrqJ6tnujUyNaW5tV2ZXzfEk6NnluF7d1uCaboo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Q3SHzsJAIyNLLoD5GigKUhnJUD2uK9XJEsHvHiKF0bJ9SLzkkuEL3ggxcdzOt1ixF
	 3e7oD9UQ+hJD4a5RhH/T2g2lnMZ9l2DTjbAD/88AdmsKJeD1pNAz7R3UItcYyZ0wVC
	 DhZU2dkh5QkBGDnQBzSvgZC+rO7qQyQyfyDW3bH8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4647tuDS021726
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 02:55:56 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 02:55:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 02:55:55 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4647tkPU055890;
	Thu, 4 Jul 2024 02:55:52 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <j-luthra@ti.com>,
        Jayesh
 Choudhary <j-choudhary@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <u-kumar1@ti.com>
Subject: Re: [PATCH v3 0/2] Enable audio support for J722S-EVM
Date: Thu, 4 Jul 2024 13:25:42 +0530
Message-ID: <171984950181.3152309.14393845920250640127.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625113301.217369-1-j-choudhary@ti.com>
References: <20240625113301.217369-1-j-choudhary@ti.com>
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

On Tue, 25 Jun 2024 17:02:59 +0530, Jayesh Choudhary wrote:
> These 2 patches enable audio on J722S-EVM platform.
> 
> This patch depends upon the bcdma driver fix posted upstream:
> <https://lore.kernel.org/all/20240607-bcdma_chan_cnt-v2-1-bf1a55529d91@ti.com/>
> 
> Changelog v2->v3:
> - Move audio_refclk1 node to SOC level dtsi (k3-j722s-main.dtsi)
>   in a separate patch
> - Rename vcc_3v3_aud to vsys_io_3v3
> - Fix ball number for McASP pins in comments
> - Fix padding for audio_ext_refclk1_pins_default pinmux
> - Pick up R-by from Jai
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j722s-main: Add audio_refclk node
      commit: a5cd7067e45c33907afe20c0d1ab5e75b09a1ee2
[2/2] arm64: dts: ti: k3-j722s-evm: Enable analog audio support
      commit: 3a36c535dfd279ff093cc9271f474a99531bea21

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


