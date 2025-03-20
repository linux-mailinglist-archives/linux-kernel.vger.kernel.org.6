Return-Path: <linux-kernel+bounces-569134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769C0A69EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883BA189474B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079691E98FB;
	Thu, 20 Mar 2025 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZaQ8pcG"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307AE38F80;
	Thu, 20 Mar 2025 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742444048; cv=fail; b=dS3T4z5S+zo3h0I5fuw64SN7nGuQ8nhBwpnH1qRyJ91XMDjZSLxRpVadDu89Y+Jtx6cScQ3FUqmfwD0ezBUSx0MzqnQYMHvxxDWlHa437spBA94p8plg1EypxgypEXRAqsulXxcbmSU9s2ygv0CAMOf5mLxeSeA54OkugzboQfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742444048; c=relaxed/simple;
	bh=gvXY4uaTDDEPbyN+YQnE897nAi7SIrsu9bi/Ni/zKpE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=qBGOXHPJr0V6tU/xYrcD4/8W1r5ZMwLu2aDvLe1gg5uf+uDtf3GWKE3VuIArztOk6lW5HbXTSlcTUaGBp/UE8jBeyy6Jg0YHkxrPDcHxSpg8BIaMwYLSzdGA9RNEEpsNGq3ifULsAZ/TFIAV4diXr5H0wYvIur1C0q1Jx0GhSIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jZaQ8pcG; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMrTEcRw7UecxG0zTEF3Nb3KhWsYFmHUQ0pfwI+yP3Rt3Gx/Mn+GgbjcqVl2ERP0F5gkaesW5Rl+fNQV5DW5yjJ2x754euvRn7c3S9H7ctrqi/yIU30r6LxpyJ5iRDPbIJYB6EGkFGgfsD73AUJ9aMLlph+mYWTCYGv7dLbr55TLgHc34M9Tzg62yYo1ZMTkxbDOZUBdmsBXN58fHOvdOcmf4AhCg0OP1u6FtmUL8ENYtGzkWT0UvzBLq5bmN7r7+4IZUwySFtRGz9cNLHF/KKY2xdFW/wLAI57IR1Z4H6r8XuYpcouYOLJ9yQIby+P8f6cZVctkTwKSiXPdRRs0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+AcrON0mSPv8VLhB9pYq5pNHFInu186AH7kwimPMGc=;
 b=vJomZz8GxmMgpqdNmdBD6BFX7679GpYwM37fL7/R73xGePtVTKqqfV7QxZdKCC5Mp2T/O811QuOgDWL0Yaq1AvQ3SZhTIbzjhkkDwneMAzS19yYr68MyHioBrAclWp90372wze1n79JkaRnaC/Xk7mU1CcAJC8mO+bs0Y/MGU4hufhenRmLxqgpspBGo5aDyO8hKeF2filS8SDn1HJubvjXHN7kk1UvhFukiLUF3DobHgDdhZRR5Vn7xn3+PdVns5s/JcqiTOBW485UpkaKKo0xbbVmBYJdnnk5oIB7gg0p6HTgd3Nm2VNuzEl+9bKKmDGHlGhDVBhbNJ2q6NK6ipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+AcrON0mSPv8VLhB9pYq5pNHFInu186AH7kwimPMGc=;
 b=jZaQ8pcGQFA8atNw31mFA29meDjjpTRMpc+wd41lzCorrJb2X++h+DtZpEUXNYP/XXoJ+pEAQP/A/YpZoVzhtpLcgF8tm/8xeffVl7oYuk+p5IcN6fpI2lLBuUb/h41n5EUbnGLivlkysh+k3nvUG38+wSnT0c4ksjazdbaSusv3zfa+iIWEI7ngZ9qHjXC5hWuh60MN4Cq4JPpNPbK1HR3AvFmH9ZTR/kR3tRQ7hDtRs0DsjJiu8kuOevBIficc+twkbkN+8jivG5U3ubNd/H/NH9G0Fs4PN+zm3AeI6Uyaz4gsgq1nMalSHUfYNmJc92dUO+i55KzH2FTxaYvsCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 20 Mar
 2025 04:14:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 04:14:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 13:13:57 +0900
Message-Id: <D8KSV0ADDYQW.30CIS1DFZOPN9@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Fiona
 Behrens" <me@kloenk.dev>
Subject: Re: [PATCH v4] rust: kernel: add support for bits/genmask macros
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250318-topic-panthor-rs-genmask-v4-1-35004fca6ac5@collabora.com> <D8KB8CPBOIY1.10ATK35TV2X79@nvidia.com>
In-Reply-To: <D8KB8CPBOIY1.10ATK35TV2X79@nvidia.com>
X-ClientProxiedBy: TY2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:404:a6::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb35674-b1d8-4d85-7c51-08dd6765a4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emhKei93b2ZRRjJtRWNPNjFIS0lvWjV3S0Y3R0F0QjlLWUFXSHIxTFgxMWVL?=
 =?utf-8?B?R0QwV3hQNFhaT3p6a3BCQWoxSjFFdnpKcE5ucDczZ0xDRHJDeG5mREx5OEpP?=
 =?utf-8?B?bDNhSUhocW9hMEtQS3BrZ2RMMHhCaVZmak9VSVpIYlFpREZqYVV5eGdjQXFB?=
 =?utf-8?B?ekdvR2x5dmV4Q1diT090V3JMa21UVFJUVUF4NkgzK2VISU1aTkxDNENjNGdU?=
 =?utf-8?B?emVWSTNRVWNPSW1ZcnRjcERYSm9SY3VxazFPQ05WNHlRclRWRzRYK2xNcXVp?=
 =?utf-8?B?OTlmbnBXQVp0Y1ErcXhpWnE5MTI5TFZiYmZGTWE5MmNDRTFjRkVPTGc0cXNB?=
 =?utf-8?B?clRNQ0pINHpueWVhbUx0WGIvMDNUWUFrempjZDZSTEt6MkRPRUdPUkRiNytI?=
 =?utf-8?B?ZXZ6SDJhNEdYbHE3WlhQeXV1cG1MMkhNdG56c3lRb2gvWlNja01nb1BCS1kr?=
 =?utf-8?B?ZWxUU0J4Y3BKcGVBdU4zdUN6bStTMVg5UERCSU0xWUlJZmVhRC9BUmYyQWJw?=
 =?utf-8?B?QUdrMVpxQ0x3ZlB4OFdJMUNiak5rWThYVVpoNGc3Nmh4RnNGN2h6M2tlbHQr?=
 =?utf-8?B?dzZFRDFXZnc1L1RkZTFwM2p5UHkvL3hCYmpDd2tlWDVvUmszbEhMQW5FT1Bo?=
 =?utf-8?B?Q3RPZHNzaGh0bEZGQmFLdmlzN1JMZmpYWDdBa2ppbVNnR0dYeXRBTjJ2TmNO?=
 =?utf-8?B?MUxzUUdHbmk5MVo1R2RKZmdjMnlwbzFZSVZJRXNBTGVBeSt2NzZqaVRMSWpm?=
 =?utf-8?B?NHFyaHNQQUtQRk9ucHcrZDdCQkhjNzl6aldWY0VxOHRZOTNWL2FjSGd3RW16?=
 =?utf-8?B?Rm9tSnVxbUtmNHlSbWxyR1FrdU40UmpKRW5Pajg1QUg5V2tZZDlJNWc3SFY0?=
 =?utf-8?B?V2YwZUZicDRMQkVtOXAwdlhadkVrMEZJVG54Rk9HVExXdzVGVjdpaUlCdUN0?=
 =?utf-8?B?R01pd3BrUnRMNnZYMzNERDRab0RMMWlmMy90TElWdHl3SmlCOFZBZjRHTERM?=
 =?utf-8?B?VHdQYlpzOU52THllRE1tNlRZYm1UeVJteFhJWU8rTTdEMnI5UVVHZkcwazJh?=
 =?utf-8?B?RUx0MmxGVk54K053TmFXVWFYYXVwdlpRcTVSZnRlL24ybjl6cVk2b2htM2JM?=
 =?utf-8?B?MTlYL2JXUFU3RXI2cG45bTRwUUpDaXhwUFUxcUZlTjlVcWtuODh4UVBOdGxD?=
 =?utf-8?B?dG9CeS9PRFVCTDR1d3daY1lVTkdsWEJwYllObDlPSzNvQXYrWjF1SjFYU0RT?=
 =?utf-8?B?UXY0c3FYeVJMZ3ltcDNjNkE4RVZmcERHTWFyRUN1c1ozc3plMEh3eWYxTmEx?=
 =?utf-8?B?MjBWY2ZxK296T3h4cEVCMy82RTN2eDd0WGJPK093bDdVdU1MVGhOZVhqTzZS?=
 =?utf-8?B?ZEhQQzlGU2FNSzNuSG1sYUdscjJMbDh5aDdCTzl5V0NiL08xYmp1VHd6Wi9s?=
 =?utf-8?B?aWNUdFBSaDFhbVA2WVdUeGtoNi9ac2xGbm9xb1hpZk5mTVFwWjV3S0dUbzJl?=
 =?utf-8?B?ZmhMTWhyK0FZZ3pHVlNmdG9vT052UmJHY0MvcWx4QzI5QjkrV0lhc0QyUVdI?=
 =?utf-8?B?aDNoUVRLdGNWTXFOaFMzVDdxcWFHUEtVRHBmL1lVVUdUL0Yxd2Vrc2I5T0o3?=
 =?utf-8?B?Q1FSSWZaeW1PUEd3Sm15RU1tdXMvUHFuNURaR2tFQnE4c3dXcUY1dkExZnl5?=
 =?utf-8?B?Qy9mMU5GRWEzUVdQQVZKOW5GdFNTa281eUlMZEw3WXVDeTQ2SkQ1UkMya0lE?=
 =?utf-8?B?WFNwNkpXd1hKYUkzN05UQ0JYOVE1aWtLell2eDdLMzRsRUQvYUh5Tm1jSGhK?=
 =?utf-8?B?azZuYVE1ajFOU2FnNTAwR2pqclJ0QURNSmRqQUQ1enU0ZnFGSmxuc1U2QlhM?=
 =?utf-8?B?OVZCbVVVL3A3Z3NNRjlsbyt0bmNuQmxLTnJmRHFBK2YrSkIyVjczQjBBQi9o?=
 =?utf-8?Q?N7Vd00E4SIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkJFWHlPeWU1ZjQ2NU9MaHFnUnlNRDYrYkJIM21EZWRuY3AvR2ljWSt4ejlV?=
 =?utf-8?B?UlJlam5FV21kOFhrNzdqRVJKZDZxZ3A5Y1dhRGhTMEZFbXBmOFRJd0krUG5W?=
 =?utf-8?B?RS9HWFBNdHNQN3k5L2UvTGhrZGNKQWQzWUthTDdFNHhVbGhDZm5OMDIvbGFm?=
 =?utf-8?B?bGhIT3BNUkVRMGY5NGFVTUtMMnBrVjhPMTVUTkFlUWFra3k2UDR1bWtwNW9S?=
 =?utf-8?B?TWhRYm9SbklHcUgrc1N2M1ZxR3pnZzFYdGxsWkxabDZwYkV0QUNDOXY4Ukla?=
 =?utf-8?B?SnFXUVB4K1dpM0JFbTZNWlFRdnBYRmwwRE1VcW5GMmNQMzdacHljSk0yRWUv?=
 =?utf-8?B?NjZzYkZtbUs2Sm8xV1Z2eVpmeCtNUDJvdmRmSWlIWTBOTnRHcmJwMHZlc0Ey?=
 =?utf-8?B?dmtWTUowaDg1QVJPOThxQXBuVWJjUGZWT3VFRkhmdlhVYk9sdjFTVnI0MThl?=
 =?utf-8?B?SUkyNTF2YzN6b2g5aGFBZFdkWTBMaDNTcXpQbW1oWWdxYTRlbHI1RGtMUHFL?=
 =?utf-8?B?VE1FNkNvOG94aDlVTVY4VHVCNFdmMU5Qai8wYVV6QlNUTFZPNW1GS1NtV2wv?=
 =?utf-8?B?dXI1TjhyZENCUkt3Z3lpZSt6SmRpL09vSVhkQ1VlMlBSOExpV0Y3eWpvTDZG?=
 =?utf-8?B?UUgwZlFhYTk5RDU2UWJ2UlBIY2VwRlZGbkZuYU43TTI0Y0dtdmVRRm9hR0RB?=
 =?utf-8?B?dE5MVlAzWjVRM1AzaEtxd0RYTHNiZDczTU40ai9BdmxGMjZHWjR2TkhZL0Ev?=
 =?utf-8?B?SnhVcW1lTDNVTzYwNXZ5ZFRFVjBRSUhqRlBvMmNvUmdVOGh6aWErUEFpVjZr?=
 =?utf-8?B?b1J3V2tkNnU0SU1xbk9aQWVpQjM1N2g1dVJFK0Q2Vng5TU0wZ0hMTXB5dlk3?=
 =?utf-8?B?eUNIUGxqQUdpZDNqZENmUzIwU0ZYU2tCVFJQb2JBSmMvOHdTYjRCcVYzWUhX?=
 =?utf-8?B?eUpsS1hHZm1vdDhOSnpqYTVFaTdoanNkbjBvQWdySjBhUFhOeloxUnhFdFhh?=
 =?utf-8?B?N3lkN0hMNWxmczhVTHREdm9nQ2FTMUlxbGUrb2NiNVZ6SXcyUlRnYjA3c1VI?=
 =?utf-8?B?VytKeXA1cVhMdXNKcUluQXBPUDFKdWJPS2ozSDZoZGJPcmI4MWZKb0FvRytD?=
 =?utf-8?B?SjB4bXJvZlFJeWpQTUVYbTZBaGYvSkVYL211azNXTkVNcVJYWFBhZjVKRWpt?=
 =?utf-8?B?ZjNFS1lQcDFXOEdBSTNPdUxJMEZpQlpNaVdlYVV1eXlkbDRRSWQraUQ1aTZj?=
 =?utf-8?B?Yk0zU1ArSXBnTFNRbjduVmt3bllpdDlOcHkranFoMzQra3E0UEhQbVBWendw?=
 =?utf-8?B?QjVuMUlQWUpKb2ZxTWM4d09QQzRvbnlZckwvUE1hL29JSmNrTEdmS2QzQVcw?=
 =?utf-8?B?VzVkM3c3SjVpSFhUSWhzcStoQzU5Y3FWd0x4aUdDdVJ2WUh6VG1ZNmtjOG1L?=
 =?utf-8?B?bkIySGRIb1VxNTN6V3BScWplWDZMcElvQTdhdjBiQjg5aVB5TlptOHkzNDcx?=
 =?utf-8?B?b0FobHRrY1RYU0NKdmc4ZE92OENWUGtPQlBOTElKVHVOWUZubk5BcnZoQUNY?=
 =?utf-8?B?c3BSRHh2MGtLcjZlVWRPTi9DUEVYTkF2bDZ2VkFRNll3cjlsaC94ci9OSW5w?=
 =?utf-8?B?RnFDYmFiYW5KL3QvcjR4TFoyejFVR1czQnBVU2hvY05hQXM3U0FjVGZqL0ls?=
 =?utf-8?B?ODIzYW4wTGJtMU80d3A4SlBleFBZbzdaOWxXY1cxaHk4WDdSaE9BUVJOK01o?=
 =?utf-8?B?bVh4YVpHZkNHUUNxMVZVdzVyQk5KTmZtaDJFMW1CM2JRVWVGVnJvV3VaYzFO?=
 =?utf-8?B?TjVPMkJzSTJUcUEvVm1VamUxd1ROUWo4YSs4QWZBV3FvZkdQVVhEMVlqSHRr?=
 =?utf-8?B?WlZ5WjNFKyt1ZWFxdGo4aUU3VVF3MVQ3VWVBUC8ySkQrTXUrWG1sZ2FLTERm?=
 =?utf-8?B?ZE9WVVN6T2x0Y00xdVJxdHlPY0ZaSlIvK0oxcGJ5RVkydFR6ZnZGZ05tRTlE?=
 =?utf-8?B?WmFQNnlIeFNwWFU0RG52Y2Z4UWNMSElLSWtJSWRjdklENGc5bkNBc1BiM3Ur?=
 =?utf-8?B?RTkrNXVpb1NlWHdQazF1R0MrR0pqL0ZpVDdNN3dDYmR1RXBZOFY0a3RUUTdz?=
 =?utf-8?B?MGk4WkU3TGllQVI0dUhSMHl6STJjckVGSkVCaEpEYzlEZE9aNlhSZ2UwcHNO?=
 =?utf-8?Q?AVfc3vl0TNYSc1hTJ9z2DOmr6siFHH0DlwdeWudLCunY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb35674-b1d8-4d85-7c51-08dd6765a4e6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 04:14:01.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93BSo2WzJA08/AGN4Ur+v6BgJrlii2JzbK050G9wX7IbjMs9DhPPBk3JyPIAWZ4cOGEMLmj/SUeyodWrORDHHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462

On Wed Mar 19, 2025 at 11:25 PM JST, Alexandre Courbot wrote:
> Hi Daniel,
>
> On Wed Mar 19, 2025 at 12:34 AM JST, Daniel Almeida wrote:
>> In light of bindgen being unable to generate bindings for macros,
>> manually define the bit and genmask C macros in Rust.
>>
>> Bit and genmask are frequently used in drivers, and are simple enough to
>> just be redefined. Their implementation is also unlikely to ever change.
>>
>> These macros are converted from their kernel equivalent. Since
>> genmask_u32 and genmask_u64 are thought to suffice, these two versions
>> are implemented as const fns instead of declarative macros.
>>
>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>
> Cool, I'll probably depend on this for the next version of my register
> layout patch [1].
>
> [1]
> https://lore.kernel.org/rust-for-linux/20250313-registers-v1-1-8d498537e8=
b2@nvidia.com/
>
>> ---
>> Changes in v4:
>> - Split bits into bits_u32 and bits_u64
>> - Added r-b's
>> - Rebased on top of rust-next
>> - Link to v3: https://lore.kernel.org/r/20250121-topic-panthor-rs-genmas=
k-v3-1-5c3bdf21ce05@collabora.com
>>
>> Changes in v3:
>> - Changed from declarative macro to const fn
>> - Added separate versions for u32 and u64
>> - Link to v2: https://lore.kernel.org/r/20241024-topic-panthor-rs-genmas=
k-v2-1-85237c1f0cea@collabora.com
>>
>> Changes in v2:
>>
>> - Added ticks around `BIT`, and `h >=3Dl` (Thanks, Benno).
>> - Decided to keep the arguments as `expr`, as I see no issues with that
>> - Added a proper example, with an assert_eq!() (Thanks, Benno)
>> - Fixed the condition h <=3D l, which should be h >=3D l.
>> - Checked that the assert for the condition above is described in the
>>   docs.
>> ---
>>  rust/kernel/bits.rs | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
>>  rust/kernel/lib.rs  |  1 +
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..ec13bb480082de9584b7d23c=
78df0e76d0fbf132
>> --- /dev/null
>> +++ b/rust/kernel/bits.rs
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Bit manipulation macros.
>> +//!
>> +//! C header: [`include/linux/bits.h`](srctree/include/linux/bits.h)
>> +
>> +/// Produces a literal where bit `n` is set.
>> +///
>> +/// Equivalent to the kernel's `BIT` macro.
>> +pub const fn bit_u32(n: u32) -> u32 {
>> +    1 << n
>> +}
>> +
>> +/// Produces a literal where bit `n` is set.
>> +///
>> +/// Equivalent to the kernel's `BIT` macro.
>> +pub const fn bit_u64(n: u32) -> u64 {
>> +    1u64 << n as u64
>> +}
>> +
>> +/// Create a contiguous bitmask starting at bit position `l` and ending=
 at
>> +/// position `h`, where `h >=3D l`.
>> +///
>> +/// # Examples
>> +/// ```
>> +///     use kernel::bits::genmask_u64;
>> +///     let mask =3D genmask_u64(39, 21);
>> +///     assert_eq!(mask, 0x000000ffffe00000);
>> +/// ```
>> +///
>> +pub const fn genmask_u64(h: u32, l: u32) -> u64 {
>> +    assert!(h >=3D l);
>> +    (!0u64 - (1u64 << l) + 1) & (!0u64 >> (64 - 1 - h))
>> +}
>> +
>> +/// Create a contiguous bitmask starting at bit position `l` and ending=
 at
>> +/// position `h`, where `h >=3D l`.
>> +///
>> +/// # Examples
>> +/// ```
>> +///     use kernel::bits::genmask_u32;
>> +///     let mask =3D genmask_u32(9, 0);
>> +///     assert_eq!(mask, 0x000003ff);
>> +/// ```
>> +///
>> +pub const fn genmask_u32(h: u32, l: u32) -> u32 {
>> +    assert!(h >=3D l);
>> +    (!0u32 - (1u32 << l) + 1) & (!0u32 >> (32 - 1 - h))
>> +}
>
> Would it make sense to also have u16 and u8 variants? I guess one can
> always use genmask_u32 and then cast to the desired type though.

Forgot to mention:

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Tested-by: Alexandre Courbot <acourbot@nvidia.com>

