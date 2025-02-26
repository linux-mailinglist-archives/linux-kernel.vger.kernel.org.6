Return-Path: <linux-kernel+bounces-534505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26685A4679A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BD93AFB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983DC224895;
	Wed, 26 Feb 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pfiNHHHD"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18767224AE6;
	Wed, 26 Feb 2025 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589939; cv=fail; b=dL1TTijBePUB5uhXzx3hTbiOfV9YbAyP6QCk4Hl7iWiKkfO2qyDQjeu1FFLEuX5z7jPbbtx4SqELIji6GAZrOnmcHwEL9lCQ9zKj8TLtuLTIHmDCBxFQl0rjobCmwdku3MrYlWfq6Ep9NAqIGb1rUq2E+bmInNsDnT8Jbwn0eCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589939; c=relaxed/simple;
	bh=r7aCqZu4FoM47kl8D355kOYKXrc1J0tCB+TBh/eGlpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7+Umft0kg3H+z4u1naJTeJhsw3F7i0v4iNBrETK348RMhZ4GMQS6HOVgwbakW6+kjMHNr1aFcxcJZ5eTcW3R7vHbmgLvnHT1kU5eOFfIj6wVbvZsuzEO+Cq6Lz7g72wYyw70Cit2AkIub4CPQwmYC4HsHuXDyj9nIIKGahysWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pfiNHHHD; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsNRwIYvlTEMeW/HNuywpQbKc5pUhNPwX9Br0mTmJmjMFfvNFi54IHYUJKoIMVKG1tNsy8aN5vJwphCed+uAg7Fx3Jh/84ux0GNAxKYUXYkqvYjoY6kBGZixoSCACuKbUpIzwEU02moe0RYppZHdGdzhyWdkOHsqPVEj7g/7ep4eUdJC+FhLrlIZaJzz6cW+cmCOBW2W+2DtpC+3eBlNMcT2Jhy0FlsvlHySzzwz/xps5nG8ZNUnybqzQm/Dqro7Dfp5iuMXip0zkCjkbkwQDzmXxlTZO6XF1MUVktDwzcsxQk4Gqdxxy5rFqqb6ZAW8mCRtM61M4OH/YoJRtqYSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYl6HGu/XWocBsR4CfvESjko6oSILmQ6fQKd/lzqg/g=;
 b=P+uZ9CBmeMmD2uFIHAgNa0EUvyKei64ZDgzTvSBY52j0d5v5vuNqFnDvjJjOm2SWvDOItGGrukjQk8kfjOtp48pZItYkeHiJA1qKHHuyQp3r1/rzR7G2UIhpNprbeZF0UYf2IGRTdIPdLGYULxxGDGqg2J1y8gA7JhVqo1g4C7TXlcy2oZ38vlXfrSOU8WehERQ9pEF1ncUPv4ejc0gFbI08m2kYLJvKUoTomOFEclMbVi+SJ1Gcd/2ScvgNL0bGiXBSnM0ZeaaMSZ1c2t2NZ73f3JpqjmMv3e2bqyiX6e0qPibpb3pkSH49fC3F7QpwfuoYFdBJ8PMIfVRQoN/z3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYl6HGu/XWocBsR4CfvESjko6oSILmQ6fQKd/lzqg/g=;
 b=pfiNHHHDnF46PVza26D2me3+Lt6k+PIF9lPVIz9g73V6dHP2rsr6vnrR4EC5FZF9TO8OGfI5O5KCUqABxRYmiNPrre/SLPE0XFfevZYqMshwx8KVpNCI1N6oeLUXJ2f23Fn6vEwRE1ZQzoQfmiXs1kN7J0zFLn1rWLDS/VrMq+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Wed, 26 Feb
 2025 17:12:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Wed, 26 Feb 2025
 17:12:14 +0000
Message-ID: <1122252b-55b9-4337-8e95-a95d3be95503@amd.com>
Date: Wed, 26 Feb 2025 11:12:07 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 00/23] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>
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
 <9e849476-7c4b-478b-bd2a-185024def3a3@intel.com>
 <Z64tw2NbJXbKpLrH@e133380.arm.com>
 <76b02daf-1b45-473e-9d75-5988a11c6887@intel.com>
 <8ef51f28-e01a-4a7d-ba86-059437edb60b@amd.com>
 <a07fca4c-c8fa-41a6-b126-59815b9a58f9@intel.com>
 <CALPaoCh7WpohzpXhSAbumjSZBv1_+1bXON7_V1pwG4bdEBr52Q@mail.gmail.com>
 <ccd9c5d7-0266-4054-879e-e084b6972ad5@intel.com>
 <CALPaoCj1TH+GN6+dFnt5xuN406u=tB-8mj+UuMRSm5KWPJW2wg@mail.gmail.com>
 <2b5a11e3-ee19-47ba-b47e-b7de2818f237@intel.com>
 <CALPaoChXvLNMg240C7RyBvg0SxXfGf_ozKC6X7Qe4OxyEcL2tw@mail.gmail.com>
 <a3b46f6f-a844-4648-905e-53d662e5715f@intel.com>
 <CALPaoCi0mFZ9TycyNs+SCR+2tuRJovQ2809jYMun4HtC64hJmA@mail.gmail.com>
 <fc3a67ee-6e97-4b9f-88d9-c24c6dab20c3@intel.com>
 <CALPaoCg97cLVVAcacnarp+880xjsedEWGJPXhYpy4P7=ky4MZw@mail.gmail.com>
 <a9078e7d-9ce6-4096-a2da-b2c6aae1e3ed@amd.com>
 <CALPaoCgN+oGgdp40TOJ9NgF9WYPdN0cG8A8BtOOMXOP6iMVfzw@mail.gmail.com>
 <eb62be12-3a1f-4aad-b50f-bf71188ced75@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <eb62be12-3a1f-4aad-b50f-bf71188ced75@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0184.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdb8dbb-3f9b-481c-d2fd-08dd5688b6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnQyTVNoNjJGQlFOdFBmdE9ES2ZNbE9PSDR2T0NLaDZ0RU56OVppVUxudy9M?=
 =?utf-8?B?VFJidmpYdWtNdmRDRjZkYUxQaFdoR2JBL3B6ZTArSk5EcVFFVWNYc1hoem1q?=
 =?utf-8?B?aXBWQ2pyb2xWZ1BtWUdTSFFHMDMvenZqbU1GNzBXYUZRTGhRYkxsY09ROG05?=
 =?utf-8?B?SGNjMkNhWlVKTFc3UFErUkZMaFR4a0ltL0ptcGhtZStEOG1WUE1Ec1E3M0g0?=
 =?utf-8?B?R0NWN28zbnR1dm05NjNsVkxJUWxybXN0YTJLUERNbVVId1JlK3VOWTlhTmFl?=
 =?utf-8?B?WDFsK3ozTVNNVC82ZGZuWmlUSElYU0hmeHkxK3BvSU9pa2xWb2Fob3FXOUVN?=
 =?utf-8?B?ZTFnWUNLYTI0UjA3R1c5ZXpjeGtxT2dkdUhyYVBEbThTYStzNVNLczFLRFZB?=
 =?utf-8?B?MEZEQ1NuTGhSZWlxZWhtUDZRWlVXNFJYNjlNSnZRaWtiQkQ2SHRKYStNMkhj?=
 =?utf-8?B?bm9xT24zNkNUc2c2cndFODdWTjV5Zi94RVJnTm9jaG1ROTBjamRhaGdRcTlJ?=
 =?utf-8?B?SGQ1MGVnV21KblQxM3NsQ3lMcXhCb0ozdXd1TUg1SDh3aDdFQloxQnovckFT?=
 =?utf-8?B?NFFRRkRzTzdoSjBZOGJKM25EVUxXREYrM3prR0tHN3RIOGs3L28yTnM5YVZr?=
 =?utf-8?B?NXhHVzYzcDdZTlp2MUJUQjlnQVlENXhBWEFBaFNZTEI2dFdXaldBMElqaS9I?=
 =?utf-8?B?ZDh0ejBIMFZnV0ovTTl1bUxmUk4zV2FxaGlBNlh5SmJTVlFsTGk4OHdVbkJa?=
 =?utf-8?B?RUY2T2JDUC9UcEVIdFJpbWQzNU5ZdW9UelRqT3VZMW5YemJuL0lRUDZzb3k1?=
 =?utf-8?B?RnZZbmlHbWVwL3k3OWRkTmRVYUVMbGVaT3RUU3FranM5bUhVWHpJVVY5SHRW?=
 =?utf-8?B?amh1NzdVZFBsK1lGT2FhMXdobEVZZ0FxdkRXNW5wdDNOaEZOZ29MaU04a0hX?=
 =?utf-8?B?QlNQSys1eUQ1N1d6bHEyYktEajFMYm1zN0Z2WW0wclNqRHM2N2JIOEZVSThV?=
 =?utf-8?B?SVg4OEFVdEpHYkRjR00xNWN1ZEZTVGN6QkJaRlY5YVlmWm15Q0hlQys0SS9R?=
 =?utf-8?B?NDNPYWRLTlJwb2dlUktSUzJmVzdHV2pQUXJRYU5HS0RnRHdxY2t6bmNuQmZj?=
 =?utf-8?B?R1F6T1ZhcElJWjJkZllYRE1lMS9qVkdDSlZCdVpXR3VsbG1KYVI3RVFvTDlD?=
 =?utf-8?B?RTJYbzl0YytKdWxibUlaVENOT1NwcFBSMWxqdWN6NlgwT29BaVRGc2F1OEMz?=
 =?utf-8?B?NHRaQ2ZCR2NlZnF5SnBOUzVyRWhOaER5Y1lKSEgxSnYySmZqU1EvbStxMUJR?=
 =?utf-8?B?cFQ4SDUxMlovT0N0dXB0QlpiZUg0ejE1eE9VUXptMWM2T08xcytkUXVqWFRB?=
 =?utf-8?B?SUlQY1Rsb0JHRGFQMGpMdWc2NFVGU1UyZGwzMXcyWTlDdnpra2JCaGh0WXRm?=
 =?utf-8?B?MUhhZlJZTEF6bFRpdmhtTnNPQTdZUHVITzM2d1h4Z3RZS0hqWUtJMUZ6NEVj?=
 =?utf-8?B?MG9nOFVQSHA1SjA1Skl0UXU0TG5zclFYRkR0bW15MnFQUldLZkF3UlNucGd4?=
 =?utf-8?B?Z0hrU2JCQ1VYa0lVak9YaVJnaUFlSlBiZUhxSWVkK0ZDcEdEZ0M1cStuaXhv?=
 =?utf-8?B?Mmp3WXZia3RDU25lMkFQU2tuR3pGV3RGcE1SMk1oUUI4MGk2aFY2dU1rekRl?=
 =?utf-8?B?R3Vlb2xqRWMrVis4eklYS2NoaUp4TmpFRTVlVmkycm1iUFQ4Y25lVWRWOXdB?=
 =?utf-8?B?dE5uZ1dRMUNrOVhzYjcxMmZibWk1VnRYcFlBb2prMTd2ZFpUeFhzNlM0dTdR?=
 =?utf-8?B?bmVWRVZyN3NDdnMxNU1paWtEdEhOUmlIaDl0MjhhK05BSU14SnNLcHRBeGN0?=
 =?utf-8?B?YWVJZjcwVTVlaXlsZWNFUFlydFlOeHRxMzBNa1ZhQ3BZSEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnVzNUp6REsxZVowZTBvRktzczFjUzE0NWs5MVErWTB6VDgvZktsNFlUUWp0?=
 =?utf-8?B?czJET3dtOVgwOWZzdmtaMlRoeWFXK08vdTJ5akJwNzBLbUx3V0ZCbXlvK0xl?=
 =?utf-8?B?L3lMY1NqUEROeklKWHFmeWNnZkV2eDNzWjYydzFTclIvZ3FQMEpMam1PRnRl?=
 =?utf-8?B?d3JjekxxbG9NRkg3WjRjL0FsbTk0aFRHSmNMditwdnRwK3IwKzFjZllYbmNx?=
 =?utf-8?B?QjQwZVBMZE5xUkIvZDBaOW14cUZPWFNIUFVMU3BrWE05R2pqSTlDdFpsNlBC?=
 =?utf-8?B?bFR4dGkxQ1FTTmZPZWlvYTZJTHJ4R3lFcTA2VmhOM3piKzY5a0ZwRlFyaDBN?=
 =?utf-8?B?dGpKaUhncC9KZjdPRGhGMFpYTlNybzF2YVc0eXFJYjZVNXM5OXBFNFlqWGtH?=
 =?utf-8?B?elNLUVUzeXJSNXNMU3N4aGd4RExCVjMzT3ZObzU2Qm1XUXJ3Ujl4UHVlaFVj?=
 =?utf-8?B?cFVrbDF4ZDFuYlZVSktzbTdwSHVadmpvZHBDV3ZCU3lIeG9STlhsYjFVUit1?=
 =?utf-8?B?Q1ZQSllCc1RBcU1kTUxSRWZSWERETlJEVzFXSUUrUGlEbkdzZDc0QmVjRWZo?=
 =?utf-8?B?RHF0U2VxKzhLbEhYcEt6WkloSjlYSk01OGM3N3N1M3Fwa3dwR0Uwam5pWTJC?=
 =?utf-8?B?a1d0ajFUbjdkRXdPa3I5Z1NEYTRtbVlnaXMvQVJaeWRxTzlFWVhMRlFSdWls?=
 =?utf-8?B?Ti8rOU92R09KbDBGVUxCSFA1YmFOdGZucVM4RE1xVllnNm40eUp6WEx0N3dm?=
 =?utf-8?B?Ylk2WUdKZ1VJOHVJM3VpVGVNbjEzUVhiYmxXUXlydlg5UTVUaGh0cnpjL1FU?=
 =?utf-8?B?MUdHNDREZlZMeXV1cXdhVzhlL1FqMzZsREx1dXJEcEc0WGxLeVhzSGEvYjhi?=
 =?utf-8?B?Zk9UWVRycURFNGlvNEg0UFpCUm5nMkZ6TlVQZlMzS1dhQk5uVk9SWlhTWE9u?=
 =?utf-8?B?bVZBVjFHNnF0VU1EMzNodjZXcmFNN09OSkFYSHJkMVZndk9yNUxpY2dMVnhU?=
 =?utf-8?B?TEFSOTUzVkp5YU5rTklabkFiUDlKeGFoV2lvOGpQelQyV2lEL21ZdFQvT1VP?=
 =?utf-8?B?bHQzcEVZWGI3alBrbkJZRTNWa0xCZU01OUt1U2YvaHZPNWl5Q1Q3anVpNjQy?=
 =?utf-8?B?SGR2WURGY1c0MUZRakZtNFRpY0NnMFJpZnNBTDZSaXZOU2NqSi9nQ3MyajM5?=
 =?utf-8?B?WE5ScXlUSC85SjFyZSthTHErWDByWDdoZzdRQzkrZVloVmF5Q0RFR2NWNjlk?=
 =?utf-8?B?YjY5SHQzT3RJZ2FMVWZRNUZPQ3dveUo4TnBFYlVwc1ZyWENDdjR1NE5VTnhP?=
 =?utf-8?B?akJlcmt2RkVmVG0yclorYnRzSld1enVCRTZCbGQzNXBGNEFxRWh3TGl3YURR?=
 =?utf-8?B?VVQ2MkJBN3ZKc1U5cWV1bFVCUXZBQmsxNGJrT0RkdFRhZlppSTY0dEVYeHRP?=
 =?utf-8?B?dDZEcndybEVqTHkrWnlwNWgvdzBCNmZoeUZmcDJKRnJjRmhDNFJ2RTFlNTht?=
 =?utf-8?B?OXZORGhJZnc0ejl3U1VLQUV0YjBDTkI2bU1LOFVPa3g3NmRNNTc2ZXJWeEcv?=
 =?utf-8?B?ayt6dVpuMFJpYWJ5b0R3WGhBOG9iczBQTjBCTmpKanByRnZkdTBRTzA5SWlV?=
 =?utf-8?B?S1Q4U2dkL3FoL1k1ZDZnMXFsbjBVbVExUTNqTFl3OFVuZHNSbzY3ejg1Umwr?=
 =?utf-8?B?VkZwRTRreDVNM3l4eXpzbU5PbnArQmdTNFdhb240UitXaUN6cEhsZ3REbmZw?=
 =?utf-8?B?bDRsVkhFcWkwd2ZneHJJRzc5QVNVeEJ0QlZSYWVSc29vK0pLeEFLTDdSdUhC?=
 =?utf-8?B?dThzdHBhTkc1YXVTYXhoVW8rVmY2OWxTSit6dHUybVlUaGVERTJHSlNpSWxl?=
 =?utf-8?B?ZGdXVW10NUlUQjVwN0JHK1RacWkzVGtMQXR3bzdCT0Z6RTBZNWdnbEdnYmdB?=
 =?utf-8?B?V1YrWGlHeU5MMUlKcVgyT3ArdWJWWHNwREJaMHJSZTdNTUpVaEFUaS9EMDFi?=
 =?utf-8?B?SzN6cTZTRmIzNjVnVU51alR1TzU5dzkzSThMZWtIZFJ2L0ZtT1ZRd2RSbXQz?=
 =?utf-8?B?M1BielhObnZIcndSM3ZyV1gwcWNnUXVFVFBZMU5laVB1OTFLRUxtSDAzRFZH?=
 =?utf-8?Q?hzhY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb8dbb-3f9b-481c-d2fd-08dd5688b6c3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 17:12:13.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CTPByOM10kT3cFuGQjVgUvODLxXs/Kl/yPBQnzSEC1ekw6nxD1WBoSsiI3xFvhb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431

Hi Peter/Reinette,

On 2/26/25 10:25, Reinette Chatre wrote:
> Hi Peter,
> 
> On 2/26/25 5:27 AM, Peter Newman wrote:
>> Hi Babu,
>>
>> On Tue, Feb 25, 2025 at 10:31 PM Moger, Babu <babu.moger@amd.com> wrote:
>>>
>>> Hi Peter,
>>>
>>> On 2/25/25 11:11, Peter Newman wrote:
>>>> Hi Reinette,
>>>>
>>>> On Fri, Feb 21, 2025 at 11:43 PM Reinette Chatre
>>>> <reinette.chatre@intel.com> wrote:
>>>>>
>>>>> Hi Peter,
>>>>>
>>>>> On 2/21/25 5:12 AM, Peter Newman wrote:
>>>>>> On Thu, Feb 20, 2025 at 7:36 PM Reinette Chatre
>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>> On 2/20/25 6:53 AM, Peter Newman wrote:
>>>>>>>> On Wed, Feb 19, 2025 at 7:21 PM Reinette Chatre
>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>> On 2/19/25 3:28 AM, Peter Newman wrote:
>>>>>>>>>> On Tue, Feb 18, 2025 at 6:50 PM Reinette Chatre
>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>> On 2/17/25 2:26 AM, Peter Newman wrote:
>>>>>>>>>>>> On Fri, Feb 14, 2025 at 8:18 PM Reinette Chatre
>>>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>>> On 2/14/25 10:31 AM, Moger, Babu wrote:
>>>>>>>>>>>>>> On 2/14/2025 12:26 AM, Reinette Chatre wrote:
>>>>>>>>>>>>>>> On 2/13/25 9:37 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>> On Wed, Feb 12, 2025 at 03:33:31PM -0800, Reinette Chatre wrote:
>>>>>>>>>>>>>>>>> On 2/12/25 9:46 AM, Dave Martin wrote:
>>>>>>>>>>>>>>>>>> On Wed, Jan 22, 2025 at 02:20:08PM -0600, Babu Moger wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> (quoting relevant parts with goal to focus discussion on new possible syntax)
>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I see the support for MPAM events distinct from the support of assignable counters.
>>>>>>>>>>>>>>>>> Once the MPAM events are sorted, I think that they can be assigned with existing interface.
>>>>>>>>>>>>>>>>> Please help me understand if you see it differently.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Doing so would need to come up with alphabetical letters for these events,
>>>>>>>>>>>>>>>>> which seems to be needed for your proposal also? If we use possible flags of:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> mbm_local_read_bytes a
>>>>>>>>>>>>>>>>> mbm_local_write_bytes b
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Then mbm_assign_control can be used as:
>>>>>>>>>>>>>>>>> # echo '//0=ab;1=b' >/sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_read_bytes
>>>>>>>>>>>>>>>>> <value>
>>>>>>>>>>>>>>>>> # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
>>>>>>>>>>>>>>>>> <sum of mbm_local_read_bytes and mbm_local_write_bytes>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> One issue would be when resctrl needs to support more than 26 events (no more flags available),
>>>>>>>>>>>>>>>>> assuming that upper case would be used for "shared" counters (unless this interface is defined
>>>>>>>>>>>>>>>>> differently and only few uppercase letters used for it). Would this be too low of a limit?
>>>>>>>>>>>>>
>>>>>>>>>>>>> As mentioned above, one possible issue with existing interface is that
>>>>>>>>>>>>> it is limited to 26 events (assuming only lower case letters are used). The limit
>>>>>>>>>>>>> is low enough to be of concern.
>>>>>>>>>>>>
>>>>>>>>>>>> The events which can be monitored by a single counter on ABMC and MPAM
>>>>>>>>>>>> so far are combinable, so 26 counters per group today means it limits
>>>>>>>>>>>> breaking down MBM traffic for each group 26 ways. If a user complained
>>>>>>>>>>>> that a 26-way breakdown of a group's MBM traffic was limiting their
>>>>>>>>>>>> investigation, I would question whether they know what they're looking
>>>>>>>>>>>> for.
>>>>>>>>>>>
>>>>>>>>>>> The key here is "so far" as well as the focus on MBM only.
>>>>>>>>>>>
>>>>>>>>>>> It is impossible for me to predict what we will see in a couple of years
>>>>>>>>>>> from Intel RDT, AMD PQoS, and Arm MPAM that now all rely on resctrl interface
>>>>>>>>>>> to support their users. Just looking at the Intel RDT spec the event register
>>>>>>>>>>> has space for 32 events for each "CPU agent" resource. That does not take into
>>>>>>>>>>> account the "non-CPU agents" that are enumerated via ACPI. Tony already mentioned
>>>>>>>>>>> that he is working on patches [1] that will add new events and shared the idea
>>>>>>>>>>> that we may be trending to support "perf" like events associated with RMID. I
>>>>>>>>>>> expect AMD PQoS and Arm MPAM to provide related enhancements to support their
>>>>>>>>>>> customers.
>>>>>>>>>>> This all makes me think that resctrl should be ready to support more events than 26.
>>>>>>>>>>
>>>>>>>>>> I was thinking of the letters as representing a reusable, user-defined
>>>>>>>>>> event-set for applying to a single counter rather than as individual
>>>>>>>>>> events, since MPAM and ABMC allow us to choose the set of events each
>>>>>>>>>> one counts. Wherever we define the letters, we could use more symbolic
>>>>>>>>>> event names.
>>>>>>>>>
>>>>>>>>> Thank you for clarifying.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> In the letters as events model, choosing the events assigned to a
>>>>>>>>>> group wouldn't be enough information, since we would want to control
>>>>>>>>>> which events should share a counter and which should be counted by
>>>>>>>>>> separate counters. I think the amount of information that would need
>>>>>>>>>> to be encoded into mbm_assign_control to represent the level of
>>>>>>>>>> configurability supported by hardware would quickly get out of hand.
>>>>>>>>>>
>>>>>>>>>> Maybe as an example, one counter for all reads, one counter for all
>>>>>>>>>> writes in ABMC would look like...
>>>>>>>>>>
>>>>>>>>>> (L3_QOS_ABMC_CFG.BwType field names below)
>>>>>>>>>>
>>>>>>>>>> (per domain)
>>>>>>>>>> group 0:
>>>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>> group 1:
>>>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>> ...
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I think this may also be what Dave was heading towards in [2] but in that
>>>>>>>>> example and above the counter configuration appears to be global. You do mention
>>>>>>>>> "configurability supported by hardware" so I wonder if per-domain counter
>>>>>>>>> configuration is a requirement?
>>>>>>>>
>>>>>>>> If it's global and we want a particular group to be watched by more
>>>>>>>> counters, I wouldn't want this to result in allocating more counters
>>>>>>>> for that group in all domains, or allocating counters in domains where
>>>>>>>> they're not needed. I want to encourage my users to avoid allocating
>>>>>>>> monitoring resources in domains where a job is not allowed to run so
>>>>>>>> there's less pressure on the counters.
>>>>>>>>
>>>>>>>> In Dave's proposal it looks like global configuration means
>>>>>>>> globally-defined "named counter configurations", which works because
>>>>>>>> it's really per-domain assignment of the configurations to however
>>>>>>>> many counters the group needs in each domain.
>>>>>>>
>>>>>>> I think I am becoming lost. Would a global configuration not break your
>>>>>>> view of "event-set applied to a single counter"? If a counter is configured
>>>>>>> globally then it would not make it possible to support the full configurability
>>>>>>> of the hardware.
>>>>>>> Before I add more confusion, let me try with an example that builds on your
>>>>>>> earlier example copied below:
>>>>>>>
>>>>>>>>>> (per domain)
>>>>>>>>>> group 0:
>>>>>>>>>>  counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>  counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>> group 1:
>>>>>>>>>>  counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>>>>  counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>>>> ...
>>>>>>>
>>>>>>> Since the above states "per domain" I rewrite the example to highlight that as
>>>>>>> I understand it:
>>>>>>>
>>>>>>> group 0:
>>>>>>>  domain 0:
>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>>  domain 1:
>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>> group 1:
>>>>>>>  domain 0:
>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>  domain 1:
>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>
>>>>>>> You mention that you do not want counters to be allocated in domains that they
>>>>>>> are not needed in. So, let's say group 0 does not need counter 0 and counter 1
>>>>>>> in domain 1, resulting in:
>>>>>>>
>>>>>>> group 0:
>>>>>>>  domain 0:
>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>> group 1:
>>>>>>>  domain 0:
>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>  domain 1:
>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>
>>>>>>> With counter 0 and counter 1 available in domain 1, these counters could
>>>>>>> theoretically be configured to give group 1 more data in domain 1:
>>>>>>>
>>>>>>> group 0:
>>>>>>>  domain 0:
>>>>>>>   counter 0: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>   counter 1: VictimBW,LclNTWr,RmtNTWr
>>>>>>> group 1:
>>>>>>>  domain 0:
>>>>>>>   counter 2: LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>>   counter 3: VictimBW,LclNTWr,RmtNTWr
>>>>>>>  domain 1:
>>>>>>>   counter 0: LclFill,RmtFill
>>>>>>>   counter 1: LclNTWr,RmtNTWr
>>>>>>>   counter 2: LclSlowFill,RmtSlowFill
>>>>>>>   counter 3: VictimBW
>>>>>>>
>>>>>>> The counters are shown with different per-domain configurations that seems to
>>>>>>> match with earlier goals of (a) choose events counted by each counter and
>>>>>>> (b) do not allocate counters in domains where they are not needed. As I
>>>>>>> understand the above does contradict global counter configuration though.
>>>>>>> Or do you mean that only the *name* of the counter is global and then
>>>>>>> that it is reconfigured as part of every assignment?
>>>>>>
>>>>>> Yes, I meant only the *name* is global. I assume based on a particular
>>>>>> system configuration, the user will settle on a handful of useful
>>>>>> groupings to count.
>>>>>>
>>>>>> Perhaps mbm_assign_control syntax is the clearest way to express an example...
>>>>>>
>>>>>>  # define global configurations (in ABMC terms), not necessarily in this
>>>>>>  # syntax and probably not in the mbm_assign_control file.
>>>>>>
>>>>>>  r=LclFill,RmtFill,LclSlowFill,RmtSlowFill
>>>>>>  w=VictimBW,LclNTWr,RmtNTWr
>>>>>>
>>>>>>  # legacy "total" configuration, effectively r+w
>>>>>>  t=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>>>
>>>>>>  /group0/0=t;1=t
>>>>>>  /group1/0=t;1=t
>>>>>>  /group2/0=_;1=t
>>>>>>  /group3/0=rw;1=_
>>>>>>
>>>>>> - group2 is restricted to domain 0
>>>>>> - group3 is restricted to domain 1
>>>>>> - the rest are unrestricted
>>>>>> - In group3, we decided we need to separate read and write traffic
>>>>>>
>>>>>> This consumes 4 counters in domain 0 and 3 counters in domain 1.
>>>>>>
>>>>>
>>>>> I see. Thank you for the example.
>>>>>
>>>>> resctrl supports per-domain configurations with the following possible when
>>>>> using mbm_total_bytes_config and mbm_local_bytes_config:
>>>>>
>>>>> t(domain 0)=LclFill,RmtFill,LclSlowFill,RmtSlowFill,VictimBW,LclNTWr,RmtNTWr
>>>>> t(domain 1)=LclFill,RmtFill,VictimBW,LclNTWr,RmtNTWr
>>>>>
>>>>>    /group0/0=t;1=t
>>>>>    /group1/0=t;1=t
>>>>>
>>>>> Even though the flags are identical in all domains, the assigned counters will
>>>>> be configured differently in each domain.
>>>>>
>>>>> With this supported by hardware and currently also supported by resctrl it seems
>>>>> reasonable to carry this forward to what will be supported next.
>>>>
>>>> The hardware supports both a per-domain mode, where all groups in a
>>>> domain use the same configurations and are limited to two events per
>>>> group and a per-group mode where every group can be configured and
>>>> assigned freely. This series is using the legacy counter access mode
>>>> where only counters whose BwType matches an instance of QOS_EVT_CFG_n
>>>> in the domain can be read. If we chose to read the assigned counter
>>>> directly (QM_EVTSEL[ExtendedEvtID]=1, QM_EVTSEL[EvtID]=L3CacheABMC)
>>>> rather than asking the hardware to find the counter by RMID, we would
>>>> not be limited to 2 counters per group/domain and the hardware would
>>>> have the same flexibility as on MPAM.
>>>
>>> In extended mode, the contents of a specific counter can be read by
>>> setting the following fields in QM_EVTSEL: [ExtendedEvtID]=1,
>>> [EvtID]=L3CacheABMC and setting [RMID] to the desired counter ID. Reading
>>> QM_CTR will then return the contents of the specified counter.
>>>
>>> It is documented below.
>>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
>>>  Section: 19.3.3.3 Assignable Bandwidth Monitoring (ABMC)
>>>
>>> We previously discussed this with you (off the public list) and I
>>> initially proposed the extended assignment mode.
>>>
>>> Yes, the extended mode allows greater flexibility by enabling multiple
>>> counters to be assigned to the same group, rather than being limited to
>>> just two.
>>>
>>> However, the challenge is that we currently lack the necessary interfaces
>>> to configure multiple events per group. Without these interfaces, the
>>> extended mode is not practical at this time.
>>>
>>> Therefore, we ultimately agreed to use the legacy mode, as it does not
>>> require modifications to the existing interface, allowing us to continue
>>> using it as is.
>>>
>>>>
>>>> (I might have said something confusing in my last messages because I
>>>> had forgotten that I switched to the extended assignment mode when
>>>> prototyping with soft-ABMC and MPAM.)
>>>>
>>>> Forcing all groups on a domain to share the same 2 counter
>>>> configurations would not be acceptable for us, as the example I gave
>>>> earlier is one I've already been asked about.
>>>
>>> I don’t see this as a blocker. It should be considered an extension to the
>>> current ABMC series. We can easily build on top of this series once we
>>> finalize how to configure the multiple event interface for each group.
>>
>> I don't think it is, either. Only being able to use ABMC to assign
>> counters is fine for our use as an incremental step. My longer-term
>> concern is the domain-scoped mbm_total_bytes_config and
>> mbm_local_bytes_config files, but they were introduced with BMEC, so
>> there's already an expectation that the files are present when BMEC is
>> supported.

It's good that we at least know about this concern now. Let's take a step
back and figure out how we can address it.

>>
>> On ABMC hardware that also supports BMEC, I'm concerned about enabling
>> ABMC when only the BMEC-style event configuration interface exists.
> 
> ABMC currently depends on BMEC making the current implementation the
> one you are concerned about?
> https://lore.kernel.org/lkml/e4111779ebb0e7004dbedc258eeae2677f578ab1.1737577229.git.babu.moger@amd.com/

I think it is more than that.

The ABMC feature allows event configuration by writing to L3_QOS_ABMC_CFG,
where we can set cntr_id, RMID, and event configuration. Currently, we
derive event configuration from BMEC settings (either
mbm_total_bytes_config or mbm_local_bytes_config).

If we don’t use BMEC values, we would need to require users to manually
specify event configuration settings.

struct mbm_cntr_cfg {
        enum resctrl_event_id   evtid;
        struct rdtgroup         *rdtgrp;
};

Currently, we determine the RMID from the rdtgroup and the event type,
while event configuration relies on BMEC:


To make event configuration independent of BMEC, we can include an
explicit event configuration field:

struct mbm_cntr_cfg {
        enum resctrl_event_id   evtid;
        u32                     evt_cfg;  // User-provided config value
        struct rdtgroup         *rdtgrp;
};

Key Considerations

1.  Counter Management: Managing counters globally (like CLOSID
management) would be simpler than handling them at the domain level,
though domain-level management is feasible.

2. User Input: Users will need to specify event configuration when
assigning events.


Here is the quick example using our current interface:
a. List the group.

#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
//0=t:0x1F,l:0x15;1=t:0x1F,l:0x15

b. Unassign an Event:

#echo "//0-l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
//0=t:0x1F;1=t:0x1F,l:0x15

c. Assign an Event:

#echo "//0+l:0x15" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control

Note that I dont want to rush here.

Peter, Can you please spend some time and propose the interface you are
thinking of based on both ABMC and MPAM.

> 
>> The scope of my issue is just whether enabling "full" ABMC support
>> will require an additional opt-in, since that could remove the BMEC
>> interface. If it does, it's something we can live with.
> 
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

