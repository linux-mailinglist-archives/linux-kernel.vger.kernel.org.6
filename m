Return-Path: <linux-kernel+bounces-230366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD442917BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFBF81C24BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5C16DC05;
	Wed, 26 Jun 2024 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="ZeTWAIzn"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2075.outbound.protection.outlook.com [40.107.255.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD916F0E1;
	Wed, 26 Jun 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392904; cv=fail; b=muIWWr/GvlThI5reTclRdHju/lB7YqIlDSMYEmkF0/hD0gJcESKa+oeUdmkJr+tZ4U405vQJo5mD7XyFfeEdPkpr/ELlNwhaoOG6a5Gb8yDMIqjHyliVVM2UFZ8AeDgI4p2+mxshknWu4VSzkIJiyc1bqKEiGCiQj1Q3xyNwsp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392904; c=relaxed/simple;
	bh=mDZZJlkVcsKOGKmKvCEVvBfa6/zQ+Wv7iupq0qbeGNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJqFiyvfDlryV+/96RsaJZtbWwRrCjtmAWLds96g5v0tgo8/H3nBrOVIJ1jmqXCKrcCdQFNFi6W4x8rsf4sIwNxYK9s+Pmnt/3CH9u/abeHhSm27VTNOpecmfO5DzGL1qmWNXwu8x7OoAM6jky3YsojzYFBtZtyyqwoAFLMGmUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=ZeTWAIzn; arc=fail smtp.client-ip=40.107.255.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBydv3IEsSHupM9FrnLJvW5YhEh0qO1v6h1DWrg37z1wPB7II8zcI2ieM1AXbXMcIygyinq5y6nPW2jI3WrXFqWJZmBLjt4+GEAwOHhm0nx7F3GepEgTbc/cWlRpSpb9g6M2/Kr6P4cvX3i6F9rF2m6MO+EjYtwV8l79ImkPQHM5nS67++ZkpYRigIYopioISrKMRG/fbqzRmaYYHNCW6RM+NMJahXSWXKteIR77hT429o6MbuQDRqP9JSYvA3dw1z0P/B6i3j0yi65mByzp+hqTtQhTjQBpCgtYtS7P2zHRzPso51RlWuWLNqUjcI28rrAnc/lQ6pycK4eOedB7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/dqJuii+ID5NkttuzvqI67JF2qX2ZPzbFRrGdWVquY=;
 b=cC0ivdx+aNbuLa8tAEOB2ddbX25jklg42Z+rafJNiTs8w+j38vvj2qPTLqTu4YhuaSQ58fydslDpYenKZV4smOr0tVO5WjVlCfoskIz3yhNoPdcexH6XreY0GoF6bGc9syixIH0etvbIqPbAX3CLqsUAe8BWlMrELNyh1J786RIg61Dv/sSGLUYLA89WwZmGYw7cTcyz0xnSeWQvgD4qzwwvevizVmEQ0ntzxquWmjU20g9l9100qJODesP+pBeI3cT/z+lvZxacn1YXiMTWEKqPMWO6Rkjd1MnnXJbZ6HbyP9SCPJ9GKsMFQ0TYpw0Uv+nE0k+Jj0z59WvtnjjFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/dqJuii+ID5NkttuzvqI67JF2qX2ZPzbFRrGdWVquY=;
 b=ZeTWAIznKp+6jc82nuOWhVy/GnrI9FBx686qB4FsZh7+jXV7RsQX1JTAiaNCfP/ok2UnyUA4Zg7dtEd+iM4RqL36pZIF26fxBlWm8u6u3paqTDYRqqcPFjmuEvcYWu1k+3e6yP3Au36i6g9GQy3yZh1J+0WeW5HCaSwiGL6wO8fEnPF+avRZqtz306Jr9BT+G52qAedWYdT9n/kGPDgFy///1Ikk5R5op5OMvlFu+SxoXVbIOWat7s+OOviu8XfG9P0sbael/bANJQS0DVGCiO+rPvH+sgkgVh+T5DEfClN/X+nzWYV+PFOsmKB9npfmlcre+bU9qVMiVPZyQgbnvw==
Received: from KL1PR02CA0009.apcprd02.prod.outlook.com (2603:1096:820:c::14)
 by KL1PR04MB7209.apcprd04.prod.outlook.com (2603:1096:820:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Wed, 26 Jun
 2024 09:08:18 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:820:c:cafe::e2) by KL1PR02CA0009.outlook.office365.com
 (2603:1096:820:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:08:17
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 05/26] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Wed, 26 Jun 2024 17:07:21 +0800
Message-Id: <20240626090744.174351-6-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|KL1PR04MB7209:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b8d35007-b5d9-4830-0bde-08dc95bf84de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SsmpOk4Aitf3Nt2xkzP4pUN0IwyjDVVu8Ef+/ilurWwBqnr64bWUVjYDTJFM?=
 =?us-ascii?Q?g/XqlnVhpNL50vgI7W0u6IM9iy5O34oEUVZSmjUL1y3Qes1ziVJ82jO0txcQ?=
 =?us-ascii?Q?1IDeEvdVSpSK/MAM5vNO04UmfxqCfmo1lWhlcoMqK70Gbhtbrmq1ayKB47NN?=
 =?us-ascii?Q?qmyYHNi3SgjxCB0GX24hkY7QQsdzwmmO2pBoFy2s707kBmuQH+hHROirvN1Y?=
 =?us-ascii?Q?YTVspNRl4rCsfve7mqKYC4uqcjeuYCzROVaNH3TK6UoZnvR2LMcqZ7zWscmK?=
 =?us-ascii?Q?z8zxUm6JxCI/3hjgCgsgWMPGFnXzdY4ozyFCkzYAsn2uLkyw/YwkXHsj/DJv?=
 =?us-ascii?Q?5BCalH7VkuPxsYbX6pIX0API3sgaBRyZ0EeJtFU+/PE1q2GlFCIPV4CoyTHE?=
 =?us-ascii?Q?0xas8cFRtkXh3gSTiAGtlw64yOhjRYnwkKOP0rMcl5lewtYgZeqnDeykJD7w?=
 =?us-ascii?Q?cFq1ZUh+mUoSHIzjoLIETjuG3b8gclRVRdk7It0Em+/Lr6Qoe/rJfn/kkT0V?=
 =?us-ascii?Q?ZO6m1O35rScBLlCoX6CGZNM3iGVfO9u4c7rJuo36+ZjYVLjXYuGkCuSJbUXB?=
 =?us-ascii?Q?MGGTZjWj3bJe0vn/xf2p+g7Fmoa9hVkqMIydiDuRpp1R6GNFrBce53Ju094h?=
 =?us-ascii?Q?3RRCUHwzcWk1Moqeh4cRAq3gBng1+WM8PjvwA6SgwOkUiqL42DkFoeWpmoZ7?=
 =?us-ascii?Q?5qla49SPZ0fmUkvia3g0aSArprrx3edoWoPuGCuipGfhzdQlRVL20+bIoXZe?=
 =?us-ascii?Q?gbuMG0vVdwHBO1rgDLV3xcEvVtKaU7PHh5SbADWsWqQMhMKRNuIAg2NRIA8n?=
 =?us-ascii?Q?yBWurQAvdSwoaU/X/5G1fWtWDSRAsP2/NOEexaTLwynNs92fZ960t2R9jGCs?=
 =?us-ascii?Q?ar+B1jOswgbwNjyrZXHinMIeOp/WDV44akef9oUAeEg7hKm2Scf1m0XlQNMg?=
 =?us-ascii?Q?TsV/yq3gvHRcr+qXXiDe+P19kSYBrPbjLi9W6KQDSLlx57heSuXXGZnLz9O0?=
 =?us-ascii?Q?Hyx97NdoxYcx3JiubWZzNx0L03PTy8YTaHEgNQns9VrjFF1kDdkSfHDLR3a5?=
 =?us-ascii?Q?O9C3sQqSe+vlUxKKlRrgdpdTRKYUy0Xhq5vPqq4k5XgCHPzYKgsxvoZs4vIL?=
 =?us-ascii?Q?xhlzDwVkolmPgQ9beBM01Vt9DTU560klS7Sz2G75YGNlDdnZ8HTKpcj1tO0M?=
 =?us-ascii?Q?huqTnLYoM9OrgoYcssXsN5SbMcn1quL+NooIcvjg7IS9lZjawSCFewaI/4NI?=
 =?us-ascii?Q?VKiji+Erm/3soljnmkW1yby35MdoGHWYztfoMyIwo//ZxTqcXTTR9e9Q4NTu?=
 =?us-ascii?Q?SZExYcZIL1oysrxeFK7l8qLUE39sN7VMUrhvMZzbO8JZhhWB7qw608oxtOux?=
 =?us-ascii?Q?32+kS2uTdT0QFrrobm4uCSaoRirxsO5I/XZ/FOSxbQGkK2aNmyr5wYhkjxlC?=
 =?us-ascii?Q?kyAxW3em1iyWwacPR8WsMmedSi3s05RU?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:08:17.8017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d35007-b5d9-4830-0bde-08dc95bf84de
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7209

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b0643e8aefee..a708e56b7ec3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -149,15 +149,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.25.1


