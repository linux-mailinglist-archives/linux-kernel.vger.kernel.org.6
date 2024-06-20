Return-Path: <linux-kernel+bounces-223434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 322D19112EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51BCE1C21127
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E573A28D;
	Thu, 20 Jun 2024 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GGzZ4Z0F"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CC41C67
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914630; cv=fail; b=g1gRhUuZj6SoLmZEhyv9myV3mjDe3zcD+GBrjYQPQdUUTnzsS8b3gZbkXqS8TMuChwm+l0SlPQZyb1XoeNS3y9qyEzwCA6M6ukcXqNaS4K5FOQr63WKgSB3irQo0YGwKIj6q1HvODuNW+YYMNiWzfvZI2nzIowfc53HGPehUeS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914630; c=relaxed/simple;
	bh=GGbPfNzLcXBGuXDkoMNxQYyptd7IdfPMqfALe7ZnRrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F/FF3jvTAK4PZS0PheYr4rHhV/zaVoqdep0kG2naRY89I2LHh6VlqbhqgiGmrMXbjUMnxfExnoF+Y938VcYEyiqhBvRIWJ+j08GLKPPFsveUZep+WFA+7PcuFygKbZOwojHVtFL4lf1LfEYSWlzaLEgFXn7hamSxn8jNZwjlgbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GGzZ4Z0F; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4XoxYR2WF5lCtnfehBLf3EeOxvQ9GjAKf9hUVqxrzufwbp58TQtAPbUqDbXNIZJ9R53F00qBylQVHweAbd4WIBNWE/jXEDhUYkcJQpaYZ1l+WlbNuFRw43dPG5dBLFFVTqLush2gqmC8srreyqATDhJ6ZqapFIl/MTgkQIBZMNJEMTKtJpYW9vDmf8u4O1qUrAJsFxrZVx+cG++qaoaoVWI8BDZRlzMEMig0PTZr6yMM0JxbSSJ6tMjrj4qBPCwtvvhKV/E49HM2ffaAacLdc0fvZVC5RpAhgheRLkleFzCs9Tvf0lbRzz6rNgwgmS6vgQsQuNv/R4n5SL3NGH6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgrGbufTk7UXAU1D0mv6SkQHDHqVWUlyjCXOwkEwtSY=;
 b=abmo59nAIj4KpxWImax46s152Pij/gOzZRU2XIBajJnctiTikEZ7SrFovni84PdSHKO2fodx5RSwwQH79Dbamf8tu0d5Ovuhhc5H1mONHzreupNJEq1luOTThwgUv/V1w1pHnWfDc+m4X0IYlJDGlwnL9stlLkdDdHIG+tbQAbrdP5OzJ9iNaL5XKdTIxKp1kLx9g7jsEvy+fPDrJ3cjMw3fKEQ5yxA2044vvpRi2kC6eLmNylYlZ6a+crdDIVLmNxtkmpIs+IBVBYDX0XQK1ZP3FwTmvFeqSH0I0XA2an20yMYTUe8UqvXzv7yRRq9bcJbxck6LhACGGFvLoCGvOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgrGbufTk7UXAU1D0mv6SkQHDHqVWUlyjCXOwkEwtSY=;
 b=GGzZ4Z0F/gVlCuS+mBGnnWRdNof/1a/ppYnXTKzw6y2z5K0rlhrA3Hq/tchntXbH87EASi84mLmQyWz56vOCVPp8gaIpBU0NRwUejlYpi/rvAF17nuayW6O5OLRmpsDakiaiYeoA/h26Ymg4ZIG86LxM7S7HFDiorakxNAoozSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 20:17:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Thu, 20 Jun 2024
 20:17:04 +0000
Message-ID: <117b2819-a146-476c-9533-43f40512d42b@amd.com>
Date: Thu, 20 Jun 2024 15:17:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lib/sort: Optimize heapsort with double-pop variation
To: Julian Sikorski <belegdol@gmail.com>, visitorckw@gmail.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
Cc: akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
 linux-kernel@vger.kernel.org, lkml@sdf.org, alexdeucher@gmail.com
References: <20240113031352.2395118-3-visitorckw@gmail.com>
 <70674dc7-5586-4183-8953-8095567e73df@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <70674dc7-5586-4183-8953-8095567e73df@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 77dd5b5f-5d63-4953-6995-08dc9165f3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3BvNjgyckc2Y2cwMkc3Rm1qQWRaTTROMmZJZGxLL0tYOVR0ajZYWFlVL3NK?=
 =?utf-8?B?YnpRT2hvYXFSQkhIN0ZWTmVZMkhXTEFLUXRDSEpoVkRRRUN0dTZtaVdCTEJm?=
 =?utf-8?B?VnBMdURIdllBdUFWS1dzTWYxNlpjZEVwT1VjeXcwTTNwOEt6UjRGOUIvUHlR?=
 =?utf-8?B?dlg1T2dDWHVUM3IzUUFWTVNocS9DaXF4YjdHQ1pYWC92SUl6VXJsL3psVVNZ?=
 =?utf-8?B?UG1XSjc0bm1qQWNPQlF2TVdYaXVxL3VueFlMWkJRblJyWmlXUUx1YnB5Mm1z?=
 =?utf-8?B?VTlHeDc0NUUzOVpVQWNON2p6WUhscXlwc1FsY3EvM05hTU0xeHJQMXNtak00?=
 =?utf-8?B?QkUrcVlpUklQVDJzblRwYTc2NC9vaUFOWXZUbnNmRXI5cHN1Mkl0NHZMOUNo?=
 =?utf-8?B?VCtwYVA1Wm84S25HYS9COGxyN3NNQXo4V0orMCtIdVduNnBxeDhNWlYrQ0w2?=
 =?utf-8?B?dTRoN2lVNG13RHlKYjhOUG1NRjNPM3NkVTNTQlJjRVpLVkZVR0hFdysyQlJQ?=
 =?utf-8?B?WXUvWmlKMGxsejlkT2RpMDczU1JOOWk5bitTZk9teWlGa2NsYi9ZazBIVEll?=
 =?utf-8?B?cTNkUkhNODRWWDlINWVKY1dtWmRqMWQyOTFHYjBsbmJXaCtwbkdYQ0o5b3R4?=
 =?utf-8?B?Q0k1dHJ2NlE3T3I1WWpoeldZZFIxZHN4L09SYTBsdFpSbWdwSEt2NWU1bUpu?=
 =?utf-8?B?K0VuTkc4U044c1dPdGUxYjVwcS83dHhUMmJiWldNRU9YT0R4NFlVUWdVN0g1?=
 =?utf-8?B?QXhqR2ZQRW1oa0JOaFdNcmxzdEkvVzFMREdEdmh0c0t4M21nMEtoNWdEWWdR?=
 =?utf-8?B?Y0NiUUJqcmtWd01YdVZGNHVWOWFUWU9PaUJQSUVTY1dRT1UybUhiV0JNT3pH?=
 =?utf-8?B?NytqWGQ0WkJROUhkdStGdnFyb1dHSk5DQlhBOXc3YXB3Rm5CU0ZqUWFtU3Iw?=
 =?utf-8?B?WHpIZE1VYmo5QW16WDAxN1Q5MG5Sb2FYbG9rMUUvSGsxcWplT0lNd2RmaS9K?=
 =?utf-8?B?RHVWM0VQUWU1dHdlVlN3eXJremJ4Sk5KOW41RUpONndPTWExMmwvQkF2ZTlQ?=
 =?utf-8?B?ZUFTb1gzdGZ0UTBlbkVQWGRZTVR3VnFJdFl4bUcwMG12Z0EzUDVUNVdWY2s1?=
 =?utf-8?B?WnZJSWluRlE4Ukk2aFA4V1BJTXRwb1lZNUVMc3NZOGJtTnpIM01nZGJPYm01?=
 =?utf-8?B?UXdTOUNHUlA2ZmJrSkJnTjcvRGZsVlBNOVNBYWxyMVhOTVc5b3hCRHJnTlhj?=
 =?utf-8?B?WVp5cjVhMGkvZnJiaHJXeXY0ZllPajI1SkoycFU1bXplbmpJWVVmUS9wYmNO?=
 =?utf-8?B?QUZ6NUFSejJ0L1FYZmpvZlZ1QmFvL2xaKzFjY2N2eTFoRVFRSjFQUkNBM3pM?=
 =?utf-8?B?azMzakRvNnFtNlJWSzlNVUpVbEZlT0VFVEhrNmp4eWpSOUVBNFZOWFp3Wkda?=
 =?utf-8?B?aWlOSzZKMkJ3MngxYWRkTVpsd1VrK1pvUERFeFI3ekM3V3VKc1NaMm5QM3hk?=
 =?utf-8?B?L3JqWmcxZlYxQjhDVzFkNWsvVW8zYjd4S2NucW5kMC9IQWNCNUs2UUR6MlpG?=
 =?utf-8?B?VnIxa3pTcHRUQnovQjRUZnJhTG5OdGpqRkNQNDV0cEtwSlpKTUN2NkxOOXV5?=
 =?utf-8?B?bW5seXhmTmFDVVd2cGpiRTdYUFdUMWkxcmszOStkRzFpQnNOa0x5UGhjYjdu?=
 =?utf-8?Q?/QGLEWZ3QEvnOF7Nb0c9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2FCNk5CQlFLYjg0SFBzUUtaUTBjK2VCMkVaMjR2dnFJM2V6dlU2aGlYN1pK?=
 =?utf-8?B?S1BwWnRncXNBY2piTG9MM1dpMDhQalNZZnRZN2tpK3ZxMHF3K0Zta3k2Sm9B?=
 =?utf-8?B?cmlLUWtSSGRPYjRTY1Vlbm9mQTJVYi9KYVdjSGoyR2J5ZTRrTnQ4SXJwNTlk?=
 =?utf-8?B?YTdiNjhvMGtJRlBaZkNpNkJNcXlwNjB2c29jS0VLRUUyS2ZPT2FZVkV2VkhC?=
 =?utf-8?B?UjhHUlNVbnBRdHdWNnhsRjhnOXNMZU1qekpEak9NNFBWdGt5WEVRY2dmQVhp?=
 =?utf-8?B?cmZGVFVoZHdQMm83WWREQ1cyRThKR1l4Q28rTXpaZHRkUmllNTZjOWxQTmVo?=
 =?utf-8?B?cEhqTk1ldEJaOStJOTRiL1dyb09IbjZOQitlMDBIb2VRenNYWHdLMXpuc3Yr?=
 =?utf-8?B?aGoxa3hGSDQ4WEMwYVVDL3FjOWxQL3pLeTVzdXFlaEJjN0w1Mi9BNzFDcGZ2?=
 =?utf-8?B?bXFqQnN2TG5HZk5qN1NDVlF3ZVpKZ3dZYzM4SFYzUmEzMDg5RUVPQkFFNEo1?=
 =?utf-8?B?Mnd1d3h2aTFvV0NsRTFRZis5UUQ1dTFMSXZrSG5EenZUaTJIZTI3VVRWd2tW?=
 =?utf-8?B?YkhzcXlHTjJLOWVHeGY2UE9BSWQ4T1pPL3NFS2tCbUxMMHRNUkpZSCt2aVpa?=
 =?utf-8?B?NkxyWmtPTEljcVVQaEVNN090dGRXOGJiVFlMMEQzRmFXQnZ0Qnlxb1JpUm9k?=
 =?utf-8?B?TFlhN2d5WUlmOFh4Tm1UTmJkMlVjTFZwd3B4L25RSWdSUmVpTGlJNFo2UUhD?=
 =?utf-8?B?M2NmMVd2aGlGeTFFd2Nvd3lRY0FiWWIyMEg0Rm1DZ3p0QjFZYmhhRFZzZnBo?=
 =?utf-8?B?NkJDYm9lWU1yZkF3cjV1eFRuU3cvL0pTYnJSUGtQaktFeTlzZnZJOVA0bjlq?=
 =?utf-8?B?UU5UYjFmbTdldTExUnA1em5xb1pRMk9uOGNDK3dMOXdnQjdoS0tNOVQ2T2pi?=
 =?utf-8?B?elh6dEx2WjJ6cTJLTE9DT3ZkdmxvaXp1SWZVdHhRbE5TOEtqenREVGZMSHQ0?=
 =?utf-8?B?UXpuREhySWNoc1RjUTFvVFNzOEkvL3N6czRxQUxPaE9UUW5PL2w1VG9FelN4?=
 =?utf-8?B?L0N0a3Z6WkNURUJacXJ5ZWRmNEdjeTg1a2lDZXlRNjZQajVkNEhoTWdSOHRR?=
 =?utf-8?B?VUlPVUhwcVJHOHgwa3lwZkhGczJ6OXN4MVJpNUxlUTBqQW5sSlpsSXByRU9r?=
 =?utf-8?B?U3FmMGwyYy9OYWhtb1Bnc0ZhSW9XNlhjdzh0MjE0MWxDZ0NrZDRqM2lJcW1l?=
 =?utf-8?B?KzBJVjdGTTVHUXRvaE40Nit3TndrZTFwclJjZ09JbXVJd2hZamhOazFZYU1S?=
 =?utf-8?B?QXFDRFlveWZNbTU5Z3BJM0VLZmN0RExWOWRseUJPRCtpTE9LbWdvVzgzN3pJ?=
 =?utf-8?B?eGUrU0xJaVQ2OUhPdXlZWk5rN0FVNGVtSWJWTWtDOWtqT0VEL0YzOEhRWXly?=
 =?utf-8?B?ZUllVUdDY3lSbXBtWW9yVHFVa3NaN1BIZmphTEpuNWhyVUNpZ0RlNnhuNDBM?=
 =?utf-8?B?N2sxWCtaYWMwbm83MVpYdStrSTBiMHJIVkt0UHpNb0VMM3B4Tnd6YTJTWmFI?=
 =?utf-8?B?cTQyc2pWbjNRaFFaVDE0V3ZiL1ptQmNpWWdLOWY0MWRvS3JDb1c1bEhUbUN4?=
 =?utf-8?B?Ulk1VE9La1J5Y1Q3YlBsNnBVT05tWU80akNIQ0YvWjdpKzV0Z0pEODBsZ0or?=
 =?utf-8?B?aENvTUlYZW1PN0J5ZmE3VzlhQWRhRm9XcGZScnFxRDYyVm9ZcXQ2SjlwL3Zo?=
 =?utf-8?B?MVVueDdIajFibmhMWW1EMkVkV3QzVXVZZFFrNWFxR0ZHcWhqZUJ0WVJpSkc5?=
 =?utf-8?B?NWVXRy8zRUlkYVFRWDM5bkhheGNvWmJZOC9zU09RSzZCMmM4SVlsdkZSSjQ3?=
 =?utf-8?B?UlNYaks2RkFzUGJPVzVlUlFkSS9BbFkwQWhLKzkwWFpPc3lwbWJaZjBMQ3Az?=
 =?utf-8?B?Tk0rbGw0RkZyUlB1V3krVFUyUkQ0Z2FHVk5wcHE0eFJlWkV3Q3BVcnVxeUlw?=
 =?utf-8?B?SkFCMWZKc0liTlFUeUN3UzJpZUlNMWczaisxcXV4Wkh2SDhkU21LNmZ2NkNC?=
 =?utf-8?B?T3gxMThSSkZ6SGRHSG9ER25uTjRhbDlYWmNHbDdvSHJ4WjcwY0tYaG5kZHVx?=
 =?utf-8?Q?swIk9UA09GNjDwXSccdsC5xux?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dd5b5f-5d63-4953-6995-08dc9165f3b2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 20:17:04.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgrjpIs/RQIo5lu3PIGURBoCy7CBe8Q3AmBna2DMKziaM4jcq0BAzN/+/jtHBQE4dtV0GJnkQfUgu27UyQiP3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694

On 6/20/2024 10:36, Julian Sikorski wrote:
> Hello,
> 
> it appears that this patch has caused suspend-to-idle regression:
> 
> https://gitlab.freedesktop.org/drm/amd/-/issues/3436
> 
> In brief, my laptop fails to suspend completely with the following error 
> in the log:
> 
> Jun 18 12:42:20 kernel: amd_pmc AMDI0005:00: Last suspend didn't reach 
> deepest state
> 
> Power consumption remains high enough that my battery has already 
> unexpectedly drained twice before I noticed something was off.
> I am not entirely sure how changes to sorting function can influence 
> suspend, but it is what it is. 6.9.5 as shipped by Fedora 40 exhibits 
> the issue, 6.9.5 as shipped by Fedora with the patch reverted does not.
> 
> Best regards,
> Juliam
> 

+regressions M/L

#regzbot ^introduced: 0e02ca29a563
#regzbot from: Kuan-Wei Chiu <visitorckw@gmail.com>
#regzbot monitor: https://gitlab.freedesktop.org/drm/amd/-/issues/3436



