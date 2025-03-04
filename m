Return-Path: <linux-kernel+bounces-544956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DA7A4E8FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA898852D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E404294EF0;
	Tue,  4 Mar 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="blvSa8Jf"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18D2862AB;
	Tue,  4 Mar 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105642; cv=fail; b=GitMGgyq3k+llb6VorlzXV/YL2n7vBCJxydE1t7VM+FernONXpTgGJNoOUd6eqrN8YpZQYwB9n/nmt+Cr2fh/VcGStYPmEu2p8VuJBn5Xf4ZS6Rfue1AGs/Z75NJIbvZeFucYbAr0LuwM9bnH/NByptbucdXCl9LAcZBKuYToP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105642; c=relaxed/simple;
	bh=k7xbUlloyPo2RtxNyB4XcwOYKMrzEtIzYPVyKX0R9PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dXNCldb7H/PZrDheetLFG4YExLr9wY7LpS/EYTrKHwYfEL7en+bvRmDzsNoYvLYfhYewOSPwtYaZSPiaffHFX3NYs9HUTxHGadGbHyUS1fyMHsOL+RRiACzC7S4YTDr6YUHP9ODalhamt/rMhELIKduAV0sPbna9oA8LnC1ik4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=blvSa8Jf; arc=fail smtp.client-ip=40.107.105.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EB3ImQO1WvNzNAwrJfhCIfhS0l57WnXyrnfASinPbTFMaurgINo2WIPzlRq0JV7ZELfr/C3NwyYPzAuD19gWgzdFrzp48tEeV6Piayp/c3fHggKaX8E8oP8OdoDrhjk4/PxlqjCj20sjocyiBVI7/waoDfRuQheHoy85yU0ZyX1SS01JPJNklnyauj4RwRJUEJcRWcn5oBelcJpO3agqNKBcBK0dCKv0R6OdxhDuLKqnO3Bb2oqjWri70uAGLjFLpmIP0fJCMZJlIdVTKWpR6tPLys67Yral+yZUuRl1bBwChMSM6qFD8Lc6b9IhIEOJPjPt5Z/k2PHz04zjNNg0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckT05wTEhij0B0lX37U9ibmcidSITwwtmI+6Om0aMyQ=;
 b=KjuR+Wn5MCflEuSmk3CK/Cw+UV1dVhw2F8xQSWJjGcczrhx48sn1JbmlLzO3d+X6bIv4WuNRjejBs9WlotA8Ad3F2IL1gS5DsMXq4fAPoTcB2a6y/YPur3zwAMXb0WZFBQH5S3Zrb5m+nB8GRfHI8NnQrJBNDiqMg9YlP5KqwX+7I4AEFHqPTWI9XEPF47AcfYgOiBzEWJTeVcEb9PP/c2891ZNuOTeEI7NpZa5ll83B7GbhZNdbQqQkXp7BsOsFqAJMtaYX/x92KNMLK+SekrKvyyh3EQgKw2QnsdZt1ytqmb5Fw6NC3dZVYVMASpzvaQhR/QfPJzRR6RSpwiOwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckT05wTEhij0B0lX37U9ibmcidSITwwtmI+6Om0aMyQ=;
 b=blvSa8Jf6+ogGu468QlIJV86RyM5cxPPLWD/Q132gwim69igsI73Wj3z36t6kf6JyHfu8zkgeWZHq/BhO3fZVkcZu7mCxzYnIXyLHZThis+zsQX6YCOWrn5zQkPIyA8uZ1Cf8dD83fHDnucRiFTIxLmt/9ezS0p6ckSF6wiqjixKZm7QIttF8AVsQZysLP9UeVhVk8Pv8Z9nk4YwaDGflf/g8drSauWY/yRnuOCyA3OKomlpTgXCiefFNx6YRgZ5plYlApwXJMVjED/qJ10JIXpTkr/L14A7DG0Yc0yQz9QDF5wCqbAU8k1qAqJuzaKl1yyCNANqobgla/0c4nnDRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU7PR04MB11137.eurprd04.prod.outlook.com (2603:10a6:10:5b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Mar
 2025 16:27:17 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:27:17 +0000
Date: Tue, 4 Mar 2025 11:27:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: florin.leotescu@oss.nxp.com
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	viorel.suman@nxp.com, carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	festevam@gmail.com, Florin Leotescu <florin.leotescu@nxp.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Microchip emc2305 yaml
 schema
Message-ID: <Z8cp1xoIXT8lgD8T@lizhi-Precision-Tower-5810>
References: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
 <20250304162136.1963384-2-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304162136.1963384-2-florin.leotescu@oss.nxp.com>
X-ClientProxiedBy: BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU7PR04MB11137:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ffe4ae-463f-4466-f835-08dd5b396db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wHsKxBIogj2E3rt2DAHtUNy/3yfvHgsMCxlLgZnkjdE7wgDXSSE1xTC4nHhC?=
 =?us-ascii?Q?BSEwK64ZtL+ugQOKCJaWDhkKVOXWsLrzkPTbG4/ZojHRqfotMoUqQkLwXhNg?=
 =?us-ascii?Q?DqiAtsogkKDALhr0aiCpGDcMyhx4iN18TPTbPUkObtKebAmmH77kiw3k495k?=
 =?us-ascii?Q?+UvYaMKqOvhXxOF95yA65ppabOlnqtsf+XQ+itFM5tho25PVJMPqdJM5TDsX?=
 =?us-ascii?Q?4eQCeotqhIEdWGDqbYhTSJ+TX3m5v7byx+7uu1GHKt6z76gpj4UlumJ2SMff?=
 =?us-ascii?Q?lYUEpC7btfbROvsZD5u0JtqUIzAkT/5sPaJlK5hDUh1fIZuBT6S0LbjTHt7i?=
 =?us-ascii?Q?pTmaJkgojORM3afCL/gcv1XA8jEVn0MrigmV1kBf11VcvnyIcvbe0GOdm5g1?=
 =?us-ascii?Q?3A8lP9+RghpYn4kvKPCeMQEvNNOemDaCjIhijaojtcLls10m7F6SR7mds5Dl?=
 =?us-ascii?Q?HmuTsOZzEausj3pLuCBNKgc4SZ2Ggzr21e+xd/sF+J0BY/J7w/IYAOxIkmvE?=
 =?us-ascii?Q?kCw/++Yt9xrVDDV655YSmIYOSjG+pR4Z3tdh2sEjc2ctGhARrC1pTdtxBskP?=
 =?us-ascii?Q?ro/Qs+PU9WfXL9oCFfwkaeIIGPcUb5G07Wd6d3usWZNxU6R0tl06lehs4C6A?=
 =?us-ascii?Q?iRz/pn0Dxws3BObVXAzGw4iCDJ0RYeCmg5Ousv8gWaQDIko4giA76+j7PejU?=
 =?us-ascii?Q?5DPvJBKlITx6Dphbv2r9NfR38SnS7txXqgwKPCa/lTkvuTu5eu5Fp6/VmeBC?=
 =?us-ascii?Q?Xqbc4RcxlDH8qtsjeWIOSidrnlrcBycJywzkCproKnrXyAN8v4p9ivfQaxUY?=
 =?us-ascii?Q?t+hXlSXveJzY35+AG8q4ljvWOl2Qv0Xv28Ik1MppQOPYGj/vgAOZMc6AN78G?=
 =?us-ascii?Q?oUmFS9gCGSoBoCF9/WtPob7Ddnfqrjl8ir6EWx7hN5eqno1Dwc8Kw2x4KKTS?=
 =?us-ascii?Q?SW49pwfTNAkHlnHu7gKj+VBUXJi5u7hpoG5CIy7OI9IK+ClK5ZRlEzt2VAIv?=
 =?us-ascii?Q?7WF6fDwF98vF/AoyHH7xbIs19nkXkUUsptk2UVriObgrtjGnpiPgjT+B8lim?=
 =?us-ascii?Q?20ifQyFY5y3f+c1p5z9HDH9257A9GlqDaB4L2iQdYqwem63n/Y1WjjGoqVhW?=
 =?us-ascii?Q?z1rNKrgvFXxqyJzuwmUPsVNqNnxUgHutkuVBfL4zDK90d2hzirHhAbNToL38?=
 =?us-ascii?Q?O2bSvIKTDmgBaMZncXfI6mBw0/lbNnr6jFyFb50JHEfQBTyu1rHDz8Dpm5Ws?=
 =?us-ascii?Q?/s1/6fgysxI6chwObmJS5A14POZO2eyGMIICnk0i+gVehXvUJjTgDwubxrTa?=
 =?us-ascii?Q?0KieFKSOnYJWF6CZyR8K7097zJtAG9DPJZbQtQVCRtALmPrIveq3JQN21jyj?=
 =?us-ascii?Q?N26VvJUjYH9Bw04FJsKN73x1DQju?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHW59JKoVe/N/ZHgXO7W5g5o4E3G5Gx+CEoLlOGbw6MysWJ1vTrUdyYWB/+9?=
 =?us-ascii?Q?qaigKdy4wtyj3Fe98kXVBre/oGDp3vDl01BIG1lIyF0/xb0m9xTlQgncUiL6?=
 =?us-ascii?Q?ohq1nuhVwUjPmVjYj8ZBQQ9LbeA++RtSHUcHZG4ZPYSRJDa/2MPG2K2h9MWt?=
 =?us-ascii?Q?gXVwiK7U/A3MUwxfNWWRoiLTZwWOIC1vctYuwR/r8fR1L2S0kiJ+jjyCT1DS?=
 =?us-ascii?Q?znGzEBTiO6G4Ra/A9kNLBwrrc8SIM5ta+p5GiEzLit1B0Xyjw01n1TUX7cca?=
 =?us-ascii?Q?ZTNwNVpC36aFo43ZNcKKbBNu+KWYlUaZbWNx7xCDrcJ2sCpxfRuEKP/K+cZB?=
 =?us-ascii?Q?l5yeKXt9CocXgkIffvbeqp/18+JAC/WdDt7mdl40k6RT2/L4RhX4Wdur143f?=
 =?us-ascii?Q?HRbxdv2V5il98mvVqEWItmdm220GtYqsveJa+yhaVKp0xROdf6PPUBK1sU9k?=
 =?us-ascii?Q?Udklxplg33U7grZk9u8eS/Pr2HC52divBj97KsYblK/enO+5pxmtvIPNMf+0?=
 =?us-ascii?Q?xYwIY+agudKzNQX50A/RfpKRw5LWUPU1OTdTegCC94iF5umnzoOqXG6aFnzD?=
 =?us-ascii?Q?MYmJnWqevuiq5ZV4Wy+2X6pEZ73Z0yxh9uCBZxCiScxMDCmY+39lbRGq+54M?=
 =?us-ascii?Q?KUCeFQTzBVvmS/uV5drpTCw84iZPSIthFt947mbso38vTyDPCJoPi+gC2P+4?=
 =?us-ascii?Q?XKYRrnfAYhqEvvXDIZz0rpzL1l1ZgKJILxqhN7a+SHYkf3J2cRQSUDLJVmgW?=
 =?us-ascii?Q?Inx6x//AC+gcstLst9mwtMd236adpetBOpAnR4zQHqz0wJ92Vpx84kkbPUth?=
 =?us-ascii?Q?yJWDmVyycqqazEDQsxYf6YSaLVuGuvKvXFYBxg+Ofec/Sl/H6wgCt41vW8Xn?=
 =?us-ascii?Q?TRJamov1GM08T1Ay5YFIZdqnQDht5jmTDwI7SSbLwLKZle2AJ7TQbn+RSsc6?=
 =?us-ascii?Q?loaIBOEONeLXDJVGkBBudiDebKFHHt+BBg7NWxvsMbnTqCpFhLMNiCmhv4Bg?=
 =?us-ascii?Q?x2yvJz80nHR3qYTkQYjIJF+nftRz8w+ryYfSJkKEnphYr4mYcSMBeVWgyEAD?=
 =?us-ascii?Q?gnnjPioehY7twBZUDg16fPTayCJIHyXXGPAsHd9lc2/MJmUWYvR9/ydpMkiN?=
 =?us-ascii?Q?uKUHjm3w/SxYNG5sEzXNmnQu0r7JWXq3i9oXk+QD3DDBz2aGb8szm7Wpv7k+?=
 =?us-ascii?Q?PdeTHO6JsNz2xaECUEkuS8lgWEABx5A4TVSyN82l2K9AqNdtme3ZRHthxU+N?=
 =?us-ascii?Q?AIx/Q0kZZ9U6ZHvJX8xVXozxGPwy9OoA4piDMAWMJX7gsadDN83epQLvalB6?=
 =?us-ascii?Q?EP8OPCulUfeQdxO0rifCSDs6nMKBMWwhAXw9AX1BAxnTOu1yAzLkgemuM/us?=
 =?us-ascii?Q?mKjgbd+UBsexBdEflA4uhymhYirzqGdfk8K+e1qX09i6gNTnnilD+jLeLGmD?=
 =?us-ascii?Q?mHUjZ5JfWvThryHKAXYmhzLE8yIgtlxerdwIrbKsYDulA7DdsEF8iWieIyG5?=
 =?us-ascii?Q?7cecvfWUGxtPbqLoe0KmW5v7I1wh98hqmubnpv4CHMuHcUqnbIAfoV0Ki7ST?=
 =?us-ascii?Q?YzfgYhQdeiLrGQogaF+DI4pNKOSBb/AG6aOtwHOD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ffe4ae-463f-4466-f835-08dd5b396db4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:27:17.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THCRa4PIPDrYR9il8vtHaz6jWeTK28enqJT2cNRvy9Mc9mnT64M1IxiH/pZkg4k1AdBGj883DI0BTSL/uG74gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11137

On Tue, Mar 04, 2025 at 06:21:34PM +0200, florin.leotescu@oss.nxp.com wrote:
> From: Florin Leotescu <florin.leotescu@nxp.com>
>
> Introduce yaml schema for Microchip emc2305 pwm fan controller.
>
> Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
> ---
>  .../bindings/hwmon/microchip,emc2305.yaml     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
>
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> new file mode 100644
> index 000000000000..cac0075a65bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/microchip,emc2305.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip EMC2305 SMBus compliant PWM fan controller
> +
> +maintainers:
> +  - Michael Shych <michaelsh@nvidia.com>

who is it? look like not Microchip and hwmon maintainer.

> +
> +description: |

Needn't |

> +  Microchip EMC2301/2/3/5 pwm controller which supports up
> +  to five programmable fan control circuits
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,emc2301
> +      - microchip,emc2302
> +      - microchip,emc2303
> +      - microchip,emc2305

According to your driver code look like all compatible with microchip,emc2301

oneOf:
  - enum:
      - microchip,emc2301
  - items:
      - enum:
          - microchip,emc2302
          - microchip,emc2303
          - microchip,emc2305
      - const: microchip,emc2301

So your driver just need one "microchip,emc2301" compatible string.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        emc2301: pwm@2f {
> +            compatible = "microchip,emc2301";
> +            reg = <0x2f>;

If only one reg:
You can go through trivial-devices.yaml

Frank

> +        };
> +    };
> --
> 2.34.1
>

