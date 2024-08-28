Return-Path: <linux-kernel+bounces-305569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C1F9630A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D43B210C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320531ABEBF;
	Wed, 28 Aug 2024 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wmz9FVVU"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB26B45C1C;
	Wed, 28 Aug 2024 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871679; cv=none; b=U5gV/y9hI86ccsUbbXTn+5eyesCeJZIpYxxnVEx1HUGcUEnu7ENolcVD1PiaCq0R4xNtYVrqA+JW1Fwj492edcuMAz7IAPVGU51ESLN0/W7PqCdScyO35FHBf2r7xFuhEajE7bS3ev+ajPiUbB14XOt1SQ3zObShbCMXRVXoxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871679; c=relaxed/simple;
	bh=W49lIIQLhc25HkMPMv7pqc/BGKv8KK5E0dnT9vOr82A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wh/GBZNllvkjUCoWSf+SoK0jDev0FIxqtG51ELDr8jL0Msjn3Pb5p6/TAG3grw8ZhJbUKV43wC4FExG2lcT36WjaK0GOo/YKQw7w61p7e9pRV3yfICsD99U5u9KhkkGTd/2ZPntU2b6iaZYxA0q/nO9O9UnSPZ7ZPOvgipsRYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wmz9FVVU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SJ1C87053966;
	Wed, 28 Aug 2024 14:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724871672;
	bh=lMqr6G602EKrXBLjx4gdC8qgvRTCanVR3j+HV2xUhlc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Wmz9FVVU3Z9AF2HDSU5mE5idvg/uefrzc3Ubv6KYOBcqqgv0P8FRR8cMKpVTDNuWT
	 4h35xifS0M/t8sZOQDM4wxyktYd5io8GWpARpUq4DXHb+MHW0I0b80hQ3CA97j1cFY
	 WcSu9u/QmfozDgR7Wzp21vsE0uJgCm3tKjSM2C7o=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SJ1BGB064204
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 14:01:12 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 14:01:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 14:01:11 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SJ1BG3056559;
	Wed, 28 Aug 2024 14:01:11 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan Brattlof <bb@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vibhore Vardhan
	<vibhore@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p5-sk: Remove CTS/RTS from wkup_uart0 pinctrl
Date: Wed, 28 Aug 2024 14:01:10 -0500
Message-ID: <172487163881.3443021.2235453208168583366.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826-am62p-v1-1-b713b48628d1@ti.com>
References: <20240826-am62p-v1-1-b713b48628d1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bryan Brattlof,

On Mon, 26 Aug 2024 13:07:48 -0500, Bryan Brattlof wrote:
> wkup_uart0 is a reserved node that is used by Device Manager firmware.
> Enabling pinctrl for CTS and RTS breaks the wakeup functionality of
> wkup_uart0. Hence they have been dropped.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62p5-sk: Remove CTS/RTS from wkup_uart0 pinctrl
      commit: 0c95ffb74eec3c3d0a5e712984f0c095e58a1021

I did do a minor commit message cleanup to keep it sensible.

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


