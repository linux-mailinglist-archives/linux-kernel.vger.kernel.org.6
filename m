Return-Path: <linux-kernel+bounces-192653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDE48D2034
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5511C21620
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08622171652;
	Tue, 28 May 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WHEd+Hai"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790C16F904;
	Tue, 28 May 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909503; cv=fail; b=HrsFIdK/HxYEsvvDiJWuCD54mDT7zOO/DnFI6h+mzUkzxX4ekww/3sGuwdvczeXU6X6+/AwiCXJ0+w/fE33/MFv13L1qVhyBogGPCbYsAzVstlwvQhNKHI0YQnpDhDPV1Dd6i0ikjmLHwhW3bANkIMjKwQA6CWaqRDpas+ywiaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909503; c=relaxed/simple;
	bh=XwO7YEGOpXFf3qfhbAtEli4OJ/RVM45dM9H7FoaTf3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L6X/2NERDaR2j/luxgTHCoXy6x4xlXHQF886aGNAh1rMRiZkg8hZOAEkutowCgHUPIRc3qePCGKJ0EiKUbcmYNfX1W+nYu7zQkwL5Adm2ATOupHUydMszx5z66SiEZCniLLbBWV5S+/KodFA3H5couvTv8vV6cgNCPWQ1/EUFt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WHEd+Hai; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvyYgxGHzKBg5MnzrmRN/i6kW2A6urQG6SXsVgPjlZu2voZvBO7MpnHzHXiBRu5VdkcURHJzAqNHXx2KB+uEaIy70qWL7f6XXGlFwpSIBAbtkw6XI7GSunjf7amDaH2ZwboxexsbwmQfEm8ZwdPeAnn0D0hrWCRrpeSKuh2WIEQ3/SoJsjjTG1iB7O0JZQZydi/IvyAeb5d+IaVSqMATavdHQ7x8nCi7ee0bTaiO2g1O8ZO/WwwpANBg0ECxH2MDaBW9OETUZ1+pDeabtj9CL/z1d/Sb3KKdQdao1Adcf2ljoat0+8aL8/eNonc1KBm7h3qEU4JLc05j4mixubuXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3/OgfIpr84rA78vi/wbUFzvLNxsREli2TFFuNxvUSk=;
 b=KXWK9RjDPE9a+v8NoEpbxj3S2YmXZhNnbsqPtrivmQdS1uBvfgq8a2LbycmYJ5Z4XkUTN1qK7nnIEjsnkBjWfKIubblhU+0DUjC6V6ttABDggwFUcfzfSEMkg4otiMDjSmiiIWImAGfM2Jyyb66RSl47Rg43+gznQvDBums0hxwiEv13iibGC+CXYGMoEjl3OtOvQuXk904/SppNn116wiAgHUmROfr6lVInj6igbeyM23IJmLUomu+Wm22/ZWcUKtEaUsDuOb72eOPufqdr9ZhgT0erdOeO50472lj4des48QPvLLCtThEIf0rcc3+Gfm6oVFSCJgA6MJiDWlCVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3/OgfIpr84rA78vi/wbUFzvLNxsREli2TFFuNxvUSk=;
 b=WHEd+HaiJIMlnxCokU7jryZlU26r5RVsL83DZl2TSURHOqO2nyvOiFNryNowwTFf3Xi4XT0jPaSdgwJ7qgh6UVEjoxs2PnDI0Tu5R9bGBhmHo0SG+2In+6sukLtChMwCFOVXxPs/hURe+dW/3qekCzgt3f0C08hrrEvG4MEV59g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB8045.eurprd04.prod.outlook.com (2603:10a6:102:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:18:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 15:18:17 +0000
Date: Tue, 28 May 2024 11:18:05 -0400
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
Subject: Re: [PATCH 5/5] arm64: dts: freescale: Add i.MX91 11x11 EVK basic
 support
Message-ID: <ZlX1rcy41Y7koyFM@lizhi-Precision-Tower-5810>
References: <20240527235158.1037971-1-pengfei.li_1@nxp.com>
 <20240527235158.1037971-6-pengfei.li_1@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527235158.1037971-6-pengfei.li_1@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:332::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a01cb64-651d-47bf-0e5a-08dc7f29668e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|376005|366007|7416005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?q0owjAnhh3mc6kNZ4u8oRTYDfPCZYJzR2kvs8rUc5/Y1+yzkNqUJmRVfNBpp?=
 =?us-ascii?Q?VMi0X3dlh5FRvX1zlxsOAx2ri5B0iEXfLoGOdDlN9pUvvHcnQ4m8+96eWYCr?=
 =?us-ascii?Q?XIiVjplCynOoEyD6FL/pbRuOZpikeVaHrW6L1Dyy5E7r50ekNvNFUUI4kBDm?=
 =?us-ascii?Q?9cdObaiARgqe6O1NHA1Tq1dSz9E3uJrRroI8ew71CCWgI19ozHe0vxWdOGLa?=
 =?us-ascii?Q?cAIxlOKxxrYEdJ/HHhlJgGZiZttRnfpqV4k/VQgvtMOY5i+MEbb6FXHov+nF?=
 =?us-ascii?Q?kTZm5kzWH0hFnzLyalkuXTj2ODbpN8APCiQQ9+QpuMWw7yXZ8PyCE2JcMGs3?=
 =?us-ascii?Q?Yo9XH7e+P4VVhsdE5/69u8MDwYwXXxey1jICcnONWRV8sWdlFGrmSgwcdeyd?=
 =?us-ascii?Q?6SxMlMZk9UQT0brfswNoX5UUszrQoWrwec78aK9C76RCvcoxGn5D9VDx/cUl?=
 =?us-ascii?Q?THQ6RlkQAyPZxKA+rvtV/Ep/0sAmTCrYZXIotKHhAL2xSYVTI09a/rjCLlqX?=
 =?us-ascii?Q?Gd4nd95SthPM7l/K9ILyqJIEXf0BQFh6xQ62d4IVJUEcTyVjrAGEOAL9qMsf?=
 =?us-ascii?Q?yAJZUg8BixXZ343fnoFlK+HHqtzlgUqhCGenfPTKTWeyf2MKQKwPm+sd9niU?=
 =?us-ascii?Q?dbPiwDRGSGYF8EM+uqJEDiTQYaSqY4oMkc7eM3Eop3LTbdQO2buiftvICRwZ?=
 =?us-ascii?Q?ARCDqdfICXmMRYy2tRKYdDwrUcHbHmM4AmPCaogkpsaGr22AP+rpuMw+FLix?=
 =?us-ascii?Q?D4TQaJHLLb4/LEfX7SGAsnxGHCXZ8C5wrpT7f16yS8aljs/2bLBq8LW9I3JN?=
 =?us-ascii?Q?YjlnDeyGqllTHlU+gJYY+fZAepRzneAh8baLfLMXvemfP/Xlmw4qR0dLWYmR?=
 =?us-ascii?Q?1J0nVnkw0rmdJyP9L9d4N6okLa8j4sMv7RpWilD0hA0EarrGlbxv3w+Pn+vU?=
 =?us-ascii?Q?sD+QFhDj+jXee7LnqkdZ/rynOKaDUlmCFxAo+E6/+PAXjfxD9NNEP6+PUT/z?=
 =?us-ascii?Q?kpy7k8tan5P/s/mRspEEGdKmrr1650REC6aKu+3e1YwEexcQG5RfhkEAYgOc?=
 =?us-ascii?Q?5pmw35J+3kbqsHO0VWrz2lBh36NgcPUzbT6m/ohZhhT8yss7op3ZnuUPo5XT?=
 =?us-ascii?Q?lscamG/5Jq6ElN/0DB6F7//KY51xgzOGtfl7saEM6PvFx/HMLg3fh6PvzhUR?=
 =?us-ascii?Q?76QmFx9/fDZGTH7e8r6rQKHfNNVnZCvnzqOrRF48PVlPYsfZWaqT1jR3gUfo?=
 =?us-ascii?Q?3DFs9tk+qKbrR3a11D+2t9LKs7YDxy3/aHUU7Df6CFg79sb4DCJReZ886Ivr?=
 =?us-ascii?Q?eBN8rpBwuWH9Dg06ssgeimaJupOIuZCTKQPSI6tmYbYiXQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?V0Q7OKoatmoFmgW7JIxx33GNscZ9/omovffxALE6iEb86fl1QThuUFHMkQzh?=
 =?us-ascii?Q?l5GieqfkdhyB8l5kQymsIvIaT6Hb/ybA+Vlvy4O2CmkL0+GKI/0JCxi5juix?=
 =?us-ascii?Q?3HRGcL+OdyN+y5YhSuklOVmg1Zwotj+HrmGDJHurY1DRHSq2cHWqMuv4OEjz?=
 =?us-ascii?Q?jW/yXhlmD75BP6o5B1X5ET6tDgDVm1K6+ZgPEFUTXY7USLW1St8j7/AyPoRy?=
 =?us-ascii?Q?T4xSazO25bFykj9fX1RNQA4i69YkEAdLEhAQfHfJ9WjWXPRs/sjfG4RO6/n5?=
 =?us-ascii?Q?53EXHTqtd9jvHmDyz5qbgGNkBdRODl9xj+B3DZnMJwE2I6jRovbM4BqS7jYS?=
 =?us-ascii?Q?Ko0/Rm9kuY82lcgxkAyn1Mg+nKiwR2Ig946JThnDeTAZMhoqKWwe1/EbnUwx?=
 =?us-ascii?Q?VSXRHwjCKM4uYzJZjcyvs5k3Tk8Hkm3+Faj3pTD1WyBSxzUmoxaDRnIanJ32?=
 =?us-ascii?Q?J3oYXSFQJZ/UrYC3bZ3ZSUmeuN3DvmEfvcTOWcDcwX1TiLOXcZ78GdiKWP9z?=
 =?us-ascii?Q?4H5nNmQ98pcXNcTlWJt16B6tTLXUtGJYKqVdDmIvwmdZxTBwbnYPZs0ViBnE?=
 =?us-ascii?Q?hiUDz3aPs5DYGJgmooVfoyQ2b+BEwd8NgVIgdKK6IZeR6VucRMuTn8JwuoPa?=
 =?us-ascii?Q?fSzx/PkW+T1qZmmEiPddzSknK0AGziTn7/VFZhtm+lq1YVTr8YtUxxSWuEPh?=
 =?us-ascii?Q?mhk3N3TmGwWi2VrycF7SDWvjZXpTgcv/ji5qskxftJ8qGNldyA6fLGVFUNrm?=
 =?us-ascii?Q?pptd9JAxGKvXwN8VD1ae1J4gg3QzMyS1iPWddHOZjsQzAGQLrmakdWLAK+KK?=
 =?us-ascii?Q?ltHqojQrEgFQT5w3PrhxD+/YZLZQxbJf56KVSSCTwUnv/k2KX405Qb36Lmlw?=
 =?us-ascii?Q?56Zux2uP0L10VnMyHvnK9sKCbmpjgEJ5T9ETTfkxNMUmVBKqbpTUNo+e2gV4?=
 =?us-ascii?Q?6w4Le/7F5h0VVLgIqNzB5AEmWZUq6g5A1yeWvuA8Ji920QxXspLXriHX6VnG?=
 =?us-ascii?Q?i+mz6V0iZiCHqz3ngePPRQxsG1wYc27j3vNmmdikmen0r7sKIgn8/4s7KMSd?=
 =?us-ascii?Q?n8KZpgjYHJ+1S4sBVJAsZPopcSYCzYjPmMOj+jCfLLDFnvWr5nNPDKS3pq60?=
 =?us-ascii?Q?IX8brvD3+qmKV2vT4AxxB/zUQ7uSYBw2hPbPHtVzIaf7UGguq363SjEKbdlG?=
 =?us-ascii?Q?S3wMEMo484TJSNmqWRbjU8Mdd/fg6s5BoHTJrLiQV3wtWFFfGXDeUl2oBN+K?=
 =?us-ascii?Q?O4uTeDsrJHS0IkT09wkAA4vnPNqQvAsE8/9XDqtnIvkESklwHyoSSTRAt4Sq?=
 =?us-ascii?Q?Y4Bi5F/jfbrgLinYJF16fB+6+lpJyOgbhbCU8E4DuJtIPCnnLBsx/5lJl0EH?=
 =?us-ascii?Q?+ii27z4315uiaVdYbpWLmQMKaxplU9u9XaL9i7iaJP9B63N/fzGg0jcpXjfm?=
 =?us-ascii?Q?wHGCSq6yBPAVINYHhvze4Bqi3gLBJaBYV2b/riJLA37aiBOMPGRQjZ3z31cm?=
 =?us-ascii?Q?B1Qg2ObxCLbTattiDisA7XuQgECZ/shQZ+C02ohcvW5A213XbTtowRiVFOrL?=
 =?us-ascii?Q?pAL3FOqoSMDhh2PPdRw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a01cb64-651d-47bf-0e5a-08dc7f29668e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:18:17.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrEfYXyIl0G8DjkHpJQ5yXgcb1QzgG5Bh/+T5PvjalDz05kAl66BOwuxvdrI6n8fLC9dE7yxZTzMM5w5uQXDoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8045

On Mon, May 27, 2024 at 04:51:58PM -0700, Pengfei Li wrote:
> Enable lpuart & SDHC for console and rootfs.

Add i.MX91 11x11 EVK board support.
- Enable lpuart1 and lpuart5.
- Enable network eqos and fec.
- Enable I2C bus and children nodes under I2C bus.
- Enable USB and related nodes (PTN5110 ...). 
- Enable uSDHC1 and uSDHC2.
- Enable MU1 and MU2.

> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx91-11x11-evk.dts    | 807 ++++++++++++++++++
>  2 files changed, 808 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index bd443c2bc5a4..7083f6824e9f 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -236,6 +236,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
>  
>  imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
>  imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
> diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> new file mode 100644
> index 000000000000..eb82a193ef72
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
> @@ -0,0 +1,807 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/usb/pd.h>
> +#include "imx91.dtsi"
> +
> +/ {
> +	model = "NXP i.MX91 11X11 EVK board";
> +	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
> +
> +	aliases {
> +		ethernet0 = &fec;
> +		ethernet1 = &eqos;
> +		rtc0 = &bbnsm_rtc;
> +	};
> +
> +	chosen {
> +		stdout-path = &lpuart1;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			alloc-ranges = <0 0x80000000 0 0x40000000>;
> +			size = <0 0x10000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
> +	reg_vref_1v8: regulator-adc-vref {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vref_1v8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> +		off-on-delay-us = <12000>;
> +		enable-active-high;
> +	};
> +
> +	reg_vdd_12v: regulator-vdd-12v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "reg_vdd_12v";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
> +		gpio = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	reg_vrpi_3v3: regulator-vrpi-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VRPI_3V3";
> +		gpio = <&pcal6524 2 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		vin-supply = <&buck4>;
> +	};
> +
> +	reg_vrpi_5v: regulator-vrpi-5v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VRPI_5V";
> +		gpio = <&pcal6524 8 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +	};
> +
> +	reg_usdhc3_vmmc: regulator-usdhc3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "WLAN_EN";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
> +		/*
> +		 * IW612 wifi chip needs more delay than other wifi chips to complete
> +		 * the host interface initialization after power up, otherwise the
> +		 * internal state of IW612 may be unstable, resulting in the failure of
> +		 * the SDIO3.0 switch voltage.
> +		 */
> +		startup-delay-us = <20000>;
> +		enable-active-high;
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&reg_vref_1v8>;
> +	status = "okay";
> +};
> +
> +&eqos {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_eqos>;
> +	pinctrl-1 = <&pinctrl_eqos_sleep>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy1>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy1: ethernet-phy@1 {
> +			reg = <1>;
> +			eee-broken-1000t;
> +		};
> +	};
> +};
> +
> +&fec {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	pinctrl-1 = <&pinctrl_fec_sleep>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy2>;
> +	fsl,magic-packet;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clock-frequency = <5000000>;
> +
> +		ethphy2: ethernet-phy@2 {
> +			reg = <2>;
> +			eee-broken-1000t;
> +		};
> +	};
> +};
> +
> +&lpi2c2 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c2>;
> +	pinctrl-1 = <&pinctrl_lpi2c2>;
> +	status = "okay";
> +
> +	pcal6524: gpio@22 {
> +		compatible = "nxp,pcal6524";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcal6524>;
> +		reg = <0x22>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pmic@25 {
> +		compatible = "nxp,pca9451a";
> +		reg = <0x25>;
> +		interrupt-parent = <&pcal6524>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "BUCK1";
> +				regulator-min-microvolt = <650000>;
> +				regulator-max-microvolt = <2237500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "BUCK2";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <2187500>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <3125>;
> +			};
> +
> +			buck4: BUCK4{
> +				regulator-name = "BUCK4";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck5: BUCK5{
> +				regulator-name = "BUCK5";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "BUCK6";
> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <3400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "LDO1";
> +				regulator-min-microvolt = <1600000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&lpi2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&pinctrl_lpi2c3>;
> +	pinctrl-1 = <&pinctrl_lpi2c3>;
> +	status = "okay";
> +
> +	ptn5110: tcpc@50 {
> +		compatible = "nxp,ptn5110";
> +		reg = <0x50>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";
> +
> +		port {
> +			typec1_dr_sw: endpoint {
> +				remote-endpoint = <&usb1_drd_sw>;
> +			};
> +		};
> +
> +		typec1_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "dual";
> +			data-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			op-sink-microwatt = <15000000>;
> +			self-powered;
> +		};
> +	};
> +
> +	ptn5110_2: tcpc@51 {
> +		compatible = "nxp,ptn5110";
> +		reg = <0x51>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +		status = "okay";
> +
> +		port {
> +			typec2_dr_sw: endpoint {
> +				remote-endpoint = <&usb2_drd_sw>;
> +			};
> +		};
> +
> +		typec2_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			power-role = "dual";
> +			data-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
> +				     PDO_VAR(5000, 20000, 3000)>;
> +			op-sink-microwatt = <15000000>;
> +			self-powered;
> +		};
> +	};
> +
> +	pcf2131: rtc@53 {
> +			compatible = "nxp,pcf2131";
> +			reg = <0x53>;
> +			interrupt-parent = <&pcal6524>;
> +			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +			status = "okay";
> +	};
> +};
> +
> +&lpuart1 { /* console */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&lpuart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart5>;
> +	status = "okay";
> +};
> +
> +&mu1 {
> +	status = "okay";
> +};
> +
> +&mu2 {
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	usb-role-switch;
> +	disable-over-current;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	status = "okay";
> +
> +	port {
> +		usb1_drd_sw: endpoint {
> +			remote-endpoint = <&typec1_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usbotg2 {
> +	dr_mode = "otg";
> +	hnp-disable;
> +	srp-disable;
> +	adp-disable;
> +	usb-role-switch;
> +	disable-over-current;
> +	samsung,picophy-pre-emp-curr-control = <3>;
> +	samsung,picophy-dc-vol-level-adjust = <7>;
> +	status = "okay";
> +
> +	port {
> +		usb2_drd_sw: endpoint {
> +			remote-endpoint = <&typec2_dr_sw>;
> +		};
> +	};
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
> +	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
> +	fsl,cd-gpio-wakeup-disable;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	bus-width = <4>;
> +	status = "okay";
> +	no-sdio;
> +	no-mmc;
> +};
> +
> +&wdog3 {
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_eqos: eqosgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET1_MDC__ENET1_MDC			0x57e
> +			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
> +			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
> +			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
> +			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
> +			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
> +			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC	0x5fe
> +			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
> +			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
> +			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1			0x57e
> +			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
> +			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
> +			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
> +			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
> +		>;
> +	};
> +
> +	pinctrl_eqos_sleep: eqosgrpsleep {
> +		fsl,pins = <
> +			MX91_PAD_ENET1_MDC__GPIO4_IO0				0x31e
> +			MX91_PAD_ENET1_MDIO__GPIO4_IO1				0x31e
> +			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
> +			MX91_PAD_ENET1_RD1__GPIO4_IO11				0x31e
> +			MX91_PAD_ENET1_RD2__GPIO4_IO12				0x31e
> +			MX91_PAD_ENET1_RD3__GPIO4_IO13				0x31e
> +			MX91_PAD_ENET1_RXC__GPIO4_IO9                          0x31e
> +			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8			0x31e
> +			MX91_PAD_ENET1_TD0__GPIO4_IO5                          0x31e
> +			MX91_PAD_ENET1_TD1__GPIO4_IO4                          0x31e
> +			MX91_PAD_ENET1_TD2__GPIO4_IO3				0x31e
> +			MX91_PAD_ENET1_TD3__GPIO4_IO3				0x31e
> +			MX91_PAD_ENET1_TXC__GPIO4_IO7                          0x31e
> +			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                       0x31e
> +		>;
> +	};
> +
> +	pinctrl_fec: fecgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
> +			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
> +			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
> +			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
> +			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
> +			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
> +			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
> +			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
> +			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
> +			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
> +			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
> +			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
> +			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
> +			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e
> +		>;
> +	};
> +
> +	pinctrl_fec_sleep: fecsleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
> +			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
> +			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
> +			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
> +			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
> +			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
> +			MX91_PAD_ENET2_RXC__GPIO4_IO23                  0x51e
> +			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
> +			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
> +			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
> +			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
> +			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
> +			MX91_PAD_ENET2_TXC__GPIO4_IO21                  0x51e
> +			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO25__CAN2_TX	0x139e
> +			MX91_PAD_GPIO_IO27__CAN2_RX	0x139e
> +		>;
> +	};
> +	pinctrl_flexcan2_sleep: flexcan2sleepgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO25__GPIO2_IO25  0x31e
> +			MX91_PAD_GPIO_IO27__GPIO2_IO27	0x31e
> +		>;
> +	};
> +
> +	pinctrl_lcdif: lcdifgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK		0x31e
> +			MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE		0x31e
> +			MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC		0x31e
> +			MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC		0x31e
> +			MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0		0x31e
> +			MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1		0x31e
> +			MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2		0x31e
> +			MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3		0x31e
> +			MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4		0x31e
> +			MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5		0x31e
> +			MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6		0x31e
> +			MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7		0x31e
> +			MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8		0x31e
> +			MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9		0x31e
> +			MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10	0x31e
> +			MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11	0x31e
> +			MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12	0x31e
> +			MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13	0x31e
> +			MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14	0x31e
> +			MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15	0x31e
> +			MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16	0x31e
> +			MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17	0x31e
> +			MX91_PAD_GPIO_IO27__GPIO2_IO27			0x31e
> +		>;
> +	};
> +
> +	pinctrl_lcdif_gpio: lcdifgpiogrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO00__GPIO2_IO0			0x51e
> +			MX91_PAD_GPIO_IO01__GPIO2_IO1			0x51e
> +			MX91_PAD_GPIO_IO02__GPIO2_IO2			0x51e
> +			MX91_PAD_GPIO_IO03__GPIO2_IO3			0x51e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c1: lpi2c1grp {
> +		fsl,pins = <
> +			MX91_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
> +			MX91_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c2: lpi2c2grp {
> +		fsl,pins = <
> +			MX91_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
> +			MX91_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_lpi2c3: lpi2c3grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
> +			MX91_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
> +		>;
> +	};
> +
> +	pinctrl_pcal6524: pcal6524grp {
> +		fsl,pins = <
> +			MX91_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX91_PAD_UART1_RXD__LPUART1_RX			0x31e
> +			MX91_PAD_UART1_TXD__LPUART1_TX			0x31e
> +		>;
> +	};
> +
> +	pinctrl_uart5: uart5grp {
> +		fsl,pins = <
> +			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
> +			MX91_PAD_DAP_TDI__LPUART5_RX		0x31e
> +			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
> +			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x1582
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1382
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x1382
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1382
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x1382
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1382
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1382
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1382
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1382
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1382
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x158e
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x138e
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x138e
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x138e
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x138e
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x138e
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x138e
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x138e
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD1_CLK__USDHC1_CLK		0x15fe
> +			MX91_PAD_SD1_CMD__USDHC1_CMD		0x13fe
> +			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
> +			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
> +			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
> +			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
> +			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
> +			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
> +			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
> +			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
> +			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_RESET_B__GPIO3_IO7	0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio_sleep: usdhc2gpiogrpsleep {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x1582
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1382
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x1382
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x1382
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x1382
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__USDHC2_CLK		0x15fe
> +			MX91_PAD_SD2_CMD__USDHC2_CMD		0x13fe
> +			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
> +			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
> +			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
> +			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
> +			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_sleep: usdhc2grpsleep {
> +		fsl,pins = <
> +			MX91_PAD_SD2_CLK__GPIO3_IO1            0x51e
> +			MX91_PAD_SD2_CMD__GPIO3_IO2		0x51e
> +			MX91_PAD_SD2_DATA0__GPIO3_IO3		0x51e
> +			MX91_PAD_SD2_DATA1__GPIO3_IO4		0x51e
> +			MX91_PAD_SD2_DATA2__GPIO3_IO5		0x51e
> +			MX91_PAD_SD2_DATA3__GPIO3_IO6		0x51e
> +			MX91_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__USDHC3_CLK		0x1582
> +			MX91_PAD_SD3_CMD__USDHC3_CMD		0x1382
> +			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x1382
> +			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x1382
> +			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x1382
> +			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x1382
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__USDHC3_CLK		0x158e
> +			MX91_PAD_SD3_CMD__USDHC3_CMD		0x138e
> +			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x138e
> +			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x138e
> +			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x138e
> +			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x138e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__USDHC3_CLK		0x15fe
> +			MX91_PAD_SD3_CMD__USDHC3_CMD		0x13fe
> +			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe
> +			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe
> +			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe
> +			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_sleep: usdhc3grpsleep {
> +		fsl,pins = <
> +			MX91_PAD_SD3_CLK__GPIO3_IO20		0x31e
> +			MX91_PAD_SD3_CMD__GPIO3_IO21		0x31e
> +			MX91_PAD_SD3_DATA0__GPIO3_IO22		0x31e
> +			MX91_PAD_SD3_DATA1__GPIO3_IO23		0x31e
> +			MX91_PAD_SD3_DATA2__GPIO3_IO24		0x31e
> +			MX91_PAD_SD3_DATA3__GPIO3_IO25		0x31e
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_wlan: usdhc3wlangrp {
> +		fsl,pins = <
> +			MX91_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai1: sai1grp {
> +		fsl,pins = <
> +			MX91_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
> +			MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC		0x31e
> +			MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0		0x31e
> +			MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai1_sleep: sai1grpsleep {
> +		fsl,pins = <
> +			MX91_PAD_SAI1_TXC__GPIO1_IO12                   0x51e
> +			MX91_PAD_SAI1_TXFS__GPIO1_IO11			0x51e
> +			MX91_PAD_SAI1_TXD0__GPIO1_IO13			0x51e
> +			MX91_PAD_SAI1_RXD0__GPIO1_IO14			0x51e
> +		>;
> +	};
> +
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO26__SAI3_TX_SYNC		0x31e
> +			MX91_PAD_GPIO_IO16__SAI3_TX_BCLK		0x31e
> +			MX91_PAD_GPIO_IO17__SAI3_MCLK			0x31e
> +			MX91_PAD_GPIO_IO19__SAI3_TX_DATA0		0x31e
> +			MX91_PAD_GPIO_IO20__SAI3_RX_DATA0		0x31e
> +		>;
> +	};
> +
> +	pinctrl_sai3_sleep: sai3grpsleep {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO26__GPIO2_IO26			0x51e
> +			MX91_PAD_GPIO_IO16__GPIO2_IO16			0x51e
> +			MX91_PAD_GPIO_IO17__GPIO2_IO17			0x51e
> +			MX91_PAD_GPIO_IO19__GPIO2_IO19			0x51e
> +			MX91_PAD_GPIO_IO20__GPIO2_IO20			0x51e
> +		>;
> +	};
> +
> +	pinctrl_pdm: pdmgrp {
> +		fsl,pins = <
> +			MX91_PAD_PDM_CLK__PDM_CLK			0x31e
> +			MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0	0x31e
> +			MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1	0x31e
> +		>;
> +	};
> +
> +	pinctrl_pdm_sleep: pdmgrpsleep {
> +		fsl,pins = <
> +			MX91_PAD_PDM_CLK__GPIO1_IO8			0x31e
> +			MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9		0x31e
> +			MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10		0x31e
> +		>;
> +	};
> +
> +	pinctrl_spdif: spdifgrp {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO22__SPDIF_IN		0x31e
> +			MX91_PAD_GPIO_IO23__SPDIF_OUT		0x31e
> +		>;
> +	};
> +
> +	pinctrl_spdif_sleep: spdifgrpsleep {
> +		fsl,pins = <
> +			MX91_PAD_GPIO_IO22__GPIO2_IO22		0x31e
> +			MX91_PAD_GPIO_IO23__GPIO2_IO23		0x31e
> +		>;
> +	};
> +};
> -- 
> 2.34.1
> 

