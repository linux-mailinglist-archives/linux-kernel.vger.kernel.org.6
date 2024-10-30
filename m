Return-Path: <linux-kernel+bounces-388209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEA99B5C08
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AAA1F21A56
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCDB1D5142;
	Wed, 30 Oct 2024 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HPUUmw5u"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B441D2B05
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730271021; cv=fail; b=HL34nwygU+rS5EycFktMjgShcJnH66/+Ii37AtPPbovnsU3IoqmGWzJvB503HF+cE7Qf3hEw0zkGWLx6kqtdsNd05hAvfeogXGmCp+/THtTjzwBtaRq17zBjhjaELLzQvegEW+Qh6/pljrf0Dp4PmvjiaMr4whRyvskMLVljnxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730271021; c=relaxed/simple;
	bh=zc6TwHVjXOUjBgClPAzL5wNXjo+6SUvoS121fuYSbj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=seNzexZv+rAJx7uTD6/OQsn9LqfWENAlsv/zqwAonhnQPcJGy2FKag33Z2KmixsbrS4hhyBCQcoCO0ua6R5bki4JK3uTYC4BZaBMdLtm6uZCtRSBFrB82eYv7WMF3dWKmdm5ILUUCGxmy6dKlK/zyl9zM0M6GqwGZAWIU+enkA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HPUUmw5u; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUzSdZ568b0RZ7iQwfxxsie5nnsvFlVvWLw4J6PJVV0DfQ7uDX1jlSfB1OeZCNjQWUS8Js8apkAsEr+ZGORQ7qFQqfPOGrHPqBAuW+AHrBIhT+O1TI6OAgedhn7rysx3VsU+AUIF9izPhk9TcqPqVndNTskvm7Lf6DVVdVhDwRkNtmB2AvP/JOHwTGqDQK6ob/3HdS1YyCeGBkfAMGUxpgP8kO7OI0jgUx3gibL0DKtLD8cWQ8EwCViUB9j95YJjqgFyS9vQSP/goxjWWDK9k2IrN8EQrItj3Xu76jXasyT/Dw7CzoSTf94PupdQGqyz1fSdnApW1/bEGqla5333sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNWlwkUFOrhQmNkcvYEY1FeajINK57JJEibOFn38qhA=;
 b=F124C6vYrQC+kLIzP5y0d7i0uhPcyGdSrQmYmEekpKJ+hW3B21PbL5h7Wm96j6Rya/zMma7+rPPUXR18dY2U8CW7Hr70g0xNWhZtQ0ihJM8y2mwftsqhG3A+IypGgUhWYzlUbwq9Iq+fUprloLQeSRdYX57DWF4epWlaJkleotwFjK1Xm1og6ndDN8ceTHjalU1Kuf0LimD772J0RQHQLYJeQc/ocKFm69CYY3+xex4P1aEduiU4TFiOc8fLLks00BDWz9Kej8WXTe9sHxQaQWCS3QiwmpRZrRUTbAiuwRFspU2eVBTPPc7XAjvqVyXcCkaC6MuSYKY3h2015qlUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNWlwkUFOrhQmNkcvYEY1FeajINK57JJEibOFn38qhA=;
 b=HPUUmw5uFDnVrYPPYyiQCMdlVhZ3psyD1Q6nHGAA37kOyCSpkeB3DUPHaNo9OCcD1B17/myzsbt1KKpMQOyaYPb2xNKduSgVhH3MiymTAFAhlaO3an7dDC6wn+lFm1wW7KBGjSpYXNEY3HadV6CDkWmu563/Tk2s1sIcUKJ3wNgIyUzYcIOfDyd+BD72m+6IicKK1CM7gcGgxUf8ihUM+gnjEHE5FMLbt4XFrovGsB30FbNUer7qSdaN/O/FLvYvDnQ/W7rUV+VQH8tL5IimWNKXO+lMJsDV4Y3T6bOdwRcU0tfkiKcSPLZegq6yRUQOsRue2GuUYYZT7mRzJZqX9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) by
 PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 06:50:08 +0000
Received: from DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579]) by DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::1be8:1c01:29ba:579%7]) with mapi id 15.20.8093.023; Wed, 30 Oct 2024
 06:50:08 +0000
Message-ID: <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
Date: Tue, 29 Oct 2024 23:50:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
To: Alistair Popple <apopple@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
 <87r07yp0ng.fsf@nvdebian.thelocal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87r07yp0ng.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To DM8PR12MB5462.namprd12.prod.outlook.com
 (2603:10b6:8:24::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5462:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ed1353-cb61-4fe8-162a-08dcf8af1786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L244aDFUdjM4b2lDVGN5aXdMbncrUm5nRmszWkRkSHc4NDkzWWRjdm9DOUhr?=
 =?utf-8?B?Qk9KUzNNVjN6Z1lnLzEvREdjbGhMZnlWK2h4Zlh3NlZRL1VqMWVxRmZ1bjlv?=
 =?utf-8?B?ckh5OWlGQXZ4WXR0R0tuNkxRcC8zWi9tRGFBaGIxNVh4d243c0hzL3ArcytL?=
 =?utf-8?B?dS80V2xBYzVrdXc2UmlqcjJSMTZlWEZPdGFnbkVPcHNueWt2dVg5c2dkdXRk?=
 =?utf-8?B?MjBmTWtTaERDSldZNC9RVGdTdlgrNjE1Qy9xb01PZVV2NmhicDE2MmxvY2pv?=
 =?utf-8?B?dzN6aW5WeXV2K05rVjBoM0VwV1J2eFhLOFMwWmRmZzY5WDhrbmoxdExQMnZw?=
 =?utf-8?B?TSt0TmxTTmtWbUl5WWZvdE9rZWc5eHd2Qm45eE1XMlJBWlpCTnR6ZnNNelVM?=
 =?utf-8?B?SWxKaHBFUWs1SUFnZU1QSldkOEpXcjZhM3JJU0hJVGxwemIvRjY3eTRjZ2E3?=
 =?utf-8?B?VktJM3dGNyt1R1FVSlZndE9RODRsT3h3NFUrOG00cXhEODdrTmNIWnMvVm50?=
 =?utf-8?B?US90Yk5RMUVqOVZTUnJNdW93WWJqRDFGT0lwR1VodVhHenlXZjJLYkE4dDd2?=
 =?utf-8?B?Z2dZeGRYcWxqcnlvU2FmSUx5Y3Erb1hid3BpcEJ3eFZ0cTEvVjkzeWdLdkww?=
 =?utf-8?B?ZnV3U0hPTXhZemhGQ1FIcUsxdWVlWlkwb1NWQWNQa2wrWEFNYmVCMC9oOVVa?=
 =?utf-8?B?RXZlRlNyWDBsOHR1TmtRYXh6eHlBaHBzbjFMVlJ0TnhOU2xONWVxMER4NEV2?=
 =?utf-8?B?TzJ4Ymt2VmVHWkxZRFU4SFk0UEVkeXlwazBjalRRUWh6LzZ1UUxNMnp5MTg1?=
 =?utf-8?B?bWx1UUEybGdUOWNnSjhML3dNOUdWZWFjM2YrN0NIcjV0Tjk5ZkVzQk9ZNmFP?=
 =?utf-8?B?cFVnWXFoUFBvbnMvS0hzWDhsY3Q0d3oxY0YzTEJrKzlRVFIvaEtoWXgyWER5?=
 =?utf-8?B?YzRwQU1Qby81ZVVjNTBVRWtnQmpYNmM0L2ZORE5Ed0JMUUt4cWVzWFBvM2hB?=
 =?utf-8?B?dGtoS1UzdVhXdTFWS05KbmhWeTlRaXl0a1NHbEVaSmtiemM4Zk1LOUMyK0dE?=
 =?utf-8?B?L2h1Z3dGdDhoS0sxdmhyUnF4YkY4cURHNzdEYlM0QW03NFpVVFhxelJRaDIw?=
 =?utf-8?B?OXpPTzFyajAxWGdtL0VwUWZXSXg1Qk1EVUgzYThuUm00S29rbzZHUnYwRmtq?=
 =?utf-8?B?QjRNcTl2SXhNUDl2aUpmUWpYY0NQWFVLbExHNkJjZ2UwVDRkRmplSnQ1U2Vs?=
 =?utf-8?B?SEtDQWk0TXd2RUpkbnIvdG45ZXVCV25pWGREQUFzbEEwM0tzVjNsblEvbWl3?=
 =?utf-8?B?N1huUG8zaEU5T29FOGRQeXA0REdpdDlsanQ4b3FaelBMcVd3NGVPaEw0RzQ0?=
 =?utf-8?B?NXlJMFVqaGIvVmVjMVRSRksrR3FlbDdSdFB3d3NaME8vTTVvV0pHUUdpTE1W?=
 =?utf-8?B?YmtuNWR3ci9tbFVtV1dtNFF4MVA2MzBIKzBSMllNWW40a0dtU3JLbXYyMjdl?=
 =?utf-8?B?RjVObkhWak42dUtGTUN1eGJ0L1h0QW4zYThCTHg0dFZLclFkWWhscHNUeXE2?=
 =?utf-8?B?clVSc1M3YjkvQWdEaTI1VlgyNXdHSTVTUDdVTjNZV01CaTJ3MWt2SWZ3US8v?=
 =?utf-8?B?U2hWVUtqVDJKakd6ZjhHdEE2em5qK2MzdE1EUk9KWGpNeDlibmVmU2xtK1lN?=
 =?utf-8?B?U1BrK1lQeDBmSEZ5elFxdVNncHRxb2x4cWQrTGtoMzJMR01RSWxnaHg2S2JD?=
 =?utf-8?Q?xajd3rQTHCFDFqKODrnLwdbUGHBCBv7199igXSo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjFTMkZaeEJkR2hScEtyZWs4MjVhL1ZpMGRGeFVQUFcvUUpkQ3d1em03Q3Iz?=
 =?utf-8?B?ZlRic05ud2lVUTNhSzd5ZnlWa3hKbnVNK2xaVnd4czQ4TndIZU8xSmgwRWVw?=
 =?utf-8?B?YUxrSnFFcFcxQWZlMG5QcW81enUzRHl4QjVaSUdBR2VjR3VIdXZJUjdNTHhz?=
 =?utf-8?B?UWRKZFpSdmk1bnUvc1FwTmp0WmJ5K01BdVlaK1BZQVVVY0ZiaGV3dzZsZjJN?=
 =?utf-8?B?MjlhclFxUUh2cEp0WVVTZ1BmbXZlVjM3UDQ3MHFyZGJEM3M1Uy9JWWx6bDJr?=
 =?utf-8?B?dEdBU1o3S3JoQ2wxNWltanA1aHlieEtnTFRmZUp0K2lwR3BRL3RzT0xuNWp1?=
 =?utf-8?B?UUMwTEJyYmRkYzFJWUY4OGNYelAwcjhNaWVJTC9SSUZBUXpXSTBCNlNKWVpz?=
 =?utf-8?B?Q0pjampmN0hCZWJjaGtzZVN1R085LzNNb0pUaXV4eGtDS3BJamhLU3NWN21h?=
 =?utf-8?B?RDBUcSt1aWphbDNORnIvTGJhc2hKaFNURkdXNHU4bFJJOU9vSmF2Q25sZ05n?=
 =?utf-8?B?aU1DMnBNdlVpNkNIRmx3YzNUK1o2N0ZVa05vR1pRR3VMTkU5alcyU1pIUlNG?=
 =?utf-8?B?bWxORnV1TEdwY0JoY0VyR2xLWDhacVJ5b29KVFg5ZzdJTldxdTNTMEF6cEhn?=
 =?utf-8?B?SkExdGV2UytvL0dpcUg1eVFybzRkOXVhc3ExVzA5aytWMzAraEk1WGlaVk1I?=
 =?utf-8?B?WFMrOWtGYjdFbzhwR1B6dU9zZHZ2bWk0eEY1ZFB1b3ViWDJubVhPYmxXUWNS?=
 =?utf-8?B?V01KaE5TenVpN0FIT2NFdHNYTDlWZXpaTlk2dzA3NVNkd1RPcmQ5VnVXWFh4?=
 =?utf-8?B?akMzcU5neWUrNTJrNDBTckE4Y3Q2ZCt3MzZ2RFg2QVcyZjBUQ29GV2lTNW9m?=
 =?utf-8?B?MmljTHVheE1lQWVPSUdWajJUUVZuRkNBTzZsNG5xL1JINGErZWFNZlFWODNK?=
 =?utf-8?B?YTdpZFo0WmZiNmNYVHVSTG1xR1BnU3U3MnFNbC9KTnAzUG1EblJ1ZDZCd0xu?=
 =?utf-8?B?bG5xcldKa0Y2TUVnajdaRVQ2VHBxcjVRNjE0c2dBcVlZdENWdUtPL3p0Tk9P?=
 =?utf-8?B?cVVsdWR4bitvT0lVWC9wR3k4MUFBbXZCMUR4aTArbWp2QkpFUEQ4VkJ3VFYz?=
 =?utf-8?B?UUpHODk4MGFNc3NjNTdrRVBlOW1kMHZkSm1yNXVZcVd5bkFRejdzZFRmdHFy?=
 =?utf-8?B?YzRzRk9hbmZEUGZ2UzJjZFo5Ymx1K3pvcXJ4ZDhHQjdEbW9ZU294RVFtS2xL?=
 =?utf-8?B?ZXB2aXAvc3VmaG9CTG9pT2VBemV6SER3ZkFJYVpVTVZvKy9OWXpUeWc0UnBN?=
 =?utf-8?B?aWxYWkxjVElRSjJFZ0RSNlRrelFwUkc3MUUvR1FSQk5KUUpPNS82Ukw3VnI5?=
 =?utf-8?B?MmhFc1dVbWpONjRhVzVuOW1jRFBMZDZsQW4yQlVwYnRnVE10MkpzK3RtTWkx?=
 =?utf-8?B?bGNxWldVZEYxZFVmMTFsaW5aMGpNWWlTTTFhMm80SVBYM0c5S29UejZmWlVq?=
 =?utf-8?B?dXYzN2xWNEVKWkFIU1UvYUYvSzR5SUIrZmNVcTQ0UTdEQUFOeEJQMTllMHZM?=
 =?utf-8?B?eUp4TmFzSXIybm9lTzJBMGhpaktsYWYwbmowbW1aRDZ2d1o4OUE4QXdWRzVN?=
 =?utf-8?B?MXJ2bmp6M3pCV0tNbkZRM0h1MURKdkZHQTBmU0xEYlN2MndDdzFCYjJiYk41?=
 =?utf-8?B?bEVZa2hPd2ptVm03aWIvcU9yNENITjlER1NQM1ZQWnNqczI4TDdqNHlVM3NI?=
 =?utf-8?B?Y0hBSFRpbkpFQVpwRHVZVU8rbkxpOEpWcjhuNnBPVVhuUWZjUDdwQ2dFekND?=
 =?utf-8?B?anJxcDJ1UmVXMDg4amRzTk85OVhkWGEwL3ErUnVhU1lIWWtkQWUwUjg5S2Ja?=
 =?utf-8?B?QlJKbU04RXUvTVA0eml2WU9paksrNjB5aHgvR1poZUVTbUVVN1NsenlaYnhU?=
 =?utf-8?B?LzUvNXlVRnNURWZkYzl2OUdoZGRFaFNMYVBtSFBjdVRGMGZJaXRndHcrMFFo?=
 =?utf-8?B?SXRzcTBMd0hESTVDNjJ6U2xmUmtMWGpMWkQ5dVB5Ym5aZ041NU1jOXlIck1I?=
 =?utf-8?B?a3NEWHg1TU9DMWsvTzRndVNoN0RIeUdZL1hWT09mK1UzVC9CMjNXRGNYZms1?=
 =?utf-8?B?T0VzNUlvQUY3THVmWmhMRG9aMlk2T1U5dWJwTGUrc3paV3FTeHpiNFlxUVRB?=
 =?utf-8?B?YkE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ed1353-cb61-4fe8-162a-08dcf8af1786
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:50:07.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jc11Et0T4JGKQjuMdsqic9Gkf5UiDL0NQI79c6/dlXSs2fkZaDaS/sPlOUxSIgAze/l9MeyxFEqdCTHEwxOz/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027

On 10/29/24 11:18 PM, Alistair Popple wrote:
> John Hubbard <jhubbard@nvidia.com> writes:
>> On 10/29/24 9:42 PM, Christoph Hellwig wrote:
>>> On Tue, Oct 29, 2024 at 09:39:15PM -0700, John Hubbard wrote:
...
>>> Because pinning down these amounts of memoryt is completely insane.
>>> I don't mind the switch to kvmalloc, but we need to put in an upper
>>> bound of what can be pinned.
>>
>> I'm wondering though, how it is that we decide how much of the user's
>> system we prevent them from using? :)  People with hardware accelerators
>> do not always have page fault capability, and yet these troublesome
>> users insist on stacking their system full of DRAM and then pointing
>> the accelerator to it.
>>
>> How would we choose a value? Memory sizes keep going up...
> 
> The obvious answer is you let users decide. I did have a patch series to
> do that via a cgroup[1]. However I dropped that series mostly because I
> couldn't find any users of such a limit to provide feedback on how they
> would use it or how they wanted it to work.
> 

Trawling through the discussion there, I see that Jason Gunthorpe mentioned:

"Things like VFIO & KVM use cases effectively pin 90% of all system memory"

...which means that we'll be able to get that in-tree call trace that 
Christoph
is asking for, pretty soon. No GPUs required. :)


thanks,
-- 
John Hubbard

> - Alistair
> 
> [1] - https://lore.kernel.org/linux-mm/cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com/
> 


