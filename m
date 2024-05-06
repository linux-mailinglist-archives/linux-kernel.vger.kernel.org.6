Return-Path: <linux-kernel+bounces-170223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BE08BD3B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734DB1C217E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A8157474;
	Mon,  6 May 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3422YUNq"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B750157463;
	Mon,  6 May 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015911; cv=fail; b=fsfkfSIZ5DI080KJkLuojMKsIxg8IZDqce+/vcIwICENhxIxzNnkV2XM1mO5oSrNHqnQeMYpTaxr7fZa3V+Q5XVyxH9dyS3ozepNwV/kyKUgdkUPJaTHDpoWjTreGmA0AboIYHvpqwawr404/13vpK+Z7QuRA6afZLlyB1tg25s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015911; c=relaxed/simple;
	bh=RTGYhv2EPXYcPoJq/yyQ8aBd87elbB4ixXaU9Cm5igs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jnvYpl69BEAhk/swssDMEpNHWXRc3H5DjhCErA9snlz6HxsTobCA0P2Wd9lPmoQ5FsLBJhvVG3D8UYK75JkCSHTrbIB/IlKuiYDrctETp0fnSqtB0ZrfkuUXXrRvB3Ux+RWx2h3P1719LlleC2NVVQEABQ+hoZ8trye/h4KUJv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3422YUNq; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k787H4c5UFmafag+Sm549ycNfEq1f7aZtiFuOckE2gtii5mkJ/AiqkRPKzcLBC6uU7M03j3ptaCwlNYdPlKgJ5SWoHBtjkXXiEH7cn8dAqwf01lBGbmZPaV87emFhsk677Vi/uA2VP29RCFbrx3hjmMOx+Hre43sj5vLRrgzm1Skn1iy60qUm9CXgQwz8ZmbijoOKrj0zc8kR0GOSc5chSn98U5igJaU69KSle0TAdwlafpWisZ0KvkiR4gZz60t8rDYIxeRS/FlE2ttlgO3BQHALmrTovw3xL9K4+S9E+qPZnSyPaoaS8EONVy7+WXdBFqlzARxQvI6t9V+PhO57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyN48cIDS4G2aONwtuU7A54YeY9eG1ffJS1tcUWka0g=;
 b=YHWQhIK0AF3oKGZri3a0kdGveXe23oEfVxIVYEaO2RHSA1CfZ9FllPhCVegtjNrrfc+IUNJMPzmWUM5WjFOPxYdFAUEYZs6Whr1xzXAWApfUxar9Xq2mRqxUmu/1XGFjaVTBtxCpwwpsk2TTCZgPBO6HfspKS5Hw34ioI6EHc78uI/0rJkyDHTbCKs+l7K8yeb0P7KLbxjzvQrsFsBc4lMVaAN6sTclyPTegnTDvQCv5C/pT36/TE0sFRULna1Rz3UrnlGNJf+8y4mSb7ZiAAvHjN9uUFD7h7paMxPiQ+o6Sw+LhiZnfp3od/ZnNMZ9kVpxl+T3K0OcVh31sBVQmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyN48cIDS4G2aONwtuU7A54YeY9eG1ffJS1tcUWka0g=;
 b=3422YUNqz3DHMPWf3SxiZfcfhRxfg95yW8Ht3h2ljaQdRWb/82QTFxvatYJ/bf3kt53YhhjWpy8qydNITR6XNJiaWfShaTlr0h0L2KElgXqy3GaZYqObAtPUzLOXNhGqoUJA7XrizlphPtqQRMejhayiCNe5WOuwA0NrELBt1kQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 17:18:24 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 17:18:24 +0000
Message-ID: <2016b830-64c7-43bd-8116-bdfd239221e3@amd.com>
Date: Mon, 6 May 2024 12:18:19 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
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
References: <cover.1711674410.git.babu.moger@amd.com>
 <48b595cc-5ffe-4507-bffd-335a60fdaab9@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <48b595cc-5ffe-4507-bffd-335a60fdaab9@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 15184256-e6fa-4c07-3c0d-08dc6df0895d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amJET243cDFuWFp1dHd6dW5uQTBzS0I3a0h6KzBaZFBOenRibUFjbGY0L04x?=
 =?utf-8?B?akg4T2krRWs4TERIQWgrZGkxNVplL2lFelJ1VzZrNFNJMHd0dlhaaXRzdzc5?=
 =?utf-8?B?STIwWWppbEJVblBHVWRPMUxCTk0yd3BObE5JYlRrN3NhKzd6eXova0syZzEz?=
 =?utf-8?B?V2xkcVhRcWdnVVEwVjRJWFh4MEFLRnZJLzdTRFg5VUJpaTRhSnFNRGVXU2N3?=
 =?utf-8?B?OTNSTGZIRm5aZS9IeEd4RTMzSEJVQWdYZEhwdGNHK3kzZmxlSkQ5V0N1akhS?=
 =?utf-8?B?QmY1S25zcVVOdm13YlBEbnZ4UStqTVROZlZ3WjBzRi9zSGxoRXlzN3JZSnRu?=
 =?utf-8?B?djVLSzZwZFgyS0NPTUNMRFFjK3NWb3Z1TEhHa1k3ZlBFbFpPS0xFM0Q4bFk4?=
 =?utf-8?B?STNKczJDd1RYUHEvR2liT3dSQkpiSzQ0Q2FLbUJmbXVBc28zQVgzeXhsMW4w?=
 =?utf-8?B?eDQ2Q0lOa0RZSEVRdDVsdTZza0o4WVd6cGVmOUx6TjhYeWpTd2VCdHArZXZl?=
 =?utf-8?B?eVhQd2lrWFZmeHZBRkZKdGhlbDlBcTdLSUNZUGZXanBQdWFOVkQxbzZhWU83?=
 =?utf-8?B?TEVRc0FFNThmZmlFQkF1SXlsTEZkNUgzVURWeGdVRmNQdUtXS21EeDJ3aFRC?=
 =?utf-8?B?RkxDeHlsTU5XZmhnV2hFcFFHdHVkdUVIRGZrUVYyZGZlaUFrMEFKNFpHWHdJ?=
 =?utf-8?B?Mlg0MlBCUWd0cDN5cHoveXpucGtyVGV6M1J4d2ltQ3VDT1U3MDZBMXJCZ1Bz?=
 =?utf-8?B?QzhtUmE2VlN0RUdUV21neFRqTDhsUkdwOTQxRXZQTFkxekJTQWlObEhJRzRH?=
 =?utf-8?B?RXBaZFFwNG1VWUI5b05HK2d0bnJmTGJTRWhKeFBsUDdBRzFxR3dEd3VRSDlC?=
 =?utf-8?B?UGJRekM5NUhVeVh0N0E5VXM1L1BxbS9tbHBtRUlybVhJZmdTdkFIRHViaS9r?=
 =?utf-8?B?R3ZYT0QwWEtCYmZZSEZ4QVAwL3BsTzFXWmpYTG83RXBzT1ZpSDJiV0xocldL?=
 =?utf-8?B?T25mSzNGU0lRTE9RWit4b0lyczYvdkQza05nK3RGbTE0bEtkblBiZ2VZWTdI?=
 =?utf-8?B?ZmtiTkhGL3lMMnBVWCtHNC9PTWU0NnJteHY2bjFROEVkeGkwcjJ2OHFzajl0?=
 =?utf-8?B?aytWWG95dU40cHdqRXowWGVIQ0FxL3BkQTlyMVYyMTFkbEQyVUNlTUtTeVdV?=
 =?utf-8?B?ckpmSnl2ZDhidWJ0Vm1QdDVDU1cwVWI2Yjk2MDVzeGJqWkxjbTdJSnByeTNR?=
 =?utf-8?B?VldZazkyZkhyeU5Jeld0S0JwL01ZNWtIZXVOcVl3VVY2c0VGekhDSzg5REVV?=
 =?utf-8?B?OENWWFNnekQyUmlrZXhjUkpNMXdsVWYwaTErL3BwOFR4T1Fkc1VqZnhJcnF5?=
 =?utf-8?B?MTVUOGVNSWt5UlFHRjZNbGl3dnJVOEhZenZRbEhuUllscHdacmU4ZjZBMGlD?=
 =?utf-8?B?T2tDY1owN1VDOTRnRWZSelVmMWJlYXRVaFh3MWk3ajJlNS8ybmR5aTVsY1k0?=
 =?utf-8?B?aFNMRFR0Yy9ObnVzZnNjSEFSb1JFK2IxMm5BU0ZlOStCRTZIU2FJcDV0WHBM?=
 =?utf-8?B?R0JNL2E2WVU2LzQzREk4Y2daR1ZSTlFCVmZIZ3c2dDJRdjBKRjUwcGJ0cDY5?=
 =?utf-8?Q?3ZqUObwviUJ3sI0mm5cX3XRMLgcw454uyG+kCfyH8WE0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlhVUjYrRlIwdUZ5MldJTnh0cVBXT3VoR1Y1S3RWMitqdHhGTXdTWVp6WDB0?=
 =?utf-8?B?MkhmOGU2SE03WkR6UDlUYkpIdzhmK3B4WjllYzJ6VDNUdmlvSGpqZFZsUDFJ?=
 =?utf-8?B?ZDJSUFpnUFIwcG1IVmpXOXBYOGJCWmRseGlQemFyTzFacFJlRkdReFlRRFpt?=
 =?utf-8?B?eTZHZVJ6aG1mSHRuU0p4RUNMaGErSzN4OUZxQU0rbHcwZlMrR2prUWlabHZv?=
 =?utf-8?B?QjQ1MGc3bkNqb2hzWGhQNG1Gc2ZTMzZCKzNxNEp2Ri90dmp4QXVNNXl0dXZR?=
 =?utf-8?B?bmVvRFQvelRCTHdjcWw3cWZpWmY4Sm1DODllRFZQNHVFbE1vcVh4Vm1KS256?=
 =?utf-8?B?YlZKTWRFNjdBclpvVlJ5NC9PdnA4eXNBR2x3VVNjWmxrMXR3RmdyMXN0Z2hH?=
 =?utf-8?B?SHVGakpqemhDY3RSUnpzaGcvbXhVbFZaWk1jdi9PeDkrMFJSSVpkd3YvdGow?=
 =?utf-8?B?bHY3N016RkgyZFE2WVBOT29NRUZjQUx0M3Era2xIbXpva2pjT0pvMDJqdy91?=
 =?utf-8?B?dHJ6WEJBLzJXNlV0ZGN1K0FTODB3SWpzZGZuRUY2SHVPaWIzeVlwMEtxQXZj?=
 =?utf-8?B?WHNabUNxRkJjKzNTeXZaK0JkV1NxaHBsK0JERmFsS2xVVnNyOCtKK21WVC9J?=
 =?utf-8?B?UEVsNExSUlZqbGUrOS9qOFNRUElxSkRiWm5BMVVKeERTblhoUzJXUGdTck1L?=
 =?utf-8?B?RVkzVEJPaVBBYkFWTmxkVDJ4dUxDd0tRakdWRTRSTXQwMkNxdkEwTXNZQjA4?=
 =?utf-8?B?TlN0L2VJYjVZY0k1dCtFa0NFTm9VUFg2elM2cGw4T0t3NXk4d1dydXVKOE53?=
 =?utf-8?B?UDd3eE5zRDRQMTlXZEU2ZEhQNGJUUThOYjJ0cEpBeHk3dFBHcXRqeUNpVmU3?=
 =?utf-8?B?TkR0Z2dnUURaODcyK205bFpPTk5BVFdYcjdmdlExM2RQVGNxY3FDZEZGYTdu?=
 =?utf-8?B?NG04OVVwekRVQ1VPQVYyci9kRHRFelNjRjJkR1NXb0FYdmE0ek5SRlRabFFU?=
 =?utf-8?B?MTFDR01BeEFQR3JIdy9PTEdJY0psS3dXQmNrZEhXYnRIMzF0S2hId2ZOSjdr?=
 =?utf-8?B?Mi9QM3hMNExqNXFSTjVnQncvR09PdXpUVXIrSE5DbjJlaTlzcWRoNEtZRFFx?=
 =?utf-8?B?b2QxY1Y3MGh3VXp5Q002cE1jOC8wdHprOVNnSnBxL2hEY2dKbEdvVHpHTDFh?=
 =?utf-8?B?d0RDSmVmb0VwalBZNDVtWHY4enloS1FidzRRTUJITjBmUkptWkRRMGFWRE5X?=
 =?utf-8?B?WllyRVUxbDlMSzYvRHIrWnNoRHBXb05IOG92UjRSM3Jkd3Z2L25DN3J2OWZE?=
 =?utf-8?B?N1BUM3RoQmdoL3FmSzRZRTgyTVhyTjlyMk5XVndBbWxrWXFtSUdIekNucHJD?=
 =?utf-8?B?aWwwTW83OWg0a1RCMUhVN0l6aXBkZW00ZkFIMUxIT1hVNXl0YUpCSDl4S0du?=
 =?utf-8?B?Y0MzbDV0TjhsSlMvdjlCdlkwZDhIN1RNbU01dHhDUUVFYXFvNTFwdk8rT3l1?=
 =?utf-8?B?TytDa01IM0Jnd3Erd2h2M1VIZk5aK1RPYmZNR0lMMnpLMjRMMXVDZUt6WXNT?=
 =?utf-8?B?NlZPanpwaHc5YkdiaGRSZUJ1NkpOTXl1NmZqcURoeFU1ZThnY2xyUE1DS3VO?=
 =?utf-8?B?dHAxYy9pZlF1eWRVdHcwMG9CNmc1aE9hZFFWamYvY0lXR0hsOHpLTnlDVjlX?=
 =?utf-8?B?SUpvQ1RGdWhIakliTURMTGxWMTlZM2pGczlXOUNCaDQzdTc5b256VVdXODdK?=
 =?utf-8?B?K1A5SHRSL2MwdHcvaHVqTmtBUUhNVWVvOUpURXVxeXVFM0ovemM0dDhVaTBM?=
 =?utf-8?B?Nm01bmI1eURvTS9wckYrbXJGanVDSDNUSUtKWW43MlYzbFZUY1hBcDVjaXF0?=
 =?utf-8?B?WkNSK1A2NHM0bVZWbS9XM2x0OFA4TE5XOTBGeWVYbUxvWlV4VU5kV3AxYkxj?=
 =?utf-8?B?VFJtSGd3MUprVThNZmJvQ0o2VURkbGdGQi9OdHlGczNvTTNIeG8xNlBDY0JM?=
 =?utf-8?B?Nnk3WEYxYUR5RVdNSzdsWThkaTRWTHFHcWhEby9sb2xKYjNvTXA3eUxISkts?=
 =?utf-8?B?c1owVTc0ZkZ6QVNYL1VPdHRDcFhwL1o3TkgyTnpuZjd2bTAzaTduMGFhWUpP?=
 =?utf-8?Q?Nmq8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15184256-e6fa-4c07-3c0d-08dc6df0895d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 17:18:24.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ybudM9c2iElfh8vPgfA/BLgrEFXXYC0dBUh6ie+XKv6TtRzfhdDLClQVh+o1IaO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733

Hi Reinette,

On 5/3/24 18:24, Reinette Chatre wrote:
> Hi Babu,
> 
> On 3/28/2024 6:06 PM, Babu Moger wrote:
> 
>> a. Check if ABMC support is available
>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>> 	[abmc] 
>> 	legacy_mbm
>>
>> 	Linux kernel detected ABMC feature and it is enabled.
> 
> Please note that this adds the "abmc" feature to the resctrl
> *filesystem* that supports more architectures than just AMD. Calling the
> resctrl filesystem feature "abmc" means that (a) AMD needs to be ok with
> other architectures calling their features that are
> similar-but-maybe-not-identical-to-AMD-ABMC "abmc", or (b) this needs
> a new generic name.

It should not a problem if other architecture calling abmc for similar
feature. But generic name is always better if there is a suggestion.


> 
>> b. Check how many ABMC counters are available. 
>>
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_cntrs 
>> 	32
>>
>> c. Create few resctrl groups.
>>
>> 	# mkdir /sys/fs/resctrl/mon_groups/default_mon1
>> 	# mkdir /sys/fs/resctrl/non_defult_group
> 
> Can this be non_default_group instead? Seems like non_defult_group is used
> consistently but its spelling is unexpected.

Ok. Will correct it. Thanks

> 
>> 	# mkdir /sys/fs/resctrl/non_defult_group/mon_groups/non_default_mon1
>>
>> d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>    to list and modify the group's assignment states.
>>
>>    The list follows the following format:
>>
>>        * Default CTRL_MON group:
>>                "//<domain_id>=<assignment_flags>"
>>
>>        * Non-default CTRL_MON group:
>>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
>>
>>        * Child MON group of default CTRL_MON group:
>>                "/<MON group>/<domain_id>=<assignment_flags>"
>>
>>        * Child MON group of non-default CTRL_MON group:
>>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
>>
>>        Assignment flags can be one of the following:
>>
>>         t  MBM total event is assigned
>>         l  MBM local event is assigned
>>         tl Both total and local MBM events are assigned
>>         _  None of the MBM events are assigned
>>
>> 	Examples:
>>
>> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control 
>> 	non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>> 	non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>> 	//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>> 	/default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
>>
>> 	There are four groups and all the groups have local and total event assigned.
>>
>> 	"//" - This is a default CONTROL MON group
>>
>> 	"non_defult_group//" - This is non default CONTROL MON group
>>
>> 	"/default_mon1/"  - This is Child MON group of the defult group
>>
>> 	"non_defult_group/non_default_mon1/" - This is child MON group of the non default group
>>
>> 	=tl means both total and local events are assigned.
>>
>> e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control.
>>
>> 	The write format is similar to the above list format with addition of
>> 	op-code for the assignment operation.
>>
>>         * Default CTRL_MON group:
>>                 "//<domain_id><op-code><assignment_flags>"
>>
>>         * Non-default CTRL_MON group:
>>                 "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
>>
>>         * Child MON group of default CTRL_MON group:
>>                 "/<MON group>/<domain_id><op-code><assignment_flags>"
>>
>>         * Child MON group of non-default CTRL_MON group:
>>                 "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
>>
>>        Op-code can be one of the following:
>>
>>         = Update the assignment to match the flags
>>         + Assign a new state
>>         - Unassign a new state
>>         _ Unassign all the states
> 
> As mentioned in https://lore.kernel.org/lkml/ZjO9hpuLz%2FjJYqvT@e133380.arm.com/
> the "_" is not an operator but instead viewed as an part of <assignment_flags>.
> It is expected to be used with "=", to unset flags it will be used as below:
> 
> echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/0=_" ...

Oh.. ok.

Will correct it. I also need to verify the parshing..

> 
>>
>>
>>         Initial group status:
>>
>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>         non_default_ctrl_mon_grp//0=tl;1=tl;
>>         non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>         //0=tl;1=tl;
>>         /child_default_mon_grp/0=tl;1=tl;
>>
>>
>>         To update the default group to assign only total event.
>>         # echo "//0=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>>         Assignment status after the update:
>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>         non_default_ctrl_mon_grp//0=tl;1=tl;
>>         non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>         //0=t;1=t;
>>         /child_default_mon_grp/0=tl;1=tl;
> 
> As mentioned in https://lore.kernel.org/lkml/330e3391-b917-4a88-bae3-bdcbb8cfd6f4@intel.com/
> using "0=t" is expected to only impact domain #0, not all domains. Similar for
> other examples below.

Ok. Sure

> 
>>
>>         To update the MON group child_default_mon_grp to remove local event:
>>         # echo "/child_default_mon_grp/0-l" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>>         Assignment status after the update:
>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>         //0=t;1=t;
>>         /child_default_mon_grp/0=t;1=t;
>>         non_default_ctrl_mon_grp//0=tl;1=tl;
>>         non_default_ctrl_mon_grp/child_non_default_mon_grp/0=tl;1=tl;
>>
>>         To update the MON group non_default_ctrl_mon_grp/child_non_default_mon_grp to
>>         remove both local and total events:
>>         # echo "non_default_ctrl_mon_grp/child_non_default_mon_grp/0_" >
>>                       /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>
>>         Assignment status after the update:
>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>         //0=t;1=t;
>>         /child_default_mon_grp/0=t;1=t;
>>         non_default_ctrl_mon_grp//0=tl;1=tl;
>>         non_default_ctrl_mon_grp/child_non_default_mon_grp/0=_;1=_;
>>
>> 	
>> f. Read the event mbm_total_bytes and mbm_local_bytes of the default group.
>>    There is no change in reading the evetns with ABMC. If the event is unassigned
> 
> evetns -> events

Sure.

> 
>>    when reading, then the read will come back as Unavailable.
>> 	
>> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	779247936
>> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
>> 	765207488
>> 	
>> g. Users will have the option to go back to legacy_mbm mode if required.
>>    This can be done using the following command.
>>
>> 	# echo "legacy_mbm" > /sys/fs/resctrl/info/L3_MON/mbm_assign
>> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>         abmc
>>         [legacy_mbm]
>>
> 
> This needs a mention about how state is impacted when a user makes this
> switch. For example, if switching from "legacy" to abmc ... if there
> are fewer than "num counters" monitor groups, will they get counters
> assigned dynamically? What happens to feature specific resctrl files?
> What happens to the counters themselves, are they reset? What else
> happens during this switch?

Sure. Will add the explanation.

When switching from "legacy" to abmc, events in already created resctrl
groups will be in Unassigned states. Users need to assign the monitors to
each group to read the events.

> 
>> 	
>> h. Check the bandwidth configuration for the group. Note that bandwidth
>>    configuration has a domain scope. Total event defaults to 0x7F (to
>>    count all the events) and local event defaults to 0x15 (to count all
>>    the local numa events). The event bitmap decoding is available at
>>    https://www.kernel.org/doc/Documentation/x86/resctrl.rst
>>    in section "mbm_total_bytes_config", "mbm_local_bytes_config":
>> 	
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
>> 	0=0x7f;1=0x7f
>> 	
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config 
>> 	0=0x15;1=0x15
>> 	
>> j. Change the bandwidth source for domain 0 for the total event to count only reads.
>>    Note that this change effects total events on the domain 0.
>> 	
>> 	#echo 0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
>> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config 
>> 	0=0x33;1=0x7F
>> 	
>> k. Now read the total event again. The mbm_total_bytes should display
>>    only the read events.
>> 	
>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>> 	314101
>> 	
>> l. Unmount the resctrl
>> 	 
>> 	#umount /sys/fs/resctrl/
>>
>> ---
> 
> Reinette

-- 
Thanks
Babu Moger

