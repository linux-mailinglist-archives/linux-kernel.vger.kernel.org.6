Return-Path: <linux-kernel+bounces-294545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8403D958F05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD5CB22736
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C04A16190B;
	Tue, 20 Aug 2024 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TYSiSM7J"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390BF18E37A;
	Tue, 20 Aug 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184280; cv=fail; b=Xv+b9bd562Gu8yhPShMYmdD8P+QPxY2MeNZuhxYkXyLURaV9ZpcFzb9PvbTyFu2T0LE3UUtIUA3UapOnZ5poJKGlpVd4WBB5vM2PhsVjb3M3jYs+qUJtdlT0OdkNlEXLbl2HtomLEgYx3hxI8KnnET6I3YNEYLqzYQyFUHlNK0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184280; c=relaxed/simple;
	bh=gYppPhqZXrhGkA1WocnDbXhPX77OAUJI0dmS+YlcaFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BTcIOwOkrpZS/IpxsfI+h5+IbiAdn6PZhZgzeV4sYP9SZPjrqcq9jg9pNG+ketfhSsmEEoBpNPKPxj3wetuMRL9/sBRP92PeMeejuqRvxEvt7kc0YgNSBbZk8Zf2iJaZ5NUQdepNjp+ItmZGUrJYCCu7uCJtLRGwyWygaKz1xJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TYSiSM7J; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQ7wNPSId/22oMYZhAPmKRpaPOdmB+g2GqQ0IXtqCoDU+C+KnR98VBKEIYO7U5aT7P+T8N7PjzTmpMy9T3prIzj1i+h3YEuM2sEmj8nldnURFalkkMlDEP9dtJON6h0fhU5hOezHTm4JKJzs9QrCz7pMvkmFRWgfwJwvxkFss+JqF15C3lJ/oRTd5xxjWyCIeJ3zEYM86iov8EqE0qz+xsyT/DbqiQE/xApJ0StUgiTxMMGpE2sWTTLHDe/1vx3nKmm+uGC+tdc3AglBytCdMydBvFTzhVUpUhDTjU59UtRZujrTKacBgSbY7ANz8nrfyjvVvIHUBgoUI0NyF9Sj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHXxS8ggNeHswk1vGIZ3GbVBRmSErsIVj1vQAQ/quiQ=;
 b=Xjlt9tQAJlra25hlmeffeH7I4PJVQX1ta+QNC0/rych0L9M7ttl0O5MYzXA65faEeqbLxKPv+TXrUUWQZkpHqy/NWUUOgUlttNVcfwrMx5yItRQ2956Mhx6UES4Of6Cyd3RWriNgm0hKveSdJYETiqh+J1sQa0OPH81BPOpa7PfCycbK5z2aNwswnpQ4YJD943W5vC/K2Jy30EZ6xHw0sc/C/W2qxWGgqhoghwv6k4zgQdKGCOpEhd/8EffTf9bjzq1mRQcqjNjs+/sDv2HiGwtlwrNoyNied93fSLLL0ciF3SqTONW4gjN03TiJBINywPtx7mc4UPBqWd48wIAxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHXxS8ggNeHswk1vGIZ3GbVBRmSErsIVj1vQAQ/quiQ=;
 b=TYSiSM7JKvIFghVv3mG3ub0nrt53q1JaaTg6V3aZyWoTvp2Zb82AohsWpk+l0F/WXGJExCgtAAcRxymrgeI+oz9FKFREjzccdNwo8SChfj8bnNE/S1en7HnO0Tmq+dSIevFU5xEIrefZScyjBWnKAw2b8IBojp2k4nn5i8L61vk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 20:04:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 20:04:35 +0000
Message-ID: <b80a9e76-764a-4303-ada8-aa4d08559664@amd.com>
Date: Tue, 20 Aug 2024 15:04:31 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 20/22] x86/resctrl: Enable AMD ABMC feature by default
 when supported
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
References: <cover.1722981659.git.babu.moger@amd.com>
 <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
 <ab979768-a98b-417b-b319-6f14da88b857@intel.com>
 <16263da0-603a-44a5-b6be-58c66b8dd863@amd.com>
 <6b1ad4b2-d99f-44fb-afcc-b9f48e51df6e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <6b1ad4b2-d99f-44fb-afcc-b9f48e51df6e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0080.namprd12.prod.outlook.com
 (2603:10b6:802:21::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: a72f141b-dd59-4100-cc9e-08dcc153507d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmJDNzdMdS9QaDV3di9temMxVGJaUi9VcTBXUTZRMnI5bE5aWU1BaVdVcklk?=
 =?utf-8?B?Tms1NE5ieS9LSHpaTHIwdXRWa3BFbklodStsU040RjRFTDBYUVRES3Y4V0pQ?=
 =?utf-8?B?SWhDa3JMdW5oTlpweExqT3ltYnk2RWhqYys5Ui9WNkI5eXgydzI3d3U5MVdq?=
 =?utf-8?B?MHRaak13ZzVQYTYrSjJ4U3FOQTVpdUZWaWZxQW5XY1d4NmtLMGJzZXJZNVRs?=
 =?utf-8?B?QkhIUnhLQ2t5eUVjVE14OVg5V1BReE4wNmV4NXZTNGVkbHZ2ZjhrSHV5bHFl?=
 =?utf-8?B?dTZxUDNUWG9WS3hXMGZKVk4vSCtGZHVLUHJCczRpc0Rja2E1dG92eTY0NkdD?=
 =?utf-8?B?TWJ5dDV4Zi8yS0g0djVrSXpVa3hGTzZMM1V3VjMzTjlMelhmMExSeE9RWmM3?=
 =?utf-8?B?Y2tCWWpxWGZTWXBCcmV3ckVQc1I0WUdHWkdEMHNDYW9ISzNRT3lmV3ZPdEJx?=
 =?utf-8?B?aXo5SFJwQXJ3NE8xclcrNTg0QVpRMktFUWVMQ1dSdWZySk9BRkF0SkNBR1RM?=
 =?utf-8?B?NFpjRFlhWTBZT1BmZzBBUlJiVzFEaGJjdGNQQ0NtNU8rM210VDdSR2JSZWhN?=
 =?utf-8?B?ZUNmUFNYL3UrcVBnbTNtTUlSQlJMdDdGWDc3SXl5bWhuSGxyVXRxQzNFaFVv?=
 =?utf-8?B?VVh1VjVoSjFVNWJ1Znl3T2U1YkVlcjdXb0NUTm83Q0EybUlBTU45ZjFMZXFR?=
 =?utf-8?B?Q3lNeXQ0ZitBOVRVcXFxTG5kZVpNTzFBaWZIMm5rV0N6QkF1S2hLVzZ5YTA3?=
 =?utf-8?B?UWJPVUdNTktXZGpGQ1VKaXFUZ1JUaW5waFhGQjJ2VmhzZCtBYS9NK2luWVA2?=
 =?utf-8?B?VkxxSzJPbHB6VzlkZktqamQ4VmE3bmFXQUxsRi95RTNuNDgzcjZQRlMvblgw?=
 =?utf-8?B?ZGNjVUZidTlMVHVpMitqSCswdDlVUUIvMDZQRHlOTTBZRmlUeHdzM1lWMkNj?=
 =?utf-8?B?SVhwRU1ReSt3c002QXE1dStBekY1MmJsTTZ6YXhWaEttZHIxQ3Fma2dFSFdu?=
 =?utf-8?B?UUluNkhzU01BSUoxbTdhdTh4WlZ1UkpVZ3FaVDFYUzFFTVdIcW0vMWI1c21L?=
 =?utf-8?B?bWM1dDltWjhrU3RSYTcvcTloem1hUTlQNTR6ZklHRzNPeHBTU0FVdTUxK05y?=
 =?utf-8?B?bURreURBTEdzdm53UGNXdFdkaTRONmhRYVRjYjJKVkVydmpDaWpzTEZXVmh2?=
 =?utf-8?B?SVZIdlRWNGhPSlJ5dXF4SUEwalJnUUk5VzFwNVJqaXgraEI2bDFUZmlaNXRY?=
 =?utf-8?B?ZmE1NTQyNVJ6aStNTHdxVGljSnhJVTdmaDAwbEVQTlR2a3h6Wm5LYWxLUGVH?=
 =?utf-8?B?VGlzeGY0Q3F3UWdFK05FODM0NjlISFo3UkFzazVML3NQZmU0d2Q3dkJNdURH?=
 =?utf-8?B?K3pvazdaMUNzVkZ0bW1CbW1DK080TzZYSWRmZFA3WUpEV1kwNjRvdEZpZHpJ?=
 =?utf-8?B?ZVNKRXJ1VHVta0dsSW9mTk9HNXViWlJoZUFtRnptUWZFUFRKUUN0SFhiV2g3?=
 =?utf-8?B?eURaU2pOY1MyOXFkbzVYTTdGUldpVjBycCtiekJIVWhPKytRMnNnTitJS0Zl?=
 =?utf-8?B?dTlycVNTTG5YNEJhT1owRGNVNzQreGo3S2hDWlNkSTdVbHQrWk8zQThSbEsv?=
 =?utf-8?B?VTdKNER1VWpNSDFPQ2oyVW56NzhJamd5UzNObnl3WjFtSHJ6enAvZEVOdnpx?=
 =?utf-8?B?Y3ZQSmVQMTRNUGFacmFiekNwYmZieElJUjVQU1JUT0xXWTE2bVBFTWF4alJi?=
 =?utf-8?Q?qNB5l/b5rqeqLPd4CQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjdFT1c3WkM4TWIzZWo0UmJSdVc5dldOb0ZOUGZ3cjExSG83c2k3Vk8xRHNK?=
 =?utf-8?B?TGRxYUpJZytVYTg1aUtVVTBkNUVrTUJLMTJKNVVVZXUra2FLL0VHMG0yZ0ZW?=
 =?utf-8?B?THJpUXdvRkVGUENKYXczZ1d1bWxEekMxeGF6VThKU1E5VEgwTGZtenk1Um9Z?=
 =?utf-8?B?M1pwSytDSkEzbm9UQ0ZTWjE4RzhWSnIwNWFpR1FzY09hQ2t0YkxvMmdMdjZ4?=
 =?utf-8?B?Y1Bsb0tudlIrQXp5SUVDQndVb2FVWUdVVEY5VWlZR3Y2Rk1odW1zbmUwdjZx?=
 =?utf-8?B?T2NabElXYTR5eHI3ZUx6OEozelY5TGhOZG1INlBxVVYxNlMvaHpDNmZlc3gv?=
 =?utf-8?B?d1p1Tm5zdThkL3pGMjVKQTlSQ09GVmE5cE9jdm9FSktERElmNkpSVTlrd0s3?=
 =?utf-8?B?VjFlTlRzMTRNWjJYZjZ3VnVSWlJWWFNBakdselJSOTM3SXpteFlPcDFmNjVU?=
 =?utf-8?B?Z3cyTXBPZnhkTXNYVEhkT1RuZjBVek1LdjBweFlyd1BSSTNPQW1hNkY5czEr?=
 =?utf-8?B?MjZvZDJ3U25ySmZnaXZOTnpjczk0cDJDZW1zMXNVQlJVUVlOUUlCT2R2RkJz?=
 =?utf-8?B?YTZCZURaVmZsZ0lOZ1ZQalozR0FRLy9IK2tJMGgzblk1ekNTS3Z3eGV6dDFl?=
 =?utf-8?B?NmpvU3J4a2NPVlJmTXlZK1R6bzF3WnZtU291ZVl3ck0rcHRSNlEzQXkvMkV5?=
 =?utf-8?B?eEd2eHlBdTVaWjdLblI0N2F1T3A3Y2ErMXdSMDlBbG5GWDRkUmxSa2U2SE9M?=
 =?utf-8?B?dExTOHJNcldXcDV5LzBHTUtkcCswRUpZRlR2bStlZjZiMFhSTHB0dzhCTjdK?=
 =?utf-8?B?UVk5Rm1IeHpLV3JWRjN4eG1xNTF6Q1R0blNDMnVKcmlOMTREajV3b3FMODls?=
 =?utf-8?B?TUlQQ3FKTVQ0Z09SRlN1VjBIZVRXOSt4aEhpaDJXbE8rUzA2dTZjZ01pdVFV?=
 =?utf-8?B?cGFCd2hiKzFyVFRaNm4yb0R3T2xyclhOSmdOZndzZUNXR3FRMU1zOFlib3lh?=
 =?utf-8?B?TXN5OGhBN1BDanJkTzcybkVqMmNYaUdkTUppNGlrVkttNzNJRzVCaVdXcmNw?=
 =?utf-8?B?K3VFc3ZkV29CNWh5dHE3Z08vNnhyZ3M4T1lhdDdtOTBHaUNXWXdxdlNoU042?=
 =?utf-8?B?WFJiUks4b3U0T0VNZG9UTnlxZEptK01DTmZJeEwzOE9xUTdTTEYrZTBMVjVm?=
 =?utf-8?B?RnIrZEtRY0JCcE9LcFE0WGlDQ2lDMmJqbjg2YmcwaXo1MVlsMFBtUkdzN2p0?=
 =?utf-8?B?RUF2c05ZL2ZqZC9TS1FCSTVKQ1YrQnBxaDF6Q2hsUkR0ajh4UllCYURrZVVu?=
 =?utf-8?B?ZkRZMUtmUG5iaktwb3V6ZDdzOXladUVwV1RnYk05Nm5qRndqUkN5eE85UkNL?=
 =?utf-8?B?NkFmTXpjb1o4TWhad2trc1UranJYSGJSMzB3cmhsN1hNSklTMS9ZMjhsQnBS?=
 =?utf-8?B?NnF4UW5FRm41OUVTMGtkUUcxblg0N1l5Y2NUeW5TS0RKUER0NmxWYkd5MnVI?=
 =?utf-8?B?aVQyUWNQdExRdVlXa2hNRXdsY3owQVFNRTlJSG5vb2Qwei9HVmMwc0d0SXl0?=
 =?utf-8?B?SlBtT3lwa0hJamJnZW4zQkl6dXMwUDhqaTNZMFdOVVY1NEdVOGFYeWI2My9i?=
 =?utf-8?B?VEpiS0huNmJoK3NMcnZGZnFEQmNYZGd4MXV3N1cvcGpUbk9VSjN2ZEhIZ3B0?=
 =?utf-8?B?OGJQaGxzWW9HWkhnTmZKZDZoZGZkcGFwMFpXV1pkK29xNmlsUE9jTFZRZW9L?=
 =?utf-8?B?YmZaSWRsbzZqclBtS0ZTRVBoS25PclRoZ1g0Vnh0K243ZXphM3ZJM3NJTkRZ?=
 =?utf-8?B?Y05JVk13d2hRSDJXUUpzVXRab1ZWWXNOZGtBa3RPSFJoYzNzM1JTbS8wa09v?=
 =?utf-8?B?dyt3cFA5U3hUc1lZUE1jNElLcVA1a3FmUGI3bXI4ZlZOUkc2emhiaTZ1YjVS?=
 =?utf-8?B?ZE5jRjdLcUpyMmtDcFRMVzBrSHlnNDBrQnNISXVsRzZsd2hPYlZnb0QxTlNV?=
 =?utf-8?B?RXNySm03bE0xaE9UcUc3YVpPaFd4UXNmSmdMYmpMSnQ4VTM4bzZtK2JBeDJn?=
 =?utf-8?B?dHYxVDNlVHVoV1krR1BYN3EzK3pvNnFlelNldWErSkQ2UkVOOVhNTEJ3Y1d2?=
 =?utf-8?Q?RUuw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72f141b-dd59-4100-cc9e-08dcc153507d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 20:04:35.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBvJTI6ech9qbVWh6D82Uu3SgQoFSyus/aSPkrtrX/OgzXnjXa5jNmralpqYEjxD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336

Hi Reinette,

On 8/20/24 13:12, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/19/24 11:18 AM, Moger, Babu wrote:
>> On 8/16/24 17:33, Reinette Chatre wrote:
>>> On 8/6/24 3:00 PM, Babu Moger wrote:
> 
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 66febff2a3d3..d15fd1bde5f4 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -2756,6 +2756,23 @@ void resctrl_arch_mbm_cntr_assign_disable(void)
>>>>        }
>>>>    }
>>>>    +void resctrl_arch_mbm_cntr_assign_configure(void)
>>>> +{
>>>> +    struct rdt_resource *r =
>>>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>>>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>>> +    bool enable = true;
>>>> +
>>>> +    mutex_lock(&rdtgroup_mutex);
>>>> +
>>>> +    if (r->mon.mbm_cntr_assignable) {
>>>> +        if (!hw_res->mbm_cntr_assign_enabled)
>>>> +            hw_res->mbm_cntr_assign_enabled = true;
>>>> +        resctrl_abmc_set_one_amd(&enable);
>>>
>>> Earlier changelogs mentioned that counters are reset when ABMC is enabled.
>>> How does that behave here when one CPU comes online? Consider the scenario
>>> where
>>> a system is booted without all CPUs online. ABMC is initially enabled on
>>> all online
>>> CPUs with this flow ... user space could start using resctrl fs and create
>>> monitor groups that start accumulating architectural state. If the
>>> remaining
>>> CPUs come online at this point and this snippet enables ABMC, would it
>>> reset
>>> all counters? Should the architectural state be cleared?
>>
>> When new cpu comes online, it should inherit the abmc state which is set
>> already. it should not force it either way. In that case, it is not
>> required to reset the architectural state.
>>
>> Responded to your earlier comment.
>> https://lore.kernel.org/lkml/0256b457-175d-4923-aa49-00e8e52b865b@amd.com/
>>
>>
>>>
>>> Also, it still does not look right that the architecture decides the
>>> policy.
>>> Could this enabling be moved to resctrl_online_cpu() for resctrl fs to
>>> request architecture to enable assignable counters if it is supported?
>>
>> Sure. Will move the resctrl_arch_mbm_cntr_assign_configure() here with
>> changes just to update the abmc state which is set during the init.
>>
> 
> I do not think we are seeing it the same way. In your earlier comment you
> mention:
> 
>> We need to set abmc state to "enabled" during the init when abmc is
>> detected.  resctrl_late_init -> .. -> rdt_get_mon_l3_config
>>
>> This only happens once during the init.
> 
> 
> I do not think that the ABMC state can be set during init since that runs
> before the fs code and thus the arch code cannot be aware of the fs policy
> that "mbm_assign_mode" is the default. This may become clear when you move
> resctrl_arch_mbm_cntr_assign_configure() to resctrl_online_cpu() though
> since I expect that the r->mon.mbm_cntr_assignable check will move
> into the fs resctrl_online_cpu() that will call the arch helper to
> set the state to enabled.

There are couple of problems here.

1. Hotplug with ABMC enabled.

  System is running with ABMC enabled. Now, new cpu cames online.
  The function resctrl_arch_mbm_cntr_assign_configure() will set the MSR
MSR_IA32_L3_QOS_EXT_CFG to enable ABMC on the new CPU. This scenario works
fine.


2. Hotplug with ABMC disabled.
  Current code will force the system to enable ABMC on the new CPU.
  That is not correct.


We need to address both these cases.


I was thinking of separating the functionality in
resctrl_arch_mbm_cntr_assign_configure() into two.

a. Just set the mbm_cntr_assign_enabled to true during the init.
   if (r->mon.mbm_cntr_assignable)
       hw_res->mbm_cntr_assign_enabled = true;

   This is similar to rdtgroup_setup_default().  Isn't it?


b. Change the functionality in resctrl_arch_mbm_cntr_assign_configure()
   to update the MSR MSR_IA32_L3_QOS_EXT_CFG based on
hw_res->mbm_cntr_assign_enabled.  Something like this.


   void resctrl_arch_mbm_cntr_assign_configure(void)
{
    ---
    if (r->mon.mbm_cntr_assignable &&  hw_res->mbm_cntr_assign_enabled)
            abmc_set_one_amd(&enable);
   ---
}


Yes.  The function resctrl_arch_mbm_cntr_assign_configure() will be called
from resctrl_online_cpu().

Does it make sense?  Any other idea?
-- 
Thanks
Babu Moger

