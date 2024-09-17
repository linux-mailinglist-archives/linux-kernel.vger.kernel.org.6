Return-Path: <linux-kernel+bounces-332060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C517197B4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82191C22B29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232391917E0;
	Tue, 17 Sep 2024 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b8QwEcjR"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F313C3D5;
	Tue, 17 Sep 2024 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726606323; cv=fail; b=Q2POJ+FhewNfA7WDzX3QvWz0g3NyX/+vq9iieZpwpVK2BbxqigQLXwYg/8R4nJZ6rtcsIlGENxacVCBPiBt969GiHlHxC6Gz5flmz7nDUS4MLS0i9AL2qEnXkIb+/M7Cdd1Qu1KlRI6tJKn3EHr+SQWuTB7q5Q9Yad3L1JEF0b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726606323; c=relaxed/simple;
	bh=jUXIQzhb20kVvC3f1tSeTCIY2/7CL/ISBac5Xfc56YQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UwFQhM8/4nZ2hVgs9XDe0f/0kejP4LhWD6tHeb5nBKOS8JAdnRvGXDebpah75GY6ylyM1mDRfrXAatL4BHgl0/EJ8+3hJguz3RCra9viU0yeYP4KY/+q/jq8dM0o484qERwXC9d+ykf1PXVDA+Vmu4BTgJP2laT/5OEzfl3KDVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b8QwEcjR; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOWCyJftho+91eOEc/aNPe1JJmP0HspBB9BIY52aDgF6RatuoIqU9TSbkupTMd6tGPHVgqj4jLaau4qs8S2denHhYht6vuYGQ7IIO5lRBdwoSDJtKDVAJzR8vS18pGU62I840IOUsqlDdWdc4v4oJTpwaHu/8VoZVntPd5rIiMd0E4lssBsBTFXiRMFDtN7c8CjsMIy65K6/RpwokVoI1cfKU7fW0smgS9nimAjvGCJpX0QtwWgiezgouxquTapB7mkCh9sitOHF8tkNEIBHK1X9NEHKf5cR3jqEZqAEvMVs/u8Xv5u2RNkyYOYIPzx+OBaYsK0PxXWfQVwq8oe7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfHQgS0yB7z/UoqDQydqwHT5X9nJm7xPAFan1qh6p/8=;
 b=IiGk/XJrWQ7APfxlxhFJTVyoZtF3xJ/5GuIOXOqGPF67gE6bNz5nPk2aEzubVB96ciSJbnY6efDwpcGhNG2ugvN+Fw/mHWV1Oi7DKLgR80vx3TcucarSU7J+S362vAABA38YylWDfXxqG5clvr6HlbXAqIpDJIKuN4LM0VLlBUgJgkg80odLCiBdA4OQoYj+bLJ5eBpq3TjPVq68qC9E1GF8serT19UvZknwqkdjgQoT9GjWMKrcFMnMJ3vtOhAnlg8O12Kxt4cfNp5E9izwnCyyEv3aPR6Lk4uVj4I5J/rtyNgPZHZuUNTj2Yix7OIHeubaDB0E9vrF6aVOjY9t+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfHQgS0yB7z/UoqDQydqwHT5X9nJm7xPAFan1qh6p/8=;
 b=b8QwEcjRL6oDbx8+B0gNCCvcjw2WSFjKUcDPhxepMUeCt5Vb5Ubv/yR15GOhhn6210cF7Yj69GYCcfU5+QYZNdVBytTgHt/shn3wMtwA/qzIUoctLekPMizQ5yldURYML+ZXYHghTqKMalfSxwrF6yattIlGPImAfmidl7vFoL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 20:51:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 20:51:58 +0000
Message-ID: <cae62055-f244-4c3e-9d68-6e86b5e221b7@amd.com>
Date: Tue, 17 Sep 2024 15:51:54 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 0/7] x86/resctrl : Support L3 Smart Data Cache Injection
 Allocation Enforcement (SDCIAE)
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
 <902dbdb5-25c8-4330-a983-f76ae98f7493@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <902dbdb5-25c8-4330-a983-f76ae98f7493@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::12) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 84015715-96b8-4585-7744-08dcd75a9225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZklsRW9SaHJoOW10SlhGdVNuRm8xUjZtcWltaWZXWExQK0pFWEJwRDNOdEFK?=
 =?utf-8?B?WU5PUk1lNzNNeEhyMmxOZVRLbFZoU2lpaVBWT2Rncno1TTgzenRzeHh1NFZ6?=
 =?utf-8?B?TVVvN2xacTBMNllVSmtXNS9vRHA1V3FYelAyQmk0RFRjaEdjdW9jVHkyTzgw?=
 =?utf-8?B?S1dSdk5yemxFSmNuTnBhNk8vS3FWcEZSYW9KK1hkcnp1elQrZkFXSVI0czN4?=
 =?utf-8?B?aEI4cDZqNld5WGN6SVdjd2syM0xOeE1YSzRtM3FMeXNZNHNwODZVSkJpMW1l?=
 =?utf-8?B?MHpSWHdBdVdUN2FsTlZQMmJOMTlyMW15SldybVNLckY4ZGZtTGwxeUh3SWtM?=
 =?utf-8?B?OWdQWnJ6SHM2S05UUG1odEFpaUx6ejM5OStBYTdsc0N1OUFRSXdCbHQ2VzhP?=
 =?utf-8?B?Y2VHeDdxTEN4ckw2R1lKU0tFZDEwYjNvd0pyUFhiaFNSZWE2N0o0MXkyMEVV?=
 =?utf-8?B?THZDc2VQeXZody94Ty9DdEdxeVg2amo2cytRekVwbTg3b2xhcmh0bmlCNW9C?=
 =?utf-8?B?UmVUSThORlN4YUJvMDlaZmFiWG9EeGJHdGZwMi9EM2RkS0ZteHV6a2FFRmp0?=
 =?utf-8?B?OXVsUjBRblAreTIyRmpBZTd4S0MrOVpHbGNZbW1TVkpuVlIrQ3ZxZ0wvQmhi?=
 =?utf-8?B?RXppOEpDdHlFSTFOa2JGRnA5aXJ3MUREdy9adTJscjROSUoxR0VzQUR6WjUr?=
 =?utf-8?B?MGsxR3pEUnJTaGNCOVZma3VLS3hybkNJVmVwQ0FXRlNhdjRCQ1FaTTZWR0lq?=
 =?utf-8?B?bUpCZlJFL3lFd2pTd21ubW9pSFRUU3hzakZHdmFwajJjaVduTlZLM2tLMVFD?=
 =?utf-8?B?TUlWTjhETFh6VkJpMzYrMHZjMndjbnRMN3M5OG5PbDhjNlQ1UzlLdldCOTRq?=
 =?utf-8?B?Y2FNV1BqMWR2ZU1LMEQ3WEJzc3pyT25ZYVljanNCMmNwS29HQTIxb01tcmxB?=
 =?utf-8?B?a0k5ai9rVEZ3UkhnaXhuTi9yc2pjVmc3LzNJSWZiK1lHRUF5SEszeDNVeWlm?=
 =?utf-8?B?VlluRXdSVXNpdFBLZURMS0ltZEVUNllERmVoeWtuMnBLRkY2bldLWWhhVlU4?=
 =?utf-8?B?Z1ZSNEE5OGR3V3hiNHd1RFQ0TjZVK011SVkzSkkwZytQUjRyZUVuTUxreEtW?=
 =?utf-8?B?NWlBK3A2V0x0Qk1tMG9RQnpMQ1MxaXE0Nzh0YWJhZ3ZJWXpBeThsTVlQbGIx?=
 =?utf-8?B?Z29DL1Zrd0hoV0pXYkpxbmJ6dU9mK0xCby81S1UzQzRGNndBbDdBQm5qUjlM?=
 =?utf-8?B?dEt2ZFppN1NjYTNLQ0VvWGJ6R0JXVUZybGQ2TnVxQUs5N0s0Q3ArK2M0dHNx?=
 =?utf-8?B?ZlRBblRDd0JMdTFkM1VaUW1lV2N2ZlM1UVlRTUh4RE5XWFFTWEowZHRVRDdv?=
 =?utf-8?B?UlBEV0RBMHdYelBnbW5aa0drYmk2alVEeHBaSFpBMm5wWjZiRlNaaWhvc3FK?=
 =?utf-8?B?MmtSZy8wQkRQWS9lN0ZIMzBtWEhzVnF1allMYzVITWJUem1qVWlMZy9BeC9m?=
 =?utf-8?B?b3pOeFJKcW0vU2NPUEMzdm41ZWlLY3RYK3g1aW9PWWxIa2s1SGVuVHczdjNF?=
 =?utf-8?B?MHNpM3J2Y0IxTEkvUVlGa0UrRjRuZUV5aTN4VytaNFhaK0FFa0hoV3Q4SFRn?=
 =?utf-8?B?MDZTUUorMGQvUE9MRHhKNFZ3L1BYcjhCTjNlakplKzBCN01CR0N0dStrd2Y3?=
 =?utf-8?B?VTYzVURVZVZ2MGFxbUVueFUzc0dZMjRkbEJCaG8wN3djWldjMDJLbk45Q1Jv?=
 =?utf-8?B?Z2Q5eEtOQ3Biajc5cGl2RXRtTGJxeUVHODNobThtb3RDV0I5emozNVJZRE5j?=
 =?utf-8?Q?aoozBkiiqVR354Ql0zFY40b+8OfJ53SXUrpWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmNzNDBIQzJkQUprQWp1eEp6YVFZNU9yTVpmRTVLa2pLRm91RkxLbFl2R2Fy?=
 =?utf-8?B?RFBRRWN3OU41N2M0VGN4ZTBMZ280M0h2bVFnRjdqZEdGWGtUS1Y0RUsvNXJz?=
 =?utf-8?B?T2svelQrR3d5MTF1ZkxuNThyT0NPcllDMTN3ak5lL1duRTN5OVpCY20zdTFo?=
 =?utf-8?B?ZzU0ZDZSMEpWUVNNUE1DdldhaFk4U09wa0xJOXA5S3FsTDBSd25LVXcvMGNp?=
 =?utf-8?B?ei8zNUtDTVZiK3RuTGpteGZWbUo4N3R5Zmthem81L0hPd0RVdm1oeHhwbHV2?=
 =?utf-8?B?TW1pdzhqeWF4QU5CZ3I1bXllemx1bnhqWUVtYzdVWC9KRzc0MGYvbldKblVv?=
 =?utf-8?B?eEl2ekYyWEIybVVFRGRNdXFjaEFWQ1NXK1o2TmMvbU9yTFZDSC9wd29tUURy?=
 =?utf-8?B?MXJvTkRCSUI1c1FuUW9JRVdaUFFQc2xjVWwxRGF0azdBWXZYMDRCRk5CUTBx?=
 =?utf-8?B?cFhKeXhPZEROdnRuSzl3TUx6ZVN3cmVIRWxkb0J3UTBiRklHTS94WXBWVDJa?=
 =?utf-8?B?MEdwZUlwWW1EdlJTZDRVcDdpSTRzUnYyamJYK010bVhlZEZodENNMktxUGJJ?=
 =?utf-8?B?Z2Ric0Vhc1ljVE50ZmdUc0ZMUkZvTk1KRGw0eHlwcGVyRld6VHBFL3lhUldo?=
 =?utf-8?B?YmdMU2J3K0xHWFdXL3hjaGpKNEZWRkxFaTl2NUNxUlZDWElMOU9FcElKVXY4?=
 =?utf-8?B?eFkxTHBNUWVTbjFrUGdDSG01elFLU2JTTWVBUm5RSFVneW1TWDVnMk41d0pL?=
 =?utf-8?B?aFVWQ3pTYVRYMUk0ckluVWNHNW1INTgzVmNlU0RWV2oyMTM0cWVxSWlZaVdI?=
 =?utf-8?B?L2hYY2d0OHdYU2xuc3cyVURRdXlZeDczeGdyeWV3ZFBJbDdscHRpMUJhTVBa?=
 =?utf-8?B?V0E1Q2FFZnpRUnlEQUo4SFNBWDhienkvajBWRVgxS2FNa2pMVHNBeTNDVjZu?=
 =?utf-8?B?RXhXRWVhWGdTa3J1SE1iTEV5d0pGTzJrNk1NRllrdWJxd3UrNG5EVXFDTzBm?=
 =?utf-8?B?Vk4yMVVmVGFicEgzRXdWWElRU1dVRGg5OXdzVnczMm00NGw2d29zOXcxa1VO?=
 =?utf-8?B?KzBrcFJHMFh2WXZEOEpMSmhRZmdiNGRzMlNIQVkxaGFEWUhxT1cxdzhMdGFB?=
 =?utf-8?B?NHlhTHFhY2lLb0ZrcmFHTTJKTXhFUy9FbUE2aVVHZXhuUUN0NGhLdlJnMGUz?=
 =?utf-8?B?eisxaFJ5b1dUWGJMeU5BWnhmWVZWaU84UUY1c09NaWNVOE5xTVpyQWsrS0RW?=
 =?utf-8?B?bGJDSWhxZlFGWG5aanJ2OGR2M0ZQS3FWM1RZQU5BRWEweG9wMlR0cGx4UVRF?=
 =?utf-8?B?M092a3BLbVFrbEw1ZmZuNXZpU0poK2R5aTNZTHU4TFRuZmptMTZ6ZnVVOVZi?=
 =?utf-8?B?U3grYzJRc3p3dVpaVHJHckp4OFJjdmRHRUU4NUdqbWxEcTdlbldJU0ZFQnox?=
 =?utf-8?B?TGp2dDJydnR0STBWV1NMazNNbzY0Q2EvQWREUXdiRXFIaXcxc1BYLzRiN0lL?=
 =?utf-8?B?VFIzNWJiSXJaN0pkMVRUU2hVMS9USEVtbVBGMk1wMzV2SXFZQ3o3ay9UQTZP?=
 =?utf-8?B?bDhzb3VMT2JtdzhCTXBIUXdpTk5uKzZ4Z2NnUFNUNU1sakhYVjNyc1B4K3Iw?=
 =?utf-8?B?QmRQRXkwd1ZMREk4U1dvYnBxdGF1Rm04MHc1d1RuTUljZWVVd1JibUNKUktI?=
 =?utf-8?B?NllKdktSZS92eXMrUHhBcDlKZjFNS0Roc2FIYldYcHQwQ0tDQUx5SjZOSVkz?=
 =?utf-8?B?aWRSMWUwSXAyazBBRWpSMWpjOHJEQUtaV2NEdk10czJjMTRGTmpjcUJXYzZ1?=
 =?utf-8?B?d1J6Nm5ZaXpHYXlUOG51MkpBU3I0TkF4clRLSnI3Q0JraHVldDRHc2Ewazd3?=
 =?utf-8?B?VFlGNFBBNEk5UmNUcWcvSTRMZnViMEhxZEVXeHdsUVBrYnZhWlhibUc3S0g4?=
 =?utf-8?B?WjBERmRnM09IMGNBeDNINkxuVWROMDVLbm90Qnd4Mys5b0VadFllSTN1UWxH?=
 =?utf-8?B?a0U0Y1dDelh0TXllTmNYVVpOdEtLL09ManIxbWd2cEtTeGVudTBKZFpQbnhi?=
 =?utf-8?B?MllJMHBiWGN5QXZEbUs0THF0ejRKMkJwQ2hQY2VRV2dPU0xIV2REZU54cUg1?=
 =?utf-8?Q?XFxs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84015715-96b8-4585-7744-08dcd75a9225
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 20:51:58.0142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQUom7kkL2oU50zIJy/t5IAGJG+/rIO4zMu/tj4rSVVXxnCQdXqJgHYDDURdQoE7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593

Hi Reinette,

Thanks for the feedback.

On 9/13/24 15:44, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/16/24 9:16 AM, Babu Moger wrote:
>>
>> This series adds the support for L3 Smart Data Cache Injection Allocation
>> Enforcement (SDCIAE) to resctrl infrastructure.
>>
>> Upcoming AMD hardware implements Smart Data Cache Injection (SDCI).
>> Smart Data Cache Injection (SDCI) is a mechanism that enables direct
>> insertion of data from I/O devices into the L3 cache. By directly caching
>> data from I/O devices rather than first storing the I/O data in DRAM, SDCI
>> reduces demands on DRAM bandwidth and reduces latency to the processor
>> consuming the I/O data. The SDCIAE (SDCI Allocation Enforcement) PQE
>> feature allows system software to limit the portion of the L3 cache used
>> for SDCI.
>>
> 
> This series introduces new user interface. Could you please describe the
> new user interface in the cover letter and how users are expected to interact
> with this interface to be able to use this new feature? Please also describe
> the impact on existing resctrl interfaces related to cache allocation from
> I/O hardware, for example "shareable_bits", "bit_usage", etc. These existing
> interfaces are used to communicate to user space how portions of cache are
> used by I/O hardware but I cannot tell from this series how this work
> builds on
> this.

Sure. Will add interface details and bit mask usage.

> 
> How does this feature work with the existing "L3 Cache Allocation Sharing
> Mask"
> that is enumerated as part of CAT feature?

Sharing is allowed as it is right now. SDCIAE cannot use the masks that
are exclusive.

> 
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
>> Injection Allocation Enforcement (SDCIAE)
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>
>> The feature requires linux support of TPH (TLP Processing Hints).
>> The support is ongoing and patches are currently under review.
>> https://lore.kernel.org/lkml/20240717205511.2541693-2-wei.huang2@amd.com/
> 
> Please note that the cover letter [1] of that series mentions "Cache
> Injection
> allows PCIe endpoints to inject I/O Coherent DMA writes directly into an
> L2 ..."
> while this series implements and refers to L3 only.

SDCIAE only applies to L3 insertion. SDCIAE has no impact on SDCI
insertion into the L2.

SDCI lines will be inserted into the L3 after being evicted by L2 based on
the maximum CLOS(CLOSIS 15) allocation mask when SDCIAE is enabled. By
limiting the number of ways in L3, it will impact the SDCI cache occupancy
in L3.
-- 
Thanks
Babu Moger

