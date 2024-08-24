Return-Path: <linux-kernel+bounces-300175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40B995DFD9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CBC2817D9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AF87DA84;
	Sat, 24 Aug 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="klBdvThk"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E445680;
	Sat, 24 Aug 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529011; cv=none; b=GjJbdHFlyCiSjPbVtYSFGFgQTFPeURxmusRxH0tZshdS8zaqcznvkmM6esl5BSA3InK1uA4syaiN/t2CJ2nkRqrOYSdIzOTn1xJOYI4xrQX86qRqFwnHEM0VzDYvGuLVSSyFJpvhtlgzT2Vt00sF/SI5ojbtvX8rPklkcApiTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529011; c=relaxed/simple;
	bh=Zgr/I6oAK/0OXMdTguWex9m/XdbX4Kq2w8aNmeSJTSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+wXJtD3q1t+p5yTe78u3MVF5CpztB9oHxKyLrlPbVHD3Xr7Y/cIcQuZmkUhHaPeoOU6sIU8m0ztCtjWj/fWzJBj4Q7H7mFcodvP1unXczNyhrd8FLjMeGZnYbmxHdXdQUBZHNcNBZ7k5+b/yIEavkLjBKXX6BBIW3UD7OI44nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=klBdvThk; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OJo2nr059766;
	Sat, 24 Aug 2024 14:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724529002;
	bh=ltY4sVhDF/U5ZBZUycDa5E/1qdCXSqchlLKOBekzano=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=klBdvThkTs9TnONAjkuZqKF2tQWL9DuZmgDVLkZSpZvtpZtdzj73lK+knvzjODkQZ
	 Qf1amotz58p1T+8z6oWn2vmvgZK6v27uBSmPX31ulc07dYLolRs4KEDZyMAWnU++bO
	 KXblVIOXhAgk7qf9/xeMIGaz5U/FQsSTvJPO7Scg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OJo1sj022792
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 14:50:02 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 14:50:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 14:50:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OJo1sY128337;
	Sat, 24 Aug 2024 14:50:01 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
CC: Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Use 4 lanes for PCIe0 on EVM
Date: Sat, 24 Aug 2024 14:49:58 -0500
Message-ID: <172452898744.505151.13187313393399728928.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720110455.3043327-1-s-vadapalli@ti.com>
References: <20240720110455.3043327-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Siddharth Vadapalli,

On Sat, 20 Jul 2024 16:34:55 +0530, Siddharth Vadapalli wrote:
> The PCIe0 instance of the PCIe controller on J784S4 SoC supports up to 4
> lanes. Additionally, all 4 lanes of PCIe0 can be utilized on J784S4-EVM
> via SERDES1. Since SERDES1 is not being used by any peripheral apart
> from PCIe0, use all 4 lanes of SERDES1 for PCIe0.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-evm: Use 4 lanes for PCIe0 on EVM
      commit: ba7b9e8408ab866aa0b3c88e406b8934782402d7

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


