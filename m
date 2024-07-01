Return-Path: <linux-kernel+bounces-236314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A051291E052
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BEC1C22508
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF0C15ECEB;
	Mon,  1 Jul 2024 13:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VOMUFvPA"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8349215A87F;
	Mon,  1 Jul 2024 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839467; cv=none; b=TljVDVskCw2bp//7kOJcqJe7imRHah/OMDPVD0ddvDnPH6n/Sf7p18y8If2e0EuKJ7Cn1hqx5o3RXa5qlpJtJQBlgxFMYVEiW699yE20WWbcub2UpWFiMezmPiZ+2KwqOX1iF+j5Uzp3Z5R/VhaOd0aChow9SCdN3kvHfK3zKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839467; c=relaxed/simple;
	bh=FuIyr5cJVkyy4ivUHpQq8SjRTBe8Hj5DYPSoV2fNhVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DE1xDN/Imrg6iHa3WL8Un8P58mUBqU00SKvJpOys+5+r5oCPWhIosclEJL9YDpqwX0kva0FoEUOqSGUSWJfDHI/MqHLkVJjADSPzwSdO25bkTCSmk7/cZ7r83jdxnvndEe9NKUx+dYLRA/vdF/f/tYHcAPJK82nU/yJIzp7DWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VOMUFvPA; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 461DAw21014721;
	Mon, 1 Jul 2024 08:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719839458;
	bh=lEQez9SmyB4tTSWUbTZtubWsey4RixNmBeiVhlXGX1k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VOMUFvPAArMgvClSRgpOA8u3uRDyxAZ58QVBKfbK5tm/eptUWGovK8Uq4Ia2WR7Zv
	 2dGG6Fp9Hin3uJZCDEMGDCPVuHOlpB6m9oYcIkf5CqNCAzcpnxuhgnASQ075p6bgaz
	 y9qzBFumv0zjylit1+akO1TKHGnj+VLS26NTJ3+k=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 461DAwuP066227
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 08:10:58 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 08:10:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 08:10:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 461DAwSt018922;
	Mon, 1 Jul 2024 08:10:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abraham I
	<kishon@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Roger Quadros <rogerq@kernel.org>
CC: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: soc: ti: Move ti,j721e-system-controller.yaml to soc/ti
Date: Mon, 1 Jul 2024 08:10:55 -0500
Message-ID: <171983945260.2331026.6584261698710579259.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240520-for-v6-11-j721e-syscon-v1-1-f57a93e12cad@kernel.org>
References: <20240520-for-v6-11-j721e-syscon-v1-1-f57a93e12cad@kernel.org>
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

On Mon, 20 May 2024 15:05:41 +0300, Roger Quadros wrote:
> soc/ti is the more appropriate location for the system controller
> device tree binding documentation so move there.
> 
> Update Kishon's email address to a working one.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] dt-bindings: soc: ti: Move ti,j721e-system-controller.yaml to soc/ti
      commit: b87a1cbb3385a806f8abfd9b8a2191e4c6620347

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


