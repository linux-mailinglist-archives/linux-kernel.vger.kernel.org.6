Return-Path: <linux-kernel+bounces-571418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F61A6BCE4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6C1189CAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCC11BEF6D;
	Fri, 21 Mar 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AXpRlI0c"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013058.outbound.protection.outlook.com [52.101.67.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44478F51;
	Fri, 21 Mar 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567179; cv=fail; b=aILaNcnqx4T4efBJb5eUTZ9yNoIjYIV13hS0J/wxtkmYk42uupzeOZvHdCzRs/gVfqUnSN48gHW9ZfsMeqJdZKJpsxn/IAprSm43YspxaYZEIEjt4aDbWUBDmtyNnarK7v3v6/nlZBicfBtYTxnoprbVy6jAFKk71hUGiLrlXWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567179; c=relaxed/simple;
	bh=lZipdt+fkW1J1TdxjjS5b0gjdifFCuG8+fDtOyBtfSU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a7HONvSaOAGeOWwiWI24QScuO7OHQpWhWkHhDwRT0ZNzQI4Zsa70b1l1d9tSFnTYEK23NDnAa8xcykDw88pZYuCQTZ5Mrqe9+hdmCPgjf9V+WqDvNkDq4egPwgGMOWZb7KETfP0Hpqghw0XtbsobhS+RS6Fr8+dH0BFZbpgD6ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AXpRlI0c; arc=fail smtp.client-ip=52.101.67.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJrQgHR/73783bHgNjqVBhuuv5GO8oW1gWE3wti6KMkYNLmKHWgggYjHBS2qURDlVd00I77EjLPZiSLd+f2VF1Cid6hgJX4MwHNxOI9Pn5xhpHn4eQaDd9GIvGsna/BdSXwBntMA+S2xxpMokP/TascSQJ8W4v59uSKIHUmJL0BADSdxL94+azpYUwj91uv+Kwu5lNRZNGN2lZE03jSyQ9VtxjYFyrEdLdxl6xY2va+sMwNvogN3Nq25bqSf5xFAOi09Dqz+g1kk1QHCjmjzTvH+H3V9qibd/lBUDz7imPYy+vd2e8Cneps/ryQ6lCBeA5Q81k9CKcMfqNmfGFa0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V43UXLfaLyspJZhlALZ9PoKPEtBBQT/DnnevrubARwI=;
 b=gYveiar0wCjssC5xRxDEKJbAodTlA2M8rjiNDfP+XCKjt3gUmSF08C/O9+83qob19hjsfQ56maW9Gt1nkjykKSygSDuRaSg5Jlh/b5Gd17ZfM1hjqv9RbiGXpKo9W9rS4NPNwybgtS1M4YD3djkItFKoCEZ10vF/qOpy6ZeK4hiBpAgRJkDXYwfoGp7Jilpz4fKjGfJWdqwkqPU9Vk0TISdoM9GQEUxLRCJSUzNnpf1Ozro7KBU5ecFhuAUoDV7ca239Mu5ZdiUBVIp8phTcYZZ4JWMNMUGbow2p4TbNaKYXkjYh/EdHQSMm0aJE9G0RAvmzgbaGo1vsLbVkivmPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V43UXLfaLyspJZhlALZ9PoKPEtBBQT/DnnevrubARwI=;
 b=AXpRlI0cqALTSCxtOSB+pfGAbBbNGxNMAE0EiZ++3CVV6mYotmcicstIZ4xkbk8JXSjCsv3e9PVY6lViQZPlFCOGRIFXWe85w86/5hx1zR73WG5C6WFGOYgpxXmFq1aneydxUg8z3AaaLYjpGQ1TWPyGC74sCaSbAhhQidnKhhQiGTjlr7NZldSlrfC0LdLMFlXK7DomhkpRwAyYpD0wM7f6UM25dSDh3FpVnDizYGBmm5l6KOb5he1hxtY7qkn3gZ2FRtu2QJRc1k7YQ3M4YjWIPY+pXR9NjArF/5PygYBCxhPOriwS9LOaiFZqFstNvgG7MZvk2yNZznS5nqVumQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 14:26:14 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 14:26:14 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>
Subject: [PATCH v6 0/3] Add OF support for Microchip emc2305 fan controller
Date: Fri, 21 Mar 2025 16:33:05 +0200
Message-Id: <20250321143308.4008623-1-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR07CA0030.eurprd07.prod.outlook.com
 (2603:10a6:205:1::43) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: 347dc572-ec54-4a75-6dfc-08dd68845599
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?8ux4/0mGMJXtPddFj9zPYfeImnHY4T6oQGA8NBFbz08LOBJmZATgaz5w6Q?=
 =?iso-8859-1?Q?bumIiiyDo3YJRy7MJKHoQ5wF9bjIltRJZn4ZNHgGo+pJAdJ06sjq3Neslx?=
 =?iso-8859-1?Q?ebkta+4gTI9kUDjvaXVdUcxFjg4/KETLAmvku7+vE5t2ieafpBZO5O7KUQ?=
 =?iso-8859-1?Q?JnB1XllATgr3VCH/9UDJR2z+GkrOocnmCXohUL3LwF1zP/5p2OyyxJr3Wv?=
 =?iso-8859-1?Q?EPFVSqxp2KV4kyJTTwDgUDsGo7n0w/wTfXOiFhYoTpGHIjh+7JXR4V9oeO?=
 =?iso-8859-1?Q?1lsq5omBIXiA+leBS9IyUceh2xxNn7D660IJh/kfXR+MJ8LA6d8yDtxVsT?=
 =?iso-8859-1?Q?BiRVS1RZmkXbEzFVVeqO1qXT+1HCRH9TdOzFezeDVCW2xA5MxnF4x+7/FL?=
 =?iso-8859-1?Q?faZZp3bXpw4vJDofJbnkU3mcjuy3MOvcpTeqV/7nxnKUcm/70neIMRKJaM?=
 =?iso-8859-1?Q?dk3tRATCCP6kQarEAnZw1edlHdIIQ0UNpIaDWmakKrVFqyt1iy/G14Yhxo?=
 =?iso-8859-1?Q?9TFpXAv/+hEEpoTfriaIz0Kd95ETDIafvNtFCNEjfWsGYcGGjffu49NmuD?=
 =?iso-8859-1?Q?qUof1BURechR1i3kPnkECjLbN5ZbdYRvR05yRXeYtzAgdpo0kmEk4Em5Ut?=
 =?iso-8859-1?Q?TmWUUuf0ksmqO9Zid+LiQ8xlxJZOkiUydYKYib7mz9JMfk8Rs5KUqhSD8a?=
 =?iso-8859-1?Q?Pqcbmcf07+ePyp08/JWM+VRsHenTuU+J0VXOzlY/2f0bT1Kxlbdl/rwsi4?=
 =?iso-8859-1?Q?eWmcUrHALOJ+X+nh5Cu6E/BHZu8accZFjL/hEQyuqtoF5e5Xq/6QYBHdf3?=
 =?iso-8859-1?Q?AWP9kuXrupAxn9/2gsyyqIwENQYGom/OQ1NR9M/vLjcb+ypPC0J08DxScI?=
 =?iso-8859-1?Q?I9VkAFhg8CYH7uaTTrtgOrpj5k1vkep1+OJK25SdSxaFezr5GBzWbpvMH4?=
 =?iso-8859-1?Q?RHNL5lJ7CnWHwX0D07qbeS15lT/nsYhl3PPWmDbh4OCL1aXSqzr7l0R/Aq?=
 =?iso-8859-1?Q?FgQawhCQB7YFetOVZTVgMcSxL1WlCJ+h3nCf/ylJL6CvpQ31jzAVeOQIZv?=
 =?iso-8859-1?Q?ISe8tjumPKxiUox+W2r/r0hJ+Wy9XBhpnl/VF0ZKpLXyh2xY1Pa6QioKAI?=
 =?iso-8859-1?Q?E2ZnACkAkRqdvgOe1kUFZ5MloBjCpA0Vmf1Q2AmpsZgGQGdyBv/dN2+VcB?=
 =?iso-8859-1?Q?X1/BDtDHphPXwVcA2g2/tNE87CSWWlZPs+/33xNB764mI73ebtE2M65MyU?=
 =?iso-8859-1?Q?pGi2IzEOEspJrfXum+QhVdI1Mw4HCzy9qFYnl46zcmTOe9aZw6s7W8Dsvw?=
 =?iso-8859-1?Q?vQ3CDfyuTzfSybsUfXxEwDGK+pWy0tigsrTP87W32p0pDajxFQYq1t4xh3?=
 =?iso-8859-1?Q?uds9uK+mVCxxX6aKB8tnSMFNXZNwzNWshzP+IDkfTDYXsRt516TJpbwt55?=
 =?iso-8859-1?Q?PUYPhx/znQeI/XynT9tvHM48TFt6es48tfWx5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?GgAr3hQab2uxVqEP5ZZcvUzyNlFT9oTh07guBaEQLFYFOXZFmu5ZldXKs9?=
 =?iso-8859-1?Q?vrYiI/tCw+W4Yb9OBwvVmkmSAeJUGSm2s3Qvr7urir3rDWNwKj5BCfQKUL?=
 =?iso-8859-1?Q?gg9UvVUqyyjHyzdRLqRAjHmT999mOZAHVFYwR+bJryvuqLV1wvt25k8W55?=
 =?iso-8859-1?Q?8w7cgtAe8VdDqvtEadeAQfyK1FMziZUwbYBFTmaoOBSFG98c+3xlEkkUwh?=
 =?iso-8859-1?Q?eLJ94XwIRyqArq9sKyQIscq3iDC/tIBLQF8T5fTjonhPmRPXWrJHl1Ge00?=
 =?iso-8859-1?Q?kCPDrUsoNJ2eF6YAxBnzbemc9kSJseWg1HFqmnI0LCJmiRleqV9d4pcn4r?=
 =?iso-8859-1?Q?xefzvR8NVX5qYtaMOtlY8ANibrO6w/+jKeFFx3hC4xNxAEI5NljOcJ5Cx7?=
 =?iso-8859-1?Q?c9lbhjjekchmtidzLNsHmlsMvJlmR/ULHjIVqUcXdCdSrJk0RyrtP4nTxw?=
 =?iso-8859-1?Q?z1XaRusNr3/LgL6W0/d9kBXeo9dc1sEckF/SAMEx0SRqLq+qmMcYiZ+E45?=
 =?iso-8859-1?Q?3+68mwU2wwZzSmvzb4Y1XggVqDFTgmN6aQxLuUI8VoKZnIRDxooNi2QY2V?=
 =?iso-8859-1?Q?t4/laqvvur7TN7f4TVTSwG6RJ88n5dsa4hVeLpIJcDrwpLRKcqG9BQh4wu?=
 =?iso-8859-1?Q?XPuh2RKhXSi0lgCOGbhpBP+xAJeA6WBVTUu3uX6neHAGdv3Etc7y78IoL4?=
 =?iso-8859-1?Q?gD+V7MJh/cpJytykNZfo900PupozZIuVAwh0S0duqNJLjBZW9a1G6Yq8Da?=
 =?iso-8859-1?Q?nX1toZa2uSYZHnWUNyD00tt5zBRbrT3T8uvA2AtBGowRMvyu5tkiz7srFk?=
 =?iso-8859-1?Q?2Csw1XseA2ulCp/0HovlV9M99t0Y9Yh4cPPzSSAKKVStRYmRpZ+AHsePMK?=
 =?iso-8859-1?Q?pvDi6Rw9AKJTriEa6Y3dGw2sf49kRKb/vR0Q415W8pLJpuRERXgkkDqFIw?=
 =?iso-8859-1?Q?wIoOF+mVW5bOeyht3mD8LQycPzb8IGwtzmUetS5LUD3KMOk23PGEaJl/Kq?=
 =?iso-8859-1?Q?IIu4KL+pvXRBGcfbO+uGqzy7AZ4B0S5STPrH8Y7Rj+SC8Q0cEzSOWy7e0G?=
 =?iso-8859-1?Q?ULF3fVvFY6YUbCTpunUMLwqj2UkqWmxz83gatdIHnVYBTk/ZWXUv5xBEC7?=
 =?iso-8859-1?Q?ch33/WnIlGyF+4NZgLCt1jn6EkJmLPKgQsmdB+iKOuMJhFoXzqLyAJA0K/?=
 =?iso-8859-1?Q?1hImioWYjw8htRau4BaaJJRrvScMC/BeKpdzVws219mzke4VkLj+nQBqo3?=
 =?iso-8859-1?Q?JS7PKcbBeK2PZyN+vQEaiNv7VW64yruPaP/owLHCddn/PFO7tEB0/XCscQ?=
 =?iso-8859-1?Q?bd5S9qsJ0T/yD7TaUk/f4aHaF0TK+/8CrowhP25PMQTCgv19R9cX4daDNS?=
 =?iso-8859-1?Q?w31XgNgUqd/gSo+u2Zc0MRGIU3GkUCQL/1cE6nFQLB81tK3hf5sbrx9Men?=
 =?iso-8859-1?Q?Y9Gmu8ybDFZp5Bs/DrXtKbHM2Y4aZwrmeNhc8D05swQKJoxd+hEFT0yxKp?=
 =?iso-8859-1?Q?AwBlssbrl8Indm7sNjDOg2b7FhdTVJIdPw3CoafK4TCHd3+33z1GN0ikFp?=
 =?iso-8859-1?Q?RrAoHEA2zRdVKL6xix/Z9XQfkNI4Kj0Qrbbg8RtNpQgbXbj8IvN+ZRH99O?=
 =?iso-8859-1?Q?f2DmB10MzzudB+otlNpeEPLFBK/Dbj7P2i?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347dc572-ec54-4a75-6dfc-08dd68845599
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 14:26:14.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEf6FbSYtDRN1Z5RZQpl6VIj6fmsP8hQ0WXAMLg5axXmj4YglnBAGzd5NSLwD49wl0a+OzYzj1CuxT0QNXd/TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061

From: Florin Leotescu <florin.leotescu@nxp.com>

This patch series add initial OF support for Microchip emc2305 fan controller.

Changes since v5:
- Corrected blank line as recommended by Krzysztof Kozlowski.
- Removed pwms property from required list as Guenter Roeck suggested.
  The pwms should not be mandatory as the driver works fine with defaults settings.

Changes since v4:
- Corrected quotes to have a consistent definition.
- Corrected DTS coding style as recommended by Krzysztof Kozlowski.
- Updated pwms phandle to include pwm frequency, pwm polarity and pwm output,
  as recommended by Guenter Roeck and skipped the pwm channel as recommended by Krzysztof Kozlowski.
- Documented the pwms args in #pwm-cells description.
- Updated pwms phandle in dt-binding example to include pwm frequency and 
  use PWM_POLARITY_INVERTED macro to inverse the PWM polarity. 

Changes since v3:
- Removed thermal_cooling_device_register_fail label since is no longer needed
  and replaced goto with imediate return, as recommended by Guenter Roeck. 
- Redefined compatible property in dt-binding, as recommended by Frank Li.
- Updated driver of compatible list.
- Renamed node name in the dt-binding example, as recommended by Connor Dooley.
- Corrected dt-binding commit subject.
- Added dt-binding fan descriptions and $ref to fan schema, 
  as Connor Dooley & Krzysztof Kozlowski recommended.
  Used similar as on maxim,max6639 and nuvoton,nct7363. 
- Updated dt-binding example.

Changes since v2:
- Removed the introduction of new properties for now and we only 
  enable basic OF support.
- Link to previous version: 
  https://lore.kernel.org/linux-arm-kernel/20250219133221.2641041-3-florin.leotescu@oss.nxp.com/T/


Florin Leotescu (3):
  dt-bindings: hwmon: Add Microchip emc2305 support
  hwmon: emc2305: Add OF support
  hwmon: emc2305: Use devm_thermal_of_cooling_device_register

 .../bindings/hwmon/microchip,emc2305.yaml     | 110 ++++++++++++++++++
 drivers/hwmon/emc2305.c                       |  38 ++----
 2 files changed, 120 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml

-- 
2.34.1


