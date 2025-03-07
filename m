Return-Path: <linux-kernel+bounces-550280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4713A55D80
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50753AC401
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14C6149C41;
	Fri,  7 Mar 2025 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nsSSvWRb"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFF1168B1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313796; cv=fail; b=FANOhIAlnIPTXRaIaNY0N2KrXxrDw1Qeej0lWOttID8QXw8d4JB+7dokA1oURSU10OSOtiWgCIah/bIJ8qCZkftSNVOP00hA3bpVBJiQCsrJXfgtFjm99l7vUi+RpaAWWiFKjSjr2TSWrCrBG8QstZKXaeMJ6MeK0nRgWvkhNLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313796; c=relaxed/simple;
	bh=Awk2W2Ry+Pzy+xcSu9xzUzFuTHqd2nDPPYltb1sg+As=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K0JlUIlE8YwiDNLxTjwWxZSAcafdYchrzw+/MZRpo01c/nAeq6lXVaf4eq+3Sd1SIuwwH4pgTbEDvhSoXnEDGBPIS/KV9/lPjNO7hN6jkx/FR+ivu9Cpq1NVG3qgzZEkTkedw5vTww2AXHgkyRDaTMyzc4EQ7WsxXwgsYdBVubc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nsSSvWRb; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQGbhqbtj8PQyCGV7eoxAe+MsFSsXjcanLDTffIaxHMrkJHvZtVEb2F35iPSrWg+gAWGQpZkhyMppDGUeOgvrEC8j+GwwF6MhtTHXsljWxN2fJW3CXHNCfnbMXoCOmwCBRhVaYBm+g1zDTojHzMnPEJOxD3Rn3YHscha9TtZpbmnXm1oiyZdHaHlctXZvXCDRivyUTTOxKw/es2/Jpfm4mkysmJAHr9htdE0zyaD8fvZygpleF/TwDmJCDgG9wrBTVqe/t8S2vG7bjs8yM9Bhl2XOElo+nutoO5v+5lRitTcG93REmtDyxTuRFIqwv9N429fNTJtygY5Htmr+5yTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T5pNGNxUJwC+oNvZ0mTn2nXogLnWfVyU3HeNmbxswY=;
 b=OxSnFs6Ljt5t/0UGcMzwEiU6ZEKvtDb665ujcyQCEcsa19zWv8bKzFaX8ac/pPQ5y30izz2VeAWUfNrqEmvqWRo/dW92FozdogAEkQtg0BozdvNgjAFiFB8jJIBRyIVryfWcNjbHrRmsVB8QinvvbqjRrYHU42OWAbtX1qbRnaLYktzG+u91RknUFdKwlwZNWRgoqdlAjS3r50L+S0j6j/k1BbqQp+jt2TjVfQXB6DCidd5/jSHDVDJI3W/EMvyt8yQhsc6mebqDw0gcYoSu8x2ap6MTWrv2JibUollH0w0kdbjrANybZpT79UfD1UsAaAP1yO39Gp+Dkms9G1dQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T5pNGNxUJwC+oNvZ0mTn2nXogLnWfVyU3HeNmbxswY=;
 b=nsSSvWRbSAX1JLyOw/kyWObHdBub2/fpG6dGHHtmW8bv57TvH7E5a9lW/zSBXlKeOj0AGa4SnQfVUCG69PR3TVQXhmkL1G+hglvCyVEAukpA9Z4GMVGaauXOParL6obHxfBHgpp2Uk9J2XZiBV/NcefpZ5W5ppAGDbsy0uYMhndba0LllP+U8mC+xtJGS9wuOUDeropntuPrYFJnO4LNornItDJ121DaZZbMOajPHuzmaaolxEihYCY9hHGNHXFBQJ0/rPuArzCWIrE9fpNS6eUJL7lSH8Nc4aGXNdy6HuKQNpvW6tx2zj0aQw0iJQPwtfSZIrJ5EB9C9cxPLv2Atw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 02:16:31 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:16:30 +0000
Message-ID: <8cd265e2-fa14-46f4-a018-edfcf73f8a92@nvidia.com>
Date: Thu, 6 Mar 2025 18:16:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 40/49] fs/resctrl: Add boiler plate for external
 resctrl code
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-41-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-41-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::9) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fe7a47-1f2c-42d3-d917-08dd5d1e12d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NExBcThPblJNU04rSE1Nd2IvMXVKWTJ2MkNPRGVOSzBFUktjY1VvSjM0S2ZP?=
 =?utf-8?B?U2NYR3R6dUo2aVkxbXhZdkRCY1I1Q0R5TXhTbGRSUWtDcktWWFBYNUpWWEpW?=
 =?utf-8?B?a1U0WDRwYU5FUlN5VXo5cGNyb0xKNnd5K3BHaTVqem9VdzYvUVhDYXZTbG9C?=
 =?utf-8?B?R3FPTHVXL0VGRVNkMFgrZlVKY3JuUTFOOUdhS0tqR09CQ2ZNeEVzcVZ1dkRs?=
 =?utf-8?B?OFR4L20wcXk4WVRkWFVjZ0FCZm4zaG1tUUVZRjk2cjFFR1RLY1IrUTR5S0Nm?=
 =?utf-8?B?cGJJVjFBdVJsQmRsbWlBMW9ObWNrM040cHhOY2l1eTVlR2VFQVN2bDZSTjRr?=
 =?utf-8?B?YnBnaHk4b3dSUEN5QitFWGxUY2xiaThtTFZEQlJnb3dTaHlHeEhlNkpnbWVW?=
 =?utf-8?B?a1J0ejNlbE92MUVtYkptSXpvY0ZoNk95ZStlWjVYUTRhS0h4cENGaVBETnpE?=
 =?utf-8?B?ayt1QmViUHUzenVvbW1jOWl5UEptbmJtZnlXa1grc3E4ZVpmTXV2TVp6UnQw?=
 =?utf-8?B?ZUMvRHI2NEdYK25xWEdic0ZieFBKNFp0d0FUKzNHTHhmQWY2L2lvczZnTWlC?=
 =?utf-8?B?N0RTeXNuVE9YT0xpTEVkYWRPR25UWnJ6ZFVrS2NaOGJPTTFQaU0vZUE4WDhi?=
 =?utf-8?B?cFF0bUZDU3F2Y1crQit1YjdCYnBxSjJNNzhkdXJGcUY5Uk1hYk1LRDVOR1g1?=
 =?utf-8?B?SWNxQm5jMEZHUjVpdkFVZzRsazdFbFgvbGN3OGZucFNvUXBoY1d1SW5sMFFs?=
 =?utf-8?B?SU9XNnh5cXJQcnB0cG5JTUR4L0wyTDhBczlzbDNsOVBaQ1h5L2twN1BrWXZr?=
 =?utf-8?B?OTkvdWtYanVoZStqNVptdUFmMTJ5ZmlZeXI4MzdpK1h0VVRRUVh6aEllV0g1?=
 =?utf-8?B?YS9raktITnRhbUNsZ2tiTjRPVkVlYkRRQVFJSzlhNzhWZWY1Qys4eHpWQUtS?=
 =?utf-8?B?TXJEVk9ldmJoNm0yaExxNGRJN054SG9wcVJSTUVTVVkxQnliTmRqYUtMOEls?=
 =?utf-8?B?R0VmaGk3U2laL3kvdHcrRHR1R1FMSzdrYVJhVkhWcVEwalRXZFdMTTFkeTBi?=
 =?utf-8?B?L3dYeTViNTFRL2hOclpqZFI0K2k3QzRjNll5M3hzb1N2eEpDOHJlSEo5L2ky?=
 =?utf-8?B?MC9BZXdtTHkzL3d4QTFUT0dGakQ5YkNlaVIrMmI5UElGWlUrM1lXV2krdGI2?=
 =?utf-8?B?dXFMVDh6WGJPOEZnOHY1MmNQWUlyTkxJdVhzOGdSQnV0cVNHSEZmb21tQVB4?=
 =?utf-8?B?N0hGbUpZQk1qd1BsOHJpMXM3MTFWOEdjNFg0eHdRVGNFcmJsSVczbHJsZHlU?=
 =?utf-8?B?eDRweFdBL0k3QVByaHFBZDcxODRzcGVQcUVveVlTTEduOUV6aEtoMVhxN1Nm?=
 =?utf-8?B?S2d4WWtwSUp6UnpzbGswM0dNdmJTdUF0bDZIcUh4dmtMVC9NQkFYU2duamlx?=
 =?utf-8?B?S0pRWkFmcjV0ZTg3bHVsc1paQ3U0VEI2TFRFS29lMnZRNDI0MTkwaVFXSVp3?=
 =?utf-8?B?OFo5cktBRGh1YkhPdW9uVHBCSDViT2ZkWFgyVjB3Qk5MWkU3THB5blV0bW5i?=
 =?utf-8?B?a3YxSGxzSHVVUllkL0orT0lsRUIvTFFuTkgzZUNJSVVxQzRKQ2pvQlIxRHhJ?=
 =?utf-8?B?MXZQOUpNd0ZCQ0s0STUvQmU5aGlOYVFyd3p2UHNSQ2VnU0l6NjYvVHZ4VDlU?=
 =?utf-8?B?V2g3ZXVPL0JyUGE5NmJ0TVBKWTlERW9WRzJOT1g0OVU0R3E4SlphanJZbUFD?=
 =?utf-8?B?dHIrYXBpVG9JNzVpQnhGZEZ4MklCSHdYOWJDTmlKM2FORi9KNFVNOUs5Z3l1?=
 =?utf-8?B?ckJhREdHQXhhS2J3blhOZ2hJQ0xZY1Y4M213SW5EeTI1SVl4THFIR1Z6S0J5?=
 =?utf-8?Q?Hy6pmk7fxE1eo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE1UY1ovYUpTbmp6eXJ0ek9pblI1RHhHelFJbzM2NjZyMXNhc1I0RWFNUnR3?=
 =?utf-8?B?UHF1UFBCbU5mSDhBckIwOHNoSTI4RU0zaTQwUUd4VElVMk1BUXowREpYWGFw?=
 =?utf-8?B?L0dYQzhYQjE1MWNFR2VQRnQ4TkhTR0wvbmZPM0dpdmdOS0NpSFE5OXN4a3lz?=
 =?utf-8?B?MjNYMHFwN1JFL2NSRS9FWTZyOGVkRFdSNzBYOEhlZ0NlcnNnclFUOS9ycll1?=
 =?utf-8?B?TUpYRHZ3QUJ6MDVVUndYWlJHcGwxTy9pT3JvUTQzNzEveTBtK3NZdjhhM0U0?=
 =?utf-8?B?eDVQeVl0aFlPM2F0aStPZDI4RWhrSmJJWjJld09wTEhDTmRmY0UxUmN6VjUw?=
 =?utf-8?B?bjkvREY0cHVDOU0xT2lxTnV3cXJod1l6a0xWbGlWdGhBZzR5bHMzdStyNjNJ?=
 =?utf-8?B?SEZQNmZRZ3hqK3l0TkEyU3RuLzkxUzRiV2tsWktsMVJvUXVsYzRpS2g2U3Jl?=
 =?utf-8?B?K0ZZcklPYTNZc0JEYzVuN1NqOTN1bldxOVZNVXB2M2JIZk9odHozZXpucU1N?=
 =?utf-8?B?WW5lRU43aW9laXhTb0UzQmtlTFRqUFJLbzcxTlgxbFhvNzJ0VmJSWC8rZjZu?=
 =?utf-8?B?VXpGMHVaNnhMSkFrSzJaOC9SQWc0d0l4TTFreTRHMDVybU00d3FvSy94U2hH?=
 =?utf-8?B?M3NWaWZrZ0NhWmtyMzdYeEFoaEdiSEhiWkNHY3ZkZzVLUjc1OHlmai9lQmE4?=
 =?utf-8?B?MkV4eXRCUE1XOU53ZldIeHBQYmZvSy8xRG53TWM4Q0ViRzNleVFKOEdVcisr?=
 =?utf-8?B?TFY5YmpWZlI5ZmwvV0t3VmVwMFFqMDJXMjNsK282R1pCc0ZkM1VMVVlTY0N6?=
 =?utf-8?B?MWpGMFFzQW1yNWdOWnI5VzlCSEtuUWpENWNuQVUxM3R0a2daT1J5dzUxUmJw?=
 =?utf-8?B?eVZBSWcwU3ZYYkF2eGFxSXY2WWRqaTZFbWEzZmZyZjFYUFQyekp3MDh6OGht?=
 =?utf-8?B?b1JGaXZ5cU43U2RQbVExN3Z3dXdRSDZWaklqbWw5U3FkK1cvcERNQkZIVS9I?=
 =?utf-8?B?Q05VWW9Pb21WTHhBRUV5Q3VMRkpHVldRS1VNYWlVNGRUNjFnbXZOUEltVVRj?=
 =?utf-8?B?T0Q5WXF3cjVTbGI1VXRtZ1BPdDdNWklCZGczLzVidWEvN3RteUhaTjYxek40?=
 =?utf-8?B?Q0s0SkJHb3RRQndNUmtjbnhFTlorOXJuVWNld2tIQlBQaVZuMnpIOEEwajln?=
 =?utf-8?B?MU9EV1RzRk9Zby9VbWZaQjBzUGFaTDFXNWdMVnd3V20xaW4wY3hxV01jSTlE?=
 =?utf-8?B?VFZkdjU3ZUhpRGdWdVAveGQvS0gvTzMxMzE2ZDZRUWQ4UEV6aDhyRGFiQkly?=
 =?utf-8?B?RU9rMXh5dlJuS0NaQVByU2NlOGlwbkVEa2ZkZTBLcERrYXF6MUI5ZEFjWGpn?=
 =?utf-8?B?VDU5VzY0UkhhYVVhaVRZMDlrVmZ5TWptZnM4RUJGVytaRU9meUtoeE11QW9q?=
 =?utf-8?B?Y3libGV3YUs3ajgwalp4T2NHTlB3RnU0bWtzZTNvTnAycC8wM29nRDU2Tk1H?=
 =?utf-8?B?RnRkVTBJUkptYVRxdWlDZW1iTGtkN1RGRHkyQ2ZLQ0sxSVBpdjRINjlMeGpS?=
 =?utf-8?B?ckJtR0ZyTjQvbGhoNm0vTDdyblBqWjNxeE9QQjN5ektKYWFST0dGeW5XbE9X?=
 =?utf-8?B?bUEyVzlVNU1DNU1QQVpWaHVXM2NzdXhpZFB0R2pLYlNwOVVPaGNSaXpoZEdU?=
 =?utf-8?B?R25jOVgzcDFRMk14R2JwVExGSVNYblBraVBsMXFIRHhueFBjVG5MWlpHWWlu?=
 =?utf-8?B?UklBY2dZUW11WEVNbEZ4YkNPcTNWSjhkd0d6VGM2RFE0TU5vM0YxQUt0cENh?=
 =?utf-8?B?WkplTjl2QmRzUEdpSjNSU2dxTnREOHBBdHVTSlUwU3FSb0FEcTRUcExlaWhU?=
 =?utf-8?B?YXROM1RrcWtjbmw0M3pOT3luQzlWMCtvWlZ5SlJTMENSc1pkSW1HVFl6TWZw?=
 =?utf-8?B?YmtINFVUVGNKSXY0SzYyN0pxZjZpQWR2Z2FJT3V6aDhSU1FsRVJMayttdWZU?=
 =?utf-8?B?V3RleUdxeVJiUEE0emh0OXZzR01lTnhERUNyS0ZBb0t4QmY3VFRvQlQwUE1s?=
 =?utf-8?B?NktET3ZhK3NXUHZ4ZmZqZUczVGFCZmYzcGlvL2c2SUNmNWhPNWdrQzVjbWZz?=
 =?utf-8?Q?YfXU1PkYBpwjLrlpOcqBeS9Za?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fe7a47-1f2c-42d3-d917-08dd5d1e12d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:16:30.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5Fp75lVt/ECf25n4sz78hCQfWi9yyV1U2XQjhofQu/zcW7C6DgAp6+MR9/fEnUG7wHZ+m+P9nARjwNFb4ojFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084


On 2/28/25 11:59, James Morse wrote:
> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
> select this.
>
> Adding an include of asm/resctrl.h to linux/resctrl.h allows the
> /fs/resctrl files to switch over to using this header instead.
>
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v6:
>   * Added 'depends on RESCTRL_FS' to the hidden kconfig options.
>
> Changes since v5:
>   * Removed double include.
>   * Removed duplicate pseudo lock Kconfig define
>   * Grammar fix and closid capitalisation change.
>
> Changes since v4:
>   * Tweaking of the commit message.
>
> Changes since v3:
>   * Reworded 'if unsure say N' from the Kconfig text, the user doesn't have
>     the choice anyway at this point.
>   * Added PWD to monitor.o's CFLAGS for the ftrace rube-goldberg build machine.
>   * Added split trace files.
>
> Changes since v2:
>   * Dropped KERNFS dependency from arch side Kconfig.
>   * Added empty trace.h file.
>   * Merged asm->linux includes from Dave's patch to decouple those
>     patches from this series.
>
> Changes since v1:
>   * Rename new file psuedo_lock.c to pseudo_lock.c, to match the name
>     of the original file (and to be less surprising).
>
>   * [Whitespace only] Under RESCTRL_FS in fs/resctrl/Kconfig, delete
>     alignment space in orphaned select ... if (which has nothing to line
>     up with any more).
>
>   * [Whitespace only] Reflow and re-tab Kconfig additions.
> ---
>   MAINTAINERS                               |  1 +
>   arch/Kconfig                              |  8 +++++
>   arch/x86/Kconfig                          | 11 ++-----
>   arch/x86/kernel/cpu/resctrl/internal.h    |  2 --
>   arch/x86/kernel/cpu/resctrl/monitor.c     |  2 +-
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
>   fs/Kconfig                                |  1 +
>   fs/Makefile                               |  1 +
>   fs/resctrl/Kconfig                        | 39 +++++++++++++++++++++++
>   fs/resctrl/Makefile                       |  6 ++++
>   fs/resctrl/ctrlmondata.c                  |  0
>   fs/resctrl/internal.h                     |  0
>   fs/resctrl/monitor.c                      |  0
>   fs/resctrl/monitor_trace.h                |  0
>   fs/resctrl/pseudo_lock.c                  |  0
>   fs/resctrl/pseudo_lock_trace.h            |  0
>   fs/resctrl/rdtgroup.c                     |  0
>   include/linux/resctrl.h                   |  4 +++
>   19 files changed, 66 insertions(+), 13 deletions(-)
>   create mode 100644 fs/resctrl/Kconfig
>   create mode 100644 fs/resctrl/Makefile
>   create mode 100644 fs/resctrl/ctrlmondata.c
>   create mode 100644 fs/resctrl/internal.h
>   create mode 100644 fs/resctrl/monitor.c
>   create mode 100644 fs/resctrl/monitor_trace.h
>   create mode 100644 fs/resctrl/pseudo_lock.c
>   create mode 100644 fs/resctrl/pseudo_lock_trace.h
>   create mode 100644 fs/resctrl/rdtgroup.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3487ac429a9a..433ba4a5a84a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19881,6 +19881,7 @@ S:	Supported
>   F:	Documentation/arch/x86/resctrl*
>   F:	arch/x86/include/asm/resctrl.h
>   F:	arch/x86/kernel/cpu/resctrl/
> +F:	fs/resctrl/
>   F:	include/linux/resctrl*.h
>   F:	tools/testing/selftests/resctrl/
>   
> diff --git a/arch/Kconfig b/arch/Kconfig
> index b8a4ff365582..2778a7859c11 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1518,6 +1518,14 @@ config STRICT_MODULE_RWX
>   config ARCH_HAS_PHYS_TO_DMA
>   	bool
>   
> +config ARCH_HAS_CPU_RESCTRL
> +	bool
> +	help
> +	  An architecture selects this option to indicate that the necessary
> +	  hooks are provided to support the common memory system usage
> +	  monitoring and control interfaces provided by the 'resctrl'
> +	  filesystem (see RESCTRL_FS).
> +
>   config HAVE_ARCH_COMPILER_H
>   	bool
>   	help
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1a89574a58f7..ea29d22a621f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -503,8 +503,9 @@ config X86_MPPARSE
>   config X86_CPU_RESCTRL
>   	bool "x86 CPU resource control support"
>   	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
> -	select KERNFS
> -	select PROC_CPU_RESCTRL		if PROC_FS
> +	depends on MISC_FILESYSTEMS
> +	select ARCH_HAS_CPU_RESCTRL
> +	select RESCTRL_FS
>   	select RESCTRL_FS_PSEUDO_LOCK
>   	help
>   	  Enable x86 CPU resource control support.
> @@ -522,12 +523,6 @@ config X86_CPU_RESCTRL
>   
>   	  Say N if unsure.
>   
> -config RESCTRL_FS_PSEUDO_LOCK
> -	bool
> -	help
> -	  Software mechanism to pin data in a cache portion using
> -	  micro-architecture specific knowledge.
> -
>   config X86_FRED
>   	bool "Flexible Return and Event Delivery"
>   	depends on X86_64
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 16c1a391d012..ee50b7375717 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -9,8 +9,6 @@
>   #include <linux/jump_label.h>
>   #include <linux/tick.h>
>   
> -#include <asm/resctrl.h>
> -
>   #define L3_QOS_CDP_ENABLE		0x01ULL
>   
>   #define L2_QOS_CDP_ENABLE		0x01ULL
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 90e7f8754b91..fcd3c41db554 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -19,11 +19,11 @@
>   
>   #include <linux/cpu.h>
>   #include <linux/module.h>
> +#include <linux/resctrl.h>
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   
>   #include <asm/cpu_device_id.h>
> -#include <asm/resctrl.h>
>   
>   #include "internal.h"
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 5c14f4999d55..69dff2bb2c09 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -18,12 +18,12 @@
>   #include <linux/mman.h>
>   #include <linux/perf_event.h>
>   #include <linux/pm_qos.h>
> +#include <linux/resctrl.h>
>   #include <linux/slab.h>
>   #include <linux/uaccess.h>
>   
>   #include <asm/cacheflush.h>
>   #include <asm/cpu_device_id.h>
> -#include <asm/resctrl.h>
>   #include <asm/perf_event.h>
>   
>   #include "../../events/perf_event.h" /* For X86_CONFIG() */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 4209d78b7aae..4108c0de298c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -18,6 +18,7 @@
>   #include <linux/fs_parser.h>
>   #include <linux/sysfs.h>
>   #include <linux/kernfs.h>
> +#include <linux/resctrl.h>
>   #include <linux/seq_buf.h>
>   #include <linux/seq_file.h>
>   #include <linux/sched/signal.h>
> @@ -28,7 +29,6 @@
>   
>   #include <uapi/linux/magic.h>
>   
> -#include <asm/resctrl.h>
>   #include "internal.h"
>   
>   DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 64d420e3c475..709e4d6656e2 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -334,6 +334,7 @@ source "fs/omfs/Kconfig"
>   source "fs/hpfs/Kconfig"
>   source "fs/qnx4/Kconfig"
>   source "fs/qnx6/Kconfig"
> +source "fs/resctrl/Kconfig"
>   source "fs/romfs/Kconfig"
>   source "fs/pstore/Kconfig"
>   source "fs/sysv/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index 15df0a923d3a..73512f13e969 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -129,3 +129,4 @@ obj-$(CONFIG_EROFS_FS)		+= erofs/
>   obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
>   obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
>   obj-$(CONFIG_BPF_LSM)		+= bpf_fs_kfuncs.o
> +obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
> diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
> new file mode 100644
> index 000000000000..478a8e2ad99f
> --- /dev/null
> +++ b/fs/resctrl/Kconfig
> @@ -0,0 +1,39 @@
> +config RESCTRL_FS
> +	bool "CPU Resource Control Filesystem (resctrl)"
> +	depends on ARCH_HAS_CPU_RESCTRL
> +	select KERNFS
> +	select PROC_CPU_RESCTRL if PROC_FS
> +	help
> +	  Some architectures provide hardware facilities to group tasks and
> +	  monitor and control their usage of memory system resources such as
> +	  caches and memory bandwidth.  Examples of such facilities include
> +	  Intel's Resource Director Technology (Intel(R) RDT) and AMD's
> +	  Platform Quality of Service (AMD QoS).
> +
> +	  If your system has the necessary support and you want to be able to
> +	  assign tasks to groups and manipulate the associated resource
> +	  monitors and controls from userspace, say Y here to get a mountable
> +	  'resctrl' filesystem that lets you do just that.
> +
> +	  If nothing mounts or prods the 'resctrl' filesystem, resource
> +	  controls and monitors are left in a quiescent, permissive state.
> +
> +	  On architectures where this can be disabled independently, it is
> +	  safe to say N.
> +
> +	  See <file:Documentation/arch/x86/resctrl.rst> for more information.
> +
> +config RESCTRL_FS_PSEUDO_LOCK
> +	bool
> +	depends on RESCTRL_FS
> +	help
> +	  Software mechanism to pin data in a cache portion using
> +	  micro-architecture specific knowledge.
> +
> +config RESCTRL_RMID_DEPENDS_ON_CLOSID
> +	bool
> +	depends on RESCTRL_FS
> +	help
> +	  Enabled by the architecture when the RMID values depend on the CLOSID.
> +	  This causes the CLOSID allocator to search for CLOSID with clean
> +	  RMID.
> diff --git a/fs/resctrl/Makefile b/fs/resctrl/Makefile
> new file mode 100644
> index 000000000000..e67f34d2236a
> --- /dev/null
> +++ b/fs/resctrl/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o
> +obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
> +
> +# To allow define_trace.h's recursive include:
> +CFLAGS_monitor.o = -I$(src)
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/fs/resctrl/monitor_trace.h b/fs/resctrl/monitor_trace.h
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/fs/resctrl/pseudo_lock_trace.h b/fs/resctrl/pseudo_lock_trace.h
> new file mode 100644
> index 000000000000..e69de29bb2d1

If merge patch 45 and 46 together to fix the pseudo_lock_trace.h 
compilation fatal issue, it's unnecessary to create pseudo_lock_trace.h 
here (and then the empty pseudo_lock_trace.h file will be deleted later 
in merged patch 45).

> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> new file mode 100644
> index 000000000000..e69de29bb2d1
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index b8f8240050b4..5c7c8bf2c47f 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -8,6 +8,10 @@
>   #include <linux/pid.h>
>   #include <linux/resctrl_types.h>
>   
> +#ifdef CONFIG_ARCH_HAS_CPU_RESCTRL
> +#include <asm/resctrl.h>
> +#endif
> +
>   /* CLOSID, RMID value used by the default control group */
>   #define RESCTRL_RESERVED_CLOSID		0
>   #define RESCTRL_RESERVED_RMID		0

Other than that,

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua


