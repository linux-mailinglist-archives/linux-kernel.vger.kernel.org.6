Return-Path: <linux-kernel+bounces-181178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0C88C788B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869891C2101C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58BA14B969;
	Thu, 16 May 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jqvb30wx"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2058.outbound.protection.outlook.com [40.107.249.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40F225D0;
	Thu, 16 May 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870444; cv=fail; b=fetd2cOb318Shm+5FM3xntNvMHP4Uc0+OBMrMFA7XgV2oJqe1UZWAI8L77lLeK9aCBx144AlgymNey0z47CS6Axmbd1e3dVg62A4HGOApBtTvF+NAy8no6vfOaN98QP0AIQqld5rvy3SVAA69TzV09bEfZB2CS3KwfLGevi2LyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870444; c=relaxed/simple;
	bh=qPq+JyQ9+Tl+SIDBI2bhtuTwP2TwXAjJPG+waMtFV8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QF8ro0hn0/JldpmfJWYsO/UCvri/deypOavnxO6X1Su5vZT1N/4nihaWdxWMHyh6r6WhgIVGPFhvObiG0K38QYcSwwTQz7rlLKCDhJlIUHJJD6w5kdkf9GZsAMnuX3Jwseiu+P4/tK3NuGSo5CHJFYJwkWyghxViA3G/dGY7WYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jqvb30wx; arc=fail smtp.client-ip=40.107.249.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCmkxK3u/dN8gaTHwdvMhrGLv6ZVDpMdI8mZj9TIMDe2s8BfCPOmRnGUQq7TnbJB2qdlphVc4YELjpVWbKI7o9TrxGMeiOzMJ4vmErpwTRSka/kbe/zdq33cYDFwK+pGxyNl7JjnVB+WXpgCXgg7G5W3ExZbgPLufhtCaSsj4/fc5USLmns5wvVjWkPcObazJ1ESDhGiQryFW98ls23+oZWNUYLmF1OeMYVKRRqf2bJJ6VSrvmzBW+9AAjCSc3B+Iknr+0lC+M0Jpo5+Ud13D++1Mu/vSPrMKiwsvdEqc9ubYeiPpfMIAmfBBZvpwwOUpW3xDt3PY1JCWCWN3mITpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be6fpn32qDD+AAXwPi7AOTNBDobbf3lN//x0sFTkJ78=;
 b=NlDPoDWo7jqnFMmSEiEZ+s7m6En4nkavi7jO7O4NiFWKVlIs56/km8FDcRkdb7ikSkIuh01BNtelz5DKAQpFbrocy/fBdEfHhIC7dumEQERZtQ8eWJBrunUzzUqpVsHi9sMBERWM99dzTo0Usnep8gpPI3+t9oH+l7WL1b8bIHCpN7DWMJ28Stfsuwnjx2AIQbi8ePeX8gwIXPaKkjbezuMzizIe0X0XL2EKi6L3bhgXjP3YvNoP+L1S2sCh1m+6zWj+HALzLCcXZcBPqTnjxvVdOd0GH2YDgf/7ROzO0gxbJB+I8xiTEEl0PW0dCIJybCjoqcVwiZsp60gkBGiA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be6fpn32qDD+AAXwPi7AOTNBDobbf3lN//x0sFTkJ78=;
 b=jqvb30wx0fINt+JG+dgsYXoM9vrdCOa3vGH1Gc5ntIToEYI3nYU6mGZBE180hk5yyOM1d1dvdkWzORqGLyP/U9gw/JiNbcopGekNc0hEaM9ys754fCe8VdYdkYsOJ+pmzwcHdF/fI3ewi9rHaDMoBXUOvYtWbFTloLcX8KRTqi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8304.eurprd04.prod.outlook.com (2603:10a6:102:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 14:40:39 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::50c6:148a:7fad:8e87]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::50c6:148a:7fad:8e87%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 14:40:39 +0000
Date: Thu, 16 May 2024 10:40:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linus.walleij@linaro.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, festevam@gmail.com,
	imx@lists.linux.dev, aisheng.dong@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] dt-bindings: firmware: arm,scmi: Add properties for i.MX95
 Pinctrl OEM extensions
Message-ID: <ZkYa3VAsLYkxhWP7@lizhi-Precision-Tower-5810>
References: <20240516073012.1699795-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516073012.1699795-1-peng.fan@oss.nxp.com>
X-ClientProxiedBy: SJ0PR03CA0126.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::11) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 319a3b84-cf3d-4813-8e8e-08dc75b627a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EeE97WcO7YcAcbtdTPDOrgS6MwlAd5pzftPBio0q3LBjgCwm4yqpMXR6faEo?=
 =?us-ascii?Q?tNftgj1cCY2OpITOihAvyLrnwQhOf6cm3QLnNIftDfTOGZGkvbZ8+0XH8y7W?=
 =?us-ascii?Q?+V2+s0r3flDSJN5GMyXcYwUPAA/aJidvnZQkkfkA/UU5nrQNPElZhocimtGq?=
 =?us-ascii?Q?hTgfIgOnSu03/TF53gQXD6QjLwvwRWJP320f4UwlFRCAHwc1GdbnxjY+LVv0?=
 =?us-ascii?Q?Ii2Qa583uqisSL2ApVew5TVukTJFuSveCDA2bCBkYXFKuBNgaINTR/6K0xOi?=
 =?us-ascii?Q?1yCagxYsPxi8upm1MsAljRXYn92ew8X0AEnoUwu9lxaJL0I0DHoGhfjsHojt?=
 =?us-ascii?Q?5V4W2MX+ABRZr2mZJtri9Mx0UiHGeRsii2ri4XdhRH6U9XD3QI65O4ydUGZc?=
 =?us-ascii?Q?2HFtC5YpDKsyAAUJSD7N3iIwRtUWI2vjc/5sKZGggpWWM/mgOhQMKW5L+jL1?=
 =?us-ascii?Q?QvYH6VLYyaIB7uMrrxzrfUQYWqgoQqbDTcDy/Nc49qf7qhES1+YQBMA4u04T?=
 =?us-ascii?Q?nJ1xSinsf48mjRZM/ovpiPr5eQzc2cI7PhsDuJJf7PGCCOzFg5ljtIjSpiax?=
 =?us-ascii?Q?A1+VOfMo+BKWQINaW03ZSBOobV2pVOjpAd8d40zZuV7BC4jECY34LPQcH9pA?=
 =?us-ascii?Q?L/6Y6OxOWuAyVOiDuryjaxwoNcDYWqpKlniaEJdLvjFUL97cSQo9cfkT8/wI?=
 =?us-ascii?Q?mXaWXdJGkb7MAhbAlzMl4pI+fOVUA6y0mZZ+VX+nAHAZa+rUlflE4/00fnJr?=
 =?us-ascii?Q?GmSoz+MaKwFQk/9qHLPcL95K6rdpqWAPAbJ/ibuuuCEQbRlkqIMN40QaDacY?=
 =?us-ascii?Q?D9AHz6XBP6752ZPVeTyzdbMMGNz9TgLTgA9FEIAEZ+4ZesSmtZnsXDKFLP+M?=
 =?us-ascii?Q?nATcZut6Wpz0tWX36ksicffKvBc2x7i5TAvKbCv4r49sNSONTwMU6AsuTjou?=
 =?us-ascii?Q?9ePd/wAiTgZVuJpA4VFq6DYJIr3U2HGSsp0hp9DX5l0huzIlFHpK2YGt+gLj?=
 =?us-ascii?Q?nDp47ajRbEYoMnEB/urlMzN6N35ZCrVNGUdsxY0q8nVxIc9GNAXKnPtMP8hc?=
 =?us-ascii?Q?HCWa9qrD0/8fWonQKSYFQbSmsO21w5k0lZEgKKr5L+OiNGE+dqAIBd+C0cYh?=
 =?us-ascii?Q?w+foRupAgVxTziYmlsnXzYbFoS8EmVSbHj87+mwX9ea1YnXM6uRO8vfzFKng?=
 =?us-ascii?Q?tLM0ZOakTr6bbdwEShc5PfkB4ZToYyb3Fg2nMwwlESGHE00lalP1pbxtpN3V?=
 =?us-ascii?Q?uvH4iDJQhSJWq/u6Yk58hLGsPtZ/tDuhDqcW3JFXyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GmB239OshfvCJrxvPLG0ri5HRzMKPmCYk715h5pL4vLSec9x1jo5AjxniELN?=
 =?us-ascii?Q?MapbLlYkDAeLdcS58KMjlzXAqOqgZKd8je+OLrI/ZUErz6oLHLaiiCjqplZR?=
 =?us-ascii?Q?Kbr3/P6te6pr6exHBxu5hdfQ1W9BAySTi828aBI394iuUYmQ7E1I0k284UFi?=
 =?us-ascii?Q?7ZbLdaTBWhP7p28BCU35zj9sg/cKoIyKGO5xroeM6dyjrybJKS3c7GzRr25Q?=
 =?us-ascii?Q?GGysud6kgW06YXlX56AatxQdfeaZovZRs5/DQXyXKa6gaD4EIKKfKfWmg39H?=
 =?us-ascii?Q?rwNPE9Lwo32dYPE8OQ0jIgi2dP03UUR4wNhE1lRgpeOTZpgVhWgN4GXCqTE0?=
 =?us-ascii?Q?Qx6KEzY6xwma6qt4DTdgLhjSduiduHeo9RW6yBMGeoCx9S41VPrQqzzs9iO+?=
 =?us-ascii?Q?91LZPCuCfubcco0HIIA6IK61Jp4uR/s8npxAajai7dmB6xGbTiVAP9bD/6Zd?=
 =?us-ascii?Q?wKFQr6yUFFCE9DxxnPssWilOUE6i6KfTRF7tI5UWbF7oaGip4SNWdAUtLKP5?=
 =?us-ascii?Q?+DFpeaJFgoglll3EjI/Ne5ErHVsECXDd/iLbh9BzJ6kavatohW1pn0XMHl38?=
 =?us-ascii?Q?+J6YewsJIqAp7T42YIJwFlluyPWNIRwpIUCd+F5Hq3z2FOTn91AgdfBXNgod?=
 =?us-ascii?Q?CRBSJsK4YiKw2koFgSgERCvANkuB7GcCUZjgzl10wc8SU5ZDO84te9gXiq55?=
 =?us-ascii?Q?NjS9qWMkLuqIo2xFLDOH7hg5IDmyvblr/joGUzSmy+0dJHBkSlSrfSfAGqgH?=
 =?us-ascii?Q?Pqea4hMpD8ZXAWcwEYEMSWAVPJDlqJ358H92OuKyJj1pJNc/50c3SFohtj5D?=
 =?us-ascii?Q?V2JGOQO8EQlgDx0Gzss52ZEeve5vL5zm2JoIhTVZMyNMryFb6HcCT+ubnjCn?=
 =?us-ascii?Q?Jf5+Iwhe6DDby3Z9TuEBj4PKoExpTMgcqtmRNpQDXQz00DZMQ/B2UC0etm+b?=
 =?us-ascii?Q?cTXHX1VIW4iOclfNQDCV8ONzdAvXXeMolIYCR8SogGJN8EwIijuqRPANP6qA?=
 =?us-ascii?Q?b5x4tO6N9zDT212R+BJyV6WsfywgEe63dtBdfbL2tigQiS6TgD6igaK1F7x7?=
 =?us-ascii?Q?qUCS4rm0CczEevPjcGzkt3ZeIaqLVxc51XSSpOOYwVWlA471o5VhVOg1soa4?=
 =?us-ascii?Q?u5YNPWzh3ZAMLp0owI/C2zlxZLLQwwlOJUqB6eMHGnNhbkPd/XlWjFlTEOs0?=
 =?us-ascii?Q?6loyUSUbJ7fYetUxK1WIvbWL493vlfLoqUTmwAY/xF35R4JWH29Bleq9wv3f?=
 =?us-ascii?Q?RVg1gGemc8pbULQCC94MntlGCnl06JqSDOZgCXGp8eauxNxRv742++lwGCys?=
 =?us-ascii?Q?BDn20DhQHpXqalVEPXrf4dw2DOztN7/DLQuz4QEbj/mn1Nh4BjbtXME+4Tt3?=
 =?us-ascii?Q?O/2ivUr9iLPZn2zBI8SqQh+Aurg3zQP9bycPwcMgSlh/s64PY0Kvzbtarrl5?=
 =?us-ascii?Q?NroPm3P+SQ9aoV0IlaqTeoTaWx7HfaeIn3yyrETlqiWnvfWdEXFFjeaBr0fn?=
 =?us-ascii?Q?Hf4Fpdn4FNDM6c9LJMvCX4JsoSWpIU5amXNC05t4rN4oc+jt+Tm/+Rr0Ahl4?=
 =?us-ascii?Q?oPwwy5KDR0nZc3s0Af1sKajCWvOnY9Hn1j6uaDIg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319a3b84-cf3d-4813-8e8e-08dc75b627a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 14:40:39.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4CDoTP0xti5gCaAlkkmffDb1AlxSDoEyxF6KWz8d3g2h4MFoky5y94ody+tFl9iOtDr495rIF6AULEalVHQaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8304

On Thu, May 16, 2024 at 03:30:12PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 Pinctrl is managed by System Control Management Interface(SCMI)
> firmware using OEM extensions. No functions, no groups are provided by
> the firmware. So add i.MX95 specific properties.
> 
> To keep aligned with current i.MX pinctrl bindings, still use "fsl,pins"
> for i.MX95.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  There is already a v6 version for i.MX95 pinctrl with binding got reviewed by
>  Rob, https://lore.kernel.org/all/20240513-pinctrl-scmi-oem-v3-v6-1-904975c99cc4@nxp.com/
>  But after NXP internal discussion, to keep "fsl,pins" for i.MX95 would make
>  it aligned with current i.MX93/8M/7 bindings which people are familiar with,
>  and easy to understand.
> 
>  Sorry to bring back so late after your reviewing in previous generic binding
>  patch. This is not to reject the v6 patch, just wanna to see whether you are
>  happy with "fsl,pins" for i.MX95. If people are happy to accept, I will post
>  out driver together with this patch in new patchset to reject v6. If people are
>  not happy, we could continue with v6.
> 
>  v6: https://lore.kernel.org/all/20240513-pinctrl-scmi-oem-v3-v6-0-904975c99cc4@nxp.com/
> 
>  Thanks,
>  Peng
> 
>  .../bindings/firmware/arm,scmi.yaml           |  4 +-
>  .../firmware/nxp,imx95-scmi-pinctrl.yaml      | 54 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 7de2c29606e5..f7a48b1e9f62 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -251,7 +251,9 @@ properties:
>      type: object
>      allOf:
>        - $ref: '#/$defs/protocol-node'
> -      - $ref: /schemas/pinctrl/pinctrl.yaml
> +      - anyOf:
> +          - $ref: /schemas/pinctrl/pinctrl.yaml
> +          - $ref: /schemas/firmware/nxp,imx95-scmi-pinctrl.yaml
>  
>      unevaluatedProperties: false
>  
> diff --git a/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
> new file mode 100644
> index 000000000000..3f28c4a171c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/nxp,imx95-scmi-pinctrl.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2024 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/nxp,imx95-scmi-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX System Control and Management Interface (SCMI) Pinctrl Protocol
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/pinctrl.yaml
> +
> +patternProperties:
> +  'grp$':
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +
> +    unevaluatedProperties: false
> +
> +    properties:
> +      fsl,pins:
> +        description:
> +          each entry consists of 6 integers and represents the mux and config
> +          setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
> +          mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
> +          be found in <arch/arm64/boot/dts/freescale/imx95-pinfunc.h>. The last
> +          integer CONFIG is the pad setting value like pull-up on this pin. Please
> +          refer to i.MX8M Plus Reference Manual for detailed CONFIG settings.
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +        items:
> +          items:
> +            - description: |

needn't "|" 

Frank

> +                "mux_reg" indicates the offset of mux register.
> +            - description: |
> +                "conf_reg" indicates the offset of pad configuration register.
> +            - description: |
> +                "input_reg" indicates the offset of select input register.
> +            - description: |
> +                "mux_val" indicates the mux value to be applied.
> +            - description: |
> +                "input_val" indicates the select input value to be applied.
> +            - description: |
> +                "pad_setting" indicates the pad configuration value to be applied.
> +
> +
> +    required:
> +      - fsl,pins
> +
> +additionalProperties: true
> -- 
> 2.37.1
> 

