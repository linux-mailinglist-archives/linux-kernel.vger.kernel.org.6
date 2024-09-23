Return-Path: <linux-kernel+bounces-336292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F6A97F1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECDEB21B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6225317BD6;
	Mon, 23 Sep 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oq7+VQum"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC4819F105;
	Mon, 23 Sep 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727122880; cv=fail; b=BBG7f3e9YfuJ+S0menelz8fR0By9dKiyRuSZwjCtkyRgz17/BNhLSvnN5Db8q0fDcJvjnvPih3VA+VZcRzjunntj7+sxXJgUau59ocqEfqPLT8NkOmFcEI2zmrourm+8hU/eRKPY6adRoUVXWUKAI96BM2CyZkIRFJnQZ8daWHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727122880; c=relaxed/simple;
	bh=ZdEUIZ1rhG6579c6yMp9O0PiXclVzurv6Lzrf//4VmY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NpA8SmjEBLIiOKpC8Ji8JbZa60Om3ZYfqdTSKuVYs5ddP254M9LwW8Xjc0WKysYNRyqNamRGfQCOAT+J4JCuHgO3oHvWFFCOf3jDp6AexQUlkTyTq6qPP7NGEf41tQMR/YaqqobRrDcoOxMhZvZi0sGzQnQBI3hnzHVsSTL6FK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oq7+VQum; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWRiZ1MZ8hgyeo8Fv2dzbxqu+6OYu8zqAO+Z7UDREJNejP2cpgNfmbpGGVZ1k25FdqZ5xxlQO49r6cI0NsNRxcu38Gf21jNQlPq9CNJRkPlm1LR9AaLOOUBeVLegcYYrLBok/0VlUStNA+zcTU3R4sIcf1anL0V/7ha12laY3/mPHNNNC5l5EUXRukXf+wlAbjXxVl6fOYS/Knv4dplPDyW4+JU2tFqvIgI+gMWiYO3ewBtWpAqPpNWR9a+IQyXDZF5uztLIXPl6rerMOSGZq29+Y2jbophjA+AaODC5KpVdAqajJcU1K5evjPAy/dK+4zQhmevlmF/Oq37S//+FVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZn9JVHcXZ8zPbR0u4sXijIOgYwuGa9eEajmn8XEGtE=;
 b=L5NVexzZ+zjFIAr9whX65XbnK57e7z9jPttNIm53uHOarFN0qST3ATqeKK0VPyrZe2fglH5vYtAT7qu073n0BwlAxlRPZiQzNfPIChFCCCO+7kHSFLXHB7tLMfDYBwNUsOQR8PHBCrbG3++kFyCVbx0BtstXUg2teW4zfDxJGvw2fMrJ2o33eKx6ckqazyeMA8zdStQq4Qs/XBz3vdMTN35c7IKw7b7UFZ1mBSeVf/N8g/1Lp19FoYksSHjhSFiy3VQllE0sEHRH5vxzXfUYA8XV2T50EXxfPcZYGTixJRIDhKds3dj2t+Y6ocYJFczJ+z94IdLarfW1HU9bc5HYoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZn9JVHcXZ8zPbR0u4sXijIOgYwuGa9eEajmn8XEGtE=;
 b=Oq7+VQum1rq3AFsL3Tz8Wg0hHACzdYrod24Z4HWvtrIncXihJqHYHDhgvbhf3Kgpom967/MeXFhLaqzcaO7EQLJXW+KC+/oa9N9SZWQ5m+zx/EbpO1ASjPS/YX+P4bxkP+WfKCdc/xzQy3HnDL7YJLnk/geaqkdCDOuaJV+dYsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 23 Sep
 2024 20:21:16 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 20:21:16 +0000
Message-ID: <520817d3-6521-4320-b6a2-d0695a5d3699@amd.com>
Date: Mon, 23 Sep 2024 15:21:12 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 13/24] x86/resctrl: Add data structures and definitions
 for ABMC assignment
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
 <e0520492d3417df6f708c7ff7b9163b64843fc77.1725488488.git.babu.moger@amd.com>
 <02f1a542-f642-4efd-898a-a604e3a741f9@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <02f1a542-f642-4efd-898a-a604e3a741f9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:806:d1::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 319498de-9629-477d-5e03-08dcdc0d46df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RktsODNpZ0dGdTIyNTZnUWRlNWs2RVVWcjAxOGpGY2VWdGd3Qkphdzh4RWhG?=
 =?utf-8?B?OTFWOHZrbzg4V3hHdHpMRFZDdHU4aEpiekV0WlcrWDd2WGFGVy9DS1lRaEtU?=
 =?utf-8?B?ZVMzem03QWpodUZ5UWFuRDFSQy9Sd1hheTVFRHordXgwaUVGVU9vbE4vZm9v?=
 =?utf-8?B?dzBvZE5kS0xudDkwRkdjZzRiMTdEdUE0NXNlSitJaWNYSVpEZzZtYWFaWWlH?=
 =?utf-8?B?dVd4Z3A1U1hSVGcrVE5BUUg4TDRsdXNPNVBCUEV3TUVFNWFFbU9pWnBYU2xF?=
 =?utf-8?B?dzZHMVZ0SWZzL0x0bEpHcDhTSkE1V25tNC9PSXFBS3R4Z3NPRGRqSC90Nkl2?=
 =?utf-8?B?KzI5VEJXdWZPajZEOTFVdGxCZUM5NGl0QlJDaGFOZy9TR3phTmdLY2xMTkhP?=
 =?utf-8?B?dDlJR2FUM0pmMjBHR0FFRnd3ZHhuVUpYR1RlbHMzeHN1VEdNNlc5b0M0eGd0?=
 =?utf-8?B?dnlPdmx1Vms4U2VudzlOTmpyTUUrWWpaUVMxdkJydnNWdEpnVythRkZvMnNp?=
 =?utf-8?B?WVB4YTM4VXlkOTVXd1hQdGxaN1UzaERXSGdwdndSODBkMUF2c3ZkSWtBQ08v?=
 =?utf-8?B?ZFk0dDkwckFOSS9oMEI2SFNDQmFKY0o2bW9sNUp4WEc0em5BVzFJNGVjSFBW?=
 =?utf-8?B?WmprNzZ6KzBNTWdTOEIvQlNwelduRDBlQjMzckNncVQxV2xSd3JlZ2JsZWNw?=
 =?utf-8?B?OEMxR3VHYmVSd3A3djltQVF0OFQ5RFQ1TmEzNGNWbVpuZ0ZKQlo0VURGSHdt?=
 =?utf-8?B?Nm8xRG4xcDRNT3FBaDRVNjhreUVocS9jbGtaK2xIdDQ3YkU0Rktxdi9yVlRZ?=
 =?utf-8?B?ZVdiZk84TnE4SE9LbnBlSTVlZmFRU0dNSDdLUjUyalB6Si92dnZ5WCtNd1FU?=
 =?utf-8?B?anJqQjhQd2lyOGZzdVJDTGtyRG9kQUFvK2Y3RXN1aWtyaURKaHF1dkZ2dmNB?=
 =?utf-8?B?UmVvbzJBQVl0RFJlcmh5S2duT1VyMmY1NzlOMWNDSFVMYVBDZmNEbzkyUitu?=
 =?utf-8?B?Q1NFbDZPbTJTb1RNVTViSzU0ZGZoSGlaTWVYUE4wVGIrRWg3QXJnRlNwWE9B?=
 =?utf-8?B?Z2pkMFMxZ2tNWndYWXdYMFA4cWNEcTNNYnh6R1VnVitnS1UwZ0thK3pyaHNr?=
 =?utf-8?B?ak5pSXdEN2hXendLUFJnNW82UDgyc3BHbzA2Q2NOWXd1dXRGV3NwdDlPdkZk?=
 =?utf-8?B?UHFsaTFVcnpmOStsNmlpNm9WUE92cWp2V2dlSTE4ejQ2aVBvNnhwb2g3bGhR?=
 =?utf-8?B?TmJpeCtqdTFleWdUNXkxSFlCUW5wYU1JaDd6MkpBcDd2clJVVy9WazRPWms1?=
 =?utf-8?B?b1MxdmF4K3Y2cFpiOGdaWDhDbWsveDZLYTh1MkVvdHFndGNBSmVLK01qazZX?=
 =?utf-8?B?ckpQQSswTDl1UU15OWxqeWlBVVdJVlR2bHlpMThFOVVXOFFaTkNmWTE3dFpj?=
 =?utf-8?B?dWtLY3YwUXBFTWw5K2dvWldpSmk5d0RTMUZUL1pUOWlTaGtzMDhEaEpyM2ZC?=
 =?utf-8?B?d2l1TWU3S0Naa2pVcFlNcGRxOGFGSWdEdC9Ya0R4MDhWdHRLWnFVZGd4djFw?=
 =?utf-8?B?dWRPdllDeXZqM0tCYnpEUUtmOTFnS3lLU2FsckIvY3p5YVNSUHB2SnpUZDNQ?=
 =?utf-8?B?T2lrakJEMzdLQ3R3WkswS0dZaWJMNHA2VnNSa1ZsWjgyQjM0SC9ZSXQ5NlIy?=
 =?utf-8?B?V05RVlQ2MVZ1aFY4QlJyOWdSc2Z1azlYT2M1YWFzdXJ6SlRxQUZ0Qkc3Szdj?=
 =?utf-8?B?M3oxME1iYTRWeWlsSUlzMGhzSURPYVBLRE9iY2JVcm8ybHdjNjh5TFpLQjJk?=
 =?utf-8?B?L1dUZkJoMys5TnR3bnVDZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y01pVnJjOFl4VG9yaGtUVDFHeHpqMXVaRXRHTG96YVNvZ2FlKzBLVmpyK1Nu?=
 =?utf-8?B?MmpleGp6U09HRFlwd2xvb2VBN0phaklqYmtrSS8zbXBOQzlodlhIckQ2b0ZT?=
 =?utf-8?B?MUVPcC81TldDTk43Rnd5QS9KYS9iRXRTK2tHNEdlUkUyam9MQlhXZU92YXJL?=
 =?utf-8?B?Tkpieis4TnlTRmwyZDJyQTRRcnRZQXNKSzR3QWNKdTh2TjFVaGs1T0t3ZE5X?=
 =?utf-8?B?Z1huVUF2T0UrZ1hiNjF2SHpLdHZXK280NVkxQmhaVHhNU2VSK0s1aFdtdll0?=
 =?utf-8?B?Kzh6VXNUM2NjbE1kNU0rMzBFckVPRDljaVVlWmIrWjM5bmNZSVlldTFqc2Iv?=
 =?utf-8?B?ZmhJWlkzbWJQcDgrZGpuVzFqaVBMcG5lTVJvaW83ckNYdGd2akl6QXRGKzRS?=
 =?utf-8?B?RkZBT25oU0oxUGxVMTFQSS83ZGN4eWcwUWpuRERjS3lFYjJTUG5YZVBaUEdG?=
 =?utf-8?B?eVVRb3pqcEVGUzJ4YlI2RTh0Nit6c1dpbFovMWtXWkx0M1c3MDZsUTQ5OG9B?=
 =?utf-8?B?QmJUQytmU0c2bUFMd20vNnJ6WVV3NEIzQ1FuZkNISUt0R3Y1a3VINytkWnVx?=
 =?utf-8?B?RFVqQ3FnVkRSVmxyR2lJb1g2SlI5RGdseDNvc0Q3MktMVmpzQWJwbmFVRVhM?=
 =?utf-8?B?RW9nSmM4S0ZSSzYvNE4yMmpGcWlUMCt0NmtldlZOUm5XYXE3bElEYUs2TlQv?=
 =?utf-8?B?dk12M25RMlhjWWJleEZocnExK1Ivb3llSVFvRndWc1pZeldFOWtZMjdoL1Ft?=
 =?utf-8?B?NFUyU0xaT1ZjUmYzUnluR2JJMWNaeXAwWFdPWnI2eXR1OFRZbXRRNUNPS3Q5?=
 =?utf-8?B?YW5IYkJwZm9MMlhuNk1rMzIvb0JvV1J3bHgrUE5SMm9QMXBjd0hSTGliam9J?=
 =?utf-8?B?K0RLbUs4Q2I3VkpFdmN6a1JWcnEzaEpKd241SElxaVlVS1FnL1FYNlI5dzBp?=
 =?utf-8?B?aW0ybDdhN0U2cWF3NDJZZzN5VEpsRUhvM05yZjgwenRTalhUb1NiNkozWTZ1?=
 =?utf-8?B?ZGNxRmhKZko0Wml5RTNHNURGRXVWUU91Wmx4clZOdVJsUVdRMFc1RWJUbExQ?=
 =?utf-8?B?ZkJVNEJweHUyUy84MGJRSitSdENGQ1N2MG1OVVVzc1RuSmFSampsclFzL3lt?=
 =?utf-8?B?Q20rUk50b2hFNG1qeHdCQW90azdjQW0wZzNVY1g4eEhTSGNRQXcvdThsSlI2?=
 =?utf-8?B?MzRqRVlOb1RZQkNWODdPTm9zWFV3OVRPQ3hUNjk2SExzVVdoUzVCa1YxVTEx?=
 =?utf-8?B?Qk9sanJzVE9NRFlLcnFCVFVrV3ZBWVlIalVBeGtodHY2L0pQb2VkMElxTHRR?=
 =?utf-8?B?djV2alVBL0g4RmFxczkrZjhTc0JPOXdxRVJUc0FxSEY1WWtMaisyR3o4Z01o?=
 =?utf-8?B?K1o0VWtXMjBONVc5bmR6Y0dLeUJKYnpaQ0wxT2JsQ1FMcXNVRStwaUMvTXRL?=
 =?utf-8?B?MG5EWUYyV0hwN0lrRTFtVWNwUmdndnAwQ0lkTStJbElxU2g2T3I3MzIxR1Rr?=
 =?utf-8?B?V2JPZXprUmRiUWVTN3BnWDYxVkI2QTNQQTRZY09pa1pJR2xlcGNQTnZ0M24y?=
 =?utf-8?B?K3hJS3A3eC9XZmt1M1FsT0U2MGJTZVRNYXFZUkdVUDJQVUFkdHJEMjluRnJz?=
 =?utf-8?B?dWhlYUJnMzdnSGpwT0hVUEMyVUp3MHNJOHJMMHFNTGlRU2Ixa1h6dXFUWmRY?=
 =?utf-8?B?alFHOXZ1bXFDQUg1RVN4ZVpkV016SDhpMXlhUmtjRmI0Rkw1TGZlWjl5bzRS?=
 =?utf-8?B?VVVpTmxQVTZ2aEhPdU9Bb2IrQndIK3NDMEYwN0xoQXg3Q2x1VnlHL1pCUGgx?=
 =?utf-8?B?QjZoZDJNZTlmb01IVUN2WmRIaVF0bmd1NXhQRWppbzMrek5LSmtUWmhMb005?=
 =?utf-8?B?UjJtM0ZEWGtEelhHYXFpb2lnQWdMRGVIcUhkbml4VVhCZjY3VXJPc1dMNnZD?=
 =?utf-8?B?L2NCM0VhNGZ6R1NLTmZvNkI3MStZUnZIM2FqbzUrazdCTms0RTVxSkNwTGUw?=
 =?utf-8?B?ekFJd2hPZ1I0RXJCcGM3akgvTlhIRVd6T0VaTC9KYklBSW5rY0pJZlFzOHBS?=
 =?utf-8?B?OHNmQXZoN1BEbVVnYzJRVjhYdTljMm9sQ0Nuc1VENUZ6T0E3ZkJtcE9QMkdy?=
 =?utf-8?Q?IpDw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319498de-9629-477d-5e03-08dcdc0d46df
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 20:21:16.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mb/5BgqIYrqvdiQdpMQUiZY8mjqq0rNRsjw8vWpnJvITx+aoy/kEVSGr4YlzBoVw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979

Hi Reinette,

On 9/19/24 12:08, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/4/24 3:21 PM, Babu Moger wrote:
>> +/*
>> + * ABMC counters can be configured by writing to L3_QOS_ABMC_CFG.
>> + * @bw_type		: Bandwidth configuration(supported by BMEC)
>> + *			  tracked by the @cntr_id.
>> + * @bw_src		: Bandwidth source (RMID or CLOSID).
>> + * @reserved1		: Reserved.
>> + * @is_clos		: @bw_src field is a CLOSID (not an RMID).
>> + * @cntr_id		: Counter identifier.
>> + * @reserved		: Reserved.
>> + * @cntr_en		: Tracking enable bit.
>> + * @cfg_en		: Configuration enable bit.
>> + *
>> + * Configuration and tracking:
>> + * CfgEn=1,CtrEn=0 : Configure CtrID and but no tracking the events yet.
>> + * CfgEn=1,CtrEn=1 : Configure CtrID and start tracking events.
> 
> Thanks for moving the text ... could it now be made to match the new (outside
> AMD arch document) destination? For example, "CfgEn" becomes "@cfg_en",

Sure. Will do.

> "CtrID" becomes "@cntr_id" etc. Also please fix language, for example
> what does "and but no tracking the events yet" mean? So far this work
> has focused on "counting" vs "not counting" events and it is not

I will change the text to "not counting".  Hope this will clarify here.

> clear how this "tracking" fits it ... this seems to be the hardware
> view that means "tracking the RMID to which @cntr_id is assigned"?
> Please help readers to understand how the implementation is supported
> by the hardware.

I have checked with hw team on this.
CfgEn: This corresponds counter assignment.
CtrEn: This is to start or stop counting.
       We always set this to 1 to start counting.
-- 
Thanks
Babu Moger

