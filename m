Return-Path: <linux-kernel+bounces-340791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35519877E7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3F21F25373
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929CC14F9EA;
	Thu, 26 Sep 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OFKRmVz4"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B43F9D5;
	Thu, 26 Sep 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369778; cv=fail; b=eGkstkEW6wOQxNVnwSqTxbFqanicos8LS44vVT2MLoLCsmhnNJeMEl5x2yV8aukzaN2EZgitvVXBtVua5lTFLdhabtk211sJ2bDdFvfhBBgwmbdsW7Q6MziQDunnB6KrgnhZRf7xDRQ58AJ2ayg0eUd9FUQIY+khP7mpWtSx8JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369778; c=relaxed/simple;
	bh=d122EStfB6j3cu0snsJI6qIcBgXZf7ix8faFdwOa5i4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O2xh5cj/MlGRMwPVc9D/LoTqvIb4lzDlQ2v8CuFk/RRxtZTQ7C7v3YvGV4L+DMmie/69pLSK/P5A3EeFznJjsn0kIQc2Xbp0S1grMe1JUebJ10ULNINw1MZBUYaQf9YGAgeEonx7jrbq19GaVlPmxLES7CZo+IV1UUZBb9znV9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OFKRmVz4; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1fuRQsWrJZF3y6OuxPPYR057kEjW2ZwRHYYtf7zkyKottKTruxyy9cdR73RaL2rNRCLIchgtvAjCsFqlImHHa7wuHSPzIfaTLpGQ+OrIXn5OL1JogZcyQNK2oqem99EEJ2VZJf1tOOhSeZanQyVGBSvXlG520dH19zq+aAC6ZTUl8Dcbs29ssaMsYYKeLK9yQ2cdoQnKyW4Dalwu3DAk8wkIpzkIDM+dQzmArg35V7a/ir/HiMQZanVW7kUuP++scjhNyXP1VjYO4SbRyASeq/vwV8fMEGm+6xbSTweoT3ViU5YZvW8ISt/9uG6DgnBNz7St6Q8Okb+xlEvmhDSuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KD7oPAOL6uFdz32lQkrccdfBUMIw1Pxj3/UqMOqmhA=;
 b=ETmwR1QBpTeS4QX93ASb4e0/jjtcHDaTPqszPGDjaFafX9u8iW99qVxhXXfKGPcQg5Xp2tPlo1+gL6A3M7UtzmxGhrhDtUlUM1bSFYsMZ6tDyBm6weJrYw426VGoAdsjxCiYiGmlDkUCkWH2WoSljsjQYF7cfX5Kp2xHlmZUZDvwxURRY1mwGduBHqMKghPWBh/pzlI1IOenQ/b+ARLVptF+UNItutUwwTD2687+A5pi2sQ2aXCOH+CDixAUUwWzCv9QpBVvslP+gDIE9XUpebDiesKczyaGeQfJ1ioS4IzlSEMiQMjeSL6j3TgmRxkKpN54RMG1n4HfBtMISlIpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KD7oPAOL6uFdz32lQkrccdfBUMIw1Pxj3/UqMOqmhA=;
 b=OFKRmVz4KU15zVYqu4/fcHmgBV4hOTwXph8FvX9ghPie1D1YC/bPuN3tMrx7KYKZ9bohx9aHTonfnHhfCzJWfwnuZ4BAOE+9fUdkV8od6eSlOk8EZvWTzRExmA6s8b4SxpdO9EhHeaqqfvr3opVw+E3ck1CQKrOF2X7E7JoOSrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.31; Thu, 26 Sep
 2024 16:56:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8005.020; Thu, 26 Sep 2024
 16:56:13 +0000
Message-ID: <e787e4e7-d3ee-46f0-8be1-9ccc1e45a7b1@amd.com>
Date: Thu, 26 Sep 2024 11:56:06 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 17/24] x86/resctrl: Add the interface to unassign a MBM
 counter
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <91e045eb3a3b461c44f61c64b826c9e05ac75abe.1725488488.git.babu.moger@amd.com>
 <5b22ebda-79d4-46c0-a8a1-5cefe6ff9f07@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5b22ebda-79d4-46c0-a8a1-5cefe6ff9f07@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:806:122::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f46483-4691-4b30-2e7b-08dcde4c20ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bCtISW1USGtIVFZtTEt4dHBFL0dlUVRaRXF3UThKNlNSK3VwZXAvaDgwWkNa?=
 =?utf-8?B?MldlcGNkMkxhYXJxWWpwc09hcW5jOUI5WUd5elgvYTIzR3VSVkJMR2graTA2?=
 =?utf-8?B?bVRxSGhnL0FrWVJYYWthcS9BbzFPNUFrcmhCbk9mSGhXaGVNWkl4VURTNUtr?=
 =?utf-8?B?V2d0aE1sQUNQOHowMjR1UkdDbjBoSjcxQnA1SE5rM25OQUxXM0ZJVzYyYjhO?=
 =?utf-8?B?SWQ3eHV5eWtpeURUR05GdHFuOS9ZKy9POEFQSFVsQzJGTmFaU0hYb1ZaeVg5?=
 =?utf-8?B?T3hNNjFJN0dOVU01MlBVb3BERFFTNFZvR2llcGZlSUJZV21zRWZaMmticVV1?=
 =?utf-8?B?eXJOU3hQSExVWWpDTmphUXNZbDBmSDRvZjhZbWlyU0kzSUpXSEFrOUZscUxS?=
 =?utf-8?B?OVV4UXluY3FVankxWXgrYWhDQ0REOG9GOWlWQ0ZkTDhmRldkeGF6NmJUeDNp?=
 =?utf-8?B?elMza0VmNDB5ZkFrS3dac3Bpdk9VVGZRbGlKUFNETGxDdkk3azRNMy9iKzlD?=
 =?utf-8?B?MFhXZURnRDVuS2V1UFdya1ExNGJqWVN2SmRZNTNib256dEgzTjBPYllWUkVp?=
 =?utf-8?B?NWo1eHdzeit2cXpsZXNiYjFNTzVOdzRSOHlmRFlycjhTZ09EbFZlaTk2Z1Ry?=
 =?utf-8?B?OXM5VzBPK2dMTUNhSks4SmFWN0NYdjdzMGRmRDkrVkl4dVkreTdpc1BlYWpJ?=
 =?utf-8?B?SzU4MXRqT1p1eFl1cGEvODVpT3BuQnJyRFRYM0U0QnhuWVplWENYdVU0MmV5?=
 =?utf-8?B?Ly9Cc1hUbytuWEljRC9YaG95dmRIdmg5dzVVdmdKYlRLODdxb203UzVyMXNW?=
 =?utf-8?B?UEc2TlNKTGRlVHF2NldDaEgzdHJKemdnS1RqbEI0ay9GNmhNeDVsQTUzaXFa?=
 =?utf-8?B?NHV2STlPd3loWHFsVm1iclNOTURjTERwVWdablJqVjRHb3FpaXM5SmppLytP?=
 =?utf-8?B?cEVqWXJnZ2NGbnBaOHdHNlpRVjFoeVAxSFlNVzFpU1hLNEVwT0NQdFcvMGZ2?=
 =?utf-8?B?ck93L1g4ZTRCZHZTWVRRcWNQOG1LUWpvU3haNWhaYmE2WVhCNCtrSysxeW9z?=
 =?utf-8?B?ZDJPUGErWUE0SENVQ1pHQWtoMldvWVZzM3lxWm1vZW1VQXdxUUFhY3UxaGM3?=
 =?utf-8?B?N0tzZ0xxSUk3K1pRVkpzQXJXUnF5M3poUFdySlhWWjlSVk5Ta0d4ZHlnRW84?=
 =?utf-8?B?c3dPdDFXbS9TL010VHFEcE5CU2lNa3lDVXplSEdyMU82SzhxdGVnQWxpK3pJ?=
 =?utf-8?B?NXRCS01NL3AyZ1IxSmgyN25ObTRtbXNUQkkyZ1llT0FGMnZzam9ZUFIzeUl6?=
 =?utf-8?B?VklJaytHeXprR0pIWlY3aW5NMHN3WGlyKy9Yc3BxNGVKa254MXVRcmRSb3d4?=
 =?utf-8?B?ZEhuQzRId2tyUVJRQ0d1alBQV211dDBiZTBJNDh1VGJGZHFKZE00bXhSdkhr?=
 =?utf-8?B?WEt5bnZOR3BGZHZHV2VlcDZCTFE3RDR1KzN3M0pSREVaYkMzS3VuczJLS1FR?=
 =?utf-8?B?dCtoTmtGMGVXWWNNaGdpN1I4SWZSWDFIRnY3UHdiV3JVajJ1TXpnd1pqeTVX?=
 =?utf-8?B?MmdzZngvZ0VrcGIybjd1djhPZC9wSk5hM3UyNzlIZzFzZUNrTmtTd1hZMHYy?=
 =?utf-8?B?OFpaNFprWHB0cEhIRFpXYWd2a3hDaEJ1cnpwOEZYMThjeGttY1owY1drMW16?=
 =?utf-8?B?WVVOL2cwcGRURGRRY2l4N0kvMml4dTkzd1lUVlVmeHJLbmp4RXU5Y2d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkxtdHZpVTRWN2NRR2gwMU1iNm5xRk9mNEttdVN3YmpwZnF3eDM4RjN0bHcw?=
 =?utf-8?B?cGVTMGtZTUFMM1kzTHh0MnVDOFQ5VGRLaHUrT0NIZWcvMmd6eW1FWnA0THdV?=
 =?utf-8?B?Zm5HWi8zd0FMLzd1TUZ5aHNUNFdBTUg5R0ZMVzhPM0M3ZXBxdGoyK0lsOFpG?=
 =?utf-8?B?Z0tFRnFxZFpFZDBDYUszclZSSElKdC9RU3hjaUdXb0JTQk10VHZFSUViQkFu?=
 =?utf-8?B?bnJHZW9kaWdHNHpvMGV6d0d4Q1Y3c3J4RW5rNGtJeEN1ZUxMek82TkpuZmJz?=
 =?utf-8?B?M3Ewd0NYRm8za0tYZGw0cGRCMllTbmczNkZZeHhCNFN1QXZhN1NrV1pLVWNK?=
 =?utf-8?B?dHptSi91eEhUZVpyZVdwNkUvK2JvVE5INGYxOXptMmg2VEhjT29VSmQ4OWNo?=
 =?utf-8?B?ZmFlWC94dGtuaVdTWnNrR3ByUGdjTnRDRW1aWUJPSjJqVVlVY0VvN3FyYTlu?=
 =?utf-8?B?NTRLL1BxRnIyTkZLdG4zT3hFR1NKZEVXeXJzczNScFZMeDNXYnRxRWI0MTlZ?=
 =?utf-8?B?bE9CYXlJV0JRSHptbnpPakpZNFRaR3IwSVRxdHVIa0FFcUhidFJlc2g5QzFE?=
 =?utf-8?B?Zk9NbUh6Z215VGJ4MndMMkxkN1ExdkloUkt4Y2krd3Z6TFBKRjFneXBDZSth?=
 =?utf-8?B?bUpKYVZRV0FvVzEraVJKbURMM3JFWFZTa21mQVN1WGphRlFudWZKVS9YaEFn?=
 =?utf-8?B?ZlZXMXEvMnluWGMyMHArK0RMalFPZ2F0elB1M3FLbEFrZWpXVno5djhoalFi?=
 =?utf-8?B?WElmdVltN3JKK2Jpek9SQTBOR2lYMCs4TE10ZzU2d3lZdENuV254YnRIWXFo?=
 =?utf-8?B?elo5VDl5WE8vTXdGNVdkdXc5VS9kdUZiazc4UklYMG0xUmM2ZlVMVXR4ejI5?=
 =?utf-8?B?dzVxN09EVkVEdnZtU2doMVU2TnNCTG9BbE9tOUI2UWtaZzRaTE44RHU1NDln?=
 =?utf-8?B?SXNlMmRWY2J6WlJ1M2lFdHBBUXIrcm43SjRvblhjK1pSQk9VeGlSY2FwUDI0?=
 =?utf-8?B?S21xd2pCc2J3dFltRjVrQUN5MEE3VkY2dDNWL0RpWC9Iallkc1cyeXY3TDJj?=
 =?utf-8?B?aE0ybXFsblU4aU1jQkFXM3h1WnNveWxSdHVVUzYrNE5pUE0xaUJzUWFRN0x4?=
 =?utf-8?B?b1BMLzUvTThEMmxLQldZQkdPOHBuNVA1TnhqdThzZWJFN2J4eVR0Um9VQ2t2?=
 =?utf-8?B?d1AvREJ2cFBHQ3A4SVdKdWw3cDR0a2hDVG15NWVSY0hrSWRoMVhiUlFEKzhN?=
 =?utf-8?B?RWh2bFdJT0NKc1B3Rk0yT2I3dXpjOVBHbzg2bmRQL0xSbkhkRFVOTUNuWXpW?=
 =?utf-8?B?V2h3SWJ5bkJyelVPdWFud2c3WmxNYjFVdktvN1MxOWdSc2ZZbnpDdG9KbFRD?=
 =?utf-8?B?dG5GdW1hTWEwUWM2UERlQ3JMRXRoUDl2Q2k0cWZLQUNrRkI4b1V4RGIxSEEz?=
 =?utf-8?B?WDBWNFQzZkoxQi9VWk1yOVk2WlhYbnNPQ0dCUjVuNHo1K2tCSmJSaXlMUnV1?=
 =?utf-8?B?bE4rM0F4b0tGYXE0Vk5keWJqSUoyMnc3aElzN1NzQWZwOGR4WVA4QlhnNlU2?=
 =?utf-8?B?YjY5alN1TmNvS2RaS2ZodEpPS2srdFpQUEdlWGNieE1ISWhtZmJpRWduSEpU?=
 =?utf-8?B?cjI5ZHN0TVdFQ3dZQlJzODYrc2Y1NzNBUXZGV1FkZDIyUFZ5RFNVQnZFNjBR?=
 =?utf-8?B?ZGc4cG9Za2VxQzdLQ1hKS0Z2a1Z5cytsL0luREhPN0xIOFpyTE1ib3JKZFkz?=
 =?utf-8?B?Mmc4UFkxWjJsSUxCTVBWcFo3bzNsa3V4RmU1ZVExdXdvRnJxOU16YkMyTFZt?=
 =?utf-8?B?VzlGODdCWjVpZHNUNVpBYUxsY0oyNFY0cnFRU2ZPM1BXei9WYjlXcUk0bXpL?=
 =?utf-8?B?Yit0c1ZlRmxoNmtHV1loajhGRXVUekJhbnpHTUozK0F1eksxWWxjWWZpU0ZF?=
 =?utf-8?B?RVNXbnFwZ2hWdmUrT0c5WnQ2Z0Y0Q0xsYkthem9xQTJDc0QvQ3JyOVVCTkdN?=
 =?utf-8?B?V2hyVHBqMnlEQWhFQWxTQ3NOOE1FWVBsWnR6eStIVVJwOS9WNTNrUk9vMjYy?=
 =?utf-8?B?RlhTVjJRVGZCWFRUTTFjbGlGRk1VZ2tabWFJaWkrYVgvY3Y4cmcyaHVkWlp3?=
 =?utf-8?Q?g62Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f46483-4691-4b30-2e7b-08dcde4c20ba
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:56:12.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rGi7dlVi4LfgqxGRmXQzwTV6hc6Tre7caPXz0CZ8iuepupv+V/WiBVrnVxk9HmU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608

Hi Reinette,

On 9/19/24 12:26, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> The mbm_cntr_assign mode provides a limited number of hardware counters
>> that can be assigned to an RMID-event pair to monitor bandwidth while
>> assigned. If all counters are in use, the kernel will show an error
>> message: "Out of MBM assignable counters" when a new assignment is
>> requested. To make space for a new assignment, users must unassign an
>> already assigned counter.
>>
>> Introduce an interface that allows for the unassignment of counter IDs
>> from both the group and the domain. Additionally, ensure that the global
>> counter is released if it is no longer assigned to any domains.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v7: Merged rdtgroup_unassign_cntr and rdtgroup_free_cntr functions.
>>     Renamed rdtgroup_mbm_cntr_test() to rdtgroup_mbm_cntr_is_assigned().
>>     Reworded the commit log little bit.
>>
>> v6: Removed mbm_cntr_free from this patch.
>>     Added counter test in all the domains and free if it is not assigned to
>>     any domains.
>>
>> v5: Few name changes to match cntr_id.
>>     Changed the function names to rdtgroup_unassign_cntr
>>     More comments on commit log.
>>
>> v4: Added domain specific unassign feature.
>>     Few name changes.
>>
>> v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
>>     The function is not called directly from user anymore. These
>>     changes are related to global assignment interface.
>>
>> v2: No changes.
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 49 ++++++++++++++++++++++++++
>>  2 files changed, 51 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 6a90fc20be5b..9a65a13ccbe9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -707,6 +707,8 @@ int resctrl_arch_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  			     u32 cntr_id, bool assign);
>>  int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>  			 struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>> +int rdtgroup_unassign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +			   struct rdt_mon_domain *d, enum resctrl_event_id evtid);
>>  void rdt_staged_configs_clear(void);
>>  bool closid_allocated(unsigned int closid);
>>  int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 1d45120ff2b5..21b9ca4ce493 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1944,6 +1944,55 @@ int rdtgroup_assign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>>  	return 0;
>>  }
>>  
>> +static int rdtgroup_mbm_cntr_is_assigned(struct rdt_resource *r, u32 cntr_id)
> 
> Should this return bool?

Sure.

> 
> With function prefix of "rdtgroup" I would expect that an rdtgroup would be one of its
> parameters but that is not the case ... this is nothing to do with a rdtgroup.
> Maybe something like "mbm_cntr_assigned_to_domain()"?

Sure.

> 
>> +{
>> +	struct rdt_mon_domain *d;
>> +
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list)
> 
> Based on function name it is unexpected that it checks the global bitmap and not the
> domain lists. The function really needs a more appropriate name to reflect what it
> actually does.

ok. The name mbm_cntr_assigned_to_domain() should be fine now.

> 
>> +		if (test_bit(cntr_id, d->mbm_cntr_map))
>> +			return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Unassign a hardware counter from the domain and the group. Global
>> + * counter will be freed once it is unassigned from all the domains.
> 
> Could this also get a similar comment as partner function about special
> meaning of NULL domain?

Sure.

> 
>> + */
>> +int rdtgroup_unassign_cntr(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +			   struct rdt_mon_domain *d,
>> +			   enum resctrl_event_id evtid)
>> +{
>> +	int index = MBM_EVENT_ARRAY_INDEX(evtid);
>> +	int cntr_id = rdtgrp->mon.cntr_id[index];
>> +
>> +	if (cntr_id != MON_CNTR_UNSET) {
> 
> Function can exit early after the MON_CNTR_UNSET check to reduce level of
> indentation in rest of function.

Sure.

> 
>> +		if (!d) {
>> +			list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +				resctrl_arch_assign_cntr(r, d, evtid,
>> +							 rdtgrp->mon.rmid,
>> +							 rdtgrp->closid,
>> +							 cntr_id, false);
>> +				clear_bit(cntr_id, d->mbm_cntr_map);
>> +			}
>> +		} else {
>> +			resctrl_arch_assign_cntr(r, d, evtid,
>> +						 rdtgrp->mon.rmid,
>> +						 rdtgrp->closid,
>> +						 cntr_id, false);
>> +			clear_bit(cntr_id, d->mbm_cntr_map);
>> +		}
>> +
>> +		/* Update the counter bitmap */
>> +		if (!rdtgroup_mbm_cntr_is_assigned(r, cntr_id)) {
>> +			mbm_cntr_free(r, cntr_id);
>> +			rdtgrp->mon.cntr_id[index] = MON_CNTR_UNSET;
>> +		}
>> +	}
>> +
>> +	return 0;
> 
> This function is called many times and there are always paths adding complexity
> to handle error from this function ... yet it always returns 0. I expect that it should
> actually do error checking of the arch callback that could actually fail on other archs, that
> should impact this function's return value and make the need for error handling apparent.

Sure. Will do it.

> 
>> +}
>> +
>>  /* rdtgroup information files for one cache resource. */
>>  static struct rftype res_common_files[] = {
>>  	{
> 
> 
> Reinette
> 

-- 
Thanks
Babu Moger

