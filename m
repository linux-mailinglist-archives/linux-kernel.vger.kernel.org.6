Return-Path: <linux-kernel+bounces-310386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7841967C16
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863D728194A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1075112D20D;
	Sun,  1 Sep 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RupRe4dJ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04076F2F3;
	Sun,  1 Sep 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725222252; cv=none; b=rz5SD9hpbYiLJXm5HvGuDb/hPB7wRCa29KBzDpzadBro1PT1fAxQ/ZJZ+jReUjHsRVDEZzo+wdQcMAEdOAUQTgDD1IIVRL76rzP+XgiMoi3tX4NFii2A0xA7HUZHykAOvwiRJ4/83uc0mBtojZfSuCXQvvFk2xUr27xKMczpwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725222252; c=relaxed/simple;
	bh=7lj3oPnQRQaHbuILJhWCDUdkLwBjpwxf7xS9HS1p+kA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyrF7P51/RUxFDSJPYnxfwwjfy3b7QOeBFYpsC8IuU9WMfrdLir/o4G+a5Uet3tZ7L15udphOSdE58CRmLIrGlIc6t6gt68VZPUeF9/rVif1aciPlNbrbjI/zFdeUizjevxJqpWn4o82tysYM7Xx0rtXQhbf1dYXXyZ41UO76vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RupRe4dJ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481KO2sl022597;
	Sun, 1 Sep 2024 15:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725222242;
	bh=2ZvF8zYbbQ0GZmc1Dz3wf+zU8rw1565Z489JU0DJJYc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RupRe4dJgkZE04beuDQ/y1uhJqWUA2ztb1/4yhSqj75UyPvgxbHHS7AngDKH3ixFX
	 /m01sWGosyngwxLX2iEFQ03sPWgXfBtC7YvFexloLmLV8obxDYVIM1z5JE52zoey2E
	 +AoT6Y7zQwFhtkrH0AmxWcZoYX1TKXiFz8TrIcak=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 481KO2Lr016975
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Sep 2024 15:24:02 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 15:24:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 15:24:02 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481KO2ci127369;
	Sun, 1 Sep 2024 15:24:02 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: iot2050: declare Ethernet PHY leds
Date: Sun, 1 Sep 2024 15:24:00 -0500
Message-ID: <172522223457.998405.3656804637764682848.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829-ivo-iot2050_leds-v1-1-792a512b2178@siemens.com>
References: <20240829-ivo-iot2050_leds-v1-1-792a512b2178@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Diogo Ivo,

On Thu, 29 Aug 2024 14:28:29 +0100, Diogo Ivo wrote:
> Each Ethernet PHY on IOT2050 platforms drives 3 LEDs whose triggers
> can be configured to signal link properties such as connection status
> or speed.
> 
> Declare the LEDs, exposing their trigger controls to userspace.
> 
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: iot2050: declare Ethernet PHY leds
      commit: f3be0032e116eda48e9a6e73002fc2c107658918

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


