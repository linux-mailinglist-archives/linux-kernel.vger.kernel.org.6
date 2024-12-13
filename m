Return-Path: <linux-kernel+bounces-444405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE99F0642
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09F5281F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5DD1A8F85;
	Fri, 13 Dec 2024 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="9np4BeUz"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021098.outbound.protection.outlook.com [40.93.194.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9971A8F7A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078183; cv=fail; b=hG5tjvMBugwOO8eDR5G1dV56Ufa2nhbWPkyxTfTyu9ncTQ8UWWOEDCuxhY7TkL6+ql8QdwxXz9CmRX3Ngi0+vx5ziavS4s6TOaYy2lQHTb/k8QmTGzwPl+Ks1KJfuw5GD3W4vDl2r8mplrwtq9Akkvx/h5AbMIqRR87VkC7WoAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078183; c=relaxed/simple;
	bh=jVB7BBm1JwPOlaGDNdfvhm2udCLMRA/B5P+wMd6kN8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nv/lbLNWBiDvB7KnNj55SJ/GWgHM1QBYt1PyOimi17VG9q36gJx4YoVwFA5ajwnxxKpr9CyzLBIQ60byei6HTxCWd0sFsQEm6laHQZSsQoA7eyobJ7btW3egLyN14Wlk/6PccEKIwwp0fgQKkOLB6QCWfn46bxbpwwZCzZBlndE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=9np4BeUz reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.194.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOca3YC82yRSlcEYjiYmB93JOgWwscyF+2wxEejTmVKTJkZV7L4H1MBIYXt473nnhyRtg+sXy9oOQmuKPb/GvGKIMF8uAIp3kLLVkfHb9DwqX9vVtZJALMYIu74XwDMZL9GS49FRMDKaT6zlpzJpgG0E6r/+T6ALIMaJ77baG4ZuRRM4zNq7hSc4+H4LaJ0Mv9JtZxg0xVHMZB5QmSNcdRLCM9Nap1Lf6Mcc4dYt2Ayv8j5gRadlz3bMUMVG3oRJr5/k1isAzGn1IcCO+oYA5kTbIOyLUavflVsYdg193D05hwICfmRjreSNqkhLHjlFT1zCdjFUYJ7LVsuMNPIiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T6bodP8/CBWS0sajpqi4l3EFEc4xYhHDYaU25KJMSY=;
 b=i129AfJBut6957iIDXVNO/uPc76l8vL9K+nTc2H7mlwGA97G1AOfyiRbC1AO0JbPJn7uoZLMOpaueiWwFT0yAr9LzMTvAx9nPuPAHm7rhYxZYIbM/nWpEHanr+83rwxGrMKV8KaJ+5qJ3iU9C+Tr1bROWm6abIxkKhWnzn7YzDUGKeHEN6hlaIOqx0GVnPVxyAy2c5WdTKWXvQkNyMlt6yOOwV2I5cvfKVWZWoyzXAtyz/yeWYds7CdLG1kZUjLL8064vlA4D7E1NlxYbH4LAN/CYeQTsX7IQjvRrG90dDxVq30caguLMRkJiXjS4IaOao8T9IbBE4d327pWJ5ONEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T6bodP8/CBWS0sajpqi4l3EFEc4xYhHDYaU25KJMSY=;
 b=9np4BeUzRza8bWeVT1rKd0EdP8d5CdLMf8oKbygmBUR1c4ErLsJZlWFLgRBgplcKkSL8xtyBP/y9Q9w0xqUkhS8Ht7vlatHq+VBoC1nknFZy0gI83U4HPpglRlhoqlqqzCC3pclPmkzJxOmv9y4abw6qPFLT55K7lP0BK0/DBWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SA1PR01MB9105.prod.exchangelabs.com (2603:10b6:806:45a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.6; Fri, 13 Dec 2024 08:22:57 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%3]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 08:22:57 +0000
Message-ID: <be0d7423-ca33-416d-a410-3ff303493261@amperemail.onmicrosoft.com>
Date: Fri, 13 Dec 2024 16:22:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2 fix] arm64: refactor the rodata=xxx
To: Ard Biesheuvel <ardb@kernel.org>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, will@kernel.org, anshuman.khandual@arm.com,
 corbet@lwn.net, patches@amperecomputing.com, cl@linux.com,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, inux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241212082426.4110-2-shijie@os.amperecomputing.com>
 <20241213053049.7592-1-shijie@os.amperecomputing.com>
 <CAMj1kXF=1Hr9G4ZjnEVzJ1snn0V4L-=+bMU4bn=m0UbYLyBqGA@mail.gmail.com>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <CAMj1kXF=1Hr9G4ZjnEVzJ1snn0V4L-=+bMU4bn=m0UbYLyBqGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SA1PR01MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: aef186f5-8d96-4edd-d796-08dd1b4f5912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlFJTXhkb2UzS2I2bmt2ckFZNDlaaFJiNUUwcnpJUGptKzNiSlZYU3ZYNzFJ?=
 =?utf-8?B?RWkvTThhQ0tTSVorbElONzBaaFA3V0UzdkhZZEE4TmlSeVdqQStnY3h0YXJj?=
 =?utf-8?B?dlRZVG9ZNmxGWVhxZkcraDFRQjVlaUN6b1lsZ0N3K1pmdmpvekxJblBCa1A2?=
 =?utf-8?B?M1RVTnJFWEE1NUJyc0toRmc0azVWM2JWb1BLOU5wV0JMbXBqQWNBMDdrc3BC?=
 =?utf-8?B?K0IvVnlsL1BzdlQ5eFpYcC9ZRTZldy9uKzIvbldWOER5Z2ZZZUdpSU5vbG9Y?=
 =?utf-8?B?NHBGRGt1bklWU0pFZFVIcVNNQ1hlTVJiRjlGVGdpSmNZaEc0ck1GY0I5Z2U2?=
 =?utf-8?B?TDFVZHhCSkZ1Z2V2ejVHWlBCbHhuVGR0eE4zeVNCT1FET2lTUTRvb1ArMTZY?=
 =?utf-8?B?M0lmNmpkdk5McndqQWcyb1BqL2JoTGhrYjQ3ZHJjV1JjMHhqTlFjZkhsVnRR?=
 =?utf-8?B?OUJtNisyNjJ5R1I0MDhDK05yMGNWWmhQeU1vaUJ5VzhtQUViTm9CcU5NVytz?=
 =?utf-8?B?Z2J0aXkyYmpLVWd6Ym80c1pybWVEZkdLSnN5Q3ZrWjBtRDhyOWRzcVh0ZE9Z?=
 =?utf-8?B?c3dUZW9yMmlEUVJBMWJKN1MzbEtiV2p0QjY0OGtnVkl1SjF5VUtqTUh6UWRx?=
 =?utf-8?B?Z2dPU3VrMUZqWEpJNzI1NUFqYzdSeENjZjE5L3Npb0Q3QlRpT1VhYSttbHF5?=
 =?utf-8?B?VUhqa0pYRnlRM1RnVG5xM3UyR1g4d3JPZUh2bHR1ak4rTlFYa2FteWlkMnVM?=
 =?utf-8?B?bEo1MWlxd2N4Vm52SVZKLzZQLzN0Si9yUWphVkxrTmEwd3A0OUJPa2ZQaGJk?=
 =?utf-8?B?MzFLbVd0Skd6Zms2dXBVdHZCbWlrekN5OEIxY2J2MktUVGpKajhUQmg3dGFz?=
 =?utf-8?B?K3g5eThKZlp3MzQ3ZHNJVmhCQmo4ZXFkQk1iYkNuUGdIVmFSMzFsNTFLZ2pN?=
 =?utf-8?B?UE9iSXd2QmU4UWZybTRrMTErQnpXdXhtKzVjZVFhN1crUjVaZW13R3g0YVRs?=
 =?utf-8?B?cmZmRFU5N1FodEZqZjAxajRmNWtSbTRLK2FEVFFmd2hSQy96Q0wwUThWU08r?=
 =?utf-8?B?L1ltTTM3TE0zWDZ0cGpiN1FSZGV4YXFpdFk0OVpXWVZydTM2VW1vN2RBSnJL?=
 =?utf-8?B?QWJ3ZUFCWXRKbmRNK21ZaWZMVUJHQWQ4aW5PRmFrMnU2elhWa2J0ZjdHVVdQ?=
 =?utf-8?B?ODA2d0tPSUczU0tqTjM4VkZNVWxRSjRLM3FMYzZxY2RVRmEzcGZ3bVczNHhG?=
 =?utf-8?B?enVKTkYxRGswTWx1ZUxCOUQ5VExiYVIwV0FmNHArb1ZsNEVGTW5uWHNCaVRl?=
 =?utf-8?B?akNHaVlzZlo5ckFabHVhUjBrVExXUkpHL0EvT2NFUWlHY1FPbnFldVgyWDk0?=
 =?utf-8?B?dlRiaDFFb05zWjU4MHVqSmRBaFpsZmt0WHVsUjVGbzJHMVIrK2tqVWRWczlO?=
 =?utf-8?B?SUE1STFYSWdOMU5CWjF4WmQzRXVTMmFrT0l4a0U2MlBKczAvNjkycmoxSmdM?=
 =?utf-8?B?NWdMUnVMNGlmK3lnN1FrcnRCWk0rbjBxS0d4OW5zdnlFT2R2WVRnL2lUMDRK?=
 =?utf-8?B?L1RYVktxam5TN29zbG1teG53YjRHK1BQMUh5WmR4VFJrb2JNM3djOXFnWGlD?=
 =?utf-8?B?UVppRjZYbEJncWFGM0JrYUFDdDJmM2o5eWp1SEtiaXRsS01YS1pvTVFRVFo4?=
 =?utf-8?B?aHlWUnVtaFF5dUQzRlZmWDJiMVc2V2E3b2dyOE0xQWd5TTJiM05KSU1IRitT?=
 =?utf-8?B?c1FEWitaTXNRaGNlNUtiRW1ad2VNWXFUT2ZPeHVCYTNLNHFBQ3grMDZBcjVm?=
 =?utf-8?B?ZGZvQk9PQU9kQkZHY3VWNXNDOXlhb2JzL3VHWENDOEdtaEVxVmROYkhxeWZn?=
 =?utf-8?Q?GK4Fig5261nXT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L05zaWExNDdma1MxMytXZm9BdlFIZEwvSk1aQS9qTnJPbEJLcXlKeWUybUhD?=
 =?utf-8?B?WWo2bjRsUEhZcXJpMkwrYXZXOFRrL29uRlIrNGZyUnR1d1c0eEw4WWpGRjEr?=
 =?utf-8?B?alhPblhEVFUzaTdBOHljMk5OOEdXcTZGNlRoTG12b0o2dEJnTUNsZmJRelRl?=
 =?utf-8?B?S0VOZGdpN0RZNStzV1k1bzdDQUY2WTlScCtsUXpvK2p2Yy9GUGl3QlZ3Vncx?=
 =?utf-8?B?YWVna2FxcHYrZlVGVkh3OXFuclE1SWlRTEtPc1hYOThCVlFNc3hGOU11MHM4?=
 =?utf-8?B?bDVYVzFic3IwU3FGUUNOMHFEZHNNZjBybVhoSTNXb1dCZ2ZBcHNPUkliM1Rz?=
 =?utf-8?B?K3JVTnNYZExXY2x4Z2dxeTgvWkd3WVdCM0M1KzBnY2JkQmJvdk0xWms3YzJJ?=
 =?utf-8?B?eHExWmVkZW1aU2d1NmpFMUpTMWpvUmJvdjdSYkR3SUg1cUM4LzRMSzBYU0da?=
 =?utf-8?B?anNqR0h3SmFUS0xacC9BUU8rcGJqWXlIWmJka1VrY3NrTHJSVklPVS92aUVZ?=
 =?utf-8?B?SDMwUVlEQ3FRd0RjMEQ0Ync3Tjk4UXIxSzh1STlUbXhBWXFlTTRKbDRjK1M0?=
 =?utf-8?B?RmVkTkVWY3pjajdCM0tHQnJUa1BJdUVnamJobEZSMFIwK3BYM1oxZmx4L2Fy?=
 =?utf-8?B?MmxVdGpKL21pT1RHcFVGMWJVUW5qTG4xUXBYbk5iU0hxSjcrSWUvMk9VMVZV?=
 =?utf-8?B?M1RyRm1hQXN2SWZvMGVVVXNodjJRU1hKRUwrSUhoaGVDM2gxS1NDU252ZE9j?=
 =?utf-8?B?NFRmTzhnYXY0cUdLS2dmbW1WN1BWcFdJU2ZrZFRsQ1VMQ3NiVFZDaGphUTI2?=
 =?utf-8?B?SlJSRCt1WGhZQ3F5WXdMNUZtV2dFVk1LUUdwQnhpMThlYXZTTWVvWXhVam05?=
 =?utf-8?B?Q3hSZjJRT0dVaTYwcEhvcmhNWWtCZVpmRTVEVjVBMVljVjBaUVA4ajBSenVG?=
 =?utf-8?B?bWd1USszTHZ6MFZRT3Zkdm5hRmhFWlhXL3dmb09ZUjZPOTN1VG5DOENtcTFq?=
 =?utf-8?B?N0UzbzFkampLRnlSTzVBNTdwN2g5MHhkRUIxOTlFT1hnNnlWRklOTnpqRVpZ?=
 =?utf-8?B?ZEhERURtd3hvV2Q5djU0dkxGTWpIRk8ra29NbkFPckUxWUF1bzFuYnV4OWZQ?=
 =?utf-8?B?c3ZuN1JFazZ2dkVyeHptQWN0a1dzS0JmandUVjR1WWw5ZmdFc0xJQUZXeHVS?=
 =?utf-8?B?WWJoOG8xbkRiL25EZWFTVzFHV1M1azA3alE0d21RUDZ3NG0rR2IvVlowNjFV?=
 =?utf-8?B?Ull6MkxYRDV5YzJJNjFoWDVsdzFsVlZjT0YycnpkTmJCMUt4aTRqQnBSTnBN?=
 =?utf-8?B?SjhrajlDeW5iT3RXQjIwdVdSQzFROG9EWUVWRlN3dy9NNVc2Wk9KMzJQb2tu?=
 =?utf-8?B?a3lmb3pVYjVXa2VtNjFYUXFWVHQrSW01cFl6UW1rQmVTa2t4bHFKVStaSUNn?=
 =?utf-8?B?ZS9SQjNkNlFXMnlucDdTNXNtTlFCTkxHaDAxeFZuR3JiZWJrcEk3V0lBOFdF?=
 =?utf-8?B?QXM1Y0ZvSkFkYXpWbWFxaTAwZy9VM3plM2lUbG1EeStOSFV1dC9NR3ZDVk0v?=
 =?utf-8?B?WHMyQ1NYTldtcnAwWk82RFpVZlpDMGpKTS9ZVkdDRkc5aFp3U1o2UU5TQ3h0?=
 =?utf-8?B?OGcyYlR2NnNFQXVlOXNPV1hWTHFIWU9DMFkzZXprZEpHZXFLQ0twZ08vby9B?=
 =?utf-8?B?aHhhUnd4Q05qU3NaNTdrOTZSNVB1TWpuSWJJRDk2SW1SUnRBWkVYMURTODA5?=
 =?utf-8?B?djNJTzFObDU4TU1xYk9PYVNsUkhJWmtaQUR5bUtoZWRmRDFQWGF0OXlTajBh?=
 =?utf-8?B?dE5pMVh0Sk5GTjAreU1RMURoTkc2VkRyTFZrV3dHWVNHUlA4THcvV1NLRHhG?=
 =?utf-8?B?MXJCZ1NxVldVMzFhU1JaWWV1UjRENSsxdlUvNThaMjNTa05XeGV0angrS213?=
 =?utf-8?B?dTRYQWoyeEVXZTZBRWlzZUsvYitTdjRJZGlheTJTcFJsbVI1OHEzVkJVQXgx?=
 =?utf-8?B?bDlNbmJHTnkzODV3TjhkeVVCSUViaVhKTTMxcjhVazZOYldTc1pPYTljbUxt?=
 =?utf-8?B?VE5CbE9maHY0TS9VYlFFY3UyWVlDc1drSzJwUDQvbkIvQitFWG1saEREdGtE?=
 =?utf-8?B?Q2dnZDM2Y0RGTVJmRm5VdFJCM0hlVHRaNk50eUJuVnA0OVhkR2pXSGJ1aVUr?=
 =?utf-8?Q?y8IRrH/C/i4HxaOKTdPz2VE=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef186f5-8d96-4edd-d796-08dd1b4f5912
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 08:22:57.0512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4V2sHvbSDXTB6bXuerUIzdGwbiAGJFC1SpwML0EGxZEWsMg9LWWBD9sEmdG2owwpf3vPcD5fQyOm+5MrVPLK7hND6d53KgIYygJl1CXaKpLxRtCuLUoPjJP1sc2IJYrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB9105

Hi Ard,

On 2024/12/13 15:30, Ard Biesheuvel wrote:
> Hello Huang Shije,
>
> On Fri, 13 Dec 2024 at 06:32, Huang Shijie
> <shijie@os.amperecomputing.com> wrote:
>> As per admin guide documentation, "rodata=on" should be the default on
>> platforms. Documentation/admin-guide/kernel-parameters.txt describes
>> these options as
>>
>>     rodata=         [KNL,EARLY]
>>             on      Mark read-only kernel memory as read-only (default).
>>             off     Leave read-only kernel memory writable for debugging.
>>             full    Mark read-only kernel memory and aliases as read-only
>>                     [arm64]
>>
>> But on arm64 platform, "rodata=full" is the default instead. This patch
>> implements the following changes.
>>
>>   - Make "rodata=on" behaviour same as the original "rodata=full"
>>   - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
>>   - Drop the original "rodata=full"
>>   - Add comment for arch_parse_debug_rodata()
>>   - Update kernel-parameters.txt as required
>>
>> After this patch, the "rodata=on" will be the default on arm64 platform
>> as well.
>>
>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>> Add more descriptions for "noalias":
>>    It is not a security feature yet.
> Why did you add that?
The following is the current status of "rodata=noalias" by checking the 
kernel page table in my machine:

    1) the kernel code keeps read-only in both the "vmalloc area" and 
the "linear area".

    2) But there is a read-only memory range which is read-only in 
"vmalloc area", but its linear alias is read-write in the "linear area".


Maybe the "security" is not a proper word.


>
> How do you envisage 'noalias' becoming a security feature? The point

for the case 2) above, if its linear alias is also mapped as read-only,

can we think it is safe as the original "rodata=full"?


> of 'full' rodata was to harden the read-only regions in the vmalloc
> space against inadvertent modification via the writeable linear alias,
> so 'noalias' is less secure than rodata=full, and should be documented
> as such.


>> ---
>>   .../admin-guide/kernel-parameters.txt         |  3 ++-
>>   arch/arm64/include/asm/setup.h                | 27 +++++++++++++++++--
>>   2 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a22b7e621007..f5db01eecbd3 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5901,7 +5901,8 @@
>>          rodata=         [KNL,EARLY]
>>                  on      Mark read-only kernel memory as read-only (default).
>>                  off     Leave read-only kernel memory writable for debugging.
>> -               full    Mark read-only kernel memory and aliases as read-only
>> +               noalias Use more block mappings,may have better performance.
>> +                       But this is not a security feature.
>>                          [arm64]

What's about change it to:

    diff --git a/Documentation/admin-guide/kernel-parameters.txt 
b/Documentation/admin-guide/kernel-parameters.txt
index a22b7e621007..3d4aef0d0811 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5901,7 +5901,8 @@
         rodata=         [KNL,EARLY]
                  on      Mark read-only kernel memory as read-only 
(default).
                  off     Leave read-only kernel memory writable for 
debugging.
-               full     Mark read-only kernel memory and aliases as 
read-only
+               noalias Use more block mappings,may have better performance.
+                        It is less secure then "rodata=on".
                         [arm64]



>>
>>          rockchip.usb_uart
>> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
>> index ba269a7a3201..0ef57d19fc2a 100644
>> --- a/arch/arm64/include/asm/setup.h
>> +++ b/arch/arm64/include/asm/setup.h
>> @@ -13,6 +13,29 @@
>>   extern phys_addr_t __fdt_pointer __initdata;
>>   extern u64 __cacheline_aligned boot_args[4];
>>
>> +/*
>> + * rodata=on (default)
>> + *
>> + *    This applies read-only attributes to VM areas and to the linear
>> + *    alias of the backing pages as well. This prevents code or read-
>> + *    only data from being modified (inadvertently or intentionally),
>> + *    via another mapping for the same memory page.
>> + *
>> + *    But this might cause linear map region to be mapped down to base
>> + *    pages, which may adversely affect performance in some cases.
>> + *
>> + * rodata=off
>> + *
>> + *    This provides more block mappings and contiguous hints for linear
>> + *    map region which would minimize TLB footprint. This also leaves
>> + *    read-only kernel memory writable for debugging.
>> + *
>> + * rodata=noalias
>> + *
>> + *    This provides more block mappings and contiguous hints for linear
>> + *    map region which would minimize TLB footprint. This is not a
>> + *    security feature yet.
> Better replace the last sentence with
>
> "This leaves the linear alias of read-only mappings in the vmalloc
> space writeable, making them susceptible to inadvertent modification
> by software."

No problem.


Thanks

Huang Shijie


