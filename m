Return-Path: <linux-kernel+bounces-170387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A18048BD621
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AA2B22745
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9F315B10A;
	Mon,  6 May 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X2s5bSWN"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6856B76;
	Mon,  6 May 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026996; cv=fail; b=aIHf7MnGQ7WT1CMfvo6Uoc84ArhqsLKlJNyno7O3QEfiZs9AS00UMvAJo1NkNd+4wHQvoaAx+vxLnoR0qKsTp4hla5JMRFaKXJ9sZ5SGzSkc6N4W7J663FkZ3zLfzR+m/43eDDu+NGfNTmByPSZDCo6OM9h/REurHS3LVSXiaBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026996; c=relaxed/simple;
	bh=1YDEZc2TUDRZXVmAsT1OtRU1LNhhBUJt2wl8GXOz/kA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iB9natMTB01fkkdGn6gd1YGjNZDSbgxS6daipgsZ2igPcr6zhz3SnsmG9w9R3N7IDwcS/2k7Wz2SaOVdzTRqtl33kyNQ2Yc72IqdW1S1SioXfwL1GRJFw/f4PwIjQsuO3Y/Cz2FCtqp7Zc9ClaYzDtydGBRZDGxyVLIAs2g7TcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X2s5bSWN; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvyMmUSSTSYzbvPmTd3O1u+d2Kck8CD4ci1P34Iwz3KaUAqEN2rdn0UZ3liLGQkG3cgL/w7pRlmk0GWKTY9iya/HRaGcV8CKoBNAiv8EubR8/Bjnsrm4EC4cXlcDRQ7KHM/zSmfDRumeGRPjiumRfQHxMU3nG912LnqFX0MeS+7hI1vy51VwOe7maxcQTBY3cEjNb6uggr3nIKxsgyzTsk3Lse7H0rarevnZpPv7R6KwWQ/vW3LA21ZIUr7MlLhfzyGBMkIZZaZLYb6Am84uFQzqsswXilaCvVflgUGhCVR1K0zPgAFr+lc/YeeVnDGE1bz9cBQ7k//483UXkk0QsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewWPuJ3OalEYmc3M0b+cdfvoGYFXTMEjuWB9UNThLAs=;
 b=F3BFAAnGBPkaBOJsZrdq+QRTTDMQZ2vbirqxSzoUaGO9hpfwFMKtz89WbHBcGkLJULFM1sSEZ6iGt+tLAcLC1wrrMrB0jyLSvWtuh8sQdT19zV53EGZb2LkPCl1n6ks9kB5Z4WwU4vMuHKpIq7LitqNAvmPmJFg9Qj0kI6uY1oZjoEWDYUVyAExGPc6OscTqUybQc3JaBG0XfBY8cRd4r9GToR+tdf1hs6HOZHOo+Upz8E/sw95yWojezJlWShTvqBSm8+12ElrIqemmyaGntn8jHPX6kRTCFpsTnazsWsHIk5pi5BLTLPmnYa9/sN52vRdXy4HDFEYY4drm8XAdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewWPuJ3OalEYmc3M0b+cdfvoGYFXTMEjuWB9UNThLAs=;
 b=X2s5bSWNSpHqe8zOGK2XKJzTpYkLPiUc5yCaEsa6XZLPBznriuEz5PrHhnLfSbGjFa9hH/2xkborDdBwYOtSLuZ17O9eYQVCSQDpeIR2oeJz/00J9uoTVHqddEJ92cElA9CjO0y2sWzS65lOlm1UDgBVnKhK3MTFtc1iB/vVhMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 20:23:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 20:23:07 +0000
Message-ID: <119fbe0f-9688-4382-9263-220f69caa718@amd.com>
Date: Mon, 6 May 2024 15:23:02 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 04/17] x86/resctrl: Introduce
 resctrl_file_fflags_init
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <363c14eeeac99eb0453ac3429f9e7bd446b2acdb.1711674410.git.babu.moger@amd.com>
 <55fa3189-b5da-494f-8ec2-7f0ab4b8d33e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <55fa3189-b5da-494f-8ec2-7f0ab4b8d33e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:5:bc::40) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 9461f2fa-719f-4072-0421-08dc6e0a56ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnBGSGZFK1ZvTEh6WlE1aVEvMWpCK2t3WmJIWWViek9qMm1ZOUo0UktqNFha?=
 =?utf-8?B?cm0rS2hKZXY4VU1vV2tsekQyVXJIKytiZ1AzT2pMU0JsWEl0UFVqcG5VbXZW?=
 =?utf-8?B?aDU1MHl2bU84YVRORXhKb1VOalArWUJWZVIwN25TcWJkWi9kL0VlQmg2eGVT?=
 =?utf-8?B?U3Y1aXU2bFJ3Y1VBZFRRc0piQUVpOGpYRXhOcDlrVjd6d0JSV0NQVnJKM1lV?=
 =?utf-8?B?bDg3OHB2VElaUXgrc2hmaDJkaEErVU8rSzlEUEdqZEJqVWVPVDB2RWk0enZI?=
 =?utf-8?B?aDA2UnVTR0J1RFZXVWNsQW54RlZRWWdlZGhiRmJBNm42RlV4QnRnUWZ5OW91?=
 =?utf-8?B?ME8rYmxuWTNyQ3B3dXU0aHBBSFJNanVqMkl3T3kvZkFJUjEyMFptdWt0WUk4?=
 =?utf-8?B?aGRsTk5LYWtEZzFaOHdzQXYvdkJ3eE9MVis4OURZS0tsL3B1LzlRa2NJNXBs?=
 =?utf-8?B?UG5VSFFkL0ZXSkdoM2lDS09BWkY4ODdCS0J0VGdsZmZmSUpwbC9oSU4zYnNS?=
 =?utf-8?B?UjJhZHY4MWNBVmVkTjR2TG5aQnJERnRpR1JjdHR4YjUzbFNsMnFDWDFKRGoz?=
 =?utf-8?B?d0tWdXJGRllGTWdlanY4T0ZjUWRwalN1eVAzMzg1Wm9oaENRY3FlNnBHZVNV?=
 =?utf-8?B?MDBjd0x5VEl3NHVJakVqUG1GdlY2ckNlTUpUV0FvM3l6RjNrSy9DQysrdWt3?=
 =?utf-8?B?L3JsNXI0TURHdDdvRXZNK1RzRlltRDVaMWtXUCtyeVdjQlJ2YnFJRHhSQUJU?=
 =?utf-8?B?cHB1b04ra2tNdk1ZZDNTd1pPMjJwaVZSWmJFK0M3NmVzRTlGcXh5OUVHTjIw?=
 =?utf-8?B?RExtUHlSVGVFRzVDcjhBaVdMMlF2R0RZMmdkQXB3OFNKcmlYUXVDV3VaSkhN?=
 =?utf-8?B?VWN5N1Q0bHVybGhaZXZCNFZxRExlY0IwWHlvSXFTTTZxYzBFRTZONmR4R2xy?=
 =?utf-8?B?QjF6Z2Q2azdxV21IeVRMUXBIcXMxeFlNbkRsSUlGdURBaDgrc1NmM01wSnF1?=
 =?utf-8?B?SzdPcUpOUmV1OUVVZzR3RjBNcmdxNVNub1lhbFk4ZTJTcmNaQWd1K0Vjcmtj?=
 =?utf-8?B?YlZsY0VxZlhjSklHeWs3bVk3ekVrNHN1b25FZkpuUElwckpyRllhVDVwRVZY?=
 =?utf-8?B?NE1lSk9KaEtQZE8zdUNMekwxZ2tsblViQThVa2JSaTBFM2prN1hIYjRVaWNr?=
 =?utf-8?B?ZE9iOEFoTjl6V2svOGdUanc3WE1vcTJxRFhMWFZ2ZFd3MDQxTkEzdUh1QjFZ?=
 =?utf-8?B?NmJlNFVIU0gxbmpWMERoY2lKbEdKUXlFR21pZDNtbGtqMVFtU0U0TmxieXFt?=
 =?utf-8?B?N0ZON3pnZFBYa3NtRllqZGZZdTlNUEFSV2NwMHd5V3NJVFdwOHUrZ0htRE0z?=
 =?utf-8?B?czFIY0VpUWZKVmRjU3AwSE14ZVN3V0E3RDk2c3dwME9wcXNWOUovT0tPdUdv?=
 =?utf-8?B?anNSNFRRbTIyK0xLZ1dVWXk3dmI1M0tyWkxMVTRwMC90YXl6MUNRZ2pIeCt1?=
 =?utf-8?B?eUNrc3RFR1FVZzFZRzJ4b1lDa2trU3gxZG5OTW9HOGNyamQvSThzSXdGNVhG?=
 =?utf-8?B?Y0k3bndPanJSeTBjaGhXZEhzMDlLUzcwVWJXTDNHMFcxVjQ4VEdEbGtIR2Rj?=
 =?utf-8?B?UTI4eWE5blBkbTgzdGlxQ1EwT2gzN1dOK2hEQWdkT01EVU9yamRUQmc0b1Z1?=
 =?utf-8?B?ZTNIajJnNzk1TWk4VklBdzNPQU5SV1lzTGZMamJheXRFUi9ZVEJtMnV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z09aSU0xZFh1L3N5dXBsS3NSRkJia0YwZGg4NFJ6ejhXQkZkd2NnemoxN0Ez?=
 =?utf-8?B?Mk41MWlXMHMrMHByNXlLQlVPUjBXaFFPY1VVeFUrSytWMlcwTHd1VCtNOTBo?=
 =?utf-8?B?N21NYkJ0NUFoUnFBdWZSaWI3WnB3clN5UVJoRzV1bFlEMFhUb0RWNjdyZmVj?=
 =?utf-8?B?ekU4a2ZXYjI2d2JuZ25OMlJZR2xGbERvUGtJQUV3YlQ0U0k4dG0yVjU0QW9k?=
 =?utf-8?B?eWZpUU5xV21rblR6bHVPdUQycFJIU2tWcC9YVmViS2VDQllweVc1ZTZhUXda?=
 =?utf-8?B?bVdYSzF6NWMrQW5xMXQzUDlndDZNd2ttQ3EydUowMmMzR056VzI4VGU2cTE4?=
 =?utf-8?B?ZHNIdlczZFg0bTduTWNzYlZJRVNDKzN4U1FVdnpFbW92cGdNVkZKVzlxSTBD?=
 =?utf-8?B?bXlja01vcGRxZUJCVWR6dHpRMEMxeXRXaGs3ZlB3aGRGYTVyVjVRT093Z2d6?=
 =?utf-8?B?SWdGcVdvL1kxUmtvbmxtWWZwSnE4cWxEQlM5MWJ1RGFZdStVWmxHZGVUeTYz?=
 =?utf-8?B?NE9GTzdUb2N2TkRMU0ovbnRFdmtlZ3NVSTJ3VVlOT1ZLYytzVWpyeHBEeXBS?=
 =?utf-8?B?RUpQb2RZSUZJMVl1TDFVSHU1M2EvdkxtNTluNWMveldtdkxWcUFjUFJFWDU4?=
 =?utf-8?B?TnhjTUlocVF6OVBDaSszM0tYa1FRUVR5b0syRWtZK0pQRVdGMzhqYXQxYll3?=
 =?utf-8?B?Z004bm1qSkZ0RFlpdHpaS3JZNDZYdjlGelc4RG1Cekp3RE1GRWNwanZsTk1a?=
 =?utf-8?B?bWFYODU3YmpsMmI4UGJsVDlILzJMRTYyTjg0RzB1ZnY2Y1AxdmlVdVhWSXpY?=
 =?utf-8?B?S3FuNzRodFNkZGxmRWU0NGViVHB5MVZ0dTNjU1NmR1c0elBtTEQwOWpwMXpX?=
 =?utf-8?B?VzI2aFNycGR0eTRHNTUxckFqQkhVNWkzb3l2VG52M2lDUHhaOC9RRVV1R1hL?=
 =?utf-8?B?azVWblh5S3hqbXNDaXdQNnphelczVmplMFRSY2FCWHdBT292bnp5MlpJUTlQ?=
 =?utf-8?B?eWowUGFUSUpxOTYvZ2I2aVNGZ3RwQkw4ejNZMlFtdngxUlg4VEhOUVBtRS9U?=
 =?utf-8?B?N2ZLRzZFYUVzQ2owbm9xQVFwbkQ3Qzg5UjAzVFZLQjZoU3RYK1RZR3lCajdv?=
 =?utf-8?B?clVDYWgxWncxR3VNVkgweXhodUdJMy9NL21xcUg3aVE2akJ2Wml2TjFHaFpL?=
 =?utf-8?B?alZkNitsdEZJeHNvTEFYRnh6OWpQMXloTDhwektYa1V6cCsrVkQrS3RDcVJY?=
 =?utf-8?B?bnJSVmtqc1F6UHJZUDVRcFRjVUJOSjNuaHpSV251VjdDYmtTd082UTVvZHZp?=
 =?utf-8?B?ZGZ0SloxUlduRVJybTJqaE1ucmEyUlNLbEJZcTJoYzZOcThXZlZ5S01KclV0?=
 =?utf-8?B?T3ZlYWI5M2xuM3ZPT1VGaTYvV2E4VzMxcmtyYXVNV05UT2V4ZWM1eGg2L1hP?=
 =?utf-8?B?RGNKMldkc29kUVRjWXhyVUtKdGV6cEtaQ1dxOWtxNnpzWnNZZHYvMk5NKzRh?=
 =?utf-8?B?NXRwQk4xK2NtY2grTWFVQitsdkFTOTVPLzVDaDVvazZkR3hVS3VRbm5leGZB?=
 =?utf-8?B?SXJQTlFxaTJlYW55ZU1FOTVmVlR3WFQxT0RIZC9NU0RWZ05FOTBUb3Y3RGVm?=
 =?utf-8?B?cUdISW05V0luYWtWVnZndEtsYmZNMmJpc0t5V0I4MFRZN2c5U29nZ0RDbkUr?=
 =?utf-8?B?OWJNM2YrNkJJSThFVkNHVUhyek9NOEN2b3JkUzh6eVYvN2NXdmdmSzU1ZkRy?=
 =?utf-8?B?QzEwY0c5NmtESXFWRTJIOWhRcGI1bEF0MWVpQVlHMkNrcmlRTUFjRi9sRnVS?=
 =?utf-8?B?S1kvTG9Uam55blZFTDd0TzF6bHQrNW95UXRsTFc2U0prclNVOWF3cUNETWZ5?=
 =?utf-8?B?R041aDJPL1dISVlneFRzanBsby9zZkcxVEozcmJSejd3MnNXUjVVOHZhT1hW?=
 =?utf-8?B?ejJVSXp1dGV4aFJkUjhnYktCb2M4SVp3RzZsQ0xLcXpOeVNtSmFGeUFyWWlx?=
 =?utf-8?B?eUpDakpLZVV3cmVMUStNZzByUm0wSHpBT3krdUc1Sk9sZWNETkxUSUlRa2ZB?=
 =?utf-8?B?aUR6Y0M5bmdtSjBMaDE0bmFabWNaQndOY3dyYktxZ1ZrY3RZY2pGR2RsYmFl?=
 =?utf-8?Q?P3Zc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9461f2fa-719f-4072-0421-08dc6e0a56ff
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 20:23:07.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4IUh9b+jEzFfm2nbPwzQkbbUBapWNxKkc4KMfPphsWf1a9z7xfLwgnIbwz9WgB1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598

Hi Reinette,

On 5/3/24 18:26, Reinette Chatre wrote:
> Hi Babu,
> 
> In shortlog, please use () to indicate function:
> resctrl_file_fflags_init().
> 
> On 3/28/2024 6:06 PM, Babu Moger wrote:
>> Consolidate multiple fflags initialization into one function.
>>
>> Remove thread_throttle_mode_init, mbm_config_rftype_init and
>> consolidate them into resctrl_file_fflags_init.
> 
> This changelog has no context and only describes what the code does,
> which can be learned from reading the patch. Could you please
> update changelog with context and motivation for this change?
How about this?

Consolidate multiple fflags initialization into one function.

The functions thread_throttle_mode_init() and mbm_config_rftype_init()
both initialize fflags for resctrl files. This can be simplified into one
function passing the file name and flags to be initialized. It also helps
code simplification of new flags initialized for ABMC feature.
-- 
Thanks
Babu Moger

