Return-Path: <linux-kernel+bounces-370250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8C69A29E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FB81F217E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7491DFE1A;
	Thu, 17 Oct 2024 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UZ7Y01UZ"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9EA1DFE01
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184073; cv=fail; b=IVkGKLgxE0eXdAJHiW4Nv3qSdE0WZP3a2srgiE4gFsbGxup/LpDBNcQzHMN2d0JdkaKMfR0zjDIATBkomYLl7Qe9nR7OAvyjEZaeUJXcfkSMKbL3gdYljHxujwAoX95qPhbMf8aKtNBXry4vPdSS4bD+WYUI6nCpHhGnq4Xj9CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184073; c=relaxed/simple;
	bh=DtOj7cHgoMUSL2RJ8GPT75tl7EmmY0UBKF2qrPfuBww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W0/+ApbTp/AIsL10evv51JerNIa6Re/grqe7xyhwLhyFN9aFrDgLWj7kJVIJYKr28eFH4cygQ6LFAJ9QO9xqt7e2rqo5sWXKRQVSHyPZoTdfh2vmrLPmkwHrNgD06WbwY0WPy1NQV5cV94akdBseK6NTgzkow2LVjz8QoK3bujs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UZ7Y01UZ; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs0NxRcoyHt8IaTG2SK+Qa1dz1bpvNelzjx/Bql1w6o6enDDQVn6Ctpmr99Mz0h5o5B0iuYdaseSxmj9yK6Tp1DkctRxjkrfxMdEsOY5jsXN5J94KL9nV8j87CELYHRHn3LXtJChvBJnfWIcmSB5CA/QlXqEsDtXJG7jHy4iKhBhDHvzCIoEFRkIW1XCIzjBu6h7dumjJUlFPSuzVpfUuG8TjbuH6SpUG70/CnSAfFPHQUTnbrywDLaMYYcOK3sHZJZXtdG5Zb8MhY8u29AxY6Zwva8n1c1DdkbqML1jvwnpjMQ0Ml4FjrygKi4RgaZ5OJbn/xTQ7gDi0n+fsSnmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQRszzpABHWK2eHCJ4/leztXJb4bsWmmnHYvCb2zpUY=;
 b=SuWGIzsh26o3sT5MvlNmv+eAEWPeEEM8KQlasKveJhQ3VsV0hEzod8X2UrEOko0hwYjrqg6JUC9WjAOjnaBObB17mAv8M+cqkGlmUgP/el1qDpE3Ii70KwA3l0zbMf7cU/tnNWkVJ+0yqckBTNDLG90K5eO2y+uyuYfdeY5Mraq7/5XPETBtbWS52cFqEFEZr310zM32zlFrzDS50bAT7frM3TiXGuVJ2FVldZK6zWuh4Q7qO9Ij628xiamyZGXItXPZBUbBJ1N5ncV4HTNQj7LSz+OssrYM0wRNE9Z6ZfAv79G1tU0Byl0POFODwJejsT9QBluYDr6C5vJeJv9JUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQRszzpABHWK2eHCJ4/leztXJb4bsWmmnHYvCb2zpUY=;
 b=UZ7Y01UZAkbh0n3jQWUB5RVKwM28irjhWafHw3GgDSTWN15YrArCi7QCKaw5Q2/4hs9P7OxM9mTqX9Lbm3t2hK1VhkgwuESK4V78KYZ7YkDyHJz7mAcIZO2ncszHNIoRhtUpeXdVb6vPuXxJnCn52njHf+SLXKkdcngDoGdZHBAJqMKQHt+mI+6U2z6QGk5tX+4SIyHBbU1IH6o5UnLS/LWNFWa8aeoMoJTS0qcOuExqfPB+R60G7daUCq46UqFzIx15i3vDKI6VtALgLlw4j6a4mn6t9ktKbbAXfcgbfK29E0MFVR9mj1/Q5Xf11d7Em13WuOzvvF1GIjTiLtNIsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 16:54:27 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.019; Thu, 17 Oct 2024
 16:54:27 +0000
Message-ID: <838f4919-6f10-44cb-b3af-597b45c07e3d@nvidia.com>
Date: Thu, 17 Oct 2024 09:54:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Alistair Popple <apopple@nvidia.com>, Shigeru Yoshida <syoshida@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
 <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::22) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0e6021-5ff6-4a33-969a-08dceecc5ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVBxdkZCTWJOV0o4cXNobis0YkY4SXBoNFRvZ0NrdW1wMVBWTmJRMmN6OUFn?=
 =?utf-8?B?NmVJdFNUUk1qUlNlZjdRL1Yxc0Vjcittc3paaURvREJ6VkNLZHQ1NDZwb1Fi?=
 =?utf-8?B?RVh0eHA2cWtzT1FETXZBUG5kclhPeE51S3V4VlA0QkhkdTlkSi9tL244UW0y?=
 =?utf-8?B?dzhEaHV6SWpwbFNQR1BYZDFjMU14cWxoaGNHVWVBekRrdmQzbnFCNTdCVU50?=
 =?utf-8?B?MVJHRThmeEJFZGxuUXlQbmtmYVh6emxSeFg0Nm1HNklQQ2N0VWZpTVI1OUhX?=
 =?utf-8?B?OFJjYzF3NEcyRG5IOXdzVFZFeXNBUzZMNDF3UE9aZ3VPVmxmc3lTc0J4UjFS?=
 =?utf-8?B?TjVyLzRnZVlVOWsrMjAyL1NwRmQ4MnZ6d2hrUENCQlBSaGY5dFNuTUk0SVRa?=
 =?utf-8?B?WEhaMzNYR0ZBdkF2QUxZOWNTcnB4ZEZyUWdSNFRUSXk5bG8yZ3B1K1FmTWpp?=
 =?utf-8?B?V2JMSzR3Zm9IcU1LR2txQkhmYkJTelgzTlhIMzJ5OThkdjFSSVdnTmdRcEtH?=
 =?utf-8?B?S1kxTFd4QWVadHI2UDgrc2o4L0F6ck9uYmFoSkgvcEhaQ0RnZkhLM1lUaTNn?=
 =?utf-8?B?UHg3RWxoZi8vQ0sxUDlZVjJBYUtvUjVCUzJQR3pmbkZpNUIybnB5U2plM0hq?=
 =?utf-8?B?NVp6cDdnTTBCOG9BQ3J0bDV6Tmg3NUQyNGphaWNxbUdJNjRCVW9nSkVmUzZP?=
 =?utf-8?B?TjB2dUxDUWdkQVBVd21rVXBhNVoxS3lvd05KN2pJSmRvanVRd3R6YUNEdW5I?=
 =?utf-8?B?KzdyZThmK2h4ZVVYZjRBQUFJTFdFM2EvRlY0dkJxNTQzb0lLSllmR1RDTUpj?=
 =?utf-8?B?aTBtOExhQmVLbk9YOWlid3E2ZXZZRndUczR4bVlVVGhlOE1XSTAxa2pxL21u?=
 =?utf-8?B?U2ZsdHZKTHNzU1R5R2NGY2U5V2FnOGdvd1FMZkYzMHpFd2V4bWs3OHkvaVFr?=
 =?utf-8?B?U05acFJrd1Jlekt2VlNidlhONkhJUitmR0lLNmx3ZlJqZW1heDhXUWVYVHZ4?=
 =?utf-8?B?V3Q1eXBZbUFjT3BkdkRYczJnaUJHMFZTTUV2U2dMTVBSbjFpVkNVU2FtMVF2?=
 =?utf-8?B?QmV3V3BzSC9kbUxrRDF0MkZ2b1BEbW1DSkE5WEFTNzNYcGtRYnB2M044NXdO?=
 =?utf-8?B?RmFoZkF6ZXlTTmlSVDQwQ09rMGJ5QzZRUmxEbnhsOUFkMmxDcm9lWDBieWZI?=
 =?utf-8?B?ZE5aRlQyN3JpQnlxbEdOWHU5ZzdVaGJsQTlQcXIzMk5kSUNuTkUxKzkvVFNG?=
 =?utf-8?B?Ui9iaUJOcEpyVnJvMDQyU1BWaU40azdzR3Evc3o3YmozQVNXUDVISFptcHky?=
 =?utf-8?B?dVNkc1lrdTlGbTN2WnVmMnEzOTF2Qld3cEMxb3ljMyt4T0RTVkFUS1JsNjFC?=
 =?utf-8?B?SzdzWXJndlMrWnp6ZTQ0dExUeUZENUwzNXU0c2hqODgyOElDR3FveUxyc2xV?=
 =?utf-8?B?TGVXODVJWElNUHlPWFZJNXpFeldmd2dqUFJhbktic2NPMUdqMUMzT05LNHds?=
 =?utf-8?B?VWJkaDExZTdkeWF6NGlQcHFYVks4MzhtemhsSTR4eGdpM1VMalZWWk44aFJw?=
 =?utf-8?B?UVZpbFE4bEErOGF2TnpLaldFU1VFSVl3Wk1iZVI3ZUc4UU8rK0llUWh0Y2FQ?=
 =?utf-8?B?YkhNelk2Ty9qazNGekUwTk84TW9VRW84OGZzNlZZV1FjNWY2RHdWZzJBOWdE?=
 =?utf-8?B?TzJKZCtrbExZaHdOZk82Z0c0akpuZmk1N2puMmdXYTdNS2plY2pEclJqOFVZ?=
 =?utf-8?Q?cjPN4bA9SAg2OrOuZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1RYM0VIaGI4d2lNSDBRV1k3WmEvc1JIZG9EbENHb1ZBZWZ0b3ArLy96dmtl?=
 =?utf-8?B?VE04WEJTbHhWUThMTHEwaTl3cWN5Z0orNG0vSm45T0Z4TG1xeXFRMHhGcStH?=
 =?utf-8?B?QkFObVFGbmhaREVuckxTV0VBL3pNczZDZDlPRDB1WWJielZnZGFsdlFWRVlE?=
 =?utf-8?B?a0hVSnJFUjdkaGpCSXo0MUNJUEk4MGVrRHMwMnI5YkdYQTJJTnpGR3V6VGVT?=
 =?utf-8?B?blFOaDkrU1h5ZC8yZk0raUhxYjlBTWs5cGxYdTdzV08xSFVyeDN2bVpjY09L?=
 =?utf-8?B?WkE1YzZTZm5MYXp5WVd4QzNoaGtSbnZpSndhMjFIM1JwdDFML0hrbUd4T1px?=
 =?utf-8?B?QmlzS1lHRTBqc1dCaFFKbnYwWm1xVmwvWjBEMGhDRTY4aDAzSjluamk1MUhI?=
 =?utf-8?B?djVvUDJVQ1dZY1R3NTVuN2NGRWZEUlBtS1k1TE84WUxOaExJck5vUUUrSFh2?=
 =?utf-8?B?a01xZmVnZSt3dXB3a01Hbng1QzM3TmJHQkh5WUpudjdVNUdLOU04ZGI4cUVk?=
 =?utf-8?B?aW9RNi9oalhOSEgyZE81SUxEb3JOYzZ5R1VjOU4zb3Nvb1B4eUw4aEpnYkhu?=
 =?utf-8?B?M2RtcFRZcXhYeFhiaisyMDlPY0JaNWdzRFB1Z3R6bFFpRWRNUEQ2M0RIdjk4?=
 =?utf-8?B?L3RYYlVldHptVURhOVhBOGlXR0VGMHV3NEdHK3VNWVpQNzRScVhTdllYd3B4?=
 =?utf-8?B?NSs3RFl6SHFuNXpKMzFPVjZXRDg3SmhoRjYvY2VwNlgwR1UrNUVHdHpZcUh0?=
 =?utf-8?B?Y2U3ZVpicmdBVXpMNisxeG9SajVBWlBkZTRpd0NmcW05ZXpNak9FZVJuUUVq?=
 =?utf-8?B?Tmp5R29kYlgveGZ4dUc0bkJ6eS8vS21veE1Yd2VHZ1J3bWZSaTg1Q0I2a09D?=
 =?utf-8?B?RStGQm9BQ24wMzAzQkQyb3NrdkFCUTBnMDE3TURGWjdzaVJseE1VL1c3Q2s3?=
 =?utf-8?B?eStQbGpzMnNZREVSbm45NW1XZk4zOTlpRnhlK1ZrenlmVEkyNWF2clU4cERH?=
 =?utf-8?B?aCtBUmw3SjhkR0Y1WnFMSm9aL1ppWTNSbXpFT0RIMkVYT05MN2hIZS9nQUNM?=
 =?utf-8?B?akVlZitvL20wbmtMN01tMFcxY1JwU0RLbUJrSXNIdWtuVzFiVnpzc1UwV05M?=
 =?utf-8?B?bHl2dXRXelFldXRuSVNsalBFQnh4S1JpWDc1bS9oQWtleHJ6RmU1WUF2RENL?=
 =?utf-8?B?NGhtclM1QStMa09FVExwSFBIdEM0MUNFVkVYTEhuV2cvRHdBcVVJYk1ndVk5?=
 =?utf-8?B?V05vNlYvTHZkd042Sk9aU2xJTGdxaUJLdi8wUEdKQmgwQlA4WTRWTnlUTk1v?=
 =?utf-8?B?YXlwYS85b1c0djI3MTZEQmF6K2RpOUU2Zjg2OEwyS2JIMWorRmlNeDBXQjRv?=
 =?utf-8?B?b2UvVW5hci9EMUxJLzN0OUFCTkV6WkJOdWxpN3NDNEVkU0ZBQ3dVRWMvUW5a?=
 =?utf-8?B?YWo1anl3TmFHTzFKMDlGRXk0bmo3cGhRcUE0WFAvKzZJMzZKSzJueU1xK2ZR?=
 =?utf-8?B?T2NZUlNSRzFDVTEwSWp5dlZFdnB1NTlHSmhzY045WFc4cDZvRElaZ3VML1Uy?=
 =?utf-8?B?V3M2cUhUSzBKQlFubzBDU3ZaZmsrMCtRSzFaZDBkNmgzTnBtbWdkdG9FbzZX?=
 =?utf-8?B?MmJOYXZXWnFaeXI4aUZCL1JMeHlCd1N2TkhZUmpScXNwZkZvcTIwc2kzaVJM?=
 =?utf-8?B?aStkQVdmWWNkUG9COUhJblpTcTZFNmVsY0VxaXh5YjdDWTdadllYRWpPZm9y?=
 =?utf-8?B?RzhzRVlTUHhJNFJjbTRaNUFlTjA4eSt3eEdHM3hHZnJSSWhFTzh0SXRNYzBR?=
 =?utf-8?B?TGhnWXJkL3c4T2xXM24yZ3JISm9jcE1wMFBRam1mYjlYaU9pRW9HakF4Y2hW?=
 =?utf-8?B?OTY4WXZhU29qZGxiZDZqZHdyaGFrUkJDeVp4VWw2MkVKQmFpRWhuRVQ5NUpX?=
 =?utf-8?B?WkJyb3NjSmNVSWcya2JWR2o0ZlRmMXU4aWZKR1FvWnk1WHpQYjJPOHBIbnhl?=
 =?utf-8?B?UTUxZzMzNCswaGFFNGxCMTBSdWxEVU5FYnl3UDVQNHdxTmhWd0hlVnFWVzVr?=
 =?utf-8?B?dkU2MWNHeGkvazNqOUFpMnRsTTJ2bHhGYVZQQlh5YU8rZFE4TFQwd3hkNmVB?=
 =?utf-8?B?WWxvZXFTeFlzYWNoWXhKaFVmSzhsZEpZVVhaZUNaeU9zNnI4NEdiUEpIZGFx?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0e6021-5ff6-4a33-969a-08dceecc5ca6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:54:27.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ql4JIbsmTsk+kxFIGoBJE2oAvLwfaBVFuRwlTvyrOfaWSBrIdg2oKxTy6VfeXpgucPrNqM1yXc2t8Z+t51JUhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351

On 10/17/24 1:51 AM, David Hildenbrand wrote:
> On 16.10.24 22:22, John Hubbard wrote:
...
>> diff --git a/mm/gup.c b/mm/gup.c
>> index a82890b46a36..24acf53c8294 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2492,6 +2492,17 @@ static long __gup_longterm_locked(struct 
>> mm_struct *mm,
>>           /* FOLL_LONGTERM implies FOLL_PIN */
>>           rc = check_and_migrate_movable_pages(nr_pinned_pages, pages);
>> +
>> +        /*
>> +         * The __get_user_pages_locked() call happens before we know
>> +         * that whether it's possible to successfully complete the whole

oops, s/that whether/that/

>> +         * operation. To compensate for this, if we get an unexpected
>> +         * error (such as -ENOMEM) then we must unpin everything, before
>> +         * erroring out.
>> +         */
>> +        if (rc != -EAGAIN && rc != 0)
>> +            unpin_user_pages(pages, nr_pinned_pages);
>> +
>>       } while (rc == -EAGAIN);
> 
> Wouldn't it be cleaner to simply have here after the loop (possibly even 
> after the memalloc_pin_restore())
> 
> if (rc)
>      unpin_user_pages(pages, nr_pinned_pages);
> 
> But maybe I am missing something.

Yes, I think you are correct. That is cleaner. Let me retest real quick just
in case, and then send a v2 that also picks up the typo and moves the 
comment
to the new location.

thanks,
-- 
John Hubbard

