Return-Path: <linux-kernel+bounces-549890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C818A5583D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37A9188C51A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96C27425F;
	Thu,  6 Mar 2025 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p8uG1Npj"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3D214A61
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295084; cv=fail; b=nnb1MYAPTb9wi7wIzxf3y4Os4vAdDxJnnig+UK688LKOYyQoccB7tRRQs0ixlDI4rxsGFrlHYsrxOHTdP074uHBa548RJXjoUzVxJ8gEWEQ9h18OB4qsoIkmr88werelSsKFLyVb+Ni/BJYaoNN/NjKqpCgRC9Z95tzL40ToNI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295084; c=relaxed/simple;
	bh=9pP02T2EJcMnU9DZTDC3MyHFpGRGyYebEPJhDSDHq48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TR9JRUzj0xYBgQgM9dQdEygvc/1qsb7B7yknbV9sQx4ZsBaJ+FAy8rCzIsxWqjWhCzdLUOSKed7EBjET+5GH0K4i6T4XbTCcxVgjbQeRldDDTGdupL2q8jMzjXl+lgR82/Vq9PVJJXceo54tDEMqtPkoHlQqme3qlxJ+eKh3i2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p8uG1Npj; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVV4YfiVkm5D+qLtEUTxg+xL8A6YwoVN6EO9FlChrQvq/65VGjYmQ8suC+nME2fgs0ofqwdXTVl0CW8CT0adj0eEA0TVWVKUWCFzYEtaoOm117VUhFRLI/8j/qX+iDu8D1aqXZ8Mv50sOjoq+nVc1ESTzOOyh4o7hvkXh8lQXOIMq7G6uQ/IPLVrBwXsrg6Y+LkRQ5htaWC0K4d+P579ChetAGaDZ0iGIQA8zSV7pvQqJat1p6lBLA0AVRF83IP5rjAvbi4TwN1vm6WgYvuTfeCFEHeVvUg1gPeJQSlreIAsxsWbMwl+1HHkMpo4XyMxITGJKf3kJEuv5drJA968PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pP02T2EJcMnU9DZTDC3MyHFpGRGyYebEPJhDSDHq48=;
 b=MFndJJplTgElo70VQFcD8ipgwKslFaRPzKMtBzD2FZkdPvqAF8hOBZ9iwcbs1WN2UuftH94SolkZAGS742IgDY0byurT9A9O16+AuM5O2LBuAzqNTWkidMFmeIOoUJzn8tXeuhGkhSfbS6LCnHfK4/XLU7zgPMko95aYW9UijiQ4HOds3Jppa3nY79S8P/WAIbI4r3dz2lYjjhmINsAGGV6D4TZg4Voqr3oruU9t1ltdgoEK/zFgaIB7rV20bnndrauTI8sI1Fgf6iWeDojIRxjrLlXnOM4c1E9pzKlFB8vCHV0fDqjF2hJTpqHmQ9NQC6fNKFNz40luQWrQJZCj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pP02T2EJcMnU9DZTDC3MyHFpGRGyYebEPJhDSDHq48=;
 b=p8uG1NpjfSOYikS+c0bORYYTVYBWqTd8jp2tnMdNnK8SFL6BEtzlTRnKt02DEi6UUKept6u90l+MO2tJbHXIKeeNaCXj+4Iu2JoIdGXTWoine357ZsSXeZelaNmaKGin55X8C18lDl0i78cqt939zlx56reXtDod+0UA1SGamru2uvyrXARV779QYTfZ2OEX/ux00LN1jQuPG9OxchPlrZfMSfNS+JaKDu/I29fz2Q+gwnGo4xTxy/+7GEoCgr5JIehv2zDeAyI3o0TDt5uUOdo5IdcdRZxKIPdh6h8HxXGzAERfA3ELCzk2Da02b7P8zjPiXLlvvSXgxpldmlOKUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:04:40 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:04:40 +0000
Message-ID: <99e7d978-17d3-4ff4-9193-1a15a6ff035f@nvidia.com>
Date: Thu, 6 Mar 2025 13:04:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/49] x86/resctrl: Add helper for setting CPU default
 properties
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
 <20250228195913.24895-10-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-10-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::15) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b45aaf-23af-4030-61f8-08dd5cf2827e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QldoTVgwaGZIbHQ5Y2pJYXMrN1FQYzgwU3lIN2xYZk92NzRQSGMzQnA2bWYr?=
 =?utf-8?B?Vmt2cEd3YWpOMVRReWVFYW1lSSthb21FK3lZOWxDdnNDQVZlSkxxN1Y4bXJK?=
 =?utf-8?B?TGdSV2FEamM2c2tQZ21GTXBYU0Q2blFoMVh3N3QzelU3dHhlL1dMMzhUUTN3?=
 =?utf-8?B?Q1RRVnpjajloMkF0SWxpeUk1c08yNzNJQnpqc3RTYm5nQnRsQmVXTkMyQzBF?=
 =?utf-8?B?aWhqVTFtNzNBemhKdm5Fc0tWNXJpZXBxRnI0VGMzb2t6QjBJZVFKKzVBV0hm?=
 =?utf-8?B?ZlA0R2FRTWxsS1JjK0FhTUt2K1puV2I1WHJrZGYvcXN5dnBaMjlFMkhCNXN5?=
 =?utf-8?B?dWFyMGQ3K3VVbFNJcmRFUTkvTHhrSmpCazNmd0RXWWpxNjN6NWJnOHVrL243?=
 =?utf-8?B?TS83THpoQnNnMDg4R1NsTU1DSlE4VEpPWS9YbkpQUWp4ZHB2UVRzRHdKY05Q?=
 =?utf-8?B?c09sdnlHUENndVFDN0kwRVVHbWFKVUd1eFA3OUJWZE1ObjVFcGIzNy9NbDFw?=
 =?utf-8?B?V1krWnlPd05IazM5VjRpV2EybUQrckJHWGtvRkZybHYvcld6a0pUeThGckxF?=
 =?utf-8?B?cHhGUW04TlNJdlpLZXlsZVhpVklOMGhhYm9NNVdGNWlGakZyV3BTTmt2ZUpY?=
 =?utf-8?B?OTBEUDIxUU4wc3RIcEdPM0RkaUpKVnRDK25NSlN4b3hIb3IveUdhZU1RUmdn?=
 =?utf-8?B?ak9WWWI1NndSV0syZ2luc01EWUdadWYzejF5ZWFyRWtvdXE1TU9pUGZEZEEx?=
 =?utf-8?B?NTVEZVZIRGh6S0ltbUhpcjZONVYwVUhXdVRNQVByUC9YS3Jha3B3MGhEWldi?=
 =?utf-8?B?RDV0K2ZaVDJTdW1yOFhKSnFFNVlzbFRxcXZsZ0lDdTNaaUhQb1pxdWtlTDBB?=
 =?utf-8?B?MDlwem9lTFQ1ZU05dC8vWUlKLy9PbWdQcGlVQkl1OGVTclk2bVAzeUdwR0ZL?=
 =?utf-8?B?MWlCeUI5ODJ0UzltQS9aN2pmSWdoZysrWVZ2MUlqWCt5R3BhOGtZV3l1aFVs?=
 =?utf-8?B?cXpuT1RoN24yaldZM0tOMkpFRVlRbHY2dXdCWDZSRVhPQkhvbnZrMlJrYjho?=
 =?utf-8?B?OTZ3Um9GbmFhR3U1MC9nL2RpS2U4Y0J6VE1vUlAzQ3pIU1cxVDUvVW9qQ1Zl?=
 =?utf-8?B?eFpSa0pzQ3p4cGgvZGtiOW9vbDVwU1grSEtkR3hyS1FYdEtTaDhXZjh4UDZJ?=
 =?utf-8?B?bUFHRGhMbGp2ZlRDUW4rU3ZWVXk0RVVKZFluQlZnaGR5eE1kekF0WlgrSmdJ?=
 =?utf-8?B?aEl1Z3hrZXoyallLVHlTRGoxTXhhSlRhM3pSd1I1aVphZjJNMEdhR05lbStQ?=
 =?utf-8?B?MG14WUE1MmRuOE9lQ2hUdERkWUpYdEljWnBYTWpNTW9zMUVod09zTzZsdWZW?=
 =?utf-8?B?ZElqdXE4emxzdWxGMGlUQy9SbmxQSDdUYThEdXIxMmFuNy9ROUNBZ25rNlZM?=
 =?utf-8?B?UTgrcUpIQlFmTzdoZ2RVRGZUR09YS1prOGZBTDNtSWRmZ1dqZitFblFJZDJ3?=
 =?utf-8?B?eEwyZGNROWFEUi91SEI4dlRpeDdoNGRXM3VyOHVwZmlqeFJ6Ym53M0FjOGN4?=
 =?utf-8?B?dC81UnR2bU9wN2lqZnpSVmt3YXdLOTFxNFNPTnVVYkFDSnRRcnNmK0xrdzNz?=
 =?utf-8?B?dC9TU0lFak1KZDRKaXZHU0FxSDcrVVplU1NLRmNQTmNCaVpMdzZsVlNGMnpZ?=
 =?utf-8?B?UTRweTczRTIxZFZIOVYwbFIxTUJDLzVobjV5UDVldnBzdXZHNG9pSnVMZEw3?=
 =?utf-8?B?UTJxZy82Z29teXhtaitnRVg2YmRVWWVOcWJoU2t1OUZNVXFsQTA1cmg5V2Zo?=
 =?utf-8?B?NTdkRGtQQUZvQkNrRnFOUU9WeGVHcW1Tek5HcG56Z3BNblAvUVorWndsaVBK?=
 =?utf-8?Q?XNAGryDDp01Ra?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3ZDOVZGbHFHSVFSSjBBYlJaeXZOVVNQMVNaSkIvT1BnLzBKeTU3cnFPVEZB?=
 =?utf-8?B?SElLZ1o0cSs0cHN6N3ZyMElDbGR6MFE4dWJPenJub0ZPc3RWRGZMTzRNbW1G?=
 =?utf-8?B?ZWwxYUtRVmM2WEtOVndZcDl1QTRvT0JDRDhwMjBWR1hoY2s2aG9LbG5YdzBB?=
 =?utf-8?B?VWlNOWZobmw3c25ITnUwVHpVVVgrSk5iREdsUXE0QzFZYkFyQVJzeUpYOXIw?=
 =?utf-8?B?M2l0MktMc2h1TjUvU1Y0NEg4TXFDQzZMNFhsRDNJRlJic1c3bXNwNTdKbUFT?=
 =?utf-8?B?ZDlzT3FLR21rUEdIWGsyQnZjTHVLckZleU9mTGZjd3FCRUt2YTRvTWJ5czIx?=
 =?utf-8?B?dGdwdXVDZ3FxSFUvc3Baa29ia1I5aFh0N2JNYmRCM21zaDFsK1JJM3pUNFlO?=
 =?utf-8?B?YnU1c1ExSmg5RHZFaXRjQkxPcnlCRzRaMGdUeDBrRTVzdXhHbnpHR2RLc1Bp?=
 =?utf-8?B?dGJEYWhaakE4WGpGUWsrcWpzZk9SQmV5d0p6QWFmUC81MGlwbkllWi9qRElo?=
 =?utf-8?B?WGxyemJYVDRBSEF6K3N4TDI1aDJDTlRBM1VmSWVpa01JWGdhZm1MbTRNZm1r?=
 =?utf-8?B?dW9Wb2FnRTFVNStUeUZzOU9nb2tpc1IzSis4SDA5dm1mbVJMRFFqYUdrODM3?=
 =?utf-8?B?cUxQRElnbUNyTGJ4OGhxdENCaXh3ZVVtSXR0SVJZNW1NcnllUERoRlY0cEU1?=
 =?utf-8?B?MVhlT2pSY2o1c2RiQytyblY2SzI1WkZqOFByMDNsNnFDVGhHSjliTEY3cjhv?=
 =?utf-8?B?WTY1UVVib0NpelhDMTdWMzZIQ3ZFMFVJWGVSUUZYREpsWm9QeCtoNGZYK3Vn?=
 =?utf-8?B?VU9FY2xDSWZXMXFxWDhsUHNRQmdZaDBxcytidzBiSzlEOEVBVEtsRHFhQmto?=
 =?utf-8?B?dlhia3puMi9WVXhDZGZuVkNLK0JOdkp4VmJDZGRlZ3gvYWp4NnhKQXhiMkdV?=
 =?utf-8?B?ZHJMZzN3cVE2QVMrcm16YW82YWVpcUlSaXdCcmNXa28zdGF4RTdQREpjMkhG?=
 =?utf-8?B?UmZRNmdNUzRHNUJRcVdmbFpXRzB4ZWF5ek1uRUVsVk9laWVFWXdaRFpzQ3lv?=
 =?utf-8?B?WnlJbnhSazdoNG5La1lSUDdMNERJeGlCMmFld3h5Mm9CaWdhVytBTjdjbnlY?=
 =?utf-8?B?Z0hkblhSRXZUMys1dUlYYjBnZUplWnBVWmJ0dEd1QjNPZ3p5bHRTV0gzQTNS?=
 =?utf-8?B?Q1BIbXJQalNhMkpqZFVESzdSRG15ZFNHbnZRN3dXK3VTRW9kMXp0SjNZU0Rw?=
 =?utf-8?B?QlF1L2Nva0pIN0pDQXV1Z1VjdGU2MmVob0FrL04xSUNrbmc3NzlrNW9zR2ps?=
 =?utf-8?B?UTBWczRubTNZT3dweE5McXd2VDkvME9rbWJyQ0JzMVBKaDVZV3pDVitqRXJQ?=
 =?utf-8?B?RkVjU0ZtYmtrd1hVdEkxTjRtY2ZYemtvRmJWQ3Q2QzkrYVY3V3g3azNuejJ2?=
 =?utf-8?B?cmlUSEFYZ09UZlJXcXJBd1ZjaUZXM1BQZ01LK044dERKREFlWUJhRjVZSkxC?=
 =?utf-8?B?RWNpQ3pTVCt4LzYrQTR1RlZubzhud3Q4TlAwaGZ3WjFBRnpBc1FEaVEzRmNR?=
 =?utf-8?B?NXZ4eFljbEFiRUY2dWNmUjlVYWdjYlIvQ3ZDOGVKVS8zZlJMRWFmYXJDaDJZ?=
 =?utf-8?B?UWNMd0pGYkpheFkrY0JLc1lBT04yMzJPbmR2Si9OL1VSTkk2YlhOYUJzWG5M?=
 =?utf-8?B?akJsZ3NHZXpVWjhzUGNNL0Q5YUVKckZOOFJ5WS9nMkxQa2kvNVNiWnpidEtQ?=
 =?utf-8?B?SG5OTGdwbDluVGkyVHZNVHlhMFpRUzcvZW9CNzRwNFlRYkNFekg5SEV5WTFk?=
 =?utf-8?B?OXpwbGR6WEFzMUVUdFg2Y0FzWWQ3M1pTTXdsdWMzWjFRS3gvZExHVDdjMjMx?=
 =?utf-8?B?NmM1VisxMTVFV1J1SEk5eWl2UEpDUWFpc3Vra3BuY2ExS1R3YVNGZzBqZXAr?=
 =?utf-8?B?dndwTmlBMmllYmxyN1lVNFFrMnpCa0lFZ1F4NisvQVpzRUhJOEdYTkRYSW55?=
 =?utf-8?B?c0RHdVlLYlNzMWpBZkJnakN3dnNDNUYrVm1DbXgwdU4yRVRHeGxmcCtuSUZw?=
 =?utf-8?B?WExxVUZTaVRmYTdsemFoYlphcUNiZjZ6eDBaNERPeXhQNndpRmE0N3c0b0p6?=
 =?utf-8?Q?5V7jVm25+udXP6o3jV83NhQuR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b45aaf-23af-4030-61f8-08dd5cf2827e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:04:39.9610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJDdDmWcFpwJ8Z/89ZyV9HJHDa0r/SGl6KG2KsHrxKBPZWPo0rf6Co0nt8xKJsNICYu3GJXTdCa3XKnOLHgerg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662


On 2/28/25 11:58, James Morse wrote:
> rdtgroup_rmdir_ctrl() and rdtgroup_rmdir_mon() set the per-CPU
> pqr_state for CPUs that were part of the rmdir()'d group.
>
> Another architecture might not have a 'pqr_state', its hardware may
> need the values in a different format. MPAM's equivalent of RMID values
> are not unique, and always need the CLOSID to be provided too.
>
> There is only one caller that modifies a single value,
> (rdtgroup_rmdir_mon()). MPAM always needs both CLOSID and RMID
> for the hardware value as these are written to the same system
> register.
>
> As rdtgroup_rmdir_mon() has the CLOSID on hand, only provide a
> helper to set both values. These values are read by
> __resctrl_sched_in(), but may be written by a different CPU without
> any locking, add READ/WRTE_ONCE() to avoid torn values.
>
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


