Return-Path: <linux-kernel+bounces-296994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8643795B1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AED1C21A82
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF817DFF4;
	Thu, 22 Aug 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WUHSRTlD"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2953C17DE15;
	Thu, 22 Aug 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319006; cv=none; b=nH4q1PAAbAoLRQQhQIW2FMbYbNqAze3nDUjsh5eV8Ke0RTVD6iVQUETLjHMpntoV43bXUE811DFpsKP41s9CqptsTA3vjA5eFs3ltBBr5A23NMbOG1oxJqPnvsZZ5O/XyCg/mdcgNjP1k/jkM0Knvu0nu/aeeJ7xNMfCwhiItto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319006; c=relaxed/simple;
	bh=vE635Lc5z/M9QvXv2NOjlajuF+PEmMNNp1qCXCumk7A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U3JqLZXdfVF3ZM0abEaKu//g8t0fqGLgVdd3TZAKBNKAsXnVFRxm8QJXUrXLC0DD0KckHJaAedPj3PsOUqcWhuzgBMLHk8pW+UhZXHbNrIjHG/XPH8IUoD+mo8OJRA0boDIAXO3iHK0EGLOKOfdIk0vTT0dftJy/g1rMGeyzDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WUHSRTlD; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47M9Tt89125905;
	Thu, 22 Aug 2024 04:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724318995;
	bh=rmp36PZnOmxESdDClRtEZdeR5WRdLWua1AMScdftLvM=;
	h=From:To:CC:Subject:Date;
	b=WUHSRTlDHRdeXqOnBohHX/ZcrMWV7A12O6iiP484ven2nYamILpZjX1BzxeHOaC9M
	 NcmTLLhr0SuPWGqAxLElDVgpSSHAxjlHBqyp3bFqBhLzAiA47i4DIZICpBaIEPttyS
	 izfxth8nX3yU1VLSs66hZsU3uuy7QhNfJ2lGXpfU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47M9TtSw010775
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Aug 2024 04:29:55 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 04:29:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 04:29:55 -0500
Received: from localhost ([10.249.48.175])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47M9TtJh044820;
	Thu, 22 Aug 2024 04:29:55 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>, <bb@ti.com>, <afd@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/4] Add R5F and C7x DSP nodes for AM62a SoC
Date: Thu, 22 Aug 2024 04:29:51 -0500
Message-ID: <20240822092955.22037-1-hnagalla@ti.com>
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

changes in v5:
*) Reordered Remoteproc device node properties to list reset, firmware
   properties before vendor specific properties.
*) Remote the SRAM node from patch2, as it can be used by other
   components and is not specific to this patchset.
*) Added new lines between sub nodes as needed.

v4: https://lore.kernel.org/all/20240820104034.15607-1-hnagalla@ti.com/ 

Devarsh Thakkar (2):
  arm64: dts: k3-am62a-wakeup: Add R5F device node
  arm64: dts: ti: k3-am62a7-sk: Enable ipc with Remoteproc nodes

Hari Nagalla (1):
  arm64: dts: k3-am62a-mcu: Add R5F Remoteproc node

Jai Luthra (1):
  arm64: dts: k3-am62a-main: Add C7xv device node

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 12 ++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi    | 25 ++++++++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 24 +++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts     | 71 +++++++++++++++++++++
 4 files changed, 132 insertions(+)

-- 
2.34.1


