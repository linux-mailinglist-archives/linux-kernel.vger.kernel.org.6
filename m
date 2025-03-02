Return-Path: <linux-kernel+bounces-540526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88076A4B1D3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8343B27AF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBDF1E5B65;
	Sun,  2 Mar 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y1KHoQOd"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B71EB3D;
	Sun,  2 Mar 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921517; cv=none; b=moTrEEKHTQKEdUlLCGcCweBmsQr5I9CadY2u0UktWwxoh7dTxhzu1Y2njf1yJU/TfaLvJT0wqx8E2LWYptcD0B2U/G1CBcaXz3/y5xg46zNbIDa1IHCw1eeiVlM40/E9px1N7D0y6wFgZqq23uEkuHDrlmKAHNMGQqN7camNBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921517; c=relaxed/simple;
	bh=27YscCQe+hnbSxxPNQ9Q+JTGS2Rt+u1A5+P2aN8ocR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ci60WG2nnrpturBOXPi92Wg/c8u1WZjR95dQ5Be58UEmOd6A0wMcPGuya4GWnZ7UYU439cTFcphmfOE42bSzcNU10NUDxzVng9KFHL0yNCICqsixdjh8LRdYHEfSUJx8FxzNg98V/axvTbPkrss5HwvEGQfMainEWFOxnfKUJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y1KHoQOd; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 522DIG9s2536636
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 07:18:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740921496;
	bh=8Z9d9cS7Mfxm3c4f5pambF3NbacZyXZO/9FMs35Tc/w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=y1KHoQOdfrMyyAp7l97uwagKrBMqfUluk0QpFCvInLlwC64u2rD5Y9gxFR8sFkWyH
	 yle72vhe/e11vecB3Qm0Sg0MHfEpbsmxp5VG0YDrjytYI6d/9M1W4eKswNuQi/pS4C
	 94L2RgrRR8VVtxdNBqEZb8f4vOKbapy3p/+TMatY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 522DIGQl016785
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 07:18:16 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 07:18:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 07:18:16 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 522DIDKk116230;
	Sun, 2 Mar 2025 07:18:13 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-som-p0: Add flash partition details
Date: Sun, 2 Mar 2025 18:48:10 +0530
Message-ID: <174092143356.3272913.16335037194305409116.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215070059.1593489-1-u-kumar1@ti.com>
References: <20250215070059.1593489-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Udit Kumar,

On Sat, 15 Feb 2025 12:30:59 +0530, Udit Kumar wrote:
> When used as boot device, OSPI flash hosts different  boot
> binaries and rootfs etc.
> So Add partition details for images hosted on OSPI flash.
> 
> 

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721s2-som-p0: Add flash partition details
      commit: d9f17c11650c205fd4802033a5e880bf79662ace

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


