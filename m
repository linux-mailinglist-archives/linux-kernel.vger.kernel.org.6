Return-Path: <linux-kernel+bounces-385241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAAD9B3471
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1061F227D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F301DE2C6;
	Mon, 28 Oct 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yg+IIvk9"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702418FDB0;
	Mon, 28 Oct 2024 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128112; cv=none; b=jHuQ0Vcg+LWnIg+obqQDetgZUZ+e7gDamaF3NPXSC59WJW15WowvwSthZQAqMlqSE1KIYOvwkN7iL9kRvt/roPe5vM2f9MI0/bQDoame8wxkjChrlOvzs8dYkfpmLSQPN0UeBaQpML2ZaTT3hEwSYOkzfGYKAX6wgxS1yDIef3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128112; c=relaxed/simple;
	bh=jiVKQ57hi7A062XHeQCcuk0VcgebYgwGxpIVbT11fb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cmoib8lR8T93EEGY0MfEg/KRZ2D3ljhprDjRSDTXvH21H8rIrIan/fsz+YifivCMkB4TDyS5gmO9O85u52DZNOw3st0K0fufhO1nfaE+Ksnbi4lIYFN9bK8xXBGo/I50uSmJUT4vQQbzP13uIQbDwu8o7iy2lXwF2j4kDkYEsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yg+IIvk9; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SF8Ox3024829;
	Mon, 28 Oct 2024 10:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730128104;
	bh=Gx1ESAmVytH8Um5rIC3OkBCktJHLJF3/Z1qDATXgXjE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yg+IIvk9jmGlq6ZRDfVy0theDCtSnN/eqJ4zLfPaxhIcI2lmQE4Cn5Ud8nOFcPYdg
	 Jw1fj+k60mCPcsAosOC7yhvjzjcoznIY9HSes5K4fVUADWz8XuGWxL9CChSEQDdAET
	 xfS5VaLLAvhAycPpMj05KxjXIf6LOBmr5BGVYRDM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49SF8Ofj052100
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 10:08:24 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 10:08:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 10:08:23 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF5tct129665;
	Mon, 28 Oct 2024 10:08:19 -0500
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
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 0/5] Introduce J742S2 SoC and EVM
Date: Mon, 28 Oct 2024 20:35:25 +0530
Message-ID: <173012710987.558239.1177036960002400473.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
References: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
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

On Mon, 02 Sep 2024 17:56:48 +0530, Manorit Chawdhry wrote:
> The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
> Support and re-uses most of the stuff from the superset device J784s4.
> 
> It initially cleans up the J784s4 SoC files so that they can be
> re-usable for j742s2 by introducing -common files. Next it cleans up the
> EVM files for j784s4 in a similar way and then goes about adding the
> support for j742s2.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: Refactor J784s4 SoC files to a common file
      commit: 9cc161a4509c2fda7cbe35b4858b496cec03c5d0
[2/5] arm64: dts: ti: Refactor J784s4-evm to a common file
      commit: 39b623c05c4652f2ec450a07cee3d179a283733b
[3/5] dt-bindings: arm: ti: Add bindings for J742S2 SoCs and Boards
      commit: 9c65033884bfec836fe45f21d079de40fc7c7bda
[4/5] arm64: dts: ti: Introduce J742S2 SoC family
      commit: 38fd90a3e1ac7e948081cf168cf10f0a20febc21
[5/5] arm64: dts: ti: Add support for J742S2 EVM board
      commit: 13dc96a52712053cfad59b0d11cab694ed5bc5ef

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


