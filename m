Return-Path: <linux-kernel+bounces-370656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85719A3028
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03FF1C21D97
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B45F1D63DF;
	Thu, 17 Oct 2024 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pagocNeS"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F81D1F7E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202249; cv=fail; b=CP3Z13fU4gWbd09CFNfT+ek9bbSyhiQMmdk01P4kzqSL8G5j0HilQnt/C9HRUzRuZNpagk57dqc5keGVVx3VNDHUzdvDCnpcMPIxyi/OA0vhLBy6aKrr/bPdz3sAhLGx6ku49armn1SjL6WwP/OunDYRGfnLTSSM0jw2f/XBHGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202249; c=relaxed/simple;
	bh=5ZRVv4bey9lBm5s2BiF9bZYGOUP2JTPTuylgmB5fRLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dVKbsc7XPt7YIISlC3ZJ7Lfrufm/Rv8WD+TwxYMJj46Ka5iiyJ8Pqn4zjKmYxtym9AHZrQZSDaMmWbyZK6CtIMnJdvWY3t3iTBAZOZn0wDLJ6Hl8yEkICszyjWFHKcGEzeo9Mc+DG7WaMtiiWCqmtpXJnho+yJ6Q/yCFpaQ9CKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pagocNeS; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyiF7oeWDpaLhzPSeK0cciO3YX7Rf6Lysy8xPz5aM/Nj04DlDaSpXOfqg9C8lOzvXzUvooFd06C7VivxuLjbQpyfxGKnxZWL9kMyvWlrWc34OJiPUJpnWzYHQYODx9T84AJZZt+sdUxtTyu3YdAcSSQqpNsdLtR6JNCAnlfYPw7Eko95uP43mTQ8obvpcb6mlRhXmy+fJj2BP64OLSXQEFWmUVoLDGumyhZsqM9bSmBeg6jSMGg9+w8mqpRFJdxVLydF9AbwBT7AdvjRlbV8reNaquFNvmCr83O2kazat4S0EYNauQsWrAruWbaTD340Av58beHvSiyOSLggS5WJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2vc54QON+QBSymTqx8rPHAf8xkd39haMsLOmhcBUfA=;
 b=TYOo9Os+ztJ5/uGnIMaXJ8VKBzsTBhMNv2p5wEFNpdP2xZeFZvOPQHE9IqMezJxkujnes/Z9HTFUEWoVqv1tsg/vGeN9prRODKJzg/U8owqrDnoU2knHjyGyTl0spttQsCRUMtQH2pactmNNNbiQj+zposZh0EA4hEn7X4+jUKT2h83WvCDiW6kXGtzRCSD9ah5WlskVhzMcsFDLEML6pA2kJnFdlb4FO9qw32cOevHUcPGtXmP7MaYOVOWbPYa1x3v5A4wClTScQ0Alk8L0ZsmvnROY1gl7ZmEpCPTFz0beGYi5k7tA4rK92CpvmJMs2FNcVEqM/0WelPqZllEkUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2vc54QON+QBSymTqx8rPHAf8xkd39haMsLOmhcBUfA=;
 b=pagocNeSuYH2QqNqahA694JJYVadiwIBNGpQaEVNJelShfuM38Xb+xvP9khNAwwlqV7oIxtibDxsvzLaR4RxXwIEcxBR9R9LK2FZkSSR05EoWxybxrSdzVjk0c9vzRLvXeKiWKbyaB6GM7yR4N7llQenhFtSC4ZsaNt6dFBudytv+zQJFz1RKMWWYnCFBSVxse2L7YcnEGVgP58TYzPjR+kETUe4d+zpuJZ7C3Fe4hl4IBgUBqxAX9ZrIsZ+2PlPY99H92Xx+8JlXamy08Vy6E41da2L9zfxebgxqVMAbyXwaJWF8idfJNm87ir4y7opoTgGyWeTeW2Mt2aju2iQzQ==
Received: from BL1PR13CA0209.namprd13.prod.outlook.com (2603:10b6:208:2be::34)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 21:57:22 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::d5) by BL1PR13CA0209.outlook.office365.com
 (2603:10b6:208:2be::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.7 via Frontend
 Transport; Thu, 17 Oct 2024 21:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 21:57:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 14:57:07 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 14:57:06 -0700
Message-ID: <a84d415d-dd18-49ef-b72a-ee381a44a429@nvidia.com>
Date: Thu, 17 Oct 2024 14:57:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
To: David Hildenbrand <david@redhat.com>, Alistair Popple <apopple@nvidia.com>
CC: Andrew Morton <akpm@linux-foundation.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Shigeru Yoshida
	<syoshida@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Minchan Kim
	<minchan@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
 <1f8dcae1-416e-43cf-8dda-5440e0db4c00@redhat.com>
 <87v7xqmmxt.fsf@nvdebian.thelocal>
 <52bd4862-d6ce-48f6-9bc2-0f7376a56115@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <52bd4862-d6ce-48f6-9bc2-0f7376a56115@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6dca29-d67e-40c0-b597-08dceef6ad57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzVNWE1hYWFwUWtGQXFLQk53NjV1bVBjU3BtcW8rWXErQTlNcVlDQW1yR3Rn?=
 =?utf-8?B?ZG5tYkhMY0VMZTl3TktaR0htMUpBU01oT0VvR0YzMmNUbSs3RGZ2QysyNzNP?=
 =?utf-8?B?MDduS3RReVFGTXN0QWRPRjhUdERyNXAyNVMzUWovVXRUMU5nNk91dUwrQnlj?=
 =?utf-8?B?bGo4VklyWWMwb1VYM3NKZG1zR3YvQmZuQjhxV3hDblBONEZmUFd4QWFvWjhC?=
 =?utf-8?B?dytkSS9ESUE5cFFKNlVTdVJrdjRmVVdPemcwV2kydTQwR3ZQQTJCeHpCb2p4?=
 =?utf-8?B?OUZBUWpCSnBPU2xXeVdVdnBUT1RKaDVMN3Z2MyttNndhdmtkZGtMNEdTbFRJ?=
 =?utf-8?B?WXhWWHRiV01xZm1OMmFLQzlGMjlpSGgrb1I4ZWV5eGhrSUs5cWZnWEQxS0t5?=
 =?utf-8?B?UzErWFl4bVpTL2R3REI3SG1hN2lvc1JNVE9NNmVhaHdoWDJXRWd2YzFQZytE?=
 =?utf-8?B?Vk9UR2JrNkZYcTF1aFkzT3ZYbnJDbHBET2I4RGpJZ2FRMFdyenN0ajNJYXZv?=
 =?utf-8?B?enNpQ2hSSERZQ1pkYm10Z3JMMDBTVytiZWlpaWRWMkh5Q0p6Z3U2d0lpM1Z1?=
 =?utf-8?B?dk5DRzVxamZTeUE1cGJLZHhvbkpzenFFVmdBVDV4KzhmdzhXcFEzR1lJVW9X?=
 =?utf-8?B?blVyWUNvTGRzUkNmUmFzMlMwNWo4aU1SbmxPa21wc2ExcjlzL3B0WWtBUHdG?=
 =?utf-8?B?eWVBZDRmSEZwMzg1S3MvVlNxS1NvdjN1UG81ZXIzSTlTcEEvZUlpSHdLeVpp?=
 =?utf-8?B?Q3htMWJqNTd3ZnBrUUZXK1VpbjE3RzZkdTN0d08xZ05XRDNXYWJyc1Y5amJB?=
 =?utf-8?B?N01RSFNYQTZ0cElibXJhQUFmeExPUWJRdEQ1cnlIVGI5c1c0R0tGZWx6TWRE?=
 =?utf-8?B?RWwyR0oxUDFra2xXRTd6aWQ5czE5MlZIM0QzSkhRVGpCbVRmQTVWazZsRlJZ?=
 =?utf-8?B?TGZXMHNQTjlQU2JULzluRDZtQXZ4dTRhQkVOM1p3UWtBWkIxVk9CYTZRVUJF?=
 =?utf-8?B?NUtGT3ZObERvYlQ3V3R0cFNPeTRWYk5mTDEwSkRZNlFPV3JucTZSZ2k2UHY5?=
 =?utf-8?B?eWpIL2hXSHFkdEY3K1I2VHc4K0g1R2R6NFRrUnhONnRwOUpkWVlKN0JuWThv?=
 =?utf-8?B?YXhUOVJ5RjdxZERCU05ZeGlmSEp2RDlJd2JrVk9FMGMvMWxIR2dzeTNITThU?=
 =?utf-8?B?L0ZsY2VTeHBZNlJ4QmhOV3JTVi85K1YxbFhEbGVXd1h2QXE3VXNuRHl6RWRj?=
 =?utf-8?B?WXZKMWdqVzJoR0pNQk5Wc1I4eGswNEQ3aHFDSTZ1eXdXTVM1RW1EaEVkQ0RD?=
 =?utf-8?B?cHpkN0JTdlJyRWV2Q0ZDd05hR0pGb2NhMlFlbUJNZktpQ05uTTJLdG1hQmpC?=
 =?utf-8?B?eGo0ek1MNGtTNVdBZ1dXUisxUjl4VGpOYmtUSjFaOG1adTNCei84eXlzZ1VZ?=
 =?utf-8?B?ZUJERXRId2NuNnpjSEVpVVgvVllBVWtEUVFvS3VKQ0xPdnZpemx5MjB6Qnc4?=
 =?utf-8?B?R0R0SDkzWEpMcVQxR1BCMGp5TVpBSUpkZDVkNlpFWG1hZDlXa29IM3BaakZD?=
 =?utf-8?B?b1gxWVR0MFMzMCtEOG5jdkVMMk5xQUxjNHMxeC9XKy9UZnExd2VQdzhqOVVr?=
 =?utf-8?B?bmJpR3BaZVlrQ1NVTjVUa2piTXFES0pKMnFjNXJ4UlUycitKZ1RhVHFXQ3Jm?=
 =?utf-8?B?djRjQWMydk43Ync5MGdNQnJFNUduUU1tUmtXTVluYXR0VTJPSzRnRlRzci8v?=
 =?utf-8?B?QTFlR2lPRjA2SEtQMFRWK010a1BCbEN5RllpcmtOZTRWL1YrdmFlT2QzU3J6?=
 =?utf-8?B?Q002RTdHOVByQ0ZxMlJobnRjQTc2V25Kc3oreHd6dDk0SWZ5eG9OZjNET01D?=
 =?utf-8?B?Z0VCdVdIVVdnanJaRGZQTHVTQUxqTGNLbVJuby85emp2dXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:57:21.5464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6dca29-d67e-40c0-b597-08dceef6ad57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689

On 10/17/24 2:47 PM, David Hildenbrand wrote:
> On 17.10.24 23:28, Alistair Popple wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>> On 16.10.24 22:22, John Hubbard wrote:
...
>>>> +        if (rc != -EAGAIN && rc != 0)
>>>> +            unpin_user_pages(pages, nr_pinned_pages);
>>>> +
>>>>        } while (rc == -EAGAIN);
>>>
>>> Wouldn't it be cleaner to simply have here after the loop (possibly
>>> even after the memalloc_pin_restore())
>>>
>>> if (rc)
>>>     unpin_user_pages(pages, nr_pinned_pages);
>>>
>>> But maybe I am missing something.
>>
>> I initially thought the same thing but I'm not sure it is
>> correct. Consider what happens when __get_user_pages_locked() fails
>> earlier in the loop. In this case it will have bailed out of the loop
>> with rc <= 0 but we shouldn't call unpin_user_pages().

doh. yes. Thanks for catching that, Alistair! I actually considered
it during the first draft, too, but got tunnel vision during the
review, sigh.

> 
> Ah, I see what you mean, I primarily only stared at the diff.
> 
> We should likely avoid using nr_pinned_pages as a temporary variable that
> can hold an error value.
> 

OK, I still want to defer all the pretty refactoring ideas into some
future effort, so for now, let's just leave v1 alone except for fixing
the typo in the comment, yes?

I'll still send out a 2-patch series with that, plus a suitably
modified fix for the memfd case too.


thanks,
-- 
John Hubbard


