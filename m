Return-Path: <linux-kernel+bounces-433016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EEA9E52F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E171661BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A083F1D90D7;
	Thu,  5 Dec 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m+1Dov+N"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF12391A1;
	Thu,  5 Dec 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395860; cv=none; b=XEGu0saes2CJvAbDDAaRbtO3HLyqhsA90m6Mjc7BcYBnQrn2F7LVd7nRvrOH+QkZH9lk+EvGnWR7xGQnkLGAf5NckdI+hwsyfB8k8VPPH5iIIvXIm8tLFKoFXTc5sMazZD2tEeEkZAZ8Xz1Z+0Q7vawqk0ohaMEANqu00XTludM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395860; c=relaxed/simple;
	bh=JwGnOTughWEw0L4EB4HcOnQER2aVLmnERNZlRF2wnBQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lmMnuqviMqDSoLqbPqSOZj9LAfHA1dllNy+6GbxCveUn54B6GZ8sbXWGwh4WUehCjixhhPiucNQR4Yb+HMUmufFUkCoe8dcGfzD8CI5jM5lY3kQDuK5eg80FRBwrh6OLxY2+QKzVpODz3+PS4SOrGS8vyRDtsyHVZghI9rXSLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m+1Dov+N; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B5AokcL109449;
	Thu, 5 Dec 2024 04:50:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733395846;
	bh=aemKenByK1Wm9gLtV2/eR1Ty/NyvthyNtF1WcfPekrI=;
	h=From:To:CC:Subject:Date;
	b=m+1Dov+NKonZEedrdEWUuOAueDFn6/ex1AUwv1y0ihwgUM/4fs9j8qRqvb2m9HXnF
	 cqjKanmkgWmAUj+LTxeofLCHA29ccNHt74DhI0gvGzNIDnYzYmoAIKvOyuy4vVsLCH
	 ebHn7e9iREOIqf38bWtG8GajvYSelM7KvCA9oTTg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B5Aokfg070540
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Dec 2024 04:50:46 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Dec 2024 04:50:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Dec 2024 04:50:45 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B5AofJq110686;
	Thu, 5 Dec 2024 04:50:42 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 0/4] Add PCIe Overlays for J721E, AM68 and AM69
Date: Thu, 5 Dec 2024 16:20:32 +0530
Message-ID: <20241205105041.749576-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

This series adds device-tree overlays for enabling Endpoint mode of
operation of the PCIe Controllers on TI's J721E, AM68 and AM69 SoCs.

Only the second patch of this series has a v3 while the rest of the
patches have been newly introduced in this series. The reason for
grouping patches is the dependency on the Makefile w.r.t. the changes
made in the patches when enabling overlays.

v3:
https://lore.kernel.org/r/20241010100933.2492806-1-s-vadapalli@ti.com/
Changes since v3:
- Rebased on next-20241204.

v2:
https://lore.kernel.org/r/20240222065733.1213434-1-s-vadapalli@ti.com/
Changes since v2:
- Rebased patch on next-20241010.
- Moved vendor specific property "ti,syscon-pcie-ctrl" to the end of the
  node.

v1:
https://lore.kernel.org/r/20240220105006.1056824-1-s-vadapalli@ti.com/
Changes since v1:
- Created a new overlay for PCIE1 based on Andrew's suggestion at:
  https://lore.kernel.org/r/415ee6d4-fe26-4582-80f3-9b503d308fdf@ti.com/
- Updated Makefile to allow applying overlay on
  "k3-j721e-evm-pcie0-ep.dtb"

Series is based on linux-next tagged next-20241204.

Logs validating series:
1. J721E Overlay test logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/682d2469884d74ad73c3e6ab4b829067
2. AM68 Overlay test logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/b302475ee8ff257dab358a7ccfaaa734
3. AM69 Overlay test logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/c50e5a09b5af962cba722619974add2b

Regards,
Siddharth.

Siddharth Vadapalli (4):
  arm64: dts: ti: Makefile: Fix typo "k3-j7200-evm-pcie1-ep.dtbo"
  arm64: dts: ti: k3-j721e-evm: Add overlay for PCIE1 Endpoint Mode
  arm64: dts: ti: k3-am68-sk-base-board: Add overlay for PCIE1 Endpoint
    Mode
  arm64: dts: ti: k3-am69-sk: Add overlay for PCIE0 Endpoint Mode

 arch/arm64/boot/dts/ti/Makefile               | 15 +++++-
 .../ti/k3-am68-sk-base-board-pcie1-ep.dtso    | 53 +++++++++++++++++++
 .../boot/dts/ti/k3-am69-sk-pcie0-ep.dtso      | 53 +++++++++++++++++++
 .../boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso    | 53 +++++++++++++++++++
 4 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board-pcie1-ep.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk-pcie0-ep.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso

-- 
2.43.0


