Return-Path: <linux-kernel+bounces-310381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0E967C0A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF3F1F21736
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB7E7F486;
	Sun,  1 Sep 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M1PFd1MZ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8837708;
	Sun,  1 Sep 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725222078; cv=none; b=cvp/f+kiaPWnQW04kQpix/iGCbHvDUwL5imb+GepYl4CC5ykACn2Dl1MceQQl9SA98tb/uUlsJvayYNzGlBMXMoeMVEgpsr2czl+3k1Aj5SBxk+Jlu3ztIC0TT5BH2UIKYvtaGSANGgCJj19vt3AtReuAv2/voKN8O0McmlIpUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725222078; c=relaxed/simple;
	bh=HaIaCS8Nv2yQ1qcLVwU5SoDiXtrxb9bzUcXM/cH0z2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTm3HDAloc5CMm7i6rKam7QiibUIvKHSP+lWXcTf/HTE+tjhfRTduh4YyUyiOKaVy2oeL83Wd6V/Uoo7VxBECZbLRiW1J+Ophxap3Tppu9Q87xhvmEe2qIpBzpb6a77/esHMm2PKcMDry+Ii2YM2gUZSy8mcrh8/c5aKIK86QQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M1PFd1MZ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481KKjnG013523;
	Sun, 1 Sep 2024 15:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725222046;
	bh=JG/OGPwxAgiRiCp+zCXfMAFKBh+4Laugya0RYoc7vwo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=M1PFd1MZmkkrq52keTac7z3DKDCFIt2yZEwPWRAviF/wBMLuNn5Mz1EhmTHM0BhOa
	 o16ws/Ny856IiY9fZ0Sfy2bVO52IeIzfQ59fUSprknzYPxaggEE6x1ujGiJU7CqQE2
	 RXCVForXsALOJLzDU2sSXQZ97i+5u5NakVoCnB0s=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 481KKjqt015596
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Sep 2024 15:20:45 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 15:20:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 15:20:45 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481KKjhb124623;
	Sun, 1 Sep 2024 15:20:45 -0500
From: Nishanth Menon <nm@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Peter Chen
	<peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Mathias Nyman
	<mathias.nyman@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo
	<kristo@kernel.org>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
CC: Nishanth Menon <nm@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        =?UTF-8?q?Gr=C3=A9gory=20Clement?= <gregory.clement@bootlin.com>,
        Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: Re: (subset) [PATCH v5 00/12] Fix USB suspend on TI J7200 (cdns3-ti, cdns3, xhci)
Date: Sun, 1 Sep 2024 15:20:42 -0500
Message-ID: <172522185704.996619.16331297087532612354.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Théo Lebrun,

On Fri, 26 Jul 2024 20:17:48 +0200, Théo Lebrun wrote:
> Currently, system-wide suspend is broken on J7200 because of a
> controller reset. The TI wrapper does not get re-initialised at resume
> and the first register access from cdns core fails.
> 
> We address that in a few ways:
>  - In cdns3-ti, if a reset has occured at resume, we reconfigure the HW.
>  - We pass the XHCI_RESET_ON_RESUME quirk, meaning the XHCI core expects
>    a resume.
>  - We add a xhci->lost_power flag.
> 
> [...]

Since Greg has picked f7fd939e805672417bbf418f6035dec9400230fd ("dt-bindings:
usb: ti,j721e-usb: fix compatible list"), the corresponding
patch needs to go via the soc dt tree, so picking just that.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[12/12] arm64: dts: ti: k3-am64: add USB fallback compatible to J721E
        commit: 99ced42d6f3ebcae52c2c6d1207d3f96d7cf88ac

Theo: Do let me know if Greg decides to drop the said patch, and I will drop
this off my PR as well. But, no action at the moment for this.

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


