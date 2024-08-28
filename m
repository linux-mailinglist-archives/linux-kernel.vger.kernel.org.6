Return-Path: <linux-kernel+bounces-305534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A8963026
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE941F21133
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA181AAE0F;
	Wed, 28 Aug 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S5TQaua8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803E1A704D;
	Wed, 28 Aug 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870273; cv=none; b=UtnTSFBvFrwaPAOcRnyABm049VhDii2UMPCg1Oq/39E/GHeGqA8p1uODDz6LMU+LYWO8kgdpBluy0RdnBZUVkPs06k5ZO3p3aIcddeFHIs7B6DJTwjU1PsivU6FhzYoOKyyfbc4w+530X0PONFCDb9vVBM6gEOfBAICYukZUg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870273; c=relaxed/simple;
	bh=NUmhHd+egPfsnnBmZ3P3MohXNYa8Nv/vlNvhtA++6WE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0+S57zR4xvXyuAOdS5RzFHyOX7JqxAJP2m32Vg7zDmB4rgjoxpUpKO/jemgAukjtdECqEQbzwAXTqLrewPH4F2tTi8s/CqxNAtPZUmyxLmfFjklP/jwLtswPAVOs/RTpBFqnLRl7SnNaiC6rsJcwYuHicLFkI4O8BPdXBORJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S5TQaua8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SIbglt095334;
	Wed, 28 Aug 2024 13:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724870262;
	bh=rMgr48VgkhQuuj27XQaUdvmqpKw+wTDzfaRpBG0WbdM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=S5TQaua8Y7/Jhd7/jyerBojHDyRNG0IbX3sOUxbMctyDoJN/Rki4V7ai4UrXSiihz
	 PGugUPViA2d2SP19fZDvdaa0fYELOso2xG9KbDQnSfBRBYLUp/f43NwT5LuUH9VjHB
	 PSbCTXXDJt9z4a3b3Ag6vftJKwNXKL95MJHDpgw0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SIbgsQ006924
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 13:37:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 13:37:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 13:37:42 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SIbgxc031591;
	Wed, 28 Aug 2024 13:37:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations
Date: Wed, 28 Aug 2024 13:37:39 -0500
Message-ID: <172487018381.3436753.17446528403419157131.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240801181232.55027-1-afd@ti.com>
References: <20240801181232.55027-1-afd@ti.com>
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

On Thu, 01 Aug 2024 13:12:31 -0500, Andrew Davis wrote:
> The DMA carveout for the C6x core 0 is at 0xa6000000 and core 1 is at
> 0xa7000000. These are reversed in DT. While both C6x can access either
> region, so this is not normally a problem, but if we start restricting
> the memory each core can access (such as with firewalls) the cores
> accessing the regions for the wrong core will not work. Fix this here.
> 
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations
      commit: 9f3814a7c06b7c7296cf8c1622078ad71820454b
[2/2] arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x carveout locations
      commit: 1a314099b7559690fe23cdf3300dfff6e830ecb1

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


