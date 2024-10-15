Return-Path: <linux-kernel+bounces-366648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD22399F83D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29FA288C52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020801F8197;
	Tue, 15 Oct 2024 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ACODnLbh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158A1F8183;
	Tue, 15 Oct 2024 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729024840; cv=fail; b=KMqBPGpE/wzgwI02wJoi4GFvnZll/WR25Ek7wPA857cfIGdlWIxZYTb9UuN2azQih2QGVNkBNqNlBZOQ2aTIrtLYsiJ0hMU9U4z8kIA4wfTAVJeghD5527NEDPTXrpfqOObc4S+vXwBglI1K1NZl0DZOMHcpZ/adIU9Vl3mYkis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729024840; c=relaxed/simple;
	bh=NrhVzf+OKSRf1uZjLDrPBe4bNjz+6QssRRY/oGNH3wc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SbSMRjssTKM/F1QU8H55YtDeEu8H/kcLfv1PwyvgsHPQZ6UkjXexKLkJvJPusZlxflUYvrr3iSKYjURlW6+MYV2f6Xyy1CTzQ1eKOcPQrABskpOJii7AdbmyOyR43orkiU6UOObjr5BUUAorvTurnWL6cmLc83eMY5VhFDyWc6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ACODnLbh; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByLMO9KiaV/NYAiN8B5W0dMHWNw/ttzIYMU1CZ8NEJkFy8SRAF+gK4f2/UzAZoypVMEYryED84k289DYyxlcaDFDaDfKUIzdsTqid22Zll9eQ79f/ltLa9/YjsOhV2N3klztIVI8XLYdM2tcbFzyHgQowGMQt0qH5QoK4huSPhIwzr55h9gTVtwGw5+pqAJR9YBWxsKrS3Gvaz8KShTSvLKKyuRJe+Y5UUXjLu9QT4lZdd++IzIIIDm0TQQS1N+IG4ogLDfZtkdSp/ysfFrH3W1qn0fs+HYgeFFY+uSPn3s2YJmMmyfW+xR7s9KpdAvR2fdr0tY1nzGjbuCOgO9CpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTnzHCM0sGv4fdnrjc/d9bGyhTwd4verzqvVTaaJDV0=;
 b=ooRzk+ank6p1BuHoT1eVJ19WTUNo22YwrogL9WITYzdza1o1+T8VXRsID17eLueiBkeMu/rlM8JtKEmuWGWaGalV4LYDvAiXCKx8HPdJzltW14wvgNd2OywyPW1xGGya8oQAfd4OlHyqVz1JaMFklfBVrUvo29g75Im/BQdju5F31+h0rSk0ddOGXTFeG2B/PwPmtBNldE7WlW9z9UQQvS7p1WhLZCorZDhSreYwDiTq1v6tCkfOeFRbwKrHPMwFUFLps8bWoiaYTjvFTrtWr7kP9lqvrJ1GQM7EYL80pY7wHMqwGRRFEKzufSz9bXwJ0WM5DT2Q3mejyXRZes3kbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTnzHCM0sGv4fdnrjc/d9bGyhTwd4verzqvVTaaJDV0=;
 b=ACODnLbhQYdQAybHgp9fAoWfSY/UQLhHsMmxsDbZC8Rz/hYkeOvusagXaAC+YO3w96d7p2MIgdNCrg55pZ2/RMJnoYFqBfwy8C29TMkrw0aq8qKDbL24Gaw5ky4N6TAhPllHPPAkDUe1GXRFOZJNO3tWGe4stAGDV6kuiAvkZu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 20:40:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.029; Tue, 15 Oct 2024
 20:40:34 +0000
Message-ID: <bf67bc4e-9cf8-4cac-9ffb-2d4f81ab7e30@amd.com>
Date: Tue, 15 Oct 2024 15:40:30 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 3/7] x86/resctrl: Introduce sdciae_capable in rdt_resource
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
 <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
 <254da029-81b2-4745-bc78-5aefeb33adb0@intel.com>
 <b96e5de8-75ce-4a7a-8788-f5d3a959d771@amd.com>
 <89da43fd-69fb-48a6-830e-e157360aeab6@amd.com>
 <dbe8a012-eb21-426f-a8e4-46efee26da62@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <dbe8a012-eb21-426f-a8e4-46efee26da62@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0163.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 276e1f1e-9f92-4e5a-4eeb-08dced599e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzFhNkZjSlFCZUlzQUZGYjl5WWpZUEZEZjc0ek02RGNqZnFXdEZ4OERIWGVs?=
 =?utf-8?B?OUVicmNqYnl2dlllUHJiMWhJVHBQMkt6ZlNISjAwL0c2WGtrRGZwSkwrSXky?=
 =?utf-8?B?Q1MreEdDZSs2bjBaWWJiY2ZkdklOR0kxS1FJK0FtZ3p2aWJhK3hKaXo0YWtL?=
 =?utf-8?B?a3hVZkM4RnpmOUwzVXZHSEFzUnNYekxKQWdZeUxIRE1UM29XSDRkSmh0bTFE?=
 =?utf-8?B?bzhyaXpOWTNTY1c4bFNWTlNoQXVxRGtrRWVabHJsbXJaRlMxaTFPMHgyelB5?=
 =?utf-8?B?S2tDZmF6NWFtVktTVXI2Yml4emlHZEpNcUFMd3VXTG0xRUVHMWhUWnlNM3FR?=
 =?utf-8?B?S053K2JDS3NrR3RiR0xWWXZ1N3V1VWhiN1VjOHZYRmtvdGtpdnNnQllUL3M3?=
 =?utf-8?B?RWU3NjNGcmN3T3lHNC9pWG9MMysyOENRUzNlRjZPV2lESllCTnpWRFg1ZzhD?=
 =?utf-8?B?dXBRWkE2OHYxRUFLUS9TOTNUUG1SOTl6bGZxbUMwTUpQOURXSy9MbWxKYStp?=
 =?utf-8?B?dklTS0VJMjZUTWlLdmlIWFpkWEVyT0VncjhNTFl0NVVsL2lkZ1lJMGsyVFdn?=
 =?utf-8?B?TTVINDUvSzRBZHdPdGRuMDYxMnFVTkUrd1poL3J6MDRuekZVbTF6Uk95MHRz?=
 =?utf-8?B?WDd3TGNTUWlneEo3TWtZM2lwM2w1eUtja2ZGOUJZK0xvLzdGQm5HMnpaNW4y?=
 =?utf-8?B?amxySVRvb3pjUHAwSHBUZ0Z4ZnZHQlVMSnQ0dWplRDFLa1gxQjNyd3JyUmhX?=
 =?utf-8?B?dHhROFk5WjRFYms2ekEybGtNWTBkdkZERUxhUUFwMnpIc2syenNTdEZDWU52?=
 =?utf-8?B?RDhKYTBpWVJaNzVaQ2lacnRMMTJiT2phZURra2crakhWeHRlcWJ2MklyWXFC?=
 =?utf-8?B?aVp3QjRGTmprTmVxdFdzYlBZODhTc3h5TDZuM0FHS2FOTW54Rm1NU3ZuUWhI?=
 =?utf-8?B?VVhiUVZMaVEzU2NiSHVPWENkZGdqQ3FLclY3WGNKU01YZzlKRmlCaXFzd1Vy?=
 =?utf-8?B?aUR0cDdRRUpGTjVNMUZWLzJnTzltdzlyOUFmbkswbUp5NWM1elVJRGdMdVl1?=
 =?utf-8?B?Z3Q5RnVSQmdCT01oMExzMm9qdFpqMWIvU0srNTMxditpLzVIenEzeldUek9j?=
 =?utf-8?B?eXczUVBsUm5QMUJzd05wdktWRnUvaG5GKzAvMk1GNmtvanpoeGNJTi9CeVkv?=
 =?utf-8?B?RngzSFZjZEllTnN5MEZNK3E3UUFjWUsvajM3QzFRNkJVd0greVFPdUQyUU9u?=
 =?utf-8?B?ZktrT3JaTkFjWDZCbU0yZEs4WGVlM2dST1dkZk1WaG9hRCtZQ0sxL3NnUDNV?=
 =?utf-8?B?aVFZSzJPRU8zRy9UNWlsVHhrSFhDMXJUVHYzTDlsU2hyQlkzaGpHYlpQY0Zi?=
 =?utf-8?B?SkNZSUhraHlJcmRzMzlhbGtnZ3hGdzEreFBKQzRRNlE0Y0NMVUQ2bVNkdzZw?=
 =?utf-8?B?UU1wYUVoZVA1RXZ2RW8wWTlKQVRWMUhGUm44YytvU1dyMDJWdmdZR1lwaENq?=
 =?utf-8?B?UGNmQmVrWndnSEJBT1FoY0I5MWlpam1RNUtNdWN6MVNhRFN6ZTFrS3lwT1R0?=
 =?utf-8?B?S09uaW5BM0FQWU5jVzhaSEZqa2ZVOE5PR0tzUElyTWRqNUZqaHRmQWpYcm1F?=
 =?utf-8?B?UEVuaVlWOHZuaDBOM2dEY2k3SEJqZWsrUWQ0bEtGdlZZNytGSmhLUVFJT1Nw?=
 =?utf-8?B?ZGFjNTFlc3JUejNnb2o0L0R0NlJ6emZCTTZEc2N1VG1wV1l0bzU3OTlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azFESEgxUEx2ak1rT3JHa3NadkhMUjdhOWF1VytmZG9qT1BJY0xYSHpFUW5o?=
 =?utf-8?B?dFhXWSs3cnJocnJhU0JoV3NUOEhrWklJdkYxdWxlUUhaQ0kxdU5vL1pzMmRl?=
 =?utf-8?B?SE5FRWVjajF1L3U2TG92NTEzbEF1cGZWRGR4ODdxeHl0VGZSNFVBcW5UcXZ0?=
 =?utf-8?B?U0srcG80TlJUeENCK25aK2VicU0rYUZ6V1o2Sm5mbzBUOFJCRlVzdDlRNWxk?=
 =?utf-8?B?V1NIYzNSZmtvYStZQi9ubHdtNVpOL3RZMjNmeWF0cjAxMFlwMktTN3dkSXNU?=
 =?utf-8?B?dkpEQmJ0SVk2SGZGdmRVOEJjRkp5aElRQ0NvUit3S2NqZHlJOWV6L2htMjFm?=
 =?utf-8?B?YUU3dVJ6U0FCMDBUSStVMy8xWUI3ak1LZGpjTmgvYXF3cXNzNTEzVk43ajM0?=
 =?utf-8?B?N0hJUWJOc0h6Ni9hZDFYV28vZytmRlY2c3RaNXRFc3k3eUJ4V2tOS3B4QzFM?=
 =?utf-8?B?TkJ0V0NxZ2lqdFFjdjZqSVZIcXRacmZXd2E4cjZZYUt2Njc2VExEWHAvQU9q?=
 =?utf-8?B?Z0VRTHFJekovL0EvWUoxZjl4eFlFT0x3cHoxMG9mbVRoN1lSSm9yTC9rcXYv?=
 =?utf-8?B?dDdTS1hYeS9ST1M5SisxYUV5bzFscUJDcmpJazhLLzBPY05TbWxUbEJsNnNx?=
 =?utf-8?B?MXdRTDdQN2RwZEU3RmowNmdnN0NMcC9JdGRsemN0Sm12TVlCWk9ZVWIya2hq?=
 =?utf-8?B?bllFVnNoV255OG45U2I5K3ozaU4ycWhaT0VXdEh4RnZ0VU9DU1V1NHFVOGI1?=
 =?utf-8?B?cXFxQmtyVjFvMEFhWkhVZ24vZm5RUW5tMHYzMnJLbzh1dUdxeWVjQjk5WGJH?=
 =?utf-8?B?Z2J5ZlN2UE92dTdIZlMxd1p1NlVzWFNieXArYWN1TlJZUXZwdWlLZHVZaFBq?=
 =?utf-8?B?K0tLZmE0NFkxL3BvT1Y2TDFVSDVZZW1FY1o5U3dTcXNyUGh2M3RoSEF2bU1p?=
 =?utf-8?B?d2NLWVN1akV0aiszSGRzN1lkczBjN1hlQmMrR3MrRm11Z2JocFJJSVNWVmFS?=
 =?utf-8?B?a0FGbWE0QWRQRy9zUThKaTFEbXVQY0dxVE4vV3cwYm95M0hVcjdJQmRQcUJB?=
 =?utf-8?B?U1BKN1lKT3M1ZDUraDQyV1RyTmtNWWpiTFhhZjF6eHNTUi8rOWw3OHNNYkJr?=
 =?utf-8?B?cnBkcHJLZGZwR3dwUW16YWdqUlZvak9reWdWMGw4bUNRY1NId1pDbnRrWU1W?=
 =?utf-8?B?b21ydkRlVS83LzZWRS8wTXlGZkYrd3hLK2xCU2FHNGRLYlNGa1BnWDdibEdy?=
 =?utf-8?B?NkRXMGR3Z2Z1MzdvZVI5OTBxWGxlZ3RabjA3dzE4cDIvc1NLUXhPSkROeExo?=
 =?utf-8?B?NmxBZGExVFhCT0hzRXdvc1JUeHFuaVAzM1JGUWpqbEx2R2tjVnZabnVNN256?=
 =?utf-8?B?OVJreGJTdlRodUhRRDc2UHZNNDZqUTNWdHhQaDc2M3FLOXlCN1FhQUZRMEx1?=
 =?utf-8?B?REJBSDlESElkU0FZS1B2RUZBNDYwZzdlNms4S0l5QWVDWkhzUjJwWWMvMVIr?=
 =?utf-8?B?V3lBVFVwOHpNVENvOUhZYlBBcEUxWkRqMCtXNGRxSHh0cnA2NWtUTnR1ZnZy?=
 =?utf-8?B?WEdNV3RYaUJ3Z0l5T3dFY1FVUGgvckxzYzRxK1VMcUJRU09POTN3VWdQaThM?=
 =?utf-8?B?ZEpSZFg4VkpraGtUa2RrUkZkaDljSmtjdnY1WnIyWnBFclFiWnowOU1Zdk4v?=
 =?utf-8?B?dlZWbHNlckZGZ3ljUDBEZGdaMU5jQkJFRkk1RHFPWVlQazJwQWdUdSt1M05v?=
 =?utf-8?B?V1FXN1JzeEViTm55UzJBeGk3ZkZscEQ2ejY0N0xmSWpZbEQ4NUtBMFEvTEUy?=
 =?utf-8?B?R2ZGTHViN2ZqbHFjRmNza1VFakhwUDhURkFGSkJWME9WbW53M1BFS2FSYTFY?=
 =?utf-8?B?UVN5VkxjRFlmMjZ4aUZMSjVwaVdvSVg4OTZwZmxhSGJFWE9EQ2FWaHA2cWRK?=
 =?utf-8?B?b0w4ME5lRE5NcnVrUjY2Q2ZpQktJR2JpdnN6UVA2QjEzTkx5c1lkTmVIVm1U?=
 =?utf-8?B?ME0wcVdsVEVrT05ReXVPTXRlWEJKOTVWbTB5MUdsU3lPdHFjLzdGaXlqelU4?=
 =?utf-8?B?VE44Z0ROTHk0RGUrZSswbVlFdEttN00xbUhzQ3VmYmxZRDJBdkYvQW1SaHZs?=
 =?utf-8?Q?/qvE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276e1f1e-9f92-4e5a-4eeb-08dced599e70
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 20:40:34.7524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLUmtT4oZJEcQ8hEOK27SMbgDX1xTya+KLjS/32IrBre5yVIaeyVEm+Dbi7jsfbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210

Hi Reinette,

On 9/19/24 10:33, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/18/24 11:22 AM, Moger, Babu wrote:
>>
>>
>> On 9/18/24 10:27, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 9/13/24 15:45, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>>>> Detect SDCIAE`(L3 Smart Data Cache Injection Allocation Enforcement)
>>>>
>>>> (stray ` char)
>>>
>>> Sure.
>>>
>>>>
>>>>> feature and initialize sdciae_capable.
>>>>
>>>> (This is a repeat of the discussion we had surrounding the ABMC feature.)
>>>>
>>>> By adding "sdciae_capable" to struct rdt_resource the "sdciae" feature
>>>> becomes a resctrl fs feature. Any other architecture that has a "similar
>>>> but perhaps not identical feature to AMD's SDCIAE" will be forced to also
>>>> call it "sdciae" ... sdciae seems like a marketing name to me and resctrl
>>>> needs something generic that could later be built on (if needed) by other
>>>> architectures.
>>>
>>> How about "cache_inject_capable" ?
>>>
>>> This seems generic. I will change the description also.
>>>
>>
>> Basically, this feature reserves specific CLOS for SDCI cache.
>>
>> We can also name "clos_reserve_capable".
> 
> Naming is always complicated. I think we should try to stay away from
> "clos" in a generic name since that creates problem when trying to
> apply it to Arm and is very specific to how AMD implements this
> feature. "cache_inject_capable" does sound much better to me ...
> it also looks like this may be more appropriate as a property
> of struct resctrl_cache?

Coming back to this again, I feel 'cache_inject_capable' is kind of very
generic. Cache injection term is used very generically everywhere.

Does  'cache_reserve_capable" sound good ?  This is inside the resctrl
subsystem. We know what it is referring to.

-- 
Thanks
Babu Moger

