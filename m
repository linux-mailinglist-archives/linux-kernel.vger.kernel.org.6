Return-Path: <linux-kernel+bounces-565156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980EEA661EA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A127D189B357
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747EA1DE3CB;
	Mon, 17 Mar 2025 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bfOjFehN"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73A2BB15
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251546; cv=fail; b=jszEVam3F4bYAc4AAVHFaBmsFxqRUnBskUrY8oyzM4EF2NbXnxFngr9u32/yNJYt9OkF1fwDv3FV4POISCTbmaT1I/FrY0MURlZyF1EQTR81waZkVtujQD6QmTIQGDg+TOgsORtQKX7O1/C9m7r0rWBKNxvSf9uSchckt4rXRSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251546; c=relaxed/simple;
	bh=U5iCHcrSK9P6HmeJ6WYIMr0TjP8jTRwBxk9Z3GeFEew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VEEszT1uOaosBVigle9oxZxFF0B+PeKfGHmVtuuKE1iYOzh0Zw9KwHjrzCuqC24IjhAKhnnZdQu3cqv2m1PXNC0LP2cx6V8dUI1chNbftEsPHmdgQEo2TOqE5rjoNHL2jNtqPvcPT4rnJfhj/2QcJaVPDaIZTs81UkHsiC29z5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bfOjFehN; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn0xQY4vAU/cNipuOYEWHOw1uKrqONeZc1PYVJM5g/VafC703JmX8nt64KjgVGH8Ho6fpEkJhm2T7IhnWVdD5P12BSOV4/tfPd3U0MdKGbDEBqbhKTasI3RyFNPFHerH8rOy7laWJ5bh3oue24L81eETZThlT5YcuuXCaHYEMufyMq1i4GDYeqEvF1sTqU9UrqKn8fSceUBK2f6wKnfmkN0X+5duTMppioDANWD86OgKLsRpLonjNlfV0oXAUMhoUEY5bZRTXQ5jjVl9xiqVIpQUllYC4GOBMMbMZMGqy4KOVRa5Zd4zlkuVsIr9OPlo/tvAdjg149iIqms1RvrJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPLET36VCiGVcaX2YUALj+G9sd9AZiaC85WfwDMy994=;
 b=l/hy02AFgjrUv2AVdxThx1MFdmWh705OIt3hFM4wJAyOzLuDB+zMAnyqNC/IURqcZ8QPoKA5OA6+thOnz2tZINvNToNdMTjE2At8nH8rdhMiok6cFWnKr7UCzsWlt7gN9+r4XanrA+GmXEc9yB8j8oNuW//9N52aWnDlXVjFOS9ROTIw0fQhmC8Hxxuzmj0sPqRmHIKwxvUr9bJsKBdqaaAyWLISg8BNLwJcbq0UOjrC2zeurim5H5JRnMo/ZxfSDwoUa7CdVfNW7NidUXlfHhgycnRYTT16t1OwWtHMAd4JExs++cl0KrgmGFMrmBTkMVZWQ8lIz6i0AAQar+wz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPLET36VCiGVcaX2YUALj+G9sd9AZiaC85WfwDMy994=;
 b=bfOjFehN3py7BXIrdyWoSPFj2VL+F5nRAiXXqGj8u8wtJFqoJYj7v+qvyfynso9EgPrGQU7/0ageRWXWN6FEdnI9e/UOEGp80vSZqwtW+jHIAk1tMIYTxZV4a5uMANXlcNp87WYIKtZmvXyQMLxEUkQDtOpwbtws6bgfLeO/Yfibrh0312xa14xZAoQORgUl2w9fogq8J/u8JQQq0DewC+K6AJ36aJDIJ98AL+GZdgnA9aXsunFJkK2EnUCHy375k1kJdLW4sTAcnczpQEvX3KvAW4cQBqYVjPFCYPEYTWPIs9fPFp1Q5MH4tXBHIYzw/SyH+rQWqUt4I5dCeaW5DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 22:45:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 22:45:42 +0000
Message-ID: <eb8cd1eb-1cd0-4eed-a87b-1edd3e26a732@nvidia.com>
Date: Mon, 17 Mar 2025 23:45:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
 <b0dea973-bf41-4f44-850c-7bc860d5bf8a@nvidia.com>
 <Z9ihbiUV7dohm7FT@slm.duckdns.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <Z9ihbiUV7dohm7FT@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:208:32e::29) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: ff19f7d3-6365-4b70-70ca-08dd65a57280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlZpRmZQOUxha05XWjVETTQ3c3VIQXlrdzNtdjg3ZUZnT3VhQXdjV05uSVlM?=
 =?utf-8?B?TmoxUmdUU05CbmFxdjhodmFWZDIvNVdnSFFaR1hVZ2FGSmF4VUIza3BhQk1j?=
 =?utf-8?B?VGxrMkhlREpGQnArcEFpZ2VWQjBsZGw0UDhOdDdEdEVvc2hvaDdZN1NBSFV1?=
 =?utf-8?B?aWZIbkVJdTRpRDQwZUw5UHdzakQreHJtNlhTV1dMUlQ0YUVMdEhUYzJ4VnBi?=
 =?utf-8?B?UTFPVWNJQlRjeGJHWS85TERXZHRYSS9mYjBrWGhZQWNCQXNROEhQakNIYmlH?=
 =?utf-8?B?TkVHQ1RENExqRXc2b2M1N3JKQTRaWWNBbzczRzBBekxrZmQ2OGN1cWEzOU1o?=
 =?utf-8?B?dzdFdWh4bmI4SGMzQTc5UGx3cFJnckgwTUgxeWV3blpHaXQ4QlNnRU1YVGV5?=
 =?utf-8?B?dUIrckJ5U2RmdmtjYzZUOHhVRCt0dTd6WTlHQXdBc2Jicyszc0xjVW93WHBu?=
 =?utf-8?B?Z3ptRTNaSmhmMEFvQmZSbDVMVkpLYXJvbU5YVW5ENldENDhoM1J4aDlnL3FD?=
 =?utf-8?B?cUNIY2djUW12Smt4V2c0dzdiWG5Vayt2aVJZWGY3a0VobXE4UEpIQUNNbk13?=
 =?utf-8?B?NTFTejNZSWJMSE0zSVo5SlYrRWtsWDZwVTZRbFNSYjRqVVQydWtVNkdpQlpO?=
 =?utf-8?B?a1lGVTlGU3dNSE13SzRZUURYUzhCMjR5eFFpcmhDak9DNjErVi9ndWRmaUdK?=
 =?utf-8?B?N1JHTVZLYVIzVHJCbnZCSmtpdHJCSWR5RFdrRkFvNU9lbUJZd2NvUmNiWHRy?=
 =?utf-8?B?aFRsKy82dDJYR1gvb2VHOTk2TVp4MjBvcFZQQi9rUENpVEljNGlZc3N2cElZ?=
 =?utf-8?B?WWtObTMzbFhuRGtwSXVNV3JyWk1NU3kvVEhSZDl0UmtYeEJ6QWxwcmtnQkZU?=
 =?utf-8?B?QmN5M3dLRnpROWRFYTRPWU9GMXlGR29pankrbjM2c0czdTJYSDhocWJUWHFM?=
 =?utf-8?B?eWoxWWtZWENzTDZtZkpFUjc3RUZPaHF3WVZvK3RIYlBlL1FwTmdnR2o4U3JZ?=
 =?utf-8?B?Smp4NEJvNkN4c1ZiUW03Z2hxS3NZUXVwRjZwNG9WZHhzSDZFdnorcWZ3Z1kz?=
 =?utf-8?B?cjhheEhSK0pNOWtOaEgwTGlKcGoxNWRDYnZqOFUrUjErcFpmVERxTldkVnl0?=
 =?utf-8?B?amcxZUIxeDMvVXNnQXQ4T0NNZnFtYTQ1eWErOURuNFdzUVN5UkprTlNJaGVP?=
 =?utf-8?B?T0licitIK3FSckRkLzExWE90SjFpRnZJb3Y4OE4vWDVYSzk4eUgvV1p1c1h3?=
 =?utf-8?B?NFFaU2JBWG1EWU5PNXJQTjJnZi9yQUJxOStZUTRqL0t6VVl0ZGtkbjBzMHFM?=
 =?utf-8?B?RDJGakx3OUd4ZVIrbURCakJhR2JHRlV0UDlYdEdpYk9iM3BidDJEblQ2Q25T?=
 =?utf-8?B?aHhmMytublZGSzE4WVY3OVhXL3ZncVh1ZEtMMmpHcFpKN3ZKV3Q4dGlNQjVN?=
 =?utf-8?B?Z3hwR0l5dlNMQVQ5QThRMGNzcHR3TDhuRnlDNTFhZjk1VG1qQmlueVZXTUNC?=
 =?utf-8?B?S2FLenMrcjlhRmlHcFZUVis1SGx1K1V0alJmM2F2ZjNTOWhnMnpYNit0TTFJ?=
 =?utf-8?B?ZEtvcURUMEhYcWlXMzdEeDFkUlg4dnhWeUZjN3UvK25UN2RKQ08yaDd2bE54?=
 =?utf-8?B?UlFPQk9ZZG1OeXRhRmhXNXh4M1BYd3kyZUhPODhrQlM4MXdyL2FVQ3o2OU53?=
 =?utf-8?B?MEZkcnErR2d3NUFXU3cvT0FDN0lBWU00d2twbEFYVUl2aSt3cTRGZWRCeTVH?=
 =?utf-8?B?blROdVdOanhFZFZIZ3VKekFaWU0yd05GYk9GTVFoMXNHOGZsSDgxUkxudWU1?=
 =?utf-8?B?eE4wN1NDNThZcFpOZHBKcTVOaWIyeDBjTjFDc1EvQkR3QjVVcWg2dlBFcVdI?=
 =?utf-8?Q?uZz9KVWn4egfx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzBGbjZaZFBXTzZWeFdpRjk5VnpzZUYyOUJaUjYwS3haT0o1NUdXVHNTNktD?=
 =?utf-8?B?ZFEyOGxManVrRExFZ2lvRE8vczQ4TlBjd3poclhEeWY3aFNDTkpFOWFua29a?=
 =?utf-8?B?dmVycmpRcmNKT0w5R0hLbHB2Rm5ZLzNNcGFpMkQ0c25UT1MwUUZMNThJUHNO?=
 =?utf-8?B?dTBRUjFRN2JGZnp4YVdCRmJoV2RqcENwN3VVRjZwZGp3Y2plQ09WUVBFL3Ba?=
 =?utf-8?B?ZVBhM0J3SWFsZTFVZ0VWTkRFaDJVZ1BaSitrNmR3bmxmQkUvSng2U2hjUXUv?=
 =?utf-8?B?M3dvK1E1SlRPOWJyRnNzejloQXcrcndndVlwN0xmT2oxdCs5RFkzd0wxVWxM?=
 =?utf-8?B?ZkUwYWNXeVNuU0ZHSDlUVHBUOHh2dDJZeWFrb3FDWVNpSDBpaXZXVWQwN04r?=
 =?utf-8?B?ZUo5cmFGMkUzbGEveEVOTVdOemx4cWhTeUdlUWVKSmtEUG5wZjVhak8xWXlV?=
 =?utf-8?B?dktESkFORVB3NHBFTXFxeG5HUTlNendoODR1bjlDWVVUU3A4MHZtelI1V2py?=
 =?utf-8?B?MUxuZUpMRDJtdlFOVFB0R3hvbGc2amYrRzBvNG9qQTlHUEhJQ0JjTnJPZXFV?=
 =?utf-8?B?TGgvYUw5Y0ZnMlljTnc0RXBDSFI4eWpaRE8xSjVnV05EMEc3d0xIMW91VFBL?=
 =?utf-8?B?M2VWVUdBbUlZZlFhY1pGQlhPZHBHdnFTekc1TFJGdTdKeXFUVWZYSklRNjFa?=
 =?utf-8?B?b1hDOXMvU2JtRTM2RnFHZXdHVXd1aDVqSm4xWUgvL0NQNmtBSkdQaU9ORjY2?=
 =?utf-8?B?aTFhYTV6T2xZSHN0UlNRYlpMY2hYVGhsL2VUcnRiOE9MelJMWjhuY1R0cmcw?=
 =?utf-8?B?T3Z0VFhZb1NJTUU1cktYRG91SVgxRmdwVS83cU5HNm41Tnp0a0lnT3JPY0RO?=
 =?utf-8?B?UE1TVEhlSTM2VmpaVTgxblBXNytHMUdXT01XL1hlTTZhMDdtVUkyaDdGYndx?=
 =?utf-8?B?Um9qbUVoclpGNnk3SUFXUS9XMUZvWGhzRlFuRlNUcjhQbWwzMEdPblpYWUU0?=
 =?utf-8?B?d3FtemltUmVKdFJhK09COVJHSFFXTzNMRXZrVVMwY0J3UmZOWU93SllUVTVn?=
 =?utf-8?B?alcrZDI1WVMvMHBLenJrU0s4eE41THRJeWV3ZitWcmsxK25INE50VGUxUTFC?=
 =?utf-8?B?V28vcGwrdTVUMFdXaDR4eFd4UHkrd2wrTWlzbHZGa3Zmb0c5OCtPMUJVMk4x?=
 =?utf-8?B?WDFBRGNaR0RkSzRldzdxZ2MzV0l0M3d1aFRHdGdiNzFKcTNWM2FtNzlhN21Y?=
 =?utf-8?B?dkRKOVZOeUladDJvUHVHZC9CVkhqL3U3UWxnRGpJMHVJWnh2TWtFQUNnZFlo?=
 =?utf-8?B?Q3ZPTkR6QlBMQk5QQWVja0pxS01FV1czL2tVNS9GK1ZDcmNlc1IzQjRnRUR4?=
 =?utf-8?B?S2lQU0F4VG1ZNllJYmh1SzdNakZiZWdSb3o0dVhZK3gzYjZGVFdXcEx2QVNX?=
 =?utf-8?B?R1FVTWFVejJSYUZJYlcraW4vMW1BMkNOQms2WitLQStldmYrQUJyYUx6eGdB?=
 =?utf-8?B?TTluL1dxZlJKSy9jZ1I5V0hwMGNpbmx6ZjVWcDJqZHFteWVETTRyQm9XTE4x?=
 =?utf-8?B?U1RNSXZHcEkrRC9VVkJkUkxMNUhwd3hnbmMreG16cm9uWjd1UXpsS3NueEpP?=
 =?utf-8?B?WW1IOHpsN0d2UkVUcVdEdWp6OE1hKzhOdy9QVVJwZFpUdHhpNHFCc25oTElI?=
 =?utf-8?B?RFE3bmxuc2NwL2JWU0FRcHRPRVdEUG9ybVQwcjlndDltUlR5YlAvZ0hQL29n?=
 =?utf-8?B?cnhyQnJ4TWlVY2Naa2RnOU5HaExqRWUwUHFnREYyS0pqRTh5dnUyb2NLYWhz?=
 =?utf-8?B?YkpQVHZiTFhZOGV5NUlwK3VSTlQ1ajFoM0toN1dyVnpUZmF5NGJRbThSekNK?=
 =?utf-8?B?ZEd3cnNoTStPR2xNeGdrT21XS3pCOGRvRnhvTlZLQlRUWXpZZHBMMDhPWjRE?=
 =?utf-8?B?T201Y1ZsZld3TkpWVTBzWHVDVDErdEFXbm9uVi9hdDUwcFVETXhmUytHQzJn?=
 =?utf-8?B?R1pNNEpNQjFOamVjcFRlV0F2R1FVV2VENmYrUno1MnZ0NHNZMmRkQnhMNHZt?=
 =?utf-8?B?L1BDNmxUaEFybmJOQjBKWGNRUi9HampGRzQrL3FRY0xLVklvZ3MvZTl4VlR4?=
 =?utf-8?Q?oWH+UFMHf+yZbKANu/l4Cb9Dz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff19f7d3-6365-4b70-70ca-08dd65a57280
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 22:45:42.3315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhwzAa3dMahnKcJbVFpR9G6AFXCMSbTOzZapVKTbC3ruKI3mvRdQpBq3eQJikYt6ypLh3PytEn7vt+44iNNZ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273



On 3/17/2025 11:25 PM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Mar 17, 2025 at 11:07:36PM +0100, Joel Fernandes wrote:
> ...
>>> I think it's preferring idle core a
>>> bit too much - it probably doesn't make sense to cross the NUMA boundary if
>>> there is an idle CPU in this node, at least.
>>
>> Yes, that is a bit extreme. I believe that is what my patch is fixing.  If
>> previous CPU and current CPU share cache, we prefer busy cores with free
>> previous idle SMT, otherwise go looking for fully idle cores. But it sounds like
>> from Peter's reply that is not necessarily a good thing to do in case 'fast
>> numa'. So I guess there is no good answer (?) or way of doing it.
> 
> Yeah, recent AMD CPUs can be configured into NUMA mode where each chiplet is
> reported as a node and they do behave like one as each has its own memory
> connection but the distances among them are significantly closer than
> traditional multi-socket. That said, I think the implementation is still a
> bit too happy to jump the boundary. What Andrea is suggesting seems
> reasonable?
> 

Thanks for sharing the AMD configurations. Yeah, agreed on Andrea's suggestion.

 - Joel



