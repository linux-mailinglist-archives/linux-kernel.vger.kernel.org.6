Return-Path: <linux-kernel+bounces-550672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B9DA562B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C0E7A3707
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0CB1DA31F;
	Fri,  7 Mar 2025 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="e6Zg2pXY"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021101.outbound.protection.outlook.com [52.101.129.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3281A5B91;
	Fri,  7 Mar 2025 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336784; cv=fail; b=Ijk7DN8++IA8UPazOFXrDDjjkVXrLTLmUsJumq5FTd71X8j8H2GWNapOja1Rq7iyKeUh55F6HvXQXlB7iDcygBQbqs7ygD2LYrO19cXvza+AsaD/J8ctNcBI/N6Tc3pST/uDXrSvaaDKdGld7baC8LYvlJgwbveEBSV4OOZIZ3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336784; c=relaxed/simple;
	bh=hLk4SAxagZ63D+wyWyPTs1Ibq4jNF/ULrEm+xEiB3bQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B4Qq8DXzlWgC7WdnG3qz0J5Tewhknh34HuQ/Mqm3Jf0N0t2TiokpvOg/M3NWRnDdDa0pavYqbQKQoU06pCxRKeGs1ESLDU+bhYxffzDCPgASlF+icdakVge8DK6edp1kGCb+QobnQVKiRBefOekPMdXcXVfUSn34AGb2BI8ZPoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=e6Zg2pXY; arc=fail smtp.client-ip=52.101.129.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpJkfvy7xlxZBz0bcBMDKn+D4mzdVPOdqFAohtZ5IETFRk88vpsDkeMhaKAZYmMPxlcfUImUSdW36vcNbud0szK0NtgZWq3RILbjbqG8pYUl+SovHXml0IOHxVnE2bFScQD9rd8ON6gHH1QxAIKp5KpsCfHECc9wnhorEMJWIBNOxA36++Lrf6PSUMcvtX2LRoJjR0+rUqQwauqWT/HkvuPsZwvn7tCA08bsgIJc6KioKYUwyrFXQ+mzBWd0rmUNqGPY9e3AAMDzO5TI30ub124Jc5FxJQsFoB2ERriDxOYRzrT7yw6d0Z0gRQNHIB2lbjgcKnI8tSCxD/6lubCeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3RZLb9giQnQVZyaIoiOUs31Ix+a8ubAPbTY01p/s6U=;
 b=Z25ERJP09WEiGE/XRyXsee+lvamwaIiD9vqCyBJyuotcvGSGcyoQFxrvd+a8WQnPATQkOJ/mTs3xhIGb0pbPDpwnpspuTmOS1u6TZvegtOKXFB9E/7FOr2hFbZ1SENI3KV3EEfk40bpJuose0arcMcIWxWIoJvESY7dPf6+514WutVyZ0TTdfR0EsuW3zlH22hLC7K33G1mBAuwOTtt023tbAXUGdbFvX92orLnI42+vDMTDmGkgfOBVm44OX9T1El6o72kffEI7PB6ajXiUdBfR9kbBGznP+bOtbT/b4nCrLUDkjhd0wOAgxMp8ZKYU86Rsl+DGgUEfWdtVMFh5YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3RZLb9giQnQVZyaIoiOUs31Ix+a8ubAPbTY01p/s6U=;
 b=e6Zg2pXYzJtsMm/HNyW8V2rhoa2duscUpDonpxSNfRQ+6IyqCEyX9OqQJFXWITUjSEMUUEvSXwHDeDUfTK9x4dSE+W/4dIbp5WVGHSEBTF1gQHR4KLM2OiQ+9NA2+/hfRyQxoErBjNI6c/lQvB7TftCYHQg2G+XRj/UchPblAAYqC6ZNtEEORJC7L9MLUonIjaq20s/BX02lhYVUKgzlBdogxYaQ2uTGrD3LIHtXpi05doT0HHPjVYnryNx0u7hPJ6yOiknJmNLo5stfvwZm0ETyfTuZ6wnpUMbD9X2rfg0Pue+/lzxjNawvPOKq5233nYl0UyQtsOZmNiPY5sN6nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEZPR03MB7246.apcprd03.prod.outlook.com (2603:1096:101:a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 08:39:39 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 08:39:39 +0000
Message-ID: <a7c5f76e-241e-486b-86c9-ae9b64f3d52d@amlogic.com>
Date: Fri, 7 Mar 2025 16:39:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] irqchip: Add support for Amlogic A4 and A5 SoCs
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com>
 <20250305-irqchip-gpio-a4-a5-v3-2-1eec70352fea@amlogic.com>
 <87h64546ca.ffs@tglx>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <87h64546ca.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::18) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEZPR03MB7246:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ea3b06-332b-4f23-4429-08dd5d539912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mzc3SUgzWjI0VFgyWHF5Qnc2d3ZyTTRwQ2o5MUZ1QmRUSWFFKzlBWDJkdmlX?=
 =?utf-8?B?Wmt2VzR0UEF5WjhGaDhEMzVIZmx2YjFxNTlZU2hPV2NIYnFMMnFDaVBsYVZY?=
 =?utf-8?B?Qi95RlZKQ3ZGei9zd09Jd2ZTWWNQSnRuQkZqTGVMRm03VlFaOGgxQVdtbDhw?=
 =?utf-8?B?UGtOTTFxT2s0dCtveVZYc2taN2xPSUF2V1VENjIyNHMzclhKcmFkY2RYdXlz?=
 =?utf-8?B?WGRlTlF3Vk1lVUg3ZkJHcjNFOUh4NDJoTGp6SWFUNXdkd1BROWNFVG5lNW4z?=
 =?utf-8?B?YWpHbG0rbXdzTDlleFpRbldwK1NxZ0duc2dEOE1uTUJINHhSR0RNbHNBcUgx?=
 =?utf-8?B?S042d2Z1citBTVFNSE42dHR2aWd6dzF2TVY0ZTBQOXNaMkZUQUVraU1qZ3R1?=
 =?utf-8?B?QWh6K2pOeHpSZEVUK2xKeDh0MHp0dTE2b0MvZzE1VGRKNzRlRnljT24rZ3pj?=
 =?utf-8?B?aTQwT09CK1dIeHJuWDNOVTFTWUdhVXhGM0F4aE5PZVBidXpIMXdFTnlzNlh5?=
 =?utf-8?B?TTNiYTRXT29KK0lNTGpHUGg4NUM5SFNZYndNSjhFS1VWUTdkYUpNeVVCSWYz?=
 =?utf-8?B?Q3Fvb1ZMalhZTGZMbFZoL2JrdHMzNzFZUlltQm9hT0JGd1FJV3d5WVp1WXpk?=
 =?utf-8?B?NFI4MmF0WXhQcU1idm1aUTNUb1lNNHY2Z1ppbCtBMGV1QnIwVkpobHU4VFNZ?=
 =?utf-8?B?L0xTNTZZbGI1M2JrZjd1cjJYMm15SStYQmJRZG5lWk9kbTZiQ2ZwWVlHU0hU?=
 =?utf-8?B?R1ZvaGRuQlQxTzRsZlVXc29ETjBYM0NYWWxzQVBBSWFrZGd3WlFHVjM5VWQr?=
 =?utf-8?B?QThhWjVHMFZ6cTZFSmhCdWxIVHhjZVFyR2NoZkhnZlc5RW1EMGI1OEsrT2V2?=
 =?utf-8?B?NEptbSt2dm9SYy9Cam5KMDR6WSt2WGNFVUhRbDFXNk9ZblpYRmZwTForR3cv?=
 =?utf-8?B?VGd6SG1xUlQ2V0JGTFloZFR2UmttT2VhbVpYOTRVZUVPczlvT0VpYmYwNGVu?=
 =?utf-8?B?UFR1TlZGZjFUS0p3dzdKb205UEhJejJ5eWo0aVhkZEpkWFNCTTR0eHJOaUhM?=
 =?utf-8?B?dGdBSUxQRmZEK3dNZFpmcU5WRk8wcXlNalpGbnlQak1SZEYwbUc5UWdRVkp4?=
 =?utf-8?B?YVJmR0Z1eEEwdEhZcXRwQXFteUhHbElpajA0aklwUkJyUkdndk45STZjWFVh?=
 =?utf-8?B?bSs5Kyt4cUZCNjBqYlludWNIMmNqNzBERXhpUFJoeHQ3enBPQjRmWVBlZ1o4?=
 =?utf-8?B?d3JJT1kzUGpXYmc2Uko4UXhkTE03K3MwbFQzK2JQMFRXWjhxSVM0dkxqaGkw?=
 =?utf-8?B?K0J1TWNZMEJqRGJTTXBtaG9EYWIzSmpneWxZd0tXdStyQWhZNjVoNjlyZkpa?=
 =?utf-8?B?YnVVUzJZdHU4cHE3TFNqc2xscXpSbzN0VDlzT3VvUnNmRmR2M0dHMEVrZDh6?=
 =?utf-8?B?ajVxMUR2VFNNRlMxMDYyeTFIZmZLSER5b3h2L3hkUXc4UEhJMWZqWEpXbXRD?=
 =?utf-8?B?b1hFZm5GTW5ucE55bnJUeHA4K1gvZ25nZUdYcjZxcmFMeWhwZ2hVYnJxZmkr?=
 =?utf-8?B?MnJPQ2d2ejFLYWl1M2h1WDZPRnowSzVFdEVkZU40MjRSeUx2Qk9yUGV5eWI0?=
 =?utf-8?B?WjBiNUpJSndwd2x0QVorUWRQYmFNYjFyRllyUUZGZ1RIRG9WRm5yL1hjRmVP?=
 =?utf-8?B?R3JQbzVxYjBqSE5aSFR2THJqZUNYdkRoMVVEOVF0dlN0Y1d5NDNZUGZ1RXgx?=
 =?utf-8?B?Wi9RRDIzYVJQYm9WRUsrOUw5RWlLNTZ2VXR6cGFnOXlzQmU5YTJTZDErMmxI?=
 =?utf-8?B?SGM2YldVVzNrZFoxNlNJK2ZkVGZlaXJsaEdEQ09PZmFPcTQ2ZEl2Y0N1SDVX?=
 =?utf-8?B?OXV2Tm9LbFV5MzluWnd5RGdlWlVVM0lpQy9kMGZjYXpEWHNyV2IwVmJzcDZn?=
 =?utf-8?Q?RLuSzvo0sRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnVDN1NPdjQzNGZwOG1MYzBNOUpFK0xnY2Z2eGFoQUdsZ2JLUGJXVDFQRFdv?=
 =?utf-8?B?N1UvbW9KNHh4Z2V1djI2UFBCOWl3bnVub3hZSXRmb2lRUkxLZENFemJXVDJK?=
 =?utf-8?B?dFczS29BSURvYU9ZWXFoKzBHc0VOTHBzL3lRbUlaelZ4dGdnTys4ZUtaaHVi?=
 =?utf-8?B?ejRmTmlvT1BWb1FuQXdweWN6K3Q0bVFST2ZwMjc3S29IdE5uSHhPV3RMNGJt?=
 =?utf-8?B?YlhFM0RUMDVjRTVwRVZvd3FPSWp4S1lmUXQ5RStVWVlYeHNmYmRCUXlXbjRv?=
 =?utf-8?B?L2RBZkx6NmtFNGpuMlU0Qkt5cnNYWmhiSmYwVk5LT3gwaC9rSVpNNWZMajZZ?=
 =?utf-8?B?UlUvbGZnT055Y2hUQzNjQnFsdzBaL1VCaDlsamhEd21oRGpjenk5R0MvRnU5?=
 =?utf-8?B?Q1c1ZzhGRUZVVTdlbThpaTFVci9NQVAyS3BnN2E0dWJTYUVNbDJXZU1sRmx1?=
 =?utf-8?B?VGdMMDZrSXVlWHR2QldtdWdIN3VEQjRkUDdQKy82ZHFRQk5QcUZ2Sm1KMDZD?=
 =?utf-8?B?VXNlak4vVi9hUW9sRWhEVEhDM1NQaFhqT0EwZUtkZDRwMjNzY0x2M3FqZVVD?=
 =?utf-8?B?Q1BuWm9NNjFTcklwMG5TZjkrL01wK2xkSExuK3Y5VEdDOStWanBOUVJJNDRD?=
 =?utf-8?B?cHNuRFhoVWh6NkFNKzdzeXVObHVlVklPNlU3NVRZSERSam9FWDA3eWYyNU1Y?=
 =?utf-8?B?NW4wcWV1UkNMQlVCYnhRYzN4ZzhvVjJDOXZ1cHR3YnVrSC9rK3Z2MlJ1N3Uz?=
 =?utf-8?B?cjlkdHVTSGhsekM5VldlcU9EbG1XZmNkUHRmZUkvY0M1N0FSQkQvQmMyRHVD?=
 =?utf-8?B?NU9DQmZMallsWGgxRzFWcXN1aUNhV0Jna2RYdlluRkt5N0tEaFE1MXU4dE9D?=
 =?utf-8?B?Y3VkZmxpMlcvMldmNjIrcFlzd0xValJGVnRCZlMwM1ZJcS9IT1doT1RwdzIr?=
 =?utf-8?B?R3Via3FabzRhRTh1SCtKT0xnU0hOWXNiTHVkWER3OG5mcmFMa1NPNTBhaUZq?=
 =?utf-8?B?amhDUk1ZS29udjVmc0tUYk1ablFhYjdVYnA5ekVMMmt6emN0TlZJVlN3M1dN?=
 =?utf-8?B?NThsc2tad3AzbjErYUlLUDZOcXRISStrUTNiT3poWEZCMG1vQTNTU1J0c01n?=
 =?utf-8?B?K1pVaXFYSUZHRjFjeW5mbFdmRmJudDlvV0g1V1Y0MU8rbFJlbE1WQjFOYVYr?=
 =?utf-8?B?dnhiaS82bkRPdjZGQ1o5Q0dJeTAvY3V1R1pTL3RQM3ZXRGp1bjY3b2REak9h?=
 =?utf-8?B?TzJWUmtQUkxqUlBKak1MSlVxa29WaGZPYWd6TVVETGpEb1J5V2U1N20yV0NN?=
 =?utf-8?B?RUpXSjBkdXJSd2lEeUgwVU02OVNWdzV1TjZnQW92STR6amFsUUcwK0lSbFpp?=
 =?utf-8?B?T25uTWsyM2sxRXRBblRESERwcnJUemxiVUh6ckNjc2lmVU5rekRmR1B0KzRy?=
 =?utf-8?B?d01sWGVuZmMrNFBiNFI2V1lQUjRFSkxCMUcxdHdoakZxL0lURTB5R3hBbllN?=
 =?utf-8?B?UmprbDFwRUlMUlJwa3FFdHBqdXJCL0FjblovSmZIZW9qT1h6RzJUcmhwMmx1?=
 =?utf-8?B?WEFSOGRCbE96blNXcjdFN3JnNnRuT0RmMCt2MS94N21VUU1QKy9xVVhLYWkx?=
 =?utf-8?B?NWlhdVdtZ3cxNXZ4SHVBT2VGOHhzNkZ4TWhoKzVHN3V0S2hnQVRJWDVsUnM4?=
 =?utf-8?B?aUZNcGg0aGp3eER2REw2Zk5BQ0ZBckdiNC9oRnFTQmM3bWsyQ2VxVVliellz?=
 =?utf-8?B?eGxhUzFTMmhLdUlWcHBDbmo5c2cxemd3WkQwOXNRSW5BSjE1MFMraE9SRTNH?=
 =?utf-8?B?TUhFdnpMMzk2WTl3d3ZKa3hMd0ZydUJxWldwY1hZTUpmSzFPMThzeE9xTDJN?=
 =?utf-8?B?V2NvS0tjdG1CNEdJQURZNURWU25ERTZtYnBVTVVIWFgya0dEcWJ2YU0yTE05?=
 =?utf-8?B?RkxjVHEyWStSbzY1R2lMSGxsblY1cmZCWW9uenpwZzV5T0hkUzVsVEt1WitT?=
 =?utf-8?B?MWxsbW1mRmh1Z2lqaHdNd0ZnTkU0emZLNXRNcVZWVG04Wm1hTzBmQy9RdDdi?=
 =?utf-8?B?elhUUEVzM2lURWdpaWpLMHBGWXJWVURMVkdyUGlZaHBiaURabjdyQTRoR2VL?=
 =?utf-8?B?a2RkTyt0KzIwZmlTcTEraWJDOGhVWGhNcjA4RDVaSytoNmcyWXN5amFHMXhk?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ea3b06-332b-4f23-4429-08dd5d539912
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 08:39:38.9793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sAApoE79tMUulO6mh8US8qpXhWlrjb8uEtrfif/JAgdApJbB4ndiuS0pd5+/QUoZNEAQGRTnbLCeo5Wktqaaz9zn0fcRm8Uq6qshbzefkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7246

Hi Thomas,
    Thanks for your advice.

On 2025/3/7 16:01, Thomas Gleixner wrote:
> [ EXTERNAL EMAIL ]
> 
> On Wed, Mar 05 2025 at 18:02, Xianwei Zhao via wrote:
>> @@ -358,16 +385,19 @@ static int meson_s4_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
>>   {
>>        u32 val = 0;
>>        unsigned int idx;
>> +     const struct meson_gpio_irq_params *params;
>> +
>> +     params = ctl->params;
> 
> Please fix up the variable declaration according to
> 
>    https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations
> 
> and initialize params right in the declaration.
> 

Will fix.

> Thanks,
> 
>          tglx

