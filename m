Return-Path: <linux-kernel+bounces-433181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058809E54D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29AA283C8D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111FF21767E;
	Thu,  5 Dec 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BXzuxkGQ"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD182144D6;
	Thu,  5 Dec 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400108; cv=none; b=p7YBWh094GPcPeHSvDvxF1bGri0W9zPb2EmpB5v14SE9QI/lMY+oqH0eZfOWsWTOjR1W82EB5bvF3yvhLy7xOzkDQLvYsEbQFY9QKu5ho6wngL899JdPwwKkyvNZGUK8v6Q24zeuoPQaLSAfK/omrsCKb/jm0Np3rzpwWGSx+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400108; c=relaxed/simple;
	bh=F1kCU0OSXtqFV90mdqqDOL7F/WnBkqUvKJBgx7LEGz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AQ/9uOTL7//2xNRNydaafvS8UKdJ/GfvHiD6jUaHw6OXzxuJ9hgx8Sg4y/LcULmtAD9xoy/Dz6UVAXLXU6KE7+tOQq3gB8+X7JIgW/3Htir+4TYjwxX4oXRxsiTBjep2BgglYeI5l9IrHEcmTB4KfvNIjZAQaQ+bn4x51eUsAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BXzuxkGQ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B5C1dFL1943300
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 5 Dec 2024 06:01:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733400099;
	bh=xeByAKCLyISHzQ6+LEbPiuQutggH8J/FE/3qIh+Q7zQ=;
	h=From:To:CC:Subject:Date;
	b=BXzuxkGQtLI1O57Qfafs0ogNMBmIB46nW1okrwq+409gtcfhi+Qm4jwd9aHFHddj8
	 0hnPyD6Zyi/yY76gsZE/lP47ChipGK4F5dkrUWjhCeY7/HcJtX0bGyNrIG46g9zQU9
	 +fWG7t8FkCNWHmfie+xEXBC0/2DESAlT/Spgt7Hk=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B5C1d1u062603;
	Thu, 5 Dec 2024 06:01:39 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Dec 2024 06:01:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Dec 2024 06:01:38 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B5C1Zp7018608;
	Thu, 5 Dec 2024 06:01:35 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Add Deep Sleep pinmux macros for TI's K3 SoCs
Date: Thu, 5 Dec 2024 17:31:27 +0530
Message-ID: <20241205120134.754664-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
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

v1:
https://lore.kernel.org/r/20241112115650.988943-1-s-vadapalli@ti.com
Changes since v1:
- Rebased on next-20241204.

Series is based on linux-next tagged next-20241204.

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
2.43.0


