Return-Path: <linux-kernel+bounces-198609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E04578D7AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F55BB21A2C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2640D1DDF6;
	Mon,  3 Jun 2024 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="AAl28D2N"
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2133.outbound.protection.outlook.com [40.107.127.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF329411;
	Mon,  3 Jun 2024 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717391848; cv=fail; b=gqqe7G2vWAosd0CFRP+Q4IxZZkVBH+sd27nWKd8wtg20SKRZ51Vf7mysNYBCRSkuUCopyRnRyBUUSC6FlDxHyJGX9FxLXZFQiwrDEocp1oTGUqKdy6R6P+2TFq3hBJmbSiaNGOgfqngOPtz7Aj9OsR1Im4mR+MpE5r6taPPsVj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717391848; c=relaxed/simple;
	bh=7chkfxR2wrsDHz5xEPvZlusbPhU0Uk4eIglKK+g4laE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=of3UNMgiS09amAef+3yiuaDgplm8Gw3CZonegs0qUSdZdzMda1sMkrB/jHpbAIc4id+yQtNMxNexEWC8oLTmJHoXIdbT1HQ0Zl6SirR0wMpsocD+Q+V4klsNA8DDJ2PSe0iczpz/GxB4cOqfkgg09dgh7fVXSxE0YZHx8zA6xaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=AAl28D2N; arc=fail smtp.client-ip=40.107.127.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R96+DqzE6s0JlJo6mdKoNdd2Guq8GNEbS7fbY7rdmEiAOCtLoG+l5XemiXTCeZPjrTku3svAsjpzjoJeupv1+AXHgIcJR4uPHu6hJuUfM4olH/6m5fYz/5GYYmU+TvD5Q+0BHfbdWi1wBfNbzs1mz3gjk9tMT523+rB5zHS2daFdJDd7Q5kiJz3A37Cxad6ChJV8Z5k2zgzEc/FTuIJ7kFEtWFTg4IHu+T1yyOFytLbLYgPDO0vPAOMLv5sslZvrBDN3p6YY1jWVEFRUvTzxYeeFcqebxNTDO0U8XbOY2Egnkzs27uFwY+p1kuE1wuZK2BgSZ4xjeK8HkG+QauwRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUSZj/NrWsc5H/ZLEYQw/WLHtj+ERBr7+o4vatuGwJs=;
 b=k4bQa+C/DzSe7qDcujeFBJ1/riYCDPpzUUfJO3Br2XWHtW7l75zF/Z5QwGm5sigeWpH3BkJmZYL/IvV0jeOjeLVD+HtoMT6zBGCDg5e8UB4pzqTdIgUkzt62ToBCUwrKQc1Y8+DQnEm3tYtZgj26SA8TKMiihP77fA8qg0nHAXVTnsfWt9AiwMIGE+KcApT3jNiMQEXOHiDEZTprlNfVtHy3fmlfmrUj3k4+hH0jm1A/XX+sAhAiApyzTE7iAQ4USs5G90TPTI3xV6S+nN0XuOl4qpLHSNHZ5NQiOcDm6+qD5QG5j0SjztZc9YIrOriIQG4B8rCg4MYd2QloDw/pUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUSZj/NrWsc5H/ZLEYQw/WLHtj+ERBr7+o4vatuGwJs=;
 b=AAl28D2Nc4cieGgdOfBd8yOEp128x7dwfNy0G3VxDnlavkkPlUzt39iGKGC+9tW9j47FLUNj6vpVt9smwE946ignuK30udre73l2B9UMMZGcBjVSu1ui2vBjLjM2UnrLXwThusf3fArfHKwZ+AnhFpyBFRtdupAsEyqFp7M2j+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by FRYP281MB3049.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:6a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.7; Mon, 3 Jun
 2024 05:17:22 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7%3]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:17:22 +0000
Date: Mon, 3 Jun 2024 07:17:21 +0200
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] siox: bus-gpio: add missing MODULE_DESCRIPTION()
Message-ID: <6qzhpezww52kpqjx7npxoevihrimfwqgrq5ksxkaetkrnbgxev@kepw2evc42rk>
References: <20240530-md-siox-bus-gpio-v1-1-6a2f943ac8ad@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-md-siox-bus-gpio-v1-1-6a2f943ac8ad@quicinc.com>
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|FRYP281MB3049:EE_
X-MS-Office365-Filtering-Correlation-Id: dc926d67-5764-4728-9fe2-08dc838c72af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fVmSjMafuIEtGOSsABOdQ7OGRRs3X14ghMtRqJKXuNFWA6rfxrreCohSc2oN?=
 =?us-ascii?Q?Rb2YqaiE2dpGYbGgO1xm/A/FBNmZO3Y/43D/EFOhJollhgIsKk7rl6RuQYZL?=
 =?us-ascii?Q?l0c1MvaCcmPRkcWP02rjNOK+wk9Xfv3FzPrsdoJFpz92NNoEp5HF63jieel/?=
 =?us-ascii?Q?Hqx55DgOulF3iXed34qElDjdivgAs08vufhTYqUo/ct40fVVmOxwjiIASb5k?=
 =?us-ascii?Q?rUCcb2JBzpnmYTKExatSSynnGGq/Ukm3tROkAB5E6Lk9Zwb8Y3u05KWhB3z5?=
 =?us-ascii?Q?ZWSw8v7XbWZQsc0ObeKffy5slcJfbY2LSqaueZhWW0nkGnXKl4Jf66s2Scwo?=
 =?us-ascii?Q?znlOP1y7akcg3LIZj1Hy7VvjOn0ZnPZx+g+Qosen0XLfPJvxgItwE/7khDbd?=
 =?us-ascii?Q?wVCCg4z5+D0pTI9495s72ENcb9stg0Y0tH+IGnjNR2jgMaqlEbmekgQYcYuG?=
 =?us-ascii?Q?G1hl5KxUS8CVMz6aV/adguu2VUQInqvsbA1yD1TLiP4Vm46t8BNtIkA7ca1j?=
 =?us-ascii?Q?ceB3mIzhyY8KdEoiDAWak17NhsSHtQYTC0mrKIzF/PBoYnfxlS9BHDYgQenm?=
 =?us-ascii?Q?/p7LaYBNYsUgD4pi4to11/fCeueiWMdaaXXNto7M0seflEjK3ylHgUVeQhsf?=
 =?us-ascii?Q?DPdyU0p8zhrx459bGEy8emWN050NmhW4wFGHmUEE2QCSEY+hGVvwUfHPYyM1?=
 =?us-ascii?Q?OWbADAjlqmxZP2JFei7p2nX2XzSkpQS9y5P2Ko+7EvmRabZJSm983n6oFya9?=
 =?us-ascii?Q?DRR0LnrISsdTPNMc2VvlxeyqrvEnBhr//HyDk9Ly7HwX/tHBHYGBAzfbhXRs?=
 =?us-ascii?Q?7GU5eJLve8IvaD50HKQZT/VEnY6Mbbhq3O3M2Ip5cc/4X0BCZXCINOaVn94j?=
 =?us-ascii?Q?+w/NG+fWDG3UXY018G1vq3Wt41RlErA2q0fn25JUlBQPgBh4WFMm7OK5/0U+?=
 =?us-ascii?Q?Gg9znFu1Y34rTxC51tkUhSo3srYyyeB4ykp5BT2/xkB7xH78jKjhO/I162XZ?=
 =?us-ascii?Q?9to6e91SihrNwZiAxSQ6IPvpGvFmCQRT18FcS4QflkyhTg3bG9U24VjfJowT?=
 =?us-ascii?Q?Az9FaoAuunLsrZ229OWDDTb0eNlUR7Wys3B4twH/qKbLUkyRuZ5By1yh4zfo?=
 =?us-ascii?Q?5/+SnkvcMrgL4dbCLfyXida7BUeescrvm2PbLWUeaWsr4q0uMEU/GKJk3BR+?=
 =?us-ascii?Q?Z2MKwnYLhpBczocX1unvuQAukeGeVvUrjt3qvl4rz9j/WF4UZHMQJTk7niJk?=
 =?us-ascii?Q?zgB3byD5AUuTwx8D5ToYYVWNGWPGJ5oBZeWjoFnlSw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pK9a/UGSBTFhaNe+jWw4/qbPSlNlC9qpTP64IgDD9dpVPLSqSPG66DYZjR+h?=
 =?us-ascii?Q?iW5ExsdRnc+8kid+irtRsehlx5vRt7bUuU4UvuVCqgfR7KTwerCh2KtdWDPZ?=
 =?us-ascii?Q?2bKWKVH/4ZOtKv6FFp+qH9ov27ToIQAc6xqZRjHN672cJC17VdhFRuivILFB?=
 =?us-ascii?Q?MtQdEh5VjF7JUASGnRlxXKF+A6koxYLtT8shUktwGILlYBmUDjBZZBMoXPuF?=
 =?us-ascii?Q?jVVOq0x+doUcUsz0TmpxP+ocRaZVBKtvIJm/ds5r9uqD7dnTWTFAKZwuoC81?=
 =?us-ascii?Q?D7+o5DhDV3TWzTbPuWtBQQXE0O+SzRHvA/p2Dspw5NOIIj1EOfQk7I//2bvk?=
 =?us-ascii?Q?H3d0TH5bM8vxaCIA6AAGcZdw5U4p6miJZtiHlCYCCU6l71YA/nA/fbPF+DGK?=
 =?us-ascii?Q?TKJvER+765EXKAdfocYq7Oa1SrDl5bgWz5BIs2+kuG2makbSz8zn9RDyNvpF?=
 =?us-ascii?Q?CYUZ5rELXQXfyjlqYL8n3+JYMs6PhhAcnTumRzOV4j+HZ5cwRnlYlQhFNpS2?=
 =?us-ascii?Q?qMW3pkwFhiBzoLwh8M8XJSAbJp2P7TcMsvg66gkq0lCFGb9OeEQMBB2Dn/W0?=
 =?us-ascii?Q?H50H2v9oDo1iSrKFrEVMahM0TO33Nio15+Is7obVz8ErBGG4v0R78Heq+BjC?=
 =?us-ascii?Q?E66+ar7F6BMcLV9vk5zRxeQBRpSHsgxP90O+MJwfBzKxCUjM5aplHa+XKsms?=
 =?us-ascii?Q?zrGBbNpBLH5wXqtACemGzAc08Y4hqmwog3HGwX5eLMbV3Iw5YSvAjkDjx2Lc?=
 =?us-ascii?Q?FGsam58TlaXsKpzaFfeuRwyGkvxHwy7fgr0KQWitQPfYPdbIjuYKemZIoZxX?=
 =?us-ascii?Q?c25OBldk/l4BVbMhusZlaUomYH2doYR3k1nC1Bi1tlCg2MOSijoIt6U/ZImd?=
 =?us-ascii?Q?R7SV9qC12OCf7129r3Xw6SJWdGREEKp+FXyJsFIktPOwIEA45vzjlKXvCUIf?=
 =?us-ascii?Q?9toZ/0p7QuwpNMMMTt9PdS9D2fVrX4DGyk1VQYa4MilkWOfTbLIdzZm2DjJz?=
 =?us-ascii?Q?ko5VqAj7K2N+m4rrwuUrx3bh4aaex+9EXoXgK5ilTMy31nP+tuTEKWd3TCDY?=
 =?us-ascii?Q?PPMjvFVEXBdgiqAVOS2hjL/aa0FZvkqH1P4PRIpA9oSIGN/f7vukZe+EFGP3?=
 =?us-ascii?Q?c2zDefg8k517fNiylQIMvV9obzqKCRPDDLNz4WLegzZ/6dLxir0jtLacdQKJ?=
 =?us-ascii?Q?NOPxEEecfDyGWYX/Znfb9b/bDoG64Izz7Xq9jzfr+REHH3vPZLy7mXRVJ29m?=
 =?us-ascii?Q?uEz8PwdYwjR+pciJZV2S1ge8gLTFXQHw2LHyHgLVyCW0fp8gFhRJD0Qsk4wa?=
 =?us-ascii?Q?MnlF4+6BZsIBXCZzEClL03KDP282hU8NyTg2BhcMlusqSSzLIhzUcK3xWqeC?=
 =?us-ascii?Q?x3iPfvOGVitU65W50wEMoLieCl8rEl6yylD5DngGmtJtOOS8Kq2jvAn+LTT2?=
 =?us-ascii?Q?BLGEcFc4FB0FHFMVGoK7QyEGOSIFA/KXITvuta1d66ca0Y0oGS4xOycWnGaf?=
 =?us-ascii?Q?/y1Ohj4eQTKZ2PRXvHrERyHlzDKX1QtSfbPjv+S3sEHo5kx+EKa0a91nupC5?=
 =?us-ascii?Q?AThJKklK1L6shFGZYY5UyjKfqAf9aN4EhpjnpaS8zqDIxI2kZ1U2pa7kehwG?=
 =?us-ascii?Q?gwG0FYfxTOKcmb84SPMYzLI2eydEeyfBDRIw/FBjfH7kY/Wxy496jopIVy7W?=
 =?us-ascii?Q?EeB8DQ=3D=3D?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dc926d67-5764-4728-9fe2-08dc838c72af
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 05:17:22.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuJWHXAbfqS7U5IuSK2P/vHIgzV8OAHLvElWg3et1y0OOM9XvmlaDD+tiP7jdpNvTBlyuy7y/Xsul/bBfV56oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB3049

Hello,

On Thu, May 30, 2024 at 09:25:37PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/siox/siox-bus-gpio.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>

@gregkh: Would you please pick up this patch?

Thanks to you both.

> ---
>  drivers/siox/siox-bus-gpio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
> index 9e01642e72de..d6f936464063 100644
> --- a/drivers/siox/siox-bus-gpio.c
> +++ b/drivers/siox/siox-bus-gpio.c
> @@ -148,5 +148,6 @@ static struct platform_driver siox_gpio_driver = {
>  module_platform_driver(siox_gpio_driver);
>  
>  MODULE_AUTHOR("Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>");
> +MODULE_DESCRIPTION("SIOX GPIO bus driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:" DRIVER_NAME);
> 
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240530-md-siox-bus-gpio-72cba921cf84
> 

Best regards
Thorsten

