Return-Path: <linux-kernel+bounces-522300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF658A3C872
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F6B1783ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DBB22B597;
	Wed, 19 Feb 2025 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bpLEdi4R"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA422AE73;
	Wed, 19 Feb 2025 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992893; cv=fail; b=FU7BOkd6FDfOlLUmsn3mMpfFJEycxni5foNq2w1eDvv0HiNC3ISxLsAMP9ovSKvOCnpdGuIE6CVz8qajMe4/xsw9lb3IhcltOnDqCbbL/ShCihUCPckMJQQ8uwbIbE+Q91LQKBVbP48nebegr2ny0an57FK2Y3H8rX9NtqsA5ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992893; c=relaxed/simple;
	bh=/8X0eT115KPcFK3IEwKu58rwtjPoB9b4UoxnoKdCqC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o/MXbMtfWryRX+wWS/PwLw3QOwwxoUewBQtViojXv1IUk0h1AjPGZ4GJVhTFec7OPrxE88qvJ/cEVHaGec85Lq2Gw+gaUjhOXO2jcms2XlSioE9BnrTzpLa3CLVDj0wnuDajLHRigcj3jxJxKNu5dM35s+VC/NusBdXqFlaalbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bpLEdi4R; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYJ/srjwKS0KOc7YM8k1CV/rFvPwK7I2/EJDpWq2n55WVBX36OB3k/bdTvlj12PT4dVWZMm1E17dIY1AHcz1DHl34af1MgwwqEG1tgKOA/JdAGBJ1KfcDgyJW3AKbiJ8LNvqzJHKvgvPJO1u9WlfobhM+p5YfaJR/Q13A5BsImkt6R0jqBKE8XCnaVJo4xItnNMxezjtietiA7MA8bkwHUH/9y0Rt8DH2wesK4RzoqcvYgmDheOXQ3Ih7y+Fnd07OtADGNwPvnItPAgePby1O7DMpJl0V2eYrdvR1NqTZ6TjdQKd5Qegjbnv1iH0xDWhzLp4u9zWp+iBr3m2lzDq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAjdpEIWKvEkb6kJ5uYW4ZP7qyULLqiUp2W5fjlJrUw=;
 b=Pe2IXu870iyCnwMjwJVl689s5w9hXG0Vfdn5CMTxNyG/KAZED8kt6rBYR5kxAa8tIOPZgDe9cCmtxzKb1xg4U4uTn1a7dPtH4AWvq5SF9WOsKsZIw63IwJxJr3zIgMdWp89BOrlE38tnnnuEC1bpZAGaP+6vMyQ+H+KcEHAND7Xubf7dPclv8qIkn7ha3hgx9obQQArqlz+qGm0cWzCY5erScbPnYJf1pPdogzq3zMg5j0mkkSJWmQsxrpl7LEHEN13Dm9U0QoJXvfV6xmr6F1xmAHNW1IqKEjF4LGqfc+gJXD9NwrcZOoXhrUvK0gDuGasfWR1pBeVk3CZpuXC1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAjdpEIWKvEkb6kJ5uYW4ZP7qyULLqiUp2W5fjlJrUw=;
 b=bpLEdi4R1kkD1X3eA5p50LSICVYVfE98kaWOFp+9gzd+7cVplFc5OSV7uALrjXxHp+I6nVX4DPyWMLrZkeAVwRzm3LcaqzDIUDaa0Rgg3sr87XKletX97WEaBqlawk9LVst7E5jxSDjoQljH9x6s2kHD+tPCbwFC++6Sn5dDreRZ/GlyTniOwtLtFgMAsiib4MyvSDqHqyx4SIDTIIkz4swZxkaX9puByqWWzYfMHCmkZwNvckYjJBnhG/70IIlAxHHAkrdkqbePt/Z/XvVTEcEZIwjso/Jo7P8xT5eA9IjQtVzCqKx9ME4U8Ktn8BKYfdHkvtRI17Z0BuUZwlTG9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by VI0PR04MB10951.eurprd04.prod.outlook.com (2603:10a6:800:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 19:21:23 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 19:21:23 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	shawnguo@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org,
	shengjiu.wang@nxp.com,
	Frank.Li@nxp.com,
	peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 2/8] dt-bindings: dsp: fsl,dsp: Add resets property
Date: Wed, 19 Feb 2025 21:20:56 +0200
Message-Id: <20250219192102.423850-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219192102.423850-1-daniel.baluta@nxp.com>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|VI0PR04MB10951:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f0ded6-ba9b-475e-b5aa-08dd511a9914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A/GB3F530MusuUTVBCANeH9Fn4aftlBx+Ab83zG4fb4qxrtXZKrdBfk4/m2M?=
 =?us-ascii?Q?nA4uuh4S9O2I2MorfxD61xSZTqjYTaXWIsB2IDdpcBB1v3rs94aRl9r5e85A?=
 =?us-ascii?Q?W58QdGcGTgeyXJLScJKlPixRiQqqq7u2GvzPR7/W2m9AXiGUPRmD0V+clWMo?=
 =?us-ascii?Q?Qr1shUXPUMbl+UjApY2VENVcE4frBH2rLNUPagrVxSBi7f3wg3dEiiskP3vP?=
 =?us-ascii?Q?mEh3VQ/TOG5eH1rqvk2nce1vKnHQgKNqhxRvg0jmJVgeA+AQbCXFzF2oBxaB?=
 =?us-ascii?Q?aNSty6Nr6cNWqa4Vozz/dE0rZs2H5RJJfTDqgGJr52ZUcO8x1jWPkmvayapx?=
 =?us-ascii?Q?4E6F9ZcxsxJSfu7UXqsR1o/5n4zG+Z4hiqOi4VPfw21KTigD4eFgvsc3Vysl?=
 =?us-ascii?Q?G75LAm0IKmIzyBd0c4AJsN8y+ycicZeF3sT/pS882tTj4rq+rY2SJyJ+KihA?=
 =?us-ascii?Q?sOjWj5xCpqeqk5dKqZigpTushses/lawxzEWk+Hpjs4IRmPGRvARLKonUrbk?=
 =?us-ascii?Q?kJe7iEb/Nkk8E3ZjZk6Z9BYyjWiA5QLODWL1hwrQbqkaqzK8kx0t1SVnp4Yf?=
 =?us-ascii?Q?3K4zMzm0v31+uXEJElji3IfRsSsMqjG127tJT0g9apLvg9guyhDnczGqAQ+w?=
 =?us-ascii?Q?4DanqteKWGzGxr0WSi24Ejj0je/J7OXLagY0WQ6rudy4IMcO5AoKwSPdr8e9?=
 =?us-ascii?Q?KxVHA78UZ5ZTkrOk/APpCDW8Z1Ec5DF9lrAugfrDdzVAIgZGetiMy3/jIfA3?=
 =?us-ascii?Q?E9I8LURi5aHB3tQWJsw38xs1BNIMAAb2ngmgbM/fmzJwLxAzgwpIEPuaRC4m?=
 =?us-ascii?Q?7y3msPHcaBd+KqW97FrqJXFoeFJe+sweKZDFLWq5+iBnmt3oadOif7fswxTo?=
 =?us-ascii?Q?MfjRK+FR/TzqeuIjjxLt00ZFGrPswP/VOuZ3zjUB8zQ4QLe4JHi8jaBtNEzh?=
 =?us-ascii?Q?Nql+CTsXjr6aVzv9O/WtUYm+vukWwun7PBZzE0t/SVRhCJyQ7CkcUDPQSIIz?=
 =?us-ascii?Q?G/ONw2sSnFmqQ3avZKudPgNzQBTKXF9xDea5K+61UUzvy58o3+zMvwjNfzVV?=
 =?us-ascii?Q?Vc5wOq4lI52cowUc5qSPWSVDheCjLpSs717XQ2sZJbKPJeOzQSKecCFRYViL?=
 =?us-ascii?Q?O2/p4vkSatAZlVKsVQXjf9Xsrn/L7ly4iWl9RmxbQpYxl+hXe+g22w1db1oN?=
 =?us-ascii?Q?iKNhlmeVLfLoE9enu9M45Qe4hQ3tgYd9Z6oKdnmsxmnG5UpJa3d+ZbIdZ34t?=
 =?us-ascii?Q?q5403YjlcMPh/uBzbgpY4qSTe4PHO8j6mOYykMBKER5jn1Igtfdbzvbd+lN+?=
 =?us-ascii?Q?05x3lSCKHrZ985op+ecAL0SxQsESpWWmxhWUcA+RcJuGq2V3agmfdQZa5MHD?=
 =?us-ascii?Q?CATJZ7tCKqjGgYIjgrUwrOoRq3QE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VA5Gg5VPfmCrXrlgXq2FfTFnKfyX6/mnENETeHplKY/1CVANystX76GCedaJ?=
 =?us-ascii?Q?sYukCtrEjtPnSByrBe16ysup7Npyv57+PV3NM+pW571zC9FuoH8nrhgeuXBg?=
 =?us-ascii?Q?oiAYXYpihHHlCnVJd2X8bh+rqgEkuOcjZ09tOvmynCDZgItOuOCy+2ur5hVd?=
 =?us-ascii?Q?TM2OcbrCZiUSYDh7xSC61R+oMqizxNG2y6mOyMz2kyu1mudVLuNXROpbeS1z?=
 =?us-ascii?Q?OaBDU0Sp8UZmb+33pZ2xhFuI4MzQrU1mBsJcU/ZShOY+72F1ZFDoSoz4rxim?=
 =?us-ascii?Q?n03LYaGtsMtrk8W0ZQgEb6/fxVDFA+9jZvF1B1ALaXADFrjGxJAVytScrebL?=
 =?us-ascii?Q?RRG0W0xEmEskzNQxwXl1ZwGFS6IUMC156//RQX57Aj0b+wTVAsXzNjrhhsXh?=
 =?us-ascii?Q?KMz3sRUnXsrTtjpnzXVcW8v3hMzNppIuEtP7owZRZgOjndsu1FX0jbEvz/yO?=
 =?us-ascii?Q?1UMEsuE6UN7MZh4/FGNnZOrt3iObGC/Tsz7vQfr+HVtVw9wMmg+gw+7hiqaj?=
 =?us-ascii?Q?ed8ucMNDCNf9VTzdsqLqKAcWmmvIOxO8y22FRjpxa/SJ91L65nCBS1KiDZ0f?=
 =?us-ascii?Q?3g6NKG7jYEgITLeppNxUK12NKT38YZuDeNImGMxpvarT4TKbivnKBejZebRR?=
 =?us-ascii?Q?Wc9tFIHjDhS3+Y/Dfks8sfOiIbP/qpZrh3EfZClAxAJvTLmez9Ol18DWe+Wp?=
 =?us-ascii?Q?02uUlFCGZ8tSwXvMt1pgszBul1By7kBeFna/F1If6QAYBBkk8zYQg3j8EUxv?=
 =?us-ascii?Q?z+AaSP6ufS5AbeYRMRTFll7Z1sjLM25oMCjjKs9ymOnMbGEyJ9Tggz6c1iuU?=
 =?us-ascii?Q?Pvstt4Bqq3QcUZ2IXzxhuVLgW3koVSdNtNouaI4p2ddisTD5LV9YWhPdQ0Em?=
 =?us-ascii?Q?OMSVRjJsfPf9B4R6f8BYpkPr+E/95iTLh5wfOkMsEBYuHpo6ATC9cEMt39qN?=
 =?us-ascii?Q?kfMzOvQxbypu84LoFre6e+xaokmR5NWDUD950dtXDIthltPDwgJqEaK+i8+s?=
 =?us-ascii?Q?a0286QYy6ght9q8M4Tak2EPlPe/H/TgP7jkjxWZN/qLuzOeuocPWSJzEDo3q?=
 =?us-ascii?Q?BIGEXqo1zKpriCPkmH9q1BqyKW2ybLp1seGwZ31Yaw+JoGOwjhj3dvHwWpfH?=
 =?us-ascii?Q?pt0Pky3onyIDtrn1tNa8pwQjCkA3mD+n8AoCx1wyPiDsCYTjUUKkR8FTZXHl?=
 =?us-ascii?Q?ajB+3w2ujsKThiqby5S4kV4TcvnZ3axMsVQI89bz6mSDD0bwW/2EqC1viA8U?=
 =?us-ascii?Q?/CapElfuASSy7CLalkhaicu7A7nfghyzGpiK7fjdN8O4Fw57I6ISE41E2Bsc?=
 =?us-ascii?Q?P4JvOZMbAq6Jresuyw6NeHZBF+fsA8FaFRWgEBnmty0Q5CQu8eTbsGMuNzzb?=
 =?us-ascii?Q?WGqeRtinIbqTah1Qo5Wn65YhUZU91GiwPD/SbrLrvQpEbJm5QKf/bRBCq/Gm?=
 =?us-ascii?Q?V8BiYOKCkVf2TVlNs2uT3DqWGcocgj9GChfi3156gIC0orHd7L+GV/9yW+mT?=
 =?us-ascii?Q?3ZsveGcjznqjdKrOQ15LYdRT240oBU4RzdZSOxdtbFOA3qJifYy1S9kZQsam?=
 =?us-ascii?Q?mnPtuMyRzlXq/QS13MFN+AJ4ZFsqbupp3CwIwwgXA/S01W2i0vZ0dNLHzfv7?=
 =?us-ascii?Q?KKUM1l1zISXnTKpKW4Az9F2HDLY9NGG/YBrv9J2whE6TrxbJVE6UrHN3zCcL?=
 =?us-ascii?Q?qPpUKQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f0ded6-ba9b-475e-b5aa-08dd511a9914
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:21:23.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: necm0lUcX0CrsArQIQfpyjPW/GIwWLU+uAKjGNe+GCIJUa3VMTeJRwdCBfrRl/wDuDMmIhx6VKhRzFSgTPmX4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10951

On i.MX8MP we introduced support for using a reset controller
to control DSP operation.

This patch adds reset property which is required for i.MX8MP.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../devicetree/bindings/dsp/fsl,dsp.yaml      | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index ab93ffd3d2e5..923e7f079f1b 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -82,6 +82,13 @@ properties:
     description:
       Phandle to syscon block which provide access for processor enablement
 
+  resets:
+    description:
+      A pair consisting of phandle to audio-blk-control and an index referencing
+      the DSP Run/Stall bit in audiomix registers.
+      See include/dt-bindings/reset/imx8mp-reset-audiomix.h for each index meaning.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -164,6 +171,16 @@ allOf:
             - const: txdb1
             - const: rxdb0
             - const: rxdb1
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8mp-dsp
+              - fsl,imx8mp-hifi4
+    then:
+      required:
+        - "resets"
 
 additionalProperties: false
 
@@ -220,5 +237,5 @@ examples:
                <&mu2 3 0>;
       memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
                       <&dsp_vdev0vring1>, <&dsp_reserved>;
-      fsl,dsp-ctrl = <&audio_blk_ctrl>;
+      resets = <&audio_blk_ctrl IMX8MP_AUDIOMIX_DSP>;
     };
-- 
2.25.1


