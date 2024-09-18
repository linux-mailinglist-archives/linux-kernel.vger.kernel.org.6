Return-Path: <linux-kernel+bounces-332493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE3D97BA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE2828191F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1DF188584;
	Wed, 18 Sep 2024 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="sLwP2NGn"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2062.outbound.protection.outlook.com [40.107.215.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06F184114;
	Wed, 18 Sep 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653302; cv=fail; b=Lod9VwlaH+h682Gr/xMFfJF6YW7tuQoQ7jxlWS4w1wwgUAV7uPqaqiS9MbXXgz2WSvOF45ncy+u4NFDptaObxGwbpx5KskXeOgjAIqU1LV+AvkEaiHV6km5THk2xOg6WRcW8qNUH+7EU13Q00MwCz+mGaKmGKy08mpM70oLMkfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653302; c=relaxed/simple;
	bh=mshZ0/dom5RFQXjBZrT0yO8Tu+Wg2SrU5Hwkzrd9KTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfRZkc6opU9odmkH0WlaYeBDr0gOptjuXrnUXgYYeJjIvTGK+txvca08pxcSDd11s1W3VOMSzjL9ZkZuJP15E1QdT1CFzDhgTg5zpTfAWuRjMyoI74slGsluvpYfABEWz5uNhJWufUpYrc9FEbsaXsoOaHtVAQ5N0+5Tz9pgx24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=sLwP2NGn; arc=fail smtp.client-ip=40.107.215.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5sH2et9kvuyUO795O34UYYdcv1SPi6qwDCBetpBArP6M3MIUs85T4xV3LG1PiQKAL9qW6O2TMs13Wp6ioJsTOqkIwzRsNXTkZ5sHxeXymkEd/jf9RB8o1CI6r4/EaWuu2Qw7NVUuH4YpHWEcmu9TWa00wroYussuskTY9wzEYfO5A9kpLhKjgAAy6OxhTIfGOgQt5l6qnTD8kZQWhtIues9w7ynCP7/8aWAYuX1/vyf76dBLMvc/Nh/v4G1qT2W/7XhQpa3ep0Uru1DgsWXAxMwc2SeE9gGMaoLSsV44FWUfXcLVE/Rx4U5geRSHS4q17XIEiJD+6jYRWZtxARLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEZHnYUwoxYEf+ntplnpkRMepWld0jZHU7odMeMAQdI=;
 b=aoE9cHS8GriidEt/bKdFbGyp/2NwRE08sfbjZ1VMDDQ8bJkZHmrg6ykOqAGj6bfWNZ8An3VCjvdsYgjOH88d5r4Nftu/1GbGCCiz+D8ogKa35AWVBW6r5cnvMGfe3BG5hTGd4Ym1AUR+g9yGDEAgcG5XNyrLGRkVdGXB7vXG3LUXfpbGAlPV2Pj9MQamO8Cnp0y19nvUQ3ProIDtAKFi1UZ2xwVi6kwE65ck68pWu3m+R9nlgOr1mR3cYdmyNuisVQ0OhW62G85f5uZ2faC7AXXuAZeihzjy7zFKo1a26jvYA3hFdO6g3pawwfyDsgorChmklQXObpl3GCqgD75PNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEZHnYUwoxYEf+ntplnpkRMepWld0jZHU7odMeMAQdI=;
 b=sLwP2NGn2RoKvYJ7Z39exloCCBHPO2r5QUrjMiDHa7UYr+/4MaE+nf+O3funbfzcWOSKN7WCGW/HYcFEpohQfBxOE73OjEz6Ep2P1M8DcQynDgSa/YSJ41OL07rxEwq7DfdkZDus7URDfOWy5A2fGkgUIQdq6hdhJKEtaAF5ZHa2z8/LwDcukmbwbah+CVM2eQIfxnNtc0Urhi+oNMs6i2YODmp48Fw/2TyDZnHPTD9O5WcgfApy5xRml6jr79WFS7lOLkzK8tZP2pzxn6bzGaUM84yFFXNtfcje+ut7nRxGsBwe6zsis3Kb/XmdBVEYf4fPWLyt+NJGSUJ5m44LRA==
Received: from SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) by TYZPR04MB7193.apcprd04.prod.outlook.com
 (2603:1096:400:451::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Wed, 18 Sep
 2024 09:54:51 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:40:cafe::6e) by SG2PR01CA0116.outlook.office365.com
 (2603:1096:4:40::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 09:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024
 09:54:50 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Noah Wang <noahwang.wang@outlook.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH v2 2/3] dt-bindings: trivial-devices: support MPS MP5023
Date: Wed, 18 Sep 2024 17:54:35 +0800
Message-Id: <20240918095438.1345886-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|TYZPR04MB7193:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f3df9b54-b045-4abb-fcba-08dcd7c7f070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013|32650700017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?onQzMi35+ljb5+BL/QAxJHxx6oPeJ7KC8MzKYSFSdh/8ZTABvj2+KktMg++z?=
 =?us-ascii?Q?kRm5jvwjqkQvCnbZfhC++JsMX7bFgrq0NPRH2MtJEM5fdrrVbudDzycK4aQV?=
 =?us-ascii?Q?9GNhAavfeXb1oWNDmZVTDXsYZBAUY+J6nYoaUGMAa2w+M9xHuocqT5AJeS1i?=
 =?us-ascii?Q?s1fS50TU18C4XpBHhLvfTHVsmX4ySocRtz0gCeTdDTgXNFsNpto8XyB8hlvp?=
 =?us-ascii?Q?evM2KVJor8vxDdF3PwWgBJkHGJhygTOkSmR3ZfFK5PTbTarRWdZe7U9esK3l?=
 =?us-ascii?Q?/TXCuf4JzmRqXdIO00s9bxBOy0n7dCtmVr+AJPhoLIg0GK3bzL56TMciucIv?=
 =?us-ascii?Q?6AiSvNY8rrfclec6rV5RUb/d+IoG+G8ZkrWAVyB6gcvWCdZZdW9AUSzhgMUz?=
 =?us-ascii?Q?O30nzI0k1B3cmbEDmf25hdbDQwTQonAgLHWFzBtnX865oj5newwILICZOx2Z?=
 =?us-ascii?Q?MIDi642pgcjyrHHfQTYHmZxXYL6Qn37K7jjwHd/UnafO3jN00PqLxyJeYPwA?=
 =?us-ascii?Q?3Mo1WbY8GLUuTpaK017l59QNVypoiKtDuzNoBD/kgR40CXgLAbnAAyhoreq2?=
 =?us-ascii?Q?f0VsPPnMH7GCyOFoYcwjGvJd0K8ASY9fzVnTsS/ajJ/2RYmnTZGjDFtYrBY6?=
 =?us-ascii?Q?hsGkMJ4+SzJvh8xQElTqlFZF989EdHNKY5oFtYmJTemjZJXnYnxtWi/MTN9c?=
 =?us-ascii?Q?aMmLT6c0A04lveJSaJXm4qqkMiOcfPEMBAkSkQBb4i/IN9Cpwpt9lxEuHVlR?=
 =?us-ascii?Q?ditaxqNVWwIkdfvElNEW1AXqkV0ErLd+Tn4AjQlv5CZKN717JgUHfY8t/i18?=
 =?us-ascii?Q?nS/HSq4slsrm4KtCWc0WVwRMZKQhT2UHisbjbZcsdDcNGqS9VUWZ8T2gRMvj?=
 =?us-ascii?Q?Lfbajte0qLPTV68RlBbEWOZVY9szEeASR2yJ/OMfSjIyOvS5CYD1EwujmpEi?=
 =?us-ascii?Q?TP97XZzvgEErktUob6n5hWv3YaOLwfVzqMYuwHcv+C7JXLq77SgSVC98+rHZ?=
 =?us-ascii?Q?MTr3muzh3Q0RhkaCPBcT09fnef8zqSFaWmDciqF2l+GPYSvBBVza1LSN/XIf?=
 =?us-ascii?Q?QlZVwvilR3Idnj29o4XLA/5SxiHIhrzDWyCDnrhr+z8bg4MUk1hlUXn97eGx?=
 =?us-ascii?Q?i23JGsifbTjidSGz7bsMTl6FErBQDcPlGpC0f5g0pZEbSwFvh3vgII0Iw4tv?=
 =?us-ascii?Q?RXauN8G5vgemgVW/3PEnZ2vQm7+aFMkm+BDnDTcMnvEM935vvilSE/CXaobY?=
 =?us-ascii?Q?tNf+S1Z/quxCrISBLOloQ4BAmNk/DKshbayB/ZEORDKyXqaKkpLdqQTDRdlz?=
 =?us-ascii?Q?6/8qp9r2gyYt4Lplt3WeTLKDpCO3ROCk6inbi48lTH+WncIdnvRuRgLFQgE1?=
 =?us-ascii?Q?BbI61jfkwOXh0mVxkmJk7NOi9idp5PcECWLwrRRgRKTi4OSkM4NEd5VXoB2D?=
 =?us-ascii?Q?Uohu9J46ytkBWYifTLQ/zmbhTN0h29jh?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013)(32650700017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 09:54:50.2011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3df9b54-b045-4abb-fcba-08dcd7c7f070
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7193

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add support for hot-swap controller MPS MP5023.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index cbb9b94e5b3b..c3253ea389d4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -296,6 +296,8 @@ properties:
           - mps,mp2975
             # Monolithic Power Systems Inc. multi-phase controller mp2993
           - mps,mp2993
+            # Monolithic Power Systems Inc. hot-swap controller mp5023
+          - mps,mp5023
             # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5920
           - mps,mp5920
             # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
-- 
2.25.1


