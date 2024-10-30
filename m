Return-Path: <linux-kernel+bounces-388117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCB89B5AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213931F24BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D17195803;
	Wed, 30 Oct 2024 04:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iKKFJFPK"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA49374F1;
	Wed, 30 Oct 2024 04:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263837; cv=none; b=Qk+emSSqRsARHa0GVI1jXRuL+J3X1IWYQpAUeU7DkSe7VhhtVdOG4ozGnNKclqKAtMffv+TGo8/d7M/1s3R4cishN87y6L1NhFrqtJ7DYhLDlweNwHBwhUdb3dqLQ6eMtujfE/6k1J7fKaFF70VjVvprobAdL87CYplzbdCw3xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263837; c=relaxed/simple;
	bh=ppXvsVXeA+nKRwqNQXHi3APPbvVXYRDjvNHhtvxdRhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M34TdCmqf1cjNFFO5aHKFX4lxSbSaWYB52OizSqtI+Hr91Rjkt8CtEiaO8PK0DXz9Qnfs7EbQQYhXKFMcys/JjDzut/FcWptVgzG2k4ETFX2v5EoG1MRocxbK0tEOrgvoCEOjJ2dUr5sWWsMrFhvdhtnIMNmDgpIsPyiDQz5Hog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iKKFJFPK; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49U4oLXR059213;
	Tue, 29 Oct 2024 23:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730263821;
	bh=YmeylMQuOayChRfW0IDabRowok9NC3hm9gjKzsrLg44=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iKKFJFPKNgg+ClxApux7NwKL2cElGwNjvGliBMUhs98FRnCEXGes1SfXe2lrEuo03
	 QL5Yn+tnZOCPTdnpTwwYxD6/RtJnooE9WaJBJUR1itZZ9Z1o1vpe67kjPuwcA0PYjr
	 vZE0+BnULwDQilzi90P3hRxr6pb8yRCwKK4r89gw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4oLEH084473;
	Tue, 29 Oct 2024 23:50:21 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 23:50:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 23:50:20 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4oG3q002974;
	Tue, 29 Oct 2024 23:50:17 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        Wadim Egorov
	<w.egorov@phytec.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <d.schultz@phytec.de>, <nm@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62-phycore-som: Add M4F remoteproc nodes
Date: Wed, 30 Oct 2024 10:20:13 +0530
Message-ID: <173021674669.3859929.16997677774746918158.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240911124251.702590-1-w.egorov@phytec.de>
References: <20240911124251.702590-1-w.egorov@phytec.de>
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

On Wed, 11 Sep 2024 14:42:49 +0200, Wadim Egorov wrote:
> The AM62x SoCs of the TI K3 family have a Cortex M4F core in the MCU
> domain. This core can be used by non safety applications as a remote
> processor. When used as a remote processor with virtio/rpmessage IPC,
> two carveout reserved memory nodes are needed. The first region is used
> as a DMA pool for the rproc device, and the second region will furnish
> the static carveout regions for the firmware memory.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am62-phycore-som: Add M4F remoteproc nodes
      commit: 703545f04465134e41654dd32c583af424c0ba54
[2/3] arm64: dts: ti: k3-am64-phycore-som: Add M4F remoteproc nodes
      commit: a13f11477e5bf249e67b9a147a6ec88667ab459a
[3/3] arm: arm64: dts: ti: k3-am642-phyboard-electra-rdk: Enable trickle charger
      commit: 62898d47a6265b5e37a7e253067230f05c0a3165

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


