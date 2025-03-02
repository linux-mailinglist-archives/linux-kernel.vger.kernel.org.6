Return-Path: <linux-kernel+bounces-540525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED57CA4B1D1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946403B281D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5291E5732;
	Sun,  2 Mar 2025 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J19nTZ/L"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE661EB3D;
	Sun,  2 Mar 2025 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921482; cv=none; b=g24MyHn7kL0UFJv5/P+G+xaPLQ2gKFAC3lUBAR8k1PCuT/84sLKAIvZDO3c1MHdE5XkWZ9kVP7uhfIWQY2Jm008aifTMnlhaPuMmw1BNk6R3r6T5i4fYE8M/1brfPbJNVmX4NrwpnSfd3zr8J7UrTY2gaciNgOhqxdbCIuM+658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921482; c=relaxed/simple;
	bh=LRsY12tsT16e0J40lyCtcjwgoHGGwQ4k82T+wOXupTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sadpd5Js1vgFZ0V7YuiIFqBoOKEjvsl8f+SBO54EIYcMY/oNYBojewmv/2eq63f1HKSBXc89F7cmkJ/jqz4FBaHi0Du1ws2/g0YsAxWb+HuazyXJvbuNS0EIbxguvBqsQVfpvNh0HduxgYqcb4aI1d9UM0njn2vlHZUtoL2ZK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J19nTZ/L; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 522DHlu83080606
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 07:17:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740921467;
	bh=G5EA4gp+ZNDKprhGpH++99VsFnGY6WNQsKRBkIsPWLg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=J19nTZ/LYPJC/UEIN/OgMtRkA0ljQxonZab+z/+PX04BgDYfKGLhVWtxioh30KBXv
	 er8cw9leyhy9wdbDsq+/zk5KcK99cinR2QlLEv6PsJFLDzOht5XW3FY7NGsWxuVQWt
	 zWg3tzX3B+88L5kKdTNH4841/DKuheT++Tzzrruk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 522DHlED016487
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 07:17:47 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 07:17:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 07:17:47 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 522DHioo115614;
	Sun, 2 Mar 2025 07:17:44 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Nishanth Menon
	<nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Reserve 128MiB of global CMA
Date: Sun, 2 Mar 2025 18:47:41 +0530
Message-ID: <174092143357.3272913.16342762135985998493.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131173508.1338842-1-nm@ti.com>
References: <20250131173508.1338842-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Nishanth Menon,

On Fri, 31 Jan 2025 11:35:08 -0600, Nishanth Menon wrote:
> In the same lines of commit 9e8560556f9c ("arm64: dts: ti:
> k3-am62x-sk-common: Reserve 128MiB of global CMA"), reserve global CMA
> pool for:
> 
> LCD Display: 16MiB, HDMI (1080p): 16MiB, GPU: 16MiB, CSI2 1 1080p
> sensor: 32MiB with a 32MiB set for other peripherals and a 16MiB
> buffer.
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am625-beagleplay: Reserve 128MiB of global CMA
      commit: 47ab49247b68423c399717f2c8623e7f5d70153e

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


