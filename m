Return-Path: <linux-kernel+bounces-389289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F49B6B03
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FB21F216B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D91BD9D8;
	Wed, 30 Oct 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ua1fDEJj"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F051BD9DB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309352; cv=fail; b=bqb+bp2eoXT3kJdO9IbENUEeB99WkV1eXB6dJPdCzJyJheJDTMqBNhxQu0t3H8ftFzfFxogYMQ6i8lgCmvER58bPKyMwW9PkChB0sbAbOhJ5Kd3aziSXEqyLoRHlC61k/4ygkiXO+skB+40fEA4XYZaQIZYHJ7HQ4LFX+rJiktY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309352; c=relaxed/simple;
	bh=w+ComFbHfawSpCabWhIKUH6zu0qA3CFFpGUPoRHr9ek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IzARv06R+Ozom2W1taKZgHdc7O27+x72Yar7AO3viwf2jbXIym4FK4TSg5zgvWlmCEPVQIZPuNyY1i6tHg3uYYufQy43IDsttuS9zRrV5lDYKb9f2YhCY01TKTIxCRYzQ7nhFgxVsizW/R9po6fl1v7oj+e9YvbtAQRmSmcXMSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ua1fDEJj; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEgiDE7Wd8/XdSxQbhg6c44+Mvd6xAh2v44FVBnAyefXybxaEu8KEHkE2WpjsZjmVoj86DK7wrhUL53YxSbqup3l7vAkE6gZyXAmLdNH2AqxZGDsv9y9SNWBh13oNk9uPzymVZw07cBFwgiG1xxiR2QfDSjo1CAQg0QsvKFQasiArNIdHFrb1ZL/HeV6XsF83SSLdUcQ/wELWXE8qv56vtnkRLx7aicbBsR0+P/UFc3sKydk/4ozCfQA1GNvvoA8YhlvCMuROucYU9fVIYBdBBW2BO1WCbvwcHrue31hKgUOHdXF71okOQNFtTsKsFT9hC2/9qsiQicynSlXnT8EnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3uR94Q+ZYUW+UI/k/l8KW0CSPACFAm2n8INCjJb0Xw=;
 b=jKj/THt3bT5eRiuFNRa4I6T9pxHR0OIqpvT25t0dMbOjJARKZkoDd1ADZkGjLkqx78CLgid+bU+993pmktFmEn/tA4P6y5QgNnfqJi1TIbyDXfUF1/WmuWqGw/yNs82GflO4Q40OqL7wmhaiOynabYOaitgMOWBmWRAgbSqaYzFfAX1ASYBHdSmd4PmVBhvG/JyCRjIK2L2gHq7VXm4USBk0k/E5Oqgtee0/kWROjzj4ncHWG9LVuCK929RrvlWmy4Bxk+2k1OTO21kYb1NeKqheaWx8Yq/6sKYojn0MmPg8otQvJ40odSGmeqL2BfAfGPKYA6nfWMkNjKYYtp4+Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3uR94Q+ZYUW+UI/k/l8KW0CSPACFAm2n8INCjJb0Xw=;
 b=Ua1fDEJjIsWvK4T6hZrCa/e0+pl8+iR937AU5+NF15i3oXKhzIRvpAmCgZzsub30jWy9N4qrTZXxIxzY3LQkraKMty4lKbB+3mLeTbBhE7IGq4mSKH2rqSwPjASj33hPxQcLsi2la51u4afBlaU/7tAzHsV+8HtQRnYmDODh2IPEOCTYXb03RwOx6vtirIWFs1afhn5If3qK9WuJQJ6DGJLUecrFPDYUHwpTbC0BNZbfZ2lvsrEYRJRFMNak4mpu7T50084FtvmCM3R0fXHk3rq6xmmJ3BKSBkwFtpcYBRo37AXtJmgwaTfR9kR1ZHuxiLgucIrWEjXXabkqs0h//Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 17:29:06 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 17:29:06 +0000
Message-ID: <ac06dcfe-c370-4a37-9d1a-2b2c2ef076aa@nvidia.com>
Date: Wed, 30 Oct 2024 10:29:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Hellwig <hch@infradead.org>
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
 <87124c1d-5b95-4499-aa4b-22f2ecd376bc@suse.cz>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87124c1d-5b95-4499-aa4b-22f2ecd376bc@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::30) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c928c4-cea1-46ea-0a41-08dcf9085b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWRvR3pPekxseUxpTjBnSE5HWm9sdGtLRVlMOE5QVTVTSUE5QVFTemp0WFZj?=
 =?utf-8?B?SmxQMmdGWU5QcnIyOEpzWmRxeThiY2VablJSWmlrcU9JVCt2eWxZMndTbjZB?=
 =?utf-8?B?MktzRXk3bmVOdVR0WGU1enpEZWFvMngwOUxZMnZpeWVqNUc5NzAzV2plNnA1?=
 =?utf-8?B?SnpteHFyaEoxN1RBQXNLWmFUL3pxdHR0SWkwcUFpS2xLT0JIcGpvWk1yRjRO?=
 =?utf-8?B?OGRPVC9JUVBicE1xZWNQays0K2doSDRhK1NZSTVvdHFZbHFYbENrVzNGdVRv?=
 =?utf-8?B?UlN0N1hMNUtJcHFGbUQ3VW0ySDNoSHJkOFJMWTN6Mm92NkF0dkRZTDU2YjR0?=
 =?utf-8?B?U0E3QUJld2c1VEhuWnA0Sk9KVll0OGh4R2ZpUElKZktNZnY4SURHenE2NnhX?=
 =?utf-8?B?bFRSUVcxSHE4aG9hazhLbm9zcWs1OHlMYk9UK3dDWWdmTkFjS1RxOVVlOVIy?=
 =?utf-8?B?R1dLd2htbW90VEtFOVdLZjB6QzBaU1pTaGIvUlcyMkQzbnBRTWZlcWFqTlJ6?=
 =?utf-8?B?cGE4ZThyQ1NWbjhaZHlLZXVYNjlRNU9odVFqNzVuRnQvZXNWSS9nbkxrZlJz?=
 =?utf-8?B?ci9KSFg3dnZYVHJFeFcyNm1PcU03Qzh6TENiT3MyVlpMWnZ0OWh4N0dLemVF?=
 =?utf-8?B?TlFLQUs4QlphS1RkSEFCZ1cxYlRuTlhZK3ovcWYvcEw5UmN0TXpQcEprL0Z5?=
 =?utf-8?B?bHdDSkFQUjVCOHA1RzJjbmMrWkU2Nk5reHpIV283cXBJWHc3YzNlWGo3Nzg2?=
 =?utf-8?B?MUhkaVIxcmpBaWk0Ryt3cGYvc2NyV1J2bFZmdlIycnk5VlU0ZzI2WFBpeHZB?=
 =?utf-8?B?N3FFZm1FWmgvUVh5cFdvN0VXaXMxd3JXOFN3bnhFRk94MVBrVytTeHdCc0V5?=
 =?utf-8?B?eDZvWWFRVGhadTFweXRuUzVMTTZCVGlUQXhTYWYvYnpVL29FT1BFbXFtSmVi?=
 =?utf-8?B?bU5yMnlYRUZoMTFYM1lmbHF1V1pJZ01PR2pONnNpckVBTmYzWW00UTd6U00w?=
 =?utf-8?B?YzV5Q0JWakFhaGtZWGRXWUZndnh0NXcrVDd0YjFuRlZpQmFObjkxcjBnN2dJ?=
 =?utf-8?B?NlJHcmtaalNyR2Y2djJwM1IzRndSWnVwSGJRNXFaYkRUU0ZMRVF6azExTEtu?=
 =?utf-8?B?cHpQOWJGdkhqU2xwT2xxZjA1bHdnUi9ic2xEdWlmcW1uY0l2SStPelBzWXEv?=
 =?utf-8?B?ZDdlTlNMaGNaeWo3QnVWVHR1UjhHNTJkSXR1eFpnZWVneDlVd2srb3ZoUTRI?=
 =?utf-8?B?VVpOcmFPZmN4NnlvaFljTXNFdVhCSDFvUHExUDdzYnFoSnlibkFnMmVIREFq?=
 =?utf-8?B?UXhsbnJyWFF6KzVkaG1VY0tRcFA5bVcvQ09qMWlNOCs1ZGM2Z2FMc2V0cjlR?=
 =?utf-8?B?KzczRHl0eUtWdUptQVdkRVl3N09Ib3NoMlZXdEg4VUhmRWJBRzAzdmtMclk2?=
 =?utf-8?B?ZG9tWllveDE4L2czeXlaN1V2U09DVUxFOCtiWkZSRVFWZGRXZnk2eHdFbFB2?=
 =?utf-8?B?YVdLNHY0cEhVcjdoa3Z4TmVnOCt3cVdNSmIzUmRDL2tXbU1ldkgyQkpIakN0?=
 =?utf-8?B?V1dZSVpCblY2RFNITk9Ec05rQk90YjBqMDJGbmlDQmd4NDJvbTNXa3dyOW90?=
 =?utf-8?B?dGxIeEE3bjd5MTZaNEVDZ1JpcGFVUU1XbnVWNVJzNUVxQVlMVlRCQlVTYlpE?=
 =?utf-8?B?Z1BsN09QUWx4enc5OTNiTnd5QWFyNk5ocnlyZ3J3cG42U1FnejIxa0R5SGFy?=
 =?utf-8?Q?Ubc4xysqJa7pNSq1rxiBzmP6YECwGANNP3iwLsM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkRGRUdOdlM1ek1RL0NvaWg2KzNJdkU5RHVpRk43Q05GMHhRUDF4YjdtVXIx?=
 =?utf-8?B?TGhmWldrRU84c0VoUEpUVFVLSk4wdTJhMTk4OTNuYlowK0xhRUNTWVdwWHNh?=
 =?utf-8?B?NDF0cVZSSEVkcXZkUE9FaXpManBvZXM5MkpHbW85eWEydHQvTE9pRzJ1UGk3?=
 =?utf-8?B?RjNGZ1lrMnpkNm1zalR4cDF5NXJpZnIyck1rNjhzNzZEVXdpNUwySEdmK0tZ?=
 =?utf-8?B?ZEUzek9qZGFQdjdoTUc1WmhBY1pMb0dTclU5VW8xb1FwaE14cHpVd3p5Ulln?=
 =?utf-8?B?b24yYjcrOWkxVUV5aG1VZDl6Z25LQ2lQZmI5TUMvTGRDbk9ldHc2TERQMksw?=
 =?utf-8?B?RnR6cHZEbHliZFBsT1JDT00xejVVeksvOHFFWC9pVGJaRXZRZFVxdFkzaXhY?=
 =?utf-8?B?NGR3d1UwTGJ4MmEwVENDZysxbU1ZbmtHZllOL1lPcUl3UUhmaFdMWEk1QjhU?=
 =?utf-8?B?enNDM1JkYTY1WlQwQURTdkJJcmZJNU5vRWV6dGJyYThSLzJydjNJaEdqcnNO?=
 =?utf-8?B?NThYMzBRVWlwU1VtUU5EQkUzSmhQWVFIWFNjVnAvOVZKSmIvWVc4aTVlZFJn?=
 =?utf-8?B?ekJyYXBzenhMY1hMTldzVUtlSmQvQllaWGg1Qlkzb2MyVWx3QU9ib0FmS0VF?=
 =?utf-8?B?cUZZTUttYWoxcEFoeVU0RHNiTnV5N1NhVExxcGdaa0w4eXlpVGgvbUlodEVP?=
 =?utf-8?B?N0I2dWlid21UbHp4TmlHRFlwcWRwSVhDZFdvbnZDU0gxS3BrUlU5cVFSczVq?=
 =?utf-8?B?ZkJOSGhaZ1ZmSVpHRzdzN3FnSGZtTGd6c2ZwOGtYVWJXK1JVMHFlZ2hRd1VD?=
 =?utf-8?B?WEJJcU0xOVZHSHNCR3hidmg0NkIzSjdXRjJob3RRbFl2Yyt3U3BUNk4rcXhx?=
 =?utf-8?B?NFhESzBSTjEvT2xyeE01dmxFeFY1MHhtRzVSUmxFdzhCTWxMV1FvbFFOTUcr?=
 =?utf-8?B?L0hXbTBUbWdOaDlTbkVaOXJXRUh0bytGZTIwY1V2a1RZZ0FublNGNThFTkJ0?=
 =?utf-8?B?TndHVlNhSGNFZTI3ckg5b3RiZDVqSk9nd0p6NGsrOFl0cmFKYldwYnBpVXFH?=
 =?utf-8?B?VzJDL0dDaHo2UnpWOFdpckhOS3YzWE1DU3ErVGZXd0liSUZUcEY3aU1kQkJD?=
 =?utf-8?B?Z21LSnRBcDVmWUtCZ3gzQjg5MGhQbkVMMG1aOExKL3pzUkxxMURoaE8zckJC?=
 =?utf-8?B?dDJzQmFaVEhoRG91ZEVlY3R1TSt2ak4vdXZQbnRFL3JNK1dJVVBHZjVneFZq?=
 =?utf-8?B?L3E2OCtCRXQ2NHdGU0ZZTzNZaEJXUDZiQ1pOeitXR0VndVpMYU5rMm85WHMx?=
 =?utf-8?B?L1Uwcjd2eUkvRzdyRVpXSGhCNmk2Mk50ZkFlemxVUGh4OC80Vlp4Y2l2eDlZ?=
 =?utf-8?B?STY4Q2JlUUJmZEswMmRJN2pVYmNMM1ZnL1RWWmNxcEh5bXR3K2JiTGkxTE1D?=
 =?utf-8?B?YTFBQXZRQWdzWFhBbnV5cldYakxFSmdMSTFJaUx3bG5iQXZLdEo5dFMrRXE1?=
 =?utf-8?B?SFB5VVVvOTV1NnI2TlZIc0xSOGtodEFjbmRucEF4bElpMDBPUWdVZ3hsSGxB?=
 =?utf-8?B?alhFRU5FbEZhSXZ5RzVDS3dDTExpbTczSjdTL0V1WGt2a0VUU2lXNzFRVnlv?=
 =?utf-8?B?L0ZUMnZZU0pMVjM0Z0lyQlNYZVpuYmRxSklicU9zRElScWk5VzI1RTk1eUpH?=
 =?utf-8?B?bEhHTlErUjNuZENpbFY4NEtFWHRyTEhUU2hXNi82K3M0RkI1cmpWRUFOTWdL?=
 =?utf-8?B?WmFsYnQ3c1BORUVYT2JuYnVCcVgzTFJGRHd5Z1BYdWo2Y3hUWHQ2ZjZTYWFq?=
 =?utf-8?B?cHkwakVMeHk3Ty8vM0FBNTBBbCtKWmFkc3pCT3R3L0NsZTBRRWxubEs5NDAy?=
 =?utf-8?B?WnIrczd6M2tiSlZxSWNnNHI2LzRUVjhZemZUdlVKRUhEemJhbTJ3NmpFby9k?=
 =?utf-8?B?eFVFcVlPL2dXeFRCN21YWC9hd29BR3o5N24yalBXU0Q4V3pnc0tMR3FUN1lk?=
 =?utf-8?B?M3ByTlZoTDZkOTlIRnJ3Q1JSSlJuaWV0dTZja29MVlAxeHBPWmo1TXNrYkJq?=
 =?utf-8?B?ZGRzRG5RVVNCZndzL01TSmRXNWRYM1lGUzQ3N0MxN1BPMk9GamRWSXZxUlVM?=
 =?utf-8?B?MXBjYit5c1VPMXpVV21kWjhtY0FwTm1ZVE93cGdxcE1aUTJ0UUlFWXZJSHpO?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c928c4-cea1-46ea-0a41-08dcf9085b49
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 17:29:06.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fmTeyQAwKJk5Vp5pdom96lLH98AmthOw4edNiFtyuqwSzBrnuvjwJ9aeP+F590Cb9VGoNZifhr8+0FKQBNTXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516

On 10/30/24 4:03 AM, Vlastimil Babka wrote:
> On 10/30/24 05:39, John Hubbard wrote:
>> On 10/29/24 9:33 PM, Christoph Hellwig wrote:
>>> On Tue, Oct 29, 2024 at 09:30:41PM -0700, John Hubbard wrote:
...
> It might be a regression even if you don't try to pin over 2GB. high-order
> (>costly order) allocations can fail and/or cause disruptive
> reclaim/compaction cycles even below MAX_PAGE_ORDER and it's better to use
> kvmalloc if physical contiguity is not needed, it will attempt the physical
> kmalloc() allocation with __GFP_NORETRY (little disruption) and fallback to
> vmalloc() quickly.
> 
> Of course if there's a way to avoid the allocation completely, even beter.

Why not both? I'm going to ask our driver team to batch the pinning calls,
as recommended nearby, just to be sure that we are following best
practices.

But it also seems good to use kvmalloc() here, and avoid any other
regressions. That's also a best practice.

thanks,
-- 
John Hubbard


