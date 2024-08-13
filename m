Return-Path: <linux-kernel+bounces-284106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC3D94FCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B04281002
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F16225AF;
	Tue, 13 Aug 2024 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y6KgShb8"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D77210E7;
	Tue, 13 Aug 2024 04:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523929; cv=fail; b=Jvx4kKe5MsmPBjJmBY6QVaFcBnABLPMXV3/bns0wa2ZPfjs0cAaBiewde6iIrA3GrhQG0qDL+vZuvu//lLAS3cwsd1sdvw3/h1CtZTsvm3pVXrn9DK5VJnGEhCaD86LhYkGyrDSlTuYq28p5o5GcMrR/bTZRHoHi6HYmaz2nDs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523929; c=relaxed/simple;
	bh=5MWqxboixVTmnGVWm9pwjg0LtBUv0f+hwyA3aipni3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m3j9k8fH/Aa0tSv8/6InuNOyh5iut01MQHy9yU/4kdGvnrmJAd3YufPF6lY+xVqnLBYnzNKmlvK9xgYxmrsy4AEAj5v/atl2AmJUIX0Dykp4zRtHgSQajWPsiB67uyIV9kLUEfnLhMP/iuZrz8CI2tSPNp13skaxIl9VZgwZtG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y6KgShb8; arc=fail smtp.client-ip=40.107.22.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBkd70G3NCeOwJBQduyg9lHPHB7jqyUk+Ki0xHacvuU/H63IMKvSdteIDoR/Kx68uhPV1S8ZCuKKJs2K8LUgGkJMD10DlFSuqRCgAudEcjmP21BnM2aFJfFp1z2kh7Rmw8w7HfxcWSWLZP5KqN5+m9KJNknBBVLhTpXQ/Ph464Hap4fXeNfJMB0qIGU1xsCJpis9i7oemnOkz9zgxTW7Zgi9V+pPQjHPYQjD3ZZ+lNm7MpABIEW7EmBXqJYrjHlEU/almBGu9DsqEMK74KeONIm7cG92cbn8RXwPqunIG26TlCeifISMvE4W/pKdMzDd+nQvvM+/BspA1kND5yZmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekACCTlccKT3M7MKd32YLyqvm+kxgo27jFdX76GazAo=;
 b=xmnEsDckHCrAjtnoEEuL/qC6I9SdC4Z52pD8dWq0HhucbUBWFZBy7xTuxXWWZhFxwCv+SDm+rTKaxNRImVr50vZ2EyvZ0ypcKINvvJvgY2poTNBzOqNI56Qt+byeO0PMI2UvGR0cDEZf5p1qvw1wv2JLrVh21JmYjun6TlsQ0ZYg9eBaJevDucn3wsm80g4bICXT3vkdUW3/vXCrnnOTt3FZk8rqgR/GpgE04t3xp3x0LnvgkwMlqzh91CsuRURFBSVgKB9En5oDlbHAclaEsVArCBvy9kpPFim6b9/jeuL6pIbsWaU0KrdIEuTb/w5eKyo94UrPplL4KkR2doA4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekACCTlccKT3M7MKd32YLyqvm+kxgo27jFdX76GazAo=;
 b=Y6KgShb8eFSOTORVYk7mv/qtIRfnUvY1sNIEB61Fto0eaWC3f9V/xrAHWCl2WW4FflMWkfvlkFhDEUYMqzPfykiEL0a1uhPi2nQeGQCPglW5KtN0+dLcf/sqWYWTHwp3rLJvzfpAsF86OOeckK15mJq2n89Qt/vZRqHQ7r0Y3YIOBkLLlllXCziDKgzts2lRPk4+aOgcfADrhYoE4T/2kYJEbT6nB/UbY0qMkFmMkDD1mN+SvD2YMBTdpMcLTkv7ZF/IcmECUwsdaR9PTsP/Q7jtMh2FKLd9Gz5Z+jwfgrJeNAvGKECtsjON2ZPXAj+bLXrdi/nbIMteGndaWcEeNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:38:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:38:45 +0000
Date: Tue, 13 Aug 2024 00:38:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NXP PTN5150A CC LOGIC AND EXTCON DRIVER" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Cc: imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: extcon: ptn5150: add child node port
Message-ID: <ZrrjTUwlf06p0gmy@lizhi-Precision-Tower-5810>
References: <20240813043353.3853595-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813043353.3853595-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9bc53e-0ebf-4170-0d88-08dcbb51d0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AZXiUcJzZG/9H1Iu2JO9iamNJyKyRUUPkfmVZjZbpWwH1F3zhSDk3JMGyax/?=
 =?us-ascii?Q?iZr9jvOmpBU1MK3JE0sgRUwh1MKwAuRiuXOwDG8sqvpe2TBoQzI5+64KGkmR?=
 =?us-ascii?Q?qp0E1BdoRKFQfhvhRLteHSQ8vNeEriqHTA4OTzvecsCK3CkpbY21+SeC3bRc?=
 =?us-ascii?Q?ko8SIRrCoT9rS6BNVt72vDkuhHAItwBLNpbS2l4qpNcRQaTZNZt4v6KApEnD?=
 =?us-ascii?Q?+5dC5eOEPI3ljhBzA3Rcn1wlf5+L6LiS81jHSRrGpU3k2svbFwo+FvwJMyJr?=
 =?us-ascii?Q?4RrBXfACaS4UMo8rt/Milo0Mo/vhPpn1LxJt07Mahq5p+pbR5bSoXG7OWPP4?=
 =?us-ascii?Q?ASKSif8JI04u88RtStQRhjrdxtLpjkmoZE5ntkNZiIHSc+g9PL5WGdliKeW7?=
 =?us-ascii?Q?yb+HZtUbYmerWMt9RrKkAqQG29LYhGrGIVaR4y1/Rm/vImtDyKLaPZH3mGx6?=
 =?us-ascii?Q?ekX0R7DQL2nYvHAjRoMq9ar2ZPK84XwFKdzDDhNkW+3Gikf+k5ROc57EZ8FI?=
 =?us-ascii?Q?agKAlnO0kz8UovXgI1Gwu287uaoNie0YP7t+XXWatV5tuVw5PB73b5fZUUJz?=
 =?us-ascii?Q?aHx8n5LJWq3Z5c2jL64OLdgIxNuDHPiAVfCvpngToxQnMNqEQbQSZ0ex7d0m?=
 =?us-ascii?Q?rZ6UWoD5FVXNEgz3mbycrATSgYKU/v4vec/bXZ9ULDfcIeHmkLIjT/Rz5mqK?=
 =?us-ascii?Q?9U3384wRve6GLLn6WCSuQCeW5SRJvRZJDKdBMKHgaTWyYxVfGdRBEDzVSK5h?=
 =?us-ascii?Q?AnpIjxd5DhMEl1Og4ppY77QlFMtD4Cu/P5wTwzRICq8ZdYwK1NA5KI52WdUO?=
 =?us-ascii?Q?jg+DP5mJNybXPvCpvkNYcXVlNmgybwsDIRCA9riVttG5ZwK9ZgN4ak4s3lr2?=
 =?us-ascii?Q?JuSDK55u3IBJ0deEQ5ztO4a1YgJRD1W5GcgKJiRD5bvUWYQPztqISl9s+6LW?=
 =?us-ascii?Q?EyGNl37Zk92y3DKGieSChpkU0SCp3LA+xpRNjrfDkjYsOvkyeoLAAPB3faV1?=
 =?us-ascii?Q?2S3+kgg7o/fE26rMHNzINJlfV1NmBicOIoOvqjcBGU5gwoJMvTyCjj0VBM0J?=
 =?us-ascii?Q?5GCkiqVcwn63oZaFhtz5H8u8IXCBYMG7VdDoxiinaX9HP7gnD6oq1hmrEsQZ?=
 =?us-ascii?Q?Kzvlwp9N9YcDVjocpyCcBg8D/MpJBC+lN1OpsdziHsq7fpOnz+m90u3L9mNn?=
 =?us-ascii?Q?wb+aFYStOZ5ger6g0kq2rQgYQyc9TbiT2wH8enFzHcXa2rBmSXAybh2gRtr+?=
 =?us-ascii?Q?D0+xW5MoR2YkwiDQGMpOeXG+FseQMQaWKx3yt7lSzBZoodDkdwpDeyhIAQfF?=
 =?us-ascii?Q?9VYV0m2dNHwLRP7X71RdQGnkYOU59PVKCapUy2yjeIEUAx5uK20l3IYcjPEh?=
 =?us-ascii?Q?fVGS6vs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A9SOhsAl1BicsViS59rkHqt2Kl7jjD3frilydD0BRXADH9EMA8hTAYxR8pRJ?=
 =?us-ascii?Q?+z4r31AskKerXOeLJUMi6J8YeNNCghXXn9ZBZuJBOZTjiJ9GeDZAJ1Ia8Ebn?=
 =?us-ascii?Q?CmSJuk/y9W9VwQGJhsfCIdNbXXh4/398gV3RI7pYwF1eAA6bTtN25+eXq1VX?=
 =?us-ascii?Q?DWidBVn+aY4E+soK1HbuIm455oHsZmD8eItXbxmPPrxCCjzMoKSB79BLYB/z?=
 =?us-ascii?Q?GlxG6nevgH2qMI1ne6IxqTidRvDE/nH/hGLXRRREQni3cHzlUxzVrR7Z25VU?=
 =?us-ascii?Q?1ZL2bti6VA1ky0XV5/YS1qbxnFwDIKxLCnABIUBUq6gS03kg2Ee1cW477DAl?=
 =?us-ascii?Q?jq434DLXXhvHE6jo9QdIwF0sLbBiy1jKzZa5q744JUnBhKcQLUu2o4GNOkhc?=
 =?us-ascii?Q?juZ+7tZp0H9thgKaAMhAYZVZ3u6whNj4xKLROnqewlcZeW+lMXip5LQWTmEs?=
 =?us-ascii?Q?7m+WJGu73GShVPAaB/uGHMt7iFyKz+I4qiaxnOHkpp53DqytaRBwMv7TOywJ?=
 =?us-ascii?Q?NCbQ0czqzNUu9EVmYv8G/npjcYV1QUvPbv4jllHUh8UaTC8sZwvnnd5JBd6y?=
 =?us-ascii?Q?/UfA8HCNqemSirsTaB4FI9jxJbA9TNxSzOTZUVmWWS5mJtTuvap8ap34G8XA?=
 =?us-ascii?Q?/xkQ9fP3PcupLjeZR56aVj1PUxfs5Bn1whKCA1Msz7FFFMp0PnEeGRUoCJv9?=
 =?us-ascii?Q?/5607YCCheVEXqY3xth1RcrpN53gUsbAEa42KUAVORf0b4ypQJc4+S29WbXJ?=
 =?us-ascii?Q?TunmHsk0V4xmNWc4saKbAwKSdSFwn05O8xFF+UpCgEYTvr+SR0NRRP+F8sk7?=
 =?us-ascii?Q?XZYV+LVPlyGo2rUb4eW2K8mIfoBuYo1tnaLHVUvYBS7Z+6s1ne+rXzm7wo1Z?=
 =?us-ascii?Q?/0T4lvsMo9B8M8PDy+87KpvVfPSvoIY/14qig2HttyBrnzxVVerKQKc8l1Ho?=
 =?us-ascii?Q?rPvHYs7cdOcZeA4NYKWOdA4boMjPEepWpNWP4dWa5DGMxhqDvOtU8wV0X4oO?=
 =?us-ascii?Q?7ABox7BiVcvSAyXNxk+qcbHDBXjYMnfVdQ1K7gJ5BqN7ZYEjBeAwXUfhWo4Z?=
 =?us-ascii?Q?zFKEyvjpfIMx+shWJk0lAvlgOI4138h+asQipp9V9uUhUY0tanqI5TKlV83w?=
 =?us-ascii?Q?9HrO39u5LoHOw27kHLtOcYJuPr3nkDJe/uiFUGfj4HocGkudavvAdBcgzzIg?=
 =?us-ascii?Q?FosI/nsyOg71Q89arqgoCS/DOOp43RiW5Mt1f+LNaC/w+B1D7RJkkRf9bXTI?=
 =?us-ascii?Q?1BsPrXcX3x7F0rC/BPfCH/NC8x1HuDSH0beaULvhzVxdggFCR6u42nDVLMSI?=
 =?us-ascii?Q?J8yOJzDOonR/+ypFy/S4F7W58RYaAC6Re+nlSwmOuIvsA9NQk8trhBssgVpN?=
 =?us-ascii?Q?YaSLiLLyDW9Tc4IoTLnOq0kXVvne4SikvwQqufoqzwPd7CJUWKTDFga076WE?=
 =?us-ascii?Q?X4OAn7CxQq5cbtrkWZl3xNvmibjZLrN5UI2qKolru2sySAW0NBRuzqUqt6Hi?=
 =?us-ascii?Q?YbiRaaPL19pRf4HZDhmjCZOrSpFV8qC5Nq/wp0uI8doLwMQ/H2kmCfZpWEJQ?=
 =?us-ascii?Q?3FWoLPEwlyXy7mTu6gPxN14yPAAwIgL0VC9/rb7K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9bc53e-0ebf-4170-0d88-08dcbb51d0cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:38:45.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeP9/PJPreKhIr2fyEcO5nl1hEIKNp4IEOEJG7UFUva6dl2PcgfwqhyUzObuy1nTtQJxF7X7yGWh1fSO6aVHGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066

On Tue, Aug 13, 2024 at 12:33:53AM -0400, Frank Li wrote:
> Add child node 'port' to allow connect to usb controller to do role-switch.
>
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb: typec@3d: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Really sorry, mistake post this. It already post at
https://lore.kernel.org/imx/20240812231820.3838925-1-Frank.Li@nxp.com/T/#u

Frank

>  Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> index d5cfa32ea52dd..28c34d78708cb 100644
> --- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> +++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> @@ -37,6 +37,11 @@ properties:
>        GPIO pin (output) used to control VBUS. If skipped, no such control
>        takes place.
>
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      A port node to link the usb controller for the dual role switch.
> +
>  required:
>    - compatible
>    - interrupts
> --
> 2.34.1
>

