Return-Path: <linux-kernel+bounces-305570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97F39630A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6798F287528
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B721AB535;
	Wed, 28 Aug 2024 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pwinlqxM"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D21993AF;
	Wed, 28 Aug 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871729; cv=none; b=K888Ij/LHw50wl9s6/DwW8jcsZ7/7VXLwYniFUnjcg42fhzu1+CyE7xy9NS//ltqtOFK3bMdC2b0pg69RI6YEVkT5isFS5swy3W750uBPxthQJJpXvnQkjqh7idjI7hcLcIBxUx56AvolM911sfw+WYBU81VvcFQSrF3SbJoRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871729; c=relaxed/simple;
	bh=s1iL0EKjIjaAXnnu8eTYshpWZ+dr32MPHL1rufb7uNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7Lv6RJdb3H/Lqtb9cLvnTpvq18A5ghZ5bHQAj3dKGaDba/ncWWVUYObuNlZZ8El92vTTePnVB9GKnAwRz5Is/8qWHRnx4NA5fLeIrPpkJkN7O0fVkkcuBJKYpO/r48wq47gpzPSWue+risAhHjNV1eKejwnQgjmsXUcU+WvgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pwinlqxM; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SJ22KI094030;
	Wed, 28 Aug 2024 14:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724871722;
	bh=2L2++9j+E+6H5IMkyDUrsG0SB8UEcgLzgOpNN3UaNw8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pwinlqxMyviRq8EdgadwGH/51Q5lpZFGGPxSPZ05CdJJf1XIabRGZO7u8nbbk5Nt6
	 y2JHUyUUtZAQ3Ho6wvRiqVybWBeLTfUQHJ0CdDe/NerTkNa0HrT9hC4mMvSYXMaxu3
	 W/CSF1G1Ydb8wM7wjcVIMr3xMCWJkNBpi93PByts=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SJ22IU021825
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 14:02:02 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 14:02:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 14:02:02 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SJ22PL057668;
	Wed, 28 Aug 2024 14:02:02 -0500
From: Nishanth Menon <nm@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bhavya
 Kapoor <b-kapoor@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <jm@ti.com>, <vigneshr@ti.com>
Subject: Re: [PATCH v2 0/2] Add support for multiple can instances as well as describe main_uart5
Date: Wed, 28 Aug 2024 14:02:00 -0500
Message-ID: <172487168711.3443156.17556165846774517423.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827105644.575862-1-b-kapoor@ti.com>
References: <20240827105644.575862-1-b-kapoor@ti.com>
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

On Tue, 27 Aug 2024 16:26:42 +0530, Bhavya Kapoor wrote:
> This series adds support for multiple can instances present on J722S
> EVM as well as describe the main_uart5 for J722S EVM.
> 
> CAN instances 0 and 1 in the mcu domain and 0 in the main domain are
> brought on the evm through headers J5, J8 and J10 respectively. Thus,
> add their respective transceiver's 0, 1 and 2 dt nodes as well as
> add the required pinmux to add support for these CAN instances.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j722s-evm: Add support for multiple CAN instances
      commit: 46ca5c7207703b36025228a6b7a29198a1539d10
[2/2] arm64: dts: ti: k3-j722s-evm: Describe main_uart5
      commit: 010b035ab4d7a1c4fd13936f42eef857ddbeede7

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


