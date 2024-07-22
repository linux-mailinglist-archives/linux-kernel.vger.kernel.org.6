Return-Path: <linux-kernel+bounces-258447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5E4938806
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E191C20D41
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DC114AA9;
	Mon, 22 Jul 2024 04:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DLWIGnu2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A51370
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721621837; cv=fail; b=uj7b15T8XFQma5P6WjfC1ARNuaF38jpACMj7Kj2yAGdbgXJw9tNVR7cu7Jc4PTrBZs8EoquI9gPdpyYjQwpnv4YhYeFwAqGv8eOlibVOBAGUn7zG3VBBs6qjF9tqc/gDrNUdiyrqDVoIhxZFdPse/SGCJdsu/ybX33mkMQIwcdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721621837; c=relaxed/simple;
	bh=Bv202IhlEXhZ2U9dOVTlyIUuP8IiTJjsT5PYS4i0xeQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AIewCeapblFdE28AsK0LSQ7lWFH3cOeUz885/ZKmXMg0ASCSm9O4ZtPw0BweAte3xbyVEk7zI13s3p1/4SsmbscvzZZpZCyhXZHY4vGMo5oePxirb/nZfsNW1lMCZKkB0qwdVWbov8Or9ZDrFB8GSDlgwP94bB/Ld3U+MMmL5BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DLWIGnu2; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3I39wF/0Fwl5UlU3lHPj5ngpfERBCVDwwxzBEW/QiKEhjlbwDhlSmq/vY8q7Qs0wLibxfRFiBai3du7SEOwmCPxSTM9b2tE0QBpfaFxn0WOYf2wlUxFjNHYBiKJ7esKP+DdSVw126sy6AyU/KCesLFuC/iLUGabyCOH+jwP0GnJU7uYcU1XrNIktWC0D4TP6hufFxm6HV9ahS4la8Wi8XkD3CPaR5uEFgiP1Gq3S1e8M6sy8OXHOXHyjccU4b98R91ylsX1gFM8hVkz/tlFSpr52Veiq74wnWxXNeiwyfqPLKdEbYpltY8k0+kUCVmlrQaMaWG7AI5gpmmZr0KM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MofPqHVnJ+Wj0SUPDWoIra3Him8GwTrRXZ6U59+mHFI=;
 b=dCv80gexIPKZmU2k/ImgP3w7QbJR1KJTFtgKRh+aHslitiEZRv9jas7MGNrxen0xcOff1HpqABGmWfRYLml3eJbhwzwH2RchSCLoy8nYd5SMgJ3fuBdIAqEt9YgEIotoNv8gu5tWeiYSrd1X4flvPEprmsxxwgA7dk9ez2NRoiJwa68bEtFQcmgBYlBGpcb6C/INcojC3rP4Gq6JGp6fYgHCnyhAlNZ3pQeQ2sPUgRAHIwEqYXlsfxkHmFIiAXlbfho+J9ezGs3Fx+W/8eRTnv8stJyjePdo4WwZFLaZi6RTOF2D2215z04kukATcwXabWEUeOdLLF552EBK3tKKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MofPqHVnJ+Wj0SUPDWoIra3Him8GwTrRXZ6U59+mHFI=;
 b=DLWIGnu2VxH7WZ3B/28lGlaldsR9zuRhN+ZKIw6/CnkjtVtP7kYMpIaKCEBFqL+gd6ICqArPY9q3GWVEXy1PMxJb/eN0ukkF6mzRK2B3ktt3SzDaOxH3Ps4nufJOYeilIwtt8ZY5thitXX8nqADVN4cqbCTsnSOlHRd/S7V5JVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 04:17:11 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 04:17:10 +0000
Message-ID: <deddb7b4-02f6-46aa-a075-cf9b7083ffd8@amd.com>
Date: Mon, 22 Jul 2024 09:47:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Mateusz Guzik <mjguzik@gmail.com>, Yu Zhao <yuzhao@google.com>
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
 <b68e43d4-91f2-4481-80a9-d166c0a43584@amd.com>
 <893a263a-0038-4b4b-9031-72567b966f73@amd.com>
 <CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com>
 <CAGudoHEd9FL+Mhk8GdFm+3gvBk35ho-BTX-f7jn=O5Lz2mij-Q@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAGudoHEd9FL+Mhk8GdFm+3gvBk35ho-BTX-f7jn=O5Lz2mij-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::27) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5b8cfd-f4a3-494b-fb73-08dcaa052838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlZTcnByRzBZMDFhWHcvWWFYUVhVbG5QQmlDa1pobHlJR09hYzhEM3UyaGp2?=
 =?utf-8?B?RmdPV1N0Wm0vY2JMK01peUdZM2xiY3BScUlQNUhJTHRKdW92Q0pYNlQxVDVI?=
 =?utf-8?B?dmhtbXdKS1M5VHNpQVh1UklIMktreFVuUlVuVWppd3ViMHJmV29WdzJGb0hz?=
 =?utf-8?B?YXprdFQrVXNydWFIVVJnMmlhOGlyTkdPQ0xJQkRXT015OXlycW9YNWRvNzVo?=
 =?utf-8?B?ZDNZajhmdlRGbGNEOERteU5yVmI2bXRYMlVHM2NZTDNMbFFjMWY1Qzg3WFQ2?=
 =?utf-8?B?NzlqYlZ6d0MraGtWRDJBdWR1UFU2Y2k0Z3VybkFiWTlJL0RpblZvaDhDOTJi?=
 =?utf-8?B?WUZNTEpOMjZVemJSTUJwU3daVStKRXY2cG8wNDVLUGsvL0VXd2ROODdZTmlV?=
 =?utf-8?B?MFh3VXRkNnFNT3pibjdrQmQxQ3FVanhwUm0ydVdhVGNQNEhxQmtGSUd5K21o?=
 =?utf-8?B?YVVmamdXM1RHd0sya1hzRS92R0ZwRmZoZFdtczdPM1JzWmFkTG1uc1FlRSta?=
 =?utf-8?B?ZU93NkJlMEZjZlA2R0Jla0RTelpwb1lkQ21zMHlnbG5obkdHZys3YXh0SDZY?=
 =?utf-8?B?RjlUWHN5TUY2S2RGc2ZGK0lMTjNHa1VBaDhyQXhveGdac2oxQmNMYVQremNH?=
 =?utf-8?B?b1hsSXJhMmc3T2NnOHJJVVF6Q09xYVovSkJtKzhmUFpqUUVwNzdTZHpQUHB1?=
 =?utf-8?B?LzMvQ3BWeHVaMDI3Q0IvdjcyYjhoK29WQ1hPT213aDVBZzRiU0FLZCs5ZzBm?=
 =?utf-8?B?RjlqVDN4N2hKc2tWWEg2SnVoYVYvR0ZhOU5KakZ3bEdIME1OcUYrUFN6Mzc3?=
 =?utf-8?B?TkExemorZzFSUGg0RTV4OW5YdVVLbURtTGxTa2tRNGNHaFBjR3BOajN6M3pk?=
 =?utf-8?B?RHRVM2VaVkpHOFQyYmlhQ2c1a2JmbklXbUhRcDh0ZkpBbUdNYzlqZGg1Tkti?=
 =?utf-8?B?VWhPNlZaV01kT2ttbWM5bGpzWWJPUmNFS3hYRFJnVXpMaFFJZEdWRzJsL1ds?=
 =?utf-8?B?TE1LUmJoL0VMSFMva1lNQk0xbTVtQmRYbmpzZ2Y1YVMycXRoUzVHYWMwaDQw?=
 =?utf-8?B?Q0hDVGtIR0lJeXB1K0Nza2ZFMlNqQVZERHRicThRdE5yV2wvV20xNUY0bTJS?=
 =?utf-8?B?UXBsOUJyMWdzNjBJdjNTeGRXWlBHdHhWaXh2UmtzM0lyNGphZU9SemltTU1G?=
 =?utf-8?B?NDhsamRWdGQ2cmpwVGIvbUxrSVpTRnVjZ0RoUkV0VWl3L1ptN0lqUXVaeHhL?=
 =?utf-8?B?ZHJCMTNTMzBKekw4NGVsWkhkT1A4RG9kdSt0WmR6Qm05d1lxRy9Bd3NwVy9o?=
 =?utf-8?B?OXo3QTdpRVR1S2RSRllPUktKOXZtOERPUnpNNnUyUmozVXRhVWhvdzMxWlFo?=
 =?utf-8?B?ODh0VFBKaEVRNFBPamUwaTRFNFZ6anUxZU5vTlgwR0piN283TzhKMW1BQzVU?=
 =?utf-8?B?aEFwanFHUVJFbkpaeTlINjFSdGZlYjBHOFBsSjRIRGx5L2MxU1k5RVAxNmpT?=
 =?utf-8?B?dzRzcTdBWXVoTlJNR0NTTVB5eXVvR2ZKaDVsTFZlaUVJL0R2dUd0d3N6aU9O?=
 =?utf-8?B?MTF3aHlKSVlxQWhsMTFOMEI4dFNRVmVEUWlHb1BmaUtLQVowZkhTMW44UVFI?=
 =?utf-8?B?NWRybzdmTGZwNWtWcGpNTEFrVS9YN2NXUE1kb01YNkxHQ2Y5MGp5VFdyNmxy?=
 =?utf-8?B?em5ZeVYrcEJVOUEwdEhGN2NjNGJYcXpRR2kvWmx2TEVvNkpFQ1ZQekY1RHpY?=
 =?utf-8?B?NVhxdllaNnh3THJMemwyNFJJSEFxejhTYWladE5oL0NrdXlaM2hlVk9jR1ZJ?=
 =?utf-8?B?eWY1SkJOSExpZUIwV3kvQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkwrTmVSeVI1RDJUOEFkS0hFWExhajlWT3cwQ1JsNTdMMVJYaGhZNHdlcnBH?=
 =?utf-8?B?TkNFV20wMzlMazFEcm5FejM3WDl6dy9RMWR6Tnl4ZkNvQXdzcCtZRTV6SGkv?=
 =?utf-8?B?Z1k5UlhIYWtwVkZ3TU1ueWxIaUtDekhOYUJYRldsL3czMDh2cTJRUGUrUTJY?=
 =?utf-8?B?Rm5WTFBPWmJ6aTYxZW5RdEl3SXNabnlBUzFRTzYwUGhPUHBnMktFemhmRHBh?=
 =?utf-8?B?WW1yWDFSRXRkS09RbVlJNUpSamxmNEZ0eDgrbmVXRFZyUVlaS1FpbFNSaUlL?=
 =?utf-8?B?WkxkN3Y5dmJoR0ZTUnhxRy9qRllIM1U1bFphRGx0NkZMaXhvaTd5LzdlV2Zp?=
 =?utf-8?B?SXlmai91OTlNMUc0MTMyTHJwa0w2dE0zNlBqbWVvcFo1Rytkc20vQ2JYdTdO?=
 =?utf-8?B?Z1JoSFdsL3Z6cy9qc055RjRIc3oyWW41RDJlbldzbWtNWVVrNnp5NnlROXRG?=
 =?utf-8?B?bTNFVStPNnU4UzQ5T3VUOEUzMWp2UWE5OE1jME54c0tMMnc5ZHlEL052d0tu?=
 =?utf-8?B?djNiRVhLVDFhWVlSQkpQelE0STQyV2krQ2s5Z0xod3JsVzdNWTJqWGdFK2ly?=
 =?utf-8?B?Q0xRRFp0d1JZMzRxMFJPNE1DamNvRXRyY016NWVPVzRQbVdqQWRFV3M4N1ZB?=
 =?utf-8?B?aXU5S25YV2FMRTIyKzQ3Q1pudmFSM2s1eEU5KzA2eHRVWFk3Y2ZpdW5tWi9T?=
 =?utf-8?B?R3M2L0xsamk5Qm8ySGVrSkllWllwRUxkbE9haWZ1QklHdmRsRDlRbEdpS2Rm?=
 =?utf-8?B?MkdnNFBGQWtpUjJZekRBeGUxdE02bUFtKzVkMnJVT1VaTGU1bUZoUmlCTHd5?=
 =?utf-8?B?VlQyK2JPaHRWNERGRzNiZEJxVFNEQkJmY3JsQkM4c1oreFcwU3pqSjFsRmV5?=
 =?utf-8?B?c01YaHVhSkxPdzRBZUdiT2liRit2cGNqaDhDZGliMEZYTXd1QXoxME14bFps?=
 =?utf-8?B?Mk02clNmSXVJYjlVTTNSeVozeUtFK3EvczhMaDI4Z0xnQngyOWdmUXJMdTVk?=
 =?utf-8?B?cEVXaCtMZkhGSGJyRjhTN3RPdUp3d3EzelhNTm5TREtMK3JMZVNPS09kMVBv?=
 =?utf-8?B?cjhkSGRaMThIRTZmSkVlSGZINVpSbEswRFBaM2VRYThFR01oanI1YWFhRSt4?=
 =?utf-8?B?aHpwZktYUm4rdG1UUWhRWHZoS2huaFBGWVdIaERmNTNEYUQ0YncwMnV4Q3Rr?=
 =?utf-8?B?aDg4UmtvMlR4WURtaUcyUzIwcmdWcUd5WFA2L0tJNStHbWpXdSs0Z05OTVY5?=
 =?utf-8?B?eXhweW80Umk0d2VscFhQL2orb0t1cjlqVkVQbU1PSDZGNmZWci8wZ2xnQklB?=
 =?utf-8?B?ME9HTmh4bW5KOUxiUGYwbFFyY0NTZUdNSG5PWCtvWlBTWlQ0c0VJUDFOL0xY?=
 =?utf-8?B?TmI2aHZkNDhhL091RWlyd0c4TFdwUzErTnM5aEVWYnFPcmtWZ0RVMStQWjVY?=
 =?utf-8?B?K2lOcW1GR0tRT2h0OVpWUms3N1YwYnBzanI4cExDQVEyYVJPYTcxZG4xczR5?=
 =?utf-8?B?bnRVcllocUY5bndyakNxa0dDZkNpZTRnS0tXdk53eXFRVVNENFNZLytIb1d6?=
 =?utf-8?B?V3VPR29KeE9nYVlZemtYSmtiaVZUa1RLSHJLbk5xS0s5bkdhYWJQY21VNmlj?=
 =?utf-8?B?M3V4VFF0T1ZGZ2R4TVlVbFJJYlBPaGh5dHhGZlA2ZmhtNGFva3ZWWjhlekYz?=
 =?utf-8?B?S051QVpWYisyMFNSTUlvTDFMenQzRGZXQkkzTG5kaFd2em5YTGVUNmRSaE1Z?=
 =?utf-8?B?NU12NGhYMjI2eTNVOWxWK3Z2VWNaQ2gvRmdCSERIUmRMOFk4Y0tjOWNtQ3JB?=
 =?utf-8?B?TW81emFjMGo4dUJuZkt2V2ZOU2h2U3RxNHBWMGtpdS9LbFpKNWlUNFBySlJl?=
 =?utf-8?B?U09yM2l1ZndlbjczWDI0YTdOelV5aFhDQlBvbVkwSmpEVkhKWVFBdmxaQktj?=
 =?utf-8?B?VFlEdytWSXc2T1AvRlhDU2M2K094QXNiWWMwSVhmSkFYbTFobVE4bXpUV2pO?=
 =?utf-8?B?MG9VOTdMT1RKREQ5UmMxTlpXeGJzOGNZcSt3VjlzTTQraTZPQkpYQ2xTQXll?=
 =?utf-8?B?NjNlSjA1YXgxY010US9aY3pEUE5PNHRBUGNMVWJhQU5Va29XVFFoQW5NQmNn?=
 =?utf-8?Q?R9qroaJ7noMpLdfTusP2/AeMF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5b8cfd-f4a3-494b-fb73-08dcaa052838
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 04:17:10.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfDTaPKRcrNtqFcYfMRuOx6FXyFWNYyXNEqrs/3b+aWREZThpIe2Un6/d2fxDlmdlEYRkUL8HSwxmIycJUWtMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532

On 20-Jul-24 1:27 PM, Mateusz Guzik wrote:
> On Fri, Jul 19, 2024 at 10:21 PM Yu Zhao <yuzhao@google.com> wrote:
>> I can't come up with any reasonable band-aid at this moment, i.e.,
>> something not too ugly to work around a more fundamental scalability
>> problem.
>>
>> Before I give up: what type of dirty data was written back to the nvme
>> device? Was it page cache or swap?
>>
> 
> With my corporate employee hat on, I would like to note a couple of
> three things.
> 
> 1. there are definitely bugs here and someone(tm) should sort them out(R)
> 
> however....
> 
> 2. the real goal is presumably to beat the kernel into shape where
> production kernels no longer suffer lockups running this workload on
> this hardware
> 3. the flamegraph (to be found in [1]) shows expensive debug enabled,
> notably for preemption count (search for preempt_count_sub to see)
> 4. I'm told the lruvec problem is being worked on (but no ETA) and I
> don't think the above justifies considering any hacks or otherwise
> putting more pressure on it
> 
> It is plausible eliminating the aforementioned debug will be good enough.
> 
> Apart from that I note percpu_counter_add_batch (+ irq debug) accounts
> for 5.8% cpu time. This will of course go down if irq tracing is
> disabled, but so happens I optimized this routine to be faster
> single-threaded (in particular by dodging the interrupt trip). The
> patch is hanging out in the mm tree [2] and is trivially applicable
> for testing.
> 
> Even if none of the debug opts can get modified, this should drop
> percpu_counter_add_batch to 1.5% or so, which may or may not have a
> side effect of avoiding the lockup problem.

Thanks, A few debug options were turned ON to gather debug data. Will do 
a full run once with them turned OFF and with the above 
percpu_counter_add_batch patch.

Regards,
Bharata.

