Return-Path: <linux-kernel+bounces-190336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A885B8CFD07
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372CF1F242C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02C713AD3A;
	Mon, 27 May 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BApJCZ4m"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8713AD2B;
	Mon, 27 May 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802475; cv=fail; b=DDFOPyeEIIBhTJbb9N6CuEMaDRa8opgzVlL3mwte3ATzT2NdOFpzWCWbJo/la0JAHHiQUe46V4rvB3ffXJt2qbTlX72Aieja8hVvxGCxF7x4xJPtke66NXDGdpQtDDmltQDjhdey42r0X1vXQ3kB/2Gtz5Qr6fwb/VI6xl7qMpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802475; c=relaxed/simple;
	bh=aZcHIOal0SuI1Cbr8Be52zDufDfPiqkwQJve497AWds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkPBcV1uxlzHmTNDTAM9vQftrkIuZmpHbJyd+4LnUxZFNcK9W26UkRDeiHuWlMXEddQTy2RqTefubN0yWPYo8mGpSLyNKTzmg86wJqrmi4b8kOu8UG8z364T2OUZwxqjZ/bz6qf+lL3CHRsTlBFhqvZAkfJDwS1GFzhl1kriszQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BApJCZ4m; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYDHyz4bygWD0d5+y4xd5XjzCiFwxZSG6ooqWoXDTPJdKtFj5n7APpryvx4Nn8V7H/2qDt7ccTnWYwJ57Lc/Aijt+e6uL16Xb/AozdQr4GUrcN2ngErFVaz+ikG590zIyruj3+VOAPxRgB2fC7AqRmE8CTY79MiGAfkyW+s0HE33eQAdh62bmJs4hiOB9BsFoFgLx80L2AKVtcN6WjCFJp/ikq7xm9w/clTKSGm1qWtV9JIyS9Ei+cdtXvDd1nq2AWdzI09V8w6hJ3WmEKxcnqk7/1cG0CTZYCdAbLspsV0TieWkgM8hnzYxbXengFrAG50qMoTf5Nhtv/rh8E0ySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u09XLHJ/KpH0bCs5x76dygZqBkD+KWQNLy0EncjAMPU=;
 b=Ajxxda/rKCAf2IuSNpG6LPp0BQS16YDjy9aMr+8tZT91WwF6bp9y4+Cfq66vPUblDzfamJfc1qAu2z4kVkEeXZvXWJt1Rv/tsAMSe5PqL7f2WDHLu7lxb77aLwKy2FFlUTSFN0LTuj3yh5O1eEJQZjDLwP7uvw0hqJVmZCQjW1VH0zLU/EVuprP7uS0b1iDggFQi2ojNZCSLE2yLbwoQsI5VZbqKvw6BxvU45PyoMrl0285XGudJgSAVVCMu+5rA/CIpL+tc/C8gIVtC96DnauU+xeZaYMMbleiIibBx7xPkGQRJU2YEyDTGetCxSMEp6QtZaWR2OlUNNmY4Qbfqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u09XLHJ/KpH0bCs5x76dygZqBkD+KWQNLy0EncjAMPU=;
 b=BApJCZ4mEpkhzjye6K7u6ldPugVVTGDxmV9xWxAA6UutSH385MeMJWK5lU+iOWyMTG4N45Kz+NtU9DhSlr7Pt9aMpg7RlKKjxTyCMaGJ28mEVvQXDDkUbi8Oovv7zYQBk6nsj07r8SlulmO3MK+eGTfl2Cm4PCyRXAjy6FD2gK8=
Received: from SA9PR13CA0051.namprd13.prod.outlook.com (2603:10b6:806:22::26)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:34:31 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::8e) by SA9PR13CA0051.outlook.office365.com
 (2603:10b6:806:22::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16 via Frontend
 Transport; Mon, 27 May 2024 09:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:34:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:34:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 02/12] arm64: zynqmp: Use fpga-region as node name
Date: Mon, 27 May 2024 11:34:08 +0200
Message-ID: <9133aed74a24ad5cd9af5a6d5aa7ee9a160f94ee.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=michal.simek@amd.com; h=from:subject:message-id; bh=aZcHIOal0SuI1Cbr8Be52zDufDfPiqkwQJve497AWds=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4Cn/z7E85FJ7pyb9ytv9/SHGgHq3Bc8dHk/gavnK9 yJ80gnxjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRDXkM8123uXr+YVrg/U7T aLpN5TRtD5nDdxjmR82ct/6TM8Peq0uPJRRynGkzWdbQAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b17893b-633c-4a55-d256-08dc7e303615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JYwJi3ECeatUX24ogyCRVSBWRVgTyqrAn9WqiaSznK2AKX2Ba5Mml8Pb7eTZ?=
 =?us-ascii?Q?83zIbgpQnRiCEU7++eYN5Xq+wQ9AgwHubWiVn6ho8f6pz075gC8YAUWCfHjZ?=
 =?us-ascii?Q?LKwwB5Z+RX89+GoTqe+fI+Ap1KRUFR3bkDsBzwELf6P2YdaqERW1dFLlhIVX?=
 =?us-ascii?Q?v+6qWt5BhsKEE/0V32siFNYu41Jlx7o/Ttr1Xq05a+FBC1LBTp7clULDT9U5?=
 =?us-ascii?Q?mD5YR/CqpD5dEWNEDXz46VnJtW8E7I0v4tksNCBIwY5KhfPVTYyce09gf0pa?=
 =?us-ascii?Q?G/8NAIFNYu/Sdm+WuQdDIA8szNMKTUItVt5kpMtQfgk0gdas2X/XVQ1vLg8p?=
 =?us-ascii?Q?MENLQmnsg6fheaUhqCNivAGlfEH0BLbBGJmX1SLqJxCm+mtBiVAgldzaUggM?=
 =?us-ascii?Q?LJ9oqS6+dtvmcsr9Mz9V9OgAcSWSyS/gZE70k5Yu0fpycf52goxgz6wWGIJG?=
 =?us-ascii?Q?5r3MAmW1ia/EanGLeVvrtdeCieajBQ8ayinFRqDVutchVNCKJUPMcNWMRe1h?=
 =?us-ascii?Q?DL9JC3G8cgDWEAJ6NAfZyglmVmuiqhJhYcaX72ID+QX3VJKJFa6uXzBh6nhE?=
 =?us-ascii?Q?q2yPq6nI4dphemI0abPssf9yW9HDHHFib5c2mXf2S1ajqJEd//iTZ8i9reAr?=
 =?us-ascii?Q?G+RlLfhqwPvFCz4NlRKhWEPAzOdETxMbbAzckn4E4dnSXCPXws4mQsLyaysO?=
 =?us-ascii?Q?6RWPsU5+DIPN9LaZd6b2cMIIofQyEOeRoSCtQNIEsk7KeIeaKG2yxPaz9z9Y?=
 =?us-ascii?Q?9ju1004maAu6wdATGUTZVRvfRL/6QEC5ozE2veowsog99VTZknHHjYxQDXJA?=
 =?us-ascii?Q?kOjbKaACKlQLMdHAzxM6Lzavf90ekCo+CDzcOGg3qeImRqtLEtBEzOMMbz9L?=
 =?us-ascii?Q?y3f97DaM/BiNzi4uXeuJ7chsnhJNixQH+5ft40QK1zHhT35VVgQ82yZMMhf9?=
 =?us-ascii?Q?VEMDDADcudslBUz7w3yxuj8eP3u2baAy3oej6hz/U48/iWBjSxksRghTk8tL?=
 =?us-ascii?Q?t3XLSx1aEAWSoUN4psesKzl8AQZ0XuMTR9BUGA+bUmp/ful80XzKlLYiU8JP?=
 =?us-ascii?Q?OSwcrlXutiEe9Q+XGAvaOGtpbR3ACBW8gXykN1foKFwDkAftZzXdJwAMuTh4?=
 =?us-ascii?Q?sdVLDpFFVeDe+jPe1a/SQ8MwyDcdRhHInMwKoG1vjQ3Ks4OJflNKLBJz6JGo?=
 =?us-ascii?Q?HgXMJJWzjpzUb5xfE6nBB2WDFSGMMVmmJ2FsEN07Ua4ZWU6vgMUMB5oVcEnp?=
 =?us-ascii?Q?Flx4AsQeQbCUgvKbbe1DvMMc0HihV2IyKTVceGocJleGJl3qJypCoY/Ei1sv?=
 =?us-ascii?Q?pgtVBhJzBsFUxXD8fTp84NOlLIoLEnzp7uwO55bcdYtBmn9hlim0ZS7WqppX?=
 =?us-ascii?Q?bb6N2NC89Ml2zVQubbiVoe0pGOU/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:34:31.0072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b17893b-633c-4a55-d256-08dc7e303615
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283

Based on commit 85f838adad54 ("dt-bindings: fpga: Convert fpga-region
binding to yaml") fpga/programmable logic should use fpga-region as node
name that's why move to it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 7a5388b7ec6d..9e9a76fca098 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -255,7 +255,7 @@ timer {
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	fpga_full: fpga-full {
+	fpga_full: fpga-region {
 		compatible = "fpga-region";
 		fpga-mgr = <&zynqmp_pcap>;
 		#address-cells = <2>;
-- 
2.40.1


