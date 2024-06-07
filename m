Return-Path: <linux-kernel+bounces-205668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B98FFEA9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CCA1F21373
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973CC15B552;
	Fri,  7 Jun 2024 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W4s97uAV"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBB5156C5B;
	Fri,  7 Jun 2024 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751087; cv=none; b=IogKKfW4naxXCV82PycrFFOt9sGzyskUyi5GqqYi+BS6MpifkC2CgmeIfBGXp8gmUisfWQo4SiJqkxBaeA9EN/U4hPLqoQVwnvg2O2iwTkYRrt9/MHFdWOW3qIYev6dQ+V1FdKi9qXtshdk+pCsSzShQa0rvzoHyUbxUxqyCTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751087; c=relaxed/simple;
	bh=xNItBElWRVuDgAbIu90ivdQtKSZ8YobEEovA3ThLLfY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f3Kfpe7EPZknFtQH73vTlzb/2snoMXeEYE8z+m7kmQcSCHXQaI4kSo9TDLESpgBg0tJNTlsDt4RfWr0/I6hgQuIz5heZstzYHXbsEkReijWwcykZ+CKhUPBl7Mk6tZYSadEzpiJ4jE7xnJODgPd/KRtmZZheutKAtVw5gM3/a7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W4s97uAV; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45794cbw002038;
	Fri, 7 Jun 2024 04:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717751078;
	bh=ddqewlg42FOznsMk3m//MzR7Do45DLsbFLW7WDkGuuQ=;
	h=From:To:CC:Subject:Date;
	b=W4s97uAVxTQw5rmxk9gKT2pl2J2Yu9PDORJRY1vMJuXY36j4rxX0CaML3a0q2yEha
	 uFM+YuRR0HbVL3MkP0oRVrySaL8SyK8A9RMGCo26pYzUR0+eTiqyWIdG4s3coprXNA
	 t7LKDHDtD3Q0zAdvWVPH3NNWccto8C5raBro84RM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45794cNp011072
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 04:04:38 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 04:04:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 04:04:37 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45794Xgj020305;
	Fri, 7 Jun 2024 04:04:34 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH 0/3] Add Remoteproc Support for TI's J722S SoCs
Date: Fri, 7 Jun 2024 14:34:30 +0530
Message-ID: <20240607090433.488454-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
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

The K3 J722S SoCs have one single-core Arm Cortex-R5F processor in each
of the WAKEUP, MCU and MAIN voltage domain, and two C71x DSP subsystems
in MAIN voltage domain. Thus, Add the DT Nodes and memory carveout
regions to add remoteproc support in J722S SoCs.

Apurva Nandan (2):
  arm64: dts: ti: Add R5F and C7x remote processor nodes
  arm64: dts: ti: k3-j722s-evm: Add memory carveouts for R5F and C7x

Beleswar Padhi (1):
  arm64: dts: ti: k3-j722s-evm: Enable Mailbox clusters

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 140 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi    |  63 +++++++++++
 2 files changed, 203 insertions(+)

-- 
2.34.1


