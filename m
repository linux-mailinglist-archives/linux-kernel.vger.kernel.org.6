Return-Path: <linux-kernel+bounces-531872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC91A4460D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6A01899B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C87218FC84;
	Tue, 25 Feb 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="RQ5CJE1K"
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021117.outbound.protection.outlook.com [52.101.95.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7421ABAB;
	Tue, 25 Feb 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500960; cv=fail; b=RnvHYTY+b+iFpvUMG4zbmxL0E5XuC1zTstov7vKxASijhpNAanzCL1DWOaF+5N1N91d1Ms0qcV0Y3vX9c/8Th8vaCKwzXplux1EjUaDPM250SYEsR1L4ssTGMT2e1966qxasijuqY4laRp5VVVsKwEsw/qYuOCeZ2BnzuHQUuHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500960; c=relaxed/simple;
	bh=k4aOTNRU0BkPvhslkRovkBmw9Nfv39f/PugEQLSVNi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cLqWS1kyNVEJ4u6UMvw6BfTcvkthUD3ZIZz9FuoXSlzLekUKX2gVNTtZ2nm7y1NNqNCNUjhfaIbzgqj/VlHJMOI8rtzcr7zF6bGt8RhXRKNGAC27TxNbzjTN+MKnTzvCgbCS+fN442ijQfH/NjGGP1azhjAszyI1Xrx/uUhzekQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=RQ5CJE1K; arc=fail smtp.client-ip=52.101.95.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkaH4sHgPkl9qqyGwp1HZZxqmfIvroLdbzE0QdxK/8567nPrx5ge79CAq01usuFlRDG4cFpYUlUOl3Y1se1+AQcJLI99RVn5xP6+Vsl/jkTzP5RB841A55p90eaoTAGT1tW2IKZFJp0cNgY7KBHZb1vqC7TeZC32TkIDtDgLhKExrecpBNyZ/0pfJHL04pj6Wu/KoNHxyD/qrnRJ+P/IZlU5xFT9vjVn6N4KI9Xg1bs3rDjkgOr+cis2NF992/KCbx4B6RKR1kTBmM6aFU0FRy4pIl0NQtuuc+BI/gft3WjytkFDRU1F4MB6D4FzFOvq/wj6RHd77KqJb+w/lzaqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVoVVXfE8xJWc6e0XCtt26iOjsMpM+XKVAcQ+IARF54=;
 b=fh97QVTrsC7DSK+Ddczn2cZmCA7hO1jDu+XukqEfenYhEcKTgi7JgXgPMZaQDDYwHhNq90fz/H0fO4lmP7I32Xob0hk2BVS851sOCCllrYqZMVR3c13IapP9cqrA70xJS2UCGM35UhKjgnfOSzDI3Rc5WI2BeXIO3W1B0gV+H0AC87frpsO26HUsotQt1aXdk8K5Ft3AFwNj3bZRDPW0QhBNwxLoX6bUUB+UscXNlxHsl4T9EtcphY2NArxNUgCRn7t7GCeaWxCkl2UKAmk3jHAVIMV7Gyf91xJOaJLg/0xvfuGShCOZtKLqJ5D5Anqa+sNBSWRWpGxAr85Z7307wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVoVVXfE8xJWc6e0XCtt26iOjsMpM+XKVAcQ+IARF54=;
 b=RQ5CJE1KFHvDweOvpmxM8f10bAxSFaHR4NQ+IpaSruNp7iEh9+aE1TV34OfDmn6Pn8zmxu2CMUdJOndGPtA89+c5jGtnmuQmhYVDL0bwCl1CjjSPi5oSEuctUR0db6gBZFndVR094L0STu+vS+lTq8z4bFFIgEfLaAP0sp1gfp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2805.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.17; Tue, 25 Feb
 2025 16:29:16 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.014; Tue, 25 Feb 2025
 16:29:16 +0000
Date: Tue, 25 Feb 2025 16:29:09 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "
 =?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v14 7/8] rust: miscdevice: add mmap support
Message-ID: <20250225162909.65942e34@eugeo>
In-Reply-To: <20250213-vma-v14-7-b29c47ab21f5@google.com>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
	<20250213-vma-v14-7-b29c47ab21f5@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2805:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3967ec-2b84-45f9-427c-08dd55b98c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCjfx3sBBFCyXVkYhd53dVt7aSqnlBYBKz8refyJpwSYefshAJG20V3hA6fM?=
 =?us-ascii?Q?cIDIiyNz2zghthzfxmKNErqvsgIIRzO3VuYUsGHXPpSLjBxfEyyM8Cti9EgI?=
 =?us-ascii?Q?NU9pxGPcDDk5pxvKh+lFNvcuR2m9vq8rFqi38zu0VM5chjBaAkPkZeei5qwS?=
 =?us-ascii?Q?9mVFIZe3jzOedVdicYtxDge6jmitGOQuUcSzYZJ3Obr7PJpepyVh0kiMUiLX?=
 =?us-ascii?Q?Dc5bS09uv7vR9RoTJ7VTJlDT+ucbW1oOmU3yjTL+1TaYWwtXW8E9k/QIpl5C?=
 =?us-ascii?Q?OOFhPP+BFToVuqzdYc4/y90Dgtx/++8qzJoXxtuWReFZDuXxBjwffASbqlgL?=
 =?us-ascii?Q?pjhtV6AYQlNvBQ6BZMR/tne8auYyIhryHSO2g3znR2qaQaT62+/pP+voul05?=
 =?us-ascii?Q?YU1amRUNEh/Tn6WwZS6aqAvMTML7BshyBvN/zFeLdQqSRQxIn7Q8lP4P7QKW?=
 =?us-ascii?Q?Of7DlN28ATXL2j68nJ9acRSZO00ZsmnWZaUul10MUUSrlXmjo/ce9SsVExkx?=
 =?us-ascii?Q?/KfyOIdv5N57ym2TSZFz25bXq01xxbYhlXlqyaiwMbtUl1ahuBxv73MF1f6k?=
 =?us-ascii?Q?E/i4RSmztjDmZ+oi1Hi5V50n4LX+uZmtRVZjjQnfAx601k48kt/wXybn+Bx7?=
 =?us-ascii?Q?SZu0dsCnDBTRT57t5mHjUFWgzECqIaYlwvC2Ux799EdzK1cZ63qvMQnxS8iE?=
 =?us-ascii?Q?DMeFzvQ4qZ7eBqeycRBfS8DhJIL5mB9A03yOls2Qvz7ERiLuOV7kkupZAtb9?=
 =?us-ascii?Q?UmPMxvtUihqELy9zcSDJd1PakC5PuSsHIPsgyxhyFk78cAMrj6qiX5i8G/g7?=
 =?us-ascii?Q?gFpKeRkJIepxDaXQSuxCW85UHeeUd2Xe/HWlJcUorLwdOQbvXrmX1T91q8rs?=
 =?us-ascii?Q?olOMwmaoJ7zra2c0NMfyDifT1EFKH6zZttb0OWJDXtjDBFUMXHBemF50YR3k?=
 =?us-ascii?Q?2bX5VoBSUDHGcn5FBYM3TP1AL7Y+0yErBEa+Kqi1amd+WT+LcZ4/n/TVq1VB?=
 =?us-ascii?Q?JE22X40HHZxkLWSj+QVGnB0ixUAjV/2HTQJg9ajAba3HCZDWKJvFp30jl84O?=
 =?us-ascii?Q?d06+UGcofsorVHgMXoeICUfy+d9cX7jFNciNzjRfeVLg+4rBb35z+m8qLg05?=
 =?us-ascii?Q?14qjvJtcWQbl/F0dVU0paI7DbHh4Ba/tGkwgCuLr8ogyHGDnoN7vxHVv15dz?=
 =?us-ascii?Q?rekL9c764ygcg0N0zU5vTgK8BEYQIgsRJLZj1ZGw3W5R8EGB9WrmSR4OQC3k?=
 =?us-ascii?Q?mzScHpEsUt7ihUriI8zE0HLrm8klW2DwnwmFxIbg0/nGJHqxGCIY+r9rNJNQ?=
 =?us-ascii?Q?DeUhfQRV0iOdgefYzt4pQIikRCnRXo45N5O7UB+lPi9ChEBF34EEwtdZyEuN?=
 =?us-ascii?Q?6tUYmJJLet4gOi6RW99c0qpI+m0g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9bR8vEaLZRznAlz1nExxWnjqRbGqFIUPn0aPtYOTYvgwASyyuoA4nNXHDb5N?=
 =?us-ascii?Q?dRzaF9WKN7lhPUUk7HQWOqkTukMdjy09zXprGV58OHI+zWeWwzAI5MVNhLaE?=
 =?us-ascii?Q?SEknXeG0sxUJtqnTdlt3aTrG7ESC15tWbSWDALnI2FoIR+a/qhQ+YIczJ/QS?=
 =?us-ascii?Q?NUHACew/j4c0VoSrpR4z3EYiHTbnuiHVygleJNZcc1Xo1DUAxg4rL9lGl52S?=
 =?us-ascii?Q?gVKAc4oFNivNXAYI4x80WnnlRTiGBkldkhsWZHJIoDlgHD8B+a3LCti/6MOB?=
 =?us-ascii?Q?hPxwGKnOOPsVrGb7s5qiLpHtjtTf0TUec2wmPRu78QuTBRwX8sdBtl6DCTQY?=
 =?us-ascii?Q?gMjoRS/MP3IxWkaEDpefjPo+tsuIiY6SOKRE2x5ihXnUwhzjbVWYu1VPFADV?=
 =?us-ascii?Q?7fI3+SwmPj4MEwam4zh5lOjIeBYkgdLOuxYppDFKzBvllm25XRJpeh/hfPM0?=
 =?us-ascii?Q?s5P7O+4RX7YIPiHKNxFFseKcHS4kpfj/FXZmbx7ilGFw9VS/HOpHPEzLrKDs?=
 =?us-ascii?Q?WpeJxT4lUeE3XNYT3DOifkNUZLNrsd7PJ342yK2eYWGMTj5f/OudyuBOGzu9?=
 =?us-ascii?Q?iQtGLGBuULvNQYPqJjahJm3OmeO8OyUnYh2winrZe0AriXdPQAQp0/MOiaEg?=
 =?us-ascii?Q?MTPz2aL3159coCTZskedin76+QYv4oB67Gs1EGnRdMBy9x//uDMef9b4HcwW?=
 =?us-ascii?Q?rgZL7Ux8eL8qqN+wRHTpZBCMMwAtXrmcbgxeCqfq64hOw69pwRCdPNi4Z7cO?=
 =?us-ascii?Q?5YGhmccH5XNM8nmlohrD0olCpq+EAXm+6Vvc4ikwOEZlUUrRE4i2J/Lur31w?=
 =?us-ascii?Q?p3J+TII8gwif43boKM7t5XujHN6b4Cxn+1tzrFF1uEN2enFvvhDR1xSpE+K6?=
 =?us-ascii?Q?bxYl7YXSju+6KT2UtwqCSdbhHHY8SyFlB98uqA1f/SQ40AQcwCPxwkB01pE4?=
 =?us-ascii?Q?ZWMGJ3vYcZ4T0BsO9Snp68NWZz6yDo0X5LRL3DOpIlL6S1sSIuFcqMVM0Ar5?=
 =?us-ascii?Q?NBQAoVKkS03hXn2+Gta8/ygaHIHgcuS5msvK/Ih0qe4brrCSjcmSbuH3HWt2?=
 =?us-ascii?Q?i8GLkDvGbnLQLSaJ9Ero2Ta2KbJfq4pCqAguNgA9DNFMdvnsoFlLslH+yOhG?=
 =?us-ascii?Q?nj2SGRVS9TBlE+QVbQVEwP1Sr0AtX4SO6K85oWWm1AtbgjhN+PjijJcqo7qv?=
 =?us-ascii?Q?8gSAS1bICvAj4bu/6gQ0Sd7mDEDFhYHXasxSGQeyu4/E0nAM/lJDSMuqHbju?=
 =?us-ascii?Q?Oud7JeWfxj4zFehXof+0X+6BPJOi0I3FJcXCdMKtak/+WtWIlESjggK51GHm?=
 =?us-ascii?Q?lITl8pqaUkqV2Bfq8ieldapUcDeyfXXjeWcGO7wPF5Kg7mvSlRf6SrwjtmLh?=
 =?us-ascii?Q?zwtZasdbM7igrIhXxL5/Ar0i/8A7KpXJfULYiD2KJ8AUF6RWkBhqxFdADPg+?=
 =?us-ascii?Q?hj0OzgKMH5+Ap7eLg3QrABrL9qAaNMc6K1/gSFjWLawFLCcUij64AB5xmWrG?=
 =?us-ascii?Q?gt83rKx/LUdvBhZf2StU/xW2HcSLd4803/iXmfdZvjkbocBjkeQ2ghRxaW2+?=
 =?us-ascii?Q?OT3ezwUnyaktX7ZNLIm+vYeyH+QZJ1z/HFHTdRGJrP8cSE7bk+giUfZDuyU6?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3967ec-2b84-45f9-427c-08dd55b98c46
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:29:16.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cxGfZhMJ+Gv7nyStw495mX9NOGuYqR+oBb4thpzKaSXr7wOS8idLEJntyzbz5sPNX6R5C6+dyysk8iKcRsGJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2805

On Thu, 13 Feb 2025 11:04:06 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Add the ability to write a file_operations->mmap hook in Rust when using
> the miscdevice abstraction. The `vma` argument to the `mmap` hook uses
> the `VmaNew` type from the previous commit; this type provides the
> correct set of operations for a file_operations->mmap hook.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/miscdevice.rs | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

