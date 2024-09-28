Return-Path: <linux-kernel+bounces-342644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB0989124
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C7E284E2B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF0155392;
	Sat, 28 Sep 2024 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="RhHkWE5Q"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020102.outbound.protection.outlook.com [52.101.196.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF7F17736;
	Sat, 28 Sep 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727552159; cv=fail; b=iyXEz2ab6hfieL7e8g4JM+OtZH9KpqnKGPwchfuvLC6UI6ZEpn/5z001T3yF5bXJPQVKmaxs685b2E58wWLWXI9pYfHfAEjJbny8y7Np+4HeN5PbyoH0+n1GOZWKnVi/3vhV+xDi9jzumuLQLtMozam73swmEnlNsuYKyJstEXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727552159; c=relaxed/simple;
	bh=ajyDsL5a/0LWKUP/BASsCNyesOVS64Gs2yBHoszbpyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WnBySwcXVcDJ1wE0DwkR2d/AUGnHmY11lTHCqkyH1OZTVAKmHM4i3Y8VPK/ImUFwy6poSAfyKEVMqsgA1+2vCgGaGe9KxVPLyhicQY2wDrZ2r8gRK92X6bUCydO7NTPebdtUCMSFJY5Fw1eDdqPvqqpVANizSHfwyFdAh2AQD9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=RhHkWE5Q; arc=fail smtp.client-ip=52.101.196.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bevw6TTa/W0Cju62sXvTLy3K3pq6LkacUT6hQZyv2Ak7CSpLvpeYAr7a9T2/6DfMydB4ELLGdcs2UmDC8LK5vZaYUavumbb+RAU9dfCOAidWMjbOygtpCyGrTdnKy0bE75gwXxWBL+pKKq6rR/Jy6Veo2huh/Ym1M90WoP7CaOvTIsj5o9XDiUC4ZTt1OWZZpxMJn+mhuKo9412jnULD29gpS86a22KD9QB+EdbSgFE604+4G0S2S3CIvn6N6bw87cd2cCytgSgvYBF69VJJ47JBNiITnhKsZETckBNnQ//VExSoAbqSwiFhQB94kbeg7apkEQ0+NIx/QfnWHpWzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMWt6PVFgE2KwrC2EJtN45gDUY4v6UICWD2AzazFn4s=;
 b=qES1B6dPTU6dTtQTg2N+OJbq47X90/nXfcJbWEMRkEabTU4kXeaGo/D6g3DsgI4fMwICMcrhdiXbKNUjDHu8TZCz/mFgxbjhXFcIEgPxBFNP6W2uhwEnrvAywGs0JRwNOSf6HWPRUDrZIwzRSX8FW7w7YIym9Tj18c3x510InYDMmeAEJnqv3wrPEg5C36K1WfzWD4TEs86xuIJ8sCimqWoryej3TagFrq5i7e5XoUErjOyqrh0EsfbFIyuuYEIGUqeqS+HeNV1Qzb98AK5JJ7MlGXZ1dgHmDt3NKViVNu/0u07pXSGL73ZqPwdGC9DgpNl8SdYCqdU1+oH/R3K91g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMWt6PVFgE2KwrC2EJtN45gDUY4v6UICWD2AzazFn4s=;
 b=RhHkWE5Q+WgZpHk5a7CWEPUJZMpY/SMJraWocwT9SIajShSGi0GufKbufhjHF43HvYcFnUV+/yx3aC8kibNXIW03vWNaO7pIwxBhiE11/tal4BfNlS8kSMrYnckzfU9rcxI41yNQ3J4XzvF1wOBFgS3CxtbsSW+v7qoQ3C867pE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3240.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sat, 28 Sep
 2024 19:35:55 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.024; Sat, 28 Sep 2024
 19:35:54 +0000
Date: Sat, 28 Sep 2024 20:35:52 +0100
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 22/26] rust: alloc: implement `Cmalloc` in module
 allocator_test
Message-ID: <20240928203552.4d490ca0.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-23-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-23-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0484.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3240:EE_
X-MS-Office365-Filtering-Correlation-Id: 8844439d-c6de-4016-851e-08dcdff4c4cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RWD6esR/9vCzzwrrXha/bJzRH9A42n9K02hRSrTmmfA3Ob+DTLbiO8B4msFY?=
 =?us-ascii?Q?D+23oBbMH8LCObNeLxz7EqET44up0GH/Uxp6bmyIHEE6phIkcuIvWUNQpP56?=
 =?us-ascii?Q?/lQIJhYTSMBKjI2kaHMpjPRP6Ysu6Svf7IYX3jXpGfE/ZLV1kJPfLHmyun0O?=
 =?us-ascii?Q?e6N8zlg8f4jOpb/OAy0LHYJ89WZlTpcoGSsKjEKiY9BH4W9Jucr4N37GMtRP?=
 =?us-ascii?Q?aEWHfhjOGOkGSg6cD65ONqYRDzjrPmddBQjbKjXjh52J/B7bkPP4pBkfL2Pd?=
 =?us-ascii?Q?VIV7V16UCJKvSf2J0CNFUc+kuIbpv8P3yhwTxzS2P9qxuOWuFEm2Qqo5tCg+?=
 =?us-ascii?Q?hnXPdMDAIRQuQTnmSmYTL9EZR+ckIyF90/muHBL8oAd8vFWX7HwzDwYE7nO0?=
 =?us-ascii?Q?TccbqYu9vQB0uLkMYlSYxjLpOUuIPp1m/W0m45TL3IdpTVlf2qvbtdkr1+T0?=
 =?us-ascii?Q?WXEwYsKhv+JVPYsI/3i0zGNbNWqmr3UVbQVySakoFYFBZc8jtiVThHIMQm32?=
 =?us-ascii?Q?czZXyv0gsh/F80JLvOBekYNWYWeRSG8ueqGbvT8n2NnDQSCfhPVcwmEGfoXq?=
 =?us-ascii?Q?8QsUb5E5fOjK7gv8LZwjUPbh5dwP2YsNTjj/8BOkgVngj8iS+mmFMUAv5SDY?=
 =?us-ascii?Q?pimbIet/wk0h51nlvaN+uflKlsToMkehIn58LRLBhOZOo+8RRshhCJNpavIB?=
 =?us-ascii?Q?mjZvriizZPA5gVy2kzKpaIBVylBYBuLo6d7su6Eps2tszROnMYzspbsK3+y0?=
 =?us-ascii?Q?imet3AjrRPdkIZkWWM/o3DW/QVhrFdWk79rWIiWZ/VEp5JTIDy9paAOv1m2A?=
 =?us-ascii?Q?vCW1x2hMxFtJ98HXh3yRMTVmKnSw/KH+olH6A+AHysk9TquFMm0aJZkhmHEz?=
 =?us-ascii?Q?VDjlvFparshff2WADIxdn3/z35xx2QyVV1KGiKwgN/ciufTRh70lK9gIPtX7?=
 =?us-ascii?Q?3zoiImU2E/I4oTX/SSB+YzqKUTrHuVZISAzCVVGffQPckoyQBi+UsfKuB62V?=
 =?us-ascii?Q?uB82U3ATU3sUWND7+0DWyPZn31WqBvObseeLo+fRUfTJ0zZnMQNf7uYs20WQ?=
 =?us-ascii?Q?nDrC1PjQ4ceLuNQhEm0HXFixXG3z4KR/Ixuly3aWQC4IoAznC3d/6BacaIQt?=
 =?us-ascii?Q?NXCC9EJkF7xjRwTp1KwFk6rIBn7FvuE8ORZivjSWH40crKr7I9YTZCWsozIo?=
 =?us-ascii?Q?PlBQ5D77VcfwsMcy1CWsr/a1Q4BZdfmMA+vEWeAMIiZwVZjjNG53TC82wTOk?=
 =?us-ascii?Q?VSgSq6qaPZYpgmiUQryL8j6aEBSrZVa8YWbD3Np+zTx5yKALnjcHcInGvzKV?=
 =?us-ascii?Q?C/S4Qx3qqrOzFS9Plo02AvX3XgBkw0Z0Tp0//ZH5JEbhRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H5ve0QHz/81q5eZskLoHhUOGuc2Or0e9slnW83Lie++FyNZQ8NmUz0kx1ND2?=
 =?us-ascii?Q?nlQYMod3MKRtp/LKNV46nMJcaA8XmEttswgypDUqFRQh2r/BgNnPznxEPtPW?=
 =?us-ascii?Q?OD1fv2N+8aWF3DQDe4C39VT/uiZd9jM1/gZP/KrPOpAmepJIO/KI9qXz5gHd?=
 =?us-ascii?Q?ciGd1iDOC8rZzkBPOICIeQ3PLI/XKsQik7i5F6I6qr3XCooryrw9E7DZwUZW?=
 =?us-ascii?Q?lqCM3orLpbVCgzXrQ2ZTe4nL9ekKXC3KQL6dhmjnoaZqJoN/bThxJYLDGzSm?=
 =?us-ascii?Q?EEKgOmg7XlkveRFx6QyKMjBpiresUxaBajaBaiXKJbDIUYNVoJP5UQZfjhrI?=
 =?us-ascii?Q?oMFaKSX5bxvVEUlFfe8oiS+EDj/Ccl/otQc87dpzcnEhubPMc8IanLRBI6QN?=
 =?us-ascii?Q?J9AXVPWg1i8HJunWxeZg7Tzk733xs8M1aJdn0UpS/cGZuvv9P83znPi2DhfW?=
 =?us-ascii?Q?2W+wcr5JiE/dsUxx8Z9ILa7rrXjvrlOyVy73Zn+kM27qJLaKf+OSEFwVQmHF?=
 =?us-ascii?Q?uniCkHjhR7BadJPRBMCOOkZKKKiudQ+bJTw6s9/YSbUfdp0sPXp8cD6QKSeE?=
 =?us-ascii?Q?mpQW+5ojeI9FgZo/JYUjCJFeiNAU61EiFQRiTkOfXeuhLVm0BjB91nrg9xoi?=
 =?us-ascii?Q?BXvzhp894DXf5pB4ogrK16VGSf39yR2z4tp/EzfC2mLyrKjAbNYfhS/VlubT?=
 =?us-ascii?Q?jCNlnobfRDm30E+KbMQQ2uF/Bs6bUgc4BohoODl2tegIdfagoEd7B++/nRB8?=
 =?us-ascii?Q?xNcjEF3um6oLUBt1JVHXFvQEP+BJNHGhP6eI13TJoWC+S7AWMvsmtWvrLf3J?=
 =?us-ascii?Q?tY3C2yX2BPR0Xa6Zzqv53sf/H1TqgZufZ4+PHeiEg7eZ8/zfa83JxcGNoiIN?=
 =?us-ascii?Q?j5gBdOhAMV8xoFiwL2GAyIOfKNxyY1lCiu3AxsUYFf6SSJB3ueC2s9bS9LpD?=
 =?us-ascii?Q?4OmGHQW+k0tvaiRiWZ/os8GAPcoNF2DMbRFq4iYVX/Z7w0hVkXxzAQBqMG5c?=
 =?us-ascii?Q?FDEIrfb36NaqDKa74efNs60ormn34lEf+6mhvV7IfzSYjFpImR9Jcy68Av6I?=
 =?us-ascii?Q?Cbf/AKMo+HEyLoetEzeKccPwUygBOh9XyoKw1uUiiP2kOb86m4YhPg/SPUFD?=
 =?us-ascii?Q?cuiUExnC2kZkk0LRoVc8ImZuRTmUBLYtLDh956p5vat6CYW60rNLgJCcERdy?=
 =?us-ascii?Q?jsTjc0YW2FJkd7V3qjM7OP9+vTb03Rc/mDAglvcEK3DJHVvEhvL1QmHzTcPl?=
 =?us-ascii?Q?rdfQcomfc1i5VWPLFRx5KUOux0DqtYlEK5iYUQuIesdZt6EHWSZu+RQ/QUqw?=
 =?us-ascii?Q?YZc8h2+vZYetGggS+Zd3hv88oETfqjWwssvLR+I7BeBoy0g6danuipJo6EuD?=
 =?us-ascii?Q?9DSnh3+od+HaTclv9REA/7CSQFQ+LLQiNJWEWL2dslwLYlMe7Fu/VuPsRbzS?=
 =?us-ascii?Q?M35RBQB61HtFi6S4UD2qycLbLSpzgqQ5AGVqaTxdt2AQ9Wfy5lDWRZds3Fkm?=
 =?us-ascii?Q?ZjTEA2h9GVYzIZ5B+3ZNFsng4zXHdcPEK3jokJWRDBcpOgip+y6rSd/vIS22?=
 =?us-ascii?Q?Opr1J1Gh4S8KvBm7v+GdpTU1HqL/SjPWWPDyQF2i?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8844439d-c6de-4016-851e-08dcdff4c4cf
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 19:35:54.7982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scEZs/bPp9agaG3eOp4BP9Hms89ry+ftv7baF7GGv09I2UToGCfRZglQwXgV8/8RH+etka9Nn/Djv+uwEdB21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3240

On Thu, 12 Sep 2024 00:52:58 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> So far the kernel's `Box` and `Vec` types can't be used by userspace
> test cases, since all users of those types (e.g. `CString`) use kernel
> allocators for instantiation.
> 
> In order to allow userspace test cases to make use of such types as
> well, implement the `Cmalloc` allocator within the allocator_test module
> and type alias all kernel allocators to `Cmalloc`. The `Cmalloc`
> allocator uses libc's realloc() function as allocator backend.

I think this needs an explaination of why it needs a complex
implementation instead of just using aligned_alloc and free.

> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/allocator_test.rs | 193 +++++++++++++++++++++++++++-
>  1 file changed, 186 insertions(+), 7 deletions(-)

