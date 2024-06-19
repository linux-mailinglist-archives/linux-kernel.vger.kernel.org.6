Return-Path: <linux-kernel+bounces-220808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C490E76A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E481F21218
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF838563F;
	Wed, 19 Jun 2024 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fq82Bogv"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE084D2A;
	Wed, 19 Jun 2024 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790792; cv=none; b=c53FdgC2qPnPD2AyOlf/q6Lqzv5ekZ59mAIcJ13ZDj3cJzBM2ewwTKjwdtOpak00RMxAVTVlbl5YtwxTehfFN2SlQ+QZZL2hMkpmTjNcEbbH1mJ/29it7FpfZPH/FXzWEGnU5o8d/mue6Kz7EyBClPD1yw6zhrnDmMrGU8jBhVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790792; c=relaxed/simple;
	bh=UalK4FgyHTnNoyXIEwzKYcVxWmkuOK/O7WrYkoFllRo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sI32PhWvOcxVCf/e8JQiVrbK2/4jYcTaOsFPQhbyUokqiaolRdQzT2hH2yBFL8BW3A329y3tYsDqWh5OdUN9XunSiLY9q8Irk+LH51MT75nWU5NBjkq8eieE4OjSdt1kuwIcqH3f1PRqFM9eTXPR24MHdUqHmk88Ps01MNwQ6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fq82Bogv; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45J9qswF077162;
	Wed, 19 Jun 2024 04:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718790774;
	bh=EoejE/w5WmUZVOHtPE0B8+G2g4Xuaq7ZSJdNB5/KtMk=;
	h=From:To:CC:Subject:Date;
	b=fq82Bogvb87pMBQ/MUc5hwLwxF/rzzmrMTO76SF0G5L+u7DBsqhhLCyo9IMts7YGW
	 8707m1MHd/iNqtY1NiUzmfpxNzWIB1zeMrwpu+XkLzNbnqiw5Fx1w8I5qkFObAE4Ek
	 Jty8ajpvQ3x6636Rmzptyba4SA7mvt5nQsMPqKZc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45J9qsis070647
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Jun 2024 04:52:54 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Jun 2024 04:52:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Jun 2024 04:52:54 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45J9qrpK089878;
	Wed, 19 Jun 2024 04:52:54 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <j-luthra@ti.com>, <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH 0/3] Enable audio for J784S4-EVM platform
Date: Wed, 19 Jun 2024 15:22:50 +0530
Message-ID: <20240619095253.290552-1-j-choudhary@ti.com>
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


Jayesh Choudhary (3):
  arm64: dts: ti: k3-j784s4-main: Add McASP nodes
  arm64: dts: ti: k3-j784s4-main: Add audio_refclk node
  arm64: dts: ti: k3-j784s4-evm: Enable analog audio support

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts   | 112 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi |  89 ++++++++++++++++
 2 files changed, 201 insertions(+)

-- 
2.25.1


