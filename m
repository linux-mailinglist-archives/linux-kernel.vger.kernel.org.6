Return-Path: <linux-kernel+bounces-176361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB698C2E7A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 03:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DD928482B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABF21172C;
	Sat, 11 May 2024 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u9I842+0"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9738C13;
	Sat, 11 May 2024 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715391645; cv=fail; b=cxNLBVP0ChYn32jKRfPI4gEbvVUVIyUlbkzrf9HOo8tKLa1BenFew0um7vsnCChPEc/abZJciqXVu/IwCG9WZjGUGXXGoDjT1QjqXpbza1SCXPLmbn343Qfkb1ALgan08KtWzcIr5C2j899S7MiM8ZVs2axB01m+tLGgczR6R4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715391645; c=relaxed/simple;
	bh=XNBb5CSulnodZZpUNycsVoG+A9ACU5jlUVx4i37C2SA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFL5u5im4YT/9QjrvLShYN0R4KSUDsvQMYcr1JJubbyMGajB2HJAs5v8lS5cXFYXBouCClPjculKFvhg0Qlvmjd3gSy9wL4RWZM0FiWwhfLIQh3lg3FGpkn49CjvDpU3HCIY0K+LXe0Nt0UCs4qGsIAcWi+xncVzbmt1BJJaBfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u9I842+0; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5gusDOGggjpxGbxAHzuLAayFVq8RzcHq4qy7QM84CfSZVX2uxegeExeT6hIMD1zuAoEk7aC/remU/igxWFFmxVxiuUOXLpGRks6WQo9/uzksiqyj/ylt8PgwAnBQ3hwfP6gIRITjQi9kyDZDFDKJJOlNcwGXUMoihxgj0B5SGWb8W+PaBr4hUL37Lg+ZsbLbxAmhwVwV/4mIhahLWp434EiO4xIG7GPjeoNAMv6tXr65YBHKq6wXk6HN3/lfVUsdUIjY+4p1qFtdjjAugNyg4dQ0l8tQd3EC9civuiCH58E/QOG/azf8oWhx/igybCFhHdZgQEwqd+EfmcUzybT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMsiec7Dvs8a8ibjmRHvEoRDeaelTvbbs8l8rntLUcA=;
 b=hLBf4yKtqyJAsMf5CmjveEH3uNIKf8pFsSzBKDyyOOYDUT7nvWEit6Iz5BezG7E6DrcaaMsGw/xQiZwxBuBgWB3cWx0xVi6+iC8v3aMkzRGE0lAXsv/nCMNjauW5M2zyJZgeZskv2IqQPUneFUiFx+zNJxj4AAWLIKlCcxgcKmwqUEB4HLeY2L54QL4ybCHaufWYX4gFihJmr7Y3RSbu2ny/W0jpBkyyBGhb6irZsGDanhJs1jMUgQ9bJ93iLvXeqPivz1Y7eksaRpR/bJMNNH4bHROS4btF8dhggirlQL9AyRhc/PInzZ8EHKZ1Y6/VrQdvtot3RPncix1m9zMPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMsiec7Dvs8a8ibjmRHvEoRDeaelTvbbs8l8rntLUcA=;
 b=u9I842+0Geu56mAJ8pGZOOz+9ITEBOxmIJguTJHUfEiwtcNAHytMNb1Y/JXfGU/ikCw108y/Aqfp6uc8S4p8V6vOffJ216FUe/sxONNHemCEHU9y/KiYZQrL7dIha/O/KKdWWXMnRSTWuCWCtmtiSW/as4uLwQhbAR4bXHR3mFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.49; Sat, 11 May 2024 01:40:39 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.047; Sat, 11 May 2024
 01:40:38 +0000
Message-ID: <356a6c8c-2c42-a321-4f8a-6d052945bc8d@amd.com>
Date: Fri, 10 May 2024 20:40:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 03/17] x86/resctrl: Detect Assignable Bandwidth
 Monitoring feature details
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>, babu.moger@amd.com,
 corbet@lwn.net, fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <63134ddf18208bbd11bcec0ec75c33ef6e5635b2.1711674410.git.babu.moger@amd.com>
 <ac22b96d-c4bb-42d9-bac8-22b9e032b59e@intel.com>
 <80b33bc6-7b70-4853-92a0-718c2d8728d3@amd.com>
 <753844b6-b68d-4b05-89b0-3ac36e1c8564@intel.com>
 <be20ffe1-ef8c-41fa-b359-9ebfaa326ebc@amd.com>
 <50d006e0-8488-4579-ab4e-701e1a8f410a@intel.com>
 <4363899d-2203-5829-9074-beb6c0e583b6@amd.com>
 <51af9362-ccb5-4393-9dfd-8615138df217@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <51af9362-ccb5-4393-9dfd-8615138df217@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: bb96650d-247e-4217-13ce-08dc715b5c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qi9LNFFXL0lmdTNkaTNiaWdQcVNlOFdZMjA4TktVbFUzSXE4anI0WTNzOE5X?=
 =?utf-8?B?bWhGbjJlVEFXVXZMZ3NtbnF3UGhwazliZFBjdXZWTzZjcS9HYnN6cnBsRFZr?=
 =?utf-8?B?T3ZhWXNtd0U0cnNxUXc5YlRnT3UweEVSNEVDa0lHOXVtbzY0WkRFb3pPamVU?=
 =?utf-8?B?RVdyZ1IvQlF2RWRGY1dPaU94cll5R0NIa0RDd0Uwc0pZY3QxYU1VakMwZmt3?=
 =?utf-8?B?b0cxR0hYMlB4aGhJMWFNbURPYjRHUnNjUDdHN3U4MUJvakdDbE5JZDIzb3ZH?=
 =?utf-8?B?L25rTWhUbTJYOGpaMDh6MHJSSkFKQjZUUVRodHppYTJKdm01NGp3TVIycUVx?=
 =?utf-8?B?SXdzMjNUS2xSalB0NnFXRFJCSkpjNTZJeDE4TDFqeDJwbjJzcXFQZmtTRVRx?=
 =?utf-8?B?NDlWVkFoMnY0MEd6dUpzeHlLdjBVaW0ybXowVVFKNkwvODBEdzAxbVRURWxs?=
 =?utf-8?B?ZWF3K2Y1S3hLRlR1cXJmays2d0FWckp5UHNPWlRNNWEyUlhEQ0h5ZlczNSts?=
 =?utf-8?B?Y24wTk9STFRXNmZPR2gvMHNKcnpIN2NYNEEwWStwMU13aE9kSkNHNlFXNWEx?=
 =?utf-8?B?N05HdDZpSFRURkpyaFNZY2lPSzg0S1Q3T1ozZndYK05qMnZ3c0VSRXRSWjYv?=
 =?utf-8?B?REEybmI1OGthWlF6SVFKbFd5cW1IMXR2TWwyTnllWXpjTGNsT3pQdHJ3OXFS?=
 =?utf-8?B?UHVuUTFCaFYrYW5hQmx0SmFzNktnZTZGME9tMkVDbm04dTVicGdwbWhaZzNX?=
 =?utf-8?B?Z25ycXlqMFJHbVc2cHBvcHlkMzRsL0dURGMrUlBGaDUzUGNSTW5BbFNPcmtH?=
 =?utf-8?B?blZyU3NaUUpGSUNJNkF6VTFZaUkrdHNQVXdDeGg5SHdsK2Q5T0ZhSGk1QTRZ?=
 =?utf-8?B?Y3ZFRTRiTWhlZXlvemlpdllHTEhtRDk5bzcxTndRZ2hMQkxwc0RZZG1SdDlZ?=
 =?utf-8?B?TnlPVEVOM09rNGc5V0VrKzBRMzZNYWtIelk4M2lZSUZ4bHpNQnRkYzQ4OTJy?=
 =?utf-8?B?U1E4RW9SUGJkSGp1MW05MEM5VkZUM1NDWERvNGxTZktHRnFqbXhNS1Nld1Ew?=
 =?utf-8?B?S01US3pzWjRGd0xzNUJPOUljcGhiNlk3dis4LyszaTJtTDlvZGRhcllIVHU3?=
 =?utf-8?B?dDRxTzhQeGZkY0p5VVpNNUhkdm5LSU0wRU5xbEVXeCt4bEsxKzM4VHhVUDBs?=
 =?utf-8?B?ZVZ6bGxZQU5mcEZvN052ekJyWmxYZHhuZFN6Rk9RWVVRL0N3ZkoxaUdWUVJY?=
 =?utf-8?B?L2tsaWU4MnBRY29mU2RKVnJxUHoxbW01MW1aaWd2UTduSVlRb2ltUGE2RVhn?=
 =?utf-8?B?Ti94MFcwZHhuRkpkY0ZsWGo1N2tDTW9vWit0NFJxdVcrYm1Vc1o1V2EyWTRw?=
 =?utf-8?B?NG15aFJtempITWVORUpTYm0wMmw3TXFmVm9HVjJoajJVazZjSzlKTkxUcVdY?=
 =?utf-8?B?MlBiZ1ZiTSt5bzVkVHlHN2RXU21JZ2JwZlpGUTlhWmsyM3lNTkZlYkVKdEFV?=
 =?utf-8?B?R01KbWRQZC9HVGxMTWdwdnJoU2dCOWh6SkIyanF6UGxPcGgvTlBTclVKUGxs?=
 =?utf-8?B?VnJ1SDlNU081M3hNekNIV0dGYkdRVkl5UzJ2WjFSdnNVQ3gxSnhhVEc0NUVx?=
 =?utf-8?Q?ZZy2hyCyVCQNXrDXPGU2N7/DUP716BH+lkmWzbhHwKCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXdsd3RmQVFoZDBidEcxSUpsVXFVSjlqQngzVnhhV0lBWEE4dTFGNFpVTzVz?=
 =?utf-8?B?Q2F5UEpDVndud05mZ0djcU9WSGs3TCtQazRmMnFWYkJVN2RzQlRwekhaU3lu?=
 =?utf-8?B?MHZ2N3BLSWN1ZWFwanh1NVBtMGlYZk9YaitrUFB1TEVRK09oK1BtS0VGcHNr?=
 =?utf-8?B?QWVNYU9SdFFnOUxBOGNGWXJTYmE5K3J1TmJrVmJCVFFzUzBJN2VHeURSNldQ?=
 =?utf-8?B?M1h6cXpUSGswOGJqNzdHdUhFcTh3QWxkQWI2ZW5xdFEyZ2dreU5PWm1QOW40?=
 =?utf-8?B?VmhjVDZ4aUZWZjlrVGd3OGNhSGZmSWNNWE5jOXZyYS9zbWRUZG5weElQaTdx?=
 =?utf-8?B?TjlJdU9kVFpKZlBIby8zN2k4L0JIUXIzNFZQYjE2bWN3bWJOM01Dd21oM1Uy?=
 =?utf-8?B?a0x1c2R0aEQ5bHBRaGhrVnl4eGxQNGhqZTltaFdLZGpLRUk5czIwTGM1N0FF?=
 =?utf-8?B?aksyRXFkMFFkc2hRL3UvdmFvRFBiRFhRM0ZpUUdUOHAvUjdiZ2ZSUGY2UTF3?=
 =?utf-8?B?UzZVaU1vS2JRWjZ4aWtBVG54aWFhVXNLbjJMdG9vSlZJMHlSbjFNYmR5UkI2?=
 =?utf-8?B?UWM4Yk80Nlk4RDJIWngvS09SaDVPd2paMTlldkpJSXlvSTV3eGNIc0JiOFpp?=
 =?utf-8?B?a0xrQTJRZ0RmdUtlUlNMeWZKbEFPRUxlV3lCV3UzeHJ1UEtEQjJZYlR6cEZE?=
 =?utf-8?B?UWxabFN5VGxEV0NTN0VrRzZlN1ZDSiswZituT3A1ZlpGVUpISHY1RkRQU3du?=
 =?utf-8?B?b3ZZOWRRNmRJZzliNUgyODNZajN3MnZsMFg4bEo2bkY5VUd0eW5PQlhlNnpm?=
 =?utf-8?B?UjE0ZzVReEhUc2RLcFoyWlpaanI2SEZ0dlpESVUzWXBVYjlacGhIUEQrOGhQ?=
 =?utf-8?B?dFR3T0tiQkR2NlJHc2RTS0Z5TW9nTWczbVpxNGdXNnVGMjVHMkZ2cU1URFY5?=
 =?utf-8?B?S05uZXJiQW1BcFd6cFZQQW1pZzhHQ05lQmIrWGZHakxiN3FOVGptaXd2THhp?=
 =?utf-8?B?Ym53eVVHSi9tYkI4enA2eUpYeGxCN1k4eUpFVG5mbDI3VUVpMkZ4OWVlcXZn?=
 =?utf-8?B?MkdTamFBOU5ES3B5ZlU0WDc5SjhHbDdNZnFuRkVDOXZNVllDYjVFenZadE1D?=
 =?utf-8?B?MHdJQXRNUEpUM1c3NnRUbi9QYWVBbzFWTU5EeG1kSXVyVVgxajEvaDFqRkhD?=
 =?utf-8?B?ZzBvQ3UxSmdGYk85M2sxYWlyQUlZVTJTMDY3QlBPUTNFbmxBaGxjeDBrZExQ?=
 =?utf-8?B?VnkvYkt3ZGxBZjkxZTdkS3RROEswTXdLTVVLOHZCak5LejNmQVA4dHBBNDBz?=
 =?utf-8?B?dTlpa0x1NXlXUm5EUmJ6Q3FSbUFPQkUvY0hIQTRuMnNYa0N6akNxUEVCYk5D?=
 =?utf-8?B?dlZNaXF6Nkw2b3NKd0svUmdYc2dFek0xY3dlM3RiNFEzS1huVlpNU1IrM1pp?=
 =?utf-8?B?VlQ5SkhoNmFQbGE2dzJvUnR1MG83SzJEVUZTSFpCNEJJNnNsSUdTVkZzYlIy?=
 =?utf-8?B?WnAvUThJcURCM3dtTm1PYXpqUTlEQ2p5ZUYxOXFQcDFxZHNwRmZwd3d3WFpZ?=
 =?utf-8?B?S0hseW1ILzlnWVB6ZzdtMkJDMnpJNys3cDQ0TDN4dDJ1Nm5BcGwrTERDV1Ja?=
 =?utf-8?B?RVNTWXZyMDBrNnVLcWxMOFZPNmRRd3V5ckh3RFJ4K2Mrd01hWWpkbDBXYm9T?=
 =?utf-8?B?ZGFjVmNkdHBFbjZPa1VsdnhPaVNhQ1U4VXBJenFPME9aVnlIQ3Q5STBzZG42?=
 =?utf-8?B?a1FCVUtKV2NIZHdwY2xYSnF3SFpoMVJQMEJmVFRONkppUzBBMnI4aHF4MzJR?=
 =?utf-8?B?TzBEVFl1bmttZ1dRdVdGQnp1dXpuMDBRVFdzS1k3UTdEbWVGNFlMQ0U1QzF5?=
 =?utf-8?B?aVk1RUZMUXN3Mzk5MTF0ckkwbE1DbEJ4djlselViSXhWekdoMnpyYWJSaE0x?=
 =?utf-8?B?YVJsUlZHckxCVENyYUlaaEVHK2Q5ck9QaTdBM0YzZmQxYWdCaFVwS2ttbG1m?=
 =?utf-8?B?dEczTFVoeXpITmtXNVFoNHlHOFpKVUFCVG14REpIUElZN1plVk5VdUZlZElS?=
 =?utf-8?B?RU9SMUJleHBpeFZyMXJzMmsrZ2pRVXcrTXlEbUVLVDQ5M3cwSHd5R0FIUUls?=
 =?utf-8?Q?obNFXe3KqbFy4TFA1V6zd+/2U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb96650d-247e-4217-13ce-08dc715b5c57
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 01:40:38.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDHRB/j010K2hET6r2I+8hwpzcaBjk4lgXph5q4XtVqdwdrb9lALi7XPDTipmc8U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820

Hi Reinette,


On 5/10/2024 1:34 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/10/2024 10:01 AM, Moger, Babu wrote:
>> On 5/9/2024 10:18 PM, Reinette Chatre wrote:
>>> On 5/9/2024 3:34 PM, Moger, Babu wrote:
>>>> On 5/7/24 15:27, Reinette Chatre wrote:
>>>>> On 5/6/2024 12:09 PM, Moger, Babu wrote:
>>>>>> On 5/3/24 18:26, Reinette Chatre wrote:
>>>>>>> On 3/28/2024 6:06 PM, Babu Moger wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>>> + * @mbm_assign_cntrs:    Maximum number of assignable counters
>>>>>>>>     */
>>>>>>>>    struct rdt_resource {
>>>>>>>>        int            rid;
>>>>>>>> @@ -188,6 +198,8 @@ struct rdt_resource {
>>>>>>>>        struct list_head    evt_list;
>>>>>>>>        unsigned long        fflags;
>>>>>>>>        bool            cdp_capable;
>>>>>>>> +    bool            mbm_assign_capable;
>>>>>>>> +    u32                     mbm_assign_cntrs;
>>>>>>>>    };
>>>>>>>
>>>>>>> Please check tabs vs spaces (in this whole series please).
>>>>>>
>>>>>> Sure. Will do.
>>>>>>
>>>>>>>
>>>>>>> I'm thinking that a new "MBM specific" struct within
>>>>>>> struct rdt_resource will be helpful to clearly separate the MBM related
>>>>>>> data. This will be similar to struct resctrl_cache for
>>>>>>> cache allocation and struct resctrl_membw for memory bandwidth
>>>>>>> allocation.
>>>>>>
>>>>>> Did you mean to move all the fields for monitoring to move to new struct?
>>>>>>
>>>>>> Struct resctrl_mbm {
>>>>>>             int                     num_rmid;
>>>>>>             bool                    mbm_assign_capable;
>>>>>>             u32                     mbm_assign_cntrs;
>>>>>> }:
>>>>>>
>>>>>
>>>>> Indeed, so not actually MBM specific but monitoring specific as you state (with
>>>>> appropriate naming?). This is purely to help organize data within struct rdt_resource
>>>>> and (similar to struct resctrl_cache and struct resctrl_membw) not a new
>>>>> structure expected to be passed around. I think evt_list can also be a member.
>>>>
>>>> How about this?
>>>>
>>>> Lets keep assign_capable in main structure(like we have mon_capable) and
>>>> move rest of them into new structure.
>>>>
>>>> Struct resctrl_mon {
>>>>              int                     num_rmid;
>>>>         struct list_head        evt_list;
>>>>              u32                     num_assign_cntrs;
>>>> }:
>>>
>>> This looks like a good start. It certainly supports ABMC. I do not yet
>>> have a clear understanding about how this will support MPAM and soft-RMID/ABMC
>>> since the current implementation has an implicit scope of one counter per event per
>>> monitor group. It thus seem reasonable to have a new generic name of "cntrs".
>>
>> How about renaming it to "assignable_counters"?
>>
> 
> As I mentioned in [1] the "assign" concept is not clear (just to me perhaps?). It
> really seems to be the marketing name percolating into the implementation. Why is
> "assignable" needed to be in a "counter" variable name? Is a variable not by definition
> "assignable"? Why not just, for example, "num_cntrs"? I believe that things to be
> as simple and obvious as possible ... this just helps to reduce confusion.

Ok. That sounds fine to me.
> 
> My previous comment regarding counter scope is not addressed by a rename though and
> I do not expect you to have the answer but I would like us to keep in mind how these
> "counters" could end up getting used. We may just later, when soft-RMID/ABMC and MPAM
> is understood, need to add a "counter scope" as well.

Sure.

> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/0d94849c-828c-4f10-a6f8-e26cc4554909@intel.com/
> 

Thanks
- Babu Moger

