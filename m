Return-Path: <linux-kernel+bounces-377889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F32D9AC81F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA481F222CC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07241A2642;
	Wed, 23 Oct 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k3Swi63j"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359419CC20;
	Wed, 23 Oct 2024 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680346; cv=none; b=Ef4eXMNXVHdvMMn0QM2donkMuhvtGSHWnVtNzvKN+FK8IR8698VCK89EOujIyS1wN2qbuGCAHV5NeptoLtxrPzChkhSAPrJUIj9L5QqGx6LZE1xLQUIwnh5pAXTuIfaWIxfcg7EyDslFriT5Vf3m9LakjC6/+R5ktBVIWYqpKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680346; c=relaxed/simple;
	bh=2UfxoJCdQX+zrGwIUniIub7eBOWzMwOUmkhc7uEiPUE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dnD9ZXaurz+9jLMKx89Qmv2zeCWGOrEmYgHXWBPZumbuOZKjHcVvsT2UnBQwaD7xxo6bKmAvPwh3GXCYFauMm3xompEU59GLqM2evbxVSF14rWdAte24Vk3GA96CPL3oibXC7thHyWJtArD4IaDSnmPkmJvt3in9At+2OMrF1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k3Swi63j; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjb1v001673;
	Wed, 23 Oct 2024 05:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729680337;
	bh=OOav69xrLjc1Tf8Pp64sba+N+3XprTxwBkpV+TNsfYQ=;
	h=From:To:CC:Subject:Date;
	b=k3Swi63jh4eAsbUspTJcyyM6Wjpl6wek4cbRnuOzzyW5qN3ziHe+cafZ6nb3XwgZq
	 zg1VOtopHA+AyFgU91TzqRZ/J58bveFph3Le0aZzF0RioVpHOQ1v1do3ZWMuy+EZOn
	 vwtzlUdl++An6LJKpS/wiNhpdnGN5LaXccZSSVrw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49NAjb4I070855
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 05:45:37 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 05:45:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 05:45:36 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.112])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49NAjW1r014331;
	Wed, 23 Oct 2024 05:45:33 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vaishnav.a@ti.com>,
        <j-keerthy@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH 0/4] MCSPI clock ID fixes for J7200/J721E/J721S2/J784S4
Date: Wed, 23 Oct 2024 16:15:28 +0530
Message-ID: <20241023104532.3438851-1-a-dutta@ti.com>
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

Hi all,
This series fixes the clock IDs for MCSPI instances across:
1) Main and Wakeup domains in j7200
2) Wakeup domain in j721e
3) Main and wakeup domain in j721s2
4) Main domain in j784s4

In j7200, kernel crashes were observed due to incorrect clock IDs.
In j721e/j721s2/j784s4, there was only a mismatch of clock IDs w.r.t
documentation, however it did not trigger a crash. The clock IDs can be
verified from the below links.

Documentation links:
J7200 - https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
J721E - https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721e/clocks.html
J721S2 - https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j721s2/clocks.html
J784S4 - https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/clocks.html

Test logs:
J7200 EVM CRASH - https://gist.github.com/anuragdutta731/2733fab2d734eea67bd5ad64a2ad982a
J7200 EVM SPI TEST - https://gist.github.com/anuragdutta731/e7f7610a0ff016415d5f58ff314a8c81
J721E EVM SPI TEST - https://gist.github.com/anuragdutta731/d8e63b1298e0c074f6a29544f30c3e87
J721S2 EVM SPI TEST - https://gist.github.com/anuragdutta731/48f6e67f776c025ec98ebe0809dac4a1
J784S4 EVM SPI TEST -https://gist.github.com/anuragdutta731/7c1367c9d0308c5b67a4efa579594970

Anurag Dutta (4):
  arm64: dts: ti: k3-j7200: Fix clock ids for MCSPI instances
  arm64: dts: ti: k3-j721e: Fix clock IDs for MCSPI instances
  arm64: dts: ti: k3-j721s2: Fix clock IDs for MCSPI instances
  arm64: dts: ti: k3-j784s4: Fix clock IDs for MCSPI instances

 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi        | 16 ++++++++--------
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi  |  6 +++---
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi  |  6 +++---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi       | 16 ++++++++--------
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi |  6 +++---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       | 16 ++++++++--------
 6 files changed, 33 insertions(+), 33 deletions(-)

-- 
2.34.1


