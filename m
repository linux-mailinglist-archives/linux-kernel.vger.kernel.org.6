Return-Path: <linux-kernel+bounces-299718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F495D91E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBC81C223E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213FA1C86F6;
	Fri, 23 Aug 2024 22:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lFyByH30"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87030195;
	Fri, 23 Aug 2024 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451255; cv=fail; b=ktSQUh6Bc8UKDGVxakRr62oG9JaG09sJCrkUf5qlCf90ZKkif36UkuX6q3O0Wp3IVPnFjrrR69+JHpW4BiuMhtbqKR8Ujm0et2btqq9jndRoe7gxdFUdXzWRn6SgGs742F50XT/uS1X4LZ92i6K1/yUGibVC3UFzJqGYKtuoUyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451255; c=relaxed/simple;
	bh=KatU2866C9NDafI6z31zL85E6CFw07ZbKmMHGIvWQuA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jb6Ir3NiSoSQyieyGaVgBse7Xm0YlEeTrROAEH29Ypopuwo4bjjSWcci/K+4nYi6QaEUqJwY8Gn6QxYjQIq26JnPAcXYqMJ6Unfw2uZ1dk3j886K9M1fzlHwIgu8q5gyRHrfgWqRN6iKAzRvVEuOEL0063bIVK6GzG/1fu1z7HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lFyByH30; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0zBNaXnKPNyzXftLxIEJ7JsnZJYAUv8JB5Yaqw94jE0pFycMdghbiADXWV20dWT8fwg1DL70V3BjjLWS5N7KTZquEYAQARPBOND5YInE3nvGtgrxNFW+acPEfkpNMG31FwdCSyUDLe3AylpPjTP3svYldQrh2aatBtz+kTEV7jkX5o2+r5cT1ZayB8YaB/FDBqEFtJ3lI284WjWM9n/HLvUOPwUMKqWhcWjhGbRu4TzDcwwNpnxWOxSFnxV+VYDVIui0KjKQBOEwDl/8oCEhO4ZxJE4apKOyIUbQBZXndNZS2SyY859/VYUl2WtU+Rrufug0PL76Z5z6pAFMNucwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUO+x0n8ThF7QYm29t02mK+rCrGQXcpJdhrs15h3hdA=;
 b=vbwW6ZGr+5rbIFjggdDewCOCtraO5EJencnd8OaCxq8GnE17mC96Ec18dZUesZ/Y1CAUZi7OEtbdMDJAjdAkykCoPtslqABMuf2iirCWClx3toN4aahElOUxUX9VIS9rF619YJl4M3UWAPpW8YPQCXElm8TMrqXXo9WybenuruhDJpLj+WjzVePcL+8ToEv/oRbM1+YYbT83qFMDVOloJ0Ynxzqsf945FYX7lYf64oqXOQL6ntRHuM6V7dFv1AWf8Pr1yRokZQwKZNJ/tc3mF9cEj+MHe9orMbVuQXM9lkXQDmFdE+CrbRNonam9AfJ3E8bCCdIeUGfG820zO98r+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUO+x0n8ThF7QYm29t02mK+rCrGQXcpJdhrs15h3hdA=;
 b=lFyByH30umXpSleNqnrXJdn2IAtIx7VzgwjppG1uHsa/tgbUauJb6hgC5FqdpF0KIlXEjtthjafFZhxSuAAiiRgojQ4KLx5JF1HpBIDW18XoMG9nIMhK6asvIq8na3qSshKP7D5QzNJSoqRmxmb3T7AhGP7ygcPFdbwbATVJ/7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Fri, 23 Aug 2024 22:14:11 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 22:14:11 +0000
Message-ID: <2e83227f-be2b-7833-0ae5-85be3dd7bdfb@amd.com>
Date: Fri, 23 Aug 2024 17:14:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 00/22] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <d093c0bc-dfd2-422a-9d23-2bde68dc6f73@intel.com>
 <3223bd31-2112-0c5e-08d4-7e4942d031ec@amd.com>
 <0dcb775e-7214-48bd-81eb-22b14d5605d1@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <0dcb775e-7214-48bd-81eb-22b14d5605d1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:610:4e::38) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f07fe48-d2f6-42a2-a8b2-08dcc3c0ea1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0k4ckJ1Y0pzdElkUStxblNZdUdKS2pOYW1QQXR0cTI2T1A3Z0ZpMjFXZUM5?=
 =?utf-8?B?ODZJbDFMSGFIU2Uxbzc2L1drRW54Zko5bzcwenA0ZGJ1R3E3S3daUCtKVHhX?=
 =?utf-8?B?QnBpdjhaMTJjZDJQT0dMaWt5RWdQYmZiTUNiRFh6NTlyMVZ3K0FJYURjUEll?=
 =?utf-8?B?UW1KeDQxcCtyeGdzUmNqa05MUmhjNnVvMjd1eEppbWVHcWxGWDR6bmVKSjQr?=
 =?utf-8?B?Qk5INHZwdklPVDFTbFlaYm5oVzJYN244TDlnZXpya3VYaXJ1OXpweWpOZURQ?=
 =?utf-8?B?dmxDWWhGQ1cyRnRxZ0NBUjBvbmlQVTRJL3lUekJuSXluWW9sbDBwemwxMnJJ?=
 =?utf-8?B?Y3F1MkVhRUpWODBXZmFzMkx2Q3pZaFhCS1RYMzhCblNtZlA2UXUzYTdGek9y?=
 =?utf-8?B?Y0xSeEM4NzBEZEJoVkM3enE1UWkxMVd6RWRFNjBqYXUvZDFVdlFmVWJvV1Fi?=
 =?utf-8?B?ek5zY2lhK1U3cTZZZjF6V3NtSGdzYnhsT3lDUVpPRXQxd1Z1YmxqZWxhZmZI?=
 =?utf-8?B?Wjd1ZFRUWm9UWk85UzVkYVorai9qNnJQRy9DU1dRMGJmcFRsL0Q1UDREZE1j?=
 =?utf-8?B?UURnUWJsaDRyc0lYYVExVHVuZkVTc1B5M3lPd3o5QXlzWmZpU0Y0S2p1ejhr?=
 =?utf-8?B?clJlejJjR21GQU02UUx6MWFKbEdJV2dvRzZkZGtjV2Q1bStUVHVITkorN2h3?=
 =?utf-8?B?ZjlpaEUvbFJLWGJKcmdpb0UwR2FkbGxqdXFzY0FIcUZITUxtdHdoQWFNU3cx?=
 =?utf-8?B?RDViRWxEQ2pMaW9la3FYQ1RLazFsdFJLUEZ2ZmU5blhJTlhNNTgxbURyREFG?=
 =?utf-8?B?VzhLZk1sVjJRRWx2Z0xoM09kNXBKVWY4WHlyaXlML3VOczUrV2tWbFVxRWtL?=
 =?utf-8?B?bVV3aTlTK2huYThtSnpLM2FXR2pjczFQZzRhWnJnUnlVek9CaUdXMUxYMEpZ?=
 =?utf-8?B?UTFXSkMxbHFlSzMxOG5sUEJhQXpYbU9MSFk5Z0xZdVFSVFlwOVlVWGRwenl6?=
 =?utf-8?B?eGc3Sm9ZYmJYdFkvODZOQ1lIdWFnUmJWTzYyR0ltc0pJTXkyaUVTRmR0VDdB?=
 =?utf-8?B?QmJqWHMva2JKQ1pZYWtrMGwzbVhIUEMvSTJxd2Ntd3E3eFB1OUwxaWI2MmFr?=
 =?utf-8?B?MnV2eG5oRVZadnlUYzEyQjFGeFJKa0tDOCtjbGZiUk5aLzNaa0FBanMrVTY5?=
 =?utf-8?B?Q01oL29RT20xRkZOTU4rc1FsUmF2WENuMDEzRmZSY01IRmt4SW9zWlBEVCt1?=
 =?utf-8?B?eUVRZXVIOFlrQk1RYUthakdwd2xNMlJuZzBNaUIvR2dCc3k0MWdHUENnN3Zn?=
 =?utf-8?B?dldwRTZIcGIvR3hBQy9EdmhHeGJNbVdjY05VMXJzbXF1bGtheitZYVdQRnB6?=
 =?utf-8?B?ajYwZG5sSHVERjVWMjNick9NdVloa2s2SVRKWkhuQ3BjSnM1aDhuL2JiUUV6?=
 =?utf-8?B?NTVBT1UxMUNuSEkwN2RvckROVXFjbExaZ2NpbVoyWlp2M0UwZ2g2blRYT0xO?=
 =?utf-8?B?b1c1dW1saDcwaWFQMjc3bmFLcGVIZUU4cG42SVdmQ3hLN1ZLWTRwYXZWWUVz?=
 =?utf-8?B?MGZ5QXpEK2ErOWRhTm5QZUpoYXZSZHA1M3lGTnZOZVVnUXphVGVGNzZuNWFS?=
 =?utf-8?B?elpTWU9rTUZUeXVPVzNpM3grY0x1cHZNU2tEMlczdkVhWkd6cFNYeHpxQUVh?=
 =?utf-8?B?cDZ4c0tnRHZBTmxHVnNEb3dKeGV1Qm82Yk1MVkpoQzFzUWhPSVdCVUNKRTN2?=
 =?utf-8?B?c1ZTV2Z5ZGhqVHhadjhLU3lYaWhTY3ZoRks1cENEbDI5SCtWWklmOVNISXZ5?=
 =?utf-8?B?eU5OYi9BRUprVEFNSVlDdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnBwcGQ2N3VHcEx3akR0dGR1K3piVktVSzRBMjZPNnJHNUYvbE0rNnJYV2Ri?=
 =?utf-8?B?SW1TMDVaRGhhOXBxWno5T05Da0ppejR0eXRTTnpWcFl2SGk3MEVtUTEwTjdl?=
 =?utf-8?B?aHV6dEg3TnlLdkN6cXFTS2ZQOGZhTnpaYUNSeWpZNnBHRkgzTjVmUE45WVI1?=
 =?utf-8?B?ZmxsZ3pkWUEwVjBUcnRNOTkzZzhVUjhKejh2YjNycUNDLzRMQW55MEZ4Q1J5?=
 =?utf-8?B?OHBiUDMrWTgyZWkzb2R2azFXaitEV2lYVytvNkE1ZE5ac1M1SlRGT1Nhc0NR?=
 =?utf-8?B?dmFEV2dXbWhxY3puTm5hV3VIV3grNEZ5cVVsNDJ6SFpQUDUvWGhKa2dSbCtP?=
 =?utf-8?B?U1llTWRLK1BxdkttNmJXR2F4WnFmS2Y2clRpeXI5cElDdXZCeHB3NGtuTG5J?=
 =?utf-8?B?ekdUZFBVa2dnb2lIdUh4YXdPYkFuRnZ0VUJ1Um1yRmVGMVdSSVdGRmkrQ0N0?=
 =?utf-8?B?QWpDZ1dGL1dsK1JIS3JkWTlVU3QyTDZxVkpnMzV0SWs4bzV5cEZZYVlwYmYw?=
 =?utf-8?B?dHRTeHljYVhYRGNjTUY3TS9qblBTTUgxKzM5ajFqOVdOYWZpRFdBR2xtTDRS?=
 =?utf-8?B?QmxBb0lXQjFvTVRyL043ZGFlZFhUVDR3Z2ZoOFhVc0pwdUpNWDlMUy9tYTRU?=
 =?utf-8?B?bkdrcXRiV3ZTOUh1NXZZTnZxL29tRnQzWjFpejlJUFZoUE5jL0JFQW9paEtN?=
 =?utf-8?B?NkRickZseGdySkNOOFVvL0J4MERrQ2tGUUtHVzFFcjlXOWJIK2JyMXZpTUJP?=
 =?utf-8?B?Znk5eU03OTZwclpXdkhRd0JlS0dsYUsyM3I2bUp1UEd0KzVPalZEZGlFU1lJ?=
 =?utf-8?B?TXc3c0E5S245RlZrOStMb0lUQnpWVFJ2L2xYTnhYa1NvM2tJckw1RFZ3ZU9L?=
 =?utf-8?B?YjBZZjAzYlQwM2ZkV0M4WmtNd3lCQUppdkJYUnZSNXNvM3lVdTkyTmpHenJ0?=
 =?utf-8?B?cFVLOE5jRWVadk1uQ2ozTlJqMzE4MnpqTy9XbHN6Zlh5cGU5SnVEVUdqSEtv?=
 =?utf-8?B?WHNKWUNpN09kK1ZyS294WlI4UUJDTUoyeUluNGdpc0xHVVFuZVo0ZVRZaTFl?=
 =?utf-8?B?SzNIQmpHNks3Tm9tSEpNSWVvK0JUR3hXR2hEVDZXVzNmWHkxZnVjVW5oTkYv?=
 =?utf-8?B?TTh1cGh5dHE4VjJEYzNZMU9lSVdabC9QbG5uMTFyaWY2clQ0VVNVNGhFNjly?=
 =?utf-8?B?T2FaR3oxaGhhMDgyR1prblJXVzAxa0xqdmg1UDZPTmdNN2FQRjFRKzIxLzA5?=
 =?utf-8?B?VmxLVm9wRDl6QlRTbzl4bW1Cd0UwN1JMN09YS0xEZ2hranN4czFCaXJ5Qjdi?=
 =?utf-8?B?elNMMU1ZdXRXeFRwZXAvd01aN08zYTZrd3AxQTEya3VSUTJWZkdmcE1QS0Jo?=
 =?utf-8?B?dlNyNVMzZ09FNVN1US80em53NEJ0alppSzlSb3QxT2JHVUtLZzRIZjVEczRQ?=
 =?utf-8?B?dmwwMnNCSWlwQXNJQk44U0JZMWw2RmdRT3RxWWV5N0hPNW9BS1VJaWFMdS93?=
 =?utf-8?B?YmpHTXlITlhuaTFReWVlM1dmZnZ6eTczTFYyNTN5L0tJdHZOUDViR2hybEtK?=
 =?utf-8?B?K0dzTGtNa1NPUjVnTTdGdDA4QnArWHAyb01hRksxYVdZWWRDSjlVQjVYRWIr?=
 =?utf-8?B?VGlkNkpOUHFvLzl6L04zNW9yTmIvWTRSbVpYYXBxRCs5bndmTlBFSGx2aFlh?=
 =?utf-8?B?RjFwbnZVVGtZais1VHlDd01CY2lHSXhVOHhHZjMxQjNSVFlKSW9HUTJ1dFNy?=
 =?utf-8?B?d0hUeEJta210NXBnRjBtNS95elV3cXhSU3ozcHNXSW1KVzhBVmJqTk12Yng2?=
 =?utf-8?B?U0hZOFJMNjNoZjBWQ25jcE40a2xkYmt4RG1PT1g3NUwxTTZ5UElpNmdmMExP?=
 =?utf-8?B?QjdVU3p6OWQ4Y2kxK3pGbThBcE1CZ0hSTTY3TTVMc1h0bGQzSDQwbGttb1pY?=
 =?utf-8?B?N3JXRmxmc2NxOXlyT254VDRWeUxNcUs5eWhLRFEzYi9Tbk9IOHUrWmdRbDJt?=
 =?utf-8?B?WFV5NjJYSGY2d1NrL2JoSWIvaWZ0REVKZzZSdUdKYzFsdHlpbzV3OURVbEFJ?=
 =?utf-8?B?U3J3WDUrVkZPUjJpVG9kYkcxRGx0K0V5dkwwQVU1dkgzR3NLQlpNZHRwc2lF?=
 =?utf-8?Q?Z4D6p02do1fSuTHrTwpT8ovd9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f07fe48-d2f6-42a2-a8b2-08dcc3c0ea1b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 22:14:10.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PJahqV34rzWEiiDJeZrigLm4aOltVmTF7k5SDBLlc8+XutUO8Q2GbW+sGDI1UVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559

Hi Reinette,

On 8/23/2024 3:29 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/21/24 6:31 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 8/16/24 16:28, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 8/6/24 3:00 PM, Babu Moger wrote:
>>>>
>>>> Feature adds following interface files:
>>>>
>>>> /sys/fs/resctrl/info/L3_MON/mbm_mode: Reports the list of assignable
>>>> monitoring features supported. The enclosed brackets indicate which
>>>> feature is enabled.
>>>
>>> I've been considering this file as a generic file where all future "MBM
>>> modes"
>>> can be captured, while this series treats it as specific to "assignable
>>> monitoring
>>> features" (btw, should this be "assignable monitoring modes" to match 
>>> the
>>> name?).
>>> Looking closer at this implementation it does make things easier that
>>> "mbm_mode" is
>>> specific to "assignable monitoring features" but when doing so I 
>>> think it
>>> should have
>>> a less generic name to avoid the obstacles we have with the existing
>>> "mon_features".
>>> Apologies that this goes back to be close to what you had earlier ... 
>>> maybe
>>> "mbm_assign_mode"?
>>
>> Lets see:
>> #cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>> [mbm_cntr_assign]  <- This already says 'assign'. Isn't that enough?
> 
> It will be enough if "mbm_mode" is intended to be used for all current
> and future MBM modes/features but this series instead dedicates this file
> to just "assignable monitoring counters" feature. Doing so prevents us
> from, in the future, expanding this file to, for example, contain
> a new entry representing a new feature.
> 
>>
>> default            <-  Default mode is not related assignable features.
> 
> If not assignable features, what is it related to? "default" being the
> absence of assignable features still seems related to me.
> 
>>
>> I would think mbm_mode is fine. Let me know.
> 
> If this work is reworded that it is intended to support any MBM mode then
> it is fine, if this work remains to dedicate this file just to assignable
> features then I think its name should be changed.

Ok. Will change it to "mbm_assign_mode".

> 
> ...
> 
>>>>
>>>>     Flags can be one of the following:
>>>>
>>>>          t  MBM total event.
>>>>          l  MBM local event.
>>>>          tl Both total and local MBM events.
>>>>          _  None of the MBM events. Only works with '=' opcode.
>>>
>>> Please take care with the implementation that seems to support a 
>>> variety of
>>> combinations. If I understand correctly the implementation support flags
>>> like,
>>> for example, "tttt", "llll", "ltlt" ... those may not be an issue but 
>>> of most
>>> concern is, for example, a pattern like "_lt" that (unexpectedly) 
>>> appears to
>>> result in set of total and local.
>>
>> Yes. Should we not allow flag combinations with "_"?
>> I am not very sure about how to go about this.
>>
> 
> This topic seems to have moved to patch #22.

Yes. got it.
> 
> ...
> 
>>>>     # echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
>>>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>>>     mbm_cntr_assign
>>>>     [legacy]
>>>>
>>>> k. Unmount the resctrl
>>>>     #umount /sys/fs/resctrl/
>>>> ---
>>>> v6:
>>>>    We still need to finalize few interface details on mbm_mode and
>>>> mbm_control
>>>>    in case of ABMC and Soft-ABMC. We can continue the discussion with
>>>> this series.
>>>
>>> Could you please list the details that need to be finalized?
>>
>> 1. mbm_mode display
>>     # cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>>       mbm_cntr_assign
>>       [legacy]
>>
>>      "mbm_cntr_assign"
>>       Are we sticking with ""mbm_cntr_assign" for ABMC?
>>       What should we name for soft-ABMC?
>>
>> 2. Also we had some concerns about Individual event assignment(ABMC)
>>     and group assignment(soft-ABMC)?
>>     Are the flags "t" and 'l' good for both these modes?
> 
> If I remember correctly the previous discussion ended with the need for
> "modes" that indicate to user space what to expect when interacting with 
> the
> MBM flags in the "mbm_control" file. The term used by ABMC should 
> reflect that
> each MBM flag/event can be set independently, while the term used by 
> soft-ABMC
> reflects that setting one flag/event makes the same change to the other
> MBM flag/event.
> 

Will add text in the resctrl.rst make it clear about it.
thanks

-- 
- Babu Moger

