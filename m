Return-Path: <linux-kernel+bounces-212882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B2D9067C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44923B24CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A6E13DDA5;
	Thu, 13 Jun 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dqlHz6ak"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABCB13D53E;
	Thu, 13 Jun 2024 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268607; cv=none; b=c2m8jZ5Zy9aX2smjxZHoj3QPHMwgxro5ROPE7uWm4SsQpblCTN7CnQgQVsfMivoNtG5G6YWdawz+YT/ZNNUq5r5DRS7AYiZdB8IMX+DUKAaXQKYN7dH8Rpg3Z/29WFIxNRAGNl4SlL9bwkzsxVXD9+fOOAAD8Ahi+e1Rs1AKC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268607; c=relaxed/simple;
	bh=H08dtzpcV6vh+UEjTegBQqh3P6JlbqWb9sXQeK2PSU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DS/dESjPGhumdaauonZW91RYB7tdvtpPA1hTCAxrKVzPowxThAdLXveK0149I7AQUXcPQhnk9ti2rbhfM7MsOrW2VjIzzz9X65QZE9ewrM1HqCZTThVMfUaLJjyfPNeOVtai8nSnoawmedNpEtWl1iIEQGuBwfADNzNR6a1XNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dqlHz6ak; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8noH6105424;
	Thu, 13 Jun 2024 03:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718268591;
	bh=WLa2Qq6Zg/X0YE7uwzuclfCHM6AmiqShLiqT1n/tRNg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dqlHz6akXLlN8o5p9dQC78rYMQwMcWbxQCgDuG6JP9u2cB/tAypgzhmghB/6ziIJx
	 lr8UgdHO5xdPlQo+MKK5go0uw2IIrH4nqhphN50/MAMhMX23hJe7nXdkYr4U00Jvb1
	 UDKWvSNk6FRl/qWXh9+7piPjU5KF7TypYbJ7gJX0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8nor4092165
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:49:50 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:49:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:49:50 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8nkEP088934;
	Thu, 13 Jun 2024 03:49:47 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <s-k6@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH] arm64: boot: dts: ti: k3-*: Add memory node to bootloader stage
Date: Thu, 13 Jun 2024 14:19:44 +0530
Message-ID: <171826022271.240984.16412947163722025506.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240506110203.3230255-1-n-francis@ti.com>
References: <20240506110203.3230255-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha Malcom Francis,

On Mon, 06 May 2024 16:32:03 +0530, Neha Malcom Francis wrote:
> Add the bootph-all property to the memory node so that it can be
> accessed by FDT functions at bootloader stage.
> 
> The bootloader requires the memory node to be able to initialize and set
> the size of the DRAM banks. For this purpose, make sure all memory nodes
> are present and standardized, and modify them if not.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: boot: dts: ti: k3-*: Add memory node to bootloader stage
      commit: 12a29fb4f9a0597ad598f2c986c8e2509a62b6ff

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


