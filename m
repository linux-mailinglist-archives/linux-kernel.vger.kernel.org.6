Return-Path: <linux-kernel+bounces-320523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFEA970B8A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8F31C218B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4521B12E48;
	Mon,  9 Sep 2024 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="k6ctwJxJ"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E033FE;
	Mon,  9 Sep 2024 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846960; cv=fail; b=HmgkR4VJRkWELSNDgiIelfyqt+PajBeT2epkrNqxGNuN96ih3iRtizbqlg3flOGyy+eyjGn9El7C1ld1JTs+v5IqZQ2yoa219vakFAvuRwyukCOebG8Z4CfVz4lZ96rAuR5up1z9vJWXArtxpPSp/Sa90I870F7lopE5Cf/jep4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846960; c=relaxed/simple;
	bh=uqmknrV/Vel9qTiWod5zdOj/0dQ5xgW5ZeEQ/o7vdsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IKEmn2ExX6qDA+kNZoZhO/FCpoARnEU4Yf6vp2wg3mr+QUJA6dXC0R+7ZuYi1ik3prkcY7viScXIGQLvs6VZl04LdUzHdrr/YAW+Rfm+VSB4VaRANVCcekr/iEyTPxlptgRQJNRdBnVpVtGA46JKMa/MIESkix1tDQAoP04jQCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=k6ctwJxJ; arc=fail smtp.client-ip=40.107.215.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSAIijJLKV/usqQvU+L10I6owAnhQU07h/L88AYY6JfMlrasVwiJLQIOMRZv9MgX0VNu7yWyGCT1rk+IjgIV36q0DF3i7tDjKNq/pc397OTGg+EQBk20NPHTa11wxwudGgrKiCHx8rDusuVu8qwv/EWT+95N2K0Rc2lOpQtcgoWyV+MSBO0w0dOPBVcYhfzwBl7MsRXaJo7oSLwWx+qdYmnZ/j9spqhAYAj1fXG/3ZhK5RlPEDi/rA6DV7VVXvx2GLw8Ugrq70C+h2T7chNTUL3r3q5HbYPsS0zdI3XE+xZQroNwqYKiFD+wabI6XvxCDM33peoxdssPNXrH2ksvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9Fvmt6G81UPVu7/HqIeOcJNoiNHvFP82vDGXMS7xO8=;
 b=DUA+dje4sVq+4IxLoKfG5nmdfhX2tm2C35K/SPvLku2OtjKPWglWRMyx+eh327tMZ8gPMpvSVt+lLiir4wW/rKKvt9hZx518FJ/n3DFau31L0YH2SE/VI53lSLGkwVM+K9rRlshNo2f26lSMlQ3IfkzTBluFymSuDjzGdMX7wdI+AD4Hdr2s9/HIeHp9CENUkCpJe6JCwQ7nK9HFs37+XAZggT5fLJQGEWMgaNEbMT4bLS7cl92inx7YN7ks/0ZOzVwostH30+Idwj88WUZ7BSteiCG52hDVV7y9FWaGRQm+71GFL6jgOxR1Gu3kYwrXIHqf0U+oKHtI9ATvECw5ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9Fvmt6G81UPVu7/HqIeOcJNoiNHvFP82vDGXMS7xO8=;
 b=k6ctwJxJLMIMc6nLwCISG/v6UfJ/jluCTC5FVmiyBd1OTSC9QLB4b50d6NtVJ4tovILBvIS49jEMOcTV+hPHc0T7R0mvhpplYCs0gzSXYa0QHAUGsu0QG2FTL9OVL0/L2UCSvopIl7nf1jdFXrtuscrzD8XmeelrbzYN6JQFzvVasiJHfcYG67r8Rn9gbFRXHYkhowopVTZ4Y2S4VB9OGAtKXZIpwPs9PGFImfjk3U1FWw3W6mSACdIqHZLylBnQtos1/ppxTn0N5InQYTqU4yErhG7WVkG3FcZXazK7WXRtUnmDSO/jA/dvWqYX9oc3CyBaPi78wd0/JzgAsjRF8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com (2603:1096:820:6d::13)
 by TYSPR03MB8717.apcprd03.prod.outlook.com (2603:1096:405:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Mon, 9 Sep
 2024 01:55:53 +0000
Received: from KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca]) by KL1PR03MB5778.apcprd03.prod.outlook.com
 ([fe80::9d11:d1f6:1097:22ca%7]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 01:55:52 +0000
Message-ID: <46c55bd0-0076-4eaa-8b12-0e28f650e5bd@amlogic.com>
Date: Mon, 9 Sep 2024 09:55:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] clk: meson: Support PLL with fixed fractional
 denominators
To: Jerome Brunet <jbrunet@baylibre.com>,
 Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240906-fix_clk-v2-0-7a3941eb2cdf@amlogic.com>
 <20240906-fix_clk-v2-1-7a3941eb2cdf@amlogic.com>
 <1jjzfpqb5a.fsf@starbuckisacylon.baylibre.com>
From: Chuan Liu <chuan.liu@amlogic.com>
In-Reply-To: <1jjzfpqb5a.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To KL1PR03MB5778.apcprd03.prod.outlook.com
 (2603:1096:820:6d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB5778:EE_|TYSPR03MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: c780833b-7f13-43d9-2fed-08dcd072893b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b29KeXh0TjNhdGhpc2trVk9uM1ZUR2h0UE02TnlFSDNUQ2tjV3ZLWHN3VjBp?=
 =?utf-8?B?TGllRnNxcFdOM3ZaalN0RFFieEJlbm82eGx0VFZnOU5tZkpIaUxaR25Ndyt3?=
 =?utf-8?B?OHhRcW1zdjdidkY4djBsZ21lMWd3alFjN1FyUHRNS2V0MnZGWTNxczVMNWMx?=
 =?utf-8?B?UjNobFVCVTBCNk5ZNmpGY2kzZElkYlEyRDc4MTlLTUdYZnorOThFL01HczZ6?=
 =?utf-8?B?OUp0bWpOcWVxcGxReXBqTlZOQWZrM0ZBdVptRUhzanhSbkdkcU03SWdweVly?=
 =?utf-8?B?MlZJdXBSTU13SWFTM25OdUluUE5BQlM4cHE5L2RmaU9XUlJlL2Y0aC9YZzcz?=
 =?utf-8?B?UEJyRnpqMHBmcDhXdExPZzlWZ3BhMmRZQUV2eXhteURUcW14aFlmL1UrVWJZ?=
 =?utf-8?B?ODFmd3U1Tnpxbjh5RVBmZ3hXS1lVaGNSckswSjlIUmx6NDhEWjhwYkVpSkhV?=
 =?utf-8?B?cVpIczNoWklmT0Vqa2VkRk1iWjdVK1U3c25JUXQrTFA1OUVwOEUxb050VlRW?=
 =?utf-8?B?OU5uSnQ5QmZVbzBHbWJQQlMzTEJ2Q0dldU1WcUg5K1dVV0NzUkZPb0FjdVlU?=
 =?utf-8?B?SFlNNml1Yk1pVVFJMnc1RG1IYnA4TUdJeWdhellQNWd3R0NhQVlJRDRCbWNq?=
 =?utf-8?B?MlUwa3pFSXpnS2YzQ0VORFVzdWgzVVZob3RxV0F6b2tSc1plRnk0NVJVY3E5?=
 =?utf-8?B?aHVVMEFNSmhkZEdiR2ZOQnJuaEZFa3N2OE5iWjRGZlg5OXcvRC83MGZZZHJG?=
 =?utf-8?B?ak12ak1hTEF4aStXQk92MVlSVjFtOE5xTE9BZFI3MEdleVpBcC9BOXFvUFB5?=
 =?utf-8?B?cVV1bG5PVUgvL3VVU2FVenFUOGt0WGNDS2dvQ2g4bk8zV0drL1ErbnFpemtM?=
 =?utf-8?B?SjMzODF3UzJsdXdiZlRIOEpuSERGTzNpNnNiVEMwdnRnNnRaNWRtYTFXbUZv?=
 =?utf-8?B?L3hEY0NKbDJuNndpZGtza3h4K3p2UFlTWDY2MmdQcXZwMHB1RE9XUU5PTmFQ?=
 =?utf-8?B?N2JlOHpBMWN6MDhPeGhpekhNaXhNcEpXanRWSUw4QnRoSjNlZTQ2MHNRTmZ2?=
 =?utf-8?B?K0h1ck1RWWF0VGp0cVIyUDNsTzA4SzNZODJjZW9JeEt3UjJFeVB6VHgvdktR?=
 =?utf-8?B?SkM1UmUwN3N3aG5nTWtLYWg2TkhWU213aVBjSS9kYXhMNTIwVEZURnZzcHQ4?=
 =?utf-8?B?U1VZSkR1emNYbkRvSzhVcmltZWluQmhBUWh6VTNxcWVCcVcrWmd1QmxncUtR?=
 =?utf-8?B?c0VSM2RwUldWMmI2Wm5ONEdEQjFuM0lLSXl0YzQ2ZmI2TE1YSU92MllZbmUy?=
 =?utf-8?B?L0hkczkzU21rVEJSVUFvVUJYMjdud2d0MVlzSlQ1QTZ4MVJyOGNVZUhBWlRI?=
 =?utf-8?B?VmhTSGJ5VHN3UFZrOGVkMzhXUWFvLzBLKzhuY2l6VGw2YTNwTHMzaVNIeGFP?=
 =?utf-8?B?NHJ0TkUzRTZuV3hQWm5WNmYxbGFPd2tLKzdIMGNzTFNwTUk4dTJYemt4Vmcv?=
 =?utf-8?B?cUZuWjZROWl3Z0VNMEsvT2Npd2NHa090TElsMGQwS1BHM3VzMTd0aTJiV0c1?=
 =?utf-8?B?Y09VSmR6WDNJNDNGd25lRzZzdDRScVovakVvbjZpc1QxNVFJYkNtZUFIMTRB?=
 =?utf-8?B?UGtUcmd3MUkxb3JMWmordThSY2pOMTMwSFRCcm92M2RUNHdXK0MyQTZDWGNZ?=
 =?utf-8?B?N1QyWU5KMkRUbkhEWkNpQlM1bng0Q0RoS1U0UUZ3dTdqZlVnNi8yZGI3N1Rx?=
 =?utf-8?B?WkRTM1hRUnF3akhLZEw0L2ZPc2cxZ1B0Yncrc09KdGpadEhCN2lPaWMxNFNz?=
 =?utf-8?B?YnZwcEticytDd3pxS0pmQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5778.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzRTb25PNXNnVDMrTE00OGFCOTJDV1A2UmlwQUliTzUyVzN3V1gvZmNFbXl3?=
 =?utf-8?B?OWt4eCtGaE1EUTZ5dmNlZUNGRFp2TG5FMjc4WUM0dDYwTUQyZ2tLS1JzMURh?=
 =?utf-8?B?a0IvQTRRMVpqTmZVQ3IrM01FbDlEMnNvQldKczI3U24zSlp5MGFBM1VKRDh2?=
 =?utf-8?B?dkx0ZEtNaHg3eWdDcVBkQzA4VzFXOExBU2hwcVZmRDVndU56eEJLcE5KRnho?=
 =?utf-8?B?d09PUzQ5OWE3alMydUJHOEQyamE2Q2ZjM0tlS0lMRFFJRldPQTAwd2dWYW9M?=
 =?utf-8?B?SGJZYmRWRlZERUV2dzBiMEdLVjBZNE1YTWtJRDNEVkkwRmozZE5vM01DbHZJ?=
 =?utf-8?B?ZHZVV0VIV0NlS2NnVXNkQkw4NjhaL1cyZlA2eU1KU3Y5azV1bklObGZzQ2hu?=
 =?utf-8?B?ZnhuK2c1Z29YR09UVjRVTXZJZGpJTm1od2M1NUtFRTVlSVBqbzdmcEI4ZG9I?=
 =?utf-8?B?OGptRmNDZFhlRjZpRTNEVTIvVDk2b29NS0pyYktFemxMbXBYNXFlNDdOVnEr?=
 =?utf-8?B?bGt3SEE5ajNjcjg2VUdWR2xBRm5wQnNZQlVLQy9hZTJJUEY5QkVIV1EyRitq?=
 =?utf-8?B?Q1JYeFFUZXI1bXFZcnM2RzUwNi9udWtud0FEMDdxTXpmK2NPUEVhTGVmSFM4?=
 =?utf-8?B?R1ZrV2xoSjVoMHJaSktaMmxURm1VYkQrV1dzNHhjaG5kTytQS1phSS8xaDE4?=
 =?utf-8?B?Mm1OR0REcWdRNVppemdhS2ZENGNNekFudStvS21Ca2dXNzRJZ1lNUWRxS3JG?=
 =?utf-8?B?WHpaaHBUVHpSenVla2pJUnFjbFZ4c2pORVJ4MUJML1FxcDR1cDFyY2YwaVcw?=
 =?utf-8?B?UWppc3g5OUs3ZFU5aHc3U0J6YzVEQzYxL29iakhSdkhDejRGYWNlWkRWNTBh?=
 =?utf-8?B?aGJ4cG10bzhGTlUwYjRjMGZkRVBnRnV2THg4SmNUblNZQjFtMGt3UVY4djFS?=
 =?utf-8?B?Vm4vTlJ6SzB1YlF2NVpML0g1NjNub3RNMlBSTzFzZHlrT3FZMi9IbzgrUS84?=
 =?utf-8?B?MU9WdXFVZnMyV0xZa1QyWm9maXRnVmgxRWhJemxVdThuTWhBYnM4Yk9lME0w?=
 =?utf-8?B?aFpJWjFNeEhrR2Y4RmRFNmkzRm1JYmhNSmFUM0JtcE1tekxhUzczU0dtcWRz?=
 =?utf-8?B?Y1l5dzlvQzhyTk5wMlFSSFplc0NqMEFEZytIOXRwUWx6ZFZ1REVpRHJVM2tX?=
 =?utf-8?B?YWhuTUliRTFXWDJVTllmS01rd2laenFzWTNMVHNXWHZxcmhETWlIK2l5ekVY?=
 =?utf-8?B?bm1EK2djd3F1bGc1VzB3VEF3VkxTcEJiRHRlRXZPOGtyZ3dCTlFUZXBaczZl?=
 =?utf-8?B?MCtJLzRFZjc0VG1OWVRZekwrWHgxY0lORE1Ob1BMNTgzMWZiVU5FWmc2SmF1?=
 =?utf-8?B?RTR1TTlPUnlxZGFBRlZLSGVSQzg2Q3hoNXFDY3FnN2gxcjZsQTBsOHdFNnFx?=
 =?utf-8?B?aDlGbS9aN0V0NmxndkV6cjh0Um90S0gxUU9Ha0tLRGpWN3pOTC9FK2s4UnQ0?=
 =?utf-8?B?YURCRHhvbjJZVnl4QmdaNWVPRDZhMnJ2UnN1R2twVy8rWnhiVnB4WGl2elhu?=
 =?utf-8?B?eXdsZkxraDNoQVljUWNTVDVoOWx5MHRKUXU0QkpOd3BHcDZXZ2pXdHBmKzMz?=
 =?utf-8?B?dlNHazQ4MkNSbUNWL2UxVzllc1F6bFpVK3lvRW1vMFNlaFdGa3dRa29rTzNS?=
 =?utf-8?B?NTFRd2lmakxFQkhnZWpQcXJXNUNXVFBaQnFxSW9MMVFVeG9sVnFzWks2OGEz?=
 =?utf-8?B?WHJPV1hxR0VIS2xCb1I5RGNnN1pma2ZpM3ZrdFpRMVo0SEJMR0RkSXFHRSth?=
 =?utf-8?B?akFRcThpZldQZFpScWFqZDFzeEprVGR0SDVMOUpKczVHSVl0ZnpmNW54dmRa?=
 =?utf-8?B?bUNIY1NNK25USVd0RUFZdXo0bndCcGJzcU9DUFZkY29ZSFdRYVl6Wll2Q3dv?=
 =?utf-8?B?Vkp6QlFUL0cvZm1DOEZXbkhTMGkydGhONEpJU2l6dzV4TWZvcXNnVUxXYXZt?=
 =?utf-8?B?ZjVHdDdybGxRa1c4SGZtRUZEbC9ZUGdqTHRaTWg5dFUxRW9hNmZ4OEpXdnNX?=
 =?utf-8?B?Mk11M0VRZ2ZSOFFsQ2dsckhUc2VSaUJxTEdzRHR5WjBYOEg0SFlKclZ5cURG?=
 =?utf-8?Q?nurUdkgMTzye5TIdbmFwP3hsq?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c780833b-7f13-43d9-2fed-08dcd072893b
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5778.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 01:55:52.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6FrSx1S92gDyISSPDE1wJh/5MicAD+D0/lE3dn8GPyvskUIWZTdxZHbtuVdIXWRml5pTCvZ/UPGOq0SPDHATA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8717


Hi, Jerome, Thank you for your quick reply! I didn't get back to you
because of the weekend.


On 2024/9/6 19:22, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
>
> On Fri 06 Sep 2024 at 18:34, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:
>
>> From: Chuan Liu <chuan.liu@amlogic.com>
>>
>> Some PLLS with fractional multipliers have fractional denominators with
>> fixed values, instead of the previous "(1 << pll-> frc.width)".
>>
>> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
>> ---
>>   drivers/clk/meson/clk-pll.c | 8 +++++---
>>   drivers/clk/meson/clk-pll.h | 1 +
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
>> index bc570a2ff3a3..a141ab450009 100644
>> --- a/drivers/clk/meson/clk-pll.c
>> +++ b/drivers/clk/meson/clk-pll.c
>> @@ -57,12 +57,13 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
>>                                          struct meson_clk_pll_data *pll)
>>   {
>>        u64 rate = (u64)parent_rate * m;
>> +     unsigned int frac_max = unlikely(pll->frac_max) ? pll->frac_max
>> :
>                                   ^ Please don't play with this unless
>                                   you've got justification a for it.


Sorry, I don't quite understand this one. Is it because you suggest keeping

"(1 << pll->frac_max)" here, followed by "if" to determine whether to assign

"pll->frac_max"?


"unlikely" is used here. My idea is that it will be possible to 
determine the value

of "frac_max" at compile time, which will result in one less "if" 
judgment and

slightly improve drive performance.


>
> By justification, I mean actual numbers showing the difference it makes
> and not just for the platforms listed in this series, but all the
> platforms supported by this driver.


You're right, In this way, even if the latter value changes, our driver 
will be

compatible.


>> +                                                       (1 << pll->frac.width);
>>
>>        if (frac && MESON_PARM_APPLICABLE(&pll->frac)) {
>>                u64 frac_rate = (u64)parent_rate * frac;
>>
>> -             rate += DIV_ROUND_UP_ULL(frac_rate,
>> -                                      (1 << pll->frac.width));
>> +             rate += DIV_ROUND_UP_ULL(frac_rate, frac_max);
>>        }
>>
>>        return DIV_ROUND_UP_ULL(rate, n);
>> @@ -100,7 +101,8 @@ static unsigned int __pll_params_with_frac(unsigned long rate,
>>                                           unsigned int n,
>>                                           struct meson_clk_pll_data *pll)
>>   {
>> -     unsigned int frac_max = (1 << pll->frac.width);
>> +     unsigned int frac_max = unlikely(pll->frac_max) ? pll->frac_max :
>> +                                                       (1 << pll->frac.width);
>>        u64 val = (u64)rate * n;
>>
>>        /* Bail out if we are already over the requested rate */
>> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
>> index 7b6b87274073..949157fb7bf5 100644
>> --- a/drivers/clk/meson/clk-pll.h
>> +++ b/drivers/clk/meson/clk-pll.h
>> @@ -43,6 +43,7 @@ struct meson_clk_pll_data {
>>        unsigned int init_count;
>>        const struct pll_params_table *table;
>>        const struct pll_mult_range *range;
>> +     unsigned int frac_max;
>>        u8 flags;
>>   };
> --
> Jerome

