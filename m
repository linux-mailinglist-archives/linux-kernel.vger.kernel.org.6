Return-Path: <linux-kernel+bounces-259819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DBF939DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38B91F2017B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5009152794;
	Tue, 23 Jul 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="CfgTTb55"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2066.outbound.protection.outlook.com [40.107.255.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9C152789;
	Tue, 23 Jul 2024 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726656; cv=fail; b=PHVis94cnKGY3k71TMqkJX+pWVKayjHiVOAmjuA15LegKggn6/nB5pSFDhOu9lXz+u3FtrZVHF90qkcsDQVyZnA/J4ztpAqbu+YZdsY9ilKTW17AYTPYk+jHmwIMoVLOgKS3E8H5DnsG78KwPOqCVCXROgxZ9oVHo1pBjGD+FxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726656; c=relaxed/simple;
	bh=jW0gVemZ4cl5PWpH2fNOD4IT7gRDiRPR9A8KhbqEULc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2nPICuH0sFV9lwKDhjucyBw0Y5FGYeHaPsEZ83PP08kLN8+NLhsXDNKrwG3ZQdS145jj/i3XmGvX0UC+4UlZtPImEso6I9iYg938w2nh75TkOqGORPmDx3wT7iifME5IilIHK+5OvoufxWEbuIzFZFGJQ07gmzQ/vaSkCP9V9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=CfgTTb55; arc=fail smtp.client-ip=40.107.255.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lffRcww1R3C4HOK5AzHAdl+YlvTDVOCXgF/3F5XB51PDqEWESEmjL/gS3mh5klV345xNjzhQNr/EtnT51WUEyzTYH2GtLLdiYHpMS+uxVOCI9w1fXXSU3s9PArsiYkvzXZFjxnwim65zEIZPHAP7pnhgdpo08kbTsQ/xtykKaSYHeOZriZL/351MA89rRwUVduaUVE9iBbAf/kN1UgCbsHPy9jIzBdRIHKQxnjoVY5xsA34Bzyc7iu9DS3ji3Muqalrpr7GJ4+8/YGvDoUkTCawWlD8MhYB5hwkuVoQBh69//ZUAnWm9MqT3WGwl9UrTNrxt5+qXkczZnbG153iW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP7PVLwcCxjPpagISxynxIAExRDCx7daqT/H5FzbdV8=;
 b=Heeyc2cKYsk7kDnsO2nFShHYnloAoaspIQzH1IXgxcWB0lFXUTEn3aFGm2pfTjG5RxfNFBIcMht/yhW96mARUpQuRDLI09O+x+1fgyu9EsZfVHOByfCECFM00aQcJqTJ6OcnzxY+zbKm/Cbhazz27nstMl+15JvH+fcVcx22LtsWQkioLhTrfK6eUDEQmyRudbWRWiBvnsh0aBp5wYSmrEWslifl51PtIeLih7OQ/rUA4q9i4oVtEc+XQA9I8Mtm55I0qWyjB3W4S5rOL6UqKoVs3qUzQSOMUPOPENMD7UT+Er6GFGDnHXmBJsufTfeA85mrvIhG4JW2RtuxOhn41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP7PVLwcCxjPpagISxynxIAExRDCx7daqT/H5FzbdV8=;
 b=CfgTTb55IBUOhex5isvzjeXHBfh8PSn1MS+ENNdGvhrmmmyu3aQZgat5+4LNUw5kEsyiCA09IGxq/ljH5ICYOT5VYCs473VUOlxRhpiQXe6tFT22Wcg9D0PYtsc1rP+kGhZ96k6gazJH9Jg34sYH0+fLaHWit+IGDOZXrQygDxcsrl6cjAvUpHbJgnKD0I/swUz2trmtBmytPRFtEskb2XhPnidLbXnekJrkQyMFqEr/In2L3M6WI7yhDwfK56YRMRKyDTMNTiyrs31cyHfmE3ziCYtEWzP7KGHjslpWWJnxX+ekteejByRw/gKyNnYMMhZY58imVrvLtkGaCsXE1g==
Received: from PS1PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::13) by TYZPR04MB5606.apcprd04.prod.outlook.com
 (2603:1096:400:1ce::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 23 Jul
 2024 09:24:10 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::f4) by PS1PR01CA0001.outlook.office365.com
 (2603:1096:300:75::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:24:10
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
Subject: [PATCH v11 15/27] ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4 NIC connection
Date: Tue, 23 Jul 2024 17:22:56 +0800
Message-Id: <20240723092310.3565410-16-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYZPR04MB5606:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1002a97a-1105-4956-5c64-08dcaaf935bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8MI15SMSYfjn0jkbmeA2dKdHzBxXiZYwuNnnAF8rjTjkHdtg+WlQGhtFZ0/Z?=
 =?us-ascii?Q?nJvaGL7j4XgGpT2q6pAx1JINozfF9Lo2si9D8MsAd07Ee+PeTjkO2fTNd84o?=
 =?us-ascii?Q?2u6mzaJU07G6hD7KLdJ/Jey8h3h1oYoc59ko3y8HR/BlbZvmzWnmtEQytabe?=
 =?us-ascii?Q?6+m6E8KQoPZWnwEyp9BW8c/3KIv3JDuQgTl/ppCtsBzB5qeA+FeO2sec+XPC?=
 =?us-ascii?Q?KcKaz55kwwYxtOArQs1LyMXIjf+LgphZgnG1mBbdQ89uiXW1fRTUCDOzmquN?=
 =?us-ascii?Q?gX3tiJK2hlU7EaMgjGtc1R365p5HmC0zSGJo9catqMTAW62B1/lhy7wvYAPs?=
 =?us-ascii?Q?75agDZiv0UIw4z98EBinUIWhCCIQwhC43opxtu7Eonecla0KkKHEiKpodC8U?=
 =?us-ascii?Q?kJXDXRNHu+4IKQpZ5KoFbWWAjkRogkyi3HXQ3LZQ2TrtcGOpyguh8yWFusnt?=
 =?us-ascii?Q?+RYc/hOJPM5s1WDhgIOOBZzPviI0fDTFcLbcoMSGpocdwZSEO8DTxlv/Tu/9?=
 =?us-ascii?Q?u0zRHKTWwt2Hc2HZ+2BY/dQ6meiTtzqO5mtr49o6sGiBlrvrFXtKJsHXANBj?=
 =?us-ascii?Q?FAMX5NzJ5FM6eMzo3vmO2ipkumLhVks+2qXEumbuW7+yPcsa39u3ZEwpnW05?=
 =?us-ascii?Q?zLmpwQqAIug1deOa8YQi20quLAOpP8m0sitCmq5l6I1u9TTpMWCUNkGo3m5o?=
 =?us-ascii?Q?j/+73ual6nkfPVZwFbBgh/5ZYqOMtH8rffUjXOARPD70XIXQ2HTntv7xo3ZN?=
 =?us-ascii?Q?iUG22FDcrIj3E4U4CNDnBV1Mg/HvGo3iPPyhRVC3+9QB209RYNexrVznKhMK?=
 =?us-ascii?Q?gH2dt5gv8VWCrQmC5V+lZTFHPTzn1DFJ4rA3QkkzP9mClF5PR1bJOTd9Bksd?=
 =?us-ascii?Q?H4jSJ0gsCyoWXHdiF3pma3UBh6JZa6fYn3BRU6c+VDSVm2pEw6cp7n87IPj7?=
 =?us-ascii?Q?8K/HRS9jPiDt1s8AKKChI8m3k/tJAG6kEFiX17mzvvNAu4Dq9bLmGjEA80WB?=
 =?us-ascii?Q?sB5O6qln70rEHeHG9ynv94OXTUuRHzKjGhbC5WdcliE6HBGiwUPogOwL/01J?=
 =?us-ascii?Q?5Bi1AXkUlb7Bg0qJxMq8usA3NBMaqckSOLSOl17Gw28JmGXwO+8FwRj+DBzR?=
 =?us-ascii?Q?SAceoUyK1UWAjU0nfkD6vzJ7LNAYwb1LD2dXt4h8/eTeT2l31k1yNdZOFnE+?=
 =?us-ascii?Q?WtGhIJfFDmFQeOjzjstkNN1YDaxewRs2MPSoNsz61iusk9wT8K62oPyMdvYV?=
 =?us-ascii?Q?FHgHpoQi5PDp5WqyChzThQeatq9Fs3/xU6uY1FBmyLCVzKFiIq62tUJCe8ep?=
 =?us-ascii?Q?CIYogGgqSoIWNDE5dALwfrS7NGRhmu4cpVhvx63rz0LMbSM2msRjCOwiF+0t?=
 =?us-ascii?Q?o2dEeYvaPrhGDK2TmmCX0Q4C3cGkNxzfFec3hrc5Vc8iR7XuDvswsj1cIwAE?=
 =?us-ascii?Q?Ce6ZXBs0EJP++SPHCWmY8qKjhl2GwpfH?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:24:10.2695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1002a97a-1105-4956-5c64-08dcaaf935bc
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5606

Remove idle state setting for yosemite4 NIC connection

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index df389b506b4b..c0497a1aa93e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1235,7 +1235,6 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
 
 		imux24: i2c@0 {
-- 
2.25.1


