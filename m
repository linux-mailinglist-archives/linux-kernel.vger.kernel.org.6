Return-Path: <linux-kernel+bounces-526523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C5AA3FFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 936D07AA54E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B01F253339;
	Fri, 21 Feb 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V6MWqgRM"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48402253331;
	Fri, 21 Feb 2025 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166574; cv=fail; b=bMeo4hevL1VIwei72ygEEEicqISo3NDlMKsMcUZqYluu/TlBoY7TVWIOsSvcw/Gve7yMwzx1NlGgItlgwYHEPnFyXet6B6e1IkrJz6gMsBWQ4S11gzXNLOYTPqrd1kjeJkE6ejMbMRFxAoQO4GbfABlNXqE8okIa7M6OVbC90kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166574; c=relaxed/simple;
	bh=1wYvjUKBb+9Gpj6WLj1haezbyvu07OsMpWGClJomKCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R8dl9ujb+DFKYl7YIID7Tq5ZuAoK+Se8p6yCof2a8aGe171WbxCoGjHcaxoaHeAlwtDJzMUq4iHu6UXOUuYRr2s1UVuYN4xfkZuy5s4HOOxghwiIhQFducb+LDH9Im18UTG3KK62LRRhogIIhHczTX1t8/hxdY0vSQdApPyVB74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V6MWqgRM; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oma1Dr95aVh2/TH8fxhAbkKNR8aYKppsju8uJCJrz4dnN27eAzgSiWc5qxt+yULKuHDx1aRcNVIfMf2sbG/MSUkMntiRkbqwD9iOhI/87j8FJe3ZYMmmTyZMb7O+HUJEGhUTWdbiXyAYiSNIRlpICjjhyG8c4bg9xFoTaHDCAq3tBwixTlbu1l328349mV/lPO6+YxeqFp4zH+Rjx+ZuDDX1Xc/eDFz8ln66kAGT8JUERLfa5SaHT24G3kPC3+/lJUvxGZ9tNbL8ZR7k9PDaCDsnJoiWy0DU1koK1Jb6XmM1mhwpWew3czFtyDy+0WN93xN3zRY5pwyap8hh1XOAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkJlu9EeruZBRTKEyJVfROzZNZmzwXdnQPEfm2KYYMk=;
 b=oA/cXkBNg22l1irNsJaYIfyXsTGPVMrngOi95+EjRH8fGuXP1rrfo+ygMKjsZBbfXu6UaKVEyQrkMzBTJ+PX5jvHazI+cA5+V9rY4G/D5MSoSiXoj/amoU0pmLRN5uRZKqJA6KNLmgWL++z0H2MYPlqIai9rDZ0/9GD6GaJvScyHlJcGEi2/V2qdcvDAlcC5OLNJl9H3JnPgdESk7EsUkeVhb9nNm7UF4wLf6v8ZUFazhvNHFEnF+iBVTO/hkVKPctG0Wjqftql/XdP/CphiVYluAZwPRhHTENoobVnUgTH+D55hOGezNyx1+JyMTDGZFwO9ixgrxUpzd5mImv1qrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkJlu9EeruZBRTKEyJVfROzZNZmzwXdnQPEfm2KYYMk=;
 b=V6MWqgRMpzat8x9tOoKDwZ/e+6qn2tTu0VsNCgajigrcez4CnTBaVlABF49RL47YY+VHu8dUgSFcJ2SLXs3iUO4c8uqHPTX06d/c4JlaaSEc9zkdxefmMBw8dC1smTB86kdtS1RiZCCYOZl/QW+nna3heNjXqP5xbb9srXUuQi29lfNztzVoRrVjsVcyJbS4o/v15JQGL4Drp1OfvmgrDX5qK96Z9a8p/4CBZOb61RSDjpLG8BR+y45c9UMa0oHVbeOW3hU5TBvi6i7L28RCa+jFfVVTXPC1FiY/JyNt/Aos9D97PYNvfZbuFt930w9HXBkdyiXnpLPvTD3AegR2Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA3PR04MB11202.eurprd04.prod.outlook.com (2603:10a6:102:4b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 21 Feb
 2025 19:36:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 19:36:08 +0000
Date: Fri, 21 Feb 2025 14:35:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: bus: add documentation for the IMX
 AIPSTZ bridge
Message-ID: <Z7jVnmWoXn4ow9NG@lizhi-Precision-Tower-5810>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-2-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221191909.31874-2-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA3PR04MB11202:EE_
X-MS-Office365-Filtering-Correlation-Id: cb66193f-e685-42aa-6fe7-08dd52aefd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1NDFYuJlgemqFUg7OWxW3e+GpufcpIoFdLw+4ia9p+y2oKrQjNk2Dk6Jx8i?=
 =?us-ascii?Q?VAOJ7nRzxjRdi/9cVq4MHOjn0qfx+8AsuuBg6rIs+i3P6gy7pjrBNOxSCChn?=
 =?us-ascii?Q?iioIRumCHPJG4DDtShPMsFEtMi6peBPZ1Vp5DNe1mXiDMCcE9rtbQqczcaPk?=
 =?us-ascii?Q?VWKqQxwJSu0qSnXIy5sC3rana1KoL9MVC5MDcwGjrlawcflDMB41tCaLZuAX?=
 =?us-ascii?Q?wJ7AUQMi2izhvfU43CM3S1hM8TKsqtEp2PXihSYqHLDBEWdKtIGCj/NMg30j?=
 =?us-ascii?Q?eQERiFYd0MwNlTV1fWzft+Ds6JmAvgFtfJcYd6EOr5diUXpTDrECCDMW95Aa?=
 =?us-ascii?Q?5K2tmGkOsrIu91yoYbNcdSxXr2WSSDK0yccab2IdZGSvnZkQWT+jDrWFYpqT?=
 =?us-ascii?Q?itd7tDwKql6hNDqDAXUEaYipULaJu8J2zPM66IDBvducpebnpEokUCy6/Yol?=
 =?us-ascii?Q?1qA1ldaOAtYURBtPWNfm5D61YFdtR5Ku+hkTjSJpPzCIOXccHn3TAEiwFwx4?=
 =?us-ascii?Q?UtJszjlsOyJv9+XnlkmOw10g8pX3GamwAFtbf4SDbaFD26UcLsvfo/pR36XS?=
 =?us-ascii?Q?iEJJZS4o44uhjGvPVnmuto2vwWtcyKIs1QueY6icqKlShYg3UA4Rz4mpaESH?=
 =?us-ascii?Q?0AaWL/G6/A5ZuHL/SNlVsEtX7zu0RSRXxyMXuHlfyRnQ3RsMnURA5wNn/f8r?=
 =?us-ascii?Q?MbdgQBW6tH/cD3CrF99ypLNCNvhIQI5TMsauBxZhZlDiGDACiUleGlniRqYU?=
 =?us-ascii?Q?q/EM3NyL5teorvSiHxS4vyQ82kKCdY785oBWCFR1APcR8OwPodKpyFMHda3H?=
 =?us-ascii?Q?c33ceKzx32/AQGy/hP8wem4JCeo0VXxTjWixNKvCT9UkG2mw3Zb12G1b3Qs2?=
 =?us-ascii?Q?a3J1NbUKwk5jb1Gx77BEn9OPNy0Evgfi2j3GNtxZXjdE7sK7CKbRI6FP9fo6?=
 =?us-ascii?Q?PemI6jZK71bxipKYkDLre0tq2hB+KNdSM4F6rPAb8cUveQx/sZ0Rax5joRBw?=
 =?us-ascii?Q?C/MSTxe4JPwYz/Wrjj4AyJDca5bJeSrAKmuhGniUC8z578htt649qoIYnrIg?=
 =?us-ascii?Q?rqvTJBtBr4PtdGAznAKXc87k0v4Rv1vIbhH/tDpk5mstSNZlHGUw4hthaw0i?=
 =?us-ascii?Q?/dVHfKww67S4ts+aiGTTRj1uJn7hjI6odpalGg3DLl04xZrClzy2dwBmq2TG?=
 =?us-ascii?Q?PFxGOSLFN4PK231R5NSAh0a6gOWSpp+DYXngiY7CAwjrofeTPOflj+g3u6Y8?=
 =?us-ascii?Q?XGi7TDo4VAiVjcjn6dhbnj7bx8atu9CcXvEDSn0YXuobLrL7GteTHYQxnMNn?=
 =?us-ascii?Q?X3kuy/idcXICurbsuU+sBZ2pwyYWCzg7WbCTZfL02BTpE5dsUnKuV6F5cEl0?=
 =?us-ascii?Q?Wcxv00TwMz5m4X8fK35zcap2VVax?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tvy7hJgsCDjQFgio5UDwvxeZmoHLwczcHiCQT1cdbkxdQ/uf+gj2pnRDjXiW?=
 =?us-ascii?Q?lfPlsImKf39ktjj8jt9xZmKc2ZYorhJ95v15pzrdkEeMxhSUVyMI8Gb7lPZo?=
 =?us-ascii?Q?AS/CaDf5ropGWT4PNecyvNB38SCE2F1c1g9S5oaYQ4sLhkPv+pgKe3FXAbHb?=
 =?us-ascii?Q?yCBqCnXBhGAcUsrI4gSHe3Lc14b8j9n40jfwZhIBHgqg2nWmjmkeesaXnknj?=
 =?us-ascii?Q?l6q79ouuDnrE5uRbqpfNDtv2StIf6lP5ncXUdfuMQqudmhQD+Cv3QcsbmetH?=
 =?us-ascii?Q?8l6T0gPMWP9trsjYlD2cUBpMDZCcrpJWRLjouzGw2+yp6nhflzbsDzuQktq1?=
 =?us-ascii?Q?1Yg3DEhdwOH3l1tbpoB2oFDBmD5gm5vKxdt/idSYkeX9hqef2BTNRDfTqR5c?=
 =?us-ascii?Q?LcRYzYykmINWEdUrPqLkqoxRz+85FLJ9egZmFJfMdFq3eWumQb1X89wdgGWj?=
 =?us-ascii?Q?LyaXWY4CzIBYLUgOEFLX9P1XHi3Aws+gyKJgy00CxT+mx3TY+O7It8BwUKxc?=
 =?us-ascii?Q?AnKQ5t+GyYb//ORfHYOBLrd8+XuwViDLhmiz4ZP7oulMPpCHG/KNBo8fj3tZ?=
 =?us-ascii?Q?hagHNoDUOiOm0bSc6oi5YwyjF7DcS6TLUWSZdtNYgkoazF6i5lJ0U6R4otL/?=
 =?us-ascii?Q?80XvXM3s91btt1HvBRD0kozkhi14S/MES73MfbnFPnazJUG1jwWiOaLzCiLz?=
 =?us-ascii?Q?JYR0RvH2968QsCY7XgfAz75hCePF7ziQ04hto8QGKhY0KTjO1LkSuCs/4Fb5?=
 =?us-ascii?Q?5CKNaBb70JiplX3C3H6n1FxxxWM1cIbRapC0CwyUhCB1xkS4b4F0FOhYP6mV?=
 =?us-ascii?Q?C23ql+h+881qLSSYWIYgLSi3S8FAhm1rN53OUzEBhPPkuQS/pSdb/SV5m0r+?=
 =?us-ascii?Q?mpLLsCWGGijrphJeTd9rbljaCbTDnnTBKP6Wvp7d77sqSdAC7f6/0jmNYXPw?=
 =?us-ascii?Q?cPHve1GzoUx9qDq7uM719xs1zX8vl/GC7bQqSTm0YV0Nu6mc9d82b/0xpKu4?=
 =?us-ascii?Q?KCJWWE3hyM8P2P3Ekl1wEdAa+cdQnfIUJyCgZ3RAqZD9ODYQSPQsFyAk9Ybg?=
 =?us-ascii?Q?6kXC8lLUJpNPjzHSiF9uwXhxt6N4rEvGkbPPDjpL2hhNWVRZlWqwlr5kpHn1?=
 =?us-ascii?Q?utKPIxtp5Us/Vcqg6Uo3GP6+c8AZMmVIYYQyEDIEpvi2MoPvJm7ufVc3ACDw?=
 =?us-ascii?Q?KwflOljfMXL8EwR5oqnHZNhVvB5qGvEx7kfrCICEpkA++9FlReROikPDY36O?=
 =?us-ascii?Q?u85Mf9rWWsDlIvEKE5OswlHXphbMYqFySfigrQT6ddygyT0a15fwaSb4O0wO?=
 =?us-ascii?Q?vi76TIA4nUfmD8zcWHZgiFRB3xT7EaqtaDIRLfTMpv6JY4qZCzrmLes4VupC?=
 =?us-ascii?Q?LZwXNsmO2dQVxnQ4LmItZAv129M2/QSnKfMha2LIAMZJ5qQTTTAe+8fL/+Cx?=
 =?us-ascii?Q?dpemPJuq7SEhsIOQq1C/OXrNeBNkgcPnYyF18pISRSSKmeRiWUgT+s7nFtF/?=
 =?us-ascii?Q?EUdlhkn0HQvrs7tQqiVxCUZUPLoTJFrehOvha7oMteww4d9t+kB3Iuj7dF2M?=
 =?us-ascii?Q?gzNqrKKjkg0duDEGKtc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb66193f-e685-42aa-6fe7-08dd52aefd15
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 19:36:08.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlD23Tb5SsMwIJN/Z41AJ3Bfah7l0tz1Yfkm95DSrshk9ml+Vs9OBGq+p9Rq6CgcGV+ZhtQBPg3xqecyxl81iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11202

On Fri, Feb 21, 2025 at 02:19:05PM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add documentation for IMX AIPSTZ bridge.
>
> Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../bindings/bus/fsl,imx8mp-aipstz.yaml       | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
>
> diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
> new file mode 100644
> index 000000000000..b0d6eaf70a84
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,imx8mp-aipstz.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/fsl,imx8mp-aipstz.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Secure AHB to IP Slave bus (AIPSTZ) bridge
> +
> +description:
> +  The secure AIPS bridge (AIPSTZ) acts as a bridge for AHB masters
> +  issuing transactions to IP Slave peripherals. Additionally, this module
> +  offers access control configurations meant to restrict which peripherals
> +  a master can access.
> +
> +maintainers:
> +  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: fsl,imx8mp-aipstz
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fsl,imx8mp-aipstz
> +      - const: simple-bus
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  "#access-controller-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - "#access-controller-cells"
> +
> +allOf:
> +  - $ref: /schemas/simple-bus.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    bus@30df0000 {
> +      compatible = "fsl,imx8mp-aipstz", "simple-bus";
> +      reg = <0x30df0000 0x10000>;
> +      power-domains = <&pgc_audio>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      #access-controller-cells = <0>;
> +      ranges;
> +    };
> --
> 2.34.1
>

