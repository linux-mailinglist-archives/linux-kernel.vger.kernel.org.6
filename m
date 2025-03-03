Return-Path: <linux-kernel+bounces-541000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F41A4B751
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABCF07A5C3F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808F71DE2DE;
	Mon,  3 Mar 2025 04:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jgHXzBJK"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB61D6DDC;
	Mon,  3 Mar 2025 04:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977739; cv=none; b=XDtzloMY0XzgSj47Tyel5L7eeVzCx9Ou0kYVZS43MLLrjXy/yaT3DfUv0T0Hl3QmUhLwiBlQg7Kzpw1k6cOrLcpChanoOxUEo7mhceZ6fxRu9rDaqduo5U41e+brWArMUe6OOLYIwFCFdWolVs+OOUT2f+Z9oXNDohjl1pxxuYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977739; c=relaxed/simple;
	bh=gRjsfRvzXQlLZ/ILSIPispCJB03i6h0dYn1gJ6KfLgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXU/YW6RWYoNu5m2A3NBW+u9MmfJ9zD9KpgMR44tszU+H+lHBJrpaM/lAtqpdP9+6X6Eer0NFOfA8PnBdwEQYpXZ08s9bmuztGScIkBbqDQetzqWdMczdHeaGyc89+E2jmkshavk/4FJhoeiPAg9fWGFNR5HeKTGr7kxaANIKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jgHXzBJK; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5234tWAe2669163
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 22:55:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740977732;
	bh=0gwfcLNFYkPRO9tV7WcTDZSJlvkg+gjxEny4VFBgD4Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jgHXzBJKmr4qTo30v7HPt+0fJMg9adTzQVIVgtGVyCwALwcF7/gOzH/j8jURr5XxS
	 N29bZSqWTKyKsBXkpgQk8mgtq3R7H6hAl08ba+UiwQJgPpXe2Qpx/ZRBQhNodjP27E
	 bq689XgrrWU2cqGjAgc+9sHr88HAUC8RJZXcGzlE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5234tWgd070617
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 22:55:32 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 22:55:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 22:55:32 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5234tSoS063226;
	Sun, 2 Mar 2025 22:55:29 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH 0/2] Add boot phase tag to USB0 on AM62A7-SK and AM62P5-SK
Date: Mon, 3 Mar 2025 10:25:21 +0530
Message-ID: <174092143354.3272913.1834909531649290105.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122124223.1118789-1-s-vadapalli@ti.com>
References: <20250122124223.1118789-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Siddharth Vadapalli,

On Wed, 22 Jan 2025 18:11:47 +0530, Siddharth Vadapalli wrote:
> This series adds the boot phase tag "bootph-all" to the device-tree node
> for USB0 on AM62A7-SK and AM62P5-SK boards. USB0 instance of USB on the
> AM62Ax and AM62Px SoCs which the aforementioned boards are based on, can
> be used for USB DFU boot. Since USB0 has to be enabled at all stages of
> the boot process when booting via USB DFU, the "bootph-all" tag is added
> in the USB0 node of the respective board files.
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am62a7-sk: Add boot phase tag for USB0
      commit: e7ee00e314da736b00ebb26405f8e2cab84cfa22
[2/2] arm64: dts: ti: k3-am62p5-sk: Add boot phase tag for USB0
      commit: 732c4cffe463f222f7f694d469d1f730f4a3adab

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


