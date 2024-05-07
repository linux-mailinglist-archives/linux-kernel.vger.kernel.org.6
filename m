Return-Path: <linux-kernel+bounces-171023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002948BDEE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934F61F22C86
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1456615E81C;
	Tue,  7 May 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iYrOa6MT"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8C15E7F3;
	Tue,  7 May 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075109; cv=none; b=Z51mYyVnCTbRGDwdbVQThGQcG84tun0ZsEqP56yXEgfHLqZMBT8peNUHqO/tvTd4AupCpTPPUHnRySBEMB3uAXSQcsOpE45ifFAUXNkpBQWdYiXtVWCYPt/+kMq2+eAK670OjR5IpnJqtipli1OeeQJKkrH+hwW1z5tFG+zfDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075109; c=relaxed/simple;
	bh=jCzU+rFjnQvRKC3i3pHmu0v2umfSoOOf24yDWdfrGuk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=igp4VQZRBom2j7clVO0c8N6IJNlAL+EfC3rPlMGgpR6S0Ydnb/gYQh1lvOsUWtJEV0NsP75Uc2UTeshCN7wYYr/qCJxDI5mAaIo0ukfYSIhPfWnjy42nT3+KBzcW7dU+MBGQ5LpOJxE8xuJqVZYOs/c9ljEinqgvpuFBzPouNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iYrOa6MT; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4479icKO104771;
	Tue, 7 May 2024 04:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715075078;
	bh=ZV0q5V3Y1PJnaGDWpRJNIVrfAmv68kDiSMCmuO8s+z4=;
	h=From:Subject:Date:To:CC;
	b=iYrOa6MTwxhMnmctZO1LxsJuHmZjC4Fqi9cwlOZSiDQgPOzcz5jq4zFnt+DLxdHeN
	 uenXwTj2jEYed5JvlgedoZWqA1ma2tqyX21bsUtwycp8XzsNKXPUlEALEHdw26+idf
	 af0p7aDsLLSIHTd2lkcLeFkfXa1hDXlh9aqVFLT8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4479ic7W059193
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 04:44:38 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 04:44:38 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 04:44:38 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4479iXjU117029;
	Tue, 7 May 2024 04:44:34 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH 0/5] Add bootph-all property for J7 boards
Date: Tue, 7 May 2024 15:14:27 +0530
Message-ID: <20240507-b4-upstream-bootph-all-v1-0-c6d52651856f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPv3OWYC/x3MQQqAIBBA0avErBswE4yuEi00pxyoFK0IorsnL
 d/i/wcyJaYMffVAooszh72gqSuYvNkXQnbFIIVUQrUCrcIz5iOR2dCGcESPZl2xc0pbLe0kZgc
 ljolmvv/xML7vB4OIO5VoAAAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715075073; l=2050;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=jCzU+rFjnQvRKC3i3pHmu0v2umfSoOOf24yDWdfrGuk=;
 b=BC3ymGLIqLvW/ED2GlyNtJnAfjX8u8LPLwQK1Rd2BM3qSSfmZAe0MSH7Cri1GdXWLfNonge4O
 mNL63UURMRsCqnxHopHhJpelLimbraau52yhZb36EKUYqoSpgwpwEvG
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The idea of this series is to add bootph-all and bootph-pre-ram property
in all the leaf nodes wherever required and cleanup any other places where
bootph-all/bootph-pre-ram exist in the parent nodes as well.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Manorit Chawdhry (5):
      arm64: dts: ti: k3-j721s2*: Add bootph-* properties
      arm64: dts: ti: k3-j784s4*: Remove bootph properties from parent nodes
      arm64: dts: ti: k3-am68*: Add bootph-* properties
      arm64: dts: ti: k3-j721e*: Add bootph-* properties
      arm64: dts: ti: k3-j7200*: Add bootph-* properties

 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi         |  3 +++
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     | 23 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |  2 ++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |  8 ++++++++
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     | 20 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  9 +++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             | 17 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |  5 +++++
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |  1 +
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       |  2 ++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 10 +---------
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         |  1 +
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi   |  6 +++---
 18 files changed, 141 insertions(+), 12 deletions(-)
---
base-commit: 11cb68ad52ac78c81e33b806b531f097e68edfa2
change-id: 20240430-b4-upstream-bootph-all-8d47b72bc0fd

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


