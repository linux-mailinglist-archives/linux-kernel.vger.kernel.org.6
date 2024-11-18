Return-Path: <linux-kernel+bounces-413425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988AF9D18E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED1EB21F17
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B901E5037;
	Mon, 18 Nov 2024 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F1PwLN9L"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304161E5005;
	Mon, 18 Nov 2024 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958086; cv=fail; b=ZQgDtkIfUwksnZ7VOKyOr3U/wyVaHB7fcMJSYW4CQuhmaY+pb1RSCOm+weYhOc1o6VMRdWq7eihlb5ki+ssh+/FJ6yvRSixNui6geFwiAjqUY6Y7fINouJt+grMl8njZftrMmxmvAvx8XYMKXR7FGooqKdR/HJOmCLMfMrEdpVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958086; c=relaxed/simple;
	bh=0vOhjqHEer1PFO8rp5/xQM4IJmxZNd4yvyG69FEt+HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LEsgelgMAl833zl8bSIxNdjMSsGxFFIIRrQHurP8ux1+IqwIuxhe5lMvIjP9ezYtfcrvmZzT5LotwAypu7Cv7u4354X8ASfrZvDuwpQYP7kYJuYzx5adpI7r0Aycjx/anV81umYhek2XIf9JiNgM6K26fn493Bw/c04Od3942jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F1PwLN9L; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM9MoXEia/awXMgxjAymH3HUPKL9cxpIgePuFjruf8PGd7SP9Lmvgad1PnnT29lh6WdoqgTZyStSya4QVf/HHYJBQ0DoSHyu+dD8hIDRsgs8U8MztAombG7jX7h3Mb+VTqWGOD1QR2bzQ2wjvaFrAjiKtphluEKN7FzaWOkekiy8tGmU+9hLowurt3MwfXLWBjIpeXLIQAfxF/YyI28ISPjH5I83lpZXzlPH0IvUcZF+VyrgYoguhmWIf8a/X+uyHjbVrM0Kko3r5PtsuGlD2+FgpRgMTxz2dx15aIPb8jDMQlaniIGUxcaR0iEYdZuPm2LARzHtqKa35545rDJxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FolX0CGG9qcDIxHC14oupH4m4iMCogn4SBJwVAIfdU=;
 b=crns2itTPE75rJn74L1SN5dTulDkO2SeSk/IZrOBmzx5SogIK2A9rZ4Vqc7Gl5X869ed/0qdqn2YxdalupXKz6iuDElg8I5WKChRUXWaioSprskYd8wlYOPW3QQ+EVO/xDOF33zRl1b2fFubKiA04+Oxx7xlRgs1V+X5ZzqbEa5a6oWWRGTCStM/+M26mCt90feO6VVC79QVT7b1g3lmn3RTZthgL6n6KOyElefEZYkNefcq0nMJ5oYLEmidSjsVQbEtxQ80JdWVY+8E0CxnI8D3fOHlHq5DDlbp7ncafLJtKB9D3kslCqbWHqd1VpKmNvP8g5TFuXu/Fs+7VFjh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FolX0CGG9qcDIxHC14oupH4m4iMCogn4SBJwVAIfdU=;
 b=F1PwLN9Lbp5Ng6pCHwdKv2LglVf/MkzcuEpe54Qj3lu996xGcwTZ47Wvtx9djx+O7RkBDgGOQpoHbH5NhIAiqtdROpEb0Q3HhnwifVINAoVS6LiOsehzlY1BfbcynNUkMp/26r49txrdTiWLA04vn+1tMOXTkXkjbId/NdbQmZbQN9gpVyYfik0xEDWyzicvfSs7Kogvh+fR50hwZsnZZrKcmjCIM71ODr4TmFS4D8tT8YrA5p+4fEpeNuGDYpTUX0y3mYjTeAewubL2L8ArFvvxaScXqBpSIVndyq9bu1pAdHjqYcDLHaDsLTdbdne/FILGGZH96ga4Dn5IRFRybQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 19:27:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 19:27:59 +0000
Date: Mon, 18 Nov 2024 14:27:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	catalin.marinas@arm.com, will@kernel.org, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	joao.goncalves@toradex.com, marex@denx.de, hvilleneuve@dimonoff.com,
	peng.fan@nxp.com, hiago.franco@toradex.com,
	frieder.schrempf@kontron.de, alexander.stein@ew.tq-group.com,
	mwalle@kernel.org, m.othacehe@gmail.com,
	Max.Merchel@ew.tq-group.com, tharvey@gateworks.com,
	quic_bjorande@quicinc.com, geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org, konradybcio@kernel.org,
	neil.armstrong@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
Message-ID: <ZzuVNnCMF/PAIwu5@lizhi-Precision-Tower-5810>
References: <20241118051541.2621360-1-pengfei.li_1@nxp.com>
 <20241118051541.2621360-2-pengfei.li_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118051541.2621360-2-pengfei.li_1@nxp.com>
X-ClientProxiedBy: SA1PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f870f0-a2f1-49ed-651d-08dd08071c83
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?/8cp12z7Hpu+em7KCWYHk2EVYG8BB1UrDyhK4SZjZnFjGJPlaYSZ2IqRcJRK?=
 =?us-ascii?Q?Y5tUpruM96INdIZprUM04nhko5QVEpH2IOe81JJuc0Zu7nnjv4IlYTVG1TyU?=
 =?us-ascii?Q?0t52wPdz7prTHpw1zyfjbOohdK7ryYlScmOPZE5Jp1KGMR589+d6ldw+0eal?=
 =?us-ascii?Q?+6iedNkdFkT+XUPZ8zF9peotyF9fITowQEqhK/HX7vfw0T0fxQ6Bch6cn4MT?=
 =?us-ascii?Q?+ff2bzYWNQ8LzXym2r3d1agX9lZr3g0Ty3Pgd7X7qXNyWKl8eBYoA4NBQnkQ?=
 =?us-ascii?Q?SP/1uUhIKyO2Fe2RtnE2/qsyb/P/Nj32rxBXiav1QbTUOJevmb3K02MIsuEB?=
 =?us-ascii?Q?Lmheiu7D1mss9xrtiBpnUa4Mg2rUd1SMPiBdRwddRLYBBVU2GDylRRIlgaH9?=
 =?us-ascii?Q?IISQON8sAWMfa/uNyx60zb6bftagczpOQuEdLi41Um6GW5ftf76gr4jBGILn?=
 =?us-ascii?Q?iZrJzt+Swohfdc0i5vIjoELCBQMupsFT6SU0pXFCiT/JGkdtp/3q4wLy7wYq?=
 =?us-ascii?Q?TSee0idKg/7EY+/C9bi4zCf3aomNwakum0U17m0+wPX0YVs7ktf6X3AxyFe8?=
 =?us-ascii?Q?ioVUYy5kOy4+HNEY6Qu4JMxYC1wZrwjMvv8DXidmPWKJhflUm2/ilFIaAzII?=
 =?us-ascii?Q?HR6cEwa4LVbXYMbs5NyswVzvWFnRbpczrJn+8VBYOjBN+hWJNVXm/I8yQKzX?=
 =?us-ascii?Q?2Sg55zAbLGptv8Uln3xzTsT08Xo1LKBY+4eI3gB7Oi9ppV3nONojtvl0EL93?=
 =?us-ascii?Q?LMBLUfFbts0olY7u68/Q2nyWQavTn+yfN3tfoAUW7fH8r7UeGBtqTqSBFBhP?=
 =?us-ascii?Q?fnTpsoDXwo/+AJKBd/s9c86k9XSmJriMJmVwGaK6cBhI66Wa91YFSpM2r6fT?=
 =?us-ascii?Q?A6z695VKOpB42fGBCkSDIpHJxW7Q4WsyP2CUb2Jwk9DGALNv8chHRZAxxeH5?=
 =?us-ascii?Q?T72jmbqB236O9HetRFgxt9FwHXJnTkNiY/QWBtfRvlBW+5TJ25aYxMD/WUPX?=
 =?us-ascii?Q?SrkNOhauN3t/dNWE4IgTukzJFPlCmCZU8KE8tR3gxPFzzCSq13vQwPBcYB+N?=
 =?us-ascii?Q?rlue5R7ZNEJEjki5Kj4XHpIhL7IvaoVYd0+t0athfIguenfDd4aVy92UQj0x?=
 =?us-ascii?Q?RSD8oCR6Mv18aU1Y8maf5NgkPdvztaGTvCitf2fcyVHTNEsDj2wn5ZohmvE8?=
 =?us-ascii?Q?dKDw8Rs2eQ3pIoMG0Bx+SVBOoZV7YM85nPg2ZdVUMwjCLYI7uuglkXfoVAI1?=
 =?us-ascii?Q?9L5yailFR1QPWf7Jbah12CIqjxKfWayogMJ3y4HAREl+KWVvPwQXSP67l/6D?=
 =?us-ascii?Q?AIDWHHjjKPXpIsdJtDazC34Y1w5u1cFj5rmAnANcdds0imidezXYxE/ogJx+?=
 =?us-ascii?Q?Roswd7g=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?qzwAzSXSB0iyeZk/DaqPk1GasMeWc0Zgwzw4Vgfj17hU0GfOlcfVU7iLFwp5?=
 =?us-ascii?Q?3mLmc+jWUr++Se6/th7PvI8Hd8X+3XoIvphspacyzJGGKdWRkPCoI5tUm53D?=
 =?us-ascii?Q?5S6JiY63ZYYu8k/JaikcFtnad/gY5w+Op580o1qE+8HwA+1TJCc7ZqDylny3?=
 =?us-ascii?Q?Sv2t8YFVHsiwV1628elFGMtjhUUDIMt9QTy+/LOpIwH41qoBKSwCC2P6mhJo?=
 =?us-ascii?Q?K5I+G/i8xko5VyDltLe2O/ss3kIsz1Py76SCuwmIpzW4h0PGVf/ua1w+0QjH?=
 =?us-ascii?Q?hxb4wLYTTM40fOjBiqNcWSX5H7TjO5S6p8vPtmJTUjTK59Bx0ZtpibVfdwxm?=
 =?us-ascii?Q?ynyhoGbQLCUzGbrs4CoUFCuYXTmPWp2VVda0Nu35n4pxQgjq1JEF6b8aUVIW?=
 =?us-ascii?Q?mT1HrS24VBXAUyJ0u8KCUcuK97TD8nASg7xhALiQjsVDQK9viFW6K70HUjkv?=
 =?us-ascii?Q?TzI9jie8zLBGJFlYIbzq6NTZsdKdWxXzXl3Vqw1cKOCKtvhq260klvBZJvl4?=
 =?us-ascii?Q?yCI29NYIb0OzDBVfuRWXFh7of+EIMorZkxRYp/BHptixzH4fVyb9LmJ+413w?=
 =?us-ascii?Q?W++Tw/xxh0dboVdwPk5dzjljmJ3ExavZv2e1I563R2mPDUlpp5uIQe25Vyl+?=
 =?us-ascii?Q?Qe2ow3touSL6kOpqErcQTl4VH5jHAX9/oZfhFi/hr6NK+g6eLFQGPx+SvI1/?=
 =?us-ascii?Q?GJurmivUZ375St+bUSd8mFV133c41nhR/P7RhL5UtkCbcI/FI8PkNaYSEYIK?=
 =?us-ascii?Q?7KxevuAW0rT1sCM5rgqgcuwBkXzrKx5t5gkdYtaENprHXr2DXoT9uVQn6eny?=
 =?us-ascii?Q?7o76oENQ4oUjJkKEUSpA9ENyDprVs1olsib8AJ+Ps2u+92RVrSEGDXTxfiIi?=
 =?us-ascii?Q?k9TwJlPrRe7gs7fT2TfkoLn/W+H7xjjjGGBpqzKEej6b5tIAc3nhVp0ukBUM?=
 =?us-ascii?Q?X4YNAy5uT9YnjiOhyQz4p3ZHvD040QqTjJcTltWD1gIu9oeQq0pJRkrOxnlN?=
 =?us-ascii?Q?AthIZ7wGeo7FvsGVLUjFuQnFs3dJM2aiEA62jy2Xgal3iosM0eltpGauhN2d?=
 =?us-ascii?Q?SXSX1gUgtpslHuBc/rCrF80A6i993vxnPHTaxk4byaYJK9r2q5L3Vaie6qV6?=
 =?us-ascii?Q?imrVZdOATYJSuy2SKUvdr5r7T8kJtccnYcu9jY8aoMzxybBJaqlbZO/QzXM4?=
 =?us-ascii?Q?G1Oac1DZ6GNauaEP3ee3WtGj5MJHxJuS/V+gvNP3QrVmR6Dq2gqnCF/IjSgk?=
 =?us-ascii?Q?ICJU2GvtqoZxDE1wy0BSm+udQoeXAM6JmdHQabJtV/pHa7PXWcrORYNbuIPY?=
 =?us-ascii?Q?z+xcMwzJH+n1bbPk5SD9q0vIZGubSuq1i/65McquD8XroA0dzZi6D0KYpJ8r?=
 =?us-ascii?Q?IG8BRmnuQmiCsmKSTLRLNNt3/8KiD+/3oO0OUVm1isTH7olhWAw+1UV2NVbl?=
 =?us-ascii?Q?psZvt2kI2FGqnvQAmNKEMlP+t23LNLdf5bXH+XDrmX8UEPhh8cM75O8yIfn1?=
 =?us-ascii?Q?fG9brWqtYeWlFJ12nQekNjblsbVER4vJhzb+a0husasZCJMpfRlJVtligulM?=
 =?us-ascii?Q?4tRj0a7OkfomzTvJjck=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f870f0-a2f1-49ed-651d-08dd08071c83
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 19:27:59.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOLaa8MzXDHu8ZKIZYf8oP/h12/rIR4QK7HRlMY/A1fcKVBSZ5xbETx6QuoLkhmeBWFF3JH988Tt/KmZ+ALAqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

On Mon, Nov 18, 2024 at 01:15:38PM +0800, Pengfei Li wrote:
> Add the board imx91-11x11-evk in the binding docuemnt.
>
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
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

