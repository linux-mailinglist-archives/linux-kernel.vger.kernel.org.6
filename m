Return-Path: <linux-kernel+bounces-562607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C11A62E10
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76343177C4C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1181FECD7;
	Sat, 15 Mar 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y36hY5Cm"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D4AD51;
	Sat, 15 Mar 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742048518; cv=fail; b=BUeindrqPLJL6wSLwawk4+KF+Vg+bmI5JMIf2jg6cwfdh+Mqx706SN84aS6WjbboUzPHco50yWVvKbwXDPpyDy4oiaUrfkY+IN4Pbq0FqA3jtt+v1jUuKYLu+sxZ74RPhg+7t7K5wo8FILE/nfPcDq7EK49VgyfVJd9vIM6EixY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742048518; c=relaxed/simple;
	bh=zkgHo3GdHKw2KY6EJTMO82Nldxd3hteBAM14bgGOVTA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=VNIpkV8sMddIWuuSLhvFc2g0DNX3V9iaXkwTWt3RyzNrWw6ybY3BdfeykpQmnYIeM+mXVttzIpY5e/W5XyIm7muHPVqfb2ZlEdC/sn7bzs2oJPQsuvzWh6mQSlEbgsXE5Qm0AXyQ6L5VVU57e0eEWNMjWllpwgRxFvfYwWiBbFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y36hY5Cm; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJtCDwMoPA8G7L1Od0XL6uxaSu5r/qE7g+zbZbeah6LWyBI9PS/wbK9PXudSawNjCgfS3KNwbMxsKxDBHjBR1HTGq/PlkdoA42/XZAsDI954iz42rililJwAe6o4NGmlfLvZgoEceRkarZZfm8hSRY66FQk7wB2zJ0BhiPY2IjA3PPEWotxbby4rYehwmR/5fsJixGpTOGJ+y3JQbvI0srLRhUKcNuzuP+MDyrQs+1JYQ4BjzzqE1KfWYmGV4wA4oVm7znZGOUpxSXacU/Q2mgUhFZTjroB8lDR2vhXpvcXrHjcqgZmMGlZngj6UjilKouTRfh4l+pG8ixlBt3kRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL64iXiQIA3I/77FtikjoUR3gGKgeD+ju08hciRPYBg=;
 b=kz7Fhz0EMDcNVHBVTdhVspUs36APAyxdEyK7krbGz+Y1q7snFDCAh58/uIHq5bc2gsXd02yV2g2lhOdLFz0a2xRxFNzYb/Nof9Xf/oshOlAKWdyJAse98FD22OndkLbLkn6ywua+47z8eoU282SzHbwUs+e+CBox6ItEMojyd2p4yTAIa1TpuWsCRAP+aui7IxTfNbF+NUTltUiFTQe5ba0oFDSdmJRy7RU1mufTUhMuhlf41vvp4a5MeAntwFCGwM/MNflCqbLMED2tHpEInN9eTFK+8yuxXPZBH++Vvnhw2FZY6FtYBaeuc+SXA31W+lVFbSJ4KCBKXNEgthiZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL64iXiQIA3I/77FtikjoUR3gGKgeD+ju08hciRPYBg=;
 b=Y36hY5CmgtktaEGgAK/1VM9xtRkbg9T1esnU7oK1b37B6aOM5+FnZfvorPL1IiUg/Ji/CiCxvx0jR326K4dZknK/A66csqmbIAL1Vv0dIpyfdnjKcOrQK2zja5weRUrKOSkzOvwzVwZ7r7C6TIQY2RzAw8RxgcpCUHLY7LDPpEGB/4sM7LXJ+rU+xpFoOloEbCyVb+JVX27y7a1Hm6t3mpAgjrskDij+cU2gY2Hkw5ZEnzXgwa48awHV1L+cna/Oj+GhjJNFBFr0ey8Nr1V2uTCpTe2LDm6270UMpEsNuDkdk5Hjk3ywW7d/79JJwIyEBTYObb8AkMkIhxobxSmDrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sat, 15 Mar
 2025 14:21:52 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8511.031; Sat, 15 Mar 2025
 14:21:52 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Mar 2025 23:21:48 +0900
Message-Id: <D8GWNOPYRQN3.GO3XVERSQUXH@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH RFC] rust: add macros to define registers layout
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250313-registers-v1-1-8d498537e8b2@nvidia.com>
 <Z9MSW4VAjqWd4NmY@pollux>
In-Reply-To: <Z9MSW4VAjqWd4NmY@pollux>
X-ClientProxiedBy: OSAPR01CA0255.jpnprd01.prod.outlook.com
 (2603:1096:604:29::27) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8648b1-5c65-4c04-8f3a-08dd63ccbb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEFiYzFjQTdNV2lzTkd5Ui85bUkyWVdacFVjWGI5Ni84bGhrejNQVUxzQnhi?=
 =?utf-8?B?SEZyaVZvRVV3ZEExVWIxdEN2cyswLzgrV1owdGk4VERXWGx0RC9aaWxsS2I2?=
 =?utf-8?B?RTJCeUZuWExGcHkzQUF3TDFVaFBndFVOMjRrZ2NWUEhVckNWbjh3NStLWmJ3?=
 =?utf-8?B?K1l3WTkxMjdiUU53Z3laZmg3VzlEYUJDZEZ6RitLQlhKTG5VN2VDQlVQTXpW?=
 =?utf-8?B?TzlXZVhUOUF3S2haS3FWc003cWRXT0xTcHFobFhEU2ZYQVQrMFJyejJiTEE1?=
 =?utf-8?B?U1RXWFhkSjRtVlNSejdUekdReDc2ZDVwTUxMeWt6RCsxLzBQV0FBY3g2WFUr?=
 =?utf-8?B?TElVeUMyU2Y3b2o2am9nSmEzQzdxdzJLdkx2eVIxL0xoTHFXYWVmeFB0SHd4?=
 =?utf-8?B?QWlEclJVYVkyTEQ2TTNVK29SWFJrU0QyL0g4d0ZRYXB4UFQ2SWdta3UzcXRu?=
 =?utf-8?B?WlR6QW42MHZRRmJ0VGgrQ2NMaE82QmpUd2d2cXlkczRzRDU2cndFYzEwbjZ5?=
 =?utf-8?B?TW4yR3Z4YVNrcEhPYWN3RURKT0ZVVTlBWk44MG9rKzcvOGh5Wm9NUXo0YlAv?=
 =?utf-8?B?RXdBYkhscy9KQUpiaUkxbGZjMEE2dTU4VXdValc2bktpVTkzc0pNa0hna1NL?=
 =?utf-8?B?Sm5ENEFKVGFXcFc0YURjVnJaUDBZSzRpclhENHR5NWE0Yi9BNnNDVmVMNDlW?=
 =?utf-8?B?YjJmVXorSzBtL05oclhzS3cvamd6ZmpyWllJdllOYjF6bnhXR21zUGxlS1Ba?=
 =?utf-8?B?VzV4MWQ0OEdaRlI2QW5nTnpjMkRBYVB5MEkyMWFxU3c5U3U0UGVHZCtjbk43?=
 =?utf-8?B?bUQ4VHdrNHdFWE9DMkNHVEUxbStiaWIyNHgwNGovRTMxV0xjb083MHFsVzc1?=
 =?utf-8?B?SUtReW8vLy9PZUhLK2VQNTBHTi9LNTlUaDlkTXdGVTdwODJvdHlOTXdxOUxY?=
 =?utf-8?B?aDdvRHY3OFdmT0REc1F5akNIMTJ5MFArRHRTSjdjeWdWbXo2bS9hNGErdHk5?=
 =?utf-8?B?QnNmak8vRVFKUWUzZStWQUZzYUZBUEhKdWx5T2o0VUxqdVcwbWJQQmR4b2I2?=
 =?utf-8?B?eThFbi9Hd25JSjltbG82cXFvc0FCTlBXV0FyMTd4TzhsTnF3R0YwYzcwTUdS?=
 =?utf-8?B?ekRWRGJVOXVXaGxBZzUvdXpOOWNlTHJlKzZpc3Ric0E4aU1OZmNiOXpMQlVD?=
 =?utf-8?B?dHcwUy8vZHR0VC9nSnBtZjJBWWtIdTY0dlVvSEJFenJmeFlZbFBNekt5QW12?=
 =?utf-8?B?SmxRejcwalRZcGpDdVNqdFNienN3dWY3MnE5ZXVWZC9KL2xKcWcyUjY1dnF6?=
 =?utf-8?B?ZWFBdGNPR2theE5vaG5PU2c1UFdyWXVXN21XOTNyNGExeDJmYlJuWE5OK09T?=
 =?utf-8?B?Zno5NjZjTmtYMWtORk1ubVc5bTJKVXo3TGNuR25IUXRTUEgwdlV4dXpXanY2?=
 =?utf-8?B?UWFnWnRTSUY4YVpWY01WUUNpcklVL0xmVW1qZnAyN1dhYjRXajNBNGhQV3Y4?=
 =?utf-8?B?RmRuRjdEV0JjS3phRnpKeHVhaEdxSW5vYjlMU0g3R3BjS0tIOFVVMm1vLzM1?=
 =?utf-8?B?ZWFGQjI1NjlyS1NWVmhqbmpidVp2a2lrMm03eHRZcFFOZkZlS1ZwNlFlODRl?=
 =?utf-8?B?RXBFOVRHOEZtOC94NCtqcHFtL2pOcUhOQVYzVUhySGNZbk5GUytjT2x3WVM2?=
 =?utf-8?B?MGJIZWxVUlZpcEVGUzcrcTRTTkhrcnZRRG9oejJMamZkcGwvOHVUMXpXeDY3?=
 =?utf-8?B?dDJVSzBqcUxXMGZZK3VhQWd6cVhTRVZkZ1F3Wm1jRTZncXNZWm9GYmZxaXBk?=
 =?utf-8?B?RWIydTdBc1EzZnYwQ28zc1dKSGZORVIzckhFeFg4VVlXYVUwd0k3QVduUldH?=
 =?utf-8?Q?sw6bWd/W1sjjy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFRibSsyRENHR2JlZWlsbFdqNkV6L1hKc2pOZm0xTXh5VGt4ZC9MVHZWZWts?=
 =?utf-8?B?MlJRckZHR0czS1pob0ZFMTcxVEdKVGNsTDM2MDZUY2lqNmFtQStHNTZnMW9a?=
 =?utf-8?B?bUYydWhZVnY5MllpSkpTMUpTTzJzckN3OGdwQ1JZcXFIRFV0Y1FPZzlVWWcz?=
 =?utf-8?B?cUYyZy8zbjRhaGw2Qmp5eWNPV2ZhRkR2QVYxTTA5TGNOR3BPMjhIdzVickE5?=
 =?utf-8?B?ZUx2UUUzRW0xODgyQlZBM3BoMFlPZUNoRzZ4OTBGQ0NzVHBhcXNNUE1ab2lz?=
 =?utf-8?B?eUhtRDZTS2h1OVhTSjVQWkZmbXNySEZOREY0Umt0RjZYdVZhdU5sYmJ5R1JY?=
 =?utf-8?B?Y3NSTjhKdDFHS3MrVGZXcU9WVW1LS3d1QzFITHVIYnlIOG1OM1cxRzg3Y0I5?=
 =?utf-8?B?M3oxK1RDQnpaS3JOdHVDdnVRcXQzcU9kc2VhVG1BOWI5L1RzdVd3dHhpQk9p?=
 =?utf-8?B?V0xpcGFUOC9GTUJPT1ZlMWlUN0NJZlp0d2ZYbWVLVkNjVjlWRTk2NDBzTlNj?=
 =?utf-8?B?bFA3OHlHUlU0OUViZEJna2JoWjBSb0Zmb1JERHRxbE45RkhkOVh3Qk53c0E3?=
 =?utf-8?B?dU5QbEc3czAwWHkvOFU1aHZEL2IrREtRLzA2dW5MYk5hKzFSZnZYVGRPUkIr?=
 =?utf-8?B?aEZmMGRVeml4U05XeWpndWFYNG9BM3dkMk9HRzBkdnJZV3VWOG01VDB0eVlM?=
 =?utf-8?B?b0Y3QjVOeUFkMlpScW1FWmYwaWY4Mmt2bzhsRFRqQTRWaHBWTURhaEJPclVS?=
 =?utf-8?B?TUU0NmVUZkZOejFWSU40OEt3b2hDb29qTDliTkY0Q0ZnMnZRSXFLd1pSdEFu?=
 =?utf-8?B?TE1IQ2NMTXhHRE0rdU91SUJma3lpZ2FGUFhmM3RqbzdIMlk2aHFKZ1U4ZWVU?=
 =?utf-8?B?MmtzMVFhUU1KazkvWTQxeWpacDlsU2xUUXFaYXlkRW5KcHg0YWtHZTVsV3Qz?=
 =?utf-8?B?Wkp6QjkzbEk1K3dzd3RTdzJxcDgxQlMvcFU3VVFmTS9MbUNCVk9GZVl1L0F6?=
 =?utf-8?B?QTNTbXJDOXdSaEI5emUvd2N6RERkQ3pCczVocGRaVHA1c1MrdUZaMmJOeEpz?=
 =?utf-8?B?QjdyQitGWUZKMWk2bFgyWkNkMEY0NmxDN09GMlg2UzJIdElYa1dQL3J0TkRy?=
 =?utf-8?B?cWtzVE5YTVhVWGVVMy9jaWxFSnc3R1FhVVZXcEpFbnhRNVY4WVdZOFU0cytw?=
 =?utf-8?B?TjMralhDamMxNVpibHB6cnFoK20yRGFhNW9wMFVIMTFMdVQ4T25Ya0tmVXEw?=
 =?utf-8?B?R0Nwcm8yOVRpZkp3eUtCTHRCWjRuOG15TEo1SnJEVy9MQnN6VVpoS2owR1Ra?=
 =?utf-8?B?OEtpQWFHemw5aHNiUjBSaVFqVVMzWnJ4S01qY1FpTGpWZy81OTFjUnI1VStk?=
 =?utf-8?B?aFAxazQ5eXlkM3hjcS9ZL3lEemtXVFVuQjAvbDZGRDg0OVVKaUtpSVc2cE13?=
 =?utf-8?B?U1RIWmNvRy81T0FuZmdEc0x5bEJBYnBlWkpyakdIUEdaOVlGY3pFb2wxejNm?=
 =?utf-8?B?TWFYT0JVMWZqZCtCV1l1L0Jua1dkaitHNVdCam1Hd04vWDlxc04xSWpuaTJM?=
 =?utf-8?B?RmQyS2RSaXRMVEFFc1Vnb1lhb1hVMlp5MFQyNHZUY0dxNEJiQUlQMHZvSTVm?=
 =?utf-8?B?SVVWcmxCNHBZelBhZHNhTDlJQzV5NG5mcC9QZFUzM1ZKMG5aYUZCb0tqb0Jh?=
 =?utf-8?B?RHNvT0R2aDd4VGNKUU5RWEVtdzdjelkvVDZNVHNob0hiV25McWJBYTRjV1lY?=
 =?utf-8?B?YjVpU2p0aGZFb1E2UXR2K2x6eGROUTBTalhxSEZuY20rWWVhSjZLeTJaaTFW?=
 =?utf-8?B?dzRFbitadFovN211MEh0b1RqZFdGYnFiUGhScTl4ZDZtZGxFQWpxSzZicGpv?=
 =?utf-8?B?azFSRHV4ZmhGV2ltd1hLbURYd1E5WWVSMTA4d1pVcHZHVm9PdmF0TFdNYklm?=
 =?utf-8?B?OWZudXM3MHZzTlozY3VjN2UwbUM5cEZvdTlEa3JBa3luVUh3UGI5QWxXNHBJ?=
 =?utf-8?B?c3FFZWpLR0EzcGExRU5BYkxLcDA4OGNhQUszcjdoNXlLMWUvZ1FTSHN3MnZV?=
 =?utf-8?B?Z0lIbHpRaml0eEFJNTZoTHp4SlBlZEhoeUEwMTdjOHhWU2pHUGphK2tnb0t3?=
 =?utf-8?B?VnBFVjJmVlVmcTJBTEhsV0l1aXJyOTBjUzRIaDBuZ0dCYTgzV284bU9GOWlv?=
 =?utf-8?Q?TjmQknb4IUXZHhQTDe1ioZsEo0cWxNKtKMMdctlc+Tv6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8648b1-5c65-4c04-8f3a-08dd63ccbb22
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 14:21:52.1960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INsU3Ek7KS467WRxTn70klB2Gg4xNJI5DXPWlxPmYZ7ljOggnqwPMwjumDnokW3m78D6V3B2dRVV/Ll619yFig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972

On Fri Mar 14, 2025 at 2:14 AM JST, Danilo Krummrich wrote:
> Hi Alex,
>
> Thanks for working on a generic solution for this! Few comments below.
>
> On Thu, Mar 13, 2025 at 11:48:25PM +0900, Alexandre Courbot wrote:
>> Add two macros, reg_def!() and reg_def_rel!(), that define a given
>> register's layout and provide accessors for absolute or relative
>> offsets, respectively.
>>=20
>> The following example (taken from the rustdoc) helps understanding how
>> they are used:
>>=20
>>     reg_def!(Boot0@0x00000100, "Basic revision information about the chi=
p";
>
> Should we call the macro just `register!`?

I was thinking this is maybe too generic, but yeah it probably makes
sense. ^_^;

>
>>         3:0     minor_rev =3D> as u8, "minor revision of the chip";
>>         7:4     major_rev =3D> as u8, "major revision of the chip";
>>         28:20   chipset =3D> try_into Chipset, "chipset model"
>
> I think we probably need an argument indicating whether the register fiel=
d is
> {RW, RO, WO}, such that we can generate the corresponding accessors / set=
 the
> corresponding masks.
>
>>     );
>>=20
>> This defines a `Boot0` type which can be read or written from offset
>> `0x100` of an `Io` region. It is composed of 3 fields, for instance
>> `minor_rev` is made of the 4 less significant bits of the register. Each
>> field can be accessed and modified using helper methods:
>>=20
>>     // Read from offset `0x100`.
>>     let boot0 =3D Boot0.read(&bar);
>>     pr_info!("chip revision: {}.{}", boot0.major_rev(), boot0.minor_rev(=
));
>>=20
>>     // `Chipset::try_from` will be called with the value of the field an=
d
>>     // returns an error if the value is invalid.
>>     let chipset =3D boot0.chipset()?;
>>=20
>>     // Update some fields and write the value back.
>>     boot0.set_major_rev(3).set_minor_rev(10).write(&bar);
>>=20
>> Fields are made accessible using one of the following strategies:
>>=20
>> - `as <type>` simply casts the field value to the requested type.
>> - `as_bit <type>` turns the field into a boolean and calls
>>   <type>::from()` with the obtained value. To be used with single-bit
>>   fields.
>> - `into <type>` calls `<type>::from()` on the value of the field. It is
>>   expected to handle all the possible values for the bit range selected.
>> - `try_into <type>` calls `<type>::try_from()` on the value of the field
>>   and returns its result.
>
> I like that, including the conversion seems pretty convenient.
>
>>=20
>> The documentation strings are optional. If present, they will be added
>> to the type or the field getter and setter methods they are attached to.
>>=20
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>> I have written these initially for the nova-core driver, then it has
>> been suggested that they might be useful outside of it as well, so here
>> goes.
>
> Feel free to add my Suggested-by. You can also refer to the corresponding=
 task
> in our nova-core task list.

Sure!

>
>>=20
>> This is my first serious attempt at writing Rust macros and I am sure
>> there is a lot that is wrong with them, but I'd like to get early
>> feedback and see whether this is actually something we want for the
>> kernel in general.
>>=20
>> The following in particular needs to be improved, suggestions are
>> welcome:
>>=20
>> - Inner types other than `u32` need to be supported - this can probably
>>   just be an extra parameter of the macro.
>
> Can't we figure this out from the bit mask in the macro?

We probably can't do that reliably IIUC - a 32-bit register might only
have its 8 LSBs holding useful data, it would still need to be read
using a 32-bit access nonetheless... Or maybe I misunderstood your
suggestion?

>
>> - The syntax can certainly be improved. I've tried to some with
>>   something that makes the register layout obvious, while fitting within
>>   the expectations of the Rust macro parser, but my lack of experience
>>   certainly shows here.
>
> Did you consider proc macros for more flexibility?

Another rabbit hole to dive into. ^_^;

That would probably allow a better syntax, while at the same time
solving the issue of the exported helper macros. Let me give it a try.

>
>> - We probably need an option to make some fields or whole registers
>>   read-only.
>
> Ah, I see, you thought of this already.
>
>> - The I/O offset and read/write methods should be optional, so the
>>   layout part can be used for things that are not registers.
>
> I guess you think of shared memory? For DMA we already have the dma_read!=
 and
> dma_write! macros that may fit in.

Right, in this case you wouldn't need to access the value through Io,
and only the field helpers make sense - so I guess they are orthogonal
with the Io access impl in the end.

