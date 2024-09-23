Return-Path: <linux-kernel+bounces-336222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A64E97F0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD62A1C219A8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6301A0716;
	Mon, 23 Sep 2024 18:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="po8RIEZK"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A603199944;
	Mon, 23 Sep 2024 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117021; cv=fail; b=nffIFz/ZClK7WV8Lu8M6fjSGODtBd5AhMkkmAhnYRpLu40mfn18hV6wyLLO5F4Qx+rlCr13MQg9qtQCxnFjm121w7QEoGl+UKPXDDZVOXybXruM78HqrR+d7eA42ViJ1DBSmxw6vziGMYrt9QhXjoRPTNZaS7HgSTaeWds9f8XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117021; c=relaxed/simple;
	bh=zip+J1V+xjIzwHcOW5fXtAL6Xoq9EP6kIyzMKLtgfwY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n5kplQp79gdhEwHl2UopADckdzxrr7ccUZeNJ9BWdtLL+HZ8ir1NX3n4RszU01wTNUoiUC5PMAG4twscW4K82jNhxyW786z2YUGkYYrqtsHJdtd/v2RM+w3UPaDEzEr1EOZqjSFuNV0eW6gTS/5BEGUFjXDL6dkaViASWY2lRzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=po8RIEZK; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAsdq9kMk00KowVGFt6aQYPwtGh6JT+uxUVtC4YhQmYwP8JuJyULuuJqjFVBqbb/30ace1r2sGKnJWYGPRcVIOo8yuRiZiVOjmWJze1AsZeEtCmY9BEN2IJVkCWctCZm3d8LOkrVNlo0kV9HurJJZrzH1GaagjsXYFG8NkKTx0+eC9z6RQACpN7o7sIvHNSrGQ+WcLyZPFuIMH3Y1H8Oc1gJx2NPBqiyvJLfMibnFD8HBSfmTGIs4nG91tmvoE/paWTTkfidqf+LK6UWIBwgNeHbmTqVfSr/gK8BVXhQGgnKzIWxFl9EHhW1/6/LKsL07TNHp5RVujLI3A+hV7dWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNy0I8ceyGiiy/54RXa3P9LddEojRRdehtF3Gc+g/6g=;
 b=Co9ZR7H+IJASvIxqzn64T4EdzAUJcf2o7D+5z8mJ8zoHhatiEd6NGVmaWKfVqNZCygajrYXlhlssUZcBNHazUEjJJfjdXCc+wGIS/L90Bul5TEeU4eCLSVnKEHbQxF7rjFiqWDZ2QC3vtjVf1MN5vbqUL64PDbyv1exJSFq2sBRg4LQp4PrnFFuOkzTUwYcC6aC79M9SPYgQ9ziUn6VoZ4uvCTHLpBjbITaAfPPe84MO6Z/sAgkphGkaeXJikZiCxLJBEscr+Z5b/Uv0zUkUj/tKDgqEG6HCdrXqC7T1JaXTy6oXPm/K4y3BvZo3tsP+QXZCOjl3pKPszYbl8Ukb0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNy0I8ceyGiiy/54RXa3P9LddEojRRdehtF3Gc+g/6g=;
 b=po8RIEZKvL05IsoNhD6ZrGbPUUvIdh0xxzlTdCsWfSmpLd+CMpmqO9OAu/n8z82b5niS6hazML6APNKkm62i0ULB67G8LAmSTLnpuBn2jD8usRgLonCzdevvO5cF9op/4p5FaVdsi32N97aHktznDzZob92rKF+a3uL3oPAh3zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Mon, 23 Sep
 2024 18:43:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 18:43:30 +0000
Message-ID: <87092f53-173d-480e-8e5d-de55a04d640d@amd.com>
Date: Mon, 23 Sep 2024 13:43:26 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 10/24] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg in struct rdt_hw_mon_domain
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
References: <cover.1725488488.git.babu.moger@amd.com>
 <3182fb783dafc73fefbd762d7d83ae790c25629d.1725488488.git.babu.moger@amd.com>
 <612ea03c-b8b5-427d-a810-8c2c291ca062@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <612ea03c-b8b5-427d-a810-8c2c291ca062@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0190.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: fabb6201-ce27-4872-f76a-08dcdbff9e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjkwOUE5bXhtdVhvblN0cWlBdHJKRGFxczk5K2Yvb21BRHJMejY5WWZMOEht?=
 =?utf-8?B?ZUI1Q3RRbHM2QVI1T2g2aTFQRk9LY0xkOUxGRDJmcU9WSGxLanFPOVZjS1Yz?=
 =?utf-8?B?Mmh4NlJvaWdDVjlEcHgwR0FySWRFbDVHNGVLVVhsaE53aGFZbjA3dmU4N1Nv?=
 =?utf-8?B?LzJUZnZVMEs3aUNGSEN0OHhKaHBGSUJEYmRBait3R3A4NVUzNDVIMTVSZEhQ?=
 =?utf-8?B?Q25TZVZjeXZBZmVuRFQzcDJJWWxxeEM1aWxDb0FSVnRaNS9DOGNxWDlWVGlM?=
 =?utf-8?B?VEhIN1YycGIzTGowRDFqaFovL1F0MXlNVkxJeTJIbEF2V2JHN09SaUcyUEZw?=
 =?utf-8?B?Q1pOR0VmNlFtTWF6MVdxMDZXUDBvY3hMSU5FZ09jeUFFNENyT0NPbGxUaVRJ?=
 =?utf-8?B?anJJRU9kUWFHOU1pbXJJekZRcVRsNHFHUjVoVmovZzU5czU1M3FrRUNpMWIv?=
 =?utf-8?B?aUp4VWpzN0ZTanBFaUpIYmlTQ1N4QjE4NE9LRzhmOU9QOTJZTW5ndThrM2x6?=
 =?utf-8?B?dFF2akFoYnVHQ0xWR01vNjg4M2xLdlE0dWV6NDVCZGJYRk8zMGY2a0xBR1B2?=
 =?utf-8?B?SHBvL3hDSzduM003RU41UnVlelF0VUdjMTB1bUNXV2U1L0NCRzVPRjRsTVdI?=
 =?utf-8?B?TnBnUjI2dVY5WlUzTWMwRmVpUkdkNXhQeEpkNTJDVVRlb2hHRWx1dno2S0Jt?=
 =?utf-8?B?algwQXpTUFRFVUhqSDVvdkFVcG1ST25BcUNBS200ZUNwaHlXM3FiK0tVdnFI?=
 =?utf-8?B?bllOckJuSG1yc3pDclhNR3d2L1Q0RVZpdVRxeTV2NCtEMHNLTlpwWHZpTmho?=
 =?utf-8?B?c0VTdkh3S2htcXM2bTlzM09zcjFvVDRsWS8vdkFZUWFLRndGTEkyQS8xWVZS?=
 =?utf-8?B?NEZQUllFUVFyZW1JcFg0aFVLUzlMQzVuYld1UlJUTDEzUjRLY0prK1QxZWl3?=
 =?utf-8?B?WXJwaFFkYlppMkxobU8vVDc4NWQxVTdFem9HOTF1eFlWOTFrVFVQcUYzWnRp?=
 =?utf-8?B?cWM3THFwcmxFSEZTMmhPK3JoZGRYT3ZjTkZwL3cwdVlBUmpBR0trekhLem5S?=
 =?utf-8?B?Y1NPeFRlRzNwR1loOWNCelZtL1dIU2tCR0ZjS0ZUWHVIZm1LcHNURlJyTUxw?=
 =?utf-8?B?WTVpU1FSWFYyYU1ycFdsUTlHYnBZcjIyWWN0UXBhWHh0eEFZV3kyWTZ5eC9m?=
 =?utf-8?B?bjBhKy9tZHZ3UDlqaHZvbW85RDFQNWFpZUpTMHFmaFpseFI5MHNzT2NmcXhj?=
 =?utf-8?B?VXE1bm82ZjBOL3d1cGc1WG5teStwdFpiSGMwWmlSaVpQa0JaNU96T0Z3QStQ?=
 =?utf-8?B?Nnd5K1dzWTJWcnJkcHJab3lETWI4NUNhcXpNUU1oc1NoQ1d1eGd4NDB0dEFG?=
 =?utf-8?B?K0JUK1ljTk5yN2hZd2JlMnBjUkV6ckgyZDJhanBPZHlSWE1xbHNKQm5zM3di?=
 =?utf-8?B?RGZiYjYyd1crVStJRStFUFJCK1RUKzZsM3NLdGt0UW5WRTRsc2twWm1rVFpN?=
 =?utf-8?B?OHpHRFhtZDJCOWNVWWdjSXEyQi9hSWJSNDYyMjMySEhmVmthRC9PK2tVSWR6?=
 =?utf-8?B?UnJzblM4QTg4cDh4OGtJakM3NkQwcXhKZm5YcDdSWTZmQ3JqN280YXYwUnRG?=
 =?utf-8?B?OGFOeU9oTGJYaTZ2R2xDYysvV3lUeU9iL00zYUMrNExsRTc1ek1aWlBORGxZ?=
 =?utf-8?B?bnBnc1k3ZTZJMHNnWjEwMUN4MHJ6OVozZFp1QS9MNWZxNWpCaGxlVkpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnpML1U3ZjVHRmQ3VldMVFo2QmQ2UUV2NzV4Y3JxeFRMbDVOVVF2aTNxMjBF?=
 =?utf-8?B?dVlvbGtldGYvWTZmNWFoZVhFYkhtSFVBTFhmS3hBZnRLMzFybmZxd1NOU3px?=
 =?utf-8?B?R2JJakJNS0NVVUxJUUVEbG5WZStuSVpLMWRnZ0lZNFdsZmZPekpWay9wb2hI?=
 =?utf-8?B?b1Jpd25ycGtyWEl4OVhudWtoakRnV29iSDRTR2hRZmVEZGNsQnF4eGx0WHNL?=
 =?utf-8?B?ZkJIUm1yRmZjN1BxLzBxQkVxTVU4QTRTa04xOG1JclBabDVFUTJtTXg1Sms4?=
 =?utf-8?B?ODZIYnVCMUd5b3dmZFROVFl2QWd1WFZzamVmTkJnQTZlajBiWHNRLzdtRkFW?=
 =?utf-8?B?Q2lkOEs4dWlRMXV1b1FlWTlvR3NlK2xWdzAzUWZSVHhTT1BpTkFpd3A3OTFo?=
 =?utf-8?B?YVI2WlhpVUZkcVJudzJJL3BXQ2RRdUJjZnhIS21idEs5cmQzSmQ4Z20yeDRj?=
 =?utf-8?B?Z3Z3Ykh2WUhBRjAwMlNMWW5Uc3RVaWhUUHY3QWJNWlhBUmUwY2JWdnVrUzEx?=
 =?utf-8?B?YmFka0xJdnAyZi9wbyt0R3IzTFlnc3NQQS9ONUJwTWsxQ1BXOTBPMDVaWWVz?=
 =?utf-8?B?SHlrNGJUUFB4dVk5bHFhRUhFTVJBbTMrSDBKcTNmelRkSkhPRXNDckFJNnRn?=
 =?utf-8?B?UzU4MDVhbGhaeHVWWDl0RnhvaWNDcVg3RFdDbEFkR3ZPM2k3YlluNm1xcXlG?=
 =?utf-8?B?VTBXY1lqZVJBZTR5ay9GMkIxbGlPUzRSbFhOWXB2ZkVqL2dqUGdUV2VvM3V2?=
 =?utf-8?B?NnhlOXhRMHhpcUZhejE3L0x6UFUxZUxIYXhjbWNuVmZqd1F4TUtDT1RsTk9a?=
 =?utf-8?B?ZVl0WklXa0xOS0Zocy9tOHZhTjlYS3BMV2hqR3l0Wk85QjI1S0plNndzVW4z?=
 =?utf-8?B?NmFhKzBlTnl3bXFrNDFhcThTSVExZVI4dzQrYlhTOVBBZUkwTUhhRUJ2dkx1?=
 =?utf-8?B?YUZsWUVRV0tSU2t4L1BlMHFjRk9yQkNGMnYySHlIcDhCUGt4ZXdLdnUxQ0l5?=
 =?utf-8?B?eTFPOW9TS0tPZEhGSU9IVFlsdjU2dXVsZlJJL2N6TnRDamhBN2gwRUdMUS9M?=
 =?utf-8?B?b1FTU1pSSkpXVmxpQmpxMHVBVEFpbmVMSk9KSGsrSmJUOUwyYlk5VHo3Ync0?=
 =?utf-8?B?ZWZHanpnSEF5UDdyOVcyaWx0ei84WVRVTCtPV1FpV2xsdEZGU01ZQ3hXTnJ6?=
 =?utf-8?B?T1F3UFdqZjg1NlhYVWNvdEFib3hHdE9oVnNZVGF2em9rT3ZBMWZZMWl5a2Fp?=
 =?utf-8?B?SUhQaWo1MzBEc2JWVnlVRU1UQmVpNkVSdFF5Z1dJa2ZZN3NjZWtxS1prSU5F?=
 =?utf-8?B?MUs0cUxQQVNVZkxjR3hXallmcUdSYnlOaHZtQ1dEblVnWFRtdks1V003Vkpv?=
 =?utf-8?B?VkVvRU9sQW9lbVM1ck9YbUdvS0Q5OXU3dWZJZTVPd2pUZlhHeVJiWE05bGhH?=
 =?utf-8?B?TzlGMVZqK3JNVWxBbkwrTlR5cTJzTUVYOFMrRXM0L3dKUHRYb05Bc1BCZ1Iz?=
 =?utf-8?B?ZmVRT2JtKzR6ZERGTERxQ1kyWU42ZjdNZ3g2RkdrRU1DYTJXQmRqQXFNVWVq?=
 =?utf-8?B?bm16QmNWblhLMEZab21OUStPQ05wR3lPbnVYYzluYzV2U3pja2hLZno3cGdC?=
 =?utf-8?B?M2NUVFM4OWxxUXZPT1U5bHlYVVZmWGl3V290UlN5V2VNdFJkYnE5ajJpWlZP?=
 =?utf-8?B?SUcrZHVKOGtaUXJFUWFCMVJQODVaZjdNVVNjNndhbWN4OGk1OXpoL0tGbEpQ?=
 =?utf-8?B?L3dSeUJuSVJDOCt0cGY2M0IySFFIQWM2bEtDTUF3MTRldTBaRk84MFpXeXNs?=
 =?utf-8?B?MlRIOGxGUlQ3NGlBTkI0WG1rV0tjQTVXL0daTXFkc2E1bjNUUXhXdnZnSU4x?=
 =?utf-8?B?ZnprNkkzdEFtQ29nZnVnNURpZnd1emtUUmppbUVZNlV1SXd4dzRlMktVRU1z?=
 =?utf-8?B?SUJsVkJQSW4yd2E4MXE2cUcxK3E3V0p2R2FYRUZjd28rQXZVUzRnYkI4WWp5?=
 =?utf-8?B?WmdmOTZ6djNFN3VRalpGNEpWYXlLL2VUMkxncDBKWUhuRjJTTEtSLzF0ZkhK?=
 =?utf-8?B?bXErRmxnTFM1ZHkwc1R1S3ladVVrdTc2QkUzSEdXK2VUaFByWWFac0V3RkM3?=
 =?utf-8?Q?PnUI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabb6201-ce27-4872-f76a-08dcdbff9e66
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 18:43:30.2282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDEFyufiEIV2pAE5+bI+BPQK2n4f9h+jX2zkGuop8fvCKyt4nA7meK7bmwKIml0n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

Hi Reinette,

On 9/19/24 11:51, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>> supported, the bandwidth events can be configured to track specific
>> events. The event configuration is domain specific. ABMC (Assignable
>> Bandwidth Monitoring Counters) feature needs event configuration
>> information to assign hardware counter to an RMID. Event configurations
> 
> "to assign hardware counter" -> "to assign a hardware counter"?

Sure.

> 
>> are not stored in resctrl but instead always read from or written to
>> hardware directly when prompted by user space.
>>
>> Read the event configuration from the hardware during the domain
>> initialization. Save the configuration value in rdt_hw_mon_domain,
> 
> "rdt_hw_mon_domain" -> "struct rdt_hw_mon_domain"

Sure.

> 
>> so it can be used for counter assignment.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v7: Fixed initializing INVALID_CONFIG_VALUE to mbm_local_cfg in case of error.
>>
>> v6: Renamed resctrl_arch_mbm_evt_config -> resctrl_mbm_evt_config_init
>>     Initialized value to INVALID_CONFIG_VALUE if it is not configurable.
>>     Minor commit message update.
>>
>> v5: Exported mon_event_config_index_get.
>>     Renamed arch_domain_mbm_evt_config to resctrl_arch_mbm_evt_config.
>>
>> v4: Read the configuration information from the hardware to initialize.
>>     Added few commit messages.
>>     Fixed the tab spaces.
>>
>> v3: Minor changes related to rebase in mbm_config_write_domain.
>>
>> v2: No changes.
>> ---
>>  arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>  arch/x86/kernel/cpu/resctrl/internal.h |  9 +++++++++
>>  arch/x86/kernel/cpu/resctrl/monitor.c  | 26 ++++++++++++++++++++++++++
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +---
>>  4 files changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 00ad00258df2..2a4be004a2df 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -632,6 +632,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
>>  
>>  	arch_mon_domain_online(r, d);
>>  
>> +	resctrl_mbm_evt_config_init(hw_dom);
> 
> Now that the arch and fs separate becomes clear I wonder if it may help to understand
> this work if we start using clear namespaces to help this distinction. Surely the
> arch code is very inconsistent in this regard (thus this function fits in), but
> resctrl_ has to be the prefix for fs code.
> 

Will rename the function to arch_mbm_evt_config_init().
-- 
Thanks
Babu Moger

