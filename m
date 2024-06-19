Return-Path: <linux-kernel+bounces-221463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F690F3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4624EB248BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A32152792;
	Wed, 19 Jun 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="20g2YEjn"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384EE1848;
	Wed, 19 Jun 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814363; cv=fail; b=EilMUxaWxEM9HuoQq3C8yZqguw8UVQO8aRBH1baJeHHmVf7soMdkbf4d0YuV3dBD0e+VLp5Rj1USNoo0/1FR/jy20bXzfyRW2tWqTRDmYntS1KHPC/rMuG5sqjzy2/35ngD1t4BTPl0PIxh45SFKMG/BMHoXoH8aMgwqNet3qX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814363; c=relaxed/simple;
	bh=w3KfZSAV6Z/KLTk2q2+eS19fg+LMyBQ/IHwoqWpedEY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N+lmTPg78pcLG7/69Pg56TkLn7u67mcWQGWOPMvkd/f9g4/zO7/GUf9CXd2Ac2ByRhWrEcOZJoE2ygxjBSOAs6lwQmqKa/hJERSC4VZhvBD8I3bBictkZa1JNjBNAEiLfXOqIR5byaS2KqQA7lXTTuEXXregQiaYQ6spCEDRc6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=20g2YEjn; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsSDLEzpHsbLZtPtNoKtU7fpszRy72f+PDqYiRjO9G58wh3vGJusQdXCkh89vNz9xmpuOqx5js0HQ6YnbmHdzuREix7cntKVicXxrLVirA9v5w009WMegaZO/fB+jGPCgzEU8ytBt9ouDWVfo6IWNoUVq7vHYQRhVtvKP9yGZ2COXFaFnD6tV+a7r2I9hDbIlVmTxMTev4GNtRX+5h1KukJiy0cWjkDa4n5UxXvfYjP0SEegGwLG7n8eZWvEGYslEg4gYau4y/u+kM6iK1Mlxf9d4xLCtDgkCTd0BG/EFj/b3lwVahS0ZYkiLWbYT2284GQiEz7M7oYIjGMASW0ScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRluKoo7o7n9KzHeT1ccADjCuiKZAzvFkoVjvS7ZURI=;
 b=akQ20pSH4KMza1/PYyiucB+Ea5SHjWJVrHTBbPHUdbhdw9PhROiyz8dFj6uWFUMU1rREStNVBv/fO2zxWD/C+MbjOX5vOg+eiOjSyPkwLdQ2XZovFjqynxmwhYpPN2PUECrd78HWZwo6MwItmmM4oWiVOk/+qn7H79xUL5Wd72Zlrlm3JJ/AJRUX9z1z4lrevRaSVz+gpiKHmF8WvbDbXKYwhg/hT6nSXrY/IeT5iD4OTQl9S+um7vSBbd2YmKPdGf6hkl5IymxRElY+j8uPsOhhZ0T++oS/OYkrm0Ht/y4N6EvVR6HUOVgKjNaq29UKiDUo+KFXY/0QIldDVoNB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRluKoo7o7n9KzHeT1ccADjCuiKZAzvFkoVjvS7ZURI=;
 b=20g2YEjnB/wKry+L5awMwH19NQY9UUjcsMtznMCjF1cENELl5MWnI6X/XZbYSgW4In+utYL3OarRfCxS8EYCrS4PCkBPqc8YbnecuFlMU4w9IVsq1nwTtTM/MLghME9GnRqXDGylbjgLLP+2mlTjqIWGO4sqFEeE+HuOXnyApAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Wed, 19 Jun
 2024 16:25:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 16:25:55 +0000
Message-ID: <b792d729-669b-4785-bdbb-23230f2e993e@amd.com>
Date: Wed, 19 Jun 2024 11:25:50 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 08/19] x86/resctrl: Introduce the interface to display
 monitor mode
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <3b9ef8bc03c1004794a087537c6f2f051760402d.1716552602.git.babu.moger@amd.com>
 <a453b19b-a909-49a5-9512-ae69c48db6c2@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <a453b19b-a909-49a5-9512-ae69c48db6c2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0177.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::32) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB9396:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6296dc-f50a-4175-509b-08dc907c7e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|7416011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjBFM2VHUTRyc05xdGZ4bVpIbDI3T1dERk1JYXNGR3hudGZBKzduamRVUmhD?=
 =?utf-8?B?SDh5a29rUmFHQmpVS1hFMWFhLy92NkxhM3pRWktzVWE1OGtRTjB6aXR1ODgr?=
 =?utf-8?B?MHNmRFhtN3k4ekVHS3hhWjExUDNUVXlDZTduRC9CYjZjZUdsNUtDU3FtMGxH?=
 =?utf-8?B?VCtWUDJFVzNmU3pBeThjSGhpalFwcXY2V2dvOUxuZmcxTWxnbHYwa1dDNktp?=
 =?utf-8?B?OE0rY0E4ZDZqa2xqWGIzTnJkQzl4QzRvWkZKRnBhUGtXZFZmVGdxQkYxWk0w?=
 =?utf-8?B?b1ZCM21jYitTSVcvQllmaFZ5WVhKc1JBd3lkNGNFU0RGdlhjT2UrNHNiSmtv?=
 =?utf-8?B?U3ZLalRmR3pOcFVHc3RJQ1hsZldCRjBmU3VyL3pnbS84RmxxZlZzbmFhWGx4?=
 =?utf-8?B?Y1J6TlN6bXRza2ZndDk4dzZ3MFVicnNNdWZHMHBFSk9EWVJpTTRFbHZHVGlH?=
 =?utf-8?B?UFRXU1BKZkVZMU8yeWwyb0RUaDFjb2JuN1RQZm40WEZRL3hlYllIWVZ5TDlp?=
 =?utf-8?B?YjJkVWUxem45cUdwUVFPQm40UktSc0wzUTRvajc2SmJ6SkZTdzlFT09YbGQ1?=
 =?utf-8?B?bGhWcHU1VVFBSmNPUWNaSmptQTN2d2t3WjlqN2pGR2VkUHFXa2pBUlh5VzE5?=
 =?utf-8?B?amNNZVJjT3UxQXlZQlpuR1lVb1VJTjlFMEQ2Z0l1aGhHVFVHNG9RWVNVVjBs?=
 =?utf-8?B?Q2NjQlFjZGh3T1BmOEJONjNRYzRBS0JodUpmTGxaSkhxa2luYXpPbkFlcVZi?=
 =?utf-8?B?clduQTJxRmZ5UDV2a3VDWDVIeWhKVjJSRDI1QVVtRWNKUTdjSlFxRFB2NU5P?=
 =?utf-8?B?cHNaMlBMdGR2d2x5ODhtT3B0UjJ5VmdRYXNJcWp3RmtEcWZnc3JqSG1qcUJi?=
 =?utf-8?B?SkNxSi9vbE8vSDA2a1BlQS85ejhkbHJ2SGhTRXlZcUJjWkxabmFtS3NaWjF1?=
 =?utf-8?B?MDNhSERYTVlZMVhrVEFTdmhkRGoyV0o3N1RyeGh0QS85cUhadzZVK1R4Q1Z1?=
 =?utf-8?B?ZGlTNVUwTVJqWmZ5bC82c2NjQ3hIK2dNTWIwQlZZbytwZHprbHFuYVhQaXIy?=
 =?utf-8?B?WlJmMmE5Z2twSnlDZmRUUjF3QjZRcldEWkxzNTRIcFRFblhTdmpFNWJEbURG?=
 =?utf-8?B?UUZJcjVZQmd0S3ZNOEVsWTJJRFRqWGNRQlU3KzhpZnJHUWhNMWVUbHhybGwv?=
 =?utf-8?B?YStBQjZiWkRWWFJqNUtMakZOTEJpcEpFZm1HNlJXQkdNMWc1M3Btc2RBMkFZ?=
 =?utf-8?B?dlBQUHJHK1RPZmRDVUFGUk9aeHBQdmI1a1RtMFJWSnMzVUR1aXR3SjBSOC9B?=
 =?utf-8?B?TG9DVkVMb2tvNWpNV2RORmw4SW83WSszNDk3R2l5Ky9XNzRQdVc3eFBhL2Fa?=
 =?utf-8?B?NEJUZHZJMjFwYlhZWUVCZUZRMTFQSjBKY0V6N1VZRTN6ajdZU283K245YTlF?=
 =?utf-8?B?eVpkOWMySUIwNEpWbjgvNGJNb0pHYzVjTW83b08rckw0TVI0L3VVclNzQU5q?=
 =?utf-8?B?UzFOa3haYVZwS0hweDJTRVFaK3lCOUZZY1NFQTA3ZjJmdHFvZCtVOFQ4bkYr?=
 =?utf-8?B?clNCeUVERFg3dGRZRkJoZHhYV3FQTFNjWUNVYmM1VlJ4TTZ0Q2hlcTM5QTRn?=
 =?utf-8?B?N1dzSFhUUHhyUnppNDlHcTcraGRhM29CaW5wRE5oRzFYWlQvaWh4a2l1ZmtB?=
 =?utf-8?B?cXR4Q2w0VkF5YjN0R094SWZpcHd6OTJGSVQ4S0dTWjcyNXIranZjRlhIYzk3?=
 =?utf-8?Q?cpCxa6omVUuBPCrkLd37+BbcEvXvsI/lUYcM6RB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(7416011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N245NE5FLzR1Tkx6N2JGcUtxM0FMWnVDY2NDeVFKdEhTcFJYQi9BN0VjUXA4?=
 =?utf-8?B?VktZU1daWi9YQkFCSGRFd3RQTGlWQ2VIUXA0NDhMdEZCWnd3cTE0KzZhYVpC?=
 =?utf-8?B?UlgreGxxMm0zZjJnS2RVWnNuM2pObVlRRktGdk5rTHM5dmpGWlUvS2ZYZjAx?=
 =?utf-8?B?Yll4VERobkhMY3VxZFlMMHpZRnZKdXRlT2JwdGhyejZUbDlINlJ2bXlielha?=
 =?utf-8?B?NzRlOEN1Y1c5K3Y1QTJvUDRjNVgzSjNVOTFoQTR1MklPdFZqMlNiQUszOHAv?=
 =?utf-8?B?K1FZQXlaUTVZRDdGOEFpVUw5VTlYeTRkZ1VGbHY4alBCOU1WSU5sOTBieTl4?=
 =?utf-8?B?NHpGQmNyV2l6dFdpWDFGN1pSb2M1cDZManN4S3NUdXEyRWNSdE9sVjJFY1ph?=
 =?utf-8?B?SFBVSVhwdDhhYVd6YXFLT0dBMHY4NXVXSlErTjZNSVdid0cvM1ZzSW5nT09l?=
 =?utf-8?B?cEczU1BaYkpyamZIckNPdDBOZExTRkdTaHZ5OTgvY2NhWnVXNXlvaTAxbWN4?=
 =?utf-8?B?Y3BKTFJCb0lOZml1VTM1cnNGcG1BVHlCd2MyY20zbFd0TnRqN0Y4UGxQdmdL?=
 =?utf-8?B?NXRsMzBpSDhseENFV1V4TXpXVGduSElmV2hKeEE1WDQyK2VGOE1OWGp3Q3h4?=
 =?utf-8?B?WlNjeFBDRDMwb1pYOENGZHFmWHh1MXVHdGxFV0hpMkFtK2NmcVE5c1VxQ3l6?=
 =?utf-8?B?Qk9FeldwZWNuZEZmaEl1bm9ZNUNvaVZieHBtZzk1YWVFVHNJVWtmQkdnMDAy?=
 =?utf-8?B?Nml3MlY3S1BkWjFOSzR5WUlFT25zT2ZxRGpJaVU0cm0wc3Q4MXIzWEV2QWw5?=
 =?utf-8?B?MkR3bnpUZW0rRC8zdUI4d2pPS2RtM3BDei9NTldNbXFFaXo2OVVPRTFON3hB?=
 =?utf-8?B?bDBIdW9WVFhrWDVHTzYra0w5a1NnMnRPYjNVemJHalk4ZHF0WEV2clVCMFZ6?=
 =?utf-8?B?Q2orN3U5MnJKNnE0Nm5rdjJRSnIvbGtkVmNXU1NPVm9uaGYvbGhiN3BGMFVn?=
 =?utf-8?B?cFlaVnlCTmJya0R2eEhYM2RIQnlRSCtIQWJRcXQ4dkxNdWtiS3pzZDlXMTlR?=
 =?utf-8?B?WmJnSldsWUJTZE84bGRLcG5FMVRtR0dWNnFrRS9JOUEzdzh3Vk5UQXpRV21R?=
 =?utf-8?B?VEdBRG9Zbjl5bXlxTFZ6cFVjZzFrb2ZEdmM5ZXJxQkNqUk53UTllbjk4V1Qx?=
 =?utf-8?B?Y2lDVGw3ZENyRCtqbXpZMGI5bTJDRGxXRmtCOWNhVGNrV3hVZ29yNUFPQkJv?=
 =?utf-8?B?a2NZaXVHbWJRWGVyQnpjMDNrSCtiR2NaWHpCS0RFUjNNVG5NM1R1a0Jpb2Jj?=
 =?utf-8?B?QnRqZlVnY1Njc2RPd04wZVJ2R2ZyTVdoYU8yQWZmWVVPem9zR3BwWDc0MDVn?=
 =?utf-8?B?bWgwWTZxTHpnYzV1eFBvenc0bnNzM0cyVDB3a09YcjBBNDBPMkhlbWlzZlox?=
 =?utf-8?B?Y01qRmFGUzc0RVp0clZzcDdDODFZMXpiQVdPeTdWeEpKcDIyTFVWcms3YzlI?=
 =?utf-8?B?T2Z6d0lObGNsbmRIOHVGZkdCcDJreUJaSTl6OUF5RS9wTlUzdVpCQlJYcmlw?=
 =?utf-8?B?cWVVQjFMVmNOSXVtc0xMT0tZMCs4b0xiQkpMbDI3NzE1ZEVMaERUL3hjbkpF?=
 =?utf-8?B?ak1zUU90dnFnbzVBQytPNjk0eUhCUTZIOUF1UkRtVWdIeGF2TTQzZUttUStn?=
 =?utf-8?B?Zk91VG5JRCtQaiszYVVONnhQaUlxeTU0S2lEN3dPbWNFVFgrRnNBSU9raFVs?=
 =?utf-8?B?RW1yaTN0ZTErOTJibWlZZmdLcFd3L1FMUDNoL2hXcHptWEt1KzVUTVRJSUVV?=
 =?utf-8?B?MTh2Y0NGOSs2VWlRRVFvTlNKcnZBcmVvRFk4bUZYK3BEenBLSDVpWi9pYzhB?=
 =?utf-8?B?eGV3b0hMOGRrS1RGdHBRaHFrL3V1VWx6N2M2MnhMS3lVOTFTMmZMU1R4c2lQ?=
 =?utf-8?B?OFFFVEs4Ty9RZU4va1RRbVQyR1VLY3lzb25qaG8xKzhOUFpHcmJPS0FkY3Zv?=
 =?utf-8?B?TitNdlBiUVhVZmFpOHBEQlVzZUhRVXZRbUhxcjY4TGQ2R0pqZSs5UmNqSGJl?=
 =?utf-8?B?dGkzazlDMm1XaWcyUVgvRy82UC9qMlBqaDM3WG9XMnduMWJwYUtVOEdoWGI5?=
 =?utf-8?Q?ynwg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6296dc-f50a-4175-509b-08dc907c7e93
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 16:25:55.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0A/bFiEvHa232gtotVkBU7MLlvUjl43Rl19VO2stWtQdHcCMzDDd5b92h46e3sN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396

Hi Reinette,

On 6/13/24 20:40, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID and monitor the bandwidth as long as it is assigned.
>> ABMC mode is enabled by default when supported. System can be one mode
>> at a time (Legacy monitor mode or ABMC mode).
>>
>> Provide an interface to display the monitor mode on the system.
>>      $cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>      [abmc]
>>      legacy
> 
> Output is different from cover letter and what this patch implements.

My bad. Will fix it,

> 
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v4: Fixed the checks for legacy and abmc mode. Default it ABMC.
>>
>> v3: New patch to display ABMC capability.
>> ---
>>   Documentation/arch/x86/resctrl.rst     | 10 ++++++++++
>>   arch/x86/kernel/cpu/resctrl/monitor.c  |  1 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
>>   3 files changed, 34 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index 7ab8172ef208..ab3cde61a124 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -261,6 +261,16 @@ with the following files:
>>       Available when ABMC feature is supported. The number of ABMC counters
>>       available for configuration.
>>   +"mbm_assign":
> 
> This name is not ideal but I am having trouble finding a better one ... I
> have
> seen you use "monitor mode" a couple of times (even in shortlog), so maybe
> that
> could be the start of a more generic name? "mbm_mode"?

mbm_mode sounds good. Like this.

$cat /sys/fs/resctrl/info/L3_MON/mbm_mode
[abmc]
legacy

Keeping just "legacy" vs mbm_legacy.


> 
>> +    Available when ABMC feature is supported. Reports the list of
>> assignable
> 
> Why not always make this file available? At least it will display that
> legacy mode is supported and it gives user space an always present file to
> query to
> determine support.

Ok. Sure.

> 
>> +    monitoring features supported. The enclosed brackets indicate which
>> +    feature is enabled.
>> +    ::
>> +
>> +      cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>> +      [abmc]
>> +      mbm_legacy
>> +
>>   "max_threshold_occupancy":
>>           Read/write file provides the largest value (in
>>           bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index e75a6146068b..b1d002e5e93d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1071,6 +1071,7 @@ int __init rdt_get_mon_l3_config(struct
>> rdt_resource *r)
>>             if (rdt_cpu_has(X86_FEATURE_ABMC)) {
>>               r->abmc_capable = true;
>> +            resctrl_file_fflags_init("mbm_assign", RFTYPE_MON_INFO);
>>               /*
>>                * Query CPUID_Fn80000020_EBX_x05 for number of
>>                * ABMC counters
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 9148d1234ede..3071bbb7a15e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -856,6 +856,23 @@ static int rdtgroup_num_cntrs_show(struct
>> kernfs_open_file *of,
>>       return 0;
>>   }
>>   +static int rdtgroup_mbm_assign_show(struct kernfs_open_file *of,
>> +                    struct seq_file *s, void *v)
>> +{
>> +    struct rdt_resource *r = of->kn->parent->priv;
>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> 
> Please use arch helper to just get abmc state instead of fs code
> digging into arch structures.

Ok. I will use "resctrl_arch_get_abmc_enabled()" to get abmc state.

> 
>> +
>> +    if (hw_res->abmc_enabled) {
>> +        seq_puts(s, "[abmc]\n");
>> +        seq_puts(s, "mbm_legacy\n");
>> +    } else {
>> +        seq_puts(s, "abmc\n");
>> +        seq_puts(s, "[mbm_legacy]\n");
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   #ifdef CONFIG_PROC_CPU_RESCTRL
>>     /*
>> @@ -1913,6 +1930,12 @@ static struct rftype res_common_files[] = {
>>           .seq_show    = mbm_local_bytes_config_show,
>>           .write        = mbm_local_bytes_config_write,
>>       },
>> +    {
>> +        .name        = "mbm_assign",
>> +        .mode        = 0444,
>> +        .kf_ops        = &rdtgroup_kf_single_ops,
>> +        .seq_show    = rdtgroup_mbm_assign_show,
>> +    },
>>       {
>>           .name        = "cpus",
>>           .mode        = 0644,
> 
> Reinette
> 

-- 
Thanks
Babu Moger

