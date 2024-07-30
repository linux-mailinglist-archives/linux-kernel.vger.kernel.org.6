Return-Path: <linux-kernel+bounces-266952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E687D940A49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69CBF1F23A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0731922F3;
	Tue, 30 Jul 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OCLRbpQn"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7CE191F6C;
	Tue, 30 Jul 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325888; cv=fail; b=MiLeTh7H6SA4d0FRaGYodT9Cs6gE/E0XEEMnmcx/ajcx/LsjlA4O09Mr5IMP4+qkNuH0Cs4oipcwQ5TIidzSUl/kJUpMjj7+XLT8HwARbH59Cgt8LdnpPyoO1dAqnidoYylnA5zIUZJt10BFh+K/XpY8a00jIWG8qNzuaYIMFiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325888; c=relaxed/simple;
	bh=wm0qZdTTVQv6FXzqbxKkwRftOoSYRy/xw4d6i6/wjeU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kEjKeLyiFFCPPHwaJJi1q/rt4NclVwQ5zzgmiTSZA7GmCXQc/NjThTMK/YmbxqWwGbvgAe8uuPxKnskvNZA2AIcp3ih/qqPeku+8pabn16mEG6XGMOLjnfMO8woCXgWjwCKCle0ZC0u5Ngqpd+nhq85ML7a/oWBfDxqXA/RERQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OCLRbpQn; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/0V4XeoakinkgiYWgVOb8K+HM6Ar3uztI7Z2/mf4RoII0nv4nbn1OorgfWQ0qXlADDK6Ya6Zf/HFPMjuE8wsBAMxJgJZRrH2HBCKWvZupUYkE9w3I4aK0wPuMVAk7FJlCF0qrd5Ih7qJdVcbp8xxO/4shK9iuC7fZtNORjvnb1vnv6zt+ALSAZ9XIEyS7ze//XyfhhqPthHxacpcZthM3W84fy9MTTXjoaFbWGuGGu3a9pMDRl2RVvs7an/1LpgO5RM2CjmwWKvLUqHBu3ylFptumYV7KRRn4g2JaChLJJKqombMDqyhvJwRmzRMMc1T473lb727TcDmoYzsBrLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wECj3+GqcK2tRhL8xNlXAd6ImYQ6shlW109w6sHvDnc=;
 b=eK8Po1pW7sKdK8yCTDUitGg9o9bTqgu64nGuTG6OdXkeMh/4ZrYrcrWShYominAPGAZvIufHnf5gV51kZebA94f8H66GTQUBdrhOlx+BGKl6694QmRvlIF+JUaWoc/9n57NAoxpFzMz3Jg/pdmNBtfDqBc9/MWCerPMIUVAX8fbqLfD26QCi+HF09VKK0h6NWoX1qc47bXFkfJWxmYNXhSamVsXM05+uCMULOFklqkxl6Ayl6NdmZSFkJDeVJMcnpvraQ/PaHrY4CiExxYhG1uk+RL5e/QpEST5ElvCJCsAm+QTTD/mFta0137DiSU4jPy37CEm284wi2JaqXmJ4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wECj3+GqcK2tRhL8xNlXAd6ImYQ6shlW109w6sHvDnc=;
 b=OCLRbpQnx7QZbUk1opkqsoFnlb4XeDTyqH+w1MQu1KTe1MwDLEPGHWegpkjfTxXT32SryUHNl5Lj1qlME3dRKqk8LUIXEeY/5zuPfOIyqj7KX4GtPcONcMmuiPDCIy/EubyWzsPu46IJP+x2MuXZo/Zy2UXRRXrT5MGKfOTFUW4=
Received: from BN9PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:fb::31)
 by IA1PR12MB7613.namprd12.prod.outlook.com (2603:10b6:208:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:51:23 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::7c) by BN9PR03CA0056.outlook.office365.com
 (2603:10b6:408:fb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 07:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.11 via Frontend Transport; Tue, 30 Jul 2024 07:51:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:51:21 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>, <robh@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Kalyani Akula <kalyani.akula@amd.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Praveen Teja Kundanala
	<praveen.teja.kundanala@amd.com>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>, "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [RESEND PATCH] dt-bindings: nvmem: Use soc-nvmem node name instead of nvmem
Date: Tue, 30 Jul 2024 09:51:12 +0200
Message-ID: <5eeb68b920d1ef186c4f623698eaa0557e0fadc7.1722325870.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2171; i=michal.simek@amd.com; h=from:subject:message-id; bh=wm0qZdTTVQv6FXzqbxKkwRftOoSYRy/xw4d6i6/wjeU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQVs4t2Grzdd7/8btUJ3+TqyJXqHY+at98ufPn4ML9/X mjtg2SOjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCRtDyG+VFzlsrNPj4h231n /GqL0oY7GpO04xjmcG7iZfv7KobR0sBNyunXXiff8FYVAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|IA1PR12MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ca78e8-e984-4cf6-efdd-08dcb06c682a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hWiN9xsU1YewCaVLR68UHmBQiaJHyzvjPHzQ7ch/xqopiblcx2B2iNW3kKhc?=
 =?us-ascii?Q?stJKIuVq7NoxQFZ1ja++STL/usONqEycInAnc2rPOFj98DHY3NjvTCNFMsvP?=
 =?us-ascii?Q?mNJegx95X0080sGA7lZf69Ptx53cJrQ10uC0w7z3uZ2gf2a+ymuoMLW8ig8V?=
 =?us-ascii?Q?tQdsHeYfCJq0YHZYXgxfZnRu6xybBKNGbd1TlT0jt6mfhxGtpRb3biFF3kub?=
 =?us-ascii?Q?xPV+xlpIt3spj39w1t7PXN87JYfw0IzczvBOG3h3oe/cmTQY+ZvujFOHu+yn?=
 =?us-ascii?Q?//gl9Wp/AGqU1sxNo7wfXJpSrUOX+kRuYvd36wMYBzTr393iXCjtmuivwcBI?=
 =?us-ascii?Q?wWk+CkYwRBUnokoCVfn+MLBACyrOt5srtZo1PS/wuug0kERFvbUGpi1eistV?=
 =?us-ascii?Q?BtUzUvLoTioTpscDekWKy6qrUQjPxN4GxfyYF8oSlb0z4VT+SQOPnYmHQ1Rv?=
 =?us-ascii?Q?jzpJHTvLNSThOkmBewp/pKuclfBFN9AwJLG9wcK+E+BMLNwgLz63ZDmjBwwz?=
 =?us-ascii?Q?CdjbgMOw4KW4uGjdt0FRcxpbMMFacfELqtxevpwKEeSg7vgZyoS5W3EII/VC?=
 =?us-ascii?Q?Mxd2ytlg07UBkbNqYs6yq1lnwh+wmTt66Z5oeZf/4DJ0PoduElmnGemj+sjD?=
 =?us-ascii?Q?pDQ1sxFW6vW6BbNK1/EsP5cgOu9rIX2xTwdFlQf1E5acGB2WgpwRcinsUj22?=
 =?us-ascii?Q?2USU+uaD1DB/NGQPctT2ZEGHflncwXOLGm9KvetGk4IE3Vh2+ZrTSEVE9CvX?=
 =?us-ascii?Q?p2Pm1xiG2tY8wnMw3Wj/PPn4+UtJ9TtC9LoR82R6mdEp6DU5sYQtAf5BGZ5b?=
 =?us-ascii?Q?Pu9h+pHCOsCtMo2ozLsH/j1qi6cJJq287eAFkiEO6PKqstbD7Ggvqz/ohBy9?=
 =?us-ascii?Q?QXBDYnnLIB5Uwu88ed97N3QyBgBFJNz9BTk9DUfBB88TOVW+a8daVo6c1Gad?=
 =?us-ascii?Q?KbxmEMG341POgqS6xpXU7nxZEOx9fZbzdG3Ldw9aW3bZafx+kT2Vw6eL9YH8?=
 =?us-ascii?Q?XHXvm39mToHen+NMnPIgYaopJVpdl3uPqQ2ZUBHyhh1VB2w1OjSud6ofsCuQ?=
 =?us-ascii?Q?kHBOi5gVk97XR16OdNGP9QhR0A0sf3CR9HKXTzBZF0EbCCKVXdeXkUABrysS?=
 =?us-ascii?Q?saqftuW73pNzO+y2OezuZU4D6RpPC/xJgbbUYWxzeukhh6KDY0epiQsvDEr9?=
 =?us-ascii?Q?eBx85djx+AGN1XgluIGfCnQb808IfICguheEG+MNKNzhX8eHJqTXzsRAGwe1?=
 =?us-ascii?Q?GjCLy+4VkN7VGeazLQSUoh8uLdpn5GWsaB37VlkF8kNN+kVaop2WEnoB2g7U?=
 =?us-ascii?Q?SBeXHEu/cHATgCLUCSKHZCi67CTEpNSrD1nQKpdsDikZlGHC64u+BUqQ0rEa?=
 =?us-ascii?Q?0VvJyoEpL8tYPNlt6fAf/qtFOTb29STOJxHWOvdu69AhLW/HSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:51:22.9743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ca78e8-e984-4cf6-efdd-08dcb06c682a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7613

Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
why also update example to have it described correctly everywhere.

Fixes: a0cfd5e99782 ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Adding comments from origin version
https://lore.kernel.org/r/42c21f3bcd75f821061d047730dbbcd40233e256.1716800023.git.michal.simek@amd.com

Rob:
 This doesn't seem like an improvement. Is there another nvmem node at
 this level? I would fix the binding instead if not.

Michal:
That name came from discussion with Conor. None suggested to fix dt-schema that's why soc-nvmem has been propagated to DT already and this patch is just fixing last occurrence.

commit d8764d347bd737efec00fae81133ffad0ae084bb (tag: zynqmp-dt-for-6.9)
Author:     Michal Simek <michal.simek@amd.com>
AuthorDate: Wed Jan 31 10:17:28 2024 +0100

    dt-bindings: firmware: xilinx: Describe soc-nvmem subnode

    Describe soc-nvmem subnode as the part of firmware node. The name can't be
    pure nvmem because dt-schema already defines it as array property that's
    why different name should be used.

    Acked-by: Conor Dooley <conor.dooley@microchip.com>
    Link: https://lore.kernel.org/r/24fe6adbf2424360618e8f5ca541ebfd8bb0723e.1706692641.git.michal.simek@amd.com
    Signed-off-by: Michal Simek <michal.simek@amd.com>

---
 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
index 917c40d5c382..1cbe44ab23b1 100644
--- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
@@ -28,7 +28,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    nvmem {
+    soc-nvmem {
         compatible = "xlnx,zynqmp-nvmem-fw";
         nvmem-layout {
             compatible = "fixed-layout";
-- 
2.43.0


