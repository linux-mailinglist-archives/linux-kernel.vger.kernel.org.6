Return-Path: <linux-kernel+bounces-230491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F943917D95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B0D1C216CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A150177998;
	Wed, 26 Jun 2024 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CP/yWKeO"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A616089A;
	Wed, 26 Jun 2024 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397014; cv=none; b=HrYUdGewEQcUroU4D+nGNHg4eCqNqBI3nRi2/FTAdy6bdyF4RZfXwxiKv0IWcp5rLozhPlhhOLMHiuc3PD+3muaP3Ds3Qvrn9kPjdENHjstVdkMlqVingvOOD0Z+6rWWRdEO2iVvyTamiwFDHwPVG2y1s2YEMe4Pp9LhrUIUKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397014; c=relaxed/simple;
	bh=Ep4U3OkPPZTIcBWPx+19jCGjtqPhQnVHpwjFL+W/Bc0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JhE1+B3A1ZLobqSGEs5y9Hid9d8+csFYAdxt4FiLTziX5LSit/q0p9QueTfnVVK/Srph6QAiFjh2GlOAAZB9GsKgt/bgJmXeQxxb6MlseE/4lPeOslGQjp/PfQHZzX/PhlgExLg/cyvt9OZHtz8nFNmaCIPut5ZBYVX4xv9wR+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CP/yWKeO; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45QAGl7B102197;
	Wed, 26 Jun 2024 05:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719397007;
	bh=YJXho8AVdwhK5yCk/v+SUMui3th4HKFl1eVnAGhcQIY=;
	h=From:To:CC:Subject:Date;
	b=CP/yWKeOX3FpA53wXfxjYyqGX5pTFAj2vTnzypoMZW4b+c19vYOt9nDJ3MlKgmrNx
	 JiiQe3FcuAADBoDpCvdKs/FTA/d9daPEnvloIJRdqv2wIu2dMoftM5UJh+UrOuxVb1
	 KClfGxl3U+OgQOxr+6wyAmnpFjEW6DVo2YT86FLQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45QAGlTY003512
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 05:16:47 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 05:16:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 05:16:46 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.248])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45QAGkWC094542;
	Wed, 26 Jun 2024 05:16:46 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <j-luthra@ti.com>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v2 0/3] Enable audio for J784S4-EVM platform
Date: Wed, 26 Jun 2024 15:46:42 +0530
Message-ID: <20240626101645.36764-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello All,

These three patches enable audio on J784S4-EVM platform.
- First patch adds the McASP nodes.
- Second patch adds the audio_refclk1 node that is required
  to configure the CTRL_MMR register for the external clock
- Third patch enables the analog audio

For audio to work, the ti-dm firmware that should be picked
for uboot is now publically available and will be shortly
merged to the ti-linux-firmware branch:
<https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/tree/ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f?h=ti-linux-firmware-next>

For testing, ~/.asoundrc file was created in root partition
which can be seen in the test logs:
<https://gist.github.com/Jayesh2000/3ca38cbac2f37842b1010af79dfe9b4c>

Changelog v1->v2:
- Rebase on tag next-20240624
- Add padding in mcasp reg property
- Add assigned-clock and assigned-clock-parents property for mcasp
  for more accurate description
- Change mcasp pinmux node name similar to other nodes
- Fix typo in k3_clk node and remove unnecessary comments for refclk1

v1 patch:
<https://lore.kernel.org/all/20240619095253.290552-1-j-choudhary@ti.com/>

Jayesh Choudhary (3):
  arm64: dts: ti: k3-j784s4-main: Add McASP nodes
  arm64: dts: ti: k3-j784s4-main: Add audio_refclk node
  arm64: dts: ti: k3-j784s4-evm: Enable analog audio support

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 111 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi |  99 ++++++++++++++++++
 2 files changed, 210 insertions(+)

-- 
2.25.1


