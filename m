Return-Path: <linux-kernel+bounces-347768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47EB98DE44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16601C227AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667C71D042F;
	Wed,  2 Oct 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QFVDllQo"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0112DD90
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881346; cv=none; b=js8zAAP8J0/WBCVhjeo6IvffAhKcsSY+GGiB6/aTvnljM5ZkwsM8ChlTZvQuaiNcty+0txfFfLhYnEp2omebkt2MQw73L6xx1+9RzukhLqCU2huOor5nrIg/FPTEe72HgwoI852Gjht+AQR0S/Z0bvEXPLah2Jsvt93VN8KB1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881346; c=relaxed/simple;
	bh=W6mcXzaf4gfiDHPgWfK/Cuo2ZbsP1iR30t0YyK4PtlQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgNHy7td/MgAohdVKfgXnhZOlIaAgIr5iR0zwfevrFCsuKdfyYXyFxRmrnREua9HQDQZXrYtKCff0XAJTt/38T3L6Oo+iCaIe/vFe8Vda0empZVge9OMLtDFiMtW/a8/hRuIMW6zN2oso0DYOZwzJSqI6WyxzFg9w++xkQPt8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QFVDllQo; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727881342; x=1728140542;
	bh=1Zth7PB10SUnJqZXJbg4axhHB6mdrLngSds/icQHss8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QFVDllQoC6LnBOJ5eOiFaquALBrsDr7Od/NXiFyZTE6w8AwYMuuKpqScpAFV8g9Ol
	 N1yG1OhhIe2h6y8lzy4QOHdWMGzlOKpeIMplEMTTI3/F759uxMULGupxWVapApvwVX
	 KORWSIV/sBfEQ9WSdPp2U9gDGIap4PYvsy5eLfpeX8kYhTCqu2B0BmZmEONR/0s6Po
	 i3rgRepDNF9LdyML8376h9BczZ/fbE2DO7uS636486qqI6aViL+fHf7gvHxOKn/L5R
	 hIOOCMuAts3H/ytNWoLiWPZigHou/0mtsiW2yrmvRxXlZoFx5vqGGG4uBwWdDQ7Jdd
	 X/SwmaTHKZKdA==
Date: Wed, 02 Oct 2024 15:02:18 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 16/29] rust: alloc: implement kernel `Vec` type
Message-ID: <977af809-71f5-4a5a-8006-a283f8a6fc25@proton.me>
In-Reply-To: <20241001150008.183102-17-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org> <20241001150008.183102-17-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3fb456826f7d1129c983ef42c4a53c0804b0ada9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.24 16:59, Danilo Krummrich wrote:
> `Vec` provides a contiguous growable array type with contents allocated
> with the kernel's allocators (e.g. `Kmalloc`, `Vmalloc` or `KVmalloc`).
>=20
> In contrast to Rust's stdlib `Vec` type, the kernel `Vec` type considers
> the kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kvec.rs | 637 ++++++++++++++++++++++++++++++++++++++

Any reason against naming this `vec.rs`?

>  rust/kernel/prelude.rs    |   2 +-
>  3 files changed, 644 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/alloc/kvec.rs

I share Gary's opinion, let's do future improvements via
good-first-issues/patches in the current cycle. But get this version
merged now.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


