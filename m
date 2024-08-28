Return-Path: <linux-kernel+bounces-304846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6069625B3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B45282CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C30A16D4C4;
	Wed, 28 Aug 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cc9KOnAU"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A3216C6A5;
	Wed, 28 Aug 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843716; cv=none; b=TavY85IoHKZXJ+lPqHIE2Wx7V/Xv/Gk448hokG8UCpuhZKQ/tMdoDJkGuEy9MlpGvtDEwWhgxni3daXrXaemQPTgYyflhYRLLWzxLOwjKbmM6oWYYNhNrZDH7zmtcDmIp9gFpKRlkDctpbv5sg4T/jcO3jz6N6wOdZoM53fj2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843716; c=relaxed/simple;
	bh=ZbhS9vqMXDQr3e/dxFe0PuE+Ui9Wl7na/zvQAar0ygw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=L4FBb3jDsY4LRb8P9S2SSFdPiReXuJrPr9smRUAiasFGIWcN9qMo5Q/WGI3mhV1KIU5LO/OvgFnH9TS+G0bfdy8RDmVp4mbXIya5NILCZmgEwsIDFNGkwk2lrEKfdL6M1fFbiVAc2iJq737dXRpeYglBVEPcSeOeU9WZtio1nw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cc9KOnAU; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SBF6JL016129;
	Wed, 28 Aug 2024 06:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724843706;
	bh=XhAruzoi2xhi5IWI0Rc6Sv77a+ExcYS8y5pSo7RoYWo=;
	h=From:Subject:Date:To:CC;
	b=cc9KOnAUxZX9ztFFNpUpErjLK1zaim4o9bgvANg0SjVW//Gez1NTXJbkwB7KXkKh3
	 tyt97jRg3F28h4yBqksYvelwXicA3+NB8rme/Dm8p52Z+RAXcArstIQxEQXKaJ3lym
	 QX4s1pQdfNlCiUDZ1LEL8cwUZdy0K3pR2CTYsg4s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SBF6um000695
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 06:15:06 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 06:15:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 06:15:05 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SBF107122618;
	Wed, 28 Aug 2024 06:15:01 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v5 0/5] Introduce J742S2 SoC and EVM
Date: Wed, 28 Aug 2024 16:44:58 +0530
Message-ID: <20240828-b4-upstream-j742s2-v5-0-9aaa02a0faee@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIGz2YC/23OTWrDMBAF4KsErTtBM9ZvVrlH6UK2R40KiYPki
 Jbgu1dJIU3AyzfwvTdXUTgnLmK3uYrMNZU0nVrQbxsxHMLpkyGNLQuSpKQhCb2Cy7nMmcMRvqy
 iQmD7YDRJj1pL0eA5c0zf99L3j5YPqcxT/rlvVLxd/+os4lpdRUBwvWeFA7rocT+n7TAdxa2r0
 pPvVt+pBBJM4DE6T6jN8OK7Z7++3zU/Bhu5C8Gzly9e/XuHftWr5iORU9FEa3F8+GVZfgGnNK/
 6cQEAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724843701; l=2049;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=ZbhS9vqMXDQr3e/dxFe0PuE+Ui9Wl7na/zvQAar0ygw=;
 b=fLFeZS+jnGO3f/wZu4/+77wPeLCXB60hpuF6ypLkqV4KM/WHHe7C0Jmh5lmabrWJFrIzmh72B
 HIyCh97jAZDDGU38eKdIjtt3CWbidEyzP5ZwTW08reCRNF5ja6ygnkX
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
Support and re-uses most of the stuff from the superset device J784s4.

It initially cleans up the J784s4 SoC files so that they can be
re-usable for j742s2 by introducing -common files. Next it cleans up the
EVM files for j784s4 in a similar way and then goes about adding the
support for j742s2.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v5:
- Rebased on upstream-next
- Align j742s2 and j784s4 comments (Siddharth)
- Link to v4: https://lore.kernel.org/r/20240819-b4-upstream-j742s2-v4-0-f2284f6f771d@ti.com

---
Manorit Chawdhry (5):
      arm64: dts: ti: Refactor J784s4 SoC files to a common file
      arm64: dts: ti: Refactor J784s4-evm to a common file
      dt-bindings: arm: ti: Add bindings for J742S2 SoCs and Boards
      arm64: dts: ti: Introduce J742S2 SoC family
      arm64: dts: ti: Add support for J742S2 EVM board

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |    6 +
 arch/arm64/boot/dts/ti/Makefile                    |    4 +
 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts           |   26 +
 arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi         |   45 +
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi              |   98 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 1427 +---------
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  150 ++
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 1437 ++++++++++
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2667 ++++++++++++++++++
 ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
 ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2847 +-------------------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  135 +-
 13 files changed, 4533 insertions(+), 4311 deletions(-)
---
base-commit: 195a402a75791e6e0d96d9da27ca77671bc656a8
change-id: 20240620-b4-upstream-j742s2-7ba652091550

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


