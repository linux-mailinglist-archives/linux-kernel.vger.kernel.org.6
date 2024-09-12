Return-Path: <linux-kernel+bounces-325999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF48D976100
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38E61C220F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB418BB95;
	Thu, 12 Sep 2024 06:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="kzeAw58s"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD7218BBA7;
	Thu, 12 Sep 2024 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121224; cv=fail; b=TrS6FD6cPwu46LTplvGeopWvWbTaPMqgIHfXSqkDHgjLotMCrAj1vzsoWWSpWxrmKOVbQXS81RsJs0xp0ojGdJxfs31fqfubqTSTBqQ+bhcwoZ9cpUFi+qFYWUfjZRSRR0DnCDMRJoBxGus1qpOV+wNmq6XWL0cP9nUKO/mRofs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121224; c=relaxed/simple;
	bh=I+apeXjXHQz2zeWTq9w0pG6dZxZlMRI/zva0J5bwT9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EnzQQiekB+hmTXuEyTT/8BxsojU1skjPLMPoyBXUDpGTwyVPNl37/52ef/f95ZUGiJqEWnDjWX66JtQtQUYRuszW4UlYCLS7wbmkpEOLR51U7Pi55BZ4NEqXQ5VE3mWNWvvhxEXW99ovcy3VHnocWLUD3vPY7PJz7RPWwjLXQEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=kzeAw58s; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFpBVWJRyfwcM7FCFjlVo7eR2v9Rm0blGx0zCHq2AyD7QDLeo0WOgCbs6xFs06nuc1JEG9izRGPPPvhmFFye7Y6gWrMx0+p3Ah4QDYRS/Q9RamoP5oms8CoKbglQGfqkpa8/XDR9bQHWZAImbo2BlcM5yCNbc/zeFZc+LHM99h/KT4tpA14rsdQFhiaNOwVWR84DnhjxQhm3xbm5X/AQnImcFM+SWbe2btGTwChDmrj1WCSdvSYBGrY+pmU0GNQW8lHVXQtqB/AvLdVuw8xd9aVwGQUEmWP6OY2t3lW6bsr549IXbVl8NlPlt1oPuhUNMuB1GbNnqnTPlFHu2KrgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wAl0++hLnxCIx+XPOgkaGvy6LMyn+s3N+fZTVQ+x0U=;
 b=kmGSlmZQ85j7nhyvSi5GTzcURbugJbPmeFQdpSjZ7jUDgrgoSiEKnXwe/2eGLYmLQd5bV3jbnwX4grxPKQzQQ2P1thnBKfRILeQpldxRfCm5u2Rf1qom4aNED+kkx1wotvbkvy/pQ5rFGMbaLooaW9E56bhdv2ZLrLy77MvPoq/0vYaeq+6vbWr+NnaCS+e7geGsIVgB8YoOKshXRFPk+cVSk/oSagYPCaHwFlJOxWFuUE4jOIH6cpNoEVnOgLj9rPXX63V9OjN5Q5giow0/MSJC6ZU//Yz4gm0qfW43Mwi53PmACY4NwRnxHmzy/PjpF01rlQiF9whb4ij9cDjKgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=redhat.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wAl0++hLnxCIx+XPOgkaGvy6LMyn+s3N+fZTVQ+x0U=;
 b=kzeAw58sDEY+u12bj5+pEuE8rhPyD9UXHwU86xZt257du3shEx+aeTo9W+4OQEpOqh4C/XbsUsqbFYg76HeSnHLWbGwk5IxKbXWGXmUpzz3mXirY6Im2ht9e0h7Jm+GPIrNWwcRHGLzXH8NlYUtadzn0w6crnbD9WX/hvq4nxpJien58d90LCxur/E/6hGpBqGRB/ynj0fbMA27S3KYABGWOSJqwFtNzFjDMOd5E8bhuWMkWlxHD/RWc5BWqcD3EfYST+nS13gdJf8Fgh3FkWdmGIKQ3vh8BKTUlfBLXFDX11ESFETAOa8gPBq3ie5mNv4uxtDJmaAS0/kO/NMMDGQ==
Received: from DUZPR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::9) by AS4PR10MB5497.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4fb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Thu, 12 Sep
 2024 06:06:56 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::b0) by DUZPR01CA0146.outlook.office365.com
 (2603:10a6:10:4bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Thu, 12 Sep 2024 06:06:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 06:06:56 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Sep
 2024 08:06:35 +0200
Received: from [10.34.219.93] (10.139.217.196) by FE-EXCAS2001.de.bosch.com
 (10.139.217.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 08:06:38 +0200
Message-ID: <3535d832-7980-4c95-a2f7-b6d90b172173@de.bosch.com>
Date: Thu, 12 Sep 2024 08:06:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] rust: Introduce irq module
To: Lyude Paul <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>
CC: Danilo Krummrich <dakr@redhat.com>, <airlied@redhat.com>, Ingo Molnar
	<mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, "Alice
 Ryhl" <aliceryhl@google.com>, Asahi Lina <lina@asahilina.net>, Valentin Obst
	<kernel@valentinobst.de>
References: <20240912005539.175428-1-lyude@redhat.com>
 <20240912005539.175428-2-lyude@redhat.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240912005539.175428-2-lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8B:EE_|AS4PR10MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: 8812aade-0ccf-43df-0121-08dcd2f11b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVZXVFJ6WGZnNnpIU1h1ZTVWZFBYRjgyVm9GRUozeDN0ZUdkNVlrNmNZdElQ?=
 =?utf-8?B?U2xYVjFFWk1pNUcvRG42WUx4ZXpVTUQvTXVtOW9LWnpHVDdmTnUzOFJnb3V4?=
 =?utf-8?B?dmpnSXROem4yQkQzQUZhZnRyOFdQYkVoOHFocFcyZFU0cS83R3NJa1lDN2VX?=
 =?utf-8?B?ak9UdnZDM2FPR3NKb1BLd3BLMWo1T283Rm0xVUJhaGNvcFFVWDduZWpROVhn?=
 =?utf-8?B?T2QxUDdTZ2ozemp1YXZEVWlIRFp5TjAxZEpDTjljS1EvOURpL0NTNURoV2RF?=
 =?utf-8?B?YVh2SjY4Vkp6TFFaZTZJck9JeU8wT1JuUy9PcDBRd1RucDlFNHZuZGZtRDk3?=
 =?utf-8?B?aHN1aDltaVNqRG1Bd05VWEJIdllJekNIL09DM2M0eHNsYXV5OURvbThJd3Fo?=
 =?utf-8?B?bzYxQVJ0SkorS0xZaGR3U3dHTDQ4cWQrVnpGTUhzeEdTcmVNVnFDT2xCNGpD?=
 =?utf-8?B?blJzc0lNTlFhQVVKaENOUG4wNmFpT3MrOG9NN3lNZDdJNjFFNjRXaXRBRlU1?=
 =?utf-8?B?NGkyT3duNms4bGh3cjB3elhNckZTYkdGb3RaOCswYlh4WjhUTWVlUU00WTRT?=
 =?utf-8?B?bnhqcEYxL2JXd1RtZ2QyeVRxSFB0dGxuS0pNUGk0Wm5OVnRERTFvaEE5YVZp?=
 =?utf-8?B?ZEYySWJqNFliOVMvU0pnVklySzBWZDNjSHR5NjJtVjFhVmdTRlJPWUQ2aDl5?=
 =?utf-8?B?c3FBdE1NUDFlN253QkY2Y0x3NkZCbUkvejVmb0VQbkcyK3NDMzg2aXVvU3Jn?=
 =?utf-8?B?WDFsZ05rQ3h4UWpyaFB4QWlFZTQzRzdpRGlEb2hHRWNlVDBQL3BjeC9kU0xm?=
 =?utf-8?B?N3ZtR1JQTWlKaWhCaXorS2RhUUVmVEkwWnVGT2FJZXh1Mlp3dlcwNzEyTTVV?=
 =?utf-8?B?ajJLWlZLdlA3cE0wcWhOQ0dHaFM0NDEyVzZpYW13Y0NCamxRbnlVUDNZSkpH?=
 =?utf-8?B?ZlZxVmtueDRxUjBJbkRMOWhaZFB2dk9XR1ZVVUVKQlMyc09pQTY5UjQ3czM5?=
 =?utf-8?B?aFg1WCttR0dUazNwcE52dUMyYWczamQ1VjRmcG53ZmovR3c1SEVnT0YrN0lh?=
 =?utf-8?B?dzE5bjUrc0tmSzdqeXdYc3JqWURkMlZNOXE0V01BT1k0cUt1bTFHbWFEUUEw?=
 =?utf-8?B?Ujc4d3Z0V0RBdmROYjdZK2dDUTlrNHhyOWN0MzFNTkZxT0tFYWc2VFU2VVRQ?=
 =?utf-8?B?aDBtdXFTNjRKclVkOVYyNUYzelNMRmVyWmpiMHliTFJ3QUhxamVJMlpPbnky?=
 =?utf-8?B?S3ZRVG5SWEJickg5ZnZQSmd5WTB0VHdKYTdsZnVaME51Sis5UDNCTXFGRE5C?=
 =?utf-8?B?bUZsUEZRK0habjhLeVAxV3l4UHpqZ0RJUEdES1hQYWlYSktvOWNFUEJhQ2pj?=
 =?utf-8?B?NjZFa2VGWjdsTFNWODVUZnlISWYwSXdSMWFtT0wwc0NuVUs0ZEN4aVNYeEhW?=
 =?utf-8?B?RDhDVVZZZGNjT2dCUGEyczdacWcvU1ZrVWhOWmpmUHoyT21aRS82QlFMUXpG?=
 =?utf-8?B?YSt1MDZSNHcvanU2ZTlkODlzN2VGRytFNk1iQUY5U2hINGZBUmYya3FXMzgy?=
 =?utf-8?B?TWNYR2xMWW1DZjc0a1BvSklnT1NESCtmZDNyak81N3ZrdWZTMFBPaUlRbkhv?=
 =?utf-8?B?S2R2NDF6NHFqZGNTVXpsVEJSYlZTTFpmSTNNb3JvWkxYeFdvNldtSTlVZElj?=
 =?utf-8?B?UDI2MHN0ZHUyRExJMDBia2YrcHFBUjQ4SjFwTXZWai9lb1RXQlB1cHZxTUUv?=
 =?utf-8?B?ek1RTkVGVnJPcGkvWjJNYXNGMmpGMWF2V0dOR1hoZlFxZXpSampYU3lYVkJq?=
 =?utf-8?B?QUZUYVBkS2NVSnpLWHlUcUtudWZ6RVJCb2JTQ2trczh1QWhhYnFTRTFmZFAz?=
 =?utf-8?B?YmF4VjdMMlZ2YWJKWmFydHdLbThTa2RaL3drU1k3TnB5b3FQanllWmgyMGg0?=
 =?utf-8?Q?dJ9crJSgiOXOxQpsRY0WKek9ctU9PX8E?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 06:06:56.4633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8812aade-0ccf-43df-0121-08dcd2f11b3b
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5497

On 12.09.2024 02:55, Lyude Paul wrote:
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
>    disabled with debug assertions
> * Fix issues in the documentation (added suggestions, missing periods, made
>    sure that all rustdoc examples compile properly)
> * Pass IrqDisabled by value, not reference
> * Ensure that IrqDisabled is !Send and !Sync using
>    PhantomData<(&'a (), *mut ())>
> * Add all of the suggested derives from Benno Lossin
> 
> V3:
> * Use `impl` for FnOnce bounds in with_irqs_disabled()
> * Use higher-ranked trait bounds for the lifetime of with_irqs_disabled()
> * Wording changes in the documentation for the module itself
> 
> V4:
> * Use the actual unsafe constructor for IrqDisabled in
>    with_irqs_disabled()
> * Fix comment style in with_irqs_disabled example
> * Check before calling local_irq_restore() in with_irqs_disabled that
>    interrupts are still disabled. 


This looks correct ...


> It would have been nice to do this from a
>    Drop implementation like I hoped, but I realized rust doesn't allow that
>    for types that implement Copy.
> * Document that interrupts can't be re-enabled within the `cb` provided to
>    `with_irqs_disabled`, and link to the github issue I just filed about
>    this that describes the solution for this.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
....
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
> +    // Confirm that IRQs are still enabled now that the callback has finished

... so here it should be 'disabled' instead of 'enabled'? "Confirm that 
IRQs are still disabled ...".

Dirk

