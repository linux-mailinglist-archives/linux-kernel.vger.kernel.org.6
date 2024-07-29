Return-Path: <linux-kernel+bounces-265168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E293ED86
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024CFB219CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E639985628;
	Mon, 29 Jul 2024 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M3kbEWXb"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6033CD2;
	Mon, 29 Jul 2024 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234869; cv=none; b=Nsazs+icPurTqbYXpJjiBjR2u2FLc35vIy9qt73ivC0eSD/RQinx0TM2VzA4Pb8CGVtjnLMEtP0SWwTZOWQ3lRQQvDBoNt4p8teVu6ijGJlWM5GRGAdJPO3t/0Kl6+xoz1jxRdQfluemQ2dG0UrWfocGVEWqvsLV5HHP8NbpFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234869; c=relaxed/simple;
	bh=b7L2/a0ta0ndRf9dq1dmoYnlsuxA0+f2ogjCJMGuSeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UmqubYcee1C1226F7v7znenMg/ayULgXmElWzNXMyI2BpwY02k6ZtBLtIvwkbkGXaplt4EZVlMxAYtauKFYwuVKxxq2iGHWMcX6q1+0m5DxupvftUtI+d7O8SpaIoJC6aJ8oGbkZNkwgVSE7Zjvosz5X/KgSQZpj0r+SkRJEs9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M3kbEWXb; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46T6YC3J090233;
	Mon, 29 Jul 2024 01:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722234852;
	bh=bmDBj3X2WvbbRsDPA+aL8S5wPchEuQcQOhZgLVIFbq0=;
	h=From:To:CC:Subject:Date;
	b=M3kbEWXbh5LimgU0AFuxbZsJeuwET7GYcaD70Eu8haX8MSezwe2S1R8sxkFSrzd7P
	 NPWDRaqj16AJkXdl0GqOxYZXgzN7ur0VqRxzgYjF5lV7Hp+JqrQ0gciFrjWWHWvTWu
	 4YfowHM235w8uIIH2cjB1LwPe+/6MFvSvug0pbHU=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46T6YCkA013427
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 01:34:12 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 01:34:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 01:34:12 -0500
Received: from localhost (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46T6YBUm078167;
	Mon, 29 Jul 2024 01:34:12 -0500
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <b-kapoor@ti.com>, <jm@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: Update mux-controller node name
Date: Mon, 29 Jul 2024 12:04:09 +0530
Message-ID: <20240729063411.1570930-1-b-kapoor@ti.com>
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

There are 2 mux-controller nodes in J721S2 and J7200 which are
responsible for transferring can signals to the can phy but same
node names for both the mux-controllers on a platform led to errors
while setting up both mux-controllers for can phys simultaneously.
Thus, update node names for these mux-controller.

Rebased to next-20240729

Bhavya Kapoor (2):
  arm64: dts: ti: k3-j721s2-som-p0: Update mux-controller node name
  arm64: dts: ti: k3-j7200-som-p0: Update mux-controller node name

 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi  | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


