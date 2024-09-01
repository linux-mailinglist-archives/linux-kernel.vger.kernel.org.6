Return-Path: <linux-kernel+bounces-310382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2273F967C0D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5DD1F21741
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888A07581D;
	Sun,  1 Sep 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SOVVBAdV"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C31F957;
	Sun,  1 Sep 2024 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725222089; cv=none; b=fbQ0cJys9PiIydL+VQoK+aU6EHLL4SoxaXF+sr5sEY2r7SoY8dcUO/BMrLg2fbBBMJ7mqM6FC48qPGZWANPwdCrxGCobaDkRzV2+r8B3Z84rCLcJqQBIMJBEqkvxgeIySYlZ7boc1jmjVfNmXam4zBp1qDrbdzHL72gBkIEUAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725222089; c=relaxed/simple;
	bh=IvJIlDIthNZ1lwypfvBgP2GJ3J5uM3u8jUctdUDC8FQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSSR7yMot6iuBSRI5bkeri6CxgNMfBAHr8f3m5kjozcjRRwuzylbHvQIkX8cx+BFEIHikEP47WWNoeScJyNsQ4Do1Pzvt7OdCMK7Ub83GzUYHfD/QkYROEKA/qUx/iIMfvPfirpKrmkxJIAg7Z8jmIevnrxAbbdN50WxQMQ59Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SOVVBAdV; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481KLEA7044066;
	Sun, 1 Sep 2024 15:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725222074;
	bh=Is2+Xz3AM8tEhv1LAOQhmqzsHkHutpPP4GhsnUVEARM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SOVVBAdVmEM0tzUsBnq4dwdDVd1UefDvhKTtNW90DNj1Ot8tAQdLoPP9o2RHoKBnA
	 wzn+KoR8f9l3ju2xoZH8qFJjSn9Y6nNsxIPtiAg3BjOnouLrIs3ZyK2QjAzZLV7P6H
	 cZvrsDZa/stY+4ERz2DdvN6y8MZpH/IhXtrR2f04=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 481KLEAI082654
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Sep 2024 15:21:14 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 15:21:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 15:21:14 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481KLEaS125018;
	Sun, 1 Sep 2024 15:21:14 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Santhosh Kumar K <s-k6@ti.com>,
        Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] K3 include entire FSS region in ranges
Date: Sun, 1 Sep 2024 15:21:11 -0500
Message-ID: <172522205232.997813.14194810707884898128.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828172956.26630-1-afd@ti.com>
References: <20240828172956.26630-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew Davis,

On Wed, 28 Aug 2024 12:29:52 -0500, Andrew Davis wrote:
> These add the full FSS region to the ranges properties. For Linux
> currently this should cause no changes, but testing very welcome.
> Software running on the R5 such as U-Boot makes more complete use
> of the lower FSS data regions and needs these ranges.
> 
> Thanks,
> Andrew
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am65: Include entire FSS region in ranges
      commit: 55799866382524cc5dae5bf90d2fa469dc7889a8
[2/4] arm64: dts: ti: k3-j721e: Include entire FSS region in ranges
      commit: 16dee71beec8957ab89ee15e6f17fcb33503a9d2
[3/4] arm64: dts: ti: k3-j721s2: Include entire FSS region in ranges
      commit: a919e59c0c1563437ab1892ff39df441da7521a4
[4/4] arm64: dts: ti: k3-j784s4: Include entire FSS region in ranges
      commit: 6c67a0f1647d486674a064d4abcadfb083a6f6da

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


