Return-Path: <linux-kernel+bounces-414927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1EF9D2F57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E617B22A65
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD8C1D2F64;
	Tue, 19 Nov 2024 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lPwgSN5i"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B628198E63;
	Tue, 19 Nov 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047152; cv=fail; b=qWz87NXr2SkRC5Uj27RV7svtbsM/24hmv4n/Z8igESZOzdk6NAmk6SyQ/TLkd46RaW5B6/es3kzha709iB9tjmZyD4q2uZ2JcMvUM1LTIKSt27HBmgTBK+Qg/9NIA3ve57MGGObwxkmToYlbENbivBrdwegxj5+gncFBUteq4n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047152; c=relaxed/simple;
	bh=MjMcye1XRiRALb3YPqbgNYQ4m1YTHv5MMTwfdl/Mgzg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QMUHBeXt1MyUiULRiYMtVHEU7dOREgI4qYHEoGY4IXdepdF0pVqOZCD0YUmMtDXQ5R7Jp2f+0o0h14L9FDhqc8lnWDtmf3BJXgLBQ0/Vm6Z+IM01Y+YGngEv3E7g3D6jUrhpln0OTVp/EUFzMqdfQGcXjSW+kpin+ya2ZAq9sU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lPwgSN5i; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw9lgbfFoMOqV4ymRLx+hxEq8kNmN6AzImiHuxpVqaoRIUIbd3W2h29HyXPFBYz0bYk/v8aGV9Q/sMUBULi9j18DNHxOzVcB4Oz8Xcs0wOeZKV0BcQLOKmZp69Cl3GJht/fzXZMQtzQO4jEUV2TdmevkUkmIS/wYS//8AUQO86M3rzRi4uwkYWHKeEt5nE8G21IH5WxW6wYARNuL8Wn1io7/Z8iViZgRUfLyGt99UasTskwi+sGF3HIjT/bGZrRBWnQIG6JlJ2Nwql9X6DDW6t3WwTnnReWQYyTu15AcmE4jP0n0tdtv5Ir5Hosp1YHFxgyglxT3wUws3HUEHusUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRNdN37OVt5Zb2pKyso9be5Xbx1wfkx60lOLaq27jjI=;
 b=j0666LK0AtFg7Wob8gEJy+STBGrtkoIYxZUYHdXA6AHvwXUBshyUvSFzMoWce9yA+7WDHwCdlq9GwfP+nyr5wbOakEPKOkdrllRmw5ghrCiFZH7E/h1M0G2Bxgv1z17Ofk2iRBY46XG3dNRJdbJkiOVmRBtKIqJNCozBGhJHXE8kiSoHMid3k1c22U4YvHYMtbwExuC3NZ/da8oxxse9duzaipWBkFLCe2+nAt3PrRaZxQMURs9NDTG7yjOXYQgKgYliHX4aF7CyJTSieCcf2sXCSqdcTv6zyzK4ZZ8cmLfEf416xH4mEfDvrFR8slwPCgtk6eNcpMtnOZARVs3erg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRNdN37OVt5Zb2pKyso9be5Xbx1wfkx60lOLaq27jjI=;
 b=lPwgSN5i0q5Ufq7xz4g+MclgpByXtPnu+J00lRQt4MnNz7ZyDVX8zs916qWGbApkqzfaw6AQiM9SnZZWuQP+bwXNtijIMv9hYa+a+MfBzR9kFUSV4AnH2iLg/Dj/blZK3Ak+yIDHNg30RgrIJNmHFpGbOGVddD/GaWhNWJhVMk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 20:12:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 20:12:20 +0000
Message-ID: <e108846f-930b-4afd-90c6-2266af96816f@amd.com>
Date: Tue, 19 Nov 2024 14:12:16 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 17/26] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <a3c2bdf2153882cc955b80b7d0fcdf7af3d09eb3.1730244116.git.babu.moger@amd.com>
 <5a7d8ff1-91c7-4e75-9730-3aa0703274a6@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5a7d8ff1-91c7-4e75-9730-3aa0703274a6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0200.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9fa64a-2670-4d2d-d861-08dd08d678f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1JCZFI2L2lpTlQ2REhMT0J1cUtKb2N4ZytibnkzSFRDeGZKbGowd2VCcTNp?=
 =?utf-8?B?NjZ3VnRMVDBlZWxKeVoyTkpmdDFncGJGTFo4NW56ZnJsbjF2cXluSjk5dEMw?=
 =?utf-8?B?UDY2b3hRTGo5dHA5QTduai9hTmRKcG5PcnJNUXdDWlVOa0wwZk1SWi9Ma0du?=
 =?utf-8?B?Zjh4ajBBOG5aWTJ1WVR4a2NTYks1T1NKaWlSTWFtYVNoNnFreHNCd3Bxem9k?=
 =?utf-8?B?NWhGSk1lVjNOYndYVzgyZHlZdzRPOWxqSys2VHh3R0k1Rzc4V3pMVE8vMlQ2?=
 =?utf-8?B?ejlwckNnNTlCcXpLZ0YxekNlMk5ZaXAxR2ZvbnhRQnMrMEc3S0NZRUJwcmwx?=
 =?utf-8?B?MXJnSXhUeEh4Wkc5RGExb2RjK0pyNEZCcWxhKzgwRkdIZkRiOXRGQUJoYytw?=
 =?utf-8?B?cFRqV0dBT0FaMjBKZG82c2s5L3IwNm1mR2JIMEU2VkpnQkp4TmNDeEJydXdQ?=
 =?utf-8?B?NGxpalVLT1kvRk5LRUlFZmJvc0d5MmhmWDFtTWZIdUE5ZW1mbWFvaklRZ21N?=
 =?utf-8?B?UzIxQXVPUVNIbDhzSE42OEhxRXhwV2NvZGhxZ2VIVzZJaUFiRUJyeG9zVDVO?=
 =?utf-8?B?UGd4ODZBWnVMSXBNWXdRYjlrU01LZ2pmR2hwM0dqN0lEOGZtM0tBYTVEbFpX?=
 =?utf-8?B?UVhEOTBPbXFDcmlDRk5LOXdQMGVGTll2YVV5OWZhaXR2TzVpdmg1ODJaSFJ0?=
 =?utf-8?B?UHliTEduRmJTaGJpWFZJSmJjckhCaEROeEhrbGczc1dpZy9hWWVqN09BR0xC?=
 =?utf-8?B?eGJJQnpYby9XZVFidkVERUJYOHI0VCtJWjVhem1FTExWRGZ0QzBmZE0wR3Fw?=
 =?utf-8?B?bUFtbXVMQTFodXVDdmxqTHl5QTk5U3NvRjhHUXhzVnJ0R0t4akw0WHNsYUl5?=
 =?utf-8?B?M1ZrSDJYY0t1ZWtIemlXYmVkZDAyOFlpTkpZQlE2QUU0cDVzbkVTSUpFR1Fm?=
 =?utf-8?B?OUdIQllBSmlDRW1NWHJOajRLV1JsQ2pEN2dkRVhjQ0tEeXhjUVFnZG5KMVhB?=
 =?utf-8?B?Q0laeVQvU3V5eStJQ0hJRzIxZElFUHRWeDdCOGVvTCtvaXRXMTBPSmdPUEd6?=
 =?utf-8?B?VTJFbXNXWEhHbHpmRkN1UFhTRStIR3hvQllrVnY1bXJDUS9VbzhuK0V5Yng3?=
 =?utf-8?B?eFc5NDN1QjJ0TitGSlRpWTNkMTJlcE9xWnVteDRqUjVpQXh0Q0pPTHVxc0V6?=
 =?utf-8?B?eFBJZ2FlRGgzY3pmWG1FdHBXYVZOWi95cXNJQlZvUGtHU01uQzlUcW1FSGIw?=
 =?utf-8?B?bFZRSXJWS2VvajBjYmJBaDJkY2hFdXFDZHJNbFg3c2V2RytKSW9XbzJHNUhE?=
 =?utf-8?B?bGc4UEdRZVlJZVlXWGM5cVRuUGJxdHl5VTlxQjdHc0prcW80MGxnb0xlR1BG?=
 =?utf-8?B?SHVxSkVRUmxPTmRjcHJ2Sy9aSVp1Qi9neVZNMStWOWZXOHhVRnlIMy82MXlM?=
 =?utf-8?B?L0E1bytRUHFJWVlacDZkcVhFdXNjZVZ0UmFwZys2RHlWb1ZESDZFSTZ5SkVW?=
 =?utf-8?B?a3lEVk5tbUh6a1lxUlNYaENZUVhZdTJYUHZQb1RZOE9aNE9vVXpFeDBzaDVL?=
 =?utf-8?B?SDlWbDlVb2ltWlcvVzljNTJCSlhmVGVSN0dyVWVoQnBsTXAyWnROOWFtRWNO?=
 =?utf-8?B?M1lrVEdVcWlwT3lCR3IvRzNFU1JRcllRRUoxc0dZZWtWaThTNEdFQnJMUUtL?=
 =?utf-8?B?ekZmL1BGNkk1cGJLN3NNaHhYdHoxOVFmNDVTa0pTL2tFSW9VN0V5aWQwWFkx?=
 =?utf-8?Q?cvOHoef1RzxA7KO2EZM0RR3iE+6O0A2LKY3Vyka?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlBuNEMvb09UUkptdlBabEMwK2JSQjg1d1o4Sis1T3FveVQ5cnVDcUh3SGs4?=
 =?utf-8?B?cmNmbWxOcGFoTS9SMkZZREkySVhZK3BmY2ZmVXZIRnRRS0o4T3Bxd3pVRGtL?=
 =?utf-8?B?VG9sQStlb1c4bGpFb2hhTEFrQ0FxZWR1dU93VFUwVytUNkI1WmJnczBmRTJx?=
 =?utf-8?B?RmdyTzNtTjJRandNZnFkV25BY0tDZTd3bVJzMVgwNVBjeWdTcFlGZW9WUHZO?=
 =?utf-8?B?c2ZwVlVZbjdFUVcrM04xcFdHZUlIakw4OWRDQVB1azU0NlZuK0M5M1lLVi9L?=
 =?utf-8?B?QVVxQ21WZ2NIOUR1Mm43clIyMXlNb2V5QUVqWjU4bkVpSjlKUEViNFR1N3R4?=
 =?utf-8?B?WktqZzUzc3BGbGx3eUNmdHphUnBONjNTaFhmUEw1cmE4TmNGQm1vYThpeWhy?=
 =?utf-8?B?SHVMMmt3QmUwbFhQNGh2Uncyb1NsWS8zeHFzNEZzS0ROdlcrTzh4elhab0FO?=
 =?utf-8?B?dnJ6bTlwZXF1RW5VbldrcmFIT3NBNmEyR2ozVEd3bXkrRUdBM1JRdmFxMXJa?=
 =?utf-8?B?MTQ3bXZiL0RRSVg0QVA0RXU0ZnVrU3EvU0lWamdmWmdTS3lvdnRsRFlieG1G?=
 =?utf-8?B?dDFlK0FlMEo5djY2UmdCR3o2Q3JuWHRLTEZuQ0tzZzhkQ1NYUnc1TWxRRzNO?=
 =?utf-8?B?NVN6ZUd3a1l6LzYwbUJlMFE4YTNVNEc2a1liY3ZpTjJSMEN5c2MrbDUxRThP?=
 =?utf-8?B?c2Q5MHVOdDAzSk5uSGZjTTUwZjFtWGpJZU1VYzZ6ZlUvZjJHL2NvcVJmT0lR?=
 =?utf-8?B?QVBJUzl6WmtjN0RIdHdjYmdGeWtYeVpaZmdQRk43OGdjYWt0ZGttajhLaUd0?=
 =?utf-8?B?VE5ZRjhLTlk3Z1Rub0NuQTVEMlFBYWNDZWxGeisxVW5talo0dFhGNjNCci8w?=
 =?utf-8?B?VWhyNTFwYlAwYTNnbVpMMXpvVnFobDdQWWtUeXNsSTNjMHFRR3RjNm4reHpK?=
 =?utf-8?B?bVkzQ1lIWTlPYVJLeHdSOXNFbmV5R1JaSXEvcCtyT0hmR1FITCtLU3E3bm9z?=
 =?utf-8?B?c1p5aW5SL05nTmcrSkZ5Z3RWT0lqNnYvSkRKS0J1eW1uVlJ5Q3ZFcTNramVC?=
 =?utf-8?B?aktwZ011ajlhY0lUU2ZCZnNCbE9najh6NzBCTnZQZ0RvQUgyeTNKNTZKaG03?=
 =?utf-8?B?eXZUbTM1QmtrWkRFWFdZMUwzRmxPazJFWngyc3BmT1RLb1FkejdnazUzektU?=
 =?utf-8?B?T0kvRjZMcUxBOHlaV0c2SU1GQjY1TWR3c3pXd0g1alI5eEdyU1Yxa1Q0VXhG?=
 =?utf-8?B?dHlHRGluWVRkL3U4QlEvQkQzV0dJZ2JkS3NXL1p4SCtvbTMvMGpnVitmYnBW?=
 =?utf-8?B?czY5TzRrSW8vSVIvOEo5NS84Zmhka2t2dEowSkoxNmo3VThyMThtL1lCUlpT?=
 =?utf-8?B?SUlkbGxTZCsySDl2dkNkdW9TUUE5RnhmSlBsOHBsR3NrenJ6L2xibThGcFdR?=
 =?utf-8?B?QzJGNk5telB0T0FpT3B3SkFwWW0xczh3N2VSSU8xZ1NFTnNxOFRRd2tLVzBJ?=
 =?utf-8?B?bEZPUTcvZGlNNVdTZEdqNndwbUJhWk56NmhzYmd6dWZnQXUweHpKWHRlQ1c5?=
 =?utf-8?B?NnR2bm1oSjZjRHFuaVdQRk1jY3VySXBqSzl2RTJNcUpXVzFqNUsxMG0rSXFX?=
 =?utf-8?B?WmFQcVJaZEp5Vk5tdnFucXAvWkxCcnlVWmVtOElYaUlpZm93eXNxRXg3cCta?=
 =?utf-8?B?NmdPSm5jR1QxdTFSSUVPMlNHSUU3TDlLbmJRUW5PYjZaelFjUUNjRHI1ZzZP?=
 =?utf-8?B?UHphSWwvWTQ4T2pFZ25TVWVrU05kZFVLeTZNVUREN3lFdGJuRGpGQXdRQ0w5?=
 =?utf-8?B?RkNoS2IrSFFDK01VQW5rYmprcnZaR0NubUMwZHh0RHQ4dTMraGZHeTZKVTVq?=
 =?utf-8?B?Y2RNZ3ZVUXJDTC8ydjMwOVRKMXdzY3NxRE9sYk5JWWU1RzlRaSsvb29BRFRs?=
 =?utf-8?B?eDUxN2VXQWhhOHUvYUZxbUJ5dzdpd01GNGZPYmllSU5vcEZKMm4xWG5XOElL?=
 =?utf-8?B?Y2NpTlYyQWtWVllpcElYcTBCSW55RGVrSWpKUUtzSG5TREJvMmtYWlI5ZXJ3?=
 =?utf-8?B?WGFpbHdhbGJqWEZUR1lVVi9mQ2lWVkVRVG9QSDVVTGI3SGJMTlRFTUlKaE5R?=
 =?utf-8?Q?DA9k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9fa64a-2670-4d2d-d861-08dd08d678f3
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:12:20.3771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4+KV7h4WxJ5B4jx/bxMBzRbVnPfM5csMfvO/AJ1dvwTx6oITF43wmyvrfpZKvxd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417

Hi Reinette,

On 11/15/24 18:44, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID, event pair and monitor the bandwidth as long as it is
>> assigned. The assigned RMID will be tracked by the hardware until the user
>> unassigns it manually.
>>
>> Counters are configured by writing to L3_QOS_ABMC_CFG MSR and
>> specifying the counter id, bandwidth source, and bandwidth types.
> 
> needs imperative tone

How about this?

Configure the counters by writing to the L3_QOS_ABMC_CFG MSR and
specifying the counter ID, bandwidth source, and bandwidth types.

> 
>>
>> Provide the interface to assign the counter ids to RMID.
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>     Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> Reinette
> 

-- 
Thanks
Babu Moger

