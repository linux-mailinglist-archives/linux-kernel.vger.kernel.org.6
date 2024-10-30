Return-Path: <linux-kernel+bounces-389375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5CA9B6C40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A7C1F214F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806661CCEC8;
	Wed, 30 Oct 2024 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F8o43YA+"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843361BD9E2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313298; cv=fail; b=bAYyvGXIYpBN0dVD64BLpSrO64em/mWltApGYglRaBiEYpKg1IVh5cNQ8nmcMntME3dFpMAnybDQOfSNtE9CoIXcwaOFkuAYS+9181uB2PWEscVUVU4caMQAT2rIpfviqnbkMhMjUzMEsFNJyEQ+fIE5M9HXBx5Eg6O4M+GXOuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313298; c=relaxed/simple;
	bh=thcR0foonAyWHKAx54hefJrauiotRaDw0fPoLovgGRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GS6B4ijewZF/sDi/8h0GypmLkzq7ARo/3drAr9uovUcEijVLmWUpSG05ZsVNCLP6YFHKio8bc+iZpkRFT7ewqPmhyKb4TWlUWMVkwtfl0aFkYkhu9zNNc3PZBlgRxoRChVCYrRKqSOeEBmZY3LKLvo4oADOSnfvi1D9Aa5oIEmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F8o43YA+; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SK2GSjzS2rz8sLUJtVTL8DuyEIb6Gxsqwn6FQKnCPn50nBVqo4eeGrf9dQrK16VwcuxrIcPpwHBqd6i5yUF8RCS59LyevMfZ2lXXsl/lCn5CUda7DI7VuPXkwita4S098LUa/n5qLAIufw5BK6jjFDc/al2+2Jc3mAYhNO8Fi7MeTHEtJZdg4WAtsOnKOKmsfLVuBtuZ6QJUEcWn9IaumSF9QdbKzykyhgHix7pgg6elVmg4+s9NldSf/4SrpDJroCdcKLERa3z/tIVOSbQV9UZG/GPdmrof886UcyfAg6wkXs6YwqmSOXGt3tadWVTNDHvqR7YDfO0GRxRGPbkwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmU1oS24Z0cSSDGEbIixN8kO/KaCLBCxN3E3JWnJsxc=;
 b=XPjCi0AqCb6Phmy8LY4EUgayE5KW+EDsKFA4DK6iRfcBco0TLallVaI3AS6ukxyJ61PjmeiMskGCkPGQdiE5Fv0OE08rB4eLQEsrIIX1G4eoAB1Xljn2R0slbYNoq5wrpB3bGLcC4ZarE90rj3V+UMIQvCQje3vR+JLRB0TUjOUGO1NW4YIHPSA8c3RFOP/zmsOWql+dQzpUQM58wL7Fcr2drT7VnQZ1lb5YS7ITGctzvBlPQ/p//lBWrPbM0JewPT4YJakHk0USYcbwanEvONNOrhCCBfRUVZzHALq0C7A1vTqPU+lmAu/YrGtM4TMlnrC8aD+P+Pw6ST5xr3jBZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmU1oS24Z0cSSDGEbIixN8kO/KaCLBCxN3E3JWnJsxc=;
 b=F8o43YA+/Oi0FY4CzfeugzWyn6zc9nzTTcFpGhaoja1Nn+5sW0WhS4ZlTDH1qwU4wq/XpxYT0jGvIwrP6dIf36fbkHpnagxLHV2yGSRo8syodb5zt8yqlfZD5/WVDF57fxSRidDq3as8w/VgWmoevBwGWSiIk4ZzWoxUnVYuwklhTNNufRw0p61VOLip1PtAO8NbqjQd8Ik9xJMB/j9Z+U8hQrBchV431Dx7CGk7BAVeNL4WyE1Xmgb8aTOv445/ah60AWDTfzdfTDw33MrCKb69RF/+4U8N/8H01jB2j9OTtlr6z/2rXbA5/GcPyCW09hAKJutpeDlVEYpqK6qrQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by MW6PR12MB8662.namprd12.prod.outlook.com (2603:10b6:303:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 18:34:50 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 18:34:50 +0000
Message-ID: <cdfadcd5-d9fe-4f90-8794-a563744ce207@nvidia.com>
Date: Wed, 30 Oct 2024 11:34:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: David Hildenbrand <david@redhat.com>, Alistair Popple <apopple@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dongwon Kim <dongwon.kim@intel.com>,
 Hugh Dickins <hughd@google.com>, Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
 <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
 <87r07yp0ng.fsf@nvdebian.thelocal>
 <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
 <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
 <8d9dc103-47c5-4719-971a-31efb091432a@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <8d9dc103-47c5-4719-971a-31efb091432a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::18) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|MW6PR12MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: 618c64c0-b797-4455-8652-08dcf91189fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWlkSFNUdmEya0Q1cTlrMldaSWk1Vlc2RGZFSjdGRHBpVERGOHBta2Z6cm9z?=
 =?utf-8?B?ZlBhdmJ5WjExZGwvOVZXTCtIRktyUmgwYi8xUkhlRTJOM1p3TWFzdTBsRXFS?=
 =?utf-8?B?TFpVaFc4Y3RZcDcybDkyVVd1NmU5NXdvcVJ3MWxrSmthMXJWZVk0a2dGRXN6?=
 =?utf-8?B?bXZaQ2hlaHFmQmh0S0hIMTBHSEtkSWVTSSt3S09uZVdnNlFtU3AyRER1T1ZY?=
 =?utf-8?B?eEZFQnVCR0pIenFBQldDQnd1cHBTTWJmR2lpRkNvWkdUUjFkdGRUZmxVVFdX?=
 =?utf-8?B?UzRoTmlrL09YMmlXaWw0L1FhREFoK1ViNlltODBRNDkwdEo4R3FGN2NUMzlX?=
 =?utf-8?B?bi9ZMEhGcUY4MFFzQjRxeElwcC94eFlhcUVHV0hidmdjQkxXcCs3am1BSXVy?=
 =?utf-8?B?ZnFWQmVlTWwzWXB2RXkzNzlQYUxReGFwYVY1d3RHT3ZlRHFONlg0ZTNZR0c5?=
 =?utf-8?B?QUxjQTNGTkJzN2pZMGJkNStuM0tUUGI0eUhYcitIdVlWNCtWSmFscUJBbnp6?=
 =?utf-8?B?RWNYUlNjUFRLLzVKcDVkaGIvRDRoMnM3Ni9WVm1FSklqekJKKzUxQVZscTBa?=
 =?utf-8?B?SXRTWWZqMVlqNnp5QXFCL09iejF5NWExUXI2Wm5GYmR2MXVlZm81VlBXOVpM?=
 =?utf-8?B?aDdoby82dmhCdTM2Wmxzd2M4d3I3cUI4U0kvWFp4MDZtRldLSDU0d0l4QzBq?=
 =?utf-8?B?Sk1aa3NGSUZwSUtNVVhjcTlOa3M3b25PUGNtRVZsclA1dWRlQVdVbEdOUi9Z?=
 =?utf-8?B?REpHMHZVZG4xZ3JUeXJzaTRudFlkMSs1VUFIeDB3RXIzZTViSXJtR25yZTN6?=
 =?utf-8?B?RlRiNWFkNitpeldjVUNKLzE4OWZEY0ZtNW00ZUtGRGF6L1FLNGNHeUQrZTZi?=
 =?utf-8?B?MmVTUzNjMnBuSUVRT3NNYU9xa3kzMFBDamtEQU5HeGhlYUgzU0lyMTBOaUZP?=
 =?utf-8?B?ckhUcVZ3ak1iWDhBcXVsSWc1aktWcEYzTjJSaSswcGc5ZDJBM0tCOEU5RWJo?=
 =?utf-8?B?S1dYYmZrWUpDRVNVTWo5ckZXd3pxWVAwQTZhcHdoYkFwTXJDWmt2cUZsSS95?=
 =?utf-8?B?UUtGZnNwdnJOTys4UUF3QlBxbGZrZFhpODBGcEd1TmpHK1VwNHJ6dkZtdCt3?=
 =?utf-8?B?REVqL1UwR3AyQ1ZIMVkxTE56RXpFMTlGaGJ5K2UzRzJlcXJRSUZmRkhvQW5p?=
 =?utf-8?B?T0hXdUQ0ZDVJd2hoTkVrRzNZbVY2WE5lZEI3UXJyYzkzWEdmYytjTENDcExU?=
 =?utf-8?B?VUVsckJIaE1XKzlyRzNMdU9YK2Y0RzNyYk5uekJUMVpnQnBHYlRMNmdlRkZj?=
 =?utf-8?B?M1JwUlRFbFRYOHVFNWRLQzU1V01YUkdnblgxcFMxa0VrQzV5ZlFORXY3RU1Z?=
 =?utf-8?B?V2VQUjgxeTh2Q2VHaHl6VHN3ZWdINnRrMkw2dlAxVDJDbUd5R0tGaEVWT2t1?=
 =?utf-8?B?NnV6VHhacGlUenBUdytyQUJLeUs5ZVUyT0lNSHN2Ymo3SW1MdkJOVmhsNWU3?=
 =?utf-8?B?N2EyWDhySUJTay9FYkFndGljOHZGdUlOak1CRkdtV2tpN1A2L3l6UXFTNm1Y?=
 =?utf-8?B?SmVxdUh0VG1yRmdwRUh0dTlDTTUweDlLQnVBb1RzUUtrMUJ5QW45djV4aXgz?=
 =?utf-8?B?L0JrY3VsVy9hS2V3aGVNdmVhODNkSkNoOUdjQ3h1NHdObzJRVUZMMzdsek9K?=
 =?utf-8?B?Wm1wdE4xRWtTVkZ3M21vVWw1ektqbXduNytnVDVMM3g3YjUxMHB5cGVWT2ZI?=
 =?utf-8?Q?JalNfPdWd2bZ/1UKtJuyIpL6UmUTqUgQBIcco94?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG5zQWVod1hmNHUrUWZTVEViUFU3MTFuaFBqdUlwandCL3NuMld5ZDltRlJ1?=
 =?utf-8?B?RXdEb3k5NWVlZlNOMGt4eDlmZSt1U052MTNBZG5ZWFVGTm04aUhCSXJjREtR?=
 =?utf-8?B?bE1YcG9ZaVI3dW1QVW5VME0zTUlsS1JJa3VvdzZzOG5kc0s0bUV4Y055U2Jk?=
 =?utf-8?B?UnMwZXpXV1poWHVnZ3J0VEZuVFZGS2I3SU5ZUmgyQ1lSWE5QZWp3dldsSmdi?=
 =?utf-8?B?T0FPU1U0WVloNHN4ZlYwZ1FoMElJVmtUMzNsN2MrU2NZVlorSDdNdFhPdWdH?=
 =?utf-8?B?ckdmZTNEZHZFSCtYK3M3ZS9uZDJNamcyRERWeUZqSUFwcUFlVmRxenMydm95?=
 =?utf-8?B?eXdhQUk0U1B0am52SlJIU0lwQm9KWkZ5VGZTS0NXWG54cDlrcGlGSFFhb202?=
 =?utf-8?B?c0FaUVV1d1BWL3IyM0NydzhxQzNiWGxWdEM0OW1iRWUwaXNsaVFsaUlmU2lz?=
 =?utf-8?B?UXduQ3RMZm9FTXk1YW91dlNIRjk2RWZ6WXpQc01pMi9nMUIwZGpkRDBadXFu?=
 =?utf-8?B?S0g4dzgwZHZjQ2FuWE5rUHJUaVdZakVCYm5xTG5xcGRZWldETkFLUURzcFdH?=
 =?utf-8?B?R3ZQZTlGajhZY2I0K29Wb1BYUktiS2xhVUY3UFRwT1BHZTYzRjBSa0VtRjBS?=
 =?utf-8?B?Q2d0ZDY0RUp5Nlhvb1hlTU1JTFBDbkdJbW54WDIzZWx4RVNmZ3dVUjlweEVK?=
 =?utf-8?B?RkRGLzJGZzExakM0VDB2ZTVvN1FvYVFDWDNuWjJrVDF2UHM2OFlXWXMyV1Br?=
 =?utf-8?B?anIybG9NNnpVbUgyNHpMOUEwakljZHluaUZQVjdtam10Qk94RXdhMG5zMVFz?=
 =?utf-8?B?WTNnTnVCNXdMNEt1QWUvWDdtTXY4NjJFSmtoZi9rWGRzUE4zWnhHaGI3MDdI?=
 =?utf-8?B?ODUxUGFMajROVEVCU2gySDZxdmF3anNQL3RyWUFPMGxDWEs4b3FiL1VEYS9B?=
 =?utf-8?B?Zit1eitaeU9ESTJ6Qk1LYmwwZXVNQzV5MU0zSG91eStXZzd2SGROazF3Nmhy?=
 =?utf-8?B?Rzl2TTd3Q3l2eWQyRGVneXAvY3EvUW5tSXpPNVFLSkZ0RGQ4MGJLL0d4bVlZ?=
 =?utf-8?B?T3NuUXFWb0F4STVTUnNsN3JaeUJaNVBsVUVkN0xSTitxQnl5aG1mU25kTkhF?=
 =?utf-8?B?aGZodm1BanhCMTR3Q3poUWtkYUdnWThhUTJRSURWWW5zamVrZDZka1ZnWTM1?=
 =?utf-8?B?ZkNMWG05RXcrU0NDYWU4Wmxnc2FPUHFxaG5JL25Hb0k3M1hlVWsxaHM4Y2FJ?=
 =?utf-8?B?c2hHbTAxM3dqdmdDZnVBekVyTHdFckxzQ2tlVnVqL2Y1RVBLeG9GdDRsU1BK?=
 =?utf-8?B?eEZCbGV3dks2SWlFWWRsUE4xdUd2dDg2a3VrUVVoTUh4bzFFVkcrS3NoanZU?=
 =?utf-8?B?REw3enRLNEh3Q0c4T1lPNjE1ZHVRNndhWDhyVW5xRk1FMnB2ekF6TDM4bHNY?=
 =?utf-8?B?NzAwbDNQUlRab1FLNFdZNHJCMVA1RkR4ZHlHbE1tQUNKZnNKMmRlanp4M0p6?=
 =?utf-8?B?TnVqRzZZMXFKZzZObkVIY1BDa3NWZGFPRlNoK29VYnpIeUFoUHFZWlJiYU1U?=
 =?utf-8?B?WldYSzZDbG9tamxFT0d4d3FlNUhUd1NVSTBYT3psYlV2WlM4QmY0dzczdUpO?=
 =?utf-8?B?R0pjRStvNDUrbzd5ZkZjSUd1NzZmVWZFUDNVZElIajFWckxNSCtOWm5Ybnc1?=
 =?utf-8?B?b2hmVWVETGg2eDE0QlVaNUJveW5XM2xiNnA1SG1WWHlKYXhveGhtYUppYUpZ?=
 =?utf-8?B?eHdiR2NqK01RYzl0Z3ViRmJEYyt6WThkcCsrKzUrdDArVUQ4TFNVcWlwbm1l?=
 =?utf-8?B?Mm9ZeTR0SzBNWnRkNVppRnFxajJ6SUU2R0JaZnd5WXJDM1FsYzVaRmp0aFAx?=
 =?utf-8?B?dUNhQzJnQ0JYTVA3OTRsc3l6Q043dVFQY1U1Nm9aRzlFclY5SWQ4TjROOE5X?=
 =?utf-8?B?bncwZnlQdUdiSmMzWmpqTkpZYUpCVXZsUXozdWhVTWIvcGdMYVpaRUpjQmJj?=
 =?utf-8?B?NUkva1BsaHNaUERKNHBvdjRIdkFxRG1RZ1JFWC9HNmdFVmVFcS9pSk5pUEMy?=
 =?utf-8?B?Z3RVcDh3cUdkcHV2WDJmZm1hMzRSNzhrWWhoZ1NCZXBscFZKclRIajBXTVZL?=
 =?utf-8?B?RlRKeEFzRWFZZVA2blplRk5BMlVnSDZnSGxRT2RJT1ZHclg5elFEK08yRHk0?=
 =?utf-8?Q?+6hlVbbrK3w/VtuEjMwbjng=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618c64c0-b797-4455-8652-08dcf91189fd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 18:34:50.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoEbaevWXQv2ScF7bRyA7unwBpyuHyQWzphXLd/3pUzVsQa864iGV9+RVeZ7kUkEFOyDsG6AQySWugPv8cOKdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8662

On 10/30/24 2:01 AM, David Hildenbrand wrote:
> On 30.10.24 09:34, David Hildenbrand wrote:
>> On 30.10.24 07:50, John Hubbard wrote:
>>> On 10/29/24 11:18 PM, Alistair Popple wrote:
>>>> John Hubbard <jhubbard@nvidia.com> writes:
>>>>> On 10/29/24 9:42 PM, Christoph Hellwig wrote:
>>>>>> On Tue, Oct 29, 2024 at 09:39:15PM -0700, John Hubbard wrote:
>>> ...
>> We should maybe try a similar limit internally: if you call
>> pin_user_pages_remote() with a large number, we'll cap it at some magic
>> value (similar to above). The caller will simply realize that not all
>> pages were pinned and will retry.
>>
>> See get_user_pages_remote(): "Returns either number of pages pinned
>> (which may be less than the number requested), or an error. Details
>> about the return value:"
>>

Yes. The API has a retry built in, and so far it has been vague about
any upper limit. So if we want such a limit, it might be helpful to
actually put in a PIN_USER_PAGES_MAX_LENGTH, in order to make it
clear to all the callers.

 From a very high level design perspective, it's not yet clear to me
that there is either a "preferred" or "not recommended" aspect to
pinning in batches vs. all at once here, as long as one stays
below the type (int, long, unsigned...) limits of the API. Batching
seems like what you do if the internal implementation is crippled
and unable to meet its API requirements. So the fact that many
callers do batching is sort of "tail wags dog".

But anyway:

>>
>> Alternatively, I recall there was a way to avoid the temporary
>> allocation ... let me hack up a prototype real quick.
> 
> Completely untested (also note the interesting TODO):
> 

Thanks for doing such a quick proof of concept, much appreciated.
This approach seems reasonable, and I do like the idea of avoiding
a new allocation deep within pin_user_pages(). Callers already had
to allocate **pages and it seemed unfortunate to do another one.

I'll try this out.


thanks,
-- 
John Hubbard

> 
>  From a23984b4f1a39ec984489fbe16708aedf4f9db95 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Wed, 30 Oct 2024 10:00:50 +0100
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/gup.c | 120 ++++++++++++++++++++++++++++++++++++-------------------
>   1 file changed, 78 insertions(+), 42 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a82890b46a36..8807b36c2363 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2273,20 +2273,56 @@ struct page *get_dump_page(unsigned long addr)
>   #endif /* CONFIG_ELF_CORE */
> 
>   #ifdef CONFIG_MIGRATION
> +
> +/*
> + * An array of either pages or folios. While we could currently 
> interpret a
> + * list of folios like a list of pages, it would only work as long as
> + * "struct folio" overlays "struct page" -- and it would not allow for
> + * avoiding page_folio() calls.
> + */
> +struct pages_or_folios {
> +    union {
> +        struct page **pages;
> +        struct folio **folios;
> +        void **entries;
> +    };
> +    bool has_folios;
> +    long nr_entries;
> +};
> +
> +static struct folio *pofs_get_folio(struct pages_or_folios *pofs, long i)
> +{
> +    if (pofs->has_folios)
> +        return pofs->folios[i];
> +    return page_folio(pofs->pages[i]);
> +}
> +
> +static void pofs_clear_entry(struct pages_or_folios *pofs, long i)
> +{
> +    pofs->entries[i] = NULL;
> +}
> +
> +static void pofs_unpin(struct pages_or_folios *pofs)
> +{
> +    if (pofs->has_folios)
> +        unpin_folios(pofs->folios, pofs->nr_entries);
> +    else
> +        unpin_user_pages(pofs->pages, pofs->nr_entries);
> +}
> +
>   /*
>    * Returns the number of collected folios. Return value is always >= 0.
>    */
>   static unsigned long collect_longterm_unpinnable_folios(
> -                    struct list_head *movable_folio_list,
> -                    unsigned long nr_folios,
> -                    struct folio **folios)
> +        struct list_head *movable_folio_list,
> +        struct pages_or_folios *pofs)
>   {
>       unsigned long i, collected = 0;
>       struct folio *prev_folio = NULL;
>       bool drain_allow = true;
> 
> -    for (i = 0; i < nr_folios; i++) {
> -        struct folio *folio = folios[i];
> +    for (i = 0; i < pofs->nr_entries; i++) {
> +        struct folio *folio = pofs_get_folio(pofs, i);
> 
>           if (folio == prev_folio)
>               continue;
> @@ -2310,6 +2346,11 @@ static unsigned long 
> collect_longterm_unpinnable_folios(
>               drain_allow = false;
>           }
> 
> +        /*
> +         * TODO: if isolation fails we might already have it in the
> +         * list, if pages of different folios are interleaved
> +         * (e.g., COW). We might want to check all entries in the list.
> +         */
>           if (!folio_isolate_lru(folio))
>               continue;
> 
> @@ -2328,15 +2369,14 @@ static unsigned long 
> collect_longterm_unpinnable_folios(
>    * failure (or partial success).
>    */
>   static int migrate_longterm_unpinnable_folios(
> -                    struct list_head *movable_folio_list,
> -                    unsigned long nr_folios,
> -                    struct folio **folios)
> +        struct list_head *movable_folio_list,
> +        struct pages_or_folios *pofs)
>   {
>       int ret;
>       unsigned long i;
> 
> -    for (i = 0; i < nr_folios; i++) {
> -        struct folio *folio = folios[i];
> +    for (i = 0; i < pofs->nr_entries; i++) {
> +        struct folio *folio = pofs_get_folio(pofs, i);
> 
>           if (folio_is_device_coherent(folio)) {
>               /*
> @@ -2344,7 +2384,7 @@ static int migrate_longterm_unpinnable_folios(
>                * convert the pin on the source folio to a normal
>                * reference.
>                */
> -            folios[i] = NULL;
> +            pofs_clear_entry(pofs, i);
>               folio_get(folio);
>               gup_put_folio(folio, 1, FOLL_PIN);
> 
> @@ -2363,8 +2403,8 @@ static int migrate_longterm_unpinnable_folios(
>            * calling folio_isolate_lru() which takes a reference so the
>            * folio won't be freed if it's migrating.
>            */
> -        unpin_folio(folios[i]);
> -        folios[i] = NULL;
> +        unpin_folio(pofs_get_folio(pofs, i));
> +        pofs_clear_entry(pofs, i);
>       }
> 
>       if (!list_empty(movable_folio_list)) {
> @@ -2387,12 +2427,24 @@ static int migrate_longterm_unpinnable_folios(
>       return -EAGAIN;
> 
>   err:
> -    unpin_folios(folios, nr_folios);
> +    pofs_unpin(pofs);
>       putback_movable_pages(movable_folio_list);
> 
>       return ret;
>   }
> 
> +static long check_and_migrate_movable_pages_or_folios(struct 
> pages_or_folios *pofs)
> +{
> +    LIST_HEAD(movable_folio_list);
> +    unsigned long collected;
> +
> +    collected = collect_longterm_unpinnable_folios(&movable_folio_list, 
> pofs);
> +    if (!collected)
> +        return 0;
> +
> +    return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);
> +}
> +
>   /*
>    * Check whether all folios are *allowed* to be pinned indefinitely 
> (longterm).
>    * Rather confusingly, all folios in the range are required to be 
> pinned via
> @@ -2412,41 +2464,25 @@ static int migrate_longterm_unpinnable_folios(
>   static long check_and_migrate_movable_folios(unsigned long nr_folios,
>                            struct folio **folios)
>   {
> -    unsigned long collected;
> -    LIST_HEAD(movable_folio_list);
> -
> -    collected = collect_longterm_unpinnable_folios(&movable_folio_list,
> -                               nr_folios, folios);
> -    if (!collected)
> -        return 0;
> +    struct pages_or_folios pofs = {
> +        .folios = folios,
> +        .has_folios = true,
> +        .nr_entries = nr_folios,
> +    };
> 
> -    return migrate_longterm_unpinnable_folios(&movable_folio_list,
> -                          nr_folios, folios);
> +    return check_and_migrate_movable_pages_or_folios(&pofs);
>   }
> 
> -/*
> - * This routine just converts all the pages in the @pages array to 
> folios and
> - * calls check_and_migrate_movable_folios() to do the heavy lifting.
> - *
> - * Please see the check_and_migrate_movable_folios() documentation for 
> details.
> - */
> +/* See check_and_migrate_movable_folios(). */
>   static long check_and_migrate_movable_pages(unsigned long nr_pages,
>                           struct page **pages)
>   {
> -    struct folio **folios;
> -    long i, ret;
> +    struct pages_or_folios pofs = {
> +        .pages = pages,
> +        .nr_entries = nr_pages,
> +    };
> 
> -    folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
> -    if (!folios)
> -        return -ENOMEM;
> -
> -    for (i = 0; i < nr_pages; i++)
> -        folios[i] = page_folio(pages[i]);
> -
> -    ret = check_and_migrate_movable_folios(nr_pages, folios);
> -
> -    kfree(folios);
> -    return ret;
> +    return check_and_migrate_movable_pages_or_folios(&pofs);
>   }
>   #else
>   static long check_and_migrate_movable_pages(unsigned long nr_pages,



