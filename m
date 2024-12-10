Return-Path: <linux-kernel+bounces-439575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585AC9EB146
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EA12812D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE991A9B40;
	Tue, 10 Dec 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iwx3uHR7"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B921A76BC;
	Tue, 10 Dec 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835257; cv=fail; b=exI63F49Vm8nBoz4Njlfl2EYmXGPsoXGEvsDqG3AMvX3gGbM2g28vOUccxHrozkorA4rtNx/LfDV+fJHKRIMhG/v36S/uTrtp9Sg0vyAkUjWCik75oX1+nziN2VdfZ8q6wUtsOLz4893Ea4UkC9M9BW1obDRmzzj3lAOn61ti9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835257; c=relaxed/simple;
	bh=rjUR1npVH3IyYxjMxwOCp/4+bCipxONhZzMMxsTfLSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzRS3JY3i4Myw9rrlVlHVco3tcolD5BUhqR9j3rsBqZYPtv2NNadQNGlD8Pvc3DYEg0jEk6HMaQVmFsw+6hbEOnnHwb8JUDwiqFULW8jXm+jDaAw2/a0RpLIICaBo+oq9AhQDXS7ZmlZnbWsTCZiR5RBJHh5LwIXhg9CzbZ9Hkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iwx3uHR7; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAFDsNKY9vOdI47isre5EAJFcq7pdC9BWIWolDWjun74aQtO5LC7x5gq2VjXMEFXlfkG/zKtrigmjRviB2gJXsL5ISUbQs5/n4eqnDw7LKu9pavR4X8kUgJ2qLrQWWzRvKkHuFKLt0c8DIc9NTMYSRtKRTlmos3bbEnMdUaIee6hMBU+93tJFtwXGBmbkqSVKDGa7L7Rp3Gk4BOJ+EFpQIHKKWJyMEIaPiSreuEB7VR+xqp236hVA3wo8aW7FxO7E2ury+EPMq8vecZhlG77o/PdGBfYljDwcvidTo/9WcwIdbC7ycIf0z2717pP8YFUKy3o/qOQ99aNVcS6kTpppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8yXNWuLp22hA2ki88spuCxcZW8z1WCjCP5ju6SrenQ=;
 b=QiAMMm24eBvveO2P2vqHpxxRqaKlELOE78BZmV+3f1RZbyvHqlEvBsE/kv3j6L127CWg+VDLLr4WaWzmaMODpKw4hYhlK6ue2B2eucylsJ3rzwX+Ovn2UwVKt1wnf/Jw+8IVr7MAgRo3unOyV7FeXhxZps/i8tI6ZZ9oznxY6TMyLON2/Vm51dHcN0oEfIHrYtd95s53KU4coM3naFN1u/7jVhQ8ocpYdaN2nT/YHf6zNxmg3M8E8G4MznpmcMm/+tAZCUEKRv9pl1T5xBz1aXfhivzDs7peMbpx5achKshe54oL8Rj1LC1+u5PZTS9aXR+vrE4A5vxNQz62/C4bFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8yXNWuLp22hA2ki88spuCxcZW8z1WCjCP5ju6SrenQ=;
 b=Iwx3uHR7xgjVg7xtkkBPbiboXpkbDMkE45an0PORSMDC1+avrfTDXsaQ9hE2JwgwBgUT9IrF+j8LOBJLdsXXxoHL0HDfWtDj+ho522SgxtA0cDYF3eWhL/UbT5Q1Ad47wb8UoPP6rR32xmmK7vqjUx3HPHNED0dxR9JfnkyjLTnfsMI29lUBR96ujWWyDTGmpxLz9Ir+qmKCllwH6yBWHu5EJoND/NvKGyoQmfbf2O89D0eNRs+ZsXuhGdjsUY90GyFZL14TRfQu2DKvdLlj9lfpABPCIMfetvjSYIdIImJr3RjtOJdDiwTw4d6/TLGDwBmDKiTyJrIA/aPphkPGGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by PA1PR04MB10793.eurprd04.prod.outlook.com (2603:10a6:102:485::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:54:11 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:54:11 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 1/6] arm64: dts: imx8mp: Add mu2 root clock
Date: Tue, 10 Dec 2024 14:53:33 +0200
Message-Id: <20241210125338.104959-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241210125338.104959-1-daniel.baluta@nxp.com>
References: <20241210125338.104959-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0040.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::20) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|PA1PR04MB10793:EE_
X-MS-Office365-Filtering-Correlation-Id: 720e08dd-bbfb-4422-83fc-08dd1919be65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CI5941qk2aIwEw7T+Sefb8JPaAeRzhqP42FzVVcEXuLGaoiqUqZHiRXOEhOJ?=
 =?us-ascii?Q?NR5UY8zlj5qK2TK+OBHSVuo2CQe3KA+OMd8yy+1oDiw3X1L0e8H6OLc/Fd3t?=
 =?us-ascii?Q?hEKHSY2e3pERj3FnO5LlX09J7JdDNjcZxX3BN7g31wFunHcXTIozllTu5F/w?=
 =?us-ascii?Q?hgnYEs7P2/dOK7PbDpLF/aULGrxEtlJ05SEVkLDQNDXM/QmT3/AfkGPIBjdU?=
 =?us-ascii?Q?RolhiBcImennOm5l3D3OBxHofhodvznA7geAhm0OGVBThhwo2szX97upv5Zo?=
 =?us-ascii?Q?/rRvOuM4CknhT09j0SQ6D6ZrL8j1aW46LBznM+eY+X1UzgwDj9ZNW1f/F0fQ?=
 =?us-ascii?Q?aQ4F9cPXgdOhsA5PFy60fRzon5LC9XKQdd+W5FnAKCHRftv6i/xutqBGqej9?=
 =?us-ascii?Q?xHhMUyzHEpKSQB+PddcyvIMvdK4TVcL1ry9plgeREtolay7MpaReH7v65+a1?=
 =?us-ascii?Q?MCg3DBrH/qW0/5m1a3lb5VWrlyER6FWVtKeJix/puO/4K0KjG/wjpmrV7AFE?=
 =?us-ascii?Q?c8xxJiFZbkyRRvqbG4R79Za+l6i73ouca6oRxStq6Cponx6o65nWpBCXrVNl?=
 =?us-ascii?Q?sMI2+hJEld2iqaX6JmrZdBvRBlW2NhTUV8+AUJkEL69w0KqosrhJnvnL1jB3?=
 =?us-ascii?Q?Ec0Kn6iOFhB25PoAzuAzJkYgQpgZgYYTonf/x4p262wBkpwpwAwnXcNwzlgk?=
 =?us-ascii?Q?3nYg/WAGQOhUcfpSRKw9qnosLWMsBIVKf9u675aYMPjkXIXjRPiij9NGDegE?=
 =?us-ascii?Q?O6RTo9Maip7NC00XtKQ6KlRVRuONHiTlAMmYYZWiFG5oEThuoyX6GL/mE5et?=
 =?us-ascii?Q?prgWq+hpkn8jkif9ZDpJLO+QhOXuUlC+VQ/cSTWg60ycRuLtQDC9m9M3edpu?=
 =?us-ascii?Q?WVuFUt+atONsJ9d5kEPlrc8QjxYuWdScKUMkPjczcC6HJDVzrapaATxhwd7n?=
 =?us-ascii?Q?j0acaJ7aCmvDt+qau9DE9gazjvqof46XYzmAg8RJ46RCPkSRigNBll3K7lmH?=
 =?us-ascii?Q?KyC5EtaWK4KkW5g0tJaoU3VvLH2tT+wOjLZ+VaKaNTpOrrEZubRNbuzNgBTu?=
 =?us-ascii?Q?AHv0SGenkpsii1WHQ0zUvsPlYy78VVmNBnRGo1z1pkc375uyp8mBAYB2o3W8?=
 =?us-ascii?Q?BLRQPdiLQzm0nmBVMDRfs/MDWlkWXvI+OCLfZqH8cApfXhCGJlhF7jTVA9Na?=
 =?us-ascii?Q?qTQLU7In4ifkGt5jr1Rh1tqc/aiKxF69VGwKFV8RuNgfBTKwKGPprZ23CnhZ?=
 =?us-ascii?Q?sY3hfMhCeDpSZpiE+4adNrDvlBjlWst7lvYH15ShtetqTDmOvSnCiljVYlHw?=
 =?us-ascii?Q?8dXwthcN8RZt1zMswy5hpnUWHVpbxxZFTclXKyXVg3jE7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d5ESKrPjoC47Dl2NMx7mkjPi1vraqTB509oq8rMo15Pxi26/l4YZ1fzmw9fL?=
 =?us-ascii?Q?m2zs2UU5hDxCJcKay34/HwYTZRMc98f3fZabvARAhVlE824rC1EKIITWDvWN?=
 =?us-ascii?Q?PtDFr4u9O1yk6FNud+dSMWNvRh3vxG/j3Mw+QGBzTjUTqDTa0o0Q6GOZOg5M?=
 =?us-ascii?Q?jH2E1m8tQEHqobv1S9sLwL/p/i9GH/0wDWNl/XZIEMBsS00mYJNwy+HSPSt1?=
 =?us-ascii?Q?sfEqcn+P/gduW8OlUVyWDKkifx+jSNIjGCy7AaPB9EsTk3K7hfnTtwZSKoXY?=
 =?us-ascii?Q?qGnWFO8Wn7HELJuy0z+F64o8WYQ0GgA8bDE8e+M2eRzVlhidrC0Qdj1kauIk?=
 =?us-ascii?Q?jUDZBbLfSjyQbAaX3lT9WcjLmZWEQ3d3n7cIc54s3Wv8Ylnkm+KjgtF/Zg9T?=
 =?us-ascii?Q?kOFvIX20k1mPHAf//XZt6Pl/1UuNbqyvFFCEPoqTcPk3ZOOm8Urpx7CxAGzf?=
 =?us-ascii?Q?gcGu1g74IqJKkokkJwF3bkL1mUSxNjOse9WVBvjfHGtDDqvg1fTApHf4VqhQ?=
 =?us-ascii?Q?FYIizQXWEzSWixClpg6eTfirgRW9Ej4mGiWevjH2RzS+83TVfFRcgWucmOk7?=
 =?us-ascii?Q?imqGMOcsvj3BOl89ZmQmatXyDwa920TUoVSZLyP0Mz/y+MH+HiLoCHlQ/K6j?=
 =?us-ascii?Q?/aB6JIs5liZJwW+pYjnr+XvFAU6dFTYah4VRu621OY8sQrDi7lEHLv3Tcwkc?=
 =?us-ascii?Q?w4LesNtk0Lg/ccIPByO3BQh8qPZuWxwecPPFWpw7WYGc9038kbUJRvfpxi6a?=
 =?us-ascii?Q?b3Yx4Ldj7esZK/RzhI0Q4g16eVdcRXOe6c3ZsY5nve8rPi9mSQ05IKErIbmQ?=
 =?us-ascii?Q?tNvbZ5hnNVFhfk5QdpEDV2TRLno8b/xeNMLY5clner2/Gm3r7hCfBMI+O0Zm?=
 =?us-ascii?Q?L2N7yHfdfbSKHPzKEneJ66FRLKBf1QrAQMm5tjzIpt0mC/UU2wxQZ5STaJew?=
 =?us-ascii?Q?k0YFUZmEQyXSgPFxzDs+VYF1F/u3waepytYCmk4rNma4iXDKc+tF4bMTPsjs?=
 =?us-ascii?Q?i+tOXM1uOsT8cQHQg4wNI1Fl6C6k09IKKtSQOITXBqHc5UU72fFi/Jx7HH21?=
 =?us-ascii?Q?8st2nP2w0AAwmoFnloaQ5YX34IwHFz9ibn3lUcYgc4tUwmnUt287+10ejtGv?=
 =?us-ascii?Q?MYk+Xkm6uVJNWxMyYDJyIUJ2/olg7frEPK90FSWseOM8W7g2nNtnKs7xpck3?=
 =?us-ascii?Q?UzdMzQJZ9pY4I/CdBU22BOw0c4WS0lYplSkWlA87h+WjAuIVakCgTdjhbGz8?=
 =?us-ascii?Q?ewAotA0VBls+SQNywcZj+mZSHIsE6V0yJnewzCmFiIXDYYcXil0bcRFZyfTx?=
 =?us-ascii?Q?uYUNxeC2p0kYkA6tub62ytixRMStX03MI686zDqckLzFBUEXmMpNxWadvIAQ?=
 =?us-ascii?Q?XGqxJnJebFIB6PJIQFUpueWhlkDXXbNXvjwvP66Rl8QQGO6wbQ75IzdA687b?=
 =?us-ascii?Q?A0GcqJ4t5EmR4M4kmpnsWT2r1W3PDWVqC21QKZPzDsVAUIzn8bEeRMs2jDEy?=
 =?us-ascii?Q?B0Lip5rFiWutdHxB0RGCOv0xLMSDX/3eNO7qqYyKUwIm0QStNnyfUhtDJnBv?=
 =?us-ascii?Q?ek8IwOlUCODSlLocTCd4IahNqdukQONSseLwmHBPt4u0up/GcyZIPpFs/k2D?=
 =?us-ascii?Q?qh1iuxnLRDjE6d4B9F+yiVSgX0FtA4e56O5Mb9PggmAzqD/TYQKZJzvVLQNf?=
 =?us-ascii?Q?hOYM3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720e08dd-bbfb-4422-83fc-08dd1919be65
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:54:11.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUxq98N31274PsfFdnHacQwuGMvy13TPi2buspe8zya6mXcJ7qpOEpgutBv8fvbJHfRyvb7NxdH7pcTQwdeoEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10793

Enable MU2 node and add mu2 root clock.
MU2 is used to communicate with DSP core.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e0d3b8cba221..00924e0836db 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1252,7 +1252,7 @@ mu2: mailbox@30e60000 {
 				reg = <0x30e60000 0x10000>;
 				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 				#mbox-cells = <2>;
-				status = "disabled";
+				clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_MU2_ROOT>;
 			};
 
 			i2c5: i2c@30ad0000 {
-- 
2.25.1


