Return-Path: <linux-kernel+bounces-353669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397049930FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E9928374C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7811D86DE;
	Mon,  7 Oct 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEUhk+ZG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D301D6DAE;
	Mon,  7 Oct 2024 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314522; cv=none; b=VRePwZyRJ/PG/BWi3W/ZgKxshn5JgULkR0dLLVMv+qKd3HZr4yWAE7Nj2t7zOcYCIsrBlf/loco18Z5MELVgtK+PBAKf9N6IP7gYicMgKgcU84uxky8y6WbRXrbEejMkk3VtWpumw89asKOYWeS19gHV8E16uhfc/ylPhL0dtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314522; c=relaxed/simple;
	bh=ybYxVy1r0p6tcbHPiZuncPNcUxCTPsEMephcffmJyQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odiCCRr1HeMtcUV1iSsOlmQzMQHNwtjKHb8tjgtFr7bxb5hc1wIrrWgd9VOki6q7vP7QVcFm5k+OYyo+C/FX/jWjFxEmC5FV3ttjGwRGMlhUS92JndFq4MVZHh8QJZSwFOEl65MDaFCnu1m6O0iqj+kyf+5Ms1dwSOQZGfvESKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEUhk+ZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6BFC4CEC6;
	Mon,  7 Oct 2024 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728314521;
	bh=ybYxVy1r0p6tcbHPiZuncPNcUxCTPsEMephcffmJyQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEUhk+ZG9Rbk1bhjMTqO8MNi1Es4V2uWvDnkGdAQBzMLuokn2wpHMfM3ddu4LOD3L
	 7N1hYXuXDQPx2IXHP28vCQxFFBfVm+QvUJ8P69NdqawJ5cp0I46+wVvuKKqMuxqTA4
	 EuFO4Ae5neBPamxCsRR9OIZZSG4SQ4BItCvNaxV39wS7ERaXdaa88H9yd+/HzTncAs
	 bd98vIOwHiNEXr8z+6AgjJPUyG8PbYp6QT8O92iQcfEJlLERiIlNw2SJMw2bnFNQn+
	 pzEi1BWlWOYeWSuR4yO43eJJaOPfZI59IVsrSIhI87tVnnLZr5JMj0vKtZo7xscTnH
	 fVt3u/QLcuhMg==
Date: Mon, 7 Oct 2024 17:21:53 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 19/29] rust: treewide: switch to the kernel `Vec` type
Message-ID: <ZwP8kTf3r3h40NKF@pollux>
References: <20241004154149.93856-1-dakr@kernel.org>
 <20241004154149.93856-20-dakr@kernel.org>
 <CAH5fLgida5mybAqE=4kk022ui0hmjRMnAttWrkn213XGXBWLXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgida5mybAqE=4kk022ui0hmjRMnAttWrkn213XGXBWLXA@mail.gmail.com>

On Mon, Oct 07, 2024 at 04:34:59PM +0200, Alice Ryhl wrote:
> On Fri, Oct 4, 2024 at 5:43 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > Now that we got the kernel `Vec` in place, convert all existing `Vec`
> > users to make use of it.
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> This is missing the mm/kasan/kasan_test_rust.rs file, which was added
> in v6.12-rc1.

Thanks Alice for pointing this out.

diff --git a/mm/kasan/kasan_test_rust.rs b/mm/kasan/kasan_test_rust.rs
index caa7175964ef..9b222624ce47 100644
--- a/mm/kasan/kasan_test_rust.rs
+++ b/mm/kasan/kasan_test_rust.rs
@@ -11,7 +11,7 @@
 /// drop the vector, and touch it.
 #[no_mangle]
 pub extern "C" fn kasan_test_rust_uaf() -> u8 {
-    let mut v: Vec<u8> = Vec::new();
+    let mut v: KVec<u8> = KVec::new();
     for _ in 0..4096 {
         v.push(0x42, GFP_KERNEL).unwrap();
     }

@Miguel: Can you please fix this up when you apply the series?

--

Unrelated to this series, but I think there's also a "regression" against the
lint series in this file:

warning: unsafe block missing a safety comment
  --> mm/kasan/kasan_test_rust.rs:20:5
   |
20 |     unsafe { *ptr }
   |     ^^^^^^^^^^^^^^^
   |
   = help: consider adding a safety comment on the preceding line
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
   = note: requested on the command line with `-W clippy::undocumented-unsafe-blocks`

warning: 1 warning emitted

