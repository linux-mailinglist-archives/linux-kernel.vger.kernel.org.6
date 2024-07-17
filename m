Return-Path: <linux-kernel+bounces-255346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04CC933F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E1E1F245F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332CF181BA5;
	Wed, 17 Jul 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3TZpmeZ9"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE7918132E;
	Wed, 17 Jul 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229776; cv=fail; b=uNP4TwXkMGg5Pn/1r2BpHJanFclNQzQ08q5yOM7xNtwjpyvzki0MMjT+uAQ7e7cQiX/j5mgaZyGmyhcxYNHkNkSfWOKVIFhwf6Rqsgh+bhtvis79gordfujgSORURTqDNYVfwIJ+fhSkOgFFQ/n328c3DYDKHsZ9xIYq5ukOIg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229776; c=relaxed/simple;
	bh=hITbIaHVOSrunMhTNGXQeVSt9xGzWm1kMeQ4ymLo+GA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qphb1OJWt5iuM7cD3A7QP3aT5CAorip6rigKcHttxnF0NgvoxwqbiaEYDKdhtpSy6GkwI4EYgBZOone1c6j/lE+7Fo4uKd4cPa7uYAgFIQjNjTKL34p+jdWA3GP4B+BOiGd3q0Qlq+RbMZzSsUwL0IbMN6i9xT9V5UG0makHSW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3TZpmeZ9; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQ8cPjUtT+6VK2OZ8OSIIPZYTPyLMPx+F0ll2hxH/J2xKQlgSwp77i9QGVYpNAzVIWhwIFM/877Wkz57KFXlPSi5FZsB7smp1lWYTHXND8leY54VvQtXbXG9s7ad3cgNeiwNEMaGgfXexadBIUZsSIQNPIadZFS+TGTmynxnrdLsGHc4pFqP4OmTHuFaa0rVsN0lt1mcnEnekTBIRRQ1zhl8EV74iXRv9ZIOZzuBPlTSat8Px15spBTgOHlIBvf5xzm6kLqccw9isn9KCgVMK/kEFxMtcior16/IcnEwfI8Y4eSBij4FCtISxVbq17LJZhfh+OEEz7BrefSIylhiLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXBClHvh4E/stdR1MJ1PXXiAXbA1ijLbP74jIk/6mKU=;
 b=h0Yd/IVXZuHwbWCNkjAdjlgDNjpgs5zdMzAecyvi33vAvIpgPx4AGILmswKl7YaGdo0JRjOT5cJ7LSweZyTtsyVO/ERYRx0rADFHv+X9leJj+NNQnkUk+xvVSc1HFemicCU5EOt8udw7UPxjuezzweaSQ9qIxTMmP/UJAavBhPdmYhufvcCy4ZlkNF1AcpdstZAuQhsZMxDOlxLWLfJb8wpoeliWZWB2GS7ld+2DewiUSdlOiX2VR8y7zH4AiwGPDerzkV47LcKRbvv4G9EPc0RrhC5ztkEPtuiWSODn1MAZmVU/BdeZx+4iNNgrNPofXjmQFVGrVAqMMd/Jqs/VRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXBClHvh4E/stdR1MJ1PXXiAXbA1ijLbP74jIk/6mKU=;
 b=3TZpmeZ9M4Im6A84f1b22JSIrmNBdhf/Ed++ipyU1GhmIJomBY7GkDSKJZAEBPB73g+Ba3DTc73I0DKXbZc6uBOxfhTErNaVQlhYo843G+x1gN4r5ahlIMryYts34Y4dQszpENxFL+8THhdRp6MNR3G/eKSw5SrhlYx/rLmCl70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 15:22:50 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 15:22:50 +0000
Message-ID: <d7dd2585-9f39-4e66-b218-4815bf888a77@amd.com>
Date: Wed, 17 Jul 2024 10:22:46 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 19/20] x86/resctrl: Introduce interface to list monitor
 states of all the groups
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
References: <cover.1720043311.git.babu.moger@amd.com>
 <3be66db2dbbe2d231fd5afbe6c7f092278b5a903.1720043311.git.babu.moger@amd.com>
 <710a83af-ed88-412f-8f7e-33678a8ed197@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <710a83af-ed88-412f-8f7e-33678a8ed197@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::9) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c65d0f-4ba5-46d7-a35b-08dca6745225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjd5VDU3U1VEcG9EbWNDdkt4ZmF2M1JkTVRwT3o3anRaZU4vcEVBak45Qlhu?=
 =?utf-8?B?SVVzRnhWUXVXbjBtU1RBTHBYN2tEYm94dVlrOWpmdHQwM1pqTmlzWUJQTmVV?=
 =?utf-8?B?cDBuRmpydzVuS0g0Vm9xbWRISEk3TEJFNmdnNTRNaHQ3b2FiZWdBN2VZKzZa?=
 =?utf-8?B?SEppWjZFd0NzemdyN1dqdVd4clRKMjlhTmVBQUlvb2dSNGRDNU1NVkpCZ3NI?=
 =?utf-8?B?Y3lYT1g4V0hIMzh2SURSVDRVdGhOWEYvTGhXcVc1eUZnTmF6M2xWdWhFeUxa?=
 =?utf-8?B?QVo2MEZIUlUvd0VISlgwTXVtdFJRMUV2SXROWUk4UkZFZWx5RGkybndDcTky?=
 =?utf-8?B?aEQxdHdUTHlLTXVvS2dOY09NM3MrOFZ1MlVsOTEyN2E4akZDT2RqbHo1Q1Vp?=
 =?utf-8?B?d2ExbDBFTFA0VGZzR014d2lWSUZIN0NZbEZwRFFpNnZGaFl4aEVLRXQ3UE1q?=
 =?utf-8?B?d1U4NUxGYjl4RHpnWkdjVFNSTXg1dDlNaE5kb2kxem5haUROeGx0TkwyZUh4?=
 =?utf-8?B?bTE5d2orOU5lMkh0NU5EVGllZVVDQ0tmOHJabWxYSW9TSXdkTkVOTlFHQTJM?=
 =?utf-8?B?eTRIU29hRzRwTnhNaTE0UVBmdit4S3RKNDEzWGR6UURnUFkrL2ZKWDdwRjVS?=
 =?utf-8?B?UXY2YnVhL0Fheklsd0h6NWRSdXVyVGdqYXRhOGF1RmRuNjU3cEUzdHpSMUcv?=
 =?utf-8?B?d1BIa1JBMHd1L1JsSlA3akJudS9wV1FuNDVEZEliS0tVRDB6cjNFc09lK1Nx?=
 =?utf-8?B?NGM1YnM2Ny8rNkxzWWNFdi9QNTdaT2drbC8xaGkvZllyQVhBbUt5bFcxbkU2?=
 =?utf-8?B?cytuTU9mVU5DZm93U1RnV1k2N01Gb1lRZk12NHQzK2lJbnYveldSVVA0VU9T?=
 =?utf-8?B?RFdqbytYazRuMW95akZWMEFERU9lMnpwb2gyemxLdG1QOWUxZHBmRXNSR0Z6?=
 =?utf-8?B?YnlVWFZVMXFvanFGclRxeE13anpQZ0VRZ0wvcVVwYTRUbVpOekJONEI0a2xu?=
 =?utf-8?B?UzkzTG5sNzd6cnBoYS90UDVLUXE0N0NMYmhRWFR0Qi94OFFIR3dzYnBKNVB1?=
 =?utf-8?B?a3g3N3RLNDM2Z2ZBRzFEVFozdHN3V1lFOERidWJVR0VYaENVdDlmZGpSQVZs?=
 =?utf-8?B?Y0FvQlMrNnFidlV1d21BWGNCVDY5SXQ5QUFHMkFqQmdORW5ROWZSeE1sUVNW?=
 =?utf-8?B?b1Bzc0ZpVHdRcXk1V0ZHdjNtOW5oSEhlV2RDNmw4RHJvbm1JQXhGYXdadUg4?=
 =?utf-8?B?eDZEd0ErdzlKT2huR0Z3RmNzWURBRVFEc1g3L2JxR1VTSVJZbmMrekJLdi9G?=
 =?utf-8?B?cVp2VWo1VGdXQi9YNnBoZVl0VENSOGdTWFBidDJ4RXgwaTh1a2dtWjRvdUpt?=
 =?utf-8?B?Rlp2eWhyVmxVUzgzSWk5RDMxR1MxZGdKcm9xMGpjZWZBSzNuZTRuWWFBMGts?=
 =?utf-8?B?S3F2aGlEZW92UnhhVG1ydUNXU3luKzJVb1NkSWVCMFkva2pRVHFNTGZrdmph?=
 =?utf-8?B?QXlUc0ZDdWhScGo5dzRIL1krL2RrMFV3R21RN2V5TlhGUlplN0lSTTVPZzdR?=
 =?utf-8?B?U2JHVXVweFE0cFZGK29Ka1k3bzhudzkydjQzWjlONE8yQXg4amFMWXJXSHIz?=
 =?utf-8?B?eTlzSTd5REd0Y2R2djM0STcrS0FLeTU4VzFRWkJ5RTlSUHd1dnR4ZWZIL2Zl?=
 =?utf-8?B?ZzJ5a3RiSFA1VHdQNUhWQkc0MzQ2WDE0UlBtUldOa095c0psdE1VT0Vya1lt?=
 =?utf-8?Q?+cF9lCSzE0EkzGVQ94=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE84b3BjMTdXV1YwRXNVbS80TVV6R1RYQ2IyY0d2a2FmRnpya0dzK0ozOFpU?=
 =?utf-8?B?bVV2UEZJWlJPYmVpREQ0Mk91akIzTUJGYlhkSmN4NkI3MFNWcHB6WVJzUHR5?=
 =?utf-8?B?WU1nMk1PYjRPaFB5SXZQTFlqSGNhak1hRU50M3JiZ2lFYzJiUFRHckNuK2xo?=
 =?utf-8?B?ZEdyRys4L2tmRHJwakVIUnpzdlFDVUFSMTJrY1pHR0E1aHg0RW1DWUk2NEZx?=
 =?utf-8?B?czVWS2ZzWE1DTVZML1FQdFhMN0VNN2dVR3FiU080T2xjS200U3pNMzJNcTZk?=
 =?utf-8?B?WUY4akV2R2s4SitzT1dJb2haMUYvVFYvNThiclgwUUhpU20wS2tEUVl5elE2?=
 =?utf-8?B?V2ZodXFmNHhGUllUKy9PeG9tK3pzUk9Rc3BPRUNQV3NLYXhqSTVnMUxlN2sr?=
 =?utf-8?B?Rm1ramNiWTFvaXBPMGxzWjIxWHYzclV6WlFhbGx5alJEbEFkUmsxejJRZUcv?=
 =?utf-8?B?L0FiNm91cUJNQ2F4QVU1YVFWdHRNTkZSMFJRQ3o2QTUxa3p3eGxRUlBtWW1t?=
 =?utf-8?B?R0JVKzVPVUplWHArUWtOTFovcjBkSXNqaVpGUG1yOWlrZEFLcmhkRUttS25T?=
 =?utf-8?B?TnhqRFYwdG5MNHhmUWVocnNnTWxlRTdZL3k5SjNkVXdQWU5lajhHVHZZaHND?=
 =?utf-8?B?QW1WQW1xRWhraDJscldJRkpWWUVSV0Jyc1RxdnluUjBKa09WQ05OUjB1d0Jv?=
 =?utf-8?B?UmtMdXVXS2FvTjlCREpFU0F4RUZOdVJHZjNwUzgzYU5HZEF3RTFnVFBaeDBa?=
 =?utf-8?B?MXA0cGd2dmVHRHVoN2dyT3dmdWhoSTBYK1FsWWtuZEFCclBBYmRsL2JZSnZx?=
 =?utf-8?B?Q2VmcmZ3ZnF5a1JobUNvTlV4enpmS3AwNlp4aFgrbnNUL0M5cTA2WDZDQ00v?=
 =?utf-8?B?VFFqb1JrSWNrcnJ3YXFtZ1ZMeElONGFNamtUVUpCdDBsSHo5Ykp2RnF4QllO?=
 =?utf-8?B?T1o4Umc1N0ZmZUFadGc0bWtLN1pTRzBWOWZXYmJ2SkZTQkFhbGJhMmUxRUc5?=
 =?utf-8?B?cFF6L2NsNlRvWFVIeGdyb3h5SU5ybjZvTFdoQjRRcU1iOXFvTytoQUJxb3hi?=
 =?utf-8?B?bitFSUNIQUQrajBmVUlTaDZHU1gySXBzbTNVcVZRRVRWNUJ5TVlwVC8wN2sy?=
 =?utf-8?B?Zm9pWFFleUd2bEFWV3dzdU9xVHE5aFlXZDJIZEgrZ1FOZHdLSmNFOUlzdkRk?=
 =?utf-8?B?ZmFzeExtOHFUSGNwUzZicWlZR1ZQK3NwbGJoaUVMYk5tRHMrM01DVjBWblZJ?=
 =?utf-8?B?UVJPRW5xTFRza3BoTElCZy93b3QrL3c4Y0wzN3RKc1R0MEZ4NDBVRHlQcDkw?=
 =?utf-8?B?Y3JFaWpyb3E2ZE03RjZCbjdVVkdtcW0vUXpEVTBJZEcvSG0xM0FQaVp4Qjgw?=
 =?utf-8?B?T2dQY2JzUXRBa01OMU43REtBL2dub0h0WjBYbXJjei9KWFZVVWlNSEdvWmVM?=
 =?utf-8?B?UWF0ZXJ0aW5qUFlWZ2pHczZndk5DUUtORG1majRnbkxibnQvaVl6OXl4amZj?=
 =?utf-8?B?VjZFYUU5b1F1QmJPRXNTcmgzZXM3YjVTVFBMcXNndEdISEpxbTd0U1pmdVpy?=
 =?utf-8?B?c29BQjhVM2xtMFFOQ0VxK3ZKSFU5eHZnY3Y2UXFYaGVYMFBROW4vL0R0anJE?=
 =?utf-8?B?QWxhVTdXSXFrbzU5MThrNEZsbHRxNFJMaEJYNDZkRjdIeWpveW1JbTg0ekxP?=
 =?utf-8?B?SnJkT25VS0UyZEdMRjFSTVFpNkhSR3ByYUFxcDhwY25iZHlkVzd1K1JOQkpO?=
 =?utf-8?B?UFJacDVYekJGUVJYRDVGRFh6cXF0NnQ0OW84WTVzaHlDUzFPNE5UU3RlRVNL?=
 =?utf-8?B?M044RmJ5T0k4VlJmUGNjb0xKelVGS0xrd0tPRUI0SGlHWklXQXMzOXd6N2My?=
 =?utf-8?B?TXRIK2ZZc2lKc0RETXRUcmYrMEoyY2ViVk5DQnd5YmlmZlBtUjRNMFNWK0k1?=
 =?utf-8?B?VEJuZFNxTnZUbmJZMkFoWU81aFR6Qit1ekZBYmFNRWx6RGlkVzNIa1ZNSHZG?=
 =?utf-8?B?VFBYZGNlbEw3Vkh1R1k0QXlnMW9CaUVCbEVUQmk4YWZLMWlhb3FqWWlnRWh5?=
 =?utf-8?B?TUk3dnlzcFZmRzgwREVwR0ZZWlFoR3c3bUhvQ2pIT3N6bnhKWEZySmN3c0ZX?=
 =?utf-8?Q?+Iig=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c65d0f-4ba5-46d7-a35b-08dca6745225
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 15:22:50.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8KOAFELQWvYIa1ESPWJHfGiHyPauFCvYmTTcIKjUELuFMAceMO2rEfMyDnUt/5p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

Hi Reinette,

On 7/12/24 17:16, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> Provide the interface to list the monitor states of all the resctrl
>> groups in ABMC mode.
>>
>> Example:
>> $cat /sys/fs/resctrl/info/L3_MON/mbm_control
>>
>> List follows the following format:
>>
>> "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>> Format for specific type of groups:
>>
>> - Default CTRL_MON group:
>>    "//<domain_id>=<flags>"
>>
>> - Non-default CTRL_MON group:
>>    "<CTRL_MON group>//<domain_id>=<flags>"
>>
>> - Child MON group of default CTRL_MON group:
>>    "/<MON group>/<domain_id>=<flags>"
>>
>> - Child MON group of non-default CTRL_MON group:
>>    "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>>
>>
>> Flags can be one of the following:
>> t  MBM total event is enabled
>> l  MBM local event is enabled
>> tl Both total and local MBM events are enabled
>> _  None of the MBM events are enabled
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v5: Replaced "assignment flags" with "flags".
>>      Changes related to mon structure.
>>      Changes related renaming the interface from mbm_assign_control to
>>      mbm_control.
>>
>> v4: Added functionality to query domain specific assigment in.
>>      rdtgroup_abmc_dom_state().
>>
>> v3: New patch.
>>      Addresses the feedback to provide the global assignment interface.
>>     
>> https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
>> ---
>>   Documentation/arch/x86/resctrl.rst     |  54 ++++++++++
>>   arch/x86/kernel/cpu/resctrl/monitor.c  |   1 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 130 +++++++++++++++++++++++++
>>   3 files changed, 185 insertions(+)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst
>> b/Documentation/arch/x86/resctrl.rst
>> index 4c41c5622627..05fee779e109 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -304,6 +304,60 @@ with the following files:
>>   "num_mbm_cntrs":
>>       The number of monitoring counters available for assignment.
>>   +"mbm_control":
>> +    Available when ABMC features are supported.
> 
> "Available when ABMC features are supported." can be dropped
> 

Ok. Sure.

>> +    Reports the resctrl group and monitor status of each group.
>> +
>> +    List follows the following format:
>> +        "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>> +
>> +    Format for specific type of grpups:
> 
> grpups -> groups

Sure.

> 
>> +
>> +    * Default CTRL_MON group:
>> +        "//<domain_id>=<flags>"
>> +
>> +    * Non-default CTRL_MON group:
>> +        "<CTRL_MON group>//<domain_id>=<flags>"
>> +
>> +    * Child MON group of default CTRL_MON group:
>> +        "/<MON group>/<domain_id>=<flags>"
>> +
>> +    * Child MON group of non-default CTRL_MON group:
>> +        "<CTRL_MON group>/<MON group>/<domain_id>=<flags>"
>> +
>> +    Flags can be one of the following:
>> +    ::
>> +
>> +     t  MBM total event is enabled.
>> +     l  MBM local event is enabled.
>> +     tl Both total and local MBM events are enabled.
>> +     _  None of the MBM events are enabled.
>> +
>> +    Examples:
>> +    ::
>> +
>> +     # mkdir /sys/fs/resctrl/mon_groups/child_default_mon_grp
>> +     # mkdir /sys/fs/resctrl/non_default_ctrl_mon_grp
>> +     # mkdir
>> /sys/fs/resctrl/non_default_ctrl_mon_grp/mon_groups/child_non_default_mon_grp
>> +
>> +     # cat /sys/fs/resctrl/info/L3_MON/mbm_control
>> +     non_default_ctrl_mon_grp//0=tl;1=tl;
>> +     non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>> +     //0=tl;1=tl;
>> +     /child_default_mon_grp/0=tl;1=tl;
>> +
>> +     There are four resctrl groups. All the groups have total and local
>> events are
>> +     enabled on domain 0 and 1.
> 
> "All the groups have total and local events are enabled" -> "All the
> groups have total and local events enabled"?
> 

Sure.

>> +
> 
> The text below seems to repeat ealier description.

I can remove it.

> 
>> +     non_default_ctrl_mon_grp// - This is a non-default CTRL_MON group.
>> +
>> +     non_default_ctrl_mon_grp/child_non_default_mon_grp/ - This is a
>> child monitor
>> +     group of non-default CTRL_MON group.
>> +
>> +     // - This is a default CTRL_MON group.
>> +
>> +     /child_default_mon_grp/ - This is a child monitor group of default
>> CTRL_MON group.
>> +
>>   "max_threshold_occupancy":
>>           Read/write file provides the largest value (in
>>           bytes) at which a previously used LLC_occupancy
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index b96b0a8bd7d3..684730f1a72d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1244,6 +1244,7 @@ int __init rdt_get_mon_l3_config(struct
>> rdt_resource *r)
>>                   r->mon.num_mbm_cntrs = 64;
>>                 resctrl_file_fflags_init("num_mbm_cntrs", RFTYPE_MON_INFO);
>> +            resctrl_file_fflags_init("mbm_control", RFTYPE_MON_INFO);
> 
> Shouldn't this file always be present?
> 

This is only relevent when monitor assign features are supported.
Having the file without the feature is not usefull.


>>           }
>>       }
>>   diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index d978668c8865..0de9f23d5389 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -944,6 +944,130 @@ static ssize_t rdtgroup_mbm_mode_write(struct
>> kernfs_open_file *of,
>>       return ret ?: nbytes;
>>   }
>>   +static void rdtgroup_abmc_dom_cfg(void *info)
>> +{
>> +    u64 *msrval = info;
>> +
>> +    wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, *msrval);
>> +    rdmsrl(MSR_IA32_L3_QOS_ABMC_DSC, *msrval);
>> +}
>> +
>> +/*
>> + * Writing the counter id with CfgEn=0 on L3_QOS_ABMC_CFG and reading
>> + * L3_QOS_ABMC_DSC back will return configuration of the counter
>> + * specified.
> 
> Can this be expanded to explain what the return values mean?

Sure. Basically returns the counter id with its configuration.

Will add few more details.

> 
>> + */
>> +static int rdtgroup_abmc_dom_state(struct rdt_mon_domain *d, u32 cntr_id,
>> +                   u32 rmid)
>> +{
>> +    union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +
>> +    abmc_cfg.split.cfg_en = 0;
>> +    abmc_cfg.split.cntr_id = cntr_id;
>> +
>> +    smp_call_function_any(&d->hdr.cpu_mask, rdtgroup_abmc_dom_cfg,
>> +                  &abmc_cfg, 1);
>> +
>> +    if (abmc_cfg.split.cntr_en && abmc_cfg.split.bw_src == rmid)
>> +        return 0;
>> +    else
>> +        return -1;
>> +}
>> +
>> +static char *rdtgroup_mon_state_to_str(struct rdtgroup *rdtgrp,
>> +                       struct rdt_mon_domain *d, char *str)
>> +{
>> +    char *tmp = str;
>> +    int dom_state = ASSIGN_NONE;
> 
> reverse fir

Sure.

> 
>> +
>> +    /*
>> +     * Query the monitor state for the domain.
>> +     * Index 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
>> +     * Index 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
> 
> Why not use the helper?

Yes.

> 
>> +     */
>> +    if (rdtgrp->mon.cntr_id[0] != MON_CNTR_UNSET)
>> +        if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[0],
>> rdtgrp->mon.rmid))
>> +            dom_state |= ASSIGN_TOTAL;
>> +
>> +    if (rdtgrp->mon.cntr_id[1] != MON_CNTR_UNSET)
>> +        if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[1],
>> rdtgrp->mon.rmid))
>> +            dom_state |= ASSIGN_LOCAL;
>> +
>> +    switch (dom_state) {
>> +    case ASSIGN_NONE:
>> +        *tmp++ = '_';
>> +        break;
>> +    case (ASSIGN_TOTAL | ASSIGN_LOCAL):
>> +        *tmp++ = 't';
>> +        *tmp++ = 'l';
>> +        break;
>> +    case ASSIGN_TOTAL:
>> +        *tmp++ = 't';
>> +        break;
>> +    case ASSIGN_LOCAL:
>> +        *tmp++ = 'l';
>> +        break;
>> +    default:
>> +        break;
>> +    }
> 
> This switch statement does not scale. Adding new flags will be painful.
> Can flags not
> just incrementally be printed as learned from hardware with "_" printed as
> last resort?
> This would elimininate need for these "ASSIGN" flags.

Let me try to understand this.

You want to remove switch statement.

if (rdtgrp->mon.cntr_id[0] != MON_CNTR_UNSET)
   if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[0], rdtgrp->mon.rmid))
    *tmp++ = 't';

if (rdtgrp->mon.cntr_id[1] != MON_CNTR_UNSET)
   if (!rdtgroup_abmc_dom_state(d, rdtgrp->mon.cntr_id[1], rdtgrp->mon.rmid))
   *tmp++ = 'l';

If none of these flags are available, then
   *tmp++ = '_';

Is that the idea?

> 
>> +
>> +    *tmp = '\0';
>> +    return str;
>> +}
>> +
>> +static int rdtgroup_mbm_control_show(struct kernfs_open_file *of,
>> +                     struct seq_file *s, void *v)
>> +{
>> +    struct rdt_resource *r = of->kn->parent->priv;
>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +    struct rdt_mon_domain *dom;
>> +    struct rdtgroup *rdtg;
>> +    int grp_default = 0;
>> +    char str[10];
>> +
>> +    if (!hw_res->abmc_enabled) {
>> +        rdt_last_cmd_puts("ABMC feature is not enabled\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    mutex_lock(&rdtgroup_mutex);
>> +
>> +    list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +        struct rdtgroup *crg;
>> +
>> +        if (rdtg == &rdtgroup_default) {
>> +            grp_default = 1;
>> +            seq_puts(s, "//");
>> +        } else {
>> +            grp_default = 0;
>> +            seq_printf(s, "%s//", rdtg->kn->name);
>> +        }
> 
> Isn't the default resource group's name already empty string? That should
> eliminate the need for this special handling, no?

Yea. Let me try that.
> 
>> +
>> +        list_for_each_entry(dom, &r->mon_domains, hdr.list)
>> +            seq_printf(s, "%d=%s;", dom->hdr.id,
>> +                   rdtgroup_mon_state_to_str(rdtg, dom, str));
>> +        seq_putc(s, '\n');
>> +
>> +        list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>> +                    mon.crdtgrp_list) {
>> +            if (grp_default)
>> +                seq_printf(s, "/%s/", crg->kn->name);
>> +            else
>> +                seq_printf(s, "%s/%s/", rdtg->kn->name,
>> +                       crg->kn->name);
>> +
> 
> Same here .... with default group having name of empty string it can just be
> printed directly, no?

Yea. Let me try that.

> 
>> +            list_for_each_entry(dom, &r->mon_domains, hdr.list)
>> +                seq_printf(s, "%d=%s;", dom->hdr.id,
>> +                       rdtgroup_mon_state_to_str(crg, dom, str));
>> +            seq_putc(s, '\n');
>> +        }
>> +    }
>> +
>> +    mutex_unlock(&rdtgroup_mutex);
>> +
>> +    return 0;
>> +}
>> +
>>   #ifdef CONFIG_PROC_CPU_RESCTRL
>>     /*
>> @@ -2156,6 +2280,12 @@ static struct rftype res_common_files[] = {
>>           .kf_ops        = &rdtgroup_kf_single_ops,
>>           .seq_show    = rdtgroup_num_mbm_cntrs_show,
>>       },
>> +    {
>> +        .name        = "mbm_control",
>> +        .mode        = 0444,
>> +        .kf_ops        = &rdtgroup_kf_single_ops,
>> +        .seq_show    = rdtgroup_mbm_control_show,
>> +    },
>>       {
>>           .name        = "cpus_list",
>>           .mode        = 0644,
> 
> Reinette
> 

-- 
Thanks
Babu Moger

