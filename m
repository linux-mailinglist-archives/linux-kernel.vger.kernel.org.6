Return-Path: <linux-kernel+bounces-522750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81334A3CE28
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47E7174F19
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F8E39AD6;
	Thu, 20 Feb 2025 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K546/OIM"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AD1BF58;
	Thu, 20 Feb 2025 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011692; cv=fail; b=uA5ubvuSAfzB6e0AO7LF/Bie3Bsh1hpCI1C51HB6ctZrR69CVAJfdkulTwkPO0cCJjS7E6KKNFaeLrSgWARW+t/d9K4XI6WzIhbzn8pG+kdrDLMv1cczpzEhyFCaz6Wb/N/FEelvvbD5jeIPCuWtZj5RcMXX0t8HMd+1Ww5eOhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011692; c=relaxed/simple;
	bh=WdAtnqHfCs51UdvFiCaupj/AhjdzRJF5K/bGRARwlT0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PRso6pLrzqhc3elEc9hHIdSzK8hxVApiNRev1DZTK7W8Al24ldBirJ7GfLfrwpwmh6ZG7dt0cQKSQJiBmoRMWhEqzKy44uCSzc5V5EpPh6s01IrXpSqgYm88x2zj6glc29DDGabmtdDvM/cg44XyzhthjDcfJU5ypIK3OhLAQXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K546/OIM; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnlxnbZKKphDjTDZFBUIOvrO2/roMDRPZKIUDV7iKmgH/q01AWyhvNC1sYhQeP4NRNa3kcdPfSo/H6wMxkGX/i3XafneCjzjKMXaF8+cbnOOT12+A2Zb602kbmdpoJKOW671dxIljPVS8W8dafzZwKu/Ub2CpB+qYhnqrWKfdWIMGmEdvZ5J8pPEYxQrnqbF4MhTM/Rs3z+bION6BDa+Sc0gpb6BTrnAcUKqFv1ExpHMDZTENECevxH3ryp8IHbpbBOHWJQhTsI5m50xiYme5s1dIoTBcXc30wbamAxziQxWympLT1cPJSP4a9dUwH8Q15pLbfWwGHIPC2OtB9NVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9LfWaa6dl4CMLwqbJfZPxJucZCci6oIM5ldM29vdgc=;
 b=yWQk2/j4i2yfpTE/55YTUlt/+Ja76a9rxrX+tDaTqPj+K6bfYWEkFIDb38g2q+pHnoC4r/eIkGtbKUHRkrYYZbeixMxMY+IYohE5wHiUltNmxb10xgc8/i7GUSydBl+yRp2PvryXliHd6QQLi6ZixsK06Qn8fNgwnOY07ZvxJA/SWewSqVhoESPW8lfkhwJi1+V94D/Z7ccqloxwquIBxogKOGIkVBzICwLZNXdihtkq6SLfZuxflbzophZPMCqpMsCwvR63O0fg6p+S4oBdA3tFnkFnp1Z1/iIfrPmFyonMOWmYhcB1ovPW+UsH3jyinGawBKbyOPGA+/xV61PyOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9LfWaa6dl4CMLwqbJfZPxJucZCci6oIM5ldM29vdgc=;
 b=K546/OIMI1ZfzvRDHIjzGaqBVuKSgvJYXHnL7ErwVF7SPjhjfE/hEVHS1m5jw763lwbdtjhG+wA9m04i0M3iHSSPGohN6bRSJhaVMS7ZqBmvgW3FzKW9Lz04sCRjBEwR/vDjVLX7Epi0suEDFsq5Ee6FfaQzHRYQeauNvGVVBZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 00:34:47 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 00:34:47 +0000
Message-ID: <1ccb907b-e8c9-4997-bc45-4a457ee84494@amd.com>
Date: Wed, 19 Feb 2025 18:34:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 23/23] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Dave Martin <Dave.Martin@arm.com>, Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, peternewman@google.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <fe1c0c4cebd353ccb3e588d7ea2fe9ef3dff0ef2.1737577229.git.babu.moger@amd.com>
 <Z7YBxNIWb7dqOnfi@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <Z7YBxNIWb7dqOnfi@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 76594910-3544-45b4-8495-08dd5146610a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFVJNktrRlA4MXNGYnRuaUt3ekRlS1ltNmlOSWxPMVFrN3BRcDdyR3dPR0x3?=
 =?utf-8?B?aUJ4WDE1eWpoK3ltc3B1NTJTZWxMRVY2UzlPV29TWGtab2ZVNzh6V1YwYllt?=
 =?utf-8?B?emNjQ1JMQWd0Rjcybnhvek1HSHJPR2NRWXo5aUFjbEZkMFY4RldGZ0Z6cGlR?=
 =?utf-8?B?SXJhMXRtdjVFZlFjS2cwRmF4eE9yNzlibTBPTVRZUVRJdEhxc2xuR3pmSjNY?=
 =?utf-8?B?OEprbjVTMGx0UVpKOWVlMGtiOHo0QTdwcDFkQURNeUNjT29WU3UxRzBYeTlJ?=
 =?utf-8?B?U2d6WHc2czhKN1N1S0dMWHZ2UzQ1UmZ1bUk0cGF1WTNkWnE3Yk15SVNMYVE4?=
 =?utf-8?B?dWg3MHdhV204MzRjMmdwcGxVRisyTm54YkVYL20rMGFkWU5HWGZSb2dMSFgr?=
 =?utf-8?B?WGcxZlB5dkhpV29ZeTRkeVoxMmZkMVE4M3d1TmkwRXBuQ0dLcGZRU3gzK2Qv?=
 =?utf-8?B?YTlFM01WUzRQL3l4SER2Y2lQQnEzL1NEc0tQWlk2QkhjTk5UYUhTcjFVVGRk?=
 =?utf-8?B?QWdzdmNqaTRYNzR0dGtuS29ialdYZnJYdjcrVFlQajVPK1AzNWd0bXB0WndR?=
 =?utf-8?B?Q0lkM1g5bzR2NkRYMDNxRG9TdWpBOEtJSnhLN1JjZzYxSDU0L2ZjMjRSN0pT?=
 =?utf-8?B?WHVhTFNZM3kwZ0xyUVZFQVFYakN5U3dFUTlxTVB3UHFxdUljTHB4Yk9TclFi?=
 =?utf-8?B?Vlc0ZUhDYWNpay93UlJjWFkxd0ZBdUE1Z1kwN3pTMGtGOEkvV0VMaGwzamgw?=
 =?utf-8?B?QTdydFZqTVd0eFZxRHgydEpKcUM5TktoL3N6Y2VkZ1NXUXM5cVRES2lXNVBY?=
 =?utf-8?B?dzJsN0NwaWpXb0RTSUI5OXpZNmNoRldJczBWazJYcUljUHYra2JZUXlidng3?=
 =?utf-8?B?cFlTeDJWNUtiL2FuQ1hEMGUyQVNQSzN4THphZUE4a1kyRjNjanRuZDQyOE1n?=
 =?utf-8?B?S1NFWnp2NzJxcU5KaFl3a0Rya2lIeGxVY25zc0JtZGlkM2VFRzR1V09TaHRv?=
 =?utf-8?B?ZWE3RWNPWVUzMDQzbUZpMm0xaGRvbmtlMmVPZkhnbUROMzMvOW03VGN6OEFP?=
 =?utf-8?B?SExHWGk5MmxuSTJDbFBzLy84dUVNdGRVOGtSSVlKQWlLZnJqWjNibi9nSlZH?=
 =?utf-8?B?ZnI0ZlVWRUcxSkppQXp3U2ZvV2lFendyOExJMEZDYzJCSTR2Sll1TnhRV0Uw?=
 =?utf-8?B?dnFURGtqeGhOVVgxQVVIeWRCcnFCKzE4ZDB2Y1EzWmVGeFB5N0ZSVFRiV2Ns?=
 =?utf-8?B?UHhDWkxPUkJTZThHRm1hMGhYNkZEdTRETVR6ZFVEejBMT212SjIrS3JUYVhT?=
 =?utf-8?B?VzFiTlJQcy9vMytXb05yRThTblJCcjViTXp0QjYyTE9CdlBOa0dIRjJlQ014?=
 =?utf-8?B?dyt4dDhITFQzN2FrbmZQQTEwcGxJNUJQakI3eHJ4aDQwU0E5bXdPZDZYclJi?=
 =?utf-8?B?bno3YWo4citQajYxSCtxNmFBM3EwcXRGU2Fmc0xhenlZSERrY1M1NHhXVnpa?=
 =?utf-8?B?S21MdkhXcjhFaTRUc2RFdjFYb0ptV05WMDYySm91V05GOHBtV2VjTFlXM1Uw?=
 =?utf-8?B?S0MvKzZCNmp1UkpERjdXdWJsM0xKOFR1OVlsbHJpU0NWVHpnYzF4Vm83TnR5?=
 =?utf-8?B?aU5ENFcyeklYRmFFb2hvdGJET3BWNGM3Q0FOVS9xQUg0K3VKUk1iaGZubEp0?=
 =?utf-8?B?MmZLOUY3M2g3Y0dYVE1oT3o4azY3OUVPSTREMGFrTjQrZVdYbG4wVHJzQ2d4?=
 =?utf-8?B?V1MzSWRZZm5XSk1SRENsK04rK001MGRIWlZGUUVxQ3ZWelE2NkdPclJIZnFY?=
 =?utf-8?B?dXJ3ZEc5Q1lxU0ZaT2Z3K3g4U1MvbXY4ZTFzTmFCOVFJRTdrRTF5a25MVjVm?=
 =?utf-8?Q?WXIcueS3VrnjB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MndFSUIrNGZXVUFHeDZ1U2J0anEzY1VPVkRCVEJjdzlFR0hZdUphYW1TVjMx?=
 =?utf-8?B?djhkRnUrZ0pmMkFLSHBiQnpiM1E3amt3UFh0RUQwNGkwSWhZODJ1MTd4b1Nq?=
 =?utf-8?B?cWtuMXAzNU5iQjAxTlRPWlNvdXNTKzM3aUNQbTR1YVR4R0s1ckhLT0RsTWtD?=
 =?utf-8?B?SkQzdmMwOW1YNzVSY0k0cEExWkI4VW0vRzVzdksvYzYxcC9EN0haaGVrcjQr?=
 =?utf-8?B?WFUzZjVGc2hMMEhwYVNmZDM0U25RY3BvLzM4ampOemRzWGF3QXE2Vm9maVlu?=
 =?utf-8?B?MUlXczdtQmdqRUlXWVI3RmhxcklJQVFJMndaVjdlWWwzRlllOTdoZGlIQkFN?=
 =?utf-8?B?OUY1RHZneDkvcnVHaXZ2VFl5RUVNS25ZQlEyM2ZnQ3BDZFVpL0x5KzJuc0Zj?=
 =?utf-8?B?cGpCa0tDVno3ek1JN2pvRFh3Zk1MVTRXK3lkYmJucDhXZWpWM25sYlp2amZl?=
 =?utf-8?B?NjRpVk05RTc3S241VG1HL3ZHTGhDcnB4bUJzWDdJWWRaU3VPSHkwaGJhT3A4?=
 =?utf-8?B?Mk1iRVJvcSt3cTcyQ2RlY25rdlRSc2lBYnY4OStLV0N0eDFlUEZ6SDM0aDhk?=
 =?utf-8?B?ODVydlNRbmN5bVdJa2FrejBtcDhmNkNHUnc4Z1lsNHdVUFpEWlJLM1plbzNK?=
 =?utf-8?B?bmdjNldla2FTVkQwb1U1M2JlSGxuMjhvRDgyUG1oNEt6MzMyK2drV3gveTMv?=
 =?utf-8?B?Vms3VHhuNTZITDFIQnlyTnM4WTYzVUVhWEZ2aE9oVmVGeXI3cmkxbUpiQlF6?=
 =?utf-8?B?Rmk5OHNlTHlEbmZhNU5OWG9NbFJtbjd6ZU50Y2laOWNpVVU0eFRtQko0a29H?=
 =?utf-8?B?RlhCV2picjVBN0FkTmdFZUFXWE1VNmRYWFpZUFpWdVZ4a2UzQUtxNjM1ejRu?=
 =?utf-8?B?ckszbXduSml3clA3c1FWRkpiWUZ0Vk5tWFpTUkduQThvb3NWSVVoVXFDWTBj?=
 =?utf-8?B?Y1JCbHkwcGJZejEvUVlPMHlFV1V3WWVPbnVoWFVJSDB6QTFiQjMzRTdVY21G?=
 =?utf-8?B?QzdtSXRFOGtRUUdibkZpUTVpUDEyUW9RaTVOL3FQdnNPTW9qZEZOb2h0TWxl?=
 =?utf-8?B?WE1rN3lUOTVRNXRmcTJKaVFLY0ZmVldsNUwwbEQ1ajhOZUdOQUNneDQwb0o0?=
 =?utf-8?B?bUVEVUt0YVBpWVhGcUFCbEVEU3Rzd0hON3lxRTBPQWxkV0EzdktRaGNLb1hu?=
 =?utf-8?B?cWdETVFVQzd2OVFQdGFzMisrSVFsNyswRFlISUJWNzg5bTV4bFhuZlZvcmRD?=
 =?utf-8?B?S2IyT0V2SDZtcGxVRmUwb1Z0cHZPcHk2TlQ0RGFQRmVrQ29mTldBenBwN2VU?=
 =?utf-8?B?c1BiOStoektjSUtwRXd4R1VWUkhsSTMwMHptSUtzdlo2clNhdkd3RjJEak0r?=
 =?utf-8?B?Z001ZlRvTjNPQ1pXNGhyN3Urd1RGVWhEaTRkQ0IzdU1HWU9HRlVONGhwKzNV?=
 =?utf-8?B?Vi95YWJEZEtUaUY1NHZIemkvQ3RzdTNlWmFKZ3JEZXVZU2d5cjhsNW94akpn?=
 =?utf-8?B?TEQzekR5SS9PNk1IODl0TU1UYzliVHpXcW9DNXRrZGZVaXNSckhQb1FSbjgr?=
 =?utf-8?B?Z1gwVkhBR0czSEYwKzBaSG8yajZGa2VpbGxFdktpYnRXZmdhWVV6Nit6ODRN?=
 =?utf-8?B?ekRhS25ldWFTN05TdDVJdVQzbkNWTHFNUlRQN1JLdm42ZkJLREpvdFpWOHRS?=
 =?utf-8?B?NDYyMVNacklHNStMd3FRU2c3RkFSaCtORmp3ZWVnV25DdnVqLzY3dUVlNUNY?=
 =?utf-8?B?Nm81ZEtMMFVFQllaMjA0TzdOdllaeFF5di9EREJ6Q0h3RFBmTFc0Y2xXalB1?=
 =?utf-8?B?ZDBseUh0eU1Jd1hSeDg4RlhuRXZUcmt3WGk4WHVmYkFIRWR3d3g1WWVMU1Ez?=
 =?utf-8?B?dk0zZjVRSXkxbnZ1alA0UVJhUlQ5YlByeHF5YlRFNjA2K0hMa3JuOHRTbHQ5?=
 =?utf-8?B?blZSM1FyNnAzaHlWbjkyWG5KeEpwUVZ2M2pha1BLQ0pPaUk0UVpySEVyTXd0?=
 =?utf-8?B?MCtSM0l6OUt4UU9HZzF3ZkttVG82Yi9XbU1rTFdlVEdkaTMwWG14VmlSUVBl?=
 =?utf-8?B?K2hkSS9YVVljcHBsMFRMY0dEZlRGRTUvRmpYZzRSaXFQczlJM1Z0MFBxaWF6?=
 =?utf-8?Q?ydlk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76594910-3544-45b4-8495-08dd5146610a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 00:34:47.6223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ir1xR8796HBUG7Noh/yOykOAW5BBW5Ixg+Y3gXtXA7U94G36cciWcqgBYsDCCv70
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433

Hi Dave,

On 2/19/2025 10:07 AM, Dave Martin wrote:
> Hi,
> 
> On Wed, Jan 22, 2025 at 02:20:31PM -0600, Babu Moger wrote:
>> When mbm_cntr_assign mode is enabled, users can designate which of the MBM
>> events in the CTRL_MON or MON groups should have counters assigned.
>>
>> Provide an interface for assigning MBM events by writing to the file:
>> /sys/fs/resctrl/info/L3_MON/mbm_assign_control. Using this interface,
>> events can be assigned or unassigned as needed.
>>
>> Format is similar to the list format with addition of opcode for the
>> assignment operation.
>>   "<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>"
> 
> [...]
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 6e29827239e0..299839bcf23f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1050,6 +1050,244 @@ static int resctrl_mbm_assign_control_show(struct kernfs_open_file *of,
> 
> [...]
> 
>> +static ssize_t resctrl_mbm_assign_control_write(struct kernfs_open_file *of,
>> +						char *buf, size_t nbytes, loff_t off)
>> +{
>> +	struct rdt_resource *r = of->kn->parent->priv;
>> +	char *token, *cmon_grp, *mon_grp;
>> +	enum rdt_group_type rtype;
>> +	int ret;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		rdt_last_cmd_puts("mbm_cntr_assign mode is not enabled\n");
>> +		mutex_unlock(&rdtgroup_mutex);
>> +		cpus_read_unlock();
>> +		return -EINVAL;
>> +	}
>> +
>> +	while ((token = strsep(&buf, "\n")) != NULL) {
>> +		/*
>> +		 * The write command follows the following format:
>> +		 * “<CTRL_MON group>/<MON group>/<domain_id><opcode><flags>”
>> +		 * Extract the CTRL_MON group.
>> +		 */
>> +		cmon_grp = strsep(&token, "/");
>> +
> 
> As when reading this file, I think that the data can grow larger than a
> page and get split into multiple write() calls.
> 
> I don't currently think the file needs to be redesigned, but there are
> some concerns about how userspace will work with it that need to be
> sorted out.
> 
> Every monitoring group can contribute a line to this file:
> 
> 	CTRL_GROUP / MON_GROUP / DOMAIN = [t][l] [ ; DOMAIN = [t][l] ]* LF
> 
> so, 2 * (NAME_MAX + 1) + NUM_DOMAINS * 5 - 1 + 1
> 
> NAME_MAX on Linux is 255, so with, say, up to 16 domains, that's about
> 600 bytes per monitoring group in the worst case.
> 
> We don't need to have many control and monitoring groups for this to
> grow potentially over 4K.
> 
> 
> We could simply place a limit on how much userspace is allowed to write
> to this file in one go, although this restriction feels difficult for
> userspace to follow -- but maybe this is workable in the short term, on
> current systems (?)
> 
> Otherwise, since we expect this interface to be written using scripting
> languages, I think we need to be prepared to accept fully-buffered
> I/O.  That means that the data may be cut at random places, not
> necessarily at newlines.  (For smaller files such as schemata this is
> not such an issue, since the whole file is likely to be small enough to
> fit into the default stdio buffers -- this is how sysfs gets away with
> it IIUC.)
> 
> For fully-buffered I/O, we may have to cache an incomplete line in
> between write() calls.  If there is a dangling incomplete line when the
> file is closed then it is hard to tell userspace, because people often
> don't bother to check the return value of close(), fclose() etc.
> However, since it's an ABI violation for userspace to end this file
> with a partial line, I think it's sufficient to report that via
> last_cmd_status.  (Making close() return -EIO still seems a good idea
> though, just in case userspace is listening.)

Seems like we can add a check in resctrl_mbm_assign_control_write() to 
compare nbytes > PAGE_SIZE.

But do we really need this? I have no way of testing this. Help me 
understand.

All these file operations go thru generic call kernfs_fop_write_iter(). 
Doesn't it take care of buffer check and overflow?


> 
> I hacked up something a bit like this so that schemata could be written
> interactively from the shell, so I can try to port that onto this series
> as an illustration, if it helps.
> 
> Cheers
> ---Dave
> 

Thanks
Babu

