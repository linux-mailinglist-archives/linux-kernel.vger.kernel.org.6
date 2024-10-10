Return-Path: <linux-kernel+bounces-359209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AED9988BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530982818B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F01CB31B;
	Thu, 10 Oct 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA82jACN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A441C9EB0;
	Thu, 10 Oct 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569129; cv=none; b=HWQ2Gpw3fYMEyo4kwcLajTvTlHvQwKjQMd4Lu0n7gDWH2S1eo6QLpfkv4Sa6JIIq+sJDxQCtVap6KIZ8MZ/q7YQSGUR1mZnjX/qOtF25QAER8gFMUYwab3ZIyWYOpLX4YafZ0KrOHDDZVGj/JI1FaXpoL0xRO8Jf6qjXI1J9O5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569129; c=relaxed/simple;
	bh=S2vQ+zWZaTuORm23PGOyM7U3jQIw5TIwYK7DK8nHzx4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=MQ+Yi729hI9SVLCn8Frz149/3tT+lxk7l9l+mbPXO7zQEuKjGxftbr4LTYfmqmypnmPprngHKVrnYPZCZA6NU4bdn+DiO0h0UxLj/gRPtLKgUlmLQmjUkGIP3xOwN2pkeple8gCBd2lD6+jQjih1bugtVqpjQ+7r04XVV0NK4LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA82jACN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E446C4CECC;
	Thu, 10 Oct 2024 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728569129;
	bh=S2vQ+zWZaTuORm23PGOyM7U3jQIw5TIwYK7DK8nHzx4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:From;
	b=MA82jACNC+TlvCbNzb3tNunip9YX6Hi7U5vguthxEbW6W7ysO95ti8s9xhrLuI1R1
	 1O7gsLf/kT/3vwx8BarMXeTvHSr32wfStwG8XbUVvZWx3dr7O/246PJYjDWd3LallD
	 Ke0xCvB1UHGlk76zDcz2qvMzdDg+b5YwqWM2WgX7n5jVpD8XtidXLvZF58qfKJusOs
	 oePl0IsO70irzbK3LJgACLEVPVYvX9OoopZPQsaD6JICQpc2h6lA63j9uwEPGwoBR6
	 4VZ7m5zyf+UhLHjh/So6Bzj93ozpzBKk2505KomKtuYrNb05+lqb3m91k7QyNyzf3m
	 eEYVwhmvRwcZw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Alice Ryhl" <aliceryhl@google.com>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?us-ascii?Q?=3D=3Futf-8=3FQ=3FBj=3DC3=3DB6rn=3F=3D?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
In-Reply-To: <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me> (Benno Lossin's
	message of "Thu, 10 Oct 2024 10:39:27 +0000")
Date: Thu, 10 Oct 2024 16:01:07 +0200
Message-ID: <87msjckqfw.fsf@kernel.org>
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
	<HVPdDHj35lGMPHyA8YvYjO4hhof-vNaVDqo_ILwyCmuY13oskqVKxaIA7OK4wo6fWYeJIV_RMtbPdjVRGJcLvg==@protonmail.internalid>
	<1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

>
> Also,
>
>     error: type `__static_lock_ty_VALUE` should have an upper camel case name
>        --> rust/kernel/sync/lock/global.rs:100:18
>         |
>     100 |               type [< __static_lock_ty_ $name >] = $valuety;
>         |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: convert the identifier to upper camel case: `StaticLockTyValue`
>

How did you manage to get these errors? The only thing I get from clippy
is this:

CC      rust/doctests_kernel_generated_kunit.o
warning: question mark operator is useless here
    --> rust/doctests_kernel_generated.rs:4744:1
     |
4744 | / kernel::sync::global_lock! {
4745 | |     // SAFETY: Initialized in module initializer before first use.
4746 | |     static MY_COUNTER: Mutex<u32> = unsafe { uninit };
4747 | |     value: 0;
4748 | | }
     | |_^
     |
     = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_question_mark
     = note: `-W clippy::needless-question-mark` implied by `-W clippy::all`
     = help: to override `-W clippy::all` add `#[allow(clippy::needless_question_mark)]`
     = note: this warning originates in the macro `$crate::global_lock` which comes from the expansion of the macro `kernel::sync::global_lock` (in Nightly builds, run with -Z macro-backtrace for more info)

warning: 1 warning emitted


BR Andreas


