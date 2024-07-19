Return-Path: <linux-kernel+bounces-257028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DAD93742C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273DE1F229A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E4E4A9B0;
	Fri, 19 Jul 2024 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="axWEaKJf"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82F3D96D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721372527; cv=fail; b=goGbDf57YoubY8XCK6U6NhrI/DWziF77qRBP/UzlV3scjgIM3717AIF598l4GXCb16BH14WFF2vTiEM8UrMQVz6MwgFJYgIr1iMS/HZ8yQsbseByuLdV+1FIManyWJPXjXKvNPZAtYL/iITozJAjvCQ3iTaz/SkG9edYv29WN30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721372527; c=relaxed/simple;
	bh=t8K4o6RCUipIFAlAHRjLmFcKpcnHHhnApgF6k16cgZY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q4oznW02kphBNdHuVbj4UqIJ2YSqvQW9w3DB4eRcpSutllIo+/FhLX7l9M1Oc48ghFUEBVAdcTuocwvqDHtWYX3ykLx9ztGcYFgGMkECPd04TRSBNJGdIaqNj2Zjp8feD/ne4LXh+xVLcVzDJa4rVMUxp2W/wTbI/p5l1l1NHKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=axWEaKJf; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjwRWbaumZx21NVeU00IYWhEL9SzjOFbquWlboDjw4Dg6MaPkfWbuPrCKfFmjRuvMVgNKIcE7pYedv/WT/X9wWqdMVk6fEXrjwXSI12ADxAjFAnrpA1OxWKRY71Y2PaFdToN+iJCGyPGWpkUUqUzdRSsTGYbMPJ7zR5p+QmKBpXeFykI5noWJo4uBVSlH0FyLMuNBMyKbMABsIPlQa6TiRYvewBe34FEXUpxjkLxxir3dzNS5yWurkySjqoJH9s/TATvHJdUj9MeW7agy0qxtLGTdXRoHHwSGRAjtwK/+hmgr/HhXEb+sHJ09IFBEu4oViNqpA/CVCrv300O8ptwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iel+B85NBWK2efOp9CzU8czy+HPSC4USzQJfs2ZgnIk=;
 b=fYgHMianE/fQCM0PSDDaIV5H8wg3tQAd1oS1dJc7bTy78Wfwyu7d4XsI2KD2iDUuj17K6QdNE8j+7VCAb6nVP71bvjccQqvgQYYPjPRSg3px02Ft0OAaIlX41SKwZaN3TO11Em0JkNzfBJKsQkQgpRfH41RYo89VDFyvUSAJblcdgu3mnwaAIbmnsOM3Fr71TeegzmuMpiOsFz7L6QwzITD8gaaqwV79fbO1g5/Qg+vyIgm+JU3VcFlSqrvDxWC+l9RJNn0iSLtYbuwSubF+69dzpPqFzTKMiXpqe1sw/GaNEF+3zwb8b6AMXICCqiGnzgNmOAfhybQRcjpx95FHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iel+B85NBWK2efOp9CzU8czy+HPSC4USzQJfs2ZgnIk=;
 b=axWEaKJf3rU4vIWdEtOzVpcnohrr3YLRIPwVN6LhMEgGExp6o7XwCTU9O+wY4g9AzpfKF/QDydOIH4i1zxuCJn9S8hRX5A7lL3j5Ctf9Bihj6KUBfd8DDqIxXfHufQhFHNruxgwXtDbtd5a2ofj4EWUVAgtPpRmlxb2XaRgIdc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB10053.eurprd04.prod.outlook.com (2603:10a6:102:387::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 07:02:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Fri, 19 Jul 2024
 07:02:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] MAINTAINERS: Add mailing list for mailbox drivers
Date: Fri, 19 Jul 2024 15:10:52 +0800
Message-Id: <20240719071052.2186084-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB10053:EE_
X-MS-Office365-Filtering-Correlation-Id: 233f0d19-56f0-45d5-1147-08dca7c0afae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7FLn+xgiFgf9pAoPe0HqWN+fFE3bkOgYg3j4MqDIVPfZf7EWZeyvFIfyMpzs?=
 =?us-ascii?Q?6A5WcMOlKuXdsgEgoKbkgHbegSKwA8Rziwk7Hm893X+CzShjw+mlIFLBsOyx?=
 =?us-ascii?Q?KmTmLbOZOjP3MOEeYWKgtyC+ZSFACAyttlH/2zfTKor1jYFgHnMyIOkN+O7F?=
 =?us-ascii?Q?uIXugnV41Ik6/nwiSRuCZH8aO6a5P56xgvSCLRSa0pgbEkBAo0ggACLGotD/?=
 =?us-ascii?Q?fRwHFbuxNjo8RsP4J7JPpAbUgMqwT/XfY0LCiIh9qRbiSeGrt6VK3h711uh3?=
 =?us-ascii?Q?aG2onU53R5alPgn5H8Wupf7u4awzZme/AH+wwMEdITaZG+JI3+xctTQiqcaF?=
 =?us-ascii?Q?DohRt8T+o2EMuG/DjBmjIcP/PMXVTCaZtdLYjUUb+7556c7s0n8R/0WezDBy?=
 =?us-ascii?Q?GYzmqmg8RYJwWx3F2wQPA2UwAsoTFhKn9LGIct/DwJS5RWHiuY3peYtMu8e+?=
 =?us-ascii?Q?/racUfRX0NzvE3lw+zVtNnYlVZMN7kx/WaBqNyVnGKU2TOaAeNx8H8JqTpcD?=
 =?us-ascii?Q?TvElhoIoqppN0PNUrSpHRPMVyUzALDD8O9VY/mcXcSPMqPui06YTkh6C+BEk?=
 =?us-ascii?Q?AbSoTzxbe6eQ/ingi/0hNURO2W5fCCZyWhME1t0AbP+nYSgB6cwazFlHapqE?=
 =?us-ascii?Q?gTQpxPOhairxBeukLloEkMmw6iEGA++A+nCJLPcD2EiUP/UQGJJe4I7kAQ5g?=
 =?us-ascii?Q?/Bk9ecpT9nAtQkqy6FQbxNVsJlOxcbhry9zS3dhwA8V68bkM+TBYomSlYP20?=
 =?us-ascii?Q?im269cc1w8Zf6X4ZpX0WeWrCVQoGsEhU8D8LX7sVsZ/N8Zuj0rklante4eGc?=
 =?us-ascii?Q?1FWFN5i9DMr3N8633liRKHqhu+ouDSJ91muydIbI4RuSS/vxWclypm3o/U8T?=
 =?us-ascii?Q?aDXL7W2FpJtXTpthO1a5DocnFV29b9Xu3FaaDHxesENdhTnvVp2ikzJvGHzW?=
 =?us-ascii?Q?rgXpfu/rVFMlGWiVF3YZw9Joz52Dmmft5D+oU+cCEOdAuUTLeeKVLn+RXXU5?=
 =?us-ascii?Q?wVOzIcUMazNkkXrW8n16xPP8Bluw1h1n9vT1Z/fzGlPHeiDH7vcSNnXjc29a?=
 =?us-ascii?Q?5uWFHkDBPKhLmTBaEnTHfWSe+bl+5lCjwkODw0Zzbum2rP5KQjbrFs1s6YkX?=
 =?us-ascii?Q?CtHhuU49pBFIQC3umGHR53R1f/x1Xh3kSbjy62HCxZp0wTYFevjowcacgzPe?=
 =?us-ascii?Q?+j2lmvUrLWHdR4+2LDSFQaHhd5kvwe7mocoPULzZpz8ocTaitbXfp+veST3o?=
 =?us-ascii?Q?L0xHkfMA4NxHtYc+oER+mtQuxdxsers60Z3GGhVk6AzHAANCYLkHwHJ/+b+z?=
 =?us-ascii?Q?cSuVCKPracSJuymI4C6AoRH8pBltjmX7PAhIC20cV7IavEeSoM4jRleyAgZR?=
 =?us-ascii?Q?BpRNeC0gQhwB6inZaZXM+oKVs5S0VyunNEIVehlnOptdNe0KbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?maACasmIFOnvFWGtQJ25SR6KOU7SIc070Xp5EuSbABdPHH2JUlIrHQDLYKFm?=
 =?us-ascii?Q?eBTth02feK71mOZhDWA9u95SCHo5JgO14j1uUSQ/axVh4m3Q1L+mAnCYL9bX?=
 =?us-ascii?Q?akZafgW652vLf21Ww3DnQzN5VnGa2pfiOGVipE55JXhfRZq58yASIvMogrwK?=
 =?us-ascii?Q?Krsu8f9Q3vqL6Sc5XZXED1tFI0FGACZn4MmV2f7NRsCpTgA2WFDbCZhcVxx/?=
 =?us-ascii?Q?qswXUno05bxCV7IkAUS6gEVR/fnA/thWsSIKkezwPjvELPTC5nHEsGAIA3CG?=
 =?us-ascii?Q?7KN3q11Xk1zNiNBgN0ALb+779VIdS7dLZp2Rp+37dQ0DO4PsSeIHXHzift6E?=
 =?us-ascii?Q?p1EI6oai3GPVOG9ORebM3OMLQ/DvxrM4cBVczoRjpT3W7N2icTlf/JmWrZdU?=
 =?us-ascii?Q?i9aL9OAQxRNheoA2/WwVr1cZxWHR1Z9wn2HDsvz/PKLWt1TmKT8QUXgTw6Or?=
 =?us-ascii?Q?A35xqf4ogQa788JNHebR8ysmA4mG9Gu0KRDBXLcVtw6v5QHT4aMdeZ9pXrDx?=
 =?us-ascii?Q?qkioh+GSdR9uDSMqExeLNkbnZDpjDlk/WPvSTancIgdEFgqX0rwitr8V1Bt+?=
 =?us-ascii?Q?OMtT1YRfZdiBDdxVyjx2R6WUK3PiKfU003bC3yPNp5nec4hvJ/3yyUwBYBwR?=
 =?us-ascii?Q?HF0pbGdxM34S3EbdRuiySZKyFE8pDWNBJu/m1JMfdMezZUOBTI35jsO0tTPV?=
 =?us-ascii?Q?ksrrXZuONcvAk72NH+gOcIS1iQBfzg4cn3lA4dnJwYKSQBefcp/2P91E0kbM?=
 =?us-ascii?Q?5xGoU4sXZYV/SSMGGlCaEhhYvtZOS61g4+qaSXwJ7fA2sM7dvveNBqhwcAtK?=
 =?us-ascii?Q?48sKLFE4CpIzdyl7WWO4Wbvm8TSt6jw0bTxeqgm+krHjYl1m8RFyKVqCGajN?=
 =?us-ascii?Q?+ceizOkbmzwvWFZ/Rb8fH4PeDlZBJIuWBgYIcObJvOsI4WFd6gWhscHxUXBA?=
 =?us-ascii?Q?h/5wzpJb9itEpnZNMHr0KkDHK3//hs7l6iPO3IsnESqSmWDXYJf1j2DWxk+C?=
 =?us-ascii?Q?jc6+v6ArjN3b3xwErKfj8/i7DmL04HSb+lwPQjFvzKVcvzJ3Te14KAmOlMtn?=
 =?us-ascii?Q?fVh77pw+8ebGhdqp/lyDW/zgdRb9q0wZ5rYxbyi99kaJTd/yQAnA/MP+oIx3?=
 =?us-ascii?Q?K/Fpgx5ibDCfUxak+isaVwpaZYtNA9bDgifPgOicyjHqWq8EXrgFMKXNpNRo?=
 =?us-ascii?Q?vjG9hJAkcWNYprD28Mv76aPy3CHPH7FoAgFS5NSQzT6oPiyYWTpA2ON6mHCh?=
 =?us-ascii?Q?eWfWxnKwYDs6ESJpjdwyfs/HK9OZY3aAxoXvQs34ltq4g6FRZkr+R+q56XUk?=
 =?us-ascii?Q?lWufPrUnvqG0zWYMs+26V8T10pV09YOrSMJHNYLrz33caKy1EY9NVMj5t4SQ?=
 =?us-ascii?Q?AOWeWZ58IZMXuh2As0RO3zqWm3Tvjkaitc9e55FyEqBJvoO9Lf8Y1BCMCOFb?=
 =?us-ascii?Q?vEQMTd8JShuworpDDiKOVGCZnSrPlSsYx1DrqYnkWgD/+PDibAh6tVyHpxsY?=
 =?us-ascii?Q?bnvbxkhy2NaxcJ3WOrdIrdoYcTTQjjXY5y/GJLcXg3aab5/I4SvaSLQmny7R?=
 =?us-ascii?Q?p+DsNgD1AM1QrgfaVP6/ZBXZvI0Vg0OAPVaq1Cx6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233f0d19-56f0-45d5-1147-08dca7c0afae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 07:02:02.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gYu/S/vFDu6UpuSJ9KDWtk6GUOsdu7e8jEVvyywQOHE5ta4z/BiYo+zbW3xP73FLeBhFcTdkvRar6HRooR43w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10053

From: Peng Fan <peng.fan@nxp.com>

A new mailing list specific to mailbox created. Add it to the
MAINTAINERS file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c87b471941c..fdcd634a35f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13407,6 +13407,7 @@ F:	net/mac80211/
 MAILBOX API
 M:	Jassi Brar <jassisinghbrar@gmail.com>
 L:	linux-kernel@vger.kernel.org
+L:	mailbox@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/mailbox/
 F:	drivers/mailbox/
-- 
2.37.1


