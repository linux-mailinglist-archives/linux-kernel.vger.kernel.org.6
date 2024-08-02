Return-Path: <linux-kernel+bounces-272651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE37945F71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2280D28328E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E94210186;
	Fri,  2 Aug 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P8xWon74"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA003211C;
	Fri,  2 Aug 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609105; cv=fail; b=k0VaQzaO0wVEKYbNQnuuQKs9AzgfIpDXVw3N+D4snqwVKbUgGPMQYalXKNs6o1GCy7r7rtr+xeOE389T1PfbHsfcga15hzenpcGBGYbzJifvSXXMT/Afl08xw6yj+pkcIZAhoJ9+aHv5SEEKuiBZL3iH5F0T63kA6iCsXSuB0Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609105; c=relaxed/simple;
	bh=Ox1QcBYSScqtQOkM5Os9oWO5lThM+wN3DJVOSu8S9EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c6ro6rodzF4yEo2j2WMtXufoqtNMzgoNuuhyoAgMNudpAfpVa2JrW+hVmUon9Rl4Gaur9GYjOZbH978LCRVaZrSuhrCnP6W5kB86FkeKRsrDwW02HRVn9RpJ02LRZ77N7cOSLZc/3mPzRmHerKX8CXtfec/yXSrccCT8JapD1Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P8xWon74; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGOzKjtGn7MOjsCveXXwyS8DxIHMjyaFLMhMTIEjpaPAJM2131jcCPg6xzujaer4lLQ9bGIBQyUwo9Fu4CIsM2UuBDgnSK3EuDWl+BfjiQ13thh39cBVYG0kGzmbLIqBLLshr7eQFXuZB2m5TPks1HRlGuf4j5ro338Fdnd+NZGmDeq7nFSondE/+HsumRxM4ZHcxAyqZuigoSiD6zihMD7ipYKYlwyq7+z9muhhqjFekW6epI7vKwhBYtSJAybLrTFuZPhR3QG8jXkQWWPjDMqmVhYsb+I3RT/6k7w/3NiqCpTuryoOZuet3lX6h5EHTGK09YmQlEWroNIqmE5/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a50fZLPqO62DANTzohgOWAh1Qut9kJ+es8BYsMhPKBk=;
 b=y0WquQm6daRH8bcB2cNjG+7j6GOpWVCpg6b1LWFFJ6Iq6rJYZG7eTZx+rmMehySn+KYUsb6zT80gNqKZL6Kpf1ADEHFu0Gdhs1e88gbpzTDcdWiLL5xezEVQBNl4GvACRq9tSuquphYW6eV7WeKsF5SeHnY9ShQ80IR3rWeWQTbxVxWkiVaPexUsgbWMrE97Ip2qVOoAaH97cosDvKvMcaNw1zYt1jm6Edgnj6FxF0h2eaDSoYuPbEMRyvuFc1nPwKoZIpLlCNv+BeXZRmYNUf2BhcdANxCE6A5v407kELOggB2gAHpcZYIMhQS5bP9p0VBhYV3MMRomm4fHPwu2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a50fZLPqO62DANTzohgOWAh1Qut9kJ+es8BYsMhPKBk=;
 b=P8xWon74e6Gzu3x+7pyykHUSw9dAp05jbY6BMd/IguaIlR+vpaqBnfJ1ETVLsREm03Iuqjf+ABIgkip68akDPhRTZxsPW0zGlvNQNWMcWpnSfG2G/k8DRQLBE/isTCPWCqZSxGc5K8HQHCqJSSdW70jhB00CJLHRN7BXzePnYCm1w1JHQyTHlZZTmvio4eiDlpV6mNv0sRBo/n5bGmrLa0IgLjgg4pzWd3R+4Pjb98VCfg8TXJ0VFlARRT5L7P8Io9W0A+87ZyYw2/mdPdUbK4QpzPDJ4DTwlgP90y63eVZFq4yZL+ApqsuZvwTwqQGw0mwkEa+m0YY/71vXzVrS9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8746.eurprd04.prod.outlook.com (2603:10a6:20b:43f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 2 Aug
 2024 14:31:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 14:31:39 +0000
Date: Fri, 2 Aug 2024 10:31:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx93: add lpi2c1 and child node
Message-ID: <Zqztwh3yghN8Drnj@lizhi-Precision-Tower-5810>
References: <20240801160915.2505610-1-Frank.Li@nxp.com>
 <944715e8-e91e-46dd-a053-7e00a17dea72@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944715e8-e91e-46dd-a053-7e00a17dea72@kernel.org>
X-ClientProxiedBy: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: d8580dc4-ecaa-429f-de86-08dcb2ffd259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tWzqzN8VJsRWZ+geoST/7O1eLlp07zadfLMuNJxv/CYOw/dw+6KLX9G/hEOv?=
 =?us-ascii?Q?7M7/KVVHIxdn1RfRby5qVpz7A9hnEDthEXVRpOyrMdT7OujKGQQLxkAH+EAe?=
 =?us-ascii?Q?iFugGbYC3s0cPH5prh52dR8X7OtIfhV+fnOrVc7A7mANwcSnkxh9sak9KyeA?=
 =?us-ascii?Q?7bgtY3C5SHvjRxh+kAM6d/+sDyZT5MQcjJqpiCc14J7FYSQBw6A5oEXaQU/Y?=
 =?us-ascii?Q?5cpT9zeDeaa14p4RFZHshsiuPNZj5puPMMgKealiGCz+buNoT5WrFVdWGjyx?=
 =?us-ascii?Q?fvQh1kUEl4r1enzKKsGk2iSHzaX1vngvbSO1p2WsxGtoG28aDqjepbONi868?=
 =?us-ascii?Q?rEYxgJi2wQ7bhJZjj68f0lw7EP1eTrLrsuq70VzPaW1Bq2XVNGLb0Ky1MV0w?=
 =?us-ascii?Q?Lm+zcpsFfvLy3mKKSWSDYGFvnUEqgfmIBzignyh52baxTo9d3DWCAHOWeWua?=
 =?us-ascii?Q?zbjZOF5+xmOHB/p7+Fc5XA4/N76hRM7XBpX4VZrGWpxXesH5DLUxo2nNyWRq?=
 =?us-ascii?Q?+ut94m+ONFotdm6DoJhH+ShwVxSAoUoT0dNPAIU7BZBbkbT9DYzJPFvZ1Hr7?=
 =?us-ascii?Q?2Wyd8CW0vKFjSXakZclnxsAFADLcNTF8w78Vj/mwiC7UsGTJ679ZQAH40QFV?=
 =?us-ascii?Q?boAvhGP/56i6PmdLruroTYgRa5UFO74WlR+hej0yubKwO1fVCC6j8M6cc2d5?=
 =?us-ascii?Q?PDlIy3ruFITt5RQwB/PAImvy7Z8hHP4aUy2dRN9wd7XpfqGovVim0yxcLoeC?=
 =?us-ascii?Q?gkEgt1moyVvr007jLnLn4Nq13+5bEWsbJz6QmuaNwm+12cPXp7tlYFQD+dFa?=
 =?us-ascii?Q?pft9PYsP6YXRU3uARrD2y2RDBw3V5jz1SL9DbN1QqfTgmLie0+FVEsfjB8Q6?=
 =?us-ascii?Q?0Z2Jy5jsud0tIk23L3794lJvIlUmQCz7fNs38l4IugJU1GseiqT5ANvYFX9l?=
 =?us-ascii?Q?ak2Gtui+HRFffiARqLmU8i/tP2M4rLp2bb7djMhywaiii80wdb+9SUK4KKdq?=
 =?us-ascii?Q?FyFmTPHUryTiAOt3/jgXOgZR9xlRoLBGgfgyYPkIUjkFDVgd+UQKFgAZBMYV?=
 =?us-ascii?Q?STtklCN4QA49AUSnDcrxMmDzBcfMd/4UHCkwgcXQAbT+Sbl5/9mtmSuRRdNz?=
 =?us-ascii?Q?nqlR4xeqZK1zgzJ55RFxTtlN3DwNPsE4CkZIX61qmCuVaFDBHP5g4puBIag7?=
 =?us-ascii?Q?yHm6Wx5ATqAUg8v/A3GQ13iwW17jYNXhs3RuCvwKbiWndcaBQqIEZBSgSntY?=
 =?us-ascii?Q?eQIHi0ftF7eaLnvlHg6aIA5l1vZ3/KRzijRYeE5hK/GggX9k4eR5oBWSNXPe?=
 =?us-ascii?Q?HiXIJiwwrQnCGZzrtyvVqkAoPI7YzSXRE3QygC2PDS/mxHXvJN3kJuxaUps6?=
 =?us-ascii?Q?+DypC/8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?STDns0c6FWmRjU+2KnfvsUnCU1HiHmCXqxcPSB+mQecg7b90/i1rjISIOflY?=
 =?us-ascii?Q?VaJ+QG/SXkI8fOx4GbsG9R32CAGZXDdyWUS4jeqjh88b/WihTc9jJnbdFSSc?=
 =?us-ascii?Q?G8XBHnsCbE9tXGrlqTyRS8oiinSrlyenBX/gy8ewEp22n2XnK5OG2EQfukju?=
 =?us-ascii?Q?jlROIfHxCoCyfJH7RRB6acHuQkEdoOQtl1SLHx34rFZgpGJz0K5yMQO0pFJn?=
 =?us-ascii?Q?jg899VyO/rVwm1Y9HdlfA8SK6m6f1xDCaFXFfFhgvuGxLUsjyRjQgd2J25ke?=
 =?us-ascii?Q?6EeBHqQqizZ3oBmq4z4wekC0rLbz6+7Xwj74Hr/WW3JV0zadEc0speK6lPtV?=
 =?us-ascii?Q?V5KH2UcJhUBnOEHw8jygoeM8pSiSIv8PX9oM2A/jEzJILHjeM8eKFb4AwRKd?=
 =?us-ascii?Q?z4aMykWk6DZ2r3eEJ8Dq5LQPfoI9CKlhQiLBns6GYU+QVCGaFCJFwLMRaNh2?=
 =?us-ascii?Q?KpaMTtFFB11quP7ruls9R3kPjjkYrodoI++7buw8/W6++tycWT2Gawh+RFRK?=
 =?us-ascii?Q?yk6eGH3ANFSW6bPLlnj8t+U4YxwdEsnyXnFdo1ikSTRSzucPSd9b2pPwOZGY?=
 =?us-ascii?Q?+Fu57e3vqjQrkgRxiwcT0JHYJoazvxe0E2DJMUzf67Esv6jUWULlao7cl4Zx?=
 =?us-ascii?Q?vD8fd5MU7jXQs/HvWBKMA0Q3QDw8BOu9gRa26FfOt4nL3syQOqRu5JMYdljS?=
 =?us-ascii?Q?EBmlS+bIIhvjEIvpkwM4hW/rcWcrpL8Zt4B83iZZyoxASJPjOMz3hq+JNONp?=
 =?us-ascii?Q?PyiJOBzsuRKWSAbtdX0zjq6J/DlLunYK+Flz01UTXzp5IBZYjlHad7ztjRDk?=
 =?us-ascii?Q?Vm0cv7/dbb+IjXslHK6uoCU7NOxXmTIRXGEL4LI3Sh29VJ00/DqambvrUkuM?=
 =?us-ascii?Q?mw3hXyeSdLWtTwNithzG2pPQoNiE7wgZXWK72wCGXzZ1mD9/krk+YWX9D9Ob?=
 =?us-ascii?Q?RaIrCvBWrPC9J3dYh40Mx3jPh8FkcI3JQ2bG0f7PRZrrJqZcPlLqnFPq2pjN?=
 =?us-ascii?Q?Kwt0uOPOZPCKePGpj1bExrohRQmGeXD4NGJOF9PDwcbTU0vY1bCHT8GvOqDX?=
 =?us-ascii?Q?/KW+TrVVmudglb0V6ZQp53/JE6H3OAyCxJzupLGgEDfzYcS180m7SRJXPXOG?=
 =?us-ascii?Q?wpoOxjpQGXGOMJihVOG0O1UEAyKmzEJ7uKa397noDkfhc5Ok3+AcGCZNX7g9?=
 =?us-ascii?Q?yBFaf0QRvOXKd4i72WJnjpXtnitxBRbLyxxzfpNuE19FAo7LM6VDZchIB0F+?=
 =?us-ascii?Q?EMdPhMYDJkiHL8jBaIwcj0962VFd5/qBRDr5RPd8UOcyYSwrhDlxQvb165AB?=
 =?us-ascii?Q?jSqeuTIeoVnLzyFYRFuUHiHmvFqL8ZQ1X1aEULznPiIMhuLFSyKHkJ1cwcXd?=
 =?us-ascii?Q?dgtXjBWpxf1T/qeZsPkhO6mLHILa6kuqmoo5TbaDQoTkfPb3ps2I87ZRzVAS?=
 =?us-ascii?Q?DjFEhSXDvbmP7ShfZOgw+3mCk06PoP+VQp+wBlQ1Gl7q0KOuCl7qZ9q4Z7fC?=
 =?us-ascii?Q?pGPnV/CWuEm4qoxxGVCdHldqs+ENdXRK/o05GgEghffteWzHr3X5bihwBX7e?=
 =?us-ascii?Q?cMi0uqCnmNUhoxv9E2BvnQ9ZbFeF6Etdyzjhh25N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8580dc4-ecaa-429f-de86-08dcb2ffd259
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 14:31:39.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctTXphLuRu2ntFLjhMK0H9Yp5KVB9ko8xPfJ4APUKjefya8oFa3RWZKR07d+BNeYXTc0O9By36INeDmr0j/Xog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8746

On Fri, Aug 02, 2024 at 09:25:54AM +0200, Krzysztof Kozlowski wrote:
> On 01/08/2024 18:09, Frank Li wrote:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> >
> > Add lpi2c1 and child node for imx93-11x11-evk board.
>
> Why? What for? What are these? We see all this from the diff, so commit
> msg should explain why and what do you want to achieve.

I really don't know how to explain why/what for these straing forward
thing, hardware board has such component, just add it dts file.

>
> >
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../boot/dts/freescale/imx93-11x11-evk.dts    | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > index a15987f49e8d6..dd387b820831a 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > @@ -145,6 +145,20 @@ ethphy2: ethernet-phy@2 {
> >  	};
> >  };
> >
> > +&lpi2c1 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_lpi2c1>;
> > +	status = "okay";
> > +
> > +	lsm6dsm@6a {
>
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

I really sorry, I forget it again.
Frank

>
>
>
>
> Best regards,
> Krzysztof
>

