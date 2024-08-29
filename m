Return-Path: <linux-kernel+bounces-307435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCA964D95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CF21F244DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79881B86D0;
	Thu, 29 Aug 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="j26c9S+d"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A861B86C6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955564; cv=none; b=Hm4yO5RNx8KkAP/8QfVftfbsm2KgCbifbybSSw7qAI6+oXoFBbWQ6MH2FPbKBY5BXUqtx/YaR6u6KA2XBBbRWz9WEjzSIHGcXJ+8957IObJ9YLh7XQf0fUmewS4AM6JbuQy0K0+m7+Bx6i7FX6yI5c/dGJcL2Jtl/dw0IdcbmYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955564; c=relaxed/simple;
	bh=h3FeHrXdQcOSknLmzlELlkNf2rblPiuIhon54Vp0OAo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UB8Ei24CANV6PV/R1/1NhglGCcsREHn72ViZnys6734vsrNpHrNeUqvVUlUlxNAcmN7X+oI0o/Ra1AgWjqscP+jFCjrkkLT8m/aPCK8mCC1PlbduXHI60eri/KosM3R+9vLLjIcDssWD42PWajulEwPRN6ipeHGTAeQvUGfJZhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=j26c9S+d; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724955555; x=1725214755;
	bh=h3FeHrXdQcOSknLmzlELlkNf2rblPiuIhon54Vp0OAo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j26c9S+dFupn+t1U3Oje/yxSGYbZnxMC/XEXQovK+KqjS8A2fvFAtfj9PTBdmwtv/
	 X8mjjPkwoQpuoJa171IgR3VCgBE3eGv3QWi0g5Idz8IikIi2RSVwIlazVVd4I7ebQC
	 J8LiziINqDK7jJ0IWYxWtKHTfRDiXZhV9csb+fI6wxeY61x1z6T9cAR9zvi5n6L9nw
	 zrjMIFf4TveSj8QOmf/iEOPNGbIHbrABII1Xmym3MMfZFIcOoMxcd0YN3P+g5kx/l4
	 XKwhMpJy9AOPqNsJVEGzYMBDQir3FSlvNAhNhUOoYgf/6nWvxaOYh1jvJaJdbvh9ac
	 pjLHfDEGkuCOg==
Date: Thu, 29 Aug 2024 18:19:09 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 01/26] rust: alloc: add `Allocator` trait
Message-ID: <60253988-37e7-4acb-b2ae-748b30a4ac21@proton.me>
In-Reply-To: <20240816001216.26575-2-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-2-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6bc830cb4344c3a2d832377fd8c8b4022cb0514a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> Add a kernel specific `Allocator` trait, that in contrast to the one in
> Rust's core library doesn't require unstable features and supports GFP
> flags.
>=20
> Subsequent patches add the following trait implementors: `Kmalloc`,
> `Vmalloc` and `KVmalloc`.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

We discussed this in our weekly meeting (I think ~one week ago?). If you
give me a draft version of the comment that you plan to add regarding
the `old_layout` parameter, I can see if I am happy with it. If I am, I
would give you my RB.

---
Cheers,
Benno


