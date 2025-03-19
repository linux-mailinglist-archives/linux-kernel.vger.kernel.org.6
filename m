Return-Path: <linux-kernel+bounces-568019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC739A68CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1704426467
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE62586EE;
	Wed, 19 Mar 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="YJgZnD7F"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA4257AD8;
	Wed, 19 Mar 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387489; cv=fail; b=O2KUwdOZtaWzCRD/wjSXuAFLWEJeHEdEK6rR9wkGQiOam7VieIyiwn+/shFkaXqrRrT7OUiasaXwYcTqC4hxpkJAZdEfWyO5ucnxwQqvq7s3zacPaCCZ6zcPqVNUsTNi3xjcVriqO1X7s2lM/bCouNDxVLH+R9DFBQgL1wL4WAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387489; c=relaxed/simple;
	bh=Zy2NUK8gTcyUNurnVJmAUzxEtcuLsQ001vQ1QzSjkRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a1nh5TXvlXEHw6o4AI+t1KzyUSHCBjKVubeT3c4RZNYyXSARfZAE2BQmgpj//j5PNtNnFnV37y+ZFKAdViUIuurzDMjhcKLaynXi8weIVMuULgg176wA/Klw/37YOW35gO/VWhbpgQUMCjeZPMOBM8QtLIGwE4e5Ze7N4mUK5wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=YJgZnD7F; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vs2ikG9ymdEghvJDrKayTfVeVTfuiFVxD74QQhg2aCV9OVxB+ub3IweZHzvFsmPmz+LTi7B+F3a5E7NYNWghkZ9FB/KMSYBE4d0Q8OIKEJfzYbIZbvxSLjFVwKr+cwnziumjxc5I2lSYHpTgDi5f0D/yV/posKfYWsrBUSXjiDkZGCU6jC4FOrRxrNGLN/OMDnLtOsQgmhAzjEVXWW3iemneP/zrzloB3ZlEjLz3UI/Lsz0HSqlAQugXR7bZ85qBDO1/WKatcYgrOOOeTTd68aUr2tHOFhCXDJW/+mv+hQc+3JllwtZiinL+spBvNyahpa017ZqPN3pcXFubwJxcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLHhbbMyRoP6Gsc8k1igNSwD3Qr3HH2VOhLqF7qJw18=;
 b=icSGL4239SNW/jw8Gqlvz31tTBrPDaj8Dw61ycKSwxC7Qv+OvrYRY5Y/kxplrMMimdgm4evQCKxGxHgOaj3sip0uBzrWC3UWqd1fGP/IvLwxSCVFx6J1fzTenvzBWCXXrSRJx7P4N2v7Qb4vZ/ekbuKcw1cS1GZ8lTkTEKBRXgnqMNMTijqubkmTYoJXmDm7hlN+wZZTlgj8PrMHonBMDAuGjw+az8ckhB/xa8YXpejnEKoHyijrpmm9fie9ovOaM71Imo9RyGSV77tP/SK/lvnQc5ajj7DifIPYkZWPAjHX4RB+bHEXvttg/93GgHimucT7oCjSu3CBA2nAypb9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLHhbbMyRoP6Gsc8k1igNSwD3Qr3HH2VOhLqF7qJw18=;
 b=YJgZnD7FLvlt19EyRA/+yBC3dc7o02pxn1VLiRe2N9UPYMj1gVGH0JyMn9Xr/H9EHWZKFAUYsF5ehUS8rrxseYs/vScfjlPq8Ze6rz7Ctg8pHGRvuQh51umHJIBlX6LIjTX4dMpgssnz7BDfkaRcafxldQDsh6s1jjfB+np01lA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB6856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:31:20 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:31:20 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 8/8] dt-bindings: mfd: ocelot: mention MDIO management and add example
Date: Wed, 19 Mar 2025 13:30:58 +0100
Message-ID: <20250319123058.452202-9-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319123058.452202-1-ravi@prevas.dk>
References: <20250319123058.452202-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0086.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::10) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f62f72c-4f41-4ca5-ad67-08dd66e1f3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PbEE+uYUj5yuXGuz2oJfE8uEpL/GHidMj81RFY90OAtt8ooXFs5wOziD5rvb?=
 =?us-ascii?Q?+3fqBF4We76IoWSNSiLcBcl1x10zdW5cz9VsRmmHtyh7yJxEa+Q+0lrcGeeh?=
 =?us-ascii?Q?fU5oTuJtiWpFD2YaQSI5PFqBbVLHWSvcj4QPeQrW8zaGJpbGFdqFOrCXrM1b?=
 =?us-ascii?Q?SsASEFQDpjyegBZ6cX6ps3MnFvD1Juh8OForVXhh216TXH1woduvR2vfXB96?=
 =?us-ascii?Q?aQED9eSZsUFWZiJbWA+hNLbQM4xKs3BT2KkHmnbQIYWP+thfMoKqB1njDMPu?=
 =?us-ascii?Q?Q8sjFGq4zdwBw8FFqnOQ70Q2hFMJa3/WS/qZCm9oeYlcwj303dtn3Db1Arlf?=
 =?us-ascii?Q?/0puBlXuNsGF5450HaOJCEonIJf6mB54sUQ/AN0BQaV16+IINQhWu5VU8oIN?=
 =?us-ascii?Q?1wX9Ew2IPNHBxmlRTYkW11p3jSKrubmyrv5wUK+xhsogCUfNjSc+tYer86oy?=
 =?us-ascii?Q?RwTNrWubNfPJ3Zm0iNyIb/dUACAf/Jv/+U/BNXTmQRkVHzoaaqGlcQboJlh7?=
 =?us-ascii?Q?xk79mtKhGaBAacfqh/q2WUh4bqU9cLZqWkw4o+ptY3sXhvb9STIlmeka+dvI?=
 =?us-ascii?Q?FrJRzTAH/U1Pu9uSjvittfDYEXpwZ5CUeoYsXvdiLUw3tn7PfN69efgtS7u0?=
 =?us-ascii?Q?6/ofSv0T3SD67xZbSdN+Bvli0beubJulGRWtrt73OATZp9mqyEWM0nTxb0C5?=
 =?us-ascii?Q?ejLzi/g7fEJDWeLt6vl0x3dkKaXyzwoDEWjsUdvAXeqIkQblkT3WqhmHF+oZ?=
 =?us-ascii?Q?BTGFYC28OHG50SGgEqeiUlVT/bO9nYNbOZp7c1mMvKpQak+sdfSN5/dHukev?=
 =?us-ascii?Q?nIjf0H6WRkVd36K4AJ9eAYVeQaTxKU2piwo56ippDB3v7ZpkvgBRXGSLzrX0?=
 =?us-ascii?Q?awHVvfcVj+H2eLUePqywn4iJ5sZI7HA4Oc2yAjZvItL+lE52yHJ5n/YnovnO?=
 =?us-ascii?Q?gQfEaHo3stU+ahYOxLrK/VEzgVQC3Ck6/gZ03UhtSCtXBXGlVPMLeFlsSKdU?=
 =?us-ascii?Q?sEbY7xxBOeZzLJvlagjXoVeNdCq4u88XoigEV3kOHuSxR82SVF9+fTPezWsk?=
 =?us-ascii?Q?gxoMzRD52a822XMvrWZ+lYHr2t3dZD5zXD2QKJOCFWgs1MRjxJu5i3342SKQ?=
 =?us-ascii?Q?DblTb0F1ZedkZRToMcTFtuJ/o/FcDNDpo781muJTywCIIuGinkk1WDLgOVcp?=
 =?us-ascii?Q?EY3QrXCfi0+0P3pZjMk/aHe3edcjulqZ0C0lE7wCXsm0OkcyLzqDgC/T753G?=
 =?us-ascii?Q?96W66c+xfrYlRIlqv98LyBlmmx4abHihPGWOtS2WJxuKQUuNUwTl3BVDQKgV?=
 =?us-ascii?Q?pS5MWf3PRpTBhCLjo6Fw1vBB+lgkVOPcJ4jVSfK5Gr6zz6mSYQqXfrDf/CHM?=
 =?us-ascii?Q?90f4r1r1/BL+GDa29Pg27r6GO3DAUtZ89BpD6vzct1SoUw66vWU3m73prSnW?=
 =?us-ascii?Q?YGQLeDi7XgAKsUQpon2C+vWoCSSphYWe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EQI3goEtMQODD59nUylxcic4kwfpLI5gB88Sk2lRIoLF1eL9EnkRcAqg8zGG?=
 =?us-ascii?Q?EdEArMqfGFHqD2NY3HR7Fr41RKPX5dRW7nyCI+CqJeVDuxBT1tj0T03oet9Q?=
 =?us-ascii?Q?qwtRFOkYqXncvQvJgSOuZqIotmb8K9DZe4ZIYP9R32IIRtjTrV8XeCO0VjDz?=
 =?us-ascii?Q?uFA9bphfiIOzyKurBkxqBQy6R8aQnwJYHlqr+baO/hIvNmD2LUlSV6qhb3hs?=
 =?us-ascii?Q?oks/LU1uefQtWyjxylMqtVlvXpqZCFfP/sM1m6vWR1kxGtWlkWFMenvbollE?=
 =?us-ascii?Q?0IT/FYCL64neL9/xdXmJIyYXgW6nvWCKRXnRYv5TqaFTfLAYxbfxxwQ7PtHe?=
 =?us-ascii?Q?CF5Rn9XTXYJkEU+V7kLYkdVEkDiG1Vzmv2ANB8eNVoHp8FMKwu5sub6N2wdc?=
 =?us-ascii?Q?0CFuaudNnNJw/sU8+FYFVeDQ6sFVxZeM14MkcHoMXbbsdcu5sPB3wvRzebaL?=
 =?us-ascii?Q?8VpOf+xAlCE6deJ+diPQvvIzKa1zUY3NPPg0JZbtMOwsWzcH7oNaVXV13s1y?=
 =?us-ascii?Q?usR/Eb0zi+tDVNWblMR+o0nm4HKhoMUm10VkD3zKv+ZZjB7V9vP3sdS/E1F4?=
 =?us-ascii?Q?RZwtUsaFx17HFpTJW++N124Yktmzy18tzJ7Hhd4BM4Nr/4+qcifPXQ7XJyTv?=
 =?us-ascii?Q?g9SqLRQwtt0/csa4bdRegDrGBJtwnENjCjbYDC9o/x6zOdaFXOAIGAlimRv4?=
 =?us-ascii?Q?Xi6BIec1aqDWrbdZ38E3bPbxaTT6TOKsze8Ize+QurdtCHxMhMCXCUBU88zV?=
 =?us-ascii?Q?ke9JAKkpMtpvr4kP/LbKBLNg2mwEME7ZLeaEyntZVYjaFPn+8wcqr1SNLGdm?=
 =?us-ascii?Q?ICCq8WSj/yKy/PfNiP5N3Bx5xaBe8mKrKDEXrm2IqoFIOqBeh4hI+s3TPGLK?=
 =?us-ascii?Q?glWqhN71qxtx/kB/M17s8SOZcyOFomHfMGHz9mc8wnC9tPjNyTPCcC2bTEx7?=
 =?us-ascii?Q?wh9cLgzIqWeut6wYvjZftZznAAdLGhHNj/y+fiqB2+PW6Q8VP68/S15wJ+c0?=
 =?us-ascii?Q?icBXnQEo3aNhlDeN/QwsQnNteLb/faL604MtMtdkuAakD2yah2NC09RKXcED?=
 =?us-ascii?Q?oUttugOTqyq7V+r/EsmU7q3D0ZQ/SFrjtf/OvorsUS2CKX5MGhtC+rLHj8dk?=
 =?us-ascii?Q?bNetjeXP9EWa17edOlkLoOvnp5V063ayU6W6iqagOb4pIFjzAT0i+g0kyEb8?=
 =?us-ascii?Q?sbqpuzndX2yUF7o3CSqFk5opnGJJkzpd4oZAGe4CPnePy/mpUDQBK4V7Xdko?=
 =?us-ascii?Q?aHy1LopXNj2jl5q/VIzvKpKwE0jPAD4UdbJAMy2Hw7s37V6pAVWGWjIE1uAf?=
 =?us-ascii?Q?+iZpuTo+zjmyiE87NvN4P2aa/AoFFBBCFrBhIbLXTN09Dic1yKaF+/FD/0c/?=
 =?us-ascii?Q?Na/Z0+NCMpNJiuoOVn/tRnYyHRJl1qG9NgXlX2nuc5YCJs1/jQeujlbr0t1H?=
 =?us-ascii?Q?reT3hovsicr6oU4CqNZfQLZisNfdYoArfdkgbiDF3VHTsd+YbB2xPGyGM3/p?=
 =?us-ascii?Q?8jaJ82w/El0pItgN5xdaCs3/q9kIYkrRKXQpdGzDOF2e3/fj5XeIT7dOcoA2?=
 =?us-ascii?Q?PkaXQcKbQBDVrCj7cgYmnC//gDjEVeqUYynLBCGCgMRZgflMJMT+x1anLPNa?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f62f72c-4f41-4ca5-ad67-08dd66e1f3f1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:31:20.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQfuGJrdSRIIXXntBEsNc1pjXSsGHKoiq8+3j+y8BFoN1mVX5af+tb+y1gT9yCttjB1Hx97auRRI3JJkvDWSuYahHdXfzMmlWW+4581Mc64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6856

The ocelot switches can also be strapped so that they can be
controlled via an MDIO bus (on either address 0 or 31). Mention that
and add an example.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 .../devicetree/bindings/mfd/mscc,ocelot.yaml  | 121 +++++++++++++++++-
 1 file changed, 119 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml b/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
index 8bd1abfc44d99..bd2787a613e16 100644
--- a/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
+++ b/Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
@@ -12,8 +12,8 @@ maintainers:
 description: |
   The Ocelot ethernet switch family contains chips that have an internal CPU
   (VSC7513, VSC7514) and chips that don't (VSC7511, VSC7512). All switches have
-  the option to be controlled externally via external interfaces like SPI or
-  PCIe.
+  the option to be controlled externally via external interfaces like SPI, MDIO
+  or PCIe.
 
   The switch family is a multi-port networking switch that supports many
   interfaces. Additionally, the device can perform pin control, MDIO buses, and
@@ -164,6 +164,123 @@ examples:
             };
         };
     };
+  - |
+    #include <dt-bindings/phy/phy-ocelot-serdes.h>
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        soc@0 {
+            compatible = "mscc,vsc7512";
+            reg = <0x0>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            mdio@7107009c {
+                compatible = "mscc,ocelot-miim";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0x7107009c 0x24>;
+
+                sw_phy1: ethernet-phy@1 {
+                    reg = <0x1>;
+                };
+                sw_phy2: ethernet-phy@2 {
+                    reg = <0x2>;
+                };
+            };
+
+            mdio@710700c0 {
+                compatible = "mscc,ocelot-miim";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0x710700c0 0x24>;
+                status = "disabled";
+            };
+
+            ocelot_gpio: pinctrl@71070034 {
+                compatible = "mscc,ocelot-pinctrl";
+                gpio-controller;
+                #gpio-cells = <2>;
+                gpio-ranges = <&ocelot_gpio 0 0 22>;
+                reg = <0x71070034 0x6c>;
+            };
+
+            gpio@710700f8 {
+                compatible = "mscc,ocelot-sgpio";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0x710700f8 0x100>;
+                status = "disabled";
+            };
+
+            ocelot_serdes: serdes@710d0000 {
+                compatible = "mscc,vsc7514-serdes";
+                reg = <0x710d0000 0x10000>;
+                #phy-cells = <2>;
+            };
+
+            ethernet-switch@71010000 {
+                compatible = "mscc,vsc7512-switch";
+                reg = <0x71010000 0x10000>,
+                    <0x71030000 0x10000>,
+                    <0x71080000 0x100>,
+                    <0x710e0000 0x10000>,
+                    <0x711e0000 0x100>,
+                    <0x711f0000 0x100>,
+                    <0x71200000 0x100>,
+                    <0x71210000 0x100>,
+                    <0x71220000 0x100>,
+                    <0x71230000 0x100>,
+                    <0x71240000 0x100>,
+                    <0x71250000 0x100>,
+                    <0x71260000 0x100>,
+                    <0x71270000 0x100>,
+                    <0x71280000 0x100>,
+                    <0x71800000 0x80000>,
+                    <0x71880000 0x10000>,
+                    <0x71040000 0x10000>,
+                    <0x71050000 0x10000>,
+                    <0x71060000 0x10000>;
+                reg-names = "sys", "rew", "qs", "ptp", "port0", "port1",
+                    "port2", "port3", "port4", "port5", "port6",
+                    "port7", "port8", "port9", "port10", "qsys",
+                    "ana", "s0", "s1", "s2";
+
+                ethernet-ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@1 {
+                        reg = <1>;
+                        label = "swp1";
+                        phy-handle = <&sw_phy1>;
+                        phy-mode = "internal";
+                    };
+
+                    port@2 {
+                        reg = <2>;
+                        label = "swp2";
+                        phy-handle = <&sw_phy2>;
+                        phy-mode = "internal";
+                    };
+
+                    port@a {
+                        reg = <10>;
+                        label = "cpu";
+                        ethernet = <&enetc_port0>;
+                        phy-connection-type = "sgmii";
+                        phys = <&ocelot_serdes 10 SERDES6G(2)>;
+
+                        fixed-link {
+                            speed = <1000>;
+                            full-duplex;
+                        };
+                    };
+                };
+            };
+        };
+    };
 
 ...
 
-- 
2.49.0


