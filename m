Return-Path: <linux-kernel+bounces-401793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF49C1F42
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8813FB24704
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA61F582A;
	Fri,  8 Nov 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bEFdS4w9"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E501F4FD3;
	Fri,  8 Nov 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076208; cv=none; b=WglOoO/GXeO6bwvpNHHPI5ETi4QZwobpQFcJ5rVbPRVq6nkg91+QI0F/L0zHd/Cy1+K31SxMGzELDSF3MoTrTNxNjGMJefVeQPM74VqfDvcCMDLjI37YOnIfkXDYj8uwfWdCJkNwYcshjdXGg6Gi3LowmWfXzmntK5ehfMIILNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076208; c=relaxed/simple;
	bh=mLzJ+0kFCZuXu1rRO3hscmiachlB9eNaapJLQWQe9pA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=es/EsAuNvNZS66DOpkCge06/xrzfGteiRCif8Vc0kdPRskJ4zk95SLWvNEepVIJsDFQJoaaINURLQawkb1L/fQCFHodfDmSzrZ+Aw9RTdz+tmMuUsc0omvXm5uNH/WOZx+yI6Mtac6FFqfVeXI7Vs4giz6sgE2s5HlDVzinUG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bEFdS4w9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A8ETnAr046784;
	Fri, 8 Nov 2024 08:29:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731076189;
	bh=DHwDBRm/kTZNcUg7348BUceEPUJFJgU9zgd2MT5a0zs=;
	h=From:To:CC:Subject:Date;
	b=bEFdS4w9eb0fOhJIZbzbqvOmvhga7+YeGMOCs6fONFTy1tXQ+10sqFXBlmNowM4Hg
	 bmFQzm/UbeF+KFRICcunrXZR8ZauDN541PMXd+8T/Gz2AxI0Yzc9FU8fwAaURfAAZ9
	 r26HzuRv96bS+Rgvx1jq/eJszLqo/xczOcgfqeSo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A8ETnA3104235
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 08:29:49 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Nov 2024 08:29:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Nov 2024 08:29:49 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A8ETnhm011246;
	Fri, 8 Nov 2024 08:29:49 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A8ETmve032063;
	Fri, 8 Nov 2024 08:29:48 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <nm@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <danishanwar@ti.com>
Subject: [PATCH v2 0/2] This series adds clocks for ICSSG for AM64x.
Date: Fri, 8 Nov 2024 19:59:44 +0530
Message-ID: <20241108142946.2286098-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

PATCH 1/2 Adds the dt binding necessary to add clocks to the device tree.
It adds the `clocks` in the dt binding of ICSSG node.

PATCH 2/2 Adds the required clock to the ICSSG nodes. It also changes the
clock used from clock 20 (ICSSG_ICLK) to clock 0 (ICSSG_CORE). This patch
adds the clock-names, assigned-clocks and assigned-clock-parents to icssg
nodes.

There is no additonal driver changes needed for this binding change.

Changes from v1 to v2:
*) Droppped assigned-clocks and assigned-clock-parents from DT binding as
suggested by Krzysztof Kozlowski

v1 https://lore.kernel.org/all/20241107104557.1442800-1-danishanwar@ti.com/

MD Danish Anwar (2):
  dt-bindings: soc: ti: pruss: Add clocks for ICSSG
  arm64: dts: ti: k3-am64-main: Switch ICSSG clock to core clock

 .../devicetree/bindings/soc/ti/ti,pruss.yaml         |  5 +++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi             | 12 ++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)


base-commit: 929beafbe7acce3267c06115e13e03ff6e50548a
-- 
2.34.1


