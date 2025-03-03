Return-Path: <linux-kernel+bounces-541001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C95DA4B753
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF89188B786
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0F71E3762;
	Mon,  3 Mar 2025 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ODHfIIRl"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97051D6DDC;
	Mon,  3 Mar 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977743; cv=none; b=MZZZEmltHUtpZmmmgCGsCoHaydOzgAjEwvxHieiF4BymEmHjt0kRj3pqTNJuRrdANMwPC2yNFH4DkVaWkM6O1kYp7D5GsrtXC21k8F1N0SC16/h84jO+1XXrb8M8USSf1qmzmaMOn0jtcgfzdxkwXHEX5Z4/nMvNQWcAb8Lg/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977743; c=relaxed/simple;
	bh=ypcOWtyf+HfQuyVp+UfGbc31+EN4Qh29nRpPInN+scs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixItTsYQtXXDx9uDTBAgi9buw63mVycOLahPJoBLvmVsbG95zoSSv+vK61WyVdR8PNLJT0yvDXHBK8c+WNKq2SapDXXvgAGFmv3L6YDBLrczL3YBRk6SIfAFA86+/ueLJsGDJtnZLTGeSKKMQaSi9MwGGb/V6xGIyBCAYF0+1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ODHfIIRl; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5234tba33209336
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 22:55:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740977737;
	bh=x0aYExE+fmXOum0ucByrnNGU4z/laft84m3pfF3bsHQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ODHfIIRlmJKJDqBLvdc6azxzq3o5WiP4VSaliChWdDsdaVqORqShW9IkL2Kjq5JyS
	 CqGsa7AZ5rlStw91uZhZK/EX1bfFshGd13AKI5W1H5q/lVT1QdP7BNfIy1UoBibRAG
	 vEvF68mnNuo53rnk40KETjrzXX6yhJPfndvjbReA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5234tbHb129160
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 22:55:37 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 22:55:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 22:55:36 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5234tSoT063226;
	Sun, 2 Mar 2025 22:55:33 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p5-sk: Support SoC wakeup using USB1 wakeup
Date: Mon, 3 Mar 2025 10:25:22 +0530
Message-ID: <174092143358.3272913.4362724493070822448.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130062550.1554651-1-s-vadapalli@ti.com>
References: <20250130062550.1554651-1-s-vadapalli@ti.com>
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

On Thu, 30 Jan 2025 11:55:47 +0530, Siddharth Vadapalli wrote:
> After the SoC has entered the Deep Sleep mode, USB1 can be used to wakeup
> the SoC based on USB events triggered by USB devices. This requires that
> the pin corresponding to the Type-A connector remains pulled up even after
> the SoC has entered the Deep Sleep mode. Hence, enable Deep Sleep pullup /
> pulldown selection for the USB1_DRVBUS pin and set its Deep Sleep state to
> PULL_UP.
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62p5-sk: Support SoC wakeup using USB1 wakeup
      commit: 115290c112952db27009668aa7ae2f29920704f0

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


