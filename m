Return-Path: <linux-kernel+bounces-349355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D7898F4B3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986B41C210DA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FB31A727D;
	Thu,  3 Oct 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ltlbQTJV"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD812C526;
	Thu,  3 Oct 2024 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974889; cv=none; b=S6IfcwIDP3/NB4Bdm1qVI3ftfG/WoIUmMjgahL49J143Vt3Su1V2GsdcGNPljKU/kSWhC8yjtCTbDddouTy+4x89jTt5zVfu1cbWdUO0hVQ+oAX/TXzJLHhVz44O8VePqqa9K2FyD90XvmLBBzJAIZrUebo35pMAZpKMxbtpPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974889; c=relaxed/simple;
	bh=4wf6T1Fnp0YFefUCUtllWmOoGNJ9ChroaHzCdDt+HPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bs28B6N1cnKHsaHKqMFjvq2MpLwYq/QG8FsUeAMijXF0L3OzkUHbfcgcDOZEDjHO+PNqrAQnAuB4wdfjqEQRjzHsc6BpJ5rXfKfZKywhr+8u21aqVCHZeOrkHcPbL2w9mRNGxTukdBs7Pq+82kYI05+/PTxLBt1Qj5ADzt5Kirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ltlbQTJV; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 493H1Jgr022819;
	Thu, 3 Oct 2024 12:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727974879;
	bh=ByOIm6peZ+NdZg0yyzFNDr3OoSg4LALHxOBhF+ABZvQ=;
	h=From:To:CC:Subject:Date;
	b=ltlbQTJV0pgV05Vmw5bEdAeiwR6BY2DSGJ3oCiWv7zpAWquxl6cLOlZ8dZmjxsqn2
	 PNqowhikPZVUcwCWN3x1sZitaiUie/1VloFYr+cDkch51sGJa2vgDvBMif/9FIo8NU
	 QEFxVlauVuKLpTjd10Wlhym6inz2/FiyJxNeLOuE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 493H1JNf030041
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Oct 2024 12:01:19 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Oct 2024 12:01:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Oct 2024 12:01:18 -0500
Received: from ula0226330.dhcp.ti.com (ula0226330.dhcp.ti.com [128.247.81.173] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 493H1IJZ034882;
	Thu, 3 Oct 2024 12:01:18 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v12 0/5] TI K3 M4F support on AM62 and AM64 SoCs
Date: Thu, 3 Oct 2024 12:01:13 -0500
Message-ID: <20241003170118.24932-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello all,

M4F driver[0] and DT bindings[1] are in, so last step is adding the
nodes to the base AM64/AM62 DTSI files, plus a couple of our
SK boards. These can be used as a reference for other boards using
AM64/AM62, or I can add these nodes for existing upstream boards,
just let me know.

Thanks,
Andrew

[0] commit ebcf9008a895a ("remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem")
[1] commit 9fedb829372d4 ("dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs")

Changes for v12:
 - Rebased on v6.12-rc1
 - Dropped taken patches
 - Added Tested-by tags

Previous series (v11):
https://lore.kernel.org/linux-arm-kernel/20240802152109.137243-1-afd@ti.com/

Hari Nagalla (5):
  arm64: dts: ti: k3-am62: Add M4F remoteproc node
  arm64: dts: ti: k3-am625-sk: Add M4F remoteproc node
  arm64: dts: ti: k3-am64: Add M4F remoteproc node
  arm64: dts: ti: k3-am642-sk: Add M4F remoteproc node
  arm64: dts: ti: k3-am642-evm: Add M4F remoteproc node

 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi       | 13 +++++++++++++
 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 19 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi       | 13 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 19 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 19 +++++++++++++++++++
 5 files changed, 83 insertions(+)

-- 
2.39.2


