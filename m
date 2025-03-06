Return-Path: <linux-kernel+bounces-549902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A04A55860
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE93188F907
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794BF272923;
	Thu,  6 Mar 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B2UMoVal"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04020FA81
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295406; cv=fail; b=rq6xE9TuhuoLtxAeZhGyvHREPgoYKM+tteYwjV95e9RgGIDug//Sb9NApVi1AVhnBfsZ94unJpLixxG+dW5j4aD0LT67XafVAXkTTfLsWET7Zz7zejGPju6d/iSEKVRKBWCfCUkuZNdSQI5HaO4A6qT6iNHwRMhuCAcUNKGF7FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295406; c=relaxed/simple;
	bh=wEjgk/M4nXLilg8f7Y57cmHQa3JCtvfmuAkVcdDnyDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O4/DZUh6kDPVm1G+3Hj2JUvgDckHzVRjuJy7u6xcqQCW/C5dlX1Yirtv45DiMhVQ9sZTvwqRV3G8NzEA+2zlHXKPxWid0TWTGqxhlSVXXl4C1csAl1a0E21mhDqJElujoK6EFWtb9XSUNnV30rTrJNcDUTmnF4c2o4jtniyYf8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B2UMoVal; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IN6DVOnNVArgIX6YL6Afzss+9/Jyj8HEvOsyj51hNh82yQHyrBd0SrkbxG9loPG9yoGjbPjvfuvt2Mi1mYi8wyC3o+6aF5JNOGdMrYRMB5p1DXidMpN1jogOisfxKw167dbrndcVVXK09AHm8boYvhpbJFBalpW2/VSGXA+9SxRQllD67pEP6Qgz2EUbXT4JaYgEXO7ALWQEeU4iilYzLaslvFfadcys3xDNiX9QO965bojpMbZiKCg0u983uiEOgy8cy/uvCeqU9TuSKDP2LM8+YkBirn/hHEyQQTrhlzkZHCn1FXkl0mlpTrst3AEWb9KKipJzZh3MQjUylRHxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4FtSZa7XYjcDFZKnex67XmX7x5V3ykYphnJgKAkdlE=;
 b=mVyIWWZT47PqrPct/14zFtOkVZi1bf2QlQgmyH4j5wBKqxde4HM4MPk+6aXLdBKgg6NtpMRQLd9QHIEEYQqoPaka9WSaH+xdwz70VGTdC6bcvSuKgqJL1M8JGQfwo0E9xHm9xvXF1WO6PtOtxgFMl7WxclH+fPuqrujpUMfKvbtJnTwUc379ZySHC6yctczvJlHoOBuJZONFpevFwUU5ouM+0V1aS1DmKEeglGozwfeQyXOsc3lN7jTqT/Oi7DXmEE7jPkCFON7qSgHiGFzhHg5DMdp8fGesH2bb6V9c90ShsQiHA//JAEYLGIYyEH3fOvML2cqIGWHjo5Ht5MCAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4FtSZa7XYjcDFZKnex67XmX7x5V3ykYphnJgKAkdlE=;
 b=B2UMoValVfQY/Qh7D6LJSbK+OLNGBlVs3OUFmi5JWD9TyK4LyDv9kx7Sp7TIXW/TDDT86JIJ1+GBkdR2N+DrZEEZE8NukjKSk8bS2lJ2dp4autAnRwPlAoK7UHSGFjAOHcPPyUm0Uj4JtDG3SxpwUheKc6km+O3qvhqArkfddNGtzQa/6KRI5bLxrCPrNagFSEH191OMMJnE2owZy9PED8/o/HO61MMK9/U4uadOvQMNRZ5+hvSCWt4A/bN14pWbajBxlPALLHkJvL7wRAjgpo6VfzsBrXmrwgAa4iW8DAuzFRFEUlYmAEVwDU1OATHyMfcf7OZzXM7tWg0Exdn5Bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 21:10:01 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:10:01 +0000
Message-ID: <dcbab896-001d-49d4-8bd5-4cda2a73a507@nvidia.com>
Date: Thu, 6 Mar 2025 13:09:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/49] x86/resctrl: Move resctrl types to a separate
 header
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
 <20250228195913.24895-14-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-14-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:a03:333::29) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aafd742-5f58-4e62-ea4d-08dd5cf34222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkllRnFleERsR2FHQksrNmFFaVhrRkxhQzBaaXpKTHZ2Z0poYUtGUm1IamZs?=
 =?utf-8?B?MTVBZDMzckc5dWlraW9NanQ1WnpQa0lFZHF1cUVEbTc1N2xDZGZqZzBSZGVC?=
 =?utf-8?B?d0d1YjBRZzg2VmJjZExGQWNvZlhubjZ2NmdxTW1iVG9DQzVJSGc1NGxPMGJE?=
 =?utf-8?B?cCtaS3BpMUpSZnlLalpKMitqam5pSGVyWmJtdmZnZ3BoTk1PMENZd0dDUzJI?=
 =?utf-8?B?VGhkT0ptbGVjNzEzNWl2QmpwRHdBVi9POHdkOFRySUc2bDBra3VlTW9BTmN5?=
 =?utf-8?B?bG1LN3dMdmdPMzJ6eTVxR3NWaXh0T1dpYXVyUGhwcVlsL2VhMzFtL1U4OSs4?=
 =?utf-8?B?MS9ZaTRXVDhEUjVQZGZjcEFMSkdBdDFKd2FIMjFOeVFOa3c2cm01VDgvc09p?=
 =?utf-8?B?Q1hzUlhJMlR2M1dtVXY5TWREYXNFVUE0RHBWaTMrV042WmEvTlVBSS9wTGpk?=
 =?utf-8?B?eVNUYXNaVUt1S1VMWUVQaHIxaURIQnNIa3B1bkp3R1ZKWU0zc04rSnhYMnBN?=
 =?utf-8?B?RTRBdjlsd1pOZHNFY3RySUtuTTZUL1ZMN0xsQ1dOM1EzYSt3ckZ2QW1SbjFi?=
 =?utf-8?B?enk5akdzVnk4dTFwOWc1cm1UOHFCY2ZnbkYyOUNDZ0gzSkl0cmxjTC9nT3lG?=
 =?utf-8?B?RkJuWXE1REJiK0QzK2JhbXJMYkdGV0M1U3BxclRVUHFucWEzckFUcm9USFNp?=
 =?utf-8?B?TjljVXVGeHZoUld0L0RpSGpiNEJRVXo0NENPS1VyU1ppUDRVc2I5clJNMmhk?=
 =?utf-8?B?b0dxRTBJUEpHRE13MjVQVDk5Uk12M1ZpMVBGNEI3NkRWOE0vRm1QSGpnYndj?=
 =?utf-8?B?MWdXVHJrdkdMNnJDdFB5ajFXUUtaR3dFTEJnSlV0ci9zNWZqZkk1OVJvUTkr?=
 =?utf-8?B?VFYrQjFjN3krcVIzQnRQb2JCS0pmQ0UwejB6UnRaQ0ZZcVBRSm1iNVJwUHZ4?=
 =?utf-8?B?MmQwV0duV1FuRWZaczgzNWRQREUyaDgydTEzRXBZYnlERU4wcDBIaWs5bU1a?=
 =?utf-8?B?UWNva25UOGhqN1crK2V5WE9pT3BHRVNFVGtFT1dRb01ITHpUMk9UWkdpRVRi?=
 =?utf-8?B?ZVZuUFp0YWFaeHZRa2FleFBMZnAxU0VnUDVsNEIxT0l0ZjBDazVvY0svdExs?=
 =?utf-8?B?Y3Izak1scS9PMEhtNkNvakRBazdPRTdyWjJhaytneEtCTTVZVXNRcm1KOE53?=
 =?utf-8?B?R0ZidGhMdSs3eDYrZWN0cFdieGpiL2Y0YzZjQTN0aGdqUTIwRHRVM1AzR2ls?=
 =?utf-8?B?YXM4S2RLTEVsb1RnQzNsc1FDVzlKNGNVQ1g3djRLTEo2elYvYmxvWGpDbUty?=
 =?utf-8?B?cWdhRkVtQVhoR0h3VFEzanhrL1ZxaWRScXFTNGxUcC82eWltWmJQazRuZkRJ?=
 =?utf-8?B?bHRMVThndGN0aVo2NzR1bzV3VGJSdDlEaDh3TjRqSmc3TGN2b2wvT1BmSU1Q?=
 =?utf-8?B?ZndhUnZBRkVDbEx1bWF4OE5SZlBZcjhBUjFOTHZyNVQ1bEtlT1RXcEtZU0ZG?=
 =?utf-8?B?dk5oaHhINGo2c2pFZXlBS0VQbGhUL3c3NE9sZXc4d0Z6WFQ2MHlZY3ZLdVNm?=
 =?utf-8?B?ekFlRk9VbmQ1YWZYTWFkc0lCdWJHYmJaOXZIU3V2NVh4eFUvTzZUVnZ1V25h?=
 =?utf-8?B?VVVha1crelJDaUQyUVpFdkJyRlc3Q21xOTNmQzFJdzFWQW92WEZQWFZkUGVX?=
 =?utf-8?B?TjJaSmcwZFBRdXU3dmV3K2loVTNGMm85Q29xaEgza2o4U1Q3bzl6RnZZck9E?=
 =?utf-8?B?c0lQRHdiRnFGTTI1TzVNT3grVWRjdS9KUHZYSmJTWEhqd0gzalNJMW45VldP?=
 =?utf-8?B?U0lHUjZzeHhsMXd0bFVlREhiZ3FnV2x2VW9LRno3bjUzbXN0V2h3TFMvaEVL?=
 =?utf-8?Q?yAz4dAilDsS1X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFROaFZ2M0ZVRVRIMjZ6Nm9mY1NicEZyemd3Z3VOd2RBYm1Ebk1pdU1iN1VK?=
 =?utf-8?B?dXd6NWhiMTJBcjEvck5xWlYvdU12RlJpVGhPajFCVUNQOGlXMXhRa0srUXk2?=
 =?utf-8?B?ajMyRWhZTWoxL2k5OEQ1clZSUWozMEJ4YiszYThhN253LzBlcUtBTlN5NUpk?=
 =?utf-8?B?eXBIZEw0YWNYckZGckxCTTNlKzduTGhxdjl2Q3JTZmJTYUpvKzNMSXJtajNB?=
 =?utf-8?B?bHNxeTBod1NFdTZEeXpTRU1RYnZOQWZwYnhhVmZsc3h6UlFGaElVVFF5OVRz?=
 =?utf-8?B?d1ErbU1GKzQ3L3czU1AyNVdVZkF0dVdJQm5hYUtZTng5enR0dUJBVUplR3o0?=
 =?utf-8?B?L3FhcnBNYkpETXpRa1ZvQXdKY0NQRFh6UXUrZ0owOXJOQ0o1L0hiNlh2czRR?=
 =?utf-8?B?Rkg1L2RzSkFuMU9Kb1Y3YW5EK1BkUDNHNUY4TmNleTlhTmhsOWk3Z2dUTjBp?=
 =?utf-8?B?TkYyK2UwU1NQWlF6MTMveWF4bUtLQ1hsUWVZd0JOa0RlSjNZWG16VktUa3hx?=
 =?utf-8?B?YzV2ZWVrMmFnM3JJeWhaRTJ6QlFIUzh4UmJValFRNzBSSXEvUWFUOVVQYTg1?=
 =?utf-8?B?bzlkbGt1R1dEaU84SnZHSVgySFVQZkx2NkpSL3M4VlJQNElRV3BxYXhFaXpl?=
 =?utf-8?B?clB5Nm80aW5sT2RaMysvNFpWTythMkdDSDIvMC9RRk1EQnZEdENObjI2c3Qw?=
 =?utf-8?B?R2M5UTgveGxIZlA3b2xuY1FmVXdnK21TaXh4R2dLSmhleVRWSHI1T25GN08x?=
 =?utf-8?B?QXAvVlFsMStaNkp6N3M2UjBlYnk0VGdKUzRDS1U4UndVdnBPdlg0Mkp0Qlcr?=
 =?utf-8?B?UCtVM2NXWkZualAya09uOFhIaXpZeGVzdDkraFdMZXFDN0xTZVNodVZ5SSti?=
 =?utf-8?B?S09PaUNEZkpvZ09JTk1sMUQ4RkE2ZDl5VmhlTUZSajZ5QW5zNE04REIrTXVy?=
 =?utf-8?B?NjFJc3RKNU1wVllVSlpaVXZPS0hVbmJsQ0s1MVpPSzdnZmNRODUxTnlpUC9o?=
 =?utf-8?B?ak9LZ0dBQUpIR3ROejI3T2g5R002ZktPZTRCMitBbkl2c24zMXVYTE1FaUxh?=
 =?utf-8?B?ZmdJbmd3SFpTbnRaYkkyY0dQMkhKZGErbXZjYnEzVTVRWFNFRkZ6b2NsN1hX?=
 =?utf-8?B?WUYzUHJmVzNUdzdVV1ZQN1FqaW9MemViK0tnQzJ4WnlRWVYxaFc1cDNWK2JH?=
 =?utf-8?B?b1Y0bkk2SDRpN2JVTmJvdUxuQ3J0UHFncG9seFNHaHFaMS9wWFlNSFZYUHB2?=
 =?utf-8?B?elo2Uk51alo2ajlFNldta2k1M3FzYjBscFgyYkhTZGFEdUwrWFl5cHF5Q25q?=
 =?utf-8?B?WklCcnpaZWZWbVZJNnREZ3QxWkIxcUJvVDV4K3g1aU92bHdmLzBHMlgyaDg3?=
 =?utf-8?B?b0gwMm1TdWZmYmFMVFJUZEw3ellqWStqZ2xaaVhJRDBRQlhPeFhxV3ZZYU9U?=
 =?utf-8?B?eFJhQ2ZDN25heUhVbVBJcm8zNkptSXZjcWdKZGZPM0ZUdTZObDErcEJVMTMx?=
 =?utf-8?B?QzR3ZUx2cmNlSW1QNnRPK2Q4S25oS01LN0YrWng0aDlLM3FHcjRNWTlNMVg4?=
 =?utf-8?B?ZEZRejdzckxJdWNFRkt0VWpLSFUybEpmT0FudTl1SFRFQmJTWXRBcjFLOWcy?=
 =?utf-8?B?VGYzNHU0U24rM3dQUnlkeHg4ZC9MRmgwVGJMZ2t6eU9SaUJOeFQrWjBvWmFX?=
 =?utf-8?B?L1NsNU5rN2NrTkhXVWpVNFkzNkd2cDdsdEpJbDVVMURNWmdha2YzZGxrT0p5?=
 =?utf-8?B?SnFBeHdmN1hBRDJ0NDFROEp0MGZvd1ZIdnBnU0VWVmd6Z1JjYW5KMTRKOS8w?=
 =?utf-8?B?WHZEZjdaV1Y1WVd4b1BwR3dRdFhEVEJjazBvdjl6UWM2WEhGUCtqdHB1S1Rt?=
 =?utf-8?B?ckRxLzlFWDJVK3pmZ29pZEpkTTF3TUYvRXJ3TDhMOFJuL2h3WElmQWNrSWNp?=
 =?utf-8?B?amJCQWxGNlNlNFJMUEtlVEJDRWxseXdreG93RHRPS0dyZngvQ3R6eTFKZFZH?=
 =?utf-8?B?TVlHcTNZaHlLaHZWYmFEM3FEQnE2MXdQSE9IK3lBZ0tyK2ZCK091NmluMFNp?=
 =?utf-8?B?aWZ1dUtUM2N6cE41MW12aUUxT3BpVFFjSktIOVd5S3VJeHI1bTFxaEZHQXV4?=
 =?utf-8?Q?H0WwmJWN3uSQJlaFfDok/eRO+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aafd742-5f58-4e62-ea4d-08dd5cf34222
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:10:01.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FN8QFyOw5FKVJwjPRv6zsEaqkS8mBi11iOXrez0cPnQa2MJEubwzVJPmVi22MxvHgTrZv/xndaJjJMJ28avq0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237


On 2/28/25 11:58, James Morse wrote:
> When resctrl is fully factored into core and per-arch code, each arch
> will need to use some resctrl common definitions in order to define its
> own specializations and helpers.  Following conventional practice, it
> would be desirable to put the dependent arch definitions in an
> <asm/resctrl.h> header that is included by the common <linux/resctrl.h>
> header.  However, this can make it awkward to avoid a circular
> dependency between <linux/resctrl.h> and the arch header.
>
> To avoid such dependencies, move the affected common types and
> constants into a new header that does not need to depend on
> <linux/resctrl.h> or on the arch headers.
>
> The same logic applies to the monitor-configuration defines, move these
> too.
>
> Some kind of enumeration for events is needed between the filesystem
> and architecture code. Take the x86 definition as its convenient for
> x86.
>
> The definition of enum resctrl_event_id is needed to allow the
> architecture code to define resctrl_arch_mon_ctx_alloc() and
> resctrl_arch_mon_ctx_free().
>
> The definition of enum resctrl_res_level is needed to allow the
> architecture code to define resctrl_arch_set_cdp_enabled() and
> resctrl_arch_get_cdp_enabled().
>
> The bits for mbm_local_bytes_config et al are ABI, and must be the same
> on all architectures. These are documented in
> Documentation/arch/x86/resctrl.rst
>
> The maintainers entry for these headers was missed when resctrl.h was
> created. Add a wildcard entry to match both resctrl.h and
> resctrl_types.h.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


