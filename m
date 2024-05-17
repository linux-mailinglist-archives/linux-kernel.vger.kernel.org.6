Return-Path: <linux-kernel+bounces-182294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B95D8C894E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAA3281589
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B012D743;
	Fri, 17 May 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rsGRznKE"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBB8479;
	Fri, 17 May 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959511; cv=fail; b=Pi+wgvC9KNwOw8B/THJGmcnyTJoZV9FxM29ko9ftrK8KOcKCgZy+GWMGzhzBGQeycrbF3QChq1hSTVhe8SzuITXOCKiGWt14ACDLdfbH0uW9T9GUjcv1Qjl0Cl4X/v+Vhjp0g6jvfG63/Q+ERoOk4hoGQWxSSttT8KGRoEwHM+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959511; c=relaxed/simple;
	bh=Gmio8fhTtUK811Zp69KbYrt9kdVPORcVwuKieDIXiPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lR+QYfJLZChyclXzuS8kK537FeT8S7T0pX/mwTWA3etVHM1m1OGFsRQCT4uS0D+5nTGZF//b0Wj4aAePf7UOsN8IDiO4X7KmsUv7/An/QllFvwAElFZxtvO7Zlmv2I3q1prTYFeZoZ38qgL/3AFozH6zg1H1695/Q+hE8DeZGa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rsGRznKE; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOnGb6cY3S6a7/ukiVp34pLwVXP0j9m69aE2pQMbnsoJXEo2F2K/CNu0Jc+4DCqT98/5gbwbT2JDr7mHxO+1kVYCBL+4F9F5SjxUvvMJzHMYeNGhT+Wd1NEgEkFUA/P4wK68tce3fvdS1lyQUdmZELpyKYAZ32rXBqysYEHoqa8ydJDlO/58jPXixjrFcDK9Z4kjYk4BRPs9qcgDXjQrt7/OaUCmlPVnYw9TBtBQofOGWtoR9tjmhk/6uiOBmaYzns8iAHW1DNf9vTwDOEx+lTTfd/nMOmv1m2uv6vDU4zyYu0mmUCFGGvX9Xeyls4k8kvioIS5KpSdXihiMFeBggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6twWvzGBz9xEkaJV8TYRDq2rbt+5LJQswJ94lkSvpg=;
 b=RYeXCKPvnbMOY3ZVbQYyWHa5i+dgxhunOwvrbNDLDB9Iz77wkvQt2BJDo1S2Lz0630XnECVlrHM0n0qnMrpoicYjRttEJIObMlju61QyAAOuozlfGEMp2m9oI/ZJ/prmbvzfBISbBeUcAehPlf882WdqZxqa5pQNyNaEDeCUO1WSmLqzU1Th7kSKH/pZEy2IngqX2y67fd97IS647QvTG9+tn+B7Nf1qhfN7NLGTOuNmniwsOjFcGSQa4lPhfOJmEoQpq6ogJhyyaNw0oswbcJhJFsc+tGCx+3KhI0y1k2FeYC2SQ2ddv3uHRbmfZye9RIDFYansB0HxpOSR98lhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6twWvzGBz9xEkaJV8TYRDq2rbt+5LJQswJ94lkSvpg=;
 b=rsGRznKEdrXm7hBcoYSB3aSzpL5g48hlOR2+03+vKb8lONUwbnqlUXN49WCWAuRT9FwiffaSfb/ewCRfWHv2b+uxWdfmEaber8DC+Rnq+8nZ2vTS2vPSCjSWhnNq1v/obr+fLgRfg7CbXfEC6dIHZAFtmTxiDnCfEOO0zRL/cR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8643.eurprd04.prod.outlook.com (2603:10a6:20b:42a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 15:25:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 15:25:06 +0000
Date: Fri, 17 May 2024 11:24:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: mfd: add schema for 8ulp's SIM
Message-ID: <Zkd2yQ02+VHs54zB@lizhi-Precision-Tower-5810>
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
 <20240516204031.171920-4-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516204031.171920-4-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8643:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d57c66-8707-4673-bab8-08dc76858808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|366007|376005|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bY8GGP0If3/+Xb/ku9QxjktQf0EIWIaoB/X38uMJBtULwGDBFxrdKzUAIdZe?=
 =?us-ascii?Q?U0A9BGEcIU8TZSPl50cv7p3bGBhQG+REnLW7wMU6pkgFS8pWohKCdalvjbB0?=
 =?us-ascii?Q?A37TKI/gsVrl9cD6hib+ObWVRczZUuQuzHc27zKiZK8jltftRMAPlZJLjidd?=
 =?us-ascii?Q?naeHG5kB7ir9HEdjr7fCjsEBHu8D78qaD3Z/PW/pJCRNubD92aJBaoOESYSu?=
 =?us-ascii?Q?CNrkMQHF6nbB8g3w9wk/RuGbcPm80Wtc5dBUHL7eUcfWuQtStJiYTTbhwGCa?=
 =?us-ascii?Q?1Yv2wHubkcytjFQ50GNmNy0kN/qCF0AtPnXcWfkqzGPpIQbl+AbCMFWaltle?=
 =?us-ascii?Q?LntB7V+3D6ApgCNftFmdl/w+5QbKe6s/kssOdYOkfGDoyPHigZ3p6EFUx+WR?=
 =?us-ascii?Q?DAVMjcwEv9dCfyRjJqo/3hfqkleMM/L4MxbUe1WpBfObrwE9hVfXW5HkWno1?=
 =?us-ascii?Q?IKPfh+nSLodcaLYGLSjCQ/+3c4QLscZ1ZiG7n9qsf4QQc8h3CyP3Ty69r+dP?=
 =?us-ascii?Q?O3WR3SgkYq0PaApD8s1Q3vjMvkMaGgadxhe/J5Z+tAMqvtuHVauLedVvKk5M?=
 =?us-ascii?Q?N9u1LFfnmIXoNQ4LRWe3ie4wKT2OS4eRh/BA6nYpByvp0FbsFAOT6ry4RoYa?=
 =?us-ascii?Q?W+U7yQtrfOc7wJYCbZNTwOYv1MySgojd9x/yfhiSkvlnF4ciMrMpRQdftmVU?=
 =?us-ascii?Q?ceVwX9Hr1kdoTrJAvgzSwtU4D1kvrNRLaRYxC8pjBXzKbiY8jTeiJlDuDELs?=
 =?us-ascii?Q?6sHNHaRqxyRjvdXjoUJuPdkrcAMnbcg6zwngyKRSkMrLc2+Ovs6vBeGKMFzP?=
 =?us-ascii?Q?YGWYs7sp+L+01hemRSijV1i/Uv5eV7DdgQKfXBs0JW0wiqamLYfsaGUxnMb9?=
 =?us-ascii?Q?zBWTBtfEsH4QUzfO/i70bk3gN2nwz3RQweZUVJrD6JYOZyIaT61Nk3FGafWw?=
 =?us-ascii?Q?WjdeyyBjYS8QOiEoZhBvI4NhUspCf4lLHRTyErNiQo6lvKrWHuntGKy6H3gc?=
 =?us-ascii?Q?8YxQfeaVuqiC0bK89oM1Gz3oGD5xmbWBi67X7lQoEvNWLRN9vQoO4s13kuKx?=
 =?us-ascii?Q?UuWoNc8Aq1Feo+6YrJ+1GFppXQZt1u1RYZmLCJEzZZopAhpqVhksXonTL4Zq?=
 =?us-ascii?Q?G8yW5PWQL3Q1lxUYSNh6uiEkgBu9wEgEgzirpwOi2cdoweWAcrFDMebCRyD/?=
 =?us-ascii?Q?TUANKbnNsSTb5tQbRpEA6t1JhNXQAgKFH7inL1CdjYZHUqEBswLfDuehz8fn?=
 =?us-ascii?Q?QqIuWBRrj/ex8JmUhNV40bX7WoyDcTspffj8yXSdvdo5NpdopTRB2UGTW97W?=
 =?us-ascii?Q?Me4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fDeYoLNcXaPd2u3ddsj7nzc72ebw2GDuB2CqvxM/ETx9Q0lUt4tAzp9KAZvN?=
 =?us-ascii?Q?U8S8b6IcIpkDGTPuZdNoQPByze92B4RWyyuL6IsFLbb2EUs01HnWGW7jy2z+?=
 =?us-ascii?Q?vKh0J8rSv6pHiC3Yo9SIgEcLDfIc+cOg5lmAqMLJyu8TJuCgalkSyMSwKTb3?=
 =?us-ascii?Q?2ibH7+YUB39x8Apzs5CLHKCw8qiIHIS6EN1eZ3DpZFz8wCfv7JHiCPsg1mZO?=
 =?us-ascii?Q?OIOS7YdsM/HuwV0HoJuzfQEHCV5PyggKWchIgA53jOjeIgE7M+h054oab96/?=
 =?us-ascii?Q?8uuRHfGdrv4NG+EPQJnhxWNsvZgME96pnwult5NWkuRw9uqvtx/IovrFhzyS?=
 =?us-ascii?Q?onRiz0xEcs57obrcfnKi6CZcNLu9EWhaIWRzbGYeM8seL1BgFMu2XkbDRAQs?=
 =?us-ascii?Q?fZe1xYziQvENKbvYWGpibnFohKDKqrPPArgHq0CvyioTeFiL0oDR6zu1BfYY?=
 =?us-ascii?Q?DcWKxqt8Sifk6+YkHDWZC/Fxwyfhzv1iX/mufpPSb2KMk42mp1w5oe6nT8ov?=
 =?us-ascii?Q?e3iBzicPV6hVW2u9PxfudbW6QgtiNg1sAAAyZP26C/cu8SfZASPcoI09PkyM?=
 =?us-ascii?Q?0VQ6OlpZW01fHr21iOc8EaTkenX2vZbBIRKZS6qRSJVJ+t1rrVY1JLU1BdWB?=
 =?us-ascii?Q?dd882FTkQ0FeOSLergr7eikl3MNKgHBm7S+u2+vOA61VMa/ADHf9HqGRbkC5?=
 =?us-ascii?Q?/5bchBn8w8InvVIbZpXIm9lC5E0iYr2+LqrXW3SbN09lHf8Qj423CBChcMnR?=
 =?us-ascii?Q?SIawDCeJVU5Cg3EJRR+q/v12Qm8mU9bEF6jESYq+nVRJi/dPf+6G2UeRrCBw?=
 =?us-ascii?Q?epbTrZ/D8ZrVpmTITgKCWHAGT3LeCgkDz5xrs9ojdC1MIgUbnY/WCDF2Ac9p?=
 =?us-ascii?Q?ppFIOlnd4mIYJmc74w8EZmn5z3mfEthR0DvOd7BWGDhp2yWsZUBR8DCl+hgD?=
 =?us-ascii?Q?8oKo8ciuWwsjxcu1R6y5jabAJuXcxTUUaFOSdQzml5L23RyPCkd3m3yILC8t?=
 =?us-ascii?Q?N3W/zC8Uz92CkCIDUJ87FM2e5un4m3lVjoMXbI7KlKSz/s/5OJ9DInU+iXOJ?=
 =?us-ascii?Q?0XzwZM5+WuUSuz81TL6q+PsOh4crEbW1/bzgHgx/TADmeBxeHwWuDPJBCc6K?=
 =?us-ascii?Q?uWRasyzflsEcsoVmmhmrSArtQUTFZdIrHTBMs1UpKpHnlfVMr4SJHAVjm/si?=
 =?us-ascii?Q?xrCvb7fuK6ZGpS9XffJa8ZvSSwOi20ojxR69pxGOTiY2Z2WWvss/ICoVu63i?=
 =?us-ascii?Q?NMy0TFUzti4CQq0TbdyI3QmKQkVG4Ce52qxNVgd1RcUN728vM6HdtGjwnLFK?=
 =?us-ascii?Q?wSfWDnCopnh+HrjgSfwxmgDMuDT8D/tLd204xoDwkiaDMFdz+gPnu8zSva7N?=
 =?us-ascii?Q?yDHiYcLTrkWOQdUhgA+CD3yAkgZeoAzUbgmIGHYv9nwcdmVWdxHQFNiwxOET?=
 =?us-ascii?Q?HJrISBChhz9wj7uoJOXJrjviAZJRPFFq2tLcT3ZWFJZoytlfzUZ9OpERjsIZ?=
 =?us-ascii?Q?amkc7W6rQg8MNQhBwcqxRKHttyalQXTJqLfQLJXOqP8syfMeiQ8fCcFE5pVK?=
 =?us-ascii?Q?pe3CzlZdnU1kUNRtY8FY2dBMn3YRTaOXS7uiLm/s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d57c66-8707-4673-bab8-08dc76858808
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 15:25:06.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVhwtgtEpWgvKGMOqzWWx/DeJK+iBYmfvHOGmJeRfVwdXpK9G/3s1o8VtEsJuYQfue57nroEmMJhdQ0cE5OvyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8643

On Thu, May 16, 2024 at 11:40:30PM +0300, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add schema for i.MX8ULP's SIM.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/mfd/nxp,imx8ulp-sim.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/nxp,imx8ulp-sim.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/nxp,imx8ulp-sim.yaml b/Documentation/devicetree/bindings/mfd/nxp,imx8ulp-sim.yaml
> new file mode 100644
> index 000000000000..fbb17c06e3c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/nxp,imx8ulp-sim.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/nxp,imx8ulp-sim.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8ULP System Integration Module
> +
> +maintainers:
> +  - Liu Ying <victor.liu@nxp.com>
> +
> +description: |

Needn't "|"

> +  8ULP's SIM provides control and configuration options for
> +  some of the chip's components.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - nxp,imx8ulp-avd-sim
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  mux-controller:
> +    $ref: ../mux/reg-mux.yaml
> +
> +  reset-controller:
> +    $ref: ../reset/nxp,imx8ulp-sim-reset.yaml

I think we directly use reset-ti-syscon.c 

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,imx8ulp-avd-sim
> +    then:
> +      required:
> +        - reset-controller
> +        - mux-controller
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8ulp-clock.h>
> +    syscon@2da50000 {
> +      compatible = "nxp,imx8ulp-avd-sim", "syscon";
> +      reg = <0x2da50000 0x38>;
> +      clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
> +
> +      mux-controller {
> +        compatible = "mmio-mux";
> +        #mux-control-cells = <1>;
> +        mux-reg-masks = <0x8 0x00000200>;
> +      };
> +
> +      reset-controller {
> +        compatible = "nxp,imx8ulp-avd-sim-reset";
> +        #reset-cells = <1>;
> +      };
> +    };
> -- 
> 2.34.1
> 

