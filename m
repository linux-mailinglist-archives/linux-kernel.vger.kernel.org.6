Return-Path: <linux-kernel+bounces-441286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E50C9ECC58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AB318866E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DECD237FDD;
	Wed, 11 Dec 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DTG/qvjH"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19622C354;
	Wed, 11 Dec 2024 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920941; cv=fail; b=uWgd27/teK6xbPGbWzTAGkVHFa1S1yXhsWfZsh6hoVgVtIu5EnESJCd+iu5PuRXQePZhqNPqTlDX9beSPj+CNGxJb9938jgR5EFrxiijnEkFZCXvP5Z0D4WISaot5df5HPua0mHRI+YsNGr+tRfrebrfIWLxwgG80hkR8OzqB5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920941; c=relaxed/simple;
	bh=BSCLgMze2JWEis0cbc/oPEr98P1ee0m3u4ARAvzf9do=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t71eu8PnE6nHn3izcMuyzLi/MvbVJcNatNF890m+knIs2rNXThGGsetzYKr3hS9CbS8tIvNeLKJT2+43RWh+RrVRxdbOTzKy42V57nK1hHRX6TWt7xCe5myeeDARcj4mFSwb7pw8q5sGoEG1RJZNfkVZ/v+4ZgEF3fWiNujyTGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DTG/qvjH; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyaG7B7RlkymYX4bSf0vfuywswpIANca53NCvXfqQY8nv4b+lMTot4xsE8TvKpefn77RrXS86I44zTY2BJMbEuRCKjX2A901gL633r0ZymiGCI6i6XVLmJlZbuturWDQbdNKl09uDJD50UJNlRnObtDaUhbKS4ImA7oKoaZ0aw9bo94aeQt5FfJczYY5Ws4U3w5+ppSoGKBodh3RhGMXj0f64odhFxHAiWJcpA0mSd44876lllFDUF2D3UKRHJUt0GmywNRWQDtVbUrGg7R6UuDM97FmG2f/JlZm+4W+ZyzLGYLtn8Hj4c0mr0JdD2NvW0SbklzNHoFSPWLoyxi0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cyqnm0cSD7tezhJlb5nrNcIjjGgrXHXSdBnNrH4EYg=;
 b=ySqLWVKvWq60NpcXzpNTfV1J8yNBuUdEpJ4QwjmfjRUKux5YCOkPrEgpzrE0g783STcoSVahyYqZa+RGpXQg8Qb0DwqnlbkaBMf7ZFE6xqBZiyyTRYe5ACCOT7Lbpv3fK+TUFQsLkgEbzZF8SNHi4MY3jVC2eCFon1aNS7epph+KVSc74AsWC/gbnYn3iNMka39sAFMoAIoSgpCXdnv0tGKiV++bDJupeYGG3zKrMG/rzkwQNzMTk3UQaUMWlJdwfFsxfEriUgPembYCJL/YzQUOHKLj30OuyAkQKU4jg4p5V2ywr7/AcrtVsa+Erg0OmWDaBvQmwy/n0qxLAcEhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cyqnm0cSD7tezhJlb5nrNcIjjGgrXHXSdBnNrH4EYg=;
 b=DTG/qvjH6V9/yN1SriL4eLSbhOgFl53g4Pj8v62SFcHw5jEgM39cA+WNU+PG0iLEF0KiZ/yzFeiIrMclYWx1+HFJNGEJX9C3cH/46Sdg4qdscvj1K/RX8ZD1ADH3YYafTgnOAIdus1LTmJbWbblmHkf129KMJK+XbrTcTATbN/Q=
Received: from BN9PR03CA0373.namprd03.prod.outlook.com (2603:10b6:408:f7::18)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 12:42:15 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::d3) by BN9PR03CA0373.outlook.office365.com
 (2603:10b6:408:f7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 12:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:42:14 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:42:12 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 09/15] ARM: zynq: Point via nvmem0 alias to eeprom on zc702/zc706
Date: Wed, 11 Dec 2024 13:41:28 +0100
Message-ID: <c4a28874455a8747638551cf09ba31aa803b8b09.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1597; i=michal.simek@amd.com; h=from:subject:message-id; bh=BSCLgMze2JWEis0cbc/oPEr98P1ee0m3u4ARAvzf9do=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjpoZuXPjxSx2Xntrvbjn8J6yG12M1zj5+G5N7nmy7 ur9u1GdHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAid7YzLGhTKmZdu88w2LZq 7YxH4SFx+92X2zLMr71doRzZFR68qzdsC4vYhSs+GswVAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 21910ab4-6aa9-457b-f520-08dd19e13d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ssT8mx/voeh14NtFLUjJsPdSH3JXj5L8RKB3c+uRtcGIaEbjAqE93QtL5NL?=
 =?us-ascii?Q?aXF9HU089pf9CV9Eyi+XAQhPevH5yhHfzObSuOvSmeTB4NUEJmmdmkJNMHve?=
 =?us-ascii?Q?vqoXqhw8TvXJtiRkZJDXtCJowfhcHxiqWxEEXBbDUueUL5c7ktNbTplYdVry?=
 =?us-ascii?Q?JU0wFxkGGvlgmOn7pEdLELQaHkj7v/BZCcgLuGakSjsK3noZ3gS7QcMhhDsO?=
 =?us-ascii?Q?7EDneJkxYlk+561XdmkFyktl+NdZXirQ7Cp7RA7ku5EEK8Z+kSkeebnuPwp5?=
 =?us-ascii?Q?Efss2052zGRgAM+HJPR3oA26nP9GorljGB7BX8Dloul9RFDuRFoZnhalN30W?=
 =?us-ascii?Q?00VdWyyMZB63bM+mqdAh5rs/1LuB6bDyCOoGH5fK3mdj3LDuhQ4PfMafCHiC?=
 =?us-ascii?Q?AKKpAACmVbB8k7OFfPWn/DKMRj+w5b/bo7jTsJR/sIvEqzBJvzTK6xPDTpCu?=
 =?us-ascii?Q?7DGlunQIHBjez0F3wmx6OrSQWTTMtOibGkQJsD1q5aD8XZfPxbSDZ8MaqE4g?=
 =?us-ascii?Q?UFleup3JALfhevLpun16CrqeG+009RugYunEPA/uH9sqSwfdEc9JzOX09VBu?=
 =?us-ascii?Q?8ZpCH/B8UORp1g7GTYX0AACXJs/ijLkQ74zG3Zh5OJLxPr5Qwj+n0yUUPeW+?=
 =?us-ascii?Q?FerXKSTu8RzqFHikG7znOnJgT0YivEI2Xz22L/K3OKi24fP2+zkEqM7eHHoi?=
 =?us-ascii?Q?wyH9mVhVuCZsubLxenYi4AHuCHjRvj1XZ4GtLYQUezyqksHsaBTXqkbYErnJ?=
 =?us-ascii?Q?0UqIjOOJ3Wj+doLlCim4eGDJ+KJYfONcws0OB9Z/TT0ajIwkvNsLdniJd8VI?=
 =?us-ascii?Q?RYrxs/FdNRKUhCvolRQwnVcnMxnToSqfQBZttYM5aBXKNNXkMgvtf5ZcraRy?=
 =?us-ascii?Q?UVX94O/2smNGa+rRJ7/pDUtSMAbuCtG3ldmblkk2pSaLJx1nmFuxddY6og41?=
 =?us-ascii?Q?363il1qBigwFjMtVTQyjhY+pM7mjAxxLNi6mEX5hgkJRJlM32x960X0ccc69?=
 =?us-ascii?Q?Trl5zz7iGPYbvtlsH+8sMeCgfHnci5rem0ZlRmcgtcr0oK4en4l4VOTVWd4j?=
 =?us-ascii?Q?yyRB6j1nplSjqFrFg6D9B2ph3RincgfUCZcCYbrKCbqweq6Wj9hARERCXjvk?=
 =?us-ascii?Q?Fe5p9HqH4y3ZSvWD72/WW7vQhVKKCrWZeUIUJE7LmF8DjH2guMi+I3cooctP?=
 =?us-ascii?Q?31zVsKP/6Pws9sg8guxSjmKBk+yKeJQNLAGoUeonxt6E1bwkkY0ufzkTTPbx?=
 =?us-ascii?Q?upQHk3jeO9GedQk2ShelZuCYF5rtNZObj7Qk5yAJCrHbSAB+9vAsT+H8kFwD?=
 =?us-ascii?Q?xJ04P1ueMpKDTYvxHjFlnWZj+ex7R7TeNZgu9T7ApQariUCkJF39sbbF99j3?=
 =?us-ascii?Q?iteyQAcsjONeguaRIDDtJnkTn6ceK2eFKoKGtmxi0w8JweRqC+1HnoJZXpgQ?=
 =?us-ascii?Q?62GEe9eDlR0Nzr2tIs/gjl5fST00qc3P?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:42:14.7427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21910ab4-6aa9-457b-f520-08dd19e13d95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087

EEPROM stores identification information about board like a board name,
revision, serial number and ethernet MAC address. U-Boot is capable to read
nvmemX aliases and read/display provided information when nvmem alias link
is described.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-zc702.dts | 3 ++-
 arch/arm/boot/dts/xilinx/zynq-zc706.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
index 975385f4ac01..9a4f3e822c7e 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
@@ -16,6 +16,7 @@ aliases {
 		i2c0 = &i2c0;
 		serial0 = &uart1;
 		mmc0 = &sdhci0;
+		nvmem0 = &eeprom;
 	};
 
 	memory@0 {
@@ -140,7 +141,7 @@ i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
-			eeprom@54 {
+			eeprom: eeprom@54 {
 				compatible = "atmel,24c08";
 				reg = <0x54>;
 			};
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc706.dts b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
index 199fb37257c2..1ebf8e422c3c 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc706.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
@@ -15,6 +15,7 @@ aliases {
 		i2c0 = &i2c0;
 		serial0 = &uart1;
 		mmc0 = &sdhci0;
+		nvmem0 = &eeprom;
 	};
 
 	memory@0 {
@@ -99,7 +100,7 @@ i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
-			eeprom@54 {
+			eeprom: eeprom@54 {
 				compatible = "atmel,24c08";
 				reg = <0x54>;
 			};
-- 
2.43.0


