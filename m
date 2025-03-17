Return-Path: <linux-kernel+bounces-563838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E3CA64973
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1011C1887F33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3F23CF11;
	Mon, 17 Mar 2025 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZehzFm9e"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF023909F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206599; cv=none; b=tn4AgG1I1k6adtSUVAnnhUPy5kwdsDmy/zP86aH3EnQcmnjCK/nUW85oZMKI0z26EvjcNTZnGFxOZclv1fjvfgHM9qw1oHhyTA7L8S3BFGl85QOfuP0TPlnkgAfisqRSY6mpZiUN2f3iKPNqc/h2VZa7dm1zO83LGO/w4Mn9tw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206599; c=relaxed/simple;
	bh=tAXyC/Z0ZWitiHzL9nvON4Jigtijh73MzpCu2PhMbDI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7VqQa8gjMSRaXKm1+PnmYpgWozYzVKonjw0n9Dab1Bwf+Lvuwgq1uO9w2dtiZoTxzUY35HMa0a/QYIGJivLxcJyDDLeeMoIOIiHATnX2QW2RyxoKi0zsE3Q+6dNLZOSegGVuXqFu/37Kx2kQW/iWGjM2bmgKJK6qPagRnIuuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZehzFm9e; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742206595; x=1742465795;
	bh=KQoILsilHEJo5usuiJ2jeJyGOMiJd+yx37iGtpQVeHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ZehzFm9e+0RYuDRbtyUDTPs4sG5OtU3hyazfGtACn6nkBSbTtMzfEBM9xf53BBC6V
	 68krE7OdugTYXo45/E8WXDximPehcXRbg03aDL9GEQTvjNdygLChDdN9Evj1LZCAAj
	 uK0CTzZDElClQtUaIgd0P+7qwWSQJ6ecEXcce09nuwvrrSNI1K/vZQBzj3ChsXqwSh
	 Wp92sYWyJa6qGeYcJwxDftalNHzgLweijHUnnCsfD8Tk5yDYfbNBOrIwNJxIeawdB7
	 uEHM76VU4ThinIyJcoN7Gi3tMVlLh1zC7bGe271p305RaDWU4SGqVfJagV/2d9VkJQ
	 3ESD41nQZ+wSg==
Date: Mon, 17 Mar 2025 10:16:30 +0000
To: Kunwu Chan <kunwu.chan@linux.dev>, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@Gmail.com>
Subject: Re: [PATCH] rust: sync: optimize rust symbol generation for CondVar
Message-ID: <D8IGOUUTDAZL.7LMGZFOHU4PU@proton.me>
In-Reply-To: <20250317081351.2503049-1-kunwu.chan@linux.dev>
References: <20250317081351.2503049-1-kunwu.chan@linux.dev>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4f3e90c92b18f37feebf3e6e5057f09b64505ab5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 9:13 AM CET, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
>
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=3Darm64, the following symbols are generated:
>
> $nm vmlinux | grep ' _R'.*CondVar | rustfilt
> ... T <kernel::sync::condvar::CondVar>::notify_all
> ... T <kernel::sync::condvar::CondVar>::notify_one
> ... T <kernel::sync::condvar::CondVar>::notify_sync
> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::pa=
nic_cold_explicit
> ... T <kernel::sync::condvar::CondVar>::new::{closure#0}::{closure#0}::pa=
nic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::p=
anic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
>
> These notify* symbols are trivial wrappers around the C functions
> __wake_up and __wake_up_sync.
> It doesn't make sense to go through a trivial wrapper for these
> functions, so mark them inline.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/sync/condvar.rs | 4 ++++
>  1 file changed, 4 insertions(+)


