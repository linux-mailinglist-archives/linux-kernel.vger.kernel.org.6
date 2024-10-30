Return-Path: <linux-kernel+bounces-388118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6659B5ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4E5B23772
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6C91993BD;
	Wed, 30 Oct 2024 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w6uf8qVZ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB81374F1;
	Wed, 30 Oct 2024 04:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263843; cv=none; b=dOiXjeNlra9obT2hpXbU2uB9X4WFeZLuuvH4DUct+QhdpouVLf0gbdWyrB1P0QzWU34Kg2bKPPDX2OJ51Za0+XYI9SIGsFApM4x4dTXM6BICqqva09M23/01JN0f29msUt18y5hj10zgHX6fLw7EXmBNZiv9a/wB0A0r0WQ+kqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263843; c=relaxed/simple;
	bh=/MxQdibD1V/HO4OYUr1yLxZC5U7fN9FxoZ1BZVYwh50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5gQC6wjtIP7da7p8I54/y1a5lNVIziEz4o0j2pwzi3oH0E8PJ8b+LL5DalaZkRv9FyKYW4RXcokVKTVOPc5pF2kpZVlX+ahccfUn0Ord7RJ/IwM0SlWpgcEAGIlXGRW8TiaDIVTamHNA95DVdFTycVoSAf8Vudf1wUHx+MyA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w6uf8qVZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49U4oYgt033153;
	Tue, 29 Oct 2024 23:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730263834;
	bh=gBqvnKBySHT0QMR6brtfcsTMmVP3SGD7XAF/nvRY0uI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=w6uf8qVZhMB4Hkc8FWK0eOqNZ9rq3ndWLciHtMt8CbxMk5hADrNtDZkeaWi1QZCmt
	 Mp+QUJm+yh1gifJAJa1PaRnpJ06B7aJOQFdrnLtWhJ8UTAWeKP83/gdkOYmyiqF046
	 vEUxwYT4ChyGFwklorQ3bsohGBEDqUTEaXVlEjbw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4oY4U084723;
	Tue, 29 Oct 2024 23:50:34 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 23:50:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 23:50:34 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4oVu9060919;
	Tue, 29 Oct 2024 23:50:31 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Judith Mendez <jm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Bhavya Kapoor <b-kapoor@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Update otap/itap values
Date: Wed, 30 Oct 2024 10:20:29 +0530
Message-ID: <173021674666.3859929.6175106568775473302.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240924195335.546900-1-jm@ti.com>
References: <20240924195335.546900-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Judith Mendez,

On Tue, 24 Sep 2024 14:53:35 -0500, Judith Mendez wrote:
> Update itap/itap values according to device datasheet [0].
> 
> Now that we have fixed timing issues for am62x [1], lets
> change the otap/itap values back according to the device
> datasheet.
> 
> [0] https://www.ti.com/lit/ds/symlink/am625.pdf
> [1] https://lore.kernel.org/linux-mmc/20240913185403.1339115-1-jm@ti.com/
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-main: Update otap/itap values
      commit: 14afef2333af526f975160e71889b2625c309068

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


