Return-Path: <linux-kernel+bounces-193961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A7B8D349B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 166A2B2106F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EAE17B4F9;
	Wed, 29 May 2024 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s1puOT30"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085BB17B4FB;
	Wed, 29 May 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978677; cv=fail; b=D1f02ir4pbqA7kdedxb+bTJSdvR2sZ/ewvew34cQX8+pFYvBmwRDMaiK4xsGVvNKAjGOER5tpYzDLR4XdELZpQ8HgQx8HO5SyAHaJIBFsggYmWhmh6GHjzwvLg7uTpWez7MsduNm5l59CBNbjBgdEcZfqLvCmE97WG+SNabwNnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978677; c=relaxed/simple;
	bh=iAJQX4OMsR1DIj8Q1sTCaokun4l27NFFv52Dnritmc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ov2bt9TJ6vJ0ak5rCUs7tZtLgrcogy/z/V7h/75iDwtHlhZ6n1IFbSmAZ2MfmKpY/LrXzJqi5MJ/ZT4XOHsUB/WfFzj78bviHtIItpNwyw21rik74H7M1vsEtnTM2wj5ug6ErqpMWXgn6FKNk390CAc9JtpMl1VF+PbRlD/BTOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s1puOT30; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3bc8G7EwLVO5m4VgIZfv9CpZc0eGEm0Zu51cnKgjOCIF4IK8BfAkqCroXE57VsSkdXc66CngvE217Q3a0dLo2eY9ewmX/gB6hPItW6RzF+wdmqXtD4JmDWxaRF5l9lyXr6GESMeHBB79E/qFKl8KxwxHcbZPTM0QnbrwhCty117xwakTDnpFwtYleVicnTMR/UOamV3sleKkDJZeB+w539774fsYmW7ZvoJW4Qv2KmlcZke+3UHT7lKJ9ehsCUkC0ky/OY4nkembdmUJsnEiXxkoTdHTeDKHJWEczvPtueS/GwYmSDK/sZrjKHbYjxq0stANCGC34kCHv8LWBcxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEsoZdmgeLcRVYiigkKVyJp3G86jZIIu/akteKh8wYQ=;
 b=aOvMQ/UNwM67c8mtDfZ/rWc+TMN+9TntTT4tT7AyPF5tjCl9WO9iuFKXKViReSwbUc1EqpJhsVurSnwEPOhUQeFluacq71f43aU5Bl7ddnIwfugjiqckxRDtykGthPgmnNOQobsNTbTEWN5eVbCDHXbfJBY1lPQT0+x6Y6sZHrqB4gqHXCUVmqjM3HN6vtPlx7SAirXvoK8pH8GUUwabhNRVsu9ikcKTxIqfu/K5YblY7dZ3lk9r0B1dxOAIuhv3AgTcc4ln+6phXyXz52UiGLHGfzVJv2j7jxTyuF1n4WScfjqmc45iYKrBLhIAI+4uM6xlmh+FApCmigKzUJBt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEsoZdmgeLcRVYiigkKVyJp3G86jZIIu/akteKh8wYQ=;
 b=s1puOT307LeBD7wmZn7ha8NlgtHHZ/ewKqOj2JlE/C6bLWFVppuHjXD5DSoGiTu5xV9fiF0M0dNPjgKPMH3WL9Kw03MRewTLxCguy40SxJmkqUQ9ZMG4cnR+h3f2JL7NL+L5+sKZK1A4lxS86VLt7u1TMw93poSpNCHF2+x6Ze0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB9PR04MB8393.eurprd04.prod.outlook.com (2603:10a6:10:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:31:12 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 10:31:12 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com,
	gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com,
	joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com,
	Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de,
	m.othacehe@gmail.com,
	bhelgaas@google.com,
	leoyang.li@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	pengfei.li_1@nxp.com
Subject: [PATCH v2 4/5] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Date: Wed, 29 May 2024 19:26:33 -0700
Message-Id: <20240530022634.2062084-5-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
References: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:122::42) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DB9PR04MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: 5744f888-75fd-4142-6577-08dc7fca761a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|52116005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?pYfpuNESpSAqTWb3esMLS1q43TM62hUg1DZEN7oGmVU1U3s/MJqh4zDgzbmN?=
 =?us-ascii?Q?fDEUd/CYCo3v+wmg5aty2KhN/aVePgXBECX0gWBrUtNYxEiOdzcv6F2UnXw+?=
 =?us-ascii?Q?XjXmYXP6/oAQ7FGO3D5fEdWKOSvEK3v1TvRkQ1HXsaOo6J2UlxhZancrRYaN?=
 =?us-ascii?Q?9I00hUKsDc0rWgdiYZvECaQtWvk3bUXl2wmKTVwREAgoeoe4gX62Pga7c/xf?=
 =?us-ascii?Q?QxmoXh0B0l4EcqhAVosVXgfQpFZ881qaymcgagUBLA4WFAYvbW2rbkIocotD?=
 =?us-ascii?Q?dpfTl3wb4RQDLpU3o38yuwwvecQGLTSYgQ+wFFxY1tAQtLeUAaY/Ml0lZO4P?=
 =?us-ascii?Q?J0gkhC4A1KhJjQYIMwLI1eZcz4GdfwtM0kkQlLHcthKbSaXWmRTEvoa8u8VP?=
 =?us-ascii?Q?MabDrH3Sf2CajRoYPpUj5eisi6gXLJN4o0QbWI0CXSp5NA7SqCw2RCH72FQz?=
 =?us-ascii?Q?FS956a22+W2Z22ECryax5zaPLiPx+OteyZsVAQ6TyDRcqn9Svjft2Mzf92sZ?=
 =?us-ascii?Q?zOix3WPFW4CiJmotAGYsnXurDhMyl7DqMvAp3MMKUKg2UMkesO58UDpLlDha?=
 =?us-ascii?Q?Fxjg6AaZJ/ZY0q4fnRF1Si5qhg+CzAVUAPYv2VSqbSBIthoSMlYfLvwBdA9X?=
 =?us-ascii?Q?UDRz9bz7wdlp43MK6KVkDkfiuCjpCVNoRA/SVTWiLkMs8mpfCFBuIj96rz91?=
 =?us-ascii?Q?8hZgTCy0/PD6e91kf47KI43K5c7lI6Gybt/wqyMGpznSmyGgTJq4R0DMW7vJ?=
 =?us-ascii?Q?iLVp0PuaxXC66HsR9eupVQ1F870B6hg7PRbvJ+G/MVjWRbVAYkFq27y/v/ZF?=
 =?us-ascii?Q?MxVzU0HHGd4y0P9eBXTv2caS0jYYCrY6Z2TAQDYsUcGQuhxNjZTbuk2z7ZPl?=
 =?us-ascii?Q?K7DQZ8XkGXmWR8sSLpz75ZJzC4tWzjV2x4qkPcsg15XxqZTHcpYVzCqJIW3u?=
 =?us-ascii?Q?UopK2bRwB8yM1qI3K3zD3edHWy0xl3B/yVAJKK9enTCK959lqIHZhOlnQl5Z?=
 =?us-ascii?Q?7CTDKq6dO9BefwQITbujYkW0ZIDKFkbdkL/1OlnoIBnDIiRtqoUVquk9AH/+?=
 =?us-ascii?Q?HNQBloNXx45UtthhKNbyCXA06F17TlphXnlGxVg6hVV1fZXRMn2o4ebkLYYQ?=
 =?us-ascii?Q?nKKv4DGmQUA8fZOLV5hA7gtSwbmZxooXZIFmPIuOs/1ZU6dCrZioe9/svNLh?=
 =?us-ascii?Q?bpYo4sUz2y9WnYU9WDA9tYVwwRvsGl6FbcgvUOEwjJIk+S+TtgxBJS05wvI9?=
 =?us-ascii?Q?w6VZ46kPwhJB8IyGPTw+5rSf8QHGL+h9MtGNIZmLnnk+aDl12ABO0y6+ao1t?=
 =?us-ascii?Q?6JODMiLTH1MnkdY50BVHKrEZr2oUz7USjMKTqn1Y/mhCjLytxL56Q/Ned7Df?=
 =?us-ascii?Q?Wo/M4HE=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?US08jnoXBQk8dhJwGiDcW8eefAlvtnv+hzGgkd9XiCE4D8mBwcJKHvVJXMs8?=
 =?us-ascii?Q?Z4LzMWYXTF4WSI1ENCZoKdTuUVmMnsuFEiR7BBokg/Lvl+XlXO+YR7Lfi9Gf?=
 =?us-ascii?Q?FwA6AXqCeHOTvxFpqazBmYPZxxXUUh8hdCEQB5K8mdcnF9uBKjKqqnqazr9H?=
 =?us-ascii?Q?nQSoNQywuZnIIphfi7hTem8CB1YNwqxroQPNLdHKignodwFxEJE9VM+A/ZBg?=
 =?us-ascii?Q?pOB6Zzj00gd1LX+Ju0i+sc3czGp+Hfyuwz7LkFJP8FjBgQw9WWnAVte8qyln?=
 =?us-ascii?Q?A0Hl9HDUHSbW+bqCKEhbBz4/H/0OatvH1SwkjRvcOWA8zMqBcV1hLtiA57xD?=
 =?us-ascii?Q?YkoTcKd1fvzuNUOVNE+07UMBUbT0eVHG1WgKTmIx8JPGIxrVOwb7hyACSTcK?=
 =?us-ascii?Q?oqiZQ/ezGuMOz8C+xv4bZmiEyo2VTN9ZrNccuBsD+SxriS0f7udk3jRs3oeW?=
 =?us-ascii?Q?ZlwxJ5um6cc8y0DDL7k9ooupcABqqdSwiAMzdrAxzTG65el9kI2YPt8voGJG?=
 =?us-ascii?Q?476TFkSxEVqrNZyhEPb3Q0koJVjBANT7G7ImsDMhGuvw+qvnle6FPkvWB82w?=
 =?us-ascii?Q?24/x9nxwlAafy9/uOwKo5/vCXXHe0tuFAkVTyVIpMm6Tf64KA/iA/8dIw+kg?=
 =?us-ascii?Q?I8tAOfKTHBY7Ap24SfUkGtRjSYaGFrWxHOmTEiyHFFojsGqee1MJVnqdAG1k?=
 =?us-ascii?Q?MMBMi9A1hgXVslI9PmWQoRQqgM2jIrxtUUhp9F7jxUBTNbJGX+rn/2m7KeAV?=
 =?us-ascii?Q?8JPBACn7HjiAjC0Yxb27X9I9eHBX4zJEuhMy/m3m1/iEXSk0z6u8KaXbe7Rw?=
 =?us-ascii?Q?yDTaKoqumsUSXEyJzt8E1md4Ojf19QNeBxQx8SA68QQLK2fJGHm4fccsM5bX?=
 =?us-ascii?Q?ez0ucZEBs84iIZlB6Tz2E7qeryOD9GWRhs9/3wAgpi46aAva4Ip7yyatOGtU?=
 =?us-ascii?Q?282/MSsQKJ+G2hNhWcfaB2D0dUYhPPPCkMk8nqb0KmK+fzPXf0Szxk9rpomW?=
 =?us-ascii?Q?t4pjp8DNTxCSyc2n5c+5meE4pPJVKyWXwfVx3a8RgEMFXS7+TnIiO7RFJe1f?=
 =?us-ascii?Q?FE0L1sYIzIraQ87OCbgFQAgI6vjMeEu/FF0LS5deIM765ZLlhhIn86Ne8U15?=
 =?us-ascii?Q?3cjd9SgN+rWMo1F1UGboVmyTE/GiAG4kw+Q7nlE7GgHF0RXTHMv3uniSapFY?=
 =?us-ascii?Q?sxMj+aPddaxOxvUHKvjx9SeSio+UiF9b75bwhC0Eya2HWJDogqyNWN81B2LH?=
 =?us-ascii?Q?vmCa0sa2hGHspqUTGPuud9D/82XRQadNo1dyBCtY9ud1NsD1bJHP4B2Hu6U4?=
 =?us-ascii?Q?cXjxuRVMeFdfNPpbPjlf9aJTeJ6wyo4kePnflN4XEd7/YZJn9qLatcWnebGN?=
 =?us-ascii?Q?sOlYVdb0AuBTsRudGcJ7XiDNoqKU+PsspeaINhcFL4L7XKl7nP+VRfr71t4J?=
 =?us-ascii?Q?qzfTIhLX22jhvZsn/GY5W9g6EOw3FVnTTcc91pOuLgZVUjGKw8pnGv/f0KSm?=
 =?us-ascii?Q?QlzWHmKrFTCwr0FgwqOrEXOwgpEYh6nlfK6fLS5hdT8VWmF9hdsOvkwCC/UW?=
 =?us-ascii?Q?JVv4ZCXWh351fZJA9jT8TH77Glxa3xK/2lQ5EPvF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5744f888-75fd-4142-6577-08dc7fca761a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:31:12.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tu5wlVf21ewd0JdFqd/u+Efc4QyJsXuDJsMYCjwVSForRprVimA71ElaWSG1GnYH0YCZC0IyD/ZOgKttu7IYHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8393

Add the board imx91-11x11-evk in the binding docuemnt.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..41b487ed27fd 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1275,6 +1275,12 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: i.MX91 based Boards
+        items:
+          - enum:
+              - fsl,imx91-11x11-evk       # i.MX91 11x11 EVK Board
+          - const: fsl,imx91
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:
-- 
2.34.1


