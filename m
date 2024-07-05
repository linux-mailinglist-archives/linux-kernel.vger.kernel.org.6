Return-Path: <linux-kernel+bounces-242523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E46FB928974
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA1D1C23940
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544A214B945;
	Fri,  5 Jul 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i+NjTql6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501D14A0B7;
	Fri,  5 Jul 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185631; cv=none; b=I2WE3CHKlhIGlliQ8BU6lB3rMVXq80bSHAfyirUAYPm/oqdWgTwIFYGPLKicRQ4Bsva1SN4GUqJ2TWFrTJX7LVUcBv4uUtgVo0sj8z/Bvy73zSiRJ6bt7luPrVl07TqQ6GT/qJiapZzDm7W4GVKz8AkksHsDfONZO7xpJuVpzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185631; c=relaxed/simple;
	bh=7O65BSY1YnjABerUEX/XSkLKOtyucgsCv4IEnEsfzOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gsu88DOZY3ob+6DQdDrQJRR++o31lYPWthugdVr2U+kvCOam/IllewtcEgvf0buvKProlc7PaMUtb7yuDGr1iAsu6Q8k9PhYw3BbO5EaKaeHPcpA4/qlp3EtBFndPSNy5DfD47vhcs6B6/5b+HJ/D7x1F4SE7PlW/iZ5yn2JQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i+NjTql6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 465DKCfI084749;
	Fri, 5 Jul 2024 08:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720185612;
	bh=8GENAj70qaKif1xSCoXGz2QyshHZX03wXyFYQ7Hi+5s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=i+NjTql6RiTijT1B7B03+IOymnRUsRNKC/UpilHGvq1Ujvm+R+M22h3MdZ+kF0mru
	 aTwuSDWWwMfi6LGp1Q4VEshAW5lsxoM6TOKwTCYzMBG9+W9CsG3XsphV+jODZ16TNU
	 Uz/Mir00HVqXrR0+GyZSyBprXSR9vmjusZMot5lI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 465DKCnJ009840
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jul 2024 08:20:12 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 08:20:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 08:20:12 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 465DK7bB072061;
	Fri, 5 Jul 2024 08:20:07 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Devarsh Thakkar
	<devarsht@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <praneeth@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <b-brnich@ti.com>,
        <detheridge@ti.com>, <p-mantena@ti.com>, <vijayp@ti.com>
Subject: Re: (subset)[PATCH 0/3] Add global CMA reserve area
Date: Fri, 5 Jul 2024 18:48:26 +0530
Message-ID: <172018547554.2460342.5699091093485450824.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613150902.2173582-1-devarsht@ti.com>
References: <20240613150902.2173582-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Devarsh Thakkar,

On Thu, 13 Jun 2024 20:38:59 +0530, Devarsh Thakkar wrote:
> Add global CMA reserve area for AM62x, AM62A and AM62P SoCs.
> These SoCs do not have MMU and hence require contiguous memory pool to
> support various multimedia use-cases.
> 
> Brandon Brnich (1):
>   arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of global CMA
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
      commit: 9e8560556f9c41da28118af3385b4e9dc832ae2b
[2/3] arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA
      commit: 6406c5d5512c0814b8c155df7f833a98d9069a72

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


