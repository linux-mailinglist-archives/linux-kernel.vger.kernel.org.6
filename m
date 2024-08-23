Return-Path: <linux-kernel+bounces-299694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA895D8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3181F22E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252BC1C825E;
	Fri, 23 Aug 2024 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CKurS1hj"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB746191F8F;
	Fri, 23 Aug 2024 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724450096; cv=none; b=MtmNoXU+px5DsxECHYx0JVqfLrC2wAs4XiU2BDQxIuDrkQvLH1QetVr0W4LO9N2ZJ2VfYqt8dzE3sC5A2P039RKjHLYzg0gd5ZIk1V66s+3tqlaNmyAy61QqrA8EuoQiEkfOGkW8ePsFlv2vimMROX1DuFQN1CVlQTluoDgJoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724450096; c=relaxed/simple;
	bh=t7sywom53WsaLukzdsDDBYmZsV0gPEF8xJb0wfON1bE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=PT0AwGacczHarhrOkYgaCI74Ki9uB4gftMUmLyvc+bRou750LC9rWqXA87+f/dnwBPIcJZz3DPtG4rYBqkeBBaAWTYhz/ujSxSHOtztVDqbNaDHzz9doHsmjHybd/E2EWjETcSmNFBU2n3W6b1EBgtjqv/eeqWggIkSSZ5cAvqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CKurS1hj; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47NLsaOb066576;
	Fri, 23 Aug 2024 16:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724450076;
	bh=qpDhikDY8YhDC+qR7BIbT5yM3q0AluoCab8OUmKiYsg=;
	h=From:Subject:Date:To:CC;
	b=CKurS1hjcSGdb+IjjMgbAbIa1rL2aJSAKeqBD1qInqxy1SfqfCxg3upydLx9DQzSq
	 B/2J4ukwFupSilnwxXMz8pjf3j/GS4w3REQRt76XcsWneTzK6m1UL2h8QXCm1KzR6R
	 Yrepi0/bbr36JEb3FUE+JVwT3D6+6Z3tmHzC9he8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47NLsa6f022451
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Aug 2024 16:54:36 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Aug 2024 16:54:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Aug 2024 16:54:36 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47NLsZiP123806;
	Fri, 23 Aug 2024 16:54:35 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 0/4] arm64: dts: ti: k3-am62{a,p}x-sk: add opp
 frequencies
Date: Fri, 23 Aug 2024 16:54:27 -0500
Message-ID: <20240823-opp-v2-0-e2f67b37c299@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABMFyWYC/1WMwQrCMBBEf6Xs2ZUklab15H9IDyFu7B5sQlKCU
 vLvrr15GXjDzNuhUGYqcO12yFS5cFwFzKkDv7j1ScgPYTDKXNSoJowpoQ26t8aFwVoPskyZAr8
 Py30WXrhsMX8OadW/9v9fNSoM5EaSCNPQ3zY++/iCubX2BbLy2FeTAAAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=bb@ti.com;
 h=from:subject:message-id; bh=t7sywom53WsaLukzdsDDBYmZsV0gPEF8xJb0wfON1bE=;
 b=owNCWmg5MUFZJlNZrIBLygAAa////v/7/n//e3f+t7d4X+dX+9/uf0/e7dKXX71dl7xW/+ewA
 Rm1Mh6gAAAAAAAAAADQ9QNNAANAeo0BtQAANAAAGmR6gBo2iZHqPSbKbT1Q5ADQ0A0aGEAAGjID
 ExAAAAAAAyaA0yM0DU0B6mjQAMmgH6oANAGExkh6nqNAGjI9QBoNDIaABo0GmmjTRkGQNDQAG1A
 NGgAAYmmRpoeoaADCANA0aAQSDlO04Qh66CedNO0eB4stDEhoIFSdMZrsGG9gfkJ1jCyW1BcUyG
 fQxP7iB94w4zlxIHFhQFlD6dimAuSxwSkVMbbSMdXiLl74sU0I7FGeILU+oUHMxDKoJTMim/XBY
 cDCJWugd/BPSsP1BFCBA75ypyDyL4z3XW4widWe/L5XWHFtdAHCYeacLPWhex6zjZMDECLbltS5
 qOVGRXfk3SF8u23YIOgNKOLkxN8xDyho9mS40KQtUw2BLiaDtgt1A4El7HaZFOQRVa/v+A2vXMV
 hnRNdQGcr0ZWIZZapT3utQ2sXBy58MASbmdfoUrDOiZCV/Lj0hNkqHFKp6g2mnzg6kkhcNKcfCa
 6ZkBEnigvdWQF4DbiihMQCkkHU6orxWhK5oDgnFmX5zMRGTqzU/u72ccFZ9gPgC+Ddc6JSMx/DR
 1B/i7kinChIVkAl5QA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello everyone

This series adds in the OPPs for the Cortex-A53s on the AM62Ax and 
AM62Px SoC families along with the defining the 
WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID which we can use to to properly 
limit the OPPs available for that variant.

Happy reviewing
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v2:
- Expanded on commit descriptions
- Split board file and SoC fdt changes into different patches
- Link to v1: https://lore.kernel.org/r/20240809-opp-v1-0-fea8efeaf963@ti.com

---
Bryan Brattlof (4):
      arm64: dts: ti: k3-am62a: add opp frequencies
      arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
      arm64: dts: ti: k3-am62p: add opp frequencies
      arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry

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


