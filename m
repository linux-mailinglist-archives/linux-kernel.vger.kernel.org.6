Return-Path: <linux-kernel+bounces-190445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EA08CFE5C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD301F22D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A8713B794;
	Mon, 27 May 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XzAgiHQ/"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63C26AFA;
	Mon, 27 May 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807027; cv=none; b=kmqUaPY1gQfr/eAzdzq6cobPkW6yfM1vwDbhZZGqRdQ0vZbzm+0DMawEWeIDpQouG8Jbminrv2eMHv8DFXworj2XZpx5Nu2g0l7tzpgJX2Q0xTw15S5CtJkBKG/YyWXGRHKvDEDPEMg3K9aouGveMOLRZLjPkfuPQoewRPk50lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807027; c=relaxed/simple;
	bh=PBIN0QawD2NPAG4XO+sttWPtgLsmF6K+be/5GyQwvLU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7KHiE2n2lR68x5Ik5Okl0lswjog0FLh+ziBag+0yQ8bAg8UPqxRP4OBmsMBNHi5NB03crVX0xViGKbWSWEFZoK4Ra4g+Ftn46KfWon7k4MX40yZiuItcxVbA8oYe+IH19uiaQnUnZ5PwBqY9h+rUJ4wijioeTJvRnPC0JfP3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XzAgiHQ/; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1716807023; x=1717066223;
	bh=zDqqdgPcxNIOCNxfRj2Ird7GKrHKPSBXxIMDgjl4viU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XzAgiHQ/0IkeWD+FyKc6E7eVOAek3i2k0BdZS91/GcyDIufbOgeXWpNrbzPjFOVKm
	 lB2os8ICoCD1RkngLrYOcKftflpTcZ8g9mPGQmTZ3yst2TnmTc4W2wuq37dX6khVE0
	 A9zeMgE9Cyl/pBl9LjROrs2rmp0WFcbTuaAjUIjSRcTFeH7arYbhU8Y1Y3umaxIVXl
	 ROvOo29re/OH17r+PvFdTvFJqjuU20CYpac4nri7Au/KWxuJqiRdQFZHRYJXYcygch
	 PpXQX/JjWYRWLjaxugTOW1/XDQxLQcIouA6v3Eco5RzqnCZm6gnr0dw1d313yo/rqN
	 iVOyijt3J/Qdg==
Date: Mon, 27 May 2024 10:50:17 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 9/9] rust: list: add ListArcField
Message-ID: <4a713d0e-00d7-4735-b68b-fbf9edb2e282@proton.me>
In-Reply-To: <20240506-linked-list-v2-9-7b910840c91f@google.com>
References: <20240506-linked-list-v2-0-7b910840c91f@google.com> <20240506-linked-list-v2-9-7b910840c91f@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f93350be2b5ccdcc25cf38e360e978dad03999b7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.05.24 11:53, Alice Ryhl wrote:
> One way to explain what `ListArc` does is that it controls exclusive
> access to the prev/next pointer field in a refcounted object. The
> feature of having a special reference to a refcounted object with
> exclusive access to specific fields is useful for other things, so
> provide a general utility for that.
>=20
> This is used by Rust Binder to keep track of which processes have a
> reference to a given node. This involves an object for each process/node
> pair, that is referenced by both the process and the node. For some
> fields in this object, only the process's reference needs to access
> them (and it needs mutable access), so Binder uses a ListArc to give the
> process's reference exclusive access.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs           |  3 ++
>  rust/kernel/list/arc_field.rs | 96 +++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 99 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


