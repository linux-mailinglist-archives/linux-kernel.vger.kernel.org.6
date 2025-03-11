Return-Path: <linux-kernel+bounces-556776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ABCA5CE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF585166062
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C4626158C;
	Tue, 11 Mar 2025 18:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F8DkDEDU"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93692263C6A;
	Tue, 11 Mar 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719574; cv=fail; b=KYXwDSA4k6asc238EnqIqYd2k/taTtcGtORR4o1xRqeVM3UBxrK/gNPl7pGsHpHfF7DTC/nG+NsbFcs26JrjT41m1yqAVtLgCvV/vP4slyXYL5FBt3A5I1eAPRqJP+a3qqIP06YXTYKOcA63RauGTpi2DDKeJ8viXqlt+XXeTUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719574; c=relaxed/simple;
	bh=PbqAbRRqUHFKurMueGoP3KTrZE561qgmlY4doEMksOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bHs8KF+8fDiS4h6lS2RRJMRz52LEDtbYMY8WA3c6XlmUi+3CXnDclcIH5EMtMk8RCp9AGyi3B/eZ07c0XhDwTaRbzH/il7vWWwgCIo3NxkHj8z7Wzsq9fWNZTNyOBS4ym/u01RJMdfQ/26juu8NqtMt5aNFZbVuYG64wWbaqrl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F8DkDEDU; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aL9C+f7ykwUFhXDtSJwzjL9HgbSY7Tof/4Hk0fsM6CrgirIoEmMD866/xmz0RbMAfMwmLgCxhoPKs9GKoiDVOfclY/UFpcdEcI4Gwzca9QvEqP7sPQzpt5Xx0vDXv9wzG6DNp1Blw6FUBzvDZD68MrJlvER0+AsWHV4sjy5H/wJSvSWtl1+iBmTl2TINluXizP00tUEcKGtxgCgi9rx7YZI0ideEiWz0scuZ96oL1OjsIKHEon7B2KePW2OfQULDdrmF7X2HQKhJC8CncgJjgFAyZsPHAaoWvLhzlGhzq104GmergGaWzYkIrFKEK06lYAf+2uVflLoFwC2vaZ5OMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wCbAc5PInEE5qVh2DnU7cM+htQqOcdOaEkTvKHnaIo=;
 b=XTDs5+LFYPuSo70ZIsoDlylEy/0uTq7LrZz7AufJn+/oE61ZJOQVuZnXk3Xf0HbINgkmh3n4f15ummQa6V/Fme3rNi1WgSySrnlwA+5kSaH2F1expYlbL9fCb6YWvJmK5v3r2vDmjyhsq+ZBUcAsrWP5RTqzgn8rlmmvasOZBdXlk2s3jRm/jOoRKjbJC2pHMAqWv8e6gyMhW+hOUdPbJCSoW6kIIAReBnCczHE3VgepU19g67c194lzxHsvT1UsH+K3KOCPAlEJ8zzBRfCY1mHbfyTsCyziPmIz2sB7pEy2UAKStrXCLi03+m3OdhJI/ZhokwwvdxDltmMVUx0iKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wCbAc5PInEE5qVh2DnU7cM+htQqOcdOaEkTvKHnaIo=;
 b=F8DkDEDU+0xJ9zjlbjYGA0HQGWqGdHPxY5uspS/7N6c1exF9MsAs+AxhYhEtt29hqZmfEbWtoTLxJkJmqHdOxLsElowgz2OOAYCj4C95R3IDmuaZxZw7xpMImGsjpDiSesBxQQdMtUnSgcuED9S8uanddVvT9vit/5t+VRKvAymGfmURrcxlrD8UAib7ZGcKPEbczABrRfR8aASb6Sq4MlCPoMNFgZoAAQIjrMCykUqoSiwyPOnxDx9Ka55A1/aay3pnZrLT2bAeBi84m7RyxZMnSVpOnGUFKn74gxwxY5ojxO5d2YNSKe5+ac6DxatZjGrgHR2DRfwLEBaQp3YkEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8367.eurprd04.prod.outlook.com (2603:10a6:102:1c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 18:59:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 18:59:27 +0000
Date: Tue, 11 Mar 2025 14:59:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 5/5] firmware: drivers: imx: adds miscdev
Message-ID: <Z9CIB9P//Tf9Lo5v@lizhi-Precision-Tower-5810>
References: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
 <20250311-imx-se-if-v13-5-9cc6d8fd6d1c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-imx-se-if-v13-5-9cc6d8fd6d1c@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:a03:333::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 36479ad5-e0b5-41a4-82f5-08dd60ced8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZVD3HJjExfXEzAzklhQzA9v53dYQ3u7tTojt0sKEveDMwx+ANsVmmDaFdgq5?=
 =?us-ascii?Q?PgwzzE+q3djfqiUR1Vyg8vP0WAsW+5PlpmpgWPFhCn0yGfxbenLf+NfAhPhZ?=
 =?us-ascii?Q?Ko6/lTyczLanYHLXkTdJMUjr4EJgmTWgOMTK3Ic5jyUgVC2rPiagkz7NX6xG?=
 =?us-ascii?Q?OeYA0d5yQGQlzSRLdgVGkcG+zAZfMC0mrVc7fd5hoZVUNLY1SfpIhLfDbKDy?=
 =?us-ascii?Q?BqPq/CmcBclX5UOLX+w7ktTaVcznjuaYGMBXaue0vQ1+9mTafQqdYH9LnX4X?=
 =?us-ascii?Q?wrOURrYFqMQaX5HC5E/Vy2SRzCejutb8gu0aBTPzK1UuS92RVjUwCxUuBxyl?=
 =?us-ascii?Q?Qh3KUvdlLiE/eWk1I+1eCSAVJiBxyhR5yUUxvjCR/3jsDmGmisI8Ybl1D8yA?=
 =?us-ascii?Q?uSas3XfcoTzExrR0Rbl0ByhXNW4L6DYJV4YALvJLlOmyLl30OzPoAdkcqhhm?=
 =?us-ascii?Q?mGsXRIiALf13xj+x+xcO4sH64lsAXuy/tNw8tuW8NTEo2zihagqxgfrcGYF3?=
 =?us-ascii?Q?CmEzEVPlivn2PU1oQdT077klr6TCddrFE/h3w4gnfH7dcmqpIpoS107pBZcv?=
 =?us-ascii?Q?vJ8AevjdXlenLZt0biaFS8W0gki2ImavfunxwWqnTD2zMmnwie+OTevqzirk?=
 =?us-ascii?Q?8NUy8H1x5nitRoMjvYqljZvso152hGdll7zNc+P+33JELXVqg7dfLMX/BF/J?=
 =?us-ascii?Q?qpXNtKWb0zmdIjtzNL1E66aAD7JgQiSO2a/+LR7Jq54Hdo1KANjYgOg4s8fo?=
 =?us-ascii?Q?RBHXwiTVKHFBWqDzisE4Bjx3wpIO4TbCgR33UFJxr34+HHm+yuNkmpEUBMAH?=
 =?us-ascii?Q?zDh8sBH4RtN0/3taO419XcJDH8r3/iqlxg+ez+XoJxwMTO9p28GWc/nbKWhz?=
 =?us-ascii?Q?dg95/JODgCV7NyZngfjd/a3wH+Pl9QQOqXhF5oFqGkhjVXJPmuQCHcUFojrb?=
 =?us-ascii?Q?LWngLFk5S0qCd5OP4tZmZ+Mw7OtyvyYZpZgnLYTT9pQ6hWkkuq9zQys5CxRp?=
 =?us-ascii?Q?9YkSqLhhgJu3szO7r0gYYXvFlGeQ9/8LoDyVd+P14I5hAtpSFhUNOt+Zdojv?=
 =?us-ascii?Q?hDh2aXlrgFtONU2YSLI9F0rO40cg2gAyhO+vXA6zS1Bdhdfhw+Ap4Fhavi94?=
 =?us-ascii?Q?84svOxP+pVGRXpYR17SQtbo/Zeq/8KZkJxflCJ9qfDpGizdA+areZCxDMXf6?=
 =?us-ascii?Q?EZVg82k5uCnwff9B4/j1Oxrttmqsn3kTrviTb8egW+1zgzY9c+B0LpPohbTJ?=
 =?us-ascii?Q?AoVF1FJQjwqATiEM9Z8x1nKPkFCQEpofQEtWzrpR3F7f/aBji3gl1NhVv41l?=
 =?us-ascii?Q?piq69m0G/KuzEsGO2OpizL+RAc6LXRmWL9wMO+mJuMCUr8+W3g77yqiNW9Md?=
 =?us-ascii?Q?J6dAHdXxXVcLaIshzUQM+7KEesDyV03TLauaTT0fOZhatLfhbglVOFXJGRo0?=
 =?us-ascii?Q?aCyf2a4b/dyfUrRUbku1aP3nJE7HEY6G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tp5TigD0kueLNKoYEZ8wBWMdW0ucgEFayXnyxnxs0dljEJIRnfYRD2Vek+uO?=
 =?us-ascii?Q?q0APk1mDYvM82bXgNEnDFhgptHU7Kcw1lf9/yaz3N6KK5CPuJJFJ98V1Yjo2?=
 =?us-ascii?Q?nsf2JxZrYXYADTcmxsQjksURyDpmAgpSGNB0M1MsleNYoP9WlbltpU/m3u0m?=
 =?us-ascii?Q?sZsNG0HIt44+ARim9qigHQ6TSbrGl/37fEo5J/OfYXj9TIcBMsiwSDDNbdbv?=
 =?us-ascii?Q?1U+8IPZWledf7tuR8kk6ca2E7zpcEdmcjEIkj1mTOqBYqWkLrmHaSl7wx1AK?=
 =?us-ascii?Q?XUtpR4azbqLElezREQItTqIEU5zlV9Jz8lkGQbsvOzJKq8qIZq1rJopm5xMj?=
 =?us-ascii?Q?MIcIxkQTlRSCdZAXk7LRMvW2iB8WaccGTK2uHdljz+jqZwCqP62Ovbna98NW?=
 =?us-ascii?Q?pYrfFjq0ERsaF0ExIIc7DFpqyCytKxBK5wFYqftFtufHM0gzwYo8xfGsY6gf?=
 =?us-ascii?Q?cmhoNFV5ut8hGIkyHf06ziT0ceyDpVp1E59qZKTkvZvnr0Rt7e4+MdxGqrSZ?=
 =?us-ascii?Q?lCKOyGyUtP3wZx2GYb/wDbKzlzMgHwLNqdSvqaeUc2THoVuGziW6LPrL+YO9?=
 =?us-ascii?Q?+gvgO7pp+VkCXCoPQc3rxt28pn/31oUUOvrN5mdnreDKPfKvVv+LiAhSxuLr?=
 =?us-ascii?Q?tkStcGRmDRysQpTCfKGJL5mqVyi81D68m1JvVvyNwsXzW8U3kwlYsPoIsoVY?=
 =?us-ascii?Q?hvxHI7u1wmcyJc+bpudhy1EesO/C1WyyWViUHlBIBjs5XKWxk81GtuPqCf3f?=
 =?us-ascii?Q?nvxeJiaWGicHP0sbL2VlRlepiFYozAwrLdCgy7F/NXKFJO5D+7U9w7J5+qeq?=
 =?us-ascii?Q?gGsxFwqihrcJ02YMcO1Z8YK5Q6mzOyp2WHZjKxxJyMnsn1wmdZMtmnu9BXvB?=
 =?us-ascii?Q?3JqMG7SCBsFzULlhDBrN9EhDL3a9gPAIYb5EOnL+ZHfeZmEW16jOoFtnsODX?=
 =?us-ascii?Q?3JoJHHZ2v/LmnQJ9/GbXEJd5DM8aMhwQToUvSddOIoILRJ7nzsUK7MfDwUXT?=
 =?us-ascii?Q?MqkjapQaKnH4XtN/wq7QqDjMzqezD8OxSFSgaUr9bXn7rZienjtHQJ1UGRuj?=
 =?us-ascii?Q?j1Us8NsPMJWLfTBJcPJSH2GWS44Y/zEAJXOuJQmjJLScQxt6NXsu0Fj/f/+r?=
 =?us-ascii?Q?XQ62oWkV9Ciw7I6nIR0OINzkaswRPmEQgUm0mAtKuhCa8/rV0IjUn/VnHYCF?=
 =?us-ascii?Q?WJIDQvC+G7OYtiHD5Te69fhQ8INKiKy5ABtRxI1QlTUBBDSfccjx+ORb3h0e?=
 =?us-ascii?Q?8CnvkvUI7EbhtN4sTpHwCuLnJ+4iJ7sqimj9v++703JZvgmJ8wdpu41dpJsB?=
 =?us-ascii?Q?KHvl7vj+Yjyw4BUK4IxllWfAKM6yeEr453L8zv3XYn4hhOfMF1kBjQwp68t3?=
 =?us-ascii?Q?pJGmbiGYpRrbyRGCVwoz8HWq1CX2K7qcsRiZ9NLFdopqR1m9AiNR1sepDi+l?=
 =?us-ascii?Q?fH68h1AogIzMVrZ8abC94pPUQjJhuBJkq5IylaGbk/RjaImEQ0vrCkApZ1ZA?=
 =?us-ascii?Q?HcvBc3Uf+WnLoeK5WncRtAmSTp/J+Cg9z11rtkvTfsZNhAZg+GPdRGLcT8rh?=
 =?us-ascii?Q?pBhqEFTOvKS8jQdcMenHLSjJs7R3d+YCoJqa8+TR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36479ad5-e0b5-41a4-82f5-08dd60ced8a3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 18:59:27.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwIhjzXo7hs4TUYJ3gqAawzdSW9ZpAv2PLeqbZqWz7dlWOY+g3qASAq7pG1j6YhCo9TJsgnkDiWdkRb63AO+Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8367

On Tue, Mar 11, 2025 at 09:09:36PM +0530, Pankaj Gupta wrote:
> Adds the driver for communication interface to secure-enclave,
> for exchanging messages with NXP secure enclave HW IP(s) like
> EdgeLock Enclave from:
> - User-Space Applications via character driver.
>
> ABI documentation for the NXP secure-enclave driver.
>
> User-space library using this driver:
> - i.MX Secure Enclave library:
>   -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
> - i.MX Secure Middle-Ware:
>   -- URL: https://github.com/nxp-imx/imx-smw.git
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  Documentation/ABI/testing/se-cdev   |  43 ++
>  drivers/firmware/imx/ele_base_msg.c |  11 +-
>  drivers/firmware/imx/ele_common.c   |  77 +++-
>  drivers/firmware/imx/ele_common.h   |  10 +-
>  drivers/firmware/imx/se_ctrl.c      | 775 +++++++++++++++++++++++++++++++++++-
>  drivers/firmware/imx/se_ctrl.h      |  43 ++
>  include/uapi/linux/se_ioctl.h       | 101 +++++
>  7 files changed, 1029 insertions(+), 31 deletions(-)
>
> diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
> new file mode 100644
> index 000000000000..dad39ffd245a
> --- /dev/null
> +++ b/Documentation/ABI/testing/se-cdev
> @@ -0,0 +1,43 @@
> +What:		/dev/<se>_mu[0-9]+_ch[0-9]+
> +Date:		Mar 2025
> +KernelVersion:	6.8
> +Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
> +Description:
> +		NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
> +		Enclave(ELE), SECO. The character device file descriptors
> +		/dev/<se>_mu*_ch* are the interface between userspace NXP's secure-
> +		enclave shared library and the kernel driver.
> +
> +		The ioctl(2)-based ABI is defined and documented in
> +		[include]<linux/firmware/imx/ele_mu_ioctl.h>.
> +		ioctl(s) are used primarily for:
> +			- shared memory management
> +			- allocation of I/O buffers
> +			- getting mu info
> +			- setting a dev-ctx as receiver to receive all the commands from FW
> +			- getting SoC info
> +			- send command and receive command response
> +
> +		The following file operations are supported:
> +
> +		open(2)
> +		  Currently the only useful flags are O_RDWR.
> +
> +		read(2)
> +		  Every read() from the opened character device context is waiting on
> +		  wait_event_interruptible, that gets set by the registered mailbox callback
> +		  function, indicating a message received from the firmware on message-
> +		  unit.
> +
> +		write(2)
> +		  Every write() to the opened character device context needs to acquire
> +		  mailbox_lock before sending message on to the message unit.
> +
> +		close(2)
> +		  Stops and frees up the I/O contexts that were associated
> +		  with the file descriptor.
> +
> +Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
> +		https://github.com/nxp-imx/imx-smw.git
> +		crypto/skcipher,
> +		drivers/nvmem/imx-ocotp-ele.c
> diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
> index eea86f50d276..ed70728f5418 100644
> --- a/drivers/firmware/imx/ele_base_msg.c
> +++ b/drivers/firmware/imx/ele_base_msg.c
> @@ -62,7 +62,7 @@ int ele_get_info(struct se_if_priv *priv, struct ele_dev_info *s_info)
>  	tx_msg->data[0] = upper_32_bits(get_info_addr);
>  	tx_msg->data[1] = lower_32_bits(get_info_addr);
>  	tx_msg->data[2] = sizeof(*s_info);
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,

Use seperate patch to change this trivial update to reduce review efforts.

>  			       tx_msg,
>  			       ELE_GET_INFO_REQ_MSG_SZ,
>  			       rx_msg,
> @@ -128,7 +128,7 @@ int ele_ping(struct se_if_priv *priv)
>  		return ret;
>  	}
>
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_PING_REQ_SZ,
>  			       rx_msg,
> @@ -177,7 +177,8 @@ int ele_service_swap(struct se_if_priv *priv,
>  	tx_msg->data[3] = lower_32_bits(addr);
>  	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
>  					 ELE_SERVICE_SWAP_REQ_MSG_SZ);
> -	ret = ele_msg_send_rcv(priv,
> +
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
>  			       rx_msg,
> @@ -230,7 +231,7 @@ int ele_fw_authenticate(struct se_if_priv *priv, phys_addr_t addr)
>  	tx_msg->data[0] = lower_32_bits(addr);
>  	tx_msg->data[2] = addr;
>
> -	ret = ele_msg_send_rcv(priv,
> +	ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  			       tx_msg,
>  			       ELE_FW_AUTH_REQ_SZ,
>  			       rx_msg,
> @@ -284,7 +285,7 @@ int ele_debug_dump(struct se_if_priv *priv)
>  		fmt_str_idx = 0;
>  		memset(rx_msg, 0xCC, ELE_DEBUG_DUMP_RSP_SZ);
>
> -		ret = ele_msg_send_rcv(priv,
> +		ret = ele_msg_send_rcv(priv->priv_dev_ctx,
>  				       tx_msg,
>  				       ELE_DEBUG_DUMP_REQ_SZ,
>  				       rx_msg,
> diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
> index 3fa8182b302f..d63346239936 100644
> --- a/drivers/firmware/imx/ele_common.c
> +++ b/drivers/firmware/imx/ele_common.c
> @@ -6,6 +6,8 @@
>  #include "ele_base_msg.h"
>  #include "ele_common.h"
>
> +u32 se_rcv_msg_timeout = SE_RCV_MSG_DEFAULT_TIMEOUT;
> +
>  u32 se_add_msg_crc(u32 *msg, u32 msg_len)
>  {
>  	u32 nb_words = msg_len / (u32)sizeof(u32);
> @@ -18,33 +20,57 @@ u32 se_add_msg_crc(u32 *msg, u32 msg_len)
>  	return crc;
>  }
>
> -int ele_msg_rcv(struct se_if_priv *priv,
> +void set_se_rcv_msg_timeout(u32 val)
> +{
> +	se_rcv_msg_timeout = val;

Do you intent to use the same timeout value for all instance?


> +}
> +
> +int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
>  		struct se_clbk_handle *se_clbk_hdl)
>  {
> -	int err = 0;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	bool wait_timeout_enabled = true;
> +	unsigned int wait;
> +	int err;
>
>  	do {
> -		err = wait_for_completion_interruptible(&se_clbk_hdl->done);
> +		if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {
> +			/* NVM-D, SE-FW slave waits indefinitly. */
> +			wait_timeout_enabled = false;
> +			err = wait_for_completion_interruptible(&se_clbk_hdl->done);
> +		} else {
> +			/* FW must send message-response in a finite time. */
> +			wait = msecs_to_jiffies(se_rcv_msg_timeout);
> +			err = wait_for_completion_interruptible_timeout(&se_clbk_hdl->done, wait);
> +		}


wait = priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx ?
	MAX_SCHEDULE_TIMEOUT : msecs_to_jiffies(se_rcv_msg_timeout);

left = wait_for_completion_interruptible_timeout(&se_clbk_hdl->done, wait);

>  		if (err == -ERESTARTSYS) {
> -			if (priv->waiting_rsp_clbk_hdl.rx_msg) {
> +			if (priv->waiting_rsp_clbk_hdl.dev_ctx) {
>  				priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
>  				continue;
>  			}
> -			dev_err(priv->dev,
> -				"Err[0x%x]:Interrupted by signal.\n",
> -				err);
>  			err = -EINTR;
>  			break;
>  		}
> -	} while (err != 0);
> +		if (err == 0) {
> +			if (wait_timeout_enabled) {
> +				err = -ETIMEDOUT;
> +				dev_err(priv->dev,
> +					"Fatal Error: SE interface: %s%d, hangs indefinitely.\n",
> +					get_se_if_name(priv->if_defs->se_if_type),
> +					priv->if_defs->se_instance_id);

simple logic use left;

> +			}
> +			break;
> +		}
> +	} while (err < 0);
>
> -	return err ? err : se_clbk_hdl->rx_msg_sz;
> +	return (err >= 0) ? se_clbk_hdl->rx_msg_sz : err;

needn't ()

>  }
>
> -int ele_msg_send(struct se_if_priv *priv,
> +int ele_msg_send(struct se_if_device_ctx *dev_ctx,
>  		 void *tx_msg,
>  		 int tx_msg_sz)
>  {
> +	struct se_if_priv *priv = dev_ctx->priv;
>  	struct se_msg_hdr *header;
>  	int err;
>
> @@ -56,7 +82,8 @@ int ele_msg_send(struct se_if_priv *priv,
>  	 */
>  	if (header->size << 2 != tx_msg_sz) {
>  		dev_err(priv->dev,
> -			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
> +			"%s: User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
> +			dev_ctx->devname,

put this change to seperated patch, which include below change.
	-     ret = ele_msg_send_rcv(priv,
	+     ret = ele_msg_send_rcv(priv->priv_dev_ctx,

>  			*(u32 *)header,
>  			header->size << 2, tx_msg_sz);
>  		return -EINVAL;
> @@ -64,7 +91,9 @@ int ele_msg_send(struct se_if_priv *priv,
>
>  	err = mbox_send_message(priv->tx_chan, tx_msg);
>  	if (err < 0) {
> -		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
> +		dev_err(priv->dev,
> +			"%s: Error: mbox_send_message failure.",
> +			dev_ctx->devname);
>  		return err;
>  	}
>  	err = tx_msg_sz;
> @@ -73,32 +102,36 @@ int ele_msg_send(struct se_if_priv *priv,
>  }
>
>  /* API used for send/receive blocking call. */
> -int ele_msg_send_rcv(struct se_if_priv *priv,
> +int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
>  		     void *tx_msg,
>  		     int tx_msg_sz,
>  		     void *rx_msg,
>  		     int exp_rx_msg_sz)
>  {
>  	int err;
> +	struct se_if_priv *priv = dev_ctx->priv;
>
>  	guard(mutex)(&priv->se_if_cmd_lock);
>
> +	priv->waiting_rsp_clbk_hdl.dev_ctx = dev_ctx;
>  	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
>  	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
>
> -	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
> +	err = ele_msg_send(dev_ctx, tx_msg, tx_msg_sz);
>  	if (err < 0)
>  		return err;
>
> -	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
> +	err = ele_msg_rcv(dev_ctx, &priv->waiting_rsp_clbk_hdl);
>
>  	if (priv->waiting_rsp_clbk_hdl.signal_rcvd) {
>  		err = -EINTR;
>  		priv->waiting_rsp_clbk_hdl.signal_rcvd = false;
>  		dev_err(priv->dev,
> -			"Err[0x%x]:Interrupted by signal.\n",
> +			"%s: Err[0x%x]:Interrupted by signal.\n",
> +			dev_ctx->devname,
>  			err);
>  	}
> +	priv->waiting_rsp_clbk_hdl.dev_ctx = NULL;
>
>  	return err;
>  }
> @@ -144,7 +177,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>  	if (header->tag == priv->if_defs->cmd_tag) {
>  		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
>  		dev_dbg(dev,
> -			"Selecting cmd receiver for mesg header:0x%x.",
> +			"Selecting cmd receiver:%s for mesg header:0x%x.",
> +			se_clbk_hdl->dev_ctx->devname,
>  			*(u32 *)header);
>
>  		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
> @@ -153,7 +187,8 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>  		 */
>  		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
>  			dev_err(dev,
> -				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
> +				"%s: CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
> +				se_clbk_hdl->dev_ctx->devname,
>  				*(u32 *)header,
>  				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
>
> @@ -164,13 +199,15 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
>  	} else if (header->tag == priv->if_defs->rsp_tag) {
>  		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
>  		dev_dbg(dev,
> -			"Selecting resp waiter for mesg header:0x%x.",
> +			"Selecting resp waiter:%s for mesg header:0x%x.",
> +			se_clbk_hdl->dev_ctx->devname,
>  			*(u32 *)header);
>
>  		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz &&
>  		    !exception_for_size(priv, header)) {
>  			dev_err(dev,
> -				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
> +				"%s: Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
> +				se_clbk_hdl->dev_ctx->devname,
>  				*(u32 *)header,
>  				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
>
> diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
> index aceb8c891ae6..3cf124f41487 100644
> --- a/drivers/firmware/imx/ele_common.h
> +++ b/drivers/firmware/imx/ele_common.h
> @@ -12,13 +12,17 @@
>
>  #define IMX_ELE_FW_DIR                 "imx/ele/"
>
> +#define SE_RCV_MSG_DEFAULT_TIMEOUT	5000
> +#define SE_RCV_MSG_LONG_TIMEOUT		5000000
> +void set_se_rcv_msg_timeout(u32 val);
> +
>  u32 se_add_msg_crc(u32 *msg, u32 msg_len);
> -int ele_msg_rcv(struct se_if_priv *priv,
> +int ele_msg_rcv(struct se_if_device_ctx *dev_ctx,
>  		struct se_clbk_handle *se_clbk_hdl);
> -int ele_msg_send(struct se_if_priv *priv,
> +int ele_msg_send(struct se_if_device_ctx *dev_ctx,
>  		 void *tx_msg,
>  		 int tx_msg_sz);
> -int ele_msg_send_rcv(struct se_if_priv *priv,
> +int ele_msg_send_rcv(struct se_if_device_ctx *dev_ctx,
>  		     void *tx_msg,
>  		     int tx_msg_sz,
>  		     void *rx_msg,
> diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
> index 12a1ceb87866..f31d97045b89 100644
> --- a/drivers/firmware/imx/se_ctrl.c
> +++ b/drivers/firmware/imx/se_ctrl.c
> @@ -23,6 +23,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/sys_soc.h>
> +#include <uapi/linux/se_ioctl.h>
>
>  #include "ele_base_msg.h"
>  #include "ele_common.h"
> @@ -31,8 +32,6 @@
>  #define MAX_SOC_INFO_DATA_SZ		256
>  #define MBOX_TX_NAME			"tx"
>  #define MBOX_RX_NAME			"rx"
> -#define SE_TYPE_STR_HSM			"hsm"
> -#define SE_TYPE_ID_HSM			0x2
>
>  struct se_fw_img_name {
>  	const u8 *prim_fw_nm_in_rfs;
> @@ -140,6 +139,24 @@ static const struct of_device_id se_match[] = {
>  	{},
>  };
>
> +char *get_se_if_name(u8 se_if_id)
> +{
> +	switch (se_if_id) {
> +	case SE_TYPE_ID_DBG: return SE_TYPE_STR_DBG;
> +	case SE_TYPE_ID_HSM: return SE_TYPE_STR_HSM;
> +	}
> +
> +	return NULL;
> +}
> +
> +static uint32_t get_se_soc_id(struct se_if_priv *priv)
> +{
> +	const struct se_soc_info *se_info =
> +				device_get_match_data(priv->dev);
> +
> +	return se_info->soc_id;
> +}
> +
>  static struct se_fw_load_info *get_load_fw_instance(struct se_if_priv *priv)
>  {
>  	return &var_se_info.load_fw;
> @@ -286,6 +303,742 @@ static int se_load_firmware(struct se_if_priv *priv)
>  	return ret;
>  }
>
> +static int init_se_shared_mem(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +
> +	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_out);
> +	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_in);
> +
> +	/*
> +	 * Allocate some memory for data exchanges with S40x.
> +	 * This will be used for data not requiring secure memory.
> +	 */
> +	se_shared_mem_mgmt->non_secure_mem.ptr =
> +			dma_alloc_coherent(priv->dev,
> +					   MAX_DATA_SIZE_PER_USER,
> +					   &se_shared_mem_mgmt->non_secure_mem.dma_addr,
> +					   GFP_KERNEL);
> +	if (!se_shared_mem_mgmt->non_secure_mem.ptr)
> +		return -ENOMEM;
> +
> +	se_shared_mem_mgmt->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
> +	se_shared_mem_mgmt->non_secure_mem.pos = 0;
> +
> +	return 0;
> +}
> +
> +static void cleanup_se_shared_mem(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +
> +	/* Unmap secure memory shared buffer. */
> +	if (se_shared_mem_mgmt->secure_mem.ptr)
> +		devm_iounmap(priv->dev,
> +			     (void __iomem *)se_shared_mem_mgmt->secure_mem.ptr);
> +
> +	se_shared_mem_mgmt->secure_mem.ptr = NULL;
> +	se_shared_mem_mgmt->secure_mem.dma_addr = 0;
> +	se_shared_mem_mgmt->secure_mem.size = 0;
> +	se_shared_mem_mgmt->secure_mem.pos = 0;

where init secure_mem? not symetric with init_se_shared_mem()

> +
> +	/* Free non-secure shared buffer. */
> +	dma_free_coherent(priv->dev, MAX_DATA_SIZE_PER_USER,
> +			  se_shared_mem_mgmt->non_secure_mem.ptr,
> +			  se_shared_mem_mgmt->non_secure_mem.dma_addr);
> +
> +	se_shared_mem_mgmt->non_secure_mem.ptr = NULL;
> +	se_shared_mem_mgmt->non_secure_mem.dma_addr = 0;
> +	se_shared_mem_mgmt->non_secure_mem.size = 0;
> +	se_shared_mem_mgmt->non_secure_mem.pos = 0;
> +}
> +
> +/* Need to copy the output data to user-device context.
> + */
> +static int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_buf_desc *b_desc, *temp;
> +	bool do_cpy = true;
> +
> +	list_for_each_entry_safe(b_desc, temp, &se_shared_mem_mgmt->pending_out, link) {

Why not need lock here?

> +		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr && do_cpy) {
> +			dev_dbg(priv->dev,
> +				"Copying output data to user.");
> +			if (do_cpy && copy_to_user(b_desc->usr_buf_ptr,
> +						   b_desc->shared_buf_ptr,
> +						   b_desc->size)) {
> +				dev_err(priv->dev,
> +					"Failure copying output data to user.");
> +				do_cpy = false;

return -EFAULT ? So needn't do_cpy.
missed  list_del(&b_desc->link) and kfree() for copy_to_user fail case.

> +			}
> +		}
> +
> +		if (b_desc->shared_buf_ptr)
> +			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +		list_del(&b_desc->link);
> +		kfree(b_desc);
> +	}
> +
> +	return do_cpy ? 0 : -EFAULT;
> +}
> +
> +/*
> + * Clean the used Shared Memory space,
> + * whether its Input Data copied from user buffers, or
> + * Data received from FW.
> + */
> +static void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
> +	struct list_head *pending_lists[] = {&se_shared_mem_mgmt->pending_in,
> +						&se_shared_mem_mgmt->pending_out};
> +	struct se_buf_desc *b_desc, *temp;
> +	int i;
> +
> +	for (i = 0; i < 2; i++) {
> +		list_for_each_entry_safe(b_desc, temp,
> +					 pending_lists[i], link) {
> +			if (b_desc->shared_buf_ptr)
> +				memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> +
> +			list_del(&b_desc->link);
> +			kfree(b_desc);
> +		}
> +	}
> +	se_shared_mem_mgmt->secure_mem.pos = 0;
> +	se_shared_mem_mgmt->non_secure_mem.pos = 0;
> +}
> +
> +static int add_b_desc_to_pending_list(void *shared_ptr_with_pos,
> +				      struct se_ioctl_setup_iobuf *io,
> +				      struct se_if_device_ctx *dev_ctx)
> +{
> +	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
> +	struct se_buf_desc *b_desc = NULL;
> +
> +	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
> +	if (!b_desc)
> +		return -ENOMEM;
> +
> +	b_desc->shared_buf_ptr = shared_ptr_with_pos;
> +	b_desc->usr_buf_ptr = io->user_buf;
> +	b_desc->size = io->length;
> +
> +	if (io->flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> +		/*
> +		 * buffer is input:
> +		 * add an entry in the "pending input buffers" list so
> +		 * that copied data can be cleaned from shared memory
> +		 * later.
> +		 */
> +		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_in);

Are you sure needn't lock for link?

> +	} else {
> +		/*
> +		 * buffer is output:
> +		 * add an entry in the "pending out buffers" list so data
> +		 * can be copied to user space when receiving Secure-Enclave
> +		 * response.
> +		 */
> +		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_out);
> +	}
> +
> +	return 0;
> +}
> +
> +/* interface for managed res to unregister a character device */
> +static void if_misc_deregister(void *miscdevice)
> +{
> +	misc_deregister(miscdevice);
> +}
> +
> +static int init_device_context(struct se_if_priv *priv, int ch_id,
> +			       struct se_if_device_ctx **new_dev_ctx,
> +			       const struct file_operations *se_if_fops)
> +{
> +	struct se_if_device_ctx *dev_ctx;
> +	int ret = 0;
> +
> +	if (ch_id)
> +		dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
> +	else
> +		dev_ctx = devm_kzalloc(priv->dev, sizeof(*dev_ctx), GFP_KERNEL);

why need distinguish it?

> +
> +	if (!dev_ctx)
> +		return -ENOMEM;
> +
> +	dev_ctx->priv = priv;
> +
> +	if (ch_id)
> +		dev_ctx->devname = kasprintf(GFP_KERNEL, "%s%d_ch%d",
> +					     get_se_if_name(priv->if_defs->se_if_type),
> +					     priv->if_defs->se_instance_id,
> +					     ch_id);
> +	else
> +		dev_ctx->devname = devm_kasprintf(priv->dev, GFP_KERNEL, "%s%d_ch%d",
> +						  get_se_if_name(priv->if_defs->se_if_type),
> +						  priv->if_defs->se_instance_id,
> +						  ch_id);

the same here.


> +	if (!dev_ctx->devname) {
> +		if (ch_id)
> +			kfree(dev_ctx);
> +
> +		return -ENOMEM;
> +	}
> +
> +	mutex_init(&dev_ctx->fops_lock);
> +
> +	*new_dev_ctx = dev_ctx;
> +
> +	if (ch_id) {
> +		list_add_tail(&dev_ctx->link, &priv->dev_ctx_list);
> +		priv->active_devctx_count++;
> +
> +		ret = init_se_shared_mem(dev_ctx);
> +		if (ret < 0) {
> +			kfree(dev_ctx->devname);
> +			kfree(dev_ctx);
> +			*new_dev_ctx = NULL;
> +			return ret;
> +		}
> +
> +		return ret;
> +	}
> +
> +	/* Only for ch_id = 0:
> +	 * - register the misc device.
> +	 * - add action
> +	 */
> +	dev_ctx->miscdev = devm_kzalloc(priv->dev, sizeof(*dev_ctx->miscdev), GFP_KERNEL);
> +	if (!dev_ctx->miscdev) {
> +		*new_dev_ctx = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	dev_ctx->miscdev->name = dev_ctx->devname;
> +	dev_ctx->miscdev->minor = MISC_DYNAMIC_MINOR;
> +	dev_ctx->miscdev->fops = se_if_fops;
> +	dev_ctx->miscdev->parent = priv->dev;
> +	ret = misc_register(dev_ctx->miscdev);
> +	if (ret) {
> +		dev_err(priv->dev, "failed to register misc device %d\n",
> +			ret);
> +		return ret;

return dev_err_probe();

> +	}
> +
> +	ret = devm_add_action(priv->dev, if_misc_deregister,
> +			      dev_ctx->miscdev);
> +	if (ret) {
> +		dev_err(priv->dev,
> +			"failed[%d] to add action to the misc-dev\n",
> +			ret);
> +		misc_deregister(dev_ctx->miscdev);

devm_add_action_or_reset();

> +	}
> +
> +	return ret;
> +}
> +
> +static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx *dev_ctx,
> +					    u64 arg)
> +{
> +	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info = {0};
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_api_msg *rx_msg __free(kfree) = NULL;
> +	int err = 0;
> +
> +	if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 __user *)arg,
> +			   sizeof(cmd_snd_rcv_rsp_info))) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +		goto exit;
> +	}
> +
> +	if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
> +		dev_err(priv->dev,
> +			"%s: User buffer too small(%d < %d)\n",
> +			dev_ctx->devname,
> +			cmd_snd_rcv_rsp_info.tx_buf_sz,
> +			SE_MU_HDR_SZ);
> +		err = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	rx_msg = kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
> +	if (!rx_msg) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	tx_msg = memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
> +			     cmd_snd_rcv_rsp_info.tx_buf_sz);
> +	if (IS_ERR(tx_msg)) {
> +		err = PTR_ERR(tx_msg);
> +		goto exit;
> +	}
> +
> +	if (tx_msg->header.tag != priv->if_defs->cmd_tag) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (tx_msg->header.ver == priv->if_defs->fw_api_ver &&
> +	    !get_load_fw_instance(priv)->is_fw_loaded) {
> +		err = se_load_firmware(priv);
> +		if (err) {
> +			dev_err(priv->dev, "Could not send the message as FW is not loaded.");
> +			err = -EPERM;
> +			goto exit;
> +		}
> +	}
> +	set_se_rcv_msg_timeout(SE_RCV_MSG_LONG_TIMEOUT);
> +
> +	err = ele_msg_send_rcv(dev_ctx,
> +			       tx_msg,
> +			       cmd_snd_rcv_rsp_info.tx_buf_sz,
> +			       rx_msg,
> +			       cmd_snd_rcv_rsp_info.rx_buf_sz);
> +	if (err < 0)
> +		goto exit;
> +
> +	dev_dbg(priv->dev,
> +		"%s: %s %s\n",
> +		dev_ctx->devname,
> +		__func__,
> +		"message received, start transmit to user");
> +
> +	/* We may need to copy the output data to user before
> +	 * delivering the completion message.
> +	 */
> +	err = se_dev_ctx_cpy_out_data(dev_ctx);
> +	if (err < 0)
> +		goto exit;
> +
> +	/* Copy data from the buffer */
> +	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     rx_msg,
> +			     cmd_snd_rcv_rsp_info.rx_buf_sz, false);
> +
> +	if (copy_to_user(cmd_snd_rcv_rsp_info.rx_buf, rx_msg,
> +			 cmd_snd_rcv_rsp_info.rx_buf_sz)) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy to user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +
> +exit:
> +
> +	/* shared memory is allocated before this IOCTL */
> +	se_dev_ctx_shared_mem_cleanup(dev_ctx);
> +
> +	if (copy_to_user((void __user *)arg, &cmd_snd_rcv_rsp_info,
> +			 sizeof(cmd_snd_rcv_rsp_info))) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy cmd_snd_rcv_rsp_info from user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +
> +	return err;
> +}
> +
> +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> +				u64 arg)
> +{
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	struct se_if_node *if_node;
> +	struct se_ioctl_get_if_info if_info;
> +	int err = 0;
> +
> +	if_node = container_of(priv->if_defs, typeof(*if_node), if_defs);
> +
> +	if_info.se_if_id = 0;
> +	if_info.interrupt_idx = 0;
> +	if_info.tz = 0;
> +	if_info.did = if_node->se_if_did;
> +	if_info.cmd_tag = priv->if_defs->cmd_tag;
> +	if_info.rsp_tag = priv->if_defs->rsp_tag;
> +	if_info.success_tag = priv->if_defs->success_tag;
> +	if_info.base_api_ver = priv->if_defs->base_api_ver;
> +	if_info.fw_api_ver = priv->if_defs->fw_api_ver;
> +
> +	dev_dbg(priv->dev,
> +		"%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x]\n",
> +		dev_ctx->devname,
> +		if_info.se_if_id, if_info.interrupt_idx,
> +		if_info.tz, if_info.did);
> +
> +	if (copy_to_user((u8 __user *)arg, &if_info, sizeof(if_info))) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy mu info to user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +
> +	return err;
> +}
> +
> +/*
> + * Copy a buffer of data to/from the user and return the address to use in
> + * messages
> + */
> +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
> +					u64 arg)
> +{
> +	struct se_shared_mem *shared_mem = NULL;
> +	struct se_ioctl_setup_iobuf io = {0};
> +	int err = 0;
> +	u32 pos;
> +
> +	if (copy_from_user(&io, (u8 __user *)arg, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed copy iobuf config from user\n",
> +			dev_ctx->devname);
> +		return -EFAULT;
> +	}
> +
> +	dev_dbg(dev_ctx->priv->dev,
> +		"%s: io [buf: %p(%d) flag: %x]\n",
> +		dev_ctx->devname,
> +		io.user_buf, io.length, io.flags);
> +
> +	if (io.length == 0 || !io.user_buf) {
> +		/*
> +		 * Accept NULL pointers since some buffers are optional
> +		 * in FW commands. In this case we should return 0 as
> +		 * pointer to be embedded into the message.
> +		 * Skip all data copy part of code below.
> +		 */
> +		io.ele_addr = 0;
> +		goto copy;
> +	}
> +
> +	/* No specific requirement for this buffer. */
> +	shared_mem = &dev_ctx->se_shared_mem_mgmt.non_secure_mem;
> +
> +	/* Check there is enough space in the shared memory. */
> +	dev_dbg(dev_ctx->priv->dev,
> +		"%s: req_size = %d, max_size= %d, curr_pos = %d",
> +		dev_ctx->devname,
> +		round_up(io.length, 8u),
> +		shared_mem->size, shared_mem->pos);
> +
> +	if (shared_mem->size < shared_mem->pos ||
> +	    round_up(io.length, 8u) > (shared_mem->size - shared_mem->pos)) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Not enough space in shared memory\n",
> +			dev_ctx->devname);
> +		return -ENOMEM;
> +	}
> +
> +	/* Allocate space in shared memory. 8 bytes aligned. */
> +	pos = shared_mem->pos;
> +	shared_mem->pos += round_up(io.length, 8u);
> +	io.ele_addr = (u64)shared_mem->dma_addr + pos;
> +
> +	memset(shared_mem->ptr + pos, 0, io.length);
> +	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
> +	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
> +		/*
> +		 * buffer is input:
> +		 * copy data from user space to this allocated buffer.
> +		 */
> +		if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> +				   io.length)) {
> +			dev_err(dev_ctx->priv->dev,
> +				"%s: Failed copy data to shared memory\n",
> +				dev_ctx->devname);
> +			return -EFAULT;
> +		}
> +	}
> +
> +	err = add_b_desc_to_pending_list(shared_mem->ptr + pos,
> +					 &io,
> +					 dev_ctx);
> +	if (err < 0)
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to allocate/link b_desc.",
> +			dev_ctx->devname);
> +
> +copy:
> +	/* Provide the EdgeLock Enclave address to user space only if success.*/
> +	if (copy_to_user((u8 __user *)arg, &io, sizeof(io))) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy iobuff setup to user.",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +
> +	return err;
> +}
> +
> +/* IOCTL to provide SoC information */
> +static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
> +					    u64 arg)
> +{
> +	struct se_ioctl_get_soc_info soc_info;
> +	int err = -EINVAL;
> +
> +	soc_info.soc_id = get_se_soc_id(dev_ctx->priv);
> +	soc_info.soc_rev = var_se_info.soc_rev;
> +
> +	err = (int)copy_to_user((u8 __user *)arg, (u8 *)(&soc_info), sizeof(soc_info));

needn't (int)

> +	if (err) {
> +		dev_err(dev_ctx->priv->dev,
> +			"%s: Failed to copy soc info to user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +
> +	return err;
> +}
> +
> +/*
> + * File operations for user-space
> + */
> +
> +/* Write a message to the MU. */
> +static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
> +				size_t size, loff_t *ppos)
> +{
> +	struct se_if_device_ctx *dev_ctx = fp->private_data;
> +	struct se_api_msg *tx_msg __free(kfree) = NULL;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	int err;
> +
> +	dev_dbg(priv->dev,
> +		"%s: write from buf (%p)%zu, ppos=%lld\n",
> +		dev_ctx->devname,
> +		buf, size, ((ppos) ? *ppos : 0));
> +
> +	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;

you can guard() see mutex.h
DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)

> +
> +	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (size < SE_MU_HDR_SZ) {
> +		dev_err(priv->dev,
> +			"%s: User buffer too small(%zu < %d)\n",
> +			dev_ctx->devname,
> +			size, SE_MU_HDR_SZ);
> +		err = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	tx_msg = memdup_user(buf, size);
> +	if (IS_ERR(tx_msg)) {
> +		err = PTR_ERR(tx_msg);
> +		goto exit;
> +	}
> +
> +	print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     tx_msg, size, false);
> +
> +	err = ele_msg_send(dev_ctx, tx_msg, size);
> +
> +exit:
> +	mutex_unlock(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/*
> + * Read a message from the MU.
> + * Blocking until a message is available.
> + */
> +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> +			       size_t size, loff_t *ppos)
> +{
> +	struct se_if_device_ctx *dev_ctx = fp->private_data;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	int err;
> +
> +	dev_dbg(priv->dev,
> +		"%s: read to buf %p(%zu), ppos=%lld\n",
> +		dev_ctx->devname,
> +		buf, size, ((ppos) ? *ppos : 0));
> +
> +	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	err = ele_msg_rcv(dev_ctx, &priv->cmd_receiver_clbk_hdl);
> +	if (err < 0) {
> +		dev_err(priv->dev,
> +			"%s: Err[0x%x]:Interrupted by signal.\n",
> +			dev_ctx->devname, err);
> +		dev_dbg(priv->dev,
> +			"Current active dev-ctx count = %d.\n",
> +			dev_ctx->priv->active_devctx_count);

You can combine to dev_err();

> +		goto exit;
> +	}
> +
> +	/* We may need to copy the output data to user before
> +	 * delivering the completion message.
> +	 */
> +	err = se_dev_ctx_cpy_out_data(dev_ctx);
> +	if (err < 0)
> +		goto exit;
> +
> +	/* Copy data from the buffer */
> +	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> +			     priv->cmd_receiver_clbk_hdl.rx_msg,
> +			     priv->cmd_receiver_clbk_hdl.rx_msg_sz,
> +			     false);
> +
> +	if (copy_to_user(buf, priv->cmd_receiver_clbk_hdl.rx_msg,
> +			 priv->cmd_receiver_clbk_hdl.rx_msg_sz)) {
> +		dev_err(priv->dev,
> +			"%s: Failed to copy to user\n",
> +			dev_ctx->devname);
> +		err = -EFAULT;
> +	}
> +	err = priv->cmd_receiver_clbk_hdl.rx_msg_sz;
> +exit:
> +	priv->cmd_receiver_clbk_hdl.rx_msg_sz = 0;
> +
> +	se_dev_ctx_shared_mem_cleanup(dev_ctx);
> +
> +	mutex_unlock(&dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Open a character device. */
> +static int se_if_fops_open(struct inode *nd, struct file *fp)
> +{
> +	struct miscdevice *miscdev = fp->private_data;
> +	struct se_if_priv *priv = dev_get_drvdata(miscdev->parent);
> +	struct se_if_device_ctx *misc_dev_ctx = priv->priv_dev_ctx;
> +	struct se_if_device_ctx *dev_ctx;
> +	int err = 0;
> +
> +	if (mutex_lock_interruptible(&misc_dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	priv->dev_ctx_mono_count++;
> +	err = init_device_context(priv,
> +				  priv->dev_ctx_mono_count ?
> +					priv->dev_ctx_mono_count
> +					: priv->dev_ctx_mono_count++,
> +				  &dev_ctx, NULL);
> +	if (err)
> +		dev_err(priv->dev,
> +			"Failed[0x%x] to create device contexts.\n",
> +			err);
> +	else
> +		fp->private_data = dev_ctx;
> +
> +	mutex_unlock(&misc_dev_ctx->fops_lock);
> +	return err;
> +}
> +
> +/* Close a character device. */
> +static int se_if_fops_close(struct inode *nd, struct file *fp)
> +{
> +	struct se_if_device_ctx *dev_ctx = fp->private_data;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +
> +	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	/* check if this device was registered as command receiver. */
> +	if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {
> +		priv->cmd_receiver_clbk_hdl.dev_ctx = NULL;
> +		kfree(priv->cmd_receiver_clbk_hdl.rx_msg);
> +		priv->cmd_receiver_clbk_hdl.rx_msg = NULL;
> +	}
> +
> +	se_dev_ctx_shared_mem_cleanup(dev_ctx);
> +	cleanup_se_shared_mem(dev_ctx);
> +
> +	priv->active_devctx_count--;
> +	list_del(&dev_ctx->link);
> +
> +	mutex_unlock(&dev_ctx->fops_lock);
> +	kfree(dev_ctx->devname);
> +	kfree(dev_ctx);
> +
> +	return 0;
> +}
> +
> +/* IOCTL entry point of a character device */
> +static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> +{
> +	struct se_if_device_ctx *dev_ctx = fp->private_data;
> +	struct se_if_priv *priv = dev_ctx->priv;
> +	int err;
> +
> +	/* Prevent race during change of device context */
> +	if (mutex_lock_interruptible(&dev_ctx->fops_lock))
> +		return -EBUSY;
> +
> +	switch (cmd) {
> +	case SE_IOCTL_ENABLE_CMD_RCV:
> +		if (!priv->cmd_receiver_clbk_hdl.dev_ctx) {
> +			if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
> +				priv->cmd_receiver_clbk_hdl.rx_msg =
> +						kzalloc(MAX_NVM_MSG_LEN,
> +							GFP_KERNEL);
> +				if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
> +					err = -ENOMEM;
> +					break;
> +				}
> +			}
> +			priv->cmd_receiver_clbk_hdl.rx_msg_sz = MAX_NVM_MSG_LEN;
> +			priv->cmd_receiver_clbk_hdl.dev_ctx = dev_ctx;
> +			err = 0;
> +		} else {
> +			err = -EBUSY;
> +		}
> +		break;
> +	case SE_IOCTL_GET_MU_INFO:
> +		err = se_ioctl_get_mu_info(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_SETUP_IOBUF:
> +		err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_GET_SOC_INFO:
> +		err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
> +		break;
> +	case SE_IOCTL_CMD_SEND_RCV_RSP:
> +		err = se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		dev_dbg(priv->dev,
> +			"%s: IOCTL %.8x not supported\n",
> +			dev_ctx->devname,
> +			cmd);
> +	}
> +
> +	mutex_unlock(&dev_ctx->fops_lock);
> +
> +	return (long)err;
> +}
> +
> +/* Char driver setup */
> +static const struct file_operations se_if_fops = {
> +	.open		= se_if_fops_open,
> +	.owner		= THIS_MODULE,
> +	.release	= se_if_fops_close,
> +	.unlocked_ioctl = se_ioctl,
> +	.read		= se_if_fops_read,
> +	.write		= se_if_fops_write,
> +};
> +
>  /* interface for managed res to free a mailbox channel */
>  static void if_mbox_free_channel(void *mbox_chan)
>  {
> @@ -321,6 +1074,7 @@ static int se_if_request_channel(struct device *dev,
>
>  static void se_if_probe_cleanup(void *plat_dev)
>  {
> +	struct se_if_device_ctx *dev_ctx, *t_dev_ctx;
>  	struct platform_device *pdev = plat_dev;
>  	struct device *dev = &pdev->dev;
>  	struct se_fw_load_info *load_fw;
> @@ -345,6 +1099,13 @@ static void se_if_probe_cleanup(void *plat_dev)
>  		load_fw->imem.buf = NULL;
>  	}
>
> +	if (priv->dev_ctx_mono_count) {
> +		list_for_each_entry_safe(dev_ctx, t_dev_ctx, &priv->dev_ctx_list, link) {
> +			list_del(&dev_ctx->link);
> +			priv->active_devctx_count--;
> +		}
> +	}
> +
>  	/* No need to check, if reserved memory is allocated
>  	 * before calling for its release. Or clearing the
>  	 * un-set bit.
> @@ -410,6 +1171,7 @@ static int se_if_probe(struct platform_device *pdev)
>  					     "Unable to get sram pool = %s.",
>  					     if_node->pool_name);
>  	}
> +	INIT_LIST_HEAD(&priv->dev_ctx_list);
>
>  	if (if_node->reserved_dma_ranges) {
>  		ret = of_reserved_mem_device_init(dev);
> @@ -418,6 +1180,12 @@ static int se_if_probe(struct platform_device *pdev)
>  					    "Failed to init reserved memory region.");
>  	}
>
> +	ret = init_device_context(priv, 0, &priv->priv_dev_ctx, &se_if_fops);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed[0x%x] to create device contexts.",
> +				     ret);
> +
>  	if (if_node->if_defs.se_if_type == SE_TYPE_ID_HSM) {
>  		ret = get_se_soc_info(priv, se_info);
>  		if (ret)
> @@ -444,7 +1212,7 @@ static int se_if_probe(struct platform_device *pdev)
>  		}
>  	}
>  	dev_info(dev, "i.MX secure-enclave: %s%d interface to firmware, configured.",
> -		 SE_TYPE_STR_HSM,
> +		 get_se_if_name(priv->if_defs->se_if_type),
>  		 priv->if_defs->se_instance_id);
>
>  	return ret;
> @@ -461,6 +1229,7 @@ static int se_suspend(struct device *dev)
>  	struct se_fw_load_info *load_fw;
>  	int ret = 0;
>
> +	set_se_rcv_msg_timeout(SE_RCV_MSG_DEFAULT_TIMEOUT);
>  	load_fw = get_load_fw_instance(priv);
>
>  	if (load_fw->imem_mgmt)
> diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
> index 32547bc97ca3..c103563091d5 100644
> --- a/drivers/firmware/imx/se_ctrl.h
> +++ b/drivers/firmware/imx/se_ctrl.h
> @@ -13,6 +13,7 @@
>  #define MAX_FW_LOAD_RETRIES		50
>
>  #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
> +#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
>  #define MAX_NVM_MSG_LEN			(256)
>  #define MESSAGING_VERSION_6		0x6
>  #define MESSAGING_VERSION_7		0x7
> @@ -20,6 +21,7 @@
>  struct se_clbk_handle {
>  	struct completion done;
>  	bool signal_rcvd;
> +	struct se_if_device_ctx *dev_ctx;
>  	u32 rx_msg_sz;
>  	/* Assignment of the rx_msg buffer to held till the
>  	 * received content as part callback function, is copied.
> @@ -34,6 +36,41 @@ struct se_imem_buf {
>  	u32 state;
>  };
>
> +struct se_buf_desc {
> +	u8 *shared_buf_ptr;
> +	void __user *usr_buf_ptr;
> +	u32 size;
> +	struct list_head link;
> +};
> +
> +struct se_shared_mem {
> +	dma_addr_t dma_addr;
> +	u32 size;
> +	u32 pos;
> +	u8 *ptr;
> +};
> +
> +struct se_shared_mem_mgmt_info {
> +	struct list_head pending_in;
> +	struct list_head pending_out;
> +
> +	struct se_shared_mem secure_mem;
> +	struct se_shared_mem non_secure_mem;
> +};
> +
> +/* Private struct for each char device instance. */
> +struct se_if_device_ctx {
> +	struct se_if_priv *priv;
> +	struct miscdevice *miscdev;
> +	const char *devname;
> +
> +	/* process one file operation at a time. */
> +	struct mutex fops_lock;
> +
> +	struct se_shared_mem_mgmt_info se_shared_mem_mgmt;
> +	struct list_head link;
> +};
> +
>  /* Header of the messages exchange with the EdgeLock Enclave */
>  struct se_msg_hdr {
>  	u8 ver;
> @@ -78,6 +115,12 @@ struct se_if_priv {
>
>  	struct gen_pool *mem_pool;
>  	const struct se_if_defines *if_defs;
> +
> +	struct se_if_device_ctx *priv_dev_ctx;
> +	struct list_head dev_ctx_list;
> +	u32 active_devctx_count;
> +	u32 dev_ctx_mono_count;
>  };
>
> +char *get_se_if_name(u8 se_if_id);
>  #endif
> diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
> new file mode 100644
> index 000000000000..29a9b1ec5ec3
> --- /dev/null
> +++ b/include/uapi/linux/se_ioctl.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef SE_IOCTL_H
> +#define SE_IOCTL_H
> +
> +#include <linux/types.h>
> +
> +#define SE_TYPE_STR_DBG			"dbg"
> +#define SE_TYPE_STR_HSM			"hsm"
> +#define SE_TYPE_ID_UNKWN		0x0
> +#define SE_TYPE_ID_DBG			0x1
> +#define SE_TYPE_ID_HSM			0x2
> +/* IOCTL definitions. */
> +
> +struct se_ioctl_setup_iobuf {
> +	void __user *user_buf;
> +	__u32 length;
> +	__u32 flags;
> +	__u64 ele_addr;
> +};
> +
> +struct se_ioctl_shared_mem_cfg {
> +	__u32 base_offset;
> +	__u32 size;
> +};
> +
> +struct se_ioctl_get_if_info {
> +	__u8 se_if_id;
> +	__u8 interrupt_idx;
> +	__u8 tz;
> +	__u8 did;
> +	__u8 cmd_tag;
> +	__u8 rsp_tag;
> +	__u8 success_tag;
> +	__u8 base_api_ver;
> +	__u8 fw_api_ver;
> +};
> +
> +struct se_ioctl_cmd_snd_rcv_rsp_info {
> +	__u32 __user *tx_buf;
> +	int tx_buf_sz;
> +	__u32 __user *rx_buf;
> +	int rx_buf_sz;
> +};
> +
> +struct se_ioctl_get_soc_info {
> +	__u16 soc_id;
> +	__u16 soc_rev;
> +};

It'd better add pack for these interface.

> +
> +/* IO Buffer Flags */
> +#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
> +#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
> +#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
> +#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
> +#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
> +
> +/* IOCTLS */
> +#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
> +
> +/*
> + * ioctl to designated the current fd as logical-reciever.
> + * This is ioctl is send when the nvm-daemon, a slave to the
> + * firmware is started by the user.
> + */
> +#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
> +
> +/*
> + * ioctl to get the buffer allocated from the memory, which is shared
> + * between kernel and FW.
> + * Post allocation, the kernel tagged the allocated memory with:
> + *  Output
> + *  Input
> + *  Input-Output
> + *  Short address
> + *  Secure-memory
> + */
> +#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, \
> +					struct se_ioctl_setup_iobuf)
> +
> +/*
> + * ioctl to get the mu information, that is used to exchange message
> + * with FW, from user-spaced.
> + */
> +#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, \
> +					struct se_ioctl_get_if_info)
> +/*
> + * ioctl to get SoC Info from user-space.
> + */
> +#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
> +					struct se_ioctl_get_soc_info)
> +
> +/*
> + * ioctl to send command and receive response from user-space.
> + */
> +#define SE_IOCTL_CMD_SEND_RCV_RSP _IOWR(SE_IOCTL, 0x07, \
> +					struct se_ioctl_cmd_snd_rcv_rsp_info)
> +#endif
>
> --
> 2.43.0
>

