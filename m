Return-Path: <linux-kernel+bounces-378848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5D69AD648
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836381F25DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D514A0AA;
	Wed, 23 Oct 2024 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PeekBMMQ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23251CC144;
	Wed, 23 Oct 2024 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717415; cv=fail; b=L9WWutVSOkpAO55SIO0/cGimtE4rbqHbXX94ivsA9pkEWrDPvw6zsF1Rmo9qL3W5aiECIFmdWdwpOJBL9qvZ0Q1Bj2uNuGWoIxeIb0NoJvIBlWzoN4iBFgWQB6cDGQPifQWYLRLt/i0jyFglckmilC9UOND61yADkxmi3KfbY1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717415; c=relaxed/simple;
	bh=3VuDzeZDlz6RHMJ3RrvMd2rpl3doY6glhJ9BC8GQBF4=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CSOQ0ZvQHpMUI2wrFkEVqu29chLUqpp1wgmq/64Uhw70tP25DqKjboNh1kxXdKwEOYU2NDAP1lKAHgWkmNXFdLsiNUXLvom5MCBjnI+Jdu8SpA8wvNvTkYkzzY2b/72moka1qTMh8TYcMY7yzfyZ588BevC9T3wRWoZ3yfUR/dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PeekBMMQ; arc=fail smtp.client-ip=40.107.247.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3p7pfLV4SgiaQKGgu/IKBl2e5990VC9tFIxhrsgz/MN/Gs1kf9p4B9/MhrkSsgIwqKAKBrbVQdlVw74YhKwlPR0wMGlFYIkiNv8cbuV5c+VUOPPAVSuEVyWM6GQR2Y+75PTQo76sc78w0J/JIjq08JIr0/ghuf0sTOGPlXtPZKqr88z3Zp43d0lO3KG0JDgx2p/t22CDX2VxsPuvJNgrmMqo7K8SbeNk/X7QrlH/m0uwE0W7rs6XNnuUfNpETg1yiJ7o74FxFBgk2ZuLWtOvIEFSfNKiPq94R5JEFvhgpHwdhAypsoRZLeb7hdwL0tBJfCo0NXcXu96GwZsGludpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwJHVorwmhSHh+9557UmkAFZ8m/q8xP9IECgyyqp5Mc=;
 b=bNFuGVOuoHpv/PLkfe5J1xGwtsVZtAElRT4K3MRt5ePTiQxw7vfcfqMAF7e6UyP2oYdExFKLZg4Cjx31/430O9mPlVSWSgu4BW9JDI0UUvD7H7ZIF9MOTjb1f67vLLbc+EU0ICIAtwN69Mne2AQOtvH44zohJLiKOjfzeqmuO19p547rKbbvqi/M7i1z6TtClpOHAbjJT5njhtXcq17gvZPJcDNjpE34wePAMh48YCvx1NkyHaxKRIP0pD+UHkJDmxNsT9X1YK+RUYzXiVuTJtuufQ3AMLzavKDREigi33JD455iBelWC9H+GoE2v4wkISsAYU9H/CX3CRy4SG+h0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwJHVorwmhSHh+9557UmkAFZ8m/q8xP9IECgyyqp5Mc=;
 b=PeekBMMQQjVBcEo9WSSUqOKKuFv84rJpdQfR93LeWyt+21AwDdW4vkTSJrdZDj86a+goy5Ft+0GqcdiH1s+1F83h5dEnBR3Gmalf3U/df6r35/lQQk2XcxcOI7/6OB14fbfjlUfI4nBj0CAfli+1gEQn/OYJM+sudT83zPTOSc/06lDEeYeaN+s1exFaLGSKLI6Z9k5nlmmHv8irBsyAzxzSvQBfVIy/YwyKYdmSqoB5sUcl3uHzz1QvkrDOEzhQe+xE15S4fWdiq6wDcI6h87kSO/LmeWHoefDkTMsjimnO/Wecsr60uO0tQv5LpTVFVsEL7C9ZXvITdoV/So4bnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 21:03:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 21:03:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com (open list:TQ SYSTEMS BOARD & DRIVER SUPPORT),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] arm64: dts: imx8mn-tqma8mqnl-mba8mx-usbot: fix coexistence of output-low and output-high in GPIO
Date: Wed, 23 Oct 2024 17:03:13 -0400
Message-Id: <20241023210313.1390767-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0111.namprd05.prod.outlook.com
 (2603:10b6:a03:334::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: ec178e6f-021b-4b3b-21b3-08dcf3a625fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IlDN7icGtgw4z6vZFm91XFqU55bPudGbjIqc3qz67rS3FTWWDTvc9fU8bii0?=
 =?us-ascii?Q?zts4QNIz703xhFZeAEZNs97TCCm0MaE9hI4q01Hy4tRS9PsvU6tF4Q/Z+7/8?=
 =?us-ascii?Q?LdhZEmGwFb7b3KBHqK0hkF5qQhIDQedWa8t1mYG/lWxkfUzXhNTrTzo4mxX5?=
 =?us-ascii?Q?Axc4wlfZKiiLi/0QVoHM+NWdFHt/xZ6F1JJrCgjf8hKGDgjaeHDxu6kVuX4n?=
 =?us-ascii?Q?+ZYn6g4CQ4PAy+GmN9dYf6qwoQxoy2BL8rdYI94/hFfPJC0I+u5v18O1yiHh?=
 =?us-ascii?Q?Db/H1fHOo3bKt5cEp+ZsRt70EDZz5j+EtCyUK8GEPsHuBrGGOLlMa9Q/wACn?=
 =?us-ascii?Q?/NEYVeEJtVdo03jgg4FxkSApa8WkBdWNxe/mmF7iBQF6EXDCUuObTfvEp9cf?=
 =?us-ascii?Q?089uGBC1+3ezJHQleGSkJPKA/OYeOeeSBEE3Weap9aKRPDLKwchT8VmtdGfI?=
 =?us-ascii?Q?R0q7+O+8U+ohqOmA3qCXHZad/pGjmf2vhBzhfArjzo54SuyN/i/dgA69lSRh?=
 =?us-ascii?Q?LGib6pWaPO2znOLG4rs9pLS9Qtv8qGG8ZAfyp12uGkLxQstmLVT2Kj3s9Eb3?=
 =?us-ascii?Q?ac0ONtQ+D2i8Ha+0GNBh6iEtMffgH9HKveEKTySvUgHvcJG6IfQTehDTOf2q?=
 =?us-ascii?Q?ZYayijO2tnEkWNLRAzyrclxfunhh88tVm3kHFbo6VfZAaLDdQAkRUqMoHhx5?=
 =?us-ascii?Q?h6fjjfHUZFKS+40VSXgeudne7tx37jai8vGolqUVKHZC5+eBtEbVP02i+jaX?=
 =?us-ascii?Q?kGSQ1CFbMFfMV3mcwuLaaC68PUP3g6aU5elHhl9RN+Lw4R8geuLdhvhnAv5p?=
 =?us-ascii?Q?g6zxdDzjyCDEucD+BIV6Kt8snki7+TzeZt2A0MymITnXY+QU6c2xKr7zkZbY?=
 =?us-ascii?Q?oIwSkRwzpGaCKXT8p/QOeeP0bAtfrZ+uTdFGS8/HbBzFIWxSt8KNDi8fHJcS?=
 =?us-ascii?Q?RRly6sE95bx9DYx8Tt+cW1KOsxRqunt/hHSIi9ztBddKG1arosP8rtWrpLRj?=
 =?us-ascii?Q?w4ids0T5ucsZWOuMGSR8fS7AMD5FCMP/PbPZ2KLhpTQfs8ALeJgRTMGEOylT?=
 =?us-ascii?Q?kbCEDad+ZQqj4JGwuAWxkGLVyiHdqloUchC0IIt4pr9azDyCbTp1wgr1kCbc?=
 =?us-ascii?Q?8hmO+5OAxgLfK0ty5clcCY/RV+gw05DdEwZrQ19uj8tuIiAYImGUGZ7HEwoM?=
 =?us-ascii?Q?sPh7pxB6sLJtpNCJaxHDh3HzJAv30TpYaNtOKJmr1GuhohtMNu7lYNo4FaY1?=
 =?us-ascii?Q?583fP/T6anD72+EUSh8Je0qMZIofi6OwX/Z6Le1dXnqiP3q25GGlSjzTZrYs?=
 =?us-ascii?Q?6F103v9i521hIQrJOttvFzWw4IbjC91YtEO/csGnLgmkPF979cH/N4jYFw1F?=
 =?us-ascii?Q?8SheX9J1EmadzmZB5dABK1x9sn2r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NtbsnYWOdwWppSJ7qnNPM3qz5VrDGSu9e3TbTU9dxsvJcFzeiT29eA9V3+7w?=
 =?us-ascii?Q?HVWQ3Nj1Op8b2Rne2uRhJuVecFCD0p2kzCryuuJRTVPAalri+k04peVnyc7p?=
 =?us-ascii?Q?nQNCs1mQL8qUmDVJfhIakZIaE11KvcM8hcXCcR29LP9MH7crciaIuZHsGcjp?=
 =?us-ascii?Q?JWfwPZsTFRjo6dcTGVJcEM3/5bcWe/5x4BqLNhHcMeGCswxXh+omHl5hnrCg?=
 =?us-ascii?Q?gr9FXTKmoMtVffH0+I5UTwcJy/jL0oLHzaBykkm48+5yL2VnYc2REIfj/d9n?=
 =?us-ascii?Q?r76SdeMhIL/OYn/ffIN5ewpr1bR5UiL06zORN1B31SK6YK0Niuvq3pP9dSFS?=
 =?us-ascii?Q?Ge7wzb9rR7BllmS8sLadui6ofPCSHiAhNMDfAYapagpgBMuXTu3koug7MBWX?=
 =?us-ascii?Q?9WXKkoh12HN+wIflVjYBKeJ4Ev9sc0+BVVTn4A307ooPS3Af7PZx9OYc9/cG?=
 =?us-ascii?Q?N2KPYYZ4/+bMd5hVTE5/gUKqOoCZBsEFpzUqtkZcuMfxs0QAS7f0HXym7wm2?=
 =?us-ascii?Q?VD77e21QL0wZXBdJUtnUAxlBUCSt3ivNDiv9VTtOsc990ublx3k3gfCjUvas?=
 =?us-ascii?Q?2dLZCCmYA9WAxLp0RXu1stMFRBlD02UoA8/jHIyoIfpAXXDf3nWHClBMDLHV?=
 =?us-ascii?Q?0kkxDKGIsxWSHFUKEIVzznGO0TZQqZbF/9ztDArKY1IeRod5pHH3pXoFW201?=
 =?us-ascii?Q?zNZkomI56i/Au/Tbk/NF6T4Lti0k3Ym0W0ahQX36QQB3rd0NXHBnJEtGkCqZ?=
 =?us-ascii?Q?JMcM3hxAH4+7LZP7l6W+cZJzxJ9LMM9nDU2dyKuoTz6BXi6PMBjcEeLXlG22?=
 =?us-ascii?Q?pGDTFbCbx4Yc2bPt0ILngJqEDningrn20/eCkBBf0kCcsAMkqNNeP6u/ycc5?=
 =?us-ascii?Q?Mjyn89ju/VH92BgFxmtbp0vObYy7qTOG9u+tKuZjZWQOtcCc9UQ3L/X24oJw?=
 =?us-ascii?Q?cPefUYU79kBvIYc3sfd6z1K6qvT5Mub8hwVehcN7cqrye4izkN70cUIy5DF3?=
 =?us-ascii?Q?k1KQVo9naSUySle0Q24jyRfE8578SS8pBrV9RMRDD21Db03Hw+7H0Cuk+eo3?=
 =?us-ascii?Q?+OaWRAwuuV1S/XYjbY8ezy5NW8+Jd9XsWOMyTqxZIQdNcm0UXmYrx7XWXnyV?=
 =?us-ascii?Q?33JHnUwMnfz0+HhZJHeRQ9SowkM9MRCXA8xcSc5GykeOq4mg07muPZ69sJuC?=
 =?us-ascii?Q?CAmbV/2Gb+POhBPE4Ltc4+UH2pybLpEN0SfCC137WW6+ZcL61iIr+s2zvMEO?=
 =?us-ascii?Q?8G8kmZHKGjNruIXdhuC1FxfFD/TSNMqvfDG3ey6dcOno+tOSD0qj2rM9ONZZ?=
 =?us-ascii?Q?qcNClv4nkwZ2ufrT9/UUt3L9ujd39Q/pnqsselOzkTNpaxlDz/luDd+xXlPa?=
 =?us-ascii?Q?XdnCsWZ/hz+ej5cXiNUJP68ajpK82ogLfcV7WF/1tyssUiJTFgSEJqi2NAs4?=
 =?us-ascii?Q?iA7ofiZRByF9HXWUFGJN/BJX2oap9ICvkACDmJXMa/kxAOcHATrCU5cv+pcS?=
 =?us-ascii?Q?rTXxby83CBldVv/tmbpCtJvPUTEufHPgnsSaJc38uAskmlQXW3ckamrZHxUj?=
 =?us-ascii?Q?vBMyYtYUyic6VGFzJJ+4iwUk+nm1exiWQ/yktOuG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec178e6f-021b-4b3b-21b3-08dcf3a625fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 21:03:30.8101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1dL7a/LQQKNqviSrCTvINmryGUjY8aQPe70+gn0VSy+magZk3Sj8JeFuGdrr5KJAdQittkoxW/R7aZxRdKGPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853

Fix the issue where both 'output-low' and 'output-high' exist under GPIO
hog nodes  (rst_usb_hub_hog and sel_usb_hub_hog) when applying device
tree overlays. Since /delete-property/ is not supported in the overlays,
setting 'output-low' results in both properties being present. The
workaround is to disable these hogs and create new ones with 'output-low'
as needed.

Fix below CHECK_DTBS warning:
arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtb: sel-usb-hub-hog:
   {'output-low': True, 'gpio-hog': True, 'gpios': [[1, 0]], 'output-high': True, 'phandle': 108, '$nodename': ['sel-usb-hub-hog']}
       is valid under each of {'required': ['output-low']}, {'required': ['output-high']

Fixes: 3f6fc30abebc ("arm64: dts: imx8mn: tqma8mqnl-mba8mx: Add USB DR overlay")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Alex:
	I have not hardware to run it. I check dtb output is correct.
---
 .../imx8mn-tqma8mqnl-mba8mx-usbotg.dtso       | 29 +++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
index 96db07fc9bece..1f2a0fe70a0a2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
@@ -29,12 +29,37 @@ usb_dr_connector: endpoint {
 	};
 };
 
+/*
+ * rst_usb_hub_hog and sel_usb_hub_hog have property 'output-high',
+ * dt overlay don't support /delete-property/. Both 'output-low' and
+ * 'output-high' will be exist under hog nodes if overlay file set
+ * 'output-low'. Workaround is disable these hog and create new hog with
+ * 'output-low'.
+ */
+
 &rst_usb_hub_hog {
-	output-low;
+	status = "disabled";
+};
+
+&expander0 {
+	rst-usb-low-hub-hog {
+		gpio-hog;
+		gpios = <13 0>;
+		output-low;
+		line-name = "RST_USB_HUB#";
+	};
 };
 
 &sel_usb_hub_hog {
-	output-low;
+	status = "disabled";
+};
+
+&gpio2 {
+	sel-usb-low-hub-hog {
+		gpio-hog;
+		gpios = <1 GPIO_ACTIVE_HIGH>;
+		output-low;
+	};
 };
 
 &usbotg1 {
-- 
2.34.1


