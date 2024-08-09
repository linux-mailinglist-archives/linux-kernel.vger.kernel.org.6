Return-Path: <linux-kernel+bounces-281237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 572EB94D4B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F921F22C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31B41990C4;
	Fri,  9 Aug 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u7tQ+cFA"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F753182B3;
	Fri,  9 Aug 2024 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220919; cv=none; b=CTro/EFfnwas+YKSTCcTAS6S/NyoHdZvdoSN6emFbaY2beCPh+6ijsu3NeFuP0E4fyC6FArrp35XzN33gEjCSfDuig5hy+sTPXRbPo5wpdaRDvmHRlfOe87Ovr1bTufZX4O9wgmRGm5KUC7qmnPgy61RD6Q+rv/kmSYv4066FBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220919; c=relaxed/simple;
	bh=gxsH5xLxbmWG2slYJ2FaXvLF3FGiDx1keyZxsof9LQE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PF3r9Tw2owPu6MqjYtRnA/oWzTpbNYOGHQP+2/JwbafNJiBOU9Y2QnGqbjjCFnGFWnDzaBu5h5qveJdPEne7fM8OeOouUgXo/3IKq9nuGXY5JzZLx7K63JNMkOuCkq/ZpRNp9SsXAd+38erJc0yazHy0yTlJ/abaLPQvE19Cew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u7tQ+cFA; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 479GSUjU027484;
	Fri, 9 Aug 2024 11:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723220910;
	bh=mKXJZ2HttY0CuAP2torj/XbsITXI8iaQFG3lN3uFhdY=;
	h=From:To:CC:Subject:Date;
	b=u7tQ+cFABGkIqif6APTsFLVJc//gaVYvJEszmUuJjg8PvDc54T+IwlVW5wN6gloga
	 BiV3Dyd8JqY5PH/hbXWDLxE2z4R/ylp7RnIY+lV+zr9qYX8AwyEBzueTZC/vA9qea1
	 70RnG78A0MnAgTWuI/n8DkFAhQr8Vw+9n4eUgc1s=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 479GSUbD013371
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Aug 2024 11:28:30 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 11:28:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 11:28:29 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 479GSToU003247;
	Fri, 9 Aug 2024 11:28:29 -0500
From: Jared McArthur <j-mcarthur@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Jared
 McArthur <j-mcarthur@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3-am62p/j722s: Add gpio-reserved-ranges for main_gpio1
Date: Fri, 9 Aug 2024 11:28:26 -0500
Message-ID: <20240809162828.1945821-1-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

The current main_gpio1 gpio controllers for the am62p and
j722s have holes that are not obvious to a user. Add the
gpio-reserved-ranges property to the davinci-gpio properties list and
add gpio-reserved-ranges to the am62p and j722s device trees. Prevents
users from trying to access gpios that don't exist.

The holes are taken from the am62p datasheet [1] (Table 5-24) and
am67x datasheet [2] (Table 5-27).

Patches depend on patch: dt-bindings: gpio: gpio-davinci: Add the
gpio-reserved-ranges property [3]

[1] https://www.ti.com/lit/ds/symlink/am62p.pdf
[2] https://www.ti.com/lit/ds/symlink/am67.pdf
[3] https://lore.kernel.org/all/20240809154638.394091-2-j-mcarthur@ti.com/

Best,
Jared McArthur

Jared McArthur (2):
  arm64: dts: ti: k3-am62p: Add gpio-reserved-ranges for main_gpio1
  arm64: dts: ti: k3-j722s: Add gpio-reserved-ranges for main_gpio1

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 1 +
 2 files changed, 2 insertions(+)

-- 
2.34.1


