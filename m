Return-Path: <linux-kernel+bounces-305381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA8962DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDECB21A50
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633AC1A4B6F;
	Wed, 28 Aug 2024 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GRfyP8AA"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9471A2C0E;
	Wed, 28 Aug 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863312; cv=fail; b=op5ldLXAzk4eSag/j2M0oCM/LtGbMQjErsHnkOukuHY+f2CtPWcOyagOnEmFEvpomXJaKAdNfUQgve8ggnuest7QhTZS4qV7MzNPLm90KHW0G1HqH9/+E/Tqw1m6Zt7F5W8k7cRyH6q+UUA+CV55yjbzjiWRiWhwivsqG3+9iuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863312; c=relaxed/simple;
	bh=+XNpLL1LZqh5MQrtP6LyHpDHPE9he9WuHpOqxpRhjhA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VZ5c0LytW79Vj9EHU/QmhLnkqx1wIXLzVlVSvmBIX2SEzy8xybrfKxRO36B2lt0cImJ8pnJ8929oHsBduOJpftHKSKfRqT2aXyxKUpwoNFAPcBxt36zgkELY/lH2ELH/LucKcptBLMRfWT/46MmssrIAzzW+1UeY/PmEAf7SinU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GRfyP8AA; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrnUADyWyn1G4e7RISp/PpARaLSqcMkb+2rzV6/YLq2BbX7rhdtKg6pEgxDyviOQzZYpPmwVVq3DpgS6FQpB1de9Cw5m3BMzfPGY4uVHmps0iaRor6+hrAhFiM69ipj3uHkbrzLQ2TlaHrqPJwQqbZc84B1SpzGeSwKw47NCkAMVFNjRD5X8S6YDRQw8Ym1YTq6SaMQpUd15C2gjn4wNVNLEawMZkj0FZVvUBoTHkFo9T37Am0lnF11cOCjmFYfYFYZzFj5P40SVKODjLW4sW8Cdjeho+lwIUtK1Ttq/WnzUe4lO7DsJMLg0Bx/jgEighwazXe7PEzvRh2gQ/ijjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSwUcghGzz8y/yPUr0c0Ah6PK9Dvy9m9Xii31BHOZq0=;
 b=ujAiwOs7C5a0GSyBP21CnpuENMfbz69AJeB6VuMgQBrOpUbrkYQMWn1adAiEgnoXnNlvuyOks0z3pn6jcAe+v2PIqAG9D31l+RE72KWvdZXTDIqP7UDKgAZHp1Npt61fNSK6P344Qq794eiFz5+q6I0jOkL6pf0uJUKZxl+PQIyF7vNBbf9ZicpNNf5O0Q6Y7fT1OkrEm/AvKa7XO0QodzZucEIM3gNH8UaOw5Mxw8Og8JkPc2wIickg6Uazkkn7YFwtNFyGsY4gOuhld/6ENgked+Hl1+NbdiIVkKX+v5Be6bkH3LuvONOJmsXmjco4En7N+0TDJgyeT7paSBr84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSwUcghGzz8y/yPUr0c0Ah6PK9Dvy9m9Xii31BHOZq0=;
 b=GRfyP8AAnxNa+R/vtlX0EHXTfPPz++ge73xdgJOZaSMEBbXRlIwuhZMfoLlCGuH858d0cz/alZSz50kx5P4s1Y2A9BLgCLn8dbKfiV3eHn4cryFyojcNzErRWtsfS2+SO0adVQhB79GpaxVp/KXHDlOJXYSjmdsLcvFAtOiCI1puG0+hs6oM8HIZtiohINEfzEyBzSoHhhMXYJtw1o+DeCziFfY+AWcCn7K+0Ktz6kdTVmzCe454D4bOUOCGB+vyJHlnMHlEQZ1VB1gS/WdtINmRJIIgKplO4v2VxBNFV1cs8BHMMDIb2lsgn226y9dFlBWqtMZd5/Wv+8DU5cUDpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7291.eurprd04.prod.outlook.com (2603:10a6:102:8c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 28 Aug
 2024 16:41:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 16:41:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: robh@kernel.org
Cc: Frank.Li@nxp.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	jdelvare@suse.com,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net
Subject: [PATCH v4 1/1] dt-bindings: hwmon: Convert ltc2978.txt to yaml
Date: Wed, 28 Aug 2024 12:41:33 -0400
Message-Id: <20240828164133.1131959-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: c170cdac-7ea4-4659-e409-08dcc7804eb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aNi5tj361BMEQIul/S36s2lFx1Ws9KasG69h55yvGSO6hbdYOR53DAGg2p3B?=
 =?us-ascii?Q?2lV7WtncQWdLdwcmGnTY2r4mVYaFzyNkeT/+KYUzDlelkj4dHje+PorqF44e?=
 =?us-ascii?Q?CaITvEQ0CUaZgmhEfgIo5ZCa5oy8TZ7uePXwRIn06wz+0MT+2cbcSO0pXh/B?=
 =?us-ascii?Q?vjU0YuAZmmj9wsCwLoIIcRMMacb23WzTFYEoxG8hdRtKkOEOhROcMrqX2u5p?=
 =?us-ascii?Q?Py0H5M3mnT2kwroYnuqTK+Nix5yssYp5D7ljKxRj+xt/zk3yHFhXVzLy+7n8?=
 =?us-ascii?Q?op5XqXkaTMvrsQf0HhdTylsuKNH5zDMVcR2dZco8SJSWc0KEr2Ys8SEhnC+a?=
 =?us-ascii?Q?BNjAlxl/EV2xNNtrL3vFG6V5kuldjpiBLILaOCnZMll8+hsEw1Pt1c6PhJ0T?=
 =?us-ascii?Q?2ok37fwjn3XF0tDopSVtkkmeSGu3M/KY3cvDrWpySBP8eB+5UxutXDVBIKN6?=
 =?us-ascii?Q?0QUY9kKNP6/nmy6SD2ve0vVNDl4mjltIkRXKfZWuuWhxEjDezyyTtzipr81n?=
 =?us-ascii?Q?Plf9YtEsfyl95ySM+BQH+s9S3otuSMyGzdl4H1z1F6Lghu9/ClC7MT0fm/nv?=
 =?us-ascii?Q?FvF31vCYje41qQG4l7s2slajLWLoGwqPfEqL+1PjhsgDRjbO9gI83fNZeOwp?=
 =?us-ascii?Q?uWwHkqQMkPolfhTPqHyj46UzNOhbbZ6qza9TU6BNXLH/xoEA4DB3yRYyhQPM?=
 =?us-ascii?Q?8b0zE1+PpGaNoEWCQsEtGkOUo7fVox6obwdzBGvV8W//XlRX3z2EVeb19q7P?=
 =?us-ascii?Q?VWng6bHEcoV3aXGZGC5MMqr7PqnQX+kvQJ62p6bsfm09VUeOe9mBE7ncbIKl?=
 =?us-ascii?Q?Q6R4DSow+nTI8zJR61G+1yb0L26CXv0dERToJVs02i7BWnOH0hOr775aft5W?=
 =?us-ascii?Q?K+A2kK+f0WY5DRU01DegIJH1PNHMaiMRJa3Zikqt1rjUTEgnnsnX969UfUwR?=
 =?us-ascii?Q?yVLaB5r/tZK2owxtNOJ+aNdRE8qa6axb9QRjGPzWjdEC8JcCtrjrRppSQ1/e?=
 =?us-ascii?Q?gd6jYU7Q9VJjonpMMzVTQTegKo5/mHgyrDpKf6PXUpmtp/YjBBPXN1iyix8S?=
 =?us-ascii?Q?LzqgWHbS6a1h5TlUN+svyccS8fFqraC5zkYxzZK5xlRqs6r9+eIvKpkVJiSS?=
 =?us-ascii?Q?cWh5u0L/h73hfqeT+WM5rBGYrgKxtGhvdSoocWuReKMupZslqOT2/3gEPhzu?=
 =?us-ascii?Q?bwpPpFoPIBFnMEkGFXbxkoUuhMrGpA1XmLns6LxiWtcj5BctczcrDn461Fno?=
 =?us-ascii?Q?vpRmPMIecPm/J0+CJQC3va9VhfMXcHy6WiWFKbA1IlRW3qZ3hAUgW+e5YWbu?=
 =?us-ascii?Q?pUUxyzIuky9bz6ToD2hUjKUHNThmtoFj4zjqwNPAtDoF6tvlTmbk0JhfjWWT?=
 =?us-ascii?Q?pJ4seX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rSnpdypK9nx6JkmPI0cue3XzNaif9SzF7ldW2X7l+ugUo/b9joY6hop/Z8Vg?=
 =?us-ascii?Q?tSWAdnm2GvGaxE+H6V0vkOv6lAkEdcImhOcdb3mLK/ZfyUQDmBTsYXuGMPUt?=
 =?us-ascii?Q?eeJUVEQKL66jznu81cz8NENoGEsnVmo/9qM569+TI7Xr9HsLVBg12C1Ds/Ks?=
 =?us-ascii?Q?G3ttJoGnHxINgx/kcNkSZIhPA97dA9l5Y/6RQkPHwv9xE9zVCQ9ogkmmMH9N?=
 =?us-ascii?Q?owbpRr0XXHb8N9m2kMoFgdlA2KmY6/6VUiVyRGGXlHOnHUbq6TYjbvCdU4hg?=
 =?us-ascii?Q?givkWOOUg98iBs+pnZm8kQRM5kOCzgMqTYqJu+2ujJIoLsnvX2OkTx9pPOha?=
 =?us-ascii?Q?WJ1wOMETuU/+wMJ2Ps11QAJScsyPnocKDOh1yBYvyDhGravYtFJdvSalhnT0?=
 =?us-ascii?Q?ZSs/JgTVjLj+HYyBVmtxfERiyDQMbTE+FYzC++BwpSSTEtssDg+v1fy6UBgE?=
 =?us-ascii?Q?qPz7x0LtEf/LgfmKhOm8wZfqrbgL8DTM3IwVjGEmLWzjC2QPui9WujMFtEWW?=
 =?us-ascii?Q?/5Tyyc+gR7fEbsO7R8aw/pC6MTsXsII3OavwCDMojO+O6qbCsSs3K/i3qtfD?=
 =?us-ascii?Q?VykHOYhYuS8Y098adEcGy7+6Bxj5yegirVxB6QwqTvRGZ2LvIVxjRZU7K2Q6?=
 =?us-ascii?Q?K7bYdeAf55Mpa+q2nLP0PKl5FjevTkbWqal4o4KYcFYmJGNEdS7RjoNzAlgV?=
 =?us-ascii?Q?DmX1lChShZVOIZnaUi7Yiq4j3s4SSpwDPdIABsQAfy5WC4S33LoIxd3ggn+A?=
 =?us-ascii?Q?TntIwQIIxgD7oPTOxInXPGjfSMEG/tywkP713z38a2MCqr3ySQDVbs4EnEm3?=
 =?us-ascii?Q?ppxCcJT7y0fZyAoLp2PewPMsFXPg3zJ4AlX8dkXr+cFnyOuvuR+SA2KTi6fw?=
 =?us-ascii?Q?SPuH1GBrOETadH1l7s7kRzA0ORxaWFr/0A/DSaR1DqdqkyLN/NniqHhmHxdK?=
 =?us-ascii?Q?VvZzGG0rkSN+hicThAI5/81qy06N9+J78y3ZoQqSyx0By7Zy3ZolTTfmK2XV?=
 =?us-ascii?Q?qYqA6bskr40Y0ch23Un6hcfCQ6Baf/Ld4Dmm4Sn5tR/zffDSySeMeEJTTEw7?=
 =?us-ascii?Q?RrLB4RSWp0NkYuVL2Fz7/ysYC36HvwCl56E16fkZxh1KeN+Vk6aTcse4wZBu?=
 =?us-ascii?Q?kdazUZdw3DXi8yvaomn/iyIzv9YYjuxBia328p4yUNFkyy+C7gnxfgm5UEEQ?=
 =?us-ascii?Q?KWoa/X8Yym00yMZ0mWODVoPErW/d6l/qaugx78vUayD83FooNESQrRTyEu0a?=
 =?us-ascii?Q?JiyHrWvpMaTITgTc8k0v/TJ7vVrk8pQxRrASeP/+P4GrpSt0WezehczCM1/F?=
 =?us-ascii?Q?Kivl6meAw/brbkaW57pUr/8oVTVxkovWfrd2dKVni8kVHpfVaSvOg/fEFY1t?=
 =?us-ascii?Q?kgY2+kCzNvPE7LdatFb7h9PMvpEb9ud6IZvX+nYLeTa6UaOZse7JDFQAi9v7?=
 =?us-ascii?Q?8OkObuzZcwrk6oV+seJwYEKh/zpZIVn2B7esDJhCbl5+n6ASoTFhfsoli+x0?=
 =?us-ascii?Q?LlforvHD2Ss5fplzJ5iLfeGXCMOLMc/dsvq23/HYANZFXut4IyY66tmeTqK5?=
 =?us-ascii?Q?kWb27O/XxP4YZfa1tvjmwyQIBIm2Lhu2/Skiebn3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c170cdac-7ea4-4659-e409-08dcc7804eb4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 16:41:47.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSMIPqYCVKeegVIX5Kidq6fDG2i4FIiPNbP1CAkmivCM/5V6nmc+AJgtya8+vz65mcCLCImDAqzjbJwyevdMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7291

Convert binding doc ltc2978.txt to yaml format.
Additional change:
- add i2c node.
- basic it is regulator according to example, move it under regulator.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
	failed to match any schema with compatible: ['lltc,ltc3882']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- keep under hwmon directory.
Change from v2 to v3
- put my name into maintainers.
change from v1 to v2
- maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
- update title to (from ltc2978 data sheet).
octal, digital power-supply monitor, supervisor, sequencer, and margin controller.
---
 .../bindings/hwmon/lltc,ltc2972.yaml          | 94 +++++++++++++++++++
 .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
 2 files changed, 94 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/lltc,ltc2972.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt

diff --git a/Documentation/devicetree/bindings/hwmon/lltc,ltc2972.yaml b/Documentation/devicetree/bindings/hwmon/lltc,ltc2972.yaml
new file mode 100644
index 0000000000000..1b930400fbcf0
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/lltc,ltc2972.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/lltc,ltc2972.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Octal Digital Power-supply monitor/supervisor/sequencer/margin controller.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc2972
+      - lltc,ltc2974
+      - lltc,ltc2975
+      - lltc,ltc2977
+      - lltc,ltc2978
+      - lltc,ltc2979
+      - lltc,ltc2980
+      - lltc,ltc3880
+      - lltc,ltc3882
+      - lltc,ltc3883
+      - lltc,ltc3884
+      - lltc,ltc3886
+      - lltc,ltc3887
+      - lltc,ltc3889
+      - lltc,ltc7880
+      - lltc,ltm2987
+      - lltc,ltm4664
+      - lltc,ltm4675
+      - lltc,ltm4676
+      - lltc,ltm4677
+      - lltc,ltm4678
+      - lltc,ltm4680
+      - lltc,ltm4686
+      - lltc,ltm4700
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      list of regulators provided by this controller.
+      Valid names of regulators depend on number of supplies supported per device:
+      * ltc2972 vout0 - vout1
+      * ltc2974, ltc2975 : vout0 - vout3
+      * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
+      * ltc2978 : vout0 - vout7
+      * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
+      * ltc7880 : vout0 - vout1
+      * ltc3883 : vout0
+      * ltm4664 : vout0 - vout1
+      * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
+      * ltm4680, ltm4686 : vout0 - vout1
+      * ltm4700 : vout0 - vout1
+
+    patternProperties:
+      "^vout[0-7]$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@5e {
+            compatible = "lltc,ltc2978";
+            reg = <0x5e>;
+
+            regulators {
+                vout0 {
+                     regulator-name = "FPGA-2.5V";
+                };
+                vout2 {
+                     regulator-name = "FPGA-1.5V";
+                };
+            };
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
deleted file mode 100644
index 4e7f6215a4533..0000000000000
--- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-ltc2978
-
-Required properties:
-- compatible: should contain one of:
-  * "lltc,ltc2972"
-  * "lltc,ltc2974"
-  * "lltc,ltc2975"
-  * "lltc,ltc2977"
-  * "lltc,ltc2978"
-  * "lltc,ltc2979"
-  * "lltc,ltc2980"
-  * "lltc,ltc3880"
-  * "lltc,ltc3882"
-  * "lltc,ltc3883"
-  * "lltc,ltc3884"
-  * "lltc,ltc3886"
-  * "lltc,ltc3887"
-  * "lltc,ltc3889"
-  * "lltc,ltc7880"
-  * "lltc,ltm2987"
-  * "lltc,ltm4664"
-  * "lltc,ltm4675"
-  * "lltc,ltm4676"
-  * "lltc,ltm4677"
-  * "lltc,ltm4678"
-  * "lltc,ltm4680"
-  * "lltc,ltm4686"
-  * "lltc,ltm4700"
-- reg: I2C slave address
-
-Optional properties:
-- regulators: A node that houses a sub-node for each regulator controlled by
-  the device. Each sub-node is identified using the node's name, with valid
-  values listed below. The content of each sub-node is defined by the
-  standard binding for regulators; see regulator.txt.
-
-Valid names of regulators depend on number of supplies supported per device:
-  * ltc2972 vout0 - vout1
-  * ltc2974, ltc2975 : vout0 - vout3
-  * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
-  * ltc2978 : vout0 - vout7
-  * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
-  * ltc7880 : vout0 - vout1
-  * ltc3883 : vout0
-  * ltm4664 : vout0 - vout1
-  * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
-  * ltm4680, ltm4686 : vout0 - vout1
-  * ltm4700 : vout0 - vout1
-
-Example:
-ltc2978@5e {
-	compatible = "lltc,ltc2978";
-	reg = <0x5e>;
-	regulators {
-		vout0 {
-			regulator-name = "FPGA-2.5V";
-		};
-		vout2 {
-			regulator-name = "FPGA-1.5V";
-		};
-	};
-};
-- 
2.34.1


