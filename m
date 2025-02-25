Return-Path: <linux-kernel+bounces-531798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6104A44517
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0663AF5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06AE16A95B;
	Tue, 25 Feb 2025 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ca/N4Wjb"
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022073.outbound.protection.outlook.com [52.101.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692291547E3;
	Tue, 25 Feb 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499000; cv=fail; b=dE7ifqY7meZ08txqc96cmsI0Vud5ef4IMy/WM6ReHVupFdULeehwnGR035314Tb4UTLNWPh2Ox1MdjVCcI/NLFoZ9nH4uDQGMOmPR6iy64Lj9EgR5AJxynU2T8N45MgWhh/b0jHoCu+vfYzhcRHePEDfyXwbdAztpIRfTkgHvDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499000; c=relaxed/simple;
	bh=kM6FtQgbs4PYS9RwAtCpG/r+2qGIiWE68yhkx6Xjctg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CM+NE5wtTJgembF9uC93kHkXMOk+xawZqBA56FP9C4qjv/tRU/OsMdqobgqoGKlSJvoP3VvTVZ0w/EMeHh67CrqorlMZ9ugTFBqFcowkuSmqPzyPpu3HHzbFVqo5llbEUB4fm547EhkcEjKGHw5kniQOx2uA50U3yVe/NMe3f1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ca/N4Wjb; arc=fail smtp.client-ip=52.101.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n28Q98QI/Cdx58JqW6IwOSPy/D4xJbvtOOA3HFR8Yy3YkrnO1I0vruMxthpX/MoyRgMlnVerJQXp5Tn+wAjPWJYPZMMKfcmtYiX8GXSUbwabZY0KYJ/3Y2AREHEyHP+xXMvEj3KlfszcucR3ZUubt6deqpg0UOrnZOzM52BjtKsMMRKII9B2pFm9w8x4iScLzodMUfLr6quED9/81natn4TEePHeI9darkw/7F8hs4vuNXI58ggJtyH15CL/xgKh0DliV+L54yEF+OgpUiPdNWJ27c49k6zVLkLQqH0salYBmMJ2lUIZ/BmoBh8pe57JwhNzOJyjDZX8BKQEPlkgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfzQGy62obrlElmVK1bqKSr8UiW/a6DKHpZy7oQ8eiA=;
 b=FNK1RzTXQ794oHMZ0k/QsgYZJe4COeCJw16OxcOmFfSwgUnHFW20N7j6VhatBaJOaj3vVN6u9HDCB7Jbysh9huDJmXKQOJ5hTt1Mm58iObmP18zflh0sppcPqgHeTBma4PHRcMLgaLLQJc1MJIsN4XLoMDPhW1z/HLAXy/hhcxubBRPO9hxjXuh12T+c2P2Wht/W3Xwpu4jeflKDBYXDzuABFPAhaHaPVlUaIwcm0gtNytx8KBSrMsabOCxNRDFTlKSUlYdgXip1Xyi/NJKQ4V2iiJzkYKb1rw/imlpXnLTCRwDFBTLGz+ETNghZABmEVaPqT0uDV2Ri92e88tF1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfzQGy62obrlElmVK1bqKSr8UiW/a6DKHpZy7oQ8eiA=;
 b=ca/N4Wjblrg/e+ZvOyEWZ7neju+XgCQD8KDMM4/IgP9OsRYQtj1NNsdTE3i7E3zYMvoqX+GND0c9eA8IIib2n6Lav7Bfxwxxd/ZRFmp5RTeB2gxI9oxTlfW1UpRvNZONLBNH1GLUvECqtaKenf/VYU65Yx3y68ILvshGRxSyXLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6567.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.17; Tue, 25 Feb
 2025 15:56:35 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.014; Tue, 25 Feb 2025
 15:56:35 +0000
Date: Tue, 25 Feb 2025 15:56:32 +0000
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
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org, Balbir Singh
 <balbirs@nvidia.com>
Subject: Re: [PATCH v14 1/8] mm: rust: add abstraction for struct mm_struct
Message-ID: <20250225155632.3a8d69e1@eugeo>
In-Reply-To: <20250213-vma-v14-1-b29c47ab21f5@google.com>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
	<20250213-vma-v14-1-b29c47ab21f5@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0320.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c54aa1-73d9-4546-78ad-08dd55b4faf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a0LYOZPAO4sth0WZB0mzTqUyJxGHQHVDWqC2XlVWhPng+tm3zcrAxD9gYzwD?=
 =?us-ascii?Q?uYPk3FNeZo9jar8RGUQAaxAA/csCZb3vO2FPTQcxCnsy4xT9IDyVdwl/utDH?=
 =?us-ascii?Q?0lOENhO7Udi6iINeRn2QEWNhZZFG+JoFb1T1mFQ60axlyOojxSpTmfLPGueA?=
 =?us-ascii?Q?jyArlttys5r6jREokjHy32mn9UySNWdakzgF3QoDxmtGk6WhR7OD4jtR985b?=
 =?us-ascii?Q?+RQmvzeIBYsj9BkCzuYqmqvoeRzt9WPsD8W5VXmAYZG5Dts1W+v8zuMQKsSS?=
 =?us-ascii?Q?Ez3908Ctf960mVvVn4O6GBJGmNJmjXrvka2YmBWaWTvAcRZHewvU+qeNtgp5?=
 =?us-ascii?Q?WROL2i+4VNzC0FlouDJz59loZEX05DsXIG9G3V35KHROkHShSPd+IMP++JhZ?=
 =?us-ascii?Q?hJBWUSI1sFk0SA3eeOy6nP+EwX4lxBj5MoqpHdepqWNRRqYfQbqgljM5Ay9H?=
 =?us-ascii?Q?lBIOKV9ETDFHk9SCraBxE1Uv0OMrDQMle0UaTsMPWQg+mO5u+Oa3oL3gz6+H?=
 =?us-ascii?Q?/1B21a11Zs/A/V8pw6HAPBW8Z9TECRZOAVB225QfeHEhGB22ZgWWUZWhJSSp?=
 =?us-ascii?Q?zTvJsxZSbYT5HmjfgQU4XmMS16Ug8SEFzTaxKmBXlB78ofKwgJTXHlzDE0pR?=
 =?us-ascii?Q?XhkRD2Qit+SuYxAzkdQ4PzPHaow0dZgsZ+3onbnvzZy1VLd58zXuNFhLCWaX?=
 =?us-ascii?Q?vX/0D+mevkgyrKS/WABqP656zISu0f2jPBl+IB5pelW7XSlevY2b1P3nEgb9?=
 =?us-ascii?Q?93gTz0Su2s6YB+BUQCF66gq/itxCfDOvQK5eUuaxV2HluIRqY8Uq3HncJ52Z?=
 =?us-ascii?Q?QUWvgZgkSC+REccXCcRwD78QXQPqyNKS1t2OcgMRI9CXuowOS2Rs0NcCQtwB?=
 =?us-ascii?Q?p3Mxj8WoXgIteGbz9t7IO79pxwqWNYwES+S03WktZMNePd8SgdgQ0cTlChQF?=
 =?us-ascii?Q?x5zBr8dtmxqN17AsRT5Wm9GSGTDSqMxPkKADJj6B+P4gHKTdcapX5hIZCw32?=
 =?us-ascii?Q?0dAoxri8YypnF6AmndZlVKlb2LqR4EUyTtJE0um9AQ0uEbW3KGwLCZRfA+3M?=
 =?us-ascii?Q?8BTHJW5EOvat6f01g30x8VYTuxivrlSLEj2/pqaXp1PSROqmRfxAn56c7y8Q?=
 =?us-ascii?Q?+a0odGHYOlmdN5MGutJixh+wfpstetQ6lI7qBUbY6RJ0Sr994QpsMiw6KLNB?=
 =?us-ascii?Q?Vyi3u4QHXptK9MnlQFhp+xhWBfu9VScro5fDA0fRoe0hqz8stcCm5xCtaoJn?=
 =?us-ascii?Q?CNmOpbdGIeRTelQhBmp4aqKrBJPCWm14z/m/t2/r8x13W1SfqHdj45Cdok8C?=
 =?us-ascii?Q?cXlIevpvs4p2dxMooLeU5ja9Wdalro1nN1RtfttBYPFg6FnDiB6ZnuDZkY5S?=
 =?us-ascii?Q?aeM4S6HDBBdY1rNyjc64iAw/SUoR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aMS+9x/cDj1ddxYIlz9/MjdP306Ai+8IqlXylCNmjy0FqzJy1+jAXKUsRHfL?=
 =?us-ascii?Q?4r/9i6wgnjyDfSMp5pvIFkel7UyOWOyixH0seKv9OZgse9o0LUD2iLmcO8/v?=
 =?us-ascii?Q?x0DcCwLw58Kt9a9MqaDnx0TGlj40gvpKL7ymRf37vLO7xLpec7icxBLDkAY0?=
 =?us-ascii?Q?Y2H937eXoLSRIQ5zClM2cK26kaGwNRwmrNOSnv8+/scKOz+aImdU73kJR4uX?=
 =?us-ascii?Q?u+gbOtqrDw+CV55yTka3qf9PeXHj61K+pe0JMKJ7ceegKtOg5+J6jyne0eCx?=
 =?us-ascii?Q?SIarACDh3tw3sAuKugAeYcyH1P4VR4wS7itznPdE7HwtT5167IB1hKun6D4n?=
 =?us-ascii?Q?gSCQix6oPCMDcsXTx2bMPYA3mUMna0rJ0XbPRzwJr5Oh4wiurFSL5MqnWY3c?=
 =?us-ascii?Q?E/hJujOASjRZh+XUTnjHATJhcAPhqe/k4S+iAEkE9lH/c4NBRuwzgxWNR4Kd?=
 =?us-ascii?Q?+8fRnfgf1tpNsafltoMlvbD5z7kt6tjZKBU0/n/kjE9ZGlOT9UhfkccwDmi6?=
 =?us-ascii?Q?pX26RG03EqW7nZMhRcOPA7G9JhykJffCGsEI0ni4D+xUYcI9HG3g7aY2+Qgi?=
 =?us-ascii?Q?qeQSlM13hJrjcOA4eDiaWCoxemDbPHY8UdqZQ2wjkN3sjLASrlUQ/gTDwAxb?=
 =?us-ascii?Q?IXtxZ5CXCQRYHHUiIdoTt80OZACuuood/kII7O/5rRykmrrI7rSDBFgIGjih?=
 =?us-ascii?Q?JxC9FXPbcBf+qtfr6dO1Eruayf2RzPGWwxn/5Umu0pxn9I0R/E+WhUQRuPQ8?=
 =?us-ascii?Q?1a+5cKSjwNGxn/mpYAGHVuUBR0JnWONYNZRGSr/H91qdW3a9bdwPMNtt1YBg?=
 =?us-ascii?Q?xFIB9J95eoGP506Z3Hd6ri2EYkvJ4gfUheBJydVe/QMaM3UTzuII+NpqkNi6?=
 =?us-ascii?Q?dtMZOwTS91+XG6vzRwNhOlB950EobJGoF0QDgZO4Ce7a20pGxDcYNhJX+6/S?=
 =?us-ascii?Q?AXTAnuZT45ex2TxwCg6jpswg4Gq+AGkUkSMyxYIL0Vcli/5WjrHP4ieWgWB9?=
 =?us-ascii?Q?W8nvEZ4kk5svEGIggJzIC34Anufief089oIuxsvEH37MfNE4X8wOVl0EiGp0?=
 =?us-ascii?Q?zUm8b3hNumzDSuIgcClKVjF0RFiX52K1Dm35GKlzW3h6KLdmehSDWf23ty1N?=
 =?us-ascii?Q?qD0Cbtfs7B9kDeea7MgdlZvVvxVDL+wFwNY15yuubYor9Fwq+CaSrXKOKaSG?=
 =?us-ascii?Q?7VCm1wkstxt0vaZ5jYLKpLlDvAR1rlR6nwU0cCzv8KW7yMpvNXAxo7xukpUX?=
 =?us-ascii?Q?qHhDT6N1PiTKInxTjcCmk7E+Gt5Jo8rmXvQ7lcODecUxBE4Ze3WXaCxUzPH3?=
 =?us-ascii?Q?AXIkSJpX58p9t8k0+/Eh1fGXUjJdmFhuhP6GNKc4maZJ4+9UPi0t17Zg66fo?=
 =?us-ascii?Q?zQG82HmSIxySQFg+UCjeU0b/U2FxPSsPDj4OoHPM3oIKlLAYg/gpL74CjFtF?=
 =?us-ascii?Q?eWi6OxGTsq13Z4dMKngGKfWMQ3QZWZSDPDhTqBewbhzUU5tyntaQsYQZOWb5?=
 =?us-ascii?Q?/Ud0FSpWSRsFn5fblMRi1283HF4uoGcwXW9fp24Ra7FrzNDU4odxfgkP7wvl?=
 =?us-ascii?Q?dEC9yqsrht/zZHAjGfkuaa78qfmQouoNQDMVeBo5Dhh3yzFyX84MC3pF7wQZ?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c54aa1-73d9-4546-78ad-08dd55b4faf2
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:56:35.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIv3OlY/SuYmeKdBp29gavU7jxSsaqDmABZKvoih0SYv5OmaCEtjkdK0S5bT+4XnqbT28oL0Wm36RofOEo4yIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6567

On Thu, 13 Feb 2025 11:04:00 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> These abstractions allow you to reference a `struct mm_struct` using
> both mmgrab and mmget refcounts. This is done using two Rust types:
> 
> * Mm - represents an mm_struct where you don't know anything about the
>   value of mm_users.
> * MmWithUser - represents an mm_struct where you know at compile time
>   that mm_users is non-zero.
> 
> This allows us to encode in the type system whether a method requires
> that mm_users is non-zero or not. For instance, you can always call
> `mmget_not_zero` but you can only call `mmap_read_lock` when mm_users is
> non-zero.
> 
> The struct is called Mm to keep consistency with the C side.
> 
> The ability to obtain `current->mm` is added later in this series.
> 
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Balbir Singh <balbirs@nvidia.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/helpers/helpers.c |   1 +
>  rust/helpers/mm.c      |  39 +++++++++
>  rust/kernel/lib.rs     |   1 +
>  rust/kernel/mm.rs      | 209 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 250 insertions(+)

