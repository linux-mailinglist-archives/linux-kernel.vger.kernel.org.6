Return-Path: <linux-kernel+bounces-256955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C832D937327
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733C92825B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 05:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2F36AF2;
	Fri, 19 Jul 2024 05:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XBrcfaBM"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797210E5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721365617; cv=fail; b=REnNZUGKZWl8ugD2WEbEHLR8R64dCEIhan8Ut/f0Ng0IV7w3I7muVin62b5XAEKZfvMt2DdYswgX3lAopAJ3Qo+VhcZl4WCXI0c5JJ6FSrr4EtwwVFyrNz04aIOGrq13DkF8z1/4OHOJuTJgjXzBzQrmAYrb90D7Vi5ZWd1dhwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721365617; c=relaxed/simple;
	bh=BPrSpIS/ZeRjuTAwGzxy4iWat5bB29Z3/t1yt6KeZIA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uiSaT2r+gmacjNf+pjuq92GN0GXch/1frQUTNO+PHTIvOGc6zJbYefc1KrCRbwzZP78dOxgG1pPxy+K/IL+gw8KHnSvPzxMSUJBuxbaOmRKGXeT9CCU6Vh5x2IvLqmSioaXAV3VGrURPgl9YQg0KaWgooZHgecVjhCD9C8SAoCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XBrcfaBM; arc=fail smtp.client-ip=40.107.95.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuFqP5FGv9XDekW2WHvTjwMF6HXpJvplzjFRGbfu7xQozR1dn1Za4Vzn+M58o9tKFeEBDOrpA4SP1NBRL8YifIREWJloHGQFJ2XEtBo871r5Bq/d6VtqX4Rt1F0yonDypPOrNr8uHJrUGhQJfPSaCl13daqHKJr/VscOeO/prYmAyRHmtq7dHZ5OgQ65VSMoSzpvuP6nmLVBiweDGByjqVTNQkvsrW3Bb1xZvMN+ZteRpiIG+wnMU3r1wWqCIrkLdhOwuSgrBIHigjmQ0LDK0i1PodOaOoMvAlAXa8X8Z0VEVNwyKNmWOVKpyJEgleQT26zAD6+E2Jczkeji3Miiaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy4qH1ZjfXacZ+AZM8fcQErA5ghHHfSV+w687ZwW4Rk=;
 b=FCXhMjEmed3cX2B+p5iRXylvzCIogbJUejScmadmtA7DqBSQAzRwqLkO8hx4dp6v4EBKxaH1e+Hythelw3LXEZZqrXtNZjWDAZsPCjqogvcWyl6e2FYMsGjhZP2tVboGupU67k0wjFc4C9pLv18gB13PfPyN/PPL1vPUNgu6LCvB3ruKIbl74aR271/VUN7MRJ4/4oyb+o74/axW41WW77Aa2Y8C9+WyblaP6Y1koi+MX8OSsoS9GFAh+o/aFL/gCXZ68/5Uf9bE/lTIEag1BdsDdwlJtdxefop2FEF6y8krt+LGo/uJJaRrDntmKftqUQzg10yFCy7m8GM67ji8Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy4qH1ZjfXacZ+AZM8fcQErA5ghHHfSV+w687ZwW4Rk=;
 b=XBrcfaBMaVBpZhpUTSQnVSeHbEfwZ1GSJkRhbw4fky8FzqSaDoK5W7P9HpCLOlWMtrl+7yWnprpDBNKzTBl0R3VaNgrDY2ZkrJalRUThWGFnJWqskDXOF/W3XcYlfv87UZX9fc/d7P6YXiOY7Lt1r4x6+5xXd2mmP6v0ELZYuts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 19 Jul
 2024 05:06:53 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 05:06:53 +0000
Message-ID: <63270710-ac43-40e9-b5ac-36588bb2cc9d@amd.com>
Date: Fri, 19 Jul 2024 07:06:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: zynqmp-ipi: Make polling period configurable
To: Ben Levinsky <ben.levinsky@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 jassisinghbrar@gmail.com
References: <20240718204057.307655-1-ben.levinsky@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240718204057.307655-1-ben.levinsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0108.eurprd04.prod.outlook.com
 (2603:10a6:803:64::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: dd61dc8c-67d4-46ec-0029-08dca7b09ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Smw2NWdHK0hkZHVIZUlpYkp6RDY0dlIxYzRjaHN1Qk4wQVVLZCtXaWcvZXhl?=
 =?utf-8?B?bW5pNlBSVHdPOXp1ZVNiMkpjblVSTGdkc0RSYjVEWHVVcFd0b2UvWE9TUEx6?=
 =?utf-8?B?M1k2RTcrWEhBam0vS3ZVYURGVmVRRjh5YzlTdGdIbG9odE1KRlM5L2ZhYjk2?=
 =?utf-8?B?WjhsMmxjWkxWejVXOGRLZFlyUFpJcGNiMXNzbWFHWWNVb1Btck9seXNvZkN5?=
 =?utf-8?B?U3JCN0NrZW80WmJSUGZNeTNWdWE4OTcxN3QwR01ad1RUZWt2bW5MT0ZOZnkv?=
 =?utf-8?B?SDVwSEhvYUNiU1Q1d1JxMDc1WGFJbnB4TlJPNWVqcDhsQUl1YUFxS3JRT29q?=
 =?utf-8?B?eWQwT0dSWjAzN0JPTzBNb2VSRHJXeVZkUkJOd3RWTUJSaVNvdEp2OGdGTk83?=
 =?utf-8?B?WHJ3WmVodm1LN1pHdTZHZGFweDV6SllDaVNUZ1dwVXI2azM1dXBjYU45enor?=
 =?utf-8?B?Z2hZQzJZRDR3MTQySGRUOGVJSmJCcG85bDc1SFhFWXo5RW53OUJYcVhDSXFR?=
 =?utf-8?B?dVlnTjhOaXVKZ29YV0JYYWxDcnV6bUpqWXBUdzBOQzJmNmR3NDlPOE1vWHdk?=
 =?utf-8?B?SmtiWDR4bjNLWE5SdFBMWEJ2TzRXcVh0TmlWUVNNU2JIL2EyNjE1eWIyMlE2?=
 =?utf-8?B?MTNWNExKL0YwWWVYRlVlbURYczhiOC9ubjdMVVhleVFrODJKazdjSEZnR1BO?=
 =?utf-8?B?ZU1KR3VqcWJwNVZQRWdWa25pZUV2c2lVUmpJbC9FWnhPaG1YU1ovTXRzSG5t?=
 =?utf-8?B?cmtQL0h3QWxFM3hmZ1drRlo2d1VmYzdZa1VYeUtmT1Y4RWVIa2NkdTRYTkNj?=
 =?utf-8?B?OHpMVFY3azd6TkRDL3FKeGM3ZmdyMFdVRGVPQ0kyWTVWZHBEdTVVeS9qUHdG?=
 =?utf-8?B?Y3lUKytrVTNpT0NVNEdEdEZKeXdCN08zdDZhZ1lVaW41R0FuSkxPdmp2ZHA4?=
 =?utf-8?B?REZOQ1NhY1F1MFV0RkJOenZoRlRXdnBHNDRmSnpZSDJCcWg0aDFBTzdpK1Jl?=
 =?utf-8?B?dXl1SXhrU0hVZXVmM2JOQ0dYUExQTVZaY1FLWXYyYjMxMllHTjZobWJoeEQ3?=
 =?utf-8?B?RXV6OXg5VHBJa1BFMnR3Q0lwWm51SERjVlFEQnZLbU4xSjVnV25YVTl4cjNY?=
 =?utf-8?B?aks1em5OT0NHMGJkb3Qxd2xrVEQzVTdyTnc5L0tYZ2UxdzhUU1djdWhMeDAv?=
 =?utf-8?B?aDlVbUplUTEveFZGZ0hraDM2bzVDcEtYUWZ3SG9UTHBZOXkwZi81RHVnd3dU?=
 =?utf-8?B?QUZTVnNVS21PSHAxdlEvcW5DdzdqV09MQUV1ZjNjUWx5ckt6RzdWSzdsa1BF?=
 =?utf-8?B?cGhvRE5kZHgzanQzeWpKc2RVUVp1T1dXcDBVU2JRU2tycm1NM0l5WEY2MFlM?=
 =?utf-8?B?N1V3cDMra0ovTTRydytoM1BwMkliUUpTZGg4U1N4QW9FQlBKSU4zMEdFQitG?=
 =?utf-8?B?RjBpQ3lkbWRCelNaaVFWWGNxWGVtcHFkNi9yN0p1NXJPd1M1K2hJRUNBRldR?=
 =?utf-8?B?Q1lTNkVORCtOenlDNVQzWTA5VDdIYXZ0Z3cxSWNSN2lEN2dkVnJqWGJDbjh5?=
 =?utf-8?B?VmVGOVhEN0pTUWZoakppekpDaDdBTS93ZE5TdG93S3VmdWkxTE9YZWJtYnpE?=
 =?utf-8?B?UmRkSU94dWtYUnNGaERSNHAzQnNBRzRvMW5xeGsrYWIyRGJCRmxpYzNmUUVh?=
 =?utf-8?B?K29leDgxa2pNeGNjbmphc3VpL0hsOWhJcG5zRDQyeWx6NVVxMVAzYUJoUExV?=
 =?utf-8?B?N1VydGxBem42dnZ4Uk5IUTIxR1ZtN3NWMjJmMDFsdjBkN3BtRUFZK0JiRGpj?=
 =?utf-8?B?SGJselRkdmUrZnN5TS9rdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmdSbDR0OXRGTlFYV21qaElMTG5GOVNkNDhJL29hYkhTVFZTRUo0dG9jQy83?=
 =?utf-8?B?UWhIUlVCb25WTG9lRW56VFA4eW1ueFFabThmMmE3aEtCT3V4K0x1Y1JaRW1u?=
 =?utf-8?B?aTFPazIycGZUMXRXZlBMT2pBeE10UFNKNXBSNjhRWFFMRjhOemtBWGw0WlZD?=
 =?utf-8?B?UEEzb1lIOWhxMzAxZ3BwODc1emlNSG1IZkFISjlFWTVhMEZvR3Y2ZmFxNzZ2?=
 =?utf-8?B?cUQxMjhPSnF3VWVYZCs0eHA0YWVlRk4ySm1TRGVxRkRLcWE0eXFPMmpCTm9s?=
 =?utf-8?B?akNwbE1XTWRhVFgvOFplTUZvb3lyYzNpYU1kUVVsM3cxVmlpTnJUcFFFejJF?=
 =?utf-8?B?Z25VMDJCZS80WDN0MzBEcjBhUWxnNlJ1UC9WREMzNmJ5ODF2RTM3bDVmc3RW?=
 =?utf-8?B?YjdQakUrVTdCYjNMVjBnR3hKY0U2TW5lQWpYMkluQklFcktxbzJZcExmVUll?=
 =?utf-8?B?aUs3aU02VkthTHJQVm01TzNjZ1pUZjFOSldLZnBTRWN3WWIyMGtqU2d4aWJD?=
 =?utf-8?B?dkIzQkp2d2F1cmd0TFJpd1NTV2RNSzg0T3Uwc1VLUTA0MmFldFZoNGVPWW9u?=
 =?utf-8?B?RTdXMmJlNGFWVGJ2U2pkZzFKNVNtQ0ZycWthMnlrZ2lQTHlBaUo1a1FjYzBS?=
 =?utf-8?B?VmJWS094dmh4ZW9GZjJlUmlLTlV5VVMrd3R4dzd1OUY2VmRXa2orc21qM0d1?=
 =?utf-8?B?Tm1OVWxZWXlFYnM0bjl0SDdSOEVIRmhabUIxVDVnVkhjRXczRm45MWJ0L0th?=
 =?utf-8?B?S2NlMGxpL21Mc05BNFBCMGlLMjY3Sk5OR29BOUJJdUg4SWNBYWpLdnRibkQ0?=
 =?utf-8?B?b2VwRDNrbHpwZmVuVXpZS3pyVWhCdXZQU2NXZHhTK0RxT0tnRTI1U0Q2QTJG?=
 =?utf-8?B?VUtJTjIrK2ZmeHJXejdncWdBemtoQUFwQ2NNRHd5K0h1NE4wWmZ1ZlJWUnRP?=
 =?utf-8?B?NVlGRzQ3UzBrS0JOR0U5NGxSbktpOUJOdEVsV1VmWG0rT2ZDT01uVEdYNHgy?=
 =?utf-8?B?QXJuNmJTVXROa3c4cUpMQlRUNlJveEh4aUQrSnBNbUFQM0xCb0lYamVYMG0w?=
 =?utf-8?B?eXlxY0tWZVh4K2tjYUNiaXI0UmIzZXdoeXUxbzVjb3hOY1BJSVk3aXNVeG5a?=
 =?utf-8?B?OHZrUUdKZUdpOG56dEd0VUMwamRETjVCQmtubmU5V2RtQXJsZEdJRThzVWJE?=
 =?utf-8?B?QkMyOEo0bTMyQytWS25zdzRuQzgrNk9hN0k2bWdHbm5SUnEwMVJGRnJ4V2RG?=
 =?utf-8?B?aDRXYTRKUHZtbWZMRUZYVjQycVJKamhibm5pVW1YV3UxYURrUlhhOS9jYVZU?=
 =?utf-8?B?K0hFT2VYMm5WN1VWM29XdjJlR01EWTZxT01tbithbVRId2U2bzFQVnE2clhY?=
 =?utf-8?B?MEZUMmVxalF6MkRQYTZ3MVJNeVQ5N2tmbXpIb3loUkgzYWpmOUVCdm8xQ0hw?=
 =?utf-8?B?WVFQVlgwM2tkSjRHejZzUEErcWdEeGtHQmQrVkJuUjF2dnk1Zyt0bEhNRTB5?=
 =?utf-8?B?MkREYnNiTlRQZkFFQTR5a2szVk90enlISDBiWGlLWU9hSmt1WTJGTHhueXBo?=
 =?utf-8?B?cnQ4NTNhNGR0VkJjenRMeWtiSVVyV2RqZkZ3R3VDd0V2bzNNVENkajl5WjBT?=
 =?utf-8?B?UzJvL3BFNFNrVTQ1dzdPSWlEOUVPSEtBNkc2cytwWGlZclZIakRsRWZRZklR?=
 =?utf-8?B?QTVodkRkV09BaE5kMmp1VXgwNTBaMWFIQkJlTmFWY0FBeXk5VHA5ZW8rZ3dx?=
 =?utf-8?B?YjVnUGkwUVVWbWg4Z0kwQVBycHNyL3Zsd1VlTGlEY0N5RE53NEdJZ2p2aU5s?=
 =?utf-8?B?WDBmN0ZzZUVQd1pyaDhGbCtmYSs4dVJQWlBhc1NzYldFeUVNU2lUQzRZd1ZC?=
 =?utf-8?B?M0UrYlNlMGhma3l3QTh2RjBxc0ZYS1BBUmxPNGZTckRzV0EvS3h3bGwxckdz?=
 =?utf-8?B?emVGdmtaTE9YeVdsbTJNMTFNVnRDaW1jbXRCOUZPZGxIZEk3TlJIYVhqa3JL?=
 =?utf-8?B?MFhCeldqaU9NMVJJRitYNk83Q01HaFZzeG9sWFo0bnBidXhvb2F3bzg3Lzk0?=
 =?utf-8?B?UWNCcU8yeGRxcVgzN1pFMGErbGNpckNEenV6bWRwMDdYUWk2azd4K3o1RVAz?=
 =?utf-8?Q?vsZ+eilvhbmKf5sBcm7+GZw7J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd61dc8c-67d4-46ec-0029-08dca7b09ac1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 05:06:53.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d21KpVidzBSwQLOEAxsT0/GWIpHeSh/+W/s+ci5JvUyvjrc5TO2GVJXouNQNtqhJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018



On 7/18/24 22:40, Ben Levinsky wrote:
> There are cases where remote that is acking mailbox message can take longer
> than the default tx_poll_period value. Therefore, enable this to be mutable.
> 
> Added tx_poll_period field while inserting the module to set the
> poll period for ack after sending mailbox message.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@amd.com>
> ---
> v2: Made param a module_param_named mutable arg as opposed to compiled option
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 4acf5612487c..521d08b9ab47 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -64,6 +64,13 @@
>   
>   #define MAX_SGI 16
>   
> +/*
> + * Module parameters
> + */
> +static int tx_poll_period = 5;
> +module_param_named(tx_poll_period, tx_poll_period, int, 0644);
> +MODULE_PARM_DESC(tx_poll_period, "Poll period waiting for ack after send.");
> +
>   /**
>    * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
>    * @is_opened: indicate if the IPI channel is opened
> @@ -537,7 +544,7 @@ static int zynqmp_ipi_mbox_probe(struct zynqmp_ipi_mbox *ipi_mbox,
>   	mbox->num_chans = 2;
>   	mbox->txdone_irq = false;
>   	mbox->txdone_poll = true;
> -	mbox->txpoll_period = 5;
> +	mbox->txpoll_period = tx_poll_period;
>   	mbox->of_xlate = zynqmp_ipi_of_xlate;
>   	chans = devm_kzalloc(mdev, 2 * sizeof(*chans), GFP_KERNEL);
>   	if (!chans)

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

