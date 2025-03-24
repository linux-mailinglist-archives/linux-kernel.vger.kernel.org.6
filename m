Return-Path: <linux-kernel+bounces-574568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED51A6E6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB12D1894FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150401EFFA2;
	Mon, 24 Mar 2025 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oB4ilr86"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CB189520
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856548; cv=fail; b=I3cPkxn7a5EjypRadESGYsMAnaJ+T5KTbzFRSxRxT/R01T+CL/GXaYNoMRRQ8AOGsp6kvCrFnlL8mCeucUwgRbFVL3DJZV7Nq1tOQJMxFMNWtgSuTVl680j3QLefclZlul/GXwUp6Up5YSkOcuSWdDa86n9VKqNq6+wo9nxskso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856548; c=relaxed/simple;
	bh=TjTv3wNX9zYcV+8569KWtLjl25lQPzwOgo1h0pab+po=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wb7xDuSGTrFUYI+rTzyBUW6KwfaSrSiG6MAOprNNiKoqYfCHCaio/aRrTXKH3nd6uwRLrpemMN/0RQBoFFRMqcbdoc6b9O+Ewr2F71aULnmKRJkMXvN2tEjxKcJ9ma7+zkqCkXrchDgW4xcCMvDvLrxaaeFKCLVyQ9cUavR/DiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oB4ilr86; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qrb493MYpJELfZIIHuFbLsy++6xv871fbyPRSgMtR/pTOldTvrp/q0rpdX2OK0o9080nD2AVEYW+vOu0pT7DJ8qf+SoTGyCrR+S0yFUHQrIEfKA+dMPKBnD+EW4bh4W6qn0sK4K7Az+WpS5nqHRfnIlXmxi5tdcsbXGTL+innBEshVLgTcMtIkLzVjcwrUbzGVwc6C5u/PC5oM8AOHcvP4BT554rB9QreZxETvDo+XrbYOkSV0gQhNJAD2lHY54CwwKkK2kwDxgI+kPhRktHMUpnOGKYoY5zttn3WaejXXseHDnaG9PtClJJTmpAAIBlEnhWdiWZ49VXQHnK+n3sbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3foCBBGvTpOx1TPJD5WsZ0fTl8lSJnhJ9G4+Nu+QP4=;
 b=b8uhxvSWtfKI0PEY6W6d0qyoUOQs5k/CQsHKqKYudiiOkxO/9juNI9vJtMg7MKiwjwC5uEszWwi9KCWLUYUKMAAfVplvW13Z/F+i5Mkey/+KHK73c0ktf4YY5Z+noOWqyahtijY6U0NSAmhF8X/tFXCn3JTZ8THNkNKT7Bqf/uof5U9GWQ3u3EQ3FkVpHb/DlDn3Piz1WZYyKsGeC6RMCcpSKHRJNGeS5lZ/zUc4Kd20E657wxArk3H4G7Y3J5c+GPusnTbcrdq26MM7dOS5x0N/6s5upESUlz4iQe9wiDmGZUeemgmqascybqKurzPpcc/TzHiEB72oW+l38GuCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3foCBBGvTpOx1TPJD5WsZ0fTl8lSJnhJ9G4+Nu+QP4=;
 b=oB4ilr86TO0lTnxuuIgJbF6+vQKCbnxSsrJhf3pspTBHKrtGuijyk/FQmQsmYk6lZWTDM+p7aYCGtCFySO9fQZu/l7BXnVnrHC67CEKaNQPw9PDGcjWL9qFgjdd9V6CPUQ5jT0HGNhtnV775vy76x4MesoGRW+JLO4EKphKN2BbOADW0wxbqfWrCiAx0UQ7le+DPiKZ2XSSUb/7rD8dFg1EdudqrbBd6EMNpxS3rO9DPzj9FtSCitid46ssMbICxLjb4HNJqbddLBmtsYmF/0Knw9N9AChtURTvLwcCpYoDGFoEWr1xveS40dkPEsqd1kUnYCE8h6gtyZtqgg1FMtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 22:49:01 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8534.031; Mon, 24 Mar 2025
 22:49:01 +0000
Message-ID: <b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com>
Date: Tue, 25 Mar 2025 09:48:56 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250322122351.3268-1-spasswolf@web.de>
 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
 <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
 <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:334::7) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: f8d9ca65-9610-40ce-7184-08dd6b2611f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm9YWDEzZm5EU0xkU2dWcENKK1oxZEJBV3QyUm00YURRRlRmdFd4Z01HMkJn?=
 =?utf-8?B?VW5wN09abmRYd0NzWUxtOW1OMTBqaFB3U3ROeGhOVituUU02WnhiZnAwWnAy?=
 =?utf-8?B?b3RFOFd4VEJzM1k0dUJ6WHJIUUx0ajFHNG5aSUpoUjB0ZHlNR3Yxd1FGRFdL?=
 =?utf-8?B?VTNRMXhEV2lpMGRvdDRaSXNpeDVhQ2p3WlliQWtyV2U4SXJYR0R2ZHB3aEsz?=
 =?utf-8?B?WTNuRDBIaEU1Q1VYQXhmQy9LU2dTUFhCMUNvUFJ2bWNldklkeFFSTU1JVUZq?=
 =?utf-8?B?cFEwdVpvN25rQ0xIRkRrb2gybEZWMmRyaGdZcStzcWVBZXU4UDdXOUdWeEQz?=
 =?utf-8?B?TWMzaFhTYkI1R3QyeTN5Q01XM2oxNU1Eb1FmSDYrdEtrL0cvMFc3amZDVFIy?=
 =?utf-8?B?VllWUTloK3VVaWNreFdGWkM3QnllVkIvNTJQSDRZSC9NckRMNUtGS05Cbzhw?=
 =?utf-8?B?QWpoaHlVa2dtSnEwc3E0YmV3MWRaa3J1Si90VEtRbGorOFA2bnVXcDNwa2N0?=
 =?utf-8?B?eHp1WjBYcSs1OXVKNmJPL0prVmFZUGMyMkNERDBtcVhackVUR29yRVJJSUt6?=
 =?utf-8?B?SndxakE1bzhMYkg4TURJZ0RMb0RRQ1RHMXRvVktUandYTXJHWEpLRnlaUE5F?=
 =?utf-8?B?cEZzZWdiWEZ0M1RGNG10OTYxN1htSDFMM1ljYWFoYS80eWNoc3ArYkNGMkdB?=
 =?utf-8?B?NEdOMTBTSnMySTIvOHZVa0UvclVJL0RDSVcxZzREZ1paUzlaYUtwcU4wcnFQ?=
 =?utf-8?B?VnVxamhMYjE0YU16NU9SL0g0cjA2Y0RwUkFoVVpSNTZGWW5sV1NrNGNpZWdB?=
 =?utf-8?B?QzhCSjFqOHY4NytoaVE0YmI1d2p5cG9ja0FON2c5SEgyR0NtMFpiN2VqZnhq?=
 =?utf-8?B?ZVNpVnJxT204QVpPVytiaXJxL3dzblVaVFNCY3d1Mks1ZzdSZnY1ZTRDb3Vz?=
 =?utf-8?B?S3l5K0owZlZKT1VVMFlRRkZ0Zk9wTzVXYlBRcHNKZk42d3kvZVZUZWRQK0VX?=
 =?utf-8?B?ejZNU0dQZzNSMzVkaUhoWmpGdXNTRjkxRzg5bG1oZlFkWWg0NDZyMGZVM25X?=
 =?utf-8?B?LzVWNTNjRkdtY0Y3OUluUVFDUGcxYVpDd0k5UXFVTFFwcUMwWjY1QVdaczRa?=
 =?utf-8?B?U0thTHhaRXNRUEJwelgrQktTMW5Qb2NqcjBmSzQ0eWt4bkZvRDFiM2ExcG80?=
 =?utf-8?B?cHNpSDRqVGtzUUZkNVNDeWJTcTdwbVo4R2h3WlB2Slc3dXY5ODdINmFubGZK?=
 =?utf-8?B?QlR2WnJoRGNxM2oxVVdBVE1qZnJCclRCRVcwcC9MbmtmVFJ2Zk5lR2UrTUo5?=
 =?utf-8?B?SmdMMU1tV3Zld1hlTE5XbDlxQUJBb3RlM09wNy9BZHNiYU9CTUxpeVJwUzJF?=
 =?utf-8?B?TWRnUzJ2WVJkRjU4TXQvRXJhRVFTdWJIckxuR2cyK2M5OEEzQUpPTElhdE1U?=
 =?utf-8?B?RGxwcWYvdlNQK2l2em9lck9pbS9zb0xHbDJzYXgxb20rWU01RlljN0NSLzFR?=
 =?utf-8?B?TTZpVitaaHZWNldzdUJCVVhGU0ZhdVNCb3FVb1BsaU81V1MyNWc5d1VYQlpU?=
 =?utf-8?B?cUF4M0tOWHhHTEErWmdCb2t3VFpnTWppamFQa3ZuY1NVaDR0emUrL0xreXBk?=
 =?utf-8?B?Y3dCNjFnTm84cmpkU3g1Ky93elgzVCtLc1IvUCtsd3RWUjZEMDVOaDIzb0kz?=
 =?utf-8?B?Rkh1clpTVUFwN3ZwYlAyc0RIMVJuamF0YXNtb0JhZUVaRVJMY3oycUJ3UnBN?=
 =?utf-8?B?VGFTTmJESFh5dExLSlZMVUhXVi9tTXFJenRZSFRnYUI1ZGhkNE9Cc244MEwv?=
 =?utf-8?B?VGRlNDVjWURQSWdoTEdhcVE0Zjhoc3ZGZHlzK3VBdEp3eFNENjVvbzJvazBQ?=
 =?utf-8?Q?4dRH2pB4om9tw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGF2clVpRzdWeHVpa2RiZy92V2R2SDJoSXV4MFFpVXhQV1JkUkhlU3BQNTly?=
 =?utf-8?B?NkNMckhyQ3lVSlVMa3FsTGdEOTJSMy9ER25Rd3p5dEpkSDdYM0pOYzk5VnZL?=
 =?utf-8?B?UklQeEVkc1VmdG1wYlN6N3M4TUw5NTB4RkxOdzlHQ2lxcGRVdG8wcEErdk80?=
 =?utf-8?B?bGdSMHhxNWdTNFprZzZZZ3RDYUtva0lWZ0lYM2FjbkkrVFk4QU9aTnVDamlK?=
 =?utf-8?B?S1RjZXBhVHZiZkkrZSsxeThrSnRHblRKWEo0OXRxcW5xU1VsTlJPZFh5Yi90?=
 =?utf-8?B?dDBNZUNzQTdZanVKaEVaVDN0OThscEJDK0czejJIbkF4OGxMNS9WMnFYdUFk?=
 =?utf-8?B?c2JIQmdqaUJKeDdMdStvUC8zMXhBTm5GSHRMZnlvbGY0NVFrVGliRi9kclRr?=
 =?utf-8?B?Wnh3YVhPV0FzSkZJT05VcWpORy8rNjFHZ3A1YzBuZ2R5VE9QZGpUZjUzOHdq?=
 =?utf-8?B?TkdNZ2xOQXdKdFo2alBtRU1CMmkwZ2ZXN05Cd0o4bmpqOEZjVGpMMS9weTJU?=
 =?utf-8?B?NXVqSEdzRElTZlE3S1V4NU5OaDh5TGo4RjA2eTI5U282S3ZFYnYvODJhNm9Q?=
 =?utf-8?B?RDZVUGNiUmUyNkRVVkQvNmwyZmRRQjF4ZkwramIyYTVhbld5blRZN3QyUHJx?=
 =?utf-8?B?Y214dGdpOEVtSTBFaGl0cHNGNm9Qays4cUhzbHZHYW5DSjZaN2xmSkxtUmJX?=
 =?utf-8?B?emxIN29pN2FtZHBkZ1RMckJPZWpQdTRyQU9raUVEMU5CTytWMlY0c1ZsM3lN?=
 =?utf-8?B?SlhpNkNoTUh1aGdGNE41cXdYVTFPLzV3VDhka0svRUlVekljR01ZWmJ5RlZO?=
 =?utf-8?B?ODdCV2VjOXVJSVNlL053RXI1WExDdkZoQzZGeTB1T25tdDRFblRLK2NsaXZF?=
 =?utf-8?B?dFYzSU81R09xQWhXQm1ROGVnbnlaSEdqaTc0UTB3ZjRRWnU3NzJoeGdYUnAw?=
 =?utf-8?B?ZUllL3V6TEpabVdvcjNlamxLZFJyL1hER3R3VzhDZnp3RVFkTTJGNFVLT1Rq?=
 =?utf-8?B?RWhaV2xLMGJYZnp5K0FMK3oyLy9uQWhBUVJWQ0lqTHRVaXdNaXJCYkRZWWtO?=
 =?utf-8?B?RUFBZ1dPNUxwcVAxS2UzUVZzMEo2cnBFYXRKcllZT0VDSzNZUGtMd0V3MWt1?=
 =?utf-8?B?OEFUS0dIeFdnOXhEVUpMUndsU01ZdCsxZFJYNVQ5c2RTb0xsQ1FsbEtreUF6?=
 =?utf-8?B?RVA3SlpVbjdIMEpOc3hscmJaTUtzUEordlQzSjBVYWc1c1FzNDhuRUdrVW84?=
 =?utf-8?B?dEhMZk1FWHNGOXZJUVg0SjNkUWRidGNVaVJ1Z3JuYTViZXZyMnhvUzRQUVdh?=
 =?utf-8?B?eFZyK2ZYb1ljOWFHWFBGUUNKSHppQy9MSWVHRjc1ZnBPaWI1SVpwb2NUNWtx?=
 =?utf-8?B?Tnkxc0tQU2J4RzlFalZGVTlzSFZRK2lnSXAxOXdMUDU0dHBWcnZHQXhGdisz?=
 =?utf-8?B?R0JKRFZTUlJncytCUkVJcXBtaFlOOW5VaGY0M0Y2Zy9EVFBlNFlCOUNyZHBr?=
 =?utf-8?B?U2dFYkpoTkNEd2V4V29zSjhqMDBrMWUxcWwwVHJFREdnd3BlRU1YR0VzeFda?=
 =?utf-8?B?d0p0MysyUlNaY0wzY29pNkFDSFAyT1NYNjU4eGF5d2EyZVVwNE56UzZyTVhH?=
 =?utf-8?B?ay9wUXhRUkU4c25hb2o4TVRRVTFML3dqdzJaMENYT1VjMFFhWHJMZkNCRll4?=
 =?utf-8?B?U2dxOHhOSDhBYW1Jb3BJTWVFWFdSOWNwcTF4anhYZlF4aGpSQU5LYnJNcmhU?=
 =?utf-8?B?SWNoZWpmZm9HdkRLamNUV0huNCtXOVg2eFE4TEs2VXVGUXczeEVBZUpGeGJF?=
 =?utf-8?B?WFpGazRHTmh6blBmZWZNVVdDQjdWaDBzQ1BaN0NaK0pMNmhmMmd2SDJTS1Vj?=
 =?utf-8?B?bU42KzdNRktHcEVHM2xjbmEyU0h3TkFLQmxUMkMyc1hTUnRrWFA1YnczWWc1?=
 =?utf-8?B?amZpeFdJMWhrR2tRODEvcmdjYWI1QWhSa21XRUhxWElURWRkZmpFcTBqeTBB?=
 =?utf-8?B?Qm5scnZoMDVMUmdHMVVXOTNzaW9iYWJFdktYc0dIZFZtcXBZaG0wUXhXdWhC?=
 =?utf-8?B?TVZrdmhKS0h4R2pUdFowQzdadkR1MHE4Z0hvQTVPUEhkeVdGZU4yL2IvS3J2?=
 =?utf-8?Q?LniZ1DykZ5Lko3AbQLyblSfi2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d9ca65-9610-40ce-7184-08dd6b2611f5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 22:49:01.2380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3j6b22q/cfAuZ9JG8MioHwQsQkDIx2HXW1NrMxGs8hiZg00QCAK9PBJAjqGY/qdhw5AvFbIQ43wsBLrrB5S+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

On 3/24/25 23:14, Christian König wrote:
> Am 24.03.25 um 12:23 schrieb Bert Karwatzki:
>> Am Sonntag, dem 23.03.2025 um 17:51 +1100 schrieb Balbir Singh:
>>> On 3/22/25 23:23, Bert Karwatzki wrote:
>>>> ...
>>>> So why is use_dma32 enabled with nokaslr? Some more printk()s give this result:
>>>>
>>>> The GPUs:
>>>> built-in:
>>>> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
>>>> discrete:
>>>> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23 [Radeon RX 6600/6600 XT/6600M] (rev c3)
>>>>
>>>> With nokaslr:
>>>> [    1.266517] [    T328] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffff
>>>> [    1.266519] [    T328] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
>>>> [    1.266520] [    T328] dma_direct_all_ram_mapped: returning true
>>>> [    1.266521] [    T328] dma_addressing_limited: returning ret = 0
>>>> [    1.266521] [    T328] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
>>>> [    1.266525] [    T328] entering ttm_device_init, use_dma32 = 0
>>>> [    1.267115] [    T328] entering ttm_pool_init, use_dma32 = 0
>>>>
>>>> [    3.965669] [    T328] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0x3fffffffffff
>>>> [    3.965671] [    T328] dma_addressing_limited: returning true
>>>> [    3.965672] [    T328] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 1
>>>> [    3.965674] [    T328] entering ttm_device_init, use_dma32 = 1
>>>> [    3.965747] [    T328] entering ttm_pool_init, use_dma32 = 1
>>>>
>>>> Without nokaslr:
>>>> [    1.300907] [    T351] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffff
>>>> [    1.300909] [    T351] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
>>>> [    1.300910] [    T351] dma_direct_all_ram_mapped: returning true
>>>> [    1.300910] [    T351] dma_addressing_limited: returning ret = 0
>>>> [    1.300911] [    T351] amdgpu 0000:03:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
>>>> [    1.300915] [    T351] entering ttm_device_init, use_dma32 = 0
>>>> [    1.301210] [    T351] entering ttm_pool_init, use_dma32 = 0
>>>>
>>>> [    4.000602] [    T351] dma_addressing_limited: mask = 0xfffffffffff bus_dma_limit = 0x0 required_mask = 0xfffffffffff
>>>> [    4.000603] [    T351] dma_addressing_limited: ops = 0000000000000000 use_dma_iommu(dev) = 0
>>>> [    4.000604] [    T351] dma_direct_all_ram_mapped: returning true
>>>> [    4.000605] [    T351] dma_addressing_limited: returning ret = 0
>>>> [    4.000606] [    T351] amdgpu 0000:08:00.0: amdgpu: amdgpu_ttm_init: calling ttm_device_init() with use_dma32 = 0
>>>> [    4.000610] [    T351] entering ttm_device_init, use_dma32 = 0
>>>> [    4.000687] [    T351] entering ttm_pool_init, use_dma32 = 0
>>>>
>>>> So with nokaslr the reuqired mask for the built-in GPU changes from 0xfffffffffff
>>>> to 0x3fffffffffff which causes dma_addressing_limited to return true which causes
>>>> the ttm_device init to be called with use_dma32 = true.
>>> Thanks, this is really the root cause, from what I understand.
> 
> Yeah, completely agree.
> 
>>>
>>>>  It also show that for the discreate GPU nothing changes so the bug does not occur
>>>> there.
>>>>
>>>> I also was able to work around the bug by calling ttm_device_init() with use_dma32=false
>>>> from amdgpu_ttm_init()  (drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c) but I'm not sure if this
>>>> has unwanted side effects.
>>>>
>>>> int amdgpu_ttm_init(struct amdgpu_device *adev)
>>>> {
>>>> 	uint64_t gtt_size;
>>>> 	int r;
>>>>
>>>> 	mutex_init(&adev->mman.gtt_window_lock);
>>>>
>>>> 	dma_set_max_seg_size(adev->dev, UINT_MAX);
>>>> 	/* No others user of address space so set it to 0 */
>>>> 	dev_info(adev->dev, "%s: calling ttm_device_init() with use_dma32 = 0 ignoring %d\n", __func__, dma_addressing_limited(adev->dev));
>>>> 	r = ttm_device_init(&adev->mman.bdev, &amdgpu_bo_driver, adev->dev,
>>>> 			       adev_to_drm(adev)->anon_inode->i_mapping,
>>>> 			       adev_to_drm(adev)->vma_offset_manager,
>>>> 			       adev->need_swiotlb,
>>>> 			       false /* use_dma32 */);
>>>> 	if (r) {
>>>> 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
>>>> 		return r;
>>>> 	}
>>>>
>>> I think this brings us really close, instead of forcing use_dma32 to false, I wonder if we need something like
>>>
>>> uin64_t dma_bits = fls64(dma_get_mask(adev->dev));
>>>
>>> to ttm_device_init, pass the last argument (use_dma32) as dma_bits < 32?
> 
> The handling is completely correct as far as i can see.
> 
>>>
>>>
>>> Thanks,
>>> Balbir Singh
>>>
>> Do these address bits have to shift when using nokaslr or PCI_P2PDMA, I think
>> this shift cause the increase of the required_dma_mask to 0x3fffffffffff?
>>
>> @@ -104,4 +104,4 @@
>>        fe30300000-fe303fffff : 0000:04:00.0
>>      fe30400000-fe30403fff : 0000:04:00.0
>>      fe30404000-fe30404fff : 0000:04:00.0
>> -afe00000000-affffffffff : 0000:03:00.0
>> +3ffe00000000-3fffffffffff : 0000:03:00.0
>>
>> And what memory is this? It's 8G in size so it could be the RAM of the discrete
>> GPU (which is at PCI 0000:03:00.0), but that is already here (part of
>> /proc/iomem):
>>
>> 1010000000-ffffffffff : PCI Bus 0000:00
>>   fc00000000-fe0fffffff : PCI Bus 0000:01
>>     fc00000000-fe0fffffff : PCI Bus 0000:02
>>       fc00000000-fe0fffffff : PCI Bus 0000:03
>>         fc00000000-fdffffffff : 0000:03:00.0  GPU RAM
>>         fe00000000-fe0fffffff : 0000:03:00.0
>>
>> lspci -v reports 8G of memory at 0xfc00000000 so I assmumed that is the GPU RAM.
>> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
>> [Radeon RX 6600/6600 XT/6600M] (rev c3)
>> 	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
>> 	Flags: bus master, fast devsel, latency 0, IRQ 107, IOMMU group 14
>> 	Memory at fc00000000 (64-bit, prefetchable) [size=8G]
>> 	Memory at fe00000000 (64-bit, prefetchable) [size=256M]
>> 	Memory at fca00000 (32-bit, non-prefetchable) [size=1M]
>> 	Expansion ROM at fcb00000 [disabled] [size=128K]
> 
> Well when you set nokaslr then that moves the BAR address of the dGPU above the limit the integrated GPU can access on the bus (usually 40 bits).
> 
> Because of this the integrated GPU starts to fallback to system memory below the 4GB limit to make sure that the stuff is always accessible by everyone.

Why does it fallback to GPU_DMA32? Is the rest of system memory not usable (upto 40 bits)?
I did not realize that the iGPU is using the BAR memory of the dGPU.

I guess the issue goes away when amdgpu.gttsize is set to 2GB, because 2GB fits in the DMA32 window

> 
> Since the memory below 4GB is very very limited we are now starting to constantly swap things in and out of that area. Basically completely killing the performance of your Steam game.
> 
> As far as I can see till that point the handling is completely intentional and working as expected.
> 
> The only thing which eludes me is why setting nokaslr changes the BAR of the dGPU? Can I get the full dmesg with and with nokasl?
> 

IIRC, the iGPU does not work correctly, the dGPU does, so it's an iGPU addressing constraint?

Balbir


