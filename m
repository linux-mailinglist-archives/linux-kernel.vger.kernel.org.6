Return-Path: <linux-kernel+bounces-171106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9138BDFD0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA371B227EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0502814E2DA;
	Tue,  7 May 2024 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ep1WvJE5"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24204F8A3;
	Tue,  7 May 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078028; cv=none; b=Iv+SbpNrbJGdmoiUh+j7q90RBJukETOHdQNSojZomVQFtVbSXWyTjhs3dWqGF15413T8i4hE5rYISIcOL51QcBskpc21Bk17DjXoFt9b6nH0IAViZVrHsilcWNnQEESntgoZXHWtjuTFF0YQFTAfpMPV9PosXG2nrfldF5ctuGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078028; c=relaxed/simple;
	bh=vuLSVLPShz6wQViPjE2btrxyoSh9Pp3r0Hm9mJD2iXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=koULRpY9oybDDLqHoCt2sBA9F4u5FUadtZbZZmRIKi/yHsJIqh+76dyJ3MRtxhS76WAVUNtUAr/EhZKIjHZfeM93UnV3WgKUT5xSkHN22+q0uH1//KR1Om+aI3yk4l40+EeYu9nmKRVIRLumWBYIYhxJufFCwtCXKj6LXiNkgNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ep1WvJE5; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 447AXb53067817;
	Tue, 7 May 2024 05:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715078017;
	bh=zv5l/OYnMFKUHadlnPzeVyb6qRV4kJtWC47FOfdYpxo=;
	h=From:To:CC:Subject:Date;
	b=Ep1WvJE509PJT0NuJphxSSih/ddxQJgUTFk0ki8T7/vSrVND1zSVhFCTsakKrBOvo
	 Vet8PpW24YILdVVm7DC/ZFoEtAByTlRJ2mLTae96uorF36F7zkJc3q4acQkWi6R4f2
	 7AAzrpJ1cmT304jbUnxZzzSSDScLY7guKRsrwQ6Y=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 447AXb7G065328
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 05:33:37 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 05:33:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 05:33:37 -0500
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 447AXWEm068713;
	Tue, 7 May 2024 05:33:33 -0500
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <j-choudhary@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <vaishnav.a@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j722s: Fix main domain GPIO count
Date: Tue, 7 May 2024 16:03:32 +0530
Message-ID: <20240507103332.167928-1-vaishnav.a@ti.com>
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

J722S does not pin out all of the GPIO same as AM62P and have
more number of GPIO on the main_gpio1 instance. Fix the GPIO
count on both instances by overriding the ti,ngpio property.

Fixes: ea55b9335ad8 ("arm64: dts: ti: Introduce J722S family of SoCs")

More details at J722S/AM67 Datasheet (Section 5.3.11, GPIO):
	https://www.ti.com/lit/ds/symlink/am67.pdf

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

Logs (6.9.0-rc7-next-20240507):
	https://gist.github.com/vaishnavachath/2a629f73f4216fe00b74a7270b987534

 arch/arm64/boot/dts/ti/k3-j722s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
index c75744edb143..9132b0232b0b 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
@@ -83,6 +83,14 @@ &inta_main_dmss {
 	ti,interrupt-ranges = <7 71 21>;
 };
 
+&main_gpio0 {
+	ti,ngpio = <87>;
+};
+
+&main_gpio1 {
+	ti,ngpio = <73>;
+};
+
 &oc_sram {
 	reg = <0x00 0x70000000 0x00 0x40000>;
 	ranges = <0x00 0x00 0x70000000 0x40000>;
-- 
2.34.1


