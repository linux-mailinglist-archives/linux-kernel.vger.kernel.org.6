Return-Path: <linux-kernel+bounces-282557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A684294E5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D84281DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F60E1494D1;
	Mon, 12 Aug 2024 04:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UN+LJ5cw"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCECD37B;
	Mon, 12 Aug 2024 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723437279; cv=fail; b=T4af2QSfHTolwA7ErsdgA228dCFOieHYGnWRyl2v6fWGe9rWWSELjU31pwtsdt3bXH1jnJQUx1cO6ztqooDPSnTIFpeV4xS7tYademeZBGYfkG4kbLmVrs1wRlLdMBE5jewLjvewDLWxOpcShy4jrr3q2V8dozWSWKUpneiSvXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723437279; c=relaxed/simple;
	bh=V+S6z4rLcjDjsV7McO+rZrCXJO56Ka7y969S9C03cKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I+W2t0HARe1h0rJWuDSa+rPvXMKH/TmgsARR96BulWYzfw6nxllIPgO8HQX+H3DoR39bJieThpeANq8TNsCYJsqRsprlHhkkM08vLkE3j/tL3slOLbq+tmmlHf8EiMknxGyJI2FUYSiLHfB8JzzvdGYOm3ko6Awh7ITUXelaOo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UN+LJ5cw; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6gF5+eu5EfvX7eDeYdYx7aijP3LJ0PP7OCDjJgvMtS4FGWo5fK3Hf0Si662jQGgvgnOknTMJ72JrrEaqk6x6b6mQvjitVuOXNkebKEYREvNvDsgXACMjZLjsYnC3FfMmTvgsNoJcmgDBKFhfYDbgXKfmWAEWrBGlgkhlLtjltvmBZ6qHPB6nReXVTndX9M1k08he9G1t56x7wlz4emyjogMX13XWbOVWp1yqwTVET4DyD0C+tq8sF2Yy6pQ9EmmlfQV0Ul2zssQqZMfnGZDjmaJ/XHwqjwSm/9/4JGH6gj8SsawHG0rWKecN8NlJM3HZQjyW1PVtMMWbqFrcvHVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzyH2Hni2gWEjr3D/5t1ULn3T0UtJ6qrhEpo634w7cQ=;
 b=EgizGwOpRbkdBjdsonNPgbZe83c8/ZY6Pv8prwHHFG7GuNyLH+myMj3uM0TjF1O0WnpvIySpSd/q+p2SLQ8zFlDbAScj+hm/vTFn+vG3wMBHpPLAb8SaXKNOGVnDUbl6mzQCoSt3CJvGBskYcvHSB4vAK7/MOCbVZEz1uxztvxq4ay+HLJLnkGsyKwqq8nbeet+iR4Oz94oUU5nME2xZN2hhgm3cYwSwyr7xAyv32jQm1sS2lIfWzuYCkIV+EduU6saqEb4qdDTK1TeL9KQDHITpWbjdQg43VqYhvYxVu5HKxMc/T9ztQdBiRCPhohE3kBPzjAVnoLBNO3s/AxbmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzyH2Hni2gWEjr3D/5t1ULn3T0UtJ6qrhEpo634w7cQ=;
 b=UN+LJ5cwRhKIOfYxnbpgEq5+6xXpN3wXrmDBNIKur4n4jUOY0mKx4F8g+74DbsUv5LPfNLlH0dhPEmU7g3gRQDDPbaLHrUpM/3b2aKMEehOVUHcFHr0mZR6uieOPD3myZMEz3zRCKETUUdRA5gTfQIG6eFld/GbS9MpzPVsjBa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 04:34:35 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::512d:6caa:552a:7ebf]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::512d:6caa:552a:7ebf%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 04:34:35 +0000
Message-ID: <d4efa03d-97bd-4ade-8cbf-e51bc74071d0@amd.com>
Date: Mon, 12 Aug 2024 10:04:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] ASoC: SOF: amd: fix for acp error reason registers
 wrong offset
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
 <sound-open-firmware@alsa-project.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240807051341.1616925-1-Vijendar.Mukunda@amd.com>
 <20240807051341.1616925-2-Vijendar.Mukunda@amd.com>
 <ZrUdOyGiFRH0sRlt@finisterre.sirena.org.uk>
 <a6a0c975-728b-4379-b074-b88ac928c58b@amd.com>
 <ZrXGzmhgyIJ9ID6I@finisterre.sirena.org.uk>
 <adeb6cf8-1fb6-4bf7-8d36-504b22c366be@amd.com>
 <Zrall8SwKewe2_hJ@finisterre.sirena.org.uk>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <Zrall8SwKewe2_hJ@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AE.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::a) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e85147-d602-4b8b-eaec-08dcba88117b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFNWWExpOXJMWDlpY0VpRSs0ZHh2Y0J3TFYvMHM5aG5aVENXTHk4aDg1bnlY?=
 =?utf-8?B?V1FuV29oYlVzQTlIWFNWbm5XeTNKMFNlRzE0TnBjMmJhQTE5bll3K3pnNDlo?=
 =?utf-8?B?WlJkV05VZTdHRmJTK2lLYkp0WDBwYkJyMDRSS1QrK1ZXSUJobHFtbEsvdlR6?=
 =?utf-8?B?aktvOWNyRlJwT2lTUzJVdUN1ZldrQmRvS1JRbDlhdEY5UVQxYzMxK3Q5am50?=
 =?utf-8?B?ZElsMU1XbnFmMVBQL3N2NVIrQ3lLMm1SZE56dENXeExUcVNVeDVqQUZIMlhD?=
 =?utf-8?B?dWlLNVdkRUJHS2d1aUM3MHo2bVBQbVk3M3VEbmZIY0xIbnJqOWtIeVJtdDRz?=
 =?utf-8?B?TkNMUGwwZEFiZzQyaEZWb1ZWU1kydWtpUndEdDhLUzRaY3ZRdDBjSTdCYTF5?=
 =?utf-8?B?Z0dkUjdFeStmZytsblVHOGZmVDcyK3VzT3RBaWc1NVJ4RUgxSEd5SlNONzVo?=
 =?utf-8?B?MmRKUUxIWGgrM2M3SThFa0NzenVWYzlGR1BFempWTVlqQ2RMeEFmL3A4enNC?=
 =?utf-8?B?NUdzVVpIVTd3QlpXZVYzR0dNY0pONzl3TFFCd2RHZ1krZnRZOWZPTUhsWmV5?=
 =?utf-8?B?c1dibndXdEpzT3hCVEJ1OHF5K2I3ZkZUSTZsUVZPRjdmSVFKdVUybmgzWndG?=
 =?utf-8?B?N3RlYmZKc1B5VE1NejQ4TzYvaXh3djNhMlBYRTY2OGR4TGpTVTVKMVA4YW1H?=
 =?utf-8?B?bFNXb0xqZEkzZzFvOWl0aTRhU0pCY24zUnkyejR3TDVSYnV5WDdINjV4clZu?=
 =?utf-8?B?SG4yN3BaMzAySEhtVW1uaUlZcmVodFhmSzN5dTBNQnRvTldmVFk3b0lFVDQ4?=
 =?utf-8?B?Vzl5K1ZoaDJYY1lPNmk0blZzNHRsVVhpV1lqamN3WnpPMlNja1ZmaVh5UmpV?=
 =?utf-8?B?UWNjdDJrbElOSERlaSszZkZkeS9LdkVBakxCT2ZjclJJTTAxZDdRWDMzQmk4?=
 =?utf-8?B?bFI0eEtYZlUzK1hoc0kvZWQrNXJTdVFiN29PR0JVbnk2N3lCMnUvVkVnbENm?=
 =?utf-8?B?YlI1Q0VieDRwNmNndkFKWlBMWjhVZ3pwS1JYN083R2dmWloxeEZDSjVWMlZD?=
 =?utf-8?B?TGVpQkh3bnBtbnducXNWNzhRRHMrNDRJd3NMK2VHWXFWdmFNVnc0M1ZVU0li?=
 =?utf-8?B?eDlocm8wQ3VsY2d5RkdZc2hsVExiS01KZUpkVSt2RnNOOG41RzE5MUVuckIw?=
 =?utf-8?B?Z2RxSCtnd1NlK0poSERDSXBDMFlZLzNzRGRRanhIaFpKa2hpckxvNnYzWFhK?=
 =?utf-8?B?bFdOajB6aHhTRUg2bzgrbklNODJSNEdna3dyZ2RKb1BUaTN6SkFHQ2t4UUdY?=
 =?utf-8?B?eWJRNGxQcmsyOXExNTZwWUQ0M1VHaEprM1UzcmNtTXF3LzU3T3lvTUtrZ0tX?=
 =?utf-8?B?NXVKZVk4bDJZcTE1MjlJT0E5eS9RQjdobFVEOFI3Y3QrMHY2U0ZEQ1k3d3lZ?=
 =?utf-8?B?Tnh4bHFhcVJIZ1VsZnhzY2FUOXc0azNmQ1hNZjIvbkwwQ1hHVVNYNE54VFkv?=
 =?utf-8?B?SW5TSjd5YSt5N0RwKzZpa2g0aHlOY2pNT3NoQWhBaTJQUk9PN1ZIb3N1SEJ2?=
 =?utf-8?B?ZjVMU01TMHpQUCszNk1ZTW5HRG11WFRkVUpCKy9nTVV1aE5sdTZtNHpFSFoz?=
 =?utf-8?B?dW5JbW5yb0paMGR4WUhKZDBsNzdEMEhqbDJPYzRrN1RlMEdDM2xxRStUdlpz?=
 =?utf-8?B?MXk0VnRMT0FMOTg1aGkzYitHUElqRWN0L0xQY0VtN1pXVlN6eDhRME5ITlFw?=
 =?utf-8?B?TktIZGZFZEd0RDRnUHQ2WEtmSWpUWUJhWlpYMktmREx5MjRScHFIaTh5cDBB?=
 =?utf-8?B?SlJVc3RjR0YzMSsxVVVSdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVIyeXVpZ2dUaTNvWjFwMFBYMjVPdnBkS3BvdU1vcTc1Z2toL0dnS2xuSlhU?=
 =?utf-8?B?aCtmZHV3ZzN4VUw4cG9NUHQrbGU4Y3V3NERqVWo1R29yaFNBUTdUaGpEZnU1?=
 =?utf-8?B?bEJrQXdxenRMbmNFcTVJdE1yT1U2emhiZHh5UHQxSHJVNXd2MnNKVmlCUHdw?=
 =?utf-8?B?d3Y5akxONVlGbkh3SXdHd0o3RUhWRGRVaUszQkZqTXNRNzlwOFFtRGVORytD?=
 =?utf-8?B?bWpWaXZHWFladlJzdlIzaWkvd20rOWs2SzlpSkp5QVRxYnUwTDJRWENvWlo4?=
 =?utf-8?B?ME9Zb3JaM1BOZGV3WUN6VFhPaUptUkhtK0pYemV6Ukgwc1VlRTh2bmQ2UUpG?=
 =?utf-8?B?Q0UzODZUTW1qNnpjWVVmSCtEVS8zV09EenFvK1ZtMWlrWGdyVEg2WUtsQndQ?=
 =?utf-8?B?TFFtYjIxcHBuYzh2YWpzL0RwRW5GVFlxak9XUGttL1pJR3VINzEvcUQwOStv?=
 =?utf-8?B?ZmlaYkEvMHk0RGJ0bXQrK0QzRWpBOVNHTEtpVW5NN2FRTkhXb0J4VFZaVWlJ?=
 =?utf-8?B?NTlrZGoyVlpZUnF5akVvemRSdTN3c0ZuUXJUWElVTUpJY25Bd0pyd1JyK044?=
 =?utf-8?B?UVNxQkxhOStneGZMeXN6UzM4d2V3UzEyMktYU21zbHJBTzJBNSthWi9GNzdE?=
 =?utf-8?B?T2k2UE9NTExwU0NEeWV6TS9Xa3Fad2FBcVh5NmpvRW16MXlRdThONXFTaTJn?=
 =?utf-8?B?UXZBR1AyZDlJeXR5QVptNHdwMlI0Z2ZKM2l5ZURqV3grZWpHWW9pdlhkQ01R?=
 =?utf-8?B?ekdXVjV0WmF4ZC96R0prVVhObVN2VkdpTVppR3FkTVJSM1FMcnAxL1ByOUZw?=
 =?utf-8?B?UmQ5cDUxWmpUSThrdjIvUGk4YlJwbGhSM0d1MWNKUHZGL21XcWVZdWd2d3Nx?=
 =?utf-8?B?WjBKNGxyU3lKdWovd2V4ZXVMYU9PWjJvVTZ6ZnYwVjY3Z0NSMEdmL2YzamlS?=
 =?utf-8?B?UmhSaWJZU0FJN0l0T3dOVzB0YnRxYWJkRmFLOVRCTDczL2x6djVWdDk5czFR?=
 =?utf-8?B?SS85YTVKREQrdWU3NGptWHhBNExvQnlhenZ3L0JiOVhFcnluVjg5NzlmeS9X?=
 =?utf-8?B?NmViTm8wWTQ5WHphR2F0eWV1WGMySnZreW8ya3B0aHZoWEpib0JyZTRKTXBB?=
 =?utf-8?B?ZjdOSHJMOVg3VnR0TlJzYUFPSTVPcGM2WThDUWlXVGxFaEphYU9vMW1YeUFy?=
 =?utf-8?B?dTVYWlVzK0VJZ1VxYmN4YVVHbWppcEVUeHA0YnlYL1N6R0kzNmx6ZC9mRWZJ?=
 =?utf-8?B?L3dtSkttSC9oeFVQdHRFSWhNbnU2Sk1hemNBUkN6a1R3a2Ivc0VoYjBMN2R6?=
 =?utf-8?B?cndBbTk0OEdqYU82N0ZMVndHZU5IRTMzcGZRVHpmTFpBb3VrU1dRaXdoa3Vk?=
 =?utf-8?B?WjRFYmFCNEJhMFlFcWZIems2b2tzTmtlWGVKNEM1bWhQMi84ZCtmNFhFS1dB?=
 =?utf-8?B?NXo3VE53aFJEbGFiaCtaRlB1YTNKSjFkQW1LVmNqN0JqSmNHQWNmZ1llcVIr?=
 =?utf-8?B?ckxHcFVIdm4vc2lMYWVFQnZDb3BGM1FUWFpvZS9qeXFYQ0ZlY0VuZ2VPa3NL?=
 =?utf-8?B?QkpsQ2crUmpTRDUxT2NubGtzL0hlQXpaMDNWOExnNHN6QStxTVdBa0wrM1k1?=
 =?utf-8?B?dktaVXIwdmxQaTNnaHlXaEN5U1A1ci9Pd2tNSk5jd3hxd2tNSWNtWXBxMUV2?=
 =?utf-8?B?SVJPeUh3RFpLVkZidTNwT2wyY25MNlB3VjgxOWwxaHl0eHBkNWYvZHh5Skdy?=
 =?utf-8?B?NHBzaDcxeEpTcmpTM0s2bFU2ajNNMDJkd05GaWJaZ2xqeTZxQ2VhcmdWNm8v?=
 =?utf-8?B?ZGdWOFM2VkI3OTJpQk9jUU9GSDVGSjVPRnJMWjdIbk92N1JpbVN6S2VRU2FP?=
 =?utf-8?B?TGVTT3RTbkxJWjhyM0xyaW9pR25uZFZhTDkxc1BvYWdGcmR4S205eGVBTVhk?=
 =?utf-8?B?RkM4Ryt4UVhnUkxxbTNKUmNxUlpnd0N4YnRFU09mdmxySXE5Z2RYT2Q5MVBC?=
 =?utf-8?B?bWJrelpVQzIxdHJYNjBpYThNcU5rb2FGR2ZDbFNOM0QwM0lHM3UwWVh3bjd0?=
 =?utf-8?B?bThMeWtveXM4ZjZLT3hueHVFTFdXRnRWcVcvUHRpUlUyV2M0MnRDdVZMUThT?=
 =?utf-8?Q?U0dRIDxPHxlWmk6RKCmFuZ6D0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e85147-d602-4b8b-eaec-08dcba88117b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 04:34:35.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwhWj/bD6YoxSsXMISTx7hDHnGoDGtPtdm98U0oM8b3YJNB2H8cYWw6MZspACFN8wSPQHO1pQBjo+9KYoLb6HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248

On 10/08/24 04:56, Mark Brown wrote:
> On Fri, Aug 09, 2024 at 01:49:37PM +0530, Mukunda,Vijendar wrote:
>> On 09/08/24 13:05, Mark Brown wrote:
>>> We want the resulting git tree to be bisectable, that means testing each
>>> commit not just the final result.
>> This patch series is prepared on top of
>> 20240801111821.18076-1-Vijendar.Mukunda@amd.com
>> which are incremental changes and also has dependency.
> For the benefit of those playing at home that's "ASoC: intel/sdw_utils:
> move dai id common macros" which is in -next as 8f87e292a34813e.  It's
> not great to base a fix for something that's in Linus' tree like this
> one which has:
>
>    Fixes: 96eb81851012 ("ASoC: SOF: amd: add interrupt handling for SoundWire manager devices")
>
> in it, and any such dependency really needs to get called out in the
> cover letter if it exists.  
Agreed. Will mention the patch dependency in the cover letter and
resend the patch series.
>
> In general you should expect bug fixes to be applied for Linus' tree by
> default, especially if they're tagged as fixing a particular commit in
> there.  That means no dependencies on anything that's already in -next
> unless explicitly called out, and if the thing in -next is just a
> cleanup or refactoring then generally it's best to just do the fix for
> Linus' tree and then separately merge it up to -next and integrate with
> whtaever cleanup/refactoring is going on there.
>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.


