Return-Path: <linux-kernel+bounces-190340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38108CFD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70211C20925
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDD613A40D;
	Mon, 27 May 2024 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BqD9v1f6"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6E13BC26;
	Mon, 27 May 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802493; cv=fail; b=iN9m3DzzkT72ZYZk+XokTCqw9AqaxWIT9+4UjMBR9zgYko1Ovmw6OToWuKkrHkFRdgvN3PZfRK1WS/B1HhuzC/INz4flb5qSXr1rkLeyVHgE26YLsdTyQD21PWNKVYTONKiQCx+bktuaPmkJeNrkPEtA0Hyj/bPnv00kfnkJYcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802493; c=relaxed/simple;
	bh=89R6qo6Ps2isvILvdqwwmkEMTfGZSNmV7W0iAE1zgfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GustyPquA3+d92fmeCzqQnq0LM3QN1cckFcDUWKjPlukWvLtEYQ2VTJk/T99MZW7b9PEOVoB02lH4wVsnKlPmmcJrlObI7ou+zV8y95zcLk9mcsjkSxWVme0WaKF1dMu8O8abBk0EcPEfrZ3CIK3ezhyQ5kQTibIyxRdMpsT5wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BqD9v1f6; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImdGaUSvdLgtssTU3CWt33vkUaih8CsfjqyHiAr0zQdNsbPE7EozOcAfHQMTV1EO60ptvN0sXsvJvwoOB2DOKtXwUrG+6o1nvA8YcbXSMGZjzBT7b85G0NH4DSi+mFnUSrzPGVK9JQENrOcZv0khIwb4KAptzY+w+U7hZ+FIdd7N/G8cJnN0EqRdINLxXECIJLYgLMjmitOEld60pdzFPM/ccFjoxtsMGk3JH0P6q1YHCUosZrYHy32wOBnLXY6mVKfvtvgeQG2lBsaJIm3qOpS/Rifp0MVJeecLqdSyQ1PCI5tUVGAer4gQIyXmO4OPcCJZ6LLVidVZ13pkpIh5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6Av+CgHDQa3zxletnl69+KTth6Ti3qcNXM48ptcYOU=;
 b=ddnUsyjZ8IbtPH9KulVWF5PNReg+nXjj8E+nFtQwZsXj9/kwrCJhhnrKMMbhM06nYhJE3ZGTRYOXuluKayBQdoT5Ga/3Ck00s8uPG0ETm3ZuDkdJfqmuBDppuCmqBAR7yOXIyTF2wsDNf6dUqm39aEkIQrRRk53tTlzwUET9KzpHUSor/EdVm+lzQwRB2DHvFoX1kkglNnUKM/0ZD3hI2hnwuKT+rs39Orj1nu90pZldDyamIgljL5gGloKgNXZWhSFArDUxZF3OEy44rJdJ84dHpYBNn5wBDFP4cIt8NuIjPZxhi1ANz+HuVE1tpjsKA1EmCXklpudebHsrDHVzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6Av+CgHDQa3zxletnl69+KTth6Ti3qcNXM48ptcYOU=;
 b=BqD9v1f6TaopeVBLKDA2bbbFRW+WpHmiid3xWwuTdNKNcYTB+agigSEC1qqayDSNdMshQFCwg7ZFLmypslUQyPxg6Ykm0m55G+JPNHXN0vLqFPienbodTZWW9ra3wwArYfjDbQweAbQAKCGeM0I56bXNXE8HskgFGt2Tft8qgnY=
Received: from SN1PR12CA0074.namprd12.prod.outlook.com (2603:10b6:802:20::45)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 27 May
 2024 09:34:49 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::7c) by SN1PR12CA0074.outlook.office365.com
 (2603:10b6:802:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Mon, 27 May 2024 09:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:34:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:34:47 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 06/12] arm64: zynqmp: Remove address/size-cells from ams node
Date: Mon, 27 May 2024 11:34:12 +0200
Message-ID: <39f73999bbec0233264ce40f05c0885c46e423be.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=663; i=michal.simek@amd.com; h=from:subject:message-id; bh=89R6qo6Ps2isvILvdqwwmkEMTfGZSNmV7W0iAE1zgfs=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4KnzRdqkjvwxUi18cPpU2jOnT6K3qyZG/uO5sWGuo rZxnrRiRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIhgzDfG+pi9JFwkY9TTy8 KgcMcgTFqhcyMMxi0j2xsn3h5QlhvZfe7v3Maps475MhAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 96854e65-4c18-4f04-7d6b-08dc7e3040d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mbfP07yTDhgpwSDvEiHmNU3Gp3SJkqysV7oHTuyd+uChrvakjlo7abzFLr3C?=
 =?us-ascii?Q?hnXPKD11M3wvQps2AXNAo4Um+dh96F+Ahx6S2k0Qrb8DwcqO5sN/3bSseOp8?=
 =?us-ascii?Q?aurdRJDFEgYTtYeghjN+uaRhC+9wd0i0Fwll4EM3ov07Ih1hY21RagbD3g55?=
 =?us-ascii?Q?tG3Kq/sK+LEd1VZdvcawn6tRLioiiNGoLnW23qgSOZCAre4BgfcsCZY7djQl?=
 =?us-ascii?Q?HqScJ31JXUN9jDcWD9KvoeVWfS5vnWJ/9fU0LeeHT7pzLZeD0+Uof+UU5jZ1?=
 =?us-ascii?Q?l5CY2Ydou8zR6A0Ul59jhxwFSGu86fbKh8UvJbjMXOuJi04Xjx9q0+iwACNf?=
 =?us-ascii?Q?fDhx9lZlTtVylUZZukPHviEqijd0JWGHdWYhfqBRH6m664orjj5eZTJMkgMy?=
 =?us-ascii?Q?2sGdpbji5YyMMEb3I+jdTtIC0rmkGctUioL8SaCHvXtvsjHS0gisP5MUcoJ7?=
 =?us-ascii?Q?UKvEYdr6ItYAovEtpumG9envzdiazMuyG4UphWPPQyCIoAyKROdtOgAV1x1e?=
 =?us-ascii?Q?/syIi92yiMhPZ7+IIecN1bmykJhQD2+wUNy3OD10XhVKd/Ig1iESd5aj2OUQ?=
 =?us-ascii?Q?D5nfz2gB4sEbhhwi6jSTzeOX293Snt3PXKuFbKl5/SxKS2spneVL972N0xZn?=
 =?us-ascii?Q?fhQ5xfnLCuPl03iXI+pec7KfKuE8XUR2i+w2wSSye+cJDilAHFGu2HJiJn+g?=
 =?us-ascii?Q?reN4YmVYsUqy1DY5kz5elNfeW6qN8YBHAH0FBL/Eo8BIrDE6HgWhGKroTBLd?=
 =?us-ascii?Q?PZZcTNFTxTjMc/nRuwn9n/p+CsS1Wu1AzguK+IQBsEZE/p2vIrM9lEwR/8Qv?=
 =?us-ascii?Q?JrPJbRoj5zmTLldITqNkwae09Y2VGOOckHjzDO+U5la3bG0LnqSsbLdqHMx9?=
 =?us-ascii?Q?vwDT2bqz+xrLyUcv5uHE5yIoAZKrsr1QCogz+uOODwja2o3J6yYBKi9w02jN?=
 =?us-ascii?Q?NY0QnzNSWzFyO38dhiwwjbDC6GYLQcsYw0otRloJteJ+rqKJxuOAljAIiovn?=
 =?us-ascii?Q?j+4L/rhIfJiGnDZWlg0MdZ51OreddihXcUEH9EEItrqviMTBpK8E1hQYy1V8?=
 =?us-ascii?Q?lnFKKD/MJdGjAw8qX0Dh708Ul2iY/qkrSvSxSh1OvzYLvZWG9exYTgeA48LV?=
 =?us-ascii?Q?niiJDqn6gtNZsWcEBd81eZomD4nNA8c0DH7FnhZXB3egt5RkK5gtJ1uJ8U6Y?=
 =?us-ascii?Q?ykynSKlBTOAUPH2uB5+EmOq9ZRvz7QxNRWC6D2yRlTFw9PNcyWqRro99zvBO?=
 =?us-ascii?Q?LMUAl3m6A0V+epREKWsMIr9Ds/og4kFzPuuzSX0hDxUQp/aQYW8boLl2ErRQ?=
 =?us-ascii?Q?mFngmHIzk81XjO0vI8wi2YXtwPLXTsa/uhdnhP3MVg5eM3N9n43DmShwi2CK?=
 =?us-ascii?Q?G+C5INsH8NZvhI5kqw9+xpGC6ZU5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:34:49.0143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96854e65-4c18-4f04-7d6b-08dc7e3040d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911

Remove unused address/size-cells properties without defining child.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 27adead77220..a121afb8231c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -1146,8 +1146,6 @@ ams_pl: ams-pl@400 {
 				compatible = "xlnx,zynqmp-ams-pl";
 				status = "disabled";
 				reg = <0x400 0x400>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 		};
 
-- 
2.40.1


