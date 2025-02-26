Return-Path: <linux-kernel+bounces-533484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7ABA45B37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AA2189547E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63324E01A;
	Wed, 26 Feb 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ob35n+B3"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DACB24DFFF;
	Wed, 26 Feb 2025 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564386; cv=fail; b=FU/7tSTu+N/GMzqY/CEJFbyfLunhnL6z+AP7+k+mMjMySnb+H8JOCal9ugmg2isk8jG/mT/Hz+IKpZkX9P/qTxS1ZBAdl22cCdWRypycKDW9kWSCcvyUTnC3EvTwR9iaU+ty22jIfzjT3xSuq8ZdUBUVIRcsDCp/qIanBmu7pF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564386; c=relaxed/simple;
	bh=TnnFcZPmOc93wrob5ho3mHO367eLS9WtxwrFW2m7twg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rk834nF007/0XvOSycjZk5eoD5bU7kwY3Dog0d1rB1JPfBOZJQA7quGON0OGN8xItuvO90Og47+J4h84saVOJt6xNr6DjF2ZUeoDh7swx+L/oC1jhxunhIgJphmsbzC4iL/u54YEUnK1dLe1/0PhYNjYmcapE9PAbw88WzaK3zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ob35n+B3; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBQCS7YBlBhfJksBe8GwWt7q5JDshelaZkCSMw/J6oPQZdf55PZzt/HqN4FvrgoypIFd97oI5mHCpZ0x3Ie9ZpRy6Quh8mNYyUYMS7by8eguKuOx4QMHsCjypPQEyYXJZkvXz7xosDZ54dinroXzs+VSaQat8RhZZo5iEJIJpjc/5JZLlrk00wYFTGCM5FmsiuNflOzgAE+rX9yXGgVeOFOddlpWb5fHfMuMnD6he5X5gQuEGSAXMTNMhUT8wbYzDg2ULxFeqMOIfvF2+RWDv4NQvtn2kaw8rwNMCwAVmCA0Ibyng9vZbiwlz44McDNx3rhGtSVhTLCEvsJ/DgvZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/E9GlGZGTf8xCsxc0SJkT7k8fOFpOHLXKPMd4Ctwps=;
 b=ArIsIfevuLS/lU4YPQkVmJduFLSOF6HlMWKE5eewXXPDp2YkXGZNMkaoGnhjANz2XU2T6TJuqltmD3zmCHNchKgaeyM+NFI1t3IvbdIBan60xfaLHUYiIEQg9Zjqryua7qZQhaBosbS0vP8qhcWGWUadBDRo+Hpo01XvPcQIHHueFfuHbPYIHIlvLCHKbEcyDwmAQHcfrCf5Yi+8C/fJ4Bkuw0Ruzva0MMD3KvIL6RPkJ+VPTWWpMJl5cTXOHM4ktnydX2MgKbpDJU2h7A56OKUvS8w0A/q/h+Yrm6pWYNCRVPwCES+IeRfjfYQpqGVLQf9dNY17gHyFFVX/WrZj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/E9GlGZGTf8xCsxc0SJkT7k8fOFpOHLXKPMd4Ctwps=;
 b=Ob35n+B3VbzkFEoXAv+9WpIZ7lO3lu09rywF7btRiFS1LfqvIPdfM36B715oPY4w2TmCU6ugb6oDYmSjze0nJtBnmoMp7rFYRk0qB4yLAPAkvsUx0CuUdr+Gk3ADwnFkzrz6G96vE0KPln4pYyPM2n6TcmpCkX3Eosao5bmjdNaYISi073iWQZOmVzzmvEojqxzhCVGXe46wyqj7cdWo9R59UG/ei23C8MqFZgTOAcSZ2gkFFOTDUdaJBcZqE4TuBexeJeQhIiXZ1SjLoAgera4A8fYyVdg8xakWuGWgBcbU+HVMwk0umkZBTy1JwlZBy8mbEXSNEegRK7dH3qHuog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 10:06:21 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%3]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 10:06:21 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/4] ASoC: dt-bindings: fsl,audmix: Document audio graph port
Date: Wed, 26 Feb 2025 18:05:06 +0800
Message-Id: <20250226100508.2352568-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
References: <20250226100508.2352568-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0233.apcprd06.prod.outlook.com
 (2603:1096:4:ac::17) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: 266b2638-cf4e-4dbf-e01d-08dd564d3833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cLaQs/A33w/XxL66ivPL6X9iW6jxpKX1/veAAJuTsjwrnoXj0gCH/MX6yQne?=
 =?us-ascii?Q?8cAUw2a/CBHQOcNLnhdW+2DkDcs46kRl/CU99nbdOfAuJZnbPuaAUl4B4LPP?=
 =?us-ascii?Q?7es9rZBTnrLaQzXmW4FFTFxiJn/6bS5cETaQ5IHKlUmcs8ZSR79H5vLVdrpw?=
 =?us-ascii?Q?0VORP4BvGVToYZ6d6Y1slbW6rW7taIV3RtN8ixkEoLI5X4uJjrH/bPhAWNew?=
 =?us-ascii?Q?ykynvejHsUoqRMK5rUnuE0vzz7+iwaqjA+jg1CpLzh//knJdrx9eLuBFQGDB?=
 =?us-ascii?Q?a4LYdk2YOhdTskIgDB77OB0arInejEsTed0l0YczYB4mf+L7Z1Xvp2/4mIxo?=
 =?us-ascii?Q?WsorawDYnYFkP0ikgMOcnwWj/EQLiBw5eLENpokr9VSQPj86BhqeI/f8ZrSn?=
 =?us-ascii?Q?lHAcgdsDr3jUcVM1pEr26taoOWBthu8zw8wOPxfhUKoYARfAU9GGxM9yi3xY?=
 =?us-ascii?Q?0dZTybo8v8rrng6INVpB7LdV824c4IYJ69BVYmiMjkvzRAj2m0HUyou/cC4X?=
 =?us-ascii?Q?S7IiLxuky9Qk1rKc9GpzGwC/oY/FbO5ve0cCafe2eBV1I6zYEBEZR/WbZmZk?=
 =?us-ascii?Q?ICPPJdaNqsxtQRqJMQ0od0sAH/ljQNYEfZo3X/RjtrVb0ntoGlgpaBoRVi+i?=
 =?us-ascii?Q?V7h5EPFWE0PdCV6nmDdDmViNH7I5fWuiScTbH+ovpjZZZAvFA4ax+EP3nbAb?=
 =?us-ascii?Q?3DesdPKD8yd96SjxmVWfVEZuHf2ww/5LyMk6cJ7QkVPT684Iv6C9Ry/j31cv?=
 =?us-ascii?Q?A9s4yUb0138/3SzjJOXjqTB4aZI1du65Yx/mKRT+HYPJUk6+bDzMmg1YCi9K?=
 =?us-ascii?Q?EJSkkS4bow451fm95s4sDyOKldpQdl47GLhsb/YmMLdHRH1gv+SSdAaSzSks?=
 =?us-ascii?Q?BdghJGrIxaVrcWhFQj8EUYLLEg7m/fsv0fc4I4/a7n2wPsd+oHvWaTBlx2Pt?=
 =?us-ascii?Q?YIZA+TwU7Rn4JGQ23S65AvdjAhRDwR8n7yVVMbMQ5kiWeejl0PD2FwJWI0Md?=
 =?us-ascii?Q?zjihA7aRoqvihui/u/SAqo0mmOYkYplB2TgWayCrh/c2EjS4o4lDAyVY4AMt?=
 =?us-ascii?Q?ti43oCReJjlzx4HWEsrt+ifSzaQ4//BLnMfy7FA59D0a5U7CHEBowZEqFo9g?=
 =?us-ascii?Q?FvQ5c98VZ5D3mYitKwd/gC96zQbTOIFkj5boixyblqzwdqdIbhzPYmy5NZYq?=
 =?us-ascii?Q?jsk9TQNGL6tcqtka+1rzpJRnERmdGbRHc5Kvv4Xah2iE8m9CtlLpXj8nCJAP?=
 =?us-ascii?Q?ad8+FR9sYbRn6Ohf1uj/7+vr97bATIgbV6guT/kfnwSZy3CQQ2EkEgEydLLP?=
 =?us-ascii?Q?3WHgQLnTPxTkhnMXyh3B0bx+RGMUlU4v5Q69y1nnFCwbnR313pDrFCqHYk4c?=
 =?us-ascii?Q?GGL/GMhRYr0X+GXtaq+IpVZ6jqhaEoMiEVQ3/eO49XEqYj8cQjlSwoX5fqVK?=
 =?us-ascii?Q?LrJwpjiiK0x9hN/n9qE2S8UtOlYeqr0OQ+QRf0AULsVNzAN6bC9ooA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kJG9OkM6Yra5ueVBeRUKTUPY7PBNHoDOg7R9UayGA4bdwx6e8Y2znHHb0qmr?=
 =?us-ascii?Q?nG9fzAf0iCobnRzEjLBjVOGwR573XrQ8NNyKIA5BbRHaYYlD2eW1FySPI5R7?=
 =?us-ascii?Q?xqAAtKorXkTYXXmUaqn6GsgaHJ4xYuUDLjJuZZ48BOHHCezxIMDf7XFVQKLb?=
 =?us-ascii?Q?vWIJF2M02dKAZirBSLH3OQPF0CXoYQq5q3Ml09ad8w/hf82Do9tNsJjBFpM9?=
 =?us-ascii?Q?sjIKsqKSrEWft53WWHMt3vZf+EkMsa9b1nqG6dvmnlhH8wTN1EwagyEMR7YX?=
 =?us-ascii?Q?dx+MYvbYp3EQa9l4KdlwiWPgAPLraspIqlIy1MmdJUVvBTgBszy78yuVZV6J?=
 =?us-ascii?Q?fzDrbx14mAgMj0dRNxYnRL7lNeKjCGNUtBEOMGsl8y862lQo0e8FXtaGYYl5?=
 =?us-ascii?Q?U+FS1Uy7SMZOqfbIXQYVg0f4XrCP7/5lSi/STNlBx58NnvRkgEQVCHdFFpAe?=
 =?us-ascii?Q?zSYVKSabm4OJ3zk53s3uqDZLKo9l4axCnx4BgKAbqaXB0iFvd0ptDn7O+q3x?=
 =?us-ascii?Q?IBMDsUFyd8BgbcRRHhE348nkAuYjg/paZHoFQRrJZStomrv8kB6tLHs5KHAO?=
 =?us-ascii?Q?1BFAaUKu41rVrIbbRBglGDSqw1Yjx1yg32dsBivamrf4QEWxcyibYCMZ0VlM?=
 =?us-ascii?Q?BzmXV+aDyadEO3v4sjXZpnlSCenUUBKk6FlsUltqXCgmVuNix8hQkMt2ThwT?=
 =?us-ascii?Q?iDLdU0hmIdq1fcgC/IBaNcaXmz4qGfc+HBQSZ4D1YOyL4oRlFyPx+wM7PxxM?=
 =?us-ascii?Q?oREaqDY2KFFRSjGOyGpxHaK7yh322AthKHheQ0CiEfETPfP4TIO1+zobC+nd?=
 =?us-ascii?Q?68nktW+3MhdMniJIL8IZeb7Cb2Q6s5BnPXTGWJzyWrxEJFQzRZ6leU1Klelq?=
 =?us-ascii?Q?2ZhAusv0zorjrP0oEOkpcJIbS7XKYIaJljE1+tcV9neum5ZuKdcqDHGQk5ff?=
 =?us-ascii?Q?6Ozj9yGY5CT3fBr9LAB2kqgLswsaHhPMpzrTFfJtLF/0qbaFWFJLDbY5u49I?=
 =?us-ascii?Q?0Iyh0I9mHUhSHTrJpUvkpqGH4zHFV4J81lliUMAbMoLyALs5pDT8FBFWXoXB?=
 =?us-ascii?Q?IEi/Em0H/Kp/+EbOlg3cF6cdRK2vo0WSY/xHz+GdTxo+G3W6ovsPJ5x/RXZ9?=
 =?us-ascii?Q?1cZam41R9pNo/P1GMT+prs+FKKULXfRvqFUpe9PUu2uwEB7CPt8hLbczKnjz?=
 =?us-ascii?Q?9luSnN+bH3s03pjjjUH5ynPLOd9pLrldWSOoYmSNTqzbC020o1IFX+BRan4p?=
 =?us-ascii?Q?YKd9ewwAe9qRKs7KOIuuHWE8Z/InmsWiLUs705HrTLo0Ld/dlXdu2jD6Qoxg?=
 =?us-ascii?Q?MYr5qjYucoV+J9FGjKo+EQQjIC71fB8goeo/UpMvtJAaCFN7DGaMPqTprSOT?=
 =?us-ascii?Q?SlYJK6eLDvQjk33BE3MQIcn+34t8v2JOYesghlCV3M6hKXpmem8XSnvqkLEK?=
 =?us-ascii?Q?U1f9c6X/iqCv3/PsKU8eKd5l4gofviX3sZMne17RUEwkJY+iH3ug9ruCVV48?=
 =?us-ascii?Q?0jmigz7HXSmgw8vR001RsLx7QOVupPUY3e6GLluqSZ+hBKC640wPB/YrJTvW?=
 =?us-ascii?Q?w6wXwMH7W5DMcc8UL5LGl17J/6sLil6fsjOX/AaR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266b2638-cf4e-4dbf-e01d-08dd564d3833
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 10:06:21.4708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtpNMpq6rlwyuZKcGlajZQPEdXki41DnPIDl45ZhGD25POtiRxQpa8SylO4iNIx3qSXlcieKfltrpB1mnQ6NVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

This device can be used in conjunction with audio-graph-card to provide
an endpoint for binding with the other side of the audio link.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,audmix.yaml | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.yaml b/Documentation/devicetree/bindings/sound/fsl,audmix.yaml
index 9413b901cf77..d3b93407b4f0 100644
--- a/Documentation/devicetree/bindings/sound/fsl,audmix.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,audmix.yaml
@@ -61,6 +61,20 @@ properties:
       - description: serial audio input 2
         maxItems: 1
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    patternProperties:
+      '^port@[0-1]':
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: Input port from SAI TX
+
+    properties:
+      port@2:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: Output port to SAI RX
+
 required:
   - compatible
   - reg
@@ -80,4 +94,50 @@ examples:
       clock-names = "ipg";
       power-domains = <&pd_audmix>;
       dais = <&sai4>, <&sai5>;
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          playback-only;
+
+          amix_endpoint0: endpoint {
+            dai-tdm-slot-num = <8>;
+            dai-tdm-slot-width = <32>;
+            dai-tdm-slot-width-map = <32 8 32>;
+            dai-format = "dsp_a";
+            remote-endpoint = <&be00_ep>;
+          };
+        };
+
+        port@1 {
+          reg = <1>;
+          playback-only;
+
+          amix_endpoint1: endpoint {
+            dai-tdm-slot-num = <8>;
+            dai-tdm-slot-width = <32>;
+            dai-tdm-slot-width-map = <32 8 32>;
+            dai-format = "dsp_a";
+            remote-endpoint = <&be01_ep>;
+          };
+        };
+
+        port@2 {
+          reg = <2>;
+          capture-only;
+
+          amix_endpoint2: endpoint {
+            dai-tdm-slot-num = <8>;
+            dai-tdm-slot-width = <32>;
+            dai-tdm-slot-width-map = <32 8 32>;
+            dai-format = "dsp_a";
+            bitclock-master;
+            frame-master;
+            remote-endpoint = <&be02_ep>;
+          };
+        };
+      };
     };
-- 
2.34.1


