Return-Path: <linux-kernel+bounces-202636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C138FCF09
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A249B1C20C78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647A19EEC4;
	Wed,  5 Jun 2024 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xUucCDLu"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF69195992;
	Wed,  5 Jun 2024 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591749; cv=none; b=t9Y33DLGpWGwAXesJlJzuERJmdAKZw5BOspf4vl5vqpZpRg5rdRfRvzZIYLyjIWIL+3IqWnnmwoM4E6CSpigTbg7OyGXfgAXk7PW5OxvRG7PLkp4FLKaERtySXq5MBNoYCrJqVcO1BCLvRmFP5EbhGSrFgMGh2Cqn9AT7Xa125M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591749; c=relaxed/simple;
	bh=wNC6mnu72bYozpkCANqb2ky3dkgbU1dG47xJIw8VeRk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mUTa1CTyZF6a3F5qKX4nQ6yJL97GEAVXt6mcWRXwcelznqI8+obqigP1PFExYlpEJRTV6o7lb1w4RXxhO+pcfCn5SRNyiasYgrIHTfs014G1NYGvsgM4m0pm2WqvDLxiYPmaXrHrMA6alyjI04zguuDYNzy9sDozpsyucvMbgNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xUucCDLu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 455Cn0u4006025;
	Wed, 5 Jun 2024 07:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717591740;
	bh=vHCfgc/NypSfFvGSaM3QEITtiq4xIvoTtGTSNIoEtN8=;
	h=From:To:CC:Subject:Date;
	b=xUucCDLufJDakECJfpPPRI3WS0e/Sv4Ix5Qa52upJoCedu2zgIA8kbkcfyuJAwt0N
	 p6uD+cziQlD2R6yX4lCdh4DKfzrjDmVoqVE7l1wbpgeUZRWScUrO7INFBscNgZ00SK
	 qt+DQZs24d2rXj2LeU0FQ/3ooP9YDnFV6rNaXTU8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 455Cn0aZ111445
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Jun 2024 07:49:00 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 07:48:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 07:48:59 -0500
Received: from localhost ([10.249.48.175])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 455CmxPr108864;
	Wed, 5 Jun 2024 07:48:59 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/4] Add R5F and C7x DSP nodes for AM62a SoC
Date: Wed, 5 Jun 2024 07:48:55 -0500
Message-ID: <20240605124859.3034-1-hnagalla@ti.com>
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

changes in v3:
*) Separated DSP node binding patch and submitted to remoteproc
   mailing list, rebased the patches to linux-next.

v2: https://lore.kernel.org/all/20230810005850.21998-1-hnagalla@ti.com/

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


