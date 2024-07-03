Return-Path: <linux-kernel+bounces-238864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B7792524A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789BA1C20869
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED29433A8;
	Wed,  3 Jul 2024 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rWFX+sXY"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F9224D1;
	Wed,  3 Jul 2024 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980957; cv=none; b=bLFZ8ywTeq3h71E3puvbRRtqmuU30QuPFekTyGvd/9ySlkIiQUj7ODjCEuIqgkGAFQH5cXKBc8ljL9pT0ASu9VfrBjOIHWC3/aT/fe+bsRNl+eYD9oHp2Fd0b/CnWVxdRzzQDmVtFnFT6L5sRn75eckq6I7IakpEyj/sMv40JQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980957; c=relaxed/simple;
	bh=C5AGltQh8B1VwVXkktko47M43MdQVa8BSlN6BvNlOd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mYs2i5BD2sJ2SzrvwHHwpZbigRaT5G3iOj4Ckyyt2Yu63Wybykvx5jedJ5QbVdGz78TEtHrvZaVcDm5Ugdgsv95Wp5hhixsph1bTiu3zK5c+2tNLzCxGD9lzlcrqHCEWnacYLXT4D3LCW2WudjAdFE23FEnDyGB/MTK3CfqZG6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rWFX+sXY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4634T51U060875;
	Tue, 2 Jul 2024 23:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719980945;
	bh=AJaG+XB6Czf9NI9eCE3gxv76XCu4Arj5ZtoCtzSLRbk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rWFX+sXYPUP42Xv2OSRWnx1/xhj+UIsH/aSYrsL+1NfUlbctaec11Lr+niHBPG2iB
	 /Pl29pfBwwoVbNt4GGn4rZwXmx9HKpWHG5W7vKDYrJBVaqzA26bd5SjJfC9Sa+dP3g
	 pJIoQT8SetnDyTSk/7GXH0j9KZJC5PqmRvcF5dz4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4634T5dr026311
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 23:29:05 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 23:29:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 23:29:04 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4634T0CI128512;
	Tue, 2 Jul 2024 23:29:01 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Matthias
 Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@ew.tq-group.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-tqma64xxl: relicense to GPL-2.0-only OR MIT
Date: Wed, 3 Jul 2024 09:58:55 +0530
Message-ID: <171984950179.3152309.6789420950981116192.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625110244.9881-1-matthias.schiffer@ew.tq-group.com>
References: <20240625110244.9881-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Matthias Schiffer,

On Tue, 25 Jun 2024 13:02:44 +0200, Matthias Schiffer wrote:
> MIT license was added to the AM64x SoC DTSIs in commit 6248b20e3203
> ("arm64: dts: ti: k3-am64: Add MIT license along with GPL-2.0"). Apply
> the same license change to the TQMa64xxL SoM and MBaX4XxL baseboard
> Device Trees.
> 
> The copyright year is updated to indicate the license change.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am64-tqma64xxl: relicense to GPL-2.0-only OR MIT
      commit: 60c2f9784d0ea1fad07a28c03a0576274beabdc3

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


