Return-Path: <linux-kernel+bounces-374955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EB69A726F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73149B22D11
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F1A1FA272;
	Mon, 21 Oct 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mhmk3pl1"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CE1DF754;
	Mon, 21 Oct 2024 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535720; cv=fail; b=Cyf/SjDL1Tl3P8kACf5ZTMTNxv8LVKwph5yvnqFftbhPn8Icc/I073ypKWXkjxOEei84I/eYajAahlVp+BrNPSAkLEyrUYGeLbBU+fyV0as1ZinJUBGnD2ywD0T2W/GKJll8JBcS0zs6oAw0CA+zoj1l3hDhsReW7RLorVCWlx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535720; c=relaxed/simple;
	bh=MMlDXKxDCjNdishBlnTN0N/dE1xcK+48cU+efMOQNKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UDIXDVucBLJPfY4KdnDL21j3h0ckZzZMKXtzXdv78tFgQu3LRU8d0gTKgvbZryc/7UsjHoq/Vd16LIg+3GYWH0BpHFjFmXWp5PoKGOgbugvykYR32vyYyTHPzhmfoztBLwuZhcLzYEovzzQPLHkDM+29bZAWYcCwl09TlwQjBu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mhmk3pl1; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lg2bTgka+Z9wxLWCUdycbMMb7MubB7le0tygCWxgZ+dqSYpsQ3Hs0Oxi1xJ4/3Z6IAQ8OIP1R/88Si6e/9EK0PFo+RDCyWmFFfKA9Ad/DmkYHw7yQQipBMJly/RBSwIr+rq8DUxu8WymrAZmq9nphybkjyxy70/CZZ3sbgXA1VFAi8sbVFS2yhI9V5dS8y4b37uOup8HDE9jBj9F/mAOkjirVwRW+5wAD0a9dO2IA5o/GYVsfptkIyNaQGDGabn2DouOwiEqQRmhCF9i3Uxb084fGxO41qQlDnrr9UlsH9eF/uD0AlaMGeCx8qqeH58aMmDO1SjWjaT6aBy2nTf8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+g+gjs4L0XFYpAX4TwMdymf2vlqY6D8v6pImp3Z1Vrg=;
 b=QAkkAl248g/2cI3/is4LSr+n+z7foDtaDB2kWTbUJGepGjd+5DW4j394VNAO6AuRwsGAB8GpGrqXLcLpPkRd/wO7ZGEXhrEOX6a5MTymH9spXxWg1tPyvnJgAeExPMQKXBdsXBCYfhn2RwyJiT/f+pukd+G6jw+DwyyQS1MrIf5+zjGf0WuYRo+ReRnYjk7jvtwvlho4HJlwoulg1isPFoetIoojnrYygvSMRrqy8n9zyMlFHXxElyi61xwdIE5IVmJu0ptOCiNaXTWZmmq2TPUdIqnbl64jH4Qyy7vNFBwzWcjde+wt7NAoV00tQrCmw/NxS2RawmPWUSExMgtttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g+gjs4L0XFYpAX4TwMdymf2vlqY6D8v6pImp3Z1Vrg=;
 b=mhmk3pl1vvh7rsVutqx9K9CpoPmTaxt9Z1MvpeZs/mCjPXOeuMIIiEQKldd+1+hl63I+IhqThkvHpzi3/oEgILSCgFvJOHc/5i0Vuw5IN2NWrjT9ZM5h0BoRWi1rLhxMByryhgSypgJ7ceiLVELfWiZzVDlzn37egGBOIg6ud1/+w94hdBQH67lts3rdVs/G9qHc/FBcpmPsB2pfsZpvulsIYGtHtLJ7r2m4CXdm1ikn5+ic74eOS9+x695RHF4romD0EIT5cYlGz038KU1GjfuEggBxdx1ICNDZiKjBHa20WwUkOFg0l8giw65fViuuaQcyqg5HW84iCaaHLf/vwg==
Received: from SJ0PR03CA0132.namprd03.prod.outlook.com (2603:10b6:a03:33c::17)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 18:35:11 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::f6) by SJ0PR03CA0132.outlook.office365.com
 (2603:10b6:a03:33c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 18:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 18:35:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:34:54 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 11:34:53 -0700
Message-ID: <dc5e7653-8d6d-4822-9c29-702ece830717@nvidia.com>
Date: Mon, 21 Oct 2024 11:34:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-mm@kvack.org>,
	<rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
 <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com>
 <CANiq72mW8seB=938XZM7bwdSU43z0eePXinE5QPYyybvNfbUeA@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CANiq72mW8seB=938XZM7bwdSU43z0eePXinE5QPYyybvNfbUeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 2781720f-7b6f-4a6a-1efa-08dcf1ff18b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWh0dUp5SngyTmdwcnFvS3owNnh5ZmZRNDc2bmJTYmg4NWxTVFJVS3hBdjRZ?=
 =?utf-8?B?b00ySmovL1g5M21mZ0x6TjM2Y2dUSkJtRVhTVlpoSGVXb28rRmp4NFN6ekNO?=
 =?utf-8?B?azRITStTTXFpZ1o1V1FoakF1K0YrWlpzYmpEMzQ0elVEb1JXcXRWTGM2YmpV?=
 =?utf-8?B?UzVnc0RJamN2M1l2c25UQVpOaGVHOGtyay9Rci9salZFdVZCS1BONkxuRjE1?=
 =?utf-8?B?WXZwVW5SK3JNRFAwNElVUTBQbldtYXY0R0h3L1h2QjZtRjN5UlkxT2d3emxo?=
 =?utf-8?B?a29mQ3laVUovdHFSWjh4M3BUMGJYZEFPdGg2and1Z1dGTmhNbE16WTRZT1BT?=
 =?utf-8?B?V3FBRUhyRWZndStvOCtuUXpPdVdIaDNoNFE0THA0ZEQ5Y2JVa0laRlZOcXB3?=
 =?utf-8?B?MTlZODdwVkZ3V3Z0QlZVNWxGdldrSEZ1eDh5NWhXZTUrTXZhOStPMjRmY0pJ?=
 =?utf-8?B?bnhTb05KbGZyREN2OFowWXkwRmg0MW5kZ2RDdVNkZkhYOXRsTFN0UXZkN040?=
 =?utf-8?B?bE5kbk5waHd4N2JwS2FUUllEc1owMVY0R2xUWDVEY002RHVGSU5LMnluUkpM?=
 =?utf-8?B?UnkvNWtad0pRaE42WFVWVVJyL0EvQ0JHSnMzMXdvcGkrcURyUU0zK21ldDdq?=
 =?utf-8?B?RlVhK2RsM25pQ1MzOWViRHpxM0tpYzVQaE9rU1hZVmREejMzNFNESHI5QUc0?=
 =?utf-8?B?Q3JpZ085YUVrQXdoVnZKNmpUN1g1bDQ4TVUvcVAvaWRqM1lEa01xVWllS0pF?=
 =?utf-8?B?ejZ4THI5Tnd4K283SEJlQW9OQTBCdzRZdWVBbXhWeWtHNjlnV3NhVENUMFN6?=
 =?utf-8?B?NmpZY0RvTWd4WE9jZnJITTVMdWJFc2ZYZEFndjVEdWxuRFp1MFcxTHVYL0o0?=
 =?utf-8?B?OHFucVFLMjUwemhTTHVoR2htQ1UzQkMzWUdjZ3NYa3V4VVdqRW5SUGZ0MzVF?=
 =?utf-8?B?UE1Ka3hva1dnOHhZbGNwQU9IcDFIWXVsLzg5Z0xjREp1STlmUm12WkFLNFNI?=
 =?utf-8?B?cE1GeEpyYWJidGNyZXA5Rkk1RUZGM0wvODZwN3hyK0libndUZlltMHI3c2E3?=
 =?utf-8?B?RDk3UXErelE4SkhrUGZyNDd0NHNSM2dVNkJzSHMrTE9ZM3FaRzlSeWVpVVpY?=
 =?utf-8?B?ZW5jUmh4NktyU1QzeGphNWJWaFUvdHJUOWVUdjJNWVBPU1VGTm9mNENvYm9x?=
 =?utf-8?B?cnRzRWxUYklrdVRiS2E0dCt6bUJWYjNqOGN5NU16ODVDR2J5MjNFM2FJdFZE?=
 =?utf-8?B?QzRubFBvQk1zMEl2alNYcTROZyttODJObk14UWR4eldOVlpJOUNzdjZuZE16?=
 =?utf-8?B?RlQ5b1lEeUoxMFBSOS8xYWNCa2Z5Qk9zMXM3T2VmelIzRVpYQittaEE4bklO?=
 =?utf-8?B?V0l1WHd4RkdnN1Y5eGd4eTl1SXJMeGNhbUkwYVhTN2I2a213WWVkMEE5Z1lW?=
 =?utf-8?B?NFBiY2RLNi9hK0s1ZzRXREpVenFBTC9hWnB0aTliL080YkZRbk4zcnBhc1ZO?=
 =?utf-8?B?eHBDZGFzRDZYcUlZVGZXd2lsWXl0cFhFTTJkS0o1MWtPT1pDdlFDRFVtSXdk?=
 =?utf-8?B?TWtzcFFrcVVIMUR0dFp2aGVpNWdhc2NKamk5UHJEbkYyYzk3MDhDS0FwYXFF?=
 =?utf-8?B?a3ROUnpvaTNpNnZid3ozcUZLNk5MUjBPMjNjYVp1Y3lJanp2UlZhUU80YkU5?=
 =?utf-8?B?QWs4TnJTNnlubTczNVdiandMRHR4MDRtcmxNZGROZTdOMm50c3R2MnVHbFBK?=
 =?utf-8?B?RDJkMmJ5R2p3V2FYVFQzV1Iwa1VuVkdKZnlaS3A4dWlnVWl0UXIyM1UzZVA2?=
 =?utf-8?B?TU9sekRUTGtGRVZVZTAxQWlkOW1DR1g5YWFnZVZtRkI3NHA0c0ZZNVh0UXpo?=
 =?utf-8?B?TlZKZWxkYko1cWlPL2FyQmU4eXRja2J6UkhDeVBXNm14aWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 18:35:11.1945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2781720f-7b6f-4a6a-1efa-08dcf1ff18b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350

On 10/21/24 11:29 AM, Miguel Ojeda wrote:
> On Mon, Oct 21, 2024 at 8:20 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> Silly nit, but I did start looking for brackets that aren't there, so:
>>
>> s/Brackets/parentheses/
> 
> I noticed that too, but I checked it and brackets is the BE spelling.
> So I left it as it is...
> 

Is this another case of C and Rust using different words for things??
Wow. OK...

thanks,
-- 
John Hubbard


