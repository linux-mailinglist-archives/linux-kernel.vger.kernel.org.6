Return-Path: <linux-kernel+bounces-310390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08531967C20
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85DE1F218DE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2946F2F4;
	Sun,  1 Sep 2024 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ka8SNJGw"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BC545BEF
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725222633; cv=none; b=XLZoShMkHypQEpVQH6ehGsNn/nGLP3Z1c9gJyPaW5i9vLqY5BUQbKIHOxiTRoaqQ4B6vfPqXSkoAx/PSIqeO+IgZHVXZA61Nqp5GfhBDW+ua8nnFxzFzjWePvM6/Ptp9YKnoPUxUwGMmaBT2KQJKfkiEM01Plw1K5AFSWXd7zw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725222633; c=relaxed/simple;
	bh=g41yC3bEP8cqEYotlsm3ix6iioalK/xccRq7i3vK3u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qd0E5+eB88BcIoCHNWhW8W2w13Opn7YPSKe8LQOAnoz/bbNWXmAE4JXBUaQtaJ5xtyE/L8X2DKg7OMfjW2wbeKSNJdWCl+H2dqOvlG6zxIF9G5zssQv0EwaN+C4ZWDRkgV0q6EAtFJeWMU0QxfEun2w+yjOzVXbsp1moIFs9h0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ka8SNJGw; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481KUPdS014834;
	Sun, 1 Sep 2024 15:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725222625;
	bh=qrzjMNEzm6bAx70IMT5wQnV4EoRx6mzWpyvwlIFL/Ik=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ka8SNJGwjgkNsdF+bIkERz/4vQIga4Te75tWNwI/yRE0+IbKxPzoAfB/5WV41jP2J
	 Mc7vUyDV69C1L7+BtYUUcv8IQr9Clh1XM0Yt4RR+wKyHmhE57NUf+EzX9BKAsmyo84
	 znOTYiIslL4WcsikOUk4fH2UOR3oT5Bh/EANQIR8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481KUP54113855;
	Sun, 1 Sep 2024 15:30:25 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 15:30:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 15:30:24 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481KUOVF027525;
	Sun, 1 Sep 2024 15:30:24 -0500
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>,
        Kevin Hilman
	<khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 0/4] firmware: ti_sci: Introduce system suspend support
Date: Sun, 1 Sep 2024 15:30:21 -0500
Message-ID: <172522245197.999960.1404822274553467215.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829201606.1407773-1-msp@baylibre.com>
References: <20240829201606.1407773-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Markus Schneider-Pargmann,

On Thu, 29 Aug 2024 22:16:01 +0200, Markus Schneider-Pargmann wrote:
> Abstract
> ********
> 
> This series introduces necessary ti_sci driver functionality to support
> various Suspend-to-RAM modes on TI AM62 family of devices. These Low
> Power Modes include Deep Sleep and MCU Only as described in section
> "6.2.4 Power Modes" of the AM62P Technical Reference Manual [0].
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/4] firmware: ti_sci: Add support for querying the firmware caps
      commit: 371af6a83b580081d2ed76671f2184c5bb52c5b6
[2/4] firmware: ti_sci: Add system suspend and resume call
      commit: 6b48779503a6a080664e917fd91a71bd3f5ae8b5
[3/4] firmware: ti_sci: Introduce Power Management Ops
      commit: 235468957c099707d96e30d91f1885afbc7f4175
[4/4] firmware: ti_sci: add CPU latency constraint management
      commit: 458d22d2e064ded193d697b0629822dc72814933

NOTE: since all other comments are incorporated, I did hand edit patch #1 to
drop the inclusion of redundant linux/dev_printk.h which was the cause of
kernel test robot warning
https://lore.kernel.org/all/202408311026.LluPK1A2-lkp@intel.com/ )
Let me know if you disagree with the change and I can drop the series from
my branch.

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


