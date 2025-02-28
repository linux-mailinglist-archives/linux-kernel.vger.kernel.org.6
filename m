Return-Path: <linux-kernel+bounces-538672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66830A49BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F331684A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0763C26B971;
	Fri, 28 Feb 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QkLfy/jB"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48353363
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752292; cv=none; b=BIQmzntj+SCB5ylQHXhJvf66Keyz9XCc/mT+voyg37HWgkI6xG87DT/j+4ehWgZNZYiV7AIsjlulrfO9F7CH0+cbLr/rX6eMfVaNvRPQ0pUX3oqiiu7DEqNFdlOcLoIvI8WPKusrDtnlHJWzdBAUWdl6z/3eBG1n7MZ4Uafj6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752292; c=relaxed/simple;
	bh=8h9qea/edu/RnpMNDZUgc8v/NytoINvq8fYODyML7E4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1wHbRgcf+GVfHUbja/ZgOvjuAazrx1AiUroD0rSL4yh0NSbVnNj/Egu1QVO5seVTnlX/gQizdNXdnxvMnQJeeAMvwy1TrTyddbVfXUmagE07dE4Sc+y8FcghoUxliGtHaFh851eqjqkeX0Di8dnp8Qq+ZleeMv//Q6UeIMiJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QkLfy/jB; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51SEHex32070698
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 08:17:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740752261;
	bh=bgW5g300tmRMFjEsqTbas4ZzfRhvbkRab1mKzDMSykU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QkLfy/jBDukeSUCA17i0+sePLLz+l7falK5ners/Flz6qW8kaYsgKsZc8JcN2rQlw
	 N9YxmgjU29wdPr3DMD3Bu0k2psvdPWpqJgX7aZXHbzEr0DYIQdXCJ4NzXnWzGzDeGw
	 aLK19hPiw0q1uX4fd3sqFkTuHgitjfU0MFcp26xc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51SEHe9p002644
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Feb 2025 08:17:40 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Feb 2025 08:17:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Feb 2025 08:17:40 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51SEHe4M008459;
	Fri, 28 Feb 2025 08:17:40 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Meghana Malladi <m-malladi@ti.com>
CC: Nishanth Menon <nm@ti.com>, <ebiggers@google.com>,
        <javier.carrasco@wolfvision.net>,
        <elinor.montmasson@savoirfairelinux.com>, <biju.das.jz@bp.renesas.com>,
        <quic_tdas@quicinc.com>, <nfraprado@collabora.com>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <geert+renesas@glider.be>, <quic_bjorande@quicinc.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        "Ravi
 Gunasekaran" <r-gunasekaran@ti.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable HSR driver
Date: Fri, 28 Feb 2025 08:17:39 -0600
Message-ID: <174075218769.3252220.16260362657554687998.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250227111828.1963918-1-m-malladi@ti.com>
References: <20250227111828.1963918-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Meghana Malladi,

On Thu, 27 Feb 2025 16:48:28 +0530, Meghana Malladi wrote:
> HSR is a redundancy protocol that can be realized with any
> two port ethernet controller.
> 
> Many of TI's K3 SoCs such as AM64x and AM65x support multi port ethernet
> controller. So enable HSR driver inorder to support this protocol for
> these SoCs.
> 
> [...]

I have applied the following to branch ti-k3-config-next on [1].
I have had to slightly improve the commit message (answering the
question: "what is HSR"), let me know if you dont agree with it and I
can drop the patch from the queue in favor of an update.

Thank you!

[1/1] arm64: defconfig: Enable HSR driver
      commit: 44807ecfa6394d8a4764775998f5dde18ec4377c

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


