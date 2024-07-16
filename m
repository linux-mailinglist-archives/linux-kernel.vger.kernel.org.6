Return-Path: <linux-kernel+bounces-254241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1919330A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557652838E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BEE19E801;
	Tue, 16 Jul 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v1FXBTNH"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28AD1B94F;
	Tue, 16 Jul 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155692; cv=fail; b=DsjDboVeZwo3VEfOFqrjkjw7VkONYM2QgNXLrOtfkPqm99mBvZGvORi3KH1M361CoUYuSf0SVy+GUOexGxOntTnavURews5fWhbpWrYwUeoyXYh3pD/CjzrjYoD2pUPRRBe+D9ows2fcDC3282Ib6wkvKtQ/9R1MV+JsBRRdn8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155692; c=relaxed/simple;
	bh=kGmVQ4V9PEIRKZMrdjvstIjnNcoAgoAmE6+YX3jXDOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KypHozXetuM6IK1BQRcrpV8V/HAPtlevE1yiH1V8RB6WCuxOfRU1hx4bhUhYrKAJPw7pBJxpddWUcHGMRWYnGo5VfhZgPM6g4WOQbxs5fvlDR2nGDLO3fuctmG74g++rLWyqRx2Cw7JTP0Nh7fWqbbqyrCwqH45wayczpXitIUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v1FXBTNH; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2oABIkTPaIiW1+mp+UcNTehsbpcjdR8kPNMi0SosKrXyq2f91zAkulkxV9l+igsBuY6xZKSrr5n95cZY8crIrB7Q5EpB8R2lYAObwe2f7sf19IyoUf5dEFycQm9DZs59z4Mb5E/oWnul5f6wU7JVOCfQMA2ueL86m/yL445Bg9o0pMS7qY8wDXxzf/szqHO4KGtLEJzNjuMfMUmUUJtgYbGLqbtwipHtYnrmgT+Xq4a66kPq5VoLpU5UJOhxDYb1cJJqkJYY+lGDpDBHP65d+56RZysuZBxnTpW5bIVvGZ1Aaavk0Du9O0bjYqI+j+aPsAB6qrVkkDHtDu8sQO3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8N6TlKlKaxES6kfVAHjDEEsI4V+bsDt5vA9NjYfEgM=;
 b=A8XoUxT03MzPXGc7iOeroDxIZjoRcwLw7trKGJLpBTEUcFpGxsDvvqT2ubjMXEr9VmZjIpOELOGiXbkuic9KXX6Rmeglw2mmQMENsCVQuxC0yf8XOrj/xU38LZQK8ho4SYQtpxKMo929Nw/NqZYK1m1MPUNca3a4L0ETNmLVMqDk+CeCTnMHj832XP2KeqrrcuhzVJE0J5i7swhd2Lk6BveugMTf3T7tretLhv5u+0OSVPmgmewYR6G1VBbzrOSXIZ9FjE1xckvL7ppF6zUDSKAB+Fctsnc47o7PFuiL9V+qXkACKlcD4rqtJYr2riGhPmDnAVNmaREsInnqZH6bjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8N6TlKlKaxES6kfVAHjDEEsI4V+bsDt5vA9NjYfEgM=;
 b=v1FXBTNHfvF+FBR7IPn5zCDOLCJoPDSDaS7Gk6Ja3avLUzxdQiWtuiUFoShuk5C5Y0Ye/zxEOwR+I+xxxPDq3RvqDmKcEB6GUWpdn4QvPrFpuJ2qMg5A0hpQTXDLE9JleeChTZLP7TNNKybG3T5pxGFWHVrshtxbYmWP8mi9DOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 18:48:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 18:48:07 +0000
Message-ID: <892693a7-1a1b-46e4-a989-052a19566231@amd.com>
Date: Tue, 16 Jul 2024 13:48:02 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 06/20] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <ed24fa5b599d6f0abe53a72613f7afd2dc9aeb1c.1720043311.git.babu.moger@amd.com>
 <ca8c5934-c531-4d5c-a765-8722e0eae5ba@intel.com>
 <706a061d-c9bf-48d5-834c-67ae1ba4729d@amd.com>
 <5e9d6516-abe7-405b-8db9-52c381559c58@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5e9d6516-abe7-405b-8db9-52c381559c58@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0049.namprd05.prod.outlook.com
 (2603:10b6:803:41::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6247b8-0331-4dd0-5bf6-08dca5c7d4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L211NERLWVNVME1mbGQ4MkhsK1BNSEtmSlI4YjVGQlg1Y3RWWjl4SkRHZHFy?=
 =?utf-8?B?U3NRUjVQekN5aU5IWXh0NlR1cy9CdkVKZjAzdDBlNjk4bFpac25aM0V0YlBm?=
 =?utf-8?B?NVFTSTJFNE5GMW1VQXZqRFJMVkQxamUxS3JCc2hUbnpDOGRBYjhZZUNGSVZr?=
 =?utf-8?B?SG9qYU81dGRqb1d1UEN0d2xQdjhmUnB6cytTbm03aHBpOXNGUDhyU2FHQVo3?=
 =?utf-8?B?blNXeVV0dUtHeXhTaEgxS0tYTlY4dmxXOVV4R01JNWhHRW5Ua2lrMCtmVW5s?=
 =?utf-8?B?NUlDR2I5N2dCT2V3Q25uSWQrT0d6R0JTTDg1OEx4VkU3eG1BbUxvOFVSQlQx?=
 =?utf-8?B?SW1TQXN4Nm1sZVJTSk5VOG9CL0tLcXlQbm5rdlovNmxYSzk3T0o1N1dUb3J5?=
 =?utf-8?B?NDF6cldYb1Z5T0wvN3F1QzF1QURQeGZiL3ZGdU1zam5pSnY0TDJkdm5ud2F0?=
 =?utf-8?B?bEdlYVJiajJRUFZWdjJzWDBtVmYzL1VnS2tnYkUyOE9tdTJUb2xocVZ5eUxB?=
 =?utf-8?B?WVVXT2pYNUUvZ2grUjNnVkorclcvYWNmY0lwNUxZeFE4ajN2N3hROXgrQVU5?=
 =?utf-8?B?L1drVkZTb0x5WVR1VFpZQm1Pbzd2QUI4Wk1Ca1lDRWQ0SFZvK3JKNHhpaWJQ?=
 =?utf-8?B?VzVuaXRUS1ZIZjBEcm56bHpVUVZCVWpwRC9PeTc2aHg4MXJaaVdoSm5xT2hp?=
 =?utf-8?B?Z2RQRFRidmVqRUxKVlRVUytlazRmQkkzSWYwcGlscXEvUG5DMUMxVVZmeDli?=
 =?utf-8?B?ZnUzYnNrTk1NaHVwcG9Fbk02cU5XZEw4TlRRaFZBN2E4VElaRWNqZS9aTU5Y?=
 =?utf-8?B?c09ZaldaSnhIMStST0JHN05HMkxPS1hoejBFTlNNTTBETnNVR3VVdHNBNm9O?=
 =?utf-8?B?K1lRMVFEMk9wQmIyOVBqVExZb20rQWhrM05IRnU2ZFBocjYveURMZ2Ywc0Zx?=
 =?utf-8?B?SWJlMzFSS0hML3A2NlM3SEtWMkxhQzVJTDlZbXBIUG01M2VjNjgvRUpwSjBr?=
 =?utf-8?B?VTc4QnF1RjQvZUNkUjNOTFdPTW1Jb2xLcEQ4MmtUR29vemFuakNXVG43SGto?=
 =?utf-8?B?cTFsaGMyNkczQ2lGRm5LQUdncXl1aEJNWnNVbTJSMGZDeU9JMWRPOUN2ZWlG?=
 =?utf-8?B?MWhIN00xaGxQd2hyT1JUUHRsdzMzS25EVEZSTE9aZ0NPWm1YT0lTZnpUbkth?=
 =?utf-8?B?d2xSRXI0eEVmUHZ2WkE2Ri9RQTVZcXRKU1JYL2ZaZXpqbXFyaGFONzRyNU5C?=
 =?utf-8?B?OGgra2V6SXhHZFdmbVBWR25CNEx6cEdIUnE1YVYvOVhiVnZxRUpNZWhDRkZm?=
 =?utf-8?B?ekovSmtYMksxTkJQZEp6azJPY2pMQUtPNFJ0MnJkMSt6SmorMWZNelZsaWdB?=
 =?utf-8?B?ZmtJMko4SG9zWUM1MFdpVGI4ZFNZL3RPamZSdzdFSXB6d1dxOU9EcnJ0T3RN?=
 =?utf-8?B?YkVLTzFwdU5kWXl3M05EazdWbjhoL0xGM3JyOG01dG05czhWQ1NCaTh6RTZ1?=
 =?utf-8?B?RGJhZjhNQ3AySndLWlJCR3ZwQ1NSbE9mLzFkNkI3aExJemp4bWR5OStvdlZM?=
 =?utf-8?B?Vms5YWcyM25HbmhYaXhoemZsek92djJHSFV2SzE0QmZBaXFuSXhTMTcxcU9w?=
 =?utf-8?B?d2FkdlFMdTR5OFJWa3JpZWEwaDdiTVRNNTdqQjZXUldxdS9NeUhiV1lCV3pF?=
 =?utf-8?B?NEdnWDZhK3VnZU0wVXZtQzFnYjFaRXp4TGFvNWYwV1pVQkoyMmVEZjFiWHNP?=
 =?utf-8?Q?FePjOM+HLAKG51aRRg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWFwK1llNWdBZTc3S1U4c1VnVTI2L2xIVmIyaWY3dk9HK3I5UWJ4Mm5FdjJ6?=
 =?utf-8?B?M3Y4TEY3UUkyOUIzeFJPVjkwcm1Zak1GVFc3K3pIQ0tzUzlMd2hpSlBTNmhl?=
 =?utf-8?B?VFd6VFN1TU9QY1ZNYjJxM2cyeXlFQVhZWWtNcFlRNjhKVERaZ0s5MENTK1Zq?=
 =?utf-8?B?ckpRRWdEcWtENER5WURvN2tOcmdJMGlTSm00ank0STJVZEE4ZXlmdVJNRTZ4?=
 =?utf-8?B?aGZHUkxpa2R1aXl4TmlMYTRsQ0d2NllOTkJ1QzRWUmZEanJ1UmJCZk1xeUUv?=
 =?utf-8?B?M3RyeUFsdTV4NVVOK0puWmRkZkV1OTRSakNRMVFPbk1yTC8xSUZoWHprMXBZ?=
 =?utf-8?B?MDRZREhGd0VHV3A1VmhlSzJyQmh4VUljVklWbVZKUEJTQVE3dVd1RVVoTVZ4?=
 =?utf-8?B?VnovRjB2UWQ0ZHE3UUQrekVuakpEVnhlVllVNy9HNG5HSlRTRlFHRlhuSVNX?=
 =?utf-8?B?aW45SzZ0T0pYK05uTDRDK0hEaXgvVHpCRTFZaTB2VHdtWEh1L1VBR1hNTlVS?=
 =?utf-8?B?OXl4UUhyTkhlVEhnVDkxU2svR0VqdFBWOVFUTzZxQWdVL3JSd0JJVWRteVNo?=
 =?utf-8?B?UGJRdTRZeUkzOGZFRm0zenRIM1JLYm5BbEJSTkI2NmNpZjd2b0YrNFZQaDc5?=
 =?utf-8?B?cGFiTTNGbzFMd2FPQ0JGRU9GZkpmM1pLZnJhOHZDR3UwSzJXVXJ0N1pibXdI?=
 =?utf-8?B?QWlwajNacitLSzBYRXpidUZVNHVqMHRObUNvN3E0dUZHRlJDS0E3WW8yb041?=
 =?utf-8?B?bTdtSWJLRDJSOHhvY3ZTV2JPc2N1UFUwbGhvc1BUMWkwTFpzWHZSK1FjSXJC?=
 =?utf-8?B?eWRuRG4zc0htSm9ROHlNUnpRdk4vT01vVVUvOU5XU25oYWpDUWFZTU55dllO?=
 =?utf-8?B?SHNTOUlMcXNlb0NSYWhFWkVmaC9OekN5WjlzQUdNdzJITjY2OXNSMlFsY3N4?=
 =?utf-8?B?OG9ndTN0NHJxMEQyUmNXS1FiWW9taE1QaEZFa0NTcjQveWgwRThmY0hYMWk0?=
 =?utf-8?B?MEpvZFVaMjZabjJMWjM2empDUGFXa1dOM2ZKekFCOS9SdVl1UkF3VUZJWXZh?=
 =?utf-8?B?WTFlcVN6eE5JNlhaQ3lMNnZqTjNKaXRJbnl2dDc3WVVTWGxUSEVRWEJRS215?=
 =?utf-8?B?VzUyR1BHbWhFL1VIYVZCV1B3NnJUQWNEbU1nSnhuSUhJT2NCb2ZGSXJKUEgx?=
 =?utf-8?B?UHNaYkdSbzlaTll4THR3OW1aRGpjbGhSYUdTRHJLRGs5VG52Y1NzVG5QUHRx?=
 =?utf-8?B?Tml0RXRpKzk5aTlWbW1wc0k3RGFWdmsza2xFS2h1NHE3ZEhnN3pFdU5WZ09X?=
 =?utf-8?B?RlZEQmFEcjhVSXhNV3pjUm9QVEo1c25iZ3pnaitqdVVoak9wSXNVdytCbnF6?=
 =?utf-8?B?UjFXVXBUcWthamFIZXhBUFpLTmpMOXM5L1lBVWdxNm1KOUdZUlJidEdXWVJF?=
 =?utf-8?B?cnB5YzF5Mm1GeWNaT3BVanFkdkNnV01RVFlqNkRpbm85ajNyckdTNVdZM0FS?=
 =?utf-8?B?ZW5xempwQ1hzYWNvbHQ1c2JiUHFjdFIyWG1JanZjZ0QwS3I3ams3NkkvTlNq?=
 =?utf-8?B?ZDdWcThLOWt4OUNtSnBzMThZNytETmRSUzhsYk5HY0pjL3NraUZKT3ExWlli?=
 =?utf-8?B?QnVyT2p5NzNjWGZSMnNzTzMzcGVWRDJTTFNRR2JNSHZBaHNTdlI2YU83bXVV?=
 =?utf-8?B?M3dFUFFBbmJUQnpKRzg5cU5hTzdsd0U4U2JLaEVvVGY1RUtoUFBpVmQreGpI?=
 =?utf-8?B?YXRpeGROUTdHTWlyQVBzb2tHR3BZWGhmVEl3V3ZTL2Q2UkR4eGN3ZDdOWXFi?=
 =?utf-8?B?bjR2SDlXWExJU3pOUWZseEV6R2hFNGRxSWdyUGE2ZUY0cFlNS1NkVmk0K2Y5?=
 =?utf-8?B?cXFIL2V5cXFSbGYxbHJvY2NVRy9keXFsNFJzR2djNDRNcmIxOXZwR1VjSE5K?=
 =?utf-8?B?RFIyNU1xeFkzZjJPbWlyanNKbkJ4S09Rbm1FTDVPWEFZYTBmUmFsK0JKTHlY?=
 =?utf-8?B?UmFwdnRDS2ZpdUFRTVBCRW53aWwrQ3h4OUJFbjVxZkhlMHE2OGJwR0dEWkdG?=
 =?utf-8?B?eXRCRUNPOWx5NS8wb0dlR0ZEQmROcXJhWGJJd0t6MzNRdDZJZ1NxNXJhYUNl?=
 =?utf-8?Q?xSRk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6247b8-0331-4dd0-5bf6-08dca5c7d4fa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:48:07.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYPWsmefqqiIvfhY60340AXIFX67MTdl6M0xg7XUGc6mvhQ2LyD5re17jIc9abii
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686

Hi Reinette,

On 7/16/24 12:51, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/16/24 8:13 AM, Moger, Babu wrote:
>> On 7/12/24 17:05, Reinette Chatre wrote:
>>> On 7/3/24 2:48 PM, Babu Moger wrote:
>>>> Add the functionality to enable/disable AMD ABMC feature.
>>>>
>>>> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
>>>> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
>>>> to be updated on all the logical processors in the QOS Domain.
>>>>
>>>> Hardware counters will reset when ABMC state is changed. Reset the
>>>> architectural state so that reading of hardware counter is not considered
>>>> as an overflow in next update.
>>>>
>>>> The ABMC feature details are documented in APM listed below [1].
>>>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>>> Monitoring (ABMC).
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>>> ---
>>>> v5: Renamed resctrl_abmc_enable to resctrl_arch_abmc_enable.
>>>>       Renamed resctrl_abmc_disable to resctrl_arch_abmc_disable.
>>>>       Introduced resctrl_arch_get_abmc_enabled to get abmc state from
>>>>       non-arch code.
>>>>       Renamed resctrl_abmc_set_all to _resctrl_abmc_enable().
>>>>       Modified commit log to make it clear about AMD ABMC feature.
>>>>
>>>> v3: No changes.
>>>>
>>>> v2: Few text changes in commit message.
>>>> ---
>>>>    arch/x86/include/asm/msr-index.h       |  1 +
>>>>    arch/x86/kernel/cpu/resctrl/internal.h | 13 +++++
>>>>    arch/x86/kernel/cpu/resctrl/rdtgroup.c | 66 ++++++++++++++++++++++++++
>>>>    3 files changed, 80 insertions(+)
>>>>
>>>> diff --git a/arch/x86/include/asm/msr-index.h
>>>> b/arch/x86/include/asm/msr-index.h
>>>> index 01342963011e..263b2d9d00ed 100644
>>>> --- a/arch/x86/include/asm/msr-index.h
>>>> +++ b/arch/x86/include/asm/msr-index.h
>>>> @@ -1174,6 +1174,7 @@
>>>>    #define MSR_IA32_MBA_BW_BASE        0xc0000200
>>>>    #define MSR_IA32_SMBA_BW_BASE        0xc0000280
>>>>    #define MSR_IA32_EVT_CFG_BASE        0xc0000400
>>>> +#define MSR_IA32_L3_QOS_EXT_CFG        0xc00003ff
>>>>      /* MSR_IA32_VMX_MISC bits */
>>>>    #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index 2bd207624eec..0ce9797f80fe 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -97,6 +97,9 @@ cpumask_any_housekeeping(const struct cpumask *mask,
>>>> int exclude_cpu)
>>>>        return cpu;
>>>>    }
>>>>    +/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature */
>>>
>>> Please be consistent throughout series to have sentences end with period.
>>
>> Sure.
>>
>>>
>>>> +#define ABMC_ENABLE            BIT(0)
>>>> +
>>>>    struct rdt_fs_context {
>>>>        struct kernfs_fs_context    kfc;
>>>>        bool                enable_cdpl2;
>>>> @@ -477,6 +480,7 @@ struct rdt_parse_data {
>>>>     * @mbm_cfg_mask:    Bandwidth sources that can be tracked when
>>>> Bandwidth
>>>>     *            Monitoring Event Configuration (BMEC) is supported.
>>>>     * @cdp_enabled:    CDP state of this resource
>>>> + * @abmc_enabled:    ABMC feature is enabled
>>>>     *
>>>>     * Members of this structure are either private to the architecture
>>>>     * e.g. mbm_width, or accessed via helpers that provide
>>>> abstraction. e.g.
>>>> @@ -491,6 +495,7 @@ struct rdt_hw_resource {
>>>>        unsigned int        mbm_width;
>>>>        unsigned int        mbm_cfg_mask;
>>>>        bool            cdp_enabled;
>>>> +    bool            abmc_enabled;
>>>>    };
>>>
>>> mbm_cntr_enabled? This is architecture specific code so there is more
>>> flexibility
>>> here, but it may make implementation easier to understand if consistent
>>> naming is used
>>> between fs and arch code.
>>
>> How about "mbm_cntr_assign_enabled" or "cntr_assign_enabled" ?
> 
> My preference is to keep the term "mbm_cntr" to be consistent with the
> other variables/struct members to help when reading the code.
> "mbm_cntr_assign_enabled" does seem to be getting long though.
> Are you planning to use it by assigning it to a local variable with shorter
> name?

Yes. We can do that.

> 
> As a sidenote, I will be offline for large portions of the next few weeks
> and thus unresponsive during this time. I'll be back to a regular
> schedule on August 12th.

Thanks for the heads up.
Thanks
Babu Moger

