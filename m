Return-Path: <linux-kernel+bounces-301947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E141495F7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032911C21E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3CA198A35;
	Mon, 26 Aug 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bwXcABFH"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295E18BC02;
	Mon, 26 Aug 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692941; cv=none; b=fg/e9j0IdyWscuG3AJ4oKs0zjuJdsG2S1Qi1hOYK+cSjnHZBKdzdcYIkvVxWvjJ3jjVEDR+7076XW6q4y/UG9Ym+JFDgNHb8CUbwSivCxO9Fh+2A1DTX69igsQx+xlm9FAN/avza7NdsCek2wLyS+WXgRZXEsMmaEaqdQAqLPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692941; c=relaxed/simple;
	bh=5AlIZ5ChdGTTQySLQ5G4iJCun/+9P+Lr7uBKemC+iKU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=tXBa40bHh3ybxG+0cIsY1N0cF6tmK7TTuIb5M8jDOz7AQxrV6ALkFeb9I14m8gYtHuUdPdmHd6hHn4onOMmrgXggql9PNN11cUYn/ffsk7tmKfu2OVKipMjoVmOyfyFxaK94JV65XF05AmFoL+eHu53/YhUI1+KWc2+1jfM3t0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bwXcABFH; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QHMB43002001;
	Mon, 26 Aug 2024 12:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724692931;
	bh=cGPhM47hcO+w8j6makPIfRMkzG53vnbBNLqX0pFGFdk=;
	h=From:Subject:Date:To:CC;
	b=bwXcABFHEYZo83pGKCv4l38LQXlypBuDogVE8o/T3VwExh1RWSW4ej60NHa1liLRw
	 lL6G2O1PvAG8j830khhZjFYXYWwBmw+BGuWmkaH46ufId/pQG545r1ik6d1Sw8SqDS
	 2YT2ReqIzD1efjpJDTkBT3eRRqSrOtXMxo2wqVKg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QHMBNT073204
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 12:22:11 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 12:22:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 12:22:11 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QHMB95123042;
	Mon, 26 Aug 2024 12:22:11 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH v3 0/4] arm64: dts: ti: k3-am62{a,p}x-sk: add opp
 frequencies
Date: Mon, 26 Aug 2024 12:22:06 -0500
Message-ID: <20240826-opp-v3-0-0934f8309e13@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL65zGYC/1XNwQrCMAwG4FcZOVvpUllXT76HeJg1dTm4jnYUZ
 ezdzSaIXgJ/yPdnhkyJKcOxmiFR4cxxkGB2Ffi+G+6k+CYZUONBt9qpOI7KhtpY7EJjrQe5HBM
 Ffm4t54vknvMU02srLfW6/felVloF6lqSEVxjThPvfXzAigv+ADQfgAII5eHVWI/OfcGyLG+Xm
 oklxAAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=bb@ti.com;
 h=from:subject:message-id; bh=5AlIZ5ChdGTTQySLQ5G4iJCun/+9P+Lr7uBKemC+iKU=;
 b=owNCWmg5MUFZJlNZEPKqGwAAY////v/Pt+n5/32bkP+xedb3ZxF/6+2mHN+//67v/t/Jn/SwA
 RsYGJBoPUBo0PUaADRoAAGgD1A0AAaAGgAA9QAAaBkPKA0Gmj0jaanqekYZQ5AHqMEADTRk0Bo0
 0Gh6hoaNAAAZGg9TQMgaNNGQaeoZpBkZD0gAZAaBmp6mQhkek0ZMmQxDQDQ0A00YEDRoNMgaAA0
 xGEyYgxDRggaaA00GJkMQGgAyAADcDDDocKi/Y2eFidjE+BjsmJgz5EOzlHGkL6pcbFYx0AFn5l
 eQo52DQd4L8+QJ/FQlkoqMOKVOjYpOkunq/P6+LYfPNtfMuBfecuYt1RDqEMNQSBs+rt3h3gRzd
 LO2dK6bQw0l7fUd7/0PGJaBBmgiKbZY/vWRoSxFwr9VlmseIaq8ALxO2jRy4apG5tjJ3Ma4Wj7I
 Xc/W4SQee6RrACrmSTQgAArPu10wCxXDH2+czifCQeOZdiJp/Pe0JlSAkisOWmS+Mn3LHGZ5oRw
 KVGIuTob4IsxayVe0YmAQrIfbd06C1PwHmr7QFDssFn94eSXtoV1uj3l/JAL0pmpeV26vPKQSBm
 DhdijEAlH8gvwKykbAmNk2O+X+VCAQFsoMIai8uoAyaLTLBEibDnGtRzkwcS+BjJf0HZzjTcM4a
 pVf4u5IpwoSAh5VQ2A=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello everyone

This series adds in the OPPs for the Cortex-A53s on the AM62Ax and 
AM62Px SoC families along with the defining the 
WKUP_MMR0_WKUP0_CTRL_MMR0_JTAG_USER_ID which we can use to to properly 
limit the OPPs available for that variant.

Happy reviewing
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v3:
- Miscellaneous spelling fixes in commit body
- Link to v2: https://lore.kernel.org/r/20240823-opp-v2-0-e2f67b37c299@ti.com

Changes in v2:
- Expanded on commit descriptions
- Split board file and SoC fdt changes into different patches
- Link to v1: https://lore.kernel.org/r/20240809-opp-v1-0-fea8efeaf963@ti.com

---
Bryan Brattlof (4):
      arm64: dts: ti: k3-am62a: add opp frequencies
      arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
      arm64: dts: ti: k3-am62p: add opp frequencies
      arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry

 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |  5 +++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |  9 ++++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi              | 51 ++++++++++++++++++++++
 .../boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi  |  5 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |  9 ++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi              | 47 ++++++++++++++++++++
 6 files changed, 126 insertions(+)
---
base-commit: 182a862560097dec7adf774af58076984cd6c1ed
change-id: 20240809-opp-7f1372af677c

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


