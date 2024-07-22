Return-Path: <linux-kernel+bounces-258446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E8938804
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EC1281111
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D1815AC4;
	Mon, 22 Jul 2024 04:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fh6UApUz"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87782CA9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721621554; cv=fail; b=eo3smrFZFf492fthoIijobI/+Ot1w55W1IwWmId8qM2FcvqBIAAeU2oCWShkT6eOZfihzByDaqiaGl4VthpDZFbUENkreUhRg2+4s9cOiUwQ8dnjFolOuPbbkGVwv9swClsJ3AHhqpEa1/OMNY5aGB2dI98REtbb/J4vmfuZhYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721621554; c=relaxed/simple;
	bh=Scz4N/d1XaDQhtxHQj/EUc6WEgX0d3yHeL3GS8FRMrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TKPFJs8XL0ykDCj42BJdhX0vHq1GIr22H3aNS7frZ0pPeAsbkxFS9tARauB3TIcZhYNCQzGSp18BYGkTPIlTM2bGCqSIJqhAASsAyJ6oyKkQbs11GwBMxy3N1c0+MW/+yxgpKW9914pgTaNPz8MopVgvT7EeHtoV7j2lwsBoOjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fh6UApUz; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+7FCYM7HjxldLll9iFMwcxw4uhL3chVmgH75HmcRUNpc2dQK3rRPat+VZWU1GUAjDIMjdCoM69ZtFqX81pP5RkSne1E/ujTgnSGkoB+RSyL5u2dkvvR1tj+NbxzpfGl6v3+C/5L7/nO3BVElQ/91B//tcgow3xMFvvAHkrJwdDkebf7V1CiHdrPBQfoH1myuracWEz7gWNGMz4NfhvLxCecb20ENfyXmUflDLrQATALiXFs1V7zHN8PIvaKCMyGQazrF52W1CkGUA5TFlmtNZxiEszmcwhm4D0esHyxwMvBO8ju2gYL9jeiCDXNpKhcwzBwFBRxzTDWHKrrOo8olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHrPoj8nj4wU/gzWLORpeXW1GRcZ9qg4Aye5A2BZmbU=;
 b=DFOuvrSIxd9T9x8HYCO+fzUFkBb1S+12A1lKpvXozU9GUjsmtJdQndBSQZyGaFGFu3xrqSmfmN2AFqmTtzJlT0TzGW3aU4OlOOUg8kmLyMhXm7MAdTRryLLqb1ZyQYgJGGgmi6L+95pGWZylFf431h5mNE4MXOs0a9h2YOIC7AVFe3K0COmkKZxHavDfY2BsyfxdZ3fFE0fCkIdUUUpFlLJ620RGFurtahbxewEnMHKZBv4vlTpK/Laj1s5MsZP+Xjlxd47yiyh2YppEQQ0PKc8CQiX8odkMnLOudkEcJaAuuLdXzZaj/GTXb2e38waLzsnjkDMQuy4T6IAy937tEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHrPoj8nj4wU/gzWLORpeXW1GRcZ9qg4Aye5A2BZmbU=;
 b=Fh6UApUz8n3gh6XlDNO1rA1HVjzhvNOPnbzCxRd59BidW+OYJpwxxmRo21EcVElrD/Cqye/UTZNrJxr+2+FzOTXR2MXwJT35Aa4XIugG1ewgfgeArDitOs2AP3qoC2eeZnRCB+yp1mcAscrl9Q8nrPkYG5iCs5Sv1pqrvg9pgvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Mon, 22 Jul
 2024 04:12:28 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 04:12:27 +0000
Message-ID: <7104d206-7ea4-4471-bbc8-0513350ff8b3@amd.com>
Date: Mon, 22 Jul 2024 09:42:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz,
 kinseyho@google.com, Mel Gorman <mgorman@suse.de>, mjguzik@gmail.com
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com>
 <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
 <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com>
 <CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com>
 <b68e43d4-91f2-4481-80a9-d166c0a43584@amd.com>
 <893a263a-0038-4b4b-9031-72567b966f73@amd.com>
 <CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::23) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e241f8-7c8b-4930-85b8-08dcaa047f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHczd2xZRG9LOWVQMG9tckxZT25aRkVpcFF6bXQ5ZEZ0dlozb2JYT0taT1g2?=
 =?utf-8?B?UURUUG5LZHZGbVd4OWxGMDViUjdTdWFSSE0ySFgwaXV3VVdqMDVzMk9YR2hC?=
 =?utf-8?B?NEFOdFpwZEpqbVp1NEloUG9DZWpCWkd4L2cvS0NsYUlYVmJrYVVoS3MwaTRY?=
 =?utf-8?B?bnUvSnBLZVg4aFJPSjFnMmZ3amtSMlVPQ2xmdlFwVUhMb1RQSmlydlRQTytr?=
 =?utf-8?B?U3pkdUZGUG5VZjJORERoa1hrTkEvLzl6K3QxRXVXcFRTQjJTeGhJd2RCbDZX?=
 =?utf-8?B?aitUdE1pVzFrT0lONmxDdW9kbnZrS3I0N2VwblliMFJkWmZxdkUxY1B4NUVj?=
 =?utf-8?B?WElQSkJLZHBUS0FYVkVsNmNoUjEyb3ZzVDFYNTdNdnZLeUN5WTNqNzZrL0o1?=
 =?utf-8?B?ZEducmJIOEMxd095NFFsdTQ0MXdMczZjdm9kaTZJRXVxbjJhLy9mS0grcVlL?=
 =?utf-8?B?TzVHeUxqQUhqTG4yQ2V2VVlGZ2VWZDhvS0phdTlDSUgwVmdzd29EOFNIWWkv?=
 =?utf-8?B?Q25VRkVISzZqMWNYazRLWGpYOVVZRyt0UTE0VUtySTg1TmRaamN4OGJHZjN3?=
 =?utf-8?B?Q2VhUHp6cFVBd3JJdEJ2NU00WmtpT2pKcGFPQ1Bnejg5QjZ5aElrSVVMdEpi?=
 =?utf-8?B?VHBYWTBSV3AwS2RtV0RZSjZ3UW5yZ1BiL3JCSDZtRnNYOWJhc3U4aDVMWkNV?=
 =?utf-8?B?WndQRzBPTW9ZdGhvWHA5dzNCUFhPa2MrK29jV2YyR2Y1M3I3Z2NEOGxEZ0l4?=
 =?utf-8?B?eTVHUlhDVFA2UWI5VDVpMmZCRmh0bjJBeGpBZ2w4REYyYkRTaWtpR1RwRUo2?=
 =?utf-8?B?R1pOUXR2OEJZOHAwWS9ZVHg2Z1pXMExINnNzU0QwRXhNSEJFd09SODRMemJp?=
 =?utf-8?B?SEE3c0FYeis1bmZhYTl1WkZVVHg2a2RQcDQvTTdkN1lXUUIyWFNLRjFSdEEx?=
 =?utf-8?B?SENKQkNsK0h0SGFQQWcxT0FZQU1iYmd5OHMzallQbDhncXpzbEdSZFVESys5?=
 =?utf-8?B?emJhTHplOGNpZHhWMzkySHYzMkpFWW9oWXlNQTQ4U25yRVFnRktKa2V0WWly?=
 =?utf-8?B?alF1YkhObmcrc293TW5PV2tja0k4TmJ6RVMxNnBFNmovSThmSVA3cktuWmRw?=
 =?utf-8?B?bEhmck9hZHBxMDNIYVh2MVp5VkpmQjVRdmFqUXpLc1ZHMzZNdFRnbWpUcExo?=
 =?utf-8?B?VG5Jek1NYU1uWVppdksxeUEzdzcvN2NPQXZLZk1KZU01OXRpSGY3a2phYXZT?=
 =?utf-8?B?WDJOVFdubTlMdXAvVDlsdzBvdS82Z3poKzB2YXgveWZ2UE9CalNGY0RSN1Ix?=
 =?utf-8?B?VzJqOFUvOXBxODNjbGw0U3ZycXZKSFNLcXdybFliRGEydW1mWi95N0NXNU1y?=
 =?utf-8?B?UDAwYWx0WmZRMzZUNVM1dkhkbTBva1RWblQvNkVhbytTZ0ZlaG1JWk96Q1lQ?=
 =?utf-8?B?WnVHaXNVZjlWeVZJNnRMWENGODRsemlKcXE3d2JocjZEMTUxdW81UVArTEFx?=
 =?utf-8?B?YVNlV3k3OSsyQk5aK0E5bUp2NnVyc1JLdlQydnJiMFppZkFZUTE1NFpRKytI?=
 =?utf-8?B?dHROc0RGTndvWS9WdWttQlp4K0xOemVwUzB3YWE2RnFXL3Fsc24xdFAwN0JZ?=
 =?utf-8?B?V1R0OE9zb2VuazdtMVlWZm11RlprdEN3bW9uR2Nhanh0a0dpQ3Jpamx6dW1t?=
 =?utf-8?B?RWlpYU8vYkhNRkpTeGNNdDVYaG91SWVBNjFtQmlpRytaUXdLRmFmYVRQNEZP?=
 =?utf-8?B?bXRCSU1BWlRJZVJ6NUtPeHRZV21TWTV4TnJPVm9SK2hCVjhKRnE0RUNWQlRM?=
 =?utf-8?B?MVZFRHZwb2NiZ0h2blNLdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHBQTHhBMnQ2c3Vab0ZadGRBQ0NKeUJTWTFvTWNvUmRaQjljeUJ0RldVMWR2?=
 =?utf-8?B?aXpPQXdmNDcxdFMxY2ZnUjhBYzAxQ2J0M1ZZcGUrcEFQUEFqK2JuZk9LYTlX?=
 =?utf-8?B?QXlXbVVMSmtOemFuZzgvdnQxbUd2TUxiREZwdkJPWTJDdWhLRmZNUWlJODVS?=
 =?utf-8?B?SisrcEtLQVBXUGNFczdxUDhjTENwL3U4STBIWDRsb2NmdlhuZzZ1M3c3cVVE?=
 =?utf-8?B?OTNJdVdvalVnN0RtUUZVclgrRjYyVCthVDV2WUp0SFFxMlJKL3lDRXlmcUVC?=
 =?utf-8?B?SVRwUWJrOGtJVFF6Y1FTSHZqalVsVm00MTBZeFhSSDBpSlVjZGdzZ3k4RGQ3?=
 =?utf-8?B?eVNVcnlxbUNQQURNVDUvWmRVSDNEaU5lak5sQUQxRUIwSFhKckRmcjFHWlgw?=
 =?utf-8?B?eFgveDVqVkhtb1gvWDJKZ2dkUWdOZEVGQXlsbFpUaTBwSTJmQVA1eTNBL2Vx?=
 =?utf-8?B?cFBtK3ZQTGx6Q3RwQzZxcTNVSTZQUkk4MHNRcjI2WjNmQ3hBQVZhZ0t0S0I4?=
 =?utf-8?B?eG5Mcmc3UUl1dmtRTWV1Rk81Z3g1NWM3U09IN2JSZHRSNC82RjNpWldvR0JB?=
 =?utf-8?B?VkU4OTd6Vkg0SGt5S1ZTTEZNa2pXYjVLVmJVaHJhbDB3NkExRUxFWWowcWd5?=
 =?utf-8?B?QXFmQy9FSW9LSFdHeStJN29wMUNORkVnemVZVUVRL1B3ZXRaMFowMXlWa09B?=
 =?utf-8?B?V2ZhNSsyb2N2YW9MajFLM2JEZzE1VTBnSGNwWEF2QVd3bEtCRkxMSXJ5VW96?=
 =?utf-8?B?WVVpNTVKMHdMeEg2RWxTQUxHRHZ6WU1WdTFSRG10Rmp2SUhHMnhIMWEvL1Uv?=
 =?utf-8?B?WGM3NzRjWUErOFpLSWREaTh4WGtMTkM3bGhoVHQ5T3ZuaDA4NHhZRjBxN2FK?=
 =?utf-8?B?alMvMVlURnRYazRZdmVsS0dpRmdQM3lMVlMxRnUyWDc3NWxqeFZrUjRueTAv?=
 =?utf-8?B?dWp3djNOR20rZkw4NHZ3akJocUxDL3Z3MzBNMVc5anVSMkJHcjFyR0V1MTFr?=
 =?utf-8?B?SVQ5UzBZSlNtOGljY3hHTUdXRzBmL3h6M1FvUEZGanE5Qk9ta3dXbFMxMGVX?=
 =?utf-8?B?VnJSUUYySmVZcTV6TGhBNE5NdlA4RStJMnNmY2g4aFdIOGRXZ0dxQTFTWXI5?=
 =?utf-8?B?b2hpMUwyeFZ5SDFyQ0prQm9zbGlWUlFqTTN1ampqZXpXMXNxaXZiWml1a01X?=
 =?utf-8?B?ZXdXNjRWeHhLOVBMYkplZXYwQ0QrL0tYdnJjUzFLQXY4NHZyR01IdU1jWGpn?=
 =?utf-8?B?UmxNU3JLY0hFV01oTHk5bXRtM1ZvMWdPdUQrZ1dOZzB0SW5CUmtBRFZBVTgz?=
 =?utf-8?B?Nmt4bmEwYytaV2R2Y2RLZkU2VWlyVWtJREkrR2lOblRKUzJIRURiNXhQNDJU?=
 =?utf-8?B?bzZnN2ZsT3RwUG1zOUEzRHRaa3dDcnh5L3hCOVVSK2pVcTBEYlh6djRlQnlO?=
 =?utf-8?B?WXpQMldlek5UUTNCZ3dvM1FtREdHenlMRW9uL0ozOWRPY0puSmxocFlVUVcw?=
 =?utf-8?B?UXMwYjFoZ0U2ZnltTDh6NDlpZ3lrWVU1K3BESWg5TUhiaXVnLzE1bHZHaDIr?=
 =?utf-8?B?UU5pR3ZjeUFpZlc0bjNRY05QKzQ2S3VEZEdZNkM3RDBBR2pCTnk2SE81Rnc1?=
 =?utf-8?B?SERic3lkWTJpY1JpQk4zUkVhYy9TU2h3ck9lb3BxVDZFUlFtbnFwOHVOYnpQ?=
 =?utf-8?B?aTIzbDhBN3g4U0xXNlBWdTFMbmY5cFF1QkIzV0RGaXRwZHRGL2NoTFZtNmE4?=
 =?utf-8?B?NWlIT1VTMVhFRXJ0T1BIM2FtTDJaQzlMaUVwSjFnb3BPUENYbk1ZZ21vWkZR?=
 =?utf-8?B?allDazEzUWxOYi9EMnhLdWtVT1hQd0RlQXQ0b0xYUm80eDhEb051NHdOS21Q?=
 =?utf-8?B?TUdKUDNWbWJCRjR2S2ladHdtYSs0b1pVS21KK2d3MTduMWFJdmJpM3hneVI4?=
 =?utf-8?B?YjlyU2xUQlRHNy9OdTZITW85U2djazBhcndDSVVrSm5WZys5VzArUHdGZStC?=
 =?utf-8?B?enlhUFlQNlZicG9jN2xWdlZwSFl1WFNidyt1dkJFREdMNFZCWnY3eTA1TlEr?=
 =?utf-8?B?WUIxblpRS2x6UHJuZXAwVnFWVjlWeUU1bnkrNjM5V3d1aVZjZVdxcHJiUDRj?=
 =?utf-8?Q?AV9G7W6H2EQA+iqYYuh261B8v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e241f8-7c8b-4930-85b8-08dcaa047f1c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 04:12:27.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWSKJLoTIXZn5j+nN8jzlr/G6yh19R42IHZadyysrtQnHsAICEIK0tOM7ZeIXCmKpIuNT0JUpIFjbG1dqsMSRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532

On 20-Jul-24 1:51 AM, Yu Zhao wrote:
>> However during the weekend mglru-enabled run (with above fix to
>> isolate_lru_folios() and also the previous two patches: truncate.patch
>> and mglru.patch and the inode fix provided by Mateusz), another hard
>> lockup related to lruvec spinlock was observed.
> 
> Thanks again for the stress tests.
> 
> I can't come up with any reasonable band-aid at this moment, i.e.,
> something not too ugly to work around a more fundamental scalability
> problem.
> 
> Before I give up: what type of dirty data was written back to the nvme
> device? Was it page cache or swap?

This is how a typical dstat report looks like when we start to see the 
problem with lruvec spinlock.

------memory-usage----- ----swap---
used  free  buff  cach| used  free|
14.3G 20.7G 1467G  185M| 938M   15G|
14.3G 20.0G 1468G  174M| 938M   15G|
14.3G 20.3G 1468G  184M| 938M   15G|
14.3G 19.8G 1468G  183M| 938M   15G|
14.3G 19.9G 1468G  183M| 938M   15G|
14.3G 19.5G 1468G  183M| 938M   15G|

As you can see, most of the usage is in buffer cache and swap is hardly 
used. Just to recap from the original post...

====
FIO is run with a size of 1TB on each NVME partition with different
combinations of ioengine/blocksize/mode parameters and buffered-IO.
Selected FS tests from LTP are run on 256GB partitions of all NVME
disks. This is the typical NVME partition layout.

nvme2n1      259:4   0   3.5T  0 disk
├─nvme2n1p1  259:6   0   256G  0 part /data_nvme2n1p1
└─nvme2n1p2  259:7   0   3.2T  0 part

Though many different runs exist in the workload, the combination that
results in the problem is buffered-IO run with sync engine.

fio -filename=/dev/nvme1n1p2 -direct=0 -thread -size=1024G \
-rwmixwrite=30  --norandommap --randrepeat=0 -ioengine=sync -bs=4k \
-numjobs=400 -runtime=25000 --time_based -group_reporting -name=mytest
====

Regards,
Bharata.




