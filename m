Return-Path: <linux-kernel+bounces-226879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 662F491452D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884AC1C222C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072BB61FE0;
	Mon, 24 Jun 2024 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOyZE1+G"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653875380F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218626; cv=none; b=NBBgctTWTmq0JG7t+VJVdoDKQDGf4GjmqVAWNRucznXHwpMPjbrCdgJguKEPRlDc/MsnuBCM3t20wCRLv+V/ic/lGK6f6s9FSkJgTWj9TpX/NzXDNRQrqt+/kPIbJiTZhCFc8u7TZQnJF/pG4sOdLbqORgaWjX9zCDL2iPHZzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218626; c=relaxed/simple;
	bh=fXHVD3G4w62BhkUqfzkmP2hT2Hb8iYR9K+kqcqeZ2LI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ug7fv3PugFAGz1GgHd6z9CwUZsItaqxzNx1PkvOed1/EMNlv98WMZPE8xr4KxIQV4P+8DuyQoAkAKcJ8Ji0A+9rN+iHDqxQhEKmN0ZPoeyzNxNJkq2fnggNktMDNFI4NNi5k9idF9l4uBGUUMaK91EYIdtVUD6jifWPndmvrroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aOyZE1+G; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-52ce324c204so845274e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719218622; x=1719823422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DImZLITJOUwBPCplCl17cwIdvOncIJOaqDc09+dtO4=;
        b=aOyZE1+GASMqvOvkHHXdgwG5GG5kSv5AuTxzhzQM9AM1wRCOGGtAP0gOzfneSp96yD
         PL/02sQXpi/YKDOmlevOz2B/dXypRgIeb2xB4A0YlA1n3ZJZWKSy1lcYg7ChEllLFn2e
         ZtYnjX/YvOx/eMUCv6pYx0tfaQnRbF4b9fZrAe/F/uya3LEFX/rLImBItikG0OXUSPAC
         I4dXVsnSj9JtGz0v/GvocjVPER/2PShvHs61LDJDKF/x8qa/laRBiBXIQTnyd0sD6HUR
         kYig1IUltqdCp1HVw8ySJemo4WTXCQEEbziXxlcRaQbB61wWz293V1OH4vFP0gwX0HNt
         pxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719218622; x=1719823422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DImZLITJOUwBPCplCl17cwIdvOncIJOaqDc09+dtO4=;
        b=rfEyrdFE8e/bH5NRE9sRjk/06lpGdfapni++z70u1iWykvH6CAeq2N7LFhpeqmj7E2
         mcOVQp2BqaYtfLwI2ASGqYJYVYzN1ZeifI6+cNb/OtaVW3LXSFDKb/TAo1d+83X4Lu28
         X6s/SRZLm+Xf5dR/HkVPzSdgdHbzOGKlHVoBMSBixH7ulRVkZP35keDmNEbXjHbu4A3D
         EhEaXH6OaGbrW35PemqRRAhKUl9sap+uPy4GpqFkwu18iWvC/qsP046IDIXoMh6RNwql
         Mj+x1skv3vdSaGKQHwrGWSnmxr/yi5mcm2ph9xQqIe+/Mhz0kmTkHFZ/jdBGjvzPpokC
         fyJw==
X-Forwarded-Encrypted: i=1; AJvYcCUOZhMiVlyz7c81M8rZf/yCiPaq/2wnM7+ZkEbXjXeYrPT8SLH2ysSkRBtMEfOy8aygcuVW4NXYZ6VZCNQIlH46F4xmEEdnsPa+yKsb
X-Gm-Message-State: AOJu0YyJebJDs62ooQ+/XFpjZVGgPygw21dA2vGtLXfii0jo9B6zhTtz
	Rp+vndLo2gUZ9mpRgAlCX/OQ7VGOzNoJzNwEdYTSNn45KfKQk5SsQFvxsOG847HDpoDAlaZfdML
	qzq1kUESV3nXW+g==
X-Google-Smtp-Source: AGHT+IFl7qaSAOzizMYkp+fnl41uvHppZeW94zgECtz+BVyjTWEAYbcTEF31TK+qXZBRAu84hM+CxGAORIag4LM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:2581:b0:51c:47e4:2608 with SMTP
 id 2adb3069b0e04-52ce17fd192mr3392e87.0.1719218622173; Mon, 24 Jun 2024
 01:43:42 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:43:31 +0000
In-Reply-To: <20240624030327.90301-4-ethan.twardy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624030327.90301-4-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624084331.2864993-1-aliceryhl@google.com>
Subject: Re: [PATCH 3/4] rust: macros: Enable use from macro_rules!
From: Alice Ryhl <aliceryhl@google.com>
To: ethan.twardy@gmail.com
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	aswinunni01@gmail.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	wedsonaf@gmail.com, yakoyoku@gmail.com
Content-Type: text/plain; charset="utf-8"

Ethan D. Twardy <ethan.twardy@gmail.com> writes:
> According to the rustdoc for the proc_macro crate[1], tokens captured
> from a "macro variable" (e.g. from within macro_rules!) may be delimited
> by invisible tokens and be contained within a proc_macro::Group.
> Previously, this scenario was not handled by macros::paste, which caused
> a proc-macro panic when the corresponding tests are enabled. Enable the
> tests, and handle this case by making macros::paste::concat recursive.

The actual change looks good to me.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

However, I have a bunch of formatting nits:

> [1]: https://doc.rust-lang.org/stable/proc_macro/enum.Delimiter.html
> 
> Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

Normally this would be formatted as:

Link: https://doc.rust-lang.org/stable/proc_macro/enum.Delimiter.html [1]
Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index d8bd34c0ba89..8afed8facb21 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -269,12 +269,26 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
>  ///
>  /// # Example
>  ///
> -/// ```ignore
> -/// use kernel::macro::paste;
> +/// ```
> +/// # const binder_driver_return_protocol_BR_OK: u32 = 0;
> +/// # const binder_driver_return_protocol_BR_ERROR: u32 = 1;
> +/// # const binder_driver_return_protocol_BR_TRANSACTION: u32 = 2;
> +/// # const binder_driver_return_protocol_BR_REPLY: u32 = 3;
> +/// # const binder_driver_return_protocol_BR_DEAD_REPLY: u32 = 4;
> +/// # const binder_driver_return_protocol_BR_TRANSACTION_COMPLETE: u32 = 5;
> +/// # const binder_driver_return_protocol_BR_INCREFS: u32 = 6;
> +/// # const binder_driver_return_protocol_BR_ACQUIRE: u32 = 7;
> +/// # const binder_driver_return_protocol_BR_RELEASE: u32 = 8;
> +/// # const binder_driver_return_protocol_BR_DECREFS: u32 = 9;
> +/// # const binder_driver_return_protocol_BR_NOOP: u32 = 10;
> +/// # const binder_driver_return_protocol_BR_SPAWN_LOOPER: u32 = 11;
> +/// # const binder_driver_return_protocol_BR_DEAD_BINDER: u32 = 12;
> +/// # const binder_driver_return_protocol_BR_CLEAR_DEATH_NOTIFICATION_DONE: u32 = 13;
> +/// # const binder_driver_return_protocol_BR_FAILED_REPLY: u32 = 14;
>  ///
>  /// macro_rules! pub_no_prefix {
>  ///     ($prefix:ident, $($newname:ident),+) => {

There's a non-hidden empty line between the last constant and
`macro_rules! pub_no_prefix`. You should either hide the empty line or
get rid of it, because it will look weird when the example is rendered.

> -///         paste! {
> +///         kernel::macros::paste! {

Another option would be to keep the import so that the empty line
separates the import from the macro declaration.

>  ///             $(pub(crate) const $newname: u32 = [<$prefix $newname>];)+
>  ///         }
>  ///     };
> @@ -313,13 +327,29 @@ pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
>  /// * `lower`: change the identifier to lower case.
>  /// * `upper`: change the identifier to upper case.
>  ///
> -/// ```ignore
> -/// use kernel::macro::paste;
> +/// ```rust
> +/// # const binder_driver_return_protocol_BR_OK: u32 = 0;
> +/// # const binder_driver_return_protocol_BR_ERROR: u32 = 1;
> +/// # const binder_driver_return_protocol_BR_TRANSACTION: u32 = 2;
> +/// # const binder_driver_return_protocol_BR_REPLY: u32 = 3;
> +/// # const binder_driver_return_protocol_BR_DEAD_REPLY: u32 = 4;
> +/// # const binder_driver_return_protocol_BR_TRANSACTION_COMPLETE: u32 = 5;
> +/// # const binder_driver_return_protocol_BR_INCREFS: u32 = 6;
> +/// # const binder_driver_return_protocol_BR_ACQUIRE: u32 = 7;
> +/// # const binder_driver_return_protocol_BR_RELEASE: u32 = 8;
> +/// # const binder_driver_return_protocol_BR_DECREFS: u32 = 9;
> +/// # const binder_driver_return_protocol_BR_NOOP: u32 = 10;
> +/// # const binder_driver_return_protocol_BR_SPAWN_LOOPER: u32 = 11;
> +/// # const binder_driver_return_protocol_BR_DEAD_BINDER: u32 = 12;
> +/// # const binder_driver_return_protocol_BR_CLEAR_DEATH_NOTIFICATION_DONE: u32 = 13;
> +/// # const binder_driver_return_protocol_BR_FAILED_REPLY: u32 = 14;
>  ///
>  /// macro_rules! pub_no_prefix {
>  ///     ($prefix:ident, $($newname:ident),+) => {

Same here.

>  ///         kernel::macros::paste! {
> -///             $(pub(crate) const fn [<$newname:lower:span>]: u32 = [<$prefix $newname:span>];)+
> +///             $(pub(crate) const fn [<$newname:lower:span>]() -> u32 {
> +///             [<$prefix $newname:span>]
> +///             })+

I would probably indent [<$prefix $newname:span>] one more time.

Alice

