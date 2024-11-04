Return-Path: <linux-kernel+bounces-395507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20A9BBEDD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5AD1C220E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD71F6671;
	Mon,  4 Nov 2024 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A0efuFFB"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D441CC177;
	Mon,  4 Nov 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752623; cv=fail; b=chFWDwq2No0Rlb8vQetIpykQ6m2iazy9KlrP2SYHS+MzdQdrfct/yT2x9wFllj/U+vWdKc2dHCBfflV4vgOrq/rEIUJGb9HGWD08slOp6VlWvmElqVKGGtvXo4KX53X2DbPHELjD40fUXllBzXBOpmY4oIOwVwJ0g6qAfuYfMDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752623; c=relaxed/simple;
	bh=msCWuu4TTtIn+8BcNHdP95TMGllUJZAhrC+Vfz6VZKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lNt2l3TpB0tjNtxG5PPDoa2TAiCd+fhBRrjbDe4qfbLoLFCfhf1ibYVgaWNo3mZFlCvPokQEjt7Zf9d0kruwPslc0SCs7sk1Y5QqDygpeirXFgXH24m4CpBJ9jYzdq/ad7fnKWae4TP8lUcuon6chUk/RyjK4EklhW4rShiKeUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A0efuFFB; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r96qyLAugTXEsnYXTMmyLvMlP580XU+fjnqf67dUgIDSveGfamln/PmuKntJhiV67EsE6tg3lzpQ02/Q9vxWJ95+QOvYkA8PoEYKBom3oa708B1sioaE7gW4Fs3PRyB+T7PKIyakGZi6Gqq7NPshBCFzE5jmaxR3pMwpnItdZxbxbql2zyeeBWpOHSzSmj/7Du9PLisOqQn/u9ixKnQzMKyXf8Mq3B1cuDj0BoEZ1bh8LyTWlsZE0rK8TO829gxWmkncie6tOcej7KMF2OmlPHcY7wywFtRqZ5UekKBr5YEgAPpsY36EHrxvDpG4KyVf0dV8ZlYrkL5kUTKsMVm74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQwoN97tgocea8vqp68RRcLJ2uJu0fJc6R/WoXPr/VQ=;
 b=ctMEdQrOL+nc8/KTAZ2upQZUq6fm++X367B40ZeDkL+FtVJ1upu7GBu9gAJ94vQ1fMx/24o/AMAVGcc3imCKBkJ9sLvnOloA0Zsr+S4OmSzBlkKNN9z75X+LEZ65JI2PVrfbndgkYunJkQHmnNEE3fb3AAM0TdRV355mpuoOvICmzbhRAQ3xdbC9RqWKfFHilWUsEfpC3Vq8SbpsiCYQJQqn7bhn9mtX1rpvsFyGftcRMO74MdMBDhKLdzcf5LY2tuNZlSjFCDkwYnznqvcLEuUyCC+5/wPhEUPDodPUMGH6Zcod/rROnZZRkyCMjEyPBi1NVoHNipeRQXq6NmXoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQwoN97tgocea8vqp68RRcLJ2uJu0fJc6R/WoXPr/VQ=;
 b=A0efuFFBEhN0U5M7p51JuzjqaU4nXnxoHFPGPp11Bs1eoC23liEfzU4hy06iZwe16p4hKhX5nAbhby6d4OV5crN6f+5s6pumGpHiuM403Cspl43DL+pjuCKKtb9TBoHkI0ciCiTvQY5PFeZM3hDaTDglxj3hPNvNn/nHT6TezrKK34Q6lZ5zxKVfvIBoNM1lUc+OsJo5kM7OOdw9+NiZWkbLT8q86EVB7MCAQjDHtQtzeWYvEPjrIclyiYxFWfvFSaPyJzlNy1S7tIMeL8WLK+YYVgS3pFnY1CeD0S65qVRVCQYcvBACl+yKrRongGMA6VxbmMox/xx0Hg2kSkW5PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9976.eurprd04.prod.outlook.com (2603:10a6:150:117::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 20:36:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 20:36:56 +0000
Date: Mon, 4 Nov 2024 15:36:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mq-zii-ultra: remove #address-cells
 of eeprom@a4
Message-ID: <ZykwYD67p+Oug/kG@lizhi-Precision-Tower-5810>
References: <20241018183117.740439-1-Frank.Li@nxp.com>
 <ZySVlU2gPSN3KKSl@dragon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZySVlU2gPSN3KKSl@dragon>
X-ClientProxiedBy: SJ0PR05CA0095.namprd05.prod.outlook.com
 (2603:10b6:a03:334::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9976:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b6eb83-ae33-4524-5c9c-08dcfd106cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?49DahJ9T5ZJ7A1mULFMZudqoGoQJkt73ribKkoJT6hgR3Pk8kzWEaZpIOThJ?=
 =?us-ascii?Q?GGNkBYAh3JvKR3xw1+SJahUV5hsFL9cXTJvNzIYQ15fReV+wmp9whYCg+MVk?=
 =?us-ascii?Q?ew8njMD1A3p9oVjWgYc9/ANUvMU7ycXHwf291bYbIiCVuQhjxP/I7AqaFlEM?=
 =?us-ascii?Q?ex/EBBeKmeVAtacXNq5+kj0wHhQtnpI9ryrfqedMfgGs/JYwKiRXFxL4ahhb?=
 =?us-ascii?Q?gNcJV6EDU3XGPtXorYd5QIF8sJtP3Txg3pNsLE75sDhN2gHS4E9BVc15Xaxq?=
 =?us-ascii?Q?SoBaO93TObTm6Yr6ZwNz7fWiwTPiyxWVoZxaVbPRjTQ1EZ/4CQZrgULvzfe/?=
 =?us-ascii?Q?GjDOdkMqyU/A2ccxh5mmXOdjnKO1DGa6IhcqZoEtLt0OhTuNnM5Y+M3yVpCe?=
 =?us-ascii?Q?Kn8PKdub5HDa7371bzYhIkEnaUkr3vNu3wQqNzD4CCYCZqHX6FyWGUEi4UxB?=
 =?us-ascii?Q?Sy2VTxONFHf3G+x9KuqHkQJD87X+QXBWjr6Ly43RswuyGiWAc7ubsdom0cxd?=
 =?us-ascii?Q?yZxS+eYVxkRSNT2oIbz7JByvhgmkP9aU/B8Z9IA1Yn+thnLZL4SSrWSVTfW+?=
 =?us-ascii?Q?NevGCRwMHghVSbGkW23zw6HMkRKuI0cAt8OocKeuX81PYuRFfM07mUhHfyL7?=
 =?us-ascii?Q?dwEn2RVW0i+SCa+TzAEh67Oj3aMVUiMAT7dAevoAxd1fpjpts/wcwh8iIzQ5?=
 =?us-ascii?Q?/SYr3SerIVm5qJZ+dkTEX41ygcPKb3a7N/8PSSDUAMBX4y9iEv+SvE8sxQzH?=
 =?us-ascii?Q?ZU238T78Dw7D8cIo1OrGa+sucQ1sO2tSRK3whzty51YhpzG/ZiIsM/6FYtGX?=
 =?us-ascii?Q?v9yAF8EpsS0aDxYKWpPhpM0Y4YS0JbMwzbPMg0BJwm0g1sP1i7fwAYOxGsLB?=
 =?us-ascii?Q?VhbR9BYC0ZO4ufhbfcRKkB2lhbE8hxzmxDv04SqkZXX5rbvmyU0Z/lGS0oKs?=
 =?us-ascii?Q?VajLhRGvNEzcMT5QWmmHEMgIiuliIycGTCoeV6GgihNbl7Dz1yWUkZB5vAz0?=
 =?us-ascii?Q?z0xnedlRNLRhdMUNDMqVc7bEK8R3Zq6xfyDKYO6zZqvpMV27QBhSEfilhnio?=
 =?us-ascii?Q?IQxhkYCUMKWGjlVBvHIjuV8iAlclyjk/P/5R9ysf94RySGP8hbGl/BelkG1k?=
 =?us-ascii?Q?XIf/OoRm3KrV/7Vle8XH4XWw5kAwl09qo0RVpEah6Rl0e7cZBAM2B50VfM/8?=
 =?us-ascii?Q?IwCp5+h/Qqp/GrU33DCjZg1YOEnWv4zLruTAY7boZIw1/oMYR/jctVW86pHO?=
 =?us-ascii?Q?vmKoX/ost+QSraseJAnnC2lugyMPHYT19OwNqNSWdwrZJBIpNHi/GI9YQ8G9?=
 =?us-ascii?Q?P3CRqXdOSaaYeAQ/QXiZGYc8wTc4HObs/LYGZd+UJJRouyfelxIjXm+y3pz9?=
 =?us-ascii?Q?9d2s0RE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eAku4L6wAXkN+H9xwxszaxMfhjZio/ijRXI+jRH87DdZGq4EVxbB0HU1tViu?=
 =?us-ascii?Q?Ok/ASXmAFNTKaL7/g8wMe8dP0DKuu1Hn24LSBshorl3PPnY4QPQYyb2exqGD?=
 =?us-ascii?Q?HibLwot3d+5jk3A7uGyLjCTgafibHqKuTfiqvkFJHWiKR8MoZ3ooy+c3XRj+?=
 =?us-ascii?Q?KAW2twiOThU6byZgaDUJgyVaBhGRuvnAZP5didwlkZ6VODhLsxLWvNNEKW7w?=
 =?us-ascii?Q?LzRrAmGeURpo1AE4HQFkUioTed4eQkGeJ71Vf9J/V4wXSEAqr4Q6RR2W6AaQ?=
 =?us-ascii?Q?00aw+9HsNDtJzawCGABOfHmfU3CqD3b7JXJ+fnYPDrosqpkoQQv6diUDmn2F?=
 =?us-ascii?Q?P9VcWxMvzU1GlqtOtlJtmzqUQWB3pP76VgfRfKoB8oTrxU6u/yMY1vSocnTt?=
 =?us-ascii?Q?gVKhYftsyIErova013izzWcYDW27cmcNQj1FqpoCHzEnYRaT93ibj2KE5afw?=
 =?us-ascii?Q?RSh3ndhFJCN5B3yEBIgVMoyV8Vw3Hn2oqD05nUeeLtW8+76xlIjsHYZU19r7?=
 =?us-ascii?Q?IIUvve3mMXgsZbatILp6KTOdpgThq22jelT52cjNvIvnFlPzwfjcw0rhDzlW?=
 =?us-ascii?Q?IPWJDneEAVLLavoV3nJyQbM058a0mvMHjtSCV2Li3lta6+uFW7bLbs+JNVfY?=
 =?us-ascii?Q?+4xxCeZZ3BSZv9v+1QFlmLfHydaqrbEyxXUBme4j5SGgTRE699xlJG/OeYkR?=
 =?us-ascii?Q?0gQEVfc3ZpQo5m5W82ii7SB86lvq5ZzUeshrYFFksEbrLmDs16ET2ubWtUZ/?=
 =?us-ascii?Q?jvj2PqoC20Db1N3PD3iuclQqxcOEkxYjni/z4JsckwYvw9clbJ0qYRAVySxp?=
 =?us-ascii?Q?PW38wvl83GMVGgM9a5J4LHPjnhB/j9WAMVbMWNoAa2uaPCOU5cyPLkWIw53v?=
 =?us-ascii?Q?4I5VOvLDTo39Ytipvp2wsK+yHbQqquv5v9Rs7LVeCXWSL5vCrkpJJYQ29weK?=
 =?us-ascii?Q?MYrcvthNvdi2cmepZwXOHlePsmw/6oCVWizlZCxXjmqkE5n6jO0sOd0kH7eA?=
 =?us-ascii?Q?wAeTlwbhzdCta6d77w4//s568+7AuUnNL5HZMv8PVVrv2VIvr5AgHUzpLLbJ?=
 =?us-ascii?Q?1tcZsSysfCBpM9QI9bQ/UoJydr8rpSCz5UGBtIHSH58KbO5eY3Pj2+jq/mUr?=
 =?us-ascii?Q?RAHuUcs9QCd1ZMWOxWkOvwEGGojvlyDZTkSYpdJ9Y0hnM0QgB1BRCV9k2kj/?=
 =?us-ascii?Q?7spVNNnCa+PX6aFHHzzyIMwTfzv4o5qP9WwxAljLNGW4/K+xFgwAGBCX+fbM?=
 =?us-ascii?Q?PI2EemCLzkE+DKnO4sNRcgKAOzkD4apQeO1oFrI6YEIVq9hPZ9Y6HtB1sFwB?=
 =?us-ascii?Q?+QytMIJ9O8u8zxx+wt8A/q2trqawqWLdSxLj/YwznPKElZpRJuOYFIF+9gIf?=
 =?us-ascii?Q?SHw4yBDaBip7Dtbj49D7jjsn1LmIqHVA6yLY2AJNA5SaXkBNLvFdaSEjFFio?=
 =?us-ascii?Q?HzL5Vq+J38jfT3lPB4WkuuuZbGg06B+sC3AOBlw2OgDO/HnE3CRQynkayB6k?=
 =?us-ascii?Q?L1KiwZ6mV/0XLL3bLD3EXGQMOY7QdevaJHMdowGQL0Ky076ifZ4otdE9c/AO?=
 =?us-ascii?Q?bS7f6P9GdnooCOIEptY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b6eb83-ae33-4524-5c9c-08dcfd106cb4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 20:36:56.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUJu7HAcD8GNKfe+hdgjqTiMA8UqVPIOOjQkPLIVsSLXzgeo8kItLzuh2T7roG3tv2dx5Y7fA+gJwYEB37utIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9976

On Fri, Nov 01, 2024 at 04:47:17PM +0800, Shawn Guo wrote:
> On Fri, Oct 18, 2024 at 02:31:16PM -0400, Frank Li wrote:
> > Remove #address-cells and #size-cells of eeprom@a4 because no children
> > nodes under eeprom@a4.
>
> Hmm, bindings/nvmem/zii,rave-sp-eeprom.txt suggests there could be child
> nodes?

"Data cells are child nodes of eerpom node, bindings for which are
documented in Documentation/devicetree/bindings/nvmem/nvmem.txt"

It should be optional property to declear offset, such as mac_address, or
watchdog_timeout value.

Here is no children nodes under eeprom@a4, so needn't #address-cells. It
should be added only when add children nodes.

Frank

>
> Shawn
>
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > index 0c960efd9b3d5..c7bbba45f3685 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > @@ -517,8 +517,6 @@ eeprom@a3 {
> >  		eeprom@a4 {
> >  			compatible = "zii,rave-sp-eeprom";
> >  			reg = <0xa4 0x4000>;
> > -			#address-cells = <1>;
> > -			#size-cells = <1>;
> >  			zii,eeprom-name = "main-eeprom";
> >  		};
> >  	};
> > --
> > 2.34.1
> >
>

