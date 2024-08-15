Return-Path: <linux-kernel+bounces-288589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F4953C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802C6285A19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20FF1553A6;
	Thu, 15 Aug 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YaLmD0Sx"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F014F9FE;
	Thu, 15 Aug 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754929; cv=none; b=KMrmYtw+6g8e2lfp0HMG2RbsMp1iFWb9h1M/bCnSFXOYp3O6+KCfgPo1SH3sgaRmAVPkb04x5KDYnf4c6RUXgNyJYzZ8/UX5dLKMKXEpPfYpZM2nzguTLRrIIP+qDSETzs1nz+yA3pSwVxvCy1SzaGvOrQakGDF64TA+Ud278Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754929; c=relaxed/simple;
	bh=UUxjqCtHRs4/YFQ0S65MUthxIXAoaLy7cH43jHPHGVw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PIn4yqW/JANMaJrjlyfsqj9k+hN3sdfxvIqqA8EY9FLXHjibohDT/J1Km3GLynG15tEulakFyNdbcnchGcX79raP8nHlDUmnBRPKgjVhyJ7t6B4Q6D7zLaOdIOrUELw3UwXv9V4M8+eufK9WNzU2mDGtEBLOxRMFCvlYOdNtKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YaLmD0Sx; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmZ5O003231;
	Thu, 15 Aug 2024 15:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723754915;
	bh=iTWfizhycS601geLHxvBEQYyxlLaflRpYEEXjAX6VsQ=;
	h=From:To:CC:Subject:Date;
	b=YaLmD0SxAhvv++E13TcBbStJ6LHng78Ko0h5wUHqCwQ1Iaj0hXS1CDQea8H3iEJ/c
	 Nv+ChuE6kcr0t5Hs2uPfU3BppGRb3TzY0a6fksFZuwJ+QVJKReMhC7iLY48FWTQYG4
	 C/hD7ZUoUISRVGsCEkSl2Prg/w38lLn3BZbZM/gs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FKmZjK059130
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 15:48:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 15:48:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 15:48:34 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FKmYNs052918;
	Thu, 15 Aug 2024 15:48:34 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>, Judith Mendez <jm@ti.com>
Subject: [PATCH v3 0/6] Add and fix ESM nodes
Date: Thu, 15 Aug 2024 15:48:27 -0500
Message-ID: <20240815204833.452132-1-jm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The following patch adds ESM nodes and fixes ESM source
interrupts for Sitara K3 platforms. Currently watchdog cannot
reset the CPU because of misconfiguration or missing ESM node
in DT.

ESM node was added for am62ax and am65x. For am62px ESM source
interrupts are fixed. Comments were also added for clarity on what
source interrupts are routed to ESM based on device TRM.

ESM nodes like MCU ESM for am65x are added for device completion,
currently, some ESM0 events are not routed to MCU ESM, so watchdog
cannot reset the CPU using the current implementation.

Changes since v2:
- Fix commit message for patch 6/6
- cc linux-arm-kernel

Judith Mendez (5):
  arm64: dts: ti: k3-am62a: Add ESM nodes
  arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
  arm64: dts: ti: k3-am62: Add comments to ESM nodes
  arm64: dts: ti: k3-am64: Add more ESM interrupt sources
  arm64: dts: ti: k3-am65: Add ESM nodes

Santhosh Kumar K (1):
  arm64: dts: ti: k3-am62p: Remove 'reserved' status for ESM

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi               | 1 +
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi                | 1 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi              | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi               | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ++-
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi  | 4 ++--
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi               | 3 ++-
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi                | 3 ++-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi               | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                | 8 ++++++++
 10 files changed, 42 insertions(+), 5 deletions(-)

-- 
2.46.0


