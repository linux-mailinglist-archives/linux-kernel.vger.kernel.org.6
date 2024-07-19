Return-Path: <linux-kernel+bounces-257265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12FE9377AB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5781C21350
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9528E12D75C;
	Fri, 19 Jul 2024 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rfVCwQqo"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2046.outbound.protection.outlook.com [40.92.40.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85911E871;
	Fri, 19 Jul 2024 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391697; cv=fail; b=JqitrrzbzrYmC91q0jjc6hq5a2GSFSuAb7KhwJOmlsNgsoJAVXzUfCDerZM79Q02EUoD2VUvkLGm1NUzONBUU9uDPNRbqj2EPeKCu/zzkCecJe6TNpLfuYYjjEUrANmPBX2fLOLyP4m5HQNwmrC4ITuFdQtQxT3LUQIissSPO6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391697; c=relaxed/simple;
	bh=ZR4GSMWIasNboXn7A4zReGRnezulBPhkmXt2u3aeTME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BXEBQjYAmNneEkET95kpctyDPypBXSbd8qJQr9VlIkirw9SuDjqDzVueT1pRXjn9MhybWwk6Y2mPy0y/IXgD2BxTZaubr4KbWkcgluce8Nnea2wTYKTz9fcxnFs9JOLUBHLMOpzX5ilZT2gok56JBW08N6gvBFXAo/i1W0B3vvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rfVCwQqo; arc=fail smtp.client-ip=40.92.40.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEOA+0UYNb7e2Cmd0yWNri4B0V7JBEvvrUVvex81lpDElFX9huKceQ8IDs+lhb6YypoTQQuEGDdSl0coIAhy/xqm9twgoqIVJRUrrAf+Q+hZoVmGrie2t/SLsYt+CRsCmJ7FvUVP+V6bcfTQXvajBYcviIzVY1bXhrNOQOOqn6Vte0Fdtud59Oc+T+DJiDtYAiILUFSaA9qFcSrOyyjsn/sNgqPwNCbN6svvCMPdqVpXwvkyZs1IrPl6fqZPtf1favOmRfhVY6TZen6gYzi+bbOowpRwGrUBqWUOKOrm5V3tXE7boaHuAtwtoxP4LjgQQueD4AMo/BjPhTx9TfRgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tldqgHwrNX2VRPJfGlCdisHuFFXVMjkMz498lCn6uCY=;
 b=NYC1lqETPzCoYRpGUWbTt5Q26bdeVdC7KbSH6jMAhH0tv/cETC85jm2CsC0/O3HXjFuMNxUlP2pUHrle1FcflFL5Z+W9LIqxO/3/38lO89btNUvtAIJb2zzHC6b0v6J8f97iG+74SUxeQp1b4XWuhDfWO/g3rgreTJXUDQ11WtuByz/vlm9jf9b+vBaGH7M9abe5LUDq8/fy55Zw5+yVwKfyWVP2GWGzPK05q0KHXTFgipWFWolcokfhfEnhvbl889pePyYDl0waSEF88K0J7zT9qmgt3/WbzI8gEVvHaQpXBfswCGIw0PEhnqJzgWcvQwLCndPpD3PGny6Ut28M0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tldqgHwrNX2VRPJfGlCdisHuFFXVMjkMz498lCn6uCY=;
 b=rfVCwQqosrYWK4Hok8cjosOYh7bnBFVz6OeO3IVos2l2LQk7O82Pw1hNWJrkC7KFUe8DPb6q7DiJiUccv34csgGUVQ+ofTAJ5Zp9OepW+FJtdwEVHU4J3lFOuF5643DD2r4k3nxOteDo6XhjMuAZ2eqYuTi0h/7ukgDw3hs1L8FNjFagSpYQ2e4MkygTIBF01M5yTcVmptCZVjPC2cJnWwY3zH8RIpOW3GSdIROitZz/dp7tbZjmKiRj5516VOsB4xsJ0cqjKHIHSoiwjdMJEIMUzyacRNP4N6T4wgnOq8dwEno9oihLE/S69QuNm752UaZlv1LNOxqk6Yhe/TDytA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB4644.namprd20.prod.outlook.com (2603:10b6:208:377::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 12:21:30 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 12:21:30 +0000
Date: Fri, 19 Jul 2024 20:21:13 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: limiao <limiao870622@163.com>, mturquette@baylibre.com, 
	sboyd@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	limiao <limiao@kylinos.cn>
Subject: Re: [PATCH] clk: sophgo: fix warning emitted by objtool
Message-ID:
 <IA1PR20MB49535179A6C3D854420939D4BBAD2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240719115727.27857-1-limiao870622@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719115727.27857-1-limiao870622@163.com>
X-TMN: [MxAeWPGvkM73f1SSdifJo6PUZcBFw2rS1feT65rSSAs=]
X-ClientProxiedBy: TYWP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <uiopz3uhmsgtjz7fmrzntz7uadaseqkx6xgz57hmb3r6fvdpqx@uae6crqaja66>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a63068-15b2-4a38-5599-08dca7ed518c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|3412199025|4302099013|440099028|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	6jZIdlsoGuclGzfk39jpCqGhAcrzjkzp7wUgAee91B4FRF7i6lboO8eixaNmvgPyrR8oOcJHvrdbhJZJRhY+d0mB6++vgEFnGoiqTvva6sVKZZiUYhsoaaybkE+JvGwQD6jwCIZr5BrErJIHxVXJFALveBX6Bp6N9l/i3VNR7SyLNAWNTmmQsJTGkL8Ikxh4ao2j4NM0bEPPsD3TQuTMIQT1dRwDf/M7ZyNxq5rjazmA+CQpVlwI8VO2J2NSYP+q+AhZlh8cHyjKFQE9cUVrF0Y7O9/1A594jPlyXMJcfybIlDctsghNdmlu3sUfzN10/yozD4U7WmywVTGG1Y+8pcTlUUG0TasQQmyQw3U1/oGv2BGzhT2PuQ/7MfTXFsjAa/rvrPKxrIalrPrPTSHjaln8zZwfiCH2C7MrV6jdq/p0q7+9jdDkehra2Qouf3oLEN35XnKuViUinOXMwzKqtfanuY5a6F1QY7iuscKJAT7z2+fpQTRpEDRQrzcPw91uNJFVE1FdfkZ2fAWBpSlaX/E15wKOZ72sM418nVAxsFofkRcMM7Y57BzfSOyzZM98mPYvU7k/SgUowFZCOEJa/qTFZyi4mURo/44r/br1S6KG7y20TdAUFfbUISGMikhZKygHRM7IECNpn08jyM4C05sl8QeFIdxzbS5q8+kQw/n1I/LAdNWJ1TOfraCWM5wDUkjEP41mRvzBz8tp8au9U5VkaiP/F1wDMpuwjgdTLRaRja8SRNFKSJ8rXctsb//BFkbRF7FEq6WxyBvNt+tWKHCsJXHoZMtYNjkyPi89v1M=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qW/LZSBQorppeSOU+5QfNwXOGKhcXD0UFPeBKBegCxihN/+nzb/3KJCs3Rrx?=
 =?us-ascii?Q?n7mjCAGfT9IHvR8sOBSlhb4P13BqYWNk651QPxLR9iV9VoHh+MQHzHLkM6iG?=
 =?us-ascii?Q?pmY2hxnTj9sNC2WyqJmiuTbiyfYK078O6tAS4VoKfY2nGSGk82STJD3NmR97?=
 =?us-ascii?Q?rUSGJnG1ox0Zj6o258kjdHy9D2NTAFSKM1w8y5eFyIgPdEV0hM/lf/abClvK?=
 =?us-ascii?Q?zVClYFeXi9xNBvNfOaoK8Gv8veS0zqTz8VJZqH9XUZ4nRDuJ7x/m6Hh8IiWL?=
 =?us-ascii?Q?QvvvxqTPbAH7ZAusIGjvUgEhYAHMiV6siMrEbcV02Kchb9C5JPWvT0wzsa9X?=
 =?us-ascii?Q?2xkeD+36huC/6rpOEG8w39mWu6xLbiP860CHB0DpI187epz3S4UZh2Krg0Tl?=
 =?us-ascii?Q?XqwxXSRBoVAsl4Nn9c8A9GgSm3erSqDzwcic88zfknAEZPeKBq2WR5Vtgch9?=
 =?us-ascii?Q?1KSKmnrjgtTQV89vFx8x2deG8f61vEi4ZelYiRZq6G1XThDV1ayqM4u5Lt93?=
 =?us-ascii?Q?QHyoTbb4XL0mGyVzdS3VmbnZH9XFXuGXenRwTaQ5ZTRFbB8oC2jo+2YmbYuu?=
 =?us-ascii?Q?wmw7F72/DccAor9bhD8MnVQk7GExp6isUIbbALyYmYZUCXdLTGiRE9sRXOeX?=
 =?us-ascii?Q?9P3lbDThmRN12oauA2PNTaasT9Ps/sCsr8D3s/dSbJvFtBjgTDba+ZXex4FB?=
 =?us-ascii?Q?V6/4yc01rUcucpxUYsUs0oMcd9hnMYvnIVAk2aj0V8By81vtjCb1yBzOOdd1?=
 =?us-ascii?Q?6yJajAwQuUzGdg1gCK1E5ILjAwEJCGddnXKsYwYdotm4ApYx5mx4XsekHWue?=
 =?us-ascii?Q?rLVjU8YbRoV7kZOHZlSJBm5iwRBxQmyDhU/LnmnYJLWbMgGmUOy40XNzLiY5?=
 =?us-ascii?Q?11mUbWB4DhaM2OkTkEuloB1gDdrzmZDEtBHo/PRubWjnNG4ppxGfzEkEwK8j?=
 =?us-ascii?Q?Wn6MKYiWxqK42KTnHINJJMz2qQiYq9y6rPaW/ZAQ2/pnXujAlmasJSp5uNYR?=
 =?us-ascii?Q?NsnY2yEETcIuJAmw/F6DCT3LnZbiVZVkUityRcmBcn9V3WK68Csokb1eJD7B?=
 =?us-ascii?Q?g40t5NF+XRRwZLEK25TeNQs3Z55HizmpzTCDHtw1cQ+jvBy2yPZuxUaOMBa3?=
 =?us-ascii?Q?4J5IK/7bGJe8p5fZxVKrGhHbnXLEi6bkpEb5FBJznn7hAyyV36dbEqWumeHY?=
 =?us-ascii?Q?0ARoq5aG8i9yq8inEJCpkJQkdikVzCNcnOUhASmRwy0kt/SHmWTs8r04m9ct?=
 =?us-ascii?Q?BugnIpUCEDZY7kSyijOI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a63068-15b2-4a38-5599-08dca7ed518c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 12:21:30.0651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4644

On Fri, Jul 19, 2024 at 07:57:27PM GMT, limiao wrote:
> From: limiao <limiao@kylinos.cn>
> 
> for ARCH=x86, the combination of CONFIG_OBJTOOL=y enables
> a host tool named 'objtool' which runs at compile time,
> when CONFIG_CLK_SOPHGO_CV1800=y or m, objtool will produces
> the following warning:
> 
> drivers/clk/sophgo/clk-cv18xx-ip.o: warning: objtool:
> mmux_round_rate() falls through to next function aclk_set_rate()
> 
> we can find the reason from objtool help document(tools/objtool/
> Documentation/objtool.txt):
> 

I think it is duplicate of
https://lore.kernel.org/linux-clk/c8e66d51f880127549e2a3e623be6787f62b310d.1720506143.git.liqiang01@kylinos.cn/

> Objtool warnings
> ----------------
> ...
> 8. file.o: warning: objtool: funcA() falls through to next function funcB()
> ...
>    2) funcA() uses the unreachable() annotation in a section of code
>      that is actually reachable.
> 
> so we replace unreachable() with returning an errno to avoid this warning.
> 
> Signed-off-by: limiao<limiao@kylinos.cn>
> ---
>  drivers/clk/sophgo/clk-cv18xx-ip.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/sophgo/clk-cv18xx-ip.c b/drivers/clk/sophgo/clk-cv18xx-ip.c
> index 805f561725ae..0fe9a9bd3f49 100644
> --- a/drivers/clk/sophgo/clk-cv18xx-ip.c
> +++ b/drivers/clk/sophgo/clk-cv18xx-ip.c
> @@ -602,7 +602,7 @@ static inline struct cv1800_clk_mmux *hw_to_cv1800_clk_mmux(struct clk_hw *hw)
>  	return container_of(common, struct cv1800_clk_mmux, common);
>  }
>  
> -static u8 mmux_get_parent_id(struct cv1800_clk_mmux *mmux)
> +static int mmux_get_parent_id(struct cv1800_clk_mmux *mmux)
>  {
>  	struct clk_hw *hw = &mmux->common.hw;
>  	struct clk_hw *parent = clk_hw_get_parent(hw);
> @@ -613,7 +613,7 @@ static u8 mmux_get_parent_id(struct cv1800_clk_mmux *mmux)
>  			return i;
>  	}
>  
> -	unreachable();
> +	return -EINVAL;
>  }
>  
>  static int mmux_enable(struct clk_hw *hw)
> @@ -648,6 +648,8 @@ static long mmux_round_rate(struct clk_hw *parent, unsigned long *parent_rate,
>  			return *parent_rate;
>  
>  		id = mmux_get_parent_id(mmux);
> +		if (id < 0)
> +			return *parent_rate;
>  	}
>  
>  	div_id = mmux->parent2sel[id];
> -- 
> 2.25.1
> 

