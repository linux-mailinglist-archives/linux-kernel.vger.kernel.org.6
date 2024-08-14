Return-Path: <linux-kernel+bounces-287004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5903A95217A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4BA1F2160F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957C1BC9ED;
	Wed, 14 Aug 2024 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlrEqt2h"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B61566A;
	Wed, 14 Aug 2024 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657581; cv=none; b=s9gCdKEZK5g8HB6nkC6mIcDFRwh3cCknxnt4XKwLPHT5NBSYurrAZw7S4aQhVE4KIXPIz9FDLj+IZ/sPjAk+632mPvo7qWSo+PZLIPBQlkecrDv90DBT0QTrt/wLrjSkIWV2XS/32qrUJNXX79ihWJfhb7ulDAbMBctMdmA17cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657581; c=relaxed/simple;
	bh=zAolmgVSnYlyn1qhiBcFXkMJvLA+AlitjpHcEqrSErQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YReIsWnMrO1TwTzIDa0tkEIlvDT6JvKKEiA+MrUY3HmES4nsyi+M5Kn4K0Qt4i7ftDmygt5iYqk2/RpUp3CxGhIs1LgpwPJQhTW6HDWBR073LZ05HgMU/iCVgWnnUVlOjgpD5PCwgiPUEXJgLmHEuwfIgPpJ0XVGNMrUGaZBjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlrEqt2h; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70968db52d0so69323a34.3;
        Wed, 14 Aug 2024 10:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723657579; x=1724262379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3dG8HiTnKfYqeHtJsvhTA3bHv2JfPNDX2q2TKLb5tA=;
        b=PlrEqt2hfFnb2pLsN+8QDt+MxVNY5kPLzrVO8xYp6Eo2xVCYXpkDPrLydUR6YjU3rz
         m28uFNtEGyEzeFpoVQuXtQRphLBaiT1weGCGPYGo9Km+FxPZxmqjPQ/g2TqnjyfPm62w
         ys2Y0ox9ohM5rtf1A8wREfJvltVxazujg6YEA1vvUXz2tfBRMNSyBQ6UBVV7UnI0x95X
         6AvzS35TRvqCn5JyDUY5w4h0wnJsLGE/DDkZIXDrS9O4BEvSstLPPHQRoT+7f2DPAFB3
         af4Z9Zy5NV8GidNNkpSdNizml2CPmNOO9f8eOSddbIXdonDxeVZQBk5GKZwqMFfr3q8B
         x++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657579; x=1724262379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3dG8HiTnKfYqeHtJsvhTA3bHv2JfPNDX2q2TKLb5tA=;
        b=RdKXyJ978CP6zzHDrud9PaxW8cql05zoFBemQEPkcfx3sc1yTKlsje6V2zn74bLJR8
         J56qLdGMuQo1KH9W3IgS7iOwexZqYU5am74AbgcnzTbb5ki69mxZciIpiMaHc8WhgEvH
         ljKkY0v+fVMDx1XXmUqV14KfCNkLbQuOr7Uak3GBgtaFPVyce4cx827r73kJIrgb33jq
         rkG9wiIiNHYEtYUHKekyXRrgFU7ji1scA9TlGCWikAWTGn/6p2rma6UHiYiRhjNCzQlS
         s0bBaxaIRbE2w+5OD5ZLYPFBidJwntm2Q6zo+jcA6q5OYutl5Qp2SbYGDylrFRhg8S4t
         FcxA==
X-Forwarded-Encrypted: i=1; AJvYcCVK7jELieEoi4NYi8lvQqo6XJr61RRXk1sbpKg+BEXLowlLSXBmeCqi+bex00aRTWJGibpwT7CzhzBsWOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6XqSzR8r2fk8aTx0NZcwBDIM09kO4APQkEbgkhDfEnCgmU6+
	q7zkgDXDEHnq/AdLoO50URylpp0Qb+3NCACxJ9hclwWAcpYcBGN3
X-Google-Smtp-Source: AGHT+IGCzqyQMpO/z9j+S25FqtCGvYR4AxxECZwhbphbUypAdEz49j0xerkum40V5b3dgHLN0C/uQA==
X-Received: by 2002:a05:6358:528d:b0:1b1:a7f4:fee4 with SMTP id e5c5f4694b2df-1b1aab8453dmr422060355d.14.1723657579375;
        Wed, 14 Aug 2024 10:46:19 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c7eb0csm46255576d6.47.2024.08.14.10.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 10:46:18 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1540B1200075;
	Wed, 14 Aug 2024 13:37:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 13:37:14 -0400
X-ME-Sender: <xms:Seu8ZqM8Sdwo6gEg-d2ztWEHHy6YxbmYRrG12wEX172mzso-vGrFYg>
    <xme:Seu8Zo9f4x8peebrMehT7PUvGzqtnkirx-9-6Kv8qL3EusZw6FML-tV9QfTRHFiF4
    y7B6FR3Im9Dgj0PfQ>
X-ME-Received: <xmr:Seu8ZhSC3ux4v9D_y4Wbqr3FrIRVhodVkLmMKdLWekc64491v-pZCOt5HibR4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepuggrkhhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegr
    ihhrlhhivggusehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhnghhosehrvgguhh
    grthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgvthgvrhiise
    hinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:Suu8ZqvG7kp7VNvdMD7EAFqzLSLpljCBf-WFdo3jmHS3bKo4cE_zFw>
    <xmx:Suu8Zif9DxpTHQwA9ybOvwz-WRq1edtNKXRDKdWG9-omTvVKCeVsqg>
    <xmx:Suu8Zu1vGin6V5vvVY6SqdVAmc_pan-H2v1LWIQQApBPN1N2vh0grQ>
    <xmx:Suu8Zm8n6mfXz4yFpoVm8Aavgap5ySES0iCuCayJu98VfTpOZOX-mw>
    <xmx:Suu8Zh9RJUN90Q9WW4LYNTsEvjvi7YVvnqLaChVLC67reYk0aBMSZJUI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 13:37:13 -0400 (EDT)
Date: Wed, 14 Aug 2024 10:35:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
Message-ID: <Zrzq8su-LhUIoavm@boqun-archlinux>
References: <20240802001452.464985-1-lyude@redhat.com>
 <20240802001452.464985-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802001452.464985-2-lyude@redhat.com>

On Thu, Aug 01, 2024 at 08:10:00PM -0400, Lyude Paul wrote:
[...]
> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> +///
> +/// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> +/// without interrupts.
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
> +///     /* When this token is available, IRQs are known to be disabled. Actions that rely on this
> +///      * can be safely performed
> +///      */
> +/// }
> +///
> +/// // Disabling interrupts. They'll be re-enabled once this closure completes.
> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> +/// ```
> +#[inline]
> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> T) -> T {

Given the current signature, can `cb` return with interrupts enabled (if
it re-enables interrupt itself)? For example:

	with_irqs_disabled(|irq_disabled| {

	    // maybe a unsafe function.
	    reenable_irq(irq_disabled);
	})

note that `cb` is a `-> T` function, other than `-> (IrqDisabled<'a>,
T)`, so semantically, it doesn't require IRQ still disabled after
return.

Regards,
Boqun

> +    // SAFETY: FFI call with no special requirements
> +    let flags = unsafe { bindings::local_irq_save() };
> +
> +    let ret = cb(IrqDisabled(PhantomData));
> +
> +    // SAFETY: `flags` comes from our previous call to local_irq_save
> +    unsafe { bindings::local_irq_restore(flags) };
> +
> +    ret
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 274bdc1b0a824..ead3a7ca5ba11 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -36,6 +36,7 @@
>  pub mod firmware;
>  pub mod init;
>  pub mod ioctl;
> +pub mod irq;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  #[cfg(CONFIG_NET)]
> -- 
> 2.45.2
> 
> 

