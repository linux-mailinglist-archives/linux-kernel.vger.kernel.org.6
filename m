Return-Path: <linux-kernel+bounces-323824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0FB9743E5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E5E285A36
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A88F1AAE1E;
	Tue, 10 Sep 2024 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HoXpBPTp"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3B1AAE10
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725998871; cv=none; b=ASpGWOnHkGtbTblfSdeimZUQH3CYVozxqMnILE0CzH1KVx28l+9BoQwESU1WWXtZGZ73DJYubBcqO9szVGwmksfyoSjPNniNYn39VBEyB1CQ96fVpqdzjGbczJPcwtbhgK8mBRFqNpVoioC0PfoXYGQpckImVvfGdhd6vmbqiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725998871; c=relaxed/simple;
	bh=vZJjz9fRezr9De4Orho1wkInbjle+j4xVcnskiX3Jyc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBrkSe7+k8BUfL+ZvRkc/+wRn3Ysdrn1K/gK8hpK1Et5tw2CtR3lnfvYZfoi+waGGbQfG+dHtEcJx06MJvpEIODbr5YFQRVjptW9dq9XATdmcf/DEeVP9Gz3vNwpZfojU9KUL3x/OHvrSzmUXjkXIOCQ/lX50ZvjFQ+JmPz0e0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HoXpBPTp; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725998867; x=1726258067;
	bh=nOd42zcosTE94cbQZZ/IFTYFSJKMt0GHgSbLskRDVkQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HoXpBPTpjnoP5A5V7R4E1D/6NyxD42pKy0jTf0D/ivgvODM8vKNqPF4994eCu9YcA
	 yNgEc9AqOBqoQtZ0M7tfwgKKb4Kz+nuU3L0nia9V30Jsl/hDSMvR1OQd0HYOovOBHa
	 Dc0KpmtQxRMW5wqzzYuAmZnHTZA9aB1VNc9tUW32VLt4/q+D7DtHHyB3sqIvmrc+NC
	 fEdBOtuxp/nYOBfU6R3WupyZZKi2kUMsWSlXk3Wrv6dY4w4XZ1Wxz0TiM2InXts0sN
	 gaw+zqp2XjA2X9SSH4gqIlPCJl4uTuMYseJw7QUBTJw0R9F0towfyKkXcLsoWFdVNd
	 /UsKLtnoW+EAw==
Date: Tue, 10 Sep 2024 20:07:40 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <a8c31bce-aac2-4ffe-8fab-2e68c9bab035@proton.me>
In-Reply-To: <20240816001216.26575-14-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-14-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9747bfca293c10b7ad4bbdb09610026864877931
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> `Vec` provides a contiguous growable array type (such as `Vec`) with
> contents allocated with the kernel's allocators (e.g. `Kmalloc`,
> `Vmalloc` or `KVmalloc`).
>=20
> In contrast to Rust's `Vec` type, the kernel `Vec` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kvec.rs | 629 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/prelude.rs    |   2 +-
>  3 files changed, 636 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/alloc/kvec.rs

I noticed that you don't have a `pop` or `remove` function implemented,
I think it would be weird to have all the other functions but not those.

---
Cheers,
Benno


