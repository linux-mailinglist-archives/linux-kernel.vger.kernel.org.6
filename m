Return-Path: <linux-kernel+bounces-222734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68A2910667
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCD21C20CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C331AF697;
	Thu, 20 Jun 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fZdKMmeV"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2097.outbound.protection.outlook.com [40.107.121.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC91AC434;
	Thu, 20 Jun 2024 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890667; cv=fail; b=kidyzoceejGG4V9Ir9O5E+3O9HClla9inGlQmo1u3wPHjCqbunSOtV3JfaB4M5sQLc5Aa1DMc2ITbKEUQkZVKJ9aFMpmZD9ZabSuTlIuwQOuTMOCxmDsUyuYKsMF9HTKI0/NOc2LLkqiuWiAq6yr/RuT2OjIdbikC1e8TlV0gYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890667; c=relaxed/simple;
	bh=cqbVZRrFUo5Arei4iiWHu4POiWYpusr3KievsOKOCD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5GKIkLxkNclK62R5hiLFeSrOlKb4/3Y/HofYOrZf7uXNUw04400BOsnih/1f7IEZ1+aGy02NzfW1EippBn+7+DLZkw8taLtmxiPSu+MA4xlxx91nW//06YcBY7PPhg3TSS9bbzvzC/x/4kAGPYD1Cni/FCR3B9Xz7DgUItev2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fZdKMmeV; arc=fail smtp.client-ip=40.107.121.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqhwRTpm3DspvzmircffJAuBtBatqBVOuZxcrDspEEeT55nvQh4+EXe3bp86jXImW9G4/tJAzm3T7LbG53l8fnVj5Z4ouug7LQaUQU/qi+EcNadmKWQf5OmhJ/qqv1+WOzcJ1Q7eVDPlfh5mEPJM60INcanZEYKp/LSwbWI/r6djEFlbLQZ/6aEj7OZKeQLnoNlOhcEvpinstcIw8U0JCv0iL6Cim3rstSxAzoHKK0/9CjhuK1M9ETYr6uXzBV7O4xTe9eGLb/nk9zlLTYoegklbNbezVi/4CukZxenx5JYkqPQNFsQ0Tkhxju80SVfdw6C6r7pRehd9+/+rFpialg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK2GRPYuyghP+QvIqNwM68EyhTEF4aZKox2vRzjt0zQ=;
 b=VBTaYycK2CJE7/D9188dLBCgfoOK/bfVTrZeQX11HaNlnT6P08xdqeVYqbwG3FUk6a7YqPJKnWvLUvCiD41paJ/nGJYIcejQgB0ecy6Eyvq39e+NNTgOUgzVCwe3Sk1XBtko3lVmyEvFsaS5KdyPqoyWFxr3NIT1E7IVwYhPPk6dqAuq2DlkbJdZzN2rQW/6ZX6TV7lRmgqxwTe/6LllvQgYi8wc1Y9wr/gMUbnhtqR4gMlUvariZH9zXNeWY28CrAMAfbOgtkIZZXscQRvjshNKrO5tIvNP7XBs+htVhzZG6EZGAXdGJSFidFfQOw4+6sxmjfp9iHuDsJ26G98XQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK2GRPYuyghP+QvIqNwM68EyhTEF4aZKox2vRzjt0zQ=;
 b=fZdKMmeVRYRozs/y4Yu+dRkLIgCTh9FtlT+k2tUQJ7M5FHZWkFf+0inr2Z22po3js3ZYbCoI6i8KV3zjVSvpT3/1F+pDvU+CrVmHnA8k+DkHsMVpQoVVwRMcBczzRqW0RwuU38LMy4i9sFFFo/mj7xwkJqdzgKurzvWydLQZGh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB3314.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 13:37:43 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 13:37:43 +0000
Date: Thu, 20 Jun 2024 14:37:41 +0100
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org,
 russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com,
 wedsonaf@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com, fujita.tomonori@gmail.com, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] rust: add abstraction for struct device
Message-ID: <20240620143741.3d03ff0b@eugeo>
In-Reply-To: <20240618154841.6716-2-dakr@redhat.com>
References: <20240618154841.6716-1-dakr@redhat.com>
	<20240618154841.6716-2-dakr@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0076.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB3314:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f859f11-4436-4721-8a9b-08dc912e2996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NkeTFi/6GDYhVnfy2Z2UoxnAUxA2dD1asfv9zsERSOI+gj508aowJf5UmQNu?=
 =?us-ascii?Q?zKblXSsk2rxkafVbIn8CvsO2Ua4c1jJaGpGd/PdKFu3ulsam8xlfc/n+LiuP?=
 =?us-ascii?Q?8ol1T/IB86bISME8f58srLFAf47ptYT6hVbW+fsKYLMLXN/Eso2787pRcVq9?=
 =?us-ascii?Q?caQrfYHndRMb5Jiktf1uOyzP6C2lM3yFYdfLp65WufZuMeIejv2a8LTTzSrI?=
 =?us-ascii?Q?yfA+Nwbc+aJ5tN3SnHkMcQlrog3S8FAbRnFi4tAq+x2ikMoqLE+oKgKvjBgX?=
 =?us-ascii?Q?a/goAKBc8yCfYocVYV//hX/wbtle0djgyDCN1Ijndw3FEHjOnlISd1ukjojd?=
 =?us-ascii?Q?76miX2iD2iV3yWuKEESDmi9JsFggT0r1hi3ihWaq1fekK9Nq190ToaECEWkf?=
 =?us-ascii?Q?LCaNniGvnCV8HDeiVZv0yaMf81880qXKrDm07dwewRfpYne09yf07/cLWxAI?=
 =?us-ascii?Q?nV5Au1v+Nreu0gBBs5Tn/2dEDkluhNjc+/v1/Mytpi1BmjrK9Gn47lQpKtqf?=
 =?us-ascii?Q?MZVa/GH1jj2C5PK1+DAz48PIQIxdwIplpDNuUziKQiiMxI0Ps8rQuEndVeJY?=
 =?us-ascii?Q?LfSe6tsc5QPb+qldQCufQZ3BWfmICC2fetyG5hScNdwrNKumPFGqnqOhGzPU?=
 =?us-ascii?Q?7RJUgPLPrwlLottv291jlwzhIprC8rJr1BWEo0ydEB55UUzfdZCpeJqG2FHP?=
 =?us-ascii?Q?sxVs/2KgaLfp4jk2CqmkdlazR8RbShSjgp3hJ44mx1ksCy/7pI5pc71EkdhS?=
 =?us-ascii?Q?WXY5iOH7lEp774Pv6M81FeITyYtN2e1zsGvTIokS20SEuKu1DVMHnIwNuNPA?=
 =?us-ascii?Q?vW8yNohTQQu8mXwHg9HPttIh35p/VQex6R7XVz3eENXpR38hVkh9NlJvORGR?=
 =?us-ascii?Q?nOBTlorZoNjUREcr1gg+/BxHHtFJyQK2W9oGa0bO9MmXBKk7k2JS04PvvqCk?=
 =?us-ascii?Q?tOeBp7YtFQtMSBDSEuAKh3wr7i3u9HZfQa9S+xZ3n0fqJvO+xVkY8R/jTIpn?=
 =?us-ascii?Q?ljVMtZIZYoEtLVIcPCZrmryhLKP4DMCSRyTBMsK/sVpDzjwkROZUrjlcKU3I?=
 =?us-ascii?Q?RNIqub2FgiFszcTaZXEF7bUttYdoWBf9TRlVCitwKDg3wICCZJU0UTSghCbN?=
 =?us-ascii?Q?Op64r2nsfnmdxY88aeXzBXaq2Kj6YLRLAu95vbT4MdbPYbI4w9pR0gz4znp6?=
 =?us-ascii?Q?yBiYYJR8yHs23vrehk/aNXxZHYFkRnF1qUaQ4RFi87hbyZyhjlJ+o0Ieqy7o?=
 =?us-ascii?Q?7WBEZucrPsZYt/lEWZZmODs5KXQUQ7F9EbWf//5odVT8I7g85EC5aKhdLdQR?=
 =?us-ascii?Q?8v8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWnDcwH1Q1rGnY0fVNvd6nX+qaihbAFe6g8Q2XN3MSVfkj8XAtc1mgVinXBO?=
 =?us-ascii?Q?px5nasANqR0ufUhFlcFArKLOzijCmAki0HjPM9HlBdWd1SmiX7mFXTSP5UHq?=
 =?us-ascii?Q?ULL+qaHk2/2buQ+1aKUai9Fquah+dG+IKX+1q9wAnVI0RIZ0JytfYr4QEDPD?=
 =?us-ascii?Q?kV4Mb9DXgaCSAR28A9v8rxieGg8nWP2VzbhNS5/EBB30hwSQ6niTeoqRlOmC?=
 =?us-ascii?Q?tdmK3ySTcucuf0ER3RVGov3OVbfhwHcYBGBuiDEpvmmIar/XQyvAzBYdNs2H?=
 =?us-ascii?Q?8r87CRNmrp/yWHMxfZAPL7WW1y2xt9wIp8P2HKhz73IPGvyqNE8LHVrRawv4?=
 =?us-ascii?Q?MGYciXmTuDm3oWMq2bfsYhQXUbhktLDlJ9C8tr6x54UOagbytGpmg+hUNFLw?=
 =?us-ascii?Q?/g2Ge486eXyA+Rf5pMqJnlnvyB5sWim7QDS3q9ChYARjG2TYZunVAF1mRwsm?=
 =?us-ascii?Q?q/2XEzYa5KgQYQcsOj/XuheQBa3qB0UEaGWr0RsyXSI7vfb1256lfaSarSF7?=
 =?us-ascii?Q?w6IUieHEWqNTipB4BQ62TaY0Z6Y4py0r33xNwOzx4cbUS/co3fzJq4C3UphO?=
 =?us-ascii?Q?Fjq5+8UzngNqYbOJIbyrgydHdxU7uTakV+B2aSwW+ig8cSOzNoE/mZMA5qoO?=
 =?us-ascii?Q?hHySGXgYCuP4cuTPTHrcgI82o5S6UG0lVdah5Ov3V6CWCuUf37RL5F7eVz+C?=
 =?us-ascii?Q?28fmtlNEL1mJ9Ox6HK1EE3G73RkRNtvtygGVEEM8ZvVLEhelcDiBz3r8vO42?=
 =?us-ascii?Q?eKhKyXR1TfESzWE3P1h6Ie/sz/pZe1TAWiTpYbPfohSBLSSGrEUtr7GRFyx6?=
 =?us-ascii?Q?msL8Gn8pLOoEGguBx7Y1Vi1x1kYUKuirLNGzDj6ukrfeRgYAHSnTVwYNHf+z?=
 =?us-ascii?Q?MSx3nOrd2GZu1MCijaHNuWGQfVKo+mjN99BzyoHBMNgNJeXKLZe6dUZppM2i?=
 =?us-ascii?Q?8lmdiD8AbVDHpi5cBtRldoVXQKNjVhgEfYhrLaClahEsAyUZokAhjPMUfMHw?=
 =?us-ascii?Q?VaW44TDVlOpp/qWpoOzvB2pC3Z7+KUez/5dkCKEyJmP49P6D3J40ElRzc7Pp?=
 =?us-ascii?Q?5mjzOX3GlWooQqG1+NhctCo8qNlcw+oLmUd0eHNcq/nxYVUmDuBlJn4zyP7g?=
 =?us-ascii?Q?vVgt8Llv2HXEXY9SxCz5hKTnElWMpcnJsHaLiv8EdQLFJIo556kclVysQzUs?=
 =?us-ascii?Q?gZ9t1bGbA+FiwamnSRYYLVCAbErY5t6/eBOnxnZTEcfEQ71d9VHWlhYvv29e?=
 =?us-ascii?Q?DkR5wYWxz4xkN57GDtrtaNiJBTggLSxV2XafMiFWdSsIiidpFhVWc7A4uvLI?=
 =?us-ascii?Q?Dmp4+CpCt+m4UFq9Cpaxj1fd7epmqnZbymg1imJFsXrRE3l/mpY9BXZGMypc?=
 =?us-ascii?Q?uBG6DJWpVUSSZnc/Axb4FGswInQxgPkWClk8rzcUteQ9/yuomhaYVJQlv2SY?=
 =?us-ascii?Q?0W8RuD7Nf0x5sDWLy7iiwzdu9D176MljQbBM519T6s8ys7GsPFg5Ng/1rXGn?=
 =?us-ascii?Q?E88Lyfw/cAtw0Rwh4FLlMdCsRKYPitOSgGbXSqKb4e/CbLpsUFiU70fTxCJ2?=
 =?us-ascii?Q?gtxExBKPv22TkKatwdAUk2ShMPWZroQWCRFMCwSL?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f859f11-4436-4721-8a9b-08dc912e2996
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 13:37:43.3492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkTccS4v9JVvKkjopBKDUuRAdKIR1n9Pyrgin/B0I3Xi2JB6zAHF9liZ+DVzeH9ZsykkgmOZY4xwb9hIpJiaXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3314

On Tue, 18 Jun 2024 17:48:34 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> Add an (always) reference-counted abstraction for a generic C `struct
> device`. This abstraction encapsulates existing `struct device` instances
> and manages its reference count.
> 
> Subsystems may use this abstraction as a base to abstract subsystem
> specific device instances based on a generic `struct device`, such as
> `struct pci_dev`.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers.c        |   1 +
>  rust/kernel/device.rs | 102 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs    |   1 +
>  3 files changed, 104 insertions(+)
>  create mode 100644 rust/kernel/device.rs



