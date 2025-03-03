Return-Path: <linux-kernel+bounces-540997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23620A4B748
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82FDB169228
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817581DB12D;
	Mon,  3 Mar 2025 04:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aU07YMWu"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D151C3BEE;
	Mon,  3 Mar 2025 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977411; cv=none; b=NEcySsFKeLo1yJO6Y2p8tEZyGSfy1y6qMqoufas6gySe776dzmEjmpyU7fe6yxHM2YvWceZnufKOxbTqIY+G6lGl82pxrqxARWwZGgiqv54RUlteNONH/6d3uqvt2IWlDmCY/ckTlUOP2yVJcyxzh2Xc3P/XZRMIkG5YwFC5UlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977411; c=relaxed/simple;
	bh=gD9BLhlpgPsgj86u5qAdEKysFCS1qKGed5alryYaTrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEIR6nnag2hBlSI7YyCK3S7iFAgxdzTnSwHk2KzMTLM1kiTZwIVG3C2lFXgZ/H9aTvIHEvd1xakRsxBTlf9NuYgBt92yNdVP6WafaY+eSQxjtKw65lFw389QdKMLX7UmrHC7kBaHz8QBrOPLDpO7UHBRqSvhUZRyHoebrC6azoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aU07YMWu; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5234o3Tk2668522
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 2 Mar 2025 22:50:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740977403;
	bh=LCf0aH05fmJBzgSm7qF5p9iHCH/I78ZbgJ7w+fU2PjQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aU07YMWuuWXpDqcHH9asBKezlpX1JHUxfzPv2jIrszC6DiE/2gcR99r+squ5MyW+X
	 Q4FUaM6YhcoNXQGDXCLpE2Iyx8lc3f2uv6zJG7J3vwBvSKWeduTIxEpJ0mI5gG/uJf
	 M8GnM0XHvDvyW9bfESBf3XXZFA12JvYturxL5ioc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5234o3AD031117;
	Sun, 2 Mar 2025 22:50:03 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 22:50:02 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 22:50:02 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5234nv9D109097;
	Sun, 2 Mar 2025 22:49:58 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
        Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        Sebin
 Francis <sebin.francis@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am62*-sk: Add wkup/mcu_uart0 aliases
Date: Mon, 3 Mar 2025 10:19:55 +0530
Message-ID: <174092143358.3272913.5963413997044284059.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203-topic-am62-serial-aliases-v6-14-v1-0-f26d4124a9f1@baylibre.com>
References: <20250203-topic-am62-serial-aliases-v6-14-v1-0-f26d4124a9f1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Markus Schneider-Pargmann,

On Mon, 03 Feb 2025 10:34:09 +0100, Markus Schneider-Pargmann wrote:
> add serial aliases for wkup and mcu uart0. Add them to have the same
> order on all boards as well.
> 
> Best
> Markus
> 
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am62x-sk-common: Add serial aliases
      commit: 3e7f622685e8c3ae3adb5d905f56008c4371c660
[2/3] arm64: dts: ti: k3-am62a7-sk: Add serial alias
      commit: 5a74aef8821885e3d567f4a67bc20ecd723731e7
[3/3] arm64: dts: ti: k3-am62p5-sk: Add serial alias
      commit: 8b0f601f9869b01e2dc35c5860eb0f8ce0650be5

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


