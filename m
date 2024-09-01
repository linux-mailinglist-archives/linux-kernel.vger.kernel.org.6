Return-Path: <linux-kernel+bounces-310383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E7967C0F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89651F2110E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0D78C8D;
	Sun,  1 Sep 2024 20:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hl/8irwm"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378937708;
	Sun,  1 Sep 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725222129; cv=none; b=FL3cj6SgWjIjgpue6calnOenstRRd7jz2nz1b7goMpzGLqe9Cw30C6itC7SUaO4hmCPoYThSAceT5cJCZ1Ci8IORXywROHAJhmJTVGqXyS/a4LsBz8BNFV1E4GuYLxOyQgWs6td69zVwHumnP0ilJVF5bAqC/Kr/ozGriHZINQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725222129; c=relaxed/simple;
	bh=/wQ2FCjlN81kUnFIYdVDvXlHNhGlpVhYizPsSaQNsXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2fSt3o/WLxBdhBTDcvo+R7kaV6x3vGDeslXgroh2uEB7Ytszg4FMdlHxlEpjDHVi6YDkyqMMV5PYGy1jWI4sZAKF4T5WMNrQm+LH0XusgGJXYQRIFEk0lk4cvqk66GKEUGZ9siG0qswt+j6fw/+04IvGtcCoPYHSRvv1Pp6Kfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hl/8irwm; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481KLnZ6076660;
	Sun, 1 Sep 2024 15:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725222109;
	bh=qXdr+mXyuSgVSO0lKNcMq/yTcWeokOnsUrm2yBC4Qg4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hl/8irwmtR4UWuvfq3o6ApAMlqQOboq/3Hd8qIK8gHEAIQPn8U5Q3Gkw9/FyuZZIW
	 o0gW3+wh3ef+F5yMTwx3Y4xyA+A2woVxpWnkF7fKWe6DE70kvysVbXkNr6f9Zg3UxW
	 7MoloNVjVhpnrk9FGj6m1aD7nfF6iJE5bQoDSczM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 481KLnkZ004175
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Sep 2024 15:21:49 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 15:21:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 15:21:49 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481KLnHM019202;
	Sun, 1 Sep 2024 15:21:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
        MD Danish Anwar
	<danishanwar@ti.com>
CC: Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am654-idk: Fix dtbs_check warning in ICSSG dmas
Date: Sun, 1 Sep 2024 15:21:47 -0500
Message-ID: <172522208323.997949.14061275815291905053.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830111000.232028-1-danishanwar@ti.com>
References: <20240830111000.232028-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi MD Danish Anwar,

On Fri, 30 Aug 2024 16:40:00 +0530, MD Danish Anwar wrote:
> ICSSG doesn't use mgmnt rsp dmas. But these are added in the dmas for
> icssg1-eth and icssg0-eth node.
> 
> These mgmnt rsp dmas result in below dtbs_check warnings.
> 
> /workdir/arch/arm64/boot/dts/ti/k3-am654-idk.dtb: icssg1-eth: dmas: [[39, 49664], [39, 49665], [39, 49666], [39, 49667], [39, 49668], [39, 49669], [39, 49670], [39, 49671], [39, 16896], [39, 16897], [39, 16898], [39, 16899]] is too long
> 	from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#
> /workdir/arch/arm64/boot/dts/ti/k3-am654-idk.dtb: icssg0-eth: dmas: [[39, 49408], [39, 49409], [39, 49410], [39, 49411], [39, 49412], [39, 49413], [39, 49414], [39, 49415], [39, 16640], [39, 16641], [39, 16642], [39, 16643]] is too long
> 	from schema $id: http://devicetree.org/schemas/net/ti,icssg-prueth.yaml#
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am654-idk: Fix dtbs_check warning in ICSSG dmas
      commit: 2bea7920da8001172f54359395700616269ccb70

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


