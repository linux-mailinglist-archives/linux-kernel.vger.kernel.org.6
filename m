Return-Path: <linux-kernel+bounces-187255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E38CCF13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA60B22F44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31DB15098E;
	Thu, 23 May 2024 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="CXfE5ajf"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2066.outbound.protection.outlook.com [40.107.117.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852214F9F2;
	Thu, 23 May 2024 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455974; cv=fail; b=InHY9us5ldXdPfN68YwzipXizeDXL+QvRu7o9nQ5nkVVAgpYHjMbT/EOEiaVjJ8XAOKJMF0h61Ff7hnmGDlk1Kgo/zOkGFPj4evzpqVWwsWTo5emiAQD6H1DWHorpVI3ZxpCd1REgYw/GQK0+PEPviNnxcFmqif0tSIafG1/iss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455974; c=relaxed/simple;
	bh=hlO3lXCni/1q/kb7fxUehMkLx79dHWk0XBPB/to4DPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2r9Fo9J5QhQF9Fm9zgrbl/eytZwZd2QVkXiaQdF5cD3tIcPFTcXslobStumPUY/+pUDNg9FqBoij2vcfWStEo3L94DZNYxjO3n6lSajx1Uxg9Xq7uokL+kT3scyJ5fHgajqeeAOw1FKkk59XQLJHEgl1QsqFCN0WZWXlqZW22g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=CXfE5ajf; arc=fail smtp.client-ip=40.107.117.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE9swRD1B1hUu3A+bS5tn9wDojRmFBS/qgjn6BvBmHX5uObgz+9R4THqpsWC5Ac19jqJKFJU+FWnDEdi+lvX4TltupxScccDlgl2ObW+h9YPvnnSJt4O541SDN4oWvryBsR5RRHmOLyrPyqJM10+cjOMVtadhO2bKJf/TTW73MaWxRo3ZKRs2F7L+k5IWIFxIAiWPCsh25ATPdLUIQM1S5jKWDPTsIfhZR4WklknStkYpKABOpPWWZDlTrjs5i2FrjstAf1MQ9mGwvSRPtSG1bDQ/U2G2ZKQPyBchBxQvlsfFqbdCu7ZMb2wIyMAtsXMo/35JCg1R8Bpzb16W9g2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPuO9qcjCRKT1hG8tAOI8QlF9L4C9eaYFzPaHsZZ6p4=;
 b=oB5mEuEcmEWMDpBfKczd/15XjNqyYpBt9sY2zEMTNQOMRPC/jTwbkrktr6275qeRlkWRzNMYHoXfx+URE9Acmi+6KM2kGDPyPU5FWD1J/PKgGYcH85+f6LcEk3989wymqtyouLXHRaOUa5FytlfSgoHyJa/Ab1q2xk57GFuTP91/J0zBPs5wkorhbYmkeFk0ElmHn1n9zNkp5W7EUJ9BTgdGb8St1TXXyjRhZbEHHcs+ishOznGK/a775qjpbgBnotyR2S9NsVLvp/WmhNytvMToo1lQv+TvorC7mTRHXbSKFx6xt0BwAejIbcRaB4UzwbXIffTe2bBqKHPDrn4l9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPuO9qcjCRKT1hG8tAOI8QlF9L4C9eaYFzPaHsZZ6p4=;
 b=CXfE5ajf8Yamko43CI1VBdLGk7yk7FNeGH88diT9xaHgU1tIKYfHrbZRVc0tZIbSCfPtsJJ7NodHPANvLGCqvSMVpFS0WBTLLS64hKm18ymwqrOrElR+NiccICSBSuBz0LISdSoeih7GCaSuFexSmizhw1BQR2n+vyPSsuUJiUA1+TAg06Dxnnr1H0PsrTK3ElRLe4odTI0quvqe1kbZsJbxXe/UKTRBD06OWHFqeMjiPIrWGey88QmIIO0ePRTu4WD25XW1ga+sFUYt/sUbB4fO72dx+ScE0HYgd7DUT0/f0PaifPOxAursGfCyxM9f81VjHtgL9+LHLwwgG+Vipw==
Received: from PS2PR03CA0001.apcprd03.prod.outlook.com (2603:1096:300:5b::13)
 by TYSPR04MB8128.apcprd04.prod.outlook.com (2603:1096:405:9a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 09:19:27 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::c0) by PS2PR03CA0001.outlook.office365.com
 (2603:1096:300:5b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:19:27
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
Subject: [PATCH v8 22/23] ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
Date: Thu, 23 May 2024 17:18:09 +0800
Message-Id: <20240523091812.2032933-23-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYSPR04MB8128:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 651a361d-d932-4068-d96c-08dc7b0971bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B1q6i9v+TSFfsZUHkOHNFNQ6YBHuOQo+VCijPwLxgmPRhseyT6ERpfm4sXMX?=
 =?us-ascii?Q?WRx+FcLj6wa9/oFbc+8MhZ0guLBV7kOSmEyHBCtgRJFaoI7CB3TAUiFO/L3R?=
 =?us-ascii?Q?dlBV1YuUr6BcEUOQ46FFryWi3I84HdhE7gxmPuI2bOoyGnrBnaSOpMOylb5S?=
 =?us-ascii?Q?PABv/BLRnDyg/+DWihYwXIJ0zajDft82ruAy/x98r0gz/TV7oGz6niIduqmf?=
 =?us-ascii?Q?pBdfzhPtyxJspVkkathki0Yj4XiOyO8BruMGndZWNsNYj6/VdHtCEjNi7kIq?=
 =?us-ascii?Q?d9dSRxt7WW/NLvupZSBbwQjqRv7IVeQQ6/1RBQAIVsxm56gMUKbr4SKfM5CB?=
 =?us-ascii?Q?0zfORH4TBght05nox9qGBdTIhVTMCyTsNe6RkGysbHrb+YmxFcEG6oGathSP?=
 =?us-ascii?Q?LY8T+N2jq92Z3YMmU3DXVe9LmbOFpVUeifMLMxQYsrQXB+mfzd2bf2Tu9F+w?=
 =?us-ascii?Q?MOoTv9gk3vD5mhyAQ8//v56821nNfwvRLsIxsUlEulXVnvFZKwt9vOnIaE9Y?=
 =?us-ascii?Q?k5YIJibyXpuTua4qIHR7KbKU5BhAvwjfgVGcJ0qoBCv1o074ovE3iPJxUkGc?=
 =?us-ascii?Q?8Ix0APD3xXPx44Kl2o15xQG4Id5NmMh4V2J7B2IiNOkKkvoU/Qs4cm6A2ZTI?=
 =?us-ascii?Q?951ZWM2OCZhEj5VPHxHxxqCfBPVrEf4oYHK85CUJWJ1dRiPAdiHi5zJ9QNAw?=
 =?us-ascii?Q?ck4iGfjcA1+FWm1kroIl1FHALjcataVgNczq7d9W7pzptVFOhrsNu21ihrs+?=
 =?us-ascii?Q?Ts+LXRGu9lPF1bkHKt833yStg3NbNhWID5MU2B8XNrAEG1GnjKnNiaqYRp9c?=
 =?us-ascii?Q?oHEA53vExcpGxaVL5u3k5VjXE8texfTIC7NOFS7DG6p98LM7APnO4vhJwxn7?=
 =?us-ascii?Q?fEyw2wDQVCcHQx3rajH7jd4a5fcZJ0VPrK3HxZEScucMuIsj7vQAj6vVomLA?=
 =?us-ascii?Q?+6u11WicEUZJEy2brdi48UTdhsnri+rJ/1q23rxi1iyaC8SKeR5sbG/eXjqB?=
 =?us-ascii?Q?R6GxHFNMqzSUXQUDUOCl8JWsQSfc1DM7JHJT6Vvam7MjodRi1tZuLWDobkAC?=
 =?us-ascii?Q?Y8MhE4mATQlLBIjWZT6iwYXIgEj5mfFsuiTeZ1BU8dbFSblYH+7AYxIB2S/N?=
 =?us-ascii?Q?3BahwC50KpnSaqq130Fd4OgjZOHUJHp7fC1SpZoL9+oC+ehZVZF8o3HcuHpo?=
 =?us-ascii?Q?/UPSqB4b95bMVLrte5a2F2NtaUc8JABSug/T1TL5ILXNXiBSciQR8vh8A6UX?=
 =?us-ascii?Q?fXMi3vEEg8MFH1HdK+Ff3cU989ydMbrr63ik5wd+IBpkzRyU4CsBT5eYYzsl?=
 =?us-ascii?Q?2QdvIJe7N+hwMGhQlkF5W0HIUfiCpPlV4l/YzlSeU/B1ud6VMt3XOqYAPWdI?=
 =?us-ascii?Q?Kx6xm9pP+WNZHBmMZdRNbU2dkIIk?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:19:27.0638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 651a361d-d932-4068-d96c-08dc7b0971bb
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8128

Revise duty cycle SMB11 and SMB16 to high: 40%, low: 60%,
to meet 400kHz-i2c clock low time spec (> 1.3 us) from EE request

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 62dfe935cbcd..21ca22281ef8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -761,6 +761,7 @@ eeprom@54 {
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@74 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -1314,6 +1315,7 @@ &i2c15 {
 	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 
 	mctp@10 {
 		compatible = "mctp-i2c-controller";
-- 
2.25.1


