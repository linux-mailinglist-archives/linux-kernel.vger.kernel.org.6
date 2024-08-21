Return-Path: <linux-kernel+bounces-296017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A83395A465
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132B6282BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F551B3B03;
	Wed, 21 Aug 2024 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mjELq810"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51D1494D1;
	Wed, 21 Aug 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263727; cv=fail; b=SsQlcqkXOvNemPy1KF1Y27JZMSR0U+o3njIVKqHyRCMDym8pmffM5zZxtq3878z05p3LnVJpRoom0BQH2HxRLPmH80Xdp65Wv7u8klj9Xa6IEWWr+nOF9kPiz9Ss2if4xFygt+LabkWnnkWGIzzAGHDAJ+4zbWB/7W2tyz1494c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263727; c=relaxed/simple;
	bh=Jj0MLZCIR2KbAIlfEZ7Z3e52wOkUmskZaeT8IMOav0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BrzUOgDuaxb1lt1MwzHOXfZ5Q1xwc84PNf6QT1nuXyWr705gjZAQerH3C5HPpg/JG65OBCJqpkZBeftsePZc4ny1FOkNafU2ylN2f8FCDihPxoB/2QHMeB97RwnHnfWppBfGzPp+3yuDWU9xy6RdqvyzJ3G7N+TUxhIdMO04K4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mjELq810; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arhcCboU80WbKhCK4anc5uhcg8fPErFUNjeBFEhtp5pMuP4CVfhgc6fLqyCL3zFJxo2f0AJfokZX1JOmZvOAd9m785nqGyYEyzQ8EBqL9ICnbnRN8N5LKZjm8HEZDXiucgYwl/E2BxHZAdBH2kQby8cCg2zRZSDHWY2w8X5ONw552/1IBPKd9ePbNnEgEZbYfKdoz7/iI/jW0Y602pGHYXaTxFfwSAguyDiJfmuG11iyNdPj/B4OvqM8VW46qlyOm1mYmflRB6+5ZWiIIs0oKq6qmaSxBVM4qnvFh5vmIWTWYhrlqd9TH7dqphnNbFhPwRysnMQ/y5kzDGrwGbZYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgDbBJI93G0IumE13NZ+lPlZhHIVIQvanfzbu5BN/hI=;
 b=vYa5of1pI+LpFK4N1Qo04zN9yewq7cVjcboJiJ0q41PL5cktZ/KbwsTh8QAseivpCGLjR5F/T+PJ92eQwOrGVa0+JwYBWkPkNFLGiKadTcg16gHH6Vr4qPgFIyxmKQ7IwlJlo4mE2znzxAEI4B8O55bPe5T1nh5sriy9fsN24a15f1t7hnG1iM2bj5Ivom5B3o4pMSAR4zRf6+ljGJNsDXzfm8r0sRA5u+LWpKjT/hZref4MsZLnPNoNzusZufrWGyh5jAe1HfRfvgNr1FyCbr+mogh3ePshDUFDmbTLWQStRnTeIK33YcWnGFYV9WmhqZRGrSIVQZhJUIck1sQqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgDbBJI93G0IumE13NZ+lPlZhHIVIQvanfzbu5BN/hI=;
 b=mjELq810kQ5D3q3weLTxrIDITwSR9lVGhB70yVb6+79saip8Aowfd5waqDTTOvbyXPx4yw/pVenAwNt0XRY0Uo4UnBeS//myc2jKwiAmqLCVE68GQwAdGvySUlwbeA+ZzZ8zaMXlqJJZxnZvANT6ev4IYJk6BZsUgIhxiVgEpX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 18:08:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 18:08:43 +0000
Message-ID: <8b23eade-9015-4d40-b9f9-f7cf5a9d08c6@amd.com>
Date: Wed, 21 Aug 2024 13:08:38 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 19/22] x86/resctrl: Introduce the interface to switch
 between monitor modes
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
 <ef586a11-5d8f-434f-962c-6893ae4668de@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ef586a11-5d8f-434f-962c-6893ae4668de@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: f8552abb-68fe-4d07-6d78-08dcc20c4ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUd3SmVTRk9uK096N3ZYTHN3N2p6RVgyaEdFMitENERXUER3eHJ5RmYrR2V6?=
 =?utf-8?B?Y2pOdnYrQ2txNVhTNExlK2w2QmU3dXFINzRjYmJ6dXF0WXg0bXFYaStBak1j?=
 =?utf-8?B?LzQvcnpwOUh0R0VEcVRlbXoxVlY2eVhUUjY5enlZZ1NpMnF6NzYxR20rU1V3?=
 =?utf-8?B?eStJWkYyY1BCWncwem5XaEw5TVlzYWpGNW1NN2VWODBwRDVhRlcxSWMrSjk0?=
 =?utf-8?B?RG0vYzEwTVZUcERyVDEyQi85OE0rcFJrUmhoZzAvdHozYk1KTVc2U1U0L2ov?=
 =?utf-8?B?Y3hYR1p5TzRqdUx3aHNHL3h3M3lUN0VWOEJaUXpZQmJaNGJORkNzVjJKQUlF?=
 =?utf-8?B?QXRNY0JLQXVUQk9wclNDSEVRUHM3aGFjdnUzUVBzYzFlM0tUNmhCZzcwM2xs?=
 =?utf-8?B?TWRJRkxVYWJZK3lIdEJ1U2JFdllUTnBsWGU4NHd3SEZudGdaSGxvSENpbDNT?=
 =?utf-8?B?RnRsTS8xS0h4M3RudHZvMGs3THVOMlRLcm0xRXZOeTFibEFCQnJBZjcwWmsw?=
 =?utf-8?B?UEIvb1pCR0ZrdkpVTmxsanN1eXZGbFEvY3RGOGpYbEdsbjVyNHZhTzNTbDVC?=
 =?utf-8?B?TXpNbk5CVGJzK1RidWh2Z3FmUlpDNHJReHF4OXkxZ0lnRVRGeUhpSkZiUURH?=
 =?utf-8?B?UmVFMmU1TzZqYzc4UjRPNjVEWmdIVWxvcVBlYzRLYkJQSmFITktUMzQ5eXU5?=
 =?utf-8?B?K3VtUGdMWTRZeXI2blFqeUptYTcwOFpLK2dnYTBzamM4WDlVN1lzclVoZlJu?=
 =?utf-8?B?TExQL0lCZlFXYWwxN2VncFV4VVZVa3ZCdklpbitmWDBXQmYzWERjd3RBajhC?=
 =?utf-8?B?dlRYS0wyVFVIVU5nNzJBUUM2QTRKdDZDNGdtRDM3QjhPc2kwMkVrT2ZQZWNu?=
 =?utf-8?B?UEZaN0sxSmpQbUZ1Vlp1anZrMmdaZ3RGS0s0SUNOVElWQmVPdlp6TVpWbkE4?=
 =?utf-8?B?Y2h5VXROMzRzY3pLeC9QTUNTaGcxV0xrMno0RzVGS3hiMUlXV2drVWxDVkts?=
 =?utf-8?B?WHF1bWVGRjVwN01IaVRZWk52dzlZcXp2M2ZaM2p5Mk9UZzRkWjdkTFVPVitO?=
 =?utf-8?B?dEVrUXV5SWVISlh0S0YxZUNESElxWnlkVWd5cENMYitUeUV1NGRrdndvaU9a?=
 =?utf-8?B?c1liMFBtand2d1RrZDZLNVFQdUpZVmdCL0xTS1FxL0xjNzZVR3hwYnlpNGN0?=
 =?utf-8?B?N3ZpYmJtOUo3MEowUysyN2tzMHlJVEt2UVRMcGhhVjZPRU1FQ0lrOEhvcXVR?=
 =?utf-8?B?M1N0c0FqSWtIOGFmcU13cWlndVBKUStnU1pGTjhWamVncStNek4xRW5wZE9i?=
 =?utf-8?B?elgxMzFkSHJuRVpJZE9DTzF1T210OFFzUUxpbEx2ZVNtOVdzNVAwOS94ekYw?=
 =?utf-8?B?NCtUd0NRenBnYzlzMGcxU3h5enZqSjdFbGlobE9LT1J1THY1ekFFdGI1dWxv?=
 =?utf-8?B?ak8xRFFMeVd4NC9NSTlYV1VpcmdIZEtqUk1Qd3lMbnFmbTZlVUh6QjJVTXJD?=
 =?utf-8?B?aVlvbEFLdWZVQ2tVak5EWkxpYS92SmZvM3hvZkdqbHNpTnlQNTcyYTAvdXFw?=
 =?utf-8?B?TUxmS2FlSGV6UzlURGViaFcwdkx2Zll5T05uVDMzdlM4UC9sNklIaVFJRU1s?=
 =?utf-8?B?bDlhTnkwdFVmUUdtbFVmMGQrQmdxSHJON3ZVZHpQeTJ6Y3lNSUtqUnExV1lI?=
 =?utf-8?B?QURxMnVqRlh0Uzh5ZWh2dmx2emZYVFQ3L051TitVYVgvMGcyZkJVWlNyQ2pz?=
 =?utf-8?B?VVZseCtDUmNIMXZIK1l5N2RhNzJEMEo4ZUZaS2RVYlF2TDc5QWV1VDN2VGVa?=
 =?utf-8?B?OEFmWTBNai9nR3VQTElPdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHpmbWtkbkprVTlkeENFNUdtU1VhSGFpeFV1d1FkN3E5SzF0WlFxMmJ5UWpW?=
 =?utf-8?B?alpKU2lNeXFrVWtNSEUxY0ZPbXluV1pVRUxWMjVqbXNLUXoyanUzckRsUGRt?=
 =?utf-8?B?MU54UjlPaThqNzBpanZqbkJyTUtCZVlqanhQbUUzNGxGSHhTb0hOVGVlZFQx?=
 =?utf-8?B?SmVJTjY4Y3kvdUlTWTcwNzlkR3JUYmZnQUZEVlJrdlBsamZBcUQ0S0dKY3Y0?=
 =?utf-8?B?dEcrcHpwRkZ0NnlKS3h0eEtJQWF5c3M4MVZWZTNXSk1ZUm9CdmU1WEZLSk8x?=
 =?utf-8?B?ak9WWWhOL3BUZlZxcXltOHZ5MkkyT2hmdDRnVVdaR1hYRjBsUllwSnpCUFRn?=
 =?utf-8?B?NVBjMWk4bmY0V1IycVM0NEVaTzY1S0hERFh0RzFodTY3Smt5ODA2Wnl6TTA4?=
 =?utf-8?B?c3hUREFHY05TcGFZU3Q3czZmYTlidmlUV00zZzlhaHVOeWwwb3daQk5nbnYx?=
 =?utf-8?B?NENYdlFZaWc3VjlaOWlwU0N2QlZmMncyeWo1b1Q0Y1dCZEJ4TUdDekVJYkxv?=
 =?utf-8?B?aDByUnFLNi82dzZHUy9Wc2Q0QVhLb1RPdmRPZUMwRGt5b01uOHBiUkhWZml4?=
 =?utf-8?B?Vkd6YTNmendqaVhxc1VHWmlKZzN2bEhDMHB3Uk00b2lMVkNYQW1Sazk1WExH?=
 =?utf-8?B?aW9Ta2hOUGtTc283RWdDblBNRWNhNDFlTW4ySEQzY1lrdG1yRDFtT1d6Z1Js?=
 =?utf-8?B?YlNKL1VSM2s2RFJWRkFWK1RXb2dPRnJrbm5qeDVwWE1TeXRZa1kramE4UjFw?=
 =?utf-8?B?aTlldTdLMSthSlJ1SjVZM1BRSFB4RmhrZjdXczFtTXo2L3crM3ZqSjZZb1VM?=
 =?utf-8?B?VGordWxSYkVRSVVRd2Vud1EzS0drWGdYV1BVZ3hrSTdPcUF3ckMzcmcxaHNR?=
 =?utf-8?B?a1BoSEowcXdKNnFST0RtSDVqRWM4dkUraG5ISEdGbzNacXFDR1d2cWxmTnha?=
 =?utf-8?B?ckVyWGwvZytNcDN0WkRYajVwZlR5UlNVMjdhNDJqSGpLQjV5UUdZR1F4TFpV?=
 =?utf-8?B?ZXlrSUgwN01NRzEvMVBNbXhUT1RJVlJBWThGM3M5dlNKSEp0OXo4V3dYUWdk?=
 =?utf-8?B?Tyt3SzgzSFBTL2FwL25kc1hmci9sMVdBbWczMHhtdzIxcEUvSFZYRVFYRDVB?=
 =?utf-8?B?dGhBaHhzQ1cxdHZUWnVTdllPM0Q1c1hBMzRLZ05LMEg5U1hlN3dDamdlRk9s?=
 =?utf-8?B?OG1oZU52UTY0UXpXZWlTV3E4eDNkUmZ4MFFPQ0pxb3c3TTlWQk5OWEtjVExI?=
 =?utf-8?B?bXhqUitjeUhLeVhjd1ErUlNpRFB6QllUaHJPSDNIQnZxK2VQMDQ0bWwwdXpq?=
 =?utf-8?B?ajFUQWtZTHlWUFEyUThoOGpHUGovRHNuOElDNDl5MkxFMHpqVkQxd2NUa1By?=
 =?utf-8?B?RVFWYmt4aHRvVmdhL0pwaUUvYTdST3J6UWlGZjdTd3hERWIxd3ZUb2RBQVoy?=
 =?utf-8?B?LzVPVlJ2Uk5QK3ZtY2FGYzhYVEIxY09CeEdFV2RwdEVRRjlISTZFREpKcG1T?=
 =?utf-8?B?WGZPZnF3VkRiWkk2UGFGOVVaUlhWY1VZc25CY2d2QTFPQkk5bVk1UHZ2NVlO?=
 =?utf-8?B?UW9ZbUJkV09zVGlLODZnczJXekhaZS9tK3huYTh4TUh6ZlNGMmpiejlablpa?=
 =?utf-8?B?c0NyTGEzakU2d2FQT2JkK0lUSVRsQ1E5b3ZRczQ5WUhSa0tZbkd1RkU1U2Iy?=
 =?utf-8?B?UkNwMWIzUzlUelZwZ1poNU1hdjcwY3VGNzlpV0xSaWg3b3ZaeS9ocXVXLzBl?=
 =?utf-8?B?d0lkVnkyL3N3WWI3MmtJQTEydlZKN3dhdXczbU54b3JTcTc2Njh2cWhFR3RR?=
 =?utf-8?B?QlpSOFg0bDVXM1dZRTRqWklBTm1VbzJ3RUowWVU3VWhFOU9aWHo2ZUQwWlJ2?=
 =?utf-8?B?aENZUFJaTkEwOStWNVBxbjJveGRCQk5VVVlLZVVBTlc0aDM3clN2cEZQdVJG?=
 =?utf-8?B?ZkNzTHRWTTVrbmt0Mk5Ba1FLYWZOYjdXVENlNGJJektpK0N0L1NtUUlOVFg2?=
 =?utf-8?B?TFprcDExT3NrWE9QWUt1TmU2VWNVTWl6T0pPZEZZQ2JYQ21zYnU2Y3lNdk0z?=
 =?utf-8?B?N21wdEgrTThPWFJQc2VETS9wSG4vQnNIbERSMkxpVFp4RExtYWp1dnk3MlFi?=
 =?utf-8?Q?sRLs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8552abb-68fe-4d07-6d78-08dcc20c4ae5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:08:43.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvoOlTtfuMLTN8szDreAgMgZMQSDQSiN2KjJKWRtCu9hPXtwBBHMymBNf9XP6EuV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293

Hi Reinette,

On 8/16/24 16:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> +static ssize_t rdtgroup_mbm_mode_write(struct kernfs_open_file *of,
>> +                       char *buf, size_t nbytes,
>> +                       loff_t off)
>> +{
>> +    int mbm_cntr_assign = resctrl_arch_get_abmc_enabled();
> 
> This needs to be protected by the mutex.

Agree.. Will do.

> 
>> +    struct rdt_resource *r = of->kn->parent->priv;
>> +    int ret = 0;
>> +
>> +    /* Valid input requires a trailing newline */
>> +    if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +        return -EINVAL;
>> +
>> +    buf[nbytes - 1] = '\0';
>> +
>> +    cpus_read_lock();
>> +    mutex_lock(&rdtgroup_mutex);
>> +
>> +    rdt_last_cmd_clear();
>> +
>> +    if (!strcmp(buf, "legacy")) {
>> +        if (mbm_cntr_assign)
>> +            resctrl_arch_mbm_cntr_assign_disable();
>> +    } else if (!strcmp(buf, "mbm_cntr_assign")) {
>> +        if (!mbm_cntr_assign) {
>> +            rdtgroup_mbm_cntr_reset(r);
>> +            ret = resctrl_arch_mbm_cntr_assign_enable();
>> +        }
>> +    } else {
>> +        ret = -EINVAL;
>> +    }
>> +
>> +    mutex_unlock(&rdtgroup_mutex);
>> +    cpus_read_unlock();
>> +
>> +    return ret ?: nbytes;
>> +}
>> +
> 
> Reinette
> 

-- 
Thanks
Babu Moger

