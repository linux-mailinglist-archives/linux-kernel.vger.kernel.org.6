Return-Path: <linux-kernel+bounces-526168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1942AA3FB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13C9705205
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1EE2153F4;
	Fri, 21 Feb 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BJKGiSO0"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020108.outbound.protection.outlook.com [52.101.195.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7488210F65;
	Fri, 21 Feb 2025 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154489; cv=fail; b=RMVxGuTQRAeWeIzjOqkpIWjI5QrsPVwOFdqtS8l3b076THS9+tnAZfFpS6vUu5Wo74PmuAATerB0fhtpi8vweiK/DaGs11nAnPa+l4NVhLgJ98R+2kGkcNSHrux6RB6t/bTm5ihL+TekJKLUaO5CYRtwB7XqUAeC1qaZ09+4wgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154489; c=relaxed/simple;
	bh=Qu05F259toLVHH8zwHZQy0LtDH46+MbcUq1TfFMPSxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hvCbBW98mbgCcR2+H5fNRje2c4S2YFpanEypvMEpAjujgWJgHIHdtLaYXaP45XxXK9tkGXYvM2i69MUbQDkocSO2a4yjfS8/yCIUu95ibW4qQiKezWYd9DoU7DeTOh6dhh3NlHgjrzK4fUk8tqFLIJUAeW/bkO6+fRGG5yEoM9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BJKGiSO0; arc=fail smtp.client-ip=52.101.195.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miOKbx5OIzg11ES/COvI0esV1paS4cBwCg/tDYb42s6DKtURpNxRAfIac4Bm1MBxf/V0OXXpg5jfMWJVbuyRkid6fsrsQJUYXIDBCupViTiaFh5MXra9YmZyIvIQ9S4Bi4QtQ82ZVHxVkP6drCU+EwUFwtwTSnTMkcScGEIPupJ0j5GG6lfg8djBMZLdQa+sC8qvsiKMm03aQ/+pWKEHoAWLDUWRohLjHOZbUyecQ5c0kO96VnX+AwtWPZDC5k1+bJo0Qp4SyfkBQdtNh6NupKCw+TgsiISoXMhhgjhu6phBKwBcA/d+1Xkmw7jy85qXN9is5DO8oWJW3/f5+oA2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kgo/pLCynhYIyReuIrVizfWHJZJB2I6sJv6VNZ9T4i8=;
 b=yoqenh46hrKzN30rru+0TfNsgp2mmZ0aAM5penEwR7niW+TVIxlSaKEAlI7StO8B4t7uZ509PXMwEl82s5HOAC8Fhar2FBxgbf6R8x1WpAFIhB15oYcsVcCZ9Mn5hTDYuDycXBuSkR6BOHqCihKtTQ8Sk2OgovQBCgMZHGPUra3FpufgzY/f9gD+QYqUb7rywwaJ/2Y0pss95vEMLjuIVowvg7l9XLSXlV4rxNHzS0ydSHLNgVB5GLJ3F8+pemkbW1ulZbe3lspfv+Tm6JE5xt7YaVJXNgRAf6H4UC0efcGLDWvyyap3Rz41AsHCKbmaNZ8kTM+oqt3RRBLGFkOlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgo/pLCynhYIyReuIrVizfWHJZJB2I6sJv6VNZ9T4i8=;
 b=BJKGiSO06VBi7lKQiIEXb5BoYWIMBEZ5ymiECiH2NwVRlDEl+uxSnmRZZA8qfKrYkJxZBGhJXHRfLcSOCueD8VigvwGLJVmhVxgyWasyBKNfz9TIVwFXhJ6IERJcEvw2AT9z6jo2g1ETBYUOTQnMFYjnGF8MX3St4V8XEu4/RSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CW1P265MB7745.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 16:14:41 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 16:14:41 +0000
Date: Fri, 21 Feb 2025 16:14:39 +0000
From: Gary Guo <gary@garyguo.net>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Wedson
 Almeida Filho <walmeida@microsoft.com>, Alex Mantel
 <alexmantel93@mailbox.org>, Will Deacon <will@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] rust: convert `Arc` to use `Refcount`
Message-ID: <20250221161439.0e34fba9@eugeo>
In-Reply-To: <CAJ-ks9npk8oSFHZHdViR1XhF+A8e2L+P0wCgmjE7mzAxS9WK1g@mail.gmail.com>
References: <20250219201602.1898383-1-gary@garyguo.net>
	<20250219201602.1898383-3-gary@garyguo.net>
	<CAJ-ks9npk8oSFHZHdViR1XhF+A8e2L+P0wCgmjE7mzAxS9WK1g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CW1P265MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ce654c-5bcb-4498-d568-08dd5292d8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTh2c1lOWnJWQUlhczJNeGRhL1ZnalliODhNMlJoTmliNlp1dENrTVB1With?=
 =?utf-8?B?anZRSVRzcEdzN1VlNFFaUGtDdzlOL2k1U1NnZW5MWE16K0Y3dWV1R3RiN2Ez?=
 =?utf-8?B?L0tySkFPQnNoT0pidFlMWktWT21yR3BVbEh3QngzazV5YnpVYSs1ZzU4RFZi?=
 =?utf-8?B?QXUvQkxNb0oyV0FydnkxWEhOcDVaNWxnMDBqeWhSYjVZK3hLMjVmV1hpcXhF?=
 =?utf-8?B?NEFqWTUvUSsvL1NUeUlkTWFZNm9QZ3hNcFZUU0dHRFB1Sm1mdTFMTFlNKzFt?=
 =?utf-8?B?WUlZYTBXTVFNSldIRCtRUmI0dGZvZUkvclpvMEp1bG9uSWtzTVVyKzdYbitN?=
 =?utf-8?B?ZjlhOE1DM3lFMzIzL1pHNmF3TnVzTDlKTS9Uay8vQmp2TytzZnVwWUdIZnZz?=
 =?utf-8?B?NENrVnAraVowNjE5dEZndUtCREtBTmdMc0xGWU9mU2t0MS9oQlBjMEZma0dQ?=
 =?utf-8?B?bG5Lei9LQXpLR0RrZGxvcy9Nd3g0V3JiTHR4N3FhMjMvaHo1THNjbndUVnJE?=
 =?utf-8?B?RHg4VEZUallSVEtUbDNvWkJjUEVCZC9KQ1Rua0pGTlhtSXMxTGpLbWk5Y2Ns?=
 =?utf-8?B?V2YyNmNNUjlyU1IzS3JxQ3ZUb0V6ZTZiWWtTY25zNXlkWUpFTUljUk5kWHNS?=
 =?utf-8?B?OVZ5ODdaTUwvZTY4Uzd5SkRIV3MxVUhYc0t2c0UwWXFFODgxS3dIT3p4dTY0?=
 =?utf-8?B?a3RWeUEzQ3crZ1ozMWtXTWxsYzhiMy93SlhtZHdMcjlrVDJSaTIyK0U2STlV?=
 =?utf-8?B?WUFFTXBla1dLOUJwUXVlSytIY01HeDVvbzZVa0V0eFVTdlVQV0V5VWxEV3dI?=
 =?utf-8?B?dXROeW5qUEZybE5iL3orOU5iMTQwdlN0UW5SUlR3WnlkK1NtZ1JaaUJ4OE1t?=
 =?utf-8?B?L2hwMmlESWdRWUEyb256bnNaMWtQU2NpblhoUDFob05yT2xyejhhb0pLTzVQ?=
 =?utf-8?B?ZFo1QmhpL2VOSVluYm8wMmpwMytqMG1lVWFzVXhjNmxUNUUzbXA2MkJaQkNx?=
 =?utf-8?B?V2RSWktpVHgwVjd2U2Z2KzN3L1pkRTIxeFp4WEJzWlN3SEZBdUpFQjBxbnNS?=
 =?utf-8?B?WHFTYjZCdkpFcEszb3RUVCtoZ01NVVllZXBEZys3VlV3L3ZxNlEyL0U3RGtk?=
 =?utf-8?B?NnhPa2MyZm5aYVdSS0tPMjFSSUxiNmMvTG5zSWZVT3lXRktTYW1MaHlyMnFu?=
 =?utf-8?B?RVRXOUZmVUtocmIyZXFRd3IyRnA5eTU5MmkyNGRHaUcxUWFROVp6YStsS045?=
 =?utf-8?B?TUUzVXpvWFRDTHptcGQ5TTFpSTZRYUp6SGpSSFgwTDBQLzVvZjc3eG5SYTJj?=
 =?utf-8?B?WFkvUnQ2L1FhMXlhM1BFZTUwQ1NiU1hGak5SS3lrc0c4ZVI5blRpZFpEakVU?=
 =?utf-8?B?RjZTbXBFZ2x2dEF5TWEvNlVRQWpzekY4V245dHNoM05OZzVIUjM0eUY3SDJQ?=
 =?utf-8?B?bG85b1dYeitYOTM1WUVVWnNhOTdydERWS2pjR1UrZ0VueUpKaVBHRG8wMjR5?=
 =?utf-8?B?SVdtcnRRLzRYOWZ4STZtd212a2Z2Uy9XOWhaeG1HYWlaMENLUm8zTkJQOTN5?=
 =?utf-8?B?Z3RyMHlaRW9mSkQwRWl6VHU0bnpsbmZBZGFubUxHZTg3WDJONWIrbHk3Q3c2?=
 =?utf-8?B?SVE1OUoycVRtbjgraWFtVTQ2bVFCakJDMzFqeklXdjNQOXArbzRRSUJrZ1Bs?=
 =?utf-8?B?S3BYUnhnWmF5RloxSVhDalN3dG9UWkR5ZlRLQ09HWUxoeVBGVVQzRmh1OGs0?=
 =?utf-8?B?aFNlRVc0Mnk4SXk0MS9JVUNHK3dwam1SSEV3UkttWnpaVEloY0VOMjc0dWdO?=
 =?utf-8?B?LzVvSXNpK1VCdmY4YXBKcUdPM29nNGNRMC9UU2NsM1NlenlVZklYbXF2Zmd2?=
 =?utf-8?Q?W7UESVEh7+9Lj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW5zaGVhcnFuVFhqSERqM3VPWUpxMTJpL0tXcGlkK2pIRGhsNTdTZDVrQzls?=
 =?utf-8?B?d3JXSytUNzZnVmtLVjUrY0VnaHhnc0lXMUpLN2tQR3R6Ym5qWlp2S3dJU3hC?=
 =?utf-8?B?ajhPd0ZlTW5tY0hzZlBYelRVTjlVRTJEczB1SUVVYkROMzREUzR3MzFkZlZa?=
 =?utf-8?B?THA0QkdYZExSQkt3RmlvTWI5SWt2MUQwTUFFaXBSd2RqNlNYVXU3S3FwUjJn?=
 =?utf-8?B?NkhPUFplbWdyNjhROHZha2MvRTMybWVySUszeTVOK21pQ0o1MElDTkIrbERG?=
 =?utf-8?B?SWVOVGNIQk5jMTRPL25yUXhOeEpFVlNwVjBhUjBrUlpaUUlQTUZ0RUE5S3pJ?=
 =?utf-8?B?SDRqVHJWOUFuUkgvTmU2QlZ1TVVFbW5ZU2xpdk9qd01NYVpGTGxqbDRMZDRR?=
 =?utf-8?B?bGNVVkw0OC8wUjlWYk1BTHphVjYrRGlHZjMxTkM4WEcxRWU5cjNIbHhZR0pY?=
 =?utf-8?B?b0JXUldieHlaL3QvZDg4NE0zc0NidlgyNWlWZTFnNmtSVDBGdGo0Z25Xa1ZZ?=
 =?utf-8?B?WG8zeXFsb3lpUUNsMUIrckVrNXJ6QWh5TCs1bFpCQ2hzUFNFamtEaFhBZFBE?=
 =?utf-8?B?emlSdjFzaFBkMU5wNXNudkQ0cGdpc0lBUmpucmF6UStnTHJ5NjNkdUptVWRI?=
 =?utf-8?B?bVVwdlpjaGhMbzVrbkpNRG1rS0lBMFA1b3VMQlUra1Z6eWZyeGtLZk5kSlB2?=
 =?utf-8?B?SU5uTkpPYjlud1pQTGxxU21vc0JlWVhDZnQvMzRaamkrUVpObExxZUlVU1dj?=
 =?utf-8?B?Q2tNTDJKcVJ4M2ppbUxHQzVnQU56VXhYWUVxTlp2OENoMVJBT0Qrd1d6eVNE?=
 =?utf-8?B?Tmk5amlEYW1LL2wrM3lMdkF2SFljMzd0T3d6ejNTU21uSzBlM2t0dW14YVNO?=
 =?utf-8?B?elFSRUNYY2hpcFVoUGpwcEV3Zkw0aFlCRVhIUmZCYUx1bTg4WDJOQkJReS9O?=
 =?utf-8?B?a3F6c1o4b0lVQ2szbXdtZWxkWmdMaFA4bUR1VEg1ZndTTWxRR01jYWkwQ2ht?=
 =?utf-8?B?WFoyYUU1ckxVQ1JXWElzSlRJR3h5clJHci9RajFLc3N4TURXcEh0TE5tUlZa?=
 =?utf-8?B?eU1rMXFFZnZZczBwSENycEtaUHFWZEdpbGltR0FTcDVJOXVzN2VUdDFlcUhP?=
 =?utf-8?B?aUxUR2JWaFlHQXcwTWtNK2lCem11bTlrVUpPekhJUUJpOE5xT0U0RFNiYUsz?=
 =?utf-8?B?U2NyUnd4NVFOa0NITXVoZlkwOWFFbXFoaHNNN21tVVVHWGtGMko0bkNCd3d4?=
 =?utf-8?B?VjlORmFiTWVLcXlFNTJ4RURCNnoyNk02UXJQYWh1Wkp0YmxDR2l0ZXZvQ1VW?=
 =?utf-8?B?dzgvOGVEc25COXJWTU1tamJGR0kwNGY4NUtHLzkwRU5mYTJhY2I4azN5U0Iz?=
 =?utf-8?B?anhuSzRhQVgwUGNjbWlVSGg1Y3RFdzFTbTQvSWM5TndSZ2V1L1ZuRXErdUw0?=
 =?utf-8?B?NTJ5ZVo3Sjh2ZUVLOHpRSmpKQ3ptME9jdmlDWkwrcjgrQ2pUSVJxVE43emNI?=
 =?utf-8?B?ek5qM2RsSTNuUnVJang1d2t3cmYwRHlGdG9WQUdwUjhKZ05MdndtUytsWXhz?=
 =?utf-8?B?bXBQdWNyMFk0aHljdE9pMVQxbkpRa0NiNS9ycWJmelF6U05DQnFNU3VWWkRQ?=
 =?utf-8?B?WElFbm45aXBnNnRPNUhURW02ZHpXcFlsSjFLdW5WYUFadmZpTHBkRDFFWnNP?=
 =?utf-8?B?WWN0MU9CUmVxZ2NSNzRQaUcwT1c4a3ZvZy9qcnJUSGoyVWpYU3hmMGpPNVpM?=
 =?utf-8?B?dnVwREs3UzV0cnRGMUFhem4ycncyczhReElsSTIrK2t3ZnRqa05FR3E3T1pN?=
 =?utf-8?B?TVdpYXorVTMrOUxTVjBIc2l6T0VHRjlIQTU0a0V3ZUdDMTF1Qm9iWktlcEYz?=
 =?utf-8?B?emNZU3ZwZlpaRWF0R05DRVZCd0RUelN5MFhRa0x1OHYvQktaRWVJMUFESUVD?=
 =?utf-8?B?bHBnT3RGUUJ0TDB6VmFSdmd6RVBDdW92YURqZE16UGE0cStXeGJEMklxNy9T?=
 =?utf-8?B?RFROT0hPT00yQlNyU3owckVSMm94bjY0VjlsTHZ6VWgrOXc5aE5vQXUvZzBV?=
 =?utf-8?B?dEpqVVRWc3hUcTVPaG9TZTRac3UxRWtkb1VITkF5aHEvdGpxYlQyUnZRY0g2?=
 =?utf-8?B?eTBROFBUSGZ4SFpQYjFMaUJSWVU0aTgreDhWeEpmR2lxTTJiaDFjY2E3RjdE?=
 =?utf-8?Q?scdH0Dh04BpNEvOhz9B+PRU=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ce654c-5bcb-4498-d568-08dd5292d8c3
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:14:41.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Dq2UKaHfd6VylAYc0fHCTu+nKROA1BKJhKthjQmErbWqiVHb13ViY/xCLzRj8/kee+WJqMZgK7b6jXIDRj9bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7745

On Wed, 19 Feb 2025 17:12:10 -0500
Tamir Duberstein <tamird@gmail.com> wrote:

> On Wed, Feb 19, 2025 at 3:17=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
> >
> > With `Refcount` type created, `Arc` can use `Refcount` instead of
> > calling into FFI directly.
> >
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > ---
> >  rust/kernel/sync/arc.rs | 65 +++++++++++++++++------------------------
> >  1 file changed, 26 insertions(+), 39 deletions(-)
> >
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index 3cefda7a4372..1f5fbc6b3742 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -8,7 +8,7 @@
> >  //! threads.
> >  //!
> >  //! It is different from the standard library's [`Arc`] in a few ways:
> > -//! 1. It is backed by the kernel's `refcount_t` type.
> > +//! 1. It is backed by the kernel's [`Refcount`] type.
> >  //! 2. It does not support weak references, which allows it to be half=
 the size.
> >  //! 3. It saturates the reference count instead of aborting when it go=
es over a threshold.
> >  //! 4. It does not provide a `get_mut` method, so the ref counted obje=
ct is pinned.
> > @@ -18,10 +18,10 @@
> >
> >  use crate::{
> >      alloc::{AllocError, Flags, KBox},
> > -    bindings,
> >      init::{self, InPlaceInit, Init, PinInit},
> > +    sync::Refcount,
> >      try_init,
> > -    types::{ForeignOwnable, Opaque},
> > +    types::ForeignOwnable,
> >  };
> >  use core::{
> >      alloc::Layout,
> > @@ -143,7 +143,7 @@ pub struct Arc<T: ?Sized> {
> >  #[pin_data]
> >  #[repr(C)]
> >  struct ArcInner<T: ?Sized> {
> > -    refcount: Opaque<bindings::refcount_t>,
> > +    refcount: Refcount,
> >      data: T,
> >  }
> >
> > @@ -155,7 +155,7 @@ impl<T: ?Sized> ArcInner<T> {
> >      /// `ptr` must have been returned by a previous call to [`Arc::int=
o_raw`], and the `Arc` must
> >      /// not yet have been destroyed.
> >      unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
> > -        let refcount_layout =3D Layout::new::<bindings::refcount_t>();
> > +        let refcount_layout =3D Layout::new::<Refcount>();
> >          // SAFETY: The caller guarantees that the pointer is valid.
> >          let val_layout =3D Layout::for_value(unsafe { &*ptr });
> >          // SAFETY: We're computing the layout of a real struct that ex=
isted when compiling this
> > @@ -207,8 +207,7 @@ impl<T> Arc<T> {
> >      pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> =
{
> >          // INVARIANT: The refcount is initialised to a non-zero value.
> >          let value =3D ArcInner {
> > -            // SAFETY: There are no safety requirements for this FFI c=
all.
> > -            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) =
}),
> > +            refcount: Refcount::new(1),
> >              data: contents,
> >          };
> >
> > @@ -290,7 +289,7 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
> >      /// use kernel::sync::{Arc, UniqueArc};
> >      ///
> >      /// let arc =3D Arc::new(42, GFP_KERNEL)?;
> > -    /// let unique_arc =3D arc.into_unique_or_drop();
> > +    /// let unique_arc =3D Arc::into_unique_or_drop(arc);
> >      ///
> >      /// // The above conversion should succeed since refcount of `arc`=
 is 1.
> >      /// assert!(unique_arc.is_some());
> > @@ -306,35 +305,30 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool =
{
> >      /// let arc =3D Arc::new(42, GFP_KERNEL)?;
> >      /// let another =3D arc.clone();
> >      ///
> > -    /// let unique_arc =3D arc.into_unique_or_drop();
> > +    /// let unique_arc =3D Arc::into_unique_or_drop(arc);
> >      ///
> >      /// // The above conversion should fail since refcount of `arc` is=
 >1.
> >      /// assert!(unique_arc.is_none());
> >      ///
> >      /// # Ok::<(), Error>(())
> >      /// ```
> > -    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
> > +    pub fn into_unique_or_drop(this: Self) -> Option<Pin<UniqueArc<T>>=
> { =20
>=20
> Why did this signature need to change?

I think I mentioned this in a earlier series. Smart pointers are not
supposed to have methods (i.e. with a self receiver) as it may shadow
deref'ed functions.

>=20
> >          // We will manually manage the refcount in this method, so we =
disable the destructor.
> > -        let me =3D ManuallyDrop::new(self);
> > +        let this =3D ManuallyDrop::new(this);
> >          // SAFETY: We own a refcount, so the pointer is still valid.
> > -        let refcount =3D unsafe { me.ptr.as_ref() }.refcount.get();
> > +        let refcount =3D unsafe { &this.ptr.as_ref().refcount };
> >
> >          // If the refcount reaches a non-zero value, then we have dest=
royed this `Arc` and will
> >          // return without further touching the `Arc`. If the refcount =
reaches zero, then there are
> >          // no other arcs, and we can create a `UniqueArc`.
> > -        //
> > -        // SAFETY: We own a refcount, so the pointer is not dangling.
> > -        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refco=
unt) };
> > -        if is_zero {
> > -            // SAFETY: We have exclusive access to the arc, so we can =
perform unsynchronized
> > -            // accesses to the refcount.
> > -            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INI=
T(1)) };
> > +        if refcount.dec_and_test() {
> > +            refcount.set(1); =20
>=20
> We could retain the unsynchronized operation here by taking a mutable
> reference above and writing through it. Right? Could we remove `set`
> from the abstraction in the previous patch?

This was suggested as well in a previous series but I don't think it's
a good idea. Creating a mutable reference and using unsynchronized
write requires `unsafe`. `set` doesn't.

Note that the `set` here is relaxed order. I doubt (if things are
inlined properly) there'll be any codegen difference with a completely
unsynchronized write.

Not having an additional unsafe is a good trade-off to me.

>=20
> >
> > -            // INVARIANT: We own the only refcount to this arc, so we =
may create a `UniqueArc`. We
> > -            // must pin the `UniqueArc` because the values was previou=
sly in an `Arc`, and they pin
> > -            // their values.
> > +            // INVARIANT: If the refcount failed to decrement because =
it is 1, then we have the
> > +            // exclusive ownership, so we may create a `UniqueArc`. We=
 must pin the `UniqueArc`
> > +            // because the values was previously in an `Arc`, and they=
 pin their values. =20
>=20
> Pre-existing typo you're taking ownership of: "the values" should be
> "the value". But why touch this comment at all?

I think this is a left-over that I forget to undo.

>=20
> >              Some(Pin::from(UniqueArc {
> > -                inner: ManuallyDrop::into_inner(me),
> > +                inner: ManuallyDrop::into_inner(this),
> >              }))
> >          } else {
> >              None
> > @@ -396,14 +390,10 @@ fn as_ref(&self) -> &T {
> >
> >  impl<T: ?Sized> Clone for Arc<T> {
> >      fn clone(&self) -> Self {
> > -        // SAFETY: By the type invariant, there is necessarily a refer=
ence to the object, so it is
> > -        // safe to dereference it.
> > -        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
> > -
> > -        // INVARIANT: C `refcount_inc` saturates the refcount, so it c=
annot overflow to zero.
> > +        // INVARIANT: `Refcount` saturates the refcount, so it cannot =
overflow to zero.
> >          // SAFETY: By the type invariant, there is necessarily a refer=
ence to the object, so it is
> >          // safe to increment the refcount.
> > -        unsafe { bindings::refcount_inc(refcount) };
> > +        unsafe { self.ptr.as_ref().refcount.inc() };
> >
> >          // SAFETY: We just incremented the refcount. This increment is=
 now owned by the new `Arc`.
> >          unsafe { Self::from_inner(self.ptr) }
> > @@ -412,16 +402,14 @@ fn clone(&self) -> Self {
> >
> >  impl<T: ?Sized> Drop for Arc<T> {
> >      fn drop(&mut self) {
> > -        // SAFETY: By the type invariant, there is necessarily a refer=
ence to the object. We cannot
> > -        // touch `refcount` after it's decremented to a non-zero value=
 because another thread/CPU
> > -        // may concurrently decrement it to zero and free it. It is ok=
 to have a raw pointer to
> > -        // freed/invalid memory as long as it is never dereferenced.
> > -        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
> > -
> >          // INVARIANT: If the refcount reaches zero, there are no other=
 instances of `Arc`, and
> >          // this instance is being dropped, so the broken invariant is =
not observable.
> > -        // SAFETY: Also by the type invariant, we are allowed to decre=
ment the refcount.
> > -        let is_zero =3D unsafe { bindings::refcount_dec_and_test(refco=
unt) };
> > +        // SAFETY: By the type invariant, there is necessarily a refer=
ence to the object.
> > +        // NOTE: we cannot touch `refcount` after it's decremented to =
a non-zero value because
> > +        // another thread/CPU may concurrently decrement it to zero an=
d free it. However it is okay
> > +        // to have a transient reference to decrement the refcount, se=
e
> > +        // https://github.com/rust-lang/rust/issues/55005.
> > +        let is_zero =3D unsafe { self.ptr.as_ref().refcount.dec_and_te=
st() }; =20
>=20
> How come this careful handling is not required in into_unique_or_drop?
> At least, the SAFETY comment there is much more mundane.

Because `into_unique_or_drop` doesn't actually remove the allocation
(it only decrements refcount for non-zero or turn it into `UniqueArc`).

>=20
> >          if is_zero {
> >              // The count reached zero, we must free the memory.
> >              //
> > @@ -673,8 +661,7 @@ pub fn new_uninit(flags: Flags) -> Result<UniqueArc=
<MaybeUninit<T>>, AllocError>
> >          // INVARIANT: The refcount is initialised to a non-zero value.
> >          let inner =3D KBox::try_init::<AllocError>(
> >              try_init!(ArcInner {
> > -                // SAFETY: There are no safety requirements for this F=
FI call.
> > -                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT=
(1) }),
> > +                refcount: Refcount::new(1),
> >                  data <- init::uninit::<T, AllocError>(),
> >              }? AllocError),
> >              flags,
> > --
> > 2.47.2
> > =20


