Return-Path: <linux-kernel+bounces-540999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076DCA4B74F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17BCF188B581
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666D1DDA3C;
	Mon,  3 Mar 2025 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R306jY5z"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4564E4AEE2;
	Mon,  3 Mar 2025 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977721; cv=none; b=nYq99zYO82QLz1yTFkrk2sZYKGvfT05AT6vx7MXtnA1h65POmHBO7XBiosygbe4QpAB/TgWVrv9dZx/R9G1g9yLq6zdJDd1bjisHAXQunk6zXr1EnPC8Z10IGHjhzCiehnDQ+VVsQBEPYoEiZsbKfkKzArTXa3oqd00fti3NxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977721; c=relaxed/simple;
	bh=6E6EQ5samIoDCtRs34Bmm3hfMLT83Dz6VXpPgACj5Gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tr0Amj3tow3emQ0mFzjoz2IR5WyvFXt5sC5qoSUu/nAhiZ5Wp5go7NrvbirjPerb8jrByW00feDsxjYulasIquTtPYaqGExxo6/YEjjm9YVboERehW2D6stQjRhe6ttUjyZJd7pxYRq9yt6fm9SB80Mcr+YzvV2OMjlCNru7bnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R306jY5z; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5234tDVf2669155
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 22:55:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740977713;
	bh=TB0TPC4ZNqf5UK3o3lD2f+f8D+/BHzV1McX5c9FGRoQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=R306jY5z1XEukGO7gznMymOdUtvtV2r0v7QBtKlsPIgSkOeZfoBD1XH1xJ6nj0VPL
	 Jl9vVYm4iJWgzV/ML/TQY66xnk/1MNEiyVOLBlGuTX0Lfeuy1j/UmAI7dyhHx+aexj
	 hYpWrjFYG+9oBXCcXsc3S9JE9r50RLKhunDabFwc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5234tDbF070489
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 22:55:13 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 22:55:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 22:55:13 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5234t9eo114408;
	Sun, 2 Mar 2025 22:55:10 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH 0/2] Add bootph-all to SERDES3 for USB DFU Boot on J721E
Date: Mon, 3 Mar 2025 10:24:51 +0530
Message-ID: <174092143357.3272913.15267994610926405442.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209081738.1874749-1-s-vadapalli@ti.com>
References: <20250209081738.1874749-1-s-vadapalli@ti.com>
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

On Sun, 09 Feb 2025 13:47:31 +0530, Siddharth Vadapalli wrote:
> This series is based on linux-next tagged next-20250207.
> 
> J721E SoC supports USB DFU Boot via USB0 instance of USB. On both
> J721E-EVM - (J721E SoM + J7 Common Processor Board) and
> J721E-SK, the USB Type-C interface which is connected to USB0 via
> SERDES3 is used for USB DFU boot.
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-j721e-common-proc-board: Add boot phase tag to SERDES3
      commit: 59ac3f9f54db76f676ac5db05054586956c57e39
[2/2] arm64: dts: ti: k3-j721e-sk: Add boot phase tag to SERDES3
      commit: 871c73229bd276fbdb43c42fb3f5a25bcd8a9c85

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


