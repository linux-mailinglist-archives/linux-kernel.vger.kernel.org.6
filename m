Return-Path: <linux-kernel+bounces-332736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D7697BE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3021F21D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241411BAEC5;
	Wed, 18 Sep 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TEhKZgkQ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9F71BA88E;
	Wed, 18 Sep 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670302; cv=fail; b=uenUzk5jUoAeg8QJRQey/QICs6tZozEkPe1h+vsePtAnOHIIRlopgQi20qqM4CKg+r47AZorHYLgAroyyRBzP+ZgcP9wXJ9UPf//TGrwiQLlWsl+iQGEn88KNaOOUNiUah1SFTfaeRs7FdUfduBuUx5RoASnqkG+pltFuhqpe5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670302; c=relaxed/simple;
	bh=fXmYnxiy78Tn2njBVVPJpdauJ498LdTb4eRg90PU+pI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PVqmPz/dkZZNrKR3ZDoPslDZGbVKjHsHj8XV0b5qv6iaAgGZRAFdnKtvYhsvmHhMISxTZWJ/6dO+GgMFVGEnQOoaMKrrcr9QEKAq5ktFGLsCHU38ukvKNMV6GFgiZKrRP/wpnl2OzPvbQkJ8CdtgtF3ilqVPrVPvhSMCfLfhvl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TEhKZgkQ; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgb7rdTU1kRf+s4+2nE+KCIyD4IX022kAEC9Qo0v+A6rWLPktwT77V8dwZxwpf4TiqHGfd/A9y6IG/+MFK6ivuf2Zy9k/m8PrdRhJMQkE/LLI37VpcIkvkKJo0qGXqN/qE2A+8IuuhqzU8AqjkxcJaIYCjY08+1GuxasfxcIsj8Thy9Dxqjuk6g5l7FgyIwKz2cZIajIqvVhzfTPFbmmJjXScrtPCNpHt3zZni93H+8DvPaK8Ue4QwgGq/7oQH6/mKfJbaFDIbZM/pcesQw9RxSi3RUPNb24wA2eReQRIgh09qGdNem3nkGl/FH9RasuSUdNhv06SXxtFTyR6cLm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdCligQyZPbp0WTnzimJw5QHEsZebR/Dvgpb/14ABWM=;
 b=WXu/iFRxvJ0KuE3PHX+Wju+DXiA+yUEe0x6Z/THg5yyehuRoMwah/VYDC+qbzcvdYZhPWeDxNBIbDD01DAd77h0bzzsU5AgNCpzTAnN8kGu1FLUhamKeVHYEqLSF1xwiTPLOexqvCLg5/1L9dUfvCRqU4nUNQz+OLqVweuEkiSzZKRYwoK12FeiQDk5KLiSeXnxVSEPSc8Qiaktd7aV7o3gSAoiD6QOFdvZmaMwTsamG5C6W53GGyRKi6ufyEC5OrIxsmtOXtBJW8kG+eKqMaRS3kuWZpCGEaAGXORcl30k3/5bhWd4cqMQRTfuyNJPtLVGA6hZtcu4VVlOS9JbyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdCligQyZPbp0WTnzimJw5QHEsZebR/Dvgpb/14ABWM=;
 b=TEhKZgkQl7z/uDCnWIKumVTY9nPcCh1GQm1BRNavNhIRmRbebsUqbVRXgQcseZzaIzMVkMf/fDZNDKwxpJnyBI23IU1wnYSjPwy5m6eVZSg7jnQPuVZ5cm9qpJER6+By5PX6goqiU6rVnncYMZhoh8ADitiRUjfylkA6otNyCtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6880.namprd12.prod.outlook.com (2603:10b6:a03:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25; Wed, 18 Sep
 2024 14:38:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 14:38:16 +0000
Message-ID: <80445b97-e238-4bdb-8435-b8d5de97a2dd@amd.com>
Date: Wed, 18 Sep 2024 09:38:13 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 2/7] x86/resctrl: Add SDCIAE feature in the command line
 options
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <c9dc15428edf7164a1ae73f10348f3fc4cb9fbbf.1723824984.git.babu.moger@amd.com>
 <8b8d1523-b925-4d6a-856e-e08cd84f348b@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8b8d1523-b925-4d6a-856e-e08cd84f348b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0068.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: e0828004-16c8-46e1-a188-08dcd7ef8864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG1kNlVCQWhkVkl6MjBGU1VpTHN0aVJJWmMvWnhCalBISnhjdkp6d2RFNVBY?=
 =?utf-8?B?cTE3UE83V1NWVzh2OE1kaCtxa1RDTk5XWVhjMHNtYWwwWXRtR0o4c25kcUlw?=
 =?utf-8?B?TmszNGIwZTNiczRVN1JGbW1LZS82R3UwTDFrM3VLNm9rWm12Z282YUtsUlFX?=
 =?utf-8?B?ZkRSRXlxNndlbnhFeGJzbWluZmdlRTAxN2F1YzloT21yR2U1VWJhT0doWUNs?=
 =?utf-8?B?NE9lNGsvUVlocmVrODNCejEzeWFmeG0xNmZvTzB4UVlXMzA4clJ6UDY2YXlR?=
 =?utf-8?B?dTc3RjZUUE5ZV05nMno5bERtdityUDEwTmpiR1QwS3BiVW94dnNuV2F4RXJ2?=
 =?utf-8?B?bm4vR3BFYXFlejg2Ritsd21aMFBsbVl3Nys3aHBwUmtLNU9MZnc2NVdHRDAy?=
 =?utf-8?B?KzZoUU9pSW5EdVh4Y2VETzR0S1hPZndHRDFyNnZ4ZVFndFlDRk9BTFdwd0JI?=
 =?utf-8?B?MXRwMkJBLzJIUzM1bVYyOHRVN3pFVjVmU0VKTW5WQUIySlJ3WTlMNUU1SGNJ?=
 =?utf-8?B?U1JqWHBadjRvYm8rWnJ6dXJDYkFDeU5BU2ROMlBveThOYVJqaVdsRmV0Yll5?=
 =?utf-8?B?TVUzVkoyaDVnRjRqZFdVOFk1VjhGeG02YmdOVGZnM3FzR0pnRXlheWJ4MkhL?=
 =?utf-8?B?ZTRETWh3cEYxUk04N3kveU5GamxCWTBkVHlWUzBuekdYWEEvMmRwazBaRzBZ?=
 =?utf-8?B?VVhXYmlVdGJTbmZlSEtjTUI3TXpyUENQd2wzRkpxYUdqNWh5eVRJQURTeHhF?=
 =?utf-8?B?V3dxSGV5djBTTWtDVVVmbmxDbGxhaGExNDg1ZEhyQlkzYXExdjVFUk96YVVD?=
 =?utf-8?B?WU1PUmRjdVFQbys2YzVJS0lWY1JscmhCNTBLWnE2UUt4OGRDSzY4SmNWVDBZ?=
 =?utf-8?B?dWFEc2RYVG9SaXZ4a082bC9jT01wRHZtdmpZMnhMcjlmWGh5c1RIOENnZmhB?=
 =?utf-8?B?NDV2ajYwbnpTa0U1YU5EdllGdlZnYjAzUkZxa09wOUhRSnhhSjZEZEoyK3JJ?=
 =?utf-8?B?OFByV1BOcm1Sc29UWWRhSVN5RG92Y25aUkJDSzk4c0JYaTNMNktEaUtPNFJD?=
 =?utf-8?B?T3BKZ0NMQlJOeE5yelYxMlNlbnVidHBrSkdVd3k0b2lQTmNRS3RIUDlYWG5H?=
 =?utf-8?B?MUxqam9wVnJicjAwY2E1Nm90Q0dUVy9LdXA2aGNRV2p0Q3poNnpDb04rOXY2?=
 =?utf-8?B?bHcyRDB1ZUkrVFBRb0tuR3Y3SGRoNTRHdzJzV0NqTnFtNmxsakdySGhaNjhj?=
 =?utf-8?B?QnFGZ0wxT05FWCswem5FdkhZdmI5Y3l2c0JjS1R5MlpZa1QxK0hpOFNwT3ZW?=
 =?utf-8?B?SzJvRnZQUXpNamYwYWdBOFdwdnBYbjhCS3JSZVZ6UlEvVndrWUJnaDBTWWpv?=
 =?utf-8?B?STRqamZwZ0plYTAxYzFnUHhDUzNRakU3NEpPYURGSEpXNGcwbnlaeTJlcEsv?=
 =?utf-8?B?NENrZDBSd2dJd0NmWkNsUnVWZUlqalRCazJ6Y2VIMUg4MFI3SWlvakFweHNP?=
 =?utf-8?B?cHJlak5na25NWGpVQmllR2RvK091UjNjc1lRQjJBNExYTnl6V2xIOG9EeVVq?=
 =?utf-8?B?cXJycytIakZkRE5LdjVwZ2pQMi9HUHZJUHhtMHFjcllXbnhSM1RkZEVZSVpn?=
 =?utf-8?B?SHk4b2dGOFAyK01mTGliQkVUWU9mb2t6U2JpMGw4aGtSNnAxN09UV0Fud09j?=
 =?utf-8?B?aVFKaGdpWnFGN3pjTHBlUVdZZzRWclZjTzgyN0ltM2Z3d1BYWFZ3WEFNWVkw?=
 =?utf-8?B?MkJ6c2NXdUdLT2p6dmhGTGtNK29nMlU3QjRFckU2U2NSczhqS0V3SnJ0MUpo?=
 =?utf-8?B?d29rV2cvZ0FoZy9iZG40dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEFrR21LTC9xUGxZR09JUmpkeFgycFFpU3pubDJNNVBIaGpVNEtFSU9IU21p?=
 =?utf-8?B?UUMyU3FsZ3dmQ2o1WkdCSVBuQ0VucXN5QVlLSzF4SzVKTFhOTXlwYk01dWVk?=
 =?utf-8?B?UmFYNHh4bVpQZkcySlljbjhoVVhOaEdIOVRaRnJHdjZEVHlxTnk3Y00zWGU4?=
 =?utf-8?B?RHVCSG9xaEE0TDZncktSOXkyRHZOK2tYelRTaDFtWWc4YjBmbGU5OFJnWXhE?=
 =?utf-8?B?eVR0LzlPRFgwbTRheldCUkhDK0pXckVjU1B0aldsODYxbVdWVU9sUnNLd1R2?=
 =?utf-8?B?ck96UjlLT2s1blJLd000OHNSR1p3M3dTbmJQMTdLQXRPTlpFRGFyTXU4dklI?=
 =?utf-8?B?T2w3bGVZamlEakpwR1BqY3puWHkvc09zcEJpelRoVGhTVVNXQVZQTGJOd0I2?=
 =?utf-8?B?eUNsNWR6U25PNC9UbnhnYXdiSUFDUHU0eXBXcmFURVVlZXNQdEhmbkxsR1FP?=
 =?utf-8?B?K2I3dnp5ZlJ2ZFJxb2duMzBBckJ0QkFqVWg4dktseTNPczNNK0prblhkd1lo?=
 =?utf-8?B?UE9UUW55RTlXVzVqcURvUzdrSUtIQnBSNHRPa0IrYVhraURpT2VhSlU4Z00v?=
 =?utf-8?B?N0w3RUs1NFZlbjZuVmFrOFNzSGZhOHZnblh4WWttVmtYZHlTc0JqMG9KWWQr?=
 =?utf-8?B?RHZXZjhMK0xPZ2haYUJtK2FLSG1vUVVwLzZDRDc1UkdBb05nOStPNzBjQTBm?=
 =?utf-8?B?WEpWRXZJUGRvYXZnRjJ5c3ZFeGpRdmxMbTRBcndhaFR2R3pJNWZHMk1QazBC?=
 =?utf-8?B?YS9hTUpmNlNEUWx6Q0JpSmlPZTQ5Szg5SXN1UW1YaUZCNXZGWnJ2dTIwSWlI?=
 =?utf-8?B?NVlncEQ0OVNpeFdQM0JWaDZRd3Zkb1FuRFJsb0lOUDZtNlhXeGVQVlozWkVU?=
 =?utf-8?B?WHA1R0JZTVRmMlBDMHg1RFV1NlBUNldtUlpiSk9VWlhYbWNsQWVoQWhjckQx?=
 =?utf-8?B?Si9vQ0QwQkVjK0p1U3k4UWd4NU84WEhWZXV3VFlNcFR3dlU0dUNzOXBBUzlV?=
 =?utf-8?B?azVGdFdldld6YzBzdVNZZHNqZU00d3lkK3U1bUJuMEwyTytFeWNrb2VoTDUw?=
 =?utf-8?B?SWtkeFI3NElQQkIxNmZsSi9leHBQOTlzS0NiY0RlLzAwbzBGTXhDSXFjRmdP?=
 =?utf-8?B?amt2bWhMWURxTm5ta28xWkZDZlJ1czV4U1FmMUFXc2RjcTcyNGxUOXVDdTNo?=
 =?utf-8?B?VmlhUlU2d2libXZBQ2NmeHBjeFZqaExoTmdwaEdhK1dqYW5ZcndFYVM4OHNW?=
 =?utf-8?B?ZWZaRTZLQUlLU0JRMy9zRWNvYk0xUjRCbzFlRENVZFpXM2NhUWxvUU4vWERi?=
 =?utf-8?B?NkVaZW9QK0ZQRFRkd3pLUjZJd1lZdGd0clhwWHovSkNoNzdXSDhXaXNuaGhn?=
 =?utf-8?B?WS9aWWtCb1NlTUc2L1ZqaWpSSkRNTVd3cHJFNEdjV0U5TnRES0tuL0QyYnJo?=
 =?utf-8?B?T0lLWnljejdPdnlZcUMydmxJODJkMXpNcE5XM2lMS1BqdFRSWWV5V1RLOWVp?=
 =?utf-8?B?MUpJTDZ0QUN1OFZyNTZhaEFFMHJhcWxRcHFIOVRiMi92cElCM3RrZWtYWGNY?=
 =?utf-8?B?SkdQOG9hVjd4ZnVZNUJSaEM0M1hOOGIycDI5ckFrWGR3MFU3WGJoSGJyOTVG?=
 =?utf-8?B?aDFvRENkYi9oUFFPeU5EY2ZrelkxR0tmam9sT2VxYkZ5dVN2ZHgrYi9ZZy9y?=
 =?utf-8?B?RjJrUks2ZU1DUWhLZlpyWDBMT003SEhYTEJIMlptSmx1NnBjZktkN21kcDdh?=
 =?utf-8?B?VjhOaDExV1g1VmNON0xKNWd5L2lQanVLYllYQmcyeHZqdTEzWGEvYXRYc2pQ?=
 =?utf-8?B?KzhVeFluZWFOK0dFVEwvTTBIOW5kNnpyRFRHZ2ZtKzZIb1F4VzZEQktDQ0Vn?=
 =?utf-8?B?aEdYYUFVQUNuSE8wajhXYzJpcm9JR3lzWmVOVzlTWnZ2WWhCZ0lXQVlyUmNj?=
 =?utf-8?B?UW5kVmRzK0tvdVlvN3RFTmdlQWVuRUc2WStRWlo5eStkZml4ZFVwUTFraVlP?=
 =?utf-8?B?MEV2c2p4QTlHaUpEWTc2Z2REWGFDZU95eUNMeTBHWUU4MndqdndCajYva3BQ?=
 =?utf-8?B?b0JvaWlVY3pWcWN1QlErYnlTeGRtVFNrdnJ2dThPaHUrdXJheEI3NTRNWWZB?=
 =?utf-8?Q?+xtk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0828004-16c8-46e1-a188-08dcd7ef8864
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 14:38:16.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SS33uT7IcVkx+ypY4voANAqU27YHJVRqODwj/KfGlBhC/GkaZt+E8QHEPFei5Lh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6880

Hi Reinette,

On 9/13/24 15:45, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/16/24 9:16 AM, Babu Moger wrote:
>> Add the command line options to enable or disable the new resctrl feature
>> L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 2 +-
>>   arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 09126bb8cc9f..63f17d23b8f4 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5604,7 +5604,7 @@
>>       rdt=        [HW,X86,RDT]
>>               Turn on/off individual RDT features. List is:
>>               cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
>> -            mba, smba, bmec.
>> +            mba, smba, bmec, sdciae.
>>               E.g. to turn on cmt and turn off mba use:
>>                   rdt=cmt,!mba
>>   diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index 1930fce9dfe9..c4dfc768ddf5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -801,6 +801,7 @@ enum {
>>       RDT_FLAG_MBA,
>>       RDT_FLAG_SMBA,
>>       RDT_FLAG_BMEC,
>> +    RDT_FLAG_SDCIAE,
>>   };
>>     #define RDT_OPT(idx, n, f)    \
>> @@ -826,6 +827,7 @@ static struct rdt_options rdt_options[]  __initdata = {
>>       RDT_OPT(RDT_FLAG_MBA,        "mba",    X86_FEATURE_MBA),
>>       RDT_OPT(RDT_FLAG_SMBA,        "smba",    X86_FEATURE_SMBA),
>>       RDT_OPT(RDT_FLAG_BMEC,        "bmec",    X86_FEATURE_BMEC),
>> +    RDT_OPT(RDT_FLAG_SDCIAE,    "sdciae",    X86_FEATURE_SDCIAE),
>>   };
>>   #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
>>   
> 
> Why is this needed when patch #5 introduces an interface to enable/disable
> this feature after mount?

We have provided option to disable the RDT features on boot. To be
consistent, I have add this feature also to the list.

Yes. Feature can be enabled or disabled after mount.
Thanks
Babu Moger

