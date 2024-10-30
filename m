Return-Path: <linux-kernel+bounces-389286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AB69B6AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3261C23E66
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03AA13FEE;
	Wed, 30 Oct 2024 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WQbyw+k2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF861BD9CB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309150; cv=fail; b=iL4mMFLUGEpw4OlisRidgGwx4oGqDakNIOeMGo+fkH/z6/VM176sA4Dguo6iB64OMxVUlKgZiP5ufXXLPNEsZHmy9uYCcqjA8KazGRD8c48tNPRfuJ3jIXncEEpdA9vf2tTtJDKBS/Uw6Q3dP5gjF7vIyyzJwSx3s8RUUbf+uzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309150; c=relaxed/simple;
	bh=EeIpDNqQsqHIjeM+yYsmxTfpD0FBObM6+yYVvOHwUN4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M/aDLjCQfk79kGq4PfUvs17pAIRZelaqKXw3uPzQFhdKcv1LflxSc8Gkec3pzOfWI1hzDX1hlvG4ifO4+VK3gh9dRqx0URr2Est74HkrdH0boLvSmP9gMj8wyaJeP9ECTMrBMJAdTvhPELQa+m7vp9EobvKnIdzPag7YyYnD9go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WQbyw+k2; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx/c9gtPcR75L8D59eWC0X8s1NULmhKw9mrZUFoXMoqySZO9DQ8/dxpezhk+sInDLGPYiT1HBsFylnWkcmlfsqGMTRDM1WG1Dy1vZLfdHsmwP6gsm1zBLP6ZXVGIlMijp86y6/Inmex4bZs3kK77B9E9yIiBRWO1bKK/5w5aUjjnNUrsUgqR2ZxFxBnbFdzuZiuM6GKhUmKTxmT9U0h/jNeczeCaevMdiYs+FOEmZcIHXVkQQHxZ0Qsm4prO9Uin0BA2v3cFhz2l1sJPWQycaCB7OlYMuOTZ/6moGsRB6AV08bgh5oHFpxpeDzIFByq97W+Xjv3UplA8EzY3Sn3+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9pCFfLyTX2idCCyvgz7AxE6fciaOvQ6okTz+4+mAJI=;
 b=PXpnxouuZgyEZ55MHspra3waAllzX3l8L9Ca1eVcvT+2c9yy0+rLHGe7D3OgV/wB4RP1DnEA2M9le3lfNx5o4y9XTUMLbgYLNcHVnyma6zUhK6uwRE79jrpcROJ3ZIRHjh9xG3Gi+MCYYQM2XY9nmA1rBMnOfmfMrs+hEYXUa8gKdnwbT2VvJm1IBFISIhE/EPEjROVC/l8jZs89ul6VLKvxcQqLxq2PXy5Y7vcOmt3Q7pLID7n7PuQTNgxGtWKLWu/7IZk8KOzyxvR/4w7KS29dX+Kjip81meViz1L8icKaQAU75hSKGjAi6oYvzoh6eo6dLGyKfbDvGCsM/mL5jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9pCFfLyTX2idCCyvgz7AxE6fciaOvQ6okTz+4+mAJI=;
 b=WQbyw+k2ZMAHsG/M0R7E9MFMMrFfxEX8j6m7eBSjD2batuel1tVlgzCMZNkrrW/HVUIpX0LwTRD6nvW6+Dzz0XwV5avx2rLRibaliTZmxBGM6OaPHUYJ+ylvg9kOxp9hnYUY3/eq/GqmdR0xGb3IIFxS3dscCBcqICseLc+AtsuGhKC7yDfNXiqNnvfKsz+bZZnC5hCMYnvDsJHSD8s7MTXMe4H9hfJ27vw/d1w79zOUUHweaft3W1u9B76sSnmxo+TzrVzRNtDnaEqKhlDnlpVw11V5dT3WMbXH0D2vzvJ0R+eXtJRPd3woYPDP2c16yaxysliCFbhtkOxFEJiyLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 17:25:44 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 17:25:44 +0000
Message-ID: <6da2d821-8efa-42da-af96-232d97cb40d8@nvidia.com>
Date: Wed, 30 Oct 2024 10:25:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: Jason Gunthorpe <jgg@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: Alistair Popple <apopple@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
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
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
 <87r07yp0ng.fsf@nvdebian.thelocal>
 <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
 <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
 <20241030120453.GC6956@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20241030120453.GC6956@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b8e242-e177-4759-ded1-08dcf907e2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0J2dG5oMFEzeEMrdDE3M2N0bTk3RHZ4VlJ1cUF5WXdmSEpYeXBVWDlOakFT?=
 =?utf-8?B?YitOT25FaW5lMEhvVkhDd0tYUzBEcGRzaDI4VHNQbS9vOUY5QTVHQU0vQjFK?=
 =?utf-8?B?QUlBOUc2K013YmovOFUwL2VSSERNcWQ5WVN2TjZ6bTNwUTBxbVFUQU1kU0N0?=
 =?utf-8?B?YmhDT2kxZ0RaRnNDUVJVVG81VDlydXU1bG1yVll5SW1XRTF2MVNjK2cyTGxT?=
 =?utf-8?B?Q2xqUGwxT25kUExDbGdvMTVYUGFvLzRxd2RlQ3c3M0ZycjIrTG10WDBUMTF6?=
 =?utf-8?B?YkZkRElrUGRkTFI3Mk1KQlA4WE1xek5qYXdsWlovNGorOFNtK2dTdHdyV05u?=
 =?utf-8?B?czIxdWpsUE1MQ0ppcFR5bkl4OWova1d6WHZFOW1TKzRpN2t1akU2cFhVN1V3?=
 =?utf-8?B?SUVnRDJXUnFFaDJIbXYyay9JRWg0MDl0UnZPeFlBaHhKOTdpaVJ2SVFIRml4?=
 =?utf-8?B?K3ljZHMwTHdBNE1ya3hWKzVpUGFMLy9td2YvV2kxVlVVR003NXdoNnRheVRM?=
 =?utf-8?B?aTU2REl4VVRjalZlTlZRZ2RpbWEwL2Z1QlluMHJEbWVLcWQzYWVzRXJ4M1Qv?=
 =?utf-8?B?VjZaZDU3UjA0NFBJTlp5QmtQR2gyTURGSWIrTFIyV1pzOFd2cjZRVkhZUkdj?=
 =?utf-8?B?N2V0NDRxUnRTR3BaRWtOYmErUnlNUGt1cGZKOS8xWDhEY3BwY2dvYzZRR21Q?=
 =?utf-8?B?MEhQeG9YYXlWWmJQM3pQZ1BjeXYyajB1UG5yNWFOeW1aTDdMd0ZITkZCa1Vq?=
 =?utf-8?B?TThaVEIzSjRTT2NBK2owSVBCcFRyUXFhR3ZTbjhmK2R2dGN3d1YyWU13NjJG?=
 =?utf-8?B?blpaZWdaUGdRNmxFWEI3dXNSN2M5MGhFSXNzWUZyYnZqdGo1eExWbkhHTTcw?=
 =?utf-8?B?UjR6ZWFDYWwwSHB5cHNKSFlwK3BJVmpVNGxYVEc1Qjh0UldYVlNjWlJzdVpO?=
 =?utf-8?B?RWM5Yk1TakRMVUo2ejl5eXBMSTNHYjM1R29Yb1Z5OERkK1RNK1I1YjdJcnk2?=
 =?utf-8?B?bG41NW9HYTBDQWV2ZitpRmxmdEVkYWdzT1l0a0VvNittY0IwSzFKR240L0ty?=
 =?utf-8?B?YUdReDhSSnFuUEtlUHZ4cVIvbXB6VzgxTW5qZml5WjFwZEVuRHBXdmhJMm5D?=
 =?utf-8?B?dW45SFN0VGdTOE1CanhRZnN5bzVPa0VuNUVEbzBmSGZHTktXWjNMd0JEZmZK?=
 =?utf-8?B?SXpXeW50SUF4VDh1U3JPMUJDNkU2N0NNbS9vTEp4QW5FNDJLcEZLaitabjhV?=
 =?utf-8?B?cUI3c042dSt2aStpdWtwclpvaDgzUUNqSDZlU2dYNUI4U1A4MWlYeGcyaFVM?=
 =?utf-8?B?REROb1VEY0c0VWtJNVF5OWgvb0lUYmw4ZHE2YTJCWkVTQ0FYT0FqSDE3bFFq?=
 =?utf-8?B?QU85ekxKTVpQTEhPZ2RTVTJOLzdrMEpLL2hkcmhCckNFd0VuU2xUejR2dlpT?=
 =?utf-8?B?OG1NVFM2WExxU3ZsTzhwaEcvNURyc2ZtTWZyRFlRM0pUc1pLQTJTQzFoQlgx?=
 =?utf-8?B?MWh0MEdHbzdwYU95dVlHMko5Y0E0ckp6ZjQxQ3BJUEk4cjM5RER3TGFBQWZI?=
 =?utf-8?B?ZFRpRnVPalFCREV1dlBIMWtMaGtraTdDZEFOd1JQQlI0NThkT0FZa1BORGFa?=
 =?utf-8?B?QjBEb3VBUExMQUViZmdtZlhGWExMcnFMNS9ldzZuSzV6dXoybkU4d3pjMmZm?=
 =?utf-8?B?ZU12QTRxNWQ4Q1ZwQ0hMS0lsSjlCSE1RTXU5dHlKSUVJcEo5dXllN2hvK08y?=
 =?utf-8?Q?eOqsRws5/9D9toIdrDrugjI/dV3DiZ6T0MhVZmS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGRFSk5zWXJqQ0UxSkFzKzdOaHNwWFR2elRITGozN09pZTNmbGVtdmhkSjBK?=
 =?utf-8?B?OVo0ZlJoWFZncVltcjhQaHVsSFJFbnNSTXBvQU0zQmkvUmQ3ZDdObnprbG9B?=
 =?utf-8?B?K09SV0JiSHlCSUh1N2lqUUR4TEFnZHhFamZPYmUxNHhwcTIrWG82eDAzSllx?=
 =?utf-8?B?T1dRNHh2a2NaMXpjYXhjMjlxdFo4VDBvc2tmOEdYUERFWE9XN0kxQWZQM3Ev?=
 =?utf-8?B?YUJHNnRZZ2h1K3hWS09OdDBxSVB3ZEs5cUZZV282OUZIYmNWYVQwV01yQ2ZH?=
 =?utf-8?B?UzI1b1V4N0RXSGNZUXR4Z2NhbjEvRTZ4SCtiK0FrcFhMeVZrZ2dqZUtmbEF3?=
 =?utf-8?B?T2pVcFFTcHB2ZHZsM2kvOWNGWVRuV0lFRDdCZWU0TUNtcTFuRGk1ZUhkTFRO?=
 =?utf-8?B?eU9EeHBQTmJlRkFvRXU4dEg0d0pZTWdRK1FIVUppcTJTaFQ0M1lxYkFjYzNN?=
 =?utf-8?B?UGRla21aOXJBL0RnTCthMVZOWCtTcWJnRzJKY2lXVzhYK3ExUlNCWVlXV0Ez?=
 =?utf-8?B?aGZIOGV3NzNiTFI2NVNnRmlxS2Rzem9QY3NZV21WUlQrZHhTa2ZMMTJQSVlO?=
 =?utf-8?B?WEJTcDZNVWZHSWd1Y0xYWFNiTXJ6TERpaFMzaXF5MEdSWGZ5Qkx6dEROZFpy?=
 =?utf-8?B?djdPcnFOOXIyWUFML3FkekFpbzcrRVpRYStNK2Uycm1iOWVSbjRsZENGTUY2?=
 =?utf-8?B?akRHa3VCZ2VpQit1M0l3dXc2YVBtU0pJSllQdWVrSnV1alRPUkJuVFVLUGRj?=
 =?utf-8?B?amdUOFVucFRTS2tpWXNUeURmOE12V1F5dFpuaDc4aDRkUkc0QlYyTzZCTytS?=
 =?utf-8?B?S3dYVm5HZzd2VzhRa3dVNUF4OHh3eEpGemtEaERuYldlNS83V0d4KzY2cnVq?=
 =?utf-8?B?bmpHdG12Nno3Z01HTUQvcS9GU3I3UXc0U042NFU5VDhlZWNWdFlQMkZEU05M?=
 =?utf-8?B?UXZQNk1DeXNlS3lKYWdDc3FHNVQyTEkzV0Z0SldocW14dk1JSndJT2srWldp?=
 =?utf-8?B?dGVKRG1HSURPZExkV29NeGplK3BXQ1BPaHFOS0l6cmlQYTZ4V2F6cFJOYkda?=
 =?utf-8?B?aUxDTjZUWDA5TXZqSnZnZldVS3k1aW5GL2R3eGk1NEx0alFvT2lhWVphMDJX?=
 =?utf-8?B?SU1OZi93UXJoZ2F2N2xzcGswalYvYk1GdkhRV1VyODl6WnpLWFBlQkJoVjBh?=
 =?utf-8?B?dEgyVVFXN2hGcWtKNG1QcFlZcjVWdURETHlob2FscmV4bXdSLzJyN0oxRTNo?=
 =?utf-8?B?MkFrWkRwUHpJbElXVnVFTTV6ZDVaMEhsTy9lV01BdTkzT1o5R1dvRkFtN3Zm?=
 =?utf-8?B?bGxtWnBHZHlUQmtkQ2ppc3RuMWlxOHgzVEcyWGx3TFVNUGd4UFNuTWcwY2I1?=
 =?utf-8?B?UEJpa3VUN0p5NzU3cWY1Qk43Sm9Fc0s4bysrQmJXSHZ6UWt2dSswUXUya1FL?=
 =?utf-8?B?OXoxNWlXQWhIUCs0aGVTdG1ZNVR4UWptK0Q1TE9xaTlwak1EbUo1UndkMC9M?=
 =?utf-8?B?WGVzUTIzcXFDTDhPM2gxTno4Y0ZtUzBXMGhhVEN5Q2VUVlJ6RkMzdXlnTG5m?=
 =?utf-8?B?R3c1cnpMY2ZUUE1wY21VS2d1dUtqb0dlR1E1d2tDejlqNmN4ZmNmSDg3WS9Y?=
 =?utf-8?B?M2N4QWZNTis4RS9CY3Q4RkgrZE80VkRFYzlZY2lLVFNaQlhTMnBiK1dPRXlr?=
 =?utf-8?B?TTA2MGwyRVAwaTZld3piUDd0QXB3UGtpSnlrV25xOHNNQW5HZTl3Mm83clJL?=
 =?utf-8?B?SHd5b0h2SXBncXR1RGlOM1dCNVJIRDQxK3U5a1hVN0J4V1hzUzZNUDIwT1Mr?=
 =?utf-8?B?bDZMYzBUaVVvNmozWGdyOHZ5WDRSUWFVZEdDUk1rSlNqTFhWTnRHcFdIQzlG?=
 =?utf-8?B?VCtFRU1SSzZmVDlkaElpdWdaMUpBTHh5SWw4dk8xakFtVEhsQTczS1J2RU1S?=
 =?utf-8?B?RWh5cUNtY2p6WjRMYXRtUkcybXZNUFpFSlA1NU1FT1phVlpKeXcrSEdhcTBF?=
 =?utf-8?B?VW5SQ0hNZXcxRHhJOGVWWFMzeXduZjVWZVdiaXNoNXVYZEdVNjJOYzBSekJr?=
 =?utf-8?B?YlB6NXJPa3F3RE5UMWttOUlCZjBSUDZWckZ2SUkyZWZCZUFjRGZDMC9aK1BW?=
 =?utf-8?B?RnBIMnJzT1hpS1QwQ0laTnFDQnVhZytTc2ZzaFVSaTJpcVFCcUlKTTNYckFr?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b8e242-e177-4759-ded1-08dcf907e2ea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 17:25:44.8042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qi4k1PiPgIHoLaUm1muT8Szbk1W1YxcFSj3AgQrL9eRa8xwR6SgKX0CjINTDAr1HrbjhouG3vOnyqEJ5lvDIRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

On 10/30/24 5:04 AM, Jason Gunthorpe wrote:
> On Wed, Oct 30, 2024 at 09:34:51AM +0100, David Hildenbrand wrote:
> 
>> The unusual thing is not the amount of system memory we are pinning but *how
>> many* pages we try pinning in the single call.
>>
>> If you stare at vfio_pin_pages_remote, we seem to be batching it.
>>
>> long req_pages = min_t(long, npage, batch->capacity);
>>
>> Which is
>>
>> #define VFIO_BATCH_MAX_CAPACITY (PAGE_SIZE / sizeof(struct page *))
>>
>> So you can fix this in your driver ;)
> 
> Yeah, everything batches that I'm aware of. RDMA also uses a 4k batch
> size, and iommufd uses 64k.
> 
> Jason

Yes. It's a surprise, but the driver can do that.


thanks,
-- 
John Hubbard


