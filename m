Return-Path: <linux-kernel+bounces-570549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44102A6B1E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81598A4E89
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813CB1EDA05;
	Thu, 20 Mar 2025 23:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pguqf2h+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97071215770
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514938; cv=fail; b=NCnVdFhc0MixVvdgtwHTWPOm4YGrqulr67edGdryp20mQ8O+OcfVNAvgtgzgTTIzYqzGbe9wZUKs7QIaXq6Q51GbaavPhMTJjg2hzWGphnxmwtUWSRKRIxekZR0bEqQ/tzT1AdtK02lp1wR7/wC7p138k/YNkFEBIN3kp9yjvrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514938; c=relaxed/simple;
	bh=cOVK8HY5+Gk6tz/PzNwbfKvSwScNVAl47eHia/2yMd4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uF1/kgKr3AhD2umCQZIKNVl1ndipyKmb29Z1oGAbrBuY61iDDh8abTJ2ClsCjk2thixAB+SsLJQvS7xmDpvg7OY21/ncGvtcONwqGy2p+VkjGXhVbo0xBuzKUBQbA7NLqxtgjBDALE3oLDLnzVDdxAZLM/bSJ9bNX7F8DKXd3GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pguqf2h+; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTlqAVVHVwOVoavnHwLNeX6YnHaS9+iH6BapC7SJc/oD/ENduP8frozUCDJglGx8dIOPrxbg1XU+DLtemv6LNXvcMKYVcxrvR+J1uJlA+2PFGeuYS455OID85LeaMvEr9SX8QthCb03CM5Da2oV4Vyq/fAJH91upFyvI6d07xD81maMBRpsmlKBfpP0lglaqkfvn13fe/6FCsL43EnkdDkL2O+MfKzbYdKPz0atSAMiY4b+oyl95fhakVrv4B5xyGJ/KReyrZuPfhY8udMTh5IM8AMjTNbzQ7VruBYaCjJzCFq9rrLUfspOO9mmezJrxNXwyYZjtyfJrW0yP6cR7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT9B61ZHRpbdy48CQKMjSIruIkSQKzX9a5Jkqf+5PIQ=;
 b=rRIXEySM5xB9DfW7SQrEtKgipD6cZbXATwksQzYi4Q+omHn+uvpdviLNr6ZAIF1Wl6TTKktNyUWVbKR8Axx/41ff0A+cWTKNCOLbEpcpYxy/6X1BB0K4wxW4OyGuLAOKlN3EUpHUi0IBONq3QHPtxDN08wWHHyWwqaidZmdMo2ApXUv00zBjUQCQ49ccgESrBEk7l9OHc3kpI//s195oW3uHiCHWA/MBHEfm5AjULNBy70Z0qytcYHL/5D7aPPCXnQ9XJvtKL334duskXP292LcF6Q1yw1e7c/Z8JRUzpnlEByk+kaO8+bVv4u24j/3iISResjXhx47ZoCWH2piYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AT9B61ZHRpbdy48CQKMjSIruIkSQKzX9a5Jkqf+5PIQ=;
 b=pguqf2h+NJzLDeDtde6vOiwheOD4dGIx+naaePHw04/Oor/HmWTlP2ZDbRpTG+dIWIpk+68QbgFItd62+xnrLlwQ81QFKplO6PRrFsxdyOmOTTH/T1jktOmoZmqiFqYXw7yiRNefNrKgIvmdgZmbGHpfh3YT4vHEYeybNOLLxpdRPNKsehjK1AW0PlvhrtKr2tk4hmI83DUFk0ZzjyWP7dVQJwhYRCjc0nU3sebUXhgZu/Vtz2HvaJusTOgoahH9LsHam78F960s1vIR9P/SYJ9CPPE3rc4So42polaJ/M1NHZQmZ2Qe23MieHgEfL+zTXx4uJbtrSL2zukRiUEX9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 23:55:32 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Thu, 20 Mar 2025
 23:55:32 +0000
Message-ID: <2cafd3e1-9265-403a-9854-7200d84ca397@nvidia.com>
Date: Fri, 21 Mar 2025 10:55:27 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Ingo Molnar <mingo@kernel.org>
Cc: Bert Karwatzki <spasswolf@web.de>, Alex Deucher <alexdeucher@gmail.com>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
 <Z9vZYIbXOz2wF59j@gmail.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <Z9vZYIbXOz2wF59j@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:a03:333::31) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e5e0f8-843d-49ab-1291-08dd680ab367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWkyNnFBZWQrSU1zL1pFL0FaTFlMaGJBbTQxc2JVM3NaQWxZdEp5OEdEMEo0?=
 =?utf-8?B?cDdMcE5zazE3YmdFdllUTTlvc0hva0VCdnFpYURXZ09mWWNoRXJVVFVoNUhM?=
 =?utf-8?B?TEFvVzlxYVNnWmZVRWc0b20vNXdhUjl1NWdQMGM4UmVUcktyM3dZYkJhZVF2?=
 =?utf-8?B?bWxkek1Pc0lDMjVOY2FZeWs0OXBwN0pSZkJLRjNMVzFOWEllQklnaTNjNCtV?=
 =?utf-8?B?ZEZHdUEyU3lrbk1CcjNCMWx0MG9qQzJ0S1l0RWk3RFpONC94SEp1NVJKY29q?=
 =?utf-8?B?UmhlNURxWDZ3a2RIL2lJaGtFa1UyaHJjUVNBOFl2TkV3UEpSdzFaQ1lqZlJK?=
 =?utf-8?B?WHFrbnJPOE1CcHBXZ2k4RlFTZkxDWnFwS2Z2MS9Cbk9YMm5SQzJaVFJvNjB4?=
 =?utf-8?B?Q1FqblduN1NaRS9EdHo0SmF1SDZXVTlQekdGYlZhRkc3ajN1eTNqWk52OHlk?=
 =?utf-8?B?OHMzUUtEait2MjJYNHhXTlh3SW1FQ2drTGh4SjJjNGVPYWJ2SVV3L3pJTm5t?=
 =?utf-8?B?QUtmUE90S3RXMHdtcDJHMWwzdyt3aVdUYTI0SC9LMEdZOWdQb21iN2V2eVo1?=
 =?utf-8?B?YktrYmpWTmxLeC9NT2ZZOU1uSE9uQ2tXL2pHcVVGaTRnTEVqQ0JLNjBRZjl5?=
 =?utf-8?B?VStpY0s4WittcVpBcUwwTDBMbmJOaTFMTlg4NEVGUytoU3JEbUI0UllqcGtN?=
 =?utf-8?B?cGM0M0RCNlgxSXlqa2JKYXlEZzZ3YVp3eWVTY2tnaXh6QlhROHU4UWFGSUdu?=
 =?utf-8?B?L3JmYlpWVXQ5ZkI1TFBMVVZIWGpzdGs4Szd6MGZjZ3ArbGNQMkU3cStqUjVu?=
 =?utf-8?B?MGNQbWxxbXArUmhTSHlqSC95eVNOdjhQOVdjdVlyd0VzU0dhd1BkSm40VG41?=
 =?utf-8?B?cVdVZWtjRVQzdllXV1lUaEQ3UGdWMWJlVlhMSXhKYkE0aEJtbVpMdXBlV1pn?=
 =?utf-8?B?NXM3alRNRFpSN2ViREJlMmh0T3BJRFU5emF5Z2k5K04wa05sUEJvOUgwcVp4?=
 =?utf-8?B?YTZJdEExSDd0bmpsZHcrUWIwd25VekRrMDVtR2xFdDZaaktYZnozUklWb0ZH?=
 =?utf-8?B?ekJYelVLc1pwK0FSSmlMeERkYmt6ek9odVFPcCtSMHNYTnJyR3dkcTV0Sm5X?=
 =?utf-8?B?WjFvN09MZzR4UDlYcTZybStOUEJLT1NkVjl6bFBrRldYb1pyMjNSOVg0N0d5?=
 =?utf-8?B?NTRMS0JqNUVPUEFiSzBLajdqdjg5MGtUYWFyZWRxcnRXanN3RjNVL2VkZFkx?=
 =?utf-8?B?SjdaYU5Rb0Q4NWdVRDhTZ010Sk1hQkIzY0tCVDZRYThNVS9BM0hyc3ZEY2U2?=
 =?utf-8?B?TTE0b0VRUXg2M2V4WkxiTmNpTzlwc2lJVlpMOTJzd3R4RG4zUk5XYVR1c0dy?=
 =?utf-8?B?bGYrQUNDUWNyYUd6QjRoUnZ3ZktWZStQeEY4QTFEREFmSUtGWVNPMU9DRFh4?=
 =?utf-8?B?RjQxSzcwc29wVFE5ZERlQ1psTGVZcUJjN0FUZ3Z5cmh4VkFjaGtCVTlxSDJL?=
 =?utf-8?B?NVdkcFluNFlFdWdyZzZhT1JreTRjcDVmbnBqWmh5ZUJlNEZjWHFCUkttSktq?=
 =?utf-8?B?NTc3ejh4RHdocGJqKzlTclB1OHlPZEpYNGFDQXVsNFhuNWFoeTNXWW41MTIw?=
 =?utf-8?B?NmNveXdwVmxzOVg3MVdoNlhzR281ajJWUklXYUlUNTBVTlNwc1h5RzgrMlM3?=
 =?utf-8?B?T0d6NWVWZDcxMUZPeGpZcEFDaStLb3AvZFF2T3ZGeEw4YVM4M2tFN2JRZ240?=
 =?utf-8?B?YThWWHJHWFJIeDRkaFZiK0hMWEhqcmtNcXZ0MHFyZUt3V2QvQ1AxUVJEWGNQ?=
 =?utf-8?B?cU1LZ2hINUxVdkVLVlczclNvZSsvSENmS1RZWnRIWVpESkxzYlpTS2hHa1Nl?=
 =?utf-8?Q?E84Dtu+OosAO3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkJtU0ZUR3U5aWQ4NmpsTnRXeTUrVDFPMndQdWZuWDdQdWwvU1lvSEp2WXN4?=
 =?utf-8?B?OW1PZDNZWmd0ZXpYOFNqdmlEamxKTnRHYjZJeTRuTEpoRkRIdU9hUlRKNURE?=
 =?utf-8?B?bFpsNHFDc1NyWUp6YXlmR09yV25zbHl0dUU2UENSYkE5QzNva1dtbXJrYnlO?=
 =?utf-8?B?Qkp6WnF0dm5ZY21sdVRnajRGMmpXNzNZbGpVMzBDRlJrRWphcXlHbWh6NkFj?=
 =?utf-8?B?Rm5iMk9DYS9EYkpqMTNWQzgrQ045TW5BMHlXMnVkSDMySEZpQkJuSXkwVUFx?=
 =?utf-8?B?RmZFSTFyQ29iQlpUU3NoVHpwb1VEK1lFNlcrVkhaQjRVeURBNG5Dakd0N1RV?=
 =?utf-8?B?aElVd0xsdlFmMHdnK2FJTUxTWC9VZE1DYm80bW1hcDZzdS9adVdGbE9rSVFh?=
 =?utf-8?B?dkNxckFtVWZOYTFiUDBLT3BzUDMxRDlNYnM0VTFseFZSQjQ0elJ5ZWt1S01Q?=
 =?utf-8?B?NkhOVlZsVXVERlIwMGZyd01yWXhVSDVzb1plYUJpMWNGVnR4bm0zTGU4NWFJ?=
 =?utf-8?B?NFIxNXdYaDh1TE1MMklScEFaWEY1R1U5N3YrMk12VTd6Z2drakwxd2xFNnRI?=
 =?utf-8?B?L3VYWGFTZTlYak1sZ1liQ0pyOFlleXhDR1dMeVV2VmFIdEVKcnAwMVhBWUdu?=
 =?utf-8?B?a2s1RUxEWDhqUjZ5ZzNTbUFCay9sQUhrOXBFQVdOMDF0d0Z4eWQ3eVJycGhX?=
 =?utf-8?B?djh5RmdhMzVkZXAyeCtEbmh3WVFRY0VHL0FLYkVKN1RVWUVtVmpMZW5MQjZz?=
 =?utf-8?B?S1ZiM2lwOGphbldTOFovMStHU054SUxCYXVzNjVGZHdZUE1zdDBJd1JMWDZT?=
 =?utf-8?B?ZTFNVmFacGd1T1ZmU3JjWHA3alJSOXV0a2JEOVRvN2lmMzFiSEswOGtocmRn?=
 =?utf-8?B?cUhMb2w0YnBROS9VQlJnOWE2azRGSXBPVkxjSHRRcUE4V1NTdUwvbjZ2REFI?=
 =?utf-8?B?MXl5YXdEcUNnaTdtWkxka0hIQUpQL2xQam5nT0JwZnhzcCtFQUFjc3o2WEk3?=
 =?utf-8?B?UFlCSkhZQ2UxYmMzZ1lsbmFtaDFJKzRheEZCRkt0cklmTzhGc0FHU1RWYVV1?=
 =?utf-8?B?SWRGcm05TGlaMlQ2dHgzTFZISXEwZ3ZZQlB0ZUVwMUF3ZXZOeHFwVEpucEZ6?=
 =?utf-8?B?clhIamlsSnAzUldCS21tTUplcnRySmZxODhtM3psMUdrOC96QUdtWUxMMjlR?=
 =?utf-8?B?ZThUUEUrbW1OOS8xTnlHeDExeDlkRVhvVklNM2JQOEhxN3dKWjdqZ0x2enpF?=
 =?utf-8?B?VFMvbUFXY1EwV29TTGJaa1ByVGQyNjJGUEpaR3R3VmtHWlZhVGNBeVN1NHJL?=
 =?utf-8?B?d0F3SXkxaWVPRGZQSVFURE1aUitIWFZ0K1NkakZvc24xTnV6bTJqZ3NBK2Jl?=
 =?utf-8?B?eVBjbU0zeXpKcXNUQ0UvQ25jQ21vVklveXdTa1pKYzdvS2dEL2hucGxXZVdU?=
 =?utf-8?B?bjJWVGg5Y2djaUNkVTl2NEJhL1k4cEo4UDBQc2R3bGNTeGNHWWhoTHg2TDF0?=
 =?utf-8?B?emg1dWJhc3duOVZQYnRxWHFGVVVBZzg4c1orM0pEcDJvQzRaMk40TGxiYVVy?=
 =?utf-8?B?Y2RGa2dvd1VmUDdEY0pndVl6TWJDNEkwR2NSTHdMYksvNStqbHRZeWhnNzI1?=
 =?utf-8?B?OTNKRUZtc005Qi9mR1kwQk4vTHJqT05HYVFrTTM3S1oxd2NmZTV6TXJkb0Mx?=
 =?utf-8?B?bldlRk1pQjc0WDlrNUJDZ3FwRVhLZkhEeHNnOEgzNDBkb0ZYN3o5c3hxMjlK?=
 =?utf-8?B?RmowMmRKWlhzdERWbHBER3duc0RMWnAvdzIvZzl1RHh0aTdib2RYUTN4blE2?=
 =?utf-8?B?VzJLSDZTSnBOVXJuUGdsNjdHU0pjeU9DYSthYk5OZ3pHVDY3MVJHd2NRWXVZ?=
 =?utf-8?B?eVo0Z0FiUXJ4UmVGN1hlc3pFMGNjZTBqdUlKbXl3alI2eW51dnRLbTE4WUdO?=
 =?utf-8?B?eG4wRnhIUExraXBNekNxM2JLMW1YeHR4eUVOMzNKeUFGQ1E2cUZpczN0Y3Bs?=
 =?utf-8?B?U1hLakhmVCtVd3o0RVpxbHorTEZzdzIvZlNiNVBKbmZsWVkyUS9OcmhMUnIw?=
 =?utf-8?B?U0V4c2JOR1hWcm9mczJXdFhmdjE5UzJjd3F6alBncEZvZGFYSkFjUDF5NEls?=
 =?utf-8?Q?U6IsiplugeYzpmIh5vv8/JSjM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e5e0f8-843d-49ab-1291-08dd680ab367
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 23:55:32.6554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOYz72gkaflq/+CWH/dgq7+w11Rj9zfbJcGacpHnaZj38K1uYfIaqnoIlyj3+HX/Zv5mrzWwCrmsRfrslWyZUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171

On 3/20/25 20:01, Ingo Molnar wrote:
> 
> * Balbir Singh <balbirs@nvidia.com> wrote:
> 
>> On 3/17/25 00:09, Bert Karwatzki wrote:
>>> This is related to the admgpu.gttsize. My laptop has the maximum amount 
>>> of memory (64G) and usually gttsize is half of main memory size. I just 
>>> tested with cmdline="nokaslr amdgpi.gttsize=2048" and the problem does 
>>> not occur. So I did some more testing with varying gttsize and got this
>>> for the built-in GPU
>>>
>>> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
>>> Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
>>>
>>> (nokaslr is always enabeld)
>>> gttssize   input behaviour
>>>  2048		GOOD
>>>  2064		GOOD
>>>  2080		SEMIBAD (i.e. noticeable input lag but not as bad as below)
>>>  3072		BAD
>>>  4096		BAD
>>>  8192		BAD
>>> 16384		BAD
>>>
>>> As the build-in GPU has ~512 VRAM there seems to be problems when gttsize >
>>> 4*VRAM so I tested for the discrete GPU with 8G of VRAM
>>> gttsize   input behaviour
>>> 49152		GOOD
>>> 64000		GOOD
>>>
>>> So for the discrete GPU increasing gttsize does no reproduce the bug.
>>>
>>
>> Very interesting, I am not a GTT expert, but with these experiments do you
>> find anything interesting in
>>
>> /sys/kernel/debug/x86/pat_memtype_list?
>>
>> It's weird that you don't see any issues in Xorg (Xfce), just the games.
>> May be we should get help from the amd-gfx experts to further diagnose/debug
>> the interaction of nokaslr with the game.
> 
> So basically your commit:
> 
>   7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
> 
> inflicts part of the effects of a 'nokaslr' boot command line option, 
> and triggers the regression due to that?
> 
> Or is there some other cause?
> 

You are right in your assessment of the root cause. Just to reiterate
- nokaslr does not work with the iGPU, specifically for the games mentioned
- There is a workaround for the problem, which involves reducing the amdgpu.gttsize
- The patch exposes the system to nokaslr situation (effect) when PCI_P2PDMA is enabled

Balbir Singh

