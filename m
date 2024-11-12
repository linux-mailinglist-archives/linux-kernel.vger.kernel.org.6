Return-Path: <linux-kernel+bounces-405797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 929FB9C5797
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14F1AB2FEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10751CD1F6;
	Tue, 12 Nov 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nn8BqYV0"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4416A2309AC;
	Tue, 12 Nov 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412638; cv=none; b=gZqMukpnkOBLkPKJkRnIqk1ClEFZW382tW9RYd1CermapOEnMkCsVMFHjHrlIPyLajhLXZPeeUCxzAaZSmWVj9P+WOGSlWiR4v+J982604G2vw7U7MYBNQZxDmnqQpnVUHVH3CyfN6vexnqY2ds6Ga3au/52qspYNtfn6WoJau4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412638; c=relaxed/simple;
	bh=orUQtSJ4knm3lokWfEk2Zsb4juDgP2iLRaTspmG7OjI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJX3KtFwv3Ja8GbnVd/QdySGZG6qMqJnNQkvU9X47kdl29A3CkFE1aXGAUM+0V7ElaJjkQ1mdjju2s1lCUamM71bDa7GxjBn8j7vqgjaXYsKgk/+S4ZxMVhdqXpr4ivPpT1KkgdjCtzTCVFU91cQ6B4FMx/JdGUYPsrZI/6kBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nn8BqYV0; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ACButEs086213;
	Tue, 12 Nov 2024 05:56:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731412615;
	bh=yy4PybiVlNbq7dsGXxtyTPs9DF2nDGpUaK/GmkktZNs=;
	h=From:To:CC:Subject:Date;
	b=nn8BqYV0bvXkCGlmWFENXgHMDHBTz6IK9EGjlU2TqKRCX9qa1FT4vSfOZ4NVENNQh
	 C0/vbUsKHI/CNBQAEbiF/C+Sfy0XRju3iPnX3QiTZoAxrn/AwYohedVoeF7zx2IN81
	 DVw5HO9nMMGX8/YwSss38pI7aGuIr6d2QkxD8fdk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ACBusPU016210
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Nov 2024 05:56:54 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Nov 2024 05:56:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Nov 2024 05:56:54 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ACBuo5S116685;
	Tue, 12 Nov 2024 05:56:51 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/2] Add Deep Sleep pinmux macros for TI's K3 SoCs
Date: Tue, 12 Nov 2024 17:26:48 +0530
Message-ID: <20241112115650.988943-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

This series introduces deep sleep macros which are common to TI's K3
SoCs and can be used to configure the behavior of SoC pins during Deep
Sleep mode. Additionally, support for SoC wakeup with USB1 on AM62x
based SoCs is added with the help of the newly introduced deep sleep
macros.

Series is based on linux-next tagged next-20241112.

Regards,
Siddharth.

Siddharth Vadapalli (2):
  arm64: dts: ti: k3-pinctrl: Introduce deep sleep macros
  arm64: dts: ti: k3-am62x-sk-common: Support SoC wakeup using USB1
    wakeup

 .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  2 +-
 arch/arm64/boot/dts/ti/k3-pinctrl.h           | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.40.1


