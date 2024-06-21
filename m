Return-Path: <linux-kernel+bounces-224978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A51912983
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D8A282978
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809B74413;
	Fri, 21 Jun 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rd/xkAHs"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE957CA7;
	Fri, 21 Jun 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983433; cv=none; b=ameoITLKV56DEDrSJ79bd19bfr0LOcFgALF5AH+9t4AWi6oY8RrxYMzDp0APPNkngjjhgktkyS1wQ/ukg7Z5GYcisNdfVEK+jwROY5DGaZ8OjauMJY0luK/gVQPehUhMLHZfPRnDfia1ae92f4JDOnM7PzDW55Ulbg1LnktSOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983433; c=relaxed/simple;
	bh=Q+xmARk2gmWy+xi8lwX1HreTsVtyXA4cJ2V9Ld478Wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYGDqKlEVafQa3Mp6AQ0ZtBAmBX7AuGOAFpbDveTaAVdueyJ3kNfQg+8WFKidWHek0sDSBnvySuVqYR6Zl1zg+sRf3vWuZhHCZeQGUD+M3RYEngtLuHUfepnCFxWblscjExdbmvBBmWr4tpR/rUzA5ehK9jyp6H4ERfG3AqiOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rd/xkAHs; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LFNgmb074653;
	Fri, 21 Jun 2024 10:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718983422;
	bh=9f94b/D8ANRqhat16jWrutUQv6VRYGl/PLuwcC9ivQY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rd/xkAHsJ1ob8oeziqBg/pohLj7vDI+US/QGOtmvzUOnLcPp+GEwaxaSTuzXsQHee
	 fIjE+WE/LQhnGNDPD9wZyugx+LqFP5H89yMnoLOpviOVGWWLlZm87jmpDHpUR/LsdG
	 rABWgxGI5AODle3Ee9OcT2TxNZSeU9q9c7nRq1Vk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LFNgUW021160
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 10:23:42 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 10:23:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 10:23:42 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LFNcVj097459;
	Fri, 21 Jun 2024 10:23:38 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Nathan Morrisson <nmorrisson@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
Subject: Re: [PATCH v3 0/4] Add overlays to disable optional hardware in k3-am6xx-phycore-som boards
Date: Fri, 21 Jun 2024 20:53:35 +0530
Message-ID: <171898028154.2272421.5900858100796814907.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613230759.1984966-1-nmorrisson@phytec.com>
References: <20240613230759.1984966-1-nmorrisson@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nathan Morrisson,

On Thu, 13 Jun 2024 16:07:55 -0700, Nathan Morrisson wrote:
> Add three overlays to disable the eth phy, rtc, and spi nor. These
> overlays will be used to disable device tree nodes for components
> that are optionally not populated.
> 
> v3:
>   - Explain the logic behind adding the overlays in commit messages
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
      commit: 1fc3858a906bf3e8c48a14587106bb61c2f8d7c5
[2/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
      commit: 1322b1796d7143dfa75e10e036c6099927ef510d
[3/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
      commit: a0b552605f8c588fdd9ea062886fb90d50534a8d
[4/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable spi nor
      commit: 9a32378884931d8f66d0d7122873156199fa422f

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


