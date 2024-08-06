Return-Path: <linux-kernel+bounces-276401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7E6949321
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F351F21004
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4B1C4601;
	Tue,  6 Aug 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SCdf4jqb"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB7118D632;
	Tue,  6 Aug 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954741; cv=none; b=QtIDYO/FLZ10wgKhau71JhjXE0S5KMeBtXEdPRG/xcjGMX+IIaMo97JeYf2OiTcvJWam6gG0n+mPxAQTSojPE+q0whECZyg0Pr2XqFlaDIh6hZiABAO8aMUwKR9xa31gUeXfl/KUJPUqlMk9k9JQgdaE7nAXRPg0oug4ncXYp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954741; c=relaxed/simple;
	bh=pcN/d/ic9v56yWAa0mZozH9gKTUJt9YBwoanEMLgqQ8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9oqIX9j+XZB2MY9q9gpS59YVM98CFfZXwTM4VX7ZMAghb1c3t3c5NI6qP2PY9okjmMcd1R270rqO1GmFUFuL2Zu5UQAgf6YlKx2W/5jQSAorzvwEgSOFaNbc4SjNqcV0G7qDo7kS0VQWq5pkXli5bY1khpVQ/id6sQqabGTFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SCdf4jqb; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722954736; x=1723213936;
	bh=JcWgkMhHASS6SjKn7f8cFn8JlrjOj0kZPaiU3wsalTI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SCdf4jqbEltI3s2WDZa/1w5lb6bDAAJvI9nhXFl2eVB5lf5QwsFPCo0bEBckB/PBS
	 X12ag+Zc3wu157YpPDGrcyGvbophuqO0UE4S+TZ508Tr4Y3JMip+X1EFk2WFtr7YXW
	 gHwe11xhY3i6C2EKzLiy+fPvhE3zddVSnLDepfebVcfta0no8Xdz5HCbhLdWWNtBHY
	 RFCoKvFSLWtViidwVf/7Y5aFa5WwjOLluifURci/EDaEYskfPUI5SBZ3UE5JNJEAlX
	 vLEjflcnBp2eNQunnE7f1kHPIzj5wwR/Mf6i8iDOPc0C30r90NuVpMKKEMtEEta0Xz
	 UBzuBJilqpoTw==
Date: Tue, 06 Aug 2024 14:32:10 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 04/10] rust: list: add struct with prev/next pointers
Message-ID: <e8753c33-f561-46e3-a521-8992fa650787@proton.me>
In-Reply-To: <20240806-linked-list-v4-4-23efc510ec92@google.com>
References: <20240806-linked-list-v4-0-23efc510ec92@google.com> <20240806-linked-list-v4-4-23efc510ec92@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6f637be5be7b73245525b299dbfb13a707c8f25c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 15:58, Alice Ryhl wrote:
> Define the ListLinks struct, which wraps the prev/next pointers that
> will be used to insert values into a List in a future patch. Also
> define the ListItem trait, which is implemented by structs that have a
> ListLinks field.
>=20
> The ListItem trait provides four different methods that are all
> essentially container_of or the reverse of container_of. Two of them are
> used before inserting/after removing an item from the list, and the two
> others are used when looking at a value without changing whether it is
> in a list. This distinction is introduced because it is needed for the
> patch that adds support for heterogeneous lists, which are implemented
> by adding a third pointer field with a fat pointer to the full struct.
> When inserting into the heterogeneous list, the pointer-to-self is
> updated to have the right vtable, and the container_of operation is
> implemented by just returning that pointer instead of using the real
> container_of operation.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs | 119 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 119 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


