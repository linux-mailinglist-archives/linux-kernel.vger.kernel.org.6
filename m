Return-Path: <linux-kernel+bounces-329495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2710F97920B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA25D282A5B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC6B1D0DDD;
	Sat, 14 Sep 2024 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PTM16wc7"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2126.outbound.protection.outlook.com [40.107.121.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762731D0DC9;
	Sat, 14 Sep 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330387; cv=fail; b=dWiGL/PhI4l2edM4lNqK5j6bi7E48S1OdHnbIZupnzJh0dnATqKbHXLLFjbifo0eeJXbaTl6Qu3YIijStGDoIj7Sh8RjXOH2uASZg/1hU4suafJkxAQH9NRfnHXq5g5wCAicXTD4V108HwUDG8gjZ7bnJNMla/6VmnqeUudZg2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330387; c=relaxed/simple;
	bh=htMU7Jtt7IKQR4y5ilKrUCekFsdQEJrGxQfTuIs1IDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EtqZGvLWpPmrmSLeOszrDrHdfPeln/YgBmKAc+t1uvDfpTnwS5XhEArh2QHmIrmHv4vVb9jqO2NnYwEsQ9kIBDROJoouqys4wxvLEfSQOM1rG3oITQZSSdNQaQhaXWtgrT5WJbplZEPMjShlkrLmdES7VYRWQ+fvJTcy/JQmK5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PTM16wc7; arc=fail smtp.client-ip=40.107.121.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOBXANUOGR7/HgXjwfIzOcaypVff2ZsiK69B5LIpu4+Fx4wBTQyCYANCw4ApSA4pFYq0hLHeUOkGFpNTDo4T8LT/pWC95aCEDlIzPKx6w5yPktiW/Va8g6Ju+G94h/Q9t3K3tIaA8xn+sZbprlU3JdVDIsNq/1OWwUmlYmDBpZvx0EBWiqqsJ4HNB8Ljv61QGjqQBgHoaT2SxLr9dXguGGj7C8h6qk+6PRadxevkhLFdWASfOppu0ve19E/dMWTX1otmEalLimuvxAuZbaw7vhiB8V+7PwKvSVNJl9hj5Hz/I5XcaDJdmcUxw6vaSFmDZ5FwWYlL6tL8Pdm9djCBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ko3hiLq9pcuaTn8AW2KyRudktWYCsg+8c975tzt9eM=;
 b=iJIDkUNvmb5LGK3tIg0gDmCh1Xnin1gCfZpe1yvdv+69HYJPjf5ciNyFiLaMQNXbtDGHvNSsvuIPjADrq6X25TF6ijuOiQo99S4BYianxvRX6+rGWOzS5rK4CXu9T4GLX6//rZI6vhQ1XaHotCTYf+pgMfAwCZKVqMZb1YDJdPS9hGXYWd4wYZw1iittvsqI4hd2Sup7bnG408eMwEgXba8zhvilKEQE8se89mjfCylrSsOyX3fM5k/lAc5EsMetyuOuOK2BpnZs6q9Wlqqh6nwWb8XNunZXEwpVIbM/RYSej94QjCooG/HYJpHB7QKviMfbxy6mjSiaF9rJV4FfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ko3hiLq9pcuaTn8AW2KyRudktWYCsg+8c975tzt9eM=;
 b=PTM16wc789h8qSfdL/en81fiKbU1Knvqy1y9S/h247yHo752O3D5b+IC88UNvrWZ6Dk+nQtsqhV54q5h0g8iAF5F2iBLupHbquK00VJOlWEPUTTGe+CPBi4VI8zf+CqqlMlEAw1dMmeUpZ9oK4mWP0q5canfnECxmwxUHnWRO2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6671.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:306::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Sat, 14 Sep
 2024 16:13:02 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sat, 14 Sep 2024
 16:13:02 +0000
Date: Sat, 14 Sep 2024 17:13:00 +0100
From: Gary Guo <gary@garyguo.net>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v5 1/3] rust: Introduce irq module
Message-ID: <20240914171300.62e42006.gary@garyguo.net>
In-Reply-To: <20240912190540.53221-2-lyude@redhat.com>
References: <20240912190540.53221-1-lyude@redhat.com>
	<20240912190540.53221-2-lyude@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0688.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 472f5355-ad38-4273-809b-08dcd4d81bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i6wrSO7Ogrv9lQRg+hlYa6pRLLOB6Qo7kYdmLt1ehuxgbdcczdeBeIkPg07w?=
 =?us-ascii?Q?JRMD88Jni0i1RoXliJEJXAB1pc+TKXr5jnLhR8hwANZtf+oa7Mr/e6zJXx8u?=
 =?us-ascii?Q?mfwF93ymItTmRiCSe2fTytfrnDhUqq/9IVct0Y0VL8knCKk4CZe0JuGGShn9?=
 =?us-ascii?Q?YyrYNmCl4ueUwBWzSOp+HEV3x0vp+x0Gcofegm+PcgfsYNDRxizjby+N0ejo?=
 =?us-ascii?Q?zzXj69k1rd7YRfakGDA+J3Urj2Fg8PcY1SZIrQ3N7zMN5V63+h4MOyzFP6Go?=
 =?us-ascii?Q?zaQSPSeusjw7lQqwgR0+HiOM/k+Kknz7+Yt145xscfxh9N66z7SsjVALJnXs?=
 =?us-ascii?Q?ai1MdGCRuVAEe6wWDyH8H/+mKz8Tc4eHWUMNZGj85D5Yb/Oq4wBTi1MBzM1F?=
 =?us-ascii?Q?t2uiQ7igDvvFaN4o7tThisEN7yclkrKXaLRqIcBZUC7RELGJtf5F8hC0RDIr?=
 =?us-ascii?Q?irU+oqn/kyu8WFS6PgcLDdFKkEdv2473SfdHe7seY6hoBiOFF4KIidCjnSyQ?=
 =?us-ascii?Q?q/w07S53dOus3x+FkVJpTi6evq3F46Qanmtp1/FB6Z5dHrTXknyC032FtXIN?=
 =?us-ascii?Q?vPqKUwZIh4rLs/WVQHIAivdARqrlsb8BYwXGRM8K0uoBdo54RQfFZfT8yVuk?=
 =?us-ascii?Q?x4zlxsTur3Krax/xcrMeoq34wjQtZKK4cJOyZICyGCCVTjj5mLg9pCXYJNtX?=
 =?us-ascii?Q?17Axfj31LcwGoAQITVpECEnwV9VfDdp9Mkv7jthNxQjhu997YZHvoZum+R3T?=
 =?us-ascii?Q?J5n8pNLAt9gjH6BqjUcVZCayhdIc7FWNwdWbEDrhftGnjxqBrf1/0XY1UjqO?=
 =?us-ascii?Q?kMd5ztNckndUVl7FdwUWkpRZQ9U9PlfE77jgL5s/MijnT7UgNiHOYNgrrmAR?=
 =?us-ascii?Q?bDwGMLGfCmEeLJrwcqH1+fMSWK6WxpjOEY67qxZ/F4ictDOjYrKlXcjssCGg?=
 =?us-ascii?Q?d/AV+qA709TAR7jsKkjowFM6RtacE6nbUJeqFB8yx2j7LrzTmogKWyAM2LZI?=
 =?us-ascii?Q?23jSZJ5Nog0wqI8Wro3dKMpZFZuuY2v6v1CSkaOigGmsdPEHYHprviwtcZKy?=
 =?us-ascii?Q?97WP8YdZGFBGmCVCR7neLyNCzqd6za+z71oeMHYkg/9csGHQR45Rs0vT/C4j?=
 =?us-ascii?Q?9KBeDN1TRD7H7O2QoT+TaJpbvuqT8sNT2LhY2wIrLqnXS3iIC8j2A5HjcrKg?=
 =?us-ascii?Q?czCkplZXdPnabApcwmR9X1WDLcaijZNgUICYccHTgFx2YUGn/FvRoWOvMBjY?=
 =?us-ascii?Q?nC0xO7HQQTwhcHlY+cklzWIK5Lx0Y3mbe/2ujTw8weafdRJY1DRu+e58S2P8?=
 =?us-ascii?Q?hqyHRmOxdzMW8jArIqy+JdKmfbyNnjSW0kT34wQBrwf1PN3HZKvyq1v0ECOA?=
 =?us-ascii?Q?Vw1+4jc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yyE2gpgrZjlHnqR7V+d14LyLolqVmyqmgNJN+6G21Rqeghpz3Te916xzNqBz?=
 =?us-ascii?Q?YJHfEANUJqjYmEY4VmVNjNsOufBxpJMFGjQORQzHGRG6GA4srhvHty7s8vFz?=
 =?us-ascii?Q?OGAjamUFcfZUtC5G6LC4eBJVDXJ9f5mHNqJFeTcC05+71TkFRXjN0bpdkeCv?=
 =?us-ascii?Q?cgMgalJpyOoRi5HC9pm52XAHh38WrMZkSmMdFNxhffSBWWm5lyaT9js93CfD?=
 =?us-ascii?Q?MY0mSd2EijdJ1McCoTAO9YatiiHsVu35GyjWxCuA62nRURRJmLnE8BcHZbMI?=
 =?us-ascii?Q?7gXf9kw5gXlTQZs001eeaKdwwBqxXwo4oHAckcl+AtOw98k8Yfp2Qt7ejOMZ?=
 =?us-ascii?Q?HkhiVSqwluhCnjnyzHoUu+T6+GrTuDTwyaVOcM3+BUs9PPCeWcgevhphp9Z3?=
 =?us-ascii?Q?7kZDFN8CMXV8UyJ8IgWxLZpyomVbxmDGyQ6purCd03YMFu9751BkJxJ26az9?=
 =?us-ascii?Q?WQSckcM/cKHI7JxMWV4kQc+9hrg5nbY99iD4+kf4zuDtS0gGqxAcvXXZ1nBT?=
 =?us-ascii?Q?qfQZ+jbiGKOYHdlx8J/Cv2Mko5dt0XbyyWrF1Bklo494Q6wgZv43awK5JqI3?=
 =?us-ascii?Q?LMxhwNl9rwFnGytX4H0j0dU9SzNhGURTSNVwbacOZwFp8LW/nEJPNqdqUa7P?=
 =?us-ascii?Q?B5lfvdoMMGwX62RaenpuAfSRI6UyYfp2MnVjsytyfD0p/KtmCnkNxxFzaU+b?=
 =?us-ascii?Q?AUw1vkuU6H5KTMiKPECAhkwKI3/B/3VEhYVunM/tcWafCVN/wBvb/2lFxDk9?=
 =?us-ascii?Q?MWEUF3riZoZecY0G1aErmpRMDp24FFstHukeJpmDgDxR1TNBCvuBjIpXh9rh?=
 =?us-ascii?Q?+4PxWMyCTtg622VQjhVsup430w3HiUfyK3kEyNEUazdADZogdeeNqvPkpH0y?=
 =?us-ascii?Q?ml3Q/eFyb8kVD7q7/aOFqktgzJ17N0gTRDuPNf9h9DjTHkPzOElN6es7box4?=
 =?us-ascii?Q?4ETUeHzHSMiZiuHGxeIgWZsv4mlYvdrXevk+47firGHm7LO4aHL94dSROaCo?=
 =?us-ascii?Q?2OqpTmSdg3QYbdeVdKXZivl+Z2bKasOqcNjw+belWWmccslGS0R7acIhzOC8?=
 =?us-ascii?Q?+NEFrMqYYa3qq+Y8IAhcPY7houj1XN0ZlhsbRTkaqEIuIeTmOHm6qcb0/aSP?=
 =?us-ascii?Q?O0o+lSTB5nUzTnqBX5CxYhcn1fCu/oKtYkocPYvX3fZ9+fzYPEPGilcAkU14?=
 =?us-ascii?Q?wgjMUS03McFS9G8rbwFsUyfhRAfPXG5VBzYZQVWVWN/wFKbeUyFtECQQBM26?=
 =?us-ascii?Q?XE3pMzeOt+L2p/yjkZCODpfryRDh4NjXODT88pPS0/L5jG76nipkPQbrLaoY?=
 =?us-ascii?Q?BUHISaHJlh3YZCT2te+Tihyht5S9SMjfvq8W2s7c8sc43GfwNA9MbgQ2hXLQ?=
 =?us-ascii?Q?nW+xhGBT5Iw9IJwIC//Dd6g3diHV/1SRkRFrdC5aiItoQA/wc1J2VFGmloLX?=
 =?us-ascii?Q?RzKqH8YstGfso+k1sxDLWuUosONhZfVcp3B7dOxNC2kGlmS0VCNCZwsl6sD8?=
 =?us-ascii?Q?5BnrTbGe3R9Q/Wbvgv44qnc3b63e5a6Hae2g1+5fOBj3ZtKN8r2xYwc7lb4Z?=
 =?us-ascii?Q?vJcQqqV/phj+EQkISbRYzwgxqe53OzsnjoP1dvgsAbx9F2bRp0TC/nuiurTW?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 472f5355-ad38-4273-809b-08dcd4d81bb4
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 16:13:02.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quOAzTLNax5V/m5bd32D+M41ik7xgHJ+Rd99xoZU0LKPGzLL8b28FNlMp0c3wDPU0oiMs3tvI4FoZr7LMCYWXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6671

On Thu, 12 Sep 2024 15:04:16 -0400
Lyude Paul <lyude@redhat.com> wrote:

> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts
> (with_irqs_disabled()) - along with the ability to annotate functions as
> expecting that IRQs are already disabled on the local CPU.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
> ---
> 
> V2:
> * Actually make it so that we check whether or not we have interrupts
>   disabled with debug assertions
> * Fix issues in the documentation (added suggestions, missing periods, made
>   sure that all rustdoc examples compile properly)
> * Pass IrqDisabled by value, not reference
> * Ensure that IrqDisabled is !Send and !Sync using
>   PhantomData<(&'a (), *mut ())>
> * Add all of the suggested derives from Benno Lossin
> 
> V3:
> * Use `impl` for FnOnce bounds in with_irqs_disabled()
> * Use higher-ranked trait bounds for the lifetime of with_irqs_disabled()
> * Wording changes in the documentation for the module itself
> 
> V4:
> * Use the actual unsafe constructor for IrqDisabled in
>   with_irqs_disabled()
> * Fix comment style in with_irqs_disabled example
> * Check before calling local_irq_restore() in with_irqs_disabled that
>   interrupts are still disabled. It would have been nice to do this from a
>   Drop implementation like I hoped, but I realized rust doesn't allow that
>   for types that implement Copy.
> * Document that interrupts can't be re-enabled within the `cb` provided to
>   `with_irqs_disabled`, and link to the github issue I just filed about
>   this that describes the solution for this.
> 
> V5:
> * Rebase against rust-next for the helpers split
> * Fix typo (enabled -> disabled) - Dirk
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/irq.c     | 22 +++++++++++
>  rust/kernel/irq.rs     | 90 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |  1 +
>  4 files changed, 114 insertions(+)
>  create mode 100644 rust/helpers/irq.c
>  create mode 100644 rust/kernel/irq.rs
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 30f40149f3a96..0bb48df454bd8 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -12,6 +12,7 @@
>  #include "build_assert.c"
>  #include "build_bug.c"
>  #include "err.c"
> +#include "irq.c"
>  #include "kunit.c"
>  #include "mutex.c"
>  #include "page.c"
> diff --git a/rust/helpers/irq.c b/rust/helpers/irq.c
> new file mode 100644
> index 0000000000000..ec1e8d700a220
> --- /dev/null
> +++ b/rust/helpers/irq.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/irqflags.h>
> +
> +unsigned long rust_helper_local_irq_save(void)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	return flags;
> +}
> +
> +void rust_helper_local_irq_restore(unsigned long flags)
> +{
> +	local_irq_restore(flags);
> +}
> +
> +bool rust_helper_irqs_disabled(void)
> +{
> +	return irqs_disabled();
> +}
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> new file mode 100644
> index 0000000000000..0673087161f08
> --- /dev/null
> +++ b/rust/kernel/irq.rs
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Interrupt controls
> +//!
> +//! This module allows Rust code to control processor interrupts. [`with_irqs_disabled()`] may be
> +//! used for nested disables of interrupts, whereas [`IrqDisabled`] can be used for annotating code
> +//! that requires interrupts to be disabled.
> +
> +use bindings;
> +use core::marker::*;
> +
> +/// A token that is only available in contexts where IRQs are disabled.
> +///
> +/// [`IrqDisabled`] is marker made available when interrupts are not active. Certain functions take
> +/// an [`IrqDisabled`] in order to indicate that they may only be run in IRQ-free contexts.

I think this should be encoded as a type invariant?

> +///
> +/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
> +/// interrupts are disabled where required.
> +///
> +/// This token can be created by [`with_irqs_disabled`]. See [`with_irqs_disabled`] for examples and
> +/// further information.
> +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
> +pub struct IrqDisabled<'a>(PhantomData<(&'a (), *mut ())>);
> +
> +impl IrqDisabled<'_> {
> +    /// Create a new [`IrqDisabled`] without disabling interrupts.
> +    ///
> +    /// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> +    /// without interrupts. If debug assertions are enabled, this function will assert that
> +    /// interrupts are disabled upon creation. Otherwise, it has no size or cost at runtime.
> +    ///
> +    /// # Panics
> +    ///
> +    /// If debug assertions are enabled, this function will panic if interrupts are not disabled
> +    /// upon creation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called in contexts where it is already known that interrupts have
> +    /// been disabled for the current CPU, as the user is making a promise that they will remain
> +    /// disabled at least until this [`IrqDisabled`] is dropped.
> +    pub unsafe fn new() -> Self {
> +        // SAFETY: FFI call with no special requirements
> +        debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +        Self(PhantomData)

This needs to assert INVARIANT.

> +    }
> +}
> +
> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> +///
> +/// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> +/// without interrupts. Note that interrupts must be disabled for the entire duration of `cb`, they
> +/// cannot be re-enabled. In the future, this may be expanded on
> +/// [as documented here](https://github.com/Rust-for-Linux/linux/issues/1115).
> +///
> +/// # Examples
> +///
> +/// Using [`with_irqs_disabled`] to call a function that can only be called with interrupts
> +/// disabled:
> +///
> +/// ```
> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
> +///
> +/// // Requiring interrupts be disabled to call a function
> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
> +///     // When this token is available, IRQs are known to be disabled. Actions that rely on this
> +///     // can be safely performed
> +/// }
> +///
> +/// // Disabling interrupts. They'll be re-enabled once this closure completes.
> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> +/// ```
> +#[inline]
> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> T) -> T {
> +    // SAFETY: FFI call with no special requirements
> +    let flags = unsafe { bindings::local_irq_save() };
> +
> +    // SAFETY: We just disabled IRQs using `local_irq_save()`
> +    let ret = cb(unsafe { IrqDisabled::new() });
> +
> +    // Confirm that IRQs are still disabled now that the callback has finished
> +    // SAFETY: FFI call with no special requirements
> +    debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +    // SAFETY: `flags` comes from our previous call to local_irq_save
> +    unsafe { bindings::local_irq_restore(flags) };
> +
> +    ret
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f10b06a78b9d5..df10c58e95c19 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -36,6 +36,7 @@
>  pub mod firmware;
>  pub mod init;
>  pub mod ioctl;
> +pub mod irq;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  pub mod list;


