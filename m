Return-Path: <linux-kernel+bounces-407462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEA79C6DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9A9B27AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841161FF7B5;
	Wed, 13 Nov 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kAb+8xex"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B701FA256;
	Wed, 13 Nov 2024 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496720; cv=none; b=WdDjTy6G558FpeUVxDoByth7RNHhJdACZNEgBNnTuIZXXzH96UTx0UMQ7/aLfe4ADMOm/gEs7SfUIQGU4VL1qt86bBEcG2fRyra/31KWv518/CfTgh/ihMWlfMN5eHVwrzobfgckXEgIC6YkyPH7GcSxuiHrshyhwqhPHA58ZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496720; c=relaxed/simple;
	bh=Ake7dgqJyZ++HhUsp0JvPQunF4zAFC6jaCfOHSqyUr4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lRQS2LUc8kx9EQij5/MUVaJILR4YPgljDthatgVznVVqLcIP9uo/0s+IPep0RniWSGC3xJE8G5E3mYVOd+lreJA5GKe/86qntaEPW2LB0sY1Jclpc65yJyCV8VYPR8ZIVHiVTajwiVnrhlPW6JiZ8XFM+unri+IS3zfOh1Q7skE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kAb+8xex; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ADB9xps2473553
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 05:09:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731496199;
	bh=gj6T3+0yCPgphcaSMUSbs+1SKIXkJ3ZDcoZDqgW4U/Y=;
	h=From:To:CC:Subject:Date;
	b=kAb+8xexK/LWFgyWs6DM0PPbc5UzVzvJOgwFz2/q5tIvPqss8AQc5mbeG2AwXN9Ta
	 elhLa3mvanzGwPDPwaOXIQR+xwkYzwXNWXlACCaADHgFY03AQuxvx9fgywae7cCIoM
	 S2ajFsw7TnqAaBMFygmiE7ZNCmcFUk924v77Rh3Y=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ADB9xxN006449;
	Wed, 13 Nov 2024 05:09:59 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Nov 2024 05:09:59 -0600
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Nov 2024 05:09:59 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ADB9xqV096947;
	Wed, 13 Nov 2024 05:09:59 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4ADB9wec021255;
	Wed, 13 Nov 2024 05:09:58 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH v3 0/2] Add Clocks for ICSSG
Date: Wed, 13 Nov 2024 16:39:53 +0530
Message-ID: <20241113110955.3876045-1-danishanwar@ti.com>
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

This series adds clocks for ICSSG for AM64x.

PATCH 1/2 Adds the dt binding necessary to add clocks to the device tree.
It adds the `clocks` in the dt binding of ICSSG node. Each ICSSG instance
has 7 clocks available to them as per AM64x TRM [1] Section 6.4.3 Table 
6-398. They are not added in the dt bindings yet. This patch adds all
available clocks to ICSSG bindings. 

PATCH 2/2 Adds the required clock to the ICSSG nodes. It also changes the
clock used from clock 20 (ICSSG_ICLK) to clock 0 (ICSSG_CORE). This patch
adds the clock-names, assigned-clocks and assigned-clock-parents to icssg
nodes.

More details on clocks can be found at [2]
There is no additional driver changes needed for this binding change.

Changes from v2 to v3:
*) Modified commit message of PATCH 1/2 to state why clocks are being added
to the binding.
*) Added all available clocks to ICSSG bindings. Earlier only two clocks
were added.
*) Added all available clocks to AM64x DTS. Earlier only two clocks were
added.

Changes from v1 to v2:
*) Dropped assigned-clocks and assigned-clock-parents from DT binding as
suggested by Krzysztof Kozlowski

[1] https://www.ti.com/lit/pdf/spruim2
[2] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am64x/clocks.html#clocks-for-pru-icssg0-device
v1 https://lore.kernel.org/all/20241107104557.1442800-1-danishanwar@ti.com/
v2 https://lore.kernel.org/all/20241108142946.2286098-1-danishanwar@ti.com/

MD Danish Anwar (2):
  dt-bindings: soc: ti: pruss: Add clocks for ICSSG
  arm64: dts: ti: k3-am64-main: Switch ICSSG clock to core clock

 .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 10 +++++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 22 +++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)


base-commit: bd05b9a700c10473c2f52bf12c5c5938c30e80b0
-- 
2.34.1


