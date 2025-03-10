Return-Path: <linux-kernel+bounces-554721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614A2A59B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87327A9395
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC665233707;
	Mon, 10 Mar 2025 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BkyVS9oM"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACF022B8D9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625184; cv=fail; b=fZd9sFMT9R6gMsRQDsy68v0Zq/VkPSTKw9j1iGMgKKWpiHowqzEL4EfpPKo47+mSfd587cMA8rBfpqb9/1eJ2gHf0chWrFLDDPb5Ds1t3nUqbXLs7oU44BJ0pbDZ6EK0+Yg5HbC5Xa5bzcjtuSG2umwW7YTEvgyWeSgYLn2YqVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625184; c=relaxed/simple;
	bh=GRfpKgA2L+fPG7AYPAdoyUVRLgbIIPaHvEKTbv7lE18=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUuHIv2WLssS05COusYJYA4UVSBgjV3VZ5BwNGOOisYbIycGG9YUqkFRMs7zhAm389DrI8ESBnMS12sYyNCQ6N0JQkYPOqJEgpU1NDvi28e8/C5ljt67uJBd13+q9rbRPWh2lShwJ74zB/DbgvhJdAVUzGuNtlgtCW67PUUpnlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BkyVS9oM; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yx/uY4JTh5pP7wi23foRqHG+jY63riXsc1qR5c3l3udY6na4Ucy2bjro8rwCDLayCb99pEbgcOzHMCopQZreVWPGGqU8Uwy01mcxPPQxK+/g3RS1whbalHEie+nWb90x8r3Mk5cHLSVS4EseVPB0c9PPubyOhAX0hHDNiIT4J5HyhWdjHyYYfTXUKWty3BjazPW8rUnwS5Uh+gknwKCbaq6xZFcNmhKeRSAZSzz2eCGHK+f4VJJMb9SpbKY9V85uZ+cYkogQ6iQP5ObhUJZKJiSXo0NqzQJk+Tm39nt1lhGXsoL7s/m6+B93xfxH6odE2krQA/RC8X80VYc+hXlboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzZu3YNzd2ym9kMZwNpI5ZV9lfWivzE1HBRF8axTQhQ=;
 b=C3Fi4cL6hIuKN7PqR20yKASUIKBiYRzWsLaVhzGwbCu0UgMrhqK31QGcQBIHUTZ2uFfC6r5FGV3DtOm9xgeyvudtnx3Y2NN5W16aoh6G7FfQnhHwbDxl6gHye7nCuxX/isMP6b5ywCvsLClPDyuT4fDSDMArh9BZuyLf2tf3OSwKWGI17Bx7Dh6JKktZGKncj5kGYFBtGZt2jZ7FplZibruSz3rFC6QAgYu04n6INlHxTwnfrMuoq/XkxtKbqPJNu3h72UmyedNrRLOT+1vMziveZOJ6OKdeRCxVM6gLzCZBEDrmJxvs1QvQu8aHlwU3No5MLAR9yL9H+Zky5Z8A9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzZu3YNzd2ym9kMZwNpI5ZV9lfWivzE1HBRF8axTQhQ=;
 b=BkyVS9oMzRImTxZSIRgIdBWUtr5RHkVnpaQOn5PQ4LtgSxlZLSPO/6uAWsfdo8eXhZSEuJGusqLRh3yVB3ShrpYC8uDcd3xZBPYuNF8pdBdmdHk5bPqAVvjiMCLAV7oiNfT3+UtH/HiVobvFx3T9jHI5IwGE9xxMow3e/zrwnQQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 16:46:19 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 16:46:19 +0000
Message-ID: <05e39b53-8e2f-4e21-8106-028fe54c37a0@amd.com>
Date: Mon, 10 Mar 2025 22:16:09 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v3 7/7] perf: Make perf_pmu_unregister() useable
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.525402029@infradead.org>
Content-Language: en-US
In-Reply-To: <20250307193723.525402029@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MW4PR12MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a94465-9499-4352-d72f-08dd5ff314fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjVNcTRaTDBrbFB1WHJPMmJiNFRuQTk1dmppTW5nZDhJeEROSTk3V2ZuRVpC?=
 =?utf-8?B?N2JXcFIxNEViVlo3TVdhcFQwUk5OV1Z0UWJNNksydkNKOHZFalhGQ1VjSHdD?=
 =?utf-8?B?eFAvU3BsTFg3N1ZtQm5Yckw1c2xzNGRHRWdpQUlta29FWVdjREEzVnhmK3NO?=
 =?utf-8?B?Z2xYNE5sSy9MVElvOW1vTVpIWkdENVFuVksrRDRyMGM0blROWVpYRUJFMGZ5?=
 =?utf-8?B?N1FlcnB5dlJka3ZzcHVjQzNzMHZ3cHYxSVk5MlhZQ25pMVh5MmY4VG02bVRj?=
 =?utf-8?B?ZlVuemNDQk54QkRTVFYyRzJxeGVCS2FuWmtlUFQvV3UyRHF2dERGT1J3YmdR?=
 =?utf-8?B?UjRzemU4Wjk1cEdSSnA1ZHI4T1piYXJKMHpxcmxFcmpvZU8ycG1hMEZ1YzVt?=
 =?utf-8?B?cGtldWpvNkZrcFdqUDJCN3FIM1FJdWthWEo4QVF0aTNlbkxFWnpzV0R5VnFD?=
 =?utf-8?B?QXJaRXcvempObnlPNC9JT3JOUXpkQjdhb1NnQjEzZWZoYVNqSzJEbnNHL05X?=
 =?utf-8?B?TmErU0h6Q0dOZEszWURRZ0NBTVpyOXBEMHlodTNJbTlCMVpKclZ4VDl1dlJ0?=
 =?utf-8?B?YmRNNklyN0NuUzJoUjlTVlZLdDhwWmx0eEpxOG1ScFhtWTJ4ZmtvQXNsL1hO?=
 =?utf-8?B?N3JaU1RIRzdNc3c4MnJVdnNXamk0bW41RUpieWlWZFdSYnJjaW5uNTlYbU5p?=
 =?utf-8?B?TkptaytrbERBUVdQVWZ3VVJzUnpUTStUOE5DOHFhQXptMXZvNE10T1Y2L1I3?=
 =?utf-8?B?L3pSejdwaXBFbzhnZWpTUnZSdmNsMG14L2IxSGRhdC9SRkdXNGliZkV1azhV?=
 =?utf-8?B?Mnl3Qmx6NFhMTXFJeER4SFZJVlg3RG0yM1RCREZmUko5WHJCaTlndmpxUGxM?=
 =?utf-8?B?SmprdEwrVk5aU0RsNyszdVo4SkRGRCtGQWNBVFVsVE1FMlREV2UrMEFRQUdI?=
 =?utf-8?B?aU9YVjVMV3J6Y2VtdVR4M2FORS90R242dnd2QmVvU3RNWmVHRjl3NkJjSkF5?=
 =?utf-8?B?L1hVL1NmbVM5dGVZZEt0cGZjR0MrYzRHWFMxTndyL1VDbEJ5b0E0c0pWR084?=
 =?utf-8?B?S2hKNnZ5cmx1OVZTdW1aS1loMHhyNG9WeC9MYkZIVWE3WFVPWjdpSUxjenhY?=
 =?utf-8?B?WU4rSlIyYWlmTVNPMFA2dE9Ea1RZUXZ4anRRcUMwTG1qL0YvZXJZLzNRblhW?=
 =?utf-8?B?VGRpQ01jd3BDcTlHNHp5bTgyRzFCblN0cGp6QkNBRTZITXZBaG5CQUYzUVNK?=
 =?utf-8?B?TnR3NllGRUZVY0pmWjFCVnlnZmZDWGRacEQydUpRRVM1a1NVTTkvOERITUh4?=
 =?utf-8?B?TEk1Sm5MYnZ1QTBJU3owTmxScUgwZW1YSDF0VGV6RzRraFErYzJtc3R6OHk1?=
 =?utf-8?B?cVpsZXYrZDZDRFVkWmlZNWVaN0dxODBacU1iK3VvWkg4NjhidUNUZE5IWDFN?=
 =?utf-8?B?dTBJWUZFSlpUS0VFWmtwZUlaNXpBdjU3dEx3a2dOM21lK1IzOENRbGpMMEFL?=
 =?utf-8?B?djRqcDRNVkc1TCswV1FKMFJ6YXRIWnZVV2NTYlZQUGhGRFZuTloyRmNqVERp?=
 =?utf-8?B?NWhHc0FBZ0RTT001QUZ4K0ZFcEgzZWMyYVljSUgzSXZ0VjcwcjJQelNCemsy?=
 =?utf-8?B?STIveXkzZzNFYU9JRE8rZGhMSzh6NnJEa0pLSXRzYmgzZ2x4ajVwcFo4ekJX?=
 =?utf-8?B?UGdaNE9pazFuOTJrSGJaYnluQ3RNb2lwN2k2QXZHNkMvbUlRa1lGcW1DVWd0?=
 =?utf-8?B?TkFQaFQvZDF5ZmdzemgwczJ6V3JhMmwzUWIxVjQ4MHZrdFdpRHRoQkJSSVVm?=
 =?utf-8?B?ZFVsOXNGMTZtUzF2bzVENVZqMGJySDBlOVRWNFFKNTJjZkZtaTc1anVxQUlB?=
 =?utf-8?Q?iqGCmZVV+3qMA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUwyN3FwMnRrSWJheU9COFlaNGZGZUlMczF4K2w3L2x6dE9WSGlJbXVtMUtW?=
 =?utf-8?B?Zmhicyt3am1RNnRSNm9qZGRjMldkVGtqTER1Sm1Vd2Q5eGp5ajlpSXRVOTlD?=
 =?utf-8?B?UU5yV08wY2czOFBzVGJNU2xBY3g4dTBZb0J5Vzh2OUR2VzF1TzZuS0pmUHV6?=
 =?utf-8?B?K1pVbWdpNG13T2dhUDFTdk5aQVN5WnZVZzBEWjNYM2xjektBRHJqVTBoUTF6?=
 =?utf-8?B?QzNpVDNhdzAydTRoZCtUcU9BRWdqVm5LY1FWR05xRndSZ1dNRTlkL3pLdkY2?=
 =?utf-8?B?YXNaT1RmaXIyekdvNnlVWjltcjlUR2RzbmIvMXh5ekp0bUljbGVIdGdlKzNs?=
 =?utf-8?B?dGtZSnpEdGxxOVBCbUFYT3RJVnF4b3pHbmw5YU02UEF5MzY0N2tKeUwzd0w1?=
 =?utf-8?B?UGpPSGZCNFphN1V1MXNBTXFPMDdaUmFhTzJ4bTJubXFwYU5HNnc2KzhuK1FY?=
 =?utf-8?B?MG0rVHZBZXNEQVNZU05FdnRmVXdPUjhwV25WTndLcm44ZytObnZIeWZVbjFC?=
 =?utf-8?B?WVdDOUhtUU9pRnhxbFpQdWVQUmpEZTZTQUtVNkhxVUNJa2F2UlRGQVlSd1lR?=
 =?utf-8?B?WFNHMzVLcTE0SUpSSnZEdFhHZnRERUt3UHlvYy94Z0ExdjNMeGpsd0s3a0tD?=
 =?utf-8?B?NnNsMklidUErTXJRZzUrU2JCVlZqZzJVblJuWUg0YlVqZHlRL25HZFlRN0JW?=
 =?utf-8?B?T2FUS2dUOEQwWnloQTlaN3FuL0phdkpZbFhUdHlrOTdTQktBNWVSQ3JBS1V2?=
 =?utf-8?B?UTUyaEora2FmU3ZrTUVaaU5oZWNoWEJTTmRCNTV6MzR3ZG5iWmlmbTJLYkZG?=
 =?utf-8?B?U0FJdmF3VVA1Tk9JTDhmWktwbTZoTkEvTEc0TjVlMTE3LzJQdDdnUllxRUFJ?=
 =?utf-8?B?Zzg3VHhVSWpBb0JRbmVFY29oK3A5c1ZhbHJMdjRNMVk5Ylpjd2tMRnhKWDNE?=
 =?utf-8?B?OHhKeE1oMFNWMDBEUmRPdExSODByb3hOWHQzVk1sVlJ1cTIzcE80WTBCOERT?=
 =?utf-8?B?ekpEcFhITUNzV2NMOFNEVWVkbXBldFdJQnFIcXFZTmZXT3p3OWh2QndIeVhy?=
 =?utf-8?B?dmtTUmk2MG8zbm9BUjQ4RXZNNE5QcFBSaEcxNzZqSEluZmlHdnVJeEdiQlpj?=
 =?utf-8?B?YkFBdjZwcW8rdjVzMzRsNUQyUUMydFJiTDQxMDR3MGdTUmJ1cGxtNWlzUWlP?=
 =?utf-8?B?ck9FbVhpdUhDclVtZ0ZSMFdTcU5qb2hsellnQjdoTGlFYjhnT3JLK2ljZkZB?=
 =?utf-8?B?WjFLdjZMV01kOVIxWHZjbGsvTnV5SXgrdG5XbXoycmFJNnMxK1I2SEYwT1pH?=
 =?utf-8?B?N1JrK3pLTTNVVlg5UkcwdVRmTU9NVnFCenhXM25CeGc2aXZ0N0FNdE4xKy90?=
 =?utf-8?B?eHFBMk9JbjVxbllaaGhmU29LdHdNaEVlelZQMlpRK0VDWDZKUHNWcVpVRGcr?=
 =?utf-8?B?MGRMeVBqc3Nlek5acFc3VS9sYmtyc3JBSlNJeS91NEVVcDFwcVBiNlhCTFFl?=
 =?utf-8?B?RElKOFJDNWNtdXJHc09KWDI0NXRqRmRQcTRRSjBoY0RBRlBIa0FheDk2WVFY?=
 =?utf-8?B?dXIrcWFocVJuZHJwTGNRLzV6dVBOOUhGYXN4RnZ6WkNPZk11RmladXo3bGNH?=
 =?utf-8?B?dEdCSURiWERaRVd3R3hKblAzNW5paldKQWVKZmxpMWdLZDE1THVaOTBMQVhY?=
 =?utf-8?B?clNLdC9tQ1dtYnJhZVhkSHNoYjA1L0JZenNocnV6TFBsT3g5aEJXZGR2aGRC?=
 =?utf-8?B?Tnh6Rm9teFNJME1kUUdrOGl6c1IyK3F6U2k3M1RkOW1QTHJRbEFKZU16dEkz?=
 =?utf-8?B?TVkxTlYxODh5cW44YXFUWUs1aU9yK0Z4ME1Zd05YMHUwejZ6M1FVV1VFRE5o?=
 =?utf-8?B?SXNRVm5ta0N1bnJXOTFoSk5rMXpibzlMYTdLKzN1NG1EWTQ5UGN5MytoWnhh?=
 =?utf-8?B?andxVnhXOE1ZSVo3bFM1Qk4vRVNPaUVGRXhIbTlVVXFzUG1FQ241eG0zTHN4?=
 =?utf-8?B?dEpOcTZWelJaRi9UWXZ3aEZnTjRrY2s4QWl4dTlqNjZpT2pxNlI2QWFhQ2lU?=
 =?utf-8?B?blFOUUNuNE4yZ3k1Smg0MERBU1VmcTR3ZWhNbktGMjBWR0xET2hIUFd5aE9h?=
 =?utf-8?Q?zbnR23uEY6Fo/Baz6pkZl3W8i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a94465-9499-4352-d72f-08dd5ff314fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:46:19.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kfX0m7OkMXYBZTbcDIdvDqpRUbLxgXhbatDDZwPePnVANmu5CT3v2E2v9jHBuL7mEC+FGw2mUMc6nDk204fhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

On 08-Mar-25 1:03 AM, Peter Zijlstra wrote:
> Previously it was only safe to call perf_pmu_unregister() if there
> were no active events of that pmu around -- which was impossible to
> guarantee since it races all sorts against perf_init_event().
> 
> Rework the whole thing by:
> 
>  - keeping track of all events for a given pmu
> 
>  - 'hiding' the pmu from perf_init_event()
> 
>  - waiting for the appropriate (s)rcu grace periods such that all
>    prior references to the PMU will be completed
> 
>  - detaching all still existing events of that pmu (see first point)
>    and moving them to a new REVOKED state.
> 
>  - actually freeing the pmu data.
> 
> Where notably the new REVOKED state must inhibit all event actions
> from reaching code that wants to use event->pmu.

I think perf_event_init_task() failure path can still race with
perf_pmu_unregister() and trigger a WARN():

        CPU 1                                          CPU 2

  perf_event_init_task()
    perf_event_free_task()
      perf_free_event(event1)
      /* event1->refcount is 1 */
                                                  perf_pmu_unregister()
                                                    pmu_detach_events()
                                                      pmu_get_event(pmu) /* Picks event1 */
                                                        atomic_long_inc_not_zero(&event1->refcount) /* event1 */
      /* event1->refcount became 2 (by CPU 2) */
        free_event(event1)
          WARN()

Thanks,
Ravi

I'll schedule a perf_fuzzer + tinypmu test overnight and see if it
reports any other issues.

