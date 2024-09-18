Return-Path: <linux-kernel+bounces-332182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738DA97B681
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 02:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E0D1F23B91
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F116AAD;
	Wed, 18 Sep 2024 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l3UYZN+e"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4A4C74;
	Wed, 18 Sep 2024 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726620611; cv=fail; b=Chg8fIXqYYI+sY7H1H1Lh9/HWnHhLRCPn5A2HI98n7DZes0ldzXlOqYdL25XPFteMc9665j60GpL1pqBEBqHurHDrkPEvCdmQbHfi2FyQwcgRVJBLHtHYFp7Ki97X+MTZSkihT2Mbam+mqhcXmhu3StyEWwfBCsFH+hqYlQL3MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726620611; c=relaxed/simple;
	bh=NhH+sM0NOYfhpK3hQcerihpklWTSjUEoETXRUblOObE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/LFrqWvf+F2aoK8qu/iejfCCr4Rg3xrQcf8zNKD1QB7Yegc16u7oVQ9Y+MPX/nlDwnEGtj+SfGeyR7u7Ob0UQioSofneR+Vd9rKXQj7g+ge5gZ0Uj7cjoFvheVBRvfwVZVcy1QaWcNgHiPfaVIAupmZPphQ3bKpSGOtXRLeqgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l3UYZN+e; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DA0NYzzCdfrUOAEznUSK8XlGPntslnVHJcJHMvJxndIhm/t6ZRxR8Yyvl8KOQFlhhKGyZeHZhBneFlNhmA3wxyxaZQ7Vx/aEn9t+cmpnJ8sWKc3s7XZSSloQalBssKNIX8jA8wU10kqMPeljwWCHapkzgVAcsGpFL/fkOzTs9qMidv+Tsl0Xgej87pcBo73/nY46PfS3hCfudGn97t2dErML6lq0WJ0S224iqfU5ofLuw6v0cWM1YFfWdk7y+kaLBmshYeDSXNFucyY0PUGk6gX4i6TgwR+6qvMH/86+MFab9r3fG8ci2jSNVULBBhdMvcctuHIHhyKhc5L08LV1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmkKhnIbanF3kheYKOXMU0qDD0FqxIWyOicejwf6tSo=;
 b=ha3C9lm4CmZHDJeISFXKXcr1t7mhKA2EonP14iMm2HecJgJmw+Jpq6wG1oovSi8c/MePfCfFV8xdhVNSwumh+Pm5lRZY9MdiS852FSl8P07yi3N4rMl0In8WFT6ULsopxDkoSpNhz+MaPHtS4vzWodwQFEmz8AYD7Qf67Ew8IXXC/g+Rwf9hXyIfdOGRA/C/tMJCARYZ8+X//37RY7mbH9fR/QQXkgiVdob310LtucyLCfI0Cd0ku2kNTwuIONuQwvWrqsdPFmm8U3JOVb6kC5I1bPgjS6SXAMU14v5MSf3DPuS1w4Y/iSx8hrCOULshm1Tkdtpno0XUQAOYlV+deQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmkKhnIbanF3kheYKOXMU0qDD0FqxIWyOicejwf6tSo=;
 b=l3UYZN+eVevghdY8hUn4b3MiNd5xO7Mpuey+zbNEUOeG/ttQpTCCMskl23oEGXN0DsBPnnBkJq91s6YjVGUl9x2wpac5C68cf1X2C+PfnLPzJ6fzP29V7+GuCtuOKuCB+FCt2P3mkiE0YgA14PyfExnaTE+gcsZxhrEJcaWdw5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Wed, 18 Sep
 2024 00:50:06 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 00:50:06 +0000
Message-ID: <87be60f3-de09-54d0-bc36-f77a7a90667b@amd.com>
Date: Tue, 17 Sep 2024 19:50:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 1/7] x86/cpufeatures: Add support for L3 Smart Data Cache
 Injection Allocation Enforcement
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
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
 <8378af17a73455661845830b40864ec1cbc303ff.1723824984.git.babu.moger@amd.com>
 <d2083424-409a-4b41-8996-d8ff9f51db2c@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <d2083424-409a-4b41-8996-d8ff9f51db2c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 1987b4d3-dd46-4847-b9d1-08dcd77bd68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGlPSDhWRms1L0k3emVsR25nMUlYZ1U0L0RwZ1BaRE1PbGY3VCtlSVR5Sm4y?=
 =?utf-8?B?LzFnNkZySGN3VXZhdS9iOFRMTWh1RTBya0FGV0l4ZW42bzdXVFVvTmx3Q3RX?=
 =?utf-8?B?UndPcndJOEh6MTZYY0syRHVjOUNIWnR1KzRYdUo5SDYwZXZEa1J1OWI4TENq?=
 =?utf-8?B?SVRMRnZLZmp4MUJRYmw5c2lFSjZOcXprMnk2RnRqcTBCYjdYSzNRTDI3Vlox?=
 =?utf-8?B?aHdLVkxwMCsrbjZxcisrY0lKZ25qUUh4RG5FOHNTZ1hXcVdncUlOaDdtY25r?=
 =?utf-8?B?cHFmREZrUnRRWFNLN0FRczRWelhEMXdBcURoOXJaTS91NTNWMnIxclZBTHMv?=
 =?utf-8?B?NHpPWUtJVzNaQ24yUFl3QVY5ZDRucXRJZU85ZTZubElkWDBkVStmdmZqaXBo?=
 =?utf-8?B?VEMzMjR6S1lFVll0Y1U3bmdCOWNZMGdnZzFFNDU5NG9USUpYc0hEUHpVWS8y?=
 =?utf-8?B?UUppK0d2S0lsNzZEUmROeVZnUVhPMkxESUcvcGpFYi9waW9ZdHgvYnB5Ukxn?=
 =?utf-8?B?d2lLa25pYmt3MDRFQ2lvdmN6MnA2THNIaTQ1YkZwNVpDOFBQQllVblFtM0Q1?=
 =?utf-8?B?NjM5dUkvRjRjbGZ2QzBTR0RrZ2xJbTlOb3Z1cUxrSU9CWnd0ZC9scWM1NENB?=
 =?utf-8?B?UEdRNTZ0RU0yUFprNkthV2JBZWMwaEVBQXJxS051YU9UTGJNaDB3YjZoZllX?=
 =?utf-8?B?TjVLUHk1cHpmSWhlQTlGS2FHM3QyNmZGTVp6dTVjOXl3Kyt1SDVFQnFBRWdG?=
 =?utf-8?B?RHVnRCtsR1hCUHY2TTV1cXFSa3hJUTh2MngvWmJLNjVPaVhhdUJXVWNEeS92?=
 =?utf-8?B?YnNqOHlJTlFVTDBQbG5XKzNqZDhVeXNDbEx0bXFzVkJGc1p0Vk5yLzJtK3FL?=
 =?utf-8?B?NlhoWkplb01CU04yYmF3czRVTU9TWFlQcUNVUk9SSUlQRVFBWHQ3YzRhOGtK?=
 =?utf-8?B?empQeXpxTjNTcm9sK3c2Tk1MSFh5TmY0ZU1Md1hCUEVzcmNBZUErYVEvSFl2?=
 =?utf-8?B?Tk9lQXZVRnY0SjFneUFJNElhZS9GekRGVHBEY01LNnNjS0tNc0ZZVm05cG55?=
 =?utf-8?B?QUJYMkpyL2xuZ3ZzMDB0SmpMcWN6U1pnNVdMMWk1VEFVV0duV1d1b2VBMTdh?=
 =?utf-8?B?Sk5PY1pRZURER2JvWS9MWFVLem03Q2thODZFQUhYdFR5WVhZQ2V1VURNV0hZ?=
 =?utf-8?B?U0svdGE3Yno5TDRncG1ONXp5RlhXRTNyVHk0SjZRdW54WTk4d0liKzZEOEN4?=
 =?utf-8?B?akd1SWJUSTlSOUkzb0RYQUVlNm03L0kyREZLeGVPTmxnYVQwWUNjNTI4b2hZ?=
 =?utf-8?B?SExuc2dEL3RsVSswUHlTcUdqdE5GZkVRS1BHYUlkamdhcncrT0dPZ1d4YUtO?=
 =?utf-8?B?RnFYZWJPTGNaMEI4OVpNSklQMGRndlRaT0VFMTNVU2tMRFh3Y1ZENWlKelkr?=
 =?utf-8?B?Q3dpSEh1RTQ3QVp1VTE5VzMwbWcwRUZsMStWL3l6VnArb1VHODlzbi9BOWU0?=
 =?utf-8?B?SVVxbjExOUF6djZ3eUVmYjRRL01HNTROUzU3dXFqZlZOV1RPNTJzR3dKeHYr?=
 =?utf-8?B?RHlSV2o1dWZlVEVXNk1ldGF1TWhzRjQ2dzRZRU5PTUVyczg4QXdwM29ueXN0?=
 =?utf-8?B?aEJYSEoxcWR3TTN5NHdYazFCbkpoQTNwWDdSUFJSZzd3c0xrYUkzc0xuL1U1?=
 =?utf-8?B?MHIzbG5FOEd1OHJFaytoTHdvRlJhRGM3VWwyT3hEY2lpUFlIYjlwWkZXcmVK?=
 =?utf-8?B?ZkdReHByUmdPSHhDWFpJaC9WTXdyeE9RRitBYVVYNHdPZ3o0dmxtVElnbWlv?=
 =?utf-8?Q?Y2q+IEZ06YbtXII7Krys34/2HNwnoymaP7yqo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1JUbDg4MlRwR2ptRDQ0UTNtSFdsN3lSbHZBMU8zeVZaRjNBN3UxN1RCYnJO?=
 =?utf-8?B?QkR5UVNkeU9ab3M0d3NjdXRtcUV3ZGNST2dXQXM2QzhQMWp6K1ZTRWkvZ1FQ?=
 =?utf-8?B?V1cxK1g5U0dGODBQYU96bjIzaGIwNnhqRVlBTWhmbjk2eHUzVmlkWTM0MkxG?=
 =?utf-8?B?L3d2eTBaVkRhelEvQ2JlZVd2bExGSkt4Y1pla3REWDFjbkk2eU1XNGJkeFNn?=
 =?utf-8?B?Wis3dFlXbkpHV3VibFV2R1RwMFNIY0RLeVZWUnZ0Wmc4U3o0dTBlalJPVjB1?=
 =?utf-8?B?VTlrdk96TnpKd00rMi9MQjlVWm0yNjhFTFNWZU0yV1VzSlorNkpIVE9vQzg5?=
 =?utf-8?B?RGV0RW0xeGJCTHFieWRXK2UzRmFOS0tWSWRhcjdsUkl1aFQ4c09SbFVBcmtp?=
 =?utf-8?B?NlNSRUNrenlPZS9JTkNtaHhzR3NKcCtSd1RPdWllK1E3QWE0Ukk3eGlOSEJL?=
 =?utf-8?B?K2hVdEhMVjhjUTVPdHpUVFE1ZHp1TWwxbTUyRkowa1o1OFN0dTJQT1NtenJo?=
 =?utf-8?B?MnF6aW5MS1BvdEpQd0tNajZmelNlTmJEU1NSa3RkVFp0Q0djK2t3QXZKcm1w?=
 =?utf-8?B?QkJ0b0xleEpaNHp1YnMxWWxlamFUV1B3ZlB0MVRzYWkzRlVOTjRZZmQ0UGhp?=
 =?utf-8?B?NGRoQ21WNU5jbGNZK25ROSt3eklyQ2lZN0ZtOWRtQWRKRFRZNFdOSy90K2Js?=
 =?utf-8?B?ZFQwSzNXWmRtVWVQSTVHU0c1enkwa2NrTk96c3NPb21EbHRhTHJUV3g1aWFm?=
 =?utf-8?B?TFdEMUpiZ05oTEN4Tkh2dWZ1ejd6SEEvZHlLRVlGSGR6WXNqU1U4TlUrQkk3?=
 =?utf-8?B?amNNbmw3b1pEbHNoUm53VjZldHJKNWhjcldPYmdoTlh6UFE0dndJYmpqQW9T?=
 =?utf-8?B?RlpJaFNmOFJ2a2tjWXo0UnlEQXdpWDNwR1BKNDN1OFpHVzFyKy9iTUMyL2NB?=
 =?utf-8?B?SzVpMGdGc0djVUM3b0hmZms4RDlRMzZHWU9ncklxdnNIR2UxWm5JcUxBTFkx?=
 =?utf-8?B?NXNHdWZpdDNYYWo0b3Fqc2cyOVdURGxsd1pHNkRXVk11V3BqVHIxeFczOFNF?=
 =?utf-8?B?b2s3WHAxRkoybVMzVEpnU3h3aWg3R0VybXpjRHhVeVcvU3MwdW9iUjVVUUJo?=
 =?utf-8?B?TDh1SFJ6ZDErcUt3R1p0N1FhbEo2UlIxQWZNcm5haFY5dWZ2Vzc3OE83SXdi?=
 =?utf-8?B?WDAxNkN5NC9nWk5oQ0pOVTRCN3E3TnFDczhOMW1WRkkrOFNHdVlVY2VMdnpC?=
 =?utf-8?B?NDNvaHRsVzRDR3hScmhucDhVT3gxNzhTaDhKanRGRG5hdVlJMDFuaEpERzVj?=
 =?utf-8?B?dG9lY0Z2NXdMT3dybTA3dkFZL3FTdkVVbHdJRFFHRzFKL3NsY3BzaWphTFRT?=
 =?utf-8?B?U2l3bEprNzdsMzhkZ2tzblJNc2RXbGMxcVk0eVFrSHFXckJLRDhnMDFrUzFL?=
 =?utf-8?B?RDl1YlEvZStHOVZraFJaTzdFYi95NHVFMnpzR3dZZFJZQ0Z0UFNDQ3ZoODVm?=
 =?utf-8?B?dGtmckJhMDNVWHhpU1VhRElKS3pYZFQyOVlKYjBjU1FOTXVENTR5eFM1cmJi?=
 =?utf-8?B?QXF4MnFuL0dlWHRpTXlpb0hZR1d1YTg3dmdPME5wVTBWbFY1Vm5UQ1MrY1Zr?=
 =?utf-8?B?WkJ1RGZ6a1d5MllDWHM4dGcwYkIvZElYSzI2aTFPSzVES1BTYW5kbW9qUFVv?=
 =?utf-8?B?cy9Ja0E3SDBRVk9lTEpIMXNveThxWGtvOU5TU3ZWcG1ZdndsWTNIdlJkKzFY?=
 =?utf-8?B?TW5KNU5PRHp2R3pVMEVXVVo3bVh2UDlQYnVZZnBiRTIxNStpUDlndmpuMysw?=
 =?utf-8?B?RERBQkJHcloyTHlQYzJGRm8yOVB6VDI2SWx3dThXTU5ncUEyRmhFTElXR0Yv?=
 =?utf-8?B?NDM0aTBMZmUwQW1DZGxCRW5CRGNZeVdZR0s0clRVL2hhdG9CcU8vdmVIWVpB?=
 =?utf-8?B?VkJnTWRwdnBVc2ozTHhUWTdTa1R2MEdVUVNpVy80U2NuM3RSR1FSNFlvRGpa?=
 =?utf-8?B?bGFSb2NiRnFjM3ZodHRxVnVhOEM1NWZjNTlNakNrVU9CQXZIZlhINUVNdEF4?=
 =?utf-8?B?cEpZTENnREVEajdRUHFaak5HMlBtTXN0Ym94ME1WZU5NNUJJWmVoVVpWKzc0?=
 =?utf-8?Q?baRwPbNLK/66IJjfWtjWtpyKK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1987b4d3-dd46-4847-b9d1-08dcd77bd68f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 00:50:06.3030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FkvJkGCyAeiGHeYi8AeB6TPEn9DQ+jPtycFtbL/3BoLszSBfH6NKFzK1PnPaPSb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

Hi Reinette,

On 9/13/2024 3:44 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/16/24 9:16 AM, Babu Moger wrote:
>> Smart Data Cache Injection (SDCI) is a mechanism that enables direct
>> insertion of data from I/O devices into the L3 cache. By directly caching
>> data from I/O devices rather than first storing the I/O data in DRAM,
>> SDCI reduces demands on DRAM bandwidth and reduces latency to the 
>> processor
>> consuming the I/O data.
>>
>> The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system 
>> software
>> to limit the portion of the L3 cache used for SDCI.
>>
>> When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
>> partitions identified by the highest-supported L3_MASK_n register where n
>> maximum supported CLOSID.
> 
> "where n maximum supported CLOSID" -> "where n is the maximum supported 
> CLOSID" ?
> 
Sure.

>>
>> Add CPUID feature bit that can be used to configure SDCIAE.
>>
>> The feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
>> Injection Allocation Enforcement (SDCIAE)
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>>   arch/x86/include/asm/cpufeatures.h | 1 +
>>   arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
>>   arch/x86/kernel/cpu/scattered.c    | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h 
>> b/arch/x86/include/asm/cpufeatures.h
>> index dd4682857c12..5ca39431d423 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -473,6 +473,7 @@
>>   #define X86_FEATURE_CLEAR_BHB_HW    (21*32+ 3) /* BHI_DIS_S HW 
>> control enabled */
>>   #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear 
>> branch history at vmexit using SW loop */
>>   #define X86_FEATURE_FAST_CPPC        (21*32 + 5) /* AMD Fast CPPC */
>> +#define X86_FEATURE_SDCIAE        (21*32 + 6) /* "" L3 Smart Data 
>> Cache Injection Allocation Enforcement */
>>   /*
>>    * BUG word(s)
>> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c 
>> b/arch/x86/kernel/cpu/cpuid-deps.c
>> index b7d9f530ae16..1ef42cc4cc75 100644
>> --- a/arch/x86/kernel/cpu/cpuid-deps.c
>> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
>> @@ -70,6 +70,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>>       { X86_FEATURE_CQM_MBM_LOCAL,        X86_FEATURE_CQM_LLC   },
>>       { X86_FEATURE_BMEC,            X86_FEATURE_CQM_MBM_TOTAL   },
>>       { X86_FEATURE_BMEC,            X86_FEATURE_CQM_MBM_LOCAL   },
>> +    { X86_FEATURE_SDCIAE,            X86_FEATURE_RDT_A     },
> 
> The need for this dependency is not clear to me. If there was a dependency
> then I would have expected it to be X86_FEATURE_CAT_L3 but we have not
> previously needed to do this. For example, X86_FEATURE_CDP_L3 does not 
> depend
> on X86_FEATURE_CAT_L3 and in turn X86_FEATURE_CAT_L3 does not depend on
> X86_FEATURE_RDT_A. Could you please elaborate why this is needed?

SDCIAE is allocation feature. So, I added X86_FEATURE_RDT_A.
Yea, It may be appropriate to add dependency on X86_FEATURE_CAT_L3. 
Because it is CAT_L3 related feature. I can change that.

I don't know the history why we didn't have dependency on CDP and CAT_L3.

Thanks
- Babu Moger

