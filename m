Return-Path: <linux-kernel+bounces-565435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98807A6681A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578ED7A2BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505C71A2658;
	Tue, 18 Mar 2025 04:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VVEOkfOc"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249894A07;
	Tue, 18 Mar 2025 04:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271166; cv=fail; b=ctwfT5tJjXR7XfEXfcyU0iuoAkjP0aNVf3X1dRjJfWQJg0IxjTdZ6i3+l6/9a6mjHcoy75d9sLLFBBowAdB5p497GiNgdSdrSZZUGLre6vFlFY9qXNwG0G25hxYmrGKQaRhYo/yauJzcFCNOJdlZG1B+6BXNgrVFiNyH0MslpYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271166; c=relaxed/simple;
	bh=yBl/mmg9WjZ2Wy8rmqC/swM/e6Hsw6FqasoZyyhiIBA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LR6Za2LKuNN9JNdrQYRsLjfQscvH2oOrg2UAXCKFdaKlxJmtclU571kEmFvn99z7J2dBScNs+C80/sd/tIel9dcE0FPw4VkRzllMRc6G3INL4BBym9HG9HftUb1GHR2V8WpD00vGpW+kR8hztjxVTUNWBcBd19hMUMnTgpmeRU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VVEOkfOc; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSjyEiteeiyFijaQnhs4lnoBt6ebhAKwKMUntmEySWaEhdjmjpFI5tEEngXw7mQKuOQv9mvxgQxK1B/8miqRLe/IUBDv7VkGYKU9SEpjhjksuTmpmLqq/rghFqUHesrwJaQvf6kJTHe55U1t6Im+yfH9F4IERMUbSByLLFJYvkYQ/349QeDTwenNme77Va7YHb/X94EhgVoa1vUSok9/8CmWTFouFogkWwZVRhdesnO4khKuhRmDXIB9EyB2LFnZEJDQKzLb8HBXQgl/Rp/eFy0X60YrNTH5VwEapsf6q+qvKjIp320+qMWSsSVAx3qaoOa8cMwIsYl72PdE4aI9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX84Y6pPK9YOw1FeEOyRUN9cFVqfhBUGf9QAX8ddxMs=;
 b=QBa8xFYW2aFTfwScBi6jE0R7Y7fxJz1Mha5Wrv7enG4lBFQJr/0tYfhzAYxFNNklr7UWJR3Pgv+dHdby4IqNp2B75FSn6bmgrb8e6sNLUJPCCFz9DEk1i9960Pp7dtaYGRbjrIOpJz9LS3bPZXEN/56UoItAJskonwyqg/p/zIPbkcXWxLtDgnoewxsOGQS9h8Liysi09TaUVHO4qs7wKL91auccyzV+KtiyYeXvczRy6/B2wkc0lxXbybGSEu2KTBoN+biE1U2FikssGzGXxI6VKG3abCs5mrAlMDrVmcidDbVLvIO9IOKe9V0VQaRGo/QFaKzOJeuNTxkNBCTwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX84Y6pPK9YOw1FeEOyRUN9cFVqfhBUGf9QAX8ddxMs=;
 b=VVEOkfOc6clBq0Q4z+TvhRpeUwQgfS2TpdYLagAviFFjVMOFOoyLJBEWEp9Chy3cXfMTmuXb+5TYPne7KW/Y2s9gl7SNMI8ntGCatwRni/aOiLfJYNQ7bPr0MqnSXNC/NQmHOOJv3TJ+x0G2wC6b4aOBcevEfCGYyOe4ZA90wAg=
Received: from CH2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:610:4f::29)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 04:12:39 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:4f:cafe::32) by CH2PR18CA0019.outlook.office365.com
 (2603:10b6:610:4f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 04:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Tue, 18 Mar 2025 04:12:39 +0000
Received: from BMCDEV-TH5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 23:12:36 -0500
From: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
To: <devicetree@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>
CC: <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Rajaganesh Rathinasabapathi
	<Rajaganesh.Rathinasabapathi@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add AMD Onyx BMC compatible
Date: Mon, 17 Mar 2025 23:12:23 -0500
Message-ID: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 6089fc30-d8cd-47b5-b687-08dd65d31f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OoUqffC+1iONBoFnQxaarbTpyzWbUe0wuUAbj4EN7aPZHCY0iICTe8GgPvPu?=
 =?us-ascii?Q?lKD9nlmRsCIC9o95AzcG2NKfz1sL9jQaRebIJYckNyFQFnUixGsoPaHfCa3P?=
 =?us-ascii?Q?yQS9GwxrZ1xqEDDOou8/CgG9t9nZ5NDM1Kip6DeoVs55AtQZUWmc0wwhgdyf?=
 =?us-ascii?Q?snSKUc+QbtnN3uhwTpniroDAvzmFshX75TAxdMtUSJd/MUHkhJvu7YqbPpJ2?=
 =?us-ascii?Q?EuMeLQYb+emGy2Uj0G9SWTmWxSzZNXcRcjCtx3hEsmHjfdK0YbN2t7k7Rrl4?=
 =?us-ascii?Q?/sq1Sezo/YcUiBmHpq563spwBO4aDbBkhjeKr9p7/HEUHIWjSt8kabhTFF/H?=
 =?us-ascii?Q?ImjPiRW2pliHn9ZuYYzSok5KgL1hNgR6C/qb74yybWruSTAyCbE6gNgtTeBR?=
 =?us-ascii?Q?LstD7w0NKEHCpK+F03gD01Om5zPd2cAXx8DKhV6LTlcesgOFgaBXh5WS5IK8?=
 =?us-ascii?Q?I7wsvmhBJPf835axQIj/McwSo3C9wSM1fH9rszRhQQp0othhp8RaOJzXjKZg?=
 =?us-ascii?Q?eHCN+nw8FYIJxZ/r4NWui1DqilJppAE+2ZlPWAmRAcpn6ZWqpBmp/Z9lgjT7?=
 =?us-ascii?Q?qjPrceLbpHb0Z+My7yeead40MjwGh9NF+zX0Ln/IDEqgGro7UanrZnnFN+Aa?=
 =?us-ascii?Q?TBRhSxb2lO4yoJajeVY6jTH1Dg//+H4hY/ZZCEGRRNtSZcE1Ohyu9aySKNOB?=
 =?us-ascii?Q?PPGNglBbezvZJ7v8aYf+uf8vQirI/q3Odk0wATQ9t3MBcLjOOYdMtxv30D4Y?=
 =?us-ascii?Q?jIwvL1wu4GZFee8j2rmcYPGdR5Obsa3GfzFsBznw5Q/inuBpQ51nkVoQJ3DQ?=
 =?us-ascii?Q?rg9Mc4vf7XDXTbF7YGSD8F2Rx70ZTb5dRjpALSfrU1qu+W5tAyV2pAZYspWC?=
 =?us-ascii?Q?O3EuDOQ1uvgElxltrhjX1dVRJhGjHgtIb47CK9hZp6ZJhawvC6zahEoaifsk?=
 =?us-ascii?Q?PirzTuJ00aCKFgVvI/Ag+sPg33fakPKt7Ta7O7l69fg2SRwvQ+kcIh3LfpLh?=
 =?us-ascii?Q?gyyAqlfxq8jT1mpp/ysWgE0HpdC0cHjFNQmxtj9EDBbV5KMgdODXYVBveLBW?=
 =?us-ascii?Q?qzDNiunqYPdzIqlc1F939gUCJYO6mA40U1A34A+alXsy0tpxsH98lejxlOs7?=
 =?us-ascii?Q?eEvwKX19YZcXKqvbJ0Ps6n/KrRaxYKr1MrVbt1eqs5h91E6uQjzPQd+2eH6U?=
 =?us-ascii?Q?OG1Z4jvFrFTgZdNxqgQG8wEK8fiQg+9zrN4IbnyiU/JoUcf6kmbi5zGI9R1p?=
 =?us-ascii?Q?VA5rjSoDdz5LCGXLqioMf/4W86kMCCBF+Fyn00wJuwx27rMXQDqDPZLou3l2?=
 =?us-ascii?Q?sBrbwnJGuxlLhjQlezAHhNsxUWbBS00ZM/SNxOAc3+ynF1L2wiy8Ptvta+MJ?=
 =?us-ascii?Q?8eM8oEGwTKKB5jpLJldRi8lE4IXZ9d09UiKzpBTR8/MihRtoKhZEwbpp0CX0?=
 =?us-ascii?Q?XLlaAuT+kQxxyrVJ+sJvPtJtHuekBaBfJET5xeF9z8v1ZScW2/gv+/79IApR?=
 =?us-ascii?Q?SSKIN0r6wldQ1Ds=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 04:12:39.7870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6089fc30-d8cd-47b5-b687-08dd65d31f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918

Document new AMD Onyx BMC board compatibles

Signed-off-by: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..98f92c16e342 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
       - description: AST2600 based boards
         items:
           - enum:
+              - amd,onyx-bmc
               - ampere,mtjefferson-bmc
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
-- 
2.34.1


