Return-Path: <linux-kernel+bounces-345469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C99E98B6AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76E91F21B32
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E290819ABC4;
	Tue,  1 Oct 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="FXXXaAvO"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2050.outbound.protection.outlook.com [40.107.117.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB65199384;
	Tue,  1 Oct 2024 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770862; cv=fail; b=ZgRnrC9oKcuyKJWyttVd0sAwI6UOkytryWp/zKHAQtYnhDcXn0ciDqtpRhpRn8DuEX66k8wcNRRj+/Q6c1VZVON3B6vJun8D3ppSCd3NbutMHAmvSuLJAjDV0DiQzY1Zyuz3VBquAz4f/ii7Ay8ZcFWwNu03r2qnmBcXN9Bp6ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770862; c=relaxed/simple;
	bh=Tq2+Lo2rgOQdpPJ4fVYG1PJI6kaDebd6kaoHfeRj8Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JFHZKYCAQZ8Ki5gmqPTXT0OuvxO90vWfBfNpi4J3A6KT/DHDm1LFM3WuUzfJsbfMDy5OKOjgzq47hLIByM4N7sASzTz8zhjbYFo1QUADG63utCK9pnpcoin45icnZHKgaX9bbVduScupznVkyE7iPY/Cz0/HgcbhcAivyriegKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=FXXXaAvO; arc=fail smtp.client-ip=40.107.117.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pztB13Gx/D9Dab71+V3+sXCsE62sfKITsNgbe04a/vR5KekExixOOYfTM4HExD5ehBs9YuMzK07XCG/Z2Ak0DhrSAbhEHzqT7KVpMDpvodyqH87jMlvkLT+lMlkVPoFs/HcY8Lwee2yqCdi7XRklCsFM9/ZJEM4ImIaBIY7hrhDYZT2zX7Ww7Ldyl2tKNhLGNB8BauhEt8OhAq6xkrr4dWI5UiMNI9LdggQxO3IlgfMepuBlEhF5NzC9SOZSE57UsgafB696qivH46qJyX6Ws2Ptu4Kcb1i0FGvXVGN9fLz0Btu30/pNATSFTUlPu2RADT6geQPEmq7FL82U4GGzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/n4bvPQyIa47fxKGAYst7E47NyH2+WHJVqeVlJdk3c=;
 b=GXg/6xp1hUfvQWPMj2oqkWELlqd/SqZRIqy07EkElXRwqdxip0zOIqdJ5C8rOdjdAlTHtQMY4ZKHeFvWItzgduwrwLIumqEFQP6+C6MRlo59NJ81Vie9Rai/+EsAnosF/CMrxLZa534kOCXSHzyMwTxi22b2TjPYEQrK3Xm8iew4TQyBJd1FCq5+Lrgl4xyTwHeLUyUXpdOv5VJ6HNqDHQWbZbee8FBTWeGefsWQQIDNLvaW8RyTo9vlSPhzI49QNAPTsGSi30SidFIYVcmsFwP4YxLI7OPvid0wORj1HvjtPjLxf1f1sB/KVdn7luslKhc+asv0wqztg4084dPy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/n4bvPQyIa47fxKGAYst7E47NyH2+WHJVqeVlJdk3c=;
 b=FXXXaAvOG5SYeP04DTFD/QpchVO7FnDVEuTyFMIE+lSHb4IyLGlMyE0eTFDrFhNOc4HRQ7quIW//hvC59hlL3a6GxjHI74/wev9plxUTFjK7vfBC6DuqLvKlNJ7kLthO0W/+R0psqlNOf+KA8/QJo2jUq2Z7+0anG5Mq/jtgWKBDhf2nDNLNX/czmhyP1o7RbxRdsMVPHDJQOqOR9Eh2q37dp3PlgcigwiFnwitYfwMvs/sXMlNFF3oMPncpu8sHGPDj200NYq1QC1ZU5nd+VvrEsAfZCeD8bAJko6jTIxIo1Z0VVqQIeBUKXq9FkLPNVywFjGTlHrA2Yzz1wtOjjA==
Received: from PS2PR02CA0096.apcprd02.prod.outlook.com (2603:1096:300:5c::36)
 by TYSPR04MB8168.apcprd04.prod.outlook.com (2603:1096:405:9c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 08:20:55 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::fa) by PS2PR02CA0096.outlook.office365.com
 (2603:1096:300:5c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 1 Oct 2024 08:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:20:54
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/10] Add I2C mux devices for yosemite4
Date: Tue,  1 Oct 2024 16:20:42 +0800
Message-Id: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYSPR04MB8168:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0b329018-1a83-4ff5-bb0c-08dce1f1f87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wc5nSXUGj+GpuUC+AkhHSXnean38qCuOkdD7SzQGjHsXMyeg/CJKyAr5jaCo?=
 =?us-ascii?Q?87o4U4J/RM0tP65ZjvreaDQlbPyG012IiWc6vj8W8qteZEo+I4zuW82ZUY5e?=
 =?us-ascii?Q?cLZ2sKD62bALQYBITIs+p1jX79Kzvd5tT4kURQAfq4bVaVlLOuxo1o0lmyrf?=
 =?us-ascii?Q?TXMEtYuAvedWwnjpFHke1G+b6GK1UQ7wft2BGxMoqyvjkfJ+oDtwTSKUfXTO?=
 =?us-ascii?Q?TbadJJZU82wEdADJZldcwJTHttOeselleuSZCtR26vgz4+iUVFd3YRqHvbNH?=
 =?us-ascii?Q?Tv4Yt7TwGbG+ASr5flDuzNxhBnv4Sl3E2Ux5AUXyMXu9DsficMahDUt1Ii5O?=
 =?us-ascii?Q?Ff+Tzzz7YmYRCCS9zAfuPYkIYRp2xk0aUK2p4d1r2NcGJ50RJL9fzj0zWspN?=
 =?us-ascii?Q?/oS5Nz5KzfXs/oT+0OE2qLOIAZaOFRfObQPFVJT5jsxOzstSblDuuyzAVWB+?=
 =?us-ascii?Q?oqBfhn4gQ0A+pHLGV2J9ADeGtc6jIyXJPZZumpMwtKsWuSXb0+7h8So3+KO6?=
 =?us-ascii?Q?DhBHNS3m/bq9IVPeBoEvTPvyKxvfL1093s7tlKcVOcbnUBZT7jgC/A5cEMgK?=
 =?us-ascii?Q?VZyrh5xsY0n217SxMhi9gf1GB7Pt77zv8LqkKkx8pX8NhA/6KwMnqxY/jhHu?=
 =?us-ascii?Q?5ksMIQWjxL/Vr3Ca39Xsd8j7qHZOTx1ETIZoqdaRDGdRolBBrHBmazHGw9F8?=
 =?us-ascii?Q?/nLchlL65YWF7kOY7RZzBX7gCWB8/Aij+ArS2pi/PR1cy4LO5lukchMFZx16?=
 =?us-ascii?Q?koXnIKtqUYNQbWswT6nKPToSNTbR8ZnWNiXKLNSa8bpRBteQd0TyYOIl2T3X?=
 =?us-ascii?Q?+7HOSdfOZ/lP8Y0W4EXXP2Ih4DqXrPU4bCKQBx0lfkH4SeCQ2fanqmllex6m?=
 =?us-ascii?Q?BDoZwhqsn53bd3dPlFpVsX7eDN1vC9NWXUp/3HlzT83/t49Z9KXot1fZ1K4g?=
 =?us-ascii?Q?OqT+qQLiS44Rup2bcz/j2kh701kSbooSYMx83hkc5afu0Or6xAfH94pnkwkx?=
 =?us-ascii?Q?SLDX0ei6n4QikVN/BFvWNqR0C5X5RVeWtVhbk67a1XD2CNbZTHr9Fhs0AK13?=
 =?us-ascii?Q?6tHjYWbFJNUgiCMbjUhftKwBRx9wHSXzcmsoquYOr7k79glCh2el1gzy4OSA?=
 =?us-ascii?Q?uSE6XSHy/5kiB7/bTKFbHtvxi57/fWbJr7p0TQlCP05zyIIcknhLPtch28aa?=
 =?us-ascii?Q?F2j4zSajxn/xkQJM+6mIeIadVwPuSCJnGbLUpwPY2iXWhYSA0RNvYvxWNvY9?=
 =?us-ascii?Q?+cypxp+uPovxVz9OjEWzy/sPytulkrsqwsG2h9e5x2A6J//2svv6T2DWHL+q?=
 =?us-ascii?Q?+r4qzIRMqRB68/PFZTaMr/aGI+3Hjbe6ypywMx9zdxYrE53zyASmHRjVEUJa?=
 =?us-ascii?Q?rHdpAcDzE079plxp/PihMUsGLrfDfwZd63fEh6QglwfExpqNS3zKhH4GZ9Yl?=
 =?us-ascii?Q?kKzqactOQJhNQt2nhS4YpWP6WmqdVXAu?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:20:54.9872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b329018-1a83-4ff5-bb0c-08dce1f1f87c
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8168

- v2
 - Remove mctp property on I2C Bus 15.
 - Add required properties for IOE on fan boards.

- v1
 - Add i2c-mux for ADC monitor on Spider Board.
 - Revise adc128d818 adc mode on Fan Boards.
 - Change the address of Fan IC on fan boards.
 - Correct the compatible string for max31790.
 - Revise address of i2c-mux for two fan boards.
 - Add i2c-mux for CPLD IOE on Spider Board.
 - Add i2c-mux for four NICs.
 - Add i2c-mux for all Server Board slots.

Ricky CX Wu (10):
  ARM: dts: aspeed: yosemite4: add i2c-mux for all Server Board slots
  ARM: dts: aspeed: yosemite4: Remove mctp property on I2C Bus 15
  ARM: dts: aspeed: yosemite4: Add i2c-mux for four NICs
  ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE on Spider Board
  ARM: dts: aspeed: yosemite4: Add required properties for IOE on fan
    boards
  ARM: dts: aspeed: yosemite4: Revise address of i2c-mux for two fan
    boards
  ARM: dts: aspeed: yosemite4: correct the compatible string for
    max31790
  ARM: dts: aspeed: yosemite4: Change the address of Fan IC on fan
    boards
  ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode on Fan Boards
  ARM: dts: aspeed: yosemite4: Add i2c-mux for ADC monitor on Spider
    Board

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 483 +++++++++++++++---
 1 file changed, 422 insertions(+), 61 deletions(-)

-- 
2.25.1


