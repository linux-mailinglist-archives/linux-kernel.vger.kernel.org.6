Return-Path: <linux-kernel+bounces-231107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC599918642
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF23B240AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE21818E756;
	Wed, 26 Jun 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="bf9UivEW"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2105.outbound.protection.outlook.com [40.107.220.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0317C7D3;
	Wed, 26 Jun 2024 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417202; cv=fail; b=M6S6vOu2cYLSSD+t/djJSbGBmqjbYSQIS7L78pHERkvz6P+2TkjVjcUIRUzBzEEbMyUlIT+v6kH8AT0Mgrw6potzZ67pdWvucUES2yBYZ4IfI7e+XGT4NuSoLX9QmEylT3xP6TiYVCFw+AYxxqjquKZvELKYTeShaKz5FfE8ILU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417202; c=relaxed/simple;
	bh=n5hNUGps6CsMOsKmpyelbl5LTQn6fFIQToq51WmE8Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cOZ05n836zEQI+h2uNyK4e7ZS+HNft187fuVR2SzdGRKLG+Q7MdzqSKZlUMX1k3r6GIrpn5cYDllvteduBJh2AHrLETrb5IGC5ghoCqbPkErD5OG36l0tvc0RfCrKQpkVDVSHd/3H9Ow9ZGMiywsT6YenF/sz0lSx0Zt724n4ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=bf9UivEW; arc=fail smtp.client-ip=40.107.220.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkjBc23nfi5ERa9u/eWAOlgsW7uV+Kl3ktEbO+QDsmbwHOYpuSllKp/yI8CIPND8/OeVMVFPSEjjTGYnltTtJYYkzPpJ+cFVSJz3PZ2lGyJJ5HuuBeVvPi+AjqgAkj0eio/XQGQ46qMvsWs82eCibkwhpzMOxycTq0mQu8va+JvK6MaC/ulEPhKeCPd9MDuFohVHofU/8x6Hx9R3b4zVi8pUtz8/lyftl+1wXoCFmkKcOlHqZlPbGVUboWtXbgTr8GGw6BBbby+vnMEfkU2TPpMa4t1GKXmuioYRKImeE6DkOQrgb1vMnnF2r2puSIXVqn4l5xJ34H4d2iH9cDp3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oprjRg5NgSdMg5904Em5anErQkQjkmWh6S2DWDp8ga0=;
 b=WajPb7j4+4/lg4VK38Cg1U11tZ8xfILzn/kmRMvHcOk8W3ZjyQULpLdEY1pOAPjDgN/DCeIjZGzFYhPXE67H+tHypHp2ihpJFslnhXoA+XJDnEAKuiHKSrupo4grwYhfWlolUY+PLJ16pHvF1ZJwsf3dqT/yQQ0gGJclyr1+gVd+UNlNCPzBkP+dbl9sdJGT4gxJEdN8SI/arle4vDW+9lITsPFZlhtxIbDnvAZ3JM5ikc/uC8H1QAJtPvhVaGIcC+xRPmKD4j0wrtkPS7wgdYvVc2ojDZ0HTNKtps06nke//JRMsGwPPxZCEwi1wDI3w7gM3tdh3KFxX2VeKb2wSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oprjRg5NgSdMg5904Em5anErQkQjkmWh6S2DWDp8ga0=;
 b=bf9UivEWyd5PLHIkGYiOUOcqcVMDGBcf+S/+NBBy27MRvbX+fHpiPxtjMYSfS4gBTkAGAZ6QGl/V1U4JYLd+l5oJT8swtY2NCgygfDaVa10H18Wxr+1PepmnOcstZ6s4xilbQEyq9Tvn+Gt/tAQOxub5LXBzMQJs3TCHxBFCkaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by IA0PR22MB4564.namprd22.prod.outlook.com (2603:10b6:208:48f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 15:53:17 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:53:16 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 3/4] dt-bindings: arm: ti: Add bindings for PHYTEC AM62Ax based hardware
Date: Wed, 26 Jun 2024 08:52:43 -0700
Message-Id: <20240626155244.3311436-3-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626155244.3311436-1-ggiordano@phytec.com>
References: <20240626155244.3311436-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:33::35) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|IA0PR22MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 855d875c-8408-4825-a4a8-08dc95f81810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|1800799022|52116012|376012|7416012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tRWTaflF9kwRPr1/jUKjHYOfu2kUVM6KGMnPo6hM1Dy7VUdheBUywyrE8MPb?=
 =?us-ascii?Q?9S+x15VWqNKsXEJdovdLQGlxOs4dR4IpI+gJU5vLJmM6UnkbjV7qxN/+MAcE?=
 =?us-ascii?Q?+qCbEcQRapNth99tNw8suUMqgHxm4vviw41pwqKQ2LFfNGAKRtbmejxAAsjH?=
 =?us-ascii?Q?+HuOq93AshEz6+NOxdNAqqFfU2uRt3u3XLEbuRXSs7CXsG9AA9paUMXxWIg4?=
 =?us-ascii?Q?hIG84ZklvP1u3N7WQHO+wsjs58aFWlqZ2OYtmsWVGupHPcsPLi2PqxRDB3zY?=
 =?us-ascii?Q?XLYhV2ECwlk6KLPJDJjNEmQtp/OXFSlPFC4Kb6nZQ9MdwIaB38d/QFy7oFrC?=
 =?us-ascii?Q?vmyA+69cBJ+rfgZezt8wQP1HpiNvx+jymYi5oSfr4tCfz6MYj6TW1iLRu9gU?=
 =?us-ascii?Q?9RLti3ks4X4o1dUWb96vrMtYLL3E3DL2vW8/JvvRyB0Zc2eGG7EEATLjL/dB?=
 =?us-ascii?Q?UGVxq/fA0Dl+QmRocJFK+07lRFZLPigG2BzrYXXpTwCd3czTtCM5jUiVfvdb?=
 =?us-ascii?Q?Au2pyafpNC2/c3f9ZbQWXL0ro9mp4ODoF+G7RvEdqHRVCE+qeC3YCVCxdrUh?=
 =?us-ascii?Q?Sc9/tWZwwiYEPjoIfiSMm6/g4O8anuC6ep0zvQxLzyVPUqF7KypS8MWh7ll4?=
 =?us-ascii?Q?pZrI8Sj8/o6x6kDfhUYLvZeZTNU0wIflcoutEaQdQKKHS4+sT0+vlDo/Jb1C?=
 =?us-ascii?Q?dWHePND9xgd+cfFSsmQG28mrYz9W2ZusXBC4WW//lhP2IvGl6zO5JhJ7MrM4?=
 =?us-ascii?Q?aPW4Sa26p9bQ3OBDfRqbYmxK/XNusDqaemFE4cj376vp4heV6ZzYiS3pk7A6?=
 =?us-ascii?Q?/WMka3ZOgwtLGZh8t2vN9MRACj2tAEObut4/KYO6G/BuHsFvosgvxAyI4COf?=
 =?us-ascii?Q?UaXmT4Y/ddu52idv0Zo4vOBNzdzVaR4MjtE0GKeWPglBNz53qBR+IF+5reCk?=
 =?us-ascii?Q?wLIRbQVKnswDluc3E/hUYR8vj17lv9seSDf4kAfrhcvdo3w+1UHPgoKVsl5z?=
 =?us-ascii?Q?jVb7fsyFx8R9K1L3AVRddogkwe5ztIuLkMHXZu9bf2jUJCWKtEe7CpWwsntG?=
 =?us-ascii?Q?Gowuhy+P0WsT8JsRYpOJTYviy9RPhDOBtG1v/bnml769IKeO1wze4JzACY4q?=
 =?us-ascii?Q?n9zpNuGEkAhcpK0np0QzR9Qw1x/QFfo2J37B5jt35s0XF7CiQk40i9/ojNe/?=
 =?us-ascii?Q?3PcOjqdCGJaBEyWZnuy1OeYaBS2aOug0tJazj8mi2sHygicyUS4apAeJ96iF?=
 =?us-ascii?Q?lW+WbiA4pAcoEJJEtihyfimoUFFItrolEsSihBK9iCCHitxyD7iMLf1Z8FjW?=
 =?us-ascii?Q?0O/wDtIqqWSud3hs5JTm20y1k3s74CPK0ffrKrJ3apru0hgi1QgcAtzNPEg9?=
 =?us-ascii?Q?S5QAKrU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(52116012)(376012)(7416012)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qrfuovbb6C4XBb6PcoQzOsrWzBF0vD1qMKU78s9nTIE4aaoxdHHKySwaLqDc?=
 =?us-ascii?Q?6Wi8GGiWCWofV8XN9VyUKTY1Mp7nN/toS6LcQPlpQYTA6dn1K/EqLi3uljBO?=
 =?us-ascii?Q?sbaOdnNaX7dp154CzR3wizMgaNGOk67TAcsoeTQLNaVZkS0bIhuxmpLVGlNQ?=
 =?us-ascii?Q?34gAOBqqF0l55W/tdvEZhm5H0vXi/ScslDIPhqjp1qtTM0sFrRLuCwOAaWxr?=
 =?us-ascii?Q?BHgoZ9w5qRERFTHuDAP9Cj1gAVXKVN1gjOwvfe8vBbYmEUjMbTWNGS36dwUy?=
 =?us-ascii?Q?r+c0Ta9uWh/ofZOvSfEgWE6Y3jA2BpZavgjVpGQjIj2rMWKJusgGBxmtgMSM?=
 =?us-ascii?Q?if5hriDzrAnlB6psTY1Wz9bOU0iow8otdd2ma2LpTl6AdtvKPK2LDAvsjYQp?=
 =?us-ascii?Q?ovwzSAHP74LHGaobi+mhb9l/oeEG775isLXT280r7VWlnxSdKXnTMUNvziUS?=
 =?us-ascii?Q?aYr8S9lz2UZGTuYVcLbswUlBD4yOzcCNJqYVu0Z2YXY7jxIL0Dd80burSkgj?=
 =?us-ascii?Q?61IK3yVjwI0l0fq2fOxVq4qnMpimFbSvS29G18pvNnk0gFW0yFZD913JsT4V?=
 =?us-ascii?Q?Cmf/Du6+KWbsn9n5Nd13pUQsh70ad6M4NA/q+rCU4+zKSqVEPaCqrMmSLZLl?=
 =?us-ascii?Q?QYsPSI0NhSUJlQMPavFx4FKb1Hi9h/En2KmJ5bfZq2AnR1kiU98ZyJ6lCuJU?=
 =?us-ascii?Q?FBCRxZW+WUGpkwYsy99GPAtGe9Pi3240Z30dHYGMBzQ3YcubG6wG229bIkvx?=
 =?us-ascii?Q?T2/iipqZoG0zuO0ht0FNmLXRoHjGI6nl0j2BiISAcyhIW414Zdnf/tnQstjw?=
 =?us-ascii?Q?kzT6X/+Hx6NSzHipTpeHOE4/qZzRcPDqa7dTElWdeoRK7ki41MmTocDVypuq?=
 =?us-ascii?Q?3784MbKmXCWqvakPlmv0DZhKfFub7+B4Pa9y3biI9fXx9JBaOqWMeC4C+MTR?=
 =?us-ascii?Q?oIcDjKcbh4NVZHpX8ZuUXThydHCXoK5jpvhaqQOXTYByrSmCLy6ZoIWWhNaO?=
 =?us-ascii?Q?GjM9W0dZtt3+kS5wkHTed0ktSx+kmhKXp+/Az3ZfXXW1dq5oUvHdWULw6/bT?=
 =?us-ascii?Q?lj1PncXPbo6S2K3rJ2DRcHhyfWKHUx54ERKVYbpEBbQxfFeXycerBEQRazK6?=
 =?us-ascii?Q?kqqgz5J0o5lm/P3U6uwxoJQH2Z2OWETDqJi137lJOIxsaexhjLp7o+eTHRGV?=
 =?us-ascii?Q?KlSTDXjZHo5lha3Ch5xEvN8sKQOYzlAbycwkOUZT9aSXDg6FiS2nW+71qJA/?=
 =?us-ascii?Q?BoUEk+YYLl76YzycjJe2/Gpfv2cruAkEfddI0ls8k7LcW86Tpa5Oj6LVSw2s?=
 =?us-ascii?Q?nvSMJ+9frlv4S5VnMBDegeQITaYwvu8D0TGx7hwII8DKQFj3/vVT8IQL8jio?=
 =?us-ascii?Q?7pVpt1YrASjecFyyIpYjh6aF5iGLSxcPUz8dWiEnua5xci3LuWn9R5tkRKTo?=
 =?us-ascii?Q?sqgbEdK4LkyM2MdTErIlYV/sfGcpcZU+8eHhSSPv7KxdDZIxF5WvzKEnOhLm?=
 =?us-ascii?Q?d4+JiZzMho7Q0Ce2lqns3sjGcE9tuKbGqQXC9b6YKwjeI84RW5ZrEsYk6ump?=
 =?us-ascii?Q?PRqqpOH31rzdxw0MRMRlB/CcmWceF1oH0QYumHn/?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855d875c-8408-4825-a4a8-08dc95f81810
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:53:16.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WlGk5cDo810OEdsHNN8wBpenzZwhFrguPM+ptY9RwCwhKxX0qLaiy+F6iuwLTVDGtIMBX9G9bUkKJ+bJsxZO2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR22MB4564

Add devicetree bindings for AM62Ax based phyCORE-AM62A7 SoM
and phyBOARD-Lyra RDK.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 52b51fd7044e..4d9c5fbb4c26 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -25,6 +25,12 @@ properties:
               - ti,am62a7-sk
           - const: ti,am62a7

+      - description: K3 AM62A7 SoC PHYTEC phyBOARD-Lyra
+        items:
+          - const: phytec,am62a7-phyboard-lyra-rdk
+          - const: phytec,am62a-phycore-som
+          - const: ti,am62a7
+
       - description: K3 AM62P5 SoC and Boards
         items:
           - enum:
--
2.25.1


