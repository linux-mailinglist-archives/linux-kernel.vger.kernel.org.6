Return-Path: <linux-kernel+bounces-316257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C21996CD24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EB2B23B9D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F85145FE0;
	Thu,  5 Sep 2024 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M45bAwyJ"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4B42AA2;
	Thu,  5 Sep 2024 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725506503; cv=fail; b=Aknn1sB/zNRc9f2jVqDVC0aOzV8RFnOZ4nNSa+urJRBJHSmin7jScOUe7TQn2Mkd8ItmLFwdmATHGJcBjhnS4z71PRiW7FHnpPyr1Aw7giMkr5eMRLVG7KGUrPCQKWeVSJUu6nDAxNln5RDFJnPaUmyLqTNEpnHNL2sPGjKR92g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725506503; c=relaxed/simple;
	bh=aBiwuhHtCnTAuN/OXUi/vUJ+DWdOkDbtKKQn7kh4LTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t7gfwDxKGW1I0CXYx+sP4nW95lImq4Uhe9vaAUlVhTwz/gpFjhjzsA7KsKuyuae9rWLIX7dnh9JlPF7+8B6A4m5PzTG8qpYdu2Hl4dVKk4SquRB/o8W6oXg5EVh+aLOXboUpgU7VN2wi08bQl2LeeGrfeQlFwJPhRjyEC9ZHvaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M45bAwyJ; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwZ0DFoUwRm6un1LyIwr5EizC3f7yXK79x+AjM3Fp0OmJizrH0emhq320NRBDKcVQ2Q/Z0ixdTQka4Qt/Cd82kUHlQXTmSsi0b9oARNOcxwY/Mg9vi5euvRWbEUugKbmXBEXQO+JO7azFFOCElozA7adF9nhuuQ8A3aG6Ie8UAl8xJeHvTYXqsZP0AonJhxUVxNtJs0aQ/mzze3yv8al1TAns0aQxibZEADRXZYtb7dLgghkLX0bTqVCcH2diQaUb/qaZva90bCd0XbLKPiEawFV0bmJZgd89uUSVExeRzAQvWm3BCTEk6iY86UD6Ig0l6J5jspCKb1c+Yw4WPp+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSs7jA2yNBMm04B2v5uKP8iyThfh+0AMlXh9y8JOvmM=;
 b=oDYiZOTPFtyWZL1O9eLR5hSi30qRiqAUP1oVtmavY5RRh5AsWK0U2VEoGE5so1/76t+S1vsuk5h3yFdqC5AlKC6jfT5/Xasc8if2oyScENtDAwbGcnxqGMPrtGE5XzGGd4KyzU563xcScyk/+kejwJ2aS69JH5PTxWD0d9VpsYcJGbz/VVz0V4zivfczMPGUG6dzYknxjFN300v9mgSF1WT3J1ZPENbKKdZJIyJD+hd1Xu5Nkk6FddA6ZvWAFjLlss9nZIGAYg3SYcz+H9FtF4DHwtv5QmgfQPn7pbZb4ANn/Z80BCbJzyuBFO5GSYRqRCPk4RQnSORoV4hashgggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSs7jA2yNBMm04B2v5uKP8iyThfh+0AMlXh9y8JOvmM=;
 b=M45bAwyJZ4ODwhrU4jfyzf4YO5JC3lfKL/X1BNbIGGLkIH7q8uHJnLWefCfYSRPy77aVclfggCuZwKG3OeOVjtjbCyUPFWBHdH47qCgujVnGjQFhgIGtyMlD6AcDxFsPmRRTK5zU+MKsh9l7ZoIna1BAjuukwrDfkVlkUKcDxiipaZTydsybyVI+iEu3qLI5iAWpLZ3YHwIq5X0EHTguXTmcKVAHbvgCFYf7r2DBEANDu0zAtY8dc3BYWEo++wE6ZDvE4RiAm31AzgukQlyadYW2v/1sy+bsk1gTIuTsJOVxHe+3g4Qk40+7pv+7ehweEb9RLjR568PWvc70Q6e3AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9116.eurprd04.prod.outlook.com (2603:10a6:10:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 03:21:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 03:21:37 +0000
Date: Wed, 4 Sep 2024 23:21:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: nxp,imx95-blk-ctl: Correct
 compatible entries by alphabetical order
Message-ID: <ZtkjuBsFCzovkJtD@lizhi-Precision-Tower-5810>
References: <1725503468-22105-1-git-send-email-hongxing.zhu@nxp.com>
 <1725503468-22105-2-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725503468-22105-2-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: bd377cf4-30a5-447b-6556-08dccd59da1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N7lMpX6eLRO0BAkA8VdQR2Fp9LAfx9EDf2zHXiLXr6c7biyesQziT2GzYG77?=
 =?us-ascii?Q?W1EsUxyCUNZFy17t+wBGZMuJGZdyCDAI19tMnTJP9/7NnecVj2I4tqm7rCRp?=
 =?us-ascii?Q?3DN+0E9jclhaW0F3DpTcrJcSkYAWxJfuoWBKaHEhlCdG5GrwvuJjvDXvxw4s?=
 =?us-ascii?Q?x1mFLnSXuvQGwVXeZ714GwDVfhKB0XPA+AzRoRrcf4FyG7aVYxHBKmTiN2tR?=
 =?us-ascii?Q?NIqbFeXnmmmImIVSGYHm+ABojWV34udN5wWHQXL5NwuqJ7osHRWbP0nU6zW9?=
 =?us-ascii?Q?JADYt0WXcCBWGo54XSQwXXJyVPq4N39MOfEAoSqJbA0WSTlSMkOXF8PlRibI?=
 =?us-ascii?Q?rvwfk+FfxB43kazUSujE1yB15EZvhN+mrPVEoIh6thUAHaW1NnQ0wWwMUIbc?=
 =?us-ascii?Q?KATVGWBet10hEbPrwb+cOO1nkTWQ7by3qIah9BGDIzBZL2fZ9E01VOysXYhf?=
 =?us-ascii?Q?g9/+RnL2ivKV74OXQXrjY2gpG58hTf8fXDK05dwqK3ZxRLhSqZfFmXkx6KpF?=
 =?us-ascii?Q?IS3rL8W4ZqTU1RTPbJyEgfIptm8aBsXRtOuXUyXuFBd5+MtVGItW8ak+hbwa?=
 =?us-ascii?Q?7Sz4zQQDv3ls3niRP9grf6wLmfvqxg0FctGViwF6Qpaan4r8z2isJF9srUwF?=
 =?us-ascii?Q?stquHXWz6ZPRbAw5tp6byfqEfro5ZnZyNg6v7eQaa0jMbY5AFBfyIqqEERdf?=
 =?us-ascii?Q?79K883TU81nb8PvI6UheXrCKLvLfeu77zpTkVQxzh+AYJtL5+A0AIGW4YrQj?=
 =?us-ascii?Q?4I7dXMjofZJPT5nJWpTwspLoKF5TtgSrROKvvLbg2XhQHMrI4Jyd/HKSeOg6?=
 =?us-ascii?Q?sKgEnz9OWwWGtu9tOeOVQLmpcjknBdcWC6Ou1G9JqPQL9Iag8GMnunYOfUlQ?=
 =?us-ascii?Q?gsXo/wTGd6i/Zx10TMynwSRDPaKG1EvWvwj6F/X25m6ZWkmHAblVZHHoq945?=
 =?us-ascii?Q?KvdL/9iOLmis7xaTd2cLhH0B5eHJKXda6SCYg7t7qSR9lzeLagPfScVNZ7AN?=
 =?us-ascii?Q?yleAX+eJBHMaevCg7IT23jWY77c47CB8KmI8tHo5znrUMTrxSnBGuqMzrJoQ?=
 =?us-ascii?Q?QF5a7zf48u+YaBd36NRuhQlT+08fFjEJHuPsjzQsV4J4+mLbL7U1Tcq6SFDE?=
 =?us-ascii?Q?ldfOWr3/07Tg8gGbKi9m1fIOeYrMWVGZnlEipAE7MUR/Q+aL0k/JZGQ7U50m?=
 =?us-ascii?Q?hXJU8PKPT64IAA+y8nRqZt2NylnwBexvy1SK/Wix4F50tPi8WM4BuXmWzd6L?=
 =?us-ascii?Q?KWBQctp/2vPCVwOVCgKbscEEgLuhKVV05nNsS1R9tKA75eYC6SdufWZmGpSn?=
 =?us-ascii?Q?ZnI9Sx1YaHmwlwaszVVsPaZZK4mRxUY+iWmvlyiJldtYDSwM6iDddZ6oFpeT?=
 =?us-ascii?Q?TS14NG2FdvcM/3Hhb1lmv/G3UVuJhME1pIangmXsHMzjDGe5Og=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KNupv73BnEiPJh00ZtnchbOLHARCL9j+kBoLdJm7L1SY0ppkfsIQEuYzSpzx?=
 =?us-ascii?Q?juak2F92QhkqUi5Dr3Rd6XflVMBIPvWdKME0QNNJCwkdzCcycVaF/wdmvnRh?=
 =?us-ascii?Q?hWWZtNCGceUPTOtqWn7imyZyN7dtZXSi4tqbqY9j59z/JNBxgBWDt1dW5gDb?=
 =?us-ascii?Q?HQqxlEyRwnqRklGOaFUB23dvvkc0fvw2jF7nuKUXzNZkQMcJOD2H4PvblSob?=
 =?us-ascii?Q?gJXB8SbU/3nubhM09qEyyfTI9JbiTqIaUzLYibwzh5Hpxd3HobY0djjl5jge?=
 =?us-ascii?Q?dqCbCZP617AWQf3XIwoNoRX1qi8wiz/6uNrFLiNM4ItfUsqZJDHnD7QgxPj7?=
 =?us-ascii?Q?UaxiyBIPyHsC1KQGEp27vvP65G4q7SpClGlR3tQp8iHw90maXc5BUmOlAjJo?=
 =?us-ascii?Q?GronoNW3ErVQx3IlJ/GG5saMvf4oMZURnhFrttTReYNZAh5mto+ioHpSmm/s?=
 =?us-ascii?Q?slVx811reoqX99mqVGbD9Jm6SYgTKvF4HtrgKiocLmQZNYR6jmqbtn1Et/Ia?=
 =?us-ascii?Q?DfJufx9KPi8FKki09ftOWWve2B3wqtEynhQsH2Z4RfHFZb/szW/8wAQcm8/j?=
 =?us-ascii?Q?kMw/CxOnaV5oGLk3F58/BuSpUnjOuWwP/Iymu2bYDyFzxawi60vMnVppxD/A?=
 =?us-ascii?Q?na6nvUQ0U1mNWEW4+MQeJ/iusgC1bNpZh3YRX322SDl9ASmPgwBKrPGptrdd?=
 =?us-ascii?Q?fD1/HNYctRs7XUX/t52hoIvYZLlHRS3maX1EUvPqAjiRRKPTKGmxe/Ll06/N?=
 =?us-ascii?Q?Ebq85ON/FY7OgefeJRtqHQMlDE6R7vvknCLy9yHQlIccSqL1N0X/yOZG8OFu?=
 =?us-ascii?Q?NKBOVbDi4jMnWIpJcRHhQKC7ayKESh4Mt2MIMbBkzSJO92Qor7b5IQnk5uy9?=
 =?us-ascii?Q?6UFN8Is3Tq6VPdLgTezzZKmrhzc00dGIIREsT0yxD6XmlcDtPbUx0z12BmfE?=
 =?us-ascii?Q?qXr0m7zey+bts0EiDAkSHt6+1kWumdz1jsmzjWQrqeby1m++FXEkMWjPvCO9?=
 =?us-ascii?Q?eimv1+jmQDoZAqEEzX12EGC8u5wb6f84IP/0kQGEUjjhrx/WoRET2zlmt8V/?=
 =?us-ascii?Q?K/UTMRa2MbMGJJcBraZCP4rBLLwN/UkbZ+8SrE1fvp5TJukpPAVz9s1EIvcc?=
 =?us-ascii?Q?VMT4G1Xu2z5gmYtryqQEiXle5sxhVTo0nI/FXMDYAmc2Um9JR0yr4sjntEXH?=
 =?us-ascii?Q?5iGd5iWFn2OfO/3dxcYRlNjzSQSiNC13hsI7X23zYbRB8pKC3pQ4G8d5BNtO?=
 =?us-ascii?Q?Zdp7qOzCw9Cbhf1vUx7Z/M8h2S/Mndh5hQxTnZ6sE7KB1cMIivDhwvv+1cmt?=
 =?us-ascii?Q?1rthTqmVzIZiu/43Pc/JzIh3CX6nBYFCi2T5hqgoJRETsQb/Cjw5ug1bh+dB?=
 =?us-ascii?Q?+m0Z1YGwZ5aJUobfOh84l2e4u94qFx5Uyr5Lq08Z3nkXNRFikJkpXT7fERak?=
 =?us-ascii?Q?xblmRKP/0nLMb8KRo6GSeWtwwbMOTVSORI1QSw8DVc0NnlPl429RsbdvLvjo?=
 =?us-ascii?Q?+E0IDL0gfx7VMYjIOPSzJx+m/GwYpx85Qv46a6hIiE10IiMw7qMMuUrYvjwN?=
 =?us-ascii?Q?WQXn6QbW+rPJPjfsFQxYvFdRl+DpfNJQAAfrfg4j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd377cf4-30a5-447b-6556-08dccd59da1f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:21:37.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn/w+Dw6oaAxoZ3E9f3/Yh4OGm3K2ZK4fkcJX1exs7e1FtSepoefo0cmhJ/9ZoKS/QgYQMSsQ8dONOSpP61rxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9116

On Thu, Sep 05, 2024 at 10:31:06AM +0800, Richard Zhu wrote:
> No function chanegs, correct compatible entries by alphabetical order.

nit:

Sort compatible entries by alphabetical order.

Frank

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> index 2dffc02dcd8b..6a928735e00d 100644
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> @@ -13,9 +13,9 @@ properties:
>    compatible:
>      items:
>        - enum:
> -          - nxp,imx95-lvds-csr
> -          - nxp,imx95-display-csr
>            - nxp,imx95-camera-csr
> +          - nxp,imx95-display-csr
> +          - nxp,imx95-lvds-csr
>            - nxp,imx95-vpu-csr
>        - const: syscon
>
> --
> 2.37.1
>

