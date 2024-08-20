Return-Path: <linux-kernel+bounces-293790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E21D9584D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE3EB24759
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD2918DF94;
	Tue, 20 Aug 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="irjcFgNj"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2AA158A18;
	Tue, 20 Aug 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150444; cv=none; b=UPQoDlDSYdGXzYh+4S95eX/ulOhm9i86nQar8WHpOj6NsCnScEDO+TceMRJvYVP4aL09RxO7iYIZTMdHGEsUOrNxwGtcXM9aN1jTDtqb4MYRyeVoaxxInS+RHzaBg+z3c5eQvnJ2w/vDRWSFbuuZXAO6jGKd055HFu1gDlsYh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150444; c=relaxed/simple;
	bh=I7gljczWOTnwTqA39gsqoOavTdMz5KXva1tRZCSbHB0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qs3+F+l7wuwLH/b8Sin9w8o4QrDxajACBTzvCBMeAUzTXLt1d6fL1Gdsmjtmlw3x6Q9hMSqoBkq6UB0RXEQI2byQtyeYCZ0CLS2D2512jtmswquNulaMH2AcY4hvXLX7YhxlIWtkYOZt5Uu4TFrIqGtKZjQcC0jpBeXlCo1c7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=irjcFgNj; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KAeZm8023271;
	Tue, 20 Aug 2024 05:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724150435;
	bh=x1ieOOvg8Az0JhJ+IBph1TRufuTwM6QG2n7UviptWW0=;
	h=From:To:CC:Subject:Date;
	b=irjcFgNjOldWyd9gg2jlBMtO0bm3lGI19uVXJ/Qmn/YaKtkMQ5pkun73sHWWIyWgv
	 jS07nlZBcLdXyzpL+dxwBK/3bQysjpIC5hygKbvcTgeKvJTZWocQ61wJbAZ36HNE2t
	 MfodGuDcCdDPaaZum5jpVvLFUXF65wE0FzeoYwFw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KAeZM1010808
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 05:40:35 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 05:40:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 05:40:34 -0500
Received: from localhost ([10.249.48.175])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KAeYHC107601;
	Tue, 20 Aug 2024 05:40:34 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>, <bb@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/4] Add R5F and C7x DSP nodes for AM62a SoC
Date: Tue, 20 Aug 2024 05:40:30 -0500
Message-ID: <20240820104034.15607-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch series adds R5F and C7x dsp processor nodes and shared
memory based Virtio/IPC configuration for AM62A SoC.

changes in v4:
*) Fixed typos in patch4 commit message.
*) With the updated binding doc for AM62A C7xv in the kernel tree
   earlier reported DTB warnings have vanished.

v3: https://lore.kernel.org/all/20240605124859.3034-1-hnagalla@ti.com/

Devarsh Thakkar (2):
  arm64: dts: k3-am62a-wakeup: Add R5F device node
  arm64: dts: ti: k3-am62a7-sk: Enable ipc with remote proc nodes

Hari Nagalla (1):
  arm64: dts: k3-am62a-mcu: Add R5F remote proc node

Jai Luthra (1):
  arm64: dts: k3-am62a-main: Add C7xv device node

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 11 ++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi    | 35 +++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 23 +++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts     | 68 +++++++++++++++++++++
 4 files changed, 137 insertions(+)

-- 
2.34.1


