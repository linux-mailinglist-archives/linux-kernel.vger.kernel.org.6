Return-Path: <linux-kernel+bounces-559761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3895DA5F939
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F65169145
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915552686BE;
	Thu, 13 Mar 2025 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eyGFkwUQ"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF0628691;
	Thu, 13 Mar 2025 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878500; cv=fail; b=jZSLcgZO0D7V2Eg+MVqUCOJtoQZxe8tVTWH8dXmv66ZXdxdNspD9ctqdwJeeistTgctO6S5vzoa7d8+L71a7fJm45cLGXlMaN7ZibzhmlzCskZ8rXysdsEDRtHDA63BzcncwNoNBR6daTyWk+7hAjxoyWeo6ZPlfhpXUTdcCcoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878500; c=relaxed/simple;
	bh=Y2YBa4fqbcxlE7tnmOb+q0kp3IKwY+a96dPXkYAm9Cw=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=BlDwegeS6dIAz6p2qS53aSR82wHH7wCO6UG0igkUK+XQnEEYeCA7GyT6mpt215IUa+yvLLoV9mRtCTkNftIEPc/O2swbyS1fO+tzO1U2Dh8UrzZE8Gz6wjFVUB7NGR5owAZ//bm790PLUCARDJGMpk6awznmzZyty601VZBjip8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eyGFkwUQ; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDclJZ3yoEbr5b9j7YR69fxp9u24lmXV+WGDVsQaogj61SNX5CutO+FQyjo/vLyDcyyBP219pGqifZn+KbwbsWGTTRChoGtCRCgUIbg+mUqGEw+36U/2iVpElC9ukSB8GoY7RCOORDorzgqrRB6bjYHmKy/Ik6HBKhsWSwtUzxJ7nWVQGupTqlr/SrozhbkaDu0tqvut81n02gtcxS8sYjRjNd1XwS7Arf5Iu2WhB2bcOe7IkeR0xbAImTnDHctk/O4hyRKtYBZytGkQp+AcJ+5KjatD14q3tS8mG/3t90jyMTNHbjLAqhQUpeU/ufDeNfUXK0cvtE4b/9FmyP8XjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey3GN34wfX/7yNncAA66LuwFrZj/sMrJ9vCS0KAyZIo=;
 b=Yl+MAKUVQYFLAYG1S//WFLF+7u373LJTZUGxAG7slyRtkRtVH3TS7H2yWfK+bD6qBPGiuQSq+6hPEgnRXvVY6fmzV7alT2J9qMv+DYnpcxgSVBf6t2T1O0HWWSFqy39aHrIl1yLwLpSxcSk7YlUjTByD2s20L16abdnNW3FeUiPRARV58APuBuHlfTMtjotN4VfGCAJIAijziNieXBeYs6daavG0lxKzJONOjPzc7dU3hK1hd5dPZN0pDUPAclY3kS36l6Iortodb0RadsjNO5i+RVIWQxH5eykLKIYshAeIzBf//26uIjzZRHe3rSNye7ZbJi4eJCt+ced0m98MKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey3GN34wfX/7yNncAA66LuwFrZj/sMrJ9vCS0KAyZIo=;
 b=eyGFkwUQdD49tfHxg/KwiR2V/zelYY7VwXV3Sg++c36n8dZV/3Q7Mg/pgn29z6EQTBmRPrUdHH6Y3IlewqDV8VBAvNLzvzk3CMr/n0IZVNcFLjxL2YPQL8ejYWBUex+g4lb9LXBMz024d0GasF64ZM66UR4TwUKe5LFzpjwCjTqLY/mRFkJ92Mb6/qpNmMcq90nmGGinFMOdyR3F3myHjyg3M7ShvUqn8DakXzAH/TvI2lDITXVGTyQmOuFKXWKbOjNK8bjygEj+3FbBKbHpLWBHWCOQ1k5Qf4aAdmt+hAlBjb1pZ/1nze2onSPs9mJyzYcmpzgGHlAozeeBumi9mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 15:08:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:08:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Mar 2025 00:08:13 +0900
Message-Id: <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com>
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Benno Lossin" <benno.lossin@proton.me>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Danilo Krummrich"
 <dakr@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
 <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me>
In-Reply-To: <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me>
X-ClientProxiedBy: TYAPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:404:28::36) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4f5e1a-8949-46ea-2126-08dd6240e1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEc2UjJwTHcxeVRSQnJ3VE1mNUQ3emlTTllUbFByOG9CenV5aS9NSkpnT0FT?=
 =?utf-8?B?SUNYZFRmbjYvQ2VXa0VQc1hmVWlkOFczZWJydG1oMmpCdDlIRVFzSHh5VU5j?=
 =?utf-8?B?c2QwVVlwcG90alp5YjlCUzVwM0FnYWZYM2ZtL3M4MVQzVWJtMUJmVUtvbG1l?=
 =?utf-8?B?YjhveDYxdUNPRk1JY3puRHlabzRwTkJGWmFmNWhubGtnOWZPZC95N1hPV2ty?=
 =?utf-8?B?SHVoNmNKWmozeGNRa1VhUi9PYjB4QmdYaGU3VzRjdThrQ0NERktkdE5BT1Ev?=
 =?utf-8?B?YVZPcnJwcUVUbVlqd2tXSWtNV09zdFh5aytLQW01RHRzMjU2QzhMbVkvYnYy?=
 =?utf-8?B?NmR4RG9GOGVESkF5U212QWpWTGJJU3ZReHRsN1krZEJwTjEreDI1dmg0VGd6?=
 =?utf-8?B?NlBCOCtDbWo5cUo1amFyblFoT0JMd2hhVFk5bERpZFFkekU5L3hQanB1MHlV?=
 =?utf-8?B?cmhPRkcxdWZHMFFJTkpObDdjcVNGNlV3dFh2bktVczZVVCtpUVNYNnkzazRx?=
 =?utf-8?B?OFZ3dURtTllHZGRJWnA2eGhUT3VQUTNKWjV5RVJBTTJ4Wk1icXNqVFY4NXhl?=
 =?utf-8?B?d0F1VGpXZDJNUFVvWDdTUTk0M3lRM2FpZWEyTHlLMFdkam96eC95MmwxbXZV?=
 =?utf-8?B?SlJJMVFieFNhYm0yNzZpNEU2L3RvS3RVbzFZcVJFdnNFSE1jSmFzZ09YbEcy?=
 =?utf-8?B?dFBwcCswNzdYUERROFk1VGZVamdjV0JuMlFSVitEeC9MdmhXMG5MN3N0Yk1q?=
 =?utf-8?B?aHYrZ2xXYWJ6bUpDemMrak51elNwOWpDNU0vTGcrZjhhR25VZ2xVZlRHdktj?=
 =?utf-8?B?aUJ2VXRqcUNTMGxXNENJM3ZIMEExT0ZZeHFQTjJKMy95WFZ3K2ROUnFkdmdJ?=
 =?utf-8?B?MnZOK2FpL0VSa3JnUzcyMGZ4dzRNUldoaUgySnlCM24wallGS0crUGFaelZJ?=
 =?utf-8?B?MGJrWnUzSHE2SUpMdFllSUhMVVBjTTBIU29XQ2VMbkV2VXlZZ0U5Y0FESFIv?=
 =?utf-8?B?cG8zRVltZHRLQ0VxWW1nemJtZitad1AwdDVRbS8xSGY2SmxwbUZncUJQbEFq?=
 =?utf-8?B?enprMk5rUldkVWhQMisyY01pSWJlamllTU16Zllrc2JLbUtHbmRoRUFEbFdJ?=
 =?utf-8?B?ckUzUSttdXorWmxBODVuOHB2d2pJeUF2WGZENHE2OCtTM3JUSnkvRUZkcFN2?=
 =?utf-8?B?N3YyZEdpaWlVRDVhcHBjTk50bWhrcUlPbjZldVNFK0F2ZkJ5eEVYMHJDem1a?=
 =?utf-8?B?TlRYODRPSUpRMktTaHpKNUE5QXFDdEJjZm9JMVc2NTJzekR2aHdwUGxta0I0?=
 =?utf-8?B?QWwxTmVlQ2N1bWVXSFE1MTd1K2xiREVFVE9jQzhjWmw5Q0tqMW5wL3JXREw0?=
 =?utf-8?B?TnFld09vL0RBTXBmbEw0MGN6UkYrRlBZREcrYU9rdkdNWEpkNWU1SEo1Snhh?=
 =?utf-8?B?RWtQcjEvK3RPajU2TmJJYUgvWnd6L0ZZVzgxcGZqVVoyVTJLYlR2a1pGOHl1?=
 =?utf-8?B?OExxT2tnSlE2Y2JGVVprR1pFTU1RZk93ZVBscnlsbXc0OXAxT3VzL1BJVStt?=
 =?utf-8?B?ODN0cE5sVmFYbjY0d1VaWWk2dDQrRUdlenpTL0NSTHI2YjVJczNyTVJtVHpm?=
 =?utf-8?B?dkZoRkdJanUxOEFnNVh6Ymh5cDBqOUtDYzZnaXkydGk4d0Z1bjBacjgvOVBQ?=
 =?utf-8?B?QzJmbnB2ekZrU0hQaDJPYXdSQkwxU2UvbEVqZVR6UnI3Rm93WlQxL3ZranlY?=
 =?utf-8?B?bC9QK21MVGF0YU8zN213V0JDZytkekFuV211a09QMVVvVUZXcEN4Y0pwTnF1?=
 =?utf-8?B?NDFtbktTU0tabmRiUW8zdW54dlhKMnpxbmppUHlXeUdHNlF6Vk9FVFlNR01q?=
 =?utf-8?B?OU9CYkNKY3RrV2hzTGhNTXdUaC9MTG9MU3JGVFAwYXJaNkc1ZXVMK0M2VGRo?=
 =?utf-8?Q?mSZTLVciFGA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjE4bUVvc2xubGVHczhZc0RYNG0xb0REM3pXS3RjUFhadC9aN2NJL3NzbHc3?=
 =?utf-8?B?d0NUR0lVZktFUytuczBQOTJpeDRYZ0pDSTJZZVQ3ZDlSMlJZRk9lVW8yV1hS?=
 =?utf-8?B?eGtxemJDdUhGaDhyeTJLSFNvNmZSV0N6NjczZHZMTGIvMXM2M0kzZUlkU3V4?=
 =?utf-8?B?dVQxb2Z5RW5DdUFmamUrUEVpazF1OVRCT3JnVU9NYlNvMzNINXRzdndOKzJv?=
 =?utf-8?B?b0tXUWVvZHk4WGs2UWFWVE9oT0NHOXIzTUJyR2k4RFY1N3g5UU5tRXlUN1BU?=
 =?utf-8?B?eXdBQ2FKQ1c2RXFhblB6Qk9tKzNmZWxGeGFEbkx2Z3JDQnBuSk96WjMxWk9y?=
 =?utf-8?B?QytDeUNWbzJaT2RQL1diRWwweWpSR2FQNHJ1b1FNS2RSYVZZZjlHVm5UL1ZP?=
 =?utf-8?B?ejhoK2JRbG8zSnRIYzVYUi9kZHVGcVovMWViU2lSNERQTGhpbXlEL2RyMnA3?=
 =?utf-8?B?SUJQa0tQNVlGRXRoZDRxa0tHR2ZkT1RTZjBYZHpqMnV6SUMxc2o3VnptcDFF?=
 =?utf-8?B?ODNacDU1cmlvR2RSdHZBYmtXKzRFZEdxaUZBeU9zaSttUkxJclUwM1FVMjBO?=
 =?utf-8?B?ckpDM29lSTB1WXBmNEtTcEpHZ3gvYXNwc2xvQ3BnWDIwbzZHYmVSbGxsWitV?=
 =?utf-8?B?S2lIeDZvemsxZWR3MkVibzV4NUJYeFBKMEJpQjhkRU5jSGtGQ0JBMGhnSm0x?=
 =?utf-8?B?L1pBdUNCakpvUWhXU0d3T2RFMnRXWCsvdGZIVkJULzdlVm1jeUZURzU2Z0xY?=
 =?utf-8?B?eXFvTHpVZy9KSDJQOXpVZ2lsK0dyM2V6aWY4cllLVzdXdldOODdHdkhEbHVw?=
 =?utf-8?B?L3JNWDZWME9nUEc4RUJLVDRMQ2QwSWo4emk3SmhudGJMN204ZHFXNDNNOW5x?=
 =?utf-8?B?a2FVOXNKOFBCdHBVYWFZKzA2UG5VVG05RUV5R081eE1QUjhhakFuY25JNWR5?=
 =?utf-8?B?amQxNHB3UHQrQ2t1SWhONFkyNlRNcWR0dHZqMXRNRUE0cVdXTDBHSjVNaEc2?=
 =?utf-8?B?c2VDSVBGajgzdjEzQVFva041VE5PNXlIUkpQQXRNZ2VNQ01sZDEyQ3lZSWZ1?=
 =?utf-8?B?Qkl4RzVZbWxUV0c3UmorbmZKL0NUYjJHQmJxZzJNOFNlYmlIWjJDVTR0eFBJ?=
 =?utf-8?B?VGRZdnJpRFpUTGRtd2d4REYrcGFHYVhIS21RS0h5V3htOGN1ZDYzQXF4QWlL?=
 =?utf-8?B?SzM3K2pXdUlySlN4UTZnNnl2M2RtNTZNcmgxMnp6NW02Mkk5K2hHYlkzbW93?=
 =?utf-8?B?Ti9IRTBCdTV3cWlkNVB1RzBkMitZcXZmWXpJOVJOQzNKTFZWZ0ZrQ0lUUGVq?=
 =?utf-8?B?NnJnSzNKOTlKdnlKYmpqYzUzcjBXSms0eFZNclZQYzNnYXpoRzFpV3AvOGFa?=
 =?utf-8?B?MEhFMHRwemhpUGdoaEZGLzNXZUpwNDdNWklwbWRYTUwzWFVDOUxjbjM4OUtS?=
 =?utf-8?B?aUg1VEYvZWpCWkNicVJiNHVuekU5N3VCMnR3dTZFVTM2UE1wUHpLSm53Um12?=
 =?utf-8?B?WEE4dmllT1BtNTZWM3dNWk5helJxVzVYS0krVDhQOThsRUE1dXFqK3RMYXRl?=
 =?utf-8?B?U0EyaEtVNkxJTU5sQW5BS28yVkwrelc3dTlaeVY0NUVUM3BvdDlkRWREZGZm?=
 =?utf-8?B?QlgraG5ncDBhTjJjbjhKZ2UraFl1RFlvK2pqUTRLZVVtNExnWnFta3VTSEY2?=
 =?utf-8?B?SDhzYk0rT0dncnJNbkJBcmVpaUtNMEErL3lqb0RMNllTOVpSOUlUczJzNWtl?=
 =?utf-8?B?WjcyaDV3WnJndjFqL21ScDl3YXpOcjliTit3OXFrUEJMNGNBOGF2czJ6WFZQ?=
 =?utf-8?B?V1kzS3hoT3dLb0NsSldEeXQwNURONUcvODhReDk5am5iYXVjdXIvNGM0Tmlu?=
 =?utf-8?B?RDRLRzRxUWwzSGdib2ZXdUZ6bzJTYXk2U1g1RkdNakUxRjJRR1E0YyttLzFM?=
 =?utf-8?B?dlR2T3JwbGpiN2R3MHNVdDBtZmJ4eE50TkFyRUkxemVtYkJIWDJadlVMamxj?=
 =?utf-8?B?VzJ4T0h3YzdZSHdUb1BvRmJTR0dkM2JBSk01YlM2b1YyTEp2SHBnTzBpYnNq?=
 =?utf-8?B?TU4zYXlnYmJ5RGZWMUtJbDBvWGdaUDZnbEJDZzZBbzZocmlqa0RVZ2tYNmJj?=
 =?utf-8?B?VnZ0N05jdkRGQjZETCsyM0xQWTFoMDRuL1JWKzRrc2hVbm1JVFBIOHdPZ1oz?=
 =?utf-8?Q?6Mw7CcYmV3V/ipIVLqTdtUrWyp/ikv8yBQxx7Q4oClRf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4f5e1a-8949-46ea-2126-08dd6240e1f9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:08:16.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3k3ZjkNEXnjBg3vrnfxtFxUroLfd4DHdP4CwEJ7oaxMrxkfO+mtN354c+e9cuG0M/kIi+nGFmdnMI0Z6AcFcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316

On Thu Mar 13, 2025 at 11:19 PM JST, Benno Lossin wrote:
> On Thu Mar 13, 2025 at 1:40 PM CET, Alexandre Courbot wrote:
>> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
>> index 1e5a9d25c21b279b01f90b02997492aa4880d84f..0157b20373b5b2892cb618b4=
6958bfe095e428b6 100644
>> --- a/rust/kernel/revocable.rs
>> +++ b/rust/kernel/revocable.rs
>> @@ -105,6 +105,28 @@ pub fn try_access(&self) -> Option<RevocableGuard<'=
_, T>> {
>>          }
>>      }
>> =20
>> +    /// Tries to access the wrapped object and run the closure `f` on i=
t with the guard held.
>> +    ///
>> +    /// This is a convenience method to run short non-sleepable code bl=
ocks while ensuring the
>> +    /// guard is dropped afterwards. [`Self::try_access`] carries the r=
isk that the caller
>> +    /// will forget to explicitly drop that returned guard before calli=
ng sleepable code ; this
>
> Space after `;`?
>
>> +    /// method adds an extra safety to make sure it doesn't happen.
>
> To be clear, you still can call a sleeping function form within the
> closure and have the same issue, but I agree that that should not happen
> accidentally (or at least not as often).

Yes, this is by no means a complete solution to the problem, just a way
to better cope with it.

>
>> +    ///
>> +    /// Returns `Err(ENXIO)` if the wrapped object has been revoked, or=
 the result of `f` after it
>> +    /// has been run.
>> +    pub fn try_with<R, F: Fn(&T) -> Result<R>>(&self, f: F) -> Result<R=
> {
>
> This (and below) can be a `FnOnce(&T) -> Result<R>`.

Indeed, thanks!

>
> Would it make sense to not use `Result` here and continue with `Option`?

We would have to return an Option<Result<R>> in this case. The current
code folds the closure's Result into the one of the guard's acquisition
for convenience.

Actually, I don't think I have ever used try_access() a single time
without converting its returned Option into a Result. Wouldn't it make
sense to do the opposite, i.e. make try_access() return Err(ENXIO) when
the guard cannot be acquired and document this behavior?


