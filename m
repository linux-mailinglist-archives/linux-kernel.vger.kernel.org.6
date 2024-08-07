Return-Path: <linux-kernel+bounces-278547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A294B1AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E6AB20DBC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE6B147C74;
	Wed,  7 Aug 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NQMueTKy"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F50146585;
	Wed,  7 Aug 2024 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723064255; cv=none; b=Y1KnpiXfmsx4hR47sAxaLa12T8x4CJHx2ioWOHBdC3MCk3/K/UaQ52om0q1woNhppHANZmxQpbGuAYel3uHc/S65llLDBwh0vJQK7K+1w4x3U8vE5HE2bAUnxc2iipnYHbC83UIG4gQX20qRhePBRXKL7SEiv+4m4IiABtfI0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723064255; c=relaxed/simple;
	bh=lJX0D4OyVWWr9tCe87V41NDjVu4MfrrbvpiyYTYcK7Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5KNH9R2KbKAPD1tZYO1Vh0dLLvNbO1hgik7kfUPle0zLBQ7oN4VjNLWmZRAefWqBtEcgD2Q5heejdV2mV4H3vgj+gQsLZUhl2r+J/p31EgyfqJrg/gBqV1DlVGtKzIjNlbjAPdeH4ym+Q3dFcsMez10uJOUDTBR8Yy4Z8vvDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NQMueTKy; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723064249; x=1723323449;
	bh=6KUh5dMzqW/isG1WMZVBXDAqaCMl8AmRgKwdpJgumNI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NQMueTKyMITuDxThP5MPcBvLQe3anwegBPA3rhCxjZXbF2wmeR+CIDzJqmR/7a4LX
	 X9Csp9v8qeEDiY8Km7SmP1FwxLQZYQOMwcgaQPspGZFTHCgSiukRPX9DhpOsUapMtW
	 9XQwwef1fDcFP21ysk/t2cJ1W3dsl0diDtfwDtKneOsWRwY6K43TXJDD8TBPiR/ftd
	 MrdLABLNM1e76774UzVFomWHkOsOuGKwe4V8SG4Hk9UF11rrK5nMc4mPtVeVIQamm1
	 /4bEUwNsb4wuR92Tf3jhJ+VCrAILMBbcd3aHEgoQgjmHTA7xw9MxdUBnz7BuskbNZ7
	 oKIer2m0p6G5Q==
Date: Wed, 07 Aug 2024 20:57:22 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 10/28] rust: treewide: switch to our kernel `Box` type
Message-ID: <1b17b4b3-69b4-4af1-a816-b401a1bb6ef2@proton.me>
In-Reply-To: <20240805152004.5039-11-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-11-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: df1d5307bc7aea13047904479f23ee45b5fc73f1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Now that we got the kernel `Box` type in place, convert all existing
> `Box` users to make use of it.

You missed a couple usages of `Box`:
- `rust/macros/lib.rs:{242,251,281}`
- `drivers/block/rnull.rs:{35,50}`

or is that intentional? (for me rnull doesn't compile after this patch)

---
Cheers,
Benno

> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/init.rs               | 41 ++++++++++++++++---------------
>  rust/kernel/init/__internal.rs    |  2 +-
>  rust/kernel/sync/arc.rs           | 17 ++++++-------
>  rust/kernel/sync/condvar.rs       |  4 +--
>  rust/kernel/sync/lock/mutex.rs    |  2 +-
>  rust/kernel/sync/lock/spinlock.rs |  2 +-
>  rust/kernel/workqueue.rs          | 20 +++++++--------
>  7 files changed, 44 insertions(+), 44 deletions(-)


