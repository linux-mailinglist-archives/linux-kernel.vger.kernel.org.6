Return-Path: <linux-kernel+bounces-190347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2AD8CFD20
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65141F257FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCD813DB88;
	Mon, 27 May 2024 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fO7upOTY"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83913D8A1;
	Mon, 27 May 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802520; cv=fail; b=Ky0XJjYBsmLKS8EffkIUYECC3H3EB9BaejXU4JYKsu7NaqX/GEvuGavmPSecLoOqYJXCqZ/hFE4CBzGH3n8YXOaWFwLmq3xkCt2TgqX/78ku1ZMzFMVTIfdvf2fExIWUJex2nIVxiyQTKsK14rRoLMO2isG3fAFwJt6DgWu7PGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802520; c=relaxed/simple;
	bh=xZGjYSV3AoMsOTulm9NKcLJNutqz6lhGUqrOdLDu3HE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1Nei+OveXYoyxISfX1whfY0V8UR/COaEba145KGUuISBHQKNwZfzY3kk7Nj9oqsY8a5d9dxc+HUcwjEG4iQ8l0j0Aiv3vOYaGJhVEAjfkK2UAhSm5R0YGveDEzZfNIBrxRJifNdWUo9a5+hm8ZqHQM7RucHhzEDHs4REDYeUPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fO7upOTY; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4nLvqkwDZYlFuUPuma0Td/CatvPwA90GyEtRd3FxbaaJgShW+Iz4tfOBFX/tc7yxW9eJ0P4RuvEAxYW5N47Ae0VG7V34hTTMdqo1iYt2wFsucerhjk34xMoosv/U3Z2uZFLhoadibUJ/b3EVA0LXm1MM/KV2sz7zE+jpqGlqHRtprdeJAkEo2rLEdlTURuiECW/EW6DrX+NsxBopbYhijIQxzs5sot18tf4fcWvvoz7LOI9bLotUvVxpwfwlU010XMZOJy+HPe9X3jvpvUjKTuBkMmK4Hw33Ve4Sq09wTgLL2Nd8JexKdW4NkEufNYLZn0o/jjKthR2Sdj6QbV96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QR+26BQKvQrpzcXYyk+OcshGVyrbSqM86JQ0j0TVKEM=;
 b=Jhx5N/LTRDP3vaRQvEn6Y5+4G0E/PGga+8+BK/d/5IKmczI+5gW6Md98Vh4FF4iOqqG2IBwTnD1Vbe2ccE023lC2ysIhMGD6Rtk4HShBksXkNfiUpfxgJxlai/h74FsIc94fZzW3F9jKwww6/8q8i5ct+QbA9MGj1Ac7oGGf9A2v7pYKfsG7hrcOW+aKku3MZ97dd+FoWIaB5+/uAg5qYFd/ThUvyCRZJR4oZ+FqhTH0nc6gkEVOcXBQ69RWCRC9OUwvoaDHPETpPkFXQOuD93hDt64znyz6YccfYQiSuHbB+1urt490UxPCSlnwtoONt/fjVXXFXOC+v3zZ+dU7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR+26BQKvQrpzcXYyk+OcshGVyrbSqM86JQ0j0TVKEM=;
 b=fO7upOTYf99eJI+x7sh7oYDpx+BYIitRisPZZdWjLCzX9z9yYhEz6GmCwg/VlQWiEoryOLfnthD4XVoN2vR22fb0VwODPwQnn2G8+EwLhNLylN5nyUlyVTYKbgM2ZFvbA6wqTYfyAb7cFMukJdgOFgWubGYAN5FhhirKVoUnQMI=
Received: from SA1P222CA0095.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::26)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 09:35:15 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::5b) by SA1P222CA0095.outlook.office365.com
 (2603:10b6:806:35e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Mon, 27 May 2024 09:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:35:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:35:14 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Vishal Patel <vishal.patel@xilinx.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 12/12] arm64: zynqmp: Add pwm-fan node and fix ttc0 pwm-cells property
Date: Mon, 27 May 2024 11:34:18 +0200
Message-ID: <ff6b4dbfc9bb1b53769ffbf7d0e932c7a8be7c08.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=michal.simek@amd.com; h=from:subject:message-id; bh=1Xedc0gq1O0CvixBiRDZ6qI/t1FkJfQJfW5xWrDpDUI=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4OlWhxbdLFeOa0rKulG2YQvLkukP5rBrFbn7xwqy/ pxtL/W5I4aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEyEU4JhntI9sXltWu5sGhev 9c5Yd8yCM/fpVYYZz7ZuPXHG4PbvRK6bwrkTz/1P+c0CAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1632aaeb-90e6-45c9-44d9-08dc7e305091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EPfnNHDUc2RNAaiw7yn9Oj0b3PeXpob63d8aR0olJN3cUIMr0ZUMrgHWacLO?=
 =?us-ascii?Q?V5eLGxdcYxuG84l7IHxjgwO6wiRDwgopr8NJoVi5vBzoLaWGqTbzfF/Jiu6V?=
 =?us-ascii?Q?rNG3rhSfIYTYvvtyPuu02YTcw3Ukwz+P2StJy2p0KhMWty9+lMbcxB0M2+fS?=
 =?us-ascii?Q?uUsh0O8LwHu+GI6s6xJIUe5mXS73VUjuqllxpEGISGuAnbOVuALXhTmxLRFV?=
 =?us-ascii?Q?mWn5tpTObUmLv/Wjcuim4yXjCnlRZTsWJOAtECN1phh/n31qDVmlu/idloZD?=
 =?us-ascii?Q?ZveKc59VobGy6VfwIY+Ktn6rLIfOtZ4T0s2a2HNP/FI4MMugDGRklYbXHAx1?=
 =?us-ascii?Q?nASaLwTdacGf6k2EfW4fiZj4zZNvZqV8vpFnBhPG87fBqckppWI9i2WcOnkR?=
 =?us-ascii?Q?CWUf5t+K5oS0LwQUDWwXdh8b76RmQd+aY+Ga7SUGcbMlSJ9BaIPBtU0A5e8K?=
 =?us-ascii?Q?wrSUiPFg8C3+z4bydSQqEu1K7CsRZ6Z+gmbjEbPlma7Vm6gvc9Szy6x6e9pB?=
 =?us-ascii?Q?FyMA87AilP2RsvPJBvoLbV0TfYM7XvnW6dE17eMa94QXTj8o2Uvkuc/JQ5Vj?=
 =?us-ascii?Q?uoh4vwUedL+130wcC3o4GjevGqEFYX+dReddL04DUsLs3MuM6kdI1k3ja46T?=
 =?us-ascii?Q?MSVaLd59BT2MohBVvQV99N5w9tKoUkHpIm/6vmR+LewO7P8/iiwJEqBdKJ+4?=
 =?us-ascii?Q?7TWLpOKdnWVLt3pcJfAbIs/RVlu2udYnlep0kG44pLBuMSOVqo06/ekZ4SaR?=
 =?us-ascii?Q?iK2Y25dscTlBLFDZsJj0Redn2qeCV0IHKYFNUmZzX97FZGb3hdjx/e+aAA6i?=
 =?us-ascii?Q?KE7XvhHArkoySxAIG884pI/JyA0qX8T9yCs7of1WyuNLIW+ML2BGLrY8y0qS?=
 =?us-ascii?Q?7W5mr0DzEnfHMmFDK6xz/Rj1J5/2XnxuWGWK6fiN62bMraGqEThQGBP2Xw7p?=
 =?us-ascii?Q?7qeVlK++oqTnk+yWsnfHw5j64clH229eg0fSP4O59ywTdyqoBL/lhbGRfyWZ?=
 =?us-ascii?Q?m5Hag0yNSXGsST4oxdvjo3B70XVNxFPRjQARw3MM6Exj8YFDpKSdmEjL3seP?=
 =?us-ascii?Q?KpJ3JQDS3y6hv2+Vv2td+dCZczSI623n7Hd9nJrO1wmP2yfFfM51M/JAIHOB?=
 =?us-ascii?Q?I81eTYzJgcZNbmWUbAh6grZNh+XmMYwVeHkQcLgIrGxHEOf+Av3Vb7OUcC3W?=
 =?us-ascii?Q?WhCeBREqXH2VpTKvGGHDPnw5djDaFpQ+eAtE2odIORmNezzEHjoR48sulBmD?=
 =?us-ascii?Q?MYrySoJNVrXv58lmAEo+pAe90ah4N4ndAG2lPuWEIoMLM90TdYTp2g4ctnsf?=
 =?us-ascii?Q?BPdzzco3b8PpsYAKRQ34PkL5ZubpyPM8CQWZHxK2beOEcYtF2U1kFvMmjfQ6?=
 =?us-ascii?Q?OzEcRo68w7gUprZ3hdn2KPjfsAOA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:35:15.4370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1632aaeb-90e6-45c9-44d9-08dc7e305091
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031

From: Vishal Patel <vishal.patel@xilinx.com>

Add pwm-fan node to control fan through hwmon and change
pwm-cells property to 3 to allow fancontrol utility to
function correctly.

Signed-off-by: Vishal Patel <vishal.patel@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 2841be11ae66..86e6c4990560 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -103,12 +103,23 @@ ams {
 			<&xilinx_ams 24>, <&xilinx_ams 25>, <&xilinx_ams 26>,
 			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams 29>;
 	};
+
+	pwm-fan {
+		compatible = "pwm-fan";
+		status = "okay";
+		pwms = <&ttc0 2 40000 0>;
+	};
 };
 
 &modepin_gpio {
 	label = "modepin";
 };
 
+&ttc0 {
+	status = "okay";
+	#pwm-cells = <3>;
+};
+
 &uart1 { /* MIO36/MIO37 */
 	status = "okay";
 };
-- 
2.40.1


