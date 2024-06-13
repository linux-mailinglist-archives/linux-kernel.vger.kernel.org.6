Return-Path: <linux-kernel+bounces-212736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618A390657B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA001F22978
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AFC13C8EC;
	Thu, 13 Jun 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BcUuMFW+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0BB13C669;
	Thu, 13 Jun 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264708; cv=none; b=a1jnxd26Pun+9Uic1V9I4+ZNFTOMbLs5zqTd3bOKl/FmjNflZmKA2GvtoG/F582j8XLpE+l7cXHltkMJNbnOyYQ3NledRAAu7g7TFyDDfrz8e2U4wXcUb3IQM5ZESR2Ejl1WqSlqCIpB0J81oXr5uTrEMCZCBrIylJVSdU/Ud9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264708; c=relaxed/simple;
	bh=J8TwD9bur5JHBQNaChyKcOSX28PgrWyiAEkXBBl+Ty4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKIWNnSX9VhtobdUYulaUD2inigD4YXj6rLaKMqCkyMGVXmS5kOvZb4sNgaA5fc5Z92b0KYzWUzLFA4DHeJQ7SkNj71eWHimBH3zUYkh/dhcOiL0qHo/O0qJEkUt7BX9pXb0qg9ltqNZ/CVNHiZjtWCWyHAybT0XLfz68ClsZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BcUuMFW+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D7j0O5089603;
	Thu, 13 Jun 2024 02:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718264700;
	bh=84VDpeUrD1yhKfJzO9P4rI0FTOd680XQfSzp2MYlKMg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BcUuMFW+kUpc/OP6C7br0wTVKqh7yymD4GODcRT5m4/RhaNxF19QiAhX/AFnN/5mV
	 e7lYxjZYEQKxsDLLVshfyBEjYiaUHlorDW5ibJQ1Uc5IwOr9kdAs7kY7nnd89cG/cv
	 tzfjEL3R4+SHxRZty/cUDqcDQeQS8dyLG5/5F8B0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D7j0eK032990
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 02:45:00 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 02:45:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 02:45:00 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D7iut5115583;
	Thu, 13 Jun 2024 02:44:57 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>, <s-vadapalli@ti.com>,
        Chintan Vankar <c-vankar@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all property in phy_gmii_sel node
Date: Thu, 13 Jun 2024 13:14:54 +0530
Message-ID: <171826022268.240984.16645643062603851712.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240430085048.3143665-1-c-vankar@ti.com>
References: <20240430085048.3143665-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Chintan Vankar,

On Tue, 30 Apr 2024 14:20:48 +0530, Chintan Vankar wrote:
> Add missing bootph-all property for CPSW MAC's PHY node
> phy_gmii_sel.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all property in phy_gmii_sel node
      commit: ba50141137fae205a731005e70687f4a52289050

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


