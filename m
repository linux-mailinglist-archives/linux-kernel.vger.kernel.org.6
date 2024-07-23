Return-Path: <linux-kernel+bounces-259542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D326939816
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41571F220C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC113A243;
	Tue, 23 Jul 2024 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TW31LTpn"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B4EC2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721699700; cv=fail; b=YPM5DeJLtNcMihkbpyPbx64Sp2DE0AETuoVs8c6ewxhcCiAi4L0NDma1uCT/WnhSnNTq4YJfB4it5E4EH180qJMQTO+tDFml2U9mJwSN88pA1h2WsYrmFwxGt7ECz4coqFPPTm3YsoKEfcULtX7mX9Df0VLPKN+FDPCuQhYgr7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721699700; c=relaxed/simple;
	bh=L4Q8JxVScE6uqTitOo5NgU5WxojH2y0yGaS+yxqsTPg=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=ND8DTbTJCTcSsulDg8HBEXqKnKLhcFGfT8kMLi/I+mid9gL5LEqDDkuOAOhTK1YYp4GBZGpNdkEmr+wbnvxgDtheuZeW0BZFDTNv/yH9Op92hfXVBmDjTIFNidJekx/F5vNmFcfRxZkpCEY9qYZD4CbG4sK6AAnLFQ4pJfq3NI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TW31LTpn; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RriBJQLgoLt7r4yF2MVGSr7GjtN4uBOnV7moNFdBDRtCRWvbCMU/Bb2tgvXSVFnk52pdEvJMTpRllcPdukklzhK4O8NrDfRcKuM9EN8s4ARYxzFiyvm2HO+MxyQqRMNVr88nFdAFaQEzxdrJUiXTmpV0HsFbpqGpDVX2knnVmDxsGhFk+B4nJv2TVS0F+6TNQqh+sSfmSn3AJydMCp4RdxOLEOy8mXXTao+rfsdiH1GTceMlANgNwYVtF8GS9mhpc9hXq68/nKMSwP7gSRlbt3tC39sJyTLE3zAVtGWKFrlvOI9amWRbnCYkEcZLPMdJuBOi9z0zxSBGIiKgLGQA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifxzlXcJ/q4S6taU05LtLupRJCjuc8NIzdjvg7rtRSA=;
 b=AvPNaUdpK4s2eL0GTtL6vr9XFDQAOwK8jKGI2LTrhms1sEMWTFXmlqJj5BTqIh3KLOQ5VE2EOh06A7A9JfxWjVsu6j0siGzkYfoE96odiaw8sPj6bsnwnqIRxdep0NL/rn23URbvcQhi0qWvZTWujr/mshPB9NGaiOR8H2kBYOJ/YscFSEXJVylXGfGrXtwmTRDCzWVE3uacvfN9B8StQCEvELJlsYn0sa5ir3zEICS4u5OYVxk7kIviCz58k5cVgMQ+RRCs31ivnaOvqSkZngGUMNxRzwd7idlJ+IKU1OE5L9FWOoWEylwLUzmQ2fug1byjznJHgTLLNSeWvHjjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifxzlXcJ/q4S6taU05LtLupRJCjuc8NIzdjvg7rtRSA=;
 b=TW31LTpnaakw4pCaeHtVve1xLxZaLqsNco3B4jty0vDGteOJ/QbLoVtQf26mnc6kGyJ6qOKbN5FjPbzC1UGw1v2qCGULibZx16snJmMRbHqIMTVyUHyR2cPuI66//OuPEv5gWErw6/vNAj04/GOIJI+Hesn0nhtW8NsnCrGvsQBqG4Js5tHYSKDscUI0wBlmbASNFhco8xtv2tJZb6ZRV2U1dhkEDmYfk1cCSqoPsU8Xb8ioeKhE7GMrYhyL0NfbGhd2dyYUWvfkk5vStMvOzFEvWX9QcrwpfbMJsEhZoPdWR+L0EXEQFb0Yg3vPPC8RaKbMSEUrgj/M0uBQl8KKew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.18; Tue, 23 Jul 2024 01:54:54 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7784.013; Tue, 23 Jul 2024
 01:54:53 +0000
Content-Type: multipart/signed;
 boundary=2e7af901c09513d7e8fbc35dde7a994c9763011067a6a171dc9ef663ed37;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 22 Jul 2024 21:54:51 -0400
Message-Id: <D2WJLRHB9T9S.DRAUA25VKCBP@nvidia.com>
Subject: Re: [PATCH v2 3/3] memory tiering: count PGPROMOTE_SUCCESS when mem
 tiering is enabled.
Cc: "David Hildenbrand" <david@redhat.com>, "Huang, Ying"
 <ying.huang@intel.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 <linux-kernel@vger.kernel.org>
To: "Kefeng Wang" <wangkefeng.wang@huawei.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.17.0
References: <20240722172917.503370-1-ziy@nvidia.com>
 <20240722172917.503370-3-ziy@nvidia.com>
 <5230d72e-81fa-4ef1-b386-90bd3b06bf0e@huawei.com>
In-Reply-To: <5230d72e-81fa-4ef1-b386-90bd3b06bf0e@huawei.com>
X-ClientProxiedBy: BL0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:2d::17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: eff5ced9-3160-40e5-4c74-08dcaaba7230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVB3UXkzUE55bGJONzJrdUFiU2gzNENDRUttNmU0OTNvZmJGT1J1RlFxSGkr?=
 =?utf-8?B?YnVQc2Z3c0hpNG03VnhaT1BSSFZIVkRTTjhld0FLZTl2SWVRUDFETlBNbit5?=
 =?utf-8?B?cHV5MnFEQkVNQVhzUWZlZ2s3cXZsVTg4SHpPWG1WV2I4NkRjRVFzbjZtcXZK?=
 =?utf-8?B?YUhPVFRoVzQ1azB5T29qVXBPbFZHOGFOZUNncDAzcEs4eXJqQ0ZlNFc0Skta?=
 =?utf-8?B?eU5NV3AzUjR2elRPeWRRYW1WYWNQMFlaQk5KcERJWmpxaEsxWUkydzl3REJt?=
 =?utf-8?B?UHpZNFc1MUhPOW0yVTlZYVBiWG9uZHlOUjJYM2tOZWxCMCs1VEZtMGpwRWRK?=
 =?utf-8?B?RXMvdnYzZGlrbFR5SThoV1lXeGxSd3IvaHcycU1vVDlHMEo3RXl0RlhOK3hC?=
 =?utf-8?B?YUtxZ2ZPVTdGZHJmMzFRa040Vm95NWl5enBkR3FCTzVrV1QrQ1dOMVZuanEx?=
 =?utf-8?B?ZlRhK01NWG8xOHlEWVRld0VsL3RiV2J2bEh1WTU2Q281blhlWWhpMUpOb1lo?=
 =?utf-8?B?UXorU20yallnYjBWcXlKNzlHWUwyQTErYlF2SlZTR05sNmhJWU5QVGJJdkZM?=
 =?utf-8?B?M3JkUUFwcVhZdFpybllUZ0dZbDdGK2dncEJnTWZabVRBaUMwVHFSbnlqTVRF?=
 =?utf-8?B?VHkyYWw0bDdxd1lFTlBFbDQ4ZUs1QXBMRkFUMmgvbkVvdE14YkRaall2Mkd5?=
 =?utf-8?B?YWk3YVNMK1lMK3RSakR5U3ZoZ25nOFBxdmpoZmxkcS9MbWx5S1FYN1dsWmt2?=
 =?utf-8?B?Uk5OYTRRLzYzT0ZwRXpxODJxVDBGVlE5eFlFVEl6MDlvTEFjdE1kVHZjWWRj?=
 =?utf-8?B?M1M3MDRsMTh2Sit4RjJkZ0pJY1ZKZm9NUUpEK3BORFBMcTVicG40a21Dbmt3?=
 =?utf-8?B?OHAzR3pQUjRaaUkvelNncnM2NSthRlRMWnk3eXczQnpka0NuVjI1VGhiczlx?=
 =?utf-8?B?RjVBZjJFU3IyeFpSVGJBUWl3OGhkaDdRNmN4bjNJMDdVK2FmbVpWUUtUZDBw?=
 =?utf-8?B?ZmtEdDZ1bnllNVJveFpPU1FvZDczeHlNdE84UUh2TFNUbVBWdDBFYkpkL3o3?=
 =?utf-8?B?UExrckR0S1U2WklYK3BGZWZBdzVweFFkRlNqbWtpbk1GRG51UGRHNVF5TWlL?=
 =?utf-8?B?Y3JDVTJqckpFZzZIcU1hc283c25TNDVrMVF0OWx2SG5KNmhzcDNpRGJNd2x0?=
 =?utf-8?B?YS9vRlJSNlBiekdhbUVRQWJ3MVZRSS93YzlSQXVZSkVxS0ZzMld1cXQrRllx?=
 =?utf-8?B?cFVPNEJiUkYvaEhFcDNUVStZOC9aNmk5QmdiTk1UK0hFNEt6QldyMEgwZnBQ?=
 =?utf-8?B?Lzg1M28ydkF2cGJ0Yzh5VnF2SmxMb2ZaeVo3emQ4Sk9KcHFwL0RJRDJ5U0Iw?=
 =?utf-8?B?d2JERHhUdVNmSzdPY2c0SDdjR2lZYUl0L09MN3V4L2J5S1NBUEQ0aVBqbGxO?=
 =?utf-8?B?UmcrTWNxNmZnZ2d0VmNWR2lmVktyMDlJS0RWM0huTnFlU0R5Q0RwaklPZTUw?=
 =?utf-8?B?VFNoVXpuZGdpUlJCZFh0dnF1dTlYN1F4RngzQWpKTXZzdXRNbFR2alpQVXEw?=
 =?utf-8?B?VE5SOXdIS1ZZcVNYMktpWkNSa1U4WFZzcjczcjNXK3dFeGpmRHRDbXoxR1lP?=
 =?utf-8?B?K0Z4d1BjQXdNRE9QNTRIMDZ1TmVYYkRkcmYxZGJBMHowOWtqendHRk12dzA0?=
 =?utf-8?B?VW4yd3FwRFBkVUh2b0drbUxubSs0SGJHQVE4cCtoZG05clVadXFObFJ6dGVE?=
 =?utf-8?B?bk1WWlU1dlhVd0gwR2gyOTkrd3ZldUQrME0zYjN3WXVNeUROVjJ4dVRCUHFD?=
 =?utf-8?B?aExPS2tYOTJaeVZVTzUyQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXhnQURuT3BFWWNySDBUdnVXRFovc2dZVFNJRGdyT3ZCMlY3MnVvM2trS1Vr?=
 =?utf-8?B?bFp0NGhBczNNdHlmQWJtekRGT2VCbkxlUk1kVmJlRjNtSWN3emxFTHVkTEFF?=
 =?utf-8?B?aU4wSHBkQ3ByKzdBUkNETHJuckRiSzUxWVhYUi8vQkRYZDhSWGJwbnA5S2l6?=
 =?utf-8?B?U1kvV1hYYnU5V1FRMGt3Qkh4MW9iZEoyTGp5Z3k0UHdlWUZCL3pSdFBrTkMz?=
 =?utf-8?B?ZG9nMnYxd1BVWW1Qekg4SUtDQlJuY2xYazJQNlpwa2FNL2VzdWJJcDFFOGJw?=
 =?utf-8?B?SzM3ZkdPQWM0RGUzZDdSWDZMaWo3YjFQMC9SSHY0N0RvNVBHaFV2YlhHcUww?=
 =?utf-8?B?RlRyVEFja0tldy9hTnAyV0xLSDRYZm1zWldwTHlnNGVZTnlYaEt5YkpJcXZT?=
 =?utf-8?B?N1RTaGZQMVNJcFY0bDhjOEdGRmdKTWJYNXZOTllUbDk0NlhpS0RWck5Gb1o1?=
 =?utf-8?B?TENxbU5NQTQ2bVVFREpCVCtHcmxUR3ozMitFNUc2NHRRZGk5eStTNTl2dTRr?=
 =?utf-8?B?cEtBdCt5c3ZKM3dXclcxWXlvQW1iZnJ5Tzc2Z0RObnVuT3h1NnlpREJzM0ZB?=
 =?utf-8?B?aGRXcVBFbU4wZFltenpOMGo2KzkzSmVHczYwZFlzc2FHWkpXMHZWb2x0cmwz?=
 =?utf-8?B?UVJ2VGJPRnU5MHllOXYvUXZIQUUzZVowR2o5UTA0SngzZjVJcnU0UzBvUjBX?=
 =?utf-8?B?ZHF6MWNHd0xoVHA4QnpBN1VKRUVGeUxKVnRIbmRvVmtrbzZZb2NQaFdicmZC?=
 =?utf-8?B?d21JeENzWHJtc0d0NFdPZkpTcXRSRmphRG8rT2w5ay8zUWlYSElCcmJkMkpC?=
 =?utf-8?B?U0ZESWxZZE4wWDFyNWNXWFNpeXlzQXJXaVFhdjhIUDZJb1gwZWZtU0pSVVZi?=
 =?utf-8?B?T2lqTUpIWjNiY0pCUkliZDFJTThrNEpJbHo3KzkvQlRXdWEyanZtZ0t6Qjgv?=
 =?utf-8?B?MGZWYjgzV1g0eEljN0hidVJRY21FUlFXbjFpNzNhTVhSWVZIUWlhOEw4elY0?=
 =?utf-8?B?MmQ2dkE1Ump3ZWxTT2NBYmhjdUZnTkZpa0hpSEVwSFh0YVZDR1kxQU1IRmRl?=
 =?utf-8?B?OXpYcnRvWjlzcXh2YmpFcXpJaXNwSWJ6NmtyWlZIQ0hqeGpQUTRjSGMwbWd2?=
 =?utf-8?B?Q3h0ZCtSb2lQcDdPRnhDWWIvZFZYdVY0TENZTm93WlpEejg5eStzV3BOQkZV?=
 =?utf-8?B?d01WcW8zYmljbzBZLzZNUEgzajR2Wmo4RWhYZklNSU53c3dHYlhxK05rL3N0?=
 =?utf-8?B?VitTTEJmN1VPRDVOKzRWSURlaEduMytiY1RmcUw3ckozYkdVMms4dHk3MktM?=
 =?utf-8?B?NFRLTWU5cm9wL1NwSUFlMXlqOXlaRkdoSW9qOHYxSklQMEovQzlmaTNwODh5?=
 =?utf-8?B?aW8ybEhBMDZHMy81aFYyeE5RbGM0dEhzM1dNTkhVbjJPNHZmeldJNUxUYU5R?=
 =?utf-8?B?WG4zZElobkZHa3YxejZuSXU2dFV2L2taWVRsRjRMUXdvZC8wKzJNVk81STdM?=
 =?utf-8?B?NlZZVjRGbDZ1a1R3dlJJVEEvY1lBeU14RGNBK0p1ekg0MTJtZUNBK0I3eHh4?=
 =?utf-8?B?ajk3Zm1yVlB5aDJraGVEaE5seUd6dGt2cHZmOWhkL1doc1NnMHd3dlUzYVRp?=
 =?utf-8?B?Z1ZqZHkyS3h1b2NWM3NoL0w0TXV5endkakVZQ3NhRGlONXMxRlRnV0lKL0VX?=
 =?utf-8?B?ZlNKWFNlaGhqRzFObHllWHJ5b0l3Q2xPV1NpVmpTZkd0MS9ONEdxMkNZVDlj?=
 =?utf-8?B?anFDSWNDam9wU29TcHMxVEFpQkNLbXNqeVBveUROQkVQYys4Q3hEQmkzeDRy?=
 =?utf-8?B?cFg3bmpETGUyTjAvTm9FL0l3K1p2OWVBNTV2cFo0c2JBdTkxcDFobnhzRW9I?=
 =?utf-8?B?UnV4Qm9xNEREc0Zpa0Z5UkRCSjZEQTdiTEpveWZPRXpBUXZFbm9TSWJlQU5D?=
 =?utf-8?B?Nmo1bE1rV2hCZVd1MXNQcGdDeXQrL0lsRmNDZHVJNE9DRTgxVHg4WGFOMlRs?=
 =?utf-8?B?eUFjOWQ2UGMybnlWOTVJNWNmcWxtRHhCWHRPeE1IdXhSNi9OTXhmaCtzN0d1?=
 =?utf-8?B?NURJWjluT0Z5RXdTMGZvZjkvV1NIaVpQU3R3UHJ5dGR4eFFaNkx2aWpIdytw?=
 =?utf-8?Q?76ugdE+szDXLq+I9vaxdZLeqk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff5ced9-3160-40e5-4c74-08dcaaba7230
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 01:54:53.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cEkyQEZ0z6Na50KUV7wcWDI3NTjTujQho3wwFgXmN1dLn/PpWAydMq+9XM00+mb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028

--2e7af901c09513d7e8fbc35dde7a994c9763011067a6a171dc9ef663ed37
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Jul 22, 2024 at 9:48 PM EDT, Kefeng Wang wrote:
>
>
> On 2024/7/23 1:29, Zi Yan wrote:
> > memory tiering can be enabled/disabled at runtime and
> > sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING is used to c=
heck
> > it. In migrate_misplaced_folio(), the check is missing when
> > PGPROMOTE_SUCCESS is incremented. Add the missing check.
> >=20
> > Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Closes: https://lore.kernel.org/linux-mm/f4ae2c9c-fe40-4807-bdb2-64cf2d=
716c1a@huawei.com/
> > Fixes: 33024536bafd ("memory tiering: hot page selection with hint page=
 fault latency")
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
Thanks.

> > ---
> >   mm/migrate.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index bdbb5bb04c91..b819809da470 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2630,7 +2630,9 @@ int migrate_misplaced_folio(struct folio *folio, =
struct vm_area_struct *vma,
> >   		putback_movable_pages(&migratepages);
> >   	if (nr_succeeded) {
> >   		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> > -		if (!node_is_toptier(folio_nid(folio)) && node_is_toptier(node))
> > +		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
> > +		    && !node_is_toptier(folio_nid(folio))
> > +		    && node_is_toptier(node))
> >   			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
> >   					    nr_succeeded);
>
> The should be in advance of patch2, and change above to use=20
> folio_has_cpupid() helper() too.

It shares the same logic of !folio_has_cpupid() but it might be confusing t=
o
put !folio_has_cpupid(folio) && node_is_toptier(node) here. folio's
cpupid has nothing to do with the stats here, thus I did not use the
function.

--=20
Best Regards,
Yan, Zi


--2e7af901c09513d7e8fbc35dde7a994c9763011067a6a171dc9ef663ed37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAABCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmafDW0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUW1MP/0Sv3Ov2XPHklC9e922UrQWO7OciJDyIBTF+
OeFqhy/vP3ggtjDgAGEgJYKfORX92gMMF1SRWF1lDccp1wlZyGrX1C3AjQWwe0qQ
hNCaz/WbbQLq7XNkGbCJubt7AWDL0svvtobPlWxN/rgQq8EpH238SBKLtgWyvkEZ
FrJ+sJ3mx6YV0BEXEXoGZLIB/hCrkcakf6ATivzfqaWoFqZvFuh9xC/u8zvQ65xQ
mvqFbM7AJjOISzaFJWu138nm0XUdjTJ7OMbiVLVqEfpwCUSdv++p7j7YIla+7K/d
7fmndU4AyxDpeGKRUQ6eDjxvKn7hjpCytdrsoVGil/Vd5j6+1NQ4rOW/knvJUhZ6
kIcjOlvSE6vf7g+16FG4GU2OtDHquFX6NnJig4fdOl/nROy9g5SAB+KiAJyu5TN+
qQTK1ZoLCIwAhvvpsRuddWNl9//eVvijx18En3K4SCWoSh6C6P3TAtp2ODAkwxDT
7u4IO5SDvCxkpHDRDGxKaRTOUX5KPcEqNPmbvubTCCecsHl5znx3CCN8WN38xqY/
12XgG+lhobps/r5AvsapnalyZDoaOo0g1UWrcwRuV8d5OBEmbqK+5ULyVlc1hQOb
OdL2KR4VvGOlBtwFQKaJrKLNOQ9fSPKnxMmMRpwWaxVGuMNZeRwozvFhnouyJ/3d
saw2m8VZ
=dZwq
-----END PGP SIGNATURE-----

--2e7af901c09513d7e8fbc35dde7a994c9763011067a6a171dc9ef663ed37--

