Return-Path: <linux-kernel+bounces-224980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A24912986
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8881F238CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA876F2F0;
	Fri, 21 Jun 2024 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dRuE8Jiq"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF65CDE9;
	Fri, 21 Jun 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983450; cv=none; b=VgbNAQOKo9mAXzzPrOevZ4czxYpVrm+NhnH36nNdlH0qmG2SL0+yVEg9p2Va29CaRqvLhGd4csnHcWi+RGHxzCgozDgGCPqEBGixSAyVe6U/IhjOdq/ViohdkS7jwVLoC33Yvvs/JfGt4Jg8l7Z76L3XSyxXddeLU/Id/rBZLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983450; c=relaxed/simple;
	bh=vmGPQ/nGhuUSDMAHeSfDoAofA9bUXkDZKgTZ5Nm88IM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvL9qzmEbyk0ZeiHzoBZkQBqx3C8JOOhNcDE65iXDxXSaMlP8tT87xx93wZ1D7VG3VXEFXyAhBY3sH3C8K4mp5MvPTPIwOOpYTjFFpo90+iLgi6SASBjBNpKfdBFRDl6698vetEPP+uaCN56Q2CSljh4g9+zp+59CYfsy+LSiO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dRuE8Jiq; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45LFNx7b081622;
	Fri, 21 Jun 2024 10:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718983439;
	bh=PKbOMgWFMOAROfionESq/dKnFk1fBHFBELlmG6LkIG8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dRuE8JiqKNCrnQyvJcF0O7751mjK0nCe3S14cSklrliLsqWNiwbVmEob6J/JROI8n
	 aLWChHToeEd0TwBpBA8Hdo1N72u/oZGYory12BA5fybUFEOJV/Vc70avjfAJXrV00E
	 xX3rsuURi8TJanSs0Eq7m7fe96IUYY772DQVFcBs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45LFNx5X044523
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Jun 2024 10:23:59 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 21
 Jun 2024 10:23:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 21 Jun 2024 10:23:59 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45LFNtA7097663;
	Fri, 21 Jun 2024 10:23:56 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Nathan Morrisson <nmorrisson@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
Subject: Re: [PATCH v4 0/2] Add PCIe overlay for am642-phyboard-electra
Date: Fri, 21 Jun 2024 20:53:53 +0530
Message-ID: <171898028150.2272421.11282073369892997083.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613195012.1925920-1-nmorrisson@phytec.com>
References: <20240613195012.1925920-1-nmorrisson@phytec.com>
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

On Thu, 13 Jun 2024 12:50:10 -0700, Nathan Morrisson wrote:
> Remove PCIe pinmuxing from the am642-phyboard-electra device tree and
> provide an overlay to mux and enable PCIe.
> 
> v4:
>   - Add explanation for disabling usb3 to commit message
> 
> v3:
>   - Fix typo from .dtbs to -dtbs in Makefile for overlay testing
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
      commit: 927718d246fcf14b2b642691936f2abe2e80917e
[2/2] arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe
      commit: e9bb631b3eb41309063fd8ad804a3935665009a4

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


