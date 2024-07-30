Return-Path: <linux-kernel+bounces-267209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8B9940E68
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 842A7283795
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4155197A76;
	Tue, 30 Jul 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Taw5MXYX"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020118.outbound.protection.outlook.com [52.101.196.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E999191F91;
	Tue, 30 Jul 2024 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333413; cv=fail; b=UnRjjcytecv+L+5DlPU9/6fAtBAORlIkZWkg/l/DED/Isti0zH4OdEUkD+B6kRQ9aU0IdfU0yPFcVMQVCFWHhNIYnCbeB6q+md/CZSDacq8ddTks7vOz9U6odsAO9Xz6onKWxN381UIAJQXDCOnIX9LC7SKUj9Ix4vV+nEAiCIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333413; c=relaxed/simple;
	bh=7NvaNNzYZrsyKCfMspQ3ZfSxmh6ajpqE/yXByC46LiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MOEu2UATxlAikhddosrLo+T/4hegDBO6lPs/8WwJlmKdPmJlAjXyogOvioIoneH8r0tgCdwZB8o9lwt7JG3l9+e6T9cl0rR/XiAUhZghIWJeHRiFe104MUqDaCc7DscuuTWMCmQqZJigH5aWh8vLIPlPEcB0mQDbC4ttYGSnp3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Taw5MXYX; arc=fail smtp.client-ip=52.101.196.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaICdJkxIphcsYNYNNuWKL4R6OzrK0Yc2WlhnktBT6ZOf0rsOQ7x/Jx/UYt01CM+E3bfrRyKZ/ck6tU8NUAOBH9RULyCDK6oj4KsBJx1DKb16LUVosw7SxHG5g9jgiKGdtlA6MX9aWZWMKbvR3e46hR0UdXgrvuYO9FnC2P6aRafVpG+u9DuOEgexdFNTVxzIof7G3yfAIUJtJnFMwrDTtOzoG9r/3EiMyGQeHThWDyBWnCSEQ94erzFDezMUT7Rsu6jPD7ujrHRRf9WiSNv00oQI8bdzFQZjgt8cVBdUu6UHdUvM0Yj3bvqhLOJ/Khcz3b3oswkUNGnS4pVzx6ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX9iqQKJM2drDnBZUubQRzSldL+AlX860qybB7G2lEg=;
 b=Sf72axLeKsB8Tv+uenVfnejCo5gyv/6ZLALpSAfTDqvBfKuZZosemrQ3GVNynUZ0JzL3mrfoZoVhUV/Bp7f1GD+5fOBAgiCG8JFTTztZtu+l9XmmXxgpT/dK68EqIUar6PWMNQUL9FV6gMV9QOG9NLZD9n6fwQs3MKUvxVygEA3mFVSTbUsMnKH1KU9EOMAmgXQryzPk0O4Of7VMDoPSunjBuoPl6++YuHsKp7Qsk4+BRtlMzbR3fWhsxA325qkoN1E/J75IesyDdo9I7uHZe9s4pq/o7vd6uHZ4tJnCu0G8tYqFIp2igP/Hbxtfds1V36qDYiC50+yWpMZ2q6O3CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX9iqQKJM2drDnBZUubQRzSldL+AlX860qybB7G2lEg=;
 b=Taw5MXYXh3PR2uxYx56CffnZsex7kRsqEeqyV9e0/V3oqaD8+Dyl2g58Dy36koSkjJNu3iFxQ+Ef2l9sU4+4NHzUt64Pzg+YLgtzdInncesk9pTQ/rIP9vp2ElpgPwIh9zr1YT8PDujoryy9TyVF2hHwWjUQUleg1X6VyzCG7cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB3508.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:56:48 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:56:48 +0000
Date: Tue, 30 Jul 2024 10:56:46 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Matthew Maurer <mmaurer@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: support arrays in target JSON
Message-ID: <20240730105646.1aa7ac07@eugeo>
In-Reply-To: <20240730-target-json-arrays-v1-1-2b376fd0ecf4@google.com>
References: <20240730-target-json-arrays-v1-1-2b376fd0ecf4@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0470.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::26) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB3508:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a304a12-3ee5-4f82-69a4-08dcb07ded51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?im8c3lAKXkQLhLOoES1Ns83UtboVwh0nRFqJ4izyEvDvivjGkFM3PHY3LMeL?=
 =?us-ascii?Q?fG8KW0/xMCEnUj5P2nKQC1TDry93+aida/gG/zFDfyxzelF8NrgfqOH8xdMh?=
 =?us-ascii?Q?1Ao/jOajFHlkU6hQE+0AdTVT5Su4AnhcUVrSgvETSLOnY2e8Hkh/KqVNWMC9?=
 =?us-ascii?Q?4KA3Bj0FMuzufBWpby/LMb8S161LVLuF85KgRoSNFojkq4PuT9q13ZR+MKwo?=
 =?us-ascii?Q?QoxWJegIaiF1UA3gKfsQe8+JaMXQIMICDehVigyAJzf0dwLhI3Vv05Y2pc4f?=
 =?us-ascii?Q?VuHLcPRMjB3yrXiQ1GPdZ+W+c3MZ+R/6YRFq4iCQL92I8khcyjM+2WibT3n4?=
 =?us-ascii?Q?XoSlN3LKDBfpVUt2IkRVxa2Cw25fQh75GvnTV2Y/Qdk5HqVaLiVyD+LvQYj0?=
 =?us-ascii?Q?+1v0V+Z06gT8UxqfaZqfR5WlccR+d7tLGzM4YRjmZ1zvYGoFa/uxM7UdUVGl?=
 =?us-ascii?Q?Pb405IYIWfwAw49QW7kMFHWpfvuCcHj1XW+JfTrr4PSxgoTB8/BSgd/s6zPs?=
 =?us-ascii?Q?EDWjBXCkvQQYTPOeX9X6AhHpTERBVBKundTYAAXFF35MFHQmyo0NqfrEH6Dm?=
 =?us-ascii?Q?EC2pDLbs05fCbRlkRdGHm3aDAZ/nXX20m8smP1gqCz8f3gbxIIOTNr4V7wWo?=
 =?us-ascii?Q?CLAHOhbSlSOFHY4gfyf19eLlGROt3t2tKrAOm+Mss5UegjsjFJoSg+005dPs?=
 =?us-ascii?Q?mAcC4IObLPWLLZq7pavnTbXFqr8pdKotRp1vXLTImP8ZHEqfzQkAB7zsekSh?=
 =?us-ascii?Q?qIS7dzQ7cVDNW2cqvip6Er6UKdDASzexjWZevRpAYAFl+LE1ET0O+y+o/v55?=
 =?us-ascii?Q?e+DdfP8OP2tW0/mu5P1qMPpC4BxB1KcXEoZ0U6YxyNZksWNb6rpzmDHK759v?=
 =?us-ascii?Q?dkV5Be7opFK2lZj9hTY9e+aRa1mWs9S+zlOphf11FzD0p83G7QAzuHP3muLE?=
 =?us-ascii?Q?LLoBXntg9hFpDVj2+vZZNF/zYhkXPTUQFv5ASa4PTG8MFWBD8l47uZ5xECYw?=
 =?us-ascii?Q?l0iLRuuFzpE9Bfq5pAYHRem412wtDWySl9L+21am/g9d3wyaivAGVxZg94yz?=
 =?us-ascii?Q?IGl3+EfvURTgl8KeS/NCOXsI/7n7m1zHhh+7tjWmS9MC7F9HbshcZ/oMFG/A?=
 =?us-ascii?Q?lldjQOTRWX2NDVDR3z+4Q9w4msULQpUGtPzNhu5OmB1RoILrJRH9KedLRVEe?=
 =?us-ascii?Q?xu6C4i4a09Td1GhmBgt//CGplg3NPsZCq2S9BtpvOCL9dM7LZs55m8XGeR9D?=
 =?us-ascii?Q?oDUOS7fMZvlzAfZaIPHnmUmaqzHb/Du4L/nWIQC+ImqvViWtiJ7nr+vppw/A?=
 =?us-ascii?Q?jh9G+jDOq2cByBYB9bBrji6z8SjD0DWrbmcsXA7LC/rqhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lKPbHOtTt1WlUMGmkKKrYnHl4zQvihxP3idseEnfROpZ3TBmTvfSd5FVmRyC?=
 =?us-ascii?Q?VOuGIKNy1bJbl7vASUaStebBOixFI/npOCAybI42b+eKpJrS0vF62vSA/1Np?=
 =?us-ascii?Q?aflXVYIxePXCGaREGH6FClkWT8fwF7YArTWEkooeicApc71mhiAzVJkRCeW5?=
 =?us-ascii?Q?QXkvSNh1bCi4sPp0IuPCwMbamgdHvS+LdBfDzHEboMpeUUWkYrWk65mOkrR9?=
 =?us-ascii?Q?UYovx69ktUGh1v5GByNwxSVFCIQhGTLcKbFPZoZvqqHrXEKpo0N0cwk8Q22+?=
 =?us-ascii?Q?oFBVPUyi2haE5iTQzjtpVbR5xxngUdC4So9UFsr36yvgJdbkXNfxhlkJiSCj?=
 =?us-ascii?Q?Kuug9n7G/SNdpB8QjztURDHkGlm43ftz62ote5D143IIiQCWVBLApH7kOiq+?=
 =?us-ascii?Q?85GRqws9250JY3UCEiiuLg/o/rbM3scz8IjATRIxYVkk7fBHQFuIrfLwaIKB?=
 =?us-ascii?Q?LWAn4UWJ/MWddPQKQuVuq8+dDdfSzRQVOEnMdSJD0ts4UJLiJK0/ikyYtcTA?=
 =?us-ascii?Q?qaIqdjPLQt2QoRFkMVBpJGt6QlxF+X3M5zVR4r8g2ZURVrpBdKuAJoHkVHJm?=
 =?us-ascii?Q?fECxl1BEkIC/3ClwlBOgJWwrrBKF0JMF4GPG6d2tNpIOUbV55cPaNuDZZ32R?=
 =?us-ascii?Q?vgATJXJLhaLec15jsuf5lNqdfnor948MgJqhbcPkjlik2umhnAFRtwXoeNeu?=
 =?us-ascii?Q?OsXG6EdEs54NCNSxYRlkG9iyeSxcxqQqiyOQVb4cBGwVS5BPSmuNMKwjPUeK?=
 =?us-ascii?Q?xV2b50eBYCDNFb203AiR0cphXh1Kk5mQ51ov1ggJ82JF+6Xd7Hl1+fZPD/U9?=
 =?us-ascii?Q?D8r2VyUkSy3F5wk7m3l8vLZaDDJPCq6fbW20dCDcktH3tD9UjjMJa03nR4Nh?=
 =?us-ascii?Q?Q00snJqzkU4IHc2t3N2PTZlAiYt5v8opoXGJJSvme3Bogh3H5i1D9OBcVPxE?=
 =?us-ascii?Q?3dFiFSoom8Suwz1wGcWOo4N1YTx6F2oPKsh6j6b9WlIAVVSTCR84jSSIxTH0?=
 =?us-ascii?Q?J7vRQg+GRu0QYoIqxKg9NtJlAxGwY0ylCemsHdLL4Z0I3v3JYZKOeiTztaP3?=
 =?us-ascii?Q?EWNBHOuBvSusC6XVLb8OWdh80z7KJbMbSQtggz1a39mPuN06erJ9n4iS/6bF?=
 =?us-ascii?Q?NkuhuiDbr92zPcI70VQ9Jw9Ad1FgIYlMu1a3o90vKSrpzAnIPqsVgZqZEl/e?=
 =?us-ascii?Q?VPyMTf1mhVpX0nYQ5zCyKeT2tjLTJoKfEzGG53vuEBdajsfgS+8xfIvdoS3T?=
 =?us-ascii?Q?AQGaPeNSmL/3E0gmmoGsPG1W5fdhqDJrwEWsJ0gijTWTgfmledREDYZDMfhX?=
 =?us-ascii?Q?W/KLHuPZ7aVgTIVyJIR6ZNy1KEx66c8K1QoQ3qMyGGRhtMNncUFz5oBZWLYd?=
 =?us-ascii?Q?9C6LYbPqgH/BlwtSoqOc734o174crV+JfTFtmuigu9zbrNedc7m6Of6I0DFe?=
 =?us-ascii?Q?PWLY6yD7wW9kxVDRIKRhPvM7WuEzlxeDCv0qgsbh5M73RVaWK3rCIUxORxDZ?=
 =?us-ascii?Q?9Mn+pZDSHuxEMkQUBjXgRcW8qeCHvbb0Ak+fMHOKeNYABOHjvcEob+6u3NEB?=
 =?us-ascii?Q?AtZLAYHdHqVhPppf8f+no2wJEbOjCDA0kU5obfsd?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a304a12-3ee5-4f82-69a4-08dcb07ded51
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:56:48.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tz+pCFZ/IuJZIlhd+RV2//Rs4hDxE6ICAmadchZfU52k3NMcXV5Gz4y3zXVFdPFDUzPcXwbT/1NmHcojlIGklA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3508

On Tue, 30 Jul 2024 09:26:24 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> From: Matthew Maurer <mmaurer@google.com>
> 
> Some configuration options such as the supported sanitizer list are
> arrays. To support using Rust with sanitizers on x86, we must update the
> target.json generator to support this case.
> 
> The Push trait is removed in favor of the From trait because the Push
> trait doesn't work well in the nested case where you are not really
> pushing values to a TargetSpec.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  scripts/generate_rust_target.rs | 82 +++++++++++++++++++++------------
>  1 file changed, 53 insertions(+), 29 deletions(-)

