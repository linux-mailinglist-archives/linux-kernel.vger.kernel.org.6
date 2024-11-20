Return-Path: <linux-kernel+bounces-415814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A02C9D3CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EC93282471
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3FE1B5ED4;
	Wed, 20 Nov 2024 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V5oa/dML"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E301ADFE8;
	Wed, 20 Nov 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111085; cv=fail; b=DiyH9gDfYU8Tgs0eZr+v9HErysNjYVENy5zQIDBvCgjHS1h1eF/NJkLM1eoMbWRo+pey/I9RX6ltChzF2Gws5RYRbbpdIOUmtwCyh/9Zfn2x8dC3+Q/u9Oj2aAt2VN/2GP7I7ux81096V5wujm81RFuuryX8T4DejIyJRF9Si7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111085; c=relaxed/simple;
	bh=Byg3ayBJfBbHhVvrRZyzx3pIAPLDT5vY8syGen6rz5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ScrqUGOZ+nAbTseHf6BK3UKOs9pqtjBbttn2t0v9OQmZHvOerWSsrkfhkUBNXUiixk+P7VthtWMdmP4KtkfEr7KmGuoUhynwWJwnf2RyExLulDqRHCZ+3H9HBCvidRGK6/OQLj/oEiYRFruavANNCogZgaP0hXARCf3eLFEQtGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V5oa/dML; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG0zeTmTwygle6dZkxpaWXRb/LVKdgSVNBxxQfN72QzAxIkvX2K9y2K6g8JZc0u39kZiDSUXHKizd3tojM5V+Xs+jjZXweJ3LI2aR+0P9ArkM2SZXcYZN5d3YG4XWTx+2mngzWWNDyG6L2zV65V4UspjcVigmxAxG4/s0Y4Dq5Ol8274xdtadzUFJu/3sQg0cYDb77z1kOiJeeX3Qn6GlMtDd+R97/cn1Py5vW8n5mupEZacIf0GQfcNNsaEJ0h7LyJJ4RDxt+Z6OsP7jPUfEjWQHIXKaWQc0cH5yQP2McKte+kI119xzBRmHn65NjB7Pl4Ko91/rpSpuCOfTYHZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGFAMBWNqhL9qJSilVnp951AcmNrZzeMd8YgTI5nhqI=;
 b=dEhaMBrmPuDnLbRrvtCBIiXRVko3Xc7X7eZlpmpI55j+nv8m5j+pzrZl0HSeSwGQbqcArXuF4BSXOdmoS6q5Nj9YCPSzuMMNgiN4b8m03O2DioUxa9DXmQiYD5KXgQNmVOEZo1+r+zhY1D26QNhSYc3fb3W+ShVJH2ESE7KkvS8pF/cIcukmftPa2Y1b+WWmnWsmx5RJ5N1eu7YuXcobaISCsbgCKMkoOpJ7h1jZ7BWaKHPHVeORU90sgmVB410J+gHl77rYJIP+IcrEvJzhL/rePQhe8GXZTbnzsC7HQrRTmFmD7UbGkuZtrnhuCT4jyj5ToVmRmZLHF8oPfimvsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGFAMBWNqhL9qJSilVnp951AcmNrZzeMd8YgTI5nhqI=;
 b=V5oa/dML4mps7qT7+n0M0OK0qja4itSuVjPpkkfLLX+ANrCD3sFbQjEiHWaYnIvd9XpqYffloEF49hT6PAO2mfSMlZlAgR+HMORZCd5SUgAXT1EKY0iiu4qBevYPt4UFReB8TfMUMRJXgievyfnqF5fsYv8LWQDXnZAOurzPetQZEeqJt8Cv58/8RtMMOqCC/JwCxYlmiDJ00iBLsnCGtv1YIC2QjUvc93cX+HcYewAX6FtUYUZ0+ofGLmMRp6gb24ht7G+Gh4TrgiuJ+QfmShT+AUMpR60nDA6orIkI2k0a5TJvuL8Kp2dl8h8Pra1DJmPJYOOdXI3LgmOhzd2Mvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:58:00 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:57:59 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
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
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/5] arm64: dts: imx8mp: Configure dsp node for rproc usage
Date: Wed, 20 Nov 2024 15:58:55 +0200
Message-ID: <20241120135859.3133984-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120135859.3133984-1-daniel.baluta@nxp.com>
References: <20241120135859.3133984-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::7) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 5200dfe2-6ea1-4e6d-98b8-08dd096b57cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W9HP/ZUvp6W97dH8sFBSPNoF0I+Aoe5ItPUCJ2GPXe8WcAE7+TLYfv5VWPph?=
 =?us-ascii?Q?AAogPQFmII8TR4VccPwvoBH+vNwDrFTDHsjZiIxM75dfhfSLE2XOlJ3jhyFE?=
 =?us-ascii?Q?ijPBjUIiwlu8RbQqSJ+xQ8Fd+O+fYc310HA9zFR+Mw1YGPcYiuKveO3IPw+o?=
 =?us-ascii?Q?Y8uK+sgwbaAtm0rh/A6eYHaJB/cOoYz3x4/mERoqpaGio2Y/0ThG2PILEqjw?=
 =?us-ascii?Q?aPE9OZgTqXZtmleotvNMNoCe8F1LXf58Hxa7+RidqoG0nu2dtT97aGwovVMm?=
 =?us-ascii?Q?yZm/EFvUdFVGfEEq1T2TTskhyNXa4lMNlCCHL7U33qbHQ6+rpuiJ3Obs3fyW?=
 =?us-ascii?Q?/Q6QBuxaCPfe7oj05o7ckMkNoGU/0yOFb0dl8z3G2J3S2bO2Wrm5UaLROfdE?=
 =?us-ascii?Q?Emrgs2+lpz4xWWFoN7BECzRPd48rBEqyg88oA9NKxrDQhSd9BdFa6nB/mTaR?=
 =?us-ascii?Q?FZCyOKUSvGbOLDcjCg0oOAqb1kJxF4hTPYqNc+6QlHECs0FqUhkmiYYWcckt?=
 =?us-ascii?Q?BF6xZcx5OSQx7ty8LTXz4tTqC9kqSA5TgVSYxfvAqjxvG2hRHq2oz/MgFf4N?=
 =?us-ascii?Q?Jjgvi+HbXm3sVWvliaMHddbmd2LdA0WPseCPodgJZ8c0bcPBxZpFRjHsa/rK?=
 =?us-ascii?Q?BqCTI9f+nNQNTizmg9wdBCtNe/eAPIG8s6jrJPUCXgvwsXG2Xpwxuo/1zv3A?=
 =?us-ascii?Q?KQuKkD+b/AY5Usc23EOfDOk/1kWqPI4CROemEH03jQIy6fRhqhYkf7KXu5eI?=
 =?us-ascii?Q?lZrDmG2EFb35FMr2PTGEtoCViZPf+Invat7+o1L4r4ROp5JVPayquUuw8bgy?=
 =?us-ascii?Q?UOy1Qowtk0ehNrUBy4hgVHlMEFDhy7BeHH9ZvB+wI2tPR4B0x3GVoqv9YGHw?=
 =?us-ascii?Q?gGn/HYDqlqBtDbBQrO1h71SOM6MgvAS97CSts6giEfzjD4S13cFazaeJ/Xuz?=
 =?us-ascii?Q?suez26XqVa5jEjmqVXXypOJMU6wBQj7MgARt/yUuqBbiQHwqYlDnHaAanzsI?=
 =?us-ascii?Q?3jjrPmSQqqJA6A+1VpdwFkd5ePrER7b+3RjUqOl6Nbogcx9bPOroiPK3WswK?=
 =?us-ascii?Q?jtp0CJsq3z7WOvWlvU6sA9knl7y6bobeorV9LDt9JC7Jxyss51N730upyN6X?=
 =?us-ascii?Q?E1TynOTP5lc2QcaRuLcmXLOpWQp8QurMyVpF2dcyJpdcW50hJacqy6W5sAcP?=
 =?us-ascii?Q?MBWftc5P3KuUUbxDl0th31akZOnGB6QSijLbCjJGnVamh8zRz6vtZUSemAr5?=
 =?us-ascii?Q?Yqbz9XYzDHoXPw+RC9iMkVegHdg90SODw1cuNoIdmXzszGvL98t4ddHptzPs?=
 =?us-ascii?Q?Gzp2sIOafbR1DYs/HfnqFgV3TwO4tOUFSNz0CyMZLlh5cSOeUD3cL0mHzoUy?=
 =?us-ascii?Q?fwcSTJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BWy0b5qWS6DKMZnA0ywK6DPSq0YmdrpqNduWo6LaO8ccz6l/QQSv01Eb/jcr?=
 =?us-ascii?Q?ALeZDsvB70hp58ffyy9dF9+LQtM1n6gqLd9VMi3ozJFcIfyBIMqclK3zzaX1?=
 =?us-ascii?Q?aYGguwRutrkpx2CKzZ7Y2tRTnuO/B2bjwOl1eu/ZO5dYIhVV4KoSWBwo3JV3?=
 =?us-ascii?Q?OwtL69Be8iEsPJSkIIEA+KGAqodAzmS7UAPe3jsV15lY7SLH8WssnflAKUpW?=
 =?us-ascii?Q?IxGS8dyIe66NGP79Z63v5BrgvjZskMWjBWJ/Vz02Q9y6pxuGmLx4C2S5gyQx?=
 =?us-ascii?Q?bLKuBnURORTyQhr/r20tQJFCifQEeraVBZGiY1n+uf7/O+xmvpcIROgqDzCs?=
 =?us-ascii?Q?lfKOmZTw4iclN50OJQ21hvQ3aIkdLIer1cGYFCoy9bUOR/2zE3ZT7GoTxzQN?=
 =?us-ascii?Q?Ggx1bFz4jpicikazg05n3xJk/6XsgNx2gyUpijqXnra9TpGVx21FSHfBPnOZ?=
 =?us-ascii?Q?DEGy9jH2kd56eqOWNw4IkIeLUofDpPCVmYZ4gRO0GdQ7OfyhaKbHr6QhgH+V?=
 =?us-ascii?Q?ZmHDZpXB+R0CI3la7TDpMfrMTVByMC9SA4kl1EeDmAosYWhV/qk2a/mxqR22?=
 =?us-ascii?Q?OPFq/AFqaq2pomN+MWN2XCXXJ8q7P3STHAnJxG40YYl82CfQ7hrSO067jBj6?=
 =?us-ascii?Q?iL1R6Ml7xrAwIlgi8ojFRi7Bpa7JlqR/FiLBPd6KjkWzAh4woh3UvnYugosY?=
 =?us-ascii?Q?wRKC+zxR65v9P+rQpjS5gBro8fcpPOzHVBFWYGZv4OoiUmsZ0PTMG6uzOugM?=
 =?us-ascii?Q?JYlZfVG7v20buHSZZ2EDBc/YgYyAPF0dbMjd5QghkRkm8CEl14wnfr225whD?=
 =?us-ascii?Q?Et0/Pw//nDGoJZEa20E23EHRIHKv9egAFzAopf681YzVB9EENbYY6yKRcI8V?=
 =?us-ascii?Q?SFxOoZYVH7736z+TkAeAXwrYCyrPMqXRhqXgE32tJCeuwwRZyr0Wd/sNAoZp?=
 =?us-ascii?Q?GUQctG/cEkO14m/MdxDYc6+FEtsP6QvCtMgLEpSiZNEXFkyCUOU4ZjD4V0VT?=
 =?us-ascii?Q?YbGuLTVdgYIfvo7xH42FfIXW+q1lz5H/zqealjVbJADbU/qeUE5rzuQjx/Bz?=
 =?us-ascii?Q?bT/nViYFyBtMO1MsrE8ksBaVjQ8He/YnaE+OYtIhS1678fifaYu6+PxSdPpt?=
 =?us-ascii?Q?NZtjBt5OaPuoG+3GUl0bCDAjOYT7QgOyy7j9ObNdCwP62+DftiNEZhCig8O3?=
 =?us-ascii?Q?NHqjb5zqXpUnZU0G+nM7aGLfSuMg/C7HFLTcpyzlv2ZX5H1FQ9tdTU0FnlqQ?=
 =?us-ascii?Q?JuWYEWzWLr1U2yeM+JgXcGCAO0mY9W/ZhqFNY7pvzPbASzjoJi5VvnNmtWt6?=
 =?us-ascii?Q?n8bG3qKmvkGJrU9RCvT6h2Iis7VbfQXqmwy8LJxi6ppqgmu+z19mPEhVpHTn?=
 =?us-ascii?Q?vEb1SmgwKVlOFDO8z+FGVyC99wz0EbfU0O3mbOIUZmkplBlqqtpyIT81ykgH?=
 =?us-ascii?Q?ho9uMTG/z7XVasPoj7UnPZ8sqkArQeCbuZSSrs+pAQkh2kRLMCW7PSOYLEuX?=
 =?us-ascii?Q?m+oelvBPoKihxjt2vxuyC7nJMOBerrpf0JgwwMCbSJ+1+3OV4b27iHeOzr3A?=
 =?us-ascii?Q?8prh7/XRAh5ALKM2WNk5+iMJswiH2qRzSXSD7zT0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5200dfe2-6ea1-4e6d-98b8-08dd096b57cd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:57:59.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qUN2wXLubc/V6TrbZMJP0G8eX/UX0xqgRL0YN0xVcteWEY8EvZVT5diit7c8Amyt/wwLk+9G8gz1WFk3Mj9Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825

DSP can be used with various frameworks (e.g audio firmware, rproc).
Currently 'dsp' configuration is intended for audio firmware but it
doesn't work well with board level DTs (e.g imx8mp-evk) because
board level DT enables audio related IPs (e.g SAI) while audio firmware
needs this IPs disabled (because firmware will configure them).

So, configure 'dsp' node to be used with rproc. This way users will be
able to use board DT to use the DSP as long as they don't clash with
Audio IP configurations.

More comples usage of 'dsp' node (e.g by audio firmware) will need to
create a separate dts file (or an overlay).

This change follows the approach taken for other i.MX8 boards
in commit 391a319c81f6d7 ("arm64: dts: imx8-ss-audio: configure dsp node
for rproc usage")

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9173deafdd74..abc8f0d4eea0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -280,7 +280,7 @@ reserved-memory {
 		ranges;
 
 		dsp_reserved: dsp@92400000 {
-			reg = <0 0x92400000 0 0x2000000>;
+			reg = <0 0x92400000 0 0x1000000>;
 			no-map;
 			status = "disabled";
 		};
@@ -2421,12 +2421,12 @@ usb_dwc3_1: usb@38200000 {
 		};
 
 		dsp: dsp@3b6e8000 {
-			compatible = "fsl,imx8mp-dsp";
+			compatible = "fsl,imx8mp-hifi4";
 			reg = <0x3b6e8000 0x88000>;
-			mbox-names = "txdb0", "txdb1",
-				"rxdb0", "rxdb1";
-			mboxes = <&mu2 2 0>, <&mu2 2 1>,
-				<&mu2 3 0>, <&mu2 3 1>;
+			power-domains = <&pgc_audio>;
+			mbox-names = "tx", "rx", "rxdb";
+			mboxes = <&mu2 0 0>, <&mu2 1 0>, <&mu2 3 0>;
+			firmware-name = "imx/dsp/hifi4.bin";
 			memory-region = <&dsp_reserved>;
 			status = "disabled";
 		};
-- 
2.43.0


