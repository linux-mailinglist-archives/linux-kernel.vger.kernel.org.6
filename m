Return-Path: <linux-kernel+bounces-522521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AA1A3CB60
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CED3A9884
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3B257431;
	Wed, 19 Feb 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SFYT4QZg"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF54F25742B;
	Wed, 19 Feb 2025 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000431; cv=fail; b=cjUgd9oHm3D47tfjZsvgSwOLF44Fy1OHyrjH+mF2E0V8qWyxTsQN/RcaX9RDJpldBz9QBE998ic1m/mn/LJaY2xQM/yaD8RyCaJbEFvPKdMAwI2XyHII+LBL+cy1Av9k3RInebazJFv+IBPt53/6e+lvrkeAgB8fyqgrUGkNIoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000431; c=relaxed/simple;
	bh=Uai6BlCZZisjTMORyM279ijKY9QAlq/Fvm6HGBjOzZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iK3n+qTzIx/v2eh4DsFQD0aQm7NfodS7TZu9O/WHaDKvZSQHtqrlv3ubBym5aIzJH/7iXnJ18xZeNvP31rV+K5tvxqaXQhfCdvoQpkMo66eVrJJ8QGQx/tPFqUj/r3qzmNVbDoeVap3nIZxXJ+Fzg1wCjqXYDW+zrElxk7tkPlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SFYT4QZg; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYwYeWJ7a7Pur642QggzywBQ3rrmIsd1R02LEQxRAg9cPoOh9YorGc07Ydg5u5i7Aqq8j6sBX9s1Q/43lNF5xDSc030MMS69HUjUCivs/509x+Qy5sPKE8cjZl5CRbbPzAQrKW73NivhAG27vdmU/QhAOghy5a3Zo2ENcce6+qryL59Xsya06OIS8sgti0DscHOXDuzru+7qyGU1b9giR3Bi1vI3tvhIadCK1eeZgbwmlT9Z34Tzocv6YSwJzVc1UyOhIkOpI+cOsMNPmiRBh4n1tXnT5f15x/e2Lg996NJq8+7+TP6oMB0oe9uzsCbV0zmgzBqUk3I0lyGGnRPPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLi2pkRJeHrMVChvA9ZCQ4miozJNOxM8/zxUrhjkLA4=;
 b=JSwUYJ6jE8R0CdWy/rJ22/lRTUHHbOg3EbMx/8LFflS/7yAYV+fH1KX3km6nkLagD3khJJXDc9QDfBFGZLCwxz4p200fuMx/TdBRrTFqZaUYnyC8/9lO5KAi3z/5DVb8vjVsOzi225F80gQghmtt1LBjS8C4J739/T7arAU0DEMHdncoNktMo1cN3MBZWDP7IJAyIYFbqJr/m58Mv0ga4rq7nJ12mS7KgRtq31OiUANCtFKXoKTrUHT00b/4V7n5YTTI/vXtrP0iMyrEoagRy0HtSHbICk85uT0laA0PzpAHp0g7B8YFkOBAZ1Mo9dcmmEyok0nOXbnHR2rubF0g8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLi2pkRJeHrMVChvA9ZCQ4miozJNOxM8/zxUrhjkLA4=;
 b=SFYT4QZgXCQpyMs8dU5o1dnP8cgvoWgjB45KGSZFkIhx+tA2RacPSWG8Yy81kB7cN0/XkJhmcwOE+9H1tYlWnQMZRJCeRCAdd4e7DoP8/gLd/rkXvyzxMWwN7c0xEB915YvksS8V0xb9o9291TIC9/Yth1lrmayiplUI+uC9kce62VHBz9BH0xRn5+qfB0PKntV/hHALDgat6T7K+49/ya5+L7aFamorqg43kmHJmlgXqVzpkkuhvfOx4+69uxBiMfs/vfzq55XVIsakKVuzRdjt4G6Z4tuP2eQXkccTtW1yHPc3hnuEuoWWzdUKS+B7WE8Di7agUhceL1pYL/jKjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 21:27:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:27:06 +0000
Date: Wed, 19 Feb 2025 16:26:57 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: p.zabel@pengutronix.de, robh@kernel.org, shawnguo@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org, shengjiu.wang@nxp.com, peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Subject: Re: [PATCH v2 2/8] dt-bindings: dsp: fsl,dsp: Add resets property
Message-ID: <Z7ZMoReqEGcSManv@lizhi-Precision-Tower-5810>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-3-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219192102.423850-3-daniel.baluta@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eca4ca8-c58e-4cd7-771d-08dd512c28c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ykHMPXWIvdSHDNgOtt1Onktl2N4YBrPDDWYErkWmYegfIOoVgTBHAKQvNkMc?=
 =?us-ascii?Q?aiFsergmZjAsYBCq7zYvZf6zz9Y5x63XPz1K004FeBNSorx0dRT5uXKAK5pW?=
 =?us-ascii?Q?4oSva5LCiaxc5XwCgBveMa/jpYWG9ms/1mpcx4j3qOu7mEWbBDgC9sE5RMIe?=
 =?us-ascii?Q?kxIDzW9qkiHd94ImrCjmkmOInQjxRaP52M8KIr8yWOXD4TKfjy3e375yGWce?=
 =?us-ascii?Q?oWlHaHLY1gug9JLwd19H7+1wCe7RNIjgU2UnadjSVQMK8fhtACMqj5cJ7ol8?=
 =?us-ascii?Q?Cwy2Rg2UXwLjMWD5aefb4srdpuTHA825dE6J6B937ElC9gojIjbrgZOVJ3NK?=
 =?us-ascii?Q?ld823L7hw9UdqmHVCdUCkX5BHqBUxlUiZvH8SRIjx3lfUaCUNHx0z8hiVK9f?=
 =?us-ascii?Q?WT4NFld3ARtIILHu4ymGOIaTf7gzlN8StA6rDISGGj6S4Ma5iNPB6ONcgYg5?=
 =?us-ascii?Q?QsoXJQErYvilUUqX2l9SE/TXKs4I/dnWHOYNYS+/5BhwLRF05JEIAAWABWYB?=
 =?us-ascii?Q?hJHCn+sgM+0QOaz7sqsBuFQ4QMZnL7Zu56bpulHb82hf/Fk7DU7C1MCIoyeJ?=
 =?us-ascii?Q?I86YN5SWfE2Icg7EeDvBEXjkgmb2Zm2nXg48qxBTmZ8COZIFO3z9Th/Z/mfc?=
 =?us-ascii?Q?Htow+Ae9LOWn/nUjkYJB0l8la4dj4im5wIsn5T2IfNH9kgyUY2pp+Af+07gx?=
 =?us-ascii?Q?nUMMHl7wAcrFKAXexGCshRmNGqkd/gCqrqxP727QROBa8z6KAU5tWKbidpYP?=
 =?us-ascii?Q?x7yM+x6ophnM8GcUnjQE5JrbbEH/wpk0Do5vt9s23mbkEqwmO5ByVz+7gQOS?=
 =?us-ascii?Q?/T2Hr4JPJDxnXQOaiaHVp4NNlcbxIzkyFHhARCvRPKCwQJmWtS+Z4LC6qflX?=
 =?us-ascii?Q?tNOAaZB1fpeyn76ZEtXyE14jXkEMt21k6YA0gjNRGhMDTUkylHiuTtlVHorH?=
 =?us-ascii?Q?WoF+yMHnALFrNHr8461whAs8zK1OaYcyPn3sdo2MvxHlm8AZSwK9cZxINVyo?=
 =?us-ascii?Q?Xizjq6S0i9gyxLKknhKxUtRxbZHBnp/mDxJb+dqoigaNzds2GxoZ6XXaqmUY?=
 =?us-ascii?Q?9vEK5qZB8jiPKaPmJfBhvAwuCwgqaTv0vZLOBqQu/c7XAK08Ml61AFYSVJnH?=
 =?us-ascii?Q?5yIx24qaijj65XjHGlKfOI0zHLbdqpn1Xfxwm1ynkzo75iHkIQ+3NAZgGZZC?=
 =?us-ascii?Q?B7Csk3VKMVriQB5ZpQZRtGZO7R/d7cqPuU1N0wHgLRJDaeEf8X3gU8Y3PDNs?=
 =?us-ascii?Q?+O2FaaEugmmq9SsQyBXdFZM4YWtIhjB4DlwV3CCBiBCCSx7MNFPCNVeV0sR3?=
 =?us-ascii?Q?10uvDko7bWvNcLpwYEZKiwt2CicggQkSLxutERy0coTX1TCT0illJy6RyHNd?=
 =?us-ascii?Q?uBDfHcbntrWyeUnj6sjusNW2znu3tG1kvp4nNTxO0ufGGGoF4FAwlBPLBLku?=
 =?us-ascii?Q?wdTjOuTWHxo8GGMnEzMfDNexeMCH6NC6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xR/an9ECzA7h0o4q3syltBpj6/gqR/cww7Ofl32kKJLZViGcQjcqlbpIqQiR?=
 =?us-ascii?Q?9GLFvgBgEPo1SJDF04Wd+t1+/XcQVOVQtjx6JO0KA35uuTJ4h9G/BhYb/cs6?=
 =?us-ascii?Q?uL9XfOKl6lYI4DkOs9YyrCej/alMr7RYCV/nBtQBrlQ0rbm8TERWOmQyVn/s?=
 =?us-ascii?Q?boKzDANNFzsCz3JB1yG/KaiCfQg1coxSbS/SEL4zO8O3S3qkbHdkLYI+v480?=
 =?us-ascii?Q?Jtrd1SMGCDDwp32KB5qRVflwJYmziioaF+UFhrdXncD3JgFAGzg2ceJW7YSQ?=
 =?us-ascii?Q?E0nuek1EbM6dwTetN12nYuiOpRzq3NXB/kCo/ojPiU+j4y/O50yjhjpdm0LV?=
 =?us-ascii?Q?81tTI1vO1+7gaPaDX0TBhmes9Pxp2PcH1lg6jZ8xVWmjO6zb/jCCOiLf1xtU?=
 =?us-ascii?Q?J42BmFLqEId1puAHZPbFRGvA9kbD35HlkUnu8wCuvoRSuoK4Dcu1d+fXHvwX?=
 =?us-ascii?Q?LZt8+cKMebska9lTBSaSJ1RB98YnqoSH8aNj98BEN/MGEPcPw5yxJE5RfIrD?=
 =?us-ascii?Q?hkSUsTA9hEkVL07R1Qt39I1agNnPkiTwrHM2rHhoNiGvy7pbU85prDNzUifA?=
 =?us-ascii?Q?FrNj6kdmz5Xlba2UbIZ1p+IvRAXvbP1g6UGS7We+/rdqxTFTC94idzseI/2v?=
 =?us-ascii?Q?aptn402Tp8yx5ju5LaZOEZ7G1eiTdMUWZvAmNlGiS+2skCV2xBwd6ot0eqyl?=
 =?us-ascii?Q?RZpsbi8bWUt2EniUSF/jwT2rPHVjuh4+FqRsnbvkW9g+mWsDz7oO0ce3tBtK?=
 =?us-ascii?Q?fp/74PLqzyfQXNSRoXJDRbi4U8RJKnimZ26HxtZsqQD3WP7EaYVJrhIE5kvc?=
 =?us-ascii?Q?EJ44x68Q5ohnSglk2/YHAGdSAY+lLWYJJAFrhL3rwVM//X3VcetUk3iLlg4s?=
 =?us-ascii?Q?qQfIdP5mDcRGOcjXRhRtSZVATvmVhOvmtxozsJ7VgL/ev1/kEcmHuaxH1dqM?=
 =?us-ascii?Q?yqcT0/0a9KIL3QXsEQdwZdMRigC57iKOoKOVOzchhqqa8CdLwFrdwZtwYw5o?=
 =?us-ascii?Q?zUFFNy5yYIhLeBgyTpk3mCmRWBOOpagG0cMgz+t4YeksCdkkT7t+5F7B63Cf?=
 =?us-ascii?Q?zaK38eqj2tsvmU/FBFkFhw9l8aV8U5sKSwDww8qs8tbXOrGU08jKWRl8QvzD?=
 =?us-ascii?Q?xgBSsUcpB0kz1yIrvHFWRpFR1Bu02biZ4ZAOzdlOwNvhZ4ml0VOejNGcYzcw?=
 =?us-ascii?Q?69xQf//AQYelIAynsgyN5e22xfcioV3kOYttQKuPZsrWtIS4kG8vkvLaU+Eb?=
 =?us-ascii?Q?kGdYJTIKmDV/lBXOCW2i65zlMq/S6HvrTEZPTsFrNsIR5g+Ie88zuBEMmtgh?=
 =?us-ascii?Q?jc+afshfkz5AlHi98xq7f/zczoGwGAjEylwRDWkocSfz3NKaCnUySlZJsgEz?=
 =?us-ascii?Q?O9aYxRGfPX3u01tvBN1K6LNb8dITnLOND4fO+L9kNtCxOuC0lqejNPOv2AB4?=
 =?us-ascii?Q?j5WMCPhZvIuczypHxrOKnCvOqWxFZveSv12eZ/46V92+/xr1CdsvKJx2YXsD?=
 =?us-ascii?Q?fZMVkNbcyxiq4+940l8l8aRhzc5FoT1Elp2v/IXIWhH3QIElqtYnlMqABaX7?=
 =?us-ascii?Q?dtpiPVGT6auQH66oRZneKntxd8icYimoYQTksEMy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eca4ca8-c58e-4cd7-771d-08dd512c28c6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:27:06.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AM0UW4NMwrfvmvjFiFauDWv62tJauhdT+Z0B5orMiruCEvN4jC+9gAcUmzpLqPe7imQ3PjxpxoYRiuhZp0WcJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

On Wed, Feb 19, 2025 at 09:20:56PM +0200, Daniel Baluta wrote:
> On i.MX8MP we introduced support for using a reset controller
> to control DSP operation.
>
> This patch adds reset property which is required for i.MX8MP.

Avoid words "this patch" according to kernel submit patch document.

Just said:  Add reset property ...

>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> index ab93ffd3d2e5..923e7f079f1b 100644
> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -82,6 +82,13 @@ properties:
>      description:
>        Phandle to syscon block which provide access for processor enablement
>
> +  resets:
> +    description:
> +      A pair consisting of phandle to audio-blk-control and an index referencing
> +      the DSP Run/Stall bit in audiomix registers.
> +      See include/dt-bindings/reset/imx8mp-reset-audiomix.h for each index meaning.

Generally, needn't description for such common property. Or just said
for example, i.MX8MP, ... , because it may change to difference reset
providor in future.

Anyway, I think it is fine leave here.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -164,6 +171,16 @@ allOf:
>              - const: txdb1
>              - const: rxdb0
>              - const: rxdb1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8mp-dsp
> +              - fsl,imx8mp-hifi4
> +    then:
> +      required:
> +        - "resets"
>
>  additionalProperties: false
>
> @@ -220,5 +237,5 @@ examples:
>                 <&mu2 3 0>;
>        memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
>                        <&dsp_vdev0vring1>, <&dsp_reserved>;
> -      fsl,dsp-ctrl = <&audio_blk_ctrl>;
> +      resets = <&audio_blk_ctrl IMX8MP_AUDIOMIX_DSP>;
>      };
> --
> 2.25.1
>

