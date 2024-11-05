Return-Path: <linux-kernel+bounces-397189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622739BD7DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E921C22C32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CCF2161FC;
	Tue,  5 Nov 2024 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="NRZpIDwl"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DDD1D5CEB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843602; cv=fail; b=n3paOJ5Fg6ep/j+wvkrl4KKaoRuD3xkL7j76x++lvz1oko6QpEV3ClRyEbNxNheFcXchYuiBkjITAXBg8pK8n3E+uXpsI/gB4wYgZKutR84PoSFHVboY/Ah6c6jo0stoK/uZvW3R0tRt5UWLYRFfBqm67wboS9Y2WyRK+Zmuj/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843602; c=relaxed/simple;
	bh=dDq4BxKPKrlnYavo45NyKei+xLk2vTMohYLMTWyTFjM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t5+Ptl2UJVuUzkoY9UL7REN5/lreOXOzi+aTxA9WBqWJl1JFhE6xgeC3GUqvFTzmQLaAdv3cIRbX+Jusptx/yALGbxKqLHvTZFT79JSDLvK/8nEah97ciga+GJzrYg7dURl9Q5BJZMTeomK/zbVehbaYx5/rYH8hoinp3RKh1Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=NRZpIDwl; arc=fail smtp.client-ip=40.107.22.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQ0eUo3xzh+MoVotmgqGtVi3t5MkWhhwiXlXV0J+PAwkR0sdJvOp36lD7m5m9kMTwDGat0E2IMIcFtVxH5qFN+KtyKgJjuaqJ7ojl2++PJoJoOs0OCdG5fMedLTCT9Ma0AF9HaJBILfoc3bFaO4MNYXHqaBsOc8JXitZwT7VOZ+upl/HVaSzCQqsBQhBOlV9ookn9tMth3RXp1PDySI3KdRCl1IPRXvHrb0ip1Tug5/LI8kRaUEy51F19KpvQSQwblMy/A8npw6p3txihaLBtdzDmbr1ErETDSec7IZMvQz9uuvJmhTOXGcEjMhnMPhlm+XWiabKe0BKWPqQfC5v4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5u6VDi0rBOaN7NHNgp43HlFLO6TlBJdfngu6NGBdyF0=;
 b=JfYY3UCUSyefugB+idZPKgiQQmhXwcFB8FdmZ4t1g+hOcTxFdMAZP23wMtjvxCl3NCiFqhJPZvgKJ+0IPW1CB66h62DpyO/cSK95bVjMjbrPWPd8Vq4vARJiMuUVQbD2+jbOFR1e6zONEcJdtyoiucfMQ1bL0pRakym42Lbi0PN4WO+e505YH75Y5Cdd+qG01rrAvvkHNvgq7NzhnGdpDpNTU9vPCNIvSq6Dtlep0kvTcE0j79rz1YHDVRE1QQtdZDrFIiK0LdQgra0ukTeShnhPRt4KDG46fhWjMO2zxfCr/Av/jXl9bSuZaxmIPClEE7s2elUXZ2tGVw18p+JAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u6VDi0rBOaN7NHNgp43HlFLO6TlBJdfngu6NGBdyF0=;
 b=NRZpIDwlH0l/Q4w/XO/03aC4lkwcPhTEHSBFfnpjHcFv6J/ea15VFnw2nHwlwxC2zYyP+eEaaPDAEph09aLyGY3xUJKdJlxQc7IIBlLxCd3AM8OEeMpVD2PDNDdYBGguxlZPNhMh176Sh+jgD1hTLFd/Q7FUydSV7eYPaVklnXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by AS8PR02MB8342.eurprd02.prod.outlook.com (2603:10a6:20b:526::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 21:53:14 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 21:53:14 +0000
Message-ID: <2c69d0e0-c090-76be-3bd2-e5e92c585ffb@axentia.se>
Date: Tue, 5 Nov 2024 22:53:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mux: constify mux class
Content-Language: sv-SE
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20241014122551.116491-1-brgl@bgdev.pl>
 <CAMRc=MfscDCr8mdxSiC8zWUgdzdqLCo3=PKhuWhWueGoq_c82w@mail.gmail.com>
 <CAMRc=MehYdep3YvfDjZPmut4d2uKq+Cb5tQecJCQMjAEJxSdTw@mail.gmail.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <CAMRc=MehYdep3YvfDjZPmut4d2uKq+Cb5tQecJCQMjAEJxSdTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0048.eurprd03.prod.outlook.com (2603:10a6:208::25)
 To DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|AS8PR02MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: a407f10a-7716-4195-af85-08dcfde43fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0lvZk5uaXFFdWh6cERTak9lb1JnL1ZsbWNTL3haVmNxcnFzbThLNWZ2UHBq?=
 =?utf-8?B?WlNMbkswdml4UFRCSlhoVm9udDdVQjFnNktwZ0ladGRkSjMwai9SSDdDam1i?=
 =?utf-8?B?R3NtV2JjOU56L0ZDUStEMERRVDFzZks2OEJBUWRRMGhWbGRvRmNpTU40Y3dT?=
 =?utf-8?B?YklzUmZlR01Hc0hJRVRyd1hSekVKL3JJb3JKeVhHdTZaREZ2MjlIcEFDNDg4?=
 =?utf-8?B?TkM3NFZnWUJtVXd3TE5qUTdzd05nN1BHQXExRTRwLzROSU1Sd1Mra0NJVW5I?=
 =?utf-8?B?dk5VaEVZOXFtVGNGVjNNYTROeEFmMk9BSWcwM2hGVDNrbDBQbnVlK3dRSldh?=
 =?utf-8?B?dVdrVjZ2dlJGbzVDdUtCbktRWHN4UlZDUncvaXFRbWdPM3hCZUhweEFsODdE?=
 =?utf-8?B?VHBzZ3RtTi9mZzJRcG1uckZHK0JvUHhjVzlWaWc0QWR6dVdwOHJJMmp1Wm0w?=
 =?utf-8?B?M3o4NmhGUldRYXlXK1EycnVWRWVzZHhwZ00rY2xyOWtiUFY4K0FzU2t0ckJn?=
 =?utf-8?B?aVdHeXBkclc1VStRRngzbU0xOHZTRk0vc09oQytwd2NBdUFzVFZhNFBHRUgr?=
 =?utf-8?B?R2xFbnZ0OEhlVDQxVFNhQllhUHh1Wlg2OVJiWEMxMEplWkVNOTVUSHdPOTJB?=
 =?utf-8?B?eCs5ektFd0wwVXJzN3ZvcDRSNzkrY0wrdUI2SndIUFRGcGlQdVI5VTVPcHli?=
 =?utf-8?B?bVhFK0hOVlFEaFQzWWNweit2d1Arc0cwVkpBVWIxV1czYmtPUDY4Y1l1L094?=
 =?utf-8?B?SnRKUTVtWGt4Z29HbWpHSUg4SjJMNEkwYUlGbEN3Q3pIaFhTdU80QmppWkR6?=
 =?utf-8?B?RnljTXpCTDZKOU1oTlR6WHRKYjN6cTBGWlBhTzZOL05jbk0vRmh1dXBoZHBO?=
 =?utf-8?B?MmxQQThZQmpubXU4UjhwNk9FYnFVZThoa3ZYNG5JN0FiZnM2ejZUd1dkalVz?=
 =?utf-8?B?NE9xai9JVm1DcEkzbUpRNnlSRkw1Y1ZERlh4RVVIM2pabEs3L283UElGVlhy?=
 =?utf-8?B?dWhjK1FkcU1sbWdPSGxqQVJwaXB2eUhRSkZvMXN2VVJzejRNWmxpTTNKT2NO?=
 =?utf-8?B?VWFtYmJlWFlXbEFOU2JoZERLemp0aXVIM0xyVmVmdDBoSWhLaUE3aXZCSGxl?=
 =?utf-8?B?UVJQWjRPUjN1RjRtREx0M091ZFZTaE9kTkxFd2pidVkwVC9sZWtJZHBFRTFG?=
 =?utf-8?B?bU90dElMVFZKT29XTWpqdDRxcW1iS0YwNFVzTmhKd1pqOWtzRTA3TkZtNks0?=
 =?utf-8?B?UTJoQ2lYTGNST0FEMWJIdjdid3lUNHBNMjZvbmdOd1JnS0JvWjY3bU5aSS9C?=
 =?utf-8?B?eHQ5VWZUU2tJaFVOM0lIaFJ4K1ViTzRTT1VZU2lnY1lPQWhEMERESXFTU1RG?=
 =?utf-8?B?MnFPeFJwdWp3U1R2RW5kaGdxeDlseWRQKzE0NGF2d0JxRldFaWp3RXduTjlD?=
 =?utf-8?B?RWVGUkdxd3N1aWxMMVVjRmFYL1g0YzRJRk8xSTBqTUdPQU1YL0tYQzVNT2Zw?=
 =?utf-8?B?VWFHNXVrNE9MM09MRGNvVG1BVXJ6enIxMW9UU3lKL3VsYklLL2NIS1RxbzBF?=
 =?utf-8?B?YjNlN0JZNUdYRkhRZVBaUjlIcmJCUFVyMGljeEhSMGVuZFdEUFNnei90WWFh?=
 =?utf-8?B?UWptT1F0aGtYdjRmNGNwMDRMUmVBcUFscFdadHFFNGRUSlhlcnhhVVVQaXAr?=
 =?utf-8?B?dXMrWTZVd1N2QmpPWmR3bnNVRWRjZDFEa2JxTjN0em1zZTNyeE94UzRoK0ow?=
 =?utf-8?Q?XhUfZOfexi4rqwHcJgguVSmPvwzbxrelrIdaTdZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WE5yZW1meDZqNzRMREU1WmZaTTQreEFXUVFCUjFWZTMyQXBUSnNqand0K3lC?=
 =?utf-8?B?Y0swaWFZRWJYeDFmbzFzWlB4ZERNOENRU2NnZVNoTzluMGRLeEVKc3hNU0Ez?=
 =?utf-8?B?RFV4dkVNTUZGM1Iwd2NIdG5Yd2hFZ21oSDU1b09rdHlEUkZsY3VSdlZweHJ4?=
 =?utf-8?B?MGlxUHVjZTlDUksvRUtZM2FyRE5qTEtaTU9pc0laem8ySldZaUlKeTZrZ0Zk?=
 =?utf-8?B?bEl4b09KQkRMNjdJUEdPc2dEcVdUWVkvSm1kdEEyb0JjY0c1WW1JMWpRTHJh?=
 =?utf-8?B?VFVVYlplWHo4dHRTTGVvU25IZjUxTFlrMUdMQjhrMCtvZHBSNFF6VUZnNmdp?=
 =?utf-8?B?VnNlRXBKMHdGOXAyQjlEaFpqM0tRenNIRnJ1ZStadUxlYzRmUTc4c0J6VU0v?=
 =?utf-8?B?VkY1WHJZSC9CZDFoSVdWem9GRm5OR3hZRU0zeWpRRnkvbzQxWXR6M0wxdlp6?=
 =?utf-8?B?UllSVmpJMTVmU2UrNDMyZGxLRkpLM25tbTEwbkZscjByaWh3OUM1YXFnRy9i?=
 =?utf-8?B?ZER6aGI4Q3pnbkpKWmIrYTB3alpnay9tNGdRZmZqaXFIOURFY3ZiMXovL2NM?=
 =?utf-8?B?QWRnNHBzd3pnL05ZZXF2b25BVld2RU5ZNmNzeGZ2Nk9nS3ZxSVZ4T3E0d2U0?=
 =?utf-8?B?d3Z1d3FRMUVZOUt5R1NYU29DSzJkMTF4SXh2Y0phZE5nSU05S2F1YTVGUmpv?=
 =?utf-8?B?dm9YaERyRmZtOUdCN0xtWXFGUXI1SFBJQlVZSFZwR3BQT2owbXpoMGFJamF4?=
 =?utf-8?B?ZkdjVmxWaUNjdjJZWDROUk1SVzJXajh0NDk2dnUwZ1JwL0dqVm9PcWFvRFlk?=
 =?utf-8?B?ZXpwOElvSE9HTVNRb1ZJdGhrVFZ6RTZzRzhnbFB4YVVuRHl0Ky9hbUdyUzJD?=
 =?utf-8?B?QjJqdjI5NDJvUUtyTmY4ZkFUTDBGRk0zNnFZZEZDU2VabzNjeUcvbzY3eFFG?=
 =?utf-8?B?ZDJDTmthbVk5UHFVQ2txMWNSOHRTUmg0a1ZuSTlmQzhyYzZpNy9La1d1d01s?=
 =?utf-8?B?d2FQbTdNODExK2ttd1dZL2d1NFgreDhha3RtdlNVS0VXdWJ6eTd4MUlERnZ0?=
 =?utf-8?B?UVFyczlzRG9VNGYrc0RnOHZ2TktjdUpyOHFkc2lQeVJYRWlQY21jVDVmamJ4?=
 =?utf-8?B?VjNMMXZoRXJZTHRlckp2REd4REV1ZnRXTFp3ZVhWMUQ1UjBQbGtkVWNGc2Mr?=
 =?utf-8?B?QjdUVmdaVXJpN2E0dTZiWll6RU1HQ1Q4cVBGS2czK0pyQUIxV1h0dzlSMSsr?=
 =?utf-8?B?cmh0MmNRVkdZczNMRGxCZC9OdVl4aWdtY2R3WHpFZElSZmhhRk93WENCRGF3?=
 =?utf-8?B?RW0yTkVRbHZsUTBmZllicG01RktMYTdsbTdyN25zVHAvSWhRc3FTNTJDSk9O?=
 =?utf-8?B?UkwycC9PRGhVWTBHUnY5aXJMYkFLRFYvSjNQMnVvL0szdkxpZWRuay9pSVpm?=
 =?utf-8?B?ZFI2UlduZDUxYkRRRUZqZmM0YXhqVTJxMU1jaWZXb3dkTFNpSkEwQXk5MDlp?=
 =?utf-8?B?QzdYbXNSU3h0bCtoTDdma291ZWF4aFpONUZOaUVRbWJwNGtIRCtBTHAyZXVH?=
 =?utf-8?B?S1huY2NTWDZLbUZ4UWl2azJ4NERWWThlVnJiOUJwaGd5N1pvbW41ZU8wL2d4?=
 =?utf-8?B?UzQ1UjdGRGhxMFgxQkE4bGUzOGRRQ2RsdGFRblhSa25yT0E2TGZJZTdOTnM4?=
 =?utf-8?B?NXpNZ1QvckNrM3FMaE5hODd2VmN0dlBCZWpYR2dkMVB5RXVjQlZPd0JtbXdU?=
 =?utf-8?B?b01nV3NvaEpwK0ExTDRwVjI5OThwanV3TFl1Q05FTEtWOTl2bEVGU3hXL05r?=
 =?utf-8?B?eklRdE9XT1NIZVJBYTVTeEV0TTlleHR3b2Y4bUxoOHB2MHZDbHlXYnhUUWI4?=
 =?utf-8?B?cVpIYjJMUm1FdVBqZi9tRDZCRDZmaitJMG1JZzVSZkhTb1VIbGFMNnE2UXZL?=
 =?utf-8?B?K2dEdmE4TjlSd1JpQ21tQWo4UHFwTExkY2dBTmFnOS9tY2QxVDl1bUNnZVBk?=
 =?utf-8?B?NUw2K09oU3RETjVhd2pQNzVYUE55YTlWOUdCZ1VMSjJTL3RKK2pSMjl6amNm?=
 =?utf-8?B?L0Ywb29OaUNvdG5QbzM4UlVWZmdjdnVYOW52Y0pWTUNwRnJObS9KcnJYMHNJ?=
 =?utf-8?Q?YdXfKgiieqrpHnZA6D71hvlmB?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a407f10a-7716-4195-af85-08dcfde43fae
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 21:53:14.3760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ofO13CI7Rqic1tufNTJGDZWJAPCGdT/M5KP1Ps4znHaxEPpCX9QEsREEgDQTiKx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8342

Hi Bartosz,

2024-11-01 at 15:21, Bartosz Golaszewski wrote:
> On Thu, Oct 24, 2024 at 9:08 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Mon, Oct 14, 2024 at 2:25 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> All class functions used here take a const pointer to the class
>>> structure so we can make the struct itself constant.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>>  drivers/mux/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>>> index 78c0022697ec..02be4ba37257 100644
>>> --- a/drivers/mux/core.c
>>> +++ b/drivers/mux/core.c
>>> @@ -42,7 +42,7 @@ struct mux_state {
>>>         unsigned int state;
>>>  };
>>>
>>> -static struct class mux_class = {
>>> +static const struct class mux_class = {
>>>         .name = "mux",
>>>  };
>>>
>>> --
>>> 2.43.0
>>>
>>
>> Gentle ping.
>>
>> Bart
> 
> Peter,
> 
> Your email doesn't bounce so I assume you are getting this. Any reason
> why this simple change is not being picked up?

I'm here, and am just being slow as usual. Sorry about that. I have now
added the patch to linux-next.

Cheers,
Peter

