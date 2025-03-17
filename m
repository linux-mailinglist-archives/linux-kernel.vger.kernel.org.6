Return-Path: <linux-kernel+bounces-563883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A3A64A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851C518877E3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA54226D09;
	Mon, 17 Mar 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H85r+MjO"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60BF13B7A3;
	Mon, 17 Mar 2025 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207386; cv=none; b=c+zAHYh1DW94RaqPvvAEvgqCgHqhsN8WSqnBr+6DSDS+MRuAL0czFiHqHDdtLCgZDdnDGU60bK3vN+H6hpRPBdHT5Tayd4HkKLffhr2slMWZsx5/7OrHhh9lSK5xcXpu0LeSJtzU6JvhaKFXByddYli21jaZQhAfD3e5KPSYZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207386; c=relaxed/simple;
	bh=KXOjYf3+dyf1XyOqFjHNibIasA8ztVPgXCMXFyZmGDI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ez3D61DAtUczySJ51IPnvRjHmRAWlD+a2w3FzchaUgaK6dWqM2cRMYySJd+dmmbYWIy15DIReV+wYNFRhNqBashHoXKzVoAm+hj8eD/3cwZwhsLmf6rau2TOVnbT+lbENEwsa4SU+zmJPpzzwKHitKhbxHxm0PxYCwCrNY2y0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H85r+MjO; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742207381; x=1742466581;
	bh=DsTyQwSSLCmjcwqszJ0OweMdwYjSkMOEECvTOTBjH1g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=H85r+MjOsnjLJ6ZOa3SXJjUqwlrmpDKXDSwOzOGzIBI1oFgu07EOkLMFYlxdhIbKI
	 bTKQnQsn0oDCDE63rLuUt6Dh5HgqsUIX+R+kit//b/g+QVPFdRqseN+t9RsRKS4G+p
	 F7OOVtPr+D54T77gcXwF3eCxu5TmTlBmuYgURxTJL383g+6wPLiYOmQntds57yRcZ8
	 qsEHk8QIX2lcccvL0qDi7DzSBSMn22md5b514gJFeMcRKIFC+7CeWzWG+vZZgqxyHI
	 dFaEd0Ikr/xlosHWStR34JE0P+VAEGzePGgNioePWhbQeza6i7faDAMBNk5cW/nt1z
	 BiX8V29gCFQ0A==
Date: Mon, 17 Mar 2025 10:29:36 +0000
To: Kunwu Chan <kunwu.chan@linux.dev>, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@Gmail.com>
Subject: Re: [PATCH v2] rust: file: optimize rust symbol generation for FileDescriptorReservation
Message-ID: <D8IGYVXXJYS1.36Z7WQ8HTYYJL@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: be417d9ad672d367c9fd3474743fd0cfb54a2c00
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 3:37 AM CET, Kunwu Chan wrote:
> From: Kunwu Chan <kunwu.chan@hotmail.com>
>
> When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
> with ARCH=3Darm64, the following symbols are generated:
>
> $ nm vmlinux | grep ' _R'.*FileDescriptorReservation | rustfilt
> ... T <kernel::fs::file::FileDescriptorReservation>::fd_install
> ... T <kernel::fs::file::FileDescriptorReservation>::get_unused_fd_flags
> ... T <kernel::fs::file::FileDescriptorReservation as core::ops::drop::Dr=
op>::drop
>
> These Rust symbols are trivial wrappers around the C functions
> fd_install, put_unused_fd and put_task_struct. It
> doesn't make sense to go through a trivial wrapper for these
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
> Changes in v2:
>  - Add link and Suggested-by
>  - Mark 'reserved_fd' as inline
>  - Reword commit msg
> ---
>  rust/kernel/fs/file.rs | 4 ++++
>  1 file changed, 4 insertions(+)


