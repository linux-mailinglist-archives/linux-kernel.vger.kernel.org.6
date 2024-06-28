Return-Path: <linux-kernel+bounces-234115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8676D91C264
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C7A1F24C39
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C615F1CB315;
	Fri, 28 Jun 2024 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ytuteiew"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A061CE089;
	Fri, 28 Jun 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587740; cv=none; b=F4zxpIx9P21cdsfwJmgnP7WHLNZBw00jRVq4I+MS5bWorqVXlV9udwRj0E4e90p5nEZAjB4Dd8w+S8gtAqcaFPPpCPzlLmHFi6lq2dyfhBMTku65OuzdgYaFXYgM26a+lJVdIT7gTqC68pIJ4udPChuckm+PQGINownKArzqGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587740; c=relaxed/simple;
	bh=P+ouPv8se+uM+bIFImsA9GJp0vFEJnkBIMBFP7cs5Jo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C2z8yByEUUDh+6BrFbpY2v+jQME891IZLc489Xs+IgDLhb+2PW71FGQ0Svp/lilV7ej2pyTa/9uXJYxsdbGKR/ZCBtcTylnSyg78n8Zn9ozWsAeVS/9LNmhLcw0nU5zsSXCKQ6/8RbmTqLpCVNperv4GfDrsFZTQaN5WWAZlKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ytuteiew; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFJc5001298;
	Fri, 28 Jun 2024 10:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719587719;
	bh=0x1dfjLJ3gFyB9hTsDCFaKMOT4ebX7SQADJSbvVdMzQ=;
	h=From:To:CC:Subject:Date;
	b=Ytuteiewz7e7m4Y4jEJDMIeadwbfTiXCbl0MKjzmeVxJORebQcy00i9fn7PgvqXEY
	 pKi2jlTg+NQ2zGXcyXaXlNTZamj7N0xrAJ6/OmgUxvRwhAzMWVxNc1vhiAjqCZtswA
	 6MLmahCIUaPFvw8tzl3uDn3i/s9zT0Uh7QtxE78A=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SFFJIR056882
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Jun 2024 10:15:19 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 10:15:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 10:15:19 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SFFJlT087911;
	Fri, 28 Jun 2024 10:15:19 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 0/7] Add MAC eFuse nodes to sys config areas
Date: Fri, 28 Jun 2024 10:15:11 -0500
Message-ID: <20240628151518.40100-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello all,

Patches are all mostly the same but split by platform, context is in
the patches.

End result is fewer DTB check warnings, some platforms now have 0 :)

This series is a replacement for this patch[0].

Thanks,
Andrew

[0] https://lore.kernel.org/lkml/f589fcea70004cae1c822871023ade86723bb1e3.1719376928.git.jan.kiszka@siemens.com/

Andrew Davis (7):
  arm64: dts: ti: k3-am65: Add cpsw-mac-efuse node to mcu_conf
  arm64: dts: ti: k3-j7200: Add cpsw-mac-efuse node to mcu_conf
  arm64: dts: ti: k3-j721e: Add cpsw-mac-efuse node to mcu_conf
  arm64: dts: ti: k3-j721s2: Add cpsw-mac-efuse node to mcu_conf
  arm64: dts: ti: k3-j784s4: Add cpsw-mac-efuse node to mcu_conf
  arm64: dts: ti: k3-am62a: Add cpsw-mac-efuse node to wkup_conf
  arm64: dts: ti: k3-am62: Add cpsw-mac-efuse node to wkup_conf

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi         |  2 +-
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi       |  5 +++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi        |  2 +-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi      | 10 +++++++---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi          | 12 ++++++++----
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi  | 14 +++++++++-----
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi  | 12 ++++++++----
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 12 ++++++++----
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 14 +++++++++-----
 9 files changed, 56 insertions(+), 27 deletions(-)

-- 
2.39.2


