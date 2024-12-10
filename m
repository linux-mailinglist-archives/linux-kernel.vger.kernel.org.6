Return-Path: <linux-kernel+bounces-439580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE419EB151
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2529C2815AF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C11AAE19;
	Tue, 10 Dec 2024 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WDK6euFA"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7761AAA1A;
	Tue, 10 Dec 2024 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835268; cv=fail; b=XY1ybveQ+yhLcMQ6kL2c1EyCXpfQzwhimDlQGmC3O/mJmIOYLrJ/Rq2KtDUiAShDju3hmJPsq/d3Ou8fRVr0WiGNHxXOBGg1cJss+YMr51dUhcwrKBkQgwThaHf/J1PNVPzYJ1Y6yfJ6HrPLcdA0PpNkbG5QjO/K1swZMHXqFJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835268; c=relaxed/simple;
	bh=KLjYj/nsxgbZ6tMkAJM3nRtXaTcyicrkOh3OnNDVvrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ERMyBjwNT5vUlNqQ4j6RGbMJnL0kDMOfH2BsoNmUsfSyFi+FoUfYSZ36ucOvdIFzIPHAq1t+sKnaHmVpUlP+P1tJKv9vW3VY+3VYq5rdLkLN21e7EraVA83R/FVxSktZle48+NreP9lcBruq70xRmjmZq2KFK/u5NGEM8N53D0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WDK6euFA; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+QJs1tS2j62WpB1RThGRnXYinoXqjN5Y1kgUFe4hm5jo6/CBADRiFW8CJi+LB2QjLHASM+xdhstmtoSGnw5kUkxT31GIADDu93w27z4ITtgx7BXjOL+c7B/EThHft9xC7XtRvArLXxwA558VJ8kPG+wL+WJs4xiYlNycWG1EEERIv+hP4TkkE1GqIOxuXSPr9N6uAciao7malTm6lBhqLYKH5+ReT1WH7+6RFxish5BZIXByqIVWLKWdH4YDfuGcj/hUjjF6M203VtmcJr47Owz9EdCRByhmdOAXZOKaBDaEwzSkAvsveUSwE7IF2lSX8Ov6JFzW2uHmH1qL0qhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWnLDaGVLYZAEVtkN49KTALKhLHFOIofCdXlNlvqBHY=;
 b=m429zBS1Jm4QCDU+NkXfhuizbAmPV8EJv6KawBd605Y4l0BJ6pVKAE9dkfRG52a/jbrqcwag2zYcSOtQmXUog0XV/ERcWc/nTq5FX8l2itZfDb7g5HT38u/z3iFa5PMusvj+GAV73J+o8WFoDP/Fb/XnhoBaRuIx8mgbSBIfPVsLnccRrwg7PhhGp1Hi6kAU/NSUr2jkYKTJky5LbgeXIlgTAQ3JvkDmh+VlDUwPsWKwdaBu+g2nwp9G0H5t8PKQo2af7G8VrAT+5wMD/6jdOf5l3gCk512Nry0LwWjWMP5Z8H9h6y7W84FYa5Y3x4saT6CIm4ws6q/XHoURPUc1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWnLDaGVLYZAEVtkN49KTALKhLHFOIofCdXlNlvqBHY=;
 b=WDK6euFAMgXnbbnk0bqGQ0shFh+dCu60f74csY5PHPzwrl1vpm4n78+JeDEX0JP5yQbEAamJy7i1/Ww0dEzZ4PdA+Y0rkEB2FJpREsE58qWuqoHxEup0m3X+u8Wh7VBzF8di+CRrHlxxSn1bxYJGqB+QGfAKwg2TS2PWnzWfGdWvJ/cMkKviWaAUbXGrNYYx4IU71KOro8Edt4yagbT2MSq3Z+d3fzmJCNLF/6rBzWIvt9s+po5gQH7CZPSEW8pu6d2oOacPjAh2EFdngCOJCp/RFQDIrOuImYMXFrND6sMgClyJqYGDZTpwTcnRtBKOuRhHPgA5Y7Ok2sFQCdtYIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by PA1PR04MB10793.eurprd04.prod.outlook.com (2603:10a6:102:485::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:54:19 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:54:19 +0000
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
Subject: [PATCH v3 6/6] arm64: dts: Add dsp rproc related mem regions
Date: Tue, 10 Dec 2024 14:53:38 +0200
Message-Id: <20241210125338.104959-7-daniel.baluta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ce29073-5bd1-4412-f8c1-08dd1919c332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3zXqSrHfnLPZrhJTtN5frIJjCHsPfLIKI7OcVrvVFeVaavIM4gH1zl/ohG+c?=
 =?us-ascii?Q?rHIbknv/l+trqBwZuJoXTfOklbQsfkDk3hXxn3q6grtqPppRPinJ9poho2Ws?=
 =?us-ascii?Q?Pt1Fs4ttsWTFRp2XSMlvQVCLWQHGjVAoKsEqX92fKEsCR5StJX9zQl6MTqOq?=
 =?us-ascii?Q?UWRUVFrs8sxVvXlwAbhmHPy0ZqvRn9yUbsxMpYvIuk2hCMO10D30qWBQ3OUJ?=
 =?us-ascii?Q?L0HmP5oKQXgAORh3lloHaqHbsp9C2dzf/MfzAnJ9zBsoC1pdOY9xhLK1VC+k?=
 =?us-ascii?Q?uc+9F1+NY1G/zX88Q2/OcFt/Wh4k44VfQomsZopo55R7o84yuYyhePO9stjy?=
 =?us-ascii?Q?rI26++U50v91IxRnUGE6R08Tw3OD0z+3/pQQSXcSl/j1fB9QMYkx6/iOyzH9?=
 =?us-ascii?Q?fLt3xaFzVxkRlvix1VJBdMuUY8l9CyzIZv3dZDmiysNMl60/OS67QsIxVU2x?=
 =?us-ascii?Q?PemGdlUK6G3xAEp7zAdIslRlyFBMy/VwZYbXo9JjqNPf0p4T9TdPJYJt7KLL?=
 =?us-ascii?Q?Fd0mAatetXa0AyjKoUbv1t6AJ3Ci2AtPQ65b/i3ZPEBfOCBMQFeUiJV4+ytV?=
 =?us-ascii?Q?fFg3S6Kt9yeN0OhRw9XCbzPmyBNenXsBxeBkdSC1nkJ0mpqVWqUJmphmH7H9?=
 =?us-ascii?Q?8R5lOaSNPkZuu/Jf3NXWOcCo1vyJBnaCXj+SwdC1sh0OXzMXu7cAOAXvjVRd?=
 =?us-ascii?Q?Z3sq6oyHVuKu8OWZryQxLk+of1f2bca9gwUs7Pq0hi/gmD77OzjNaeWso6Oc?=
 =?us-ascii?Q?d4L2MDzI7OI0jDAJPJssxd1xKVNeV+gZ5t6H00kU/hteBiloP01qT6ISBGuZ?=
 =?us-ascii?Q?iMWwITufm//M0HyMx0InmtUJMw3CDdkEfxlytKh8aqy72Ju+diuwVV2z30rR?=
 =?us-ascii?Q?/j9Iuemte5KnNArfvXNwks9VR3BGsuxk21SBnIclKmlDgdbBQ8C+9dI/kF13?=
 =?us-ascii?Q?YhtMUH+1CAq/NBH5ufHb8mtaYf2+kPHlxNHG2oIuUdpLPaS0WQRa3iUi04o/?=
 =?us-ascii?Q?fMW5qQSop+HJLxh7b5s2+Mfvhhwn80cA9AKG4z6bunE1jC/8z14Q1rTao/9x?=
 =?us-ascii?Q?Z3rcxb/1jj6rMdZsTnt/8uPCoimTOLK25J9w0nnlog5jMCaoj4WCDUftv/pl?=
 =?us-ascii?Q?po4mh64Kn3d1ZhE/Zn1e/BVB2GE7V/NQVGcrnc0JfWjHRmtQ3Yri6QnqNDiZ?=
 =?us-ascii?Q?pv9tXxOW0upxPXwC77GSCKCukHHJPeO87YK8zPSoE8PLn4XzdrkUQ5ppOtdv?=
 =?us-ascii?Q?dM1zX+Km9KjglQHUTom/KVlqay2XQrWCtVJ1s2hsXlreBJPgxUDSwTK/cB+v?=
 =?us-ascii?Q?IIayCsR4GVI7qrL2PoR8GF189rLibqeWy3CjkWzA0dDSOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jK1CZA2ohxLCw7o2gOoIvimdTxytBw08U8kLA6poXxO9sEtboI03XfD3gFN4?=
 =?us-ascii?Q?i1Y8UfQ6T9zh27LpnV21zza4s9nLBg1b7kHWfnVqi0ZrZbZaZiiMEdTXnd6u?=
 =?us-ascii?Q?Qu7JmSwZxl4mGp+YDA5STlkOXD7V2AZfi0alIpxA99zae+LNwtdDihJarm/a?=
 =?us-ascii?Q?DalSu8iRemwdADMszX73EaFUJUSQq+4bwu0ZJ1wfHDAMA9ubkDJI0wX+dx16?=
 =?us-ascii?Q?M7FEoxhP9Q4AsMSW6tv1gGLYacLJRqn9gngjKge1pijlbnfjgfaO30l8BRyk?=
 =?us-ascii?Q?tHqv3HynVXexB4MduSiuig/+h/VaualfoWUmdR0x+pa/98hB4Fu4zJYkNNKw?=
 =?us-ascii?Q?TOBxBC7qbCQYbcKH5VqJ7ARpWjBGiEmlTatDyBN4E0DVY4PRHKIElTEyA/fk?=
 =?us-ascii?Q?OaMPsyb2yb7y62e/jd1Hat31YZiR/g/ojCBKOuWg8TeeCBHrSsL8ZQvGmkcB?=
 =?us-ascii?Q?5hOEqmoX4xbH11ud1zXoYH/uoJDPFQfpsz9yicTwQQO8sh4gi/safU+7OM9U?=
 =?us-ascii?Q?2untFrZX6YRmupbs3bHmleE0HSjwE/tnQo43PjHxy5KjlGGfig5K2ZJuuYzK?=
 =?us-ascii?Q?V/oKC/KaL6OWJ5pntU3ucvrIT/ByTtQwm1urBa/W8i4ptIXQyrt6//A2w90m?=
 =?us-ascii?Q?aMMA6iTJeEbpxu5BnTDkl2+9FbZW5SRjHE94vqfHRsW487lTBREglYcENQjD?=
 =?us-ascii?Q?Dor9WrDYygPLz9kdUH33G+WiErAgakOmeBrgmvDer170Ds+iHGMZyZeKCeCI?=
 =?us-ascii?Q?2cMN24p1TpkpeDDKLvTTanP9Egs0W5GIWvO0yvmYyzm6h+qegTMck3guU7ia?=
 =?us-ascii?Q?KWPlyS7sNs4SPWz5z7dpl5XydAsOQJ8vI8OpBgis6GsfawfsAqwnFj/02tUl?=
 =?us-ascii?Q?SJjvvaR+2S3xZusd8f0gLkqc6nfhSntB0m/0v4k2zZF3ij6CCWYaTlBYVtLI?=
 =?us-ascii?Q?LFQQ5j3j8RWY127GE5ZwW6pEt9vM2kfuQQrky5vk4qwUe7BCEevS61Dbk2HN?=
 =?us-ascii?Q?QCeyih8F3WKRNDIezLdGCtE3fonmOyC2tSku4uDaLAj5HSOjuJil+eingDBT?=
 =?us-ascii?Q?LGu20e5QstAPzIBiILU4xWKYPzCdnI0Zl8DAdFAmaqGxSzUOh0QByHZmAIuG?=
 =?us-ascii?Q?wmONrGa0KDgB2uoTXDxGwB0i8es8DJQja1rAma9BNyWDo5USSBJpqFwjwVpK?=
 =?us-ascii?Q?eTFJiIVpL44DgOf30fAR0I9sW5oOnh1TAPcAbRqG/osnTGWEmYqaj+V43II6?=
 =?us-ascii?Q?PBdhOmA6RnXXghgASO7AK/K+CEW+YYsFQfKJmp7ZsEyaoLG9pGsx4825D30p?=
 =?us-ascii?Q?CG8m0q6kR2PrSXAoOV01lLZTSutxmYGAooKYPQj9vzcLriy2oCOAQXl8lRCU?=
 =?us-ascii?Q?CM+BmyHnkpWVQ0LheK4U/JlIubcxUbWZ/p0NWZzv7qN2zxpV1LP4ZDzxy865?=
 =?us-ascii?Q?Nikfd6kOZ8TNcEhMS3nh+8tseDi8f6bo+V3g6ANMBeyRf/QUkpQp+ancuXfo?=
 =?us-ascii?Q?3bwjaJN2FjWvBTEWpI7dR81HbzCNg0gbIowRPyf3WzNkkMOcTVwBGfXgydW0?=
 =?us-ascii?Q?C6sHotvIKk+A+GCBRbbk8d3qUSSmqySO5ow/OMRakT3X0uQonoZPQV9zmOUY?=
 =?us-ascii?Q?xWla46fi4kGZumimJrJAPIspmaOhKsu8WQRbmD3GEq0zLskfn/fmNVC1sfKM?=
 =?us-ascii?Q?QWI5ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce29073-5bd1-4412-f8c1-08dd1919c332
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:54:19.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGBmKEFlCJ1zUXClZ9hwt8VrRbLA99KW0V+9Z6eGljvcWORUMylGTJs5aJGHQTGuglahYcAgc3VUlcRgoEpOlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10793

With imx8mp-evk board we are now configuring 'dsp' node for rproc usage,
so add rproc specific memory regions.

Also, enable dsp node because it is ready to be used.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index d26930f1a9e9..c732ee79772d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -291,6 +291,16 @@ &aud2htx {
 	status = "okay";
 };
 
+&dsp_reserved {
+	status = "okay";
+};
+
+&dsp {
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
-- 
2.25.1


