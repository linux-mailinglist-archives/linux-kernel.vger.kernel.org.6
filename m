Return-Path: <linux-kernel+bounces-345472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B085398B6B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC03A1C2214A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55AF19C553;
	Tue,  1 Oct 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="cSdE7gCt"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2077.outbound.protection.outlook.com [40.107.215.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966619ABBD;
	Tue,  1 Oct 2024 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770870; cv=fail; b=CX+FPjdQrnGG+WwUWiTuaD4RhKyniHQ+PnraKIv3YMpRbdL5q9iVdCrAiOHlOBBqpnaNBfWvdpdUJOY5cLguv3kdu3k64pyH8gqVFsTnJUu9VFguAQUaAv6UkvsMJNj93PJjJyFukp8eyBqL8DuZ0Yf86oIPjYAKh3cNo6vwCvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770870; c=relaxed/simple;
	bh=U4mamKWKksQ9TVYpjGBWQDnZXzFSMsAIVferImzXmYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=br5JXwybILRt2LpEtXDcvNV/K7nbwMjOY2gAFikFmNgwgh4BBfqKgvInS+kK5WuSdSXq6z+TrvStGL3FXm0LXNocxwzpY2wx2jekdHUI5rMfPCVfLSZZfJs9oVgjH35WBDR2970BS4vFAUZp3xLZb3xcd6st6hakY9Asv2HWBbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=cSdE7gCt; arc=fail smtp.client-ip=40.107.215.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=df7jEEKaGBuBeYPTI/CJ27A21Rt/vcngS53WqYPk1LCv0IfrzRIzNreWqc/eGJntkVu4+sjf224yjgpNzZArrKhQc8vHshwEnF+as3JZRecN/plEdUOIaI5q7jSJaDWMbDwyBpJGUyyNigPceLjX1yK6raNLdG9ulILDyZVlcptykktCnNEh7jt7JG+XEKYD2gBc5Ns+SrULRrAmLzKZKDmHWPVKV9p7ECv7R4c8EbeEfwxsHfKi1+ugg27U5MpLcjqwHUxGkDRq1dF4pX4mMox9e5Rf5ZONKEBZ0o+8bu5ngBYHi4ojClSM3kMwndH+mqyKkHtZS4kh3/6AxhTczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inByA5Ug/f4pmCNuoM8qabe8FYNpHK0U8PFTpQCAcm0=;
 b=zWJILkX//r+VBTsBklZHs/hVfnC3FCmOgpRU29Ix2UuUPDmjgxV3ql5Vgv/xLH9txM/IQ26lNtPIwV1pcG0ZH8fo0ZjeZpvCOXHknXK2V6o7baDAg8v1WM8ojEhSJGOfvjFXvkTTAamNt52rEnLbAJ3yYqV5qlvHixbz/LzRD2yTUJuAtQunfreEE9E6KfenEo9fKrDd3+XPkQ7hjD64V9ixV4cnpn843UwVbula9tFeJv++qkDKs5mcoBCxPFFDSbR4ScOohZnS6glOuAh2i0hbEv2zKJi/47CZ9ozCxB7pD4qzRkNSTdBCVgV4ppCKSnq33x7bISKTTwCkEocnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inByA5Ug/f4pmCNuoM8qabe8FYNpHK0U8PFTpQCAcm0=;
 b=cSdE7gCtTa4c1eshta/Tqj40i741HF5/eapqwXJmBI+LU4M1Tvb9pSPLj9gHPgNIOhsidzIrSwVeIRXOPnmELbPosJOZz7xMS7CBqNgFoAgJWPV7OcRFfEkn23O0n7+WU/8Vf138XtFzSe2r93L4xVTC94Dt2MdpWBQC7LRsABtQZ8a59pKvtDqhhbyzD66snTnVLhffQ91Gw5n5taoNS1WcfkI52cR+Z681cgt7kVYAkR1whP1Y99ksPq6Ib2kHPqwa87MGxywfBJjbMvFRfBdQENpg8Zik/0ULTS96uQhm/J5omnj9444YkUlU/tNg1G+5dFsuqeY8FiJ/KIdD0Q==
Received: from PS2PR02CA0081.apcprd02.prod.outlook.com (2603:1096:300:5c::21)
 by TYSPR04MB8289.apcprd04.prod.outlook.com (2603:1096:405:c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 08:21:00 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::fa) by PS2PR02CA0081.outlook.office365.com
 (2603:1096:300:5c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 1 Oct 2024 08:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 08:21:00
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/10] ARM: dts: aspeed: yosemite4: Remove mctp property on I2C Bus 15
Date: Tue,  1 Oct 2024 16:20:44 +0800
Message-Id: <20241001082053.3455836-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|TYSPR04MB8289:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5b9da402-86d4-461f-22c2-08dce1f1fb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q94g73sNGkTjcRbZJec+AkyMZhjfRVSX3Ro5qby/cPUbW0+J7gA9bUhzYGvK?=
 =?us-ascii?Q?yf8/kf/jphCLJWJX4CLMDI1vFN6L/x3jr7NJnKCBo4y1h+twRE1S7L5C72Ch?=
 =?us-ascii?Q?WIOQSrWrD69O0S5f4NKn0fdLPrHl7TTaGzYQ71OwnFQis3uSJOfoRmkDY7eb?=
 =?us-ascii?Q?okLSNK2cIP86AZ2LoHt39k8cWfzIYSo9PTq2P56UcxoX0iPz7F9nk7R/2z8e?=
 =?us-ascii?Q?B0An2jYlQIKSpdeROTs7n5IlBj+TiSkvUxVM+9AL31bwCYH4Ep76AODLpj3B?=
 =?us-ascii?Q?kxX5GY2zfGQzl8aTC7HS0wHlDlPpPqfgCJXneGSZvvNdjVaeNDYbjBC/cUsP?=
 =?us-ascii?Q?IzFKdY3fVnijy6vJPHJbGH/nt4AgofvbwBlpEpM1HoQyoMyU/ms2U7jOwhgb?=
 =?us-ascii?Q?7V7qgxzt/L6oU2ROVVysJS+pbv2MiwTt+l+9+qX/vhjxj1qpQqgCTR/Z2KZJ?=
 =?us-ascii?Q?XPAuwTp4hIyNInNBUABr3PIzt3Oqy3p9iTKBjmMtI/pcH36S/YPkqqwJMOWi?=
 =?us-ascii?Q?JReJ0iO/jJ8TDuzAaEMAZ7eqjmWF5PcUZtKuVZ4oNbO/9+E/Kmlhk6gsnhfK?=
 =?us-ascii?Q?XxzmTsd/bMH9JPYg2vJsRv6vBOnteWz2yd60NrA5Vx5RFUdqULV1cfJY4SNc?=
 =?us-ascii?Q?Mh9jDEdC4+XhTGrrr+CVo5jZnOKiqTGoDPr8Jy7uvm2VKj/unzJG6or2MfbZ?=
 =?us-ascii?Q?Oqd0R5GYqNEPqNrPmYYGk9KXgTCxThCIXaY9ReB2lA4kO0/S0JQC336HnDBi?=
 =?us-ascii?Q?Zmx7OkYWUkcRwPvczuBbvuFgOKseJm5jgllmryI33/DOKhel9EKyFV/KZoEr?=
 =?us-ascii?Q?UjHhH6OMZVYIH1kO/A6X7iBSCMx5ybq5+YVXhW3Y2EKN3crEc/tJ1uvvOJzo?=
 =?us-ascii?Q?x13CNKWd2cPWCnLnJLujySkLrxQ5N5nNVjp8BDIM3nrgxBhDmajUhcR0Am2y?=
 =?us-ascii?Q?77hMlHGtQjMp9CUYkVcagN5a2IzxrZIULoZTejPaH8F8Zs8ww+COeW4H54TC?=
 =?us-ascii?Q?fEHSxgv3PRVrZVQ0sIz17ZJEWPL1ARjP2ZUhNp6m8n1T/UeBQ9Hy9RZRISff?=
 =?us-ascii?Q?xvDZBQRgK3hL0jgurjSe/V5V00ozvkdAMDyZhD5sHruOWW/bL7sNOxDBYW6Z?=
 =?us-ascii?Q?4LNXVRnhuxbwHYq1UP1j0JwxOXLPU/S1OjuBBCg/s7jbUgjoN+6+OcCF9aJo?=
 =?us-ascii?Q?YQkim251e+bAevPHEe6dbz0QvnDY0w3LonvwAcMlc3YXS/moIzA9obNQMZYX?=
 =?us-ascii?Q?o/4qvCwfRmzwFXCYHkQ2qbQmUFVrUUcM0CEf0DSbes5CHIlaiG6Qrggr3nbW?=
 =?us-ascii?Q?/g/632xjNZ4i23bYDK5t+sWU5sqJpkBQ+AEVMScTSbTxrm+J/jO7YPTZvfQc?=
 =?us-ascii?Q?iVgkArwDGLGgGwAeYidbRxE2wSj2W4RFjV14u3ZmtgpvFqxtOjhDMRjJR4kf?=
 =?us-ascii?Q?fEf18QomJ0vUeeWOH9eQB/G4+b8Gyrl9?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:21:00.1122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9da402-86d4-461f-22c2-08dce1f1fb8d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8289

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Remove the mctp-controller property on I2C bus 15 because we need to add
the property on the I2C mux to each NIC so that the MCTP driver will
ensure that each port is configured properly before communicating with
the NICs.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index dbc992a625b7..ad119e484bb4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1197,7 +1197,6 @@ adc@35 {
 
 &i2c15 {
 	status = "okay";
-	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
 
-- 
2.25.1


