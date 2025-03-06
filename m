Return-Path: <linux-kernel+bounces-549935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644FDA558CA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC183A3370
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AA4207669;
	Thu,  6 Mar 2025 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CIjqEGDt"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2214249E5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296637; cv=fail; b=f3+XFHECVX2EAPQGi2nsYge35qb4mYQcssWoD02eQVznprS9WaxOiH7AXJ7QeIUgvTKCF69YrAzWcQbUtQXhh4pKgy/Cl0F2+ipuqS+KbteJBsVCsw8TATxrVuY/+GO2O4HWJLTr/RbouKKJOfeo9GA4x5YIN/GavLg0RWR0T2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296637; c=relaxed/simple;
	bh=2DLxa1FpBL7DpMul8eOihgn+lj0B3c79c49EnC0WZvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=klQWB3PeRRxVaFTP2+F2/Q9lbBlAzlljlCnBY4il8rDHdIa3UcZrJmM+qCXg7uOfABNglcLiyuFv58IO+Tcto8FkcDtz8TswuKce/jsQfu7OJIl4QpjypLy7bQh3UiOHh38FogpL0g6vfX3jUYBJ37PeNUr1BrYXBH9A9knmc2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CIjqEGDt; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEAi5cS8kIGK3LMC753sAnE0HlFqkDSeipCm0+BSE6JtLDVtUV3ppFKUGb6QQ4MA/XtWJ0U0BTflDD6cRqbqm3CiRZqD6y+0xuKSoppUOIFK4H9cQ+yD6xpy3RKZrX6T+ZdtKBWeu//QDQBcEHr/3yraFWvdSghLzOGtMsjTevXcb3FUYxZZwq1sFEVwmK7sZXOLLVHn8F556Dk/FY4OxVVjLelrJXT4tmShgGX9Y9xlhvThfrTSQD3tYGMTxMmwyoDXhOogregxH+9cSzsY8lMwoR4gXEVEFH9wylUpkhCOTbmZmUongJdgkeaV0kfAnHWRFP6Uj9ErPXAeP1L33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DLxa1FpBL7DpMul8eOihgn+lj0B3c79c49EnC0WZvQ=;
 b=sAedFsSbKV3ocLsCJgHTn8Na63eZfuvMxp/DjylqD4XsZbI1ZVuIVsQNURFAGbK0c0sItMPmNMmYgUAyHRxDmZnWrW+W2LagAJF9fA08J6gWlUUziDnnVOGFTiBS6lOSgoIaoCVT4dfx94BzwzCTmSakGR0sEEYv1DaEjbuc07zQAE2VqOj3oLVygqOmCYXQkbhBQbACZEBG6qbyB2c1GXG40TRDHEO/mYukwxc6enDZ7634V2R08hD7ErURlXOI6dYhwpMVfcBvLO1/OXrBJKdm+1CqCVPaeMfu9XdwpkgLtfTy0zbNqe7ILA5Dr1U7jZ6AvioqRVpBnjFEW+uGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DLxa1FpBL7DpMul8eOihgn+lj0B3c79c49EnC0WZvQ=;
 b=CIjqEGDtlWtTSnaDNgG94vPeS0jV38Bm00lWfA2G26LRuN1o0imJAAH+gMZIigwOeig7GHeYmUpgMZSVoPmJaZaRNnWYz6CEY4y3o5f90tqWe+3MyfsMpXS2ty1o3Vqi9s5dMbrY9GkEicNIzMLBU1gaD01nYUj6z7CUFdrjJC5hmuz7kUoGDwgpzb+spOiV2EMIGuucB+7e99lHraFcKLGClTc69+9PdiRYhu0TxhN2+0qbt4kwiGTO4djF4j3ANGbuNo//ymQO6uRoP++4C/DaoXf0UQuillyw/4zqkVlvviLIgYe5NWJLsNgQ8k1NfVmelws7IEl+PCM9A7YIIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:30:29 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:30:29 +0000
Message-ID: <7fbfe391-fa65-495c-8507-9b6fafcc098c@nvidia.com>
Date: Thu, 6 Mar 2025 13:30:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/49] x86/resctrl: Move the is_mbm_*_enabled() helpers
 to asm/resctrl.h
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
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-19-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-19-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::25) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 727df1dc-6dd3-49fb-bf4c-08dd5cf61e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUNnaGI3ODh0Z2I1Z0dkTzNidWtpLzhLb2hnZmduLzZpb21qRTdUV0lhb1ov?=
 =?utf-8?B?MnBtaWl4ajlxSlVwQytCNEpTZ1UyNzRLZ0lMM2Y1QzM5OWJOOFF2RTltNzgw?=
 =?utf-8?B?dkZZazFrZ0FJK1p2MlJFejlOaHBSM3hlS3ovMVVDVjRSUktkVlFSWGRCY0pa?=
 =?utf-8?B?SGFvb0dlTXhpdXcwZTd0bTc1dDZnbys1NnhmaG02dDczMHZiRTl6UmdrRmlz?=
 =?utf-8?B?K3YrYmtoTCtacHhOVnZTckZiQ2xFaldOeUlydTEyZ3gxOFhTVm5KQUxOZzBL?=
 =?utf-8?B?bC9rS1dMUTBBNEhkSk13VjBnUEMvT090SE1ZeVBoQVdMY2FGNDhYWWNyOXZD?=
 =?utf-8?B?NWtkaUtoV0hpaS81TmY0UkFBTVZSQXRzMUpvNVlhRFNmcTQ2dy9zVGdNVjB6?=
 =?utf-8?B?VnR1QjVuRzg1TEQxOWJGQnZLNFZqRjNwT212aTkxNFhwSFpqaTdVUjVTV29C?=
 =?utf-8?B?OUduU1RwUGlUdjZBUUc4eHk5d0dOYU94blJtQkJhM0YrSVZKWFFzRUI3cnVW?=
 =?utf-8?B?Qys0dGtUcDdMdHJBNEhlV0xoZ0dudE1CS1JvM0ZzK1NMRVhxYzJMZFpCaTJX?=
 =?utf-8?B?SkROdHF2eDBVMjJRNjYyRVh0RElRNTNWYXovcnNKRjNFaGRWVWRNWEw5UkdP?=
 =?utf-8?B?UGFDclA2QXI2cXk2a1pIb2dnWlJEYWh6S3FDSEVwUjl1bmZGUUU1Q0QrODRB?=
 =?utf-8?B?MUV1c25VclMxSlVaNUZlZ2E0YngwMzcrZ011c2NoUU82RmZjZ3VXRGVaa2c0?=
 =?utf-8?B?Qm9XQnIwbnZwNWVFbjNJL3pqSXJuemMySERLYXd5QjR6M25zRXZDTzZJRXdv?=
 =?utf-8?B?aG92Z0Fjb1Yyc2JxSDdxdW9PcGJWSlhGTnB0QmNGQW1WcDhjNTkvYzMzNlRh?=
 =?utf-8?B?REtJMi93cWtoOTRCNmdzZ1p0WTdQdThCTkxhYmpJbXl1WDVwaEFZQjBWdjFL?=
 =?utf-8?B?NnY0b0F1SUptL0lISTRwSnJZL2dBUTRpSzEzZTJzZjBEdkI2UGRRdmRITldB?=
 =?utf-8?B?VVloQ1lESGFvWXFFdlE2NmZuOW5ROFNDb2NURVFmSEdWOU56eXQ0MzNMWjhB?=
 =?utf-8?B?YWJmczBpMFVMOUkrSmJDWGlQWXFocEsyekxFV3hyYjZBcjFGdWVpVWpvNEhs?=
 =?utf-8?B?dXp5UVd2b3BBZXVKWkFWT1RhQ2ZQL0VNVHBudG0xV3YvVCt6anVwY2llSVFq?=
 =?utf-8?B?SllEenBJWWl6REtRRko4cGUrNksyZ3oyWVRWd0cxWUs0KzRlMEp5b3RjRHl2?=
 =?utf-8?B?cHE5eGFKckRFc0Nqdm9vQk5OTW1ML1d6aDhUOVhzQzU0dFQ2YSsyMW0yLzZy?=
 =?utf-8?B?c3JIcmFsSXVJMDBwYkVtWHNyd0RzQW05QzhuclFqbDk3WGRIVGU2alQvOGhx?=
 =?utf-8?B?QmxJNDRLb1lNaCtHY2JRbE40OGlaQmgza09jdHQvRDVjQUZreVVDUFBDeTIz?=
 =?utf-8?B?OWlxcUlicDdobmc3bjV0cFpIL0lDcDJiNUxiT1dXOWFLandVYzVkYWNkeUFV?=
 =?utf-8?B?bXJEaHNmWEJORzJ3YXhiL2FTQUFucmZVa0ZjbExjRktlN08yT0hpbzV0Y1ow?=
 =?utf-8?B?S29DZ3cxNys1NktQQTNoODhwUm5PNHltWTJCOFhjSVQ5b2oycE1uL1hoZnA0?=
 =?utf-8?B?TTNwM2Z4ZkwrSjRPMXA2emtwUitGekNMZm5kVXl6dHk3TGZ0Qmlod0hFUXFC?=
 =?utf-8?B?UmNyYSswTWU5QlFyZVVuOWF1dTNoeDZvZG9jRTBRTjRoZ29CVmsxSkNUYjZT?=
 =?utf-8?B?SGpNYUE1dEJ3UXRBU3JMVU1GUkdlOUw1c2REUm8ramNMVm1oNDA2L0tueWYw?=
 =?utf-8?B?ejRjTUl2b2Q5dnEzYzhZSGJSTFI2K1gvWjhSQnF0MFhKT1YvVjBObHZHQzM3?=
 =?utf-8?Q?R2y+tNY67czH1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGxZbTNkKzVkOFdGcmMrdmFDODhvMjJqTVl1ZjhtZ3VjNVN6UVJhMzROcGVl?=
 =?utf-8?B?cnBrODJqRFgyYnpteDBqR3VUK1RuYnpYZktHdGZnMXhtMlliaC9wcVhHcFpB?=
 =?utf-8?B?ZE1jOHpOSWFYdk1TRXpCZTRqOWNOT0ljSHQxeTFCU0NrdXFSVEZweVZMWjh6?=
 =?utf-8?B?WXVnRjQ3Y3I5YVU3dzJkSjd2bVE1a2JMbFpqdkh3akVoQ0hHWXdIUXU5OVVv?=
 =?utf-8?B?ZFU5S2VOd0tEL0IrdTZFUUtEOVJ0eDFxNUpPMFVkZUlyZ0IvQzZUVVlZNVE0?=
 =?utf-8?B?NHB4ZVZRa0hFZ213MktIRzh6Y2NENXJ5VkFZYm9TSXlEWE80UUxuNWJvRnND?=
 =?utf-8?B?ZlJyZmRMTHd0Nm9uNytZck8vR0hoWDl5djZFZ04wNUF4c0tUaVhtU05nUDd6?=
 =?utf-8?B?bS9qZllhVmJlS3hPeWxwK01wZ3JwZ0RobjVxTmxnSTNKb0RTT0dDbkxmNXVO?=
 =?utf-8?B?dmRlRnR5K2tQMXNpamZRc3VnNGNCRytZeUgxNXpaUEFrVjdhOVZoUFR3OFpF?=
 =?utf-8?B?cTRlQy81bVBMSEZZajZaWlFzRzUwcjJmeHBLbkZMaVFUSHROMVpyQ3hZK09W?=
 =?utf-8?B?V00zeXh5ZWljMHQ5VGlCNkJMTWlObHVlaXF5YXBUU29zNzNnNEJ3OWZCaitI?=
 =?utf-8?B?RUhOc1BwUmRSeXNzc0ZUd0FPSDZsclp3Tk0xWnJwTmprMzFuWmx6cXg1dmFJ?=
 =?utf-8?B?U1BxWFhJN2FmTTVCMEVsWXgxMlJreC9mdHZmTU9pOTF2SHp4UWh0SW1mbzBH?=
 =?utf-8?B?ZkhEL3NyMWJDZjNHRStzQW9ZOHErTVZUM1NoMmlneGlLTC9BU2czUTRaRTdJ?=
 =?utf-8?B?R1pKQm9pZ0k0RHE5bmEwODBsdzUxZGsxa2V4TzN1c0dwR1UySklOQXFVM05W?=
 =?utf-8?B?Q0R3YVZLZlloRG1xTDJ2Ym1RSDdBSjNkV1lReGVQNzZEcHBNL1BLUWxPbG5n?=
 =?utf-8?B?Y1M4NmYzUlBmQVZqeDhVWFhaUy9IbXRVbG1hY0tGVzMrbE1YdXpZMENuMStk?=
 =?utf-8?B?UmhQcU51OWlYMzVxdkd3MG5zTExZSjh2azdkNVhTNjFodnk4d1g1YWJuZmg0?=
 =?utf-8?B?R3VPMlNaVUhnaTNhOFpvTHMwK3k5Um5YUGNzaEs1ZnM0aXh6Y09DTXFwdmY4?=
 =?utf-8?B?TUIwaHZWQXZoc0NSOEE3dlZCWmkvcGJkU3g1ejlvU2liRWlQR0NrT09oMllS?=
 =?utf-8?B?Wk01eHdOM1NDbkVQeStkbFlhNzNyYUEvWXZUeElHVDg5ZlF4akVwcUFtaEV6?=
 =?utf-8?B?aG5DZlhHcXBLaEJvamVEM3FpYUFxUmR6ZG44Y2tCakZwWDc0Qk12eVZ0U0wx?=
 =?utf-8?B?MjVWUDlBU1p2OW5RZ3FnOXZGWnl0ZlEvMlJiY0lsQnB4c1gxVENBcUpRZEw1?=
 =?utf-8?B?TUpHcDBaL29NVkxUOFphWUdZUmdSZ1g1OGc0MTl5OTJObEVaK09HR1JNMzRG?=
 =?utf-8?B?aHFiN2xmekUycWUyS3l2L1NUeFpLdkxLZlhFTHdGTnFuNUc0UGtoZ2xnbVky?=
 =?utf-8?B?YTh5VkN2ZnhmZGxSN1hNdGlFMENabnZuM3YvU1l1ZHNsMWJTbTQwT2YzSnhk?=
 =?utf-8?B?anB3bWIrTGUxdTEvdDRQV3pFeWtmaWVHcmJqcXZzUm9UWGhaVnBDcjFpL0N3?=
 =?utf-8?B?QWNDdHhaekxJSU5lbXl4emJKYVNza00zVnlNM2EweHZHNzNpYU9aVWJlL0NS?=
 =?utf-8?B?M3RFdXVYS08xRERLSVBuL3JsMkFBWE1tdmtFR21nZHBkbUg5dFV0Ump5dE5a?=
 =?utf-8?B?OG5uV1JPT0U0WU80Uk9PWUNsQ1ZsVXFrTlFyTmVHVGQyVHJ6WHdZUm5NUXNk?=
 =?utf-8?B?bEFSQ3BsYy9vZTJGZllIVk9uVllmSy81WDN3V2M4MG9FZndjRFpVYkFQZmcv?=
 =?utf-8?B?Z2tpNG04SzRPT0gvTk0wYWgwam8vWFE0T0FjcFpDbnl4MzVHWldFdXhXeHF4?=
 =?utf-8?B?UHN2b3gyUkZ4V2VUR3NkWDJmS0hwUXZLYktEZHg1Wk5sT2Q2TnZwMUIrbjB3?=
 =?utf-8?B?dkgzR3liVzBac0RFODh3T1BrUVRvM2Nma2tzZGtBRWdER3JZR3dGTm9DU3RQ?=
 =?utf-8?B?M1RtZGxCdks1UG95bytlZzVFc2hTM1JKL2NCaExYUGdBQzBWSnhCcVZBN0J3?=
 =?utf-8?Q?fNbvQyz9rrr+RyDgvjvaGPfRC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727df1dc-6dd3-49fb-bf4c-08dd5cf61e2c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:30:29.5995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sC+7oovaTOIdEiwIa7++LqdUZfEFv3nacKFMMGPG1vn9FIG6j9iCyDOSBGcAiASZ5oDNO9a+8fUehUdbYkiQPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> The architecture specific parts of resctrl provide helpers like
> is_mbm_total_enabled() and is_mbm_local_enabled() to hide accesses
> to the rdt_mon_features bitmap.
>
> Exposing a group of helpers between the architecture and filesystem code
> is preferable to a single unsigned-long like rdt_mon_features. Helpers
> can be more readable and have a well defined behaviour, while allowing
> architectures to hide more complex behaviour.
>
> Once the filesystem parts of resctrl are moved, these existing helpers can
> no longer live in internal.h. Move them to include/linux/resctrl.h
> Once these are exposed to the wider kernel, they should have a
> 'resctrl_arch_' prefix, to fit the rest of the arch<->fs interface.
>
> Move and rename the helpers that touch rdt_mon_features directly.
> is_mbm_event() and is_mbm_enabled() are only called from rdtgroup.c,
> so can be moved into that file.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


