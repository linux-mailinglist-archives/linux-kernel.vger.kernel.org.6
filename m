Return-Path: <linux-kernel+bounces-563868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A1A649AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503F3168F33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBE23A980;
	Mon, 17 Mar 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iz8umakO"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B7222CBE3;
	Mon, 17 Mar 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207039; cv=none; b=RaRgWxQtDx2CnvM+TvhSWUHBR/VnNTyUPxuW2Zl1hTHUlM9D1iu0Lig5eyd9wgYpJ+3cmpAvnCu+PvTwAY0yxORgE0VQMpOcjpYrDH89JtrHbIRpWAiQ7Tg5idV92TV1yaB6raQVxosyw2yOjhm4Tn+5BSzdkr0ctiVtWXtpe28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207039; c=relaxed/simple;
	bh=pIVLFkm47pCR6w+Z+PEWMNYYYxg8mOrqdzANo897rXA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTI4ggfPgf/wiJIynTuWdz/NSCGyxdwS04LFhIAfdWTMzGr0r29iYrfrCdbP9odEq/Nf4llNKY7Yu1sMf/+kJJVFXJEamKD44IFeaeCxHE0rc8EMbmZZUDZbB/2w0Onb9rS2jP4feXkAg70EsvLUdUKMQS2eYPoxnojdGwHhkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iz8umakO; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742207035; x=1742466235;
	bh=MbL20IMMOiuE0tyDlYbi7mItlyDlTT2h74sF3mfYft8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=iz8umakObCbHhFhZpKdvjsDl1AcG939QUDlZW+V/42pPgGLjxoQhljGICBVw+ifqU
	 jCqDOeIYM5tqaOM8F+0WygiytvppMT0huCPuKWws+LUWxyvEquhl+OrFd4AgnrLUlX
	 mcd7vmadSKpf+wGaydrpqL9OOilpvuAP6gGjZ2yHDoiYRuuCqpq7b3yKgcIz43W+QP
	 CcFfIYeMJlM58DdsrsEtlhm2bnnPHyrOLkDifY0uXNl0ZHFq8R2cUY6qq/XAkj57IG
	 kJKbuwCSBv36Al28arGbYFOC7N94+XZ7yZgoDOm0FMXA+mrmyiQSVTNqRgt+HWNwYk
	 DOcymEIlHKPTA==
Date: Mon, 17 Mar 2025 10:23:49 +0000
To: Kunwu Chan <kunwu.chan@linux.dev>, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@Gmail.com>
Subject: Re: [PATCH v2] rust: sync: optimize Rust symbol generation for PollCondVar
Message-ID: <D8IGUG4SGRP4.1JJBWPJ46AJBG@proton.me>
In-Reply-To: <20250317025205.2366518-1-kunwu.chan@linux.dev>
References: <20250317025205.2366518-1-kunwu.chan@linux.dev>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d737427aa33b14d06bf3f49d07aea7ba2e097d12
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 3:52 AM CET, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
>
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=3Darm64, the following symbols are generated:
>
> $nm vmlinux | grep ' _R'.*PollCondVar  | rustfilt
> ... T <kernel::sync::poll::PollCondVar>::new::{closure#0}::{closure#0}::p=
anic_cold_explicit
> ... T <kernel::sync::poll::PollCondVar as kernel::init::PinnedDrop>::drop
> ... T <kernel::sync::poll::PollCondVar as core::ops::drop::Drop>::drop
>
> This Rust symbol
> (<kernel::sync::poll::PollCondVar as kernel::init::PinnedDrop>::drop)
> is trivial wrappers around the C functions __wake_up_pollfree
> and synchronize_rcu. It doesn't make sense to go through a trivial
> wrapper for its functions,so mark it inline.
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
> Changes in v2:
>  - Add link and Suggested-by
>  - Reword commit msg
> ---
>  rust/kernel/sync/poll.rs | 1 +
>  1 file changed, 1 insertion(+)


