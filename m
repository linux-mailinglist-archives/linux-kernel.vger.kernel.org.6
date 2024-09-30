Return-Path: <linux-kernel+bounces-343331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6666C9899B7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152FD2829DD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161715589B;
	Mon, 30 Sep 2024 04:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="XvOajfvF"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE93209;
	Mon, 30 Sep 2024 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727669752; cv=fail; b=UJCeMYiJ4nNJSuis44xrSi74nKtAImOPFUh+FqgDuMawFkT7Gx8OMNWezcNgURxpVBxOUfu4BrSM0avPPRB2pdQFMjm9r9HoencpfWiawgF7u4H54z4KIQwExytb23u68XprvUCb4qsb0Y9QXEhBplFRjFmh/x85W1g6UrLF01I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727669752; c=relaxed/simple;
	bh=yCoDTUZK7qqvdwwzNJ4fqjhoktB3g9eSGM94PMBeXJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hJCwr39tEWuu9qbLMP6EYLdeH7Vk7MXdVFACfGJRcq5GByPMQaHcSMW8rWmFy5a99AYjfdHQTqLQkSHKOtGNB0wJhU0gxYVB2qm87+GO9YYBwYAogHEIcznSenEeGipQP23NoLu2A1XivFLgk9zoIScAARR2QoidFkUc2s0vBho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=XvOajfvF; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTr/BLXcJS3T388J6CPOopeKdkbt1qqPplYZdazp0bqf0WAdRbWwDXKGi3pVv/PT1nRTvwdRJ9LkHegpwdQ179JMbSfQUXjq8jZ/RopfB1yD16mGieOfKX5OpAgJg6/UOVP8wzrLsZtBx8MWFVDScxyVhiY2BnFWZbYQHFJDv/zlH+feQyFaNGAJ4QBC4UNtZ8KHpf2MMKIVUURe7otSv7ZBINmaSzvtq/93rwyltWPumv0HrYNg+pcM7pe9QtMNbPQ/n3nTYAscA3BDLCqiW+t4Z2Ydc2Vsgt9QM/1W8/4FvwCpK3J4ew6FeIavu4dKgabr04Qw5+kzire5mBmoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsXvMZEWVGsnZLLLT8iN4CIFmX6U5G8dD0i+BBVmuFk=;
 b=ELubRfc0VjtchQWHTXNwVAKTlzzSORNgHNWQDvPEfuBqgQu/s05MAkOqCQ9iKDjFQop36d6M2bnMcKk9xgrxKh3SXT5wpTZSBxjtvyxIep1NLURJ3jKx7wcnM+/Lud+eBcLLqQ/g+SHy+94mIRbSv0X4g74YkFf0mfHPHhCTSrPv/I9OD3JMhDbaCduzgiJsY+NMsVSIlKYaTSw7OudJeHKjO+UDGXrMAD5qLX99P8lJJ/1kulesIwIq3T1LNC6s3rQ/kQZNCEFCA3PwR3BcScZx0z2JGFF22/J4NhCIXJwXq5tLRH96RIrgAwLnIN8odxEB/n2bFUr8AkzKPImfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=gmail.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsXvMZEWVGsnZLLLT8iN4CIFmX6U5G8dD0i+BBVmuFk=;
 b=XvOajfvFjdkjYKhzSZa5L5H4/LoG4e1bEsZKVKwTt0SMAynn9GWqMV9XVPvakav5mBdpg1P6oho7P+IjAg5f9w+NNrhPqx/m+QtbzR4Xjq5fUuSpZydmbRetnXKehUU0rtWG3NNE8A3U7wZO4RxJTWNqW0ObR4T/fkZ7jM5/XvEpJR8m0Ef2ukbX1fXwLCDt4fV8xI4hDMh2daa3UbsFXp5Q3NMVe23fHfPQKBFCIT2zpyO3yOipCX1BDKYl3eWk/8ZLAiTbiY7nRzJNldxa0iKDB6WGuqoPdS/E9mbZfBhgf915xH2HrOh+ANhD7PKyIldDe1qEo+g10WDCLrqHWA==
Received: from AM5PR0101CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::36) by DB9PR10MB6004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:39f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 04:15:44 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:206:16:cafe::c8) by AM5PR0101CA0023.outlook.office365.com
 (2603:10a6:206:16::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26 via Frontend
 Transport; Mon, 30 Sep 2024 04:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 04:15:44 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Sep
 2024 06:15:44 +0200
Received: from [10.34.219.93] (10.139.217.196) by SI-EXCAS2000.de.bosch.com
 (10.139.217.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Sep
 2024 06:15:43 +0200
Message-ID: <6d08a751-fbeb-4dd2-af78-32ae89704208@de.bosch.com>
Date: Mon, 30 Sep 2024 06:15:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: re-order exports to fix rustfmt
To: Tudor Gheorghiu <tudor.reda@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>
CC: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240930010931.64080-2-tudor.reda@gmail.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240930010931.64080-2-tudor.reda@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A798:EE_|DB9PR10MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 256f3b3d-7070-45d7-dc0e-08dce1068db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R05zTWhZK29QdkRVSDQxZ3lvVnJ6UlZxeDhsSDhKNTRFUjEwWmVib2xEbjF4?=
 =?utf-8?B?UDN3Y0xpRWZ2aFdvVjJzSWF0b1k3dHQrWGFNLzZ5ZnZtWTQ4bXNZOUh5Y243?=
 =?utf-8?B?Q0RDNFQrd0t2dVUxaE9JNXdkTlpqS05KT0NvaEl5d093RzBSTWJmN29yRUNM?=
 =?utf-8?B?SzdNTmdJclhEQm9weE01MmV2Mm83SWdTWThuK3Z3ZXoyUHp5WFVSdHduS2pG?=
 =?utf-8?B?MmQyYkJJRG4xbG52VGNwZmJMckpxbEhMVjB5M3RTS1BxV0tYcFprdEtpWktJ?=
 =?utf-8?B?SkpmS1NsU2VhZTMrNENHbEFsTEd0Ums2bDVjZ010SUNIaXhFM2EzSk10bnUx?=
 =?utf-8?B?ZlpKY0x1VlFLd1NxR0FEMjJSZ1hEZ0JtbFc0QzF2Q1pkSVdremRjb0RzcHdV?=
 =?utf-8?B?WmlZZU0xYTB1d1czRVhuY2lzN1dqZTQ1NW9MN2I4TWNTaTlXVVFYcG9uRGxv?=
 =?utf-8?B?d2hOZjY5bFlzVDhITFRtdytwbE1tRDBLQVJKci9DY3ExMWlSSlBXM21jcE5N?=
 =?utf-8?B?dWFuK1IvZzF1UVJXNitHV3JBdy9PdjhMUUNXRExadW9xam9oZjhjamFXSUMy?=
 =?utf-8?B?Z3dvUE9ZT1orQWhNZ1JCdlc3UE5LN1NabmhVdk1QdnY2U0YzMGI3c3JYdGwx?=
 =?utf-8?B?MS9BMXVraU1ZdFI1NFk2Skl1Y2FZY0VSSWlFUEQ2OUhnSk0wMXJPbGp0NHRq?=
 =?utf-8?B?U3hraWRieWtrVFF2bC83LzhtaUZnUVJ4ZFFLeS9oblBhSXhidVZNQ0p1bXVF?=
 =?utf-8?B?QnB4MDlpK0lzbWRXd0g4eDRxZUd4NHdoSzlWeGxoY0Jkd003cm1ZT1ZOYzRr?=
 =?utf-8?B?SFJHdThiSVNFUWRIMVk2cGNaTDVEdy9GakhnbmV3NzBtYW1KNkw3RDd5eElK?=
 =?utf-8?B?dXJqMURWdWRZbC9yOEVvZUIvQ3FqblFLWGdmTXU3QmI1cHZncXJhLyt6OGhq?=
 =?utf-8?B?d3YxMnF5VmkrWTd6NzJJYmJCRDQzc3VDdWVwNEJQOHpxaDNsK0xCclVYR0dP?=
 =?utf-8?B?YVZjMVZPQ1hUd0oxMWlsYlBqQmJpMXNpaC9pNEVsbXdKem9TYURYbkFGUHdt?=
 =?utf-8?B?d3krRzRvTGU2eGE2ZWxQMzkxWVJ5c3EvdU9YcGdjQXhUWE9uNXlHWFlldTNW?=
 =?utf-8?B?SlptK1JFZ2FVcEhrT2gvbmJtRUNYb29lY2ViNmd6eVRpTnRzTHR2ZFV1Mm9v?=
 =?utf-8?B?OEhZcExpb1B4NlNFSGFiby9QdGZXaWcyTzcrM3Z6MXA5RjN0ZmNDbHBOa2p4?=
 =?utf-8?B?V1drY0FKdTgzcFdjL2NxOXBLUVZlWSt0MzhEOVpLQmZ3azJRcHE0ZkFLTS9S?=
 =?utf-8?B?SGZ3dE5xMTd6VlQxSTNqT3hlQnNvWnorTENxMWVNMkxnanJlU1ZScmNhekhK?=
 =?utf-8?B?VElzVjRSQi9oZlFDME0zQ01lNU0vOVg4Yzdudm5mdEFVaEV2YVhqMitxakk3?=
 =?utf-8?B?ZFhVT3dHdEFOL1VsbVdHV3JQZkYySGdsRm5KL24yMURKMEdXcXNsaEhYdTlK?=
 =?utf-8?B?bWtLRE5COXFHOU55V1pVbDZJS20wek5TRGVkWjVCazY2akF6aTNaaGVLbEhB?=
 =?utf-8?B?ZFRldUlmeEJReVFGd3ZvWG5xUDczV2lMdmw3aDk0SFhkZzFQVlVMSnNhUFhq?=
 =?utf-8?B?bU4zODBPV3l3OWdqZjcvdm5tbmtQT0pCRTdKR2p0aUZhOWJ1SlFyOWlYZzdy?=
 =?utf-8?B?YVBIUk5YeU5wU3AzS3FJS2k3K3pjNVdIdnRaQzVoYzNSV1BMaUp6S2hpcTFJ?=
 =?utf-8?B?a25lZXFFUndhd2hkWEZGb0x0YTVMUytGU1p6UDE1d3FNb0dSZDRFT1V6Mm14?=
 =?utf-8?B?WlhDVGN1Qmx4eVJXSUR6aFlnTWdHUE4xTGVid0VTelJka0x0bSt4TXByNG5L?=
 =?utf-8?B?ZXdLRFhGczV6c2Z4ZFRQSE9oZzh4OEN2K3ZXbkl4ZWd1SGJHeW4rcWY2dGly?=
 =?utf-8?B?YkpvWG1OaXl3aitrY3J1SDJORGxKVEllRXAvSGxyODRmYi91K1lycjFUQXkv?=
 =?utf-8?B?QXMwOFo4VlJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 04:15:44.2833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 256f3b3d-7070-45d7-dc0e-08dce1068db7
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6004

On 30.09.2024 03:09, Tudor Gheorghiu wrote:
> In the recent rust-6.12 tag merge at 570172569238, the rbtree export was
> added after the sizes export, thus breaking rustfmt's alphabetical
> export ordering rules.
> 
> Signed-off-by: Tudor Gheorghiu <tudor.reda@gmail.com>
> ---
>   rust/kernel/lib.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 22a3bfa5a9e9..b5f4b3ce6b48 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -44,8 +44,8 @@
>   pub mod page;
>   pub mod prelude;
>   pub mod print;
> -pub mod sizes;
>   pub mod rbtree;
> +pub mod sizes;
>   mod static_assert;
>   #[doc(hidden)]

I think we have that in rust-fixes already:

https://github.com/Rust-for-Linux/linux/commit/ece207a83e464af710d641f29e32b7a144c48e79

Dirk


