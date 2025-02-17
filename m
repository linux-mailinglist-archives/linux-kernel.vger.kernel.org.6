Return-Path: <linux-kernel+bounces-518043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37BDA3890C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0383A9AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65C1224B08;
	Mon, 17 Feb 2025 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="Z3nXdZas"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E329408;
	Mon, 17 Feb 2025 16:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809482; cv=fail; b=nYfFK9gvAMW2vpeuJ3Kmh8V8DxNk/u8xj7H3jjMt9mF1UUirSuE2WUayGGNBBEMgWAHdXIyBdqWlz9KN3xqqOaPF0oONV+TSUSqEs4LhhVVOKck/yzNatYNoVxwFuHX0wUqakqslcw9XI45R4JHpOobfXfVki2YFix0lfj8bKqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809482; c=relaxed/simple;
	bh=5cqE0kcLaVs9EG1+dybQzW1L28JqPDyZICyjZDZl0Og=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nGIzqAgzYybYovG5zOwf43Eq5CQgCXcF7rtvgBvOlfX0innYWTij+2+ytakPNedFtN4V+QD4LqP01KtKQNLrbcAWFa2rFgDrioqjfb92EJyyWRIpVPmEJ3YRQecRFjhSJlQgKt4OaxhLKIk1ZKZXsLUkTrf+R8M7lg4mpUS+eLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=Z3nXdZas; arc=fail smtp.client-ip=40.107.20.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmmi3lvf2EOM3YOznqT2O1NY6EZd89cbJOKCLftC5uJu0gdUZZzP5BNTGkjkaYJ6LmFg6L0QyRNglEaRQe7hBWYQfW48wSrY23rTzV+xSsYhOb77M0HYBiuTrClyG2IT0S9Dziul0xxP3OIh3gdxNbcu7z5kaXlJ59p3/LT6Y3h2LpBvsiNCHQWtsGFtgcnGCGWo6jZFZbe/5NeCnWtiO5gwwEKyjwbFlqCOOHT9wPsiXbQun32ydFneXI8NXt/oRsV/3pDmdt8gVVKPUkinI76j31X0aNDWKUqNZN3G7DSj6NiE9VdQc6O+K+mcaU8TsMCsv4c+IGZtU3FCW5rVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+mTMD+pAH6A4YKrgr+gReSXGikIJE788Ny2TOlgw+M=;
 b=V8GBLnQkfdjNNVPx+jNr6lAFHC2/NRh9gfgi9auQFy8bqrwiFIy2aYsulI/7k80EhLpgQh1hRXxOD8oRutepnvjyV8knEXglg0oDGJobNArxMagGK3fes2Jje13gi3kqOmk1e2O8LHv88UTNvVaI3/J3zwwwPWyTx6YqEslXCAygjxgYXBEw1uryCE1KLQ6/5Vpu6/fQGpH5Q2Yn9UrqNGjYkvGDdprZyVx+19uylxeMAWz0Mm1LeHmh1YXeVNd1P9bsMVgusmreYpoqT6iwk2gD7i6dkQb5idz9UJi/eTdqoc+pwSqp7rNPwRi2m84W/8rKS0e0CjGDhsAnND5Ysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+mTMD+pAH6A4YKrgr+gReSXGikIJE788Ny2TOlgw+M=;
 b=Z3nXdZas/mzARyjOs2EEkTfMDhIp0hlv+EaWBtvp1lsragx8hKHhphPE8U/4s/UalnMscAFV7zycrFk4diWRlqTgPsHu5nCzcYjYFU6khnMHNRQwDyY2dfT7pwdguzgur22ibSFUgSyZKt9sg3in5OcUV3TSa4tqEtS3INPJuTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 16:24:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 16:24:34 +0000
Message-ID: <62901afd-0944-4ecb-8f3c-90904410a0f6@cherry.de>
Date: Mon, 17 Feb 2025 17:24:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/8] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588j
To: Alexey Charkov <alchark@gmail.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Dragan Simic
 <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kever Yang <kever.yang@rock-chips.com>
References: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
 <d8ce8db2-1717-40f8-b53e-24cc71a758c9@cherry.de>
 <CABjd4Yw-r-ogfwcrph4K1wbkybS25gk6LFg8wpqLG27uWdybNA@mail.gmail.com>
 <2914631.KiezcSG77Q@diego>
 <CABjd4YxF4N1tAgGUZk-oKkMUO+Q9rWHZsas9gMQdJ+TF4A1=NA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABjd4YxF4N1tAgGUZk-oKkMUO+Q9rWHZsas9gMQdJ+TF4A1=NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 0faad05b-4299-4d96-6db6-08dd4f6f9076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tmg4YXpXQXphVmpDWThrcVpGaGorT1FPMUtvQTJmOGlOV0hrOW12Y1JxZm4z?=
 =?utf-8?B?V3J2U1pWcno3bVkyNTdVZEN2amNNOXNqQ3BrcmZrcDU2MzlrSHhxSG9YTDVL?=
 =?utf-8?B?T1ZIM3hxUkRwQ1NvT1loOUFHSWNLSGx5Q1NkQWdMWng3NWh1WWJjbFpsek1M?=
 =?utf-8?B?VHhXM1dJNGVwQ0RJZGJaQm1rQjN5UGxwclRCbTRVQWNXVXVPaDBXNm4va2NL?=
 =?utf-8?B?ZkpnZENMOFVwUWhFMy8xWWQ5NWFoNmovVDlkTUU0ejFyNVhNNUJUSkhKQWRB?=
 =?utf-8?B?MUR0d21meEYyZkRjMHNnazFjRDViWUZvNThIRURQTk9yM1ZLRFIwMlpVbVNE?=
 =?utf-8?B?V3JJZWRjT1pVbWs2SE9yRVdxOUlteGRIT0QzMkJ3eWxnV2tKMG5CTlBzOUFp?=
 =?utf-8?B?T2NCQmJtWnNscUthWitGSFUwc01LME9FSzR4VnNpT3g2MzdZelFvNlozbm5n?=
 =?utf-8?B?UlVvTUNIRDgxN3lFNkk4RUg3SUxHTVNRUXo1V1NBZTZwajNQYS9SZzRWS3l2?=
 =?utf-8?B?a3lnM0cyNXg4KzRGMFdwOWtUWDV4c0F4QlFhaE1iUVVPQUpCWFRGTWNZclRk?=
 =?utf-8?B?NnBXOTZuMDdvbnI3YnlyV0Y1MXoySFhzcVZnWjhINitXeEJSTWpacHAxQ0ZL?=
 =?utf-8?B?WUVzaEd0NHNxTktZUG82SDNTOXRzZjQzU0tTYmV3ODd1SXlSU0s1bEVqNVZZ?=
 =?utf-8?B?RVRaMU8rTDgvQkhRQlJZRkhsa0hYRk1sNDZNUGtqeGZBU1FxL1dwUDZnQ3R3?=
 =?utf-8?B?VS9QUDQ1STV2WFhQZ2xraC92QTNncVJacWdTa2hpek00TlR2WWdSc1BFaDU4?=
 =?utf-8?B?bm4xcVhXK3NTa2dkYXpWaHArNUxLVVlkU0lSMCtzZWdQbVlRT1BwajBoci9G?=
 =?utf-8?B?NmVnM09rNmtiNmxKTGl2a1doNEJSUUVSM0FQZldCZFlqS3E2QnhyalFpeTFl?=
 =?utf-8?B?b1hSS0NUUnlJY2E5Mk9nNXdNQUlSbUJwMnNKYm14ZVhEcVJLWjFMOGJaUVRs?=
 =?utf-8?B?WUpCb3lhMi9oeC81c1lkY1NHRU5FQS80d3lUOGtrZFI3ZUFrY3c4RnIxT29T?=
 =?utf-8?B?VmwyZG50cWgvUUpDbWtKbW1JUU92RklBM3JsS3QxdDVBOEpxNldjTGcvM0NR?=
 =?utf-8?B?QmhCYUpUQy9KdHpFeU5KMFVBWnF0WTlUaDdLZUpnWE5rY1R0RUFGSXVZb08z?=
 =?utf-8?B?cG9YVm9TRjZ2ZitCM0lWUS9OWi9jdzB5K2llMkZtVndQVGRQQTZjZjBsc0J3?=
 =?utf-8?B?UTNqNmFmeUNnSlRlcFZYUXl4R2JZc0UvdXEyVGppRFNpM3E1OHZzV2NaOHZt?=
 =?utf-8?B?TWJwSUhlNS8vYzJVNFJzTE92V3N4aTMzRWRjckt6M3BPbzI4MllNOTBvUmpM?=
 =?utf-8?B?VjA0NjdOU2V4Wk5MMnRvbnIzNXd4M0xwdmNiRzNnSnMwakhGUzlTUFQyc2Ra?=
 =?utf-8?B?a1R3MGRVaFZiaU9rc3gzd2FVZ2hpRU0xVEF4TTlKSTRwMzE5aTZVWXhnN1JC?=
 =?utf-8?B?eVdoT05Vc0Jqc1FaeE9pWFpZSXJwVE1NbFRjWUZwekxZQk54TndSUTZ5Y2Jx?=
 =?utf-8?B?T1B3bTZnUTY1akQydEtaR2doQzgxWEkrNUlYSy9HaUtXTFR3WXdjUTBqazI2?=
 =?utf-8?B?UGNjTEE4enBmc2d5blhya0hrbzZSQThkMElDK2tqdTJWc3dBb1pCSklHV3Jr?=
 =?utf-8?B?K1RXbHJmUExKWVlQdXZnVWt6VXVhVmE1bkhjUGlPNmtINXAzTHUzS1NxNENx?=
 =?utf-8?B?YTFHZnRGaXZzNW5lbGlJajdvUUhQNXU4VERzZW1sR0IzdHB6KzVHQVNnc282?=
 =?utf-8?B?VDZKVGJGN0JWWnhyRE9oUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXhJc3h6UFR6cW91V3I3dmZyamlqYTdOUzVBNjRyQnlzTmFlTVl2UzNyZWlF?=
 =?utf-8?B?QVRKVkdETWJKQnVqc2lDUE1Jc0N2TWNIVHkwNEFFMU5hTDRtc2pmTjlLZGUx?=
 =?utf-8?B?Ym5ONXNOVjZUK3pHc096UnFNTnVRSlJvS2hCb0JtMTN3TjFFb3B0NGxsY1oy?=
 =?utf-8?B?TGRMTWtrbzU0V2dBZ0F4RUpBd2FUZ09lTHprcUo4L2J4dHhCbVppOUY0NFM4?=
 =?utf-8?B?dy9xNXIyM2NKNUd0M20xVjZNY010MjZ2WEtPTnR4TnVFb2RWbjdaM1NiUTBL?=
 =?utf-8?B?c09QcDB2b1B3RkU3VHVadUdaeEc5VmwySDhBVGZHQ2Qya3lOTjN3dC81V0hC?=
 =?utf-8?B?ZWljN2Y2U1pIazYrYkR5bU93QVljWHdEY0daRnRMalE3QVNaMEg2b2pOWUFX?=
 =?utf-8?B?Q0MzR1l6SjQ2d094MEZocEtBYWVmVGEvcHpsZjBrNVlUVUJIaVpFREIvTnhn?=
 =?utf-8?B?b29XQ2hBQnBWUEVzNUR5bGVhTURjb0dGLytvU2VhY0hpYXRETGRlTE1yaDQ1?=
 =?utf-8?B?L0hlcjJSNEN5R2VEaFlPeGFtZ1lkTXdvVXNkaHVrRFZNS1BoUkhBaWluWnVC?=
 =?utf-8?B?b2VCS3pXd24waXdMVTVwNE51KzRGMlN5VzI2VGhmVzlkU0x3amI2VEFWVlpY?=
 =?utf-8?B?elZ0MTBWUjVGMGFNZ0I0eHBHTElhdGh1ajExMy92RUNyNkgvSlZZSDN3MXV5?=
 =?utf-8?B?VHYvdDh0V1kwb2J2Tlc3eVB3UXd3ZGdEMFdkd25DQW1LTlAzYlQzZkxORDBk?=
 =?utf-8?B?SXN3VUJ2WVdEYlJjaXFxVFNMZ0FjRk8yVHdjM3dxdkhGVnE1bkhGVWVQZHJi?=
 =?utf-8?B?WFUrcys0RXY2ZGlXSU1uNE5JazdqaUZ2eEVDMkNlNjd0QklGRXloTFZHb3VI?=
 =?utf-8?B?ZStZdkVqREtZUGhKRlRPeXVQT1pXTmhkNGc3bmhqK2M4V1RXdXFmMHRPZVJS?=
 =?utf-8?B?WTNQc2hCQjl3Yi9hUjB3cTl2dGNJS2dIbXBpanJjd2h3bVJTUXI5SFQ5M20r?=
 =?utf-8?B?ZU1pVHpkZ0dRcHlhT1o4aFRPZmlxQXFScXJlV01XaTN1SWp6NlR1eWRoZ0cr?=
 =?utf-8?B?WEZ3V1BZamR6cmMzMGdISjExN0d5RCtIV0lpSU1Ka2tBSkhCS1hjN0tZVmM3?=
 =?utf-8?B?eTNUUTdvS1lLMjVVZUhXb2dhRUh4bW1CUHlnd00wcVpwSmhyaXBpbFZobkpy?=
 =?utf-8?B?T2VIMkgzUnNuS2ZIRHkzN1R3dWtpelg5Z0NKemNNbVFnaFpUa2cvckUyeEYz?=
 =?utf-8?B?NTlJd2dzaDR5S2s0SzhuaXZndlhxSm9paWdQaC9acnp3S1Zoanl6a1ZQaXpY?=
 =?utf-8?B?OTZPUzc0VDJhVXo4a3dGM2taNFh1ZWRqbWFJMGJYVGVVK25ZalltQ1doenNY?=
 =?utf-8?B?NDFEVWlPWDdmZFY1WUQwNTJiZEYraWxPWmlTd1o5ZEE3VlZndXpaamxlbjBu?=
 =?utf-8?B?M1pjRGZpY1l2WTlnYlU1Uy9RVTRyOU9JbWd0SGJiSWIwakFmbzdLbWIvdEhL?=
 =?utf-8?B?NDk3Sm42eENnS2I3Tk1KdEtNSEl2MHZlM2dQNEg2TFNqcmYxa0NrTFB2YmpT?=
 =?utf-8?B?dGJmRG1keWkzdldmeVVTcjBzYm14TVZLTTl4NjRTS0FZRHNqbWNkVXg5bXBL?=
 =?utf-8?B?UExucmdVTVhoWWQxcXdjbjk1clBhZlV5bWtGUUxKbWtVamNlUXExUkIwdVJL?=
 =?utf-8?B?ektVKytJaTgxbjA2ckJuQ0M3VTI3NXVRV2NNWTVXK3U5aWZ6WjJ4R0RXa1Rk?=
 =?utf-8?B?bFRIMHFvczkrS2p1NG1JL3lFYUZnL2hCekpLMWNPRUlhSkZ4RHR2cmVHNWc2?=
 =?utf-8?B?VnFCNjVhd3FObVZjcU1VS2hBQUY2cGkyVUxIU3BESElIZ0ZJNHUyUWpUTkov?=
 =?utf-8?B?d3NxcmhkN2FMQXJPc3ZDQnNHUzUwV0RQVjVLYVRFTGhiVi84aHVmd3ZiSDYx?=
 =?utf-8?B?RitGTVJtRjdaVEdEVVdUczdFWitkQWJuK3FsVDhIREpmRXRNdGlEMk1xcC9p?=
 =?utf-8?B?NFhYMlVJb1BINlFHNHlQSlNkOWlwSFRoKytoMCt2TnRwcHJ3d0p5N0JCcGI5?=
 =?utf-8?B?eVFkZnF5ZENGUmlOcHgySy9iOWRjbjMreGUvb2Z1NU5ZNFBubkVXQVlTenlw?=
 =?utf-8?B?ZFkySHFXdjl5bFE2OHRWa1ZVbEVCZStXTGtpMVVOdE1yTlFTbDBnMzZZdTk1?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faad05b-4299-4d96-6db6-08dd4f6f9076
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 16:24:34.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qsje2GydMZXhH58TvyYdbclV2ubt2HNJQ57lRQVlovopg+55iIOdY+uDf5CREyzLDoXxH49Oz42fyBJf0ybhBUsvjRNcMz2T8BiARa+/LRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813

Hi all,

On 2/16/25 1:32 PM, Alexey Charkov wrote:
> Hi Heiko,
> 
> On Sat, Feb 15, 2025 at 11:30 PM Heiko Stübner <heiko@sntech.de> wrote:
>>
>> Am Samstag, 15. Februar 2025, 19:59:44 MEZ schrieb Alexey Charkov:
>>> On Tue, Feb 11, 2025 at 7:32 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>> On 6/17/24 8:28 PM, Alexey Charkov wrote:
>>>>> RK3588j is the 'industrial' variant of RK3588, and it uses a different
>>>>> set of OPPs both in terms of allowed frequencies and in terms of
>>>>> applicable voltages at each frequency setpoint.
>>>>>
>>>>> Add the OPPs that apply to RK3588j (and apparently RK3588m too) to
>>>>> enable dynamic CPU frequency scaling.
>>>>>
>>>>> OPP values are derived from Rockchip downstream sources [1] by taking
>>>>> only those OPPs which have the highest frequency for a given voltage
>>>>> level and dropping the rest (if they are included, the kernel complains
>>>>> at boot time about them being inefficient)
>>>>>
>>>>> [1] https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>>>>>
>>>>
>>>> Funny stuff actually. Rockchip have their own downstream cpufreq driver
>>>> which autodetects at runtime the SoC variant and filter out OPPs based
>>>> on that info. And this patch is based on those values and filters.
>>>>
>>>> However, they also decided that maybe this isn't the best way to do it
>>>> and they decided to have an rk3588j.dtsi where they remove some of those
>>>> OPPs instead of just updating the mask/filter in their base dtsi
>>>> (rk3588s.dtsi downstream). See
>>>> https://github.com/rockchip-linux/kernel/blob/604cec4004abe5a96c734f2fab7b74809d2d742f/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>>>
>>> Funny stuff indeed! Judging by the comments in the file you
>>> referenced, those higher OPP values constitute an 'overdrive' mode,
>>> and apparently the chip shouldn't stay in those for prolonged periods
>>> of time. However, I couldn't locate any dts file inside Rockchip
>>> sources that would include this rk3588j.dtsi - so not sure if we
>>> should follow what it says too zealously.
>>>

That was a clear oversight on my side.

The commit adding support for the J/M OPPs in rk3588s.dtsi downstream 
just precedes the one adding the removal of the J OPPs in rk3588j.dtsi, 
so not sure what was the intended effect there. I'll open a ticket with 
them to see if I can get some answer until/unless Kever chimes in.

>>>> So...
>>>>
>>>>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/rockchip/rk3588j.dtsi | 108 ++++++++++++++++++++++++++++++
>>>>>    1 file changed, 108 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>>>>> index 0bbeee399a63..b7e69553857b 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
>>>>> @@ -5,3 +5,111 @@
>>>>>     */
>>>>>
>>>>>    #include "rk3588-extra.dtsi"
>>>>> +
>>>>> +/ {
>>>>> +     cluster0_opp_table: opp-table-cluster0 {
>>>>> +             compatible = "operating-points-v2";
>>>>> +             opp-shared;
>>>>> +
>>>>> +             opp-1416000000 {
>>>>> +                     opp-hz = /bits/ 64 <1416000000>;
>>>>> +                     opp-microvolt = <750000 750000 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +                     opp-suspend;
>>>>> +             };
>>>>> +             opp-1608000000 {
>>>>> +                     opp-hz = /bits/ 64 <1608000000>;
>>>>> +                     opp-microvolt = <887500 887500 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>> +             opp-1704000000 {
>>>>> +                     opp-hz = /bits/ 64 <1704000000>;
>>>>> +                     opp-microvolt = <937500 937500 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>
>>>> None of those are valid according to Rockchip, we should have
>>>
>>> Well, valid but more taxing on the hardware apparently.
>>>
>>>>                  opp-1296000000 {
>>>>                          opp-hz = /bits/ 64 <1296000000>;
>>>>                          opp-microvolt = <750000 750000 950000>;
>>>>                          clock-latency-ns = <40000>;
>>>>                          opp-suspend;
>>>>                  };
>>>>
>>>> instead?
>>>
>>> I dropped this one because it uses a lower frequency but same voltage
>>> as the 1.416 GHz one, thus being 'inefficient' as the thermal
>>> subsystem says in the logs. It can be added back if we decide to
>>> remove opp-1416000000.

That was exactly my point, the 1.296GHz OPP would then be the highest 
frequency at that voltage.

>>>
>>>> and...
>>>>
>>>>> +     };
>>>>> +
>>>>> +     cluster1_opp_table: opp-table-cluster1 {
>>>>> +             compatible = "operating-points-v2";
>>>>> +             opp-shared;
>>>>> +
>>>>> +             opp-1416000000 {
>>>>> +                     opp-hz = /bits/ 64 <1416000000>;
>>>>> +                     opp-microvolt = <750000 750000 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>> +             opp-1608000000 {
>>>>> +                     opp-hz = /bits/ 64 <1608000000>;
>>>>> +                     opp-microvolt = <787500 787500 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>> +             opp-1800000000 {
>>>>> +                     opp-hz = /bits/ 64 <1800000000>;
>>>>> +                     opp-microvolt = <875000 875000 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>> +             opp-2016000000 {
>>>>> +                     opp-hz = /bits/ 64 <2016000000>;
>>>>> +                     opp-microvolt = <950000 950000 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>
>>>> opp-1800000000 and opp-2016000000 should be removed.
>>>>
>>>> and...
>>>>
>>>>> +     };
>>>>> +
>>>>> +     cluster2_opp_table: opp-table-cluster2 {
>>>>> +             compatible = "operating-points-v2";
>>>>> +             opp-shared;
>>>>> +
>>>>> +             opp-1416000000 {
>>>>> +                     opp-hz = /bits/ 64 <1416000000>;
>>>>> +                     opp-microvolt = <750000 750000 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>> +             opp-1608000000 {
>>>>> +                     opp-hz = /bits/ 64 <1608000000>;
>>>>> +                     opp-microvolt = <787500 787500 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>> +             opp-1800000000 {
>>>>> +                     opp-hz = /bits/ 64 <1800000000>;
>>>>> +                     opp-microvolt = <875000 875000 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>> +             opp-2016000000 {
>>>>> +                     opp-hz = /bits/ 64 <2016000000>;
>>>>> +                     opp-microvolt = <950000 950000 950000>;
>>>>> +                     clock-latency-ns = <40000>;
>>>>> +             };
>>>>
>>>> opp-1800000000 and opp-2016000000 should be removed as well.
>>>>
>>>> Did I misunderstand what Rockchip did here? Adding Kever in Cc at least
>>>> for awareness on Rockchip side :)
>>>>
>>>> I guess another option could be to mark those above as
>>>>
>>>> turbo-mode;
>>>>
>>>> though no clue what this would entail. From a glance at cpufreq, it
>>>> seems that for Rockchip since we use the default cpufreq-dt, it would
>>>> mark those as unusable, so essentially a no-op, so better remove them
>>>> entirely?
>>>
>>> I believe the opp core just marks 'turbo-mode' opps as
>>> CPUFREQ_BOOST_FREQ, and cpufreq-dt only passes that flag along to the
>>> cpufreq core. But then to actually use those boost frequencies I would
>>> guess the governor needs to somehow know the power/thermal constraints
>>> of the chip?.. Don't know where that is defined.
>>
>> personally I don't believe in "boost" frequencies - except when they are
>> declared officially.
>>
>> Rockchip for the longest time maintains that running the chip outside
>> the declared power/rate envelope can reduce its overall lifetime.
>>
>> So for Rockchip in mainline a "it runs stable for me" has never been a
>> suitable reasoning ;-) .
> 
> My key concern here was perhaps that we are looking at a file inside
> the Rockchip source tree which looks relevant by the name of it, but
> doesn't actually get included anywhere for any of the boards. This may
> or may not constitute an endorsement by Rockchip of any OPPs listed
> there :-D
> 

Will ask for confirmation through their ticket system.

> I haven't seen a TRM for the J variant, nor do I have a board with
> RK3588J to run tests, so it would be great if Kever could chime in
> with how these OPPs are different from the others (or not).
> 

I do have access to some J variant product but that won't help if you 
need to run the boards for months/years at the highest freq in a 
temperature-controlled chamber at the highest supported temperature for 
the SoC. I don't think there's a TRM for the J variant, that wouldn't 
make sense as it's the exact same SoC, just a different binning. 
Similarly to what was done for RK3588S, RK3588S2, RK3582, RK3583, etc.. 
I don't think there's a TRM for those, but there's a datasheet, c.f. 
https://www.lcsc.com/datasheet/lcsc_datasheet_2403201054_Rockchip-RK3588J_C22364189.pdf 
but that says 1.6GHz for the A76 cores and 1.3GHz for the A55 while the 
the j-m OPP in rk3558s.dtsi downstream list the highest as 1.7GHz (but 
rk3588j.dtsi removes it).

Will report if Rockchip has answered on their ticket system.

Cheers,
Quentin

