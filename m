Return-Path: <linux-kernel+bounces-374997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B39A72F1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51E61C20B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC81FBC88;
	Mon, 21 Oct 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TBO6dTpt"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E02209B;
	Mon, 21 Oct 2024 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537770; cv=fail; b=HOW2iRe8Eb7ehbHm+CgOVA80pZKD8L38WD3PbonxHJw9S5gww26vjNqVlW/eQjG1RIfRD/Zw490FmiYePBzEAuOUzN60fZWBzhI/1UJOFzBHZACbsnj0fbRUHgpENT+o8vJnGr9X03zrPB/q2iRXRffWUesOxNZge6aBX6t2FH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537770; c=relaxed/simple;
	bh=PYQA4cj7amgAUwRtye7R6yC6O6RiU6g1exe3iTUOcIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tgsJjTjL+/Nn8yal9dCwqL/PIALHE9bgDDqbdqSNkY9gE7SLaf+I5CvNEDjZMpggIpgtxsmyHD66lzZpwMIE7OoRsOaD8rxbCu+kZtYwOJDuK5rawMPq0kbTKqSu5KdcYSWiQ1/zz3sH4+DoHt/iR3uA8+wqifFxl12ehQry6rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TBO6dTpt; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSU217JzUrv6SUW23sHZP/Uk+GmEFe78wjNCrdCTDzeim+eM8T3KFsByKYC2Q5/hjiPlg51pm1c7qDlC8MAQVqk4GIqODfj+s5toCMhv7DQuNbeDwh0kSdxUlAt8s7RocH3o1TPnOyfnJCvo3zsHPIb1TEhFIcLnu+qRKg84eQ4rz/IaEsRG5ehuBDD1hWNzNIZHaapA/GO0PB0KSakWo4e+660mhaWkxkqxxM2Gfx2avWKQRQlxND9GaNEtaACTWUbnHDGu8sqs/F+kmoR6MpG1+tGK8cd3kZ9cq575m0E9tSFWcDeKDw4cXthgbLVv2uCeE8JjE3W2LYgEKJn1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LML1kw4TWUFhcOyV1HopMa45wqLHDsCAn5y703ePfls=;
 b=K0SU2LG8bt2A0SQhy4XWWQ8WClVgc7yEIKdTHd91dJsI+ccNWdMzLOqTqS2MrJHzEaoYxwTIpW5uvMHT3jE0pepRZ6/3aJYEZINv44QbT8Oju/bi+R7DpilvSmCh7Ty2rI/Zo9tZMaklDSfRIfuhHF/MbHlkfdkL6UKPUytLJGnwabeZ4wiQ+LBlEBZPbP7mZXusdKUBT/G9YibHf3j3nKajFZwVo6VLcSkPio7q2r00ixfZqJcJbGisJ6krZgMv+2U7k9p3gHb/H0dGedO9vm2eJ+fhc3HO71YJBnNq+QiNSYHT6T7IHOJkED0jieVRedPFdr8z/thciCUBzqhWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=ryhl.io smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LML1kw4TWUFhcOyV1HopMa45wqLHDsCAn5y703ePfls=;
 b=TBO6dTptjo19OCe5u00JkmZ7onGWQzlyElEa+iuUKrKdzzvsA62aUYk1u1S6CMJnJHKj8YxAv44y4IQ1ipHNM/wmbeoIfP7Mg+vEfPgC51w1QiMnLR1duJ54waNpu14KmGpNogIHiCB9TDrJpwm1BFQ/N9q38yM3qmSBCjFAMWO7PC32n91dLgPJCq14on0j90ikULWAdrX6DmhNr3Gtk1LJJFyqqDn2X+pdmxwrMdQ0qShthsNXI60Y/tB/nzPyLaZWgmTtD7Zdzz8nG5S8zE7e0cLxCNnJmCFFyhFEGwLHdm//Ci9bclUIAaUsqpWG4YDmt9WwVWMuyv0EUHEXIw==
Received: from BN9PR03CA0730.namprd03.prod.outlook.com (2603:10b6:408:110::15)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 21 Oct
 2024 19:09:22 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::36) by BN9PR03CA0730.outlook.office365.com
 (2603:10b6:408:110::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 19:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 19:09:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 12:09:01 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 12:09:00 -0700
Message-ID: <682c97a0-9877-4e31-b180-c1e38d3bc883@nvidia.com>
Date: Mon, 21 Oct 2024 12:08:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: Alice Ryhl <alice@ryhl.io>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
 <dc5e7653-8d6d-4822-9c29-702ece830717@nvidia.com>
 <CANiq72kuQ-fNTYw33czgN3_DYjixzk01+hahFhR4QSkENeDBkw@mail.gmail.com>
 <b93805c1-28a6-4ad9-b0d2-5116ef4b0d83@nvidia.com>
 <afc139fe-ac03-43e7-a5c0-22410f1acea3@ryhl.io>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <afc139fe-ac03-43e7-a5c0-22410f1acea3@ryhl.io>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e1809c-c558-41b0-f755-08dcf203df06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2dHSjNzZW5jQTdFVHpRNXJNdU04Q0tmYkFQbTBXV21UcWRRQnRtbjdGUG9k?=
 =?utf-8?B?UjN2QkRTOVl1STh3SGRKSTVvYXNJdVZMWS8wdjlKWVVTcDY2UFpROG96c3pk?=
 =?utf-8?B?cWpwdENraE1NVGJBTHJhd0JqbEU5YlFIcFFjeXAwaG10YzhLWTZ1SWV0R3Q2?=
 =?utf-8?B?MnZkNXhJRThxZHU3VVR0NTljYkNFMWZYNjNBaFdhMTV3THI0MmpRMjh2OE9J?=
 =?utf-8?B?dmNXVkk0RGNkUnFxb1lPTGprd2JsV3M1THdWUWk3Z2dsNGhEWnhwR2NXWEdS?=
 =?utf-8?B?Y0QwR1k1c2Y5NmV3S1NEQWhvcHh4SjVtVjB1WUNaN09hV2YxendVNk1MOFRH?=
 =?utf-8?B?UDVKSkRSM1BReitvbTNkM3JZZ0wrUURhazdmYmJPQmpUOG1TY2VSTXNDY3c3?=
 =?utf-8?B?VHYrSzQ3ZFFPN0NTU1dlU3hzU01VanlKYUlLVThWaTVnWjlzbDlaSDlIOUx3?=
 =?utf-8?B?SzdRNzVVN3h4a2xva3ZibnBnVWEySFAzbXFqaWhpU0p1MEJncU9tU213MXpE?=
 =?utf-8?B?K2pWVDQxZDFEaUlxaWZ4MFFxdVg0b2YzMFhsLzgyaWNmVHNaaERiQklmNzdB?=
 =?utf-8?B?czhnNHpGdkVoUXh2alV4K3N0OVZWSS8wQ0xxd0VtY0U0Mlc4ZzlYdGxCWXdG?=
 =?utf-8?B?R1lrbXRWaGczUHppTEpNVCtid3crMGgzNElZOUY2dUxWK3VxU1JzenAxakJZ?=
 =?utf-8?B?WXBEQ3RzZ1c5aUhYc1UxcmhMaC9yWlFsYUhjVEozRVMrQ2t2QllKbUFIUFRI?=
 =?utf-8?B?ZUxhQTZORUY3VWxZV25SVWtDMVJISlF1Y1lQemxTOUF2WFNqUFpUQ2Zya0w3?=
 =?utf-8?B?TFVNbTk5dk0vbHJHSGhEOWVFeHhYd1Irc2RXalJQYkk5WVd0QjI0QnExMGlW?=
 =?utf-8?B?ZUVQRVBOMzNDb1ZnMHY0aS9QeFBWWFlDVXV5OThWUUZuL243UkVxUkxqSWZX?=
 =?utf-8?B?T3lld3dTNUp5NWNXOXpIby9lbVlydmR1cGlITU9Rd21BdXpReVI2YWNFREJ4?=
 =?utf-8?B?dHpxWFFRV0J4U1M5S0h2QVEyYVFoRTFudXl1UFFraFNaOHZvME1ONDE4cFl2?=
 =?utf-8?B?TEt6Vnp3VWhxV3ArTkxzc3IxajFRMysrNGlkZ1VpQUJTUjU3THFnUGZ0OFo5?=
 =?utf-8?B?U2lra3k1N3loY1hucDhDRUNZZXJlTXpsN0ZjWkd3bWFMVWI0UThsMlBFUkpi?=
 =?utf-8?B?akx5ZUU1ajlhOVM2dnJCZXNMT2JSWGpBNFZBUnFTakU2cUdqSzhFOG5uOStu?=
 =?utf-8?B?cC8rRisyOUhtc0g1TFlvdGdURWNGYUZBUHlFYXNIRjBwNi94dWhnZExwZDd3?=
 =?utf-8?B?ZWNDK3lka2lRMS9WYTJUZHBXSWxFMWdIeGJ4Nkw2NDNXbHBIT1QxMkYxR3BT?=
 =?utf-8?B?eFFhWHRTV2pJd29TcGx5U2RUUTM3cE1ubnoyLzR5cGVnSWtiSDJLUFZjU3U2?=
 =?utf-8?B?VVNjLzA1MlpOQkZDVE9ybGEvMzJtL1F3QlNnWTJPbEZMMVZxVTIxaStadllC?=
 =?utf-8?B?VCtMU3BpWE1yYzRTV3hnODlnNjkzNTNtK1ZYREUrRTZRdmhvVFZnTmp6QXZ3?=
 =?utf-8?B?eXl0dlJaaVNHUTJOUzhoLy9idDdaeGhGQmwySWtJdk03Nm0zMkJWZmo0ZHFu?=
 =?utf-8?B?bWJNVzBrY1VHejFZengzUWk3WGVYRU1HZzMwMkVWaWo0NUxBOU84aCtkMWtk?=
 =?utf-8?B?N1lmcDV0djBmczMyK25IQkVtQjZ1ZjlpUlA3TkVvMlN5ajl3VXlHd2g1TWlH?=
 =?utf-8?B?OUx0MVRTQXJBZml5ZWVQRTd2Q1FPbUI4bHJGY1VpYzZ1OUJoVGtQZGZPYkNr?=
 =?utf-8?B?V2pvMk1vcUtRU1NWMGxSQ1BaZ2FYWWFsUDhOMENld3hHNUM5bENVVXVtcmNJ?=
 =?utf-8?B?cFJ2TU5KQXQvc3pVTnlNZGVjVjZ2Qnh2TlowNXhzaG9wZHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:09:21.8492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e1809c-c558-41b0-f755-08dcf203df06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978

On 10/21/24 11:59 AM, Alice Ryhl wrote:
> On 10/21/24 8:41 PM, John Hubbard wrote:
>> On 10/21/24 11:37 AM, Miguel Ojeda wrote:
>>> On Mon, Oct 21, 2024 at 8:35 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>>>
>>>> Is this another case of C and Rust using different words for things??
>>>> Wow. OK...
>>>
>>> I am not sure what you mean -- by BE I meant British English.
>>>
>>> See my other reply as well -- I just changed it anyway because Rust
>>> apparently uses "parentheses".
>>>
>>
>> Right. For spoken languages, that's simply preference, and I would not
>> try to impose anything on anyone there.
>>
>> But in this case, at least for C (and, from reading my Rust book(s), I
>> thought for Rust also), "parentheses" is a technical specification, and
>> we should prefer to be accurate:
>>
>>      parentheses: ()
>>      brackets:    []
>>
>> Yes?
> What word would you use to collectively talk about (), [], {}? In my native language they're all a kind of parenthesis.
> 

Good question. I've never attempted that when discussing programming
language details, because it hasn't come up, because it would be a
programming error in C to use one in place of the other. And it is
rare to refer to both cases in C.

Rust so far seems to have the same distinction, although I am standing
by to be corrected as necessary, there! :)

At a higher level of abstraction, though, perhaps "grouping" is a good
word.


thanks,
-- 
John Hubbard


