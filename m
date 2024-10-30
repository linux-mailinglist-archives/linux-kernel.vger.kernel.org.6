Return-Path: <linux-kernel+bounces-388120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01979B5ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027481C22880
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1886198E89;
	Wed, 30 Oct 2024 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZC3PKORl"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18279374F1;
	Wed, 30 Oct 2024 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263884; cv=none; b=mnr+bXsHkAt1mv5yKgRKP7F0o2iiDVX+FPmZxPbvSil0tiJUUpp3vTkTzYI3tutNwIT4ZiU+ArNDyGPoa9OVtrT0xKD/6hx5vLBEDFUL/xGekUCdTa+AUdpVTHEJbgpUwLLEl9zUcxmoupG6G/9ms1108psIq8H51/9SvOgdkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263884; c=relaxed/simple;
	bh=96tH+dm+6GxNxl6Toq5Ukv3RhC66b7SuGXd3FkUsCQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3RoT7LVxfj64D1Ri2dBxzdDN5A6Vn3x7lEMOXfvSHrMPqQ1YmxNDGUhBUi06Z6wcFPhF699zm6TkbephthJ7DGvqDrIwjA/eM+nz5bXAhpi6t7PUEZGyspH0Pcqtziom+fpZ2LUnARRcvIZ6n9N6cAjpe6IoayIlGQKnAeSVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZC3PKORl; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49U4pH9Z059807;
	Tue, 29 Oct 2024 23:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730263877;
	bh=P5xWe2qGp1zJi1HAfyqxvR6bkfEvGyVfKesTdiBP3t0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZC3PKORlKHfu1h8XTdkSxGBrAUkESiJAXDh6dCOddrH5ncsjXCQnNfFGTaK179FaE
	 DCf6VO1XpjnlP8BLu5ethmzgKfvGQr+xL5+8Ml9oR5zOeC48TmDAOodHE7daBAxHji
	 n7C9IK29xxDMvGxy6OFyp2q4nBxigdL2l+WTP9kI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49U4pHZf117694
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 23:51:17 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 23:51:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 23:51:16 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4pC3U061595;
	Tue, 29 Oct 2024 23:51:13 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j7200-evm: Add overlay for PCIE1 Endpoint Mode
Date: Wed, 30 Oct 2024 10:21:10 +0530
Message-ID: <173021674667.3859929.7376219255805790509.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241001093426.3401765-1-s-vadapalli@ti.com>
References: <20241001093426.3401765-1-s-vadapalli@ti.com>
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

On Tue, 01 Oct 2024 15:04:26 +0530, Siddharth Vadapalli wrote:
> Add overlay to enable the PCIE1 instance of PCIe on J7200-EVM in
> Endpoint mode of operation.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j7200-evm: Add overlay for PCIE1 Endpoint Mode
      commit: f43ec89bbc83813efa1d33215ab920e66fcc9471

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


