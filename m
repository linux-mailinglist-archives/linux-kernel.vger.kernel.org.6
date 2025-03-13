Return-Path: <linux-kernel+bounces-559758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F6A5F92D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9178E17BDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A082686B1;
	Thu, 13 Mar 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aZyvDSA9"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D7A241C8B;
	Thu, 13 Mar 2025 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878159; cv=fail; b=kKZqZlXkt7Nr7IW23qeXhysKMzENE4ujFd5Tuw+XDTEU4/5JPE9HGWzb07osFETMGU1xdgerU2l0JKRc3HrEBoq8oeVuPvFcCklo8yqHVgoRMd3ge1zlE1Mzn5z55eUUWaKFBcaWfOmiEf7bRfzG76fAnU/QSyQ4XFpY7pn1gQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878159; c=relaxed/simple;
	bh=dh/GwsY7+7OI/mCyX/iDwsla5p6xkt44x7um+zCPxdM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=XSS1gLAQizR6XO5z9cfI6hlQUICK+uFC7a5CnMFnmE8jcT2xzxaTZhkNI5Uzqh2BJc+3gkrQVEBOyCdb0EotGNNYLuyMxXY8Z8rVce/jw6X7AzYH3SGKDRfnoMZlbRJsDZvJVRSUmkaoDMpaGEJ4MN4qm9uFs1A88khIiYFHqAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aZyvDSA9; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzPyafgnvwxYnmardy9Rmi7nYS/a79hSz6oBFFIUigr5oNkvM810IKc/Q02zGnJPj88Tc1yUSrde/W0gQiJPmUM3SHJHq5Z2rP7CM1Ha444Rj1Dw52m6T7sLvFw4/0v0V9gEDQEFmiX9Lx4osuc4AY+lUg22eUOclhH5PtPQ9Qc3JaY7sPtWhe0WTfFNVfnHnbTpiOG4gDsb4xxPduu+dY5qIFR5JuKvpn6KmiGRyyWtuj3xdAL78QumpQH0kzseotN3UsqYgH4UDMd2RXCXEm7PR6jSppX7P45hlgjJaVkkBFVJukEzzjUOJAn189bZXTXJlTE5Upq8Re1CMBGcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBtiOjydrxlCpwS20vAXrOwF9W1KM9q/P7BvHS2ut/c=;
 b=swdYKXlg07hcrj9APmO98SULG0uUtqaagUOWRqpY4St3osQHAon4kXpGA5tqjuHRpDPXrjLBRK8sbhBA3xB4zQL7sK/JZXjw9MEUZzjat5sGNLteoruI8Dt32nXIDHEdhVwoXHbyAIMDGjV9tNBrzGF89G+4vpSwVtKm7+bSFoLuXnL/XvdpyEILQub7z+ohglgwjIuFGHkSxM80GSlVODXv7duM+dE+ZhElsx6FAi5je2VHeGBfem/Fjjs4g/Erg1UqGvjdfkRh6Bh+XQ0qmE5k7YxlMWxsiz69eUHZD3l0UOpdNYx53eUgApNnDUDzF5jKv+tnqXuoXAt5t9x8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBtiOjydrxlCpwS20vAXrOwF9W1KM9q/P7BvHS2ut/c=;
 b=aZyvDSA9oAKu0gJBliJPCqdfrwTVdFv5/lbs/AMHNvfUgfuCdYb2C0tU1WYz55y5O5nDGnoYLx0A1yoTh5XKsJBtXtQFCjeeudIhQ5OoXUCXZu/nEPqz/29LdQ+/9so9SqvPKg4isWqCSgrsonMuBPk8SUXFVpbb9BnK/tIoMHsyGt/YQLrpylLlIR6b9ictYLo2PvJXHW7spgSkS9QFDG56sbrNiYNvMDMWFYkVgVTnfLB2TRHxWg2mls4WKGGF9IM24xT4+jyrMljy9foGQzbEBC7szkVgfU/0srFRMCxBrFOVnkT+MpGka5H+f2tHYi0orqpbn++9RuDDploOLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 15:02:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:02:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Mar 2025 00:02:29 +0900
Message-Id: <D8F89QYB689L.UWU0WFGZ04XU@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH RFC] rust: add macros to define registers layout
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250313-registers-v1-1-8d498537e8b2@nvidia.com>
 <Z9Ly8R-kZaiamicV@Mac.home>
In-Reply-To: <Z9Ly8R-kZaiamicV@Mac.home>
X-ClientProxiedBy: TYCP301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4d2f4f-505b-44aa-2952-08dd624014ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3lOQjBDRGpacm9zWXBVdDFjM1BLbkdKcWw1am0xNW5iWUVuZ3hrVlNiRTB2?=
 =?utf-8?B?d210RmIwd01SV0c3NHNjRkRJQVpzeGwxRkd6alhUWWlJV0ZramFoNit1ZTcy?=
 =?utf-8?B?QUtzL2tuQ3ZHZkc3eDRaTk9taWhVUzVNQlJsdDZUOGl6cnlNYlZWOHhWY1pL?=
 =?utf-8?B?dFpteFdEWnB0Qmk4WmJoQUdmWHZBdjJJSEZKRHdad0hQWGk4ZUtNdDl3dmlz?=
 =?utf-8?B?M0NuR3cwci82UWxqRDA3SlZ0ZmlBQmhUWUhzRS9EOTBHRVJvODR2TUtFemtY?=
 =?utf-8?B?Y3A3ZUFnS0FPem1jNmxINDYrclMwQStpQ1Q5UjJDTzJiUWdQa25BdVQ3d2Jp?=
 =?utf-8?B?TVRsK0QvU3g4L3ZqYTduNEZ2Y21JakJmalhKcnEwS09hRVc0aGcwb1pyZ0li?=
 =?utf-8?B?SFc3MGI4TXZCeGRiU2g1c2JHM2M4ZCtXMGF6MWkwNE10L2xwbG9jaW1oazlq?=
 =?utf-8?B?ZHUxL3Q0MDRxZk1FeFFXejV1VExmdzBIRnhTalAvcSt0a2dwSkdaOVdCTmhV?=
 =?utf-8?B?TDlzcitYQlV0TG5hbHpsWit1dlBZTVlwL084ZlRwZWEzejVxdFF4YVY4QWxJ?=
 =?utf-8?B?RE0rZEdsaDk5a3ZBVGdFM0psV1had3hCRFFhVUprV0NEQ3NtL1NlSVl5RCto?=
 =?utf-8?B?Zzhxd3U4ZU1QMmEwanZvOHZabVdveVJGWlEvTDl1bHpNU04rdldKekxUc3gr?=
 =?utf-8?B?RHp2N1RJL3RTZnVQMUZSTTRSZFIrbko0VzlHR3ROYzFHclpmV0c4MXpmOHhm?=
 =?utf-8?B?WkVKQUVmbFgzd0p0aDlVMlJORkZjNkh3cFFVN1UzOEZ6dVpTaTFhMGZHV3cr?=
 =?utf-8?B?ZTFZdm5nQkV5RUYyNkQwK3VqL3AxSElmWGlXN2xjWXJCNlFYQ1lib1ZkcGd5?=
 =?utf-8?B?aTdSYytDbHFEcEZCL0wzUUNUcVI4Qm5tQzAxUE1XQjFCY3lYY091MXFvTUJa?=
 =?utf-8?B?RGlJNFlheHJoM2VRcXk0VHpxYTNaRHhKRWo3UjRtWjNiRTJLaXlzaUlyY2Nk?=
 =?utf-8?B?MURJYjFTZDhja0JoOVVzajlMNmxUYndWekFkYllsanoxUHRXUFNVRm9Nbzhz?=
 =?utf-8?B?dmo3N1B2Rys2SVEzRCtWMlRYdlIrKzQ0ZlZCOTFIbzZpcjJ1TkIzVHJCK3Ns?=
 =?utf-8?B?clVEVEpad00rdG1GblpMMVd4MjVUejVxZ2VLZ3ZSenN2MlRqS1NjZ3FldjE1?=
 =?utf-8?B?TjEra1JTK0ZzM3RMbDJSVGp4YmF4TnZ3U0piS2tpTW16a3Fkc1BPclNDaFRh?=
 =?utf-8?B?a0pReWpGVDVGTGovZ2NYYzJJSGo3K2hwcWdaU0NvaXlJbldJd0pwNXJDNDBy?=
 =?utf-8?B?ZTBrNFkvU21qaEpyWG9ZNzRjT0RYUlJrWkZpRmpkZnQwOW8weUY5YmtqWXJL?=
 =?utf-8?B?ZkVzbDRRSS9qdDhYTDZiSTNya1plT3hQK3U4YnpUY1dydDdjR1lZREdSWW9H?=
 =?utf-8?B?RmI4Y095aDhodkpYNDcrOXlCOXM4ci81YzhWK3VtMjBMYkJkSmNjdnQ1T0o5?=
 =?utf-8?B?U1dTUXFwa2h1bndUaDFDK2pwTUdLdlY3UDZ1UEtZMVRmeFovUDZmSjVydVpG?=
 =?utf-8?B?S2pjWHJjeU1BT1QvYXpLc0dSY1UwYWFxU0VyRDlrMy9rRWEzdjhDanpESnZH?=
 =?utf-8?B?dDk4c3JZRlRqS254OG1yWnZyRU1FUFU2RWF3Tm9IK1Y3Q2F0R1VybkkvSDYr?=
 =?utf-8?B?Q0d6a25kNmQ4RnYxVWh1Vm5DUXNPVERvMHFxZERIcFp3SFpzM3l0amhzb3Q3?=
 =?utf-8?B?UXd2bVZIYmZZZ2xPdEhmZVRodzNLeDVCUldraXBKRDN3cTNxMmM4Z1gwUVZz?=
 =?utf-8?B?R1IyazBDSExCVXkrZE1QUDdxUG5hMU1QRzFlQ1J0Y3AySEhoUXJWbkltb3lv?=
 =?utf-8?Q?63mLiwM2anr29?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sms5UVhKcTd6d2owanppY05aRllKUVZGNWN6bEgwajBaVy9TNUgwcHRqSFho?=
 =?utf-8?B?SXZKcXNudDd2OWZxZEdmQWJaczdkbmdkOVRHTXMyMG5ncU1zQ1hDREtCRCtU?=
 =?utf-8?B?QVdRR2ZiZXNLdVgvTWpjUjA5VHM5WGdrWCtHbmorWG5JY0k5K21aOEtpUXAv?=
 =?utf-8?B?K1g1UUNyUlhYUS9iYkN2RVhDTGdJMGxEZWdjbjZrMnF2eWJwY0QzMk13Z2pa?=
 =?utf-8?B?N0NZdzdSM2ZuQVcwRXJwRUgyRUFnTXB4RGhHN1ZEc1h1VmMvMmxIT09kbTJD?=
 =?utf-8?B?bjIxakVuSVZlL1FibVB0ekJRdzN1b3lGUWlSaEd0Yk9ra21iZThsTlFjdmhK?=
 =?utf-8?B?M2E1NEZVVmJlOE1ZdEZUajhCSktxcnlhc0FIc3FpeEhjaWl5Qm9Pd3hNd1la?=
 =?utf-8?B?cWxOeEZzWFdkR0lBTzlWUmV3QTArZVZzTkNoRGZydmIxQndDRkU5MlB2TmRt?=
 =?utf-8?B?c2I1ZFQrNUt1Q0ErSmV4N0xtR2lxTTdWRTVXTW5hUysrTWd5L1BESkJPQWNU?=
 =?utf-8?B?RHg1WXBtMWRMc2grUHVvR3RaSXUvVzlWNnBJOFl0ZDArY1h1aXUrbzZCVmxW?=
 =?utf-8?B?eCtHbE02QUJqSFB3SWk0RlQ5QXo3OFo1ZmlwbGtIN2lwTkdRVVMwSFNScWhX?=
 =?utf-8?B?eEZySGFnMjIvdlRrZ0t0VGd2YTV0QTJGZ1NsTHdLcVZLbjV6SE1rSTl1N0xE?=
 =?utf-8?B?K2FzMVdYNDBFWUl3QmpZam9iZm45cEZSNTdvcXArdk9ETmQwM0lKUTErL0ww?=
 =?utf-8?B?bDk0aHYvYkhZc3U4UW1sWlJSaWV2MVdnQXEvSGZRdDg0R3YxVDYrTFJBWFlY?=
 =?utf-8?B?bHFjZHJVMzNBVnVDYUM0QjhIWitJZ2ZKajE3MHJhNmlwc3lRR29QZ0JvOTJX?=
 =?utf-8?B?bFZKZE9lakJQd0VYVUk0azlFc2xyK0tsaTFlQnI3OFM4QVZ2VkRkbG1NUEVj?=
 =?utf-8?B?WS9ERk1NeXp6TTVpYzlXUzJtc3pUd1NlNTlOcXlqWktHTVNyUGlzM2QzT1p2?=
 =?utf-8?B?S3hZZTJrb2k1WXhLc1ZldDNjYTBFMDdZU3JEWDcyeDdLOHlVQ2ZtYmJKb1Vp?=
 =?utf-8?B?am5COTdVdmxMenJjcnZKeDVjaHlFMHdaakRnaEtqZUlNYXJESXA0TzFZNytS?=
 =?utf-8?B?bDVlRjhCbTlYciszSmI3TEdmdklRVzVmU0gwSjZ3YUZoQUNjVHZSRGdraytM?=
 =?utf-8?B?S1cydnVZdW1xdnMzZlozbmxRMmhCUGtEMTlhVlpidXFpM1NuWm9Bc2phTk8x?=
 =?utf-8?B?RSt5SXV1alVobWkrcDZWNnN0RVJEbFFzNUZjTkdCaUwvYzBMMVFoblk2VXhM?=
 =?utf-8?B?ZUxNRWh5eUQ3ODZqNE4xSlppZUcyZXpjb1dESkdZZU5KVjV3N0tsSW9zYmtI?=
 =?utf-8?B?azlORDI0c2VNc1FXMlJudzNWeTN3QU1xS1hrWnBYUGFEcEhEK251enlVVGhU?=
 =?utf-8?B?U0t5K3BYbFRDeitONW82UHA0RHlYZ045djZTTUxqditsYW9GRmdYRjJBVkdu?=
 =?utf-8?B?MzU1anBPeFdIRTBxZTNGSmFZVGFEY3UzeTByOHk4Q2pCUmxRSVRsRG41UlB6?=
 =?utf-8?B?Q1lBeUVIYmhXZnFrYmhYTUdnRExXc3N6R2RyRTgwKzhLaDVZUlJKdTV4ODZW?=
 =?utf-8?B?UVgrK0d2TmMxaU5Rb3oxalQzVWpjaFFGQURXWEhNS3JuSms2SVIvRzdXU0JI?=
 =?utf-8?B?Q0RuYWZsSVdHaWNvYzlTWXVxN0hvb2dRd1ZXeXdSYnowUTU4ZktDZ2l4SWN5?=
 =?utf-8?B?bnlzSkNXVmRCSXlwTWFEby9uUSs5aG9VbDlOUUI2bS90LytzSTB4a3V4am5J?=
 =?utf-8?B?dVlidldzRkh6UUsvNnUxM2hZajV6NXgzYXpqalZYM25rYjJDZjh5am15RUgv?=
 =?utf-8?B?LzNlQWs0cldReGdmTjFRRU1Kd3puKzI4NWlkbmhqaDVHUjhpN3ZvUmhFQlV1?=
 =?utf-8?B?R0llb011MlpFZWFmbEdXTVdjZEZiUEtQUE5jVGJPalo0eUVqbnROcEt5WEhV?=
 =?utf-8?B?UktzVVJsbVRQUjBYb1BSMEVhVjkzcGZpaWhyZlBaZ21JRzFLbkwxc3VhVEhO?=
 =?utf-8?B?bC85L05Id2gweVFCa003cGlUalVIMUxHVjBFb0h5ckRnNGo2b1pObVVxVkRQ?=
 =?utf-8?B?T1ZCSmpxd2piNHF2Q3Z0b1JobWdpSW0weUVRN2FaMVRSTXFlcFMvaUlscVpZ?=
 =?utf-8?Q?GXMtOWinXIsQC5NYLXCcYKpiGBqmkVGRIYAozGQyDMZH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4d2f4f-505b-44aa-2952-08dd624014ef
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:02:32.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTu/GmmVsdjiR8Uec+/ZYcISz7jiY980AMdBIX1Wkdug9jKSskiZ4I99WqQ/EbqegJksWBr+nxclQTDbI/4M1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316

On Fri Mar 14, 2025 at 12:00 AM JST, Boqun Feng wrote:
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
>>         3:0     minor_rev =3D> as u8, "minor revision of the chip";
>>         7:4     major_rev =3D> as u8, "major revision of the chip";
>>         28:20   chipset =3D> try_into Chipset, "chipset model"
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
>>=20
>> The documentation strings are optional. If present, they will be added
>> to the type or the field getter and setter methods they are attached to.
>>=20
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>> I have written these initially for the nova-core driver, then it has
>> been suggested that they might be useful outside of it as well, so here
>> goes.
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
>> - The syntax can certainly be improved. I've tried to some with
>>   something that makes the register layout obvious, while fitting within
>>   the expectations of the Rust macro parser, but my lack of experience
>>   certainly shows here.
>> - We probably need an option to make some fields or whole registers
>>   read-only.
>> - The I/O offset and read/write methods should be optional, so the
>>   layout part can be used for things that are not registers.
>> - The visibility of the helper macros is a bit of a headache - I haven't
>>   found a way to completely hide them to the outside, so I have prefixed
>>   them with `__` for now.
>> - Formatting - there are some pretty long lines, not sure how to break
>>   them in an idiomatic way.
>>=20
>> Sorry if this is still a bit rough around the edges, but hopefully the
>> potential benefit is properly conveyed.
>> ---
>>  rust/kernel/lib.rs |   1 +
>>  rust/kernel/reg.rs | 284 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 285 insertions(+)
>>=20
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 398242f92a961c3a445d681c65449047a847968a..d610199f6675d22fa01d4db5=
24d9989581f7b646 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -69,6 +69,7 @@
>>  pub mod prelude;
>>  pub mod print;
>>  pub mod rbtree;
>> +mod reg;
>
> This is for io registers? Could you please move it into kernel::io
> instead of defining it as a top level mod?

It is (although one could argue that the bitfield accessors can probably
be useful for non-register types as well), and agreed that this would
fit better in kernel::io. Thanks for the suggestion.

