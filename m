Return-Path: <linux-kernel+bounces-540530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A6A4B1DD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B60188BF5C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C8C1E5B72;
	Sun,  2 Mar 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SYoeIhcg"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49091DF735;
	Sun,  2 Mar 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921613; cv=none; b=RppHgPmOjFFfHpQM3gYRjXUNSmwLh2vAM7Frzy5wSBaIDnoeKftounrO/HMvVf28cXqCm3cOLPTfpVVJZGptk2trHXYEKT0aZuy+/3IGZPI/s4VZZt2RXjEzZ33vbAqqYrQaj5pTpN1cdORU+Nd3/2XJRgpk+05T8sEb+rXP1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921613; c=relaxed/simple;
	bh=0C37q3v1SsmA8neNWiCmQDcsaR3d8nWrx2rw2VdTvqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7QTh7K7/TNiQjottq6eiXTPOh6SRXjUfKPkvoJMGMZAmvDS9qeK9cq5RStip5XI5maE45KH2PW2f1Nn/QDBNX6p2MAS/AoKikj4f2ChFX70yXHHpeqevodwSplWErh5YNGXsGpfySgS/2Z9LVaHhzvNgZd+OPquSxzXNcihEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SYoeIhcg; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 522DJu373080857
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 07:19:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740921596;
	bh=26tkCrM20QXEPHTpgA63PAfwjvTBInrFP/GdOCqqIcg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SYoeIhcgGrT6cAw7Fu94bkrFI6BM1rw0BVnE3RxKjc+zqeIc01GS1YpLLULUdMTlZ
	 Jf5EmdeZPqDM8IpgpHqQaaRYzW5Op0zOb7wIMlkP7jNigLBV3/na1PdxCP83N2sBvK
	 j+ZpeBvfW4y1tb/OwyQEuenoDJ5GhlfI7GfLZOOI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 522DJuNB017632
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 07:19:56 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 07:19:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 07:19:56 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 522DJqsU117340;
	Sun, 2 Mar 2025 07:19:53 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62p: Enable AUDIO_REFCLKx
Date: Sun, 2 Mar 2025 18:49:50 +0530
Message-ID: <174092143360.3272913.6825110714284930452.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206153911.414702-1-francesco@dolcini.it>
References: <20250206153911.414702-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Francesco Dolcini,

On Thu, 06 Feb 2025 16:39:11 +0100, Francesco Dolcini wrote:
> On AM62P-based SoCs the AUDIO_REFCLKx clocks can be used as an input to
> external peripherals when configured through CTRL_MMR, so add the
> clock nodes.
> 
> 

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62p: Enable AUDIO_REFCLKx
      commit: a5a7b2be9506d4483ddc9b4bd20e8948c456a8cb

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


