Return-Path: <linux-kernel+bounces-550902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD316A5658B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F76176B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2E220E33F;
	Fri,  7 Mar 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RgBVVqVg"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8A20D507;
	Fri,  7 Mar 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343820; cv=none; b=WusjKWGQRWjPwgfEMRTPxk9aXsQ58vt3e6zzrd19zsU67Mk0nOHRRPGCMcSJw9ukfIVUnwp0PDSKQZyr0M5J2bQt39XAIj5D6BQ6BEiwlpwRiFa0QQEIgYOJRFatXFDowXyIMnS+TEsQ+rWcJhTCUOLE5aXG4yr/jLagh/T2ZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343820; c=relaxed/simple;
	bh=NxGKOzJhH0syB/5UESiHYjZElY5LVqIHIR57niTMWic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t25TGWDLuyTUWUNFeAelsqqjJNyak7teyWhM620Qd+BfYeHjuhmheSSbfwICJyrr6cOeKaOaTpr5RyMHtBInrdFWznZMSBQrIqpEgeRwm0VBuN6zk8v3hdXR7MJcoqbQxUxcwgM7/BVsKDhRPkTQb18NfM/KBo5VubmhrpGaWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RgBVVqVg; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 527AakJR3942632
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 7 Mar 2025 04:36:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741343806;
	bh=/q/4BzWAkO+zh9PIsVSkrHOjIySSifAyOimM8ksoJNM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RgBVVqVgcvK/Nii3mcdbyFJ86WQJZs6WZZYiHykmh9RuaLfH5KWoOJfnclNADCM1N
	 U9OsSZbW6sHY3XqqpmKmsjpg3atje4+Of5hv3/XPAi8VbMpVv0bKHRkJz6pFP7PE4B
	 awZQ4hsP7p6RCupDTlppHCeKxmsoN2NexubF5v68=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527AakT9029556;
	Fri, 7 Mar 2025 04:36:46 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 04:36:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 04:36:45 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 527Aaf28021789;
	Fri, 7 Mar 2025 04:36:42 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Wadim Egorov <w.egorov@phytec.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH v2 1/5] arm64: dts: ti: k3-am62x-phyboard-lyra: Add boot phase tags
Date: Fri, 7 Mar 2025 16:06:36 +0530
Message-ID: <174133309362.1072814.1438889304366712802.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305085537.3976579-1-w.egorov@phytec.de>
References: <20250305085537.3976579-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Wadim Egorov,

On Wed, 05 Mar 2025 09:55:33 +0100, Wadim Egorov wrote:
> The bootph-all and bootph-pre-ram tags were introduced in dt-schema
> (dtschema/schemas/bootph.yaml) to define node usage across different
> boot phases.
> 
> Add boot phase tags to all required nodes to ensure boot support from
> all sources, including UART, USB (DFU), Ethernet, uSD card, eMMC, and
> OSPI NOR Flash.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-am62x-phyboard-lyra: Add boot phase tags
      commit: c2d18ec0ea4ce9d6d8be5a1a9b266f57a40b5e24
[2/5] arm64: dts: ti: k3-am62a-phycore-som: Add boot phase tags
      commit: a5965ee0107a37ca4c73f05f06f55dad759572d2
[3/5] arm64: dts: ti: k3-am642-phyboard-electra: Add boot phase tags
      commit: a9c8485cd13cdffee5bdcda6b625f678900994c4
[4/5] arm64: dts: ti: k3-am642-phyboard-electra: Reorder properties per DTS coding style
      commit: 61a12b5a9923e4beec5595fed3b9c3d5c0c25c32
[5/5] arm64: dts: ti: k3-am62a-phycore-som: Reorder properties per DTS coding style
      commit: a89d3f47b09c793d0454350739ee8695ff30fb5c

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


