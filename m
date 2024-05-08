Return-Path: <linux-kernel+bounces-173087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 793E78BFB4E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4B81F24A9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D198172A;
	Wed,  8 May 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="SpmzvdF0"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2098.outbound.protection.outlook.com [40.107.13.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821637D41C;
	Wed,  8 May 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165425; cv=fail; b=MyVc8WHQN12Sl2komh7iG598QfdRRsDjEYwkzizwHEboKnNt8CNjUYr9w4trF9FmJZRIl2fSZBMCV3F1xb4Z5hPAUL9fSxFSb1+YF3Rp04UFI2FjIkYuVW2Kx2N1ur8scPSltjyKf7VWG24rZrRZsPdOHMCD5Gp9WrHZbDWsV7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165425; c=relaxed/simple;
	bh=uzxmiur6EMoryo0kTyDmf2JqJmbGbI7oFhBZbtPv/j4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CVnV319jArsNIbjd9mp58uhpEimNWw+kzUZtocYADl3wGUvu7NgNZ5tDlWO5K0OO0VjzuxxQqQ6UNbYoOBUcUp4beQ0vbFToF6NYGhb9Q4XiL+35w4dS5yeEnPmaSc/cBFqVJXL9YTHec1LSj58PhRzeEZfXSP9pHTp6lWv3cAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=SpmzvdF0; arc=fail smtp.client-ip=40.107.13.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYq7zhGzwkTj7c9QptM4ay85gRy+HjaOcLDkMdqKMdbfQyzzZ3S6oVwCettKhCQYVK5w5+k8WvJ92UmSos3Oz+ZDkzhS5AUUf38CoAPhgTR3rPQFTeq2V2gTIC8zjtGuDBoK4xojGkUAEnWj7ae8zZUaFL5RgWkZNwjhQc5fPocqH+bHrQOs/IsJFQWzPhXl7S0WKnHcad52qg2YlwF1Tg4z6ZBLmm0+COyAASzPKK/nEbjOTjznu5XAOWGv6cMiwDDw5KXDKVl9uPcsXLlkaMisdDRjVcnUN6hwUPMFXUwZ6WZtj6H/bRQhAKDxt8sD+j+UgR66M5nbRFDKWuFYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R19VF7r+8FFWd+++OJnrCUB6dSuHsa+2AnsZT7m/Ksw=;
 b=SqaRHGN5dlH4mp96ZeRxIvbjTNHcCJQrNmDnBDeYUydn3ad/UlHo8aO0KlNf8kfs24vfZ7wnt8fqaa5dBwJn2ctjuZKxE2kQwaez3G4Bkq7KxVICLKw+2uBry0LqHMV41lqS58SV2WzWk+rHMgBFlRWxyoO/ZjJ8SOuPKdu0gAqgkCC4oJdYRjUDQABBcdp2s9oS880CY+YPLLLWK/GHbfIG25ugX3HxNT+HkhpX66fxflHXxl1IDv6YoFSF/SU3V9NV4zzpdjA7TDC1qdMqrOQtWpOCLFs44125nhXJVQjd9Avh0KZ+pavzM5jmLyIDFcIb2eU0Upvfq63WaPt/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R19VF7r+8FFWd+++OJnrCUB6dSuHsa+2AnsZT7m/Ksw=;
 b=SpmzvdF0BnP614+vt37M+2MaSRWu4u7x7Ng1xnrCPY6LNyJxSd3YzQvYXsfiORdTav9jQ+IGFr/fKmT8/GHAaM2NP+mJVj8xpzKcsZrQ4WEDsv5fLV1VnUpUQoLjMdqWfl3Bw0rRZ6POZTfTIyIXLexyH81s+/OxIKfuyFE7p+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by VI0PR04MB10369.eurprd04.prod.outlook.com (2603:10a6:800:235::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 10:50:15 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 10:50:15 +0000
Message-ID: <a729c591-694f-4bed-bf09-b4430381766f@cherry.de>
Date: Wed, 8 May 2024 12:50:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: rockchip: Add OPP data for CPU cores
 on RK3588
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Dragan Simic
 <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kever Yang <kever.yang@rock-chips.com>
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
 <20240506-rk-dts-additions-v4-6-271023ddfd40@gmail.com>
 <e220061e-0bb5-4fa4-9a91-aefd81e6636c@cherry.de>
 <CABjd4YweBc_0d=ej-=0o6FPdHxh-i3FSbSp5bDs9cZcmosEMeA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CABjd4YweBc_0d=ej-=0o6FPdHxh-i3FSbSp5bDs9cZcmosEMeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::22) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|VI0PR04MB10369:EE_
X-MS-Office365-Filtering-Correlation-Id: e72a4920-bbc7-4d69-058c-08dc6f4ca4ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWhnTGtJaGk2eCt1MmF6OHRsWXozcXVibTRkVTFpcGs0eW1XZmx2a0pyNUhW?=
 =?utf-8?B?NzlGU0U1b1JZQ0lxdTlPeU9FK1Q4WDdRbU1wMmpPdDcvQ1ZhLzdDaTdvbktD?=
 =?utf-8?B?SWdzaFdhbEl5VkZsZzI4d0RFVVdwNGNVNHlmMzJVNzlGdW5kSk45ZFZEajdL?=
 =?utf-8?B?K2ZBLzE1elJPUWdpS3o2eHowQ1Jra1Z1YVA3elFNeW5JSHFLMHEyZHFaM0Vs?=
 =?utf-8?B?TGZ4aXV6a0U1NU8zMUdHcGp0MEJYS0RWV3g4YmFwTUlpYVAyb2p0SzZDM3dE?=
 =?utf-8?B?UFIzQ2lYd1VQU1NlWGhJRTlLa21mUjlZSEZPTmR5c2srWHFVWWFIN0JJaEdL?=
 =?utf-8?B?UkV2OGFvMmFiMEI0L2MxSktudzdwNjRndFNrVUc5dE9UV2liSGtqVHZWSEI2?=
 =?utf-8?B?bGsveE5RZXc3cE9WemVTcnJtY1hQeCsyalpEdjByTUR1MnExQno4dUJob0VR?=
 =?utf-8?B?VktDS1VMNm9yK1lXZ2NlZUpUVmNPWmpKQlBwcWV2S0tycDJNZ251SjhjZFJD?=
 =?utf-8?B?bVZrYzA4cytiYS9oeWtjd0puNW1HQnU1QmZYNnFiV2JNUUNyNnR3bmx0Rjlh?=
 =?utf-8?B?ek9hekcxWXd3OHhmNVpuWXpkTlk3Y0ozVkFld2pLbm02RnpWdjRCd2cvRFM1?=
 =?utf-8?B?UlZzOFd3dWs3TklqbWNkNXREMTdwdndiZGVGbVJWYVhSZDFpTnBSMEl4aUQ4?=
 =?utf-8?B?VDFlRGZqS3lBc05xUzRRMEtUcEI4YVRlVEYzYkJUc3E3QjhiRE8ySEpJREdy?=
 =?utf-8?B?bktJdTRBTjJmMmYzT1NFcWJjYzJVNWxtNndGQ3RTbjRoaGtLcjVFaXFUV2tM?=
 =?utf-8?B?cE90bHU0d2lMdDZTUitraG9UYTNUVFpqdXlNdks2K0phZWxQczloaHkrQ0M5?=
 =?utf-8?B?aXUyTzRYaDRYSU0ySDlVTmV5aHBxTHVWdlFCM1RyeWVZWTV5dUtsL2xRTXkv?=
 =?utf-8?B?SHEvajg2YlVTdFExcnFWeGR4U0Z0SXRvNHkrTzlKemxlaU11UGNud2FOdFQr?=
 =?utf-8?B?VUgwUnRjeDYxTHUxWXhWWWJvVWtwMDFxUlV6ZldTZHFaMWNaMUx5MC9FYXNK?=
 =?utf-8?B?Q0N4Zlh1WUhkN3FBNkVOQ0w3T2JDS2MybW5FTFhyMlZNRHFxdU5hMVpkaHVV?=
 =?utf-8?B?QklvL3JRRWtRVmk5Vjk0Tk1EQlh1ZEgyR2xJL0xuYXEvSzhKdFR6UWJQemRq?=
 =?utf-8?B?Rmc5VU9rdGM5UFRaRkEyU20wSEFyQWordzNJU0dUMTdIWXpXZDFBbjBJNWR2?=
 =?utf-8?B?ZEI5QUZSUTd5SG1DQUI1b3kyM2tHODRKWlI0RWRxT21TY3BMQnA4UjlWV2NS?=
 =?utf-8?B?d2JtSGpFdUtKOFFpS0NIQ0FqMHVQQjNzenp2bUVDODUvUFlWOG5tUE5rd0Nw?=
 =?utf-8?B?dWFZUWF1NnZ3eUplL1FJZzlLTURhaGdSVnNud1grNnEzcXV5Sys1NklldCts?=
 =?utf-8?B?SEVmZ0wvQjdBTllJSVpiNlpTVm5hTHFDdWtaSGd0M21SYXJuUTEydzRPNXdD?=
 =?utf-8?B?dlBmb211K1ZmQlhVU0FtZ3NuSnZraExtZGFkZWx1L2hXR3c5Ymw3NWZEU3pt?=
 =?utf-8?B?TDlNSjJNVGIwVzErc1ZBUVNCdk1QbjZBWXhVTzFSUldFejdoTjczUWdnWnFt?=
 =?utf-8?Q?1BjKF7APC73ZxRzJkRw16pLR4E9gr7ETHp9ate4G+wZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnhoS1pqc1VEZGNtRjVoWWdUL010bTFMUTRmaW12Nmt0Q0xwaHh2VENyMFhT?=
 =?utf-8?B?dkVUWFRQYTNWTEhTaTNnQVIrSGxwd084by80c0NaWDNsakhYSTBXLzE4TlVP?=
 =?utf-8?B?UWlOSDhpQnlsTGI5L1A5cFdtUHFZcjIwalFIQ2lMQmtMditBUkFUZnptcFJT?=
 =?utf-8?B?aXJxa0pJbGdrRjNvWWF4akY5T3psdHN1QkhPR3BhdWsyT0lUTVRibmlUK0Zs?=
 =?utf-8?B?MkQrRURUSDVPVkxUSFdwcDY4S2JSWTZmMGpWRjlTaVJWdGNaajBMenRvcVc5?=
 =?utf-8?B?Skg2Y0lqamZuSlNhUU9tYzJyNjlWOHNyRmdscUxBRy9IMzJXNUl3dmY5UG1q?=
 =?utf-8?B?Q2Y2blh0L240bmttL1hHSVhJbC9xV0pVOFFYTVk3d25ZWkkzTy80aWFySFk4?=
 =?utf-8?B?aDlUT0JCbFg0WGhxTzhaS0tMeGJGQVNNSUhRK2FMWk1zNHNwUnlLMFFUQ2JY?=
 =?utf-8?B?OU1JRFpDZFI4cThLZ2hQWmgvdjc4SHRmTkJSVmJncnVPYUlTc2JpQVN0NzN3?=
 =?utf-8?B?c1NVNXg1QjFWeHhBNDdSbUJ3U0lyQ2cwTXBNU1M5UmpvSWJWd0pDQk9oVGlx?=
 =?utf-8?B?RXYwc3N6TUFlbXhhSmlYdVFvc29XUjA5a0RaMXliWmpKajdQN0JaY1ZMMzNN?=
 =?utf-8?B?QU0vS2lTRmZyMmRnQTd6eWsvSTBEUUM0U202dzVhbjBNQzJ1T1kyM253QTRz?=
 =?utf-8?B?TENONEMyU2NxVU50Yzl2MUdIT2lVeXJpbi9JempTWDdmYW9ZeWtqM2V0SUdG?=
 =?utf-8?B?c1FTMk1iR3ZxcUNrSjl4ZlU0dzZQcERtc2Eyb3Y1eHkvQUIySlA5eEJBUWxZ?=
 =?utf-8?B?dzVJMWhhUys0T2tuQyt4TmZaTUNpZ3dyVERrT2c3VVk1YlpRaU56SmJuWGFV?=
 =?utf-8?B?Z1VranVFM1g2dm9Uak85a2ZORkQ4RkI5ZWM1N25wL2FwdDl5REc5cnlwL1d1?=
 =?utf-8?B?REt3UGR5bHNEcmdXMDNiVXptYWVFdmxKSi9iOUwxb0NHOEZLMnRTWHAzTnVv?=
 =?utf-8?B?MlJxNWtnbXNKS3hJbmFGOXMvcGw4V3dhL0NpcXBXWVp5ZEF2T2hLenVYNGZ4?=
 =?utf-8?B?OHZuMXNqYlc0cDEyWDJESE5YVjdNMEhsclRQZzlKUGNVcklxMUdNTkJ1ajUz?=
 =?utf-8?B?TEZkT1lScnlUeGpkUm9DcUI1Y3lKd3Vkc0lCU2ozdnZ0eEh2TE5nd1ZNcVd0?=
 =?utf-8?B?eHk4ejl4OWFKeGZXNXJnZWMrZzB2enNYVGJiMVJ3bkNvNTZnaFdGV2QvMysy?=
 =?utf-8?B?RVBuNWdidUFZMVRPRGprMWtKKys3aVBkMkpMUXg0bW11Tlg5ZUdqSzc1d1Rq?=
 =?utf-8?B?eTFNUGhuMForN0Z6VXRkTk9LV0x6U2tUY1BvMXhCeXhYL1I3OFhFRjVXRHAr?=
 =?utf-8?B?ZklDZUdmY3JUNVlqd1lqdHVyb3ZpTEU3Vk0yellZYTMzVTM4QU5WMWpoN0V1?=
 =?utf-8?B?RkFObG9hUC9saFNDRFdXdWttUm16RFF2WlNwWkgxSTVhbmtrUnJSQTIxRVBL?=
 =?utf-8?B?NGhxWEM3SXExWkhpN1YyRFVjeUFDNXZIVGQyVVNIcjJvdlN5TUk5eUc4RVEv?=
 =?utf-8?B?T0s1YWNVZlpTUHF5bjh5QzBIVHVOKy8yNS9mM0VkRktjSFJNdUlIVHNMQmdS?=
 =?utf-8?B?OXdpcWpYVW9sNWF2a1VVRnJCM3l0cnVFV3pnbkE5WFZQQ0hidVl2N1NxL2lM?=
 =?utf-8?B?TFc3T3lzeEZJOU5SbTVVZXd0UTVvd0d0VWo3Q1k3emwxUFY2WXlrZFRWcHRJ?=
 =?utf-8?B?a3VEZi9kREJoRjdLeGp2S0x2VStWRTl5dmprYVJ5blJOV1BKWjVNcVcya1VR?=
 =?utf-8?B?bEg2RDNBUXNFdjl5ak9BaGRja0hlQXk0eTZmTzBHdTd4M2ZkVCtlT1Zaay9u?=
 =?utf-8?B?ZUc3bmxMTHQ5YjBwMFM5Nk5sVWJJb3VTY3RrREhHd3VrNklmVWR1Njl6VGx5?=
 =?utf-8?B?b1R3Szk5MG1rZWprQmgvRit3bVNPVlA0ZVAxdGFSYzBubkUybEdkZ29rd0kw?=
 =?utf-8?B?aHFUUHhRUlZIdkNlMUNQejRDYzdXbzN0Q3gwSEQ3QlBUMjdxYmlWUDBBVWtD?=
 =?utf-8?B?WFFkSWZZU1hpZDFzWDZiZnZkb0h4bkw2azZBTkI1aFp0N25ST00wU2FsaVg3?=
 =?utf-8?B?K0tkWHZ3L01LZnYxdEYzMTB5RDlscUQ5UjF0V0hGclN6NlN5Z294aWdKVS9t?=
 =?utf-8?Q?YEmrPBtkEzjjHO98jRjtWVw=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e72a4920-bbc7-4d69-058c-08dc6f4ca4ee
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 10:50:15.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lhhkv7cPWXAN4YGax3DfBbFYR3ZkEzMf9aA5S+9fMYEI1ZO+3a3uUZT1+SqsdfZD3F4rlRzd3UyoJfZahHV5Sz4ilaqT4b1WiHDmKxxIulU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10369

Hi Alexey,

On 5/8/24 11:43 AM, Alexey Charkov wrote:
> Hi Quentin,
> 
> On Wed, May 8, 2024 at 1:12 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Alexey,
>>
>> On 5/6/24 11:36 AM, Alexey Charkov wrote:
>>> By default the CPUs on RK3588 start up in a conservative performance
>>> mode. Add frequency and voltage mappings to the device tree to enable
>>> dynamic scaling via cpufreq.
>>>
>>> OPP values are adapted from Radxa's downstream kernel for Rock 5B [1],
>>> stripping them down to the minimum frequency and voltage combinations
>>> as expected by the generic upstream cpufreq-dt driver, and also dropping
>>> those OPPs that don't differ in voltage but only in frequency (keeping
>>> the top frequency OPP in each case).
>>>
>>> Note that this patch ignores voltage scaling for the CPU memory
>>> interface which the downstream kernel does through a custom cpufreq
>>> driver, and which is why the downstream version has two sets of voltage
>>> values for each OPP (the second one being meant for the memory
>>> interface supply regulator). This is done instead via regulator
>>> coupling between CPU and memory interface supplies on affected boards.
>>>
>>
>> I'm not sure this is everything we need though.
>>
>> For the LITTLE cores cluster, all OPPs up to 1.416GHz are using the same
>> opp-supported-hw, however the ones above, aren't.
> 
> Thanks a lot for pointing this out - could you please elaborate which
> downstream kernel you referred to?
> 

The one provided by Rockchip directly :) No intermediates.

I can give you the one we use on our products at the moment: 
https://git.embedded.cherry.de/tiger-linux.git/ (or jaguar-linux, 
doesn't matter).

The one that is (publicly) "maintained" by Rockchip is:
https://github.com/rockchip-linux/kernel/tree/develop-5.10

 From Cherry's git repo:
"""
$ rg -B1 --color never -N opp-supported-hw 
arch/arm64/boot/dts/rockchip/rk3588s.dtsi
		opp-408000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-600000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-816000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1008000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1200000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1416000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1608000000 {
			opp-supported-hw = <0xfb 0xffff>;
--
		opp-1704000000 {
			opp-supported-hw = <0x02 0xffff>;
--
		opp-1800000000 {
			opp-supported-hw = <0xf9 0xffff>;
--
		opp-408000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-600000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-816000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1008000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1200000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1416000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1608000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1800000000 {
			opp-supported-hw = <0xfb 0xffff>;
--
		opp-2016000000 {
			opp-supported-hw = <0xfb 0xffff>;
--
		opp-2208000000 {
			opp-supported-hw = <0xf9 0xffff>;
--
		opp-2256000000 {
			opp-supported-hw = <0xf9 0x13>;
--
		opp-2304000000 {
			opp-supported-hw = <0xf9 0x24>;
--
		opp-2352000000 {
			opp-supported-hw = <0xf9 0x48>;
--
		opp-2400000000 {
			opp-supported-hw = <0xf9 0x80>;
--
		opp-408000000 {
			opp-supported-hw = <0xff 0x0ffff>;
--
		opp-600000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-816000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1008000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1200000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1416000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1608000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-1800000000 {
			opp-supported-hw = <0xfb 0xffff>;
--
		opp-2016000000 {
			opp-supported-hw = <0xfb 0xffff>;
--
		opp-2208000000 {
			opp-supported-hw = <0xf9 0xffff>;
--
		opp-2256000000 {
			opp-supported-hw = <0xf9 0x13>;
--
		opp-2304000000 {
			opp-supported-hw = <0xf9 0x24>;
--
		opp-2352000000 {
			opp-supported-hw = <0xf9 0x48>;
--
		opp-2400000000 {
			opp-supported-hw = <0xf9 0x80>;
--
		opp-300000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-400000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-500000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-600000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-700000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-800000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-900000000 {
			opp-supported-hw = <0xfb 0xffff>;
--
		opp-1000000000 {
			opp-supported-hw = <0xfb 0xffff>;
--
		opp-300000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-400000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-500000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-600000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-700000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-800000000 {
			opp-supported-hw = <0xff 0xffff>;
--
		opp-900000000 {
			opp-supported-hw = <0xfb 0xffff>;
--
		opp-1000000000 {
			opp-supported-hw = <0xfb 0xffff>;
"""

In order: LITTLE, big0, big1, DMC (memory), GPU and then NPU OPP table.

Looking at the 6.1 development branch from Rockchip 
(https://github.com/JeffyCN/mirrors/blob/kernel-6.1). The LITTLE cluster 
OPPs seem to all be using the same opp-supported-hw entry now (but 
different from the one in 5.10). But, the big cluster OPPs in 6.1 are 
matching the one in 5.10 (that is, not the ones from Radxa).

>> 1.608GHz, 1.704GHz and 1.8GHz are all using different opp-supported-hw.
> 
> In Radxa's downstream kernel source that I looked at [1] the LITTLE
> core cluster has all OPPs listed with opp-supported-hw = <0xff
> 0xffff>;
> 
>> Similarly, for the big cores clusters, all OPPs up to 1.608GHz are using
>> the same opp-supported-hw, but not the ones above.
>>
>> 1.8GHz and 2.016GHz, 2.208GHz, 2.256GHz, 2.304GHz, 2.352GHz and 2.4GHz
>> all have a different opp-supported-hw.
> 
> Hmm, only 2.256GHz, 2.304GHz and 2.352GHz in the sources I'm looking
> at have a different opp-supported-hw = <0xff 0x0>; (but note that I
> dropped them all from my patch here)
> 

Seems to be a change made by Radxa folks: 
https://github.com/radxa/kernel/commit/cf277d5eb46ef55517afffa10d48dd71bdd00c61 
(yay to no commit log \o/)

>> The values in that array are coming from cpu leakage (different for
>> LITTLE, big0 and big1 clusters) and "specification serial number"
>> (whatever that means), those are coming from the SoC OTP. In the
>> downstream kernel from Rockchip, the former value is called "SoC
>> Version" and the latter "Speed Grade".
> 
>  From what I understood by studying Radxa's downstream kernel sources
> and TF-A sources [2], the "leakage" in NVMEM cells drives the
> selection of power-optimized voltage levels (opp-microvolt-L1 through
> opp-microvolt-L7) for each OPP depending on a OTP-programmed silicon
> quality metric, whereas in my patch I only kept the most conservative
> voltage values for each OPP (i.e. highest-voltage default ones) and
> not the power-optimized ones.
> 
> So the proposed patch should (supposedly?) work on any silicon, only
> the heat death of the universe becomes marginally closer :)
> 

An OPP from the DT is selected if _opp_is_supported returns true. This 
is based on supported_hw member of the opp_table, which we set through 
dev_pm_opp_set_supported_hw. This is called by 
drivers/cpufreq/rockchip-cpufreq.c with two values: SoC Version and 
Speed Grade. The SoC version is a bitmap set by rk3588_get_soc_info by 
reading specification_serial_number region in the OTP and reading the 
first byte. If it is anything but 0xd (RK3588M) or 0xa (RK3588J), it is 
BIT(0).

To know if the opp is supported, you extract the first value of the 
array and mask it with the value gotten from rk3588_get_soc_info (the 
bitfield). This means that for RK3588 (and not the M or J variant), the 
first value of the OPP opp-supported-hw is a match if it is an odd 
number, so only opp-1704000000 in LITTLE cluster is excluded (on that 
sole match).

The second value in opp-supported-hw seems to be derived somehow from 
the cpu_leakage OTP. This is likely the same rabbit hole you dug two 
months ago, so I'll trust your findings there to avoid getting my hands 
dirty :)

In summary, false alarm (but still surprising changes made by Radxa 
here, not that they matter if they only run their kernel on "pure" 
RK3588). Sorry for the noise, and thanks for the explanations :)

I'm surprised that we removed the lowest frequencies at the same 
voltage, are they not even allowing us to save a teeny tiny bit of power 
consumption? (I'm asking because I'm pretty sure we'll eventually get 
customers complaining the CPU freq doesn't go in super low frequency "so 
this must be a way to consume less power in idle!").

Cheers,
Quentin

