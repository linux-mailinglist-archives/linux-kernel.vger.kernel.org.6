Return-Path: <linux-kernel+bounces-562601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0BFA62DE4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A64189DBC7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC2A201260;
	Sat, 15 Mar 2025 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jdDyP0hH"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B6C8E0;
	Sat, 15 Mar 2025 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047673; cv=fail; b=Js4UaJw5JwDSjNZs+WRMrviR4zGsC7ILvvzhmMx9n76KVY8il4VRFukjGlNlPUaKOM5o+kV1TOBm6ap7MaD+yRNLadQa1DS8iM9L0J/K0oqRZD/5FKL8KcZsn7T0Hq5I3S+/8W2cHUlay0J2DJskl4gahGMJbBDLWhIRVol29UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047673; c=relaxed/simple;
	bh=1kxMS4JU+8SiSQZzBwPbkGY1Vbv6IHd9zoJAmQHfsB8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IXJfpsrQQ3cAkR68KAQyD4xuBhDw2V40xXSY4lZdwi1GKjFX6DXI3+K36Gd0Th9Y2MQOzlUzJG5S5/BOKpuU10Ye6pPRpD+VN3hJmuN/OXCKjtbai3ymm1dJWPSwt7hZpdDV0QvtwDlr6Qk/IpmDDZRk1/Jwej4HF3yTyXziu/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jdDyP0hH; arc=fail smtp.client-ip=40.107.100.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6vSxbvEhSnq4Nw+cVHfV+1sQOrykgnefdzGX+lArIk5sEJD/TU49ODODJXaBCqm6d4fYeoI7SV8ygUeaBLzd/ITLcJS1WqaOtb/c+LJIwSTwCWm4DgUgEARB8oxcLiLLfs5nrwNGrBqCjYGeGqqjyjCT3xpaGCQCxYHISSDBDfDJkMucsWQV8wjJlelZ3n8UKQ3IHhHK3nfQ8xh6VWXCx6bZd40z3gbTs3fx/Up04okC44qFbOJVPdG/YcrzUV/P+TWaN8rDLWyaa95DtLTX1F/lyIAE/aDaTYjCJpsnKLOl1vK1TkT77gxO4InhHUwpsaIKqlBwQRRTAXVzcaqFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JkDf5oCaG8RyKfmTvRTEpZmKobOzG3G0ZtUrvJvBtM=;
 b=QIaZO/E5TdvAZpq8WEG0oJiqOGfJwpqwKZe2Vo2bMdObRl3v8/Cbg3i2XNZBPv3tcmV4lhzpV59N5tVKevX8oxJ/NptyXyjX3okkYkea4Xl47xYFjU1KJRUp+W2Fryo1jINek2Ti4swQ3CgkRKTRnEZSexU0UTXLrJvjtXG7FZb5DzpAuEUKGvSwuz9w9NuO/uS4Xnq7TSG8PtmO6h+i08UKkT1Eqp/JLHu5WlGzHYemi1q1WXTbLROQ8d4mQLjo19PSLM5BsI74wJpC5HJYf2lEgKJHnJLm+9pTAr3N2CC5YgrKrQQKOQeyHqW8ANbf+rBiNK5T/4hxsUgeRdVSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JkDf5oCaG8RyKfmTvRTEpZmKobOzG3G0ZtUrvJvBtM=;
 b=jdDyP0hHrJEnsqnuNGg5bPn+LyeEwTl70ikQepcBtik0bMO/41U60Lc2o+UDz4eYOGD8p4PmuzV55wvlt6L0qpsnkIwUdVU13Z5AeSytkMh0q8Z1LKA+KP/tP1Wa+WNripHfZchlzgzgnde3jmSJPkhvsFRYgmAlXDBRd3rDSFZSl+jeCE50gw+ald51EzcPo7iMSj5xEMy4v/84Unr/ei9MufdAmEn2pRvmAoTGLeivo5nsNkPClXegAohes/lL9fVFTDJrh8C4Pty0uhPqa+a9x7ZN8NKRFMWxYnPedRPEDqyvfXfpVXJ0UqXosFRc1fU6lEkiX5+gnARdeWeGmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Sat, 15 Mar
 2025 14:07:48 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8511.031; Sat, 15 Mar 2025
 14:07:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Mar 2025 23:07:44 +0900
Message-Id: <D8GWCWYM15WI.3II7R71LIAEI9@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Benno Lossin" <benno.lossin@proton.me>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
 <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me>
 <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com>
 <D8F91L51P2EA.2FBHGJYSV06HY@proton.me> <Z9L-Z4Aw64Hi5Lj8@pollux>
 <D8FBUHBNPIEL.5A8GOEMPJSEA@proton.me>
In-Reply-To: <D8FBUHBNPIEL.5A8GOEMPJSEA@proton.me>
X-ClientProxiedBy: TYCP286CA0343.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebb8198-4968-4339-411c-08dd63cac3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXBQbUh2YWJhMzRjdXQvbXpZMlhyVjVvTVF5VU1WMTEyVGVydTdLRmxtaEd4?=
 =?utf-8?B?bUV5NCtIM1dYc0o4Qzlia2E5WklubElRZmRDTlFTL1docnUwR2hSTUFKbHph?=
 =?utf-8?B?QkJ1eWsrSExzaFZWWk1ZT1ZHMW9odzg3OVF6cm1LQzJUcjE2VUxha0RrQlFh?=
 =?utf-8?B?TEVDK1pIaDJ6WlpNRUpldEdMdm85cDJzeER0Qlc5aTJaaDExRzkyVmpkMFor?=
 =?utf-8?B?NnZHTkloQm9CUmMrNmlrOTNadVh4T3B0citDQi9JNnd0Mkhic0NseDJvK0lh?=
 =?utf-8?B?VVExbzc3a0c2dW1rZ1c0TzgrOWVSRTZIdkpzRzA2K0NCdnpqMW14UFJLOFBR?=
 =?utf-8?B?cE1GRjJqU0QvMzdDNzdERmJRUEJTRm1wTk02QytUM0ViNDg0NVVCKzJTbHpI?=
 =?utf-8?B?TGYyVFJJa3h5QjBsbEhraEt6VjVmcEZ0Q25zam5wL3YyS0RCcUdRR3JiTDAw?=
 =?utf-8?B?Q2I1MlBrcThxNE9hRUFRNjcrTG45Qlg3UDVEK29Gak1lcWs1VW1DcDhvdmtu?=
 =?utf-8?B?ZTZnbFNoZWc1MGNlQ2t6a1lVWmlSMkhWdFdxOVpzck4yNXNRSEk0T2pwYWYw?=
 =?utf-8?B?NnJqQ3huOHRaTjdqNFA4YkxzemVhQmpzTGxGaWRFandDbEp4b2RBM1FuY0Za?=
 =?utf-8?B?dHN4SnZLUUhRYitkcHJCeGsrQWJ5UWo5eHlCOEJaZTg3QndCUUpza1IwK0cx?=
 =?utf-8?B?WnNwaWc4bEZYdTVBWFJWZjNpUWpTRFZ5dVZCVEJLOXBGTkVKTWtUTURxeTBR?=
 =?utf-8?B?TmoyYWNpemlKRkhwQ05GbzFyYmxsckhneHFBcVRFM1I4ejVicm1xSjdab0dX?=
 =?utf-8?B?cjlTanFURWdyOTMrSFdUeURwSm1ab1ZvUHNxMUhHRjN3Vyt0Vk9wNU5Nc2pj?=
 =?utf-8?B?QnNjODhwZVVIWU1rVjd0SFYydWhBUnk5M3ppRHl3UFYrcjJsMnYzU0pndWww?=
 =?utf-8?B?ZllTSUtvUmwrUGZYZ2ZuZEhkOSszUUY3SWM1SUdWTmZoUXIwRmR4LzNJQUtC?=
 =?utf-8?B?Y0UrREd2bHovOHIvRkhsRkozK0RMUFRMZU56bzFzdkc0bHBwdHNwMy95M1U1?=
 =?utf-8?B?ZlhUNzhvLytsekFIZXpaZ01QRWF2R1VJZE0vaEoxSlV3aStCZUEvYmx1Y2xi?=
 =?utf-8?B?SzY2dHZ3SDl2em5KNzNWWi84RGRtd2Z5WVdOdTB4dWxzMU5wQlFLdDFBQWU4?=
 =?utf-8?B?a2tNSUdwN1JrOUtQdGxhQXpNZEYvY0lIUjhMUkpXUTZHcHI0OWFSV1FnZThQ?=
 =?utf-8?B?UEhqSi90UHZwdFAvVWtYVzE1RnlVSkswZDF1TTcvS1JtaUxvVk5PMkk3VW9V?=
 =?utf-8?B?QXFNRjNBbEx5ZUJXRmIvcnlYK3p4aWx2RG1tNVVObjA0SEhOL0dOZmFvZXRE?=
 =?utf-8?B?YzJTN0VRKzFJODBGWlU1WHkwYXVhQWMyN1p4UGVuYXFqNDlPNE5wbUJsVFdW?=
 =?utf-8?B?MExZQ0FiWHpWMEc2SWxiSUJ0VFFMa0ZscUNaZHFnVnlaUy9FRytkV2xkdHpV?=
 =?utf-8?B?dEhWaFpDUEFUUGp1clNIZkdFbjV3YW9VcTdSRXZUZ0tnT3FYQ000VjVNYjBL?=
 =?utf-8?B?UGZxOHE1UzExVTk3MkFRd2hrVXQzZVF4YWhSMVJKWUg2T0FXRC9WcWhnemYx?=
 =?utf-8?B?Rmdqdm00eW9tWUVpbUE5RS9JTGg3N1NITkNiNnplTElNYlgrb3UybEVRaEhQ?=
 =?utf-8?B?dFhIaVNSUUFNb0FSMDlXQWRCRFRxR3BIMEk0S3lJOGlUOUIzemRLNjRzSzJW?=
 =?utf-8?B?dlVadWdsME00T1BWTTJvUEQrUzEyVkVlQWNmYU1WZ2VtNEpnWmVCbE9vMXNH?=
 =?utf-8?B?UnVZSzZESUFUNWlZa05iM0tBSGNmUWk0WUw3QUVGUG5TUzVSL0pSNjZoMFZk?=
 =?utf-8?Q?xrePEjjyxJbs4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blRJQWhER21qUXIwMEwvbDhaWXZNeEtzeVRBVDkzMUgzRGs5RUNKVndKYkxJ?=
 =?utf-8?B?VE93ZHdldmZnNnE3YWV0bHRlSVlES1BybHlCaGFwMXk3YnNFekY5WW1CQlJ4?=
 =?utf-8?B?NzBIZ3ZERzVsaDJqRU45d0dXditsZU9YakZ3UEJlR0IrY0l3SEJRVUZndWxI?=
 =?utf-8?B?aUNRL1RFMGllc3ZzdUpjSHVxN01PNzd5VE85QmJhS2VwQ2VYSk80bG9MTno2?=
 =?utf-8?B?SFE4akxYZTBxdnF5cHQrcVNaOWNnQjJVVmU1b2dNTXUyZXRXbG5Jam5IT2lY?=
 =?utf-8?B?aGphWlhlMDdVWFNkRGFhTEp1T29XS1dzQThqdG5VQnVsa3FWbmJDZ3JIKzVO?=
 =?utf-8?B?Tmhzc2JMbXVLSW5QN0psaU5jN015dGl3NmFuMWY5RzVwZVBIaU9hWVVmcm8r?=
 =?utf-8?B?RnMvK0M2ZjQrYmdQdWpxUHhuM3crRTVNaVZKa1FZclhERHJCV0crQU9XWmlj?=
 =?utf-8?B?a2NidTZJUTVaMmhZKzE1T1BYUTM4VFJlQ0Y2c253ZUNWR25ydit1NjhhbzFT?=
 =?utf-8?B?amZzV21SUGZWUno3VHVTbC93WW9ydk5IYmxTakFWYUFQUk9aejVxWnhwb1pV?=
 =?utf-8?B?TnlJRGxZNnMxTG1haThDa0JXZ2hlZlRiVDV6SE1MY1B0NlduYS9HcTVtMmJY?=
 =?utf-8?B?VDZNT1lvWGRVUVFMbFhpVi9WN0twUW5lZURMcTNSMU5aNTE0RHRvYW9JYXZZ?=
 =?utf-8?B?Yk9GVXZYQ1VHU01WR05zdGozVzd5VmR0Q1VPbjZpeGFBRWU1aHBSbmM1bGVX?=
 =?utf-8?B?U3loY05FWWJqM2t4eVBNbUdyT3NNREswL2JOdDFjbnNsYTgzdFRRc3BKc3Zp?=
 =?utf-8?B?a1JRdFdrbWNDVUVjaWlnUDc2dHRRVllTazFMT2p3VVpoZ3doY1k0TjJGeEdx?=
 =?utf-8?B?SmtXcHZheDd3cG5vUjV1cFRiMlNHMVUrK1dubW5xRmRjVmtxemhBakJzKzVC?=
 =?utf-8?B?MmZDaEo2VnBBNHhMSHVERHRYUE1vRkxoV240SU9nQXRnVzZqRzF5Y05hc25a?=
 =?utf-8?B?Zmp0QVZoQUdMeFhDc3E1UnMyYWlteVdUOUl2akRzOEVaNHk5WnVydjlNLzJq?=
 =?utf-8?B?bG5BR1kvQXpGUlpsYzFtY2JNQ0ZEWjJBVS9UZW9MdVBlYktoVkNHR2hPT3Jp?=
 =?utf-8?B?M2VqbGZUSWs4aXNtbDVMMklEdDY1dVQ2ZWtHa1kvSUQ0ZDlCSmw5REU2eHk1?=
 =?utf-8?B?cU55QzRrUVdSZ2dnNnJyUm1ESzNSVHpWbTB0aUlrTHgvNXBNWXRzRU8wRU9O?=
 =?utf-8?B?R1FiVkpxZW40TzJEUC8wL3VOL3BGU2NPc2NsV2JIakFpNm81N0dVNmNESVZl?=
 =?utf-8?B?QXp4eEVsK01PUlgwa0VZMW4zUS8ySnV5a2lMbE90aW5Cam84RG96bEJiRXcx?=
 =?utf-8?B?aWdwWHNuRFBJTWRveFB6UWRNUy9JdTcwOUZ0b01pejBmbGpZSFpsdzFqSmxJ?=
 =?utf-8?B?Rnc3YzlRdEF2aEhCVDVZUmUzRGFGM2swb3VVeFBIdnM1ZzF1MVB4cW1iNy8w?=
 =?utf-8?B?VnpIZ2JxS0dvbVFTUWFVS29rdDl2NzlMUXIxeHBuY0VMUnQycUJvTE9CaHVP?=
 =?utf-8?B?VGwxMjBzNEZlbEpPVnc2a0NtVmR3NVczN2FtYjRYTnc3TlVkQUZ5Y2NrT3dk?=
 =?utf-8?B?Q2JYOFJFUlJWZnRwanc3NVMzTkNPL0c4SHJhVkFscjBVVW4vZXhXeUNYR2Zz?=
 =?utf-8?B?d01Mei84UFZpdGlqNGh4RXVTbHFHYjJodk1aSlRzUFJjcXVqdVJsRFlWNmw2?=
 =?utf-8?B?dko1ZkZWQlM5WUNWVXl4bUNPMXJyaXRqalBNVTM2L0ZwNzIrU2JnNks1bEhL?=
 =?utf-8?B?VHFSSDlmYmFJaGp4TWdpUjJrVVVWU2tJcm5EOUIvdTdyRC9mYjd1Mm5VS25U?=
 =?utf-8?B?WnRmVnZiZ2kyOGl0eklqbjZhcDFZSVQvRVpvWEUxU3gzUER3NmtQWk13K1N5?=
 =?utf-8?B?U1RMM2Y0RkJ3eVp3UmpyR1Z5ZmFvTTVDUkh3RWowYi9yeFBkYmNWRDdYVUdO?=
 =?utf-8?B?c09ZN0FIdlpoRDZZT0orcmF5bkl5WHN3RnBiYjYrZjZlRXl1c1dJUS9qRWIw?=
 =?utf-8?B?Mmh5VnBuOHU2R1ZtaFBHcWx6Y1poSEEyeUtsRW9pS0VyTkVNSkdxM0lSTnFl?=
 =?utf-8?B?cWsxam5mamkvUjdwU2xNLzROb3NWcGNsOHBaTWhQL0FRcTlubTc5S0E2QjB0?=
 =?utf-8?Q?HBNUsj57KVLmHUqMTSb9Dn35APcl+lxMgVs90hWvnVQl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebb8198-4968-4339-411c-08dd63cac3d3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 14:07:47.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sMeStPFEtosvD7ztmBzU9ho9NEyaOQkHDVipfV+qKwGDaB2rECS6UBip0RfcYK5yq6AUyc+V8vBdIJOzGkgsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341

On Fri Mar 14, 2025 at 2:50 AM JST, Benno Lossin wrote:
> On Thu Mar 13, 2025 at 4:48 PM CET, Danilo Krummrich wrote:
>> On Thu, Mar 13, 2025 at 03:38:55PM +0000, Benno Lossin wrote:
>>> On Thu Mar 13, 2025 at 4:08 PM CET, Alexandre Courbot wrote:
>>> > On Thu Mar 13, 2025 at 11:19 PM JST, Benno Lossin wrote:
>>> >> Would it make sense to not use `Result` here and continue with `Opti=
on`?
>>> >
>>> > We would have to return an Option<Result<R>> in this case. The curren=
t
>>> > code folds the closure's Result into the one of the guard's acquisiti=
on
>>> > for convenience.
>>> >
>>> > Actually, I don't think I have ever used try_access() a single time
>>> > without converting its returned Option into a Result. Wouldn't it mak=
e
>>> > sense to do the opposite, i.e. make try_access() return Err(ENXIO) wh=
en
>>> > the guard cannot be acquired and document this behavior?
>>>=20
>>> Sure, if you're always doing
>>>=20
>>>     let guard =3D rev.try_access().ok_or(ENXIO)?;
>>>=20
>>> Then it makes sense from my view, maybe Danilo has some other argument
>>> for why `Option` is better.
>>
>> Most of the time I think we indeed want to derive an Err() if try_access=
()
>> fails, but not with a specific error code. The error code depends on the=
 context
>> of where the revocable is used (e.g. for I/O mappings), but it also depe=
nds on
>> the driver semantics.
>
> In that case a single function with this signature would make sense:
>
>     fn access_with<R>(&self, f: impl FnOnce(&T) -> R) -> Option<R>;
>
> If there are common usages that always return the same error code, then
> we could add them as functions with `Result`.

Yeah the more I think about it the more this seems to make sense,
from a strictly logical point of view.

Where I am still on the fence is that the goal is also to reduce the
friction introduced by the Revocable business, which a large driver
might need to interact with hundreds of times. If the user wants the
callback to return a Result, then this method will return an
Option<Result>. One would then need to ok_or the Option, then flatten
the two results, which is a bit verbose.

I suppose drivers could add their own macros to do that automatically
and reduce code verbosity, at the cost of less cohesion across drivers.
Guess I'll go with that if I cannot come with anything better.

