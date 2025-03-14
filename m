Return-Path: <linux-kernel+bounces-561294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9BA60FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BC43BD04F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524ED1FA243;
	Fri, 14 Mar 2025 11:21:24 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098631FCFF3;
	Fri, 14 Mar 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951284; cv=none; b=qEnVp8keJYPSfoy0nWjs9vCXci4Bn2CHw7pBqUyaho9X2JSzrYzhc/470YNmqQ/ezm24yKlnMTkSJxM1a3Pio57hl9twHFH09eWGgOky9CeApEsUhYP6I+8FBpq//sEC4H2yYp0Q4A+2XisyVL4rHvsajopHiCYaK91eM7w7v48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951284; c=relaxed/simple;
	bh=npHj6QVZ23F0tcCDkSsD3IjZb1fqRwV4e7DQZwIS5s8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QJxL70JnYI0prrsYuskjPQ324VOMn6SRLsF6RYuUxx/w/I8Z2WVnQqE5+mDCyDCtGzMxHPTAefvezyLstfDey+J6M8jdILGDEeRGvK22Er1kgOFXD3yzZSK4RWby9XrOxXfgdEEKlzaomi/+ZaAIt2WNlYjScm9879v5b5yLIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 14 Mar
 2025 19:21:14 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Fri, 14 Mar 2025 19:21:14 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v4 0/3] Add AST2600 LPC PCC support
Date: Fri, 14 Mar 2025 19:21:10 +0800
Message-ID: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

--
v4
aspeed-lpc-pcc.c:
 -- Remove the debug message in the aspeed_lpc_pcc_probe.
 -- Add pcc-ports in the aspeed-g6.dtsi.

v3
aspeed-lpc-pcc.c:
 -- Add ida_free and fix the dev usage with removing some debug messages.
aspeed-lpc.yaml:
 -- Add description about the pcc-ports usage.

v2:
 -- Change driver path to drivers/misc

Kevin Chen (3):
  dt-binding: aspeed: Add LPC PCC controller
  ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
  soc: aspeed: lpc-pcc: Add PCC controller support

 .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  38 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   8 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/aspeed-lpc-pcc.c                 | 437 ++++++++++++++++++
 5 files changed, 494 insertions(+)
 create mode 100644 drivers/misc/aspeed-lpc-pcc.c

-- 
2.34.1


