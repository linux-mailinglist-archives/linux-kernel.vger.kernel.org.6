Return-Path: <linux-kernel+bounces-400147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F120A9C098B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1DD284ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E17212D31;
	Thu,  7 Nov 2024 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rxsf+1rQ"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932D7DA9C;
	Thu,  7 Nov 2024 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991790; cv=fail; b=bquzslWc/iT+XlG5OzqjGGi2igtx+R3XnWfkWrXH5yWsGekHfFPOqT/VwXjlGIZH4tdI4KJFn5d5NvfZsX5jmYNwLhVYVVDAsm1UFguyq4cSHkqdidCM44cnISKHOdqDLy0DUJbwKrCXqWg4X0+1WYbgrFT+mOeVqYXmL+GlkxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991790; c=relaxed/simple;
	bh=UikS+OmNvhHW3djpK050dLD1CmeD08dSgvOGnidoLJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gaVkkapitNAa1dpeFRR6iz+OfB2l3Yt85RcWkdfobD2qccukBhDIlIdAhcSHOwQLVcE1V5xkw13ITrvfXo+SYfPv8nJMF7+ZiZWLF+KcIgOITLmlle8pN4rWydfcdjXeRr/SHz4uWHGPYN1K05U/kJjCO8TjlTvKxrEuL1N/bAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rxsf+1rQ; arc=fail smtp.client-ip=40.107.247.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEHDPtZ02hUmuGFAdPfxxChNX/QWLyu4JVNYjTfssRXMBb6OtIAL07QGJ9KuBl4y9YmJ6pGTervgpZMA4Rw8wFjuhE+WHwlBhkZfFyJBgQ5oi1Ac4CNDrYTEARfd5hBWh+ZEycS5C6phYU7XfEmDwQZRpDpA6jFaQgdF1gQCqwdLsCxYCHxdDWTwzUrGxMjksoPw/2OaN7bFzMvcKK4TXr4mfmbmdwUKROZWim2fijNahF8ZKTvFKQ9JA9+EpKpzWST7wSHYp7Sbp8+U1RkMrSeuYb0s9xtE/hHJJcurn1+a9QTTQRC8xVcz1vAOug8YhEuC/yY1/AqGuQ0Q4Bd3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChxI+JJz8Xodkt4+L3iUBIBX0LyvBwkYhztGG5S+XVI=;
 b=wgX9F0GGI/nPzrBqpFge1jYVT8BiHdtThyl8xw/Utrh+qUZ1Mb5N7OgQHoPnw2T/5LVmQ7FmTbVoyVpzZ8KnJlWo6GonEKUk/WLymQUnMPfCfAz2zudwRbmDWOjGY3wXhh2kpSrFWq4fK/8+CdiP1E0DJUaxojfVPIzahk85k/zBf+RUowYr6xWzFlk0Qj1cOAu4kGMxwvWE0yDi0qFWW6JDQgpWkQEnczfk7XVEcsI3Hr4p38aMPr1vQnIZWzg7wWi9t6UZ6ZCPzfpyYRPa4CyYj6oyyn4+6L2wiQjB5pjW9D+lYtjMUO+h/k3XQFz+DxxCSBz3sZo2DOQcBuhtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChxI+JJz8Xodkt4+L3iUBIBX0LyvBwkYhztGG5S+XVI=;
 b=Rxsf+1rQqUj5TvvKy2DhFIrWEuEzpnL95t0u4ZiKVP4NeP/gFRrAOrc7ovYzNz80B9YsrkEL58xzD9zXHP2v9qOem8jx/T5gxfvicFTTZhVCDbYeLfKP161t4oxLvfa2tXcvLLWPuSfunxKhxy8l+4IOYmX/muAeBQdf7gDmyvoYJoVHXTb88pNkTjQo8NaAYI8mxpD0oNoYP/tjCXYicdOV/nQ8s7MNlJchjolxTDh8uYnwOVHqT7TxnaabKDnd8NdIQrbKZ30LR5lBGq9YcOvV2O3lVt4hu9LE3jZ7D/kMs6p5KV2K5wmHeniG9PfcuM4KQbO62+vN03V48LYsug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9411.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 15:03:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 15:03:04 +0000
Date: Thu, 7 Nov 2024 10:02:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de, marex@denx.de,
	hvilleneuve@dimonoff.com, peng.fan@nxp.com,
	alexander.stein@ew.tq-group.com, m.othacehe@gmail.com,
	mwalle@kernel.org, Max.Merchel@ew.tq-group.com,
	hiago.franco@toradex.com, tharvey@gateworks.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Message-ID: <ZyzWnHmPyjBJZ7/F@lizhi-Precision-Tower-5810>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
 <20241108022703.1877171-2-pengfei.li_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108022703.1877171-2-pengfei.li_1@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: b759af0c-00f1-40c1-de65-08dcff3d47ba
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?kgUM1oN2/GYjV9fq9a8LvwNbZT65oGmsOpx9QAtjh366qxoCoSmgENCj1cxf?=
 =?us-ascii?Q?b68U54y2VXX4UfFJ+ueurXX4A9Wl/e9NRDWIy41aGdub8ZxX6x7sTz7IaW2P?=
 =?us-ascii?Q?0DFOXWbJGltjHWsCl4EFQutraBT45ITXoS0EmHOxwxKBcXPB5uqvKuH6M24b?=
 =?us-ascii?Q?egJlHSndads+YQQmN8PGYUUSnszFrvJMosGsfsLlI3cx+cbSEcpklhKi6j9/?=
 =?us-ascii?Q?gHKbB/OS9IYN7BCqvymUP2eS64/NiX3tcy1TMdGMYsHqzD7+IKyzv/TIb5Qb?=
 =?us-ascii?Q?z/wjTpr01tlo0Eu6z3l4fWjz8fzYa82LhjIWLejplXDFAe7iF0J/lFRm+fOI?=
 =?us-ascii?Q?TiXCrfIyX4L7rH6jqLwyGNMWey5ThWL6ELPXYBgkzMtDDmk+n/XVgE7WYyA/?=
 =?us-ascii?Q?6ed0iVfnjP0LBjiB3PfpJ1hwA0So4H839I6Xyzvbfq0Msz1LKGd65WJUCtGy?=
 =?us-ascii?Q?A9ng0EorBp8phVZ+9+yCGE7D2LRkYo56X3LcsyDz4fqdHFouyuC2++o4vA0r?=
 =?us-ascii?Q?IeiAZXrw84t6L20yJmyCz6uH9bkL7fzJpJcTvL/lx57J48XpHTpHG3CYqLDz?=
 =?us-ascii?Q?09acpVCxdCA8E6WjL5WxIZn1JYEc5n9uFBwri3j3XYvjSy8XZUDNBSCEIibv?=
 =?us-ascii?Q?Q1hj4IsWLP5dR36CHiNAMEPELDuOUs8M/7C/3sAzcHBn9/Mm7sOo6oEXJ466?=
 =?us-ascii?Q?CmsBTZSPQ2+/isHJTOeXYUiBALOepZBf4ZnTu0Bw/4N+8YsonTEtYryzGL41?=
 =?us-ascii?Q?aOmmaw0savSUGNwBwGRUUIJmsDgSLfyEhlnp84OxwauAZWS6PkvlM/ABMPaQ?=
 =?us-ascii?Q?FKKBrIdfzP3LxYOQXTfi6lIH+VuOLc+veeQvl7X9kGEpD2NrpIwEXsEMxVz1?=
 =?us-ascii?Q?e/jO9FeQ6j7oAp/gbGKsOOxDMFHrhkRg7odaRiWRaXbro+ErlVufnfOXPNj4?=
 =?us-ascii?Q?/qjNhlxOTzCj98N35Nu8vEwmHtYon108Vu4YsBPulOWnwsnpBRTGkiXgyJ/x?=
 =?us-ascii?Q?w+FNmNSdZwrpnCKIy/WXOrrkyb2vUsq8krXE6BF3q5OBmQdYGuvk9BlmnccD?=
 =?us-ascii?Q?GurFs4nLNdV147Zk8fyEg1RaPc5p0ObjweT5yhcDrJ9OP+Q74PWFTuk2zw2i?=
 =?us-ascii?Q?fCOisADXTEyQYRHDF62+qLFd63MpKdrVt4n2+tCMsJS2NbmX8dO9+kQJmHc6?=
 =?us-ascii?Q?Rl+Ufk62YJkgL5KgLiJPpY2JAjPmOumwwedHinnEEcvWDOG+wXA5WoCSC4wb?=
 =?us-ascii?Q?TWsooRJA+qg9I9dxYLhBDp5jw0E4yv4/YAmOy3qtCos7xyNWsG+xOCvY720p?=
 =?us-ascii?Q?ZT+PEmUV4Gov/2JhS7kioJXTPoDzqAs6d3W7s3aJj0z7BL87P96MHTsQNvN4?=
 =?us-ascii?Q?L91fnwg=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?0K2+eiFuokzdyg96uv1MQVJ/PuKjik1Qs5eAvgnfNlu7ZCvijnCZatIg645R?=
 =?us-ascii?Q?FxUUarulLtT/ZzysrFfbacz3rJSgCnak1bmhTNP7jwHl8l6qOUmDg0py36tS?=
 =?us-ascii?Q?9Bsib50GeKWKd+oQDmeFGboz0L19BTrd2HydUinawS9Oj1B0aZl8OUEcfyC6?=
 =?us-ascii?Q?cwTfDUFdTbq0gNl9Z+pp2pjtgZERkPiNCDYvGZ8DeHWzeXOoswX+fNy45HYy?=
 =?us-ascii?Q?4onlNyoVNZv34NEJ9HUcci0fwiSchP9sP7L6bv5tgQIVemJe8mxzsjraadD5?=
 =?us-ascii?Q?CXk/6xV4zGK1Z/ki75Tqm4oFAisG7i5dlHmFbh3nRW7/OW44FFYWBDXZkyEI?=
 =?us-ascii?Q?5zSi3+c1qHjAWHXj6FvMl3GoeWTyxvpR4BnpIM+6P0TqKmEzabEga29lcCAs?=
 =?us-ascii?Q?MUME2KKbO/uKyuq666bsk4IohalequdxtZ8uCBmPcTkfh7DBPEHVZbi0BzJb?=
 =?us-ascii?Q?e2rrl5OsNIjqqwfQIq3ccRVA9y5gpK96/Ce3vreiXFVZY9oMhMtrVA4PJA2r?=
 =?us-ascii?Q?Rnz1Y+QwwxTP9SPNICy/gkDUe9i+WwRQOrr50HwV2HlQVNNPbWth5OVpdOzm?=
 =?us-ascii?Q?h7xUOq3Qwbaa1qF60Gpc7AsteWXr1nH+y4M287t91LvUqkOzIp4UfQWKyAha?=
 =?us-ascii?Q?4YFim2Zl6EA+ZN0z6LGOxBA9OHXVH0Wz7J6KbTXVbkuC27GsI/FIRH629D8E?=
 =?us-ascii?Q?02hDrePae6Tc5tAN96chNz5ppRqKli/B9ml+U7nkoM/5Q20C0NlIOOacgZ1u?=
 =?us-ascii?Q?J8Whpc+8z30T1oWAc+6et/WQDFUVvrmzTZAb9zHTEpvotw2T2ADC2qVNu9XX?=
 =?us-ascii?Q?E8ZonKhu5mjBl/t/IivWfKy31rGjX8E/wl03SAIJvABhi0wuE0Xdv4gTEXtt?=
 =?us-ascii?Q?ORSWbYu+x6estxW5JBnB6FwDEXgE93o5kItAMY0PspTeCCXG+L4EoYdE9XDM?=
 =?us-ascii?Q?hw2x2m743WfYGbMWTNy44WF/m1pQQXjLap9zwrqRofIBs11Le+Y0xtF5zHnD?=
 =?us-ascii?Q?hZuMdE4iRutVtfTcwh82mUHr/R6Dqz+AUzPG4amjQbuZYugTTZMA5mEM/+JJ?=
 =?us-ascii?Q?16C/4+YNOnWxTw3kclxL34gtL7yDHPTaFEDHk1TE+aBw6WDJ3qsie3E6XLsL?=
 =?us-ascii?Q?7bvbbLPH0T4eczpaS8Pc1SaB+yD8gDE+iypEehIJq1af2Yf/LowXo4wQyoeO?=
 =?us-ascii?Q?14hYaMQVfzuXHgftnkLzE3oLTzYJUkNIcGn01H5PxS+2URkjra/XBRGn/AwS?=
 =?us-ascii?Q?9ietCZrEodZYPckVh33PC0PHQB7dYqD/Ae9pTan57UXi9kdFxo057dIzQpl6?=
 =?us-ascii?Q?P+CmsywWGbPsL9EmPkhIJhLR3YZDSuKAFHsuFPuL+0cvOXxyzm8d9ERHEFjB?=
 =?us-ascii?Q?L6WBc6ubXyZxGobYEdkwvIyjyMDoxiIuhGBmdMKWed/4wBI5aGQGR2awm1f8?=
 =?us-ascii?Q?2P7wZmiVdQsVNBJNBqUgq6levOHEKySVYpjWy0BqAfp3CZkAnw6elqVfOqqF?=
 =?us-ascii?Q?CedZNn5tBl7cpwQypPH+7LnDJi/7lsPWxFuX4ZTHN4y/SLUjrxCnxlEx5tA7?=
 =?us-ascii?Q?SpYHoRM7Z42YbPZvdtg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b759af0c-00f1-40c1-de65-08dcff3d47ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 15:03:04.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +d6Y9dHPHEtgg8UYEgdwLKqavbBi3pv5ep8BdUIrHkwtdhomW5Xy6f1AEQCUB2PV1arWxFU77PhCd3C8BApFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9411

On Thu, Nov 07, 2024 at 06:27:01PM -0800, Pengfei Li wrote:
> Add the board imx91-11x11-evk in the binding docuemnt.
>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---

Please not include my review tag next time when send out to public list.
review tag need explicitily sent out.

Anyways, I am fine for this patch.

Frank

>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 6e0dcf4307f1..5951317ce900 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1332,6 +1332,12 @@ properties:
>                - fsl,imx8ulp-evk           # i.MX8ULP EVK Board
>            - const: fsl,imx8ulp
>
> +      - description: i.MX91 based Boards
> +        items:
> +          - enum:
> +              - fsl,imx91-11x11-evk       # i.MX91 11x11 EVK Board
> +          - const: fsl,imx91
> +
>        - description: i.MX93 based Boards
>          items:
>            - enum:
> --
> 2.34.1
>

