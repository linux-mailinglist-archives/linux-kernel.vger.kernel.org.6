Return-Path: <linux-kernel+bounces-556511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6ACA5CAED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8B93B833D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515525FA34;
	Tue, 11 Mar 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Eb6QomPg"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588825BACF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710805; cv=none; b=fhvBI7ZSZpMadFPMi3uf31Ox/yW2r9KUt8X7v8K660J5Eqlj3aC2OQgZumti1l2sGzdI1I5zisTUK/CYp3jFocV0mBRSUeEnL1l+NTUDpJRZgGOMpwViiSMljz+LBasM6My9fu0nedekCGy9NPTcFMbfi1crZvLon7gek4rGXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710805; c=relaxed/simple;
	bh=KXZfn+E+1UOPS6s6xjPmbs9/5t+fveiBOai0moxW8jA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQOYymVINTsH0aFTGQU2xsQHieNhuIxh5T7vc4PaId+ppjbSI4/UXGglvIATP2fOm4VvV2jcRXVgLurdEtdGFyvOm9yUQ+Y7tBNHqR4MZEe18Sv7KDji+hhfcz/oOmqi+2yjxEWxGMf6xWewxcj1d2tmV51ZYlGXxsjwasXSJqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Eb6QomPg; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ark2rwdxgbgn7jyg7trvov3zxe.protonmail; t=1741710801; x=1741970001;
	bh=KXZfn+E+1UOPS6s6xjPmbs9/5t+fveiBOai0moxW8jA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Eb6QomPgRoUkiUbVXTyTXTzkIRdUpicXNtrQgACu6wNF7q6skb1Sf2YlqD7Rju1kR
	 oqZWPUfpTxjGHafGjn6pU5G8NImsXBC2xLR4XfrCPUkM65OkhTGC0rHYiZyqUErS1X
	 W4rYuRYqHUOkald9coOVF9MKZm/nF+C8lnJcmiuoWC6CIWwGOcqNk1rhlGJxTPZ0MR
	 8ZGGciIvUK46Aiv//t/wWUpPjDeRH/J8wdDnlAoK5HyfgPBwLYp6xv/4MmneLH8hPR
	 RIsHBov4eFCLDpHXulDY92A2/azIkU6Xlc6rvovIxjtN8QwvTpkrkJHHheemYOsrK3
	 tUjMdIrL5EDqA==
Date: Tue, 11 Mar 2025 16:33:16 +0000
To: Panagiotis Foliadis <pfoliadis@posteo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] rust: task: mark Task methods inline
Message-ID: <D8DKY3QWDX9P.1V1M6JXQ1NCSS@proton.me>
In-Reply-To: <20250311-inline-c-wrappers-v2-1-72c99d35ff33@posteo.net>
References: <20250311-inline-c-wrappers-v2-1-72c99d35ff33@posteo.net>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0768b22bbf1dc2a7566b643e75c5d7b61f955053
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 11, 2025 at 4:05 PM CET, Panagiotis Foliadis wrote:
> When you build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> toolchain provided by kernel.org, the following symbols are generated:
>
> $ nm vmlinux | grep ' _R'.*Task | rustfilt
> ffffffff817b2d30 T <kernel::task::Task>::get_pid_ns
> ffffffff817b2d50 T <kernel::task::Task>::tgid_nr_ns
> ffffffff817b2c90 T <kernel::task::Task>::current_pid_ns
> ffffffff817b2d00 T <kernel::task::Task>::signal_pending
> ffffffff817b2cc0 T <kernel::task::Task>::uid
> ffffffff817b2ce0 T <kernel::task::Task>::euid
> ffffffff817b2c70 T <kernel::task::Task>::current
> ffffffff817b2d70 T <kernel::task::Task>::wake_up
> ffffffff817b2db0 T <kernel::task::Task as kernel::types::AlwaysRefCounted=
>::dec_ref
> ffffffff817b2d90 T <kernel::task::Task as kernel::types::AlwaysRefCounted=
>::inc_ref
>
> These Rust symbols are trivial wrappers around the C functions
> get_pid_ns, task_tgid_nr_ns, task_active_pid_ns, signal_pending, uid,
> euid, get_current, wake_up, get_task_struct and put_task_struct.It
> doesn't make sense to go through a trivial wrapper for these
> functions, so mark them inline.
>
> After applying this patch, the above command will produce no output.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


