Return-Path: <linux-kernel+bounces-225037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99394912AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CBE2885A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C608815FA6C;
	Fri, 21 Jun 2024 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g7z+96IM"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337695028C;
	Fri, 21 Jun 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986049; cv=fail; b=MTo6cdKfagA9MpRGOi3X5OUP6v/hlmrbFP/m7miFHOPFCU0cpGkIGhOFRvZmx7M5qoqCkJMLWnUYaA9+9Z/4unureTuHg6x3MYHL8i6Bs5KhwqljXYOLoO11RLnv5ORDWa+1sOQTYrTtxkt4A4yzkgA1DFijy0eYzmmoj1zAhUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986049; c=relaxed/simple;
	bh=JpaYyBN08u0EjPWtYvmvWyQkWpUC9RpxgGK/lHXCmtM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=senhihGoMyJfva/aFo0/H3zMsU88f7rB4PF31vM4+emsy6ZQbjzyD4zchli6bedpI9RT2VouuruiKhfhHra5uVB+U4kn4cmGSrKbzliVtF5WapZ7ZuJZTcuG9yoxJhkg4hZ3pFFFFK8OEXXMjnYwi8rf3+/brWwPo6SJWDvvW9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g7z+96IM; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVStwhTyBxeqh69mEjdin0d/D8tthZsIwPN71bcGReI118QBKQ8ziED7cnuwEVE4ZXcpvTl+Lt0IYnxhcOmR8/eTlENCcRx3ObAzyO6wJ4Qx+Z2hrCoYvqvaTuVkChOqOCr26k4AaCSS2T/cxO08VByY7pJ0QiFBZ7b7MeHMSo+4VFP6+ZxIOpQ3XnWBQXvqbY8Yc0zgUkSjQ0C8IWLvRj24hv9AIrerkrDcCr3CAT/JMo1QmUaiHfDV+E4LgL0nLrY4X4FM2EUjZorDYPXlAfWTS6GdkRO4/W9/BxVeWRtwO2Dk/q45UWf3F6QPlv24c2qav+emNfBm4OoZrEL6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKy/LFnobdYp08OxvJgM0t0R2emTMLUxoOqowSDGHlQ=;
 b=afnhSmNKMkg33MmVblzA1dlK93NZB7FZHXCQzqHITO9a69M0ICLa/HvtdpMpWoLWhZNm/vsa7d0fAcxpiF4zcGNFKmx5cVDfo/yfsr0Fli82MlVp1Op6uzUNKx+PuhhyaqBfH/6WZA2fX/BohVqBl3cuNQ+SmuYvWNZWy09Af23OrKfxaSRn6stB6V04a6VQ3yaTkGL8YiZE7DCa6teCpCQy6cZ2MOwDXVa/DPQ2w2LZ1kIrwpqjAAMFkFap8soJDkYV1AJA3fPrxTWnGZ60+aneBUT3HWTbTF2rAyek6ZAXJ4F4yFephbOnvoOBgm0UFSXy7xpNeAoIC68n8yvJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKy/LFnobdYp08OxvJgM0t0R2emTMLUxoOqowSDGHlQ=;
 b=g7z+96IM8UK45Z3t6dndhLAMRB3BUUgmNW6JbzmomXpZaz9dQlnQBb4dzCAvFG0ReEx/lZEmOcDXIxITyc/ee3amb2AGUUQmCA8/M78Z0FpnpwbBRdPhtJif6O6askUVM5TENhnQQoYPCOCbgEOiNs8BFULIQylw5C+dKR7aH8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 16:07:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 16:07:21 +0000
Message-ID: <0c7a7447-957e-6b89-9928-ebbe560339b0@amd.com>
Date: Fri, 21 Jun 2024 11:07:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 14/19] x86/resctrl: Add the interface to assign ABMC
 counter
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <631092558e7fe0ac2e6267070e40c4a97b300f57.1716552602.git.babu.moger@amd.com>
 <e649a49f-344f-4dbd-be2f-d70f932a80f4@intel.com>
 <16b7768c-8f68-65fb-19a5-55a117dd0603@amd.com>
 <13297090-926c-4585-95ac-02a865ad1e49@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <13297090-926c-4585-95ac-02a865ad1e49@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0070.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 3504e903-59d4-438f-a8c1-08dc920c3b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTdIUFpsWWZBMFZMeWxKV3FudkZMUVQ4VEF4b0dteTJwOUpVTDhnMkorRU1x?=
 =?utf-8?B?a1MzYzl6VXppMEp2TXdQMmUvdk5LeVZ5R25OUWt1akdDUHhCcThobW1iNHVq?=
 =?utf-8?B?bm9TTVBPRW9SV3RlcW9VbEI3M0VYdCtFZE9nUDNjUjFmWnhsamV5bTJ0Z0Fi?=
 =?utf-8?B?WWN1cnlFT3FSSEE0VWRpdVJVK2VjbzJjWnA0a0JkWnhWclo2MW9aRWhGVGlD?=
 =?utf-8?B?NUtCUW9kd3lrWEhteHErRnZjWnljOU5ZTDF5bFVscjZTR0VwajhqRUFNZUV6?=
 =?utf-8?B?UVNtcDlWcDR4eUtmTEd2NEpQQmJpMW1meW1COUNwMTkrYnBVOTgyN0gwRDFs?=
 =?utf-8?B?Q1ZNbG0wUkx0YVdsT3dSaitOanhoWEpuSm9QbC9TdEVaRW9ScVVvNXBlMlh5?=
 =?utf-8?B?T0dtWXBKUlkwZ3RyZGt5OUtsbDNNNllNTEsweUFqNnNyK2w4WG45cDMra2Fm?=
 =?utf-8?B?UTNobG1DWXJDZlkzMHNEUENkRHBXcE1jUVM0eHQ5Rno1dWNiWHNMbUJ5K085?=
 =?utf-8?B?S1oxdjBsb1hhQ0VKeEZuU2tqSDBOWWkzS1FUcmZrUzlKQ2ZkUzgxY3d3bnkx?=
 =?utf-8?B?VkJtdWFMSnJQVW5XdEdtdm5CYTBYWkM5UnltRDhkRVUwcGhjc1JvNmVZOFNq?=
 =?utf-8?B?dk16eVZhc2RKZjlxQkl6YVZpOTNUL2FzVEtSWFkvM24wZ2prMU1lSFhQQXBO?=
 =?utf-8?B?Sk1KeE8vdDNHMlV1WCtnOGdRZTRvYTZLN1FiTW55R0gvR1dsdEkwbjhPTE1x?=
 =?utf-8?B?a01lZE44MnZmOXJCbU9wT0xkdC9ydEl4ZkppTnRPa1Z6d0Z4TEd4Tkk4RmJZ?=
 =?utf-8?B?Y1BxVEEvVTZBYWxLanUwSkJydGRvdGJqYTRQZXRaTU0xREliTk55Wk1GdC9Q?=
 =?utf-8?B?d2gyTXJ3SldPTlZpZDR5R1R3SHNsZUs2RVhBUlV4V1Nuc1hweEFOTWxHZ2du?=
 =?utf-8?B?am1jc0tDTkE3R3BRWVc3STcxVUIzdS9hTXQ2bERCR1hUei9pSHdldmptLzQ4?=
 =?utf-8?B?YWNic2g2TW4xUFZ3dm9lMUJlZTN2TUhQK3FXL2llU3RmWjR3a2tDbnF2M2JO?=
 =?utf-8?B?ZGNIRVFvQURtZzlzeEtJN3hpVVpGNFJmeU55SEFrQW15SnFTaVhEeURkL2NT?=
 =?utf-8?B?VVdvenBuY1pDSnhmVVZQcHFPTG5oaklFT29vQTJMVU5YWjJ5MjV4aGo4MEo3?=
 =?utf-8?B?VHkyTzMvMmhwTWlkV0NNVFpnU3FRQVFBR3JNRE43VVNjem9kZDgrM2laSFVn?=
 =?utf-8?B?dEswK2ZlTGRtaVpWMDFEYUpwSndYU29EbGVGcC8wZ0ZiamRuZ0tRWEg0aWx3?=
 =?utf-8?B?dnJSMjBDd1JwWWVIVFlVLzUydEJ2UWt6VE42TFdYQ3dGemtOMExQSEFsVkht?=
 =?utf-8?B?YUU2UUVINE5mK2xmV2xYY0UyUVRqbHIvRit3eGk4SDNiQlcwTVlDWHVMOTJF?=
 =?utf-8?B?NEhpZkJueVp1ODA0a3JITDV5UFFBeXFha3ZicmZ3dzRmWlV4R29PbGI2dVFz?=
 =?utf-8?B?cFo3cGlNZm9rTW9YU2JVTlZpU2tZbkFXSFkwRGJ3eVl2Q01jelN3TndvbTEz?=
 =?utf-8?B?Q29kTmxEbnhmUzV0RE05T0Q5Mlp6WTlUZm9EWm95dHMvMkJ2TGY0Z3N3UDZw?=
 =?utf-8?B?WlhUdldQbTN6Z01jTkxjR1lsb25NM0kvSVl4YjllSy9zb01jSVNIRVRwZ2NQ?=
 =?utf-8?B?eHEyUncyOFFHUjRqdFZYOXBKNWt0eTVldTJmdG9SMkZxRDlyNHNQblhhZlFs?=
 =?utf-8?Q?ijsT/VhOpvEpfDDk28Q+LN8GPXgm4WplAIlKZi9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGhaREhrSGFQWG5EUDVKOVp5REhNemdOUlFYQ1FieTRFeGp2bUkxa2RqNDln?=
 =?utf-8?B?UEdkZ2xFakE3K0JNdlVISWZvQkRZSmZlSFF0ZXliMVdPQWZHTG1YL3VIb2Iw?=
 =?utf-8?B?OHdpSm5HdnZBZ1VZajlZSVVFNFB4NUhoek1hV3B0ZTdSd0RGWHdxaHhQOVpx?=
 =?utf-8?B?aFFQbzZqc2lhVVNLMHJycXBHaHZkZDJZV1dUWW53N01yalcxYTFsN2Jnd1lZ?=
 =?utf-8?B?dnNrT29ZWnI5RWR5eHlRNG9rQ0llMVJzbFM2bG9hUGtBQm9mVXFGZXk3bE5B?=
 =?utf-8?B?KzdXNXBERU8vNVA4TDFEVnMyTXN5NHBYQ2RPR2FRSHFnWWFUK2Zpc05xZEha?=
 =?utf-8?B?T2lRWUVnMkRoRlFPMHNiWnVXWUdGa3pScHhMOS9JQnExZVJNbTJCOVYzOVhS?=
 =?utf-8?B?NWJnUUJvV2ZzZ3UxZG1DZlRzVEpxL25LanVuYjgxL3JBYXA1VXdaeUJkUFB3?=
 =?utf-8?B?Uzl3K2htSEU1OFQwL3dHWmxuNWlDU3dtbUtUSHl5OU8yQ0NGYXVwRVl6Rkp6?=
 =?utf-8?B?enk0QmpkQW5oMWJ4TmZtWTNLaXpxWVQvZXEzZUtvOWdPOTdwT282ZUw5TWhK?=
 =?utf-8?B?MkJQblVBaGRVMFBabTVtMnRnM0xhMC85QlRJYWxpSmVVM2FDSzJYWnJzTXYv?=
 =?utf-8?B?UERBTGc4cEcwNytaYkhzWEhOVDVSQjhxaUVvNEx6RnkwU3pncjhrWllDOEZS?=
 =?utf-8?B?dGh4ZVZxUGVjcUdaZVVSdy93ckRNdy9zOVVVcE44K1Nmdm1WSklXSFFkSkp0?=
 =?utf-8?B?L29ldHpsNk1mNWtFNXlrQkVsaG1odUs2OWl5S3FEMVExemgyRVdEOWZ0UnhU?=
 =?utf-8?B?L3VINUtVVVdFR3FueDZoNW1yd29lSndDUTRhcXFZMkRPL2k0THkyaitMNGI4?=
 =?utf-8?B?cmpyekorQnBTd2JLR2ZMSWlRcS94RERtSGk3UFQvai9yREc2c0dxUUM4U1ly?=
 =?utf-8?B?cEZNTFRIenkyZC9EMDA3SDVEdWk4NFRFNXNiVmZJU3VZTGFPUWpwbWRwWWFv?=
 =?utf-8?B?MWxDdjZubVJwaTBsSUVPYWEvNzVJdk95R2dIRFkxczJuTlZITkR5dFZvVmNo?=
 =?utf-8?B?M1g3ZmxBN08wYVd0N2ZGQ0hsaWZCQzZWcnpvUzRKMDRpQnV4MHhlaDE1dzhn?=
 =?utf-8?B?K2N0Mmd3eHBKWGF4azI3Zk5JekFMMk5zRktWS3FmOEhVREIrSHRtQVdFUU1I?=
 =?utf-8?B?WFNsNldRcStuUVdSKzdtaVFhamhuNFFaT0YxK3dPVFAwelF6NWJPaUg2ZXgv?=
 =?utf-8?B?NDYrUSs4RE8zdWZLaEdQYUhXZ0N5cyttT3ZWU0dUR2piamJuSWpBdHRpUVJK?=
 =?utf-8?B?bmEyNnFibXhPYUlWNEE3YUxwdG53M3FvMk92NEVmS2s0Nkx3dERmcHIrMzFu?=
 =?utf-8?B?bkoxZ2g5K0ZxMERocEYrcnkvZFlORGRCcW40ZmtaVEw3U1dHOFk3WmJkRlJM?=
 =?utf-8?B?cno4T0Fqank5Wkp5Z1hLT0xUckwrYklzMDROcDdlQWh5M0l2TXNGUWRNU0Fu?=
 =?utf-8?B?R0wxSjBlWWFZTFVjbTBxOWhPUmdpbWhEQzc3eDdwaThNVDFxbmFucHpURWlx?=
 =?utf-8?B?NHpnajVhYnA5MDgzTWpjVXdhY0tBbGhNbGhNSjV6elpZVERTcHpieC9wUTll?=
 =?utf-8?B?QlJDb1B2d1ROQlZ4SkR1R1E4MXk0Y2NPOGRzeGxTdWJkbE9MVHJOODF5WkNv?=
 =?utf-8?B?SEVHcHpGcTlXTy9YdTBJUUFITTNqZ3QxcFkwRjBOTkpJclRndU1icExSR0s0?=
 =?utf-8?B?b3puNEJ2cmtIM1NtcDYxdzIvcy9MbU5sL2ZGQjB3TktHU01nYk1BOHdlM2RU?=
 =?utf-8?B?NXJ4N0cwMUhMK0dUalRFVHFHeTNDUjJ6YkEzcFBhZDNSSjRqZTJST2phUVV3?=
 =?utf-8?B?ZmRtejliUDMyYVYvaW1JZHJnd0NIdkx3VFNnVHlCaER6UVV1bTIxUHRzYitO?=
 =?utf-8?B?QXEyTU1BSC92alZUM1hXV2ZLMU9jRzFlbitGYldDak56UzNoakhtTTRSZng5?=
 =?utf-8?B?U2Exdm1oQnlQZDlLQTJJaWhkdkJrR25sTFpMeUg3QW5IOG00V1FHV2N3QUxW?=
 =?utf-8?B?MENIUXNSOFZhUFRTYm9wa3ljZzhYNVpzaENCMEE2V3cxS1J6UTQyY2kwRE9x?=
 =?utf-8?Q?PUrs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3504e903-59d4-438f-a8c1-08dc920c3b28
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:07:21.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hL8e1mhFv6RKk+k/28WzDU6pHe43SQ4iFXHkse1TjqWgNjUsuRlu6Igcfs0b9U1P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263

Hi Reinette,

On 6/20/2024 5:50 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/19/24 3:38 PM, Moger, Babu wrote:
>> On 6/13/2024 8:48 PM, Reinette Chatre wrote:
>>> On 5/24/24 5:23 AM, Babu Moger wrote:
> 
>>>> +int resctrl_arch_assign(struct rdt_domain *d, u32 evtid, u32 rmid,
>>>> +            u32 ctr_id, u32 closid, bool enable)
>>>> +{
>>>> +    struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>>>> +    union l3_qos_abmc_cfg abmc_cfg = { 0 };
>>>> +    struct arch_mbm_state *arch_mbm;
>>>> +
>>>> +    abmc_cfg.split.cfg_en = 1;
>>>> +    abmc_cfg.split.ctr_en = enable ? 1 : 0;
>>>> +    abmc_cfg.split.ctr_id = ctr_id;
>>>> +    abmc_cfg.split.bw_src = rmid;
>>>> +
>>>> +    /*
>>>> +     * Read the event configuration from the domain and pass it as
>>>> +     * bw_type.
>>>> +     */
>>>> +    if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID) {
>>>> +        abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
>>>> +        arch_mbm = &hw_dom->arch_mbm_total[rmid];
>>>> +    } else {
>>>> +        abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
>>>> +        arch_mbm = &hw_dom->arch_mbm_local[rmid];
>>>> +    }
>>>> +
>>>> +    smp_call_function_any(&d->cpu_mask, rdtgroup_abmc_cfg, 
>>>> &abmc_cfg, 1);
>>>> +
>>>> +    /* Reset the internal counters */
>>>
>>> "internal counters"? This needs a definition ... but since this is not
>>> a new data structure the comment can be more specific about what is done
>>> and why.
>>
>> How about?
>> /* Reset internal mbm event counters. */
> 
> I think it is potentially confusing to introduce a new concept of
> "internal counters". This is just the architectural state helping to
> detect overflows. This commit has no mention of this but I assume that
> the re-configuration of the counter will reset it, which explains
> why it is required to reset the state maintained by software.
> A similar comment to what can be found in mbm_config_write_domain()
> would be useful. This does not have to be so elaborate, maybe just 
> something
> like (please feel free to improve):
> 
>      Configuring a hardware counter resets it. Reset architectural
>      state to match.
> 

Sure. Thanks
- Babu Moger

