Return-Path: <linux-kernel+bounces-387241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F09B4E67
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B823B2512B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6C4196D90;
	Tue, 29 Oct 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TLm6H5hs"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FAE194A44;
	Tue, 29 Oct 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216837; cv=none; b=pNHWFVsHQU1aGY0iUl5NBMJ3xEJGZXf/tUr8UHFBkN8TkqhQaeWmBEwkZp6rrCtiugbBPWHyNJITdd2lbTna8se14XbUHSqWdeRq8yp3cyMGFMdpqLl11afzTWudD2uhR6gk2PHlP9dgM7oEktmnEI+PzIb0IEdSteLFD0+xcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216837; c=relaxed/simple;
	bh=MzRLhMitdAfNa6d1w+4rK7xhp0DzHBeyQBQ4Cj83fG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFKm6b32RHVZV7dMNbmv+3vqy4B+IJbjh+JfbZYMrfY6pbIQgrencKgoDgk9WyZa2w9P3/pbW8xQFYGjzGGdiVqcot9iTO2ajozsZlcVGMqtovBFYgVkzwB0pYZ14mYkiip/elS55kIpHF/HL9s8W4Bu4RRhYWsyVGc6CcgWZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TLm6H5hs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49TFl3ie017388;
	Tue, 29 Oct 2024 10:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730216823;
	bh=sfiQdLTsM4V8BHphb5DQhMwvFatwHGMvvsgf3NLzPQI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TLm6H5hssuGhsb5EOrHm1dSzGe222cwCNim5S2xlzlKu5OB+7Uc00jLgNhdN0WVbe
	 nEzYzUeFH4l20SIq4PI9+frK5WIw6x+gBhvEDgBY+BlnwP8tmnq2YzA/Sr8A9h3LT4
	 I52kZ0jFj/sBko1HDXlvUJF/h83EQ4D5tjmk8QJA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49TFl379018252
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 10:47:03 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 10:47:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 10:47:00 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49TFkufT082870;
	Tue, 29 Oct 2024 10:46:56 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <d-gole@ti.com>, <lorforlinux@beagleboard.org>, <jkridner@beagleboard.org>,
        <robertcnelson@beagleboard.org>, Nishanth Menon
	<nm@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ayush Singh <ayush@beagleboard.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] arm64: dts: ti: k3-am625-beagleplay: Enable MikroBUS PWM
Date: Tue, 29 Oct 2024 21:16:53 +0530
Message-ID: <173021674666.3859929.3387135730934868690.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016-beagleplay-pwm-v1-1-245ae88859bc@beagleboard.org>
References: <20241016-beagleplay-pwm-v1-1-245ae88859bc@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Ayush Singh,

On Wed, 16 Oct 2024 20:41:15 +0530, Ayush Singh wrote:
> Add pinmux for PWM functionality of MikroBUS PWM pin and enable the pwm
> controller.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am625-beagleplay: Enable MikroBUS PWM
      commit: 1e5e2ff46294d3a712a4a54ede7910a193ef2c35

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


