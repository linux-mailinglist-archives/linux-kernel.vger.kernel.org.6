Return-Path: <linux-kernel+bounces-232670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7E91ACA3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD461C244A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C70199EB7;
	Thu, 27 Jun 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X4gHTvhE"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEEB199E95;
	Thu, 27 Jun 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505556; cv=none; b=gwsYIG1hQSeDXEop2HUY14OmuFJKiKwhh0NKaYb5mahtXSZ42kfK95vqJZPFqDE9sur5e8G1rvPjeuN+YVXNDr8PKY+YT45Vo32OKrxXJShwIP8792CzzBomzUitiwwoyjp0wFNzbzZLt6tRV15fzUIY0RNfzNDAYeRz6S/aSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505556; c=relaxed/simple;
	bh=4483B/KPKHfUrPDphNJJ5o2UgzjO9LKvAYfFIVeIgeo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I9GB7hh6ULdrRApTo5lLTGbn8wKExJUeagpaQ7FkzqDUViYzCmf68GZM4KnzTSzYlfLgf8hKDu5wt8AZr6t/pz2fFYJCcBZSiukjNn3XZo852+89Fj9klyPm0LqngxP7H8E16uEM82AKZcc54xyypxsVmQ4KtPWqAdoVRGThIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=X4gHTvhE; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RGPf8H049641;
	Thu, 27 Jun 2024 11:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719505541;
	bh=fgYhpcw093MJq02OE39ek/JeBKZVyhhLarJy9EUqBvg=;
	h=From:To:CC:Subject:Date;
	b=X4gHTvhELPwJyEfZYqyvL5rrpo1wwoW0pQFkn8l9V4C9HKjVJObjrIXZfV72e1NH3
	 oFBcjApl5KaYHPikwi0Uuo2Qiq4HrAmAmkQbm1rCHx/iCHOYgusjgGlL9qsLHA//RS
	 EjM6B3a4zTM1mgtmcr6ML2B3407BVgaDXpsbnAT0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RGPfEH079358
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 11:25:41 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 11:25:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 11:25:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RGPeV2130217;
	Thu, 27 Jun 2024 11:25:41 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Vignesh Raghavendra
	<vigneshr@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>, Bryan Brattlof <bb@ti.com>,
        Dhruva Gole <d-gole@ti.com>, Nishanth Menon
	<nm@ti.com>
Subject: [PATCH V2 0/3] arm64: dts: ti: k3-am62p/j722s: Add gpio-ranges properties
Date: Thu, 27 Jun 2024 11:25:36 -0500
Message-ID: <20240627162539.691223-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

This series was tested on BeagleY-AI[1] using the script[2].

This allows gpiod to request for a gpio that is not in the default GPIO
mux mode and the framework controls the mux over to required GPIO mode.

The series is based off next-20240617.

NOTE: there is also a dtb_warning that is added, The fix for which is in
the binding[3].

Changes since V1:
 - Mux definition PIN_GPIO_RANGE_IOPAD instead of PIN_GPIO_MUX_MODE
 - Refactored on top of next-20240626
 - Note: since the patches have changed, I have skipped Dhruva's
   reviewed-by

V1: https://lore.kernel.org/linux-arm-kernel/20240618173123.2592074-1-nm@ti.com/

Jared McArthur (1):
  arm64: dts: ti: k3-j722s: Add gpio-ranges properties

Nishanth Menon (2):
  arm64: dts: ti: k3-pinctrl: Define a generic GPIO MUX Mode
  arm64: dts: ti: k3-am62p: Add gpio-ranges properties

 .../boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi      | 17 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi      | 18 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-pinctrl.h            |  3 +++
 4 files changed, 46 insertions(+)

base-commit: df9574a57d02b265322e77fb8628d4d33641dda9

[1] https://www.beagleboard.org/boards/beagley-ai
[2] https://gist.github.com/nmenon/4973770cf0df3f02c2e4f7f3d048d80d
[3] https://lore.kernel.org/linux-arm-kernel/20240627150610.469645-1-nm@ti.com/

-- 
2.43.0

