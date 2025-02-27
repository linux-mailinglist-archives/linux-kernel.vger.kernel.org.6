Return-Path: <linux-kernel+bounces-537185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F511A488F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F4C168FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503826F467;
	Thu, 27 Feb 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KEn55KSf"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4A26E95D;
	Thu, 27 Feb 2025 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684363; cv=none; b=Ymo3L9dKz/QCsE8b5pGdAT1M7lc0wOS2BKDet+wZpoBT1jTLPFdOth0ZEYCvlwvpkwSsPC33NIstDkH+wVlJUlnfJMuytMUQ/BRaOyMmahFIDF9CUklw843JGvEHp3XfmZL5zrtC82IeVdyGGpYtlvR2EshhWdrW8tqSXbvXOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684363; c=relaxed/simple;
	bh=+MnmQAWHaliLVDUS1hWbgMPHvuQn4za/3sOMfuhi2tg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mve14Sny01Z4KkCANuae3v3ucRZObHC6cMQ61XZl/wnbxwp2s8HHDyWrFKFEZcHycKay41W7nYKCyuBCi/+Tvg/OXSqPQlv7apaI626yCOe/0nX8ORAbGio6VuuLZxgCcPVRlbsvmKejx/mdRhFPj9V9+iv0cmL6cVf4ROX2iIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KEn55KSf; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RFjKPt005358;
	Thu, 27 Feb 2025 11:25:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=L+Ymq3rUGoUbchUwObBot+u
	Zi50aDDGM2O9Rfhoc+HQ=; b=KEn55KSfKjOgs+58LJClx6Gp2al7aRI4Rf0MOEz
	0UpNy8WIyjqnxAO81CTwvEq8noosLoQQgogsrBxKKqHOq3afDOjbW3OrLeyki1hR
	I4lwa/9svz5mbjkUVfZTyGBBSD73TG9v60fcSZ0/O4DbfUP4uAyT+TrHBb16gjAF
	xOSeAPm+yPbftSwuRCQcOlYfjfc+3uffkc3pmhHIevqiqZ4o++PTJ9vAL0cd8coi
	79amE9Pr6sDHr9hSWqHDZSs41h0qB0PkCDyRoD/GYaCgXIMSJGrlcdaokzqTwg9D
	E+NwFd6tUVPZPMv2W/8lbOAGliydm6FkOwrjOudnUJGiSbw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 452tyjrhbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 11:25:39 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Feb 2025 11:25:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Feb 2025 11:25:38 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id 1EA733F7079;
	Thu, 27 Feb 2025 11:25:38 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH v3 0/3] Add Armada8K reset controller support
Date: Thu, 27 Feb 2025 11:25:33 -0800
Message-ID: <20250227192536.2426490-1-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -cHPloBC-hxEftL3iYoYFCczjX1kjUaK
X-Authority-Analysis: v=2.4 cv=UIYnHDfy c=1 sm=1 tr=0 ts=67c0bc33 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=T2h4t0Lz3GQA:10 a=Jdwyv6mE_Hljsyy0yKYA:9
X-Proofpoint-GUID: -cHPloBC-hxEftL3iYoYFCczjX1kjUaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01

Armada8K has one simple register for unit soft reset, which is part of
the system controller register area. The simple reset code doesn't
support register access via regmap for the syscon devices. This patch
series created a new driver based on the simple reset code, and add
Armada8K support then.

Thanks,
Wilson

---

Changes in v3:
  - Abandoned the use of the 'offset' property to specify the register
    offset.
  - Dropped the changes to 'cp110-system-controller.txt'.
  - Created a new dt-binding head file to define the reset lines.
  - Fixed the errors and warnings reported by dt_binding_check and
    dtbs_check.

Changes in v2:
  - Created a new driver for SYSCON device instead of extending the
    simple reset code.
  - Allow to retreive the register offset from the 'reg' property as
    an alternative to the 'offset' property.
  - Allow to retrevie the register size from the 'reg' property to
    calculate the number of reset lines.
  - Added the new dt-binding files to document the device-tree scheme
    and fix DT check issues.
  - Updated the device-tree node name to 'reset-controller' to follow
    the name conventions.

Changes in v1:
  - Init version.

Wilson Ding (3):
  dt-bindings: reset: Add Armada8K reset controller
  reset: Add support for Armada8K reset controller
  arm64: dts: marvell: cp11x: Add reset controller node

 .../reset/marvell,armada8k-reset.yaml         |  48 +++++
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   8 +
 drivers/reset/Kconfig                         |  12 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-simple-syscon.c           | 188 ++++++++++++++++++
 .../reset/marvell,armada8k-reset.h            |  27 +++
 include/linux/reset/reset-simple.h            |   3 +
 7 files changed, 287 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
 create mode 100644 drivers/reset/reset-simple-syscon.c
 create mode 100644 include/dt-bindings/reset/marvell,armada8k-reset.h

-- 
2.43.0


