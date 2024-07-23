Return-Path: <linux-kernel+bounces-259550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B7939834
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA531C21970
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 02:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157B13B5A5;
	Tue, 23 Jul 2024 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UjaBJFWG"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2042.outbound.protection.outlook.com [40.92.23.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1D13B2B6;
	Tue, 23 Jul 2024 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721701154; cv=fail; b=R4RSTmfQE6+6m7rIpyFdc/7fbZqlqsSt2gzkwFOfxlfIUpEza5OU0NItfPDfVCL3v49hCiH5aB8ne3OmK9NdtN6TFVINqf7awcMQhQHZFOE39MCtFXQwyu/DZCUe+gmu7X/ZT8AsgDpV8SfTU5oK5jplw2JihpAICOX2veYH4VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721701154; c=relaxed/simple;
	bh=dLXUGtvpb9/Cr4Spos+eUk9K7X7kqo3RFIc5QcAfIaM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jAMbPef8KX4/Xu8lHH/d7YBwQ/ns5B9BT59NuCE2GPgB7FVd7mdlCPM32YBSFONJojCEnNDJHXkZ6wLp5nLJcq0XI7Z09p6Qh4+iJgQDNvb9Sd23wR/FsSyElql7zIh1SoNO/R+IHt06/lrsjJJBe8UrHEL5nZwtlhPSIKjqwj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UjaBJFWG; arc=fail smtp.client-ip=40.92.23.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QB2BIQFxVmGJVdEv431qq05x4YuHx+TO2mvXd2j7cCYUZrEGLNqJXBmULu2NPMOpAKIf1z4w2Ek8r+kDF+0zSeWZZWCSY+IqocLf1j1hRKCV81kKL0FkST1qo13nCXTEkWrVrKuQHTi09EjJeg7izVygofGY4WLgMZaGO2nrNtaMtdaXsDGtoC1TU5XGnH8dZAaGRfYM6x0/XvBxYUw1T0uwZOQaZRu3m99331nVLig7AtDTWp8vY4lT5kNPY7P4Ga9cZWHObnmlmP3c/VLcTIE+O6bzqIlB/0d+DdQYr1JQ7UkEy1+867A80gnrTKnvx9+2gufIZ3i4C0fgIAFrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVqoP6N7yFGG1dbc+ozcjeci9fVNVSwhE93MqgISy24=;
 b=B0WIrqw1wXJNEadDua6uHgPGZaldGQik/Pq5U/NeObMEVIwFfl0oMjbtrQob+13crg/IH7eUANsII5kn9B/aWBXFZ6WrSYXhqpqmj1o7/DTp/Ey9aoA5O5Y4QX7WyTyqnOnPv68FJfFi58xFlK6pSl3dZPAfGNNusBFibP+7+5E5UovVvWTA/ys4WWREPl0YvsN/qsOmNEhvkS0hQInr/zX19PMi8w8EDrJ0IvevyRW+Z7dlpT4a5F9vOf3YiEsqEIGmIjkYDPl+v8s2rhnIlrDhGo3gFULzizzbilV8FEv1uXLwY8k79Ty7sygOrQJmG2WPMEaySdifvp29wkwfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVqoP6N7yFGG1dbc+ozcjeci9fVNVSwhE93MqgISy24=;
 b=UjaBJFWG2XxNxrULV3jXr7W2JAIpolPgvfuf7omad70/Q1nfaJQq6/BM3/tXcXgkvxVsKCXPAwJveBIThrt/3ZaVOhn7eKeLBhWik/fMCc49wl3hlRb4OT0RQHIlDnG8dNzl2uIb6rcVq/7kslVCBobABHx9T0lsyLiLvXVQRVefGiTpRd6Pyo8ZpyKoLvZVQjnDuel5BRtcP/PtUmh90jshkym/xfiiurXJnXuZADxii6xC4uSanH/NvKNZ9M2A4J0qURlz7ZfGncZw2YkwwMXcHgRo3tE1wtsm6bfQ+GEJxgMPlPBLXxkF1qNdmEjEYNJGOACrxM0XuQtp4p3KQQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB7096.namprd20.prod.outlook.com (2603:10b6:510:305::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Tue, 23 Jul
 2024 02:19:09 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 02:19:09 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: dts: sophgo: Add sdhci0 configuration for Huanshan Pi
Date: Tue, 23 Jul 2024 10:18:49 +0800
Message-ID:
 <IA1PR20MB49538AC83C5DB314D10F7186BBA92@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [E5z/HCVyRP85ZYWvcajIW25oCMklz0L6DcTyN+bseTI=]
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240723021850.227272-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 02427b8a-7f87-439d-ec9a-08dcaabdd610
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	NCbyqctp7WnutumywhNBov83fJL7XiYpbYVzZU85u/K586gcu4R4DEBG7iDXXA9fPIYR5NXkMv+ysO+UXE81SUjQazECBTFE/6cddWFvuzEgdzOIkHnp+sMToBOA+ZYswPrl04Pu+hCkcV++Lt9xBqASzEht9q4WpYEq8hjzkhAUq6TrB26lAGjw7m7HI/s8w3iKo4NliWmyFEk5u3sV+gYI2ORF8K2fvBNzCd9TpHrpfb5iGMMs+q3Uge3Vdn+mV1y4SMwxWfw35EocurRgcc/zd5f19LowFn2rsizHdTQGMLIutnFv3oA3wbWXNWSHhk8kEG9GkWKZ0QkbP9HPNkmzsz6WxeC4PvIQgLlDOSmU0BzGO+Vo5ytboxGcloHfd209Fdqg2ZtbrUVLWcKLV3grbG+LuDnbTY91mscVlnFyd6oFWTHPYBuR+VatWU1lg2vRueLl1TRV/A5xyMyCM/tAiul180FBuV13wKKUEvpCSXafTULpEv3mgKWd//Q/5CgJPi/eo/pd53UdDEV5UdPntUqpod4QN9r2y/0TcEqZvosU/Uc0HyvWGlyxVyt64qLTxeNWcvoNN7ERXapUa/gZcY30whqeNm1+0VOn7ZlRht9m2CICPYTHbmJoUmh+3oIlIJh7HOsSHUSBmmw659lSAsI6/QMiXlbDq7SIlx2njMGMj72WsjlN9uP+BV+5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/xsxRlJEoswd3tDvPABoZVHrYQgm/EI5m+mBVJLyIcG0IWHf5V0n7ASIwCq?=
 =?us-ascii?Q?Jr48QXBNEPgMT2W6jQgwUzJopkaIcM4hm10rBV7J9+d881rCR7n4t8n/XyzW?=
 =?us-ascii?Q?LTpmBGqtDQUq8V+M/7z8nqaqXNw1Z1apbu1z2vehK9KJ7LM7LEyoFBfWuhLZ?=
 =?us-ascii?Q?sJD60YzhYNWmd9bD/cm7ppZp+EK2fXur4UVs+pT+JHghb90LaOZ4IjZVgmHF?=
 =?us-ascii?Q?FUOUmFrUzWUpLL8ZOY0b3eA1nIg/odn6eUqKJxztK6n5jbi8tznuiEUTJIH7?=
 =?us-ascii?Q?J/G39CR2fpcK/CXsqf4/pxDYp5E4JbiKlMW2fLRNG1/MpVOeuntQWZfnLa9n?=
 =?us-ascii?Q?+SAkqo/GDcDmHABL2elMN6q8Z2ZVCmrs1kjY3W4xQhGoQlLpr++9D8zHUJck?=
 =?us-ascii?Q?8XXHJNNMGVmWRdcWhncqKxeHKBO63F4gM+0jICCvpZio+fLZr5PGYR8dUhTD?=
 =?us-ascii?Q?5T+MrIbQvqdv4BYOp2CTtZA+NDqo2JrLrqkFm7YsH0SUq9Bbq5uGGOT9Ns2F?=
 =?us-ascii?Q?wLpvVMk5k5hJAgn4Ld+EUXY3F1GGGfaAOMJ4D+XVsWuP/agAJoyA7ZqvG34t?=
 =?us-ascii?Q?LN1HJnB7/BfK2HMfr4anw+I/cBs7AQy1eaRwmYR7nn417m+2YBDNJIiFZz7s?=
 =?us-ascii?Q?edTcsdQ0JCdiucEhWuiaggBL2JhmXG79AMkXBwBzNEncrV9S6MvUYDoS2faH?=
 =?us-ascii?Q?XgnFUlZgznL3C/oxQFhezmg6vLgqYUmIoxGMnpyyQjS5xth2t6f/zHV4oQSQ?=
 =?us-ascii?Q?zJhkaRxP3+gu9Zel7SMt5xKD9XlwRZ+yTpbFdkmhgRASoVbJgrJf9Szb47f6?=
 =?us-ascii?Q?MffZV6hgMpLbtL/kn2o7HczuWb4S3Q8fWAJLcs7MuA2SBYxbxblf7YovQNeL?=
 =?us-ascii?Q?aMDP9dEk9qOZbMQNUC1euPhRH4b9GKV3ZtW7hc5wi10PVinMPnQNLiUcrksz?=
 =?us-ascii?Q?ymGFDjm2TkSyF13+It4nymyyKIRLuFXJNWFLRQS2dGEhYpWgPUtFPBl4gOjC?=
 =?us-ascii?Q?KHkoKmfpHZJESBqesQvLC1pkT+L5+ncFoOrjv5l/9d1bv7VB94kQ/oxz4W2Z?=
 =?us-ascii?Q?hoTpC78+lQJBU7rHFEQ226TR9x66kbvE33LypzefA4U7j5rN9LG+jEEjaIBK?=
 =?us-ascii?Q?bgiyXKPsXMbV+GbvsTz0oHpL1UWYjgULdZuvZFsqQgqsCX8GCBge65h/QayF?=
 =?us-ascii?Q?3D1MA/iAZSWbHDpPA7dY4bbwBrKkWTxekhKCW9jYVnN+HkdcRSqSp3fXniCW?=
 =?us-ascii?Q?ZP5d3XB51qsospseDuoJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02427b8a-7f87-439d-ec9a-08dcaabdd610
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 02:19:09.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB7096

Add configuration for sdhci0 for Huanshan Pi to support sd card.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
index aa361f3a86bb..7b5f57853690 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
@@ -43,6 +43,15 @@ &osc {
 	clock-frequency = <25000000>;
 };

+&sdhci0 {
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+};
+
 &uart0 {
 	status = "okay";
 };
--
2.45.2


