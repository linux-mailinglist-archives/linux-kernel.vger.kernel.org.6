Return-Path: <linux-kernel+bounces-244483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F2492A4C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D036B20A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24312133439;
	Mon,  8 Jul 2024 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SEJAO8Uz"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B3E1C06
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449279; cv=fail; b=ANKmK0CEdYALr2t1xaCJfb3vjpiu4xfqVsIHX6Js2sjuJfSr/GbOR8CodCaW484sZIV7XNbazkIVJZMlkmznw/M0yHLfmMN/palPOin3AJKsR465sBzwsyURZN5LPrdceshCLtjENIejcFKKOaD7LGomzLCT5JheSxtmQxQRAIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449279; c=relaxed/simple;
	bh=0PLYY+5oIsPbyeKWAr5/9x+wI+ZC1uQGSKKO2+zk5SA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eTBhIQ7RJBk9pNi3/ShDaPuAtAU5krehr+m1xneGkyY6pcUBxp6Lux3miHHvK4R60YSF1Pz8kKHvc4bdrts3DMcwGKQGrnZhhTnoChgtASmHkSSyufOxDiby4Ga8VBziykpmwwelACI9uRk8w22XtWmm9ub6b339tImsm3QuUdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SEJAO8Uz; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE6pEPm3smz+OHtbe+gFLAGBTUeYM0QwJi9ZibCykiRKXWxc1b1yQhOMjg4W3Kvu+KJnuZU4ZQ9pXEc05TcvYzeRl1TWPk/ulKgQUdtqewmUmrj2skms9HbBcKvlYohDJq7GNe2QaXVoWQJRpwLRskPMAg7wUyw+LOUvxs1NdnDc93keD4iEXuwwsRLyc7JbPV6iM/CUUoe9fLlAWV7nuhBbA868YjNbo0BxBhyofgGiWvPEzDIeDFKjMJIcqt43N8zg9FhI0alglToK+4TAsJBfeBj3Unc/g04SMuELaoJAyHWKKx5UtApB0N86cjPCSdr44W3PU+Fi1XGPpiSZqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vsnBuBv1xjM04r3EzySZEDEuqwa9iqOEI1a+OrPoBo=;
 b=RKFrcMQC+A2HFD0dr7pillMohczmW8LgrKa17LO1qnN83m9JSadLJP81lqoX4eA4v/m70yOo1TvUwuqoOp92+o4E6kzK7751yUb0Iuo9EP+MRA+UkRN4bAVQaBmawp/TF1Z8XtQFPuMmInOba0oqupl4jOjXf4fgZT7MGZQ0Vjgmj97g5tDLN5dGKi9mZ9MUW5gUmaHUD2hn5A9u7Y2l3t/rn+F1+Ur7pEEc5sMNZ8ibpgZ2Xpmk21QyZvXUCvJy2bXOQNnEcWV0RxB4ydA5z1lfaWCR6OQYbredrkmi+nxRArUn2Aq/CmickLkFuJNFcMaHw5vmIdL7XiclieQBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vsnBuBv1xjM04r3EzySZEDEuqwa9iqOEI1a+OrPoBo=;
 b=SEJAO8UzN+Bx4c4AExooCdDLYeytfzcDPl4YMg7c/2pMIc+z9UOI9Z6CC7b52N/s5I70pcF3cxNpDKsNpW+RgoEFR8TWryWNSPgcN57uQe69Eq2S1aIWjXRYwNqdDj/wvW8eoON1zyieirhCNoRMFQJfot16LY1EO/2g0Bf84fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 14:34:35 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 14:34:35 +0000
Message-ID: <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com>
Date: Mon, 8 Jul 2024 20:04:22 +0530
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
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::12) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 1579998b-9b1a-485c-3b30-08dc9f5b1679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjFWSDRxUnRQUUhvT3JNUG11S1diRExqZ0JFbVNuNGFwbFJHSmZwUzRvUWth?=
 =?utf-8?B?NXJlVlZwL0NkczJJZnFrVU9NeU96N1Zza2gvSkVrWFVqSTNITWRaWUxCYmk5?=
 =?utf-8?B?V2hKempwTyttQkdRRk1GUS9nY1RscFRoL0lrdFZ3TmlGYTNxQTNPUDYvWGRB?=
 =?utf-8?B?ZHJmRWJlM0ZXSWF3WGhxUXJrNlJFVEZCU2xuT0RSNTI1R0h3NzBRNERKOW90?=
 =?utf-8?B?WjNTNWVON2FRTEtncE1RZEl5ZkoyR01LbmxFSXcyK2k1d2ZKSGJCNWUvaDBC?=
 =?utf-8?B?ditacU5BWjhTLzlMYS8vZklEbDlrcHNMNjVRUUR4UU1yR0R2Ynp1RE95Q0lK?=
 =?utf-8?B?WUROQnNBWXBzUHVWVll4S2JMZjNQb2lzVGFZU3A3SDNtelZ6QURRYktQWW0v?=
 =?utf-8?B?TVdVZUxDTG1DNWV0bFA5VmRZUTVlZzJhWDNPclFFeVB3VzVvZnRIcHh0VVBV?=
 =?utf-8?B?RW12SWxBTTVjc2lQSE1MeEV6NU0rL1lhU2dqdERrMXBNWVFEZUtxMFJRUXpl?=
 =?utf-8?B?czNBbnhPWXV5R1BVM0RkZnY4V0dYUEovYTAxV3pDSzhzbmNSelZWaG9OejlE?=
 =?utf-8?B?VnUyYWZiSWlwN2RBVFNGNEQzTEV6WS85SGRud1Vhc3lPWm12RWZiYWhOc2Jy?=
 =?utf-8?B?NFZXRE1tenhtZk1CTDNwamcrUWdINTZPV01TQTArWVV6N0llTzQzR1Q2ZTh1?=
 =?utf-8?B?UkE2TStnV1FjcFE3Mk5CUW1OVDZ0alNkRWxUcEdWVFVvdkdPTUR6Q0xKczhS?=
 =?utf-8?B?ZlArNC9vR3IvL0ZpUktMMDZQVHJ5TlRyVVN3RGNTb24vVmpKOVFmRnZPVk9a?=
 =?utf-8?B?OTZDN08zcXZrME9QOGQ1TG5sSHpBWDB5Z3d3dS9nSkRBNjlwY0llc0I0Vmhu?=
 =?utf-8?B?NTJzaC8vOHpBVDhkbUVXNWpEM2U5NGJTNzJmVlRvUDMvM1o4NFEwbzRuSVhK?=
 =?utf-8?B?amNUekxIaGV4V1lpR1VuRUErV0lzdStkQlBoZVRldjl0U3F1QW1odW9mbnpi?=
 =?utf-8?B?eDdMSkU2VHc3M2lSYjRXQmJpTzUvdklzbnZXUWYxR1lQNThoOFFxLzFNZnYy?=
 =?utf-8?B?OUhkNWp0NVN0Z2ZkWmxQNmowbklZaWpXeTV2a2g5cDVsUGQxSS9ERnhjL0JU?=
 =?utf-8?B?OFNRREkzaWpjbEhzK3ZiVGhDYkJNYUJNZm9YVXBLaWI0NjNma0cwTk93VnJB?=
 =?utf-8?B?YWxkWXF2RjRQU2FtcXAxM3laTUQ4N05teFloSk5SeXR4elBhaU15M0JVYUt0?=
 =?utf-8?B?UEpjYlVXSEJ3UUVVYU5DN293M21wOWtCbGJzUGljTkpWTTlFNDk2Q1FBOVNR?=
 =?utf-8?B?OEREVXEwRUtVcGZkaytQVW9ZMFNaWlNqVG9GdGJwLytHNHhzc0tkYjB0RHg5?=
 =?utf-8?B?MGR2R1BEMlhaRTJxYWZMSmhUL1JUQ1VKTXRrSzlwUWhYMW13N0VEeGxvTVNS?=
 =?utf-8?B?MUVVb1N2M3lKc25XU2ZqbmZSQkxVaWZDLzlwNkloNkxoY2xicnZraTkyRWpG?=
 =?utf-8?B?UENqZnQ4d3Mvem5WazhLOWdLODZtd2FJRTVncVVJTE1zVDY1Yjh5SXVmTU9N?=
 =?utf-8?B?S0x0U1NrUWN4Y2MwdnJpNXBsb1F6M3AzS3BrWnladGgyOUlBcHNtaHFBRmRW?=
 =?utf-8?B?b2xuSGFsSzZXR003R1ZjZ1JvZ2I4ZVNpUG5mYTdBZllmUUswa2FDUGpqUkY1?=
 =?utf-8?B?dko0NWt1RE5ZcHFXbnRhMVNiU1pDdGsyQ2RNSUN1S1BEWmpReWlqVVFuL3BD?=
 =?utf-8?B?QTJuYWtHcGMyWTFTMEM4SEVZM0tjZXNzajR4bnJhUzZVMmdXc2tQN0ZGcHZm?=
 =?utf-8?B?NVhDMnhjOW9kQW9sUXZ5UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWl3eFdZTWRWVWdZU292VzRiTDFlbjVyOTR3REc3aDdZMEVXK3BFMjBMRE9u?=
 =?utf-8?B?VldHV1orSjRNbGhmMVBZZmlIZEZJZ2duNTBlOUVpU0RERC9oUVdXc1RKaUVa?=
 =?utf-8?B?R2R1emZSbXd4R0NGWWF6UmZybzFlMWhVR0Mxa2dwTjdrbzhIeVdXdTIzMWZ3?=
 =?utf-8?B?WTRJc0QvZ0VRQXhldGRRWU9qbWRLWUlKUW9IckxPdU95NGxSMzFjUmQzSzNx?=
 =?utf-8?B?cHV2M2Y5eVkzZnBmQVBZUzU5RFVSbThWSGFUSHQrbE1QRkh0dmsyTG9GSDdw?=
 =?utf-8?B?SEJ6YTFUWE9qTUI3aGQ5TU1UMUNiVEdsd0FtbnpXZUZxeGpmTzY4bW03Mk1u?=
 =?utf-8?B?THNaZlowU2t1dEVoTGwwS2FpZ1ZJVDlPQnkyeUpGeDJyVDBIbkd1MzVnM1gw?=
 =?utf-8?B?Wi9uYnI0aS84QXUxQU13RGpVb3Zpamg4Mk1qQW44ekxBaWxUN0lnRXBmWGlB?=
 =?utf-8?B?SzJyeUtuaWlCWTlPdmVLM3VXMGN4OGttUmtneWc2NXB4Sms3S21heDRLMnd0?=
 =?utf-8?B?QkpyR1AvRVY3RVJEbHpTcVdOOStUVHNBb1pJY2lDdmppU3lCWXpNR0JzUGlW?=
 =?utf-8?B?dWkwcVdsdXFheE11VnFsYUJ3Q3Y5Y1hhN2plcXZwMXRoeU1zRXBYVzJSNFlk?=
 =?utf-8?B?ZEIvVDVuR3ArWUtJLzB5TEZNK2FYcGdOUTZqWDRiRzdldS9YdzBsMFhVaGh2?=
 =?utf-8?B?Y0QwK1BOdzRqRzk5QWwwcFJPR3ovNlRMbG85UWM0aWlpbGQ5YnF5NTRhejVr?=
 =?utf-8?B?OG9hRTlDdDg4dWhrdmp3ZGJSOFp3VG55VkJxYnJqT2JwU1FjbEt3cGZwQmdx?=
 =?utf-8?B?SEU1NGZLdFVDMG5PUHNybFk1aWdEYlZIOTNFYVdwWTBVVkpOanhkQkNHU2NT?=
 =?utf-8?B?SHlhbFE4ZEwrcGVNK0l4YWFaMStPb3doK2pySC9sTU4rN2prbFE2WXYyMHdq?=
 =?utf-8?B?UE9EVk1PbldvbXVSRVlYVUYwRUVIUGJGYmxjVzQ5NFRheFl0M3N5UkQyTDk5?=
 =?utf-8?B?UG9MdmwwMTdwMjROaFdyNUJ1SW1ONGsyczQyYmpnWkZQbHdJMWpWUjhtL25G?=
 =?utf-8?B?QnF2MFMvRWdEdHhKbkpOSXB4bjBCVndEM3R2OVEwY1FjalRkdkZhRlB2RlZD?=
 =?utf-8?B?VWxiQmEvelorVldzMm1lUVFrWTI0THB0S0VML1VpbmhxRVFXUVI0OWtRak5G?=
 =?utf-8?B?YXZQOU5PMGxMNG9zUnJnTWNXOVJ5eEFsY2xWMUovMThTUmxMSTE3ZGNQTnJo?=
 =?utf-8?B?b3kvREw0b3VlL3J5MDZlZXZBZXN6ZVAwNG81WjAwc1h6OUxTeDkrTXhJZjh6?=
 =?utf-8?B?WkRLdWJDendTcThsWk9GWjlhNWpGQmhUeW1jbDBreHFzbzNGUGVWdGVTNmNW?=
 =?utf-8?B?Vy9FakNSYWlqSVMzbmdYQjc5bWJNRzBBendUbzdub01Td0ErSjdSL29zUTZw?=
 =?utf-8?B?M1NWTG9WUllaV3J0a0JERFZ3UDZyQUlTN3BnQmZJVHdkTUkzdFU1WGplNm92?=
 =?utf-8?B?R0MvM3pvY0pZRWFBUW1LSktuWkdTL29IaTlnUnB0TlB2Q25BT1piVlF3aUtQ?=
 =?utf-8?B?L05CbkZNS1BzdU1mbDIzWkxvemM2YzFUdm1MWWswTldZNVpBSnZPM3EyRmp2?=
 =?utf-8?B?Mng2S2dkL1pEYlIyQ2ZaaldNUEhwRE5HbGZSSWxheE9vTzJJVVdMY3ZuNWc2?=
 =?utf-8?B?RmVMK2tYeW5tVGJEY2M4RnBkUlZyVVNKQ2xRa3ZFZThLQmVkNmdJT3Irb2po?=
 =?utf-8?B?M1dqdFM4eTdsTEZCT3c5VFZIaGNXZmxZNVVHdVRwQVIwWXcvQU92VFpTYzhl?=
 =?utf-8?B?YWQ1YkNsNEQ0R3hCL0p5N2NERFZKUUhmSUxYMEFPUFZWZlovbktUK25KM1Ir?=
 =?utf-8?B?QWxnT1NNZzArczhzWjQyK0pKMEVMU2liNmdtelRxQjdwU0ZJTUZ5U1p5di9D?=
 =?utf-8?B?cTBwOG5YSTFrTHJyUVZydHE4ejFiM2U0NFp2Nm5odWxqc3lCUkZyT0tJUGUx?=
 =?utf-8?B?b3RJemFmYVQ4bHd0bFltakZmOUlIalRLV3ZURHFQZEJmV3l6Tys1cDJyVkRX?=
 =?utf-8?B?cFFyLzA1MXdHYzBkM2txbkE0WENCZDFMU2J6TmxicUVha3JXVEoyTWorTklx?=
 =?utf-8?Q?Y6+81NN0QEwmvVnOVrM6zvANO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1579998b-9b1a-485c-3b30-08dc9f5b1679
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 14:34:34.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2e4A9LLnUembXLpxvxuLZMCBSqXOBmcdUfl9JA7tx3lLfCizxpjJuQZE9t9q8SWDIXOZDjN3H5/vE/zwLKOTWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

Hi Yu Zhao,

Thanks for your patches. See below...

On 07-Jul-24 4:12 AM, Yu Zhao wrote:
> Hi Bharata,
> 
> On Wed, Jul 3, 2024 at 9:11 AM Bharata B Rao <bharata@amd.com> wrote:
>>
<snip>
>> 
>> Some experiments tried
>> ======================
>> 1) When MGLRU was enabled many soft lockups were observed, no hard
>> lockups were seen for 48 hours run. Below is once such soft lockup.
> 
> This is not really an MGLRU issue -- can you please try one of the
> attached patches? It (truncate.patch) should help with or without
> MGLRU.

With truncate.patch and default LRU scheme, a few hard lockups are seen.

First one is this:

watchdog: Watchdog detected hard LOCKUP on cpu 487
CPU: 487 PID: 11525 Comm: fio Not tainted 6.10.0-rc3 #27
RIP: 0010:native_queued_spin_lock_slowpath+0x81/0x300
Call Trace:
   <NMI>
   ? show_regs+0x69/0x80
   ? watchdog_hardlockup_check+0x1b4/0x3a0
<SNIP>
   ? native_queued_spin_lock_slowpath+0x81/0x300
   </NMI>
   <TASK>
   ? __pfx_folio_activate_fn+0x10/0x10
   _raw_spin_lock_irqsave+0x5b/0x70
   folio_lruvec_lock_irqsave+0x62/0x90
   folio_batch_move_lru+0x9d/0x160
   folio_activate+0x95/0xe0
   folio_mark_accessed+0x11f/0x160
   filemap_read+0x343/0x3d0
<SNIP>
   blkdev_read_iter+0x6f/0x140
   vfs_read+0x25b/0x340
   ksys_read+0x67/0xf0
   __x64_sys_read+0x19/0x20
   x64_sys_call+0x1771/0x20d0

This is the next one:

watchdog: Watchdog detected hard LOCKUP on cpu 219
CPU: 219 PID: 2584763 Comm: fs_racer_dir_cr Not tainted 6.10.0-rc3 #27
RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
Call Trace:
   <NMI>
   ? show_regs+0x69/0x80
   ? watchdog_hardlockup_check+0x1b4/0x3a0
<SNIP>
   ? native_queued_spin_lock_slowpath+0x2b4/0x300
   </NMI>
   <TASK>
   _raw_spin_lock_irqsave+0x5b/0x70
   folio_lruvec_lock_irqsave+0x62/0x90
   __page_cache_release+0x89/0x2f0
   folios_put_refs+0x92/0x230
   __folio_batch_release+0x74/0x90
   truncate_inode_pages_range+0x16f/0x520
   truncate_pagecache+0x49/0x70
   ext4_setattr+0x326/0xaa0
   notify_change+0x353/0x500
   do_truncate+0x83/0xe0
   path_openat+0xd9e/0x1090
   do_filp_open+0xaa/0x150
   do_sys_openat2+0x9b/0xd0
   __x64_sys_openat+0x55/0x90
   x64_sys_call+0xe55/0x20d0
   do_syscall_64+0x7e/0x130
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

When this happens, all-CPU backtrace shows a CPU being in 
isolate_lru_folios().

> 
>> kernel: watchdog: BUG: soft lockup - CPU#29 stuck for 11s! [fio:2701649]
>> kernel: CPU: 29 PID: 2701649 Comm: fio Tainted: G             L
>> 6.10.0-rc3-mglru-irqstrc #24
>> kernel: RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
>> kernel: Call Trace:
>> kernel:  <IRQ>
>> kernel:  ? show_regs+0x69/0x80
>> kernel:  ? watchdog_timer_fn+0x223/0x2b0
>> kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
>> <SNIP>
>> kernel:  </IRQ>
>> kernel:  <TASK>
>> kernel:  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
>> kernel:  ? native_queued_spin_lock_slowpath+0x2b4/0x300
>> kernel:  _raw_spin_lock+0x38/0x50
>> kernel:  clear_shadow_entry+0x3d/0x100
>> kernel:  ? __pfx_workingset_update_node+0x10/0x10
>> kernel:  mapping_try_invalidate+0x117/0x1d0
>> kernel:  invalidate_mapping_pages+0x10/0x20
>> kernel:  invalidate_bdev+0x3c/0x50
>> kernel:  blkdev_common_ioctl+0x5f7/0xa90
>> kernel:  blkdev_ioctl+0x109/0x270
>> kernel:  x64_sys_call+0x1215/0x20d0
>> kernel:  do_syscall_64+0x7e/0x130
>>
>> This happens to be contending on inode i_lock spinlock.
>>
>> Below preemptirqsoff trace points to preemption being disabled for more
>> than 10s and the lock in picture is lruvec spinlock.
> 
> Also if you could try the other patch (mglru.patch) please. It should
> help reduce unnecessary rotations from deactivate_file_folio(), which
> in turn should reduce the contention on the LRU lock for MGLRU.

Currently testing is in progress with mglru.patch and MGLRU enabled. 
Will get back on the results.

Regards,
Bharata.

