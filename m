Return-Path: <linux-kernel+bounces-220194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6519090DDF0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30F5B2227D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4C176AC8;
	Tue, 18 Jun 2024 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sF/FNQ7D"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB521741FC;
	Tue, 18 Jun 2024 21:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744587; cv=fail; b=Ctqgs1z16v6NxVXoCaWHHkclPbCG3W3A8rti+XsF3t+vLoFsj9GZUWCASumEsv1rJQsEnJOJYfw6/NaL9nxWL/XCwta1uNbDEnZ/oT8M/Uwv79U5DEcDoEquqhdrhutZSXmFpZDQFkpCYYC3SLBcxnPkLt6AI++AnyeTs+O+FHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744587; c=relaxed/simple;
	bh=BmqIyS1YqfBMuLJwFk9nse0O/MFN9FRXBKjWIoL3it4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EXpmFDZ9VQTVXV6Bva7MPKIYzNRRoj/sZ7F25UHeQfCCK87ViAV3tBWRBGBE/2l087TbkkVGivbSFUfMbQ2AZWFdclZyF8QYoZAcTF0VDMo1r2cVXQp7CR8gcs2PoHRPFJr0qFzQyJoEbITgRMn05PcMr0i5/Kc58DlBR/i/7Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sF/FNQ7D; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bk+QGkMr7pTXpKskfOCLUQ4AJuOAL065nOO6jPJCrORptqWKqO73dhhFZ10ZoZY5TeCbT5Xt9PvV9cTRII3oaAIlpl7ynGfhLnYF1ctEGiEzJVM5J/b9JenZ02KH9BF8G6ZDtGvsAC20GWMHtA+pfsRRloC9IcHjP5sAdiadTuIj8WBvy16D1SlXlrsGfErpPRkCW33GDpE830f5LqSans2PmH8tW0hW8VhDnFoc7ZMz/NERbDGKnJ/hA7YSMDW5kvRTqJFCQBQZHpV/IqHcOVcOFOlvRDyVBh0q9Jhv+Fq54XvMtN1cHoQ+p0w/pE6pfn4UHa087hqxTEXau/u11A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqENAGazTG3dG0N7so/QPCMZ5zoKbOYx6IHZjFaZbvA=;
 b=AGIotszdds9916B/yzGceZxzqpIyhRyoLGS8JPvK7ohvcwPDqi58x9E+f35KxnGg8IQM50KcrsQ4eG5Q981hDJCJzlyT+C8EUZLb/0oc9omfCENv6ZTOI+eQWxDPN/eFZuMTVuFSARjknDKuMAyLlCjkvDIfUHZWVmNJVFtA+wkaRsO4Ub95L0CzQcZDzLKqCX9Q1bvZd5IPTZBonMXWAybkB5L0H4a5M2KMaRoXgMVdvy+m1bhRMTf/dLY7zLJKlVJR9uKlUXwB77SHGNdpFdWgu4cBjXPPMvzSkx6FjlbGukS28vx3OrZN7gr/5Ax8a1SpS1q0sapwXZqNLQUa+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqENAGazTG3dG0N7so/QPCMZ5zoKbOYx6IHZjFaZbvA=;
 b=sF/FNQ7D81xfd7vvBiMJoUFgttWMECIzeK+nW9KVd86Mdpud3lqJo6X8CdwN7/XAinfLsx4LPTzyZst8RxqV4FnDX7pfCNDj8vTknPizXp5Hc0w7rI/qV0fYEfWat74/exRZa6qoPm0fpDtyFaFCpnT+bEKtqVO31w/6WHbu4rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 21:03:03 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Tue, 18 Jun 2024
 21:03:03 +0000
Message-ID: <a8ee33f2-b3b2-4b3c-4bb0-b758dcb34337@amd.com>
Date: Tue, 18 Jun 2024 16:02:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v4 03/19] x86/resctrl: Consolidate monitoring related data
 from rdt_resource
Reply-To: babu.moger@amd.com
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
References: <cover.1716552602.git.babu.moger@amd.com>
 <8f73c9ec4c9999c262d9297d46a03209a8affe3f.1716552602.git.babu.moger@amd.com>
 <1c06a79c-e1dc-4798-9fce-3082597eee3a@intel.com>
Content-Language: en-US
In-Reply-To: <1c06a79c-e1dc-4798-9fce-3082597eee3a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0104.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 86edee79-f5cf-404c-c3ce-08dc8fda0a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVNMakQwM1hYQzBNZ0JZKzBCSHNCTnZTMWNVaVJzYnBqcVNlZGJETTNDeXgz?=
 =?utf-8?B?MTNOMThFMk41Ylk2L2hzSGpraEJxZXZzMjF1bERZL044cFJObmtOT0JIQ0pR?=
 =?utf-8?B?dnNpakEwZ3k1NFJjVEo4RVFYWEozRzlRdVZ0d0JLM3BTYXRFNVhGdFJrb0RT?=
 =?utf-8?B?ZDM4czBRWVNXWlgwZEtDTmVjYzZBWEV2S09zcS8yWFZvbjhTUXE2NG5kd05D?=
 =?utf-8?B?dzcwT2ttNWhhQTlMeEJwRFZlT3lzSnlZdEtHMkR4VEp6TmkrR25xRGRubkhB?=
 =?utf-8?B?Yys2cVJoZnBlazlGcjBjUElyek93UC9hd1lVWVpsZEQzMndsWFRRajV1TG44?=
 =?utf-8?B?dWZWR0tVSFRSUmVPN1o3cmZSamNLVFBNckhWc2J3cGhuUk1yaXRBN2l6T0dO?=
 =?utf-8?B?UHU5dWZjVStnRldFS3pvSTlrcG1NNFJUbCtodzhrQ1Nmdm9uOUtwL1plbzA4?=
 =?utf-8?B?c00yNlBSRjhvem9wZ3FLZUhMT2ZvZVVrQlBrOUNxZmc3M1YxR0VsU21zdHlh?=
 =?utf-8?B?ODErRWc2b1VhZGhMZE9BSVV4UTE0MnR1TU8yRkN5d2pYZG1WRG81U3ZwK3ND?=
 =?utf-8?B?aVlQZzQzVDNIN1loK3I0RkJsQ0RCZ1dDSGNsMjJIOGFZN3dvdG9CUDM3WHdw?=
 =?utf-8?B?ZTRjb04yTUtJL2gzd2VVTXBrYjViK0J2Z1ZDNnFTSTRMU1Z1S2hCZHRNbTRX?=
 =?utf-8?B?SXRwcVJrZnpCSHpHU3hicjgxRGZRUzdPNVdTVmp5N0VuK3gvT2E5UmJOMDRy?=
 =?utf-8?B?b3FaZU92TEo5ZHJVTHovTTFmb1pheEVQNnF4RlQ4VmxmUVEzSHpJL29KL3lN?=
 =?utf-8?B?VVRreGJ0akkzNU5MTVVGTkw1S2VjZVNJL1lLTTZUQmdCY0t0d2JzNGhBdDhP?=
 =?utf-8?B?OUdVMXdOK0N0VEVkU08xM0hMVnd6R1BhcVJ1OGtUaHdOUG5FUFJyQzk4RTc4?=
 =?utf-8?B?TzVjU3VHVnlwYzI3TWxzaXBrMnJ4NS9ETzM0cGRhU3QvelM3KzNEeWFQUzAw?=
 =?utf-8?B?UmRIMnZ6M0dBM0xGa3VZZGcxNm15N3VrV2dzWUR6VHhoSDZrOHQzUlg3SU5N?=
 =?utf-8?B?OGVIb0poaEdMcXI2ZTFKSTAvK2k2R282YkZiYmpOcTA0NGdRT3ZWVkU2V3pz?=
 =?utf-8?B?a2h2bzRKRzAzTWxCTnJQdXFycGVFNWNoRGh1SXVlemZzNW9SbnV1b2g1SXZv?=
 =?utf-8?B?T2pGSTRKWGNyK0pjRlVuZHNLZFRaWjZTaEFOSFRrWWVhaTlBbXRzK1ZrNnA1?=
 =?utf-8?B?cHVDRXV6akRGdU40OUp3THI1UEd6ZCtVVzIwSXBlZHRiQWZWNGRHcjV5bHFQ?=
 =?utf-8?B?QzZnSGhqM21oWjRlK003cjIxOVB5UkJNczRnUkNUY3NHV2NsNlk1SFM5a0Ft?=
 =?utf-8?B?cHYwa3BtREFMOUJkNUp0cGhUK0YzQmt1cFU0aW8vN2tuL3ptcXF2eTJnME1N?=
 =?utf-8?B?OTIvWjN3KzFwTXdHVW1RUndERDlJWlhrSVQwWUl3RFFvNmVyRmRkR2I1Zkd1?=
 =?utf-8?B?NStGNitDWE1uNHdKeW1FRU9rRTJvOXlQRGhDQWNLVTFPQ0FucEJ0cDc2R1E0?=
 =?utf-8?B?SkNZMzZHUnFxb2R4TXg4cVMyQk50alVpeVREZkx1aGs3RHZPWTFpY3JVRU1y?=
 =?utf-8?B?c3hRWjg5RUdFQjhGcEhVSjB1KzQ4OVpZVXNFZWI0b3pWUjdHb1A2SWxkZkgz?=
 =?utf-8?B?Zm40WGc3WHQwMi95UERvVTVmWVc5OWVZQ051MEh6b1VxK1N4MFc1ZkFiMEw5?=
 =?utf-8?Q?+GhhaqPpMDIMxEMJR3As3gAQZpcQF+eHUNkcpxN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk5yWnpndHBrVmYySWFYY2NvcWRHWERYZ1NDdXcyWHM2ZVRxbXBuUVpDK3Iv?=
 =?utf-8?B?K2x2b25mWExudXg2Nml5T2lIdGcxcGxKTG1VLzJwWWhwZmppcGhNSHEvVE4x?=
 =?utf-8?B?a2lhSWRLb0p1cEJJS3hjOXpPZ3oyOHBMZkxQSGJxVVQ5OHp4aUlTWGJvMGto?=
 =?utf-8?B?c0kvV3ExOGl0cXc3QlBySFBIVThpcVIyTXdFcjdRTXU5aHJZTnkxbXlWdjhY?=
 =?utf-8?B?MEx6UkwwQjR0M0d0SWU0K0dxMUlSRmJwLzgwTENhSTBVVUJNVmRyMW1XZmxl?=
 =?utf-8?B?d1lGOUdKdEZRbWxZUG80UWI3ZWQ3bkd3d2JqV09MeUxiTURSQ3hZUEp3Sndp?=
 =?utf-8?B?Rm13K2V3c3EzNVExTjE0YWFtcW5iQW1ZT0x1a29oZUNGemgyQThaeGdLZWF0?=
 =?utf-8?B?ZlpSZENEZzlSbGplaldoam1hdUZha3RzcWoyL0JzY2JkTWw0T3ZZVDNrdFhT?=
 =?utf-8?B?Z1FqWHlZbm5RTGVxWkVmRC9aY1BCakFDWk5YcC91TVV0UEVubzh4VVIvTFY4?=
 =?utf-8?B?cCtkai9YQk5jeEhWRXNGYmtiMnFxMDdDZ1hSSThZeS9xcXFla0h5T2lncGhr?=
 =?utf-8?B?ejY0UTBsMmlTNDFnNEt6MzVQSVlDV0FxSWVUdG14UnVJQ0VpUTlpMGtkeVpR?=
 =?utf-8?B?SzJBUk9TMVA0NVNZdEc0L3UvL2xua3RaNFNiMXp6ZDdBLzN4WStNcTlaVHVV?=
 =?utf-8?B?TjBFQWd3SWtDdlhQT253OFoydzFxNnZhZ2tLT1A3VXQwL3RnSTNoU25aWEMr?=
 =?utf-8?B?OTFTdURFYWZMbFNHZ01pZXZ4T1JjRWhrOENXVUF4akYwc2NJM3ZRZ1d4V1VU?=
 =?utf-8?B?dm1lL0hGRDA0WGVJd1p1bGJNTEVUeXplbUpiOGM3c0tTU2h6WFBicTVBTWd5?=
 =?utf-8?B?WERMTEl4ajhkY1pMbkl4L2ZqYjRUdk1XWFdETHRadlltQnFsVDBXZWxCdTE2?=
 =?utf-8?B?eW1tZjFtaFVSbzNNelBpR3RPZVRuOFJmVVliMnlVRHlUVzdLSDlHSXRxOHdH?=
 =?utf-8?B?OU4vMHRDRENGMWdZdE00c1FLNUtOK21ZL1lMSDFnRTVuRlZ5UlQ5UHA4QjdB?=
 =?utf-8?B?U0ovYmJWUk9NS3hNejdKVmN6MFViZDhxZnVjQS9JZnVtWHlaSy9PK3l4a1Jk?=
 =?utf-8?B?TDdsTE5mQzhDQ0lHcHhwaFI2Z3VUSUtFai9NczN2VXd3Z25LNjdBRU1IeGdN?=
 =?utf-8?B?UEV1ekRReWdrWVJTKytKc3VSSzdUQUNjM0FVMnZKYXBNMUR0NzZEUjQ4a3Bo?=
 =?utf-8?B?eTF1NlFmM2kxajJMUGNHblk5RjFIbHlTMTFwRnZpRzQ3TVUvRDZOeENBNytx?=
 =?utf-8?B?ZVQxZkErMUhvbGJNMTNEWG9vSy9CUDgzOUlDbEdVbTV4TFp0eUwzRzdHV1p5?=
 =?utf-8?B?ZkxyZ2ptcExZdmJvNDNwMWVSR0tiVzNjWjZCb1hWTEpIaCtzVnZrZmwvcnZo?=
 =?utf-8?B?MnVWZGJBdWp2YzlMQkFRbWNJamt5Q3M2emhLNWt4TldEWUxOQXVrQTNLNGdH?=
 =?utf-8?B?czFoRFdrNWc3bUE5cmM4aTY4T2JkY0U0RHorc2NKcXZPMDZyWDRINHRBcFBt?=
 =?utf-8?B?ams2U1dCQXc3N09hUEp1WGQySC9rYk9NSk5YZ2JIOGt6WnVEMlhiU3lKd0NY?=
 =?utf-8?B?ZUVmV3lNNEdjcVZYeXBZMmlUdUhydDcvbFlrVUxVNFNEVUxueUdmK1JaeU8z?=
 =?utf-8?B?UUFBZmZXa1JzRzd2eWJFWnJkZERGZkpxSXBMZ0hRWEZMcmxGMEtNVUsxSWNI?=
 =?utf-8?B?Q0pRS2dha2R1Y2pNaTRIbE40VlJIK090ODJSaTYwOXFkZ3oxV2VXVlB6c2hD?=
 =?utf-8?B?bVgvNFV3eXJVSmkzdkNabmQxWm9MNGFPSmRnY0J1bFhRLy9aRDkyV3lMNUtO?=
 =?utf-8?B?aFVpemJtZmFtRjJnU0Z2S29XeE1HM1JIUEtrUVVQZWZ3Qi9wNjJ4QUFRSmJw?=
 =?utf-8?B?Sk81bmFIQ0R1Y2pvUTViSkNyK21WcnRLK2QyN0hRSEltRUxuNVhmN1g1RGJo?=
 =?utf-8?B?ZzFJY2dXVllQK2pqeVYwMGp4SmNvUTFWc1Bwa0h3bHE4YTZEOWgvMXB3dVFQ?=
 =?utf-8?B?dThtbTZNWnlYSmNReGgrTzBENFFCbC8yV05CSnlpa09KWUg0KzZmMFIwbWxR?=
 =?utf-8?B?MFdIT09TeXRUVk9QOHF2emp3ZTlPbytneTlwQWxLTEREM0oxdkl1UlBhUkJZ?=
 =?utf-8?Q?Imew4lMrTzTVGza/BpLIjG9Ipmy565fc2WtTdt+gQ6mT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86edee79-f5cf-404c-c3ce-08dc8fda0a87
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 21:03:03.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prjr3hMS8QW9J0PZLnZzzYK5ADe7055sIixIzcqThemMtO7kTOglEKQ3xlb6C4ct
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360

Hi Reinette,

On 6/13/24 19:55, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> Consolidate all the data related to monitoring into separate structure
>> for better readability.
> 
> This needs a better motivation because "better readability" is subjective.
> You can motivate this work by noting that this is re-organization in
> preparation
> for more monitoring specific properties that will clobber the existing
> resource
> struct more. To support this organization the pattern of the cache allocation
> and memory bandwidth allocation features that consolidate the feature
> specific
> properties into a struct is followed.
> 

Sure. Sounds good.
-- 
Thanks
Babu Moger

