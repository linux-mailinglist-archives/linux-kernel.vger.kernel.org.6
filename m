Return-Path: <linux-kernel+bounces-281591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495C494D88C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC911C221A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD5116A923;
	Fri,  9 Aug 2024 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hgOt9hYd"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DC12E7E;
	Fri,  9 Aug 2024 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723240887; cv=none; b=sGeQwLu7a6U3VWcTXDKiAnkvWq9W0/1Ocsp/NQ3Fm7a8g2X27daFZuP1kULYKk/m0+esT1sDNh5ECLu6xPuZeC0KrQiCPZHGjLk3fIrk8nNGI4LzEgOr1NQrI8tMvuI8mTkndE5BWM89eR0jJmtA0U3pEmiYwd2XVHe3YrRDXEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723240887; c=relaxed/simple;
	bh=K+vTRuXQhg2g2Cl9c/PlxSOeXUMRVvF1bnbXDavpV8I=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=i5jdRuijHKxZInoerya3REzl0MUcVc/EUBgj//myL7IvjPvCbqu7G8v429yQrEAfYkARkGUSFPDKW59FKpJ5xGi9NR+l2rfnqdcNDPxcyaF7/lh+ZEVfWmGubEg6TpORny8cqBTWDis81uhT4dNxrDbynOvLJL33rNIHsYuyNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hgOt9hYd; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 479M1IeP094187;
	Fri, 9 Aug 2024 17:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723240878;
	bh=0AwIn1yzR3Qv1t6EnQVJ7ST/Hs15gCpAdMy8g2D6Hw8=;
	h=From:Subject:Date:To:CC;
	b=hgOt9hYdp90NM+KENvMp0qOsJ5PTxtOHlrD9NLyqmFcQezuPjEN/MKLNIgcktVVb1
	 zG3DmMdRJ8vHM7QprrficES4d6MLYvD92bnib4UdWs1zhp721w5fJ335SEEBplkOuH
	 Oa93+Sittlh4oM5pm1PMwqbYI9nMMhD+kwjgeSco=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 479M1IQG066443
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Aug 2024 17:01:18 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 17:01:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 17:01:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 479M1I7F008541;
	Fri, 9 Aug 2024 17:01:18 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3-am62{a,p}x-sk: add opp frequencies
Date: Fri, 9 Aug 2024 17:01:12 -0500
Message-ID: <20240809-opp-v1-0-fea8efeaf963@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKiRtmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNL3fyCAl3zNENjc6PENDNz82QloMqCotS0zAqwKdGxtbUAvhU60FU
 AAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello everyone

This small series add the opp frequencies for the Cortex-A53s on the 
am62px-sk and am62ax-sk reference boards allowing them to slow down when 
idle and save some power at runtime.

Happy reviewing
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (2):
      arm64: dts: ti: k3-am62a: add opp frequencies
      arm64: dts: ti: k3-am62p: add opp frequencies

 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |  5 +++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |  9 ++++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi              | 51 ++++++++++++++++++++++
 .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |  9 ++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi              | 47 ++++++++++++++++++++
 6 files changed, 126 insertions(+)
---
base-commit: e3cce1229c34b5c28f103361c4d6b3ef17302d5d
change-id: 20240809-opp-7f1372af677c

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


