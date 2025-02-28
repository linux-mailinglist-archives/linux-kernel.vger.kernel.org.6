Return-Path: <linux-kernel+bounces-538108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5019A494A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6391894BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCFB2571A9;
	Fri, 28 Feb 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjWGqT+J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00F256C61;
	Fri, 28 Feb 2025 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734337; cv=none; b=IewyoziAN2C+xGjmZx3jQAq8Pt34M/pftFQyhIGFRvfIkfdysL4zb0sfyALaoo1AC7R/5yQF0VmBmvsGhH/PODXvst1bI18tXNaxBp9PeRGiHEhr+SGUxurP2zfU4T54BleBDwOu9ya4axQupbmesFDnAPWZB3dmgPz0W98iH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734337; c=relaxed/simple;
	bh=uB5PTVlXDv0B3iRpX4jdZ8TQyFJQWls/IBwSuYbL3/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KcBqYyOtwM5lCuOvIyKO72PLS+ZbvANzi2XjuJzu2ib6aMJkoinqlBIn1DgPiA5Ni6tpPsnPk3a2KZouXQzrH4nFUIUhBytV7fbfCCk8QproGV+BQpqXMXjPC5E/hc3HALMDVfW2QvnekqgpBkVV16HTejLSag7VqZUzTeyGJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjWGqT+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E52C4CED6;
	Fri, 28 Feb 2025 09:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740734336;
	bh=uB5PTVlXDv0B3iRpX4jdZ8TQyFJQWls/IBwSuYbL3/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NjWGqT+JamxuUjZZRDeSqqR1JlMUGON4jg2mxVUseVyQqPe5bXTCBbhysMJqRtRFp
	 nZOJFXaQ7h5jFv0PRII2Fexl5hW3qnW+S7TvX71bwyq9hma8I5ZY3+UekWkkhPklmE
	 bNNANQJA8ZU662X8MTZpIAfihQ6EWfpTepVjqyfbrVtr+oBya/k7I6vSBiZwbPu/bs
	 ic4JIf7KPbmXPjI7P8W0VyvDTZKaN71QNZSntlxIAN+8DZjDDpayajvQpGvVBPCOsA
	 gqmYnORCxsalzkJIe+UVdloEpFPzOd66PgHVog8b6+Cfb7QDfHImixzYyyf6OFCVz7
	 1wdaUT5PnYfig==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Petr Mladek" <pmladek@suse.com>,  "Steven Rostedt"
 <rostedt@goodmis.org>,  "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>,  "Rasmus Villemoes"
 <linux@rasmusvillemoes.dk>,  "Sergey Senozhatsky"
 <senozhatsky@chromium.org>,  "Andrew Morton" <akpm@linux-foundation.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,  "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,  "Maxime Ripard"
 <mripard@kernel.org>,  "Thomas Zimmermann" <tzimmermann@suse.de>,  "David
 Airlie" <airlied@gmail.com>,  "Simona Vetter" <simona@ffwll.ch>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] rust: fix signature of rust_fmt_argument
In-Reply-To: <CAH5fLgjKoHpGS9ugxawwJJbb68trHEVvBCCNWFcNSbScGKpuDA@mail.gmail.com>
 (Alice
	Ryhl's message of "Fri, 28 Feb 2025 09:44:21 +0100")
References: <20250227-export-macro-v1-0-948775fc37aa@google.com>
	<qxbD5y-rJZMJDMN1wtODJBCAdNtNdQFsYIDhZUex7KcbPiUvABElh5V8c9EFoAPZ7xQe_L8JS6MzAIqciAb12w==@protonmail.internalid>
	<20250227-export-macro-v1-1-948775fc37aa@google.com>
	<87v7suo5ay.fsf@kernel.org>
	<gVJNIhgBAA9F_JwBjIVAALoIygNL07ep4CbT7nvqOdSCFdsMFZ8yFyfmQuPIChTqoQrrUs1kl11GsYYgz_mW_A==@protonmail.internalid>
	<CAH5fLgjKoHpGS9ugxawwJJbb68trHEVvBCCNWFcNSbScGKpuDA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 28 Feb 2025 10:17:30 +0100
Message-ID: <87eczio2c5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Fri, Feb 28, 2025 at 9:20=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > Without this change, the rest of this series will emit the following
>> > error message:
>> >
>> > error[E0308]: `if` and `else` have incompatible types
>> >   --> <linux>/rust/kernel/print.rs:22:22
>> >    |
>> > 21 | #[export]
>> >    | --------- expected because of this
>> > 22 | unsafe extern "C" fn rust_fmt_argument(
>> >    |                      ^^^^^^^^^^^^^^^^^ expected `u8`, found `i8`
>> >    |
>> >    =3D note: expected fn item `unsafe extern "C" fn(*mut u8, *mut u8, =
*mut c_void) -> *mut u8 {bindings::rust_fmt_argument}`
>> >               found fn item `unsafe extern "C" fn(*mut i8, *mut i8, *c=
onst c_void) -> *mut i8 {print::rust_fmt_argument}`
>> >
>> > The error may be different depending on the architecture.
>> >
>> > Fixes: 787983da7718 ("vsprintf: add new `%pA` format specifier")
>> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> > ---
>> >  lib/vsprintf.c       | 2 +-
>> >  rust/kernel/print.rs | 8 ++++----
>> >  2 files changed, 5 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>> > index 56fe96319292..a8ac4c4fffcf 100644
>> > --- a/lib/vsprintf.c
>> > +++ b/lib/vsprintf.c
>> > @@ -2285,7 +2285,7 @@ int __init no_hash_pointers_enable(char *str)
>> >  early_param("no_hash_pointers", no_hash_pointers_enable);
>> >
>> >  /* Used for Rust formatting ('%pA'). */
>> > -char *rust_fmt_argument(char *buf, char *end, void *ptr);
>> > +char *rust_fmt_argument(char *buf, char *end, const void *ptr);
>> >
>> >  /*
>> >   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>> > diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
>> > index b19ee490be58..8551631dedf1 100644
>> > --- a/rust/kernel/print.rs
>> > +++ b/rust/kernel/print.rs
>> > @@ -6,13 +6,13 @@
>> >  //!
>> >  //! Reference: <https://docs.kernel.org/core-api/printk-basics.html>
>> >
>> > -use core::{
>> > +use core::fmt;
>> > +
>> > +use crate::{
>> >      ffi::{c_char, c_void},
>> > -    fmt,
>> > +    str::RawFormatter,
>> >  };
>> >
>> > -use crate::str::RawFormatter;
>> > -
>> >  // Called from `vsprintf` with format specifier `%pA`.
>> >  #[expect(clippy::missing_safety_doc)]
>> >  #[no_mangle]
>>
>> The changes in this last hunk is not mentioned in the commit message.
>
> The diff is rendered pretty poorly, but this is just importing
> integers from crate::ffi instead of core::ffi, and I do believe that
> the commit message makes it clear that this is needed.

I see, thanks for clarifying. Consider including the clarification in
the commit message.


Best regards,
Andreas Hindborg







