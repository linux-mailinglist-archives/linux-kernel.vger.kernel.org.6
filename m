Return-Path: <linux-kernel+bounces-173647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6478C035F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B592893B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C665A12AAE1;
	Wed,  8 May 2024 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lr5guYEJ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77412BE86;
	Wed,  8 May 2024 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190034; cv=fail; b=bxVvaWwtgUt3CE66bGb5oQ2P6BnLIvc4YStiepWWs7Id4gDuTVXyHGTZkSNUANENk+4EKebUHWwXcHjh+IyWfq5hQGp8mBIm68jbFUzw8GF89sdyckOQrnCTQQwBPL4BBujBaKjHZF3CKZeU2nZSCfqmpmDMAUn8SEAZJO0wpD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190034; c=relaxed/simple;
	bh=JIE6lyVm5pnKaatn9pjtELlWr2MM8tcfCqaC7ii+CTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XEKgONHaAwkQ62duVMlhBAIZeFum0voGIPQW3OAb06HZ6ytOwsTXBkhtm4PqLySe9sJOzBGTF39XELJwjFVdthXGjgKmyd/Ky7rTmKDIdcseOMCj1burZ9JcbEz48iGcUtDvxoAc1w1c8h/xziZ/XJiCgVIWQ4IIlnwh2AnQBwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lr5guYEJ; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAnPEHyQJoH5sg0/ya/YptrYawDUsosG657vm/NVJKOXRoS26lXAkttdXqksSn1WUECCrKQSASctAZnWNrDqev2x2p9AN4RGmpd1wKD5774A6IflcY0iQHATYyGa7QFwIOGlozqmsb3vPlOl9ztf7h6FjJXmq6fpbt0mVPo+N8pAQFrA90iOwVlNI5iu8GErJvSnTdvyl91LMzOHVeGil+7k9Wc12Pi+Q3Wy1pe8+0HPAKk5nwnwQshtyWPapNc7bv4y+czASObvpLebP2tYaSqb9rgV9jaRiOoVYwZF8KVSvOF+Cir5PhL6QUycEC+lnev+7A0b58xRlPIEGngINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xboDFtpuTOSRtYGLaMjIwRmAw75pEXiFAFiPlwlYU3I=;
 b=UHbkJFu6SzDZBjpJrnMbrRRWHvmKXPa5lHzfSid8cwhfsUit4t8HfU2WuOx4+hxhsYQeONVJz9JNcwtPMtRdUNnDkrp+7nFROJ7KfDu4FyvpMig1MOoN2v+UIEGbcQSfXg33QuKrjQn6T1SSbhZUez3mCgWblkA56RhYf6Oa56sas3946APIbdgDf/wttM2kmBneZ4hWQV1lRSXYq3iibbsoN9NjYQhiv8+M9nufJZ43/jn+QLkfH7Zz2RQ/BvNPe6bmEPZ0G9wPp4ZqOx1hhgv43yeb08KyEabaOiRNzzFtPN8AiUSyf7eWrsyvYKn6YaKzpIN+RQraieuc37hfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xboDFtpuTOSRtYGLaMjIwRmAw75pEXiFAFiPlwlYU3I=;
 b=lr5guYEJtqh39kIgEf/AMEjM6uh+ZnlOS8bX+IfcHcT/NEVw0On0LObN7aL/ZaaOt5MorMLdcUmZdfNY/ConYURmZPj3uSkWEY0xeIrTS9ZA7U1AZ0sXcsdhfQPtwbjfJhSBp+We3OdnFIRoQFoqCUDwMqmEwlUj3btaLnxa0EY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 17:40:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 17:40:27 +0000
Message-ID: <2a4cf5a4-9cca-4212-8a3e-8e7cce583b6f@amd.com>
Date: Wed, 8 May 2024 12:40:23 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 12/17] x86/resctrl: Add the functionality to assign
 the RMID
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
 <a6cb26639976873b1b85ec1606c2168493120ba3.1711674410.git.babu.moger@amd.com>
 <b5e68d85-4bf2-4e55-a9c1-b39cb7d94db6@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <b5e68d85-4bf2-4e55-a9c1-b39cb7d94db6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0096.namprd12.prod.outlook.com
 (2603:10b6:802:21::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 4277270e-78aa-4fe7-eaa1-08dc6f85f2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elBHK1hKdFdkK1dxZmZTNjBuRGxiSEJwdUJPMk0wTE43c1RyaDlpNzN0SlB4?=
 =?utf-8?B?emNwSzRiMTlBV0I3YityaVNYc1ljaU8wYlZoVUlmZTl1M0M1elkwdFRFNFUz?=
 =?utf-8?B?eHpkeE9kRmdLdXk4MUdzZm5qWlltZXhRZzd5c2tvVU4rSm9HUEwzVjZUR2Vi?=
 =?utf-8?B?WlE3MnBkUlBJWUMvUXIvVkRWOGFTSjRhUnhGdUJSNXpiZjRja3FBUWZlY1Zm?=
 =?utf-8?B?Y1ZWcnJuRFgrdXVpQ1ZwSytaSnBhZlQ2ejFWeVZaclZiVXViMEs0dTFsRXNV?=
 =?utf-8?B?T0s0NEdIaTRtek1QQ3dhZVozU1ZtMi80YjBTaXI0Tk9xLzYrOEppQW81N3dT?=
 =?utf-8?B?RHJ0RGVCU2paekU4L1R5T0tVOEllOWhxbjBWTnRXbFpjcm4zTlN5YmlRNHRu?=
 =?utf-8?B?b3dvbnhucDh6cTl0dlZZSWprY2QwSEk4ZFdXUkZsTHM2NkNrRWV2SGtzNGQx?=
 =?utf-8?B?K3BGd3RMWVF2NW56cFlibHlXaDdqZkY5YnNQYSsvdjdpeXpEV1JNM1luTlZG?=
 =?utf-8?B?TFVZWTlOZnFPY3V3TXRoWlJRQncwY3hCK0JDU0hqVjdWdDU4Z0tXNlZZRU1B?=
 =?utf-8?B?anlEckNqVmRNNWRtcW4xMTc4aE9mL2c0VFpoemxhWU9qc09uZ1JOQnBwVmhz?=
 =?utf-8?B?eWkrVEFqNndjM1FhSlBYWVRnbGxSSDN0TWZNOVM0TEcwZ3VaaklqYU9XSkY2?=
 =?utf-8?B?ejMzWGlmaW9CZWFvelRpQmRPOE9SaXJZMGFUUFEyMndtbjVLYm5lYTFHRjVT?=
 =?utf-8?B?WXl6a2loVmtwc2hRa2VOYlFHVnkzeUU3NEp6WmtYVEx5UDk3c3FPS0JybFhL?=
 =?utf-8?B?bFEwazk4WDhycGdKT0libi9MU2NtemNMcFoxUFJiaGY4dVZGS3Fmb1MxT2RX?=
 =?utf-8?B?ZFVlQnN3V1FSSnVoQ2ZJMjR0MXkvTDRyTU1ZR25tNGttR2U1VkhJK0wyZGU5?=
 =?utf-8?B?dWoxZkFtYXpLWkp3WVB6QU9rbmMyUHRuVFAzYUpmZkVvZmpSRjhkTXpUcm9q?=
 =?utf-8?B?ZlFFZ1YvcHg5b1UxODRWWnFVSlQwZDM1QjJNa0NNVTZTcmQwUnY0MTZkMUho?=
 =?utf-8?B?YnlpNkhBYlNTaEVObmsxMXQ3bnFCUzhwdE40bnlUazV0NXNyVk4raXhpUzZs?=
 =?utf-8?B?eTVUNXNlQ3RrKzJWZ0hJSWJKOWZOb1l5Tjc5RWo0WUI5Yk1nZ3M3MzdCY3Jr?=
 =?utf-8?B?SWEwL1VEV25ya1BkbXVIT1FWZmNkdlhJcitaSS9OWExGN3FEdjZPdzl4dWE2?=
 =?utf-8?B?K2t2dlkzNk1yWXJZa0MrTFlXdEJSd2REQzJ1M09aRnNVMVFWN2F3aVBBemF2?=
 =?utf-8?B?L3BHZTFjYmFNYkdDaFRJVWFpK09qTVBacFVpWE5BNWQwVlN4WkRYYXJobkl6?=
 =?utf-8?B?d3M0bjJYdWJVcXlHaGVXcVRITDRhd1ZJc2hCQU1tc21UL29vV2hOWnc1L285?=
 =?utf-8?B?WTBodFlUYldicTg5d0RqVytaU1dyQVR4a2piZDJaSmI2bklGTmtoNzdTVkZs?=
 =?utf-8?B?bXl3aEt2a2xEb0E4R09UUDFPMjlNcnI1Mk50TzloT05Cb2lxTzlqNmd3aHlT?=
 =?utf-8?B?MFlTOEVNR09uOEJMcnNnSkVRMkNmSkI1RmxrRnJKU3RqWlFObTNoM05sMG42?=
 =?utf-8?Q?twy2gsq5tCwYw+tGhXAN29RLkJ2H2W0gRdrzLxe3XeVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUEyekJERUtRVFdNQm5ycXhHTjJXQU51OUxWQitJOWxSa3FBL0E3SExIM2V4?=
 =?utf-8?B?cnN4Q2FhTGt0Z3Y0emw2bjNzY3JtM3hRWUs4ZmZNQ1lhT3hkdVhBMEljYWFH?=
 =?utf-8?B?Q2xZTVlXNFg0NDVDWngrWjdkS1ZhYkRoZGVKYVZ3WDQ5UysxZ0dhWlBFSGhB?=
 =?utf-8?B?Tm1tV1IvL1RuODBCUlRyamw2L0c1d1hkRHhYaUlHOFYwTWRsSmRLRmhRVERr?=
 =?utf-8?B?N2VJN05DbDZZS2MxNDNGMHNWeE9BMjFteGZDQW5rSUxySEVyS21xVWdFQWM0?=
 =?utf-8?B?WlpuMk9qUlRHSy9LM3ZnT01LUE9oQUZnVFJ5SHZvY1lITVArQ1dDWUYva0Fh?=
 =?utf-8?B?akRmbkg1bWNOQVY0cVN3cGhGWVp1L2J3clNkTzl2OXJrZml1WS9yWEZGajc0?=
 =?utf-8?B?M01ORFJJR2YzV3R0d3NTSDRKaCtzeDd4cWVSbVN5MDR3Ky9PRDkwRjJOUzJK?=
 =?utf-8?B?V1NIeWZBRyt5VjZvLzhBQkU2S1E1dlhhNFRrZFpHaUovazZYRTJSaWxBTUFy?=
 =?utf-8?B?VEhhK0V1Q2ptQUFzMk1yRXNEeGsrUmZJVjhob0h4UjVVbmk1UGY3dXUvYXRO?=
 =?utf-8?B?cHNkZzk4VVNJYUFUUWdCeUhCaGFDellGRHhjYWpkR0loSXZrbkJBS3daeGlw?=
 =?utf-8?B?bmVUMjM3MUcyYUhsV1o2NHdzT1VsK00zbmJmUjFVRitYeC9pNEFSMXBpSW44?=
 =?utf-8?B?VFlNWWpacWpmMEhkbUhhK0dBYlJ6QVJSd2tZWHpkMVEwVGdMNmtMUDFDblJR?=
 =?utf-8?B?clBVVVB5cmpEY1RMcDNrS0ZNbk5XK2JCenoyWDNIbm82NWRDNWl1UXZIV2Nh?=
 =?utf-8?B?ZE9vQ2cyNktla0c0L21LRVdkbDh1angrUmVCWjBCT3dDdC9pc1BwVUU5YzF0?=
 =?utf-8?B?WGZZdDlQeFFld3lMZENQVHFJSy9WRVBZOU9MZ1FHN3FxWlduMkhOZzZRcS9i?=
 =?utf-8?B?dytha2RiZU8zMTcvVEtPRmwxZE1pR1hvWklpU3IrMXN4VFZ5bDBGY0FYc3Uw?=
 =?utf-8?B?Y0gzd3MzdmpsdkV5RFdzVGoxTVh1WnkzYWxUSks5dFdHYmJEQk5RanNnMDFX?=
 =?utf-8?B?eTRSTS9QNUtwakk0NGNtRWsyOThlT2tyQ2VCZkhkNVVaSGRld1VVRzdGL3E2?=
 =?utf-8?B?M1RnYVFvSE45ZzFLN29LdVJIRVNRYmlCK0hmVDN6T3R2cEpBTVhDVHFRYk1L?=
 =?utf-8?B?VlNoV2gyZlNteTJXZUNPa285S1VVYmlGL1lrU2E4WHNwbm54bERKWkt1VnNn?=
 =?utf-8?B?bjdhLzl2QjR5a0tnUGNnRHQ3MmZRWUN5bmpVdjJ3elE4SS9JcUJZUm5WVlNu?=
 =?utf-8?B?T09MeWxVMDFiajRqV2xYZXM5OWF5S2JDZGdCbEZPcG5Tb2t6U29iNGRyL04r?=
 =?utf-8?B?QkJYaEs3MXFaNEhIeE96bmY2a3p0S1lFeldJSUN0L0h1MHBpTWRVR2JNS0NE?=
 =?utf-8?B?Z0tCMUNYcTZlY0U5blZSM1BmYnQ5SkI5b2YvWnpVaDIrMjBzMVNnSWZPN21T?=
 =?utf-8?B?L1ZMa1JDL3JUMzdZeXlWd3J1LzF3eDFwU0FQaUcrMnp2YnA2cGlQYUMrdDQz?=
 =?utf-8?B?RjZheXlSQkxoSzBJRW1adnluYzhXRTMvNEpOT0hpWHlBWjY5Qi9zN3lsR0NP?=
 =?utf-8?B?VlRDOTZsSUY5OThESzBqTGx1TTNoUVdNRWovU25QNXNYNkNpbitqMEQ5MVZR?=
 =?utf-8?B?MCtLZ2hDWStDazAzZkhjRkZ1TnJlTFhZS3o4QitvM0d4ZXoxSjE1dVc2SFlr?=
 =?utf-8?B?VTd4MXhzTWF0TVkyRjZjVGw2b01VOU5La0xpZnp1eFErTkd4KzUyUldGc3BW?=
 =?utf-8?B?dml5c0tySUxaRmppMmRQcjFOdmsrbWs5YWQ3SldNQThxUFRGVURXQkdTTWR4?=
 =?utf-8?B?b08xcXNLL0V4Y3l6RHRBY1RWMVlhOUcvNHVSeFpYOWlXTTBVaDQrMlU1Rnh2?=
 =?utf-8?B?Z2hCbG9wZmxLZER0T2VJdDd6bTRJV2dXUjJwbzdhYm80SER4a2FzcWVaeFFo?=
 =?utf-8?B?MDE3Wk9ESWpHNDJreGhZZGJFbzJmM3pZMThqTHNpcGxQVDY4OStpcnhOeHJv?=
 =?utf-8?B?R0s3QkNzOGVjQ0R1dGUySnBzMzJYSnB6U2hNaHJkYkJQWVgxUWt4WHdhNk1U?=
 =?utf-8?Q?/Qhc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4277270e-78aa-4fe7-eaa1-08dc6f85f2dc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:40:27.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUd2CNavIBmv0zmDXH4dmQxWiJa7fJvuSQM8KmkClb7HQaxZIErHXaH9FMBb0aiL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

Hi Reinette,

On 5/3/24 18:33, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/28/2024 6:06 PM, Babu Moger wrote:
>> With the support of ABMC (Assignable Bandwidth Monitoring Counters)
>> feature, the user has the option to assign or unassign the RMID to
>> hardware counter and monitor the bandwidth for the longer duration.
> 
> What is meant with "the longer duration" (this term is used throughout
> this series)? Perhaps "for as long as a hardware counter is assigned"?

Yes. Sure.

> 
>>
>> Provide the interface to assign the counter to the group.
>>
>> The ABMC feature implements a pair of MSRs, L3_QOS_ABMC_CFG (MSR
>> C000_03FDh) and L3_QOS_ABMC_DSC (MSR C000_3FEh). Each logical processor
>> implements a separate copy of these registers. Attempts to read or write
>> these MSRs when ABMC is not enabled will result in a #GP(0) exception.
>>
>> Individual assignable bandwidth counters are configured by writing to
>> L3_QOS_ABMC_CFG MSR and specifying the Counter ID, Bandwidth Source, and
>> Bandwidth Types. Reading L3_QOS_ABMC_DSC returns the configuration of the
>> counter specified by L3_QOS_ABMC_CFG [CtrID].
> 
> This mentions the AMD architecture parts needing configuration but not what
> resctrl parts are used to accomplish this configuration. It is difficult to
> understand this work without this connection.

Let me reword this in the next revison.

> 
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>     Monitoring (ABMC).
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> ---
>> v3: Removed the static from the prototype of rdtgroup_assign_abmc.
>>     The function is not called directly from user anymore. These
>>     changes are related to global assignment interface.
>>
>> v2: Minor text changes in commit message.
>> ---
>>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 86 ++++++++++++++++++++++++++
>>  2 files changed, 87 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 88453c86474b..9d84c80104f9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -651,6 +651,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>  void __init resctrl_file_fflags_init(const char *config,
>>  				     unsigned long fflags);
>>  void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
>> +ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp, u32 evtid, int mon_state);
>>  void rdt_staged_configs_clear(void);
>>  bool closid_allocated(unsigned int closid);
>>  int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 7f54788a58de..cfbdaf8b5f83 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -202,6 +202,18 @@ static void assign_cntrs_init(void)
>>  	assign_cntrs_free_map_len = r->mbm_assign_cntrs;
>>  }
>>  
>> +static int assign_cntrs_alloc(void)
>> +{
>> +	u32 counterid = ffs(assign_cntrs_free_map);
>> +
>> +	if (counterid == 0)
>> +		return -ENOSPC;
>> +	counterid--;
>> +	assign_cntrs_free_map &= ~(1 << counterid);
>> +
>> +	return counterid;
> 
> Use bitmap API ... eg. find_first_bit() (eliminates
> need to adjust counterid), __clear_bit()

Ok Sure.

> 
>> +}
>> +
>>  /**
>>   * rdtgroup_mode_by_closid - Return mode of resource group with closid
>>   * @closid: closid if the resource group
>> @@ -1848,6 +1860,80 @@ static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
>>  	return ret ?: nbytes;
>>  }
>>  
>> +static void rdtgroup_abmc_msrwrite(void *info)
>> +{
>> +	u64 *msrval = info;
>> +
>> +	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
>> +}
>> +
>> +static void rdtgroup_abmc_domain(struct rdt_domain *d, struct rdtgroup *rdtgrp,
>> +				 u32 evtid, int index, bool assign)
>> +{
>> +	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +	struct arch_mbm_state *arch_mbm;
>> +
>> +	abmc_cfg.split.cfg_en = 1;
>> +	abmc_cfg.split.ctr_en = assign ? 1 : 0;
>> +	abmc_cfg.split.ctr_id = rdtgrp->mon.abmc_ctr_id[index];
>> +	abmc_cfg.split.bw_src = rdtgrp->mon.rmid;
>> +
>> +	/*
>> +	 * Read the event configuration from the domain and pass it as
>> +	 * bw_type.
>> +	 */
>> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
>> +		arch_mbm = &hw_dom->arch_mbm_total[rdtgrp->mon.rmid];
>> +	} else {
>> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
>> +		arch_mbm = &hw_dom->arch_mbm_local[rdtgrp->mon.rmid];
>> +	}
>> +
>> +	smp_call_function_any(&d->cpu_mask, rdtgroup_abmc_msrwrite, &abmc_cfg, 1);
>> +
>> +	/* Reset the internal counters */
>> +	if (arch_mbm)
>> +		memset(arch_mbm, 0, sizeof(struct arch_mbm_state));
>> +}
>> +
>> +ssize_t rdtgroup_assign_abmc(struct rdtgroup *rdtgrp, u32 evtid, int mon_state)
>> +{
>> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +	int counterid = 0, index;
>> +	struct rdt_domain *d;
>> +
>> +	if (rdtgrp->mon.mon_state & mon_state) {
>> +		rdt_last_cmd_puts("ABMC counter is assigned already\n");
>> +		return 0;
>> +	}
>> +
>> +	index = mon_event_config_index_get(evtid);
>> +	if (index == INVALID_CONFIG_INDEX) {
>> +		pr_warn_once("Invalid event id %d\n", evtid);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Allocate a new counter and update domains
>> +	 */
>> +	counterid = assign_cntrs_alloc();
>> +	if (counterid < 0) {
>> +		rdt_last_cmd_puts("Out of ABMC counters\n");
>> +		return -ENOSPC;
>> +	}
>> +
>> +	rdtgrp->mon.abmc_ctr_id[index] = counterid;
>> +
>> +	list_for_each_entry(d, &r->domains, list)
>> +		rdtgroup_abmc_domain(d, rdtgrp, evtid, index, 1);
>> +
>> +	rdtgrp->mon.mon_state |= mon_state;
>> +
>> +	return 0;
>> +}
>> +
>>  /* rdtgroup information files for one cache resource. */
>>  static struct rftype res_common_files[] = {
>>  	{
> 
> It is not clear to me where the filesystem and architecture boundaries
> are, but I understand that you and Peter already discussed this and I look
> forward to next version that will make this easier to understand.

Same here. I am not very clear as well. We havent discussed anything out
of the mailing list. I see that fftype flags available for both fs and
arch layer looking at the latest patches from Dave. Will change it as
things change moving along.
-- 
Thanks
Babu Moger

