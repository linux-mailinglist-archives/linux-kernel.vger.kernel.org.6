Return-Path: <linux-kernel+bounces-368461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E30D9A1004
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BDAB24ABC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB2E20C03A;
	Wed, 16 Oct 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g3decX5o"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424D15B987;
	Wed, 16 Oct 2024 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097192; cv=fail; b=pTkC9qu0mRZNrBZhI1MPN62p9s3bg+R10oMPhEXYM7SiZbuAT1+ldndXPbEKFpISNT7zpoyLm8kVEhfU7fzlIrvC1WiLWuTtK9RIV9/6D2bexLQB+YC4kDm+ODxwi4kS1+qmyqwn+qgiwEeUVllXPpJ2pZpx0is2nLj/ggsD6nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097192; c=relaxed/simple;
	bh=eUPnCvHFNhONzsjT3i0+17hXh03QLzA2gf7d4/EFjVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ELjSamAS7XiV6a3UIoTEHkmRvwH0EVj64spXtson5haUNJ9futVsRolcODpeqv1AXOgzbn5fa2szyESWflmLdNhbR9T6L2G99cvWlMlabCqhdhAdJJbUQifGAE6sKIflZbfK/ru5EHJl4Accg3WI9am70Shxp72eBeB+V+QvYtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g3decX5o; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivZJI0ZSt0MGeOHkwZnm0Tln5NAlM+BtphGVblc88xY4SMOR8Wh5ZYnlv0X8plCvWAhSEYP7P4xvDTBrmn34dCZCkMwxz5B3rAWimp5hoKNi0EtstTuZ3aeNOOMhV/rOTWe45A1Y87Tq5WMdfONaenUyjqnMXQAtvUvo1iADwR6cZmd2yg1f+9uNXJiZMFdmHG0Mz0ZHIXbqINdzWRm5gCKN6Y26IpF9QqHab0PmnILTHUhtX2DTSSR/C4FspOsrRWLGTOX7YOQ384C6xo36s/SN7b7rgu74cq05lXC3zrjjdi65+JwPxKks3X81J19DMRAUcFAeSiW2V6GV6Usz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNFERzO+zCOOGI4Jyf4a1c9QSfQfOMQ2fuIsQIYXvik=;
 b=qlZNG9POwapL79U4TtWG/uVnFfBve9TlxlXJ8/Af6yyjt9B6Q2lHFXLIUdsNH+5aRTSi7gZ+taZCpm3Abr3e83i0Wo15iTCdxWaM/hJo0bsVbn21vL5wkQZ1FKvav/csDuZqWFI4W+z3fenvmHZ8JuYmJ8Bcq9BRsiKnQv9VCVQGg8qPu2f2gt6FFT5Jh5yk2rEyL2MrApJxUsEsq5iYarMwiSRwwv/mFKZimQVre7PKenEMSjvMDKxzt7ddYPb3P99gs2CLFU1ohHAOSEa6ronAZqxK0elAQ/LIMH/EDmE3hHy3ZdODb4AojDDClWM7l7w5a4k0+2tBMBu13669pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNFERzO+zCOOGI4Jyf4a1c9QSfQfOMQ2fuIsQIYXvik=;
 b=g3decX5oyH1e5Fa7ZQ+5Q8JQsJr2dy6+RMZrdO8L4swsLXWd+Suow6mY/rABXPvch+8M8+LyxhT/Wm6k5ScuCx2Nu6x+b3hpIo5wKAhP+7FFfzTUGrgRj1DVNBKM8MltQpIyZVfT28e+9SmVtKt2R2NZ1ThgEIOBBUrGc4NfzzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 16:46:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.029; Wed, 16 Oct 2024
 16:46:27 +0000
Message-ID: <08dbb3e1-ab5c-41e1-978c-9c8885ffbe20@amd.com>
Date: Wed, 16 Oct 2024 11:46:23 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 3/7] x86/resctrl: Introduce sdciae_capable in rdt_resource
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: fenghua.yu@intel.com, hpa@zytor.com, paulmck@kernel.org,
 thuth@redhat.com, xiongwei.song@windriver.com, ardb@kernel.org,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 sandipan.das@amd.com, kai.huang@intel.com, peterz@infradead.org,
 kan.liang@linux.intel.com, pbonzini@redhat.com, xin3.li@intel.com,
 ebiggers@google.com, alexandre.chartre@oracle.com, perry.yuan@amd.com,
 tan.shaopeng@fujitsu.com, james.morse@arm.com, tony.luck@intel.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1723824984.git.babu.moger@amd.com>
 <cf9e47bbd66dbbdb76f0124620fad2f1b06e977e.1723824984.git.babu.moger@amd.com>
 <254da029-81b2-4745-bc78-5aefeb33adb0@intel.com>
 <b96e5de8-75ce-4a7a-8788-f5d3a959d771@amd.com>
 <89da43fd-69fb-48a6-830e-e157360aeab6@amd.com>
 <dbe8a012-eb21-426f-a8e4-46efee26da62@intel.com>
 <bf67bc4e-9cf8-4cac-9ffb-2d4f81ab7e30@amd.com>
 <ca29046a-29db-4bb0-815a-c482385194c7@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ca29046a-29db-4bb0-815a-c482385194c7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0065.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 30520f71-25ee-4428-13c4-08dcee0213d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkRZcGlpd0JjMDdHbGRiSTZ4ZUMreFRaVEdwMFdmNkF2Y3U2UWFHaklHUERB?=
 =?utf-8?B?dGM4UkdQYUZnN214NTlJc3R4MXB1endTUS8yUkJSdnhYbEFITnhXVFpFUFpv?=
 =?utf-8?B?UFRidUd5L1pGKytwcFV0RDdnVUlOZG11U1B1NXVweWRFN241RkZaSEx2dkNm?=
 =?utf-8?B?SzFUT2I4cUJGaEdBV1ZjR2QyZ0lDVzRaUnU3WjROT0RKNGJFeGpsMVVWaXVs?=
 =?utf-8?B?b3Q0VE9BQjZmN2gxRXVwZFhXQ0t2cEpDdjg3RUg1Uyt1dndOaWhjNWpac2lQ?=
 =?utf-8?B?bVczelE3OW4wSEdVZndQc3ZrdnNRc1cyTGd2bFpFcENFR3NTWEVMSEhCR0Fk?=
 =?utf-8?B?bkJzQ2NBU2RIYnFEMng3VVd5SWxVMDF6STZrckcrYjRRS2hNM1h4cW1TYUpw?=
 =?utf-8?B?TEo3TitpelNxb3ZCWnR2QjQ0dDhhYlgySExER3pCdVViT2hWc05kbFhTMXRh?=
 =?utf-8?B?ME5pWGk1YXJzZmk2S2Vla2c1R2hXYXhDY1I4QTRiaVRXWTlhaCtnZmJaUlFp?=
 =?utf-8?B?Mmc5MTU4UTRzTEdnTEtFSXBoYjd3VFV0Qm81d0NmOUxSUkVrSm15TWdTNDBJ?=
 =?utf-8?B?a1hXN0JSZ0s5MkxVWUpyeWZYNzlzYjBBMzZ5VTZ1VVV3bHl3SkptbVFJVXFC?=
 =?utf-8?B?a21rODVNcXl1WmpOZkZTRzBaSlNOR29HOEpFcGZKUHhEbGtpVUhCRkc5MnNh?=
 =?utf-8?B?SFlLdVpUY3duZk9yczBBNkx3VksycVNKVGhZbzR6YzQxZVF0emYwNHpYRG1T?=
 =?utf-8?B?dnpxL3l4ajR3YzF4bDB3L3pqUk1hWUlXckFNc0JNVndXY2pZdERGZm5GMnp4?=
 =?utf-8?B?RmR4WmpVUHF6NnFXa2tDRjBiYVZRdFVvSU5rY1JKdkF2RzlOejVxMUhkc1Zq?=
 =?utf-8?B?Q3FlK2hlVzQrdXdRbWpCL3hRRFoyc1J0R3RpRCtvNzBEM0E3aUFaYXdoVyty?=
 =?utf-8?B?ZFU1UlJwMXdGRGlMdEZzY1htUG9GZThBaU1USVdZMFk5RVhpUkJlQ0tOYVRv?=
 =?utf-8?B?Wkw4YzlXTXp6R0l6OGZHVVIwUk43QStKTjVSVVlwZ3JVd1BTMjZFYUczWC9v?=
 =?utf-8?B?dVc1dTZUVHhUeWRZbE5zUngyZ0ZwZyticjRoZmppR3N6WkhuSkRtNXp2UkNY?=
 =?utf-8?B?T3o1Zis5Z0FGR0I1SG9mWlJGQndNVGdiWFJBNklJMng0UWI2VWFhQjV2Ykxj?=
 =?utf-8?B?clZpOUpZTys4amVndHJGOWxSbzA5cmVXUXBtM0FaVUpOd1VObjE2eHVtQkJU?=
 =?utf-8?B?ZHJQK29MN0ZlaVlabUJMd1ZMTTNmbzZDMTMrQUw5S2FBYk5NN3c2VEtNc0xH?=
 =?utf-8?B?aXBOMGZkYkVlR3lPT0I2YjlxSXY0MXVJNW1Ua3loRUEyQTFnOGREVnBRcVdy?=
 =?utf-8?B?aEdidkMwRmJXL0ZlRmNGOHI5QWR2U0F4MTFJT05qL0lpaGNnM3hqRkZtY3pj?=
 =?utf-8?B?MTBzVzREU1NZd1Y0NjA5QWlQYWtOMFUrZ0dXUGluWFBYK0tsVkNjdFdBQWk3?=
 =?utf-8?B?YllYcjZPaXFkYzdvNEtUZ21Kdlg0MWNhY25VYW9nTGZNRUxrbEZLY0E2amdH?=
 =?utf-8?B?cCtEakNyU1lSTTdLTWlGVi93K3pIMUw1NjgwNGNXRThWZi9rZ0kwMmVmZ1Vk?=
 =?utf-8?B?cUppdGhnRGpIc201YXNWTmE3MDIwUWROOHRwalVGMkFhdzNTbUh3Tzh5OGZI?=
 =?utf-8?B?aTltM3NFMlZpOEplWUFWbXNpT3Q3MmZmUzBYUEZOVm1nRFE1aWpJcC9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUZpc3lxalBnQ2NmakdMKzZtT1Z6R2JwWVZ5RWh0ODNMcGJEK016YWJnTnNv?=
 =?utf-8?B?clBEamJseXBxaXh2amhiVFUvRFhCQ1FwQ1NCSzNJS25TRkxvTmdzaXVaSXpT?=
 =?utf-8?B?U09BQVozdlRrR2lTVnVEc1NYREFIVWt0WkZsc1VZN3dyazd0cGpuSnFzbHZs?=
 =?utf-8?B?ZkpmbFRLYVRQWkJHUFN2YzN0b0pOWTV3UUxhYlNhU0ZhOXRjM1RvUjhRaStz?=
 =?utf-8?B?YWFucXdRakhiaEc5eWVOU1lDaXU2YUdGNW1VNGNGaVJjZmxKYmh1elNGZkd1?=
 =?utf-8?B?RGNMOXpnR3FzczF0S0F2TDdhODFZdlp5S1NCUnFUWDJ2alpwTkU4elh4K0Zi?=
 =?utf-8?B?N2wxNmJVNVpkajNVbjBnUkxoQm4rdTBxc2NMVzkzdFZCeEowck5ybVpUY3ly?=
 =?utf-8?B?Q3VFUU9CNzJLb0xRV0hjSFBlMEJzbFMvSElmOGZvemlSSFVIVFNRQ2ZlNXFM?=
 =?utf-8?B?dUFnUkZ0VFJvM2V5OTdFM2FnMVFuaGdzSEpDU1VuSU0xNmRCcmYzOGliT3B1?=
 =?utf-8?B?MG1LblNOTDczZ3dVT25RZ2JzU0hhZVFmSGFsMnZQUWRGY04wMWRXSDNCNitr?=
 =?utf-8?B?SzIvbFJaS00vU25NRGR4UWp4a2pFNWdNUWt3UnVncUhXcXh3RStmc0xtWk0z?=
 =?utf-8?B?VnlRRzNoTXloMER3ZTJ5OUZWZlNqbFM3cFZ5N1ZKcDRBTVNkdzNDUVdWTDgv?=
 =?utf-8?B?bHAwUml0SlZ4dUFEamo1akZFRFhzeU1uQ3J2bDdFVjlvNzlVMk9UczdLaUMr?=
 =?utf-8?B?ZzFZY2pqMnVnVUQvYkJVMXpkNFZhalo4Y2hpQ01vZm9FUVZvbkNRcTZ0bkF4?=
 =?utf-8?B?SGR2NWNtRFVtY2t5WXlnKzE1WHdBVkd0OTg2YVlrOEZWM3I4cVJleVpKVm85?=
 =?utf-8?B?ZXFjS05oWmQ0U2x0S2FwMDBRZnB5MXNjQVlBdXlNazc1aktSZDYzQ3FLOXkv?=
 =?utf-8?B?VWlWKzhKM0ZGSXhKM3ErWWdYU0pZb1JmcmxXVlBMaElwK2RDbGc3bUFmVHNJ?=
 =?utf-8?B?RXVYZ2RTVk45dTV0dzBBNS9iVWhtWnpMVXpBQ1RCT0phU3lWWVo4K0lBRDlC?=
 =?utf-8?B?ZGt1NTgyMjM0M0pHSVlxMkJpUzVMTDg5WUwwRy9Sakgwc3piUlUxQ2pGY0Iv?=
 =?utf-8?B?bzJVWmdxeDFVSGl1Njl6cGJvcEVYSnlKN3ZUT3dLR1lKdkJ1S0pjakxuYWtx?=
 =?utf-8?B?b1l0cHQwcWtzYU9SdVlyWXdFSG5BT1licTY2VmhRbEx5RjdBM3pYODBoTXhn?=
 =?utf-8?B?dXR6alNyMW40YktpL0N6a0ZkSlRWRWpCMTR5Ty9RNmVjTWNORjlWRXJrb1RY?=
 =?utf-8?B?cUpvRVVGZVo2TzdsaDVsUWZCcVNJcjRnbllCcjc5eDFuaHFuZUttZXMxYzlC?=
 =?utf-8?B?dmFvZ1oxZUdpK2g2MjByOFZlM2VHVEJnendKVU5lRHAwSVZFRFJxOFh4aHVI?=
 =?utf-8?B?TmxWYWx0SmhGUnJYV2l4RGszMFFGNWxKd29uWDBRYmF1TFZNU2I1U0o4RUdF?=
 =?utf-8?B?VlFzRElUc0Q2Y1I4Wjk2THo3MkNSdlI4QWpqb3MzK2dkNldmM3Bzb25SUGVS?=
 =?utf-8?B?YjJWclZ2ZDV1ZVMrM24zbXhZbkJPclhocDhKcDlSUlJRQ3AyOTRoWDRrL1NS?=
 =?utf-8?B?cW1TaFlnNEoya1VJZlQ1U2NFcThua3VCK2pMYmJFazJlYUtTd21oWDZxdkZP?=
 =?utf-8?B?b3MvRktqcFdSWnVndUtSQXJ2ZmhBTkErU2RQa0xMcnpSL1BsS2syTFloKytz?=
 =?utf-8?B?SGs3SUZ0VFM2Rjd3U1pyd09YU2xudGdhRWlqekxRSGZpU1JlSjgyazFWQ0hR?=
 =?utf-8?B?NnlZMlNlekhiYWhlazRjYWUrcTZXUXNWUjE5SkUyT2kzTXozRHJZTmlzTnRM?=
 =?utf-8?B?cTZ2TEpEYTBUalV5ZWlid0dzeUNsN0s4OGUwenptYS9WVk9MMWx1Q1JRb1dR?=
 =?utf-8?B?bFpEanYvcjNTL08xQ3RsZVU3VU1UejVaL29nY1A1MXFXczVOa0RKMDBaOUZx?=
 =?utf-8?B?YWZhejc2bnRoWlRwSWhnYlZFR1EzcEpvbGZKcVdxZUp3dGxvQjFMZ3ZiMkV1?=
 =?utf-8?B?eEZ5UnhsQVpXK3kvaTAxRlpJR0xhalBhd0xteWg0dmpuQ3R0ODAwcERGcERJ?=
 =?utf-8?Q?maeE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30520f71-25ee-4428-13c4-08dcee0213d6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:46:27.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjfpN/zX5kFh+NrA1ciprQome6dd3gReIqDEqz4WRCGjmy/ywMYnVyxRAqtpG6DG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

Hi Reinette,

On 10/16/24 10:54, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/15/24 1:40 PM, Moger, Babu wrote:
>> On 9/19/24 10:33, Reinette Chatre wrote:
>>> On 9/18/24 11:22 AM, Moger, Babu wrote:
>>>> On 9/18/24 10:27, Moger, Babu wrote:
>>>>> On 9/13/24 15:45, Reinette Chatre wrote:
>>>>>> On 8/16/24 9:16 AM, Babu Moger wrote:
>>>>>>> Detect SDCIAE`(L3 Smart Data Cache Injection Allocation Enforcement)
>>>>>>
>>>>>> (stray ` char)
>>>>>
>>>>> Sure.
>>>>>
>>>>>>
>>>>>>> feature and initialize sdciae_capable.
>>>>>>
>>>>>> (This is a repeat of the discussion we had surrounding the ABMC feature.)
>>>>>>
>>>>>> By adding "sdciae_capable" to struct rdt_resource the "sdciae" feature
>>>>>> becomes a resctrl fs feature. Any other architecture that has a "similar
>>>>>> but perhaps not identical feature to AMD's SDCIAE" will be forced to also
>>>>>> call it "sdciae" ... sdciae seems like a marketing name to me and resctrl
>>>>>> needs something generic that could later be built on (if needed) by other
>>>>>> architectures.
>>>>>
>>>>> How about "cache_inject_capable" ?
>>>>>
>>>>> This seems generic. I will change the description also.
>>>>>
>>>>
>>>> Basically, this feature reserves specific CLOS for SDCI cache.
>>>>
>>>> We can also name "clos_reserve_capable".
>>>
>>> Naming is always complicated. I think we should try to stay away from
>>> "clos" in a generic name since that creates problem when trying to
>>> apply it to Arm and is very specific to how AMD implements this
>>> feature. "cache_inject_capable" does sound much better to me ...
>>> it also looks like this may be more appropriate as a property
>>> of struct resctrl_cache?
>>
>> Coming back to this again, I feel 'cache_inject_capable' is kind of very
>> generic. Cache injection term is used very generically everywhere.
>>
>> Does  'cache_reserve_capable" sound good ?  This is inside the resctrl
>> subsystem. We know what it is referring to.
>>
> 
> Since this is inside resctrl "cache_reserve_capable" sounds like existing
> CAT to me. Could it help if the term "io" appears in the name? Something like
> "io_reserve_capable"? When this is a member of struct resctrl_cache it should
> be implicit that it refers to the cache.

Yea. Naming is difficult.

How about "io_alloc_capable"?

-- 
Thanks
Babu Moger

