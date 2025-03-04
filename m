Return-Path: <linux-kernel+bounces-544903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210E9A4E814
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EF48C208D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694DA2C153E;
	Tue,  4 Mar 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eMOaZ7b1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48EC283CA9;
	Tue,  4 Mar 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104863; cv=fail; b=tAOY1Sv1i6gKrpEP8mi8GSuW0337fMv8IMfNQo0nWW8A7cYrgHwwalzi6FweW1n4GhfnTY+zn0VoesvbvjlNsrbYiMbZ43KB9O1Zw1bPnKvUNYJuIL3NuGrYPHO9Voc9NlMJ2qLkHshXszGvYCdDPvRxJmWFO84Z3L++9Q1hDrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104863; c=relaxed/simple;
	bh=GyQYFuEr5OgVK9c0WmFCBuC1T5b4MUeFYf/5+pSRVeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r5fO1zjzeMaHD4gMK8p826+le+sN4RZsyfJjCIXbec7TVa4YdyxaZ1ov73iK0SoIha/XcFqiLPx37trBEMsLEShKWlIPKYTtQQ291wD9hmUiQtVqjpesYEKEKjQt3vDweam6km9tu6Wj8b1agqDyujFwPb0B4O9WNnKhsZoEQNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eMOaZ7b1; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6rLNvpkzvSlTfATu06NcPCxgeYsSS4oQsTWjA6g6LeiN69dc0PFunjFrDjjI4H5IFEqqy3u2T/F8z55g7R9IEvgcpQeC/jeio8KzCSu4bkuV188YtV82rfwYQ+/2ymNqEw4doYWR7kxRPlc0JETLfbrpWuwfa0eJG7k/hoE7OTxbV2sS33pgkOjv+k3nxi+uGcRJOTTObxPx3/uhpcDOyPiMvf8yMfr936DK1sEmHs1eqk+w+t8NfocntdOBu7NGnRYXS8Tm9EeLnIJwBsCThb4wZpZ9t2ZhnjoMHTfkum5yTD+kahmYpbVP5RN7yU4s99yYqlSEMaIxICAnnEi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNt5AHlkS796wk/PkoC+tptN5w8o/xdicEm439ZzySQ=;
 b=cT4+rpJjW64sGjdPG8HjxqoHM6JBsgx4gdSTyBRcYqdJPgvocOb/8d9tibIojFuXM9Y9tIrmbKJl9r7VD5tFZ2Vxom08WbSmdMmFpI/bRHeVZhpg6UvjkL95K6fzlSg3kuhCm0K7mDD4JXtLwhrYs0hLSYZeJunXaAHGme83hyKwWj+zwNbFnWD63qoWyGmwHtSq6uvra6UbZZReRYyKFQOaPWJ7CnJVTzxUK8uD2EzZ+NAqcHQhjNkIBqiwV91sMPgJVwTjbjI8NJKxKlVp12FFX0oPOTIXCbZW0qrJ1QTCaqEDFFxvOnQrRzgOz/agVLuAr1XDr2BeMRmgEUs2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNt5AHlkS796wk/PkoC+tptN5w8o/xdicEm439ZzySQ=;
 b=eMOaZ7b1DTefiHJmbCDwicGgambEUvQ/qq7gU3KBC6HgJANf091M0EImel0NziSBlJC8OBpTPYezn01OnFDx39jUt/9VqRa7JUQtrcrzwSVq2BSI+2Grbi3XpEOMhJxPkRHbPzKwxfyF+pRI/cRTnRMh6gbqIlH0AWdYm1XcWCzzvr8ImPZglk5ACBMMMSheHhpNI/LVQk3vfor+QGaiVS4yC8ElPNSqpGO34Hb4KoLfZjykTxtiGS8BvD1p6hn/NLZ5MnaAkIF/oDP336H71yhpXiWxOPHUUYqCb5h3da/TcxVc/h+QdlymPcjcWZlho0cxWjf7mpADiV9/YhSh8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by DU4PR04MB11080.eurprd04.prod.outlook.com (2603:10a6:10:587::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:14:19 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 16:14:18 +0000
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
Subject: [PATCH v3 1/3] dt-bindings: hwmon: Add Microchip emc2305 yaml schema
Date: Tue,  4 Mar 2025 18:21:34 +0200
Message-Id: <20250304162136.1963384-2-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
References: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::17) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|DU4PR04MB11080:EE_
X-MS-Office365-Filtering-Correlation-Id: ea64ea2e-1020-43bb-66c6-08dd5b379de3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?MdDMUyIo/+GYf0NhyTUTmEDeyhXXJrbZq5objMM5e/rosG6FtZuXyaT0MG?=
 =?iso-8859-1?Q?vAkL0Q4ahb38C4XQFimHTsI4O0XpKSDZXU89TDMS+uMtWIlY4Srn0ka5wM?=
 =?iso-8859-1?Q?VXqx9Q+mK2Ig+up28d+vjgy/bFbePmxJ6Tnxf3e0JONJKe2VhCqA1pgp4u?=
 =?iso-8859-1?Q?kcRVhwWqSrX9uLoI1swKkYsLAygw280UsZ4z0hmpPOgcaca3xV36w/bwn5?=
 =?iso-8859-1?Q?kcZLiQ7XH/ukV7q4tUE9hIrWel4M4VSOq9LkmyATHvL/4rvkXN5Db+XmuI?=
 =?iso-8859-1?Q?vn1nXPxg2/aKEJTZ52G+eVbYFb8qku6uKGbcwN87GeUmoWfrJwWKe6Wnct?=
 =?iso-8859-1?Q?GUIjrb4oaoRMdNARzEzxgjVCw+YzqLFJztEZ7JGiz92qurRoy/21wkGljl?=
 =?iso-8859-1?Q?F4tJ1DzbfOHWiNDxxV/FfyCZthX0a+GSFDEE4a58ijLT5QossVTOqBuCye?=
 =?iso-8859-1?Q?UHP0dKk1KKCo6Klq9BqjcneDvwP3kIxG2WzpG9D5rxgQhQc+AfdtPKtVYB?=
 =?iso-8859-1?Q?OzUBxexY3SH+6QPpgaFb7UP9T9tT47GQRQWrZ+oUJsNUnCEAppaxWwGY+q?=
 =?iso-8859-1?Q?+yaxaQt3YvS0BUcRtx2l6w8+DVqC5GhSJ5IAt68Ww9ZsBIx0+shFTC4uEJ?=
 =?iso-8859-1?Q?Jt/IaEGjbtBfqR4abIJMaIsv2B3ES7euCMyLTb9s7d4kaAJAKzoZDEzMn/?=
 =?iso-8859-1?Q?E38YVA8OKTv9CoBoNOwNozve7yeOscXWTf1WtBG4gOXV1nLubbC4Dn5xf0?=
 =?iso-8859-1?Q?ikSCC14NpnRrb/tFquDdTS+FlHmaScguBqZVk494H8hy+kmxZ4XATXpBwu?=
 =?iso-8859-1?Q?1j1BAFuovSCMIG/i3y6VE7fs7qtVt/BvrZPtR51ESni5dMXUWG7ZjpXhjd?=
 =?iso-8859-1?Q?X6thy6rzRJ71Z0EPOp6QvOPlhfMPPZy+470PaVTU0y0p0DfCtA99JjugOY?=
 =?iso-8859-1?Q?Vq7YyU7rJCFz1OaQo1lQMKcZA3Pna1qWMZZOPuHECF0w592saBFWlFvmTP?=
 =?iso-8859-1?Q?h4KPjDSckmLTQrGcBXVhwOL19z5Of3Vm//5kFMbtnlBDMpVpZ58mZBiFEG?=
 =?iso-8859-1?Q?RXDVWWJ/nmmKgZKf2Y6F+EsiJmUYozB6b3E8R4SfYjf9TaocnwPknG3rBX?=
 =?iso-8859-1?Q?a5pmlkNtP0tJotb/NEI4w1CgEgvvATTSf1DB7PAYKtnkRkVE6Sf8m+oBR5?=
 =?iso-8859-1?Q?bfkcgN/2JFrpFzNj+gvUdvikLFawD0qwprcSIhApL6y7rXB9ceIjUtGRe4?=
 =?iso-8859-1?Q?65OQjD+NxNX4dQSVHp7YYEj1nFANyl5QZvSfVCn2x3xAYyZGhHbErDwWia?=
 =?iso-8859-1?Q?4ga7Lf6MLfs08gKjrWHQjiYFmANlwUXH3YEBT7cNF3GRELFTZAsPDR/UW7?=
 =?iso-8859-1?Q?ys50NWhXOZiJ9d/Cs2Ri2+8wBf7NswlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?dUxB57eq2M62UkFA3V78gkQeI8iT99OT7kc80cMZdYiZeCVZ8/NHkmuMDe?=
 =?iso-8859-1?Q?j3T86uCGY9i0eK3x2i25l5ZDhAfE8Z6cO5hQBUqDKx15u2BuFuYZOWcz8f?=
 =?iso-8859-1?Q?KOxBSrR0eiByyR5f3WZ2tlEyA3M+Oio6xwAfPgIBoem7fWOTK38Ilap+km?=
 =?iso-8859-1?Q?jlypEgswPpohGm4t2lPD+zfJ3bReqMW7IgxPJI1hXjHIGaGUTxRb11DiqO?=
 =?iso-8859-1?Q?C7aNjBzNrf/QS2yILW0ttsrzmsoV00g3WRkGmcg2NBfcrYMfye1NeMkx8t?=
 =?iso-8859-1?Q?WiSm6U2t2JJUxVN8x4X1QOTMGXOWe+Ck3mRfLKBLI/GutgQztDFyV1LXOU?=
 =?iso-8859-1?Q?l6r2D4GjzMnWYX+nEjr7jpaRKJXc5P3w1inEMeaxn+PN1VocayPWLvoANf?=
 =?iso-8859-1?Q?xp5kPCYZmOl+Vj2GDbERqJQi3pDql2rZd2ypoBvTqyj0hZo0NTjR3BQ1aA?=
 =?iso-8859-1?Q?jEJwmtmU2VuZLkcnrmwYjMBjx+Eck/rkVt9eXoqT3sDJ89plZl6Tng2P0i?=
 =?iso-8859-1?Q?nGZCwpkVACESiLr/saDYmBrlSEUsM2crM7HKmT3FgNzOPxLbvPCIlNRFgY?=
 =?iso-8859-1?Q?HChgqjul7TR5+QMRyK8OGc7mQmDhJWCYrTTG9dr1RNvT3LB3hinVlKiEUe?=
 =?iso-8859-1?Q?u4Svvu3S0mI4IiH97nYMB1g7qRl1BSX2QxKt7zWKwBDEntDh5HvPgfLXDB?=
 =?iso-8859-1?Q?U7ZEBlq1obFt6GspX5lNEvYXwucSGtrJn45CUb40aFg20nr2x1a9vkZKO9?=
 =?iso-8859-1?Q?M2mWfmRACoHh8KcHMEy8lX3wvCW9jCZjYoa2m9RA8rBmzdtuh9Bh8ZmCTr?=
 =?iso-8859-1?Q?gQBLNAoL19kHQyxWaEeX4ZRQGkymjsWBbmKafo8yhOkE6BIfdnixhXrvkU?=
 =?iso-8859-1?Q?mNP+swRQUCp17gvVjf3/cht+kw4rD2tMCCr4jPoRx2L+2pZjhHz2yIpLav?=
 =?iso-8859-1?Q?I2/SPcNxeFMBDyX6dVpFziqvO/kacZnLE8uE3Ixv6sxUu8JuE3fksM61T1?=
 =?iso-8859-1?Q?FC3Vzvz5YgliMRMWNV8PSTlvrVY78VCJVOx9OvT8wZYEDvqwNLH3jPVIKH?=
 =?iso-8859-1?Q?kbRBi32S/EZDfCEjBVJM/69hHpIeZnUBCqig47Civ6G1FTT2yrFKjV48N3?=
 =?iso-8859-1?Q?JFKbn7h7OepO4RocrBg3v8sF2LjufdabypYMSf8bkYlhkn7F3xGsei/Rp7?=
 =?iso-8859-1?Q?LY7F8KktzlUHon6O1MmysUYdTZtkxXaCTCxmjGtalXjxy7HiIOb9VPF9TS?=
 =?iso-8859-1?Q?6XkBzCNvmB3Us7GxGHM3Rv3XwObq1Zn4J4eIVJUGGE+2Ul78GjgLj0TTWP?=
 =?iso-8859-1?Q?4+cJmBeuO33/AEgT9lZ8DNn7+m5KYyzSSopZrvRdkyTPTMmDTWeiqiF764?=
 =?iso-8859-1?Q?tc7uTih/KB5ksdWZyCgnFBrGUJrGX/3JRU3nA5rautSrCP01g+AnuLsPVW?=
 =?iso-8859-1?Q?S3RiqMVml9cU1IaS3p4PbZKnrk0zOEFCidmNfV3kGgBfFCowI2hXcyhN72?=
 =?iso-8859-1?Q?8LXhSqJJvRmLkW5E2s3B9Mco3gWVuc6XJFtwkUjve9AbvBWOHVwqsPBQf7?=
 =?iso-8859-1?Q?LEZy4AM4ACqCYpVSL+q0HT5FDCGgTSEj+gA0D+iorj9/LEdqzul3uU7biL?=
 =?iso-8859-1?Q?NHllYr9/YnUgECychR1Lz4fOxQfcwpB9RA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea64ea2e-1020-43bb-66c6-08dd5b379de3
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:14:18.8562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDbV+WVdnRIZHHyc433cQvxmBBzlv5zuI5KRT9DImNsXGD5xielGj4ONu9R3bpoFrt9qbOjVFjHQyOOCKSIdZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11080

From: Florin Leotescu <florin.leotescu@nxp.com>

Introduce yaml schema for Microchip emc2305 pwm fan controller.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
---
 .../bindings/hwmon/microchip,emc2305.yaml     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
new file mode 100644
index 000000000000..cac0075a65bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/microchip,emc2305.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip EMC2305 SMBus compliant PWM fan controller
+
+maintainers:
+  - Michael Shych <michaelsh@nvidia.com>
+
+description: |
+  Microchip EMC2301/2/3/5 pwm controller which supports up
+  to five programmable fan control circuits
+
+properties:
+  compatible:
+    enum:
+      - microchip,emc2301
+      - microchip,emc2302
+      - microchip,emc2303
+      - microchip,emc2305
+
+  reg:
+    maxItems: 1
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
+        emc2301: pwm@2f {
+            compatible = "microchip,emc2301";
+            reg = <0x2f>;
+        };
+    };
-- 
2.34.1


