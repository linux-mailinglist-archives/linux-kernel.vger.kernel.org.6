Return-Path: <linux-kernel+bounces-549943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826CDA558DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D23175968
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1E277020;
	Thu,  6 Mar 2025 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S4Ul2JgH"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B47207669
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296829; cv=fail; b=JwEKHxFMr27B3Nmls9VB972OqikwkEUriy4Xojzl00tUywE8J6qHuOw6peVwGtts3xRUgvtqGYD89XaAeF94HYbYPKHy8kW/iKtAMoUNFxQ7Axydy7u15dRY0cBnaMtJ66KApsCZypzOAH1vnjsIq3LlPVv2tkD88cszkCfsZFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296829; c=relaxed/simple;
	bh=3R4yOwOwx7w1vHBru2BeJGGFvBxwPSibdBewv9BIuTc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=igxnmZjAfrQzuuDiEVuKFkvSja5ERrmRLqZShsRrlERczzrd5zlPABGG7OFEWGxjbXY5mnAqoKfjEuCmLPORFf5Dj6amvdos/E9f1q7XUGxFSouqgqp66hTRG6S3YnjbL8GoAcCD+T1eUNzlC59WFqOC5ktQQme+bckPm/hgdSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S4Ul2JgH; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDhGNMKXVWG4MhCbaDSR3Ft1a/zOvIinBOm5IdrctSi0sZTcW2cEXVYOEEAyBhCm5+ZEsxzt35I5KY4EszwsCrAkqWBz/X6OOHXF+zRER5zXNA4kJEuZh6BIr/W3g6D4KOkgcnys+8WBCajVPGyAMEQBBCKVWpm09tEvczc7ajwqwXwyMAubbPXqVhln2cVajnk7lJ7fWpw6mdfegD2/Vh9zbW7lxKBe60k0upFfO+Im2Aj6griqNwv6AiuR4X2ikn2l+3JeBWmiOxOpKBicmwv7FFhObZxyKmca1fkF4oRKowqaIZQe25EVYreLD44Fql2IILZDmohU7lfka3QfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R4yOwOwx7w1vHBru2BeJGGFvBxwPSibdBewv9BIuTc=;
 b=sV3SaiJkN5qZXclYOl0YJg7U+lybqI7QT3OG+sf4op1QxU8ths8j/uWmr7u9JyzlGUj6Yn1jTWJyL5YXUFNfcJjicdEaD5pdI/8rUmkEfm2UkblBicpdnNoYhWlRVhi/0Y9s+Nz6hy0/2fD2jzBT+4YHeIgt3JbGZQuK7AmLVWzCGgYbqK+EoyqsmpkIP99jOxGCnwG2zb5w+ao2ggrnL34U2mh8+XGrxnYEl8lktrRNU3lbqCdw9MyBRkmI5RJhNeWefV80yINQfIyE/DSJI7UmXdDfndAF6YCX9gCsEP6q8LyeAkeBuKobmjDIi80jqZoxXWaf7vhSG2B0Iait2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3R4yOwOwx7w1vHBru2BeJGGFvBxwPSibdBewv9BIuTc=;
 b=S4Ul2JgHrlsb1JlcCHLu84PFcUwfvLwOSXReMsCVfeRTXn/uURD28/pfEa3R/ugS2yLsWnueLHlg7JnQzE095+WAqSy9+kHB7qsKsHe/6YjVc+LgfISDVyobr+YA6tjiWBIHM3XWiI/KZkXGQduxj8PnVmjbV7Sa/kQC0lEM4FUBg5B17wp1ZKEIA/Qvb5HgW7uHE33QrA8Y5Vrq9Muh5lrI7OvRF3qS7SsjP4Hx5JenemEmMjeFgWRPr4+vxqbNNl9iw1NDEurgqtG0HjpI2A20N5ehtrnqyJN5RWHflNo3dNnQJGKJHUF+AsFYA/WgM4GozB7rLJdCYN5oR35baw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:33:44 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:33:44 +0000
Message-ID: <d2732499-e0c9-48da-89d7-eca2d491fc2d@nvidia.com>
Date: Thu, 6 Mar 2025 13:33:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/49] x86/resctrl: Move mba_mbps_default_event init to
 filesystem code
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-22-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-22-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::30) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 18433e46-2c92-44b3-0173-08dd5cf69230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YURUZkR4MGxEVmwzQXM0Q3VPTE5MbUNzbHh6eHZ4QWFKUjZlU2pwYSthcEtw?=
 =?utf-8?B?RkZwR0lhOCtob20wdDRweVhMZTk2aUtvL1F3cjJVNXROZUx6d3VmY2ppemxp?=
 =?utf-8?B?QU9BdXF1cnFGQ2FMN3NyTVRUbW16ejl2eUNWZ1k3SWVWbUJtRnhhekUzYi9G?=
 =?utf-8?B?NEJwL29OWkRoUzN5aFBhQ1dWWHJiWk9VVWpMaTluT1RqbE1IaE5YZ0h4U0RN?=
 =?utf-8?B?aURlV2ZsZlhtcmZ0ZzFQczNnRC9yWmV0T2hBWjhSZGlEbUEwaFR0cm1JWjN6?=
 =?utf-8?B?RzRQVnNFSUszYmYzcldRaTAvbkxJTzQwcTIxazEzZkpLeVROQjVOdVh0NElB?=
 =?utf-8?B?L0lQcUZnVlVQdU0zNGR5ZGVPVXo5eExwMkFKb1B6VWgyWXdCRjVnSm9TdTcr?=
 =?utf-8?B?VUFpZUJlM0lWZnVuSGVlMitBbklVaXRFdERqNXBheFhrSVU4OTFDZkNDVmNx?=
 =?utf-8?B?byt3Q21ERklDSGVzNU9Od1NKR0FBT0pwVGJkbHFOSzJQSitaZjNObEFmWWR0?=
 =?utf-8?B?SWFyaWdBelpwRVdtOHFwNk1lMGFVVE5Gb1psSitQZjhPc1RkdENCQUJJZ213?=
 =?utf-8?B?aFplUTlWVWorQTFuYVg0aFNjbjB2bEJKa2Z3Rnp2NzlaU3ZSalo5TkVkN1ls?=
 =?utf-8?B?NWErNUFYWC94eWE2VzF1UW41VCsvTzZnU2w2WVVYaGx0eTgzdjRiakxaaDBJ?=
 =?utf-8?B?SjRLdEdwT25ZQWpzK25mS0xNc1MyVjljdmRLdW9QZ1VWQ25nbHgvM1FLT2s0?=
 =?utf-8?B?aDJRbUh4ZS9uVUUzM2pHRlNqeVpSYTFnRWNUb0dlbE9jam5EdlA5Z1FnRUlB?=
 =?utf-8?B?d2Z3aGpJU21PakgrQnRLSyt3OXQyT3IvVGEwTmZmQkQ2empMaCtvdjNaR2Vq?=
 =?utf-8?B?eHk2YUxSTE5MSmo0WEttTjFOMEM0NEZFTk4zNmdrTmxLVGVrdTZLQ09RYmlh?=
 =?utf-8?B?QmlDMWRpSkd6RnRYVXVRbFo3K0RoUURwSEU1NG1Ya21yZk9oK2NhMksvankr?=
 =?utf-8?B?eXpiUzJwRnZLSVJpN3JqTHNtYTZxWlVucnYxSmtwd3g1UXpNTld2TGpQQ2Rj?=
 =?utf-8?B?Ym11UWg4ZkhHdFY0SlVLY2NiUFo5aUp4RkQ0SG9tUXRnN2JWNXQrY085NzhD?=
 =?utf-8?B?enFFb28vZmk1cm0xMy9RZmppb3k4cVVWZG9jWGthaGhyL09DczVpcEltZjlG?=
 =?utf-8?B?K0pmRmtLekpkWVg4bklZREtJbkVGVjVYaHdEVjBiK2lWUG5YUStic3psdGVU?=
 =?utf-8?B?c0lCTUM5L1hVS3BUeDkyNGhkdVVONk1JNVI0RUJ0Q0w1L2VyVFJLL1FKWUkw?=
 =?utf-8?B?WWhGRkE0RE1GMWFFV043YVFBQ2RSUm0xUUxBaW4vdFUzSXpYakc4cXd0ekpM?=
 =?utf-8?B?SnVObU92OUtvTnk2ZUQ1aE9lZ1JqYUFIWW5ZVUpXOE5zN1lCc0UwbTVrdTV3?=
 =?utf-8?B?UW16Y3NwUWNUdXlyT2wzVWFhaHNRTVVxbnlsRE05RkVOb1FqblY2b2VGM2Y2?=
 =?utf-8?B?MjlERHNBZlgxYjZvVy9wZ2FudUNVTld0VmJXRldRZ0V6SysrdWVJNFBhSmhs?=
 =?utf-8?B?M2d5UmRLRDRCMXpqWVNmalFXdnpTS3Mwblh3bWtnQndHazBZQ1dIUytsVkNh?=
 =?utf-8?B?ZXhicS9VNGFDNVMvTTZEeFhFa1FBajUvbUlJYkROYnlrN0tqQ0JrM2V2eUJn?=
 =?utf-8?B?eDNPdlcyK0xKbVp5OFF0MG9IQlFvVytJRGVtbVE5SzNER3JyM0tNc3FxWEtj?=
 =?utf-8?B?WklFZE41bUlIMEJWQS9iMTFMSGgxMnlFamhHb3ZKWmxvNGpja0lNeVNLSTRo?=
 =?utf-8?B?QmtwZjdZTFBNTTRKUXVCeWdoNnQycTJWZFdCMGExdUlILzFJVjV5N3Z4SEZj?=
 =?utf-8?Q?Do1maBojT+6mt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVYrTFRWY3llVmlhZXdXYXEybndzcU5HOTk5ejNoMWVVZ1daVWszUTFFZS9t?=
 =?utf-8?B?ekVDUFBZNGRnNVZrWWo5VklvekV1YjVLUFVQa0prRlRpQXBkdW5mRFN0Yjht?=
 =?utf-8?B?L1FGUlRISmN5TVdmQnYzcjcwYXM0RUVvdUlITlhzZmpiU2kwRG93RW4xakFY?=
 =?utf-8?B?VjFBT3B3cm1PYlRReFQ3QzZabkZFR0xQSFNBazFuelFueTBkbzd3OWt5UFlu?=
 =?utf-8?B?aytaMWNLT013R0lyZFkyRnBuV1UvMmZDZHJpNzNlTGFQeCtXQ2xuTUhveEhq?=
 =?utf-8?B?YkZrNS9XWWEyakMvbVFDZzlvYkFGRXdleXJ5dnNtWCtkdldHbzdzUVhudkNu?=
 =?utf-8?B?Ui9sMnhsZUdTUG0wU2JKV0tBWnhVeWhDOFNtRmo4VnRuY054TDZoMzF4RDha?=
 =?utf-8?B?WVRMUERlbENtVVZZNHRRUUpJcy8yUk1vVTVZZm11UzR3THBNVEVhdkJIbEJV?=
 =?utf-8?B?V2E3K3ZKemtQeEhhQ0xva0w0c1FqQzlueFBsbmwyZXMyRThHMTMxRjhBTGt2?=
 =?utf-8?B?Kzg4Mkp5eWxRMzFzbFZYR3hHLzZmTlUwRGxXSTU0L3V4UEJhMXlxSFpHNGgz?=
 =?utf-8?B?R2xiWGt3T051M2VZdnBJSnprVVloWElKY3NzeXBJakZIVUR4b0dFelR4U3ZN?=
 =?utf-8?B?eUVpeXhFUUYyT2llNm1XS2JnZVpRNTdHN0hwSVRWS0ZyZlY0NzBsR29FWElZ?=
 =?utf-8?B?NWFoaTI0bFQyYzZrR2Y2ZllQZmRiV2VXb0ZoeTZqb0wrNHk2enJYQ3hoSXFx?=
 =?utf-8?B?Ukx6WXhJTFlja2xubUsvTlZHUnJOQ3BzRk9WMHU5bzVDL2tpSGtINUxCM0dm?=
 =?utf-8?B?Y280aCswZnZhdXF4d0lIRUpDR2hDYWloT3UxaTNUTjljT21wOVI0VFh2YkQv?=
 =?utf-8?B?enJVV2l6czVEenMxcldLeEdBUDdZcGlQWktmcVBMdSs5aWRuQ1VTaXIwK2Nz?=
 =?utf-8?B?cFl4anBubkRtVVF2VzRyTG8xemRsQjRnNUxGVUd0TlphZU1NSXIzSnNLbGt1?=
 =?utf-8?B?YnNteVVya0NJOWpnL21EeGNYUDNDb1JJZ1Rzb2poc0ZEYmlKYi9wMTNKZXZh?=
 =?utf-8?B?clpTNEhDVGxDMDdlL3U4ajB5ejJTNDdUZVcwbXQzZjl1d1hzQzVWSWdFL1Qr?=
 =?utf-8?B?MkhjRU1ZcjVFTkNJdGExQ2NhemxWeFN0N3AySUVRcnRUcVoySzlwWWV4ZjZ5?=
 =?utf-8?B?R0RJMFNHWTZHNFhxNGdVZk5qZ0ZPd1ViOUVjemY2dXM1MW9hMWJNNEErOHpp?=
 =?utf-8?B?RERvbkhMdlg4MzUxRnJSVk1NQUtYbkVSVFFLRkozR21HdjJ4TmJuVEJWQm5C?=
 =?utf-8?B?YkprOVZGMHpjaU1UUTlEemNMQTNjdWRaWjdvQ2JKcU01cFc2U2crazVFZUVo?=
 =?utf-8?B?OVdmbXBUM3ZhVmc1Vm5uandyTk8zbmRuaCtQN2ZYVTRabEwxT1hpRWVadTlK?=
 =?utf-8?B?YW40R1ZiVGFWVjMxUHd4SldtanoxMUFYUkRyNnlVQ0JiUFFLT3NGTmlZSW8r?=
 =?utf-8?B?YVRjVmI3ZStWV0hOTXVZSTJkQmdVQmh1NC9CK2FWZTIxQytIUFVoSzVXZFl2?=
 =?utf-8?B?WVpNbUJ0VnRqSE9WQTF1SEVuVVRSQ2FCOTRlK2UrcUZCRE5SenpySFh0UzN1?=
 =?utf-8?B?RGd3RGZ6bkl5c1V3UG8zNisyQ1ZIaWF6YzFYUlJCZVRCeHBRNzdoOTU3OUUw?=
 =?utf-8?B?R1JBM0I2Si83eFBBZzEzUE4wUmd3RTNSZVdaMCt1N29kWHFOZlRrRUVlMGcz?=
 =?utf-8?B?NXdQQVAvb0VxeFYxRHZTeHoydTg4bVlZK1A3UDArT1dKNUw4aFZyOUcwQytt?=
 =?utf-8?B?U2NMM2N1Tll3Z1pXRHFPV1dNdS94UXBSb2U3cVUwYU44eUNpR1dFc25sbDV2?=
 =?utf-8?B?Z21CYlJFUU5lQXNlS2VZMUJCTDBWUmlCcFlNTWNoUGpoWW1ISEUrNkU3cmZN?=
 =?utf-8?B?WHdHMzU3bXlLOUM0NlRxOVFVeTN0c1pxM3N0U2tNQVA1eXExQzlZRkh5VGxi?=
 =?utf-8?B?QnkrTVhGMjZOeVJLWW5xdGZUQzR5cGVuVUU2dmNNcFgySXRGbmtZVDFzUmJm?=
 =?utf-8?B?TWZ4b3p2QkJsdlJZUmFUZGlZTUYvZ0xlRGpTUHNJQk9Iczl4bVVvUGhUYTls?=
 =?utf-8?Q?RkW239GQ8mFzLouL362eTcaM4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18433e46-2c92-44b3-0173-08dd5cf69230
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:33:44.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBNdplMtfA3iWqXHMHFuJ9WObOOXOvBBqV5SVUY3tqQHRZOgnp9o3lBGkfiJKaImDCJrJdWHuQq3+m/dgC19Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> mba_mbps_default_event is initialised base on whether mbm_local or
> mbm_total is supported. In the case of both, it is initialised to
> mbm_local. mba_mbps_default_event is initialised in core.c's
> get_rdt_mon_resources(), while all the readers are in rdtgroup.c.
>
> After this code is split into architecture specific and filesystem code,
> get_rdt_mon_resources() remains part of the architecture code, which
> would mean mba_mbps_default_event has to be exposed by the filesystem
> code.
>
> Move the initialisation to the filesystem's resctrl_mon_resource_init()
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


