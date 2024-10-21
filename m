Return-Path: <linux-kernel+bounces-373594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A8F9A593B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850692826F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3842E1CEEA3;
	Mon, 21 Oct 2024 03:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cOtJhLWy"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFEB450EE
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729481216; cv=fail; b=ZjjzOTHUM0kUGLCwT8EWIksPZSnpDndQziqFsar55orb4y2XQfb9iBpXmDk8hBlfeM1TsZL/zZXb1srjjmWhhkPQWFoLq19zZ/qxts1uMwXK9bBmMVvkIPU3NRyTG0uFcdDCSMsYhFvW9iZ6Zd0s8tJNn0Wo41LwNrc/W0bXYsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729481216; c=relaxed/simple;
	bh=yUEWJJZhRiJnTv7CpD4rTkAyPd9ywtzpDiJRLCAAx2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L3NxJJo4e2I1m0lJaM/smsSx6mJYYyznMpmqQy6Wt1rwKZ8uBWOVY23zzi7NooXE8WQm7OJ0gnZnpXIQ4SyRbFwU8dWz31m4oX37Rprs0SZuBLhpYPENV0focNAxl1uKp9NSrrtQx+OAGWCB/RqR9fh2vTGnzskC8XqP2YFAjUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cOtJhLWy; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWUHtriWTo8INO09j+39GSbP8Rc3smpwl2L0x9x/pK9N0T2BCEtdihu3+KZ23Qzvyzmr8Zpgac6adeGTxhP7AAA8t4nUVlUW4ilLcDlYcF4VrWFrYldhrx+JdQjvla0dskDVxQG+4rSoBwsAxyPCSoREKYFjpq/mTHWvrfQfFgjrwrcYMpIl/wB4XBUbONvRZacLJVPDCeQaJfvfBogyoUiJtnSryPwHrpiEVozIwENg2fFaZHepKgzkI9ju4u4GST7gxn8vC/1Sx+/4YkhoRswrRxq+xBkQQluujfDf3ihaZPko2Cz2RhXHwh+k0B/Z48dQLcWMwNO/HLm7jPD6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhHQlesG4Bct7XEJewgtoN+GpkBJwSetbZwJPxNYQBw=;
 b=KpyshRyRz6sqKrAnTSmI5yXb/OVWvTFB/NJw6cVzvzRknhS+oM/6gSaW5u075Hdv0U9MreCNUJy8Q104Ho6+s7kpdfY7/8tmGJOh5bo8SwfbXJU2xtUcGOjv6qyUzxvF9BwzaSjJ6pd/C5Gz17YSGqfNR7o/seYUlgMav758/py8hTG3IUebAEUyvy0EEYrTcvtQlGpNs+fWTa3B/Oyg8Pfwl9xrFpLEHGGdi3n+TVyEwZwpV2bsz7sRcE+6Kwr8LVf9oRabMsYs3tI8wwf+r0Xb9B1SJKmnRGX0QIa7wd9duEhLdJu8VhODVQKEiLHEAHIAxvCLi1+/+vyVSsPp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhHQlesG4Bct7XEJewgtoN+GpkBJwSetbZwJPxNYQBw=;
 b=cOtJhLWyRzr73trwVxLsEHWHdQZVl1CtwxaNnEOAiCgYdXm4siR8RThtCSe6qgkLjTW+UcgSaCD42trsHOwkbYCuGELn/5XtbkHETF9eDhjb3fz3nT5rUYzvFGddbNgLf6aAOuzMS3NFpUiFftj0tL0A9lhLcNcjEPiRfrVmROY1TYnTMy2ZJzxDAuOp6j1r3em/w4zss08j8aUPgVAWNw2kzlhYcU86hgwBN38hvDNdWySPdb1NbgsaJ7igaGFo/Jmx8pAprpQRJDZ499kan2xqoIjrEUzSUt8MPEofVW2NOLOFxDv8x0wAn5EJ9pyI+Oqs58HkGKOieNgZ6v8mHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by CH3PR12MB9146.namprd12.prod.outlook.com (2603:10b6:610:19c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Mon, 21 Oct
 2024 03:26:51 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 03:26:51 +0000
Message-ID: <142152a5-d265-4aa5-b103-dede882f9715@nvidia.com>
Date: Sun, 20 Oct 2024 20:26:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/gup: stop leaking pinned pages in low memory
 conditions
To: Alistair Popple <apopple@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>, Shigeru Yoshida <syoshida@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241018223411.310331-1-jhubbard@nvidia.com>
 <87y12ibbew.fsf@nvdebian.thelocal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87y12ibbew.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::6) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|CH3PR12MB9146:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d4e673-9ab5-4991-1111-08dcf1803400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1AwdU52dW9Ra3hJSWx0VlRzU250ek12b1djR2VrcWt4aW1TeExSVVFSWDdQ?=
 =?utf-8?B?M2dRdU5TTlU0Z0w1a2ViUGIvb0lrZHNaRDdDOG50Rllqek5oZ2ltcEN2MFNr?=
 =?utf-8?B?MlNQVW5nZm5NZXhqQzdWOFE3UGNmVFRkaHdFUGRPQWlMMUE1RE51SXdsT0tW?=
 =?utf-8?B?cUtYUG1VYytCeGV0d3FFelhLWjJiWUFsN0hOUTVtSTQzQ0VkQVFidFMrNUtK?=
 =?utf-8?B?UklHR0ovWFppcllRdEJuOTltS1ZUY3lvWWxhSUdPSDhWZXVCTHpDMkdwTGhv?=
 =?utf-8?B?Y1pvTFAvTzN6MEh2RTRuYzFEZ2dSZVRSSkt2dFpHeHlDdFlHT2IvcjVxNU82?=
 =?utf-8?B?d3V2UW43cTdQN0FQL3BvUFFabm9LQzBwL3VPNnFsL0RLVkRQaDRvRCswRkVS?=
 =?utf-8?B?dGduQzN6YlVrbkZIbnNKcWhKMnYwdXIrMXJrK3NTZmRBQXdmQmpkQU9PenJT?=
 =?utf-8?B?QWU5TzVBU0paczZUQnc2akFrUUg3VTNIYkR0MDJ4WnhMdnlMQ1BCLzJxbEdC?=
 =?utf-8?B?eWFuVDlhQU44WWFXUm9ubUZZVnY0OHZIWi9iYk5QTjlQMDFiMFB1ZWsrVTVC?=
 =?utf-8?B?MXMvRUErYUF6Qm80WU5iVW1BV3hEK01VRzBMNGFtTS90VW5vckJoa0lkV254?=
 =?utf-8?B?YmI4ZEFkWlBYN2N2TG40WkRONXJBNm10UlZKNjhhNVMySnplUytubmV1azNK?=
 =?utf-8?B?QndLZ0EwaWg0K1FIb2hUYUJBeUJmeDFtd1VpalZqRk5ZZXE2ekRMdndmcnEr?=
 =?utf-8?B?RHBtTEZrY1BUOGVkU21SaHpTMWltOFQya0JQdlZ1YVNJMXF5YVpaNVJjRDBM?=
 =?utf-8?B?TFNwMjJ0dE1xYkJkQTBsL21BYVB0aXQ1UTJ3WWxKa3loeFRlUHlPSElJUHAz?=
 =?utf-8?B?T0hKRlM2bXpRYnorZnJaSDAySXNWZVpIbWlZODRSbXI3S3p1cjFCV2VDczB3?=
 =?utf-8?B?TThrSHZkRWtnYmlqeE5SSkdIRXUxQU1RTWJUK2FwZDkwc3U2R3E4M3J6OXdU?=
 =?utf-8?B?VXoyVy9CMHlid1BaLzYwTmlLT2Y4WWw2ZS9maEJhaG43Wm1RbU0xMCt1dW9u?=
 =?utf-8?B?T3dldkRWMUNDOWViSzNBMTNaMnFOVW5zOVhpbWpUbU9OWnVSV25wckpJNEY2?=
 =?utf-8?B?SFVLN2xnZ0FjSis1S3B2bVcwUkExY29yTXRsR2JaUmZLckxEWGs2NFBiNytX?=
 =?utf-8?B?OG5mck5VNHJTaDVibmt4UjZiczZTY0NVWk9TNUZoWUV6dVlidFI1YzRZOWFS?=
 =?utf-8?B?Y0hTYXB2L0ZMbTJkbEcwYzM2S1ZvZXBzQmZLaEE1Wm94U0xBWUlHaXEvUDBj?=
 =?utf-8?B?VW1nV0tabE1vUzJWclZRd3FTeFN5cG5jRjVRYWpFRUltK2Ywc0tWYmxLMUp3?=
 =?utf-8?B?WUJueUdlbWRTWEFoMFJYcElpU3pxMVlxbG8zR2RkVmJhVWRFTW1Pa0RaY2lj?=
 =?utf-8?B?a0w0Qmh6RWZlNll2Slc1WEV1QWUxUzV0MWdSdUJzMXJWbzRhU2hHS0JDSUJJ?=
 =?utf-8?B?VDR1SllKVHRYLzF4M3NMc1pFYU5nNXJkenh6Q2xFWnRxcU1lWVhwNXFpK2s1?=
 =?utf-8?B?NlpiQmg3VzljUzhuVFBQWndDTUxRRjFxeDFndFlERFJ3M0V3aFdaSWNWS2pZ?=
 =?utf-8?B?dGNCbEliOUZSaVp3QWhNanM1aE9HVGV5b1ZpQ2hjYzJlWCtWckkrRHAyajZW?=
 =?utf-8?B?MjZlQ1o2cmo4WU4xRFljMC92YWY4Rm1QcjRFQ08va3p0cTZqWHdpT29oazlv?=
 =?utf-8?Q?n3KnXDP09Kv7LjMHrT8bR8tPLGG47y6Wjt3TYvE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGlPS1Y2ZSswVkRWelYySVIvV052R3NxaEdUTDlhN2hhazd4Y2RBSTkralNN?=
 =?utf-8?B?SU1pNkY0aVIvU21nV3J5SU5ncTh3b1F5UG5ERWRJaVd3cTd1RVRSKzdxemI2?=
 =?utf-8?B?d1JCZXlFcUFzaXhvaWh1Q25QaTBvcmQ0c0tPbWUvTFowWmpxKzNPUFJGNU1x?=
 =?utf-8?B?WjFZQ1Vic2JodUdFcWxiT01lQjNLaHRVK0NVUERuWjNlTXEwRkxib20zL0E4?=
 =?utf-8?B?ZUdWaVJMOE9FUGdnNTlnWEpRV3lSdWhra1hIVDdnL2x1RmVGd1k1TVpEWUhv?=
 =?utf-8?B?ZGdoMGdjREpiMm1IRGFxMFJocVRrS0UvR0JZV2hRWVlJaEJCR2JJcGpJMVZu?=
 =?utf-8?B?MDM5VmZYa21RYys4ZXh2SlJGd0lHdWpaSW9ESmp6N3VvMWYyOFhHQXBLSDBT?=
 =?utf-8?B?WDBCTlMrbldCSDZRTmJzT05DVlp6akJRRklqWGxRcW5yUC92WTg2dGlNeTh5?=
 =?utf-8?B?N2xlT0dwVVd6Yk0vTG45emFQMld5d1NXZUpXOVdYdEV0TUIxdGIrY2FXSG1l?=
 =?utf-8?B?aW5pVFVDaVlFeEhlSW1RMGJJOVgwRGhpVjdrQ2pkZEJDTmpJQlRnajJIUDBU?=
 =?utf-8?B?M1FMMTNJZHJhV1VKZVlLNGo4SHcxV2JCcFowQ05GTXk3eVVmU3JxTkdKWHV2?=
 =?utf-8?B?M0xpN0pDM0tMWFBUaG5yVDhNcVd6YWxUMXlKMkFjUy9ZWk1xc291MFJnZ1RR?=
 =?utf-8?B?ZEduUDJSMGZINGNIb0YxMHNSSkRNekZNSmY5SnN6RVRUMXJRTnB4SkIzaWpq?=
 =?utf-8?B?RzJhYmE1N3I2ZkMxYk5pZEdQRjBRcXhHTHFQNExTVTAxSjBhL1Zhb0YzeWk3?=
 =?utf-8?B?bFRNa0RGaExqcE0ydmVpMkhuazltUmtCR3NYelJyZlNuRXBreDFScVhxNE05?=
 =?utf-8?B?cjhCdzkvanFYOWxHVURZeWZMRVlvcko3NHFWeTA0bmxTY1dZQkpvZm5veTdW?=
 =?utf-8?B?clpNWE9vVGYrdWVBK3lCcnJNRjZReGdKUENHL0t1Z0Q4aW15ZEx3QlVOaFFU?=
 =?utf-8?B?eDJGc0FPTWtVWEpPMGtCM1VpSklVWXlrUk9ITXFjc3BSNStkR2xxVjZwMGZW?=
 =?utf-8?B?QTFmalBraEFxRGJqVFVlNFRyTkR0TkliTmhicW9kUUFwZytXZS8rNW9SVGZ2?=
 =?utf-8?B?YWF6UlZmaFRkZGtoUVZNaUY5K21IT3FVRWVqTnlLZTh3OGZadFIxRlh6YzM0?=
 =?utf-8?B?ZU10cWJtdCt1cStYQ1VvU2JQWkxBQ3E0bVZKUW1ITGtDKyt1cXF6QU9FNyt3?=
 =?utf-8?B?V2FoMk9VaTBOR0l6QzdqNkcrc2txTm9EbEFzb0dwTnpPYUpnS3ZXMjBzT3dQ?=
 =?utf-8?B?RFdzUDZVSTFMWm1KQVcxUzVsMG5CV3VYN2NmaUtyTWJRWWpzZitTWGVidU83?=
 =?utf-8?B?WExrbkxyODY5ZkR5cFpDa01LV0V4UEw1UWFnMVU2NkEvSmU3eXNicEErV283?=
 =?utf-8?B?Z2c3VWhvS2RCT1lTbUxtTHl4RnlGRVBXc0pTSitKemU2c01yQ002SWs3cTRI?=
 =?utf-8?B?azBITmJncGt0ZHovbXJuK1JqTkIyOWl3ODBzRTQ2YTc5V2ZEMTZlRDZRZ2VF?=
 =?utf-8?B?MzFETjg5L3VIenJOaFpxTWlHMW0wRnlWZmUxUHhTcVVPaUZVWEJOTHpBUHNv?=
 =?utf-8?B?K1g5NTN5YXJYbXc5QUMwbHhCK1VENWlSRHdLS1hrZFExbFd3VW1jaWY3bktJ?=
 =?utf-8?B?ZDFlYUVkVmRYY2FZcXl0ODdWYXRVZDNOTkpadDVPWHhvOUFwSHFnWHVYT0M1?=
 =?utf-8?B?K3U3Sjl1WVFwd21rN2VhSlRwc2RndE9XRklXQ2JSM3BLLzNkaExiZHBEemhh?=
 =?utf-8?B?M1lqU2xBTEJBNTBPcEMvT2lVdTV5M0lHVjIyeVVNb0xEQnhDKzdoWXZQeXMy?=
 =?utf-8?B?WkptYjhteEFhNW1TanBqc3Y3a3RpZ2ZpalkyOHo0SkxjN0lDcHhLT0liT1gv?=
 =?utf-8?B?VVRNYmk1SjI2elhhTlFWd3BIcnNDVlN6WTdkUHVWY0JxV1o4cFJTSEZ2Wldv?=
 =?utf-8?B?YnFLVmZPS0NROW9iOHJUVzBybnUvWGgzcU55NmZtWlMzazA2YWNPenlCa2FM?=
 =?utf-8?B?ZmV3Q0pQVCszR21nSlM5d3RzVEVpcE0xSVNJM1dPbzNWU3hSYVpEOVNHc3JD?=
 =?utf-8?B?c1I2TzdSdGcybTEza1JwaENOcWxxL05WdWpDNVZmYThjRmNTMDRDOUFLeXlm?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d4e673-9ab5-4991-1111-08dcf1803400
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 03:26:51.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3D7IGZvgJiC+CMBZ9uRKCIbXjIRGlZLE/WKO25iRE/7XYWunNm2Tc8dE7LTtyKXuQfaGmBQheAy/ZLLwz+kVbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9146

On 10/20/24 4:26 PM, Alistair Popple wrote:
> John Hubbard <jhubbard@nvidia.com> writes:
> [...]
>> @@ -2437,8 +2440,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>>   	long i, ret;
>>   
>>   	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
>> -	if (!folios)
>> +	if (!folios) {
>> +		unpin_user_pages(pages, nr_pages);
> 
> ie. Doesn't this unpinning need to happen in
> check_and_migrate_movable_folios()?

It already does.

check_and_migrate_movable_folios() calls
migrate_longterm_unpinnable_folios(), which unpins if errors occur.


thanks,
-- 
John Hubbard


