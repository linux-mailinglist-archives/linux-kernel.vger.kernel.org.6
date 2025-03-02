Return-Path: <linux-kernel+bounces-540531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC92A4B1DF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C145C188B800
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4961E5B72;
	Sun,  2 Mar 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OkxPTu6t"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A51DF735;
	Sun,  2 Mar 2025 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921624; cv=none; b=LXipKTn3Z142qTxP1olwi8J/AlNUDC0xtRma5Qqheuzhd46io43EYZuLNXW86OhVMhoDcu+FmoyarVDkv+/ERf4nmnHOij7siSZQEVely7ahP9UroNHT5lxZRbdJr5/x9z04Xk94W8AYqSoPtSo20UuvChzx0QmNRrRHJAIJEaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921624; c=relaxed/simple;
	bh=MbrAI8ryJL2Y9GIh11b4shqFAAM+wfSr1oQ3Y9pf6aY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dqm2wHNUkHQOEM/UtX8fEgz1Lvuh2yvhTtu245mYqTGKUhi5DM20RYZVlMT92op/bc+k2mLlZoRi3I8YvNB8IYyrW/uxBLjfxKmIr3ZTSPU63p9UMogb13MnE4BMgnpmzOqwzoIeO0FH1B2mwAdDYZiE7L8aP3KmUrDYMTWm6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OkxPTu6t; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 522DKHsA3080908
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 07:20:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740921617;
	bh=M7Ic2jgTdH4ygRKl2McVhlZtpvDMbBW9NScFRGUlOiI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OkxPTu6tZVyoygy0n/cms/SXAky6tGtgGeh3po2r+1IclK8ZhuplsyvXqssCcTNZO
	 Ckw0IDLD9ffH6rcxEC8TRtIKeBUKlWpw/h6zsCaxAunNrpbYozTTOaBAiPsz6qn3c9
	 anMwsXQCbGtpJW54lJARPxMyod71KrZ/hbY9H4/c=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 522DKHZ1018156
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 07:20:17 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 07:20:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 07:20:17 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 522DKEsO117888;
	Sun, 2 Mar 2025 07:20:14 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sai Sree
 Kartheek Adivi <s-adivi@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a-mcu: enable mcu domain pinmux
Date: Sun, 2 Mar 2025 18:50:12 +0530
Message-ID: <174092143352.3272913.2726139010475904694.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120075442.181191-1-s-adivi@ti.com>
References: <20250120075442.181191-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Sai Sree Kartheek Adivi,

On Mon, 20 Jan 2025 13:24:42 +0530, Sai Sree Kartheek Adivi wrote:
> Enable mcu domain pinmux by default to be able to access mcu domain
> peripherals from main domain.
> 
> This also makes it consistent with the rest of the k3 platforms where
> mcu domain pinmux is enabled by default.
> 
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a-mcu: enable mcu domain pinmux
      commit: 9e999a702701b621be7427a6f2cc29bd04defa7f

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


