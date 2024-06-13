Return-Path: <linux-kernel+bounces-213496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F334907614
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75EAAB21146
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37111494B1;
	Thu, 13 Jun 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vFlDP90P"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258D146A7C;
	Thu, 13 Jun 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291354; cv=none; b=I99Zw9BNJ6mPBkFfcCHwF9Sdk+3TGeCR83MADRrVlp6erK2azU2A9vUP3HEzWwAbWrdG38TdAMxiEIrgTInPgJMpUBSZIIBf/EhhBk1Db+CGHeM6heiq04SjPyM4m1hJ7JY9ALcsfl2qL+yZi/TbDN4zU1QWGM+LOAm5vL7nJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291354; c=relaxed/simple;
	bh=IVYkz90yaTE3z4B+EqN8XLi+raRuQilsLjeTT9BuXaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bf4aLBqr9W6VVWf5nrhKTthzkto/RGuLfR92fnDHH3icXLyvgyonX1parE5FOVmD7Ydp+cphyjtC5VqEyfkFnX+EKLKOrBx9WXimZjXBdsgBkthliWezcrIRBCJJgfrcvCFKDTUAQH23g6RCfUFVWV9ALygl6a3SFnWh/TSNGag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vFlDP90P; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45DF94Rv130711;
	Thu, 13 Jun 2024 10:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718291344;
	bh=32mKoizTR6PHBLpGzlW5Pi6+patznan4E9AoSqgQKLU=;
	h=From:To:CC:Subject:Date;
	b=vFlDP90Pm7ywX54I+44BPg2wLHb0XdPK1n178EFriyWRasUgfnJ4hHs2ozb5GzQpl
	 jb++SsCngnUbFm3jzC2XutAB7s88LBU1CQYVlG4HAGkCaRpyKao3c7xlD5lyXploTz
	 P7aBHLjSP/6rq1HhKuN3WAZPbat7aNXDdVcfrEJA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45DF945E054777
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 10:09:04 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 10:09:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 10:09:03 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45DF93Ra007405;
	Thu, 13 Jun 2024 10:09:03 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <devarsht@ti.com>
Subject: [PATCH 0/3] Add global CMA reserve area
Date: Thu, 13 Jun 2024 20:38:59 +0530
Message-ID: <20240613150902.2173582-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add global CMA reserve area for AM62x, AM62A and AM62P SoCs.
These SoCs do not have MMU and hence require contiguous memory pool to
support various multimedia use-cases.

Brandon Brnich (1):
  arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of global CMA

Devarsh Thakkar (2):
  arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
  arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA

 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 9 +++++++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 7 +++++++
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
 3 files changed, 24 insertions(+)

-- 
2.39.1


