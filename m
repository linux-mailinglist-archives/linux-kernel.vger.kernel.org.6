Return-Path: <linux-kernel+bounces-240681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A15CD9270F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A43D282E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7521A3BA2;
	Thu,  4 Jul 2024 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VnV0udz+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706171A2544;
	Thu,  4 Jul 2024 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720079538; cv=none; b=qhU/qIgkT5kYbBtdrZ6lrCKs7E/s1x0PEr8XliNG4DV39FhOVV/3ze0W9bYH0q04hdIF8xY15BGS+04JVjkmmcHqVEBFP/FV8JIJCMtyfjdFZ419PhCgUUJRLltfKhfW8his3R844gpi8b065oLyniJytVSA7L0V8aaAC2FNkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720079538; c=relaxed/simple;
	bh=jp2RtkQId3Zr6TuGjgAlCjF+iDncU9K6v9Gu0SzFjqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onfWBXNfA57Fdm63CgpDFIUQcp3wdrBrhf8EkmbmLzFzhXOTP0zFj3f1ngnJVTylCuXb1kalKW1QYwr1OxHmdWu0DzRGquuj9vKh1BhT4wTEdGG6L6WpEIEzAKFaSgEoH+iN16Hku/3PSgSgNRZ/8IH5JxyPyFMwux2mJ7aGHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VnV0udz+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4647q77x105591;
	Thu, 4 Jul 2024 02:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720079527;
	bh=85e7iYDncPuePEVeAU/LHg33nJNNQIR90mvLOeHa0mY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VnV0udz+BGSobOa4OHu9TssoZRN45WIJoHSvDWQFaks49LCYw3LuAhC7yEl0rElKy
	 bDY5s3HT399QQ5ENmfMfn3/Io94iJ/N3hHdTzDGgvISTXgu7+Wex7crtrDp8wrHiyB
	 LZDJzf/nT9rAoVqw6K7/BIbBKCmCw1H12VbIsZIY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4647q7XA106308
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 02:52:07 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 02:52:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 02:52:06 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4647q2ZB005281;
	Thu, 4 Jul 2024 02:52:03 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <m-chawdhry@ti.com>,
        Sinthu Raja
	<sinthu.raja@ti.com>
Subject: Re: [PATCH v4] arm64: dts: ti: k3-am68-sk-som: Add support for OSPI flash
Date: Thu, 4 Jul 2024 13:22:00 +0530
Message-ID: <171984950181.3152309.2613520266196229760.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622161835.3610348-1-u-kumar1@ti.com>
References: <20240622161835.3610348-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit Kumar,

On Sat, 22 Jun 2024 21:48:35 +0530, Udit Kumar wrote:
> AM68 SK has an OSPI NOR flash on its SOM connected to OSPI0 instance.
> Enable support for the same. Also, describe the OSPI flash partition
> information through the device tree, according to the offsets in the
> bootloader.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am68-sk-som: Add support for OSPI flash
      commit: 73f1f26e2e4cda4e105476708961f0c3aff4515e

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


