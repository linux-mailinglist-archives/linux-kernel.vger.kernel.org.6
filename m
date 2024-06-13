Return-Path: <linux-kernel+bounces-212626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ED290640A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D96283CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB1136E0F;
	Thu, 13 Jun 2024 06:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gcn2HZfj"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45A9136997
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260154; cv=none; b=FyH/qv/DG4JAxpZPaJI25EqxsFz2QPy+mRBClNKBWdLfzVKgyfvzai7Ia2XIuYHP4bC7MgRpWmsl+rC3s/m6Zvrt+I+zlna8u+qWnLP8n7TdFgCPTCe/JQuwsy5/By13UBN6aObo3bAdKN9aL1zAnJ5FEiymp/7XJQwQLa+HEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260154; c=relaxed/simple;
	bh=L+ZyfYUB/49H7fqqpagn1m4EnCL7bSRVJgQl6qRA0YI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oX5Ta7kRt2epz19bUgEzxvH1LT65uXk1xHsY9KzPv4xwEXSpKI5iCYiRNwG7QufPV+u0XqgiyUBnesSHn9ZIi5kGKnPU14MAiaf7QuLVCct+LiXAaH4fSQoHMv9BY4mCAGnbg9oL20mIot9NfvZQdi0Xkr7emkCzmvE7t1BjmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gcn2HZfj; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D6SkiX109449;
	Thu, 13 Jun 2024 01:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718260126;
	bh=WlUt1b7V47ynFIY0d9uZYsE+QP4W5MiWYbktde2sSqE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gcn2HZfjiMTrkQD03Lk5WK7Vl04pphCuJqNLJ5rvD7G6lQsUeWH6pynasfwh28RCN
	 ZbzGJC4GOfavUhlekcejG5+zzPAFqeMBQNyBM4NkOK8BHHxdgU3MwRCrIfLyl5kKlF
	 PIxyBoDPR3TpyGVr9odD3bto5kwbT+QDnYHkAoFE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D6Skrh017379
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 01:28:46 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 01:28:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 01:28:46 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D6SeYb002306;
	Thu, 13 Jun 2024 01:28:41 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <will@kernel.org>, <catalin.marinas@arm.com>,
        Vaishnav Achath
	<vaishnav.a@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <m.szyprowski@samsung.com>,
        <arnd@arndb.de>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>,
        <quic_bjorande@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nfraprado@collabora.com>,
        <u-kumar1@ti.com>, <nm@ti.com>
Subject: Re: [PATCH] arm64: defconfig: Enable MTD support for Hyperbus
Date: Thu, 13 Jun 2024 11:58:33 +0530
Message-ID: <171826009025.225208.12911943453800317987.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611115820.1269805-1-vaishnav.a@ti.com>
References: <20240611115820.1269805-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vaishnav Achath,

On Tue, 11 Jun 2024 17:28:20 +0530, Vaishnav Achath wrote:
> TI Jacinto 7 SoCs (J721E, J7200) have Hyperbus controllers present
> which can be used to interface with Hyperflash and HyperRAM storage
> devices. Enable the necessary configs for Hyperbus support within
> the MTD subsystem and the specific Hyperbus controller as module.
> 
> 

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[1/1] arm64: defconfig: Enable MTD support for Hyperbus
      commit: 74aa5704cf194441001f16dfd4d5d90f4d3bf413

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


