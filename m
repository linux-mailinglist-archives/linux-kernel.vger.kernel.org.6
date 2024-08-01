Return-Path: <linux-kernel+bounces-271236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70776944B65
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E991B25457
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355B01A01D5;
	Thu,  1 Aug 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JMXYWzQB"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2128.outbound.protection.outlook.com [40.107.122.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8D19FA96;
	Thu,  1 Aug 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515620; cv=fail; b=kqxpd7/Z6BcGdEw58soYwKFB68p85W1RRxZFWG6v5HhXJ+uo3vLAnqZuBoZ6bI9FbNoE/uK+r4prppLOTlEYggMVowZXbdtsgOVpffjJ7r/7SBGvVg70CFG8clxS7tgYetjpmRo+soa6VvwOXGxmhDyXw3a4Wzzq4AdNt5vgyCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515620; c=relaxed/simple;
	bh=RJMitLItY+2LDyIZOz8JJkQER0rGaFjFdBWMYv5XDEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HEdUJi3hRmXt60Cmxeie4vAjWque/sRUzrKEWVDJRnAuteEXh3Ie/BWEtYjyfgq16fi1/lqDXRfbFIZ6+cMYM+nSdAKDWRgcPD4g5iudKKLPRV5pk7V1hZ/jIe0f6WZa2LVdfOe0g2LyB8hOWzFPJwGLY0t0KyMJ+AzdnFSvGWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JMXYWzQB; arc=fail smtp.client-ip=40.107.122.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOsZZYl73C8zqRTzcVGQIymBkcZGl23LrZUSpnVscV4f3hW/BpbvCfwhcpPchLBbAcOzhtJNOn5qrfX6vuNTlExXnaUqiZJh5N1VWolyxR8nXJWdQ63FETnsIXU4D7a/GKjlXbXRr9QeUA9mVtY4wJe+Z5OkUIGGJ97HRA96a8bwu3ELPtui4nQ4gh/dAVxl9jHSAvJdRaMQJu4Z0X0GLlumC7u0JAfF1xSA8HoUSMdQZLU/o3UjaTYmTfHxEEfyP1axEzxr3T8TqsyZzuL1u3yCWRHvsC5szIsj6p8G+vIwFpMCf7fyA74cFnipbknf3CeRWZQ7XbDEND6QmB1lVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftM8nJljvilzAfS1v29/KfeIRjkG+YphvaZr1Yqn/o8=;
 b=HbwBArnimRSPk7G3s9JJ0NeSGEywQytNtqv0NIlHgKr5Ow/NiXilE8JTwa72D/hCmkA31dRJgXVyw21rkEU0bnoQH20Tcn/1uuf267u+emD19Dg1RQjh9A6ezscDXDihF0XPs0iEq5PTN/rZI3+CWxKotiTCBGAUx/LwR1Oul57xATmIfkrUR9On7lVHcnRLRzgN9nfxN3g59pIh6XOPqHd5jCdwSsIBooimPCPnkxnTCCtMypuN5zm2X+DQpJ3zUU29tYn78CAftVci3zukYLIHhn/sDDk+IBONnVebnEcpU20qn0Qy9R7YCe5VO6sc5mV5QffUqUXMdse/mcU+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftM8nJljvilzAfS1v29/KfeIRjkG+YphvaZr1Yqn/o8=;
 b=JMXYWzQBK7CPVEPqcR5rD1bvLb8AZtx4Ub3vvTLsv+lmXmfHzzTRXZUFPlOBZFY8qU/AuwGJIBl0+uU26BHkbV4eyjRfMdtQnFtgDR+mShbfjY91BQ1/UlChJuSIQ7WO1LBcU34N3BYkItTt1IzRG59UNpcK6IragzMgmLLcQtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5190.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:285::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 12:30:59 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 12:30:59 +0000
Date: Thu, 1 Aug 2024 13:30:55 +0100
From: Gary Guo <gary@garyguo.net>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: init: add `write_[pin_]init` functions
Message-ID: <20240801133055.6d127fd1@eugeo>
In-Reply-To: <20240708205325.1275473-2-benno.lossin@proton.me>
References: <20240708205325.1275473-1-benno.lossin@proton.me>
	<20240708205325.1275473-2-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0167.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::12) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: fd225dce-548d-4a92-c078-08dcb225cc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I3LW8C6bbqQDIXjxQ0HduNmUt0+T8CZHW7+1U7r3j1zDhUB4zGk0wlpyQNp4?=
 =?us-ascii?Q?8mN3l7zvFYTHim+eBKpIUVjxcgF4YIiXbQWq1HfwENfdihbq9DjClYmTt27E?=
 =?us-ascii?Q?WToc8wsDF8guq6jB6hVzPw0SZc0fep2V91CZjTm1TgLP5vZMcmEdVGtch4DR?=
 =?us-ascii?Q?dPb4QXF35JNFNknQXaCJoWHsXMgwYvmYAAmeSrRSwCMvojUryRiSWIcsDXki?=
 =?us-ascii?Q?9E3syxN2V+B+nNZJ4u3dTAhCxmH70MOFiSjOKQy3/ySs8cVzacQrNpREoHjL?=
 =?us-ascii?Q?EbyfiIri2m3z3FOwSdvtG08GPx3Kc1dS+ktBpU73kddLLLuFzU7ioZ4VO7nd?=
 =?us-ascii?Q?2F2oX+taDxs16bga3PY0Tm2SjhwQ4y9sjXtbuXrVf68peHOYAkqBca6qG9oZ?=
 =?us-ascii?Q?wcMgo8NSRBMs17Hv4iWJ8DgnKZ/6Fkwluio0X+PPS1lMSB0I/59y8amStlgx?=
 =?us-ascii?Q?veamSRe0V2U7URzb1SLraI5KR+HNylmDXePEwaVS3AsHrlIhst1fh5/I7EJN?=
 =?us-ascii?Q?Ij9b3SVeOvKODV5nyVIE5IivbZjx6KCmYQy1OeTcQmTgB7N2g8fVUFBoprlO?=
 =?us-ascii?Q?wHPpUmW0WF54eH4kHHWJ6EfuDrGSTRvd+mk3E19qh05ml5ov2efFy20T/d5r?=
 =?us-ascii?Q?fC0WFr37Z6xwimNfuDFbf3ZMH5gcAajXFsjG35DCUBPDN4zCogEDh4Onx0/b?=
 =?us-ascii?Q?RYR6+h559ylSW2miQxxKc6xbsRHQ6b5LwnuOhb8U0KtvcHn8Ir2jBMvy+jNA?=
 =?us-ascii?Q?St/EPMQdWut9tHzhr+wUPrdnnMGVgO3zhyrvZF74Cw/K9iJ5aO6UudAzAV9b?=
 =?us-ascii?Q?TJRRoE5D4GqQ9tm5h5cWu+lL3ykh52GxYjXbp6Xp2D3U7EXPMuLNLVpgNK9q?=
 =?us-ascii?Q?gsilKVh+xsB80dFdhpEncmx81SMiphhCA7nKNx2gZDzFcmXVxRM/JG0+KrT8?=
 =?us-ascii?Q?lIxXhzVx4/VkkgDFClmPJ89YOo0ob0z3EOusyMA7FIBD9AezXEjyCV/9LH+o?=
 =?us-ascii?Q?xWnb8D99tARa+oh8HXw4OLjd+vT+izt9spSO/iLEtHpTJabu8rZEpOUb7eV1?=
 =?us-ascii?Q?zpqpVJr9CgzoHQyEftvTkuy04C7v2fB6hYpLrQukiAQMc5QWHVgzSmYHfLU+?=
 =?us-ascii?Q?P+ATku4Eyx8p4DPtde2oOxyMJCOZ5t4kRm71Hh2IiewE0CcUiQGbJBFH2BtH?=
 =?us-ascii?Q?nhS+fkNuRCSVl3Hl/7fHHLDVcBADWc3052jROS9GQNe0xrbvv98z9W+bO03h?=
 =?us-ascii?Q?FYHbOq9a9vLfTMbT910UgTJfsuV6W+JvIJyr4W/dYeLPXLHzts5ZwSoWBctF?=
 =?us-ascii?Q?LJw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EgT65mjcAUuQTEfRjZqlX57s5PsbttHUaL6tjkioVvg7khFWE/q/fnLkTW6C?=
 =?us-ascii?Q?yF8lj3ikzsiBjKA2STrf0meEe+YnIUOhjv6RcKwXJxg1PFVr178+XjoI1/bk?=
 =?us-ascii?Q?HlHM5BOoQLIGk0+LFvWsEhrejdp92hqp4hv9dbalhgiMw3OwWPxCxtHC9qA2?=
 =?us-ascii?Q?9sTorrEGlg+gFZPvhTJX5ToLsY2azQokSKbIQjm4Y7dbCovE4hjCCjpsh2Jw?=
 =?us-ascii?Q?HjyQ8F5OgtIiyXvW7K0po1hddmpNlGvxDTp6tGNcfeGY51g2maPw7zPqCzLe?=
 =?us-ascii?Q?Pz6kb4rOj9DOnQYOr9vXnMlDrRNp1TyH90BYumgXqghM/kQrYAHK0ItyhaiW?=
 =?us-ascii?Q?J8TdmR6OXxR3ZDTb+PMYajSxbu/gzTF8kfUirH9ThaVnUt5wNfsugtJzHBUh?=
 =?us-ascii?Q?8KUT2LsPd++sc5QkyKLNdSxsmbQ5+031utouRX36SZaiPGwyl8YsGs7pp5yA?=
 =?us-ascii?Q?RTWYCOUQl1qr7LYYHRyuAzC05Z3A3mG1NbjZbkgjx1D4JQoHdgH9qSHHO0wh?=
 =?us-ascii?Q?QVUaqhfQQl6O0u/5YRUesOI0AxDRaostai848JscxP3iQKK/fx2wV/N022lz?=
 =?us-ascii?Q?DopGWbEJmWWsYxqZTx/eWdFGyb1d/I/JQlVJwxI3+RhuJ1yJQnWfB5pUwUuw?=
 =?us-ascii?Q?gErAUhnk7VTNMx8L3KqrNLst+ZvHjAlmt177bfOm2lPvJeg42krYZ9Vr3eB/?=
 =?us-ascii?Q?f+HfUs/MMI/FgQ3fljPD/3Ya2OptKEjmYkZfZY/AdzIMQGL8ZmDBFd6ODMWr?=
 =?us-ascii?Q?IEe6g5WgcAN5IlvADK42m6LMkGdkl8z0jaGkV8K4zgrbSwxD4P3C8yVdB9zi?=
 =?us-ascii?Q?Z4dcRnZodMx0Yu0oCDmjMpQ8wsJcanva/NkgbT8H9ffz1d0/bG/ugcmL0rkU?=
 =?us-ascii?Q?X1Bj5ulZ9x/CUcfmT4xViRZgK8pD0xfjmNLgprpNfI28EQ36aeVOJ3ATGKN9?=
 =?us-ascii?Q?opWjgrW7Ru//T76YLAMkL9r0hmT/5VyY+D/a18bnyT/ZBd5/QJbjLUT+cmJ7?=
 =?us-ascii?Q?puoVLd6zvhWr5koZppHU9sr3fXufbihvYBHsSnLUsbRWw/Ww08C1y5cpxPcj?=
 =?us-ascii?Q?aYSN5XjVnwcE90kz2eTvFS5tzUTn7lsfbo3K9edVSvGhq5RdPmCU8wuO8a3M?=
 =?us-ascii?Q?8gHUnNfiMnnuBwjXVQT6Zf0LBuFSlrdLpZp/UwlQxVo+yJmm5ClmhSf1J1qf?=
 =?us-ascii?Q?LE1aeQOhCiFoURD8Gx3HQUYrDNO20Hbv0i+xSFIa4kNkPvjSlYoo3qe/E9dR?=
 =?us-ascii?Q?3QBHRuPhCPM6GsyhL922BOVl/GGLYMdpVREq5194Y3P0/aLQVhb+UYqVz/Sp?=
 =?us-ascii?Q?uxtTgO9Hwe8JbpVEJXARcU6kARqShefXBiZ//vjvu+EoqIh2EUzf7RGjPyHQ?=
 =?us-ascii?Q?lPQj2WZQRcWmfyy/lMivKqrtKmDGW1AMEvagpTvclh1uwuumpCltj8uSHLqA?=
 =?us-ascii?Q?7Vz3lPqOCSbcv5j0Leof68Uy7ci+lC9RRrbSH41hOiLVZb1L76VxK4Wfqqjk?=
 =?us-ascii?Q?qgYeN2YH4z/6Z/cPlbQ3GJbcRWPGDfzQMcnzZNq86rO3r2w2RFirkw8jSZNE?=
 =?us-ascii?Q?wyF8tvlCgC2xDjk9uerEwCCawhpiEbJV5hQEaR80mJ1/VknbLaiKempaFo4o?=
 =?us-ascii?Q?SXpGGKhW9X6knATemwjm2kCjXBWqnEQ0PCf1O5Faalh9?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fd225dce-548d-4a92-c078-08dcb225cc2c
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 12:30:58.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oK1nMxXp6wBXlu0VrBPVDdxpfeXz1OzwzM7Htq1WJuxGKVEQpk7AU2A4Zu1THsG5ilNx+YCaum1Dpp28gKZ8Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5190

On Mon, 08 Jul 2024 20:53:46 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Sometimes it is necessary to split allocation and initialization into
> two steps. One such situation is when reusing existing allocations
> obtained via `Box::drop_contents`. See [1] for an example.
> In order to support this use case add `write_[pin_]init` functions to the
> pin-init API. These functions operate on already allocated smart
> pointers that wrap `MaybeUninit<T>`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57ad3f5bc592@proton.me/ [1]
> ---
>  rust/kernel/init.rs    | 84 ++++++++++++++++++++++++++++++------------
>  rust/kernel/prelude.rs |  2 +-
>  2 files changed, 61 insertions(+), 25 deletions(-)

