Return-Path: <linux-kernel+bounces-276945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43FB949A40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4EA1F227B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075CC165F08;
	Tue,  6 Aug 2024 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EBVrfHvB"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC5374C4;
	Tue,  6 Aug 2024 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980077; cv=none; b=RS6uD8Im/nSccKgTpVzGPja3tZ9rZZWeboJUPZcvFk7LI9WWcJZwYieQl+8Z6xkz0XGjtYUykeybr+f0HVei4drRGVDXSSbDzYltnNk0igU5ckDtA5TFaRVWANfCSyoT2Ktbbuu7KGRvU1zR8ruxQhHdXJYjNKBm0DTWD4xH/6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980077; c=relaxed/simple;
	bh=/jTkFQ8ev6vvnwdDNVwixlkwQ69qyZwJEDKz4pu6HKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDRct6X07PDEtDiQ0PdizJOQV3CALh3B88zehO9SMd++Ect/BW87V/bccHGg/mdT+6DlAaeSSP5ck4Hn8vK4PE1IzjfGXxy1WMCrHhTlsMSwZJm+wyctBv8hYRczrniVl7lswmSRDsQRgQTI2kXfGrtyuU5wlsv91U+hghY7Fhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EBVrfHvB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476LYUGj122182;
	Tue, 6 Aug 2024 16:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722980070;
	bh=UHFII3hknLPwvageK9iQOUyvT59K+4CNg5YM0uH1HDM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EBVrfHvByBNtn81TxrDTZTLfLAtO+6b2WrxEFyrEhk2tXuH0YAGp0v6eSAKkje9h7
	 oFtJPMC29N0k15XyFX2GGyVlML0++X3bPcYHQHFdFC2LPofpo+QLGuL26Q29JB0urZ
	 /Y0HDwZ5nITXDOLUTPFEvVBIR03y30JVsltZQrCg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476LYUcC101299
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 16:34:30 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 16:34:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 16:34:29 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476LYThK085253;
	Tue, 6 Aug 2024 16:34:29 -0500
From: Nishanth Menon <nm@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bhavya
 Kapoor <b-kapoor@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <jm@ti.com>, <vigneshr@ti.com>
Subject: Re: [PATCH 0/2] arm64: dts: ti: Update mux-controller node name
Date: Tue, 6 Aug 2024 16:34:28 -0500
Message-ID: <172298005662.488348.14948625003852817425.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729063411.1570930-1-b-kapoor@ti.com>
References: <20240729063411.1570930-1-b-kapoor@ti.com>
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

On Mon, 29 Jul 2024 12:04:09 +0530, Bhavya Kapoor wrote:
> There are 2 mux-controller nodes in J721S2 and J7200 which are
> responsible for transferring can signals to the can phy but same
> node names for both the mux-controllers on a platform led to errors
> while setting up both mux-controllers for can phys simultaneously.
> Thus, update node names for these mux-controller.
> 
> Rebased to next-20240729
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721s2-som-p0: Update mux-controller node name
      commit: c36f60772e2aeca253924572a9f348ba27192bd0
[2/2] arm64: dts: ti: k3-j7200-som-p0: Update mux-controller node name
      commit: e3cce1229c34b5c28f103361c4d6b3ef17302d5d

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


