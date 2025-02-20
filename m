Return-Path: <linux-kernel+bounces-524888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FA6A3E865
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1324917F25B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51329267AEE;
	Thu, 20 Feb 2025 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="U6M0fEFV"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B482673B9;
	Thu, 20 Feb 2025 23:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093946; cv=none; b=Xtd5AzIuNojPLIDTdqVWjNwwx+TPDAJf+yG4WTp1ZNjZBvyzYUUjMOuh6rIseXRrkLhIuEaqgo+cJF9deh3U4Zul3DU6tf1HPaKKslBt9q/Oojj5AKLjCvhNnCWZLJd5ybJxwH80nhBY3SHhLs02yjWnYEy+fe7oPc9pQ2ZsG4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093946; c=relaxed/simple;
	bh=Spj/goPUDzFGqkrCbwbufCYDfMYOvILE3tPpjpiLtdY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=un6c7wNnX8OY6o26/QeDY4WsARQDLtDJtdCF+te9SagtL9Z9ZSjW/6jtBU0e+KXAf5D2SQbcC1bxmi8diqC19gNlFACSdSiykBXWirzRkdYBR/1PwHEshjnUcd583qbr+8iKshWl7N3tHYc2MwFfyOEUbM/6veN/d/9VtI0I5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=U6M0fEFV; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KL98lf029271;
	Thu, 20 Feb 2025 15:25:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=qHxXlJmqY7Qeoukk/Mug5bb
	yhZku9Mld84zeeuVZBss=; b=U6M0fEFVS6NrWzJKPpEFRQM/dKtrZnJmQtiGvKM
	6c3eB1fCvZZCBnhmPPL023tV7VO/ej7phAmFhmU+D2CEo641XQpqCrjkXyz94HzY
	QP1VWpFDfFD0xBblYgERQiDGiMa8s0ofTkkzsn0KfWztB4jVFFagaHa/JTvnZz7I
	3D+BnJg5pWUmKhxvQW4rn7CcsOlfHMdPF6rF4iXNzsMi51dbQbzA696zZdnJ2vY+
	XWwxBWCAc8G1DLsMrw6MnQ+7DZyCrhrGHlmKJ4c1LtuGYpvSCNc7JQwdCwa2nl5d
	t2TalQ1tIoVNmxXe4IhVtsNGOoS8zoCPfh1VQcpC0vTOFOQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xc24r915-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:25:31 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 20 Feb 2025 15:25:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 20 Feb 2025 15:25:29 -0800
Received: from wd-ubuntu-24-04.marvell.com (wd-ubuntu-24-04.marvell.com [10.111.132.113])
	by maili.marvell.com (Postfix) with ESMTP id A3C435B692D;
	Thu, 20 Feb 2025 15:25:29 -0800 (PST)
From: Wilson Ding <dingwei@marvell.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <salee@marvell.com>, <gakula@marvell.com>,
        Wilson Ding <dingwei@marvell.com>
Subject: [PATCH v2 0/4] Add Armada8K reset controller support
Date: Thu, 20 Feb 2025 15:25:23 -0800
Message-ID: <20250220232527.882888-1-dingwei@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HWBi2PcT7VOYBMInwbzQhadaooHUw8wX
X-Proofpoint-ORIG-GUID: HWBi2PcT7VOYBMInwbzQhadaooHUw8wX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01

Armada8K has one simple register for unit soft reset, which is part of
the system controller register area. The simple reset code doesn't
support register access via regmap for the syscon devices. This patch
series created a new driver based on the simple reset code, and add
Armada8K support then.

Thanks,
Wilson

---

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

Wilson Ding (4):
  dt-bindings: reset: Add Armada8K reset controller
  dt-bindings: cp110: Document the reset controller
  reset: Add support for Armada8K reset controller
  arm64: dts: marvell: cp11x: Add reset controller node

 .../arm/marvell/cp110-system-controller.txt   |  43 ++++
 .../reset/marvell,armada8k-reset.yaml         |  45 ++++
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   6 +
 drivers/reset/Kconfig                         |  12 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-simple-syscon.c           | 195 ++++++++++++++++++
 include/linux/reset/reset-simple.h            |   3 +
 7 files changed, 305 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
 create mode 100644 drivers/reset/reset-simple-syscon.c

-- 
2.43.0


