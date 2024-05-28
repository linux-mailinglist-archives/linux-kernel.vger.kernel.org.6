Return-Path: <linux-kernel+bounces-192629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6528D1FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D812281827
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8270217083F;
	Tue, 28 May 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S1rolDO5"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2816D4F5;
	Tue, 28 May 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909117; cv=fail; b=c5R6Pl4f1UL2ijcRPQdvbmz5JT/qxavbzLJ1paW2HRV5fzQrOnkHkomX0GqjDVsVj24Eax4jKzY7kWYIv/ah2+MjMJ6TOtyE38lASO6g9lf31mYp10EPlnVuaFc9488XsQ5Zvm7BLtb5pIkAj554qmZ+ON5GF3xq9Q6drngcTws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909117; c=relaxed/simple;
	bh=4v/PRMlkSKaHIgGGYOFeYdVkgb5zW6H3Y9JAvwxVD08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I8PUwmNHoUx56YXKt6WLOUNjePsUryv8K26uwklQKlHMVF1VjRevYB47JmmbT8HwEx91cdG8vvNCu7jWLWBkYD9B57Nwry3k0Z5cO2TOXefhoitlnnusYoHQYLTX2RqCgTAz+JEfr7BqwmYW2waxluSuLnSgAcffMykAmDvlhb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=S1rolDO5; arc=fail smtp.client-ip=40.107.7.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuNsAYs9y04f8isTyZiaB/Wf7sTDRzESHookvGxdqUPeBlZtmJCJl7gfYtyD3O7PIm2QMFPir0hE937bXJFOc39u3szdzqMDLONV2tT9LFGw/Cja9AD84wu+mptLlMOkAaHo8G7u4r2aDi0k3btZwn1vfXdMKXf99uKWmun/StW7EJUNK/CuBr1ocg0pNsfgNgD0/BfMirQEU0sBaEmjwkwsfJgD71nt3mh+6Kqb/IFUuel9rYNWBeVDp1tcszlmaafnifvDvEYR1Wq3fKePX5OlexhKNPo1KKUSaGZwpHqRo3319b6tk8hO3x8vdWdBeO9ms2yYMMTbiV/8GsU+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VXYp/Xb/6gnBf5GY8x8gQv7AlEQWgNip3mn8Jr0f+Y=;
 b=HAtakv34tHZPefSehyXTlbvdrclmp1txF9ulxmi2rJbEoXO1LcOlfCtBIhZeSQYhc8rKPYj2Eh3TlWxZhZPdaNJIN3ksvP2QtUEGvwDGie+t3b9rgOBoJKpWaAFWxIhpMKSbTCvlowP9Jf6WEmBaArQJ35p8k3fYeRs2LvcI/Z2skBzO72StcvBySOVD1C3CApknvUxM5qfHEqqRBAkmyUlUFr7iX1j9ANeRfU8yjBhYT8AroYQmFbI8stDn1uPE005oX0hq/N7CZ2DA1UkZkurO8xkDUnSHmFaBXIR/n+gMW2N+Qb5LIAgbU36jZWkH9NmcSejwJuqWjeAVurjW4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VXYp/Xb/6gnBf5GY8x8gQv7AlEQWgNip3mn8Jr0f+Y=;
 b=S1rolDO5xpLwahO8Xtf9MYp1pVb0zxN9XD8bQll0xSxAPmXPt8pFXm3Df6Q6ZwxZqEFIVg0StUIj8Xc8CB48lY4/vI2CHkMVKu6YJU+I/FlPTrTp9Vuaf/cvIrlb2b0EWyU0SIITXyCB6J201vMCvONVHodxHrSgHX1AKz1e2cU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8904.eurprd04.prod.outlook.com (2603:10a6:10:2e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:11:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 15:11:52 +0000
Date: Tue, 28 May 2024 11:11:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, ping.bai@nxp.com, ye.li@nxp.com,
	peng.fan@nxp.com, aisheng.dong@nxp.com, tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com, gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com, joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com, Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de, m.othacehe@gmail.com, bhelgaas@google.com,
	leoyang.li@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Message-ID: <ZlX0LS1j3QeWe3bn@lizhi-Precision-Tower-5810>
References: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
 <20240527235158.1037971-5-pengfei.li_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527235158.1037971-5-pengfei.li_1@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: f9081016-c724-4006-56a6-08dc7f288118
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|52116005|7416005|376005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?mPMXDTISPZedBJUeIKdkbNVaqnSIshnTjTZGYbNdAX76t3oXXVhjv7rr0ZM2?=
 =?us-ascii?Q?O5Y7kCzaPLemlLcMMPsyQP6KFpsgKd6KBBlE4nTEnFLgaZSPj/x/W5fTsvTQ?=
 =?us-ascii?Q?zOJjtlKWOrJRbGplqBz2wywPfO9ciVirqTFvwfgrgEjCHYsXbWKHWGk5VzM2?=
 =?us-ascii?Q?hnnEuX5P65Lw58PC6pPHRm3+JTrOs5BqTEVYe334Sf7pqwfLpNn/FD9sxlDB?=
 =?us-ascii?Q?k9rPf2sshaoOctsMZUAVMH3nk0srUPDuuZ8OB8NIapb2JG/sH/6aUZsE/YEN?=
 =?us-ascii?Q?CAvY3ExOl75MuU1h8zR86VkzWpPH5Cii6p5xaE20u3e7lFzgiUWVm8/F4dmz?=
 =?us-ascii?Q?VfQlgxMlZjNd1BApmEYl3JQRS2vZfYUlbKM81rpCYVYqoXWgi4hv60L4l8b0?=
 =?us-ascii?Q?JD5pjii+6zcjUCbF7UiURsby5QWPTbXgJd6CctYPBOirpvdr7y6gKAs3LS5Y?=
 =?us-ascii?Q?cCWC377+HzWSD2yNrJkBZvndvEzV3JWqaZi0TM16Z/7Rj2hX0wVo5hWG7nw4?=
 =?us-ascii?Q?yTNsRV8KirkuQEb6T3PHH0GXYx6y4Dc64Sn8ReGt1mt1xCS78a4mroAlBN2Q?=
 =?us-ascii?Q?5IF+A/6tOmUEoepGTXflVeba8g9Jj/fuuP0UrK6FKy9yv+tEqO6QC6o+yfUx?=
 =?us-ascii?Q?/KPWJ3gyHdQtvZ0RpUHXK/kP1iF8/bzRK0dDWvQM/7iFH6Glkr6VYy1U/r/Z?=
 =?us-ascii?Q?hOHuxIjIaboUmouoYj2c/0sGfZuoMcsGeRDl2BVPE87UBTBJVcYR2jnpbydI?=
 =?us-ascii?Q?nK9BTUU3Wn/wi9+zP7GWDWXH4LvXOUXhk1z8D7PNW0pasjuwtFI+cX2c+n8I?=
 =?us-ascii?Q?fUY0sYtWLNAVNF+0eopqFdM0or3wjBNtGYyCJ/22xn9+S/hkaSbCVGDxh/Wm?=
 =?us-ascii?Q?acm7P/PKpg8bjMIRQKH8k2jlloo0MSovjfXMxN+4VaqbDpNQhhMtTKCRTWtA?=
 =?us-ascii?Q?YtRaDnG7sr/gCg8qhPn31cxOpq1UZ8KcUHjfUxQKLJlBiqk3N0EXlTRjjcEa?=
 =?us-ascii?Q?gyM5BWHC87rixlhnbaO+vcClcckbggzjcx5FGnEVPTR5JDq1cgkZo/clQdGW?=
 =?us-ascii?Q?oRTELtLI3UskEBwfAyxcyyyVhlbSyiiikE2Q37op0wfp3dcyhuKxbjsCykW7?=
 =?us-ascii?Q?6+rpuDuIMHQc6maqL2Y4QZMvyPM2Er2GRD88BcQzHvQGJ2qWZasMWxdVgSW/?=
 =?us-ascii?Q?siCVGEqzl8QjYHmtuMbh3u/ClztgWFnODp/Emmr5EMkpVvCa8XFReEezrPsF?=
 =?us-ascii?Q?TpmgWKey79+1jvlRZ83f7fphR5qlWwrvR71qWSpUaDpv3oWqqOGOOTa2ww4J?=
 =?us-ascii?Q?AzaKDVMFVIDn4V+O8crjYM4sQMjU/EdPM/ChHBGks/GdhQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(376005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?jOvOBqL0CA/6ZPhfVOFhiDjCyTxR7qbF8/d8HlFcoZZxK7Q/6qGOyA1C9jdO?=
 =?us-ascii?Q?yBPXcUFUIfwqSZVp+mOy3W/YszpcK0FqceeDfB7jZR4igvyyIQy+jsFZx8pz?=
 =?us-ascii?Q?LhPwN9slT5onEy/JGWsoziw9M0ru/G8b6bALWLRA3XfSUyzmKCDJiZ82bHXS?=
 =?us-ascii?Q?AgUBTGtzEtJ/wwaCPPPn20yieyPTBo0SuwWFnycZXZ5E6aSFIyUFQJMpzKq4?=
 =?us-ascii?Q?Ds5aNHLl3NVjgVQ5AT95kIoiKsSFLuOLzsFkQLFz6MI/sAVJ9dTEnWzlFeOj?=
 =?us-ascii?Q?A4tFcyYjgheKKrvA17OocIY/8M6Z/UGWW0sV+pyTDwGnaxWBIWcLqYTy/gbh?=
 =?us-ascii?Q?JdBZqpkOH1V9NcxwTzM/x+H/fMnhnfo+rJcKD6a0qiGji6SqCPZuy+oGZ9oP?=
 =?us-ascii?Q?KgOsZhOq4LIxY1LUO/b3tioEAWSFZwHuUjilc99bnz0Ces6UhaIwzhmLIXah?=
 =?us-ascii?Q?SO7zvFbpB3v66UzKhmILJtJBUCYEN23636s4TVXg3kEk8lZi6hI6lKYwQl8L?=
 =?us-ascii?Q?6ZvIuNWopIE+C1taiv/k7vVYoTdbfuQDAVOHtVkTh21RUokEfl7LOaSBBvBi?=
 =?us-ascii?Q?Lz0OZ9ESQGA+6xVvQLX5p5+SUDebhWkVBE2Uyss3+ca2rOMGuGRDhEDqZiPs?=
 =?us-ascii?Q?9mCXDflZzXMhQmJzcwuzExxDmp08IgBl8z47eB05B7sfvTJRs2OM/eHFHcLj?=
 =?us-ascii?Q?IbrNp3AAYXrriPROQV2/AGTTlFjN0kOqtI/x9OSq8qU+F/wkBy8R535TuGhn?=
 =?us-ascii?Q?Hzy0kGT91gVgHH1zS9EnIKGl8eAgPdecAS7Pq1WfHcNG0h+QNbYRvBplGlck?=
 =?us-ascii?Q?Xw8lkGm1+jRgberAfi1BM2q1zDXsGxetk8h7RO3JyrHbdPN9XKxRRbTP/joZ?=
 =?us-ascii?Q?KehEPp+C8HaOcRPFD+1kQWCCTN5dHDOm0MWDDOOOkufoNWGNCO1SOfjk0LE7?=
 =?us-ascii?Q?/bBGVUZpwiL/SGr7zs+SdziPShzptXnWr1G0tYx+/w0DgnpHAjICNVgf1ihO?=
 =?us-ascii?Q?fToTUwmXL7j8RXFn6kKBEBOSwS+LuFX1YEvPL9U6Blwmm96eNuYYdsFHSzxS?=
 =?us-ascii?Q?EGPAr3uau1YgQmovgcuU7VYjdA73ViW8s0XezzIhPn+FpCGtPuaRdE5ez/Wl?=
 =?us-ascii?Q?HTzO9BpmauXzafYW7qDxxka3JTLdDfNZWRpnq7zIV42gN+eKMofFI5GHdaDA?=
 =?us-ascii?Q?OgjZtKdQia25ynJQ42RjGddn5dBnzd+g9bHTupMLaj/SzNm3rSH7RixY/s6W?=
 =?us-ascii?Q?xt2Zwe+JhGUALdFzoMTIyPfCLM5Sk02s09ukyr1j0Zhhyx+MRtnon0e5sIP6?=
 =?us-ascii?Q?zFgvnvBnWNn+iIlnmZdFqxsXEFS/RlSrzfaf2TBCkqjghc8WwpOL4A0YOdPl?=
 =?us-ascii?Q?qwuPAjvuId6Mx97vVWm8l2rzhUaoCtfg+uiYlNj0iXOpN/8kDI52Bi+P7Up/?=
 =?us-ascii?Q?aAZInPtEvlkDHy89PL6L5C6UU4f/XQ/wpq4iBBPC4kTqGWUSCFr7y1mPp12+?=
 =?us-ascii?Q?t++D8rp9q0I8hHIHk3MTwFOvWhuLqLup/O0HA/L6TWQsXbA+V8NYmufiZwaR?=
 =?us-ascii?Q?XlnEwY7I0cm+TynGFA1ay3kRsDFtN0wHbxIXt0MO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9081016-c724-4006-56a6-08dc7f288118
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:11:52.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQ8vzH5UwL+RKjS2MOjWtLWbwCDPNjgSpOnOyY0YgV2VX2MKm2dklg1WCvZZtXwShhYOxg2dBqwz1E076d8C+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8904

On Mon, May 27, 2024 at 04:51:57PM -0700, Pengfei Li wrote:
> Add the board imx91-11x11-evk in the binding docuemnt.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 6d185d09cb6a..41b487ed27fd 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1275,6 +1275,12 @@ properties:
>                - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
>            - const: fsl,imx93
>  
> +      - description: i.MX91 based Boards
> +        items:
> +          - enum:
> +              - fsl,imx91-11x11-evk       # i.MX91 11x11 EVK Board
> +          - const: fsl,imx91
> +
>        - description: i.MXRT1050 based Boards
>          items:
>            - enum:
> -- 
> 2.34.1
> 

