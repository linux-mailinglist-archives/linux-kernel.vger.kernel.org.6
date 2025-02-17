Return-Path: <linux-kernel+bounces-518103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8C0A38A03
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C08C1893036
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A2422653B;
	Mon, 17 Feb 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjOqYtnf"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38867225A42;
	Mon, 17 Feb 2025 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810735; cv=fail; b=Jgs8IaAoilkUEXQyCsEz8ZVIQDA9C7YAD76sOPPBwa3hv3c456YmXXGavjOzbaqgXk3OZOlMcg+D3/lwoA2HXcUuRQDO2ekBKw7GelJOrmb0icC77Jpjni53/okACeNv9GqcNbNiQIDa40rKnraoWtp5dkhdRQXOqdtbIKUoCaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810735; c=relaxed/simple;
	bh=xhCLCI3BMLZd+DyOT/LRPhp4XwN8a8tehd0+QvhIAek=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h0ViMrbgDRgOkgPVAQbi/DTbhgNGOIo1fr3j1S6+teIjaa4s0a7VAeaqhMv/U47jAPL//WpMY24KToEuX9IrzU6Dw6tO9tMVQduCkwVkiMxliVSkpkTFAnFzUUswtEPehWfZK/U3T7Fpf/J4UXPZNptY91X98JRkBVqtaYGkapQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjOqYtnf; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ie7QLgIfYzR0sjlFnwWcnqqbbhcl4fcuetdNrov+PUxbRT7xEvL7E4nYtVdAl3P9OeIiYZVLU7rISVXUBXtlJ4DzwYCJtRiXeMmXdD10mt2B1CNOxOU1kPLCceoF/q34XwuEXq1Yfp+O4UlsztKwIdo772Nu5/iFMoJowfPWBB+lutxjzfjL42CATcRFSvRpVg9w/OBn5DQcaXEk9Ke8iNlat9OktSYn6NnBonYWhlIHZlmG8v2u9TyWSsb2aLX/eZVepizDJqUp4Jac7h6Urg5WenjhjsAV4MbKJsTeO3Qx0S6qstvHtjmzqqgFD1ROy0zEYX3ey+cu1+HqAmOkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOWVQC0XCE9Ww+ObODQoOFZh/yZv3dH6lU5lbzw6Pzo=;
 b=dwLUHDaCyHomtWueLYVKqcjRuIHZ9V3zeeT6XhTTj2Tt87+8x/CasknnHBhT+woPJsUdM9Jgf2Rg9b6iO3G/KqDDghKVv9YNmeJzM2TEbPzrDelYZ13yLTrfenz9Uz/ONX5GFv2XDp75JljF1boOA+I3MafqLi5sbfxyR7phSFwvvBP2roX4/skYQwS1zZ/Zw9Lppv53ODG+MhUounffkjZO0CTWCG9DFITH9r8le3ZQMnsS3P3ystox4xkhe+RE/BhKCfNO+WQQZmBF+wAHYvCkwLmc8oQ9wehNsxSdEzmC0B/455MzwKZTa+xkOR0p1dTab8V5PpuSLNcU3E85PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOWVQC0XCE9Ww+ObODQoOFZh/yZv3dH6lU5lbzw6Pzo=;
 b=yjOqYtnfTsihCcXMBIRHW75D1ciLGA6UP6cKtnDwcxAPPr7b+x4mXGW9Sdf6EmYHrGmyuug8n6dB230yOuqHhBvNyWDPsoPHtHVLbsavhCzyqQRguQYsLOlIFZBlq9ID3jwm9k6muRFtrGYgSo41dSiGa+Dcv4PjmwVHRxHMyps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH8PR12MB7424.namprd12.prod.outlook.com (2603:10b6:510:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Mon, 17 Feb
 2025 16:45:31 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%2]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 16:45:31 +0000
Message-ID: <bdb48b29-92cf-4f98-b375-25ec84f0941a@amd.com>
Date: Mon, 17 Feb 2025 10:45:29 -0600
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Reply-To: babu.moger@amd.com
To: Peter Newman <peternewman@google.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: "Moger, Babu" <bmoger@amd.com>, Dave Martin <Dave.Martin@arm.com>,
 corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, tony.luck@intel.com, x86@kernel.org,
 hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
 thuth@redhat.com, rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <Z6zeXby8ajh0ax6i@e133380.arm.com>
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH8PR12MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: 812affcb-406f-444f-49d3-08dd4f727e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clhxcmU0OUh5QXBaUmx1eDlNUWw2dHBMTXBTZWVRSXVtdy8xN1hCbWZEaDEx?=
 =?utf-8?B?bktyUVV4TldpZHYyZW05aXM3dzFYTDJQWFRIaWhuYmJtY2Z1TFFTWERzcnBC?=
 =?utf-8?B?eHdSSnZ0em10MGIxT0FvcDhkVEpOcm9Wdnc3eG1RNmgzdldtV2wyeDlCc0Z0?=
 =?utf-8?B?bHY0MUpqQjVTY05HdVk0SG1SY1RPclBhRHFwUVcyWVI0THpQcnRWYU96ZjhU?=
 =?utf-8?B?YlQ1SUlGWW5oZEw4WW90aDJLdGpmREpwL1ZjbW9yenlQL25DNVlaR29iSjVM?=
 =?utf-8?B?UGJXaithSHRjeUg1N21QUHVrMkxRZjd3WWFuRXMrcDZDell6RHh4cld0Qno4?=
 =?utf-8?B?UnQwY09mVHZkWDU3clBtdXFjZXM2ZTN1QmdUUmJycVBWSVU0d3k2a0dSckgv?=
 =?utf-8?B?T0dON01JcFZwVlVTdERVMy9oUklzTzlBQmpUMnhQSEV1Ylc2L09SZndOT2lT?=
 =?utf-8?B?WnVnMldaTVNxUk5kcXg1VXFBZHIrbVg4NmNkYU5kL3VtNzF5b1Z4S2d2dTlD?=
 =?utf-8?B?WFBEcmNjTXJKeXdEYXVmemFRZWJ3a1FTQUhvZkI4UUhBbDFId2FGZEt2RkNV?=
 =?utf-8?B?WnZFRUI0bi9jZk9zZmx1ZHcvbWhZWFlHcjNmZ0ZlQzBFclRCZTcvd3dTVDh2?=
 =?utf-8?B?SHQ4UTVhZGVJalhnamU5Z2JMOWFBYjhvN3Z5allLeERscnNVeGtOa1hjOGQy?=
 =?utf-8?B?VXRlUmFHS0trTnBPc3pzN1BqMFNxaDJNL2JuUmc5WHZmdmIxUFNSN3d5c3U4?=
 =?utf-8?B?TStOUS9OajRmdWlHZjBVS2ZuQUsvVEh0c2lPanFWTk1PMSt1aUJjVmEzZXhC?=
 =?utf-8?B?TmlRVFhGS3BKYmZ6ZGE5U2pzdmE5Rm1xaUJ1NzlyT2ZBeUZZWkJqdnBQUGVR?=
 =?utf-8?B?cnFUNnFJVGhsSEJYU0I5NzdFZnJqcnVVTmhkZys1K1BGWGpwL3hTSE1Cc0FM?=
 =?utf-8?B?NnhNTVJNZll3MXVtYStwNnhXTEVVWm4wN1VSRTh4d1FIOExPNW45NHlENnZT?=
 =?utf-8?B?cWJIS2dGWXh6M2RmZy9RRjlteFVoWUlSRFAyZko2ekZYdUhMMWE0Zk1DZS93?=
 =?utf-8?B?QTJMQ3R3bGR3WEVadG1QU2tnSFFqNkdyNmlFZ0IwRVFrV0JzRTg1cGVPTUoy?=
 =?utf-8?B?dWthdFRwdmNvK01neWdWTmpPSDZadlJIWUpzTVFtWDBYblFpdHBIbWNSNHRs?=
 =?utf-8?B?ZVhsOVRGcEtRQmRXOHl4RE44REpCc0VoWnlBdG1pNm1TbmFOMXpiR0xMc200?=
 =?utf-8?B?TUFTREsyaXZiZzdEUWtaaFRuQisrcnZNbXp1c0JaSUlxclJKa25ybHhXZjNU?=
 =?utf-8?B?eDhsNnRtWGdFWDNKaFFHUWFSWVNBRzdVQnlPTytMVzFaYTdzSW1tOVNQcDBq?=
 =?utf-8?B?Vmo0REI3am01T1NDd203VkNvOGJLb2dwa2U1OGhENjBIQzhSUkxGZGppNjJo?=
 =?utf-8?B?SW16Zk9ua2gyRWt4Nm04ekFpOGJOa0NGODdqQ0pycmxpbmoveGxZSDQ5U0Yw?=
 =?utf-8?B?ajJMc2FKRXVlQUk3UlczTGhsam5MaUZvTWpNU1N0OCs0aHUzazcwMk92STVU?=
 =?utf-8?B?RVN3YS82dlN3SUNpbGNOWFRTbzZZR2R4VGlMb0I5UktPMURVR2JWMjc2Wnox?=
 =?utf-8?B?cHRqVGQzbHArUTNWaGVnWkgyZmxHdE1SYkQ3aGtITlNnS3drR2E2YUxPbXRk?=
 =?utf-8?B?UzFQMkxBQWtlRUtlRkc5UmtzRTM4VzdNUzZYWFpMYlI0Zk8wNjVHUDFmYkJC?=
 =?utf-8?B?bVMybjE4YUVoSHZrTmRHTzFIa0NBMFRlVzgwMitrZVhuRXkwVHpiaTBNWkxT?=
 =?utf-8?B?b0pBNEZHaEpNcmRENFI2ZElVTFd4Y0MvKzZOaFZ2VDZyZXI0RnZmaXBOcGd4?=
 =?utf-8?Q?bNl0/7wGZHqHd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UC9DMVRCbUxzSlRrcXFGRkdFOUZDSTF5Z2ViakZWSjNwanZMcVZMa0N4Y0Vx?=
 =?utf-8?B?eDJ3Rk5kYlkxOFpOQ28vdHZ4RkxsRFR0czdpUWYyM09oeXBIMnVkTUd4ZnRS?=
 =?utf-8?B?cUp5dlUxZmZRTi9aKzNCRXRpaWxjMlZnYTVvL0dwTTFXbkZKM3gwVFZxQ1Va?=
 =?utf-8?B?b1QxeXVRbUJLTG5laU55SmRKUmExMUo1UXZmekoyTlprZlNWRHNWMVpVb0Qw?=
 =?utf-8?B?bGZLVTVHOW9ZclBhdlZRaWNFeklMUlk1djQxODkyNWdhWldCVmYvK09STXFo?=
 =?utf-8?B?VkhhYnBjME8rME12cFZ6MnhsWWwzTHhiNU5aOXBIdEgvM1dQeTJqc081WVNN?=
 =?utf-8?B?Q3owZFU1QjRCZElSWjFyOU9oUklYN05FNHF5emdDVzRRTEFHcm0zOVdKWSt4?=
 =?utf-8?B?bUduM3RZUDBZeERJdVo2aEg1TWNHZGZDdmlrYnFhRGd2T3A3bnNtTWZENDZj?=
 =?utf-8?B?U3IvM1JxbFJpeCtXRFRTYzN6UUxUUzJPVytDT2xObjZRdHpYaHV1OG5aeWk3?=
 =?utf-8?B?L3liMXo1L01sNFg0L2JaYkkwMEZjVU0zZVZkYk9QZkgxK1g3TTZNWFBzOUcv?=
 =?utf-8?B?aGZxWEIwSFRRQXpTNDA4NHZIZkVSd0JIUkdVWityaDNsU1c5bk9CRi9pM0xX?=
 =?utf-8?B?Q2lZQWQ0Z0Q0bUl5Y3BiTzd1VEp1MmUwZnpTOFY5V2pMUVM3OGpIN3p4d25Z?=
 =?utf-8?B?TE1PTCtRS2FvZU5QYUl4N1Z3ODM3ZmlnVU9nNXlrYXVSWlhIa0R5VXU5SFpV?=
 =?utf-8?B?V1pCRnFENWhyeXZEa3I1VEpXTmpGWVlENzZXZ0tKNlQwM0l0WWxTS1YrVXRF?=
 =?utf-8?B?Q3IwTmczNitMamhlVTh3aVN1VnpreEIyUVprTTNKMTM0NDM4U0srcFZ6OEpC?=
 =?utf-8?B?eWVhZ3JCbVdyKzBNcEY0SEtpcndMNHNqT1VDK3QrL2tOVXhRUDJBVlBxY2R0?=
 =?utf-8?B?dThydmNmanBaODJUYTI5MlBzRHBXRGlIb0NES1dWODhXU2QvTE1xWjJkTjJW?=
 =?utf-8?B?blRQTEhrbnFyL3NQUDhMaVRiNGNtVVpLOGtseElWckVhVEF1bzRZMkJKSUNo?=
 =?utf-8?B?NHBLRGdqZ3h1ZTgzdWxLa0V4Y1NDcE92UGpJVkttU2NYQ1RDUEV4c0hIMnVB?=
 =?utf-8?B?VE1lUVlqc01TYTdBcVRqeHBMTmVWWWdSaTVqWkJPendRYVI3L1JhQ21pS09w?=
 =?utf-8?B?VmJwaHFjdHV4RC9KaEtHYVFuR3BmaERMWVViVkVuNDZkYnBMeUtHSkVtbmpw?=
 =?utf-8?B?eVQ5TkVCS3BFb21KM2xpSXJVTG9NY3FxWG52dXRtZm0wcFNINzZaQnA2d3hJ?=
 =?utf-8?B?bjRsWEhSaExCdWd1Q29VSjJ6RmdRSVR0K1pjdlZ4RXdLdVVVYUxyejVSWTVr?=
 =?utf-8?B?NnJZeVNEMS9ieXFPUUl5TTEwaVJncDBGY0RKajhxbkE3aFZ2VzdSSkNnRFVa?=
 =?utf-8?B?bXRpSzQrdloySjM0TWpsTmpIS1JaNVV4NmthRjhsUDl5c2xsWUc2cmk2VXgr?=
 =?utf-8?B?anpDb25xV2xCMlo2RDJaSHRoK2hraEFRUXIxWlRLb2V0a3RqNnJOMTZ5d2hz?=
 =?utf-8?B?bGprcTZSQWpvVU9KMHhEMmVvRy85VWVOTENybllpQjBvZlZXVWdqaFlSL0Ra?=
 =?utf-8?B?RlZ4R0owUUVWMDIwM1BtNlM1OE91YVRVZDNtdGxlcVp5WThiSks1bFUvRFEz?=
 =?utf-8?B?MzZUMzVtZzIvcmxSN0NJbmZhbXpGbndsYVZnZjZxRUJhZ21oRis3U0RUSjd6?=
 =?utf-8?B?OVc5NnYwZXpyUmwzOFBOaHlqcWwvTWdINVNSYkdwQ0FOS01CeW10cEwwV21B?=
 =?utf-8?B?MVlMUllCZW0ydW93dTlQRXJTS2NxQ1dGcnRYR1hCckQwTDJTK1ZBMXZlVTk5?=
 =?utf-8?B?bzgwZjVWSjZqZU9nQVdhMHRxcnlRZThWR1RUYlQ4Um40U2pENThLTVYyTFpq?=
 =?utf-8?B?MWs2VTN4cHFyY0xFVWhjM21HN2Q2a2VTVjFHUnVUOG5aTjhkKzJLOTBtUWJo?=
 =?utf-8?B?bDB4cEI5dzA2VmNIUjVJV2I5VE5NZXB1ZkYrekRSaGFub3VVQ2VwSkJwSVFv?=
 =?utf-8?B?VVVxeEhMV2JIYXVqZmlwVC9IK2Jqd3pqcW9IL1RjRXdzaDJVZlMwNGcwelQw?=
 =?utf-8?Q?ivd0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812affcb-406f-444f-49d3-08dd4f727e06
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 16:45:31.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bP16mc57ETiGP8uanHsqesQg40FTH14DcGxYg6t71M/zHWCAPuTQhiqccSPIdIF2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7424

Hi All,

On 2/17/25 04:26, Peter Newman wrote:
> Hi Reinette,
> 
> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> Hi Babu,
>>
>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>
>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>
>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>> Please help me understand if you see it differently.
>>>>>>
>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>
>>>>>> mbm_local_read_bytes a
>>>>>> mbm_local_write_bytes b
>>>>>>
>>>>>> Then mbm_assign_control can be used as:
>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>> <value>
>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>
>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>
>> As mentioned above, one possible issue with existing interface is that
>> it is limited to 26 events (assuming only lower case letters are used). The limit
>> is low enough to be of concern.
> 
> The events which can be monitored by a single counter on ABMC and MPAM
> so far are combinable, so 26 counters per group today means it limits
> breaking down MBM traffic for each group 26 ways. If a user complained
> that a 26-way breakdown of a group's MBM traffic was limiting their
> investigation, I would question whether they know what they're looking
> for.

Based on the discussion so far, it felt like it is not a group level
breakdown. It is kind of global level breakdown. I could be wrong here.

My understanding so far, MPAM has a number of global counters. It can be
assigned to any domain in the system and monitor events.

They also have a way to configure the events (read, write or both).

Both these feature are inline with current resctrl implementation and can
be easily adapted.

One thing I am not clear why MPAM implementation plans to create separate
files(dynamically) in /sys/fs/resctrl/info/L3_MON/ directory to read the
events. We already have files in each group to read the events.

# ls -l /sys/fs/resctrl/mon_data/mon_L3_00/
total 0
-r--r--r--. 1 root root 0 Feb 17 08:16 llc_occupancy
-r--r--r--. 1 root root 0 Feb 17 08:16 mbm_local_bytes
-r--r--r--. 1 root root 0 Feb 17 08:16 mbm_total_bytes

-- 
Thanks
Babu Moger

