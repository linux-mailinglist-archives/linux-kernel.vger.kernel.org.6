Return-Path: <linux-kernel+bounces-212886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8579067CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17F228A02D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42FD1422A3;
	Thu, 13 Jun 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="foVm020E"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF91420A0;
	Thu, 13 Jun 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268657; cv=none; b=TQzxw7Gl3JjsqF2AOR27tFT2mTahYT8c3V0X1qcviBRZjQFn4pUxsCqbEbHQmqf++z+Rn+FTjX4/PcgfcqOdoyckckDR0Zyoa5JtqGaaAbJdTSZLBbpPP2EDeSv97Cos40KUYvN3sD0vUkiL0e4vPNJiQ+4I4WznZ8DzeKGfZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268657; c=relaxed/simple;
	bh=6Fqc2KilhpQCbZvrECtElaNt9VdgPUK/0Pw8ZT2QXvo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyoIN8PSNoKi9MBItJaf4gKzdEkHmvhSo4yPMq6ybDGSZ7ZYX8sJUJ1+b4gOvZnSosjo+KOP/Mua9nQULjlpZSSOSVjz4NZ7pxElSo34XhPNKhedDs1nzx7denDZtHSo5id4nTs+XaRGXoknkoFPJeeEdeAFxOOV7HaXNLJcdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=foVm020E; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8oc0N025792;
	Thu, 13 Jun 2024 03:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718268638;
	bh=j25xqSkqPcT4/qHc/9OgyQnEMjdQ3hKqTjHTmX6z+DE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=foVm020EGeosKa1eGc6+MaBzGWmdimVb/0vDZxKpjgawq/G03jFcmL/y/kT0ay7Ht
	 XkXmZSOOVmV+YjzzfISR0/e5Rw+y6OrwIgHXmMPN+aX6m6qsR9TNrr7e7AHfsdzhRE
	 R2qb5qlnuMi32gD5zWItG6vnlGMQT2IrOOW2TC+s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8ocMY101705
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:50:38 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:50:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:50:38 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8oXKq100236;
	Thu, 13 Jun 2024 03:50:34 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <robh@kernel.org>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, Neha Malcom Francis <n-francis@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <marten.lindahl@axis.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v3 0/3] arm64: ti: Add TPS6287 nodes
Date: Thu, 13 Jun 2024 14:20:32 +0530
Message-ID: <171826022275.240984.3079027342635467737.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240528040159.3919652-1-n-francis@ti.com>
References: <20240528040159.3919652-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha Malcom Francis,

On Tue, 28 May 2024 09:31:56 +0530, Neha Malcom Francis wrote:
> Add nodes for TPS6287x present in AM68 SK, AM69 SK and J784S4 EVM. They
> are a family of synchronous step-down DC/DC converters. These converters
> are used to enable AVS (Adaptive Voltage Scaling) for these devices.
> 
> Also since AM68 SK lacks DT node of it's PMIC, LP8733; make use of this
> series to add that in as well.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am68-sk-base-board: Add LP8733 and TPS6287 nodes
      commit: 1149215a442b47d54a154c378e6c6080339b3712
[2/3] arm64: dts: ti: k3-am69-sk: Add TPS62873 node
      commit: 80ad4406922cdeab683c6db22e0a97e54570cc07
[3/3] arm64: dts: ti: k3-j784s4-evm: Add TPS62873 node
      commit: 79160cabf3136992be4276c22858688e9e1925f2

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


