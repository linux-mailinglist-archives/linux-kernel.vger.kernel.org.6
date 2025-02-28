Return-Path: <linux-kernel+bounces-539000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452CCA49FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7963B5914
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F731F09B3;
	Fri, 28 Feb 2025 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P6hsEuJU"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BBF1F09A8
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762165; cv=fail; b=VJ9EMde1XGEYB7yab3VqxB5QrNm9OQnjeASOsyXmu4AkPyb1M6PG/2I7BK6fV6/qt3bj0OYKvzulE8av8a7dt6yzOtRbTO4PnY+hZVKZSOGLvFB/kfzSwCrWfqoRHaKCuTB2Jw5UZSpUykQgp/8hXmvSOI3Naabk7VbrwzRzRfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762165; c=relaxed/simple;
	bh=6VMigSKZEdExrXmG66jIFsQBcduQZZDwhhrWpd6fcuc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FjFzuE6rm2h0rBnXbSj21XswDhYP2CRBGHjBKMM156SKr9pRFeRpfd6zGaAWDlWlKGz/tQRlxHDVSlCBmvbYJR7+guzrZNzcMrevBP4XSz92RU/8jJQTYZiIkTnIGlx9jCnBpwdt4Y37JDEu4OyN6IvqwBGbGd1wyGzW8zLX0gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P6hsEuJU; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foHBP7XEipRzClkAZlIh7OISOR8o2thPMT4qwMFN06A0khP1f3q689bQncyYWhiIk1yGNod1ehWSn/YPgFQM8PsgP38V0eq5k90XngJQEkZxW43Doeg/HieJpdPw6t6I3OJ9IJ/MqM61VMHUt/s0qgKKmlcAaZFr9iJqr82glRfw1PuPnzHmw7piqlxjf9HizN64V40HHDrJbNnOSveE/PnakdY9M0v/uIeDF4hcdp7rAANOCpuorZaE/MdBX1ZdvAJqLs/quBqUNJmpN3r4YOBzQE6mUOpteAmQoKx3BIuTJOXmn8HsskiYXKWiMrCeT4yq/K7+Fi8m6bq5ez5nJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hG1qMY6l1XcQpYhMWIbfUVXk99ylvB0uH/HW4IO9hLY=;
 b=h18NJqKV4IwfkKfdm+7bPH4l6Hy2Wz41l7pVpe79+6PT+oYZdwaQz6liF57QjdWaCu0auZe2H2NYVtSSigW5Z+CYIXored0Ynosa8KfmFLstMh+WBHzwVfmnAJv7x80GV25wz4HeIlw0aggR3cT3crG5NmnGW4mLpN6PUqNOnrpK1bXIOw37ci98In8xIev+W3nj16UeNEg+7udfLJTa1XKr5XuZaWZqMbc1afQLgwhpkM5YfjE+ixZTq5VA3W0QkOBfI8qslZQ7gT+KrW3ieKtHb6Xfs/uckumA8Am6LekS8VPYFSXFu+X1r6ulhxd+eWUCec0yEdt3y8J1tV+WgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG1qMY6l1XcQpYhMWIbfUVXk99ylvB0uH/HW4IO9hLY=;
 b=P6hsEuJUpd4OKcEA2SxmnnYpqg9s2M4rx4TXthnnUUh3sXwISsveew8gRGqEjH0jmzJTMh+9LJuxZi6kVxducOUTr07t74NyMLw6bzRAJ8X36IUDfrasAeGeDco5ctzC+4y8sqUWV1yRKDcc6aI/4nX/5tlBInOMjj2Cxd+af+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 17:02:42 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 17:02:41 +0000
Message-ID: <028f5f2b-ec42-4704-b82b-2f604fd11cf8@amd.com>
Date: Fri, 28 Feb 2025 22:32:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: fix shmem xarray update during migration
To: Zi Yan <ziy@nvidia.com>, Liu Shixin <liushixin2@huawei.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song
 <baohua@kernel.org>, David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>,
 Charan Teja Kalla <quic_charante@quicinc.com>, linux-kernel@vger.kernel.org
References: <20250228154219.2214149-1-ziy@nvidia.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <20250228154219.2214149-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 095ae20c-ecca-411c-794f-08dd5819b646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzBmVmVnbE1rSnJjSFlxUTFnSXFmK05kQ3NjMDU2LzEwWHVtSTA4RGFwWDhL?=
 =?utf-8?B?QTZ5Vy9UZEp0TzhYeGdJeW1pSldSRnE4VUZyNlE4d1ZWUy85VXdQSnZKUjNS?=
 =?utf-8?B?aHIwZEJDTk5WUHpLK3dzUll0WTgrT2Z3VFhjajF1V2tiRlBnTElTQ0xtVElk?=
 =?utf-8?B?YUVsMDVmVUMwQ2JKNjlNNThIRE1VNnRIZnVCTHA5SC9sMW9DdzBmT1BMZ2Nl?=
 =?utf-8?B?Wk1nVnlDVFhLWGFQNGFDY1ljSFlIcE9zOTJDd0F6SEZxbnVGNS9QTWJTNi8v?=
 =?utf-8?B?b2c3a2VsVGlFZmlsZC91N3Vxd2xzTFB4QmZLUTVNa250bVZIaXYwUzVJckNW?=
 =?utf-8?B?WkwydnhFV1plMlVLRFJ3OTU2Z3BvSmlxczlKNm1DOEZ5VVVRTFVqZnBvS0lY?=
 =?utf-8?B?cEdtVGo4OEdzY1ZhSHlJNEFQUFZtcWgrbWtsOXNqYlFIYldGZFVGMkRwL3lt?=
 =?utf-8?B?bit6bjlPc0tIS2Y3VlBxajlrUHI3Qzg2OGp0b3ZZTzVJekxpQ2RYMkFwMGc1?=
 =?utf-8?B?L3J4OEhwSXFhZW9ZWHVWWXhlSVJGOTFTRm1UNkdzUjNOZFRvY1BwaFVqR0ZZ?=
 =?utf-8?B?STdqWUNubmM4SE9yRmF2Tm10ZFJxcmFiUUNmNEdsbHgrUmtOWEFUa0hlYUF3?=
 =?utf-8?B?QUtFbGxXcndBblBQVHFlSEw5TGtlUDFvcGh5ckRFZjV1YlFMVUdwWFhYNy84?=
 =?utf-8?B?QVp1Z3U5T2JsM3E4ZUhVSVg5VTlPUHRkUG5ST3lHQzRzZnBWcDZUcmJqcDB0?=
 =?utf-8?B?a2RkVWdDeEQrZVBtbGtXRUxCTmNadmNNWEFFNGtVZWpNM1VpNGxGVmwxd05z?=
 =?utf-8?B?dGIyb21RY2dVREZNbDFFcVhWVGY4dkR5WlJGR21hUk4zc3MxUTUrOGIwUHBp?=
 =?utf-8?B?NVcrcCt4UVpzTkNsZC9SdVZ2bnVaVXZaZXRzWGl1cjRaUGYrL2h2dDRvQjJt?=
 =?utf-8?B?YzN5UW9ybEdXVTU0QlA2dmoydVIzNVQ4ZTIyR2trSlZmRHFRZ1BNY3AwWkhp?=
 =?utf-8?B?SHNoY09hUFBhOVd4anVuTnVtSVZkRjNCWTdGZTIzZXJSRS9zWmlPKzlaUnp6?=
 =?utf-8?B?c0MrMGVDdVQzR2tjTWoxUFRJOG1kYiswLy9JREs0SmpXV0pSekNZZjZvdko5?=
 =?utf-8?B?YzNNR2RJSVFSVlBCbXl0SjNKL0dNbEl6ZWdhV3BhK25WTDk1UHJBRnJxMnFx?=
 =?utf-8?B?OG4vSjFkN3BTczVLbUZRYlNtL1l5TERsVUZUeTdHdUhpSlB6OFlkZkRmNFli?=
 =?utf-8?B?TXNaRlpZK0xUbnlmbGFiMXRBNDUybmFlWjNkNlJmTXhObk9ySFhDaTREeWVt?=
 =?utf-8?B?N1lpc2pyWklHZlhaaW0zTHBYRUlocHlmS3o1Rzd0a1N6aEx6NmVHM05FYWdG?=
 =?utf-8?B?QUJORHhCdjVudUltdmtoTDN3Qng4T1JKM2ViT2ROVDExcDV5ZWxmVkVkQTJU?=
 =?utf-8?B?QTYyT2tic2haWGZ1dlExaU1tTm5PaU5mYnpNd2dtdmZxSFdxTXN4RFhURWox?=
 =?utf-8?B?aGNCUGlINXNVRys0bVFMY2Y2eVoyZkdmZG44WGlVOVJNZE1UcEdyUnk2SzAz?=
 =?utf-8?B?Umc4Vi9ZTEEwZDNJdXFBRGxEUmEwbDFiUEdsem55T2ExbzRmemhKb1d5Wm5J?=
 =?utf-8?B?blVka0pFWHlFc1Q1RUI0TGxmQkI0RE1RN3pSTUYrdXk3Q29SdldQM2JpR09L?=
 =?utf-8?B?NktiQU9MQVR2d1RqeUZrTm9XV3BqT2NZc1d3VTFvaDNqWEl1ZkNSdWhDbjRQ?=
 =?utf-8?B?T0tDMTlWVUVXK2hQbmkydFd3MktSZDFjZ0RPZEh4c0dMMktkWU52alhWKzh1?=
 =?utf-8?B?WmRMRFVXWXJLUnZ4VnI1UjViWE1xd1hFRFpPQ1JQT2M2WE8zUEliOGpDeW5W?=
 =?utf-8?Q?gdLpgzwtANrrU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhhZ0JiOU10akIrUWFpSCs1dm1ZRFdvWWIxdVc1U25RNmhUY2pBRHRJeFZz?=
 =?utf-8?B?NlU4eU91dnJ0RUtVOU0zY3dCWVpYdjJpRGZzVjhKTTBJcnhGUEhpVGg3SEJx?=
 =?utf-8?B?TndiNHc2NkhMT3prZ0VYUmsyWmdsS1p2SXBMOXh5d3BuU0dXTkxUdUtCK3VO?=
 =?utf-8?B?M3QrMDJqSzUwRGU1Wkw4KzN6bm1zeFpjeHZTWkxOMGtrclVJeXExUWJxbThV?=
 =?utf-8?B?VG9hcklhWjhMMVQxcmFsM2pVS043U0J2MGV0TllWRStidCt0L2VKZFMzWWZa?=
 =?utf-8?B?alA5VnJUcWFWYTNIcnYvcXQrTzU3V1U2SVNhcjA2blBzUEJEeWJ3M256VGp4?=
 =?utf-8?B?WDFmdURLWExISXRhTW9EL1Z4TTF5c0doWSt1bnJhQlRpV2UzY2hIdEFpOERv?=
 =?utf-8?B?dUl4N2JwRmxDTG04YlFrNHNwaTN3QmRQOHIrVUxoZEU4U1hFRTd6czlqVEFn?=
 =?utf-8?B?Rm5xcWJjNGp6aEZTbXlsUVl5MW1aSlpBMjdkS2lyV2JxOVpVWFM0c0Zjc3l0?=
 =?utf-8?B?QWI0SGlBS1pMRjJYTThlUHpiR3JCV0p6QzltSThmRE5VUWxmcjlDOThVMWlO?=
 =?utf-8?B?M1RTcEZ1QU4zN21ES2FyZU5kekt0U0ZkaHA0RlJhekVzZi9qbEdZVWEydS9y?=
 =?utf-8?B?dzViK0dDYXRrMjZ3azZ6VEZVKzZLZE5lRUo5WWJ5a0svRkhKa2d6T3pIN2NG?=
 =?utf-8?B?akhkYWhuNWs1dTRkeTltWFBkODhKNDNWQ0ViNXloQWlML3lBUkJHN0lER0VF?=
 =?utf-8?B?ak1XUE0vbUhkS2NWMU1EL2U0dGV2STlKOGlzdTFsSEl1T1JNTGYyU2d1aVdj?=
 =?utf-8?B?cFhId2pTSWE0eThibkxLL3I0WEVUTCtoVkpQaFIxVG9aVUJ2Sk1Ed0lPRXBT?=
 =?utf-8?B?NHFhTk9sV2NwRG9EeS9kYXFEazRTWlBDdlorZEpudGFOSFc2UWZhdTF3OHhw?=
 =?utf-8?B?citXSkRwbTdOYjN5c01kMlFoYjlpK0VyU0Z6YmIvang3Mk9EQTZsYXlUMFFI?=
 =?utf-8?B?VllpSVFBRi9TQU5abEtvbVRnMGo0WmJOTXZ3NW4vT1BLZGg5UkZ5WGUrc3hn?=
 =?utf-8?B?OTc4dkVHb0sxNUdYdEJpWTl1V1ZDL0h1clU1MUhISTUzUDR5dlVBdDJkQTVB?=
 =?utf-8?B?Yy9ReVdtQkQ0Mmo4ci9ORDU2dmcvUFg5cjNmUnNDWnRjRURwL0xVb0hzdTNW?=
 =?utf-8?B?NEoways4UUswYlo4c1hJalkyN2xNWHFSRGdRVHBzUGZmRXQ5czM3WFRhdkVW?=
 =?utf-8?B?bHdDdFZ1YmdaZ1duZDdCTGVUMlp4ZnhFUmJHNUZEY3Jud0I3MC83R0xLRWVY?=
 =?utf-8?B?ckc5Wk9ONE45VThtaU8wai9YUXE2aDRNOWEwL0pZVHhoWkR0UzlQUGlrVUxs?=
 =?utf-8?B?enVjK1BwVmgrdllMYlNrcWVYTENHUnhzZjNrRDEvQ201OG5zTUFXVENYTXc1?=
 =?utf-8?B?bmwxbXZ6ekl5OEg5dDF2NXF2aUcxM1VEZzlYR21GT05WOG1zamRsazB0TDlN?=
 =?utf-8?B?YVIyejljOUhBVTVlaHo3THZMM1RLdDI1NTJETWs0NDBYb0FqNGRpQzZONVZr?=
 =?utf-8?B?d2EvVlArbXd4K0p5UXVxdlUrSXpXYVlUakcwRHFJNzQ1eVpuM0ZhUC9lZFFN?=
 =?utf-8?B?TXFxYUg3UTZTMTlSV1cyaHRqS243b1ZjNFZ5VE92bHF3VDRWTkl4TndUUWpI?=
 =?utf-8?B?WDNxNEpodVdmSytkeW9POVY5cG8vQUp5elhTRzFyTXN2enVkd3lhT3lDU1ZE?=
 =?utf-8?B?TGlBcWRBWUlISDRlVGJnZFN4UWNGZGtYTGVSMldFRHllTXZjU3ZhYlU1eDNU?=
 =?utf-8?B?MUNYamM5dzJaMTY2dnFwdURtZ0ZKSlg3SEJuL2FoQk9uWjdhNlRYQ0NCUlpx?=
 =?utf-8?B?SGRLQmdHZ3QzU2ZSaUNNa1d1VTRqaGpBRU5EWTdWeTdBOVpwTWhOaUZXeE9G?=
 =?utf-8?B?UmpjNktkKzI2UHZhakpEWTNHQUlWTkRKdnRMRWwxSmRncnRwOU9wczdudHBU?=
 =?utf-8?B?UzdxUGlJdTk5OFZvSmtRQTJjdi92N2dVeUFZOVJ2ZUg1OFBuYTAreDVmR2VV?=
 =?utf-8?B?VlN1cFFHdG9aVmRidXBMQmM4L3JxT08xTi9ZRC9vUWtIdStyS3R4dzBnTFJL?=
 =?utf-8?Q?tjEHH3Gq28JA0CKvxRp0ZEdk3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095ae20c-ecca-411c-794f-08dd5819b646
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:02:41.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fOaweFEUKRWpdvuomrXnR2mnLZMmEqgG4WJq4NxxPKMJZlLsaSuPhAkJUdx8ZSqTz1cc4Xb/AtQ/UzHjFy2iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451

On 2/28/2025 9:12 PM, Zi Yan wrote:
> Pagecache uses multi-index entries for large folio, so does shmem. Only
> swap cache still stores multiple entries for a single large folio.
> Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
> fixed swap cache but got shmem wrong by storing multiple entries for
> a large shmem folio. Fix it by storing a single entry for a shmem
> folio.
> 
> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
> Reported-by: Liu Shixin <liushixin2@huawei.com>
> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/migrate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 365c6daa8d1b..9db26f5527a8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -44,6 +44,7 @@
>  #include <linux/sched/sysctl.h>
>  #include <linux/memory-tiers.h>
>  #include <linux/pagewalk.h>
> +#include <linux/shmem_fs.h>
>  
>  #include <asm/tlbflush.h>
>  
> @@ -524,7 +525,11 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>  			folio_set_swapcache(newfolio);
>  			newfolio->private = folio_get_private(folio);
>  		}
> -		entries = nr;
> +		/* shmem uses high-order entry */
> +		if (shmem_mapping(mapping))
> +			entries = 1;
> +		else
> +			entries = nr;

LGTM functionally.
As a minor style suggestion, can we consider using a ternary operator:

	entries = shmem_mapping(mapping) ? 1 : nr;  /* shmem uses high-order entry */

This looks cleaner to me.

Reviewed-by: Shivank Garg <shivankg@amd.com>

>  	} else {
>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>  		entries = 1;


