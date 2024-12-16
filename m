Return-Path: <linux-kernel+bounces-447787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9CD9F3701
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114D418851A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9822202C50;
	Mon, 16 Dec 2024 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xnavs/IW"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013016.outbound.protection.outlook.com [52.101.67.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21A126BF7;
	Mon, 16 Dec 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368733; cv=fail; b=DldA4O15qCkauuJIY/EWZ6GvX7C1y5As8ofk1rXI0mF4JGp8Y8iNXzM4SDh87D4fCitHiwmPQUOhT2ecKLcyySoVao9viVAsGIavNG0tEBr2McRmJicKkfVAcQJ0YTUPe79Rbpe+NlTTeXG2/3BxkCjG/TPvoAaKJW3xvQ7y7VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368733; c=relaxed/simple;
	bh=GFtHfR/3rAo2QCqfhYA2cxvKsN1WzQ90Zlau3znJWi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t0P5cRIJocsAmryUq5ECc3KGDG8MfPnXKIiqyt0swiTjQpXPrpZjhBq4DkE+4Ols1A/l1JZvmyxOxSkCHC8h7BjqOsxnDyMPxxtS4GYa/tbnZ/6Xapw2kY2gaBmE/yLf5yQxc3EsUtEOakransmsrvbyM7ZBUB+gg9r2iVgJg8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xnavs/IW; arc=fail smtp.client-ip=52.101.67.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6zMjGb5k1n6CIthw8pDOt0j8uXcJvhO0O8apjMdJ1HRajnjpcX5DjNu2b/+hLNVT0uiXswigLPhNPKwRxRyaJCC1dygXBcUCmc+Wb7AhzWXWgVsx2ADEpDhXvjeAoCcjtky2yU0pqOZt+0IQGfeVIykUH6QkDAO/vLFRgHxUbgNJIwWASt8GrnlE8V1LTbYCTZjcNw/2zliuFCA3xUXYN5S2ic69sLaYHP742yF3UPBpQiNQ/0/iB4zUjulEF1hj1WtADJKUgqRvEq2uUQMAiX48v0NK7S4BbiOfimqdQo3jQgzT5ZqdP3sbfh3BGpzhP/QqyWKx7Lr7cP96XtuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/wMXGWT5zV9EdCBDfgLyDiiqSUR6SKKO/j7KI7ucXg=;
 b=UnOZ/urrvDLVjJwurlZ8mIG20BQU5+U/MIDu4vL7pRFcPIEaIvMwp5V9Rc4YwPHWOT+h1TRzb5QsBi5WvneIOJlLEvob403MyOHQvftnu72wD3Xlet+2rKsiTt11TAcnRh/GTeStmyI1hvMkT2j/c+C2NzV8xocgoPmWkR13uqQdDjR6h1r2baPZHZOG8zwyGHGl1dQzZmBfg75p+FtL72+pGYpUsVZfocXxZvoucB+C86I83YoJDmKyHFQK5Md1NWciAkbU3RfqVL1qxnUeBPMiZ+KXwnPtA/KH4f6+GUDCI0nD5rU+xDo3JqbO97Jo3mFSqHZCj2y88hO0LkM8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/wMXGWT5zV9EdCBDfgLyDiiqSUR6SKKO/j7KI7ucXg=;
 b=Xnavs/IWzXGmXm4DWN40ZUr9vdYlhFFIdxoj3gTrNLza9h0+IDEwpRh93p2VF7/Nc09s159sWIy7tlO0v2OcPU7m4Z796a7tUy6b24cR6S2uMjF9taqh2Yaqa3I1IQ6CIYSsV7ehUskOhpMw7br/HPA4FynqUfBAR7U7CUDcGFWO8h52IVNZyuOyFaAKZjrm4aYZ0dXXb0sxoVhmvza3bVG/AA7pzbxxP3yYygaQ8RiPGQwBnPIILXMqq8RX6+zrgg8m3DkjwXyxRXwpKEhyAX0+RMxXyi19zxP5CifgfEsldWXMLDFwXUyBFJLALbLOWCOtNx7ZcVBmG2gx/Kf+Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8438.eurprd04.prod.outlook.com (2603:10a6:20b:411::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 17:05:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8251.008; Mon, 16 Dec 2024
 17:05:26 +0000
Date: Mon, 16 Dec 2024 12:05:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] arm64: dts: imx: add imx95 dts for sof
Message-ID: <Z2Bdzr4/hs4b+s83@lizhi-Precision-Tower-5810>
References: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
 <20241216145039.3074-6-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216145039.3074-6-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af40392-016c-431f-5963-08dd1df3d64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RYRj2JKBzEH4bOvjqo4GTfrixF+wHURabFpYjQrfVMO0aSrKSNGo4aFVfaKg?=
 =?us-ascii?Q?WXePoINhZ8Qy7IRPhPjacs7GdSwNpm1mYSeDc0f2in0wFhBDcEANWeMHKFor?=
 =?us-ascii?Q?2Y+fbExUuHORv6yfle1jT5Gs+D8jS14wLlbDAYR/BSrpqiAQW1+JuniqqoIi?=
 =?us-ascii?Q?EpoCEm6GJvKSE+r44pE+AmLl1cNFmZ1xT+/AvsHgF7kE0t7VJ2Y/UAfD2bn8?=
 =?us-ascii?Q?8rEt7GjfkLysmUCFR8CzUzkR6FErbTkLwgyq5rouyQCH35DwDvt0ozlrWZWM?=
 =?us-ascii?Q?FRzg9sToIls87mEfu+ynxA6LZv61x0owr5QBkZD8004+9hsf3tDcnbqgPMjj?=
 =?us-ascii?Q?ueC/kv9kathXjCnPsok3aD5WnDQ64MzZDdTikZhN/UmLExvnbJ3il3wWFNKG?=
 =?us-ascii?Q?CGfH5E/WrO38ylJBuZ/TxGaHchQ0//o7zPnmdsU0j3CCOqDEkZK2g+3C2vwy?=
 =?us-ascii?Q?aA3Ci7vgu+qimew33MnD8EzPYcK1G7noM3KLeD9q5OK4awIwkDIqoHEy9AqZ?=
 =?us-ascii?Q?h+YxboxJ+IwcFspJ1F/elHaLI/1xmqNjV3obJ61sZD9SpDwqjih0Ei2/1BkZ?=
 =?us-ascii?Q?w6Lsdtu/tpnY6jybwIBXUE3pkiPoYqlTQR/gnQnnD08UA1kxUBGYTg7B6hNN?=
 =?us-ascii?Q?vR7NjDUF+oAR3Yxzi+VdYUY8E/oiqeDKwiCuqaJup/ji0ODHQ+XEPEuQtcy8?=
 =?us-ascii?Q?302NC9btvdWIlU9wdyqxGC3uteMPSZJwn4YUl16a5n1u+FZzduawUr0u8CHb?=
 =?us-ascii?Q?SElmjzwa3oquf71VS/62nv+X3PBv9m61O37Jtrs2X48GvK+c8JtcDIUbbn/V?=
 =?us-ascii?Q?3xiPRAq6cKLJEt1VLoRoOkGsgEqtVN7koIIEraNzy7qEVdqGqRhFKQYbmPRI?=
 =?us-ascii?Q?GbcJRP8MW0lvBQRQrOIhqRmZrW+P9jdYTYf5g1gSPkvJHBc4Br+uILtD9+Yr?=
 =?us-ascii?Q?jdkaMLO7mOprKDvCB53pWRjqGWOrc4xaYhXIrwwMb5vACnKhkPjTpCAFHeu5?=
 =?us-ascii?Q?VDRhWvD2Th8gjhvspiKJ89kgwsRubkrGG4GPfoWmnd2prfJFoxcNAhBZflOO?=
 =?us-ascii?Q?bJliU9am5F3HZqkpqUl6Bi9KukfQAkkTdnXsj+BD0BhHoErKvtXqV0lzeO9W?=
 =?us-ascii?Q?/PuYIAC8bNi5nAJumg6KHOn/jIJTvXNnEo41j+JbCmjyaPM9hUr2g9GtG9Qe?=
 =?us-ascii?Q?o1ADDU0uUtG9xFfwcYmuTNqpKDaCVBMwVeQkxKLvritkm0gwW8vLOgAO6VY5?=
 =?us-ascii?Q?ABuqUweDmOsF7sXDnrNjPpBFZJg+T+n48TQ7wXx1RZ1ulKfgSkChpjhHA2EW?=
 =?us-ascii?Q?YGmyhTvO/dJfZHkCMxBfZG3R8w/AWnXztotRs28LOSqgrEmeSPuvKedFCDjS?=
 =?us-ascii?Q?HzODReh2IKNzppnglEtNkNrmeMK7GmiiS7DStH4oZ4GZBzBeD2D9MXXfVLku?=
 =?us-ascii?Q?Ln6ykn745hlHUJtKmuYRcz71Hsr4g+hy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gu/0J9+NC1cf8d9bWoYcXM1nxCyThbBCcWVZPNlAOv6JF2SP6shiwUR43yoc?=
 =?us-ascii?Q?UlAfOtEdL6gL/yQPjpMIbGZggJ3oz8BMd7R3ZVu7iwBkojdhcTOrAs3Z/J8M?=
 =?us-ascii?Q?14MzKYhJ/xj4wQZgVrOgTZQLpu3t7qkH7lDUQTtPXax83pqkLBOJ2VuJ/Pu0?=
 =?us-ascii?Q?LO4KrXM7Qt6Ti3XkCET7zL6kEmu8/6OkPtsWJk6v+W4wG4VXYqlU4JC9rcSH?=
 =?us-ascii?Q?pQsNvirukfWoezV1uDrW0NXwkX29e/mpfqYVJLtvsJtnM5H2VzrF76e3/NTm?=
 =?us-ascii?Q?sJp+TPFWCumw5BIfiwVp31R2WAl8X2OZc+okHVju2Fjzpwq3V7EH7J1f9afI?=
 =?us-ascii?Q?Q+8St7OvVC5yHsO7ygWS3ve+AUUHzlKOSU4L7M7XkXsnH76UovWOCjVGz3sR?=
 =?us-ascii?Q?hSi23r4BFZsg4qY2D3bJ3YebNA8VvAkEFNOSK9jnNobo+q3pW6CVrXhj0obm?=
 =?us-ascii?Q?ee4+KM9uPnfYDlUzG7qk00TxctISXk21MrUjy65sN46fXUn6ybMflqqa7tG4?=
 =?us-ascii?Q?T9vW5d1GFS8AqeVkNFvwsp+J0ifUxI02qqi+l+HvAqRqpgYgHGY+BVjaDIF0?=
 =?us-ascii?Q?dWVZI0dcG5Avk7ftYIn/StRqhBR0sABKMSDNMZ7TEX/8hBupcTbl2tWNO52h?=
 =?us-ascii?Q?tgq6gcmld9z4whl4Lh7Y2wRpVupUmN/aPhba0jqLulICeiJz+L3u0F55o7hh?=
 =?us-ascii?Q?30P9hF3BCSfLsF2KfMMUFNJJY9MtU8s9MeMrLyWUhTkFcx3M7HCdcBNuCGhg?=
 =?us-ascii?Q?/2ZU1n2Svb8v6ihh2Fddq1wdHTRuINybk0Y5KksKSactw4oQQlqnOK38/IJT?=
 =?us-ascii?Q?K8216B9Dzn+/Qn+rLN0PvIGTdlz5xUpUw/kmb2APtzziqwjRn2QMaLLDkQYG?=
 =?us-ascii?Q?+7vh3FDD67HtwyQ0X15gqqhvIB9rSq+TzEepWrvqdWlCS8me73Glh1mmzETA?=
 =?us-ascii?Q?UsbBqjg5gwajE5EUzpNgZeEdAtW6HJDq/O6CwvSRt6r9gDpgFpknTRhR9Tb1?=
 =?us-ascii?Q?/hhzcwylwEQqOQReKc4QP8Fj5Dpk4YpzAxg0hg1gN/PB9LM142ZFtV16sP/o?=
 =?us-ascii?Q?hWaL4PZ5cXwgZMYXi9gePSKDOyphWYrJtOOzDTD3fG7RWivk6xS0gAm6r46V?=
 =?us-ascii?Q?5FiUdyCpaUAB7V3I62r1aF7h1ENEdPnHCnU1JI3YJNte48/1fkB3oib0qIUE?=
 =?us-ascii?Q?Qi5vDgNZl9pBA2m1OIrgG1u9bok8Elkwdcx4dd6ksSEewtRImOjSFujxX/ed?=
 =?us-ascii?Q?9LxlOAIHrPQG7+LHOlKn8VDGWsWtnUGkv6aReLjHRovZ2tTRdnirUuCh8oYa?=
 =?us-ascii?Q?CHsni9hjQPTUWLggX3q1kTVD6EziV8XA29k8oVfIwgRShpvKpm54cDbIqF8k?=
 =?us-ascii?Q?ss7XszEBY5xB5N8KdwgOpBKzl+7uGfxGFc+vWaPMteq/1KKOwFXfqcRz5P3x?=
 =?us-ascii?Q?HfNWJEDI8/0dI9OHX//V8j44lOeXRs6XaLwIv3Gsqi9JHDxxH0PhkVXhT+vF?=
 =?us-ascii?Q?2YBuZs6VlI4qDaqaSWK9dAODQXngrl6OEfdG3xkc0Bu+2UzjYqMShdaEPNFx?=
 =?us-ascii?Q?qHYvbtentJ0ZWQQvgyU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af40392-016c-431f-5963-08dd1df3d64f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:05:26.7610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA9iV/CHzU/SKNMUnrt92+msBVl2ZTpiPFdV9c/CN8c6uftnbeYzTM2dkWvqbqmn4Qlgy23DMub5KdzemaS5gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8438

On Mon, Dec 16, 2024 at 09:50:39AM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add imx95 DTS for SOF usage.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../dts/freescale/imx95-19x19-evk-sof.dts     | 75 +++++++++++++++++++
>  2 files changed, 76 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 839432153cc7..27f64e333e4b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -282,6 +282,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb
>
>  imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
> new file mode 100644
> index 000000000000..8eef83d7bdd7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include "imx95-19x19-evk.dts"
> +
> +/ {
> +	sof_cpu: cm7-cpu@80000000 {
> +		compatible = "fsl,imx95-cm7-sof";
> +		reg = <0x0 0x80000000 0x0 0x6100000>;
> +		memory-region = <&adma_res>;
> +		mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
> +		mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";

need empty line here.

> +		cpu: port {
> +			cpu_ep: endpoint { remote-endpoint = <&codec_ep>; };
> +		};
> +	};
> +
> +	reserved-memory {
> +		adma_res: memory@86100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x86100000 0x0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
> +	sof-sound-wm8962 {
> +		compatible = "audio-graph-card2";
> +		links = <&cpu>;
> +		label = "wm8962-audio";
> +		hp-det-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_hp>;
> +		widgets =
> +			"Headphone", "Headphones",
> +			"Microphone", "Headset Mic";
> +		routing =
> +			"Headphones", "HPOUTL",
> +			"Headphones", "HPOUTR",
> +			"Headset Mic", "MICBIAS",
> +			"IN3R", "Headset Mic",
> +			"IN1R", "Headset Mic";
> +	};
> +
> +	sound-wm8962 {
> +		status = "disabled";
> +	};
> +
> +};
> +
> +&edma2 {
> +	dma-channel-mask = <0xc0000000>, <0x0>;
> +};

why need change dma mask here?

> +
> +&sai3 {
> +	status = "disabled";
> +};
> +
> +&wm8962 {
> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_SAI3>;
> +	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates = <3932160000>, <3612672000>,
> +			       <393216000>, <361267200>,
> +			       <12288000>;

empty line here

> +	port {
> +		codec_ep: endpoint { remote-endpoint = <&cpu_ep>; };
> +	};
> +};
> --
> 2.34.1
>

