Return-Path: <linux-kernel+bounces-388122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E29B5AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938F11F24DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED41993AE;
	Wed, 30 Oct 2024 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TvgSqcCo"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D1193063;
	Wed, 30 Oct 2024 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263930; cv=none; b=Vd0w0lmE/E1LHCB6BcS1SAnuuOvzFw7MDOrte1+UZWrc4NgSiC8y1Q8tRIVegeOLdtH3J+9jJHNtvNQtCP0HwUU37Wii/UssSExLKke/GI5WUGMPgXjqtkf8WvMFLoEYovTzJrpcgBmILIErs208tInrMDeK9iyZHZ1ktq96Va8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263930; c=relaxed/simple;
	bh=KyE8Y0094IzvX+QztK/Hl+miMVHP0Icf7MRK1ez9ffk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7YjAWZw5i5zqJE/kOnB78t4STyJ+GO+6WklsYeVXuYaoEKE+FF0I4OHDFZiW7nZnh2tg0Qs8lrBMxhJIkr0eVmd+4pS7vcyfxlbYk9TaV57xHMYfj2Hg1vk5gqLtGvYaWDWVcQTKZtvyFX4wPD5Pp1pxN5wfGkM/bkTfgURQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TvgSqcCo; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49U4ptv3046150;
	Tue, 29 Oct 2024 23:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730263915;
	bh=jENql/JSGijaO51AIfErQCfqmfrbjatMPfN+Lc1t6vM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TvgSqcCoshNhLT2WsRBHnmLIrWxj0EABkJKiP6S29tdE08vt+ebDFWfCEffVf+ivK
	 rHf8MoB+mkAGQsl+7CopGi2h8yFmWzQn6g4gGoLMR82G5IDrpLtvfklnjscCwoPOJW
	 ZOJd6C60oWuecT7MJ8DE+5xsslaPcQhxafiOYdcg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4ptxp085245;
	Tue, 29 Oct 2024 23:51:55 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 23:51:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 23:51:55 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4pp9e062140;
	Tue, 29 Oct 2024 23:51:52 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<jpaulo.silvagoncalves@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62-verdin: Fix SoM ADC compatible
Date: Wed, 30 Oct 2024 10:21:47 +0530
Message-ID: <173021674664.3859929.252749757982306283.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015113334.246110-1-jpaulo.silvagoncalves@gmail.com>
References: <20241015113334.246110-1-jpaulo.silvagoncalves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi João Paulo Gonçalves,

On Tue, 15 Oct 2024 08:33:34 -0300, João Paulo Gonçalves wrote:
> Fix Verdin AM62 on-SOM ADC compatible. Currently the hardware is not
> correctly described in the DT, use the correct TI TLA2024 compatible that
> matches what is assembled on the board.
> 
> The "ti,tla2024" compatible was introduced in Linux v5.19 and Verdin AM62
> support was introduced in Linux v6.5.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-verdin: Fix SoM ADC compatible
      commit: ab53b8c0ac975d8c4d61927d2be14afce14f6902

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


