Return-Path: <linux-kernel+bounces-300178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192FA95DFE0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B384B2199B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFDC7DA9E;
	Sat, 24 Aug 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jAp40bDP"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFE56742;
	Sat, 24 Aug 2024 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529074; cv=none; b=QPaOfp+3tsbgd7+O68kHEdUefvsKzl3Vz/155R5NCDYwla9IcMkLXqYlgvOoEi+6Cof+TYOQAbhm69uB0vRbF6Htdv+K+3YsbgKeg0sBJ3Jemlbtiduu3XMxnpXPkQvlo/M5CK5LRcSbhaVx+xtIOGQG0QG8pPr6wl/fVEi/aO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529074; c=relaxed/simple;
	bh=4M13GuS1mlFm09dRwiXGRn+cU4oR5wqpWFQ7CYYROqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeO6J/BOeeRMICW+HwIDdBN4oEXEw6ZTX619L8OHBJ5iS3jzAfqth+aUybMH6/+2R0M8fa8/IIrfaqP7X3G6VZSCmcgmoeGBZCYGUV6uuOPnanOzWimq4VqXvUeY3/wfT+lLaKo8bI43dRnsNnln2ii/elKRwb8hvXubYAxPm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jAp40bDP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OJp7Gp027056;
	Sat, 24 Aug 2024 14:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724529067;
	bh=iKZ3bGGQvXM7IbHd6dt/DsmhKb4rB5gP+voTGtIjaPk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jAp40bDPZKB17Ak0XCr6A4BSbRg4P4GMIgoZioL+8T0ARc6QW4/JXCrYkdiW1n/Ol
	 5RBMQYQfKbnCLKt52x6WxdAmeKD3zI44DVsFJd7LibFU8MVDBAugxlNGDjsOgHHdRU
	 Zcx1rwjbUvLt6LDRJ4u+6PCOdVHkz61GbbE/pJqk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OJp7j1023492
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 14:51:07 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 14:51:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 14:51:06 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OJp6WE129347;
	Sat, 24 Aug 2024 14:51:06 -0500
From: Nishanth Menon <nm@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bhavya
 Kapoor <b-kapoor@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <m-chawdhry@ti.com>, <vigneshr@ti.com>,
        <sinthu.raja@ti.com>, <n-francis@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin mux for mmc1
Date: Sat, 24 Aug 2024 14:51:04 -0500
Message-ID: <172452904209.505316.16529561641969371318.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809072231.2931206-1-b-kapoor@ti.com>
References: <20240809072231.2931206-1-b-kapoor@ti.com>
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

On Fri, 09 Aug 2024 12:52:31 +0530, Bhavya Kapoor wrote:
> mmc1 is not functional and needs clock loopback so that it can
> create sampling clock from this for high speed SDIO operations.
> Thus, add clklb pin mux to get mmc1 working.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin mux for mmc1
      commit: f2a5177bb83dce16f13c9f5f8f828714e4788a8d

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


