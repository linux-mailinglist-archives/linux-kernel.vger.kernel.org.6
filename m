Return-Path: <linux-kernel+bounces-363402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A8F99C1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97149B24D91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06A29474;
	Mon, 14 Oct 2024 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s1WX9os8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8D61531D5;
	Mon, 14 Oct 2024 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891955; cv=none; b=W+OE2D24fHQgjzuf/zrA54iYxsXuz3rlMRl8FZ8ghyiCuWboOvFFsShTFfMNifMjObvB8rstuMDdbpmUGXc4jMn3D5VKXODzcEqgw7KRdBWIonNf9itriLquoHjHzVJmSw8PWEOg6Sjg/SR8t/NjgIE8JPtZoNqphc3oRwUkoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891955; c=relaxed/simple;
	bh=yEvxxRf9TXg9M/Rmq5k+ytY0zA0b+0QoWrYllZ+xMRw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HtOauDb1BJqbKUK9ZXUWSeWPrp0dVd2jkuyBkEK5arQDDRyi83bt+teTb7zJJaI7/vVRDoYTjiX7DnAA5FqUteWXCkBYEyEDaF04H3gcnA7gKOBohNLayg0/X8eRSIrfVOGGqnM15oxBJelVE4idgPGy0VkcN0/We5fSEsGVOdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s1WX9os8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jXTc087290;
	Mon, 14 Oct 2024 02:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728891933;
	bh=BBjjHktL3eks10w8gRP2iSSOj2j20CKXBn5MezkiEkc=;
	h=From:To:CC:Subject:Date;
	b=s1WX9os8gpVI3dbIfODu+cwfLyIE1ArRrEjpAbuZmKckJUegDJMgVQbdC9PLSE/l2
	 +m7lEN4MMmHDtpUCVUZZglz7/MBpSmebcq2fMo4I4eo0D8AsmdR40/mriZpShKHT/C
	 esbt43zTne03RdV6Jyyc6NzlEJgRSrL91BI5gorM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E7jXVB010211
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 02:45:33 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 02:45:32 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 02:45:32 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E7jWOW068538;
	Mon, 14 Oct 2024 02:45:32 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 49E7jWD2025327;
	Mon, 14 Oct 2024 02:45:32 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH 0/4] Add pa-stats Support
Date: Mon, 14 Oct 2024 13:15:23 +0530
Message-ID: <20241014074527.1121613-1-danishanwar@ti.com>
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

This series adds ti,pa-stats node to AM64x and AM65x dts files.
The driver and binding patches are already merged.

MD Danish Anwar (4):
  arm64: dts: ti: k3-am65-main: Add ti,pruss-pa-st node
  arm64: dts: ti: k3-am654-icssg2: Add ti,pa-stats property
  arm64: dts: ti: k3-am64-main: Add ti,pruss-pa-st node
  arm64: dts: ti: k3-am64: Add ti,pa-stats property

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi    | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts     |  1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi    | 15 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso |  1 +
 arch/arm64/boot/dts/ti/k3-am654-idk.dtso    |  2 ++
 5 files changed, 29 insertions(+)


base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
-- 
2.34.1


