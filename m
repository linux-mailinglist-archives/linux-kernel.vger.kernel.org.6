Return-Path: <linux-kernel+bounces-387244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3819D9B4E6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F851F238DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592F1990B3;
	Tue, 29 Oct 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AEFOVmUc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B859197548;
	Tue, 29 Oct 2024 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216859; cv=none; b=q82P5IKoWvJsif0bwMhdzAQ2sSOIVP0yDatBI2Rgk05cSr9kuZstQRXgmwFyeLW3SVFRbYzxgHj1F8y3VVeFFIiS9LFfY6RIev0qhNeoWA6pw8AT9APFdCNrPYSNCMF8fuQgflGaYXjncCOPrQyV/gwsXlSOoqoqrRyQpT885SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216859; c=relaxed/simple;
	bh=yVXHfBrbbaMXj3e62dKxzjQmsfQa7PGzMdwwnxU0A18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUQp9RhRDY6W6ciMS9LPQYSvbgOygeHMCh/a1zrfsSpmiwrCaUz2UpCEIRQawvMquTHNsF3cBWwibXts2cZKvqbpsiAfPd/qPgQ0bWubYScMzOTyT5TcztlPP3FStSjvx2fNmMOH/tbHd4I+yw/X6HJzOybaAkrNbEQeFej/mGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AEFOVmUc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TFlSn3017443;
	Tue, 29 Oct 2024 10:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730216848;
	bh=GLjfUODQODOaRX/d1s4wSCIi5iG+h1DU0f5TSsQNgoo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AEFOVmUcKQGazhaNrxs1IP+Dp4izBj4Ac0XDnDHza307aHm2DrLVssyk0b5K1SvQv
	 MbvnpQhoYdcSC4s3I9NmfZfEGqFbB40zAJMV4hCHPtz2+VmfPB5zuSJFVt5KZXUOCm
	 moeTiOrKVgl6W7n40r9epXgrqmJ+4Pjla4iPIl3U=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49TFlSbg010235
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 10:47:28 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 10:47:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 10:47:28 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TFlNKE083333;
	Tue, 29 Oct 2024 10:47:24 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Manorit Chawdhry <m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis
	<afd@ti.com>
Subject: Re: [PATCH v6 00/12] Add bootph-all property for J7 boards
Date: Tue, 29 Oct 2024 21:17:21 +0530
Message-ID: <173021674661.3859929.13298221281337904627.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
References: <20241024-b4-upstream-bootph-all-v6-0-2af90e3a4fe7@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Manorit Chawdhry,

On Thu, 24 Oct 2024 10:50:57 +0530, Manorit Chawdhry wrote:
> The idea of this series is to add bootph-all and bootph-pre-ram property
> in all the leaf nodes wherever required and cleanup any other places where
> bootph-all/bootph-pre-ram exist in the parent nodes as well since now
> the bootloaders can handle it.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[01/12] arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup: Move bootph from mcu_timer1 to mcu_timer0
        commit: 1d381865ad86b05328a3c4d841d2f0d2c07a8b6b
[02/12] arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup: Remove parent nodes bootph-*
        commit: c4fbee5eb6fa5212e9e6285b9116e0e2fae42c52
[03/12] arm64: dts: ti: k3-j784s4: Add bootph-* properties
        commit: f54d577df4a06c8e075ba9c1bd8fd6c18167d47e
[04/12] arm64: dts: ti: k3-j721s2: Add bootph-* properties
        commit: 83ab86a4412f6143acdf75fd315c196d255a0089
[05/12] arm64: dts: ti: k3-j721e: Add bootph-* properties
        commit: dd2c7aeca3ece4ab78a9d87fe2dcce365b5ce87d
[06/12] arm64: dts: ti: k3-j7200: Add bootph-* properties
        commit: b903ab269e67ce5788b0b2a39db4bd11fd19359b
[07/12] arm64: dts: ti: k3-j784s4-j742s2-evm-common: Remove parent nodes bootph-*
        commit: 49b0b706af963424decf4b6c67b09a83af91a067
[08/12] arm64: dts: ti: k3-j721s2-evm*: Add bootph-* properties
        commit: 15a432a4a0d2a6b79fdb798539e6fdbc87ed526c
[09/12] arm64: dts: ti: k3-am68-sk*: Add bootph-* properties
        commit: 781cb8f1ad769c7999ef3b35f216ff150130f3ee
[10/12] arm64: dts: ti: k3-j721e-evm*: Add bootph-* properties
        commit: fbdb8aa4eab8405c8709aab9e3bba48b5a955cbc
[11/12] arm64: dts: ti: k3-j721e-sk*: Add bootph-* properties
        commit: e45355835c40eb96fe92ec98cc9a9e9e60df0845
[12/12] arm64: dts: ti: k3-j7200-evm*: Add bootph-* properties
        commit: bdb543b1664bb4a54edf6ab651a36915d037220b

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


