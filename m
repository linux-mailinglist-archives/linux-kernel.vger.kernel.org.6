Return-Path: <linux-kernel+bounces-248614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B04D92DFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0AF1F237C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607D48249A;
	Thu, 11 Jul 2024 05:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kvxs26Pr"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F636BB33
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676615; cv=fail; b=SNSpUWtcIr2uKG581kxzmlt+QLp+wEbZk6DvHApH+d30u5gIl/PR6vpRDQT5ApGkkRWWIOHCvNRoHTB8d1LrqM5OpXFbCkLPfC/wrUKmxJMnVouvaWOnbaupS/LUmF9XV3pvP2BccvGz8vGxLHvv4UYhJpMCPJAebb8JErzwWgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676615; c=relaxed/simple;
	bh=DaAdkJaNoRS3olcP+w4TJuLHYQyVeFvqWx6Bp085/kQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kkaH600iHYBZg/3smkcSeDO/gOGsPXo/757wom98OvoCtMdb3mWW4D2Ugg7DP91YxBBabXtduzxm0xe/xRf9vYg0ITFe9gldyc6GYttgqxIyPuMs0mhGA5N82M4lvb0oeIDCc/WmdDF34thZTNzoKk3H9cbuE7VKvvndWUCN6G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kvxs26Pr; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7Am6TVY6cBQK0RANvn3JBuwhht2Szp6DPaNQ2i3CN2GVkm1+J0PxRJ2k4zPioADIDcRu5ftAAdef9mOgcJYTQxoyydM2p4RC2MtkIhSYW2Xqc7HyY1xfizygO0bRGK2AvsVXNtYnt5t9vgayM4zGrBL3DKE4uCAIhMwFO3pijl5r51WnhJS+GzG7XxmHeipQliFhQ5RiU7XA8hBeylDbtfeFcPg6ZPVAA2H3M+zcY/sDuzJ05iuSmYm78F0SNcXnvCnLI6UKvl9ot95XnIUEG9EnPzrtQt39gQOy9U/qBJ4zsRWt3u9+kAsX8REk5Wi1Wy6EEMTPAphwh/ku+g04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVGu/uzih6546yMDrtugJxC9+QIYk0fffVYF/Fu5Ips=;
 b=LCBZqzDVXQco35SUac1liy6s9xu/4iSG+WwabAbils06Kq+NPau+v3c0zUDoY1VC7HrU9lev+wjR4QJfYiwx9eAJrYMg+AGmOaXvWWrwdh004mE428n7oCTEWvPywRrgnpIc8/IY5uW/ZunL+t6V7sSJZw9X782iUT0BErbbDkD1Vj879Z+xJDdSLbGclrHWGTN4oz/NHnCmwHXheWx46UwRENmd7X8OL2S2zpKtsa4uSCaehNmoFFRAMZmckr9p4lhBktfvEWqLK2LFuyybG9KpSgG+gY7m78Hyt7Jw2ae4mtC7wbmGGo12YlU0wzjxhYyHleNPKWI2oVb/rR8ijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVGu/uzih6546yMDrtugJxC9+QIYk0fffVYF/Fu5Ips=;
 b=Kvxs26Prv1v16CRqsJ5n4WNHJcKGYZs9RoHmO1kDf+2qH2zy9qmHSBD3hKyvvzuEXDhm1nyhVyYBsrSF3iA5nh/4TyKrJpZGs31DZUJPac3+WYw0DLMYDi/hqA8HR0HsW4/IX5Ey1a4x+tbaB2gy9VCkQXBjfbVyxSkzx/TUM0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Thu, 11 Jul
 2024 05:43:28 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 05:43:27 +0000
Message-ID: <b68e43d4-91f2-4481-80a9-d166c0a43584@amd.com>
Date: Thu, 11 Jul 2024 11:13:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz,
 kinseyho@google.com, Mel Gorman <mgorman@suse.de>
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com>
 <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
 <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com>
 <CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 8100076b-c3a0-4e6a-6fe7-08dca16c6357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXlwYnJxZ2U5WEJvZXhkbklIWjFXVENaR3IwTWszWjBmZUF0azFObmRTelFz?=
 =?utf-8?B?UDdTQ1lsRllKdUdlYTU0UksrUXpxNnYrWDdMNWpZMW03c1F0cVg4WVpTMDlx?=
 =?utf-8?B?a285WEpiWXNRVW91NElrdis2amNJWXNxTEtoWnpmVjRoVWQ3aWJ4NGRWUUMx?=
 =?utf-8?B?ZmlRU2Z6ZTQ2ZFFTM09YdVpVSnk4NlZnOWU2UXNjejVSekY0MElIOHJvTm05?=
 =?utf-8?B?N2hDTHp2SWdVS3NnZ3p1SDA4eUVVQ3VaczNOYjJaSTBrMTdrVnJSRHMzZmMr?=
 =?utf-8?B?NEE4M0N2L0pXTG1yZXBEdXUzZXNxVVY1MVJtdG0vK1kycExoMENNTUcyQVd0?=
 =?utf-8?B?UndEdWk5QnNNN3FRSWUyNVJwTGhMTUpCcDF1ZFQzMnlVZVB4K0RzYkkxNmJM?=
 =?utf-8?B?cHVVNnZIVVJTaWhzNS9aRXFYUFdrb0pFbU5jZk43eEZNN3k2QWFHL1JxcHJa?=
 =?utf-8?B?NHdmVk0waFY0K0NWNEtoVlV6R2dOaHNEcGhlSlhURDZlZTUrL2hzRUNkNitq?=
 =?utf-8?B?cVJrU05rNnhNNS9nSTRtcUMzNThCSkhkUk8wWWorWHNzU0U4QW12Mys1OHl4?=
 =?utf-8?B?Lzc4WUdEanVUVFRheHIwWGNDY3VlNzFaR3REK0RUK1J0Y0JiVzZPV29QQWRS?=
 =?utf-8?B?SHpCdUE4Y0FZTlFERmllU2hSQllCeFliT21wc2NJOU0wczZKMlk5QVdIWTZQ?=
 =?utf-8?B?N295cnp6TjFaVTZSTU0xWGZmMno4OW03R1Q4QTJnV3R4YVF5VFJTdzk5RWY1?=
 =?utf-8?B?ekphN0cvRTNGVHh5bFhtWHJ0bkZPRVliQmhXa2cyZHc4QkVKQXNXa2J2emRZ?=
 =?utf-8?B?MStuZlhwb05jbTQ1NG52ZkoxZk1BUXRzSXFseWF6enpseEhqZnZrU3BCL2VH?=
 =?utf-8?B?dEdyM3VNWlhiQXhpRFBDdzFGL01Ncit2T1VuVFR1WWtFKzd2MXVNTlczWSs1?=
 =?utf-8?B?RzV0TGZLSGxqeFJWSFpCdWh0czRmanVwQ1NsZTFNdzBZejVCL3hUcFZ1aThj?=
 =?utf-8?B?Qzg5QzZsdkVWRzZPaEx3Mms5Mi9jeStmeWZ5ZE44ZUdnMjlYMVp5WmdjWUVO?=
 =?utf-8?B?Q0tldE05SWlqcUZFWTFpZWpJSGVuRXdtVWE5NUMyTEc1R0E5a1VNYm1tUlFl?=
 =?utf-8?B?alNGOXo5UnNYMXRZbW1MNnZzLy9VQThBUzF3NDNRMkdtaEh4MFJCdEI4clBW?=
 =?utf-8?B?dGpza3J5WW9iQ0tIQUlZU0k4UTNDUnlYNDc0Q1ZwZWU5OEZXQk5nSzN3UCtM?=
 =?utf-8?B?SXYxQmFEbkhmZlpLTmxHOFdkS2pwMGdwQjY5Tk10Q3FyamFheGZuN3dTS0Iy?=
 =?utf-8?B?dHFGc1FKRjdEUFVNcWlPRXlLTlkyL0lTV09NaExJdjlpVnFzcklKRW41dGdQ?=
 =?utf-8?B?bC9ReUlEZDRCTXU2LzNmMlZsenBlczAyaHY5SHlZc3BZT0JYWkxwQytTVmc3?=
 =?utf-8?B?SlQ4ODJ6N2RrUlhMTDNDRkNEVExkRVZzaVN3YXZicnUwTnFCb240cFRIOTBE?=
 =?utf-8?B?TEw3Y1N4d1FkM0dSRFM3QldjWDl1REpQbDlBUkdFN1Q5bnU5MzJGeHAzYmJJ?=
 =?utf-8?B?cGVFQURCN0tac05JbEU4N1VPVmRpZnd1TjF1UWVnVkdJMnhjOGh6K2pxVnFo?=
 =?utf-8?B?d3hqY0FrVWVuY05xM1diaDRJbk5rT0tBdkN0eDUvZGJ0WHFoUnhOQ1FZdzJa?=
 =?utf-8?B?Z3VHREQ2TitwNmtGTUI0QzhHb0tCdTFPbFlzUjdIeklVUENGV0tQSkVlaURi?=
 =?utf-8?B?Q0JJUy9KaWJBcUNJT2hGTXhOakxGakwvbzNoRjgxY2VQeEpXRmhNWmZBWVI2?=
 =?utf-8?B?cUJtOWJIQ2llVG1iQjlUUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG5XOFJSUzZoU1pBUWowVG8zZWprZEJIa0tRMUQ3Wk41czZqaTgyNzcrMThI?=
 =?utf-8?B?UGJpbGZSb21wM2lUS2lOVHdlYTNRbmtvczUxV1VLYmI4NDloSTYvcHo2bnZa?=
 =?utf-8?B?SlhVbVZQZ2x3K1JLa0UrTGcyckI4Z1V4c3p5VThDL0QxUkh6dzRqS29HWDc5?=
 =?utf-8?B?aFEvdGRsQmdsaHdVNm95aE1mWFE0d284R1Z1SHRKTTNDay9jNzNma3FpTmEz?=
 =?utf-8?B?NURsb093dCs4YnRXMStCMWhUc3VlNGo1STY1dDNiRlRmSDNHMFdwcWhYRThw?=
 =?utf-8?B?ZUY2WWRHeVMrZVF3TG5Fa05QdHVTbnJMSlk3N3l2R3pjc0V5YW9RWlpodFVv?=
 =?utf-8?B?YzQ1Yy95WmM5Vk1tWE5Fc0UxQndyUGdFOEYyeGlNVnhVdXN6ZUFkRFBFZktk?=
 =?utf-8?B?NDBsb0I3RllJc1BSYXkyUFdhMDJJQkRuNk4xcDJhdjVjcUhjV1kwU1pCM0Rv?=
 =?utf-8?B?WnRIazFISW90VUhWZHVCOFdRT3o1amJOcDRHTUMxbTRRZ2xOOUo1ZkF3Rldk?=
 =?utf-8?B?L0FQVHRXV3VpVmhlY2RncW1vbVQzcjZRM2liSmZEQ1pKUCswbnM4eml4MG9F?=
 =?utf-8?B?MXg4LzZWdHg3dDlCSXB4V1JzZzZsKzNhUHM3V3NUVmp4U09iYXhRWGFOZmlj?=
 =?utf-8?B?cnY5amVjcithWUNnbXZ2NUdGUVd4dURHc2tVTm5DR0pJT29hcTRGU0phbkFG?=
 =?utf-8?B?WjgxSjc1NFROQi9BV0lDcDUrVGpPd2hzcWRnclpWa0UzaDRadHJCd1o5djlr?=
 =?utf-8?B?amh2eWhFVGI2OUZKZURkaGxkMmFIdGZRQ0hsR1ZraEx5dWt0d2hkaXJRZndO?=
 =?utf-8?B?c2pOSERRRm9mYkwvZm9DUnl4bWQ4aDNKZlJHbExYaU9CQVdPVmU3bXdnbFpm?=
 =?utf-8?B?NVdlYm40QmhhSjVTTUpZeUtqMU0xaHQvb3NmY0IzdlBJTXlTdFNsaUpDQk9O?=
 =?utf-8?B?T0pscVZnek5GcUdJRUdBOHNaaWpFR0NCRUd5OFVCNnVSVDNTenZrQkZTSDdW?=
 =?utf-8?B?eGoyTCt3bm9tZGFPMmRqVEp4MEI0elphc0JJcVpScEVaemdEWVo2QkxGLzBh?=
 =?utf-8?B?eGF2cFd1MENyZ1BjUVNzYmxCbWx6MDRyOUpmUU4xd0JYNGd2RzUwOVVib2V3?=
 =?utf-8?B?Vzk1NFV5WGlTYmtSZFNONmd1TjNSdkRCbTIwcDB0a00vVjNyZGNrWmVUTWs5?=
 =?utf-8?B?Q281UEllNEJOWEl1Nlh3Zk5NSFVEeEVGUDIxUmxCT0MrMWRQSkIwS3Z6eGFa?=
 =?utf-8?B?a2wwc3pzcmx0MjIyRUJjdjB4eWQyeDBTSko2eDEyV1JMVzVOMzBWS3pWRGpw?=
 =?utf-8?B?TXNSYzdoQ2tHbWMzbmNKZFk3TGFBWlVxNU10Uk51VXlvbTdidkxQWWptakoy?=
 =?utf-8?B?bnR5UTJ5S0RFN1FLZEEzRXpJV25LSTlUa2FibHY1MW4wQ2NvRC82QkMyOE14?=
 =?utf-8?B?Z0R6RWV6ZnZPTjNPcnZTa0t5YnFQcVkvdm9Ua3BDTGpteW1RZ0RLNXBLTTM2?=
 =?utf-8?B?OVlzV3JKZVh3UGcxemYrYW9lTC8wVWc1akphR2lSQWE4amZCaE9adVlXME1u?=
 =?utf-8?B?STNNTDg0NkdrdEhpVWhIUkhUM21reXRoSFVVMks5T1VUNjE3Q0UxTHRlN3BC?=
 =?utf-8?B?dENIRi93U2JYeVJicTIrTXUvUFVEeU1uajNLRVlaSnl0K1pLN3ZpTW9qM2NS?=
 =?utf-8?B?RVN2NmpBV3V1d2Jkd1F2bzhoeVhMbHJaenNWUFRTeElHNlZwWDBFdUlmNmM1?=
 =?utf-8?B?OG1rWlUzWUxuVVNFeHdKRDU0eW01VHk4U0NDak0rS2Y5M3B3cGVQSTQxV2RQ?=
 =?utf-8?B?NjZqQ0E1WDlqNXljYmF5Wk1HRGtVRVgrSmpkSEhuODJqQ2hObEEzV21VMlVX?=
 =?utf-8?B?RFNJc25NY3pNcjNvVVVkZ040U0tzbkJjWVZKVmRqVlQ4VGxEZkNVd3M1N2dM?=
 =?utf-8?B?T2lCd25vVDh5aGwzUnVONUsvdUkwbzc4bk5HSFlGREhPQkp5OGR4WnFOZE5L?=
 =?utf-8?B?ZVFHMGpTUXYvcnAyUzhjSlNZZUtFMGMxVU42NEk5aUo1bS9KNzEzZHdzWjlz?=
 =?utf-8?B?MXV1R0RMS0w0bnlQZjBDQ0JjQTkrWVR4RFRyaElGYzZmN3FkeExtdHc5YkRC?=
 =?utf-8?Q?9IotjcjOfKOv3McXh7eN3fGrq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8100076b-c3a0-4e6a-6fe7-08dca16c6357
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 05:43:27.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAXwzchiotCsV4ILcgJHpBsrhVpJbsb82k25uBITnD4N1H14m8n9Me9uRpak0rYaPwp4zo1G4CejrLJFjAz0Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322

On 09-Jul-24 11:28 AM, Yu Zhao wrote:
> On Mon, Jul 8, 2024 at 10:31 PM Bharata B Rao <bharata@amd.com> wrote:
>>
>> On 08-Jul-24 9:47 PM, Yu Zhao wrote:
>>> On Mon, Jul 8, 2024 at 8:34 AM Bharata B Rao <bharata@amd.com> wrote:
>>>>
>>>> Hi Yu Zhao,
>>>>
>>>> Thanks for your patches. See below...
>>>>
>>>> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
>>>>> Hi Bharata,
>>>>>
>>>>> On Wed, Jul 3, 2024 at 9:11 AM Bharata B Rao <bharata@amd.com> wrote:
>>>>>>
>>>> <snip>
>>>>>>
>>>>>> Some experiments tried
>>>>>> ======================
>>>>>> 1) When MGLRU was enabled many soft lockups were observed, no hard
>>>>>> lockups were seen for 48 hours run. Below is once such soft lockup.
>>>>>
>>>>> This is not really an MGLRU issue -- can you please try one of the
>>>>> attached patches? It (truncate.patch) should help with or without
>>>>> MGLRU.
>>>>
>>>> With truncate.patch and default LRU scheme, a few hard lockups are seen.
>>>
>>> Thanks.
>>>
>>> In your original report, you said:
>>>
>>>     Most of the times the two contended locks are lruvec and
>>>     inode->i_lock spinlocks.
>>>     ...
>>>     Often times, the perf output at the time of the problem shows
>>>     heavy contention on lruvec spin lock. Similar contention is
>>>     also observed with inode i_lock (in clear_shadow_entry path)
>>>
>>> Based on this new report, does it mean the i_lock is not as contended,
>>> for the same path (truncation) you tested? If so, I'll post
>>> truncate.patch and add reported-by and tested-by you, unless you have
>>> objections.
>>
>> truncate.patch has been tested on two systems with default LRU scheme
>> and the lockup due to inode->i_lock hasn't been seen yet after 24 hours run.
> 
> Thanks.
> 
>>>
>>> The two paths below were contended on the LRU lock, but they already
>>> batch their operations. So I don't know what else we can do surgically
>>> to improve them.
>>
>> What has been seen with this workload is that the lruvec spinlock is
>> held for a long time from shrink_[active/inactive]_list path. In this
>> path, there is a case in isolate_lru_folios() where scanning of LRU
>> lists can become unbounded. To isolate a page from ZONE_DMA, sometimes
>> scanning/skipping of more than 150 million folios were seen. There is
>> already a comment in there which explains why nr_skipped shouldn't be
>> counted, but is there any possibility of re-looking at this condition?
> 
> For this specific case, probably this can help:
> 
> @@ -1659,8 +1659,15 @@ static unsigned long
> isolate_lru_folios(unsigned long nr_to_scan,
>                  if (folio_zonenum(folio) > sc->reclaim_idx ||
>                                  skip_cma(folio, sc)) {
>                          nr_skipped[folio_zonenum(folio)] += nr_pages;
> -                       move_to = &folios_skipped;
> -                       goto move;
> +                       list_move(&folio->lru, &folios_skipped);
> +                       if (spin_is_contended(&lruvec->lru_lock)) {
> +                               if (!list_empty(dst))
> +                                       break;
> +                               spin_unlock_irq(&lruvec->lru_lock);
> +                               cond_resched();
> +                               spin_lock_irq(&lruvec->lru_lock);
> +                       }
> +                       continue;
>                  }

Thanks, this helped. With this fix, the test ran for 24hrs without any 
lockups attributable to lruvec spinlock. As noted in this thread, 
earlier isolate_lru_folios() used to scan millions of folios and spend a 
lot of time with spinlock held but after this fix, such a scenario is no 
longer seen.

However the contention seems to have shifted to other areas and these 
are the two MM related soft and hard lockups that were observed during 
this run:

Soft lockup
===========
watchdog: BUG: soft lockup - CPU#425 stuck for 12s!
CPU: 425 PID: 145707 Comm: fio Kdump: loaded Tainted: G        W 
  6.10.0-rc3-trkwtrs_trnct_nvme_lruvecresched #21
RIP: 0010:handle_softirqs+0x70/0x2f0

   __rmqueue_pcplist+0x4ce/0x9a0
   get_page_from_freelist+0x2e1/0x1650
   __alloc_pages_noprof+0x1b4/0x12c0
   alloc_pages_mpol_noprof+0xdd/0x200
   folio_alloc_noprof+0x67/0xe0

Hard lockup
===========
watchdog: Watchdog detected hard LOCKUP on cpu 296
CPU: 296 PID: 150155 Comm: fio Kdump: loaded Tainted: G        W    L 
  6.10.0-rc3-trkwtrs_trnct_nvme_lruvecresched #21
RIP: 0010:native_queued_spin_lock_slowpath+0x347/0x430

  Call Trace:
   <NMI>
   ? watchdog_hardlockup_check+0x1a2/0x370
   ? watchdog_overflow_callback+0x6d/0x80
<SNIP>
  native_queued_spin_lock_slowpath+0x347/0x430
   </NMI>
   <IRQ>
   _raw_spin_lock_irqsave+0x46/0x60
   free_unref_page+0x19f/0x540
   ? __slab_free+0x2ab/0x2b0
   __free_pages+0x9d/0xb0
   __free_slab+0xa7/0xf0
   free_slab+0x31/0x100
   discard_slab+0x32/0x40
   __put_partials+0xb8/0xe0
   put_cpu_partial+0x5a/0x90
   __slab_free+0x1d9/0x2b0
   kfree+0x244/0x280
   mempool_kfree+0x12/0x20
   mempool_free+0x30/0x90
   nvme_unmap_data+0xd0/0x150 [nvme]
   nvme_pci_complete_batch+0xaf/0xd0 [nvme]
   nvme_irq+0x96/0xe0 [nvme]
   __handle_irq_event_percpu+0x50/0x1b0

Regards,
Bharata.

