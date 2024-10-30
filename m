Return-Path: <linux-kernel+bounces-388113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2D9B5AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E1A1C213DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906284A4E;
	Wed, 30 Oct 2024 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZjAiWMmj"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F83193081
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263503; cv=fail; b=l0n7iqYvYtVUUx1t9w1kG6DJ+m91ne7AQnXFuio88jgdlgiOndgWD1l+4rPqe4CxoFwHZzZlFCqAB7R1AYnRZ75KhoJP2wZ+y1xERUouCdNHWmvncaLPboD55921Rx3RMmROCgjJzyCBhJuKCqwOcbfuGd6iUh/XX2Cy0SCFmbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263503; c=relaxed/simple;
	bh=UujgZtwPb8cHZ7jFAcV6DmMtCWUgU8kjpCZWfwJNNfc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k1VzgiaSfjLR6FfMunu3mxqI1+C2nRpOM4hUxkgt/cJYFdsmlEO59PVgvVIFFsPRum5+jB3HficZBg6seRBTxXyFQMXfTAHQENngdTP67ZJ2riDj0S1fa5EfOVYQ5EG3e/9c81ttgMDiMlSRtd3eq/LB5uKuu9eb6a7HFBHL95c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZjAiWMmj; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoXQI3dTXlqwKbTOBM/BxZxDkYTDQKbWG+PffFBsI+6UGaC3BB07PnCkVE6cHFFKJ1BfqFwrd4mlFM+kxB343weNzhLOloVmWPp7rdn/HrvyWgJPAPc9SSe5bJhx8M+QL4qSehN87r9SSRFRkfvoDTT4BiOyuYPozMpTPLMKwRUjhtk+SKSYoG3Jk5SbWC19gf1j99p1ORb4nrbR01RYaYtVUwsUPzPJiiZDiMEmio+yeMBkTiaGrx2bmE3IKOSfLTCsd+fuhD9mCqYPcwwJTFKoxqfh/bTChcYcXBJp6JoTejbEz51u+M+7VS6DmB5tL54tUHsZroZF8is/Pc01BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfrPTb252MFI7ENDDPxfZdGlbmiKT+3du7+OPDF46CM=;
 b=kptzLFUoa3Jb5aaddUPW/zUG3bjvfe6TDuy7nP8Tu1JkTl4Df7Dagj+sUwP6ZPqGMlAPgeKN4G+m/KUOakEpvsPCSS/zJfFuH+pVFuk85hDvgriZ7/nTDw986wVrZu3BEvnmrxV378alj1Hwtu0iYhQsnEVz+nRII4btY2B7hZR1gCTP43e3j9NsplGIwLHtAMAzETDPwXhueYW4MjBkbUK6K7yS1mB+VVc0mRdyhHTranjuCXxMWwl9YxfOm+BLztxr6ldgKNTw6wDrx7vwcZGVwsKGHisjtLMxRx8my/RNjzcIeniZlvWvr4H7oaqfQ8MFHeHx+bnJOkXWqTQNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfrPTb252MFI7ENDDPxfZdGlbmiKT+3du7+OPDF46CM=;
 b=ZjAiWMmj3H3MHsrdmLsxIyFMGoCzhpSMteirSZMA46fw3xyJag8cQDibx7pXFthwwmfzAChlInqWjUVYF1+J+ACGOTkIX16XZ+Aem2EAryGsD+Pc/KpSchNUiEFbJTkK2+2wnB3JQSo2RYQpHSwGL/nWFgQHV6a5LyNrTBjBcOFb7hcDqluXjYoIBasma+6R6dzb3K/xzCJF229I3keEobTyWAMV55pcrD0ZKzXKgh29UFJ1wZ5tDiLx26HhGGrYB+ChdwUxgdKMXPnpEjCT/idlPnnwCv8UEqchaWSJDFxUjJ6qaYbajlMrgR5E8Sc8SVvaUEfmR9eTc0Wel1C7XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) by
 DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Wed, 30 Oct 2024 04:44:54 +0000
Received: from DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579]) by DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579%7]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 04:44:54 +0000
Message-ID: <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
Date: Tue, 29 Oct 2024 21:44:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 David Hildenbrand <david@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>, Hugh Dickins <hughd@google.com>,
 Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
 <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZyG5IumNPMUDBQOq@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To DM8PR12MB5462.namprd12.prod.outlook.com
 (2603:10b6:8:24::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: e4412541-c89f-456c-0372-08dcf89d991e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2lBcFZtOXozektEb1dLc2pkNzZvL2ZBR3VWMzN1Q2hmbWZ2TUhUaGZyN28w?=
 =?utf-8?B?Ty9CNmhUMGI3R2JaY0p1WU5qZk1uOVJ3bjFMbzBOc2h3WUNnNkpZYjZTTmtQ?=
 =?utf-8?B?cVJqclZRKzQyZkxCVmhRdWlZUURBN1orUm1MS29XbE9OVVNVSi9aOWNCS1BR?=
 =?utf-8?B?V2E5WDk5YWRJYW1mamtmcWNrWDdDTGttV29oZ3JtSUpSQ3o5S3ZUZkNWcVJr?=
 =?utf-8?B?ZHZPZjlORG5IWFZWVmFZNUIzSmJaU1pVeFY0SnNGU1NSZWJScEtpWlBuY2cz?=
 =?utf-8?B?UDlyL1UxV09Lamg4cE5sWEYvRDdXVmIwS1VhUDQ2YTRFRzEram5zWmI0Vmc4?=
 =?utf-8?B?OVRSTXNNSXBOTGlqZVpaQlhlOUo3VjhkOFY4bWxqYTV6UzVMTTBPVkw2QnZ1?=
 =?utf-8?B?OTZNa3ErTXBxSnhKVEV6NWVWemNuNHQ4K05neThUSldFWWxieWdMeThpd3ZY?=
 =?utf-8?B?WkxvcU5WR05DY3VCRmpuTVcxNVZFUVJkVDFYQXB1NHhZU1pHVDBZbmx0aUFN?=
 =?utf-8?B?eUhhTUtXUHhmTFNYRGdJcldtaVQwa2tpczVsSDJXVlVGakJ2dzZVaVdKdUll?=
 =?utf-8?B?K3kwWitmdkFvSUVGUmtPVjQ4NnFFQTZYUDZCRkRVTEh0K1VDeFJiZUt1WWMy?=
 =?utf-8?B?WGxQWVZqTE43ZkFuOHdyL3l2YjJBbUJuclNIU1ZGYUlqOXFrbXZjS3Z6a01F?=
 =?utf-8?B?SnRjZ1VEMW1xRlFPY29xMUl6SmszVlJzbW5kcXRWVHFXOWpITHhPNEl0ZmZW?=
 =?utf-8?B?ampBV2dTeHJVNUZFNFpUaEx3NXlDcWFDcHloNmkrWlRYTGRtd0dRYVNVTHVQ?=
 =?utf-8?B?Q3E3bXkxSUlaaExUa2RQNkk0UWdJc2UvamtRcHlhcTJpV0gxNXU1Y0hpeDND?=
 =?utf-8?B?MW12U2sxMzZpY01FV28weFJnVFkraHFOMUJ1UnRMbDZoQ0RSdURhMnczNlZP?=
 =?utf-8?B?QXlXYTNNRmNrRDhpMmwzMGlFMnUxRUU0ZmQ4UVhZOUQvRnpkc1Y5R0tsR0Y5?=
 =?utf-8?B?QUNORzFlVWNHQUIxK1JDSkJjVmtlVUdseDNTMi9SditTelRadkRBa1AvSzJY?=
 =?utf-8?B?MnYxK1B3NFBxTmxYdzQrTmtvaG8xdytvT1MvK3VjeWtUM254ZEI3alkvOVhj?=
 =?utf-8?B?WDRLZUxCRUJlOTJnTHVEVVQySmFDVEsxYVp1eTFMZ3hsc0ZIbHJJVUpXTEF0?=
 =?utf-8?B?RzVadk9ZWmh5YWVqUERURWZpSkFOdjBEZ0U3ang5WFpQamtxOE5GSGxNRFda?=
 =?utf-8?B?cmdIYk4xeVI2Q08xOUIxVm5NaERLcXhMYzVFSTducUhxdys0NThrTGh2azho?=
 =?utf-8?B?eUs3c2pRZSs2ek1wZDlFVWEwUVR5SkExLzd6SUtGS1hocWV4YXpjWTU4ZjFa?=
 =?utf-8?B?SDIxMnhlRXhHODBmWXlhV1IydzVXTkF4STRxelkwQkV5cW82RVBzTDRUTita?=
 =?utf-8?B?OElJNS9UM3ZaRXJCbzI1RkZpclVSbE01YkF3N3NBeEpoOEtzSjhRSkJzY2dC?=
 =?utf-8?B?ZUdycHVtUlJ2T3Z5NEpEWXFWQ3ZlYVkwZEZyOVMzeXRRdWdCaHM5VjRqNWQx?=
 =?utf-8?B?RWlhVVVPZzJOWjQ1UDRWdEVmM09mOG9RVUJLQkwyYjJkdHhGTUcvUGdsZkZq?=
 =?utf-8?B?VDlUYnY5QXVFdnZLYTBpeFZEWkt1OVYzMTRueCt6ZFhHTnhPcXh5bDBQbU9z?=
 =?utf-8?B?UGxoelltRjZMajJDVnJOVWNxU0dXd21pZ2s3REFFalNqK3FTQ0o5TVVRejAx?=
 =?utf-8?Q?0fyb7y5SAUejy7yip0HBZ5urcl07132PHzeCF7I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?empGYmhKU0NOMVJaN1YzZTdOejFnV3VPZ2R3ZGRnR3NGZ0dJUDk2aEdNWWF3?=
 =?utf-8?B?Q2JEU1B6NVdtclNOOHpGN2lQUlY4ZTZ4WExFWGNkV2ZxZ05NbFllR2g1OFUr?=
 =?utf-8?B?TGtyR0FPSWZENkdjMGJGOUV2WjNQU3hYckRNOEtPMmMzNkpSMkFWRW16Tjhz?=
 =?utf-8?B?WXVVcU1IU3Y0YmtlQmFnczFmY3ZVT0wxanJNT3dGQlZOUXkvV3R4NHluVGZl?=
 =?utf-8?B?Q1AzdTd6RTlzRHZWem9FenIzWWpMNDV1NnAxSDlram8rVlpHM0JJVzFvMTYy?=
 =?utf-8?B?ZjBZNnNUZzdoRGpzSGZGZjkyMmJzTlh3a1k3RFczYnhZZWxIVnNVaVhPa1hn?=
 =?utf-8?B?RWpIZUNpUUFNcjErOWx5bm92dHYwQ3FBNFV5c0JldnJwaGhFeVZPVWFDMkgr?=
 =?utf-8?B?Wk82U0JqeUFYVFZDTUtESy80emZRSUdpUll3RDVUTjBkRmhSR04wRjVremcv?=
 =?utf-8?B?cGRrL2F3WWNUb2NDMWVsTEw0QXpqN2FTTHA5M09PZmpqNDBFb0duQVlFazZY?=
 =?utf-8?B?azlGbC9mN01OOEloc1dFV3NQVDVxVXZDa3dlS0taUHlXTllkTmcxWDdEbWxw?=
 =?utf-8?B?NjU5MkNMZWFjN3BmSEhwR1oxcTFPU1lORzBhQkJ5d1BpMEJnMXZtUWY2S2Vw?=
 =?utf-8?B?eU5zYzlYQTFCeWk2UnNDZmU0OU5BdDNUZ2d1Q0xZeHRibUhKc3lvTm9VeFZ5?=
 =?utf-8?B?NHlIUkNLekN2OGh3T1QwTFMrVGxpU2NqQ1NGTDlXMXZubHQwVDF0Z2tJajhH?=
 =?utf-8?B?SW00WmRNb3h3MUpnczBqNGd5VmFNTUhYWW1xTXlvcExTd2VQRnZuejcrangz?=
 =?utf-8?B?MUtKK1BpR2RGQTRVQ01kUzEyYStWRlJpakNDZlVRdEFMOGF2YVZvMjRTTUVl?=
 =?utf-8?B?Zm1MUG5oS2hvOElSaDAyMkZUa3RzQkh2cGdPd1RqY05wK3IwQmYzYjcyYUFx?=
 =?utf-8?B?TmluM3pRQ3pDaTk2RGlEakR6VzBJWXZSK0t4TXV4OUF1ZzJsL0UwQWlQREZZ?=
 =?utf-8?B?Wmk5Rkc3MWYrYkVlY0ZTRG5uWHhPS1habWpzaGRZbGJTcURWSEFpRzlKeUdv?=
 =?utf-8?B?QjJFejBtYWtDb3Z4eDZRdTk4ZlFacWpPMGJCd1NjTGIxYnpTYTl6WndGN09E?=
 =?utf-8?B?aUhJdG5RaGVFdnVOYTZtWmxDUk0rZEVDQTZha2hhQXBWTy9jVkVMcitIckxk?=
 =?utf-8?B?ckZkVW5tYjFVUmNVV3ZJZVI5NU1qd0NaV2xkZHF6TUVIZkxRUUdiUW1XaUlm?=
 =?utf-8?B?TGw0QnJ4ZTF1MjhNbDB3NXU3Y096QUlRa3FrbzlPWjZqVW5EZVF1RXM1MlV0?=
 =?utf-8?B?MzhBRWZiRzBRdEsvRGwvYVp0MVNjbllyaWMzS3dPQ3I3djNIZ0lDV2thZFFZ?=
 =?utf-8?B?L2JNelE1bm9NUDZwY1Y5TzZVSWpUZVdRcUNOK0UwaXB1VlBRZi9yY0s4YkV3?=
 =?utf-8?B?Y3I4YWlHeUgwNkhEejhTcWV0T09uRDJZTUJ2Q0tsZ1d6U0lHVGxaWlQ1VTNu?=
 =?utf-8?B?KzE2bU5zTDg3bEtRaElXcXBJaHlYY1lqTnN4YTBidGU0VEs3NGZ2UDFFN3Nr?=
 =?utf-8?B?S3FtamhmemFsVlYyVDRXT3ZXWVZ4WER1NUF4aDRxNWdTZFEzTFdhaHZ3N1pa?=
 =?utf-8?B?elk0TzIrQ0JqWGxCTFpzZE80dktNcjhRWjJIY3hEbndUZ3VLNElqbUFseUpy?=
 =?utf-8?B?ZkphQ29sWFFHYWpTZzRaZzJISWk2QVAvRC9zNk5Pa1hIaWdRSFZJUjl3dEg0?=
 =?utf-8?B?R2VVbkRIRzlKNnljZTJvSFNTTXc3TGZOZmNETE5ia1lLUGtuTEZnaml3anZ2?=
 =?utf-8?B?Mk45elEwcnlPRHJUNzRoM0ZzejBsUU1XR0U4VzIvd2d2cGtXYlltdzBUTnM3?=
 =?utf-8?B?RVhabXUrUExXZ1RvTmhMT1I5eTBveGliL3ZPN3VOVlhSa1BLTm5PYnJhOFFE?=
 =?utf-8?B?NDRZWDZWVSt0QVhYWVBxSEFRbnh0VzRzVDFDL1JleEs3Y0NTcXo1OTh3d3dB?=
 =?utf-8?B?TTJrNUhsUXlRb1poaGZwallvRXF5cE5FRTU4SXlMSDhxM0N4eXcwWk1vcmU2?=
 =?utf-8?B?dUtRUzdnS3VBL2RLZVVjV2pRemxFTUU4RTFtaEdsc2JDSkhqTnpNdzU4QmVn?=
 =?utf-8?B?UXgwOUNwb3MyYS9Ka1JlVjVaM0dkcHdCSzlNZlI1WFAvWTlnekZsWVU5eTZC?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4412541-c89f-456c-0372-08dcf89d991e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 04:44:54.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpG8oUkJqBUNP83re8YoNma5u5MfqLSxSWwD3pDjh2GFTWJhWyMNYD5OTXAQvKW0ALjKuG1jl7GJMfrag9F0Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527

On 10/29/24 9:42 PM, Christoph Hellwig wrote:
> On Tue, Oct 29, 2024 at 09:39:15PM -0700, John Hubbard wrote:
>> I expect I could piece together something with Nouveau, given enough
>> time and help from Ben Skeggs and Danillo and all...
>>
>> Yes, this originated with the out of tree driver. But it never occurred
>> to me that upstream be uninterested in an obvious fix to an obvious
>> regression.
> 
> Because pinning down these amounts of memoryt is completely insane.
> I don't mind the switch to kvmalloc, but we need to put in an upper
> bound of what can be pinned.

I'm wondering though, how it is that we decide how much of the user's
system we prevent them from using? :)  People with hardware accelerators
do not always have page fault capability, and yet these troublesome
users insist on stacking their system full of DRAM and then pointing
the accelerator to it.

How would we choose a value? Memory sizes keep going up...


thanks,
-- 
John Hubbard


