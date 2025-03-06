Return-Path: <linux-kernel+bounces-549895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D51AA55855
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA74E3A7DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2D277027;
	Thu,  6 Mar 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aCGTs+Ct"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672C20F061
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295137; cv=fail; b=lN1fLENqKdoXofkTTQ4T52+2F/Exxn2u9XxHt3+yuijZIsmtTc8+YVFd/HDpvicYPulLZuy5OJ1KAsZjc+8/smDWy4MmvJi4UGYZFBY3xvzdbvYufl1M6j19E7wtSIg++pslTt4VtQQf3LaRBEtWSVNkXZGyK/4wGHFlMl8LHdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295137; c=relaxed/simple;
	bh=DvRNb3oN5O5qhoQaIcdETSOyssPGtqPLOaTfjjIm5TU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=evX3tL4c4mdeZRPTWJKdYKePf1sMDGAzuhFqBThkqQGJfW2xL879zRFs5p+OzIrwl3o7MqPeJEjJyDHAPOuaq44TLj6Y4PlFguCuR9MeVhxm4F1VyjZ/CvgQCcFTIe1onMgw09OL0mXbX8QuYXZ594BxLk9y40SV3T5xZvx+J+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aCGTs+Ct; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/Ext1i4U16MdZjagxtoMYqchf6mrdijGM6WU9xyeT4CM9TYNQDiREjlBNM6jPwHRgMJRQB5m7HMFeUSW/IxS/3ClpzqzsExtf7L2tPiCgIXNv0Kt4Pc//kZRcjwGed8PEslASWZ1sOZBJmYPaAXICO8NDu7tmFRZGF8wP+tWK61FXtF/1QtAcFhTXZ9nBDaYGVH0hVqB+riRUlNmTzZglN67hXj8VSWsd7+amkmLr2U+tWdM72XWraCq4EJLkZU8alpON31ftfGFXa+yLVwYtmIhZm9nBOkiwyRaFnE9FBzQ5F+Q8RnrsMAHDRwKmdRlKS300mrCvt2yY4MsYyHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvRNb3oN5O5qhoQaIcdETSOyssPGtqPLOaTfjjIm5TU=;
 b=rvUMgQ6olShsHz3bIcvE9I8X2Z7WP9M/1gyz8QE6MYxSiU9oslD6Tq6vakgBahwi4k7CXuGmo2CfnP65HFtz8RyjQWaIKQZsQLL8dWiMbHi6PJEKFyOADGuyZbQvbYqZj0eot2AE/FdTXl7MtJGbHorOTv6Kb/kw2+MsftkVEJxcPDg/huEGOreb/j3xp/E39sIcZbhfBG8m6vylPQdU55xHMx4166iJydc8iJyT/ByF/wbTYK6Etf/0P29E/VGfuO6V+3WnM5dAYC3B76xkdh+hkkIdl98vxZd7CwcWFTTgS83Bbi/h9vNjPV3/cmV91Wko0NQGnwhrCasIs962gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvRNb3oN5O5qhoQaIcdETSOyssPGtqPLOaTfjjIm5TU=;
 b=aCGTs+CtvzgKbW5rJojA8WOwAeQs+IbFpW/0uGij3NTFV5aXcMFzHJtwotrePppMN3S9gn7KxtBRVx/tWaA4k3SO6n8rWySzyZtSScQWbAYvWsGI56MoqskBD+Qg+eCL5stzKlTGkI57qQQvmdfCcM4ZCcaYXlfaMutQwfwN3DE1LiuLjGG4V4y2e72WATG955dMZagw2OSUyhi+OXZ1vmYe88Wz+Nu4exgLOUJn8P7ZbCik18LZWGkpOUJCwgFQDB/00oMSg1KMNkXmOkGCnYbOIsCRzrJgYr3Dwnv5jin/dxw9v1264Zi9HJnF65LYTzz0VRGq0gtLxbnN+QgDZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MW4PR12MB7237.namprd12.prod.outlook.com (2603:10b6:303:22a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 21:05:30 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:05:30 +0000
Message-ID: <641a990e-6249-4491-9b6a-6a2d51be3b48@nvidia.com>
Date: Thu, 6 Mar 2025 13:05:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/49] x86/resctrl: Expose resctrl fs's init function
 to the rest of the kernel
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
 <20250228195913.24895-12-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-12-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::10) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MW4PR12MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab931c0-a3ac-4210-f065-08dd5cf2a051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkFsVTRwSHBNK1p2dXJJYUhJQy9aWFZDZW82cjZRVkZwekVVZU8vMS9LZE1w?=
 =?utf-8?B?WEVFVnNsVTAydWk3TnZoNmJqZTFtYS9lSEVhRGFEdzZ4TWt1MklZR1hUc1l3?=
 =?utf-8?B?NTdrVVFObnd0aDVyN2YwNXdQaW1xNlNNYnZXV0JSUmE5VGkrYnFKRXgzTHR5?=
 =?utf-8?B?SGZFTSthcU1qYXNhV1lnMFRZcTRDVDJjdkVvT0h2R3VINUliZ3prNjNmU1ZM?=
 =?utf-8?B?NXh3YWs5MFY2YUU4ZWhLV3FIUXphd1RjK2kyZ3JBTTVGYWFUY0VlZ290bEtk?=
 =?utf-8?B?ZDBpL096Y2FqTUk1Wm1zSm4zQi8yYjRwWjlwWnFNSnR5dFlneWNEb0hmOGdV?=
 =?utf-8?B?M0Y1cXFPWWhOT3FRUVgxZW0wNWxMZVFzbjN6a00zQTFPQmpSZEFHNk5QbUhF?=
 =?utf-8?B?ZUhtMHB6TWs3aHl2eFFWNkJzQWd4WktPMDQ3TmxUbnM2b3NzanNjWkdDbTVY?=
 =?utf-8?B?SGVjd29KY2VhcllwWTE4ZkNpN2JMakIyT0FvRWVhVXJrdDFvNGFDNmZ1WnJk?=
 =?utf-8?B?WjJ2a3lqcWg1ektteU9TOUhZQm9qZjBXblowVVNpbWM1aHBYQnkvbVhVMHR2?=
 =?utf-8?B?bko4UjZ0dEg0bWNEL1Z0OC9yaFBCTnZ2K2xsdU41dkJldHZ5MWpwUUlFVWg1?=
 =?utf-8?B?aFN6cTBNT29xNis3T1RzZU4vdDNyRlJsSTJlMldtV0hnbEFXaDBIT0oyTDQ0?=
 =?utf-8?B?SDhHOVRlN1ZDTjFpN1BCUlp0dFE5OUpjcHBEUGZ5VG1Yb2psVFBRSU50dHpP?=
 =?utf-8?B?K1lWblF2SkRZbGp0WjljKy8wZzBMTHY4RU9ZcEhUTWNDY2FaNlB4cng5U0Nv?=
 =?utf-8?B?Q3NUWGdGUFJYVk1sZTlHaGRNOC9CQTVhNldEWGFPRllzWDdkdTZlRC91VUxG?=
 =?utf-8?B?c2VvczhkZFhoMUxSNHljZ2ZJNjEvYkVldjZoaDd5blZ6bFZ0ZTdmVWtJZXNu?=
 =?utf-8?B?azFmdkpHNUtFQWllVUJValAyV2o2aXNKeXpkL2NXbHFHeEhFTFB4L0RjazhC?=
 =?utf-8?B?Y05zdXlsZlF1Yno2V1Y3N093OHA1M2NZdEk5MStFaUcydXJPb1RSaXNYYXpl?=
 =?utf-8?B?TTJscE1UL1pXd2hXLzdtTnZTUXF2S3lCSnRMQjFYc01OaVpKTUtNR2wybUJl?=
 =?utf-8?B?cE5LQWtCNjBWYzQxaE1iMjZlcXdQMy9jd0xkb2FLSHliR2VtcnNZNTVrMXNx?=
 =?utf-8?B?UzJvK0J0ZXYwL2JHWmwvUHBociszeXZGR0xiWkFuN3BXdDhaR2hvOGl0ajdr?=
 =?utf-8?B?OUNCZmk0TDhwYXEybCs5ZUdVbGpYZHFBVlF6UlJzSllQVC9RWjZMT2ZFMklF?=
 =?utf-8?B?TEY0Q0FLY0R3US94eFBSTUtyWVVuMmd4d2RyV1k1Q09zSGx6YW80MHB2STIv?=
 =?utf-8?B?S2VzOFRCR1ZTZ3h2OHNSTnBJSHhGY1hGeTk3bUZhd3E5MC96dncwbHdlVmp6?=
 =?utf-8?B?WmN1RFRZWUNRUGtZTERSN3prZDZNQ3BsRHphdTNtUkovUis3R2pDKytaZHZR?=
 =?utf-8?B?UThldUhwMWZjalFxQmdzVDhiOU1VdVFzaFBtdGlPR3oyZ09FS2hOcmkrR2xM?=
 =?utf-8?B?ckc4dzZ0cDE3TGpGS2dDdmQrajQ2a3R3UUFxR2FaZDY3Ukt2SUZQUUFaaDZQ?=
 =?utf-8?B?NjBIQjRrQTBxZW9PNUlDb3phT2Jzd3lsTUtXWU5pTVJwZGEwODdNV2FrVUI4?=
 =?utf-8?B?Zkp2OFRCU2x5a2xlSTdHR1l3L1hMWGFaZ1k3eWRrN2lZU0xUTjRHQzRqWnJE?=
 =?utf-8?B?aVRmUDg5MW94UG82S2ZheHpYeUVuT2x3RkQwVm9OUU1OUzQyVWxLclY5L1FB?=
 =?utf-8?B?aGNzd1pWbHpGbE5OMlh4QUNLRXdQNkI1SWJqVFNlS1pXSDFLbEVpK3phT1g0?=
 =?utf-8?Q?eWeyiSVIPWKbL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDhzcVpsbVorQlFXMVpMVXpJMVdKU2tpTU5MMDI5d2hycm5VbjVxamI0QjJX?=
 =?utf-8?B?aVFlcFVhZEVPK2xMcVBRZ1J6bWdNdWgyUUdOM1VSbkVyQWdoL3RoOG5mV3F1?=
 =?utf-8?B?TUJCbnI4MFNGL0t2RS9ZamM5bE9XWjE2WS9EdlpQcXBqNDdEbzVMSU9LaDVF?=
 =?utf-8?B?VEFncit3NTZWKzVjeXJKRUc5SCtESHpqWklRbzRsTUlGTmRjREQ1QTVESGJz?=
 =?utf-8?B?eFVrdnlUbk9GaEg4MXB6Ykl1dDNwTUFZVU8zeklQaVNJaXo3enV0Nk93LzZS?=
 =?utf-8?B?ekVWQ2FtOXZTaGVSdmRDY0t5UjBpdmlFd1lJTTBKUWF1NlB5VSs2cDcyOExu?=
 =?utf-8?B?dG5OcSs3OUIvdlRhdFMvd0toa1hjWk40ZmRrMVFvRGtNZDc0Zk52NXYrVjF0?=
 =?utf-8?B?a1lwaHErU0RDNXp5eUtjamtleU5PY2hiRmxJM2lVQjRLUkhkUXhZSFBMVGty?=
 =?utf-8?B?TUduK0h0QlVTaHdaeTdMdTRLMWp1dmxrWGplRWFRU0Znb1ZKWXJKTytZcGZO?=
 =?utf-8?B?cVRMd3ZqdlI3eTVDcW1LR2wrcTI1ZytFSm5WNnMxRE1BVjBvSXdkb2VMbnIr?=
 =?utf-8?B?a2FwZTBIVVhwaVZqZmtQTzhLaVA3MnRLZFoxV1djVnFKa2tQSEpWYUdldmJr?=
 =?utf-8?B?b0c0K1VlWk9Ca3kzUkdUbWNaWS9vdjErMk5pZVZsTThhTmJ3RHRQZ1JuRHFt?=
 =?utf-8?B?bWZwbk5HbWlkY2xhSUtaYmd3MkpvZ3hRMnVEZFdqTDU3dHA4Q05WdE40YmNT?=
 =?utf-8?B?KzRjY3BneE85VExLcWg5MCtuM292M1VibGFyWklZMkFac2VDODc2MU1hZUM5?=
 =?utf-8?B?K0V4NkZCR0huelB6WCtxaGxmRXNtZWtLSkxRWEhyOUhRcHBTaTNjcXB2WS9q?=
 =?utf-8?B?Tzl3WnpkUnNEeDhmSnlmOFREQXBEclArSXFBV3BZMzZhcUwwSzVyV2tjUkNt?=
 =?utf-8?B?c1FGQnlDNXB6dlZVNWlJS0lCUUR3M3BFWXZ1b3lhMUdaMk9xdWduR2c2MWRL?=
 =?utf-8?B?emUvUlk0Nk9uSlJMcml5YWU1ZlFlbUxJOXFodnZSVlF5UVlCVTBibEVvdnNh?=
 =?utf-8?B?Wmk4ZHd3T2Ywc1dDLzF3K1BqWktrbnJXenI3MlBRN0NNZ202WmFpWDkvcWJv?=
 =?utf-8?B?SWZnSHRqelBwMldXV1Jjd3RzdnUzcjc4UmpKL2ZpTXlMMDQ5N1duenBOZjh5?=
 =?utf-8?B?VGhpQi9lbzBKWnpiWTFEZFVNR3VCMStQbzZKbHExaVg4Qno0ZWNMeVAxdkhh?=
 =?utf-8?B?d08yZWt6WVFPK2R6TWltUExjQy9IUUl3eDVHUjNsZ2h2YXJXSTF5UzB2aTUx?=
 =?utf-8?B?ODh3dWhZakVqNnNkZUlVZE1qbFo4RTRSQUpCcCt3WGh2SjM4RitqSnoxTzRo?=
 =?utf-8?B?R0lZY1hMMXNYYjBUSGdzZ2Q4Qmlyci9kMWZYQWR4V0VicUVCTjY5MjJjR2JU?=
 =?utf-8?B?SFNtWjlDNHlTRGR6TWhEanY5VjlLNTg2NHJ6eFd5STdqaU56Zkp4ZnpLTXB5?=
 =?utf-8?B?UHJ3QkhKK2tDZUxSK2QzbmJ6c0graTdnN2l2WUZ4ejMyUUwwSm9PcW03dGNN?=
 =?utf-8?B?eG9OWGtMVWo4UnJWZnBleXRGQWIzczN3Um84OW1vZ3lvdnNqa29RZFIzdFZE?=
 =?utf-8?B?Ykcwa0EwOHo2cHB0TDBIVEcwQlZlNC9yQXl2SEQ3aGJTR2lUVzJuRDBpM1Rl?=
 =?utf-8?B?WEFqMVdHZmMzN1AxR2hPMXg3SWxwQ0VQNXMxQTFMa2p6NDA0SFlHM3lFUnFq?=
 =?utf-8?B?amozSENWdUpHK0RmQXlEalRWZ3ZaOVBFemJoMU85ZG9ML1picW1QSC8rRnBR?=
 =?utf-8?B?NTJLOTJQckgrN2UrNUxoMExJcWpNUFBZdWZHanJMK2R2VEJRR0I2Z3FDZmZF?=
 =?utf-8?B?N1hjNXozQXJnUEl1Rk1DNTdybGxjOWZKc3FEUnF4QlNhcUhJMHNlWFplSHVr?=
 =?utf-8?B?NVdHaEtuMjY4cGY3b2J0UjdsUm43Q21UUE02VEVmVThHalV1RXhsd01YSytD?=
 =?utf-8?B?NnkxZmlzQ0d6eDRlYWhKVWxDTU5KSlhZOHlHdHRYbEx3UGQ4akRCNFhMQTIx?=
 =?utf-8?B?blZkOEdOdHhrdDhjRnA0RGRsUlNHbDZnRStnK1hKVDdyc05ZcEhNbm5YSVJk?=
 =?utf-8?Q?7QDQL255ERS9Y+MqbrLBkEnyK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab931c0-a3ac-4210-f065-08dd5cf2a051
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:05:29.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4LhkdbG3yfCni4JL6IXn1RQIbz8l/u73G/ogpzmHKi5bv8RLuyl75rhFmLcrN0EdDOqjhzBcRs/UkG2Tv5KEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7237


On 2/28/25 11:58, James Morse wrote:
> rdtgroup_init() needs exposing to the rest of the kernel so that arch
> code can call it once it lives in core code. As this is one of the few
> functions exposed, rename it to have "resctrl" in the name. The same
> goes for the exit call.
>
> Rename x86's arch code init functions for RDT to have an arch
> prefix to make it clear these are part of the architecture code.
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


