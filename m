Return-Path: <linux-kernel+bounces-238869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FC92525B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289701C24BEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0DB2E636;
	Wed,  3 Jul 2024 04:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y9LjyRy8"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FBC17996;
	Wed,  3 Jul 2024 04:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981171; cv=none; b=DUzIcehcdK6VpogupcmO6r84tuE0WWVlcG6LT3/EWRlrqgBP8yIpFCFqJlpqRJIauJJxmo8miWCxDEo56nZa/hRkzghppay0EXJNiYnV7yuMyCcTpH5fZhYDCkc922v8MeIZqqrW6TJ+JckGOkHAzSRTav/RSdiqBOSvfX0K5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981171; c=relaxed/simple;
	bh=T3yCBmEjh/vrVJe8JAN0JTFGoL7fYqur4iZnFr9onXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z29tdcjzV28sPMEMTI26lSEwGCVXaPqjGVb65+2f97SvYS5Yi0Bzb4MJVsFfFdx6CfxKC7/zK0wAdrcQFB48brr3dMG1c11NDl1QCCYkdaNTc71PGinWfWYAhVs3cZDiyDha1nXFywnxxRbWAjUIHhE6bRMmkFg5eEaGGbKAaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y9LjyRy8; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4634WcmP062277;
	Tue, 2 Jul 2024 23:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719981158;
	bh=luzFzf0HFM7+Giy0JGCU4FTSBmYgDS1q6aWO8MAsOgE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Y9LjyRy8PaUlxozcMiaRGD7ozZ1PNxba92Bb51+WBErEOK4OztMJ7W2HOzR3e0G18
	 rqpYEgYP4WGlzAWSzOQuOQvOdpaFCbnchAkF1+Vz1LeQj6H1wNcaSHzJdbKl/aEU7w
	 fttcjcxqAs7iy3yfyireMbvVDi/2P5LzJPU4CAp0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4634Wcvr025242
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 23:32:38 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 23:32:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 23:32:38 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4634WYmx050271;
	Tue, 2 Jul 2024 23:32:35 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>, Andrew Davis <afd@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Add MAC eFuse nodes to sys config areas
Date: Wed, 3 Jul 2024 10:02:01 +0530
Message-ID: <171984950183.3152309.11635024979528305029.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628151518.40100-1-afd@ti.com>
References: <20240628151518.40100-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew Davis,

On Fri, 28 Jun 2024 10:15:11 -0500, Andrew Davis wrote:
> Patches are all mostly the same but split by platform, context is in
> the patches.
> 
> End result is fewer DTB check warnings, some platforms now have 0 :)
> 
> This series is a replacement for this patch[0].
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/7] arm64: dts: ti: k3-am65: Add cpsw-mac-efuse node to mcu_conf
      commit: 0ab18cecc806586144ea8f245d15a8da71c332eb
[2/7] arm64: dts: ti: k3-j7200: Add cpsw-mac-efuse node to mcu_conf
      commit: 3128edb3c4a8ad8f7c53d11fc5a21da5d6b597ba
[3/7] arm64: dts: ti: k3-j721e: Add cpsw-mac-efuse node to mcu_conf
      commit: 1147fa465a82db96f9883477c3351b77a48e457c
[4/7] arm64: dts: ti: k3-j721s2: Add cpsw-mac-efuse node to mcu_conf
      commit: 418291e705a9824b09f76858c374b04cf4e7a1d3
[5/7] arm64: dts: ti: k3-j784s4: Add cpsw-mac-efuse node to mcu_conf
      commit: 74e074d22a4161c86b3acc12d6fc1dbd60b177f9
[6/7] arm64: dts: ti: k3-am62a: Add cpsw-mac-efuse node to wkup_conf
      commit: 00d20114b515b4697af228cf3c01120ca1335270
[7/7] arm64: dts: ti: k3-am62: Add cpsw-mac-efuse node to wkup_conf
      commit: c870321e4317ea28443e12445f070b35089fd45e

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


