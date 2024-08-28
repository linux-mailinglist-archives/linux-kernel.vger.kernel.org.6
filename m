Return-Path: <linux-kernel+bounces-305572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EE9630AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6523FB20C94
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC681AB532;
	Wed, 28 Aug 2024 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P7J1wL1o"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40231D696;
	Wed, 28 Aug 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871882; cv=none; b=BKFsf5FqeslqsHvS24PwkbsyUODMe910xuvvRyLh2870I1JoOHO4CwHyw4FUMabkjRatREaORfBrztW0/sXQKD5tqhDgQjZF1yEHxkaDXvSsSQXfJC+XrXl5uKM9dz9z8487cPtjEtil27aOkkO812dDgV1Cw+Pcju00tt8gEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871882; c=relaxed/simple;
	bh=2PbMUHDVGW2h2OsCN+ZdmA+kAdqhvNBQiOnzfvvguRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAyoBuid1jDJfwA761O4NMXGOBekDfkhPDQrEJ7ZYJK+iIkedIPhIqmErY6198V6WORl65Txiz4kTfrahMjajE81dqkuk8TXSMYZ1D3tTWFBErLRs2i4Ij+hv45cec1+EsyPgJwFgn/3p126lk2cOXfUdociIEQvhzCDD0T2EYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P7J1wL1o; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SJ4VZG054856;
	Wed, 28 Aug 2024 14:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724871871;
	bh=keod4O1+yAxg+zkJuMNaiR40evVQhpWT7LOuKFUl74c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=P7J1wL1oqbJOatBfVBUpLy9nSghmMvvZAL7OSGvZllt4VzL5L6TX/hCoSSP43DSqv
	 7GKQN56YhXKu+IxnYcf4wAlDuKh04slpSSb0TY1RM34CzZmtI2RrE8/jgaBGZjt9VW
	 ZMv7QcBu8Tn5bwHDei3Z6IyeGwfp/ukB8RjX8/Pw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SJ4VLo018111
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 14:04:31 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 14:04:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 14:04:30 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SJ4UT9066055;
	Wed, 28 Aug 2024 14:04:30 -0500
From: Nishanth Menon <nm@ti.com>
To: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
        Devarsh Thakkar
	<devarsht@ti.com>
CC: Nishanth Menon <nm@ti.com>, <s-jain1@ti.com>, <r-donadkar@ti.com>,
        <praneeth@ti.com>
Subject: Re: [PATCH 0/2] Enable E5010 JPEG encoder
Date: Wed, 28 Aug 2024 14:04:28 -0500
Message-ID: <172487179147.3443633.3959874500764738240.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826162250.380005-1-devarsht@ti.com>
References: <20240826162250.380005-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Devarsh Thakkar,

On Mon, 26 Aug 2024 21:52:48 +0530, Devarsh Thakkar wrote:
> This series adds support for E5010 JPEG encoder device-tree node for TI's
> AM62A SoC and enables it in defconfig.
> 
> Devarsh Thakkar (2):
>   arm64: dts: ti: k3-am62a : Add E5010 JPEG Encoder
>   arm64: defconfig: Enable E5010 JPEG Encoder
> 
> [...]


I have applied

Following to branch ti-k3-dts-next on [1].

[1/2] arm64: dts: ti: k3-am62a : Add E5010 JPEG Encoder
      commit: 540fcd5fbdb5f3bbd6f6a88d85b9993a9318d474

Following to branch ti-k3-config-next on [1]:

[2/2] arm64: defconfig: Enable E5010 JPEG Encoder
      commit: e8c643daeaa9040e18f8349993b9bc504e9d2117

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


